Return-Path: <linux-kernel+bounces-527927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96A7BA41154
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 20:51:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B8827A887C
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 19:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0023E1D86E6;
	Sun, 23 Feb 2025 19:50:16 +0000 (UTC)
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4A7F1946B8
	for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2025 19:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.67.55.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740340215; cv=none; b=KIHuYN6BxYi7EAZk/HXnYlyE8APjnaWycKbjz7ZkuoSN6GIFmnTJToRLyVja3pCiGxRAHzYdI/IG32+2ehOKIRUFet/KQyQHC37X1xbiYvNwa2Q7RAXD2Yfv9W9frt39CN0pHi4XgXFp7WEXHMxR89qrbdWNsEDbzuXuqcSjROo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740340215; c=relaxed/simple;
	bh=oo+XJGK73tGx9Ra+iWfScOyEiw70vYTcO6aavaOrdRE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ALI0//TaEWt3+BqW7uunrHhCTEJ8eK3MXZx+EZ+MAH3Bp1HxgeCnIB1+MlRoOhMRgRBTHAcauvBz4GW4ZACMRNFYblKiBEaTTma8Hx8huwhGpi41qhBrA22neOFyE9+39zrMC+/tyZ4Bu2y7liGxYbE+YNwYrDOogO2cdEv94Xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com; spf=pass smtp.mailfrom=shelob.surriel.com; arc=none smtp.client-ip=96.67.55.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shelob.surriel.com
Received: from fangorn.home.surriel.com ([10.0.13.7])
	by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <riel@shelob.surriel.com>)
	id 1tmHyz-000000001hX-0Zts;
	Sun, 23 Feb 2025 14:49:45 -0500
From: Rik van Riel <riel@surriel.com>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
	bp@alien8.de,
	peterz@infradead.org,
	dave.hansen@linux.intel.com,
	zhengqi.arch@bytedance.com,
	nadav.amit@gmail.com,
	thomas.lendacky@amd.com,
	kernel-team@meta.com,
	linux-mm@kvack.org,
	akpm@linux-foundation.org,
	jackmanb@google.com,
	jannh@google.com,
	mhklinux@outlook.com,
	andrew.cooper3@citrix.com,
	Manali.Shukla@amd.com,
	mingo@kernel.org,
	Rik van Riel <riel@surriel.com>
Subject: [PATCH v13 14/14] x86/mm: add noinvlpgb commandline option
Date: Sun, 23 Feb 2025 14:49:04 -0500
Message-ID: <20250223194943.3518952-15-riel@surriel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250223194943.3518952-1-riel@surriel.com>
References: <20250223194943.3518952-1-riel@surriel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: riel@surriel.com

Add a "noinvlpgb" commandline option to disable AMD
broadcast TLB flushing at boot time.

Also fix up the "nopcid" boot option to automatically
disable INVLPGB functionality, which relies on processes
to run on globally allocated PCIDs.

Signed-off-by: Rik van Riel <riel@surriel.com>
Suggested-by: Brendan Jackman <jackmanb@google.com>
---
 .../admin-guide/kernel-parameters.txt         |  3 ++
 arch/x86/kernel/cpu/common.c                  | 28 +++++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index fb8752b42ec8..91260e1949fb 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4182,6 +4182,8 @@
 
 	nomodule	Disable module load
 
+	noinvlpgb	[X86-64,EARLY] Disable the INVLPGB cpu feature.
+
 	nonmi_ipi	[X86] Disable using NMI IPIs during panic/reboot to
 			shutdown the other cpus.  Instead use the REBOOT_VECTOR
 			irq.
@@ -4190,6 +4192,7 @@
 			pagetables) support.
 
 	nopcid		[X86-64,EARLY] Disable the PCID cpu feature.
+			This also disables INVLPGB, which relies on PCID.
 
 	nopku		[X86] Disable Memory Protection Keys CPU feature found
 			in some Intel CPUs.
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 7cce91b19fb2..b038c9b50b32 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -243,6 +243,33 @@ DEFINE_PER_CPU_PAGE_ALIGNED(struct gdt_page, gdt_page) = { .gdt = {
 } };
 EXPORT_PER_CPU_SYMBOL_GPL(gdt_page);
 
+#ifdef CONFIG_X86_BROADCAST_TLB_FLUSH
+static void disable_invlpgb(void)
+{
+	/* do not emit a message if the feature is not present */
+	if (!boot_cpu_has(X86_FEATURE_INVLPGB))
+		return;
+
+	setup_clear_cpu_cap(X86_FEATURE_INVLPGB);
+	pr_info("INVLPGB feature disabled\n");
+}
+
+static int __init x86_noinvlpgb_setup(char *s)
+{
+	/* noinvlpgb doesn't accept parameters */
+	if (s)
+		return -EINVAL;
+
+	disable_invlpgb();
+	return 0;
+}
+early_param("noinvlpgb", x86_noinvlpgb_setup);
+#else
+static void disable_invlpgb(void)
+{
+}
+#endif
+
 #ifdef CONFIG_X86_64
 static int __init x86_nopcid_setup(char *s)
 {
@@ -256,6 +283,7 @@ static int __init x86_nopcid_setup(char *s)
 
 	setup_clear_cpu_cap(X86_FEATURE_PCID);
 	pr_info("nopcid: PCID feature disabled\n");
+	disable_invlpgb();
 	return 0;
 }
 early_param("nopcid", x86_nopcid_setup);
-- 
2.47.1


