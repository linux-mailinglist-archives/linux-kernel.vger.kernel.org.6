Return-Path: <linux-kernel+bounces-545765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7B8EA4F12E
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 00:06:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53E637A5EDB
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 23:05:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABBC227C87B;
	Tue,  4 Mar 2025 23:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UqWqfCRa"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD5E427C15A
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 23:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741129516; cv=none; b=PhWrgnOeMdGgI5rg9pc3Ld+hQl8Mk23W3S95Wrf4mZwIz73gngMmco7kMoOAyIyT5efCBwvY2Er53X4lAN5ACb6xBTnvXv08gYmrQXdhmalJR8hk2juA75OOEcWHVaAx7JW8VNdskiVcPrxbFFx+ywUAS+dy7gW26ASg1jXtIPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741129516; c=relaxed/simple;
	bh=H7KSE1RYrshvUFGJnP3ejIrBqUM1jbXJhYU6mYIyRu8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IK9BetqV7rNmuGeAE7LZoH5vS/wz6EHuM2lFYbW1efAQOM6fSYLQdxRNoOWS99JAZbGMOsFmGid4wkslVrYRYZmrti6SrBP1JDnJAzmvbzH0cuu8pTRW+c9KrAUBiJ8+kFUjAN/8M1l1dh6KmNCU7RlBn2Da4O4UXUqs5VK1PUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UqWqfCRa; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 524Liulk009946
	for <linux-kernel@vger.kernel.org>; Tue, 4 Mar 2025 23:05:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=uSqnCviNEbU
	NoXfwtDyicmV9Arq/nNUqt1uGmYnbL+A=; b=UqWqfCRalyxPB1/8oAWBfWMVH/e
	sFISc56goDzhVGb1OcoXOzPEh55JqyvcDaGUprW4ASumxmvo2G71Ut/JvdIDb7vj
	7RFKTCHGLa8aaHNrFdGyfnuSWQNYS0Yra3dpsbsnbayKMkWoWdNEWRd6AWhZwtzy
	G9csNuqwpedMKY00Y5ghB7FAl17Eho1f7FWNRI7e8B7oOdsTIgfsI4G1XoL628wT
	Xm1yZiIYP0e4N0RdlZ+J5yOaBrNnwVN6vRLrm5z2x8nKwY0/2ELTbfGIGJ71la4Q
	vCW60tdl+xw4eU5RXE8pRAFAeVfjl89Udes0+/Yosvq6K64+A/dbE9MAb7g==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 455p6wkcxr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 23:05:13 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2fed20dd70cso7033093a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 15:05:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741129512; x=1741734312;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uSqnCviNEbUNoXfwtDyicmV9Arq/nNUqt1uGmYnbL+A=;
        b=L48QvmQ0hEhdjXTa6GD5EnX9J97wSCeSjL33IK7KxG1p9WQHr0oHDyWSQHbyitnQBl
         BuBtVm7RoQK0eZta/aWPUIKB2WZwm6hdns4Mhe0Q4OLAZaKDE5srIenFrRpSVq0CCefz
         GTE/2LpQVSG46rD7X1qG2GS0DarN7g24nqa7FyzGH5NW3DuXmNaO/hLzUCy8tPJZQCm4
         YrgmtvnUjfE+lgk7Ht0d5stlHCZTcjTg+dtFG/55hfYazz2RrSEJCLnhufaU0Bl0QcWa
         EeEG2dBrw6KPVnVmuw4k18gmJ6bWCaMGrXdHrOl7Avv4a9rQIQz+ko3ck/O6Tt44n+uL
         A/KQ==
X-Forwarded-Encrypted: i=1; AJvYcCUg7dTy9pR7qlp7z9VyGQwDBu6Oa3bc8fh4MLSoWUIL7X1KYiZGCRNumqrPF+UIywyUZ0Sd9hOYZXyuBLs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSihOXVrnkxZAy3WS88e2BymZ9h69gX9+xZLYMsCq9rv3CC2q2
	36dS320pf7g0DVxts/ZPqG4Bp1mPX7Dglpy4HO+Hj671yObu3+dh2uPpOyYC2urWliz0zgyH+tf
	hgRGPP8J+FlHvDmwElhnsFid0b8xe+4C204TNnuemQeAW1AmcrWxCq6OSY+Cb6zE=
