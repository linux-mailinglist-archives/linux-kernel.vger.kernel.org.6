Return-Path: <linux-kernel+bounces-522055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 176C1A3C548
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 17:42:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AFD51629E3
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 16:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D5061FF7BC;
	Wed, 19 Feb 2025 16:41:20 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B410A1FECD9
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 16:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739983280; cv=none; b=O8qXmcLVRLzXpTlRD0JCywgGdAvoJYxK83TFZLYBjdDCIWQPx4DgbyX4M4UB+zqLso1X1ZIEbcnE3iryVOkq0NHpgVHOD2F9LHMQY5qPE7k0di3N0bo0aGWxC7S2VSTjfBiAblc8xnDE+tmZF8v6OYuWjBJKx8DHyn9VX6DskEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739983280; c=relaxed/simple;
	bh=KLnK/Ja0S9/NJfa6d61a2G0S5RlFUFSOS3iaAKUnlzw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Syn5ilrjlKDy9AsaKUyj3fB5VvEegsavCVtCL1ufWDCzkWFDGUQHx5hyVL1zF+swZQQ4LIa2yD/uozdRJtLDK4c6Tw/sYqovmAbw2Bu32XTQ2GigMrwam6Wcc7BhYNxd2iAhi9ngr0Ts4QB8QuTN/Q6K9Z0QrFoQX3jWO3Uwdgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 820B51688;
	Wed, 19 Feb 2025 08:41:35 -0800 (PST)
Received: from e123572-lin.arm.com (e123572-lin.cambridge.arm.com [10.1.194.54])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1BEA23F6A8;
	Wed, 19 Feb 2025 08:41:15 -0800 (PST)
From: Kevin Brodsky <kevin.brodsky@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	Kevin Brodsky <kevin.brodsky@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Joey Gouly <joey.gouly@arm.com>,
	Will Deacon <will@kernel.org>
Subject: [PATCH 1/3] arm64/sysreg: Improve PIR/POR helpers
Date: Wed, 19 Feb 2025 16:40:27 +0000
Message-ID: <20250219164029.2309119-2-kevin.brodsky@arm.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250219164029.2309119-1-kevin.brodsky@arm.com>
References: <20250219164029.2309119-1-kevin.brodsky@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We currently have one helper to set a PIRx_ELx's permission field to
a given value, PIRx_ELx_PERM(), and another helper to extract a
permission field from POR_ELx, POR_ELx_IDX(). The naming is pretty
confusing - it isn't clear at all that "_PERM" corresponds to a
setter and "_IDX" to a getter.

This patch aims at improving the situation by using the same
suffixes as FIELD_PREP()/FIELD_GET(), which we have already adopted
for SYS_FIELD_{PREP,GET}():

* PIRx_ELx_PERM_PREP(), POR_ELx_PERM_PREP() create a register value
  where the permission field for a given index is set to a given value.

* POR_ELx_PERM_GET() extracts the permission field from a given
  register value for a given index.

These helpers are not implemented using FIELD_PREP()/FIELD_GET()
because the mask may not be constant, and they need to be usable in
assembly. They are all defined in asm/sysreg.h, as one would expect
for basic sysreg-related helpers.

Finally the new POR_ELx_PERM_* macros are used for existing
calculations in signal.c and mmu.c.

Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
---
 arch/arm64/include/asm/pgtable-prot.h | 36 +++++++++++++--------------
 arch/arm64/include/asm/por.h          |  9 +++----
 arch/arm64/include/asm/sysreg.h       | 10 +++++++-
 arch/arm64/kernel/signal.c            |  2 +-
 arch/arm64/mm/mmu.c                   |  6 ++---
 5 files changed, 34 insertions(+), 29 deletions(-)

diff --git a/arch/arm64/include/asm/pgtable-prot.h b/arch/arm64/include/asm/pgtable-prot.h
index a95f1f77bb39..7830d031742e 100644
--- a/arch/arm64/include/asm/pgtable-prot.h
+++ b/arch/arm64/include/asm/pgtable-prot.h
@@ -169,25 +169,25 @@ static inline bool __pure lpa2_is_enabled(void)
 #define PAGE_GCS_RO	__pgprot(_PAGE_GCS_RO)
 
 #define PIE_E0	( \
