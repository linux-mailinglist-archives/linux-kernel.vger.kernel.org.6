Return-Path: <linux-kernel+bounces-196480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBBDD8D5CD8
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 10:36:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF42F1C2290A
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 08:36:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AFAE152162;
	Fri, 31 May 2024 08:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y4SehAPy"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF732150980;
	Fri, 31 May 2024 08:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717144563; cv=none; b=PyAZhdhyxGHjDlllW8tl6D/fEohcztAbwS67emoHIBCoiLJNd/+19xswIzTdDX/ZsdVKtmejaOc97bfeThtmlFatGejrK3Y6CkAi/S8x0XGdw5eooQ6h4w+k1fFKdXtCzWL9FGur8xODeSUqOZSvAW4AIwQTg7eJbOiCpaaiWOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717144563; c=relaxed/simple;
	bh=v47caOo50vrBzPaSET/JvoN04/v1VUoO5XuozIOCxzQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qw9314Jtljj6NUyoUXxGaO14SfUIF0KneCnoauQHD0iYZRG76j2jlpnzHHidJz/1m6HkBpwvimzAQUsdxazppT9vVRvFfYUTrJz4cQzRYnKtUPBlwPTloF6kyqdBRn/450TGJVgeDRUTKNcE24IKTeWlEXVJdJpyWjx/VZxXcDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y4SehAPy; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717144562; x=1748680562;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=v47caOo50vrBzPaSET/JvoN04/v1VUoO5XuozIOCxzQ=;
  b=Y4SehAPy8kWq1Wh6orx4ZMAa95OauZn2xt+sK+Nfe/4Fq6wPXllbUtYA
   3UsDuCpgqvabcLUETWGxwjEnCYFPJkbW9EL2nxc46zBVvFS6ThtunR317
   MH7uQWc/r1qUNQ3QmtTtTrBRzfBqAUhA3RZ1SnibFdKrNwzCwSsgu5tMB
   nxuBe48V6HyQxY7Uqh5q3TtYgtT83PqX2C4AdI9mXDlOfQZV2dfqFkEno
   cUnVrhnNe8ofZ4e4Xgke/aMoaeP1MRX4h5besUWurJHMzWua6T2okPArX
   68oM5e2PFrPbjNrsMnO0d7o039CVrtxZVICKAXOBwqvIO0rJSKb/zNdIx
   g==;
X-CSE-ConnectionGUID: MNACb/NDSwmVx4nEBZ4k6A==
X-CSE-MsgGUID: 4bLBGz5nTo6AMQXlOMAXtQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11088"; a="13495950"
X-IronPort-AV: E=Sophos;i="6.08,203,1712646000"; 
   d="scan'208";a="13495950"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2024 01:36:00 -0700
X-CSE-ConnectionGUID: 3IWi82zJSQukPa31XGCjeA==
X-CSE-MsgGUID: O+berEIyS6qxJDrNnGDnZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,203,1712646000"; 
   d="scan'208";a="36193449"
Received: from spandruv-desk.jf.intel.com ([10.54.75.19])
  by fmviesa009.fm.intel.com with ESMTP; 31 May 2024 01:35:59 -0700
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com
Cc: platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	andriy.shevchenko@linux.intel.com,
	rui.zhang@intel.com,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v2 1/3] platform/x86: ISST: Add model specific loading for common module
Date: Fri, 31 May 2024 01:35:46 -0700
Message-ID: <20240531083554.1313110-2-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240531083554.1313110-1-srinivas.pandruvada@linux.intel.com>
References: <20240531083554.1313110-1-srinivas.pandruvada@linux.intel.com>
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
Reviewed-by: Zhang Rui <rui.zhang@intel.com>
---
v2:
Split the MSR check for Skylake-X to new patch as suggested by Ilpo.
Using new family model check macros.

Note:
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Andy's Reviewed-by was for one version before Rafael and Rui's
comments were addressed. So didn't add it before "---". 
We can add it if there is no issue from Andy.

