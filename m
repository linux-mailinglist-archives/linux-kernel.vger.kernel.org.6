Return-Path: <linux-kernel+bounces-213312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 043AD9073A3
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 15:26:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D0E4B2331F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 13:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BC3714658A;
	Thu, 13 Jun 2024 13:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="v7CYwVN3"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26054145B1D
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 13:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718285063; cv=none; b=O/yIfBbTbyO2NVURzxJDg4DNuagwFTaJ0Wwf130Lpap4xmIEfTQ/xHCfnsTA3Y8+lje50pnawDz0JBBO8Hbs8iqTjVAKO/Y8SHjTvmehTz4iZ0/eRbcbH2+bAXP0/YUibqSWrmHosp2MHXx6N5L/oFb8FLVajjgzdwWxgkScMxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718285063; c=relaxed/simple;
	bh=LpbziCjZRkzrPCbzYtUAQhYRDTw/5cNCLTZgMC5mxrE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bG2B01+jfFWhsIa2V8R+eSHQqvgSwWa14rlpuKUkYacqdXICnA2lr0L11KieDAH5wfpoIqJ79hFhgwbcHCBUe1uc5H1CyegQOCPHgld57VyPZ+qlttzDvHK4t4oRqPCZ0tn9UB40ykCG220+7V+B+8jhoP4/JVkUsggRKAbDTEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=v7CYwVN3; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-421bb51d81aso8369535e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 06:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1718285059; x=1718889859; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tya0ITp4z4S3hnZL7iK4UAV9x+Mi7A2TRjTzUlOjL/8=;
        b=v7CYwVN3TCuTZjXV5IVE04Lu+ji9UjYw3OCp9bxeN2OhWTGDa2imrnOQ5gqlLUmXIX
         6CCAXqtuL3Zz7NeomSI4TCXFCgS9ua/6OjkLeJWwEen9/+y1KBikWVEadFxjtV/alJlT
         Yixy8aOxxjJZoWzKF7D60kQt2zyZ+jYCi3/sv2ck/m3ROfzqQvZyLw9aZA3eSzDSflDJ
         8CO9ZGU5LbSjncOAhZzQbr9sF4zERoV7HBPYaohRFpYpNdDNJaYD5nZou1vSbOqg+yq/
         uGpUyNYkCJ3oJ01Ej+RKGv1ZlE7gmtyxXAkpEFUJbn4rsISKy78Fqi9+4UawEwlD+hLt
         ErBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718285059; x=1718889859;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tya0ITp4z4S3hnZL7iK4UAV9x+Mi7A2TRjTzUlOjL/8=;
        b=Sdu0N3wEhXTLHPvL7pVhTy49pI9ZPClFaFwTnGgb+q5WYcnYKKWqEPEiwQyVgrY1v3
         Hk0g+54ZxqYZp329D98BmreqjehHJsDvdqeJRbwJ8TMG/8ua9RP5ufMaXQQ3CrNIspH0
         ZsD66Owzn4h60Ap6caYVboa2BJsJyPSnfdSjTvZIT5nknagk1PjtfSrg9naEp3Wc2I9Q
         a6ZJ9MmfvGJ+WiHchDDKfmpIGlyudYNOMHkZ7HOMVSPPthzxuBDpEfg76tdr1Y9Xn2PW
         yBZArQWESpsc0JT5b5kIpUtu/47hODzS9b8HRzVvd0HJli8EpTuUu60ZMwsoYHsq+eVb
         pzAw==
X-Forwarded-Encrypted: i=1; AJvYcCXLt9zGMJYUHzxsfdH4Lzx1/2/E+Xc5LZe2Jy4A5J6/4KeFkDP+7QNzPGoE/XV8pjC5bua5R6ofUjkB4tKYvAW/edLwIbiAqYOx+Mpr
X-Gm-Message-State: AOJu0YyCwpo59mVJJU0wdg8ZV8/DnA5PPb2Sry/z4SPwHB4Br3NLFyiq
	TgNRbseM1hlhSCb08zJmj28Kmy6zIDsoVO3hs4XhBLtIZ6j53yHrrdgptRCZG/w=
X-Google-Smtp-Source: AGHT+IGbVJk/idr4DAbfqDBHeVeUSQXIMINdv853E/IV6oCCF2ifS2Cr4eRXr+Mrg1v3ct8+2iM7VQ==
X-Received: by 2002:a05:600c:1f1a:b0:421:7407:d778 with SMTP id 5b1f17b1804b1-422862a7251mr36347485e9.14.1718285059563;
        Thu, 13 Jun 2024 06:24:19 -0700 (PDT)
Received: from blaptop.baylibre (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-422f5f33c6esm25086225e9.4.2024.06.13.06.24.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 06:24:18 -0700 (PDT)
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
Subject: [PATCH v4 3/4] thermal: Add support of multi sensors to thermal_of
Date: Thu, 13 Jun 2024 15:24:09 +0200
Message-ID: <20240613132410.161663-4-abailon@baylibre.com>
X-Mailer: git-send-email 2.44.1
In-Reply-To: <20240613132410.161663-1-abailon@baylibre.com>
References: <20240613132410.161663-1-abailon@baylibre.com>
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
index aa34b6e82e26..fef966557b30 100644
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
+		multi_ops = thermal_multi_sensor_alloc_ops();
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


