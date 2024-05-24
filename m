Return-Path: <linux-kernel+bounces-188796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EBE438CE717
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 16:32:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A11AF281823
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 14:32:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49C1812D219;
	Fri, 24 May 2024 14:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="zmT5rMh9"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2228312C805
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 14:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716561122; cv=none; b=t/Wk4DZHZSvszjGsN4xYAnsVdPyzQ0XwdF33UZ2TxR2/hrWIl3/0qyg62+fjgJfNqkaH0AEzsLEfOsXAI7/T7XRvPbPfEmC574d7xHpXU77zaHxmL65pIBnp6jwKckDKtfrOQnRgqpVju72b0xeBDPM9qi7mFSZUqlSfb2U1rXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716561122; c=relaxed/simple;
	bh=XxQPs+CKFd+C8xKkktDLuby2qDkISiDB0yAv0iDwLio=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qUe3VDoAwHkEPBe2t/Lx6QQpmkojZwwUPzdmboPN11fynrzem+j1/vb56iuqkk/VyiFkK4pyhZnsBo98PxE1qn69PynAOQfu34xc8+AjSuysuHVFC0cD+y5DJJ6K2On4ScXpNdqmIAiId3aHPBraOoEmfkeV1a3RqzsiCa+20OY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=zmT5rMh9; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-42108822e3cso4906235e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 07:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1716561118; x=1717165918; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5NZtcu9PAYXkGaMFVFG3nx6sddIRSoZPbItA3KPqh64=;
        b=zmT5rMh9zaxZCK/RNMgXtQhVH80OwCuawwlsXa+0ZB7wdl+aRghR0MkLu/OXkXUsUI
         NJczJMjI4C/5P6F7ovB9mW9fHe1YpfGRdkvIQ6XUzoXl72LnoDtPrurNPWPq2cPDCpf3
         BYog2sf49jjB75kyRwa8jaPxKLMNNuCqF49024mDZ/dEMoncXM62uxTNHacTq8bNOs1Y
         y2A/paPNpLtYJOeC8fOmWmkhSslAS64VCxHsASEyaHFsr51MqXosxN/vzb0lctkuWQUI
         47MW9NyB1niq62Yo5pGC7o4p+U+L0nLl+JptIvNE7jfbwH+wvYzsLzlofiQlpd34e8W5
         uSwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716561118; x=1717165918;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5NZtcu9PAYXkGaMFVFG3nx6sddIRSoZPbItA3KPqh64=;
        b=xLgj1HE+K4kXTQJfcCeJqCLps3+oXMAMIHQNKLBMGl9tUPPAl/0ygFQqeNaucJtYnP
         a90L/FVoHPGRdTdqLd1fMaKuUI0gZB43ByTUZuLPhrZ2QAB8yir87ihpZFfSX+6bjnGz
         Jd5UcXNiY6807YV2pLu5bK6Vag8zPRY8RV52lwxii89r36P94++mSfSNeDOoD8PF2JvH
         coFZL+kbi2B1XdF0aH30FAK6aXUDEeyyRM7bIDQgeS+fKpEt2OQzki8DKagamAsI5xxl
         KVaKxuxHgD3XHv2+Vz7jlqLYyX1cKLi/Puducm/XnLk2aGeqxohK91uHFNPG4G3NpOgv
         Akig==
X-Forwarded-Encrypted: i=1; AJvYcCWheHL0d7NadGphufdEjOivoni5JiT5MpGWVnmCwsxA3HycUreXq9DxSEM/uC4NVTbiJzYzeH3kbeRkjfGiURo/hp8IzZShL/FXFMO4
X-Gm-Message-State: AOJu0Yy7OBZoKSImfKURvovOpi8WCurYEVOkanykfmfL12DlpeNKsyoi
	NO7q4qrpMnN6DT8OYrUXvKi3oxTyPnUePF3rRiA1lNKXtnvgetTqiWXwS50X3wY=
