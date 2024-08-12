Return-Path: <linux-kernel+bounces-282747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DDEDA94E81C
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 09:53:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E6451C21786
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 07:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E56C615C155;
	Mon, 12 Aug 2024 07:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XFU1cdm6"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2178225DA;
	Mon, 12 Aug 2024 07:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723449209; cv=none; b=hTeLqFv8y+wlHJevJz9eImr47ISO8fEb9DweLH5OxaWLXmmVxftsF2i0mfWFzdGmrt2tsVWb6ULs8F1L+qoBiOVwBv+BmIvXJPSlSl/aTUL7vJ30Kroazfh4b+YyH4223sAbOWUV8gsrPwJU83N0ijZSrFiH+lNIdVW7voMW8wA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723449209; c=relaxed/simple;
	bh=yER9ECaWC3IMUJdmyfW3eRFZCMGXlQq9Juc1YWzMYPk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=J/H0W4WvVWYw6bahUgBIs4fduqho2gioU1DEXrsT0RqmsOHJtvd4LcNNBi4I9pjIR2gwWWuKZcYl/Xb+XsoF9N9m/6WBJT4oCBFpOd8bAaG6NJH05MPd2s6DOuDGQImJ/i8LQTJwlBSQPjDSJl+Xk5Tj7NdfTZ/AXKVe2wxiTDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XFU1cdm6; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723449207; x=1754985207;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=yER9ECaWC3IMUJdmyfW3eRFZCMGXlQq9Juc1YWzMYPk=;
  b=XFU1cdm64ixw1bsGMO6c8fnBEo8+x4ZCC0hqKQ7REcxEt5F7smuio9NL
   dSpKHVN6PdTNIaw7jpBZsEYOWszoqDOkHfzeutGLCM1ij2AuKbONOOAqj
   pjlXEXECgv84DEoVtl6NcLM/CJ3e7hMPAlHPhzR4TxuHhQKqYYPnkw3G6
   L0VmEkGvBXtSr8HY3cbBS5HVUI91LEwTlXhyg8YqPeoM7PKzmuKSDT/9K
   IIhGlbgm6mqPE4mSNlRkEb6GZtYzirLcZ8FVjkWIoGrvKCgLntGeydHpN
   zERj8QYNWAtEiuwvgjiqT9bXwW0XS11E3pd1ALwgzvkji0OXDR8PG4ABt
   A==;
X-CSE-ConnectionGUID: IirQhU84RreoXgw4I4zBiw==
X-CSE-MsgGUID: yG8JddpLRkuen2sS7JA2Tw==
X-IronPort-AV: E=McAfee;i="6700,10204,11161"; a="25313286"
X-IronPort-AV: E=Sophos;i="6.09,282,1716274800"; 
   d="scan'208";a="25313286"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2024 00:53:26 -0700
X-CSE-ConnectionGUID: IRtdwPF9RmuiRz84aQ70Xg==
X-CSE-MsgGUID: ZHNIyP7uR9aqXXCAKHwdpA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,282,1716274800"; 
   d="scan'208";a="58085702"
Received: from jraag-nuc8i7beh.iind.intel.com ([10.145.169.79])
  by orviesa009.jf.intel.com with ESMTP; 12 Aug 2024 00:53:19 -0700
From: Raag Jadav <raag.jadav@intel.com>
To: jani.nikula@linux.intel.com,
	joonas.lahtinen@linux.intel.com,
	rodrigo.vivi@intel.com,
	tursulin@ursulin.net,
	airlied@gmail.com,
	daniel@ffwll.ch,
	linux@roeck-us.net,
	andi.shyti@linux.intel.com,
	andriy.shevchenko@linux.intel.com
Cc: intel-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	anshuman.gupta@intel.com,
	badal.nilawar@intel.com,
	riana.tauro@intel.com,
	ashutosh.dixit@intel.com,
	karthik.poosa@intel.com,
	Raag Jadav <raag.jadav@intel.com>
Subject: [PATCH v5] drm/i915/hwmon: expose fan speed
Date: Mon, 12 Aug 2024 13:45:38 +0530
Message-Id: <20240812081538.1457396-1-raag.jadav@intel.com>
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

v2: Handle overflow, add mutex protection and ABI documentation
    Aesthetic adjustments (Riana)
v3: Declare rotations as "long", change ABI date and version
    Add commenter name in changelog (Riana)
v4: Fix wakeref leak
    Drop switch case and simplify hwm_fan_xx() (Andi)
v5: Rework time calculation, aesthetic adjustments (Andy)

Signed-off-by: Raag Jadav <raag.jadav@intel.com>
Reviewed-by: Riana Tauro <riana.tauro@intel.com>
---
 .../ABI/testing/sysfs-driver-intel-i915-hwmon |  8 ++
 drivers/gpu/drm/i915/gt/intel_gt_regs.h       |  2 +
 drivers/gpu/drm/i915/i915_hwmon.c             | 85 +++++++++++++++++++
 3 files changed, 95 insertions(+)

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
index 49db3e09826c..a867b81a0900 100644
--- a/drivers/gpu/drm/i915/i915_hwmon.c
+++ b/drivers/gpu/drm/i915/i915_hwmon.c
@@ -5,6 +5,7 @@
 
 #include <linux/hwmon.h>
 #include <linux/hwmon-sysfs.h>
