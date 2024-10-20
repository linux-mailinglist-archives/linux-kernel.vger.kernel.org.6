Return-Path: <linux-kernel+bounces-373143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B12299A52F2
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 08:51:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B9C81F212B1
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 06:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16CE217C9E;
	Sun, 20 Oct 2024 06:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EH9c4M06"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C631928EB;
	Sun, 20 Oct 2024 06:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729407057; cv=none; b=Nlku6WYIKFwNtNufzx1lu3EpHEVpODjI0n/GCflOMfoSQIwvAeeqpbhzXxN4j/Q7rhgf7YXyogoUvYp1Q/7k+Jj+HUo4YaG99H6NyaJIPOhTnuFInTG9JZ494vCeA1Cpe58ca21OM6m9TG8+doOFICAJwjUW3C0hflG3aMTDP/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729407057; c=relaxed/simple;
	bh=Cf6eLL/oK/2Ir4bVqv9yHXutWtwSCE1F7LYv6MlYOTA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=B063MKER1MQAqmS2FjZFitPutpmiw88KFyHRy3mnuaxpZH8aO/4rBQuL4g/V2JisIFCbzxacVAN8HwLc2c6c2oZnxSB3RPvbOr8WQeO9qFFWtawq9cmhPh8LDcFjBRSHqv5aZEIbMHwsaC4CWBzcTxNcuK1M3qSTiY87yHZW0OI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EH9c4M06; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729407054; x=1760943054;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Cf6eLL/oK/2Ir4bVqv9yHXutWtwSCE1F7LYv6MlYOTA=;
  b=EH9c4M0648Ht1DPm2rJ4KPwL4aycDevLZZ+yZnZlF2xcF2WQDhnk4YbR
   lZMPRYwtnThtQ/quPCByWQlKZVJ/u3/C+WBSkFAEs3anzb2oKJ3h0nTcm
   Q3jxqTZ7d0uamnBSjhxXsNaXOrvmo/HNeggMF59qbyNnUhRoqPPIEf6t1
   3V79OSH5FES/6bldpFhma+3i0wBf2c+lnUbO5jO4ilLbIjhQ+KZxxnhAn
   fk2JimrgcNw9FG3T9HC0S5OQSlV1SJnfM0+EVjUPu1ZujDg7Yr5ub8T8s
   TTPKG7k08VA+MQu13CMTHeBEZVO9rHM/33P54oz6eCU1W0/daV42lzxo/
   w==;
X-CSE-ConnectionGUID: cd0lNFGLRHCKABpdtZoTMw==
X-CSE-MsgGUID: ORyK3HzaRLWU7Nq8ZLEoFw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="40026757"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="40026757"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2024 23:50:54 -0700
X-CSE-ConnectionGUID: isCuoNaEQROBSUfipFRwjA==
X-CSE-MsgGUID: yIB8uUtyR9KrNQ7u97HlUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,218,1725346800"; 
   d="scan'208";a="79189919"
Received: from spandruv-desk.jf.intel.com ([10.54.75.21])
  by orviesa010.jf.intel.com with ESMTP; 19 Oct 2024 23:50:55 -0700
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: corentin.chary@gmail.com,
	luke@ljones.dev,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com
Cc: platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Michael Larabel <Michael@phoronix.com>,
	Casey Bowman <casey.g.bowman@intel.com>
Subject: [PATCH] platform/x86: asus-wmi: Support setting AIPT modes
Date: Sat, 19 Oct 2024 23:50:51 -0700
Message-ID: <20241020065051.1724435-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Some recent Asus laptops are supporting ASUS Intelligent Performance
Technology (AIPT). This solution allows users to have maximized CPU
performance in models with a chassis providing more thermal head room.
Refer to [1].

There are major performance issues when Linux is installed on these
laptops compared to Windows install. One such report is published for
Graphics benchmarks on Asus ASUS Zenbook S 14 with Lunar Lake
processors [2].

By default, these laptops are booting in "Whisper Mode" till OS power
management or tools change this to other AIPT mode. This "Whisper" mode
calls to set lower maximum and minimum RAPL (Running Average Power Limit)
via thermal tables. On Linux this leads to lower performance even when
platform power profile is "balanced". This "Whisper" mode should
correspond to "quiet" mode.

