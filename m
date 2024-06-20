Return-Path: <linux-kernel+bounces-222352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 914D7910036
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 11:23:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0964B1F21E31
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 09:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC7E619FA99;
	Thu, 20 Jun 2024 09:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JB6Rp7YD"
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D22119EEC8
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 09:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718875395; cv=none; b=t4+cZl18aR1LKM60Engz8pluAC5myEFKUSw+9VOPyMQHoIizuYSH81PGCVkKkH9nruy7Jw42TLRMun1LU7xBONBT7eKaA4W5vDLPhdqI1uH+V6XtsSPMjQcb7wkb51GSbp3/3rUFuwc5xoZ/z2saibgB4n6CDpcAmhHgA2YuGfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718875395; c=relaxed/simple;
	bh=NuPDUWIRZf/8Tye0d5C7wcsBP1Z7rW595BqKKgapVX4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Il/Orj2H8tpoE398SkTEky9H8WBlSrKYdT5A8McLBgbwQcK1MnkofIATM6IE9fLbxb/ROTPmOlcouZXroNe3b06LBX8D/tInFr6i6bnOL8Ts/MeOrC0UopMb2fQ/WYQndMskQj728sQsWGysHmrjkXGrppGcsWOOFTztLm+xAmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=JB6Rp7YD; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3c9b94951cfso348813b6e.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 02:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1718875392; x=1719480192; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MTOvxtIiI/1rSVsnyqK5ede7Xf3BGz8mkXjO1sfkrcE=;
        b=JB6Rp7YDo/PiGR7hEctW02ic+eFP/kj7KHmAKdCeD+GrwGF0RF2x8Cg1jIT5moE5vn
         9rNVenkQOP0ylf4wEh03Vj8jXpr+ltRlcNYZTnnC7sOsRPTaGjY2QHG1MEHHftC3WOGz
         1sV0bHO6mY0XUWlzcohwILGXE8PYjMO5yqsro=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718875392; x=1719480192;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MTOvxtIiI/1rSVsnyqK5ede7Xf3BGz8mkXjO1sfkrcE=;
        b=iFnWFIzrKgXeELnQDfPfoQD32RvPViW6uYz5JEpMNkoCUwtsjXgxhjqLvRPyhOHtMd
         e6f0Le1BQ5aQ/Q9ayUhlMACQyCVHRKVbGwVWHShLRp7cnYkgABMo9hkTvSbRGDydMsEa
         LWQigwN2ZTFy34XJV9JNY3sJEqn9ryLPUBfYnN1IP3gNGtgL9KdI/bbK0KYvl6BMavr+
         ae23IU0LURpiyx3f1j2nT4C+kPXvTHGi8Gw9cQf+JxTwV9uYTn6Hdx066MdlsOhkWKOL
         NF/LjOwCeGA5N4ln4SjrizltVg0e/yqMNODN52bYE+GILUyloNb51vq8UhvIKEhkmF+W
         qeIQ==
X-Forwarded-Encrypted: i=1; AJvYcCWf7XpNrj6rI3/dR/Wry44SAknr9e0cnkzKYfJ9T6Y2R10a+XQsDnCiaxU4Xti7CaAMLoxC70QeTwsMl6nU76lN2AsrP5Czk2SZaoxa
X-Gm-Message-State: AOJu0YxHNey9vqgDKMU8dvCqplsD44dCmC+0ha9HwNOKtA7Jf8Olt0Tl
	cBM+t7eSomYWPsqHvG1DCrCrsGZ9UV/Qn5y8JL3S7qg0iGRlLcvGSW79DsdhQw==
X-Google-Smtp-Source: AGHT+IHG1Qywf1NHXqmplHsfBSGZmQpZMD312c+7WzkDmSDb1JUiu8ehCBtziKheqH469mAnY8PkLQ==
X-Received: by 2002:a05:6871:586:b0:25c:be22:8ae2 with SMTP id 586e51a60fabf-25cbe2290eamr1168729fac.33.1718875392592;
        Thu, 20 Jun 2024 02:23:12 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:c53a:5326:7f72:759f])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-705cc96aee8sm11950339b3a.73.2024.06.20.02.23.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 02:23:12 -0700 (PDT)
From: Chen-Yu Tsai <wenst@chromium.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	Nicolas Pitre <npitre@baylibre.com>,
	Alexandre Mergnat <amergnat@baylibre.com>,
	=?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= <nfraprado@collabora.com>,
	Julien Panis <jpanis@baylibre.com>,
	Balsam CHIHI <bchihi@baylibre.com>,
	Frank Wunderlich <frank-w@public-files.de>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH] thermal/drivers/mediatek/lvts_thermal: Provide default calibration data
Date: Thu, 20 Jun 2024 17:23:03 +0800
Message-ID: <20240620092306.2352606-1-wenst@chromium.org>
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On some pre-production hardware, the SoCs do not contain calibration
data for the thermal sensors. The downstream drivers provide default
values that sort of work, instead of having the thermal sensors not
work at all.

Port the default values to the upstream driver. These values are from
the ChromeOS kernels, which sadly do not cover the MT7988.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 drivers/thermal/mediatek/lvts_thermal.c | 34 +++++++++++++++++++------
 1 file changed, 26 insertions(+), 8 deletions(-)

diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/mediatek/lvts_thermal.c
index 73148bd8da1f..1997e91bb3be 100644
--- a/drivers/thermal/mediatek/lvts_thermal.c
+++ b/drivers/thermal/mediatek/lvts_thermal.c
@@ -128,6 +128,7 @@ struct lvts_data {
 	int temp_factor;
 	int temp_offset;
 	int gt_calib_bit_offset;
+	unsigned int def_calibration;
 };
 
 struct lvts_sensor {
@@ -689,6 +690,10 @@ static int lvts_calibration_init(struct device *dev, struct lvts_ctrl *lvts_ctrl
 					size_t calib_len)
 {
 	int i;
+	u32 gt;
+
+	/* A zero value for gt means that device has invalid efuse data */
+	gt = (((u32 *)efuse_calibration)[0] >> lvts_ctrl->lvts_data->gt_calib_bit_offset) & 0xff;
 
 	lvts_for_each_valid_sensor(i, lvts_ctrl_data) {
 		const struct lvts_sensor_data *sensor =
@@ -699,10 +704,17 @@ static int lvts_calibration_init(struct device *dev, struct lvts_ctrl *lvts_ctrl
 		    sensor->cal_offsets[2] >= calib_len)
 			return -EINVAL;
 
-		lvts_ctrl->calibration[i] =
-			(efuse_calibration[sensor->cal_offsets[0]] << 0) +
-			(efuse_calibration[sensor->cal_offsets[1]] << 8) +
-			(efuse_calibration[sensor->cal_offsets[2]] << 16);
+		if (gt) {
+			lvts_ctrl->calibration[i] =
+				(efuse_calibration[sensor->cal_offsets[0]] << 0) +
+				(efuse_calibration[sensor->cal_offsets[1]] << 8) +
+				(efuse_calibration[sensor->cal_offsets[2]] << 16);
+		} else if (lvts_ctrl->lvts_data->def_calibration) {
+			lvts_ctrl->calibration[i] = lvts_ctrl->lvts_data->def_calibration;
+		} else {
+			dev_err(dev, "efuse contains invalid calibration data and no default given.\n");
+			return -ENODATA;
+		}
 	}
 
 	return 0;
@@ -770,14 +782,13 @@ static int lvts_golden_temp_init(struct device *dev, u8 *calib,
 	gt = (((u32 *)calib)[0] >> lvts_data->gt_calib_bit_offset) & 0xff;
 
 	/* A zero value for gt means that device has invalid efuse data */
-	if (!gt)
-		return -ENODATA;
-
-	if (gt < LVTS_GOLDEN_TEMP_MAX)
+	if (gt && gt < LVTS_GOLDEN_TEMP_MAX)
 		golden_temp = gt;
 
 	golden_temp_offset = golden_temp * 500 + lvts_data->temp_offset;
 
+	dev_info(dev, "%sgolden temp=%d\n", gt ? "" : "fake ", golden_temp);
+
 	return 0;
 }
 
@@ -1701,6 +1712,7 @@ static const struct lvts_data mt8186_lvts_data = {
 	.temp_factor	= LVTS_COEFF_A_MT7988,
 	.temp_offset	= LVTS_COEFF_B_MT7988,
 	.gt_calib_bit_offset = 24,
+	.def_calibration = 19000,
 };
 
 static const struct lvts_data mt8188_lvts_mcu_data = {
@@ -1709,6 +1721,7 @@ static const struct lvts_data mt8188_lvts_mcu_data = {
 	.temp_factor	= LVTS_COEFF_A_MT8195,
 	.temp_offset	= LVTS_COEFF_B_MT8195,
 	.gt_calib_bit_offset = 20,
+	.def_calibration = 35000,
 };
 
 static const struct lvts_data mt8188_lvts_ap_data = {
@@ -1717,6 +1730,7 @@ static const struct lvts_data mt8188_lvts_ap_data = {
 	.temp_factor	= LVTS_COEFF_A_MT8195,
 	.temp_offset	= LVTS_COEFF_B_MT8195,
 	.gt_calib_bit_offset = 20,
+	.def_calibration = 35000,
 };
 
 static const struct lvts_data mt8192_lvts_mcu_data = {
@@ -1725,6 +1739,7 @@ static const struct lvts_data mt8192_lvts_mcu_data = {
 	.temp_factor	= LVTS_COEFF_A_MT8195,
 	.temp_offset	= LVTS_COEFF_B_MT8195,
 	.gt_calib_bit_offset = 24,
+	.def_calibration = 35000,
 };
 
 static const struct lvts_data mt8192_lvts_ap_data = {
@@ -1733,6 +1748,7 @@ static const struct lvts_data mt8192_lvts_ap_data = {
 	.temp_factor	= LVTS_COEFF_A_MT8195,
 	.temp_offset	= LVTS_COEFF_B_MT8195,
 	.gt_calib_bit_offset = 24,
+	.def_calibration = 35000,
 };
 
 static const struct lvts_data mt8195_lvts_mcu_data = {
@@ -1741,6 +1757,7 @@ static const struct lvts_data mt8195_lvts_mcu_data = {
 	.temp_factor	= LVTS_COEFF_A_MT8195,
 	.temp_offset	= LVTS_COEFF_B_MT8195,
 	.gt_calib_bit_offset = 24,
+	.def_calibration = 35000,
 };
 
 static const struct lvts_data mt8195_lvts_ap_data = {
@@ -1749,6 +1766,7 @@ static const struct lvts_data mt8195_lvts_ap_data = {
 	.temp_factor	= LVTS_COEFF_A_MT8195,
 	.temp_offset	= LVTS_COEFF_B_MT8195,
 	.gt_calib_bit_offset = 24,
+	.def_calibration = 35000,
 };
 
 static const struct of_device_id lvts_of_match[] = {
-- 
2.45.2.741.gdbec12cfda-goog


