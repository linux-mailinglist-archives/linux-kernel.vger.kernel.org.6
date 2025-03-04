Return-Path: <linux-kernel+bounces-544318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 32B64A4E00B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 15:02:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3992E3B4590
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 14:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59A882054E2;
	Tue,  4 Mar 2025 13:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="li36mmNf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C812063D7
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 13:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741096740; cv=none; b=KYgdMzC12ErSi6jEAyGDrEdsKI0cmPn28f7RG854K6lBlhp2nCaznwICDjN37o/C0PhR2OWFmNVvik7UNe8AgKESQeoqs6NEueGpq6YemQBwYVmNG9wGQFjIwkdWJjYp4LDcOgFDrQr0MhQ6RkOpbVcuh42BBBo7GGN9/+3ZpZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741096740; c=relaxed/simple;
	bh=9c2Sjy45ucPykbiLx09DjVwbvVa+jkeWfLgJg4HPpMw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YITo3AoJ16B5wCcfGMoIfYEZdJ9kTsUKMdgJAknxEz47i40XvmfZzBsQUeNCPnAutpR7ZmaPd8an+BYGupcJfXfOU/SlmSUqeLjoD+Rz21+dXWLewywwWlOpQqipDwFFGBO3XV8Qg6TVFPhoL5ILRyUZAHSXj7tsGjAVx4iOyj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=li36mmNf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95CCAC4CEE5;
	Tue,  4 Mar 2025 13:58:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741096740;
	bh=9c2Sjy45ucPykbiLx09DjVwbvVa+jkeWfLgJg4HPpMw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=li36mmNfukBpxBkysoR3bxmyUpKSu6bxn6vCrX/WOwfkw6/ZMkyU2UBjUbzp9EIdO
	 0RKSgZ1sUYMKzoBN7WAh8ToBmY7S0k/5vfOnWOlJg6eXNl76M3spdD/h6G0WzMK4EL
	 iuWOdPCneAD/eG7wnFtqJj8/DaY0dRcjc9NnfsT73A0Fj/t5WLW8blOsynLGlVKQNs
	 q3aQELgkEn3cO2RBmwos/wAVpTSMjZhsQdVtP6n+25lF/6MA865p14lSRUdhus28BL
	 DJcPDIszXJBAyDtNlg8Gd1H7/DkNUGyDnOVXtwiU1HhwLy7S6vbh8eMthWNqmqePmC
	 uSSJ1Ogw0mwDw==
From: Borislav Petkov <bp@kernel.org>
To: riel@surriel.com
Cc: Manali.Shukla@amd.com,
	akpm@linux-foundation.org,
	andrew.cooper3@citrix.com,
	jackmanb@google.com,
	jannh@google.com,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	mhklinux@outlook.com,
	nadav.amit@gmail.com,
	thomas.lendacky@amd.com,
	x86@kernel.org,
	zhengqi.arch@bytedance.com,
	Borislav Petkov <bp@alien8.de>
Subject: [PATCH v15 11/11] x86/mm: Enable AMD translation cache extensions
Date: Tue,  4 Mar 2025 14:58:16 +0100
Message-ID: <20250304135816.12356-12-bp@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250304135816.12356-1-bp@kernel.org>
References: <20250304135816.12356-1-bp@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Rik van Riel <riel@surriel.com>

With AMD TCE (translation cache extensions) only the intermediate mappings
that cover the address range zapped by INVLPG / INVLPGB get invalidated,
rather than all intermediate mappings getting zapped at every TLB invalidation.

This can help reduce the TLB miss rate, by keeping more intermediate mappings
in the cache.

From the AMD manual:

Translation Cache Extension (TCE) Bit. Bit 15, read/write. Setting this bit to
1 changes how the INVLPG, INVLPGB, and INVPCID instructions operate on TLB
entries. When this bit is 0, these instructions remove the target PTE from the
TLB as well as all upper-level table entries that are cached in the TLB,
whether or not they are associated with the target PTE.  When this bit is set,
these instructions will remove the target PTE and only those upper-level
entries that lead to the target PTE in the page table hierarchy, leaving
unrelated upper-level entries intact.

  [ bp: use cpu_has()... I know, it is a mess. ]

Signed-off-by: Rik van Riel <riel@surriel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20250226030129.530345-13-riel@surriel.com
---
 arch/x86/include/asm/msr-index.h       | 2 ++
 arch/x86/kernel/cpu/amd.c              | 4 ++++
 tools/arch/x86/include/asm/msr-index.h | 2 ++
 3 files changed, 8 insertions(+)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 72765b2fe0d8..1aacd6b68fab 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -25,6 +25,7 @@
 #define _EFER_SVME		12 /* Enable virtualization */
 #define _EFER_LMSLE		13 /* Long Mode Segment Limit Enable */
 #define _EFER_FFXSR		14 /* Enable Fast FXSAVE/FXRSTOR */
+#define _EFER_TCE		15 /* Enable Translation Cache Extensions */
 #define _EFER_AUTOIBRS		21 /* Enable Automatic IBRS */
 
 #define EFER_SCE		(1<<_EFER_SCE)
@@ -34,6 +35,7 @@
 #define EFER_SVME		(1<<_EFER_SVME)
 #define EFER_LMSLE		(1<<_EFER_LMSLE)
 #define EFER_FFXSR		(1<<_EFER_FFXSR)
+#define EFER_TCE		(1<<_EFER_TCE)
 #define EFER_AUTOIBRS		(1<<_EFER_AUTOIBRS)
 
 /*
diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index 7a72ef47a983..705853315c0d 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -1075,6 +1075,10 @@ static void init_amd(struct cpuinfo_x86 *c)
 
 	/* AMD CPUs don't need fencing after x2APIC/TSC_DEADLINE MSR writes. */
 	clear_cpu_cap(c, X86_FEATURE_APIC_MSRS_FENCE);
+
+	/* Enable Translation Cache Extension */
+	if (cpu_has(c, X86_FEATURE_TCE))
+		msr_set_bit(MSR_EFER, _EFER_TCE);
 }
 
 #ifdef CONFIG_X86_32
diff --git a/tools/arch/x86/include/asm/msr-index.h b/tools/arch/x86/include/asm/msr-index.h
index 3ae84c3b8e6d..dc1c1057f26e 100644
--- a/tools/arch/x86/include/asm/msr-index.h
+++ b/tools/arch/x86/include/asm/msr-index.h
@@ -25,6 +25,7 @@
 #define _EFER_SVME		12 /* Enable virtualization */
 #define _EFER_LMSLE		13 /* Long Mode Segment Limit Enable */
 #define _EFER_FFXSR		14 /* Enable Fast FXSAVE/FXRSTOR */
+#define _EFER_TCE		15 /* Enable Translation Cache Extensions */
 #define _EFER_AUTOIBRS		21 /* Enable Automatic IBRS */
 
 #define EFER_SCE		(1<<_EFER_SCE)
@@ -34,6 +35,7 @@
 #define EFER_SVME		(1<<_EFER_SVME)
 #define EFER_LMSLE		(1<<_EFER_LMSLE)
 #define EFER_FFXSR		(1<<_EFER_FFXSR)
+#define EFER_TCE		(1<<_EFER_TCE)
 #define EFER_AUTOIBRS		(1<<_EFER_AUTOIBRS)
 
 /*
-- 
2.43.0


