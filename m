Return-Path: <linux-kernel+bounces-287925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 87E66952E46
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 14:30:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CA351F26DE6
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 12:30:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F13B619D897;
	Thu, 15 Aug 2024 12:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W4uD7Zi8"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6D1B19DF85
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 12:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723724989; cv=none; b=sdlTPWaSz9CSV0UIx7VCx+UVXa1vhjFc/KagRVbhinTyo/9LYodt1LsdtwTiSPUEQT537WXpvThSiuAja5vGDgG1OwOx8PbcigJN9JQT2kbCs1RLktxC2WHHHFpylMktXAVbfzYkM68CCw/J/2x97YaVH8XHNjf5HzOw1D7DnXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723724989; c=relaxed/simple;
	bh=bFUxl7b5tqBfFHPgqLgDKxjE7x1ckyrKPsXsEVklM6o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UT6U1zLSNVbQkMJv/y2uzYwgKsls5xHXLQ8DbSYOB+UZHu6r6V/0JHPv81ylHRZX9cCITnSJHAvjZ69c4PZF7fUwtNlddmlUX66YvktMaOa8vKHc2awH8BWKq/fPRtGLzBRDKiAXxvaMqbt7IHsgnqwc6O3wN/2WrgCkMgfZeWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W4uD7Zi8; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723724987; x=1755260987;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bFUxl7b5tqBfFHPgqLgDKxjE7x1ckyrKPsXsEVklM6o=;
  b=W4uD7Zi8oIuNqHrj5YFSLSXRf1vMVCewKRHic+jhRzpT+f25tKHLWLYE
   qVGRuWmvTrChML7tCJKZtdCiw4bYo3Lq1OKAj3jgBE+GWklhP70tvhBmB
   MSqgN73He2/yqfdyS/le+rCX2cilwgeFUUoYcPS9QnaXEqlJq+DVV6+Hq
   j/oQV5J0wTZRxpLcwcpTtyX/1KUAR5Aje5tFaOiyrHsspPZXc1YcKp8fh
   iCEZJi2ONdcEeb53hKOZBvcJaOpobQMOpUL9IRAb++03dghWPivMyAjBN
   TJ9z+N2iL3vT2r9vXvpFMFXcbtBAs+gKS+EAz6h7qaMvAx6U4wiE7ZHQb
   g==;
X-CSE-ConnectionGUID: UhXLG+cASamhGtxoZiY6Dg==
X-CSE-MsgGUID: EpDiQy6uRLKBTZXpYcbfig==
X-IronPort-AV: E=McAfee;i="6700,10204,11165"; a="22112254"
X-IronPort-AV: E=Sophos;i="6.10,148,1719903600"; 
   d="scan'208";a="22112254"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2024 05:29:47 -0700
X-CSE-ConnectionGUID: D2hreIwSSTKbfOz6tS8o4w==
X-CSE-MsgGUID: ZFvcLFhJRNae4LAgaNeasA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,148,1719903600"; 
   d="scan'208";a="59489472"
Received: from unknown (HELO khuang2-desk.gar.corp.intel.com) ([10.124.223.78])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2024 05:29:44 -0700
From: Kai Huang <kai.huang@intel.com>
To: dave.hansen@intel.com,
	kirill.shutemov@linux.intel.com,
	bp@alien8.de,
	tglx@linutronix.de,
	peterz@infradead.org,
	mingo@redhat.com
Cc: x86@kernel.org,
	hpa@zytor.com,
	luto@kernel.org,
	linux-kernel@vger.kernel.org,
	thomas.lendacky@amd.com,
	pbonzini@redhat.com,
	seanjc@google.com
Subject: [PATCH v5 3/5] x86/virt/tdx: Make module initializatiton state immutable in reboot notifier
Date: Fri, 16 Aug 2024 00:29:19 +1200
Message-ID: <f437bb7da17d3df888c51b19b3b580d10e91a4e7.1723723470.git.kai.huang@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1723723470.git.kai.huang@intel.com>
References: <cover.1723723470.git.kai.huang@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the kernel has ever enabled TDX, part of system memory remains TDX
private memory when kexec happens.  E.g., the PAMT (Physical Address
Metadata Table) pages used by the TDX module to track each TDX memory
page's state are never freed once the TDX module is initialized.

