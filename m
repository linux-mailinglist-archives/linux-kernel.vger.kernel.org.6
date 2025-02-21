Return-Path: <linux-kernel+bounces-524989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E599A3E975
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 01:56:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52B0A7AAC92
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 00:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A4A81DE4D5;
	Fri, 21 Feb 2025 00:54:17 +0000 (UTC)
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C0C487A5
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 00:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.67.55.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740099256; cv=none; b=YGkIGgqRjkEfd1Y+g/pEgdz83twP8o6j3/pXjrchQWYsjutsRTXjeNEbfC07UqdCizoWnWFnWSqH1LOy1G239c9dJf9esjumV+PMenuGUmKRUaVYvsC4AvOBCvpTkKtJtaBL/rAbf//e2itQ9sAShsoW49v7I/6w2+SA8llr4zQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740099256; c=relaxed/simple;
	bh=taym24D/FG4S+/ELFtgumlIGWXwx4f59DqeyhC1DsvY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qcv56ff1aWB6ckN7qFNQom3vGo9BotVN5W11q2+we8WYv+1dfAn25IBsiHKp/QubbispaAhc9Am9UJR+4HcFo9687pY+0GQ3I7Rt0LIe2gPZ74Gh4RY7Tm580YHZNL2GtF+cjusY/q3QQFQ0nVGVxVIiPJyCR4KG48my/zmPn18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com; spf=pass smtp.mailfrom=shelob.surriel.com; arc=none smtp.client-ip=96.67.55.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shelob.surriel.com
Received: from fangorn.home.surriel.com ([10.0.13.7])
	by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <riel@shelob.surriel.com>)
	id 1tlHIZ-000000003Qf-2CL0;
	Thu, 20 Feb 2025 19:53:47 -0500
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
	Rik van Riel <riel@surriel.com>
Subject: [PATCH v12 16/16] x86/mm: add noinvlpgb commandline option
Date: Thu, 20 Feb 2025 19:53:15 -0500
Message-ID: <20250221005345.2156760-17-riel@surriel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250221005345.2156760-1-riel@surriel.com>
References: <20250221005345.2156760-1-riel@surriel.com>
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
index 742bdb0c4846..b1ead1136d5c 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -245,6 +245,33 @@ DEFINE_PER_CPU_PAGE_ALIGNED(struct gdt_page, gdt_page) = { .gdt = {
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
@@ -258,6 +285,7 @@ static int __init x86_nopcid_setup(char *s)
 
 	setup_clear_cpu_cap(X86_FEATURE_PCID);
 	pr_info("nopcid: PCID feature disabled\n");
+	disable_invlpgb();
 	return 0;
 }
 early_param("nopcid", x86_nopcid_setup);
-- 
2.47.1


