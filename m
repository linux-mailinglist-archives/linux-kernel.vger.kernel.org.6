Return-Path: <linux-kernel+bounces-512198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 519D5A3357A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 03:24:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AF40168046
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 02:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64B34202C40;
	Thu, 13 Feb 2025 02:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mLduJNIU"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0201820010B
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 02:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739413407; cv=none; b=bENtzWwYx0m51QxoAP0zBecfyS5ksbL/k6+awcKQYcQyQq6kNzecdtoI6r6dJ0xXUcerVa9x6fzcCZq3y57LGz0sOjxj8EaDQJutQVgQGo+GcDcTTEVuvGt9hANNvKaxONohOwUJIg/IuX09zYKzEqKp5fRDzsSuWe8Kq/3A4/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739413407; c=relaxed/simple;
	bh=KyIi0V4Mp6gPo+F4KA4qOFqrz0MVhzqomVxCnu29utQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JsnIZX/ziVTpy7D1gmF2AZri8UbuQLRpuF825Wfz9e+IOAZ2sW+OZO7du73pn1ooMKNZ57bePqlP49TCQAu6DIKz5taFbzYcFnqLHmXKfHAaQbLRxHnxipwYKR0FE8oIqVmscPIoNPjLljkhTYTIRsdnXWHzHF847GOM4ViffgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mLduJNIU; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739413407; x=1770949407;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=KyIi0V4Mp6gPo+F4KA4qOFqrz0MVhzqomVxCnu29utQ=;
  b=mLduJNIULksOSB9eejBp3rpCV9dLydy8YbPdRwX+9rleISEAD1+imQSl
   mUjD+CLO59D2uClXQEgYCsL63JnnxgxhwyxBICHcdNZFVjoZdeUSWqM4m
   vBZeSTeZjGoayE/w8iFdUa5ySpB48EuUNAlj9trXXjuWgD6hxaWWsVSjz
   hmsKz2EaF4DNmKRKbmI0xHnVNMeTglJyku8b5T4zWLGHOVU9h3+LCVe+O
   t3rQxP0pmZ7ErtiipRpNAeexiZstul4VdOcMGqkvG3SI4i+/30IhvRRjF
   6LyF6HNC6u5/+uj8xQhzd8ce1T4s03ZRN3i5ZmDieuFn0SYASHM3r0//r
   w==;
X-CSE-ConnectionGUID: VYQ5zIQYR5i2IDaF3FrKrA==
X-CSE-MsgGUID: e3Yyt3raR4KE6PmDsfy2VA==
X-IronPort-AV: E=McAfee;i="6700,10204,11343"; a="62566646"
X-IronPort-AV: E=Sophos;i="6.13,281,1732608000"; 
   d="scan'208";a="62566646"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2025 18:23:26 -0800
X-CSE-ConnectionGUID: hYXVCTrfT0eCv6yYg+g/TQ==
X-CSE-MsgGUID: WDHwzdiOS9W3/MyhQCSt9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="113905850"
Received: from rtice-desk1.amr.corp.intel.com (HELO bxing-mobl1.clients.intel.com) ([10.246.116.160])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2025 18:23:24 -0800
From: Cedric Xing <cedric.xing@intel.com>
Date: Wed, 12 Feb 2025 20:23:07 -0600
Subject: [PATCH 4/4] x86/tdx: Expose TDX MRs through TSM sysfs interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250212-tdx-rtmr-v1-4-9795dc49e132@intel.com>
References: <20250212-tdx-rtmr-v1-0-9795dc49e132@intel.com>
In-Reply-To: <20250212-tdx-rtmr-v1-0-9795dc49e132@intel.com>
To: Dan Williams <dan.j.williams@intel.com>, 
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, 
 Dave Hansen <dave.hansen@linux.intel.com>, 
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, x86@kernel.org, 
 "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, 
 Cedric Xing <cedric.xing@intel.com>
X-Mailer: b4 0.13.0

TDX MRs are made accessible to user mode as files (attributes) in sysfs.

Below shows the directory structure of TDX MRs inside a TDVM.

/sys/kernel/tsm
└── tdx
    ├── mrconfigid
    │   └── sha384
    │       └── digest
    ├── mrowner
    │   └── sha384
    │       └── digest
    ├── mrownerconfig
    │   └── sha384
    │       └── digest
    ├── mrtd
    │   └── sha384
    │       └── digest
    ├── report0
    ├── reportdata
    ├── rtmr0
    │   └── sha384
    │       └── digest
    ├── rtmr1
    │   └── sha384
    │       └── digest
    ├── rtmr2
    │   └── sha384
    │       └── digest
    ├── rtmr3
    │   └── sha384
    │       └── digest
    └── servtd_hash
        └── sha384
            └── digest