X-Gm-Gg: ASbGncvKlg4wdqc8XxtqpjbgW/xM9HqGs3HgkiwfMQ1w6DesK3YRBX5WiFhFA5d8RJ0
	0c42OD8lij15cBp8uyuTjkq6mZxxvQQhr5rwOdnZ6uagpf2mncvBybMhgpkUDRfqg2SBZxrf7kr
	N2m/FbGZx7m4SMYaajWHXphjXNoMDxYdNZF67g8pP8p57nBZkCaSoA6TICKNxkcemB1wxroyx6V
	Mk3o4ku7GS2155oITQZuoHuprmqrNp3H3MN3rPkQN2p8onpCKodsSqZf5u1KSOm6uAPVmwuYtiu
	YyOWkHtm6P/WKS4hcP2Bb7sZN0NuujYnBlWfQ9mCX8xIkSVUHZl2neqrN09RzxxAih8uuTbifQU
	SdkU=
X-Received: by 2002:a05:6a20:1582:b0:1f3:1d13:969f with SMTP id adf61e73a8af0-1f3494632fcmr1698645637.9.1741129512190;
        Tue, 04 Mar 2025 15:05:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE29dGVni57iqiYJXK50rIEzOLiq1im/AohVYkzzeKXwALS2G3RbdVYMf54EhRPh3LwABQATQ==
X-Received: by 2002:a05:6a20:1582:b0:1f3:1d13:969f with SMTP id adf61e73a8af0-1f3494632fcmr1698579637.9.1741129511702;
        Tue, 04 Mar 2025 15:05:11 -0800 (PST)
Received: from hu-amelende-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7349fe6cfd9sm11492793b3a.76.2025.03.04.15.05.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 15:05:10 -0800 (PST)
From: Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>
To: amitk@kernel.org, thara.gopinath@gmail.com, rafael@kernel.org,
        daniel.lezcano@linaro.org
Cc: rui.zhang@intel.com, lukasz.luba@arm.com, david.collins@oss.qualcomm.com,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dmitry.baryshkov@linaro.org
Subject: [PATCH v3 5/5] thermal: qcom-spmi-temp-alarm: add support for LITE PMIC peripherals
Date: Tue,  4 Mar 2025 15:05:02 -0800
Message-Id: <20250304230502.1470523-6-anjelique.melendez@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250304230502.1470523-1-anjelique.melendez@oss.qualcomm.com>
References: <20250304230502.1470523-1-anjelique.melendez@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=EZcyQOmC c=1 sm=1 tr=0 ts=67c78729 cx=c_pps a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=Vs1iUdzkB0EA:10 a=EUspDBNiAAAA:8 a=47G9NL9pyX4x7Wg37RYA:9 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-GUID: boRnifX8gSQfu1hDq5k9vaKOk8RyzcGh
X-Proofpoint-ORIG-GUID: boRnifX8gSQfu1hDq5k9vaKOk8RyzcGh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-04_09,2025-03-04_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 adultscore=0 lowpriorityscore=0 mlxlogscore=999 suspectscore=0 bulkscore=0
 clxscore=1015 priorityscore=1501 spamscore=0 impostorscore=0
 malwarescore=0 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503040184

Add support for TEMP_ALARM LITE PMIC peripherals. This subtype
utilizes a pair of registers to configure a warning interrupt
threshold temperature and an automatic hardware shutdown
threshold temperature.

Signed-off-by: David Collins <david.collins@oss.qualcomm.com>
Signed-off-by: Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>
---
 drivers/thermal/qcom/qcom-spmi-temp-alarm.c | 204 +++++++++++++++++++-
 1 file changed, 203 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/qcom/qcom-spmi-temp-alarm.c b/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
