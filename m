Return-Path: <linux-kernel+bounces-367322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 387DE9A00E8
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 07:46:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8227BB23519
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 05:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A87911885A0;
	Wed, 16 Oct 2024 05:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OWfp7QNn"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3760E14D2B1
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 05:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729057555; cv=none; b=ujgJeciLATCDRrEzTszNBiiyoAnbd3tfCvqKyn4i+GHn+vvrfa+ozaggr+iqY6w0RUf3suW2nVwWR3NHfDYMKqRVK/w3VKzIQe5XSrmIPZ0V0zygO2SCIKhrl4iQQzyXeFz3jQnuYflnTvgR3eMCWr4+6VA+g11R7xv059BOQio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729057555; c=relaxed/simple;
	bh=1qivdgPzhiPmx8coSkwgmE5FSvW0jIi1boUu/nZ5AZ8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=avGFQh2+wJmrtYruY4z9J8nv7TyXsZgJWWkwyb4I3EEpXAYT5bxhOAA0A2JCZW9kNrPMowXu+sIl6ZoNZM+dTHPPkvUeyw4ujWzGbhKL5lCaGMpDmQHXFPIg179Hhtle6xIj82eWw698hYt9BzF5/9KcRyX/epXCz8VxrjM8YEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=OWfp7QNn; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-20cb89a4e4cso29039415ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 22:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1729057552; x=1729662352; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cwJJmP/ZXKEl//vPqzZxNk4JrFy3Wy0nARrCJ7oJJlA=;
        b=OWfp7QNnzo3CaFVj8Ff7yHNQUSAK0dRPq6qYl2PShOnkGYi1key/rht+la2RVezY6e
         U81ppxGESWUyGiZG/2YdGgYzYdD1LbL+sGgoVKCZXrN7xvK9mDNZMPbeBqS89k6noYxG
         ZXK7tDYaTXjCXss3PPOMOsz5hEJ1EVPBF+hWM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729057552; x=1729662352;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cwJJmP/ZXKEl//vPqzZxNk4JrFy3Wy0nARrCJ7oJJlA=;
        b=VpLpeYYadrsleCEEC+A28CwvjK0O9lDOvOwmpc/cRBQdGZZvN3c4Layc+HI09zZrmh
         qJ3NBFy4vQG+KescQPwXscS4I6aFcEN4SPLO9l+5BbWcLVVvBQOLTOkW91HvUdvoEaSf
         jP34G3ALMiBbUgMuCLW+5yDGVwCdWgrtQytEYsOUC3n0J5MWUGeOL6LSOnOI55hMpyRG
         Qfqt5hiZyPpc5LVceRHQQ2OkopAO3Y2zuxbgV3hdgW9aOXoTrMvg4346/7fsakCJDdFT
         5BalG6AjisBgK0dXNukldjvgstj6nfO3vsB7EQmFPrWgrUZcbLA3RswD2VU9Hklnoi+K
         +pbQ==
X-Forwarded-Encrypted: i=1; AJvYcCVSnjcQGMeCkwnqdeM0gKFUm3dep809v1cvPUBigWepymLKVWdXZSvNpWfujRvuOarEUkBP6M0U8owY6bc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/9JETNmV+98IOVbN2RBtDIL4QlchYMWqA/iDnZOK5Em6Fu4XW
	bTol4vMvmaIPIJoI8wLZXhz0Cjb5OTyJqm0oLjtEWVBFKrBLk1iQ/ql3HvMuAA==
X-Google-Smtp-Source: AGHT+IH3whYd/baJm6rc+ZppTWb+JBSQWjk0NVYypdzoLrAlYYZJ3ieGQmoMLJmDKyJB4k56J9jq5g==
X-Received: by 2002:a17:903:1211:b0:20c:f648:e3a7 with SMTP id d9443c01a7336-20d27f20cf6mr33038135ad.50.1729057552365;
        Tue, 15 Oct 2024 22:45:52 -0700 (PDT)
Received: from yuanhsinte.c.googlers.com (176.220.194.35.bc.googleusercontent.com. [35.194.220.176])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20d1805ba92sm21449385ad.255.2024.10.15.22.45.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 22:45:51 -0700 (PDT)
From: Hsin-Te Yuan <yuanhsinte@chromium.org>
Date: Wed, 16 Oct 2024 05:45:46 +0000
Subject: [PATCH RESEND v12] thermal/drivers/mediatek: add another get_temp
 ops for thermal sensors
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241016-auxadc_thermal-v12-1-c0433e9f61af@chromium.org>
X-B4-Tracking: v=1; b=H4sIAAlTD2cC/3XNvQ6CMBQF4Fchna3pXxCcHGR10NEYUy4tbSLUt
 EAwhHe36eCgcbzn5Hx3QUF5qwLaZwvyarLBuj4elG0yBEb2rcK2iQFihAlSkBLLcZYN3AejfCc
 fuKwV54WCoqaA4ujplbZzEq/oXF2q0xHdYm5sGJx/pUcTpan+Z8YeUyw1zwF2QnPJD2C86+zYb
 Z1vkzdR9jEoIfTXYNFgdZEDKYXWIv8y1nV9A8Tjfan+AAAA