So, when AIPT is present change the default mode to "Standard" during
boot. Map the three platform power profile modes as follows:

Power Profile Mode      AIPT mode
-----------------------------------
quiet			Whisper
balanced		Standard
performance		Performance
------------------------------------

Here AIPT mode can be detected by checking presese of "FANL" method under
PNP HID "PNP0C14" and UID "ATK". If AIPT mode is present, this takes
precedence over the existing VIVO thermal policy. These modes are set
using "FANL" method.

Although this “FANL” method is not used in the Asus WMI driver, users
have used this method from user space [3] to set AIPT modes. Used this
as a reference.

Link: https://www.asus.com/content/laptop-asus-intelligent-performance-technology-aipt/ # [1]
Reported-by: Michael Larabel <Michael@phoronix.com>
Closes: https://www.phoronix.com/review/lunar-lake-xe2/5 # [2]
Link: https://github.com/dominiksalvet/asus-fan-control/issues/151 # [3]
Tested-by: Casey Bowman <casey.g.bowman@intel.com>
Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/platform/x86/asus-wmi.c | 93 +++++++++++++++++++++++++++++++--
 1 file changed, 89 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index 7a48220b4f5a..06689d0f98c7 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -100,6 +100,11 @@ module_param(fnlock_default, bool, 0444);
 #define ASUS_THROTTLE_THERMAL_POLICY_SILENT_VIVO	1
 #define ASUS_THROTTLE_THERMAL_POLICY_OVERBOOST_VIVO	2
 
+#define AIPT_STANDARD				0
+#define AIPT_WHISPER				1
+#define AIPT_PERFORMANCE			2
+#define AIPT_FULL_SPEED				3
+
 #define PLATFORM_PROFILE_MAX 2
 
 #define USB_INTEL_XUSB2PR		0xD0
@@ -333,6 +338,9 @@ struct asus_wmi {
 	struct asus_wmi_debug debug;
 
 	struct asus_wmi_driver *driver;
+	acpi_handle acpi_mgmt_handle;
+	int asus_aipt_mode;
+	bool asus_aipt_present;
 };
 
 /* WMI ************************************************************************/
