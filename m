Return-Path: <linux-kernel+bounces-532306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A059A44B44
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 20:26:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 305DC189F473
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 19:25:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9338220C46B;
	Tue, 25 Feb 2025 19:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WiAtUBIZ"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B4120C006
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 19:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740511480; cv=none; b=OKXkopT3iqyeChUaLMIncl/biPpBsydVU5u761fof2LxDMFKl7M2C13cDDDIc/p9GAgoalYBYCEL1UqpvShY9vtAsTHQj7FShwi5Y2j+2YdAiqgurOOMIIVFeDtzWeYvZ6W+w4yAlRO8GN/65kgBkUSnF0iT8xl6t2bx4nyN/CM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740511480; c=relaxed/simple;
	bh=lLwIURtKZJUGidXlT3Y8BXV8+48ulOdPve60a5sXTu8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kBTfzsmbJK98IcVvvPINKEVVrDOil3EHDdo9tRNhm+MTSHoRWdf6j6gEoQkp+O9ob84KtaCeWkSy81lP2fqp4qqZj5+OxMEFnqr3pCdHTvPC/RgoWwYFy4pJGbE0YEO27ZySdrAVyTRwfKsTbpV7uyHNgVN4oAQYphuvAgGYy80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WiAtUBIZ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51PI4USn013334
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 19:24:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=sncinBpcYxj
	t4APU9WKLzYEwcQdqUmwiyrxdzC7yG6M=; b=WiAtUBIZj0ttkCcp07XUSFDGiyj
	1HiQg5y53sKGXUZHvwodICq4dxQER817hoFLKh7C2dPfuwcTgTfGjVjqYgCRjJ/C
	X9YOUJleEHPLCUWMIRWF/f+as8DrYT67AiDBWdOURV10QQvhJTBgOHOHbOG+sOXn
	jP86iNP7sagbe/fGS3IHfckpQVNcHZEbi2UVXf2qMTz+2z8X7Fgsic19Pw3OP6Hv
	SPbPC1CdeBxtXaBEHh5GUCVQk7kWSpOztTvBQ02kV1bfc5wmMA1893N6FFbfk5wp
	X+SEHGBAmzxE+s9r53zrMWszPL3eUWnNQx3eNcvt8ysqT6Xnd6OW9NZAHLw==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44y5wgt28x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 19:24:37 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2210305535bso197954705ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 11:24:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740511476; x=1741116276;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sncinBpcYxjt4APU9WKLzYEwcQdqUmwiyrxdzC7yG6M=;
        b=iHMBvHKTIDkJoVBK9T5EjkGeEcR0ruj4OIZqr+Fwr5tvvphY9rYHAl75gjh4EH5FOc
         2Y9+dt0N+3UBi4Hr8C9ikHVazddSa3umvbBl3s2T8BWPnpQTO7OIMU91ooSXswMuSAmq
         5YrCcaE9lJgtK/IanN/MxkUfwRJ53z8YR/LMdTyBC0b3/hkBk6oJ0ww0XPIxnmOch8bE
         6Rcy6WxED6H1cZ3SjUeikZ2pTJeZYasankgLFabDnvYhgHaOCgf4rFiKZwPEdj/vD5LN
         ZOFRQBmkWaNP6Cio7jVpyqyzXXkJRhqo5uCeyV1W/zkarBLxsQvrNV4yqM37XTNs7MTv
         PHhQ==
X-Forwarded-Encrypted: i=1; AJvYcCVh1eKm1wnqylWsKPoCKGJULiCBAPIISneecW3cwLNcm1R5qoNG5JHQ8/RGR63JhlWyyK6SsxFyiPkl+8U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwN/rA4Dk2Ughpvz3B+9s57V4/ZHskf1mP9zZbo6jEeZlpi6Ch4
	HvzzsBdRtiqKmXgcUrOHtWLjmK+oqYMvGwaY/1P71BPVDoBV8udp6vNRmRVcW4Az4b5UM1VMW8y
	+919dQ0QccZ59ZXCP10Wf7oa87ASDwe8CD323xhVAs+2j/+mi5uomP2QMxp3AMqw=
