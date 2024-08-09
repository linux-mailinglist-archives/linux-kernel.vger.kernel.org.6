Return-Path: <linux-kernel+bounces-280591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CEBE994CC83
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 10:44:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86D2128719A
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 08:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F55D18F2D9;
	Fri,  9 Aug 2024 08:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="obZxb7BX"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0345C18C329
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 08:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723193054; cv=none; b=TtFlbJHJJXJH5XV2PR64AGL0bAzXDSYusQ73V2nxq8EtgIKrsuZjRCEkZMdD1OYmbWh1FDNgfWTzkcK4p1YsAGpBPq/kLrNfvY/Z+4e3D53ftZCBMFg/XqjBTXhokT7V7Nerbr3f4d3adEOE2HFb5rSXxEL940kSvRhvX9eLPuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723193054; c=relaxed/simple;
	bh=002Iw5hvkpAt3ItQd2VKemW6iaeFt1cHml0VZKYLTP4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=nseuJ2h9TOPkxtQf/fnvoQ9SwNtBqerBD+E5KcdTDebsj31Ehu/H40ib/bse05VpHgaxgEWE4cKy6DgrCoM+UOpNacmQJ8weszVjjH2OA2Tnc6SG0HDjM8pBlHbAbhjgUNs95NDzkETKMBjwrMvTQd5oiPcXtV39v8TbHAl8yZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=obZxb7BX; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1fd9e6189d5so17173775ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2024 01:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1723193051; x=1723797851; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=y0dpw8AgsTIrUWx34LKeqU4wVt9f4efe1RzhjQJq/dc=;
        b=obZxb7BX5g1pjn59N4UhIIp75tWHEpLuMVQ+oZT17/TCtgFSjf4iCaZHKLA730Uxlq
         pixcREyc+7UkzCL5xqdzpdCWsxWYfVQ9ObuQGnVcL+16fbjd5uKlILZaBb6QcKkOyzCz
         qpOyaLP4o7jb7cJmN/4xdURovX/77T5L2IsVw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723193051; x=1723797851;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y0dpw8AgsTIrUWx34LKeqU4wVt9f4efe1RzhjQJq/dc=;
        b=DJNmPkoBdCh2/D8ush7SaWMBoRlGMzvIBCianm6r3GMUfr5r/9nzd9Qsfn10pOi5mc
         oLlUV1vaLqwABm4lZhGHNADsyE0lT3yd9OHTmA/bEFB+07tvF5lGMPne6+awCgtbEuwN
         LvD/8SIh365dICcnoMDfa7SlXQP6wDGiMAOu9c5suHJMt6NnODZeqRkiESIg1nqyBNbR
         FsNVoHtBGh9jhXSB59GhLHWdfjVowuCywtDiKzf1aos8JPMsHwE0bXYUVhg/ifC9qy0X
         z67ff06eLmPiL8kW22NQ+vwnN+jbkm7fzEFsBmAqMFj/jShr5rHJKKKPTMJcGhv0T85e
         sMPA==
X-Forwarded-Encrypted: i=1; AJvYcCVUm7e77Kmnuy0XvUY0MXV8GtTaN8GBTMNY1reG9jU+vdIgIFNoixEhXUCDpJsQl7VHdYaCL4yeNXlATCwb9M+TtExGpFBaypKOksXO
X-Gm-Message-State: AOJu0YwPZhZZ26P9CcZf/+3A4Zrmb3LZyUMnC5T2Twl8xIFVFOAEyKQF
	ZoiynyLZUDmxdX82DiuQgTnQhuy/0826erEr0Nhjh19IdR4bO2BuFTLvWQksOA==
X-Google-Smtp-Source: AGHT+IGGsGMiUcvqjnFicMWVFbGdRWqa1sapo0jRgPkfp/Vxg1YwskwbsK0XDEVYAwmw4zGopgZQMg==
X-Received: by 2002:a17:903:32d0:b0:1ff:4535:9b57 with SMTP id d9443c01a7336-200ae60f46bmr7553385ad.51.1723193051051;
        Fri, 09 Aug 2024 01:44:11 -0700 (PDT)