X-Change-ID: 20240809-auxadc_thermal-9be338ec8b1c
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 James Lo <james.lo@mediatek.com>, Michael Kao <michael.kao@mediatek.com>, 
 Hsin-Yi Wang <hsinyi@chromium.org>, Ben Tseng <ben.tseng@mediatek.com>, 
 Hsin-Te Yuan <yuanhsinte@chromium.org>
X-Mailer: b4 0.15-dev-7be4f

From: James Lo <james.lo@mediatek.com>

Previously, the driver only supported reading the temperature from all
sensors and returning the maximum value. This updatea adds another
get_temp ops to support reading the temperature from each sensor
separately.

This feature provides the ability to read all thermal sensor values in
the SoC through the node /sys/class/thermal.

Signed-off-by: Michael Kao <michael.kao@mediatek.com>
Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
Signed-off-by: Ben Tseng <ben.tseng@mediatek.com>
Signed-off-by: James Lo <james.lo@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Hsin-Te Yuan <yuanhsinte@chromium.org>
---
Changes in v12:
- Remove unnecessary check and unused variable assignment in mtk_read_sensor_temp.
- Add more about what this patch achieves in the commit message.
- Link to v11: https://lore.kernel.org/r/20240809-auxadc_thermal-v11-1-af36cc74f3a3@chromium.org

Changes in V11:
    - Rebase on kernel v6.11-rc2
    - Use mtk_thermal_temp_is_valid in mtk_read_sensor_temp just like
      mtk_thermal_bank_temperature
    - Change the error handling of devm_thermal_of_zone_register return
      value
    - link to V10: https://lore.kernel.org/lkml/20220519101044.16765-1-james.lo@mediatek.com/

Changes in V10:
    - Rebase to kernel-v5.18-rc7
    - Resend

Changes in V9:
    - Rebase to kernel-v5.14-rc1
    - Bind raw_to_mcelsius_v1 or raw_to_mcelsius_v2 to compatible
      data of struct mtk_thermal_data
    - Remove duplicate struct 'mtk_thermal_bank'
    - Remove unnecessary if condition check
    - Return error if any thermal zone fail to register

Changes in V8:
    - Rebase to kernel-v5.13-rc1
    - Resend

Changes in v7:
    - Fix build error in v6.

Changes in v6:
    - Rebase to kernel-5.11-rc1.
    - [1/3]
        - add interrupts property.
    - [2/3]
        - add the Tested-by in the commit message.
    - [3/3]
        - use the mt->conf->msr[id] instead of conf->msr[id] in the
          _get_sensor_temp and mtk_thermal_bank_temperature.
        - remove the redundant space in _get_sensor_temp and
          mtk_read_sensor_temp.
        - change kmalloc to dev_kmalloc in mtk_thermal_probe.

Changes in v5:
    - Rebase to kernel-5.9-rc1.
    - Revise the title of cover letter.
    - Drop "[v4,7/7] thermal: mediatek: use spinlock to protect PTPCORESEL"
    - [2/2]
        -  Add the judgement to the version of raw_to_mcelsius.

Changes in v4:
    - Rebase to kernel-5.6-rc1.
    - [1/7]
        - Squash thermal zone settings in the dtsi from [v3,5/8]
          arm64: dts: mt8183: Increase polling frequency for CPU thermal zone.
        - Remove the property of interrupts and mediatek,hw-reset-temp.
    - [2/7]
        - Correct commit message.
    - [4/7]
        - Change the target temperature to the 80C and change the commit message.
    - [6/7]
        - Adjust newline alignment.
        - Fix the judgement on the return value of registering thermal zone.

Changes in v3:
    - Rebase to kernel-5.5-rc1.
    - [1/8]
        - Update sustainable power of cpu, tzts1~5 and tztsABB.
    - [7/8]
        - Bypass the failure that non cpu_thermal sensor is not find in thermal-zones
          in dts, which is normal for mt8173, so prompt a warning here instead of
          failing.

    Return -EAGAIN instead of -EACCESS on the first read of sensor that
        often are bogus values. This can avoid following warning on boot:

          thermal thermal_zone6: failed to read out thermal zone (-13)

Changes in v2:
    - [1/8]
        - Add the sustainable-power,trips,cooling-maps to the tzts1~tztsABB.
    - [4/8]
        - Add the min opp of cpu throttle.
---

---
 drivers/thermal/mediatek/auxadc_thermal.c | 70 +++++++++++++++++++++++++++----
 1 file changed, 62 insertions(+), 8 deletions(-)

