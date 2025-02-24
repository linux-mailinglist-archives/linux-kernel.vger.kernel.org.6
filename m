Return-Path: <linux-kernel+bounces-528134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B676A413F5
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 04:23:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1B7C17245F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 03:22:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 788441B4234;
	Mon, 24 Feb 2025 03:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ATD+jVa7"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAE051A5B9A
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 03:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740367323; cv=none; b=KJUPmAb0jCRLzbfIYH3SYUS9qEhS5JtXXAY8S5pGCz2kD0KqKMlDmOijzSdWReUHXRJV44UO3QlAE7Acg+Y2qukspyg0hgtlZKM/xvDSozIu84DmLWwwzKOQAlzyEm6dn4VxeaHObqtPsuefVNkzz63QGytQXsmtTwLoiOFaFJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740367323; c=relaxed/simple;
	bh=gtvQmFMZq96hBKeNoF2V0rliu4QKfGTnrxvFeoQp8Ss=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QI+xgzH6ksZtcgePTXv/FgRlZQ1zitl2Hpa/Us7AXLD+lsURdpBaKM1g5jEooiIfw/ZsavRtKyxyIfGUPikxl1FvSbQqKpn0IGYxuqnFj2Df6TBVexhi4NWF34W5poTLZmWxVoVdkHAGeJiYwHHkXOEgbIaHn3dZIP/rdoxSkBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ATD+jVa7; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740367322; x=1771903322;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=gtvQmFMZq96hBKeNoF2V0rliu4QKfGTnrxvFeoQp8Ss=;
  b=ATD+jVa784JgKNPocwP0DvSWeip4DRsKwNbdcgZibnkllG3GKR8lXOjC
   ZQ4sG7BysksbCamkvDxtFHxyKaNYrZX71IUokDkV+RWujy/2UAGsaQP6w
   sqJ6EUb44R/SwlZnLa0iry8Vx3BnOFGCEzMurrBXLkougZOqIXTDXQt4K
   eZHMXAWS/KZwE5SEbhUly8Gd9wfLhz7+yzVAkro4lOQUfUwz0EJqWa/av
   d4afg4ymr/9dYjnWitXCS4GgJGOwmFBLuFNndzUGy6OnIIF5U1W8Hiex+
   j02sY7BbrczEcKxFtoFTlRmeJldqh7xW498W7ZKYI1xV6zL5JDGoROT2i
   A==;
X-CSE-ConnectionGUID: mjqVxB5qToStJx0d01EFPg==
X-CSE-MsgGUID: H/3XUxImQJ+kI3rnIxIS9Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11354"; a="28706895"
X-IronPort-AV: E=Sophos;i="6.13,309,1732608000"; 
   d="scan'208";a="28706895"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2025 19:21:56 -0800
X-CSE-ConnectionGUID: 98GZGlJlThOh0sx475/aTw==
X-CSE-MsgGUID: /pY/rAzpTNOzD/pMmjuJvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,309,1732608000"; 
   d="scan'208";a="116441906"
Received: from shanagud-mobl.amr.corp.intel.com (HELO bxing-mobl1.clients.intel.com) ([10.246.117.251])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2025 19:21:17 -0800
From: Cedric Xing <cedric.xing@intel.com>
Date: Sun, 23 Feb 2025 21:20:15 -0600
Subject: [PATCH v2 4/4] x86/tdx: Expose TDX MRs through TSM sysfs interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250223-tdx-rtmr-v2-4-f2d85b0a5f94@intel.com>
References: <20250223-tdx-rtmr-v2-0-f2d85b0a5f94@intel.com>
In-Reply-To: <20250223-tdx-rtmr-v2-0-f2d85b0a5f94@intel.com>
To: Dan Williams <dan.j.williams@intel.com>, 
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, 
 Dave Hansen <dave.hansen@linux.intel.com>, 
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, x86@kernel.org, 
 "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, 
 Dionna Amalie Glaze <dionnaglaze@google.com>, 
 James Bottomley <James.Bottomley@HansenPartnership.com>, 
 Dan Middleton <dan.middleton@linux.intel.com>, 
 Mikko Ylinen <mikko.ylinen@linux.intel.com>, 
 Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>
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
enabled/disabled by setting TDX_GUEST_DRIVER_TSM_REPORT to Y/n.