The digest attribute/file of each MR contains the MR's current value.

Writing to the digest attribute/file of an RTMR extends the written value
to that RTMR.

The report0 and reportdata attributes offer a simple interface for user
mode applications to request TDREPORTs. These 2 attributes can be
enabled/disabled by setting CONFIG_TDX_GUEST_DRIVER_TSM_REPORT to Y/n.

Signed-off-by: Cedric Xing <cedric.xing@intel.com>
---
 drivers/virt/coco/tdx-guest/Kconfig     |  15 ++++
 drivers/virt/coco/tdx-guest/tdx-guest.c | 119 ++++++++++++++++++++++++++++++++
 2 files changed, 134 insertions(+)

diff --git a/drivers/virt/coco/tdx-guest/Kconfig b/drivers/virt/coco/tdx-guest/Kconfig
index 22dd59e19431..effadcfd9918 100644
--- a/drivers/virt/coco/tdx-guest/Kconfig
+++ b/drivers/virt/coco/tdx-guest/Kconfig
@@ -9,3 +9,18 @@ config TDX_GUEST_DRIVER
 
 	  To compile this driver as module, choose M here. The module will
 	  be called tdx-guest.
+
+if TDX_GUEST_DRIVER
+
+config TDX_GUEST_DRIVER_TSM_REPORT
+	bool "tdx-guest: Enable TSM raw TDREPORT interface"
+	default y
+	help
+	  This option adds 2 files, namely report0 and reportdata, to the TSM
+	  sysfs directory tree (/sys/kernel/tsm/tdx/).
+
+	  To request a TDREPORT, set REPORTDATA by writing to
+	  /sys/kernel/tsm/tdx/reportdata, then read
+	  /sys/kernel/tsm/tdx/report0.
+
+endif
diff --git a/drivers/virt/coco/tdx-guest/tdx-guest.c b/drivers/virt/coco/tdx-guest/tdx-guest.c
index 224e7dde9cde..c95aa17e728c 100644
--- a/drivers/virt/coco/tdx-guest/tdx-guest.c
+++ b/drivers/virt/coco/tdx-guest/tdx-guest.c
@@ -5,6 +5,8 @@
  * Copyright (C) 2022 Intel Corporation
  */
 
+#define pr_fmt(fmt)			KBUILD_MODNAME ": " fmt
+
 #include <linux/kernel.h>
 #include <linux/miscdevice.h>
 #include <linux/mm.h>
@@ -18,6 +20,8 @@
 #include <linux/tsm.h>
 #include <linux/sizes.h>
 
+#include <crypto/hash_info.h>
+
 #include <uapi/linux/tdx-guest.h>
 
 #include <asm/cpu_device_id.h>
@@ -304,6 +308,114 @@ static const struct tsm_ops tdx_tsm_ops = {
 	.report_bin_attr_visible = tdx_report_bin_attr_visible,
 };
 
