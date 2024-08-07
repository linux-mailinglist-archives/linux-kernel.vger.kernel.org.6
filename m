Return-Path: <linux-kernel+bounces-277869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB94194A781
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 14:08:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2F6C285E92
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 12:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE1A31E4EFB;
	Wed,  7 Aug 2024 12:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JWH/SOCo"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D2A31E6725;
	Wed,  7 Aug 2024 12:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723032474; cv=none; b=Km1ttSF3sr2Jk6lYVq+7bG2GAXwT2vyKFEgbEiiDU2m+iU5BXwsFqNIkulxFSB+HDSQ0waFPWqb3cO83fk4/6kaO5+Hj3tbV85ZtMiP1e6tBMKl5hhDwcO4Rk5Kuo3hCevaLtBzYFyZbHuP8t39zCTfdXnTEIsuJcLY0tJGVof0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723032474; c=relaxed/simple;
	bh=Yz167uTaMz9q9BuBfAk4wU8AEfX9sRD5xBcmCC5iI9I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WzlmOwaCRWfhteK3+0WgGhYIRoJPTS6GuVtUQod6GWbfFgFcBEEc3XS57c2DSE3AM16GlqWLgkfl+YFkcJSJXEut4WoUEnClqUAzQOH9fFrXJzCaI1A20f4ehW7ue4RNoKcGZMsboEpyTfdwVrA3+vMyku2fLbWTBRiw+3Nur7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JWH/SOCo; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723032473; x=1754568473;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Yz167uTaMz9q9BuBfAk4wU8AEfX9sRD5xBcmCC5iI9I=;
  b=JWH/SOCovDv3LW+BvSlf73ltQIna9JVPGk8tXLa+AUOrPyZfR35b8quy
   yU4ofKkCFqxlzhe9utLMimDbA1Jn6EiXA8MVmEjpwIwDZU7ZpY13t1b82
   bNJowgVF+qJZZwlOH+e8QLyZPr7J6S3y43/XD7ak/y/dGOlQ1Uz2L7gtj
   VTwow2Njq73QOuaivqdYByLPESYhS5yUKZVx2eJXdwh7E2SXfLryOKpfn
   kkSc+UPW+4OaG6y91sLN8CFy5MGz5pqpKxcXpvO1KcaHSth+h5uXNCR2H
   F3IBeqZ8Umwgn+MwRW0wG/eh+CAiWQrqTqbQ6f+rF12lWChBLIxn/fUzf
   A==;
X-CSE-ConnectionGUID: bKHbKSdmTVSwmm5RYFg4Nw==
X-CSE-MsgGUID: 31aLZjJcRa+47r3Telmnsw==
X-IronPort-AV: E=McAfee;i="6700,10204,11157"; a="32484016"
X-IronPort-AV: E=Sophos;i="6.09,269,1716274800"; 
   d="scan'208";a="32484016"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2024 05:07:52 -0700
X-CSE-ConnectionGUID: CilM0nwsSue/vyw2croYaQ==
X-CSE-MsgGUID: 27i/zZk9RiOVZNRwPZXPWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,269,1716274800"; 
   d="scan'208";a="80080475"
Received: from jraag-nuc8i7beh.iind.intel.com ([10.145.169.79])
  by fmviesa002.fm.intel.com with ESMTP; 07 Aug 2024 05:07:46 -0700
From: Raag Jadav <raag.jadav@intel.com>
To: jani.nikula@linux.intel.com,
	joonas.lahtinen@linux.intel.com,
	rodrigo.vivi@intel.com,
	tursulin@ursulin.net,
	airlied@gmail.com,
	daniel@ffwll.ch,
	linux@roeck-us.net
Cc: intel-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	anshuman.gupta@intel.com,
	badal.nilawar@intel.com,
	riana.tauro@intel.com,
	ashutosh.dixit@intel.com,
	karthik.poosa@intel.com,
	andriy.shevchenko@linux.intel.com,
	Raag Jadav <raag.jadav@intel.com>
Subject: [PATCH v3] drm/i915/hwmon: expose fan speed
Date: Wed,  7 Aug 2024 18:00:18 +0530
Message-Id: <20240807123018.827506-1-raag.jadav@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add hwmon support for fan1_input attribute, which will expose fan speed
in RPM. With this in place we can monitor fan speed using lm-sensors tool.

$ sensors
i915-pci-0300
Adapter: PCI adapter
in0:         653.00 mV
fan1:        3833 RPM
power1:           N/A  (max =  43.00 W)
energy1:      32.02 kJ

v3:
- Declare rotations as "long" and drop redundant casting
- Change date and version in ABI documentation
- Add commenter name in changelog (Riana)