+#include <linux/jiffies.h>
 #include <linux/types.h>
 
 #include "i915_drv.h"
@@ -36,6 +37,7 @@ struct hwm_reg {
 	i915_reg_t pkg_rapl_limit;
 	i915_reg_t energy_status_all;
 	i915_reg_t energy_status_tile;
+	i915_reg_t fan_speed;
 };
 
 struct hwm_energy_info {
@@ -43,11 +45,17 @@ struct hwm_energy_info {
 	long accum_energy;			/* Accumulated energy for energy1_input */
 };
 
+struct hwm_fan_info {
+	u32 reg_val_prev;
+	u64 time_prev;
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
@@ -276,6 +284,7 @@ static const struct hwmon_channel_info * const hwm_info[] = {
 	HWMON_CHANNEL_INFO(power, HWMON_P_MAX | HWMON_P_RATED_MAX | HWMON_P_CRIT),
 	HWMON_CHANNEL_INFO(energy, HWMON_E_INPUT),
 	HWMON_CHANNEL_INFO(curr, HWMON_C_CRIT),
+	HWMON_CHANNEL_INFO(fan, HWMON_F_INPUT),
 	NULL
 };
 
@@ -613,6 +622,66 @@ hwm_curr_write(struct hwm_drvdata *ddat, u32 attr, long val)
 	}
 }
 
+static umode_t
+hwm_fan_is_visible(const struct hwm_drvdata *ddat, u32 attr)
+{
+	struct i915_hwmon *hwmon = ddat->hwmon;
+
+	return attr == hwmon_fan_input &&
+	       i915_mmio_reg_valid(hwmon->rg.fan_speed) ? 0444 : 0;
+}
+
+static int
+hwm_fan_read(struct hwm_drvdata *ddat, u32 attr, long *val)
+{
+	struct i915_hwmon *hwmon = ddat->hwmon;
+	struct hwm_fan_info *fi = &ddat->fi;
+	u64 rotations, time_now, time;
+	intel_wakeref_t wakeref;
+	u32 reg_val, pulses;
+	int ret = 0;
+
+	if (attr != hwmon_fan_input)
+		return -EOPNOTSUPP;
+
+	wakeref = intel_runtime_pm_get(ddat->uncore->rpm);
+	mutex_lock(&hwmon->hwmon_lock);
+
+	reg_val = intel_uncore_read(ddat->uncore, hwmon->rg.fan_speed);
+	time_now = get_jiffies_64();
+
+	/* Handle HW register overflow */
+	if (reg_val >= fi->reg_val_prev)
+		pulses = reg_val - fi->reg_val_prev;
+	else
+		pulses = UINT_MAX - fi->reg_val_prev + reg_val;
+
+	/*
+	 * HW register value is accumulated count of pulses from
+	 * PWM fan with the scale of 2 pulses per rotation.
+	 */
+	rotations = pulses / 2;
+
+	time = jiffies_delta_to_msecs(time_now - fi->time_prev);
+	if (unlikely(!time)) {
+		ret = -EAGAIN;
+		goto exit;
+	}
+
+	/*
+	 * Convert to minutes for calculating RPM.
+	 * RPM = number of rotations * msecs per minute / time in msecs
+	 */
+	*val = DIV_ROUND_UP(rotations * (MSEC_PER_SEC * 60), time);
+
+	fi->reg_val_prev = reg_val;
+	fi->time_prev = time_now;
+exit:
+	mutex_unlock(&hwmon->hwmon_lock);
+	intel_runtime_pm_put(ddat->uncore->rpm, wakeref);
+	return ret;
+}
+
 static umode_t
 hwm_is_visible(const void *drvdata, enum hwmon_sensor_types type,
 	       u32 attr, int channel)
@@ -628,6 +697,8 @@ hwm_is_visible(const void *drvdata, enum hwmon_sensor_types type,
 		return hwm_energy_is_visible(ddat, attr);
 	case hwmon_curr:
 		return hwm_curr_is_visible(ddat, attr);
+	case hwmon_fan:
+		return hwm_fan_is_visible(ddat, attr);
 	default:
 		return 0;
 	}
@@ -648,6 +719,8 @@ hwm_read(struct device *dev, enum hwmon_sensor_types type, u32 attr,
 		return hwm_energy_read(ddat, attr, val);
 	case hwmon_curr:
 		return hwm_curr_read(ddat, attr, val);
+	case hwmon_fan:
+		return hwm_fan_read(ddat, attr, val);
 	default:
 		return -EOPNOTSUPP;
 	}
@@ -739,12 +812,14 @@ hwm_get_preregistration_info(struct drm_i915_private *i915)
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
@@ -755,6 +830,16 @@ hwm_get_preregistration_info(struct drm_i915_private *i915)
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
+			ddat->fi.time_prev = get_jiffies_64();
+		}
 	}
 
 	hwmon->scl_shift_power = REG_FIELD_GET(PKG_PWR_UNIT, val_sku_unit);
-- 
2.34.1