diff --git a/drivers/thermal/mediatek/auxadc_thermal.c b/drivers/thermal/mediatek/auxadc_thermal.c
index 9ee2e7283435acfcbb1a956303b6122a08affecc..10938be2e5545fba2fff7d5cc5a0269d42e5d44d 100644
--- a/drivers/thermal/mediatek/auxadc_thermal.c
+++ b/drivers/thermal/mediatek/auxadc_thermal.c
@@ -847,7 +847,8 @@ static int mtk_thermal_bank_temperature(struct mtk_thermal_bank *bank)
 
 static int mtk_read_temp(struct thermal_zone_device *tz, int *temperature)
 {
-	struct mtk_thermal *mt = thermal_zone_device_priv(tz);
+	struct mtk_thermal_bank *bank = thermal_zone_device_priv(tz);
+	struct mtk_thermal *mt = bank->mt;
 	int i;
 	int tempmax = INT_MIN;
 
@@ -866,10 +867,41 @@ static int mtk_read_temp(struct thermal_zone_device *tz, int *temperature)
 	return 0;
 }
 
+static int mtk_read_sensor_temp(struct thermal_zone_device *tz, int *temperature)
+{
+	struct mtk_thermal_bank *bank = thermal_zone_device_priv(tz);
+	struct mtk_thermal *mt = bank->mt;
+	const struct mtk_thermal_data *conf = mt->conf;
+	int id = bank->id - 1;
+	int temp = INT_MIN;
+	u32 raw;
+
+	raw = readl(mt->thermal_base + conf->msr[id]);
+
+	temp = mt->raw_to_mcelsius(mt, id, raw);
+
+	/*
+	 * The first read of a sensor often contains very high bogus
+	 * temperature value. Filter these out so that the system does
+	 * not immediately shut down.
+	 */
+
+	if (unlikely(!mtk_thermal_temp_is_valid(temp)))
+		return -EAGAIN;
+
+	*temperature = temp;
+
+	return 0;
+}
+
 static const struct thermal_zone_device_ops mtk_thermal_ops = {
 	.get_temp = mtk_read_temp,
 };
 
+static const struct thermal_zone_device_ops mtk_thermal_sensor_ops = {
+	.get_temp = mtk_read_sensor_temp,
+};
+
 static void mtk_thermal_init_bank(struct mtk_thermal *mt, int num,
 				  u32 apmixed_phys_base, u32 auxadc_phys_base,
 				  int ctrl_id)
@@ -1199,6 +1231,7 @@ static int mtk_thermal_probe(struct platform_device *pdev)
 	u64 auxadc_phys_base, apmixed_phys_base;
 	struct thermal_zone_device *tzdev;
 	void __iomem *apmixed_base, *auxadc_base;
+	struct mtk_thermal_bank *tz;
 
 	mt = devm_kzalloc(&pdev->dev, sizeof(*mt), GFP_KERNEL);
 	if (!mt)
@@ -1285,14 +1318,35 @@ static int mtk_thermal_probe(struct platform_device *pdev)
 			mtk_thermal_init_bank(mt, i, apmixed_phys_base,
 					      auxadc_phys_base, ctrl_id);
 
-	tzdev = devm_thermal_of_zone_register(&pdev->dev, 0, mt,
-					      &mtk_thermal_ops);
-	if (IS_ERR(tzdev))
-		return PTR_ERR(tzdev);
+	for (i = 0; i <= mt->conf->num_sensors; i++) {
+		tz = devm_kmalloc(&pdev->dev, sizeof(*tz), GFP_KERNEL);
+		if (!tz)
+			return -ENOMEM;
+
+		tz->mt = mt;
+		tz->id = i;
+
+		tzdev = devm_thermal_of_zone_register(&pdev->dev, i,
+						      tz, (i == 0) ?
+						      &mtk_thermal_ops
+						      : &mtk_thermal_sensor_ops);
+
+		if (IS_ERR(tzdev)) {
+			ret = PTR_ERR(tzdev);
+			if (ret == -ENODEV) {
+				dev_warn(&pdev->dev, "can't find thermal sensor %d\n", i);
+				continue;
+			}
+			dev_err(&pdev->dev,
+				"Error: Failed to register thermal zone %d, ret = %d\n",
+				i, ret);
+			return ret;
+		}
 
-	ret = devm_thermal_add_hwmon_sysfs(&pdev->dev, tzdev);
-	if (ret)
-		dev_warn(&pdev->dev, "error in thermal_add_hwmon_sysfs");
+		ret = devm_thermal_add_hwmon_sysfs(&pdev->dev, tzdev);
+		if (ret)
+			dev_warn(&pdev->dev, "error in thermal_add_hwmon_sysfs: %d\n", ret);
+	}
 
 	return 0;
 }

---
base-commit: b589839414be04b2b37e4bf6f84af576c99faf64
change-id: 20240809-auxadc_thermal-9be338ec8b1c

Best regards,
-- 
Hsin-Te Yuan <yuanhsinte@chromium.org>


