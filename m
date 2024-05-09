Return-Path: <linux-kernel+bounces-175058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC7CC8C19B3
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 01:03:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDE9A2855B2
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 23:03:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7628C130A46;
	Thu,  9 May 2024 23:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AAUYEXmh"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9235012D755;
	Thu,  9 May 2024 23:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715295769; cv=none; b=NTuAs/K/68dtZfTocNnMeGCf8Y/mBwz6/ydCAI0KGtMUbg41hM0yA5elHP3ChtTFHILvro1iHk63nUPPMqTAHCwj/zKdBzF11fRkHUIhoM15eH5Dfko0s9TBbYVHHvZt1YA3CCvc1Qy7cHI/jQ0MSEnIn/14n1APqfJPI3juHiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715295769; c=relaxed/simple;
	bh=vnVA/pN6y9rbKw76o1gmBlKyEfxuKQeabl8ovgTNHWs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B9qaWo4u1om93fgkHyhhK9WWWN2CM13HPSLjhlXu1fGHISKE/ZqKN++yuAhMbtJICcdhLptMzyAbsL5vDAPO1Lr46M8HxSxswua+d5y60ylQo/lyKNs6UYXAN+NRtBG4npjYNyK30dVSkEyxpOcLiOn+vhve+dmS3XxBUViMVdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AAUYEXmh; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715295768; x=1746831768;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vnVA/pN6y9rbKw76o1gmBlKyEfxuKQeabl8ovgTNHWs=;
  b=AAUYEXmhWiIz/aUKz4B1ezA8alnLSKUwK0g3LCcD5XlSZqDY6bMouoHl
   kzikO1g43xPsq34jeE7MNxrhaYBGwMpDPxo9z4hqMzEpelrPeezXVtg2R
   mWqP+MlnJNQnY1FbZ1RrGl3HtK45Wgo6XwG8i7JdwRCKaecAHo5fLCEdZ
   iFtYaOnyLZ6HPgaRry18szjCHjA+8ZCwivq+t9dZff5/8d1QWhER3D+WH
   40N0qai4CroNoq53rpZBVY6G9b2AVtJC2t2nPfR7UkYYoPOhOwhIpU8bn
   Kms9GtIWRB4IQWTk0xA0lcA9tJC2Dq7V/cV00LnpkJivlLMoWN02nX0RD
   A==;
X-CSE-ConnectionGUID: qf26JtJ/S+6y6kd72vjDZA==
X-CSE-MsgGUID: sDwTjTn4QVKMLIt+WPAZgQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11068"; a="11100506"
X-IronPort-AV: E=Sophos;i="6.08,149,1712646000"; 
   d="scan'208";a="11100506"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2024 16:02:46 -0700
X-CSE-ConnectionGUID: 2U5Ns5k1TMiDUTHEtNQNtA==
X-CSE-MsgGUID: AkvU97SOTZeIhr2GAQiHdA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,149,1712646000"; 
   d="scan'208";a="29790213"
Received: from spandruv-desk.jf.intel.com ([10.54.75.19])
  by orviesa006.jf.intel.com with ESMTP; 09 May 2024 16:02:45 -0700
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	andriy.shevchenko@linux.intel.com
Cc: platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 1/2] platform/x86: ISST: Add model specific loading for common module
Date: Thu,  9 May 2024 16:02:35 -0700
Message-ID: <20240509230236.1494326-2-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240509230236.1494326-1-srinivas.pandruvada@linux.intel.com>
References: <20240509230236.1494326-1-srinivas.pandruvada@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

SST common module is loaded when model specific or TPMI SST driver
registers for services. There are model specific features used in SST
common modules which are checked with a CPU model list. So, this module
is model specific.

There are some use cases where loading the common module independently
only on the supported CPU models helps. The first use case is for
preventing SST TPMI module loading if the model specific features are
not implemented. The second use case for presenting information to
user space when SST is used in OOB (Out of Band) mode.

1.
With TPMI, SST interface is architectural. This means that no need to add
new PCI device IDs for new CPU models. This means that there can be lag
in adding CPU models for the model specific features in the common
module. For example, before adding CPU model to GRANITERAPIDS_D to
hpm_cpu_ids[], SST is still functional for some features and but will
get/set wrong data for features like SST-CP. This is because IOCTL
ISST_IF_GET_PHY_ID, will not give correct mapping for newer CPU models.
So adding explicit model check during load time will prevent such cases.
For unsupported CPU models, common driver will fail to load and hence
dependent modules will not be loaded.

