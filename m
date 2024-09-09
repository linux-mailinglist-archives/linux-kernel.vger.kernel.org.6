Return-Path: <linux-kernel+bounces-320838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B394D971134
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 10:09:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D13C81C22437
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 08:09:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78DA31B2515;
	Mon,  9 Sep 2024 08:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Bw1DLT7x"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A6361B29B4
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 08:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725869219; cv=none; b=sHQ4brFDvWKNrkdlfAsr2YCjE6iLNuzC9Mwex8DpexKPDp5xuqggHY1MZynx0Y9a0QaheNdBBS17f4rWGpy+Jor+XX3OtPbfHxhFRlXsN1DMMJqoJe6ecO+k8kQWB/niWQ92l51ne4Okte2ZET0uzAZiNHhh7GW57LGWsxqEhlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725869219; c=relaxed/simple;
	bh=JZ6Am+24tztbAY85cSJ+sNB1sggT0i1QSYAHJLuUAQ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cpuTsBeC12DBSOingWoWdpspmIfh51tUA4wnYsn4NxilUrLTXRPTvQl2jKy7PT/fKLwBNMe0g7FsndkKTfeNBjVy+2VhJrvccCTjQ1JimWORU805+msn59oWAHqM567+areKjrWm43ibSOraEoNMj/SQrKQK/n/qim8waqIyv7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Bw1DLT7x; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725869218; x=1757405218;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JZ6Am+24tztbAY85cSJ+sNB1sggT0i1QSYAHJLuUAQ4=;
  b=Bw1DLT7xm3qUWsPhPUjsY3D6+LOHjU6gtcBIQxugv4TgKugUcZi8GT3z
   0LWWidsvMLtMjsxjUdVzriNHqVacUY6+aC0C2tL61/odKaBLT0CE9vq8n
   Q8ezvHffOJLtpnJNNB6AxsW/3OsEs0C+GoE5JX9FIBkkg5Vogk4b6qf60
   CqqkvcZBPZ0PsuMUMJyLTCyKoNFiWYvuOQYmnUKj21+Yz0hKLZeraCWiN
   2Utmx9vWYfRPkhnJ5Tyf53vuJLI+8Lu2aFdKsaW2BMI8TMA0HPhgfT2Bi
   XsY9ezrl1Yo/sfbu2Pizvq+TpqVjTDUDayjuZ5BR0VnDD457Ftop+kb3I
   w==;
X-CSE-ConnectionGUID: YFKrVHW1Qhe64pbtbEWfaQ==
X-CSE-MsgGUID: Vv8/d6cLQTGu+9MBHrX3Ng==
X-IronPort-AV: E=McAfee;i="6700,10204,11189"; a="24410591"
X-IronPort-AV: E=Sophos;i="6.10,213,1719903600"; 
   d="scan'208";a="24410591"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2024 01:06:58 -0700
X-CSE-ConnectionGUID: OomO29MeSWyMstev6jJbrg==
X-CSE-MsgGUID: Lzm/UVRKSjqkmHxp0ZMRBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,213,1719903600"; 
   d="scan'208";a="67327050"
Received: from rfrazer-mobl3.amr.corp.intel.com (HELO khuang2-desk.gar.corp.intel.com) ([10.124.222.253])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2024 01:06:55 -0700
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
Subject: [PATCH v6 3/5] x86/virt/tdx: Make module initializatiton state immutable in reboot notifier
Date: Mon,  9 Sep 2024 20:06:25 +1200
Message-ID: <9a79d6726fa3d933a7f8fdf50f2e3ea0ab7737c2.1725868065.git.kai.huang@intel.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1725868065.git.kai.huang@intel.com>
References: <cover.1725868065.git.kai.huang@intel.com>
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


