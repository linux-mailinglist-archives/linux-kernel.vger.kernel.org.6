Return-Path: <linux-kernel+bounces-337125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55EA19845B2
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 14:15:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CAB41C22867
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 12:15:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05F9B1A7AC6;
	Tue, 24 Sep 2024 12:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n4zvlQUA"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C54F81A7ACD
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 12:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727180066; cv=none; b=tHdhzhQa9xTaZSgOVrVm36GxtnIlLy+H9ABQQoSoEzlobg/CFt0w+4lQGAbldF05Ug2iqCDFHvSwnjznlZgWBdHPfZ+1PvkWjlXddDVo49fhZneoB3Gf4E60EZVzqTYB4P/hS6Ad4f4Xni4MmMYGTjBZ9+jZCVdgYH9dbViOSuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727180066; c=relaxed/simple;
	bh=i9I7CYjN9Hg7NAX4f/c7zsafdYgH7puGwntScyQFo64=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lFzfDjxruJ8dV4oZvAU55wMfPvJj9M7H0aRISFxUfGGqiWq8JNp9ap3I8k9Y/Pkf0IgGFG1nh3AJFp7sS4arX0XTX5nWrca9KRwKEhT2OqpvvHsKiv17yvSPwzdG2j+dFAMaUq4zAbw8XEzw6SdXNxs9yaxDMZNiwHCP7ujFG2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n4zvlQUA; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727180065; x=1758716065;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=i9I7CYjN9Hg7NAX4f/c7zsafdYgH7puGwntScyQFo64=;
  b=n4zvlQUABHrQNf0/bOS4jUQdcvdwEO93SgYskkPFriiL6OIfckGCeE3n
   e6rUBd2r8yeR/oEvA1t7FstQQ54dOh7HHGoxPqbnozBhLCdbc3tiC4GQW
   q7aKb0Be+jWfRAkRtaR8tTGXT4bnsC9Ag/2HcTP3b43RyXS5iqM0C41xB
   kXITsphGVWR7kmfub6KSXg56mURf4oGGJ3wYJsny+NsTf/idFelwcK18B
   Q34giMrTzBN33+lOKOykJNrQLawNUbWYXwVLnJhCz2wIWjot8L/qxd6OR
   ioF4R5KACZj7UZ0Ns0m0eK5Z5kEdX+XIIKBUK7mxcbIJHqgHLMndL0p1j
   Q==;
X-CSE-ConnectionGUID: OLgNsQVGR0OeZOViYbHQFw==
X-CSE-MsgGUID: ZDnlo17VQJGcOd/qJYPLwQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11204"; a="29881884"
X-IronPort-AV: E=Sophos;i="6.10,254,1719903600"; 
   d="scan'208";a="29881884"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2024 05:14:24 -0700
X-CSE-ConnectionGUID: J2w3TNJKQ4im6zjhmWEu6g==
X-CSE-MsgGUID: yNZgZSA+Qwy1j3C2GsqoNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,254,1719903600"; 
   d="scan'208";a="71473251"
Received: from ccbilbre-mobl3.amr.corp.intel.com (HELO khuang2-desk.gar.corp.intel.com) ([10.124.221.10])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2024 05:14:21 -0700
From: Kai Huang <kai.huang@intel.com>
To: dave.hansen@intel.com,
	bp@alien8.de,
	tglx@linutronix.de,
	peterz@infradead.org,
	mingo@redhat.com,
	hpa@zytor.com,
	kirill.shutemov@linux.intel.com
Cc: x86@kernel.org,
	linux-kernel@vger.kernel.org,
	pbonzini@redhat.com,
	seanjc@google.com,
	dan.j.williams@intel.com,
	thomas.lendacky@amd.com,
	rick.p.edgecombe@intel.com,
	isaku.yamahata@intel.com,
	ashish.kalra@amd.com,
	bhe@redhat.com,
	nik.borisov@suse.com,
	sagis@google.com
Subject: [PATCH v7 3/5] x86/virt/tdx: Make module initializatiton state immutable in reboot notifier
Date: Wed, 25 Sep 2024 00:13:55 +1200
Message-ID: <3372ac6b77a6fbc98be17fcbf6680ce5497c6251.1727179214.git.kai.huang@intel.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1727179214.git.kai.huang@intel.com>
References: <cover.1727179214.git.kai.huang@intel.com>
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

v6 -> v7:
 - No change

v5 -> v6:
 - No change

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
2.46.0