@@ -3804,6 +3812,19 @@ static ssize_t throttle_thermal_policy_store(struct device *dev,
 static DEVICE_ATTR_RW(throttle_thermal_policy);
 
 /* Platform profile ***********************************************************/
+static int asus_wmi_write_aipt_mode(struct asus_wmi *asus, int aipt_mode)
+{
+	int status;
+
+	status = acpi_execute_simple_method(asus->acpi_mgmt_handle, "FANL", aipt_mode);
+	if (ACPI_FAILURE(status)) {
+		acpi_handle_info(asus->acpi_mgmt_handle, "FANL execute failed\n");
+		return -EIO;
+	}
+
+	return 0;
+}
+
 static int asus_wmi_platform_profile_to_vivo(struct asus_wmi *asus, int mode)
 {
 	bool vivo;
@@ -3844,6 +3865,26 @@ static int asus_wmi_platform_profile_mode_from_vivo(struct asus_wmi *asus, int m
 	return mode;
 }
 
+static int asus_wmi_aipt_platform_profile_get(struct asus_wmi *asus,
+					      enum platform_profile_option *profile)
+{
+	switch (asus->asus_aipt_mode) {
+	case AIPT_STANDARD:
+		*profile = PLATFORM_PROFILE_BALANCED;
+		break;
+	case AIPT_PERFORMANCE:
+		*profile = PLATFORM_PROFILE_PERFORMANCE;
+		break;
+	case AIPT_WHISPER:
+		*profile = PLATFORM_PROFILE_QUIET;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static int asus_wmi_platform_profile_get(struct platform_profile_handler *pprof,
 					enum platform_profile_option *profile)
 {
@@ -3851,6 +3892,10 @@ static int asus_wmi_platform_profile_get(struct platform_profile_handler *pprof,
 	int tp;
 
 	asus = container_of(pprof, struct asus_wmi, platform_profile_handler);
+
+	if (asus->asus_aipt_present)
+		return asus_wmi_aipt_platform_profile_get(asus, profile);
+
 	tp = asus->throttle_thermal_policy_mode;
 
 	switch (asus_wmi_platform_profile_mode_from_vivo(asus, tp)) {
@@ -3874,26 +3919,42 @@ static int asus_wmi_platform_profile_set(struct platform_profile_handler *pprof,
 					enum platform_profile_option profile)
 {
 	struct asus_wmi *asus;
-	int tp;
+	int ret = 0, tp, aipt_mode;
 
 	asus = container_of(pprof, struct asus_wmi, platform_profile_handler);
 
 	switch (profile) {
 	case PLATFORM_PROFILE_PERFORMANCE:
 		tp = ASUS_THROTTLE_THERMAL_POLICY_OVERBOOST;
+		aipt_mode = AIPT_PERFORMANCE;
 		break;
 	case PLATFORM_PROFILE_BALANCED:
 		tp = ASUS_THROTTLE_THERMAL_POLICY_DEFAULT;
+		aipt_mode = AIPT_STANDARD;
 		break;
 	case PLATFORM_PROFILE_QUIET:
 		tp = ASUS_THROTTLE_THERMAL_POLICY_SILENT;
+		aipt_mode = AIPT_WHISPER;
 		break;
 	default:
 		return -EOPNOTSUPP;
 	}
 
-	asus->throttle_thermal_policy_mode = asus_wmi_platform_profile_to_vivo(asus, tp);
-	return throttle_thermal_policy_write(asus);
+	if (asus->asus_aipt_present) {
+		ret = asus_wmi_write_aipt_mode(asus, aipt_mode);
+		if (!ret) {
+			asus->asus_aipt_mode = aipt_mode;
+			goto skip_vivo;
+		}
+	}
+
+	if (asus->throttle_thermal_policy_dev) {
+		asus->throttle_thermal_policy_mode = asus_wmi_platform_profile_to_vivo(asus, tp);
+		ret = throttle_thermal_policy_write(asus);
+	}
+
+skip_vivo:
+	return ret;
 }
 
 static int platform_profile_setup(struct asus_wmi *asus)
@@ -3905,7 +3966,7 @@ static int platform_profile_setup(struct asus_wmi *asus)
 	 * Not an error if a component platform_profile relies on is unavailable
 	 * so early return, skipping the setup of platform_profile.
 	 */
-	if (!asus->throttle_thermal_policy_dev)
+	if (!asus->throttle_thermal_policy_dev && !asus->asus_aipt_present)
 		return 0;
 
 	dev_info(dev, "Using throttle_thermal_policy for platform_profile support\n");
@@ -4538,6 +4599,7 @@ static int asus_wmi_sysfs_init(struct platform_device *device)
 static int asus_wmi_platform_init(struct asus_wmi *asus)
 {
 	struct device *dev = &asus->platform_device->dev;
+	struct acpi_device *adev;
 	char *wmi_uid;
 	int rv;
 
@@ -4593,6 +4655,29 @@ static int asus_wmi_platform_init(struct asus_wmi *asus)
 		asus_wmi_set_devstate(ASUS_WMI_DEVID_CWAP,
 				      asus->driver->quirks->wapf, NULL);
 
+	/*
+	 * Check presence of Intelligent Performance Technology (AIPT).
+	 * If present store acpi handle and set asus_aipt_present to true.
+	 */
+	adev = acpi_dev_get_first_match_dev("PNP0C14", "ATK", -1);
+	if (adev) {
+		acpi_handle handle = acpi_device_handle(adev);
+
+		acpi_dev_put(adev);
+
+		if (!acpi_has_method(handle, "FANL"))
+			return 0;
+
+		asus->acpi_mgmt_handle = handle;
+		asus->asus_aipt_present = true;
+		dev_info(dev, "ASUS Intelligent Performance Technology (AIPT) is present\n");
+		/*
+		 * Set the mode corresponding to default Linux platform power
+		 * profile Balanced
+		 */
+		asus_wmi_write_aipt_mode(asus, AIPT_STANDARD);
+	}
+
 	return 0;
 }
 
-- 
2.43.0