v2:
- Add mutex protection
- Handle overflow
- Add ABI documentation
- Aesthetic adjustments (Riana)

Signed-off-by: Raag Jadav <raag.jadav@intel.com>
Reviewed-by: Riana Tauro <riana.tauro@intel.com>
---
 .../ABI/testing/sysfs-driver-intel-i915-hwmon |  8 ++
 drivers/gpu/drm/i915/gt/intel_gt_regs.h       |  2 +
 drivers/gpu/drm/i915/i915_hwmon.c             | 88 +++++++++++++++++++
 3 files changed, 98 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-driver-intel-i915-hwmon b/Documentation/ABI/testing/sysfs-driver-intel-i915-hwmon
index 92fe7c5c5ac1..be4141a7522f 100644
--- a/Documentation/ABI/testing/sysfs-driver-intel-i915-hwmon
+++ b/Documentation/ABI/testing/sysfs-driver-intel-i915-hwmon
@@ -75,3 +75,11 @@ Description:	RO. Energy input of device or gt in microjoules.
 		for the gt.
 
 		Only supported for particular Intel i915 graphics platforms.
+
+What:		/sys/bus/pci/drivers/i915/.../hwmon/hwmon<i>/fan1_input
+Date:		November 2024
+KernelVersion:	6.12
+Contact:	intel-gfx@lists.freedesktop.org
+Description:	RO. Fan speed of device in RPM.
+
+		Only supported for particular Intel i915 graphics platforms.
diff --git a/drivers/gpu/drm/i915/gt/intel_gt_regs.h b/drivers/gpu/drm/i915/gt/intel_gt_regs.h
index e42b3a5d4e63..57a3c83d3655 100644
--- a/drivers/gpu/drm/i915/gt/intel_gt_regs.h
+++ b/drivers/gpu/drm/i915/gt/intel_gt_regs.h
@@ -1553,6 +1553,8 @@
 #define VLV_RENDER_C0_COUNT			_MMIO(0x138118)
 #define VLV_MEDIA_C0_COUNT			_MMIO(0x13811c)
 
+#define PCU_PWM_FAN_SPEED			_MMIO(0x138140)
+
 #define GEN12_RPSTAT1				_MMIO(0x1381b4)
 #define   GEN12_VOLTAGE_MASK			REG_GENMASK(10, 0)
 #define   GEN12_CAGF_MASK			REG_GENMASK(19, 11)
diff --git a/drivers/gpu/drm/i915/i915_hwmon.c b/drivers/gpu/drm/i915/i915_hwmon.c
index 49db3e09826c..6b34cb146ea4 100644
--- a/drivers/gpu/drm/i915/i915_hwmon.c
+++ b/drivers/gpu/drm/i915/i915_hwmon.c
@@ -36,6 +36,7 @@ struct hwm_reg {
 	i915_reg_t pkg_rapl_limit;
 	i915_reg_t energy_status_all;
 	i915_reg_t energy_status_tile;
+	i915_reg_t fan_speed;
 };
 
 struct hwm_energy_info {
@@ -43,11 +44,17 @@ struct hwm_energy_info {
 	long accum_energy;			/* Accumulated energy for energy1_input */
 };
 
+struct hwm_fan_info {
+	u32 reg_val_prev;
+	u32 time_prev;
+};
+
 struct hwm_drvdata {
 	struct i915_hwmon *hwmon;
 	struct intel_uncore *uncore;
 	struct device *hwmon_dev;
 	struct hwm_energy_info ei;		/*  Energy info for energy1_input */
+	struct hwm_fan_info fi;			/*  Fan info for fan1_input */
 	char name[12];
 	int gt_n;
 	bool reset_in_progress;
@@ -276,6 +283,7 @@ static const struct hwmon_channel_info * const hwm_info[] = {
 	HWMON_CHANNEL_INFO(power, HWMON_P_MAX | HWMON_P_RATED_MAX | HWMON_P_CRIT),
 	HWMON_CHANNEL_INFO(energy, HWMON_E_INPUT),
 	HWMON_CHANNEL_INFO(curr, HWMON_C_CRIT),
+	HWMON_CHANNEL_INFO(fan, HWMON_F_INPUT),
 	NULL
 };
 
@@ -613,6 +621,70 @@ hwm_curr_write(struct hwm_drvdata *ddat, u32 attr, long val)
 	}
 }
 