Also incorporated changes suggested by "Wysocki, Rafael J"
<rafael.j.wysocki@intel.com>.

We have all the models supported till date are already in 6.9
kernel. So this is more for future proofing for the first use case.

 .../intel/speed_select_if/isst_if_common.c    | 63 +++++++++++--------
 1 file changed, 37 insertions(+), 26 deletions(-)

diff --git a/drivers/platform/x86/intel/speed_select_if/isst_if_common.c b/drivers/platform/x86/intel/speed_select_if/isst_if_common.c
index 713c0d1fa85f..47f5f26e6c20 100644
--- a/drivers/platform/x86/intel/speed_select_if/isst_if_common.c
+++ b/drivers/platform/x86/intel/speed_select_if/isst_if_common.c
@@ -718,14 +718,6 @@ static struct miscdevice isst_if_char_driver = {
 	.fops		= &isst_if_char_driver_ops,
 };
 
-static const struct x86_cpu_id hpm_cpu_ids[] = {
-	X86_MATCH_INTEL_FAM6_MODEL(GRANITERAPIDS_D,	NULL),
-	X86_MATCH_INTEL_FAM6_MODEL(GRANITERAPIDS_X,	NULL),
-	X86_MATCH_INTEL_FAM6_MODEL(ATOM_CRESTMONT,	NULL),
-	X86_MATCH_INTEL_FAM6_MODEL(ATOM_CRESTMONT_X,	NULL),
-	{}
-};
-
 static int isst_misc_reg(void)
 {
 	mutex_lock(&punit_misc_dev_reg_lock);
@@ -733,12 +725,6 @@ static int isst_misc_reg(void)
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
@@ -786,8 +772,6 @@ static void isst_misc_unreg(void)
  */
 int isst_if_cdev_register(int device_type, struct isst_if_cmd_cb *cb)
 {
-	int ret;
-
 	if (device_type >= ISST_IF_DEV_MAX)
 		return -EINVAL;
 
@@ -805,15 +789,6 @@ int isst_if_cdev_register(int device_type, struct isst_if_cmd_cb *cb)
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
@@ -829,7 +804,6 @@ EXPORT_SYMBOL_GPL(isst_if_cdev_register);
  */
 void isst_if_cdev_unregister(int device_type)
 {
-	isst_misc_unreg();
 	mutex_lock(&punit_misc_dev_open_lock);
 	punit_callbacks[device_type].def_ioctl = NULL;
 	punit_callbacks[device_type].registered = 0;
@@ -839,5 +813,42 @@ void isst_if_cdev_unregister(int device_type)
 }
 EXPORT_SYMBOL_GPL(isst_if_cdev_unregister);
 
+#define SST_HPM_SUPPORTED	0x01
+
+static const struct x86_cpu_id isst_cpu_ids[] = {
+	X86_MATCH_VFM(INTEL_ATOM_CRESTMONT,	SST_HPM_SUPPORTED),
+	X86_MATCH_VFM(INTEL_ATOM_CRESTMONT_X,	SST_HPM_SUPPORTED),
+	X86_MATCH_VFM(INTEL_EMERALDRAPIDS_X,	0),
+	X86_MATCH_VFM(INTEL_GRANITERAPIDS_D,	SST_HPM_SUPPORTED),
+	X86_MATCH_VFM(INTEL_GRANITERAPIDS_X,	SST_HPM_SUPPORTED),
+	X86_MATCH_VFM(INTEL_ICELAKE_D,		0),
+	X86_MATCH_VFM(INTEL_ICELAKE_X,		0),
+	X86_MATCH_VFM(INTEL_SAPPHIRERAPIDS_X,	0),
+	X86_MATCH_VFM(INTEL_SKYLAKE_X,		0),
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
+	if (id->driver_data == SST_HPM_SUPPORTED)
+		isst_hpm_support = true;
+
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
2.40.1