In kexec, the kernel will need to convert all TDX private pages back to
normal when the platform has the TDX "partial write machine check"
erratum.  Such conversion will need to be done after stopping all remote
CPUs so that no more TDX activity can possibly happen.

Register a reboot notifier to make the TDX module initialization state
immutable during the preparation phase of kexec, so that the kernel can
later use module state to determine whether it is possible for the
system to have any TDX private page.  Otherwise, the remote CPU could be
stopped when it is in the middle of module initialization and the module
state wouldn't be able to reflect this.

Specifically, upon receiving the reboot notifier, stop further module
initialization if the kernel hasn't enabled TDX yet.  If there's any
other thread trying to initialize TDX module, wait until the ongoing
module initialization to finish.

The reboot notifier is triggered when the kernel goes to reboot, kexec,
halt or shutdown.  In any case, there's no need to allow the kernel to
continue to initialize the TDX module anyway (if not done yet).

Signed-off-by: Kai Huang <kai.huang@intel.com>
---

v4 -> v5:
 - New patch to split the 'tdx_rebooting' around reboot notifier (Dave).

---
 arch/x86/virt/vmx/tdx/tdx.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index 4e2b2e2ac9f9..c33417fe4086 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -27,6 +27,7 @@
 #include <linux/log2.h>
 #include <linux/acpi.h>
 #include <linux/suspend.h>
+#include <linux/reboot.h>
 #include <asm/page.h>
 #include <asm/special_insns.h>
 #include <asm/msr-index.h>
@@ -52,6 +53,8 @@ static DEFINE_MUTEX(tdx_module_lock);
 /* All TDX-usable memory regions.  Protected by mem_hotplug_lock. */
 static LIST_HEAD(tdx_memlist);
 
+static bool tdx_rebooting;
+
 typedef void (*sc_err_func_t)(u64 fn, u64 err, struct tdx_module_args *args);
 
 static inline void seamcall_err(u64 fn, u64 err, struct tdx_module_args *args)
@@ -1185,6 +1188,9 @@ static int __tdx_enable(void)
 {
 	int ret;
 
+	if (tdx_rebooting)
+		return -EINVAL;
+
 	ret = init_tdx_module();
 	if (ret) {
 		pr_err("module initialization failed (%d)\n", ret);
@@ -1418,6 +1424,21 @@ static struct notifier_block tdx_memory_nb = {
 	.notifier_call = tdx_memory_notifier,
 };
 
+static int tdx_reboot_notifier(struct notifier_block *nb, unsigned long mode,
+			       void *unused)
+{
+	/* Wait for ongoing TDX initialization to finish */
+	mutex_lock(&tdx_module_lock);
+	tdx_rebooting = true;
+	mutex_unlock(&tdx_module_lock);
+
+	return NOTIFY_OK;
+}
+
+static struct notifier_block tdx_reboot_nb = {
+	.notifier_call = tdx_reboot_notifier,
+};
+
 static void __init check_tdx_erratum(void)
 {
 	/*
@@ -1472,6 +1493,14 @@ void __init tdx_init(void)
 		return;
 	}
 
+	err = register_reboot_notifier(&tdx_reboot_nb);
+	if (err) {
+		pr_err("initialization failed: register_reboot_notifier() failed (%d)\n",
+				err);
+		unregister_memory_notifier(&tdx_memory_nb);
+		return;
+	}
+
 #if defined(CONFIG_ACPI) && defined(CONFIG_SUSPEND)
 	pr_info("Disable ACPI S3. Turn off TDX in the BIOS to use ACPI S3.\n");
 	acpi_suspend_lowlevel = NULL;
-- 
2.45.2