X-Gm-Gg: ASbGncvJhB7/L2so9E4SbFju+uXjP/L8w8Cd2rsTZrUxL4roxhykmlp53KPlb6orinG
	R9Mrsa11mbTm6mbgzG5eJGZCa2s9YFm+8i7n4Tj8k2BdoRlDRk/sDKC+XPchZvXM0xWMpsoDBs0
	UcUF0V7uq/dNx+n/O36bPy4NuLaIA6i3PmC9PwcLiq2zahEypEDlpBWzvOnOh6qfPZ/NRmYeJJV
	AYzJ0bKKipKXdItHf17AqCRmtSSmRIrRxo4hJmy2ehtAeada03EpBIM1Y/zYLRVxlCzyD8tM2Ob
	IZP+tCEBvkjYT9sRiI19o1A6zh7zGEMwD3YY3A5+X7oYu922GjGkKk9qnLSLuYOVeqjnPPBwAmw
	W4Uk=
X-Received: by 2002:a17:902:ea0c:b0:21f:35fd:1b57 with SMTP id d9443c01a7336-221a118747dmr293239285ad.43.1740511476554;
        Tue, 25 Feb 2025 11:24:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGcZhSdu3/3liSui3KRPqS+qc4K7OLYsdM23pgGyUKxKLvh4wc8up9IeNok70qF0g++GnZEmw==
X-Received: by 2002:a17:902:ea0c:b0:21f:35fd:1b57 with SMTP id d9443c01a7336-221a118747dmr293238895ad.43.1740511476154;
        Tue, 25 Feb 2025 11:24:36 -0800 (PST)
Received: from hu-amelende-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2230a095865sm17915365ad.145.2025.02.25.11.24.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 11:24:35 -0800 (PST)
From: Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>
To: amitk@kernel.org, thara.gopinath@gmail.com, rafael@kernel.org,
        daniel.lezcano@linaro.org
Cc: rui.zhang@intel.com, lukasz.luba@arm.com, david.collins@oss.qualcomm.com,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/5] thermal: qcom-spmi-temp-alarm: add support for GEN2 rev 2 PMIC peripherals
Date: Tue, 25 Feb 2025 11:24:28 -0800
Message-Id: <20250225192429.2328092-5-anjelique.melendez@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250225192429.2328092-1-anjelique.melendez@oss.qualcomm.com>
References: <20250225192429.2328092-1-anjelique.melendez@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 9qlrgNtODXC68mKW1w5CIWA6mDaHzXD5
X-Proofpoint-ORIG-GUID: 9qlrgNtODXC68mKW1w5CIWA6mDaHzXD5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-25_06,2025-02-25_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 clxscore=1015 adultscore=0 phishscore=0 mlxlogscore=999 spamscore=0
 mlxscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502250120

Add support for TEMP_ALARM GEN2 PMIC peripherals with digital major
revision 2.  This revision utilizes individual temp DAC registers
to set the threshold temperature for over-temperature stages 1,
2, and 3 instead of a single register to specify a set of
thresholds.

Signed-off-by: David Collins <david.collins@oss.qualcomm.com>
Signed-off-by: Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>
---
 drivers/thermal/qcom/qcom-spmi-temp-alarm.c | 136 ++++++++++++++++++++
 1 file changed, 136 insertions(+)

diff --git a/drivers/thermal/qcom/qcom-spmi-temp-alarm.c b/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
index fbfe633441ba..b4afe93ae87f 100644
--- a/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
+++ b/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
@@ -26,6 +26,11 @@
 #define QPNP_TM_REG_SHUTDOWN_CTRL1	0x40
 #define QPNP_TM_REG_ALARM_CTRL		0x46
 
+/* TEMP_DAC_STGx registers are only present for TEMP_GEN2 v2.0 */
+#define QPNP_TM_REG_TEMP_DAC_STG1	0x47
+#define QPNP_TM_REG_TEMP_DAC_STG2	0x48
+#define QPNP_TM_REG_TEMP_DAC_STG3	0x49
+
 #define QPNP_TM_TYPE			0x09
 #define QPNP_TM_SUBTYPE_GEN1		0x08
 #define QPNP_TM_SUBTYPE_GEN2		0x09