Received: from yuanhsinte.c.googlers.com (46.165.189.35.bc.googleusercontent.com. [35.189.165.46])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff58f21794sm137237355ad.27.2024.08.09.01.44.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 01:44:10 -0700 (PDT)
From: Hsin-Te Yuan <yuanhsinte@chromium.org>
Date: Fri, 09 Aug 2024 08:44:04 +0000
Subject: [PATCH v11] thermal/drivers/mediatek: add another get_temp ops for
 thermal sensors
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240809-auxadc_thermal-v11-1-af36cc74f3a3@chromium.org>
X-B4-Tracking: v=1; b=H4sIANTWtWYC/x2MQQqAIBAAvyJ7TtDsYH0lItS2WigLrRCkvycdZ
 2AmQ8RAGKFjGQI+FOnwBaSsGLjV+AU5TUVALepGaNFycyczufFaMexm461FpTQ6baWDEp0BZ0r
 /sR/e9wOzRNHeYQAAAA==
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
X-Mailer: b4 0.15-dev-37811

From: James Lo <james.lo@mediatek.com>

Provide thermal zone to read thermal sensor
in the SoC. We can read all the thermal sensors
value in the SoC by the node /sys/class/thermal/

Signed-off-by: Michael Kao <michael.kao@mediatek.com>
Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
Signed-off-by: Ben Tseng <ben.tseng@mediatek.com>
Signed-off-by: James Lo <james.lo@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Hsin-Te Yuan <yuanhsinte@chromium.org>
---
Resurrecting this patch specifically for MediaTek MT8183 Kukui devices.

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
 drivers/thermal/mediatek/auxadc_thermal.c | 71 +++++++++++++++++++++++++++----
 1 file changed, 63 insertions(+), 8 deletions(-)

diff --git a/drivers/thermal/mediatek/auxadc_thermal.c b/drivers/thermal/mediatek/auxadc_thermal.c
index 9ee2e7283435..8b50d560bbf9 100644
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
 
@@ -866,10 +867,46 @@ static int mtk_read_temp(struct thermal_zone_device *tz, int *temperature)
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
+	if (id < 0)
+		return  -EACCES;
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
+	if (!mtk_thermal_temp_is_valid(temp)) {
+		temp = THERMAL_TEMP_INVALID;
+		return -EAGAIN;
+	}
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
@@ -1199,6 +1236,7 @@ static int mtk_thermal_probe(struct platform_device *pdev)
 	u64 auxadc_phys_base, apmixed_phys_base;
 	struct thermal_zone_device *tzdev;
 	void __iomem *apmixed_base, *auxadc_base;
+	struct mtk_thermal_bank *tz;
 
 	mt = devm_kzalloc(&pdev->dev, sizeof(*mt), GFP_KERNEL);
 	if (!mt)
@@ -1285,14 +1323,31 @@ static int mtk_thermal_probe(struct platform_device *pdev)
 			mtk_thermal_init_bank(mt, i, apmixed_phys_base,
 					      auxadc_phys_base, ctrl_id);
 
-	tzdev = devm_thermal_of_zone_register(&pdev->dev, 0, mt,
-					      &mtk_thermal_ops);
-	if (IS_ERR(tzdev))
-		return PTR_ERR(tzdev);
+	for (i = 0; i < mt->conf->num_sensors + 1; i++) {
+		tz = devm_kmalloc(&pdev->dev, sizeof(*tz), GFP_KERNEL);
+		if (!tz)
+			return -ENOMEM;
+
+		tz->mt = mt;
+		tz->id = i;
+
+		tzdev = devm_thermal_of_zone_register(&pdev->dev, i,
+				tz, (i == 0) ?
+				&mtk_thermal_ops : &mtk_thermal_sensor_ops);
+
+		if (IS_ERR(tzdev)) {
+			if (PTR_ERR(tzdev) == -ENODEV) {
+				dev_warn(&pdev->dev, "can't find thermal sensor %d\n", i);
+				continue;
+			}
+			if (PTR_ERR(tzdev) != -EACCES)
+				return PTR_ERR(tzdev);
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
base-commit: ee9a43b7cfe2d8a3520335fea7d8ce71b8cabd9d
change-id: 20240809-auxadc_thermal-9be338ec8b1c

Best regards,
-- 
Hsin-Te Yuan <yuanhsinte@chromium.org>


