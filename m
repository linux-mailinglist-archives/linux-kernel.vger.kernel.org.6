Return-Path: <linux-kernel+bounces-522056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F5EDA3C54A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 17:43:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEA9C3A3FD0
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 16:41:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3682E2080CE;
	Wed, 19 Feb 2025 16:41:21 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 128861FF1DE
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 16:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739983280; cv=none; b=Cy755IPQCR3WVLBMlHEBqy89gb1NtnXW9oVg8qEbfHKoRNCtq9fF5IrBqg9h5wn94KLxvl4ZZqgxIMtpVEaMGCjtaRDdZKPF31ETBaZk1iPdBUfFlzIyRb8dcfepMjo0ZcODdk6d48u0LChHiad5x/OpA8x/uMVe8PWtvq9utUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739983280; c=relaxed/simple;
	bh=2sBR9qItZZOqfqSoJ0QH9/EK8wyYa2zIgabRbY29GmA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KMqhEtRtIWEp8jzk4Y9QNRlwR/S2lhgTEX/2vNf7AndZhu5PMnKIF13J7NFIi+vC7vVg7mtTC4u95Aqzb2q8lr2Z2/31ayyWw+4UJPlqpcN0xNKUjGzMsUCxtruQsG6VLj2N8tDRRibI0Nx1rHtfwhEKPOw7/hazGNNEABQgdIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C605D202C;
	Wed, 19 Feb 2025 08:41:36 -0800 (PST)
Received: from e123572-lin.arm.com (e123572-lin.cambridge.arm.com [10.1.194.54])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 605163F6A8;
	Wed, 19 Feb 2025 08:41:17 -0800 (PST)
From: Kevin Brodsky <kevin.brodsky@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	Kevin Brodsky <kevin.brodsky@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Joey Gouly <joey.gouly@arm.com>,
	Will Deacon <will@kernel.org>
Subject: [PATCH 2/3] arm64/sysreg: Rename POE_RXW to POE_RWX
Date: Wed, 19 Feb 2025 16:40:28 +0000
Message-ID: <20250219164029.2309119-3-kevin.brodsky@arm.com>
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

It is customary to list R, W, X permissions in that order. In fact
this is already the case for PIE constants (PIE_RWX). Rename POE_RXW
accordingly, as well as POE_XW (currently unused).

While at it also swap the W/X lines in
compute_s1_overlay_permissions() to follow the R, W, X order.

Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
---
 arch/arm64/include/asm/sysreg.h | 6 +++---
 arch/arm64/kernel/signal.c      | 2 +-
 arch/arm64/kvm/at.c             | 8 ++++----
 arch/arm64/mm/mmu.c             | 4 ++--
 4 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index c9ce4ce5131c..034e0576de5a 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -1077,8 +1077,8 @@
 #define POE_RX		UL(0x3)
 #define POE_W		UL(0x4)
 #define POE_RW		UL(0x5)
-#define POE_XW		UL(0x6)
-#define POE_RXW		UL(0x7)
+#define POE_WX		UL(0x6)
+#define POE_RWX		UL(0x7)
 #define POE_MASK	UL(0xf)
 
 #define POR_ELx_BITS_PER_IDX		4
@@ -1087,7 +1087,7 @@
 #define POR_ELx_PERM_PREP(idx, perm)	(((perm) & POE_MASK) << POR_ELx_PERM_SHIFT(idx))
 
 /* Initial value for Permission Overlay Extension for EL0 */
-#define POR_EL0_INIT	POE_RXW
+#define POR_EL0_INIT	POE_RWX
 
 /*
  * Definitions for Guarded Control Stack
diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
index bf6226256549..a7c37afb4ebe 100644
--- a/arch/arm64/kernel/signal.c
+++ b/arch/arm64/kernel/signal.c
@@ -91,7 +91,7 @@ static void save_reset_user_access_state(struct user_access_state *ua_state)
 		u64 por_enable_all = 0;
 
 		for (int pkey = 0; pkey < arch_max_pkey(); pkey++)
-			por_enable_all |= POR_ELx_PERM_PREP(pkey, POE_RXW);
+			por_enable_all |= POR_ELx_PERM_PREP(pkey, POE_RWX);
 
 		ua_state->por_el0 = read_sysreg_s(SYS_POR_EL0);
 		write_sysreg_s(por_enable_all, SYS_POR_EL0);
diff --git a/arch/arm64/kvm/at.c b/arch/arm64/kvm/at.c
index 3a96c96816e9..f74a66ce3064 100644
--- a/arch/arm64/kvm/at.c
+++ b/arch/arm64/kvm/at.c
@@ -1090,22 +1090,22 @@ static void compute_s1_overlay_permissions(struct kvm_vcpu *vcpu,
 		break;
 	}
 
-	if (pov_perms & ~POE_RXW)
+	if (pov_perms & ~POE_RWX)
 		pov_perms = POE_NONE;
 
 	if (wi->poe && wr->pov) {
 		wr->pr &= pov_perms & POE_R;
-		wr->px &= pov_perms & POE_X;
 		wr->pw &= pov_perms & POE_W;
+		wr->px &= pov_perms & POE_X;
 	}
 
-	if (uov_perms & ~POE_RXW)
+	if (uov_perms & ~POE_RWX)
 		uov_perms = POE_NONE;
 
 	if (wi->e0poe && wr->uov) {
 		wr->ur &= uov_perms & POE_R;
-		wr->ux &= uov_perms & POE_X;
 		wr->uw &= uov_perms & POE_W;
+		wr->ux &= uov_perms & POE_X;
 	}
 }
 
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 69a83a77ccce..3c54dea1303f 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -1555,7 +1555,7 @@ void __cpu_replace_ttbr1(pgd_t *pgdp, bool cnp)
 #ifdef CONFIG_ARCH_HAS_PKEYS
 int arch_set_user_pkey_access(struct task_struct *tsk, int pkey, unsigned long init_val)
 {
-	u64 new_por = POE_RXW;
+	u64 new_por;
 	u64 old_por;
 
 	if (!system_supports_poe())
@@ -1570,7 +1570,7 @@ int arch_set_user_pkey_access(struct task_struct *tsk, int pkey, unsigned long i
 		return -EINVAL;
 
 	/* Set the bits we need in POR:  */
-	new_por = POE_RXW;
+	new_por = POE_RWX;
 	if (init_val & PKEY_DISABLE_WRITE)
 		new_por &= ~POE_W;
 	if (init_val & PKEY_DISABLE_ACCESS)
-- 
2.47.0