index efd2b6534127..2547a69dbd07 100644
--- a/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
+++ b/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
@@ -23,6 +23,7 @@
 #define QPNP_TM_REG_TYPE		0x04
 #define QPNP_TM_REG_SUBTYPE		0x05
 #define QPNP_TM_REG_STATUS		0x08
+#define QPNP_TM_REG_IRQ_STATUS		0x10
 #define QPNP_TM_REG_SHUTDOWN_CTRL1	0x40
 #define QPNP_TM_REG_ALARM_CTRL		0x46
 
@@ -30,14 +31,20 @@
 #define QPNP_TM_REG_TEMP_DAC_STG1	0x47
 #define QPNP_TM_REG_TEMP_DAC_STG2	0x48
 #define QPNP_TM_REG_TEMP_DAC_STG3	0x49
+#define QPNP_TM_REG_LITE_TEMP_CFG1	0x50
+#define QPNP_TM_REG_LITE_TEMP_CFG2	0x51
 
 #define QPNP_TM_TYPE			0x09
 #define QPNP_TM_SUBTYPE_GEN1		0x08
 #define QPNP_TM_SUBTYPE_GEN2		0x09
+#define QPNP_TM_SUBTYPE_LITE		0xC0
 
 #define STATUS_GEN1_STAGE_MASK		GENMASK(1, 0)
 #define STATUS_GEN2_STATE_MASK		GENMASK(6, 4)
 
+/* IRQ status only needed for TEMP_ALARM_LITE */
+#define IRQ_STATUS_MASK			BIT(0)
+
 #define SHUTDOWN_CTRL1_OVERRIDE_S2	BIT(6)
 #define SHUTDOWN_CTRL1_THRESHOLD_MASK	GENMASK(1, 0)
 
@@ -45,6 +52,8 @@
 
 #define ALARM_CTRL_FORCE_ENABLE		BIT(7)
 
+#define LITE_TEMP_CFG_THRESHOLD_MASK	GENMASK(3, 2)
+
 #define THRESH_COUNT			4
 #define STAGE_COUNT			3
 
@@ -89,6 +98,19 @@ static const long temp_dac_max[STAGE_COUNT] = {
 	119375, 159375, 159375
 };
 
+/*
+ * TEMP_ALARM_LITE has two stages: warning and shutdown with independently
+ * configured threshold temperatures.
+ */
+
+static const long temp_lite_warning_map[THRESH_COUNT] = {
+	115000, 125000, 135000, 145000
+};
+
+static const long temp_lite_shutdown_map[THRESH_COUNT] = {
+	135000, 145000, 160000, 175000
+};
+
 /* Temperature in Milli Celsius reported during stage 0 if no ADC is present */
 #define DEFAULT_TEMP			37000
 
@@ -198,6 +220,24 @@ static int qpnp_tm_gen2_get_temp_stage(struct qpnp_tm_chip *chip)
 	return alarm_state_map[ret];
 }
 