+static umode_t
+hwm_fan_is_visible(const struct hwm_drvdata *ddat, u32 attr)
+{
+	struct i915_hwmon *hwmon = ddat->hwmon;
+
+	switch (attr) {
+	case hwmon_fan_input:
+		return i915_mmio_reg_valid(hwmon->rg.fan_speed) ? 0444 : 0;
+	default:
+		return 0;
+	}
+}
+
+static int
+hwm_fan_read(struct hwm_drvdata *ddat, u32 attr, long *val)
+{
+	struct i915_hwmon *hwmon = ddat->hwmon;
+	struct hwm_fan_info *fi = &ddat->fi;
+	u32 reg_val, pulses, time, time_now;
+	intel_wakeref_t wakeref;
+	long rotations;
+	int ret = 0;
+
+	switch (attr) {
+	case hwmon_fan_input:
+		with_intel_runtime_pm(ddat->uncore->rpm, wakeref) {
+			mutex_lock(&hwmon->hwmon_lock);
+
+			reg_val = intel_uncore_read(ddat->uncore, hwmon->rg.fan_speed);
+			time_now = jiffies_to_msecs(jiffies);
+
+			/* Handle overflow */
+			if (reg_val >= fi->reg_val_prev)
+				pulses = reg_val - fi->reg_val_prev;
+			else
+				pulses = UINT_MAX - fi->reg_val_prev + reg_val;
+
+			/*
+			 * HW register value is accumulated count of pulses from
+			 * PWM fan with the scale of 2 pulses per rotation.
+			 */
+			rotations = pulses >> 1;
+			time = time_now - fi->time_prev;
+
+			if (unlikely(!time)) {
+				ret = -EAGAIN;
+				mutex_unlock(&hwmon->hwmon_lock);
+				break;
+			}
+
+			/* Convert to minutes for calculating RPM */
+			*val = DIV_ROUND_UP(rotations * (60 * MSEC_PER_SEC), time);
+
+			fi->reg_val_prev = reg_val;
+			fi->time_prev = time_now;
+
+			mutex_unlock(&hwmon->hwmon_lock);
+		}
+		return ret;
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
 static umode_t
 hwm_is_visible(const void *drvdata, enum hwmon_sensor_types type,
 	       u32 attr, int channel)
@@ -628,6 +700,8 @@ hwm_is_visible(const void *drvdata, enum hwmon_sensor_types type,
 		return hwm_energy_is_visible(ddat, attr);
 	case hwmon_curr:
 		return hwm_curr_is_visible(ddat, attr);
+	case hwmon_fan:
+		return hwm_fan_is_visible(ddat, attr);
 	default:
 		return 0;
 	}
@@ -648,6 +722,8 @@ hwm_read(struct device *dev, enum hwmon_sensor_types type, u32 attr,
 		return hwm_energy_read(ddat, attr, val);
 	case hwmon_curr:
 		return hwm_curr_read(ddat, attr, val);
+	case hwmon_fan:
+		return hwm_fan_read(ddat, attr, val);
 	default:
 		return -EOPNOTSUPP;
 	}
@@ -739,12 +815,14 @@ hwm_get_preregistration_info(struct drm_i915_private *i915)
 		hwmon->rg.pkg_rapl_limit = PCU_PACKAGE_RAPL_LIMIT;
 		hwmon->rg.energy_status_all = PCU_PACKAGE_ENERGY_STATUS;
 		hwmon->rg.energy_status_tile = INVALID_MMIO_REG;
+		hwmon->rg.fan_speed = PCU_PWM_FAN_SPEED;
 	} else {
 		hwmon->rg.pkg_power_sku_unit = INVALID_MMIO_REG;
 		hwmon->rg.pkg_power_sku = INVALID_MMIO_REG;
 		hwmon->rg.pkg_rapl_limit = INVALID_MMIO_REG;
 		hwmon->rg.energy_status_all = INVALID_MMIO_REG;
 		hwmon->rg.energy_status_tile = INVALID_MMIO_REG;
+		hwmon->rg.fan_speed = INVALID_MMIO_REG;
 	}
 
 	with_intel_runtime_pm(uncore->rpm, wakeref) {
@@ -755,6 +833,16 @@ hwm_get_preregistration_info(struct drm_i915_private *i915)
 		if (i915_mmio_reg_valid(hwmon->rg.pkg_power_sku_unit))
 			val_sku_unit = intel_uncore_read(uncore,
 							 hwmon->rg.pkg_power_sku_unit);
+
+		/*
+		 * Store the initial fan register value, so that we can use it for
+		 * initial fan speed calculation.
+		 */
+		if (i915_mmio_reg_valid(hwmon->rg.fan_speed)) {
+			ddat->fi.reg_val_prev = intel_uncore_read(uncore,
+								  hwmon->rg.fan_speed);
+			ddat->fi.time_prev = jiffies_to_msecs(jiffies);
+		}
 	}
 
 	hwmon->scl_shift_power = REG_FIELD_GET(PKG_PWR_UNIT, val_sku_unit);
-- 
2.34.1