-	PIRx_ELx_PERM(pte_pi_index(_PAGE_GCS),           PIE_GCS)  | \
-	PIRx_ELx_PERM(pte_pi_index(_PAGE_GCS_RO),        PIE_R)   | \
-	PIRx_ELx_PERM(pte_pi_index(_PAGE_EXECONLY),      PIE_X_O) | \
-	PIRx_ELx_PERM(pte_pi_index(_PAGE_READONLY_EXEC), PIE_RX_O)  | \
-	PIRx_ELx_PERM(pte_pi_index(_PAGE_SHARED_EXEC),   PIE_RWX_O) | \
-	PIRx_ELx_PERM(pte_pi_index(_PAGE_READONLY),      PIE_R_O)   | \
-	PIRx_ELx_PERM(pte_pi_index(_PAGE_SHARED),        PIE_RW_O))
+	PIRx_ELx_PERM_PREP(pte_pi_index(_PAGE_GCS),           PIE_GCS)  | \
+	PIRx_ELx_PERM_PREP(pte_pi_index(_PAGE_GCS_RO),        PIE_R)   | \
+	PIRx_ELx_PERM_PREP(pte_pi_index(_PAGE_EXECONLY),      PIE_X_O) | \
+	PIRx_ELx_PERM_PREP(pte_pi_index(_PAGE_READONLY_EXEC), PIE_RX_O)  | \
+	PIRx_ELx_PERM_PREP(pte_pi_index(_PAGE_SHARED_EXEC),   PIE_RWX_O) | \
+	PIRx_ELx_PERM_PREP(pte_pi_index(_PAGE_READONLY),      PIE_R_O)   | \
+	PIRx_ELx_PERM_PREP(pte_pi_index(_PAGE_SHARED),        PIE_RW_O))
 
 #define PIE_E1	( \
-	PIRx_ELx_PERM(pte_pi_index(_PAGE_GCS),           PIE_NONE_O) | \
-	PIRx_ELx_PERM(pte_pi_index(_PAGE_GCS_RO),        PIE_NONE_O) | \
-	PIRx_ELx_PERM(pte_pi_index(_PAGE_EXECONLY),      PIE_NONE_O) | \
-	PIRx_ELx_PERM(pte_pi_index(_PAGE_READONLY_EXEC), PIE_R)      | \
-	PIRx_ELx_PERM(pte_pi_index(_PAGE_SHARED_EXEC),   PIE_RW)     | \
-	PIRx_ELx_PERM(pte_pi_index(_PAGE_READONLY),      PIE_R)      | \
-	PIRx_ELx_PERM(pte_pi_index(_PAGE_SHARED),        PIE_RW)     | \
-	PIRx_ELx_PERM(pte_pi_index(_PAGE_KERNEL_ROX),    PIE_RX)     | \
-	PIRx_ELx_PERM(pte_pi_index(_PAGE_KERNEL_EXEC),   PIE_RWX)    | \
-	PIRx_ELx_PERM(pte_pi_index(_PAGE_KERNEL_RO),     PIE_R)      | \
-	PIRx_ELx_PERM(pte_pi_index(_PAGE_KERNEL),        PIE_RW))
+	PIRx_ELx_PERM_PREP(pte_pi_index(_PAGE_GCS),           PIE_NONE_O) | \
+	PIRx_ELx_PERM_PREP(pte_pi_index(_PAGE_GCS_RO),        PIE_NONE_O) | \
+	PIRx_ELx_PERM_PREP(pte_pi_index(_PAGE_EXECONLY),      PIE_NONE_O) | \
+	PIRx_ELx_PERM_PREP(pte_pi_index(_PAGE_READONLY_EXEC), PIE_R)      | \
+	PIRx_ELx_PERM_PREP(pte_pi_index(_PAGE_SHARED_EXEC),   PIE_RW)     | \
+	PIRx_ELx_PERM_PREP(pte_pi_index(_PAGE_READONLY),      PIE_R)      | \
+	PIRx_ELx_PERM_PREP(pte_pi_index(_PAGE_SHARED),        PIE_RW)     | \
+	PIRx_ELx_PERM_PREP(pte_pi_index(_PAGE_KERNEL_ROX),    PIE_RX)     | \
+	PIRx_ELx_PERM_PREP(pte_pi_index(_PAGE_KERNEL_EXEC),   PIE_RWX)    | \
+	PIRx_ELx_PERM_PREP(pte_pi_index(_PAGE_KERNEL_RO),     PIE_R)      | \
+	PIRx_ELx_PERM_PREP(pte_pi_index(_PAGE_KERNEL),        PIE_RW))
 
 #endif /* __ASM_PGTABLE_PROT_H */
diff --git a/arch/arm64/include/asm/por.h b/arch/arm64/include/asm/por.h
index e06e9f473675..e6bf00bd0500 100644
--- a/arch/arm64/include/asm/por.h
+++ b/arch/arm64/include/asm/por.h
@@ -6,26 +6,25 @@
 #ifndef _ASM_ARM64_POR_H
 #define _ASM_ARM64_POR_H
 