+enum {
+	TDREPORT_reportdata = 128,
+	TDREPORT_tdinfo = 512,
+	TDREPORT_mrtd = TDREPORT_tdinfo + 16,
+	TDREPORT_mrconfigid = TDREPORT_mrtd + 48,
+	TDREPORT_mrowner = TDREPORT_mrconfigid + 48,
+	TDREPORT_mrownerconfig = TDREPORT_mrowner + 48,
+	TDREPORT_rtmr0 = TDREPORT_mrownerconfig + 48,
+	TDREPORT_rtmr1 = TDREPORT_rtmr0 + 48,
+	TDREPORT_rtmr2 = TDREPORT_rtmr1 + 48,
+	TDREPORT_rtmr3 = TDREPORT_rtmr2 + 48,
+	TDREPORT_servtd_hash = TDREPORT_rtmr3 + 48,
+};
+
+static u8 tdx_mr_report[TDX_REPORT_LEN] __aligned(TDX_REPORT_LEN);
+
+#define TDX_MR_(r)	.mr_value = tdx_mr_report + TDREPORT_##r, TSM_MR_(r, SHA384)
+static const struct tsm_measurement_register tdx_mrs[] = {
+	{ TDX_MR_(rtmr0) | TSM_MR_F_RTMR | TSM_MR_F_W },
+	{ TDX_MR_(rtmr1) | TSM_MR_F_RTMR | TSM_MR_F_W },
+	{ TDX_MR_(rtmr2) | TSM_MR_F_RTMR | TSM_MR_F_W },
+	{ TDX_MR_(rtmr3) | TSM_MR_F_RTMR | TSM_MR_F_W },
+	{ TDX_MR_(mrtd) },
+	{ TDX_MR_(mrconfigid) },
+	{ TDX_MR_(mrowner) },
+	{ TDX_MR_(mrownerconfig) },
+	{ TDX_MR_(servtd_hash) },
+#ifdef CONFIG_TDX_GUEST_DRIVER_TSM_REPORT
+	{ .mr_value = tdx_mr_report, .mr_size = sizeof(tdx_mr_report),
+	  .mr_name = "report0", .mr_flags = TSM_MR_F_LIVE | TSM_MR_F_F },
+	{ .mr_value = tdx_mr_report + TDREPORT_reportdata,
+	  TSM_MR_(reportdata, SHA512) | TSM_MR_F_W | TSM_MR_F_F },
+#endif
+	{}
+};
+#undef TDX_MR_
+
+static int tdx_mr_refresh(struct tsm_measurement *tmr,
+			  const struct tsm_measurement_register *mr)
+{
+	u8 *reportdata, *tdreport;
+	int ret;
+
+	reportdata = tdx_mr_report + TDREPORT_reportdata;
+
+	/*
+	 * TDCALL requires a GPA as input. Depending on whether this module is
+	 * built as a built-in (Y) or a module (M), tdx_mr_report may or may
+	 * not be converted to a GPA using virt_to_phys. If not, a directly
+	 * mapped buffer must be allocated using kmalloc and used as an
+	 * intermediary.
+	 */
+	if (virt_addr_valid(tdx_mr_report))
+		tdreport = tdx_mr_report;
+	else {
+		tdreport = kmalloc(sizeof(tdx_mr_report), GFP_KERNEL);
+		if (!tdreport)
+			return -ENOMEM;
+
+		reportdata = memcpy(tdreport + TDREPORT_reportdata, reportdata,
+				    TDX_REPORTDATA_LEN);
+	}
+
+	ret = tdx_mcall_get_report0(reportdata, tdreport);
+	if (ret)
+		pr_err("GetReport call failed\n");
+
+	if (tdreport != tdx_mr_report) {
+		memcpy(tdx_mr_report, tdreport, sizeof(tdx_mr_report));
+		kfree(tdreport);
+	}
+
+	return ret;
+}
+
+static int tdx_mr_extend(struct tsm_measurement *tmr,
+			 const struct tsm_measurement_register *mr, const u8 *data)
+{
+	u8 *buf;
+	int ret;
+
+	if (virt_addr_valid(data))
+		buf = (u8 *)data;
+	else {
+		buf = kmalloc(64, GFP_KERNEL);
+		if (!buf)
+			return -ENOMEM;
+
+		memcpy(buf, data, mr->mr_size);
+	}
+
+	ret = tdx_mcall_rtmr_extend((u8)(mr - tmr->mrs), buf);
+	if (ret)
+		pr_err("Extending RTMR%ld failed\n", mr - tmr->mrs);
+
+	if (buf != data)
+		kfree(buf);
+
+	return ret;
+}
+
+static struct tsm_measurement tdx_measurement = {
+	.name = "tdx",
+	.mrs = tdx_mrs,
+	.refresh = tdx_mr_refresh,
+	.extend = tdx_mr_extend,
+};
+
 static int __init tdx_guest_init(void)
 {
 	int ret;
@@ -326,8 +438,14 @@ static int __init tdx_guest_init(void)
 	if (ret)
 		goto free_quote;
 
+	ret = tsm_register_measurement(&tdx_measurement);
+	if (ret)
+		goto unregister_tsm;
+
 	return 0;
 
+unregister_tsm:
+	tsm_unregister(&tdx_tsm_ops);
 free_quote:
 	free_quote_buf(quote_data);
 free_misc:
@@ -339,6 +457,7 @@ module_init(tdx_guest_init);
 
 static void __exit tdx_guest_exit(void)
 {
+	tsm_unregister_measurement(&tdx_measurement);
 	tsm_unregister(&tdx_tsm_ops);
 	free_quote_buf(quote_data);
 	misc_deregister(&tdx_misc_dev);

-- 
2.43.0