X-Google-Smtp-Source: AGHT+IFWU8gG+e37pZmxQTBYP+ymcZvgVYFKwYUoy5BLlIk1BxT5PROIa+A09uXjEL4pfbi1jnhA8g==
X-Received: by 2002:a05:6000:11cf:b0:351:debf:a39e with SMTP id ffacd0b85a97d-354f757d1a5mr5109406f8f.27.1716561118543;
        Fri, 24 May 2024 07:31:58 -0700 (PDT)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3557a090c2bsm1719611f8f.59.2024.05.24.07.31.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 May 2024 07:31:58 -0700 (PDT)
From: Alexandre Bailon <abailon@baylibre.com>
To: rafael@kernel.org,
	daniel.lezcano@linaro.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org
Cc: rui.zhang@intel.com,
	lukasz.luba@arm.com,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alexandre Bailon <abailon@baylibre.com>
Subject: [PATCH v3 3/6] thermal: Add support of multi sensors to thermal_of
Date: Fri, 24 May 2024 16:31:47 +0200
Message-ID: <20240524143150.610949-4-abailon@baylibre.com>
X-Mailer: git-send-email 2.44.1
In-Reply-To: <20240524143150.610949-1-abailon@baylibre.com>
References: <20240524143150.610949-1-abailon@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This updates thermal_of to support more than one sensor.
If during the registration we find another thermal zone referencing
this sensors and some other, then we create the multi sensor thermal
zone (if it doesn't exist) and register the sensor to it.

Signed-off-by: Alexandre Bailon <abailon@baylibre.com>
---
 drivers/thermal/thermal_of.c | 250 +++++++++++++++++++++++++++++++++--
 1 file changed, 241 insertions(+), 9 deletions(-)

diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
index aa34b6e82e26..75e3cfb8488a 100644
--- a/drivers/thermal/thermal_of.c
+++ b/drivers/thermal/thermal_of.c
@@ -18,6 +18,8 @@
 
 #include "thermal_core.h"
 
+#define STRLEN_ID (8)
+
 /***   functions parsing device tree nodes   ***/
 
 static int of_find_trip_id(struct device_node *np, struct device_node *trip)
@@ -222,6 +224,77 @@ static struct device_node *of_thermal_zone_find(struct device_node *sensor, int
 	return tz;
 }
 
+static int thermal_of_multi_sensor_get_name(struct device_node *sensor, int id,
+					    struct device_node *tz, char *name)
+{
+	struct of_phandle_args sensor_specs;
+	int count, i;
+
+	tz = of_thermal_zone_find(sensor, id);
+	if (!tz) {
+		pr_debug("No thermal zones description\n");
+		return -ENODEV;
+	}
+
+	count = of_count_phandle_with_args(tz, "thermal-sensors",
+						"#thermal-sensor-cells");
+	if (count <= 0)
+		return count;
+
+	for (i = 0; i < count; i++) {
+
+		int ret;
+
+		ret = of_parse_phandle_with_args(tz, "thermal-sensors",
+							"#thermal-sensor-cells",
+							i, &sensor_specs);
+		if (ret < 0) {
+			pr_err("%pOFn: Failed to read thermal-sensors cells: %d\n", tz, ret);
+			return ret;
+		}
+
+		if ((sensor == sensor_specs.np) && id == (sensor_specs.args_count ?
+								sensor_specs.args[0] : 0)) {
+			snprintf(name, THERMAL_NAME_LENGTH, "%s%d", tz->name, id);
+			return 0;
+		}
+	}
+
+	return -ENODEV;
+}
+
+static int thermal_of_multi_sensor_get_id(struct device_node *sensor,
+					 struct device_node *tz, int id)
+{
+	struct of_phandle_args sensor_specs;
+	int count, i;
+
+	count = of_count_phandle_with_args(tz, "thermal-sensors",
+						"#thermal-sensor-cells");
+	if (count <= 0)
+		return 0;
+
+	for (i = 0; i < count; i++) {
+
+		int ret;
+
+		ret = of_parse_phandle_with_args(tz, "thermal-sensors",
+							"#thermal-sensor-cells",
+							i, &sensor_specs);
+		if (ret < 0) {
+			pr_err("%pOFn: Failed to read thermal-sensors cells: %d\n", tz, ret);
+			return 0;
+		}
+
+		if ((sensor == sensor_specs.np) && id == (sensor_specs.args_count ?
+								sensor_specs.args[0] : 0)) {
+			return i;
+		}
+	}
+
+	return -ENODEV;
+}
+
 static int thermal_of_monitor_init(struct device_node *np, int *delay, int *pdelay)
 {
 	int ret;
@@ -281,6 +354,17 @@ static struct device_node *thermal_of_zone_get_by_name(struct thermal_zone_devic
 		return ERR_PTR(-ENODEV);
 
 	tz_np = of_get_child_by_name(np, tz->type);
+	if (!tz_np) {
+		char tmp[THERMAL_NAME_LENGTH];
+		char *ptr;
+
+		ptr = strrchr(tz->type, '.');
+		if (!ptr)
+			return ERR_PTR(-ENODEV);
+
+		strscpy(tmp, tz->type, (ptr - tz->type) + 1);
+		tz_np = of_get_child_by_name(np, tmp);
+	}
 
 	of_node_put(np);
 
@@ -444,10 +528,140 @@ static int thermal_of_unbind(struct thermal_zone_device *tz,
  */
 static void thermal_of_zone_unregister(struct thermal_zone_device *tz)
 {
+	thermal_multi_sensor_unregister(tz);
 	thermal_zone_device_disable(tz);
 	thermal_zone_device_unregister(tz);
 }
 
+static int thermal_of_multi_sensor_validate_coeff(struct device_node *sensor, int id,
+						  struct device_node *tz_np)
+{
+	u32 *coeff;
+	int ret;
+	int i;
+
+	int count;
+	int index;
+	int offset;
+
+	index = thermal_of_multi_sensor_get_id(sensor, tz_np, id);
+	if (index < 0)
+		return -ENODEV;
+
+
+	count = of_count_phandle_with_args(tz_np,
+					   "thermal-sensors",
+					   "#thermal-sensor-cells");
+	if (count < 0)
+		return count;
+
+	coeff = kmalloc_array(count, sizeof(*coeff), GFP_KERNEL);
+	if (!coeff)
+		return -ENOMEM;
+
+	for (i = 0; i < count; i++) {
+		ret = of_property_read_u32_index(tz_np,
+						 "coefficients",
+						 i, coeff + i);
+		if (ret)
+			coeff[i] = 1;
+	}
+
+	ret = of_property_read_u32_index(tz_np, "coefficients",
+					 count, &offset);
+	if (ret)
+		offset = 0;
+
+	/* Make sure the coeff and offset won't cause an overflow */
+	ret = thermal_multi_sensor_validate_coeff(coeff, count, offset);
+
+	kfree(coeff);
+
+	return ret;
+}
+
+static int thermal_of_mutli_sensor_coeff(struct device_node *sensor, int id,
+					 struct device_node *tz_np,
+					 u32 *coeff)
+{
+	int index;
+	int ret;
+
+	index = thermal_of_multi_sensor_get_id(sensor, tz_np, id);
+	if (index < 0)
+		return index;
+
+	ret = of_property_read_u32_index(tz_np, "coefficients", index, coeff);
+	if (ret)
+		*coeff = 1;
+
+	return 0;
+}
+
+static struct thermal_zone_device *
+thermal_of_register_multi_tz(struct device_node *sensor, int id, struct device_node *np,
+			     const char *type, struct thermal_trip *trips, int num_trips,
+			     void *devdata, struct thermal_zone_device_ops *ops,
+			     const struct thermal_zone_params *tzp, int passive_delay,
+			     int polling_delay)
+{
+	struct thermal_zone_device *multi_tz, *tz;
+	char name[THERMAL_NAME_LENGTH];
+	u32 coeff;
+	int ret;
+
+	multi_tz = thermal_multi_sensor_find_tz(type);
+	if (!multi_tz) {
+		struct thermal_zone_device_ops *multi_ops;
+
+		ret = thermal_of_multi_sensor_validate_coeff(sensor, id, np);
+		if (ret)
+			return ERR_PTR(ret);
+
+		multi_ops = thermal_multi_sensor_alloc_ops(THERMAL_AGGR_AVG);
+		if (IS_ERR_OR_NULL(multi_ops))
+			return ERR_PTR(PTR_ERR(multi_ops));
+		multi_ops->bind = thermal_of_bind;
+		multi_ops->unbind = thermal_of_unbind;
+
+		multi_tz = thermal_multi_sensor_tz_alloc(type, trips, num_trips,
+							 multi_ops,
+							 passive_delay, polling_delay);
+		if (IS_ERR_OR_NULL(multi_tz)) {
+			kfree(multi_ops);
+			return multi_tz;
+		}
+	}
+
+	ret = thermal_of_multi_sensor_get_name(sensor, id, np, name);
+	if (ret)
+		goto out_release_multi_tz;
+
+	tz = thermal_tripless_zone_device_register(name, devdata, ops, tzp);
+	if (IS_ERR_OR_NULL(tz)) {
+		ret = PTR_ERR(tz);
+		goto out_release_multi_tz;
+	}
+
+	ret = thermal_of_mutli_sensor_coeff(sensor, id, np, &coeff);
+	if (ret)
+		goto out_release_tz;
+
+	ret = thermal_multi_sensor_register(multi_tz, tz, coeff);
+	if (ret)
+		goto out_release_tz;
+
+	return tz;
+
+out_release_tz:
+	thermal_zone_device_unregister(tz);
+out_release_multi_tz:
+	thermal_multi_sensor_tz_free(multi_tz);
+
+	return ERR_PTR(ret);
+}
+
+
 /**
  * thermal_of_zone_register - Register a thermal zone with device node
  * sensor
@@ -479,6 +693,7 @@ static struct thermal_zone_device *thermal_of_zone_register(struct device_node *
 	const char *action;
 	int delay, pdelay;
 	int ntrips;
+	int count;
 	int ret;
 
 	np = of_thermal_zone_find(sensor, id);
@@ -488,10 +703,19 @@ static struct thermal_zone_device *thermal_of_zone_register(struct device_node *
 		return ERR_CAST(np);
 	}
 
-	trips = thermal_of_trips_init(np, &ntrips);
-	if (IS_ERR(trips)) {
-		pr_err("Failed to find trip points for %pOFn id=%d\n", sensor, id);
-		return ERR_CAST(trips);
+	count = of_count_phandle_with_args(np, "thermal-sensors",
+						"#thermal-sensor-cells");
+	if (count <= 0)
+		return ERR_PTR(count);
+
+	/* Only allocate trips if the thermal zone doesn't exist yet */
+	if (!thermal_multi_sensor_find_tz(np->name)) {
+		trips = thermal_of_trips_init(np, &ntrips);
+		if (IS_ERR(trips)) {
+			pr_err("Failed to find trip points for %pOFn id=%d\n", sensor, id);
+			ret = PTR_ERR(trips);
+			goto out_kfree_trips;
+		}
 	}
 
 	ret = thermal_of_monitor_init(np, &delay, &pdelay);
@@ -502,17 +726,25 @@ static struct thermal_zone_device *thermal_of_zone_register(struct device_node *
 
 	thermal_of_parameters_init(np, &tzp);
 
-	of_ops.bind = thermal_of_bind;
-	of_ops.unbind = thermal_of_unbind;
+	if (count == 1) {
+		of_ops.bind = thermal_of_bind;
+		of_ops.unbind = thermal_of_unbind;
+	}
 
 	ret = of_property_read_string(np, "critical-action", &action);
 	if (!ret)
 		if (!of_ops.critical && !strcasecmp(action, "reboot"))
 			of_ops.critical = thermal_zone_device_critical_reboot;
 
-	tz = thermal_zone_device_register_with_trips(np->name, trips, ntrips,
-						     data, &of_ops, &tzp,
-						     pdelay, delay);
+	if (count == 1) {
+		tz = thermal_zone_device_register_with_trips(np->name, trips, ntrips,
+							     data, &of_ops, &tzp,
+							     pdelay, delay);
+	} else {
+		tz = thermal_of_register_multi_tz(sensor, id, np, np->name, trips,
+						  ntrips, data, &of_ops, &tzp,
+						  pdelay, delay);
+	}
 	if (IS_ERR(tz)) {
 		ret = PTR_ERR(tz);
 		pr_err("Failed to register thermal zone %pOFn: %d\n", np, ret);
-- 
2.44.1