-#define POR_BITS_PER_PKEY		4
-#define POR_ELx_IDX(por_elx, idx)	(((por_elx) >> ((idx) * POR_BITS_PER_PKEY)) & 0xf)
+#include <asm/sysreg.h>
 
 static inline bool por_elx_allows_read(u64 por, u8 pkey)
 {
-	u8 perm = POR_ELx_IDX(por, pkey);
+	u8 perm = POR_ELx_PERM_GET(pkey, por);
 
 	return perm & POE_R;
 }
 
 static inline bool por_elx_allows_write(u64 por, u8 pkey)
 {
-	u8 perm = POR_ELx_IDX(por, pkey);
+	u8 perm = POR_ELx_PERM_GET(pkey, por);
 
 	return perm & POE_W;
 }
 
 static inline bool por_elx_allows_exec(u64 por, u8 pkey)
 {
-	u8 perm = POR_ELx_IDX(por, pkey);
+	u8 perm = POR_ELx_PERM_GET(pkey, por);
 
 	return perm & POE_X;
 }
diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index 05ea5223d2d5..c9ce4ce5131c 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -1062,8 +1062,11 @@
 #define PIE_RX		UL(0xa)
 #define PIE_RW		UL(0xc)
 #define PIE_RWX		UL(0xe)
+#define PIE_MASK	UL(0xf)
 
-#define PIRx_ELx_PERM(idx, perm)	((perm) << ((idx) * 4))
+#define PIRx_ELx_BITS_PER_IDX		4
+#define PIRx_ELx_PERM_SHIFT(idx)	((idx) * PIRx_ELx_BITS_PER_IDX)
+#define PIRx_ELx_PERM_PREP(idx, perm)	(((perm) & PIE_MASK) << PIRx_ELx_PERM_SHIFT(idx))
 
 /*
  * Permission Overlay Extension (POE) permission encodings.
@@ -1078,6 +1081,11 @@
 #define POE_RXW		UL(0x7)
 #define POE_MASK	UL(0xf)
 
+#define POR_ELx_BITS_PER_IDX		4
+#define POR_ELx_PERM_SHIFT(idx)		((idx) * POR_ELx_BITS_PER_IDX)
+#define POR_ELx_PERM_GET(idx, reg)	(((reg) >> POR_ELx_PERM_SHIFT(idx)) & POE_MASK)
+#define POR_ELx_PERM_PREP(idx, perm)	(((perm) & POE_MASK) << POR_ELx_PERM_SHIFT(idx))
+
 /* Initial value for Permission Overlay Extension for EL0 */
 #define POR_EL0_INIT	POE_RXW
 
diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
index 99ea26d400ff..bf6226256549 100644
--- a/arch/arm64/kernel/signal.c
+++ b/arch/arm64/kernel/signal.c
@@ -91,7 +91,7 @@ static void save_reset_user_access_state(struct user_access_state *ua_state)
 		u64 por_enable_all = 0;
 
 		for (int pkey = 0; pkey < arch_max_pkey(); pkey++)
-			por_enable_all |= POE_RXW << (pkey * POR_BITS_PER_PKEY);
+			por_enable_all |= POR_ELx_PERM_PREP(pkey, POE_RXW);
 
 		ua_state->por_el0 = read_sysreg_s(SYS_POR_EL0);
 		write_sysreg_s(por_enable_all, SYS_POR_EL0);
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index b4df5bc5b1b8..69a83a77ccce 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -1557,7 +1557,6 @@ int arch_set_user_pkey_access(struct task_struct *tsk, int pkey, unsigned long i
 {
 	u64 new_por = POE_RXW;
 	u64 old_por;
-	u64 pkey_shift;
 
 	if (!system_supports_poe())
 		return -ENOSPC;
@@ -1582,12 +1581,11 @@ int arch_set_user_pkey_access(struct task_struct *tsk, int pkey, unsigned long i
 		new_por &= ~POE_X;
 
 	/* Shift the bits in to the correct place in POR for pkey: */
-	pkey_shift = pkey * POR_BITS_PER_PKEY;
-	new_por <<= pkey_shift;
+	new_por = POR_ELx_PERM_PREP(pkey, new_por);
 
 	/* Get old POR and mask off any old bits in place: */
 	old_por = read_sysreg_s(SYS_POR_EL0);
-	old_por &= ~(POE_MASK << pkey_shift);
+	old_por &= ~(POE_MASK << POR_ELx_PERM_SHIFT(pkey));
 
 	/* Write old part along with new part: */
 	write_sysreg_s(old_por | new_por, SYS_POR_EL0);
-- 
2.47.0