2.
When the SST TPMI features are controlled by some OOB agent (not from OS
interface), even if the CPU model is supported, there will be no user
space interface available for tools as SST TPMI modules will not
be loaded. User space interface is registered when TPMI modules call
isst_if_cdev_register(). Even in this case user space orchestrator
software needs to get power domain information to schedule workload and
get/set turbo ratio limits. This information is exposed by the common
module using IOCTLs ISST_IF_GET_PHY_ID and ISST_IF_MSR_COMMAND
respectively. Since the user space MSR access can be locked, direct MSR
access from the user space is not an option using /dev/cpu/*/msr.

Converge all the existing model checks to one common place and
use driver data to differentiate. On successful model check
call isst_misc_reg().

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Reviewed-by: Zhang Rui <rui.zhang@intel.com
---
Note:
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Andy's Reviewed-by was for one version before Rafael and Rui's
comments were addressed. So didn't add it before "---". 
We can add it if there is no issue from Andy.

Also incorporated changes suggested by "Wysocki, Rafael J"
<rafael.j.wysocki@intel.com>.

We have all the models supported till date are already in 6.9
kernel. So this is more for future proofing for the first use case.


 .../intel/speed_select_if/isst_if_common.c    | 80 +++++++++++++------
 1 file changed, 56 insertions(+), 24 deletions(-)

diff --git a/drivers/platform/x86/intel/speed_select_if/isst_if_common.c b/drivers/platform/x86/intel/speed_select_if/isst_if_common.c
index 88a17be7cb7e..f886f9369fad 100644
--- a/drivers/platform/x86/intel/speed_select_if/isst_if_common.c
+++ b/drivers/platform/x86/intel/speed_select_if/isst_if_common.c
@@ -718,12 +718,6 @@ static struct miscdevice isst_if_char_driver = {
 	.fops		= &isst_if_char_driver_ops,
 };
 
-static const struct x86_cpu_id hpm_cpu_ids[] = {
-	X86_MATCH_INTEL_FAM6_MODEL(GRANITERAPIDS_X,	NULL),
-	X86_MATCH_INTEL_FAM6_MODEL(ATOM_CRESTMONT_X,	NULL),
-	{}
-};
-
 static int isst_misc_reg(void)
 {
 	mutex_lock(&punit_misc_dev_reg_lock);
@@ -731,12 +725,6 @@ static int isst_misc_reg(void)
 		goto unlock_exit;
 
 	if (!misc_usage_count) {
-		const struct x86_cpu_id *id;
-
-		id = x86_match_cpu(hpm_cpu_ids);
-		if (id)
-			isst_hpm_support = true;
-
 		misc_device_ret = isst_if_cpu_info_init();
 		if (misc_device_ret)
 			goto unlock_exit;
@@ -784,8 +772,6 @@ static void isst_misc_unreg(void)
  */
 int isst_if_cdev_register(int device_type, struct isst_if_cmd_cb *cb)
 {
-	int ret;
-
 	if (device_type >= ISST_IF_DEV_MAX)
 		return -EINVAL;
 
@@ -803,15 +789,6 @@ int isst_if_cdev_register(int device_type, struct isst_if_cmd_cb *cb)
 	punit_callbacks[device_type].registered = 1;
 	mutex_unlock(&punit_misc_dev_open_lock);
 
-	ret = isst_misc_reg();
-	if (ret) {
-		/*
-		 * No need of mutex as the misc device register failed
-		 * as no one can open device yet. Hence no contention.
-		 */
-		punit_callbacks[device_type].registered = 0;
-		return ret;
-	}
 	return 0;
 }
 EXPORT_SYMBOL_GPL(isst_if_cdev_register);
@@ -827,7 +804,6 @@ EXPORT_SYMBOL_GPL(isst_if_cdev_register);
  */
 void isst_if_cdev_unregister(int device_type)
 {
-	isst_misc_unreg();
 	mutex_lock(&punit_misc_dev_open_lock);
 	punit_callbacks[device_type].def_ioctl = NULL;
 	punit_callbacks[device_type].registered = 0;
@@ -837,5 +813,61 @@ void isst_if_cdev_unregister(int device_type)
 }
 EXPORT_SYMBOL_GPL(isst_if_cdev_unregister);
 
+#define SST_HPM_SUPPORTED		0x01
+#define SST_MBOX_SUPPORTED		0x02
+
+#define MSR_OS_MAILBOX_INTERFACE        0xB0
+#define MSR_OS_MAILBOX_DATA             0xB1
+
+static const struct x86_cpu_id isst_cpu_ids[] = {
+	X86_MATCH_INTEL_FAM6_MODEL(ATOM_CRESTMONT,	SST_HPM_SUPPORTED),
+	X86_MATCH_INTEL_FAM6_MODEL(ATOM_CRESTMONT_X,	SST_HPM_SUPPORTED),
+	X86_MATCH_INTEL_FAM6_MODEL(EMERALDRAPIDS_X,	0),
+	X86_MATCH_INTEL_FAM6_MODEL(GRANITERAPIDS_D,	SST_HPM_SUPPORTED),
+	X86_MATCH_INTEL_FAM6_MODEL(GRANITERAPIDS_X,	SST_HPM_SUPPORTED),
+	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_D,		0),
+	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_X,		0),
+	X86_MATCH_INTEL_FAM6_MODEL(SAPPHIRERAPIDS_X,	0),
+	X86_MATCH_INTEL_FAM6_MODEL(SKYLAKE_X,		SST_MBOX_SUPPORTED),
+	{}
+};
+MODULE_DEVICE_TABLE(x86cpu, isst_cpu_ids);
+
+static int __init isst_if_common_init(void)
+{
+	const struct x86_cpu_id *id;
+
+	id = x86_match_cpu(isst_cpu_ids);
+	if (!id)
+		return -ENODEV;
+
+	if (!id->driver_data)
+		goto misc_reg;
+
+	if (id->driver_data == SST_HPM_SUPPORTED) {
+		isst_hpm_support = true;
+		goto misc_reg;
+	}
+
+	if (id->driver_data == SST_MBOX_SUPPORTED) {
+		u64 data;
+
+		/* Can fail only on some Skylake-X generations */
+		if (rdmsrl_safe(MSR_OS_MAILBOX_INTERFACE, &data) ||
+		    rdmsrl_safe(MSR_OS_MAILBOX_DATA, &data))
+			return -ENODEV;
+	}
+
+misc_reg:
+	return isst_misc_reg();
+}
+module_init(isst_if_common_init)
+
+static void __exit isst_if_common_exit(void)
+{
+	isst_misc_unreg();
+}
+module_exit(isst_if_common_exit)
+
 MODULE_DESCRIPTION("ISST common interface module");
 MODULE_LICENSE("GPL v2");
-- 
2.44.0


