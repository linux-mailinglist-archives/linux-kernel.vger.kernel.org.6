Return-Path: <linux-kernel+bounces-358475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BAC7997FCE
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 10:31:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A098CB25678
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 08:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 634D51FEFCF;
	Thu, 10 Oct 2024 07:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kMrres3i"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAC0B1FEFC1
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 07:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728546475; cv=none; b=d1hRilyZfSNXzVysBtbmpbB2qTPifwQ8kLzVNOKmUXmummh7WzIlZg3akPYUbAaeaGMjtzcVqax5+64Njp2ua1QQav1pwRkcwn1T0q1fZaMlFZDdfeZYZHnuVv4qmNVVoRFABLlCZr7epJp18wPl/R7Uw+26cNQp40p9c2BB/P8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728546475; c=relaxed/simple;
	bh=br+zYnMwtP2W99coXs+94igddUMorqNE7meqm6enj60=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=br7CzGGHFz8bY6Y4KHmXrXqJ2niTrbYQ58MwSPNW8gmqrX+Nm+o7UwjA0wXezvgER1QYYw4iDKc1Us8LaQ0+p5CcekW5Q12ttJ8sx2L15x/2JI1HZJ4Y81Gk3JjwFQtaXN2XVeV6tVtvyTa1ILz9VarST1Cc8i7UhEp851E+aEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kMrres3i; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728546474; x=1760082474;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=br+zYnMwtP2W99coXs+94igddUMorqNE7meqm6enj60=;
  b=kMrres3iZ1c0QvTSRApcWEJRULP7MGtY8LbelrSPawZYabEGZtXj2fa8
   e29LlDXQsLcWM3FiJgNGW5hwV3IIX9JSOMW+VHkWsRazr0eYw+l+klkUa
   11VnD3cushY5gSNCbrbHmigabqUaTvP3DfU4uW/F3MZ3IIRnDnUCLEo7y
   0NJsAFb0i10nlqzNuxeCtXA9kkraqYyUgP7QwnwmdaHZPrP8PS5vXWhlR
   w8du9//ilYtuPWgQ6iOgQELiqEtRHRgHgk4k4uFfLMNebjZ3z8r+jjsVn
   NNd32pylC3sI0Je+pEafEdCjKbSofmSeggVEh/DatGfRert3P9P5uV430
   g==;
X-CSE-ConnectionGUID: rZfsQl+2SGquW3sDn+05+A==
X-CSE-MsgGUID: LKnSuL4MQGyN6UuPYf0w3w==
X-IronPort-AV: E=McAfee;i="6700,10204,11220"; a="38472898"
X-IronPort-AV: E=Sophos;i="6.11,192,1725346800"; 
   d="scan'208";a="38472898"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2024 00:47:48 -0700
X-CSE-ConnectionGUID: 89YLszNPRTyY143WsKhdvw==
X-CSE-MsgGUID: HB4PB0d6TX+q+6mLkQ42Nw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,192,1725346800"; 
   d="scan'208";a="81307090"
Received: from unknown (HELO yhuang6-mobl2.ccr.corp.intel.com) ([10.245.243.193])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2024 00:47:44 -0700
From: Huang Ying <ying.huang@intel.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Cc: x86@kernel.org,
	linux-coco@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Huang Ying <ying.huang@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Kai Huang <kai.huang@intel.com>,
	David Hildenbrand <david@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Andy Lutomirski <luto@kernel.org>,
	Oscar Salvador <osalvador@suse.de>
Subject: [PATCH -V2] tdx, memory hotplug: Check whole hot-adding memory range for TDX
Date: Thu, 10 Oct 2024 15:47:26 +0800
Message-Id: <20241010074726.1397820-1-ying.huang@intel.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On systems with TDX (Trust Domain eXtensions) enabled, memory ranges
hot-added must be checked for compatibility by TDX.  This is currently
implemented through memory hotplug notifiers for each memory_block.
If a memory range which isn't TDX compatible is hot-added, for
example, some CXL memory, the command line as follows,

  $ echo 1 > /sys/devices/system/node/nodeX/memoryY/online

will report something like,

  bash: echo: write error: Operation not permitted

If pr_debug() is enabled, the error message like below will be shown
in the kernel log,

  online_pages [mem 0xXXXXXXXXXX-0xXXXXXXXXXX] failed

Both are too general to root cause the problem.  This will confuse
users.  One solution is to print some error messages in the TDX memory
hotplug notifier.  However, memory hotplug notifiers are called for
each memory block, so this may lead to a large volume of messages in
the kernel log if a large number of memory blocks are onlined with a
script or automatically.  For example, the typical size of memory
block is 128MB on x86_64, when online 64GB CXL memory, 512 messages
will be logged.

Therefore, in this patch, the whole hot-adding memory range is checked
for TDX compatibility through a newly added architecture specific
function (arch_check_hotplug_memory_range()).  If rejected, the memory
hot-adding will be aborted with a proper kernel log message.  Which
looks like something as below,

  virt/tdx: Reject hot-adding memory range: 0xXXXXXXXX-0xXXXXXXXX for TDX compatibility.

The target use case is to support CXL memory on TDX enabled systems.
If the CXL memory isn't compatible with TDX, the whole CXL memory
range hot-adding will be rejected.  While the CXL memory can still be
used via devdax interface.

This also makes the original TDX memory hotplug notifier useless, so
delete it.

Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
Suggested-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Acked-by: Kai Huang <kai.huang@intel.com>
Acked-by: David Hildenbrand <david@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Oscar Salvador <osalvador@suse.de>
---

Changes:

v2:

- Collected reviewed-by and acked-by.

- Added comments for tdx_check_hotplug_memory_range(), Thanks David!