@@ -65,6 +70,25 @@ static const long temp_map_gen2_v1[THRESH_COUNT][STAGE_COUNT] = {
 
 #define TEMP_STAGE_HYSTERESIS		2000
 
+/*
+ * For TEMP_GEN2 v2.0, TEMP_DAC_STG1/2/3 registers are used to set the threshold
+ * for each stage independently.
+ * TEMP_DAC_STG* = 0 --> 80 C
+ * Each 8 step increase in TEMP_DAC_STG* value corresponds to 5 C (5000 mC).
+ */
+#define TEMP_DAC_MIN			80000
+#define TEMP_DAC_SCALE_NUM		8
+#define TEMP_DAC_SCALE_DEN		5000
+
+#define TEMP_DAC_TEMP_TO_REG(temp) \
+	(((temp) - TEMP_DAC_MIN) * TEMP_DAC_SCALE_NUM / TEMP_DAC_SCALE_DEN)
+#define TEMP_DAC_REG_TO_TEMP(reg) \
+	(TEMP_DAC_MIN + (reg) * TEMP_DAC_SCALE_DEN / TEMP_DAC_SCALE_NUM)
+
+static const long temp_dac_max[STAGE_COUNT] = {
+	119375, 159375, 159375
+};
+
 /* Temperature in Milli Celsius reported during stage 0 if no ADC is present */
 #define DEFAULT_TEMP			37000
 
@@ -73,6 +97,7 @@ struct qpnp_tm_chip;
 struct spmi_temp_alarm_data {
 	const struct thermal_zone_device_ops *ops;
 	const long (*temp_map)[THRESH_COUNT][STAGE_COUNT];
+	int (*setup)(struct qpnp_tm_chip *chip);
 	int (*get_temp_stage)(struct qpnp_tm_chip *chip);
 	int (*configure_trip_temps)(struct qpnp_tm_chip *chip);
 };
@@ -88,6 +113,7 @@ struct qpnp_tm_chip {
 	unsigned int			thresh;
 	unsigned int			stage;
 	unsigned int			base;
+	unsigned int			ntrips;
 	/* protects .thresh, .stage and chip registers */
 	struct mutex			lock;
 	bool				initialized;
@@ -305,6 +331,52 @@ static const struct thermal_zone_device_ops qpnp_tm_sensor_ops = {
 	.set_trip_temp = qpnp_tm_set_trip_temp,
 };
 
+static int qpnp_tm_gen2_rev2_set_temp_thresh(struct qpnp_tm_chip *chip, int trip, int temp)
+{
+	int ret, temp_cfg;
+	u8 reg;
+
+	if (trip < 0 || trip >= STAGE_COUNT) {
+		dev_err(chip->dev, "invalid TEMP_DAC trip = %d\n", trip);
+		return -EINVAL;
+	} else if (temp < TEMP_DAC_MIN || temp > temp_dac_max[trip]) {
+		dev_err(chip->dev, "invalid TEMP_DAC temp = %d\n", temp);
+		return -EINVAL;
+	}
+
+	reg = TEMP_DAC_TEMP_TO_REG(temp);
+	temp_cfg = TEMP_DAC_REG_TO_TEMP(reg);
+
+	ret = qpnp_tm_write(chip, QPNP_TM_REG_TEMP_DAC_STG1 + trip, reg);
+	if (ret < 0) {
+		dev_err(chip->dev, "TEMP_DAC_STG write failed, ret=%d\n", ret);
+		return ret;
+	}
+
+	chip->temp_thresh_map[trip] = temp_cfg;
+
+	return 0;
+}
+
+static int qpnp_tm_gen2_rev2_set_trip_temp(struct thermal_zone_device *tz,
+					   const struct thermal_trip *trip, int temp)
+{
+	unsigned int trip_index = THERMAL_TRIP_PRIV_TO_INT(trip->priv);
+	struct qpnp_tm_chip *chip = thermal_zone_device_priv(tz);
+	int ret;
+
+	mutex_lock(&chip->lock);
+	ret = qpnp_tm_gen2_rev2_set_temp_thresh(chip, trip_index, temp);
+	mutex_unlock(&chip->lock);
+
+	return ret;
+}
+
+static const struct thermal_zone_device_ops qpnp_tm_gen2_rev2_sensor_ops = {
+	.get_temp = qpnp_tm_get_temp,
+	.set_trip_temp = qpnp_tm_gen2_rev2_set_trip_temp,
+};
+
 static irqreturn_t qpnp_tm_isr(int irq, void *data)
 {
 	struct qpnp_tm_chip *chip = data;
@@ -329,6 +401,58 @@ static int qpnp_tm_configure_trip_temp(struct qpnp_tm_chip *chip)
 	return qpnp_tm_update_critical_trip_temp(chip, crit_temp);
 }
 
+/* Configure TEMP_DAC registers based on DT thermal_zone trips */
+static int qpnp_tm_gen2_rev2_configure_trip_temps_cb(struct thermal_trip *trip, void *data)
+{
+	struct qpnp_tm_chip *chip = data;
+	int ret;
+
+	trip->priv = THERMAL_INT_TO_TRIP_PRIV(chip->ntrips);
+	ret = qpnp_tm_gen2_rev2_set_temp_thresh(chip, chip->ntrips, trip->temperature);
+	chip->ntrips++;
+
+	return ret;
+}
+
+static int qpnp_tm_gen2_rev2_configure_trip_temps(struct qpnp_tm_chip *chip)
+{
+	int ret, i;
+
+	ret = thermal_zone_for_each_trip(chip->tz_dev,
+					 qpnp_tm_gen2_rev2_configure_trip_temps_cb, chip);
+	if (ret < 0)
+		return ret;
+
+	/* Verify that trips are strictly increasing. */
+	for (i = 1; i < STAGE_COUNT; i++) {
+		if (chip->temp_thresh_map[i] <= chip->temp_thresh_map[i - 1]) {
+			dev_err(chip->dev, "Threshold %d=%ld <= threshold %d=%ld\n",
+				i, chip->temp_thresh_map[i], i - 1,
+				chip->temp_thresh_map[i - 1]);
+			return -EINVAL;
+		}
+	}
+
+	return 0;
+}
+
+/* Read the hardware default TEMP_DAC stage threshold temperatures */
+static int qpnp_tm_gen2_rev2_setup(struct qpnp_tm_chip *chip)
+{
+	int ret, i;
+	u8 reg = 0;
+
+	for (i = 0; i < STAGE_COUNT; i++) {
+		ret = qpnp_tm_read(chip, QPNP_TM_REG_TEMP_DAC_STG1 + i, &reg);
+		if (ret < 0)
+			return ret;
+
+		chip->temp_thresh_map[i] = TEMP_DAC_REG_TO_TEMP(reg);
+	}
+
+	return 0;
+}
+
 static const struct spmi_temp_alarm_data spmi_temp_alarm_data = {
 	.ops = &qpnp_tm_sensor_ops,
 	.temp_map = &temp_map_gen1,
@@ -350,6 +474,13 @@ static const struct spmi_temp_alarm_data spmi_temp_alarm_gen2_rev1_data = {
 	.get_temp_stage = qpnp_tm_gen2_get_temp_stage,
 };
 
+static const struct spmi_temp_alarm_data spmi_temp_alarm_gen2_rev2_data = {
+	.ops = &qpnp_tm_gen2_rev2_sensor_ops,
+	.setup = qpnp_tm_gen2_rev2_setup,
+	.configure_trip_temps = qpnp_tm_gen2_rev2_configure_trip_temps,
+	.get_temp_stage = qpnp_tm_gen2_get_temp_stage,
+};
+
 /*
  * This function initializes the internal temp value based on only the
  * current thermal stage and threshold. Setup threshold control and
@@ -484,6 +615,8 @@ static int qpnp_tm_probe(struct platform_device *pdev)
 
 	if (subtype == QPNP_TM_SUBTYPE_GEN1)
 		chip->data = &spmi_temp_alarm_data;
+	else if (subtype == QPNP_TM_SUBTYPE_GEN2 && dig_major >= 2)
+		chip->data = &spmi_temp_alarm_gen2_rev2_data;
 	else if (subtype == QPNP_TM_SUBTYPE_GEN2 && dig_major >= 1)
 		chip->data = &spmi_temp_alarm_gen2_rev1_data;
 	else if (subtype == QPNP_TM_SUBTYPE_GEN2)
@@ -491,6 +624,9 @@ static int qpnp_tm_probe(struct platform_device *pdev)
 	else
 		return -ENODEV;
 
+	if (chip->data->setup)
+		chip->data->setup(chip);
+
 	/*
 	 * Register the sensor before initializing the hardware to be able to
 	 * read the trip points. get_temp() returns the default temperature
-- 
2.34.1