+/**
+ * qpnp_tm_lite_get_temp_stage() - return over-temperature stage
+ * @chip:		Pointer to the qpnp_tm chip
+ *
+ * Return: alarm interrupt state on success, or errno on failure.
+ */
+static int qpnp_tm_lite_get_temp_stage(struct qpnp_tm_chip *chip)
+{
+	u8 reg = 0;
+	int ret;
+
+	ret = qpnp_tm_read(chip, QPNP_TM_REG_IRQ_STATUS, &reg);
+	if (ret < 0)
+		return ret;
+
+	return reg & IRQ_STATUS_MASK;
+}
+
 /*
  * This function updates the internal temp value based on the
  * current thermal stage and threshold as well as the previous stage
@@ -377,6 +417,96 @@ static const struct thermal_zone_device_ops qpnp_tm_gen2_rev2_sensor_ops = {
 	.set_trip_temp = qpnp_tm_gen2_rev2_set_trip_temp,
 };
 
+static int qpnp_tm_lite_set_temp_thresh(struct qpnp_tm_chip *chip, int trip, int temp)
+{
+	int ret, temp_cfg, i;
+	const long *temp_map;
+	u16 addr;
+	u8 reg, thresh;
+
+	if (trip < 0 || trip >= STAGE_COUNT) {
+		dev_err(chip->dev, "invalid TEMP_LITE trip = %d\n", trip);
+		return -EINVAL;
+	}
+
+	switch (trip) {
+	case 0:
+		temp_map = temp_lite_warning_map;
+		addr = QPNP_TM_REG_LITE_TEMP_CFG1;
+		break;
+	case 1:
+		/*
+		 * The second trip point is purely in software to facilitate
+		 * a controlled shutdown after the warning threshold is crossed
+		 * but before the automatic hardware shutdown threshold is
+		 * crossed.
+		 */
+		return 0;
+	case 2:
+		temp_map = temp_lite_shutdown_map;
+		addr = QPNP_TM_REG_LITE_TEMP_CFG2;
+		break;
+	default:
+		return 0;
+	}
+
+	if (temp < temp_map[THRESH_MIN] || temp > temp_map[THRESH_MAX]) {
+		dev_err(chip->dev, "invalid TEMP_LITE temp = %d\n", temp);
+		return -EINVAL;
+	}
+
+	thresh = 0;
+	temp_cfg = temp_map[thresh];
+	for (i = THRESH_MAX; i >= THRESH_MIN; i--) {
+		if (temp >= temp_map[i]) {
+			thresh = i;
+			temp_cfg = temp_map[i];
+			break;
+		}
+	}
+
+	if (temp_cfg == chip->temp_thresh_map[trip])
+		return 0;
+
+	ret = qpnp_tm_read(chip, addr, &reg);
+	if (ret < 0) {
+		dev_err(chip->dev, "LITE_TEMP_CFG read failed, ret=%d\n", ret);
+		return ret;
+	}
+
+	reg &= ~LITE_TEMP_CFG_THRESHOLD_MASK;
+	reg |= FIELD_PREP(LITE_TEMP_CFG_THRESHOLD_MASK, thresh);
+
+	ret = qpnp_tm_write(chip, addr, reg);
+	if (ret < 0) {
+		dev_err(chip->dev, "LITE_TEMP_CFG write failed, ret=%d\n", ret);
+		return ret;
+	}
+
+	chip->temp_thresh_map[trip] = temp_cfg;
+
+	return 0;
+}
+
+static int qpnp_tm_lite_set_trip_temp(struct thermal_zone_device *tz,
+				      const struct thermal_trip *trip, int temp)
+{
+	unsigned int trip_index = THERMAL_TRIP_PRIV_TO_INT(trip->priv);
+	struct qpnp_tm_chip *chip = thermal_zone_device_priv(tz);
+	int ret;
+
+	mutex_lock(&chip->lock);
+	ret = qpnp_tm_lite_set_temp_thresh(chip, trip_index, temp);
+	mutex_unlock(&chip->lock);
+
+	return ret;
+}
+
+static const struct thermal_zone_device_ops qpnp_tm_lite_sensor_ops = {
+	.get_temp = qpnp_tm_get_temp,
+	.set_trip_temp = qpnp_tm_lite_set_trip_temp,
+};
+
 static irqreturn_t qpnp_tm_isr(int irq, void *data)
 {
 	struct qpnp_tm_chip *chip = data;
@@ -453,6 +583,68 @@ static int qpnp_tm_gen2_rev2_setup(struct qpnp_tm_chip *chip)
 	return 0;
 }
 