- Link to v1: https://lore.kernel.org/lkml/20240930055112.344206-1-ying.huang@intel.com/

---
 arch/x86/include/asm/tdx.h     |  2 ++
 arch/x86/mm/init_64.c          |  6 +++++
 arch/x86/virt/vmx/tdx/tdx.c    | 40 +++++++++++++++-------------------
 include/linux/memory_hotplug.h |  3 +++
 mm/memory_hotplug.c            |  7 +++++-
 5 files changed, 34 insertions(+), 24 deletions(-)

diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
index eba178996d84..6db5da34e4ba 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -116,11 +116,13 @@ static inline u64 sc_retry(sc_func_t func, u64 fn,
 int tdx_cpu_enable(void);
 int tdx_enable(void);
 const char *tdx_dump_mce_info(struct mce *m);
+int tdx_check_hotplug_memory_range(u64 start, u64 size);
 #else
 static inline void tdx_init(void) { }
 static inline int tdx_cpu_enable(void) { return -ENODEV; }
 static inline int tdx_enable(void)  { return -ENODEV; }
 static inline const char *tdx_dump_mce_info(struct mce *m) { return NULL; }
+static inline int tdx_check_hotplug_memory_range(u64 start, u64 size) { return 0; }
 #endif	/* CONFIG_INTEL_TDX_HOST */
 
 #endif /* !__ASSEMBLY__ */
diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index ff253648706f..30a4ad4272ce 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -55,6 +55,7 @@
 #include <asm/uv/uv.h>
 #include <asm/setup.h>
 #include <asm/ftrace.h>
+#include <asm/tdx.h>
 
 #include "mm_internal.h"
 
@@ -974,6 +975,11 @@ int add_pages(int nid, unsigned long start_pfn, unsigned long nr_pages,
 	return ret;
 }
 
+int arch_check_hotplug_memory_range(u64 start, u64 size)
+{
+	return tdx_check_hotplug_memory_range(start, size);
+}
+
 int arch_add_memory(int nid, u64 start, u64 size,
 		    struct mhp_params *params)
 {
diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index 4e2b2e2ac9f9..f70b4ebe7cc5 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -1388,36 +1388,37 @@ static bool is_tdx_memory(unsigned long start_pfn, unsigned long end_pfn)
 	return false;
 }
 
-static int tdx_memory_notifier(struct notifier_block *nb, unsigned long action,
-			       void *v)
+/*
+ * We don't allow mixture of TDX and !TDX memory in the buddy so we
+ * won't run into trouble when launching encrypted VMs that really
+ * need TDX-capable memory.
+ */
+int tdx_check_hotplug_memory_range(u64 start, u64 size)
 {
-	struct memory_notify *mn = v;
-
-	if (action != MEM_GOING_ONLINE)
-		return NOTIFY_OK;
+	u64 start_pfn = PHYS_PFN(start);
+	u64 end_pfn = PHYS_PFN(start + size);
 
 	/*
 	 * Empty list means TDX isn't enabled.  Allow any memory
-	 * to go online.
+	 * to be hot-added.
 	 */
 	if (list_empty(&tdx_memlist))
-		return NOTIFY_OK;
+		return 0;
 
 	/*
 	 * The TDX memory configuration is static and can not be
-	 * changed.  Reject onlining any memory which is outside of
+	 * changed.  Reject hot-adding any memory which is outside of
 	 * the static configuration whether it supports TDX or not.
 	 */
-	if (is_tdx_memory(mn->start_pfn, mn->start_pfn + mn->nr_pages))
-		return NOTIFY_OK;
+	if (is_tdx_memory(start_pfn, end_pfn))
+		return 0;
 
-	return NOTIFY_BAD;
+	pr_info("Reject hot-adding memory range: %#llx-%#llx for TDX compatibility.\n",
+		start, start + size);
+
+	return -EINVAL;
 }
 
-static struct notifier_block tdx_memory_nb = {
-	.notifier_call = tdx_memory_notifier,
-};
-
 static void __init check_tdx_erratum(void)
 {
 	/*
@@ -1465,13 +1466,6 @@ void __init tdx_init(void)
 		return;
 	}
 
-	err = register_memory_notifier(&tdx_memory_nb);
-	if (err) {
-		pr_err("initialization failed: register_memory_notifier() failed (%d)\n",
-				err);
-		return;
-	}
-
 #if defined(CONFIG_ACPI) && defined(CONFIG_SUSPEND)
 	pr_info("Disable ACPI S3. Turn off TDX in the BIOS to use ACPI S3.\n");
 	acpi_suspend_lowlevel = NULL;
diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
index b27ddce5d324..c5ba7b909bb4 100644
--- a/include/linux/memory_hotplug.h
+++ b/include/linux/memory_hotplug.h
@@ -140,6 +140,9 @@ extern int try_online_node(int nid);
 
 extern int arch_add_memory(int nid, u64 start, u64 size,
 			   struct mhp_params *params);
+
+extern int arch_check_hotplug_memory_range(u64 start, u64 size);
+
 extern u64 max_mem_size;
 
 extern int mhp_online_type_from_str(const char *str);
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 621ae1015106..c4769f24b1e2 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1305,6 +1305,11 @@ int try_online_node(int nid)
 	return ret;
 }
 
+int __weak arch_check_hotplug_memory_range(u64 start, u64 size)
+{
+	return 0;
+}
+
 static int check_hotplug_memory_range(u64 start, u64 size)
 {
 	/* memory range must be block size aligned */
@@ -1315,7 +1320,7 @@ static int check_hotplug_memory_range(u64 start, u64 size)
 		return -EINVAL;
 	}
 
-	return 0;
+	return arch_check_hotplug_memory_range(start, size);
 }
 
 static int online_memory_block(struct memory_block *mem, void *arg)
-- 
2.39.2


