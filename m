Return-Path: <linux-kernel+bounces-250608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF74C92F9D1
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 14:01:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A297A282B1D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 12:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53BE416D4F5;
	Fri, 12 Jul 2024 12:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q/QDS0r+"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E0038DCC
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 12:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720785654; cv=none; b=gW0HpZd2cu6YR/pd5r/FXhG5A0Cx9XUZu3pyPKJMyNomWiKxpFGZ94GxPt2mrmz0fEHScel+e+b4fhTK/ZmH/Op1yiRpOV8E28N+5G9PBqYF/Xb7yl39PN4vk98xq4EVhcK006/7eD8o74I6IWCN9rkNEtuEUghUJsJHf41cf+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720785654; c=relaxed/simple;
	bh=o7vz8xVIkT+hBTZntG1OJYZ9jPasws2I0t685Uabb5E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Q2TI3lElvdqzJroj0sdUX3cVnoN47BUmXcp9y1O7LJVFKYdANVadih6UBWzO1dclBXWxpaSe5bvtCey9I5SSQhiN7GTWhPWEevb+gP3RkHRGcaDAI7KjMGUnT0GXo4svV7HDFq1+el6+/jlaZIGxdyryKDFhHbQSd2MyoenxB84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q/QDS0r+; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720785653; x=1752321653;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=o7vz8xVIkT+hBTZntG1OJYZ9jPasws2I0t685Uabb5E=;
  b=Q/QDS0r+9gU2vaJ0BVOkqsTWygN/3Ozhf9u+Ni4rpX6Gb4vkI4CeilNC
   xvzcrhObcIy5LTYqCuD0jC56q3B5neNo4u/VOhJFc865bzFAKMwl3Kx24
   Tq9c9S8kZRizjPcebjQEfEsbu1u8UnqjjEAJpyTBBrLN94B3QJgJpyI1V
   I6/9XExp+EAB6qYVN0tZoXzMCEbjKbAdHglwpwb9dco0x5AU3CbRtFfhU
   yah+7uTGbe9cvWn98JTykf8xpOfgjLwcWyD3eLN3M9lhk3V0RweM6kwW/
   wcKg1SGgkIKCx9+xq7maqJBpRCBJXLAQ9tUyJShnLiP5UcPJ5KuHr2BRL
   g==;
X-CSE-ConnectionGUID: tukDBv3xQCi3qrIa5AqEig==
X-CSE-MsgGUID: YqXimWnJSN+YLjzCsIs3Aw==
X-IronPort-AV: E=McAfee;i="6700,10204,11130"; a="18339979"
X-IronPort-AV: E=Sophos;i="6.09,202,1716274800"; 
   d="scan'208";a="18339979"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2024 05:00:52 -0700
X-CSE-ConnectionGUID: HMd4kqDCQjiGtIZmjDF6ww==
X-CSE-MsgGUID: Xeebi1Q7QgOkf+GzHUNpUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,202,1716274800"; 
   d="scan'208";a="53463344"
Received: from jraag-nuc8i7beh.iind.intel.com ([10.145.169.79])
  by fmviesa004.fm.intel.com with ESMTP; 12 Jul 2024 05:00:45 -0700
From: Raag Jadav <raag.jadav@intel.com>
To: jani.nikula@linux.intel.com,
	joonas.lahtinen@linux.intel.com,
	rodrigo.vivi@intel.com,
	tursulin@ursulin.net,
	airlied@gmail.com,
	daniel@ffwll.ch
Cc: intel-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	anshuman.gupta@intel.com,
	badal.nilawar@intel.com,
	riana.tauro@intel.com,
	ashutosh.dixit@intel.com,
	karthik.poosa@intel.com,
	andriy.shevchenko@linux.intel.com,
	Raag Jadav <raag.jadav@intel.com>
Subject: [PATCH v1] drm/i915/hwmon: expose fan speed
Date: Fri, 12 Jul 2024 17:53:56 +0530
Message-Id: <20240712122356.360613-1-raag.jadav@intel.com>
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

Signed-off-by: Raag Jadav <raag.jadav@intel.com>
---
 drivers/gpu/drm/i915/gt/intel_gt_regs.h |  2 +
 drivers/gpu/drm/i915/i915_hwmon.c       | 71 +++++++++++++++++++++++++
 2 files changed, 73 insertions(+)

diff --git a/drivers/gpu/drm/i915/gt/intel_gt_regs.h b/drivers/gpu/drm/i915/gt/intel_gt_regs.h
index e42b3a5d4e63..407d8152755a 100644
--- a/drivers/gpu/drm/i915/gt/intel_gt_regs.h
+++ b/drivers/gpu/drm/i915/gt/intel_gt_regs.h
@@ -1553,6 +1553,8 @@
 #define VLV_RENDER_C0_COUNT			_MMIO(0x138118)
 #define VLV_MEDIA_C0_COUNT			_MMIO(0x13811c)
 