+/* Configure TEMP_LITE registers based on DT thermal_zone trips */
+static int qpnp_tm_lite_configure_trip_temps_cb(struct thermal_trip *trip, void *data)
+{
+	struct qpnp_tm_chip *chip = data;
+	int ret;
+
+	trip->priv = THERMAL_INT_TO_TRIP_PRIV(chip->ntrips);
+	ret = qpnp_tm_lite_set_temp_thresh(chip, chip->ntrips, trip->temperature);
+	chip->ntrips++;
+
+	return ret;
+}
+
+static int qpnp_tm_lite_configure_trip_temps(struct qpnp_tm_chip *chip)
+{
+	int ret;
+
+	ret = thermal_zone_for_each_trip(chip->tz_dev, qpnp_tm_lite_configure_trip_temps_cb, chip);
+	if (ret < 0)
+		return ret;
+
+	/* Verify that trips are strictly increasing. */
+	if (chip->temp_thresh_map[2] <= chip->temp_thresh_map[0]) {
+		dev_err(chip->dev, "Threshold 2=%ld <= threshold 0=%ld\n",
+			chip->temp_thresh_map[2], chip->temp_thresh_map[0]);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+/* Read the hardware default TEMP_LITE stage threshold temperatures */
+static int qpnp_tm_lite_setup(struct qpnp_tm_chip *chip)
+{
+	int ret, thresh;
+	u8 reg = 0;
+
+	/*
+	 * Store the warning trip temp in temp_thresh_map[0] and the shutdown trip
+	 * temp in temp_thresh_map[2].  The second trip point is purely in software
+	 * to facilitate a controlled shutdown after the warning threshold is
+	 * crossed but before the automatic hardware shutdown threshold is
+	 * crossed.  Thus, there is no register to read for the second trip
+	 * point.
+	 */
+	ret = qpnp_tm_read(chip, QPNP_TM_REG_LITE_TEMP_CFG1, &reg);
+	if (ret < 0)
+		return ret;
+
+	thresh = FIELD_GET(LITE_TEMP_CFG_THRESHOLD_MASK, reg);
+	chip->temp_thresh_map[0] = temp_lite_warning_map[thresh];
+
+	ret = qpnp_tm_read(chip, QPNP_TM_REG_LITE_TEMP_CFG2, &reg);
+	if (ret < 0)
+		return ret;
+
+	thresh = FIELD_GET(LITE_TEMP_CFG_THRESHOLD_MASK, reg);
+	chip->temp_thresh_map[2] = temp_lite_shutdown_map[thresh];
+
+	return 0;
+}
+
 static const struct spmi_temp_alarm_data spmi_temp_alarm_data = {
 	.ops = &qpnp_tm_sensor_ops,
 	.temp_map = &temp_map_gen1,
@@ -481,6 +673,13 @@ static const struct spmi_temp_alarm_data spmi_temp_alarm_gen2_rev2_data = {
 	.get_temp_stage = qpnp_tm_gen2_get_temp_stage,
 };
 
+static const struct spmi_temp_alarm_data spmi_temp_alarm_lite_data = {
+	.ops = &qpnp_tm_lite_sensor_ops,
+	.setup = qpnp_tm_lite_setup,
+	.configure_trip_temps = qpnp_tm_lite_configure_trip_temps,
+	.get_temp_stage = qpnp_tm_lite_get_temp_stage,
+};
+
 /*
  * This function initializes the internal temp value based on only the
  * current thermal stage and threshold. Setup threshold control and
@@ -605,7 +804,8 @@ static int qpnp_tm_probe(struct platform_device *pdev)
 	}
 
 	if (type != QPNP_TM_TYPE || (subtype != QPNP_TM_SUBTYPE_GEN1
-				     && subtype != QPNP_TM_SUBTYPE_GEN2)) {
+				     && subtype != QPNP_TM_SUBTYPE_GEN2
+				     && subtype != QPNP_TM_SUBTYPE_LITE)) {
 		dev_err(&pdev->dev, "invalid type 0x%02x or subtype 0x%02x\n",
 			type, subtype);
 		return -ENODEV;
@@ -621,6 +821,8 @@ static int qpnp_tm_probe(struct platform_device *pdev)
 		chip->data = &spmi_temp_alarm_gen2_rev1_data;
 	else if (subtype == QPNP_TM_SUBTYPE_GEN2)
 		chip->data = &spmi_temp_alarm_gen2_data;
+	else if (subtype == QPNP_TM_SUBTYPE_LITE)
+		chip->data = &spmi_temp_alarm_lite_data;
 	else
 		return -ENODEV;
 
-- 
2.34.1


