Return-Path: <linux-kernel+bounces-443151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D63A29EE7FD
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 14:44:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CF92163261
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 13:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 038D32144DE;
	Thu, 12 Dec 2024 13:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=3mdeb.com header.i=@3mdeb.com header.b="XFiqHsIB"
Received: from 10.mo575.mail-out.ovh.net (10.mo575.mail-out.ovh.net [46.105.79.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D30F08460
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 13:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.105.79.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734011058; cv=none; b=WNLjClRhidHMh+3TokAnOxRJGNcxoC1Ytz53hhl42e/84gJHKyTi8kZWkkn362aRUxCfc3DW5G7aN1JJYr+zKq46UsDQSP4Uy3/yAWKeKQljtVehzD59NDXLpSN6/Maj1fAkQmJMArKfOYqlEbv3Mmngzkcl7bUjF+vaL4nqXU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734011058; c=relaxed/simple;
	bh=m1xKmcmSprfC2NYWPBcdenaf4RJ+Ild82X6LKbzA3cI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lXTJdOCwMZ3kHQ+EweRyponoXw2gKQj77MDSlSYJS6sLYx++Pr35yTymS7vf/n0j9JSDTqgxiR8GYYIkLJ3QKGu+/6cWyspiuCfCd4aL+wSFb/8lRMHT/dVp1t0biaSHSEUf2Jwi8SDv+aituY5M7YE0H5C9XrkrYIQmas3lMag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=3mdeb.com; spf=pass smtp.mailfrom=3mdeb.com; dkim=pass (2048-bit key) header.d=3mdeb.com header.i=@3mdeb.com header.b=XFiqHsIB; arc=none smtp.client-ip=46.105.79.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=3mdeb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=3mdeb.com
Received: from director8.ghost.mail-out.ovh.net (unknown [10.108.9.148])
	by mo575.mail-out.ovh.net (Postfix) with ESMTP id 4Y8D4G11yqz1v31
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 13:35:26 +0000 (UTC)
Received: from ghost-submission-5b5ff79f4f-pn4fc (unknown [10.108.42.192])
	by director8.ghost.mail-out.ovh.net (Postfix) with ESMTPS id 60D3B1FEA8;
	Thu, 12 Dec 2024 13:35:25 +0000 (UTC)
Received: from 3mdeb.com ([37.59.142.106])
	by ghost-submission-5b5ff79f4f-pn4fc with ESMTPSA
	id aa9HOpzmWmf2xwAAX7fgwQ
	(envelope-from <sergii.dmytruk@3mdeb.com>); Thu, 12 Dec 2024 13:35:25 +0000
Authentication-Results:garm.ovh; auth=pass (GARM-106R006824d5145-0310-4c6c-a4b8-b7c89933c7a6,
                    B639BF7A6EC39DD0505FDBB1524E94DB3A46F08D) smtp.auth=sergii.dmytruk@3mdeb.com
X-OVh-ClientIp:176.111.183.174
From: Sergii Dmytruk <sergii.dmytruk@3mdeb.com>
To: linux-kernel@vger.kernel.org
Cc: trenchboot-devel@googlegroups.com
Subject: [RFC PATCH 4/9] x86: Split up Secure Launch setup and finalize functions
Date: Thu, 12 Dec 2024 15:35:02 +0200
Message-ID: <f1eaf9661856b3c5baa489b7c51f753a244c4e8a.1734008878.git.sergii.dmytruk@3mdeb.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1734008878.git.sergii.dmytruk@3mdeb.com>
References: <cover.1734008878.git.sergii.dmytruk@3mdeb.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 16617719677887558812
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeefuddrkeehgdehvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecunecujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgvrhhgihhiucffmhihthhruhhkuceoshgvrhhgihhirdgumhihthhruhhkseefmhguvggsrdgtohhmqeenucggtffrrghtthgvrhhnpefhheefheduieelieekfffgfffgfedutdevleevvdfhfffgledvgfdtuddtheefieenucfkphepuddvjedrtddrtddruddpudejiedrudduuddrudekfedrudejgedpfeejrdehledrudegvddruddtieenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepihhnvghtpeduvdejrddtrddtrddupdhmrghilhhfrhhomhepshgvrhhgihhirdgumhihthhruhhkseefmhguvggsrdgtohhmpdhnsggprhgtphhtthhopedupdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdfovfetjfhoshhtpehmohehjeehmgdpmhhouggvpehsmhhtphhouhht
DKIM-Signature: a=rsa-sha256; bh=Zl5/FfrhPZ8f8pPldhAWjCNSwL68bRDVPV+BOAbDnp0=;
 c=relaxed/relaxed; d=3mdeb.com; h=From; s=ovhmo3617313-selector1;
 t=1734010526; v=1;
 b=XFiqHsIBR06cDVL/WPeXgsAO2/bZsmjqEsJpQ9MuXNmJitvZNC5fvBrcXCh/Vgv0ogRUNiby
 mldI17KScnPoL8ZHLCrMXMYIesXJotAzmhIljvxl7ONAXKjpqTBa0FUPeGLUuxk4di8deSBqYIF
 Un+XTX2Qf8G53j0lNIz3fHVJ+wht2A0aoHcAzok6RCl9a0C/O+Kiqo9ui7SeLyILtfT+EV1TbVs
 rCNfNvUs2i3719+46OPZn2faqZYgKFssJvm8Ly83mbF6YG8RCLofMtVFAbOOHgrbt5Xh6wSWRtl
 /AOLyuGGZ6r01d+dKBJQCneOXuP/PT91OGlfGhypd6ofg==

From: Ross Philipson <ross.philipson@oracle.com>

Split up the setup and findalize functions internally to determine
the type of launch and call the appropriate function (TXT or SKINIT
version).

Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
Signed-off-by: Sergii Dmytruk <sergii.dmytruk@3mdeb.com>
---
 arch/x86/include/asm/svm.h |  2 ++
 arch/x86/kernel/setup.c    |  2 +-
 arch/x86/kernel/slaunch.c  | 69 +++++++++++++++++++++++++++++++-------
 include/linux/slaunch.h    |  4 +--
 4 files changed, 62 insertions(+), 15 deletions(-)

diff --git a/arch/x86/include/asm/svm.h b/arch/x86/include/asm/svm.h
index f0dea3750ca9..e9755f6562c8 100644
--- a/arch/x86/include/asm/svm.h
+++ b/arch/x86/include/asm/svm.h
@@ -575,6 +575,8 @@ struct vmcb {
 
 #define SVM_CPUID_FUNC 0x8000000a
 
+#define SVM_VM_CR_INIT_REDIRECTION 1
+
 #define SVM_SELECTOR_S_SHIFT 4
 #define SVM_SELECTOR_DPL_SHIFT 5
 #define SVM_SELECTOR_P_SHIFT 7
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index d915f21306aa..e8bff04201b5 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -939,7 +939,7 @@ void __init setup_arch(char **cmdline_p)
 	early_gart_iommu_check();
 #endif
 
-	slaunch_setup_txt();
+	slaunch_setup();
 
 	/*
 	 * partially used pages are not usable - thus
diff --git a/arch/x86/kernel/slaunch.c b/arch/x86/kernel/slaunch.c
index c828d46f3271..7a8ecc8c08a8 100644
--- a/arch/x86/kernel/slaunch.c
+++ b/arch/x86/kernel/slaunch.c
@@ -18,6 +18,7 @@
 #include <asm/tlbflush.h>
 #include <asm/e820/api.h>
 #include <asm/setup.h>
+#include <asm/svm.h>
 #include <asm/realmode.h>
 #include <linux/slr_table.h>
 #include <linux/slaunch.h>
@@ -437,21 +438,11 @@ void __init slaunch_fixup_jump_vector(void)
  * Intel TXT specific late stub setup and validation called from within
  * x86 specific setup_arch().
  */
-void __init slaunch_setup_txt(void)
+static void __init slaunch_setup_txt(void)
 {
 	u64 one = TXT_REGVALUE_ONE, val;
 	void __iomem *txt;
 
-	if (!boot_cpu_has(X86_FEATURE_SMX))
-		return;
-
-	/*
-	 * If booted through secure launch entry point, the loadflags
-	 * option will be set.
-	 */
-	if (!(boot_params.hdr.loadflags & SLAUNCH_FLAG))
-		return;
-
 	/*
 	 * See if SENTER was done by reading the status register in the
 	 * public space. If the public register space cannot be read, TXT may
@@ -523,6 +514,42 @@ void __init slaunch_setup_txt(void)
 	pr_info("Intel TXT setup complete\n");
 }
 
+/*
+ * AMD SKINIT specific late stub setup and validation called from within
+ * x86 specific setup_arch().
+ */
+static void __init slaunch_setup_skinit(void)
+{
+	u64 val;
+
+	/*
+	 * If the platform is performing a Secure Launch via SKINIT
+	 * INIT_REDIRECTION flag will be active.
+	 */
+	rdmsrl(MSR_VM_CR, val);
+	if (!(val & (1 << SVM_VM_CR_INIT_REDIRECTION)))
+		return;
+
+	/* Set flags on BSP so subsequent code knows it was a SKINIT launch */
+	sl_flags |= (SL_FLAG_ACTIVE|SL_FLAG_ARCH_SKINIT);
+	pr_info("AMD SKINIT setup complete\n");
+}
+
+void __init slaunch_setup(void)
+{
+	/*
+	 * If booted through secure launch entry point, the loadflags
+	 * option will be set.
+	 */
+	if (!(boot_params.hdr.loadflags & SLAUNCH_FLAG))
+		return;
+
+	if (boot_cpu_has(X86_FEATURE_SMX))
+		slaunch_setup_txt();
+	else if (boot_cpu_has(X86_FEATURE_SKINIT))
+		slaunch_setup_skinit();
+}
+
 static inline void smx_getsec_sexit(void)
 {
 	asm volatile ("getsec\n"
@@ -533,7 +560,7 @@ static inline void smx_getsec_sexit(void)
  * Used during kexec and on reboot paths to finalize the TXT state
  * and do an SEXIT exiting the DRTM and disabling SMX mode.
  */
-void slaunch_finalize(int do_sexit)
+static void slaunch_finalize_txt(int do_sexit)
 {
 	u64 one = TXT_REGVALUE_ONE, val;
 	void __iomem *config;
@@ -594,3 +621,21 @@ void slaunch_finalize(int do_sexit)
 
 	pr_info("TXT SEXIT complete.\n");
 }
+
+/*
+ * Used during kexec and on reboot paths to finalize the SKINIT.
+ */
+static void slaunch_finalize_skinit(void)
+{
+	/* AMD CPUs with PSP-supported DRTM */
+	if (!slaunch_is_skinit_psp())
+		return;
+}
+
+void slaunch_finalize(int do_sexit)
+{
+	if (boot_cpu_has(X86_FEATURE_SMX))
+		slaunch_finalize_txt(do_sexit);
+	else if (boot_cpu_has(X86_FEATURE_SKINIT))
+		slaunch_finalize_skinit();
+}
diff --git a/include/linux/slaunch.h b/include/linux/slaunch.h
index ab01fb6aee15..869b78d8c299 100644
--- a/include/linux/slaunch.h
+++ b/include/linux/slaunch.h
@@ -536,7 +536,7 @@ static inline int tpm2_log_event(struct txt_heap_event_log_pointer2_1_element *e
 /*
  * External functions avalailable in mainline kernel.
  */
-void slaunch_setup_txt(void);
+void slaunch_setup(void);
 void slaunch_fixup_jump_vector(void);
 u32 slaunch_get_flags(void);
 struct sl_ap_wake_info *slaunch_get_ap_wake_info(void);
@@ -552,7 +552,7 @@ void slaunch_psp_finalize(void);
 
 #else
 
-static inline void slaunch_setup_txt(void)
+static inline void slaunch_setup(void)
 {
 }
 
-- 
2.47.1