+#define GEN12_PWM_FAN_SPEED			_MMIO(0x138140)
+
 #define GEN12_RPSTAT1				_MMIO(0x1381b4)
 #define   GEN12_VOLTAGE_MASK			REG_GENMASK(10, 0)
 #define   GEN12_CAGF_MASK			REG_GENMASK(19, 11)
diff --git a/drivers/gpu/drm/i915/i915_hwmon.c b/drivers/gpu/drm/i915/i915_hwmon.c
index 49db3e09826c..f829c7837d83 100644
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
 
@@ -613,6 +621,55 @@ hwm_curr_write(struct hwm_drvdata *ddat, u32 attr, long val)
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
+	u32 reg_val, rotation, time, time_now;
+	intel_wakeref_t wakeref;
+
+	switch (attr) {
+	case hwmon_fan_input:
+		with_intel_runtime_pm(ddat->uncore->rpm, wakeref)
+			reg_val = intel_uncore_read(ddat->uncore, hwmon->rg.fan_speed);
+
+		time_now = jiffies_to_msecs(jiffies);
+
+		/*
+		 * HW register value is accumulated count of pulses from
+		 * PWM fan with the scale of 2 pulses per rotation.
+		 */
+		rotation = (reg_val - ddat->fi.reg_val_prev) >> 1;
+		time = time_now - ddat->fi.time_prev;
+
+		if (!time)
+			return -EAGAIN;
+
+		/* Convert to minutes for calculating RPM. */
+		*val = DIV_ROUND_UP((long)rotation * (60 * 1000), time);
+
+		ddat->fi.reg_val_prev = reg_val;
+		ddat->fi.time_prev = time_now;
+
+		return 0;
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
 static umode_t
 hwm_is_visible(const void *drvdata, enum hwmon_sensor_types type,
 	       u32 attr, int channel)
@@ -628,6 +685,8 @@ hwm_is_visible(const void *drvdata, enum hwmon_sensor_types type,
 		return hwm_energy_is_visible(ddat, attr);
 	case hwmon_curr:
 		return hwm_curr_is_visible(ddat, attr);
+	case hwmon_fan:
+		return hwm_fan_is_visible(ddat, attr);
 	default:
 		return 0;
 	}
@@ -648,6 +707,8 @@ hwm_read(struct device *dev, enum hwmon_sensor_types type, u32 attr,
 		return hwm_energy_read(ddat, attr, val);
 	case hwmon_curr:
 		return hwm_curr_read(ddat, attr, val);
+	case hwmon_fan:
+		return hwm_fan_read(ddat, attr, val);
 	default:
 		return -EOPNOTSUPP;
 	}
@@ -739,12 +800,14 @@ hwm_get_preregistration_info(struct drm_i915_private *i915)
 		hwmon->rg.pkg_rapl_limit = PCU_PACKAGE_RAPL_LIMIT;
 		hwmon->rg.energy_status_all = PCU_PACKAGE_ENERGY_STATUS;
 		hwmon->rg.energy_status_tile = INVALID_MMIO_REG;
+		hwmon->rg.fan_speed = GEN12_PWM_FAN_SPEED;
 	} else {
 		hwmon->rg.pkg_power_sku_unit = INVALID_MMIO_REG;
 		hwmon->rg.pkg_power_sku = INVALID_MMIO_REG;
 		hwmon->rg.pkg_rapl_limit = INVALID_MMIO_REG;
 		hwmon->rg.energy_status_all = INVALID_MMIO_REG;
 		hwmon->rg.energy_status_tile = INVALID_MMIO_REG;
+		hwmon->rg.fan_speed = INVALID_MMIO_REG;
 	}
 
 	with_intel_runtime_pm(uncore->rpm, wakeref) {
@@ -771,6 +834,14 @@ hwm_get_preregistration_info(struct drm_i915_private *i915)
 		for_each_gt(gt, i915, i)
 			hwm_energy(&hwmon->ddat_gt[i], &energy);
 	}
+
+	if (i915_mmio_reg_valid(hwmon->rg.fan_speed)) {
+		/* Take initial readings and use it while calculating actual fan speed. */
+		with_intel_runtime_pm(uncore->rpm, wakeref)
+			ddat->fi.reg_val_prev = intel_uncore_read(ddat->uncore,
+								  hwmon->rg.fan_speed);
+		ddat->fi.time_prev = jiffies_to_msecs(jiffies);
+	}
 }
 
 void i915_hwmon_register(struct drm_i915_private *i915)
-- 
2.34.1