Signed-off-by: Cedric Xing <cedric.xing@intel.com>
---
 drivers/virt/coco/tdx-guest/Kconfig     |  24 +++++--
 drivers/virt/coco/tdx-guest/tdx-guest.c | 115 ++++++++++++++++++++++++++++++++
 2 files changed, 134 insertions(+), 5 deletions(-)

diff --git a/drivers/virt/coco/tdx-guest/Kconfig b/drivers/virt/coco/tdx-guest/Kconfig
index 22dd59e19431..a1c5e8fdd511 100644
--- a/drivers/virt/coco/tdx-guest/Kconfig
+++ b/drivers/virt/coco/tdx-guest/Kconfig
@@ -3,9 +3,23 @@ config TDX_GUEST_DRIVER
 	depends on INTEL_TDX_GUEST
 	select TSM_REPORTS
 	help
-	  The driver provides userspace interface to communicate with
-	  the TDX module to request the TDX guest details like attestation
-	  report.
+	  The driver provides userspace interface to communicate with the TDX
+	  module to request the TDX guest details like attestation report.
 
-	  To compile this driver as module, choose M here. The module will
-	  be called tdx-guest.
+	  To compile this driver as module, choose M here. The module will be
+	  called tdx-guest.
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
index 224e7dde9cde..a31fe2098901 100644
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
@@ -304,6 +308,110 @@ static const struct tsm_ops tdx_tsm_ops = {
 	.report_bin_attr_visible = tdx_report_bin_attr_visible,
 };
 
+enum {
+	TDREPORT_MRSIZE = SHA384_DIGEST_SIZE,
+
+	TDREPORT_reportdata = 128,
+	TDREPORT_tdinfo = 512,
+	TDREPORT_mrtd = TDREPORT_tdinfo + 16,
+	TDREPORT_mrconfigid = TDREPORT_mrtd + TDREPORT_MRSIZE,
+	TDREPORT_mrowner = TDREPORT_mrconfigid + TDREPORT_MRSIZE,
+	TDREPORT_mrownerconfig = TDREPORT_mrowner + TDREPORT_MRSIZE,
+	TDREPORT_rtmr0 = TDREPORT_mrownerconfig + TDREPORT_MRSIZE,
+	TDREPORT_rtmr1 = TDREPORT_rtmr0 + TDREPORT_MRSIZE,
+	TDREPORT_rtmr2 = TDREPORT_rtmr1 + TDREPORT_MRSIZE,
+	TDREPORT_rtmr3 = TDREPORT_rtmr2 + TDREPORT_MRSIZE,
+	TDREPORT_servtd_hash = TDREPORT_rtmr3 + TDREPORT_MRSIZE,
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
+#if IS_ENABLED(CONFIG_TDX_GUEST_DRIVER_TSM_REPORT)
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
+#if IS_BUILTIN(CONFIG_TDX_GUEST_DRIVER)
+	tdreport = tdx_mr_report;
+#else
+	tdreport = kmalloc(sizeof(tdx_mr_report), GFP_KERNEL);
+	if (!tdreport)
+		return -ENOMEM;
+
+	reportdata = memcpy(tdreport + TDREPORT_reportdata, reportdata,
+			    TDX_REPORTDATA_LEN);
+#endif
+
+	ret = tdx_mcall_get_report0(reportdata, tdreport);
+	if (ret)
+		pr_err("GetReport call failed\n");
+
+#if !IS_BUILTIN(CONFIG_TDX_GUEST_DRIVER)
+	memcpy(tdx_mr_report, tdreport, sizeof(tdx_mr_report));
+	kfree(tdreport);
+#endif
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
+	buf = kmalloc(64, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	memcpy(buf, data, TDREPORT_MRSIZE);
+
+	ret = tdx_mcall_extend_rtmr((u8)(mr - tmr->mrs), buf);
+	if (ret)
+		pr_err("Extending RTMR%ld failed\n", mr - tmr->mrs);
+
+	kfree(buf);
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
@@ -326,8 +434,14 @@ static int __init tdx_guest_init(void)
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
@@ -339,6 +453,7 @@ module_init(tdx_guest_init);
 
 static void __exit tdx_guest_exit(void)
 {
+	tsm_unregister_measurement(&tdx_measurement);
 	tsm_unregister(&tdx_tsm_ops);
 	free_quote_buf(quote_data);
 	misc_deregister(&tdx_misc_dev);

-- 
2.43.0


