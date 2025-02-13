Return-Path: <linux-kernel+bounces-513906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F41C2A35014
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 22:04:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A3133AB82C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 21:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9473F26982C;
	Thu, 13 Feb 2025 21:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nlAEbEhb"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4EF4266B6E
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 21:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739480651; cv=none; b=pm+oLtyCtQm4/09ODCw1LM7oqm9ocSQB0qLPxrNq8MBOB2V1HKXEXNPM3m2QdmzsJ/SVo1u8Qw3IUCY1U0/JAAH1TnGkCCT3rWWaTlWHMVrVAfCfuy0PSctSYDRUkVsrhboc+cu1+lKLYAmUoj04Uz1FKarGCl9RmcsXpbh+298=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739480651; c=relaxed/simple;
	bh=GM+4bhNAl1441YOTR5MbZ5/yN2e4mNV75gEtdPN/F1c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CraZtNYFsQXt25Xk0sEtvJHjUXg3N4jwnfyVNrrOPROhfWeZTpOYx9yPrs2ADKxLpTaWWh4E7YbRBg69Xg7Hkth8DS4HF6F615w6zvkXTokzbp1NmgEuNmZFF+m9W4L0ho8+GzbrWTTGuTh2QR/VECX7Uvrtp12IKZMFuJnHhV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nlAEbEhb; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51DA2N8n002033
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 21:04:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=rSa4lNLlL57
	Ev4X2zTTAhjSNjhxW2Koo6K25PXXREP8=; b=nlAEbEhb/OYR3tI/SQrL/srpiqF
	Yfujqbi6rnEyVMrfJIv0YL/v9qcl0y3ObrvJrR3g+HiM3t6Gkwq1TD93rNvF6lIY
	FfaeOpf7AYn8XVNTvAoWtON+wAeBLru6tUXY9wFsK5alire2GqU9DbwaAEE9xKzU
	SNe6IazVtnDrS46ESSgXOB93gpSRrWBNF9nU2D9XL3MXSh3oulZTkWm8ZA6ncxGg
	rWGNXwoD3pHESnp9WedrTd0a9jzDF8aAQX442E3ISKLwaIX4DqmKVJSLyE7nHcyE
	reu8/YiWH03ZtEjnnSpUiviDn7d7IJIChfWduwXumd1W7n1neSJ19eOblrg==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44semp9mu4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 21:04:08 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-220e62c4fc2so8989595ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 13:04:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739480648; x=1740085448;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rSa4lNLlL57Ev4X2zTTAhjSNjhxW2Koo6K25PXXREP8=;
        b=jnBgNQbjzUjXNUv7tcO9dN6+GZDsKpn0zaV/nFIT+vSWcCLZVPBRaVfAgJls5mM9cJ
         UpsDY3E5ktlmhQLEhKx+c9ImQgrJbp9VsV1liN0P8L+kcmi4M2KLR0ms1P630W8hgdIE
         EbgnbNQS6DBfe1ok2sTQKIgmnOwfFYrslO6c35JFVSTwYoqjSl+I6aYpEAPrcC73tCE9
         GMJG0yHwPhjCjh7ev71P++56USqzpNDfJtLnHSsxYXq4EbGJYwh6McFic0KfDn7Q+1aZ
         xUXlk9Ljr6PqTbIRb8i+LjUGlMwQr35NHqp66x+2evG0xbGURUrZ81PHPPeR7vXNxqnE
         6bHA==
X-Forwarded-Encrypted: i=1; AJvYcCV0/1NPPPJaogZg8x0MY5mBw39AFYX+VNCxT1VXos13JbINdYFsjAhNUDALMV1qH8FF0rMPfoPDKzPuP8I=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywnv50/uzx7M4QVqQs2DhQZtXaQcrjdBPhzTAAIpuKwZmHpj4VR
	nHuBfFFwExyncbanptkAY5RHXA3J18KufyshBYPhjmxz3KhJzKgv3HkM9KRvLBVcs2R7Q3f1U8V
	VSAPdaBNQGkyNGg9/BGy5aOWVxZNQDHQ8XOiX2EI1yDt0orgtdgi/qdtLobFvj/s=
X-Gm-Gg: ASbGncsUQIZW32fuK+v0kQY6qcfApnBjkhnILxvyA5ZRa2r5vErKx6Qp6g2EX4FiKAa
	7uHb+25XhLWZXdE4pL9d7+4795gefuHOv2UvDYYlwE9K6q28ZW40mTepWEU90ou+Tx/lVqC4Oll
	F3ZBvto9tgf3S57G45oHOv8BQjZDBR93miS9mv3ZlxgLBx+PBWysGbbmIvkhv+hAtJX2+ZZt3HL
	/lkh906FjSMY+ShPBUL/vPxqCQUe+Bwr5p1F7LLH0SMJqesStuP8Oqn1/O3c1nX2H9yG7CAW7sY
	FAU+1AdhCO+FchW1VIq7G4DHeUUHrXZY7RA8UGuPlWJD4D2ncUwuBJ2GCQdzMuh9d1JC
X-Received: by 2002:a17:902:e74e:b0:216:760c:3879 with SMTP id d9443c01a7336-220bbc7b79dmr146033255ad.46.1739480647619;
        Thu, 13 Feb 2025 13:04:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFgKGFpXY49cB7/WgrJ0o/4+EO/NF/DO/9XpQ+ewKlCA1oyIhD8ja67LLFDR1fOkvkZtaSRIw==
X-Received: by 2002:a17:902:e74e:b0:216:760c:3879 with SMTP id d9443c01a7336-220bbc7b79dmr146032745ad.46.1739480647163;
        Thu, 13 Feb 2025 13:04:07 -0800 (PST)
Received: from hu-amelende-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220dacfc769sm14339375ad.201.2025.02.13.13.04.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 13:04:06 -0800 (PST)
From: Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>
To: amitk@kernel.org, thara.gopinath@gmail.com, rafael@kernel.org,
        daniel.lezcano@linaro.org
Cc: rui.zhang@intel.com, lukasz.luba@arm.com, david.collins@oss.qualcomm.com,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] thermal: qcom-spmi-temp-alarm: Add temp alarm data struct based on HW subtype
Date: Thu, 13 Feb 2025 13:04:01 -0800
Message-Id: <20250213210403.3396392-3-anjelique.melendez@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250213210403.3396392-1-anjelique.melendez@oss.qualcomm.com>
References: <20250213210403.3396392-1-anjelique.melendez@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: pqCOhs8r0crVTjCwt8p4ZknLSBDAPrVJ
X-Proofpoint-GUID: pqCOhs8r0crVTjCwt8p4ZknLSBDAPrVJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-13_08,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 mlxscore=0 bulkscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0
 impostorscore=0 malwarescore=0 mlxlogscore=999 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2501170000
 definitions=main-2502130148

Currently multiple if/else statements are used in functions to decipher
between SPMI temp alarm Gen 1, Gen 2 and Gen 2 Rev 1 functionality. Instead
refactor the driver so that SPMI temp alarm chips will have reference to a
spmi_temp_alarm_data struct which defines data and function callbacks
based on the HW subtype.

Signed-off-by: Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>
---
 drivers/thermal/qcom/qcom-spmi-temp-alarm.c | 143 +++++++++++++-------
 1 file changed, 95 insertions(+), 48 deletions(-)

diff --git a/drivers/thermal/qcom/qcom-spmi-temp-alarm.c b/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
index b2077ff9fe73..af71d4238340 100644
--- a/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
+++ b/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
@@ -31,7 +31,6 @@
 
 #define STATUS_GEN1_STAGE_MASK		GENMASK(1, 0)
 #define STATUS_GEN2_STATE_MASK		GENMASK(6, 4)
-#define STATUS_GEN2_STATE_SHIFT		4
 
 #define SHUTDOWN_CTRL1_OVERRIDE_S2	BIT(6)
 #define SHUTDOWN_CTRL1_THRESHOLD_MASK	GENMASK(1, 0)
@@ -68,10 +67,20 @@ static const long temp_map_gen2_v1[THRESH_COUNT][STAGE_COUNT] = {
 /* Temperature in Milli Celsius reported during stage 0 if no ADC is present */
 #define DEFAULT_TEMP			37000
 
+struct qpnp_tm_chip;
+
+struct spmi_temp_alarm_data {
+	const struct thermal_zone_device_ops *ops;
+	const long (*temp_map)[THRESH_COUNT][STAGE_COUNT];
+	int (*get_temp_stage)(struct qpnp_tm_chip *chip);
+	int (*configure_trip_temps)(struct qpnp_tm_chip *chip);
+};
+
 struct qpnp_tm_chip {
 	struct regmap			*map;
 	struct device			*dev;
 	struct thermal_zone_device	*tz_dev;
+	const struct spmi_temp_alarm_data *data;
 	unsigned int			subtype;
 	unsigned int			dig_revision;
 	long				temp;
@@ -82,14 +91,11 @@ struct qpnp_tm_chip {
 	struct mutex			lock;
 	bool				initialized;
 	bool				require_s2_shutdown;
+	long				temp_thresh_map[STAGE_COUNT];
 
 	struct iio_channel		*adc;
-	const long			(*temp_map)[THRESH_COUNT][STAGE_COUNT];
 };
 
-/* This array maps from GEN2 alarm state to GEN1 alarm stage */
-static const unsigned int alarm_state_map[8] = {0, 1, 1, 2, 2, 3, 3, 3};
-
 static int qpnp_tm_read(struct qpnp_tm_chip *chip, u16 addr, u8 *data)
 {
 	unsigned int val;
@@ -118,34 +124,51 @@ static int qpnp_tm_write(struct qpnp_tm_chip *chip, u16 addr, u8 data)
  */
 static long qpnp_tm_decode_temp(struct qpnp_tm_chip *chip, unsigned int stage)
 {
-	if (!chip->temp_map || chip->thresh >= THRESH_COUNT || stage == 0 ||
-	    stage > STAGE_COUNT)
+	if (stage == 0 || stage > STAGE_COUNT)
 		return 0;
 
-	return (*chip->temp_map)[chip->thresh][stage - 1];
+	return chip->temp_thresh_map[stage - 1];
 }
 
 /**
  * qpnp_tm_get_temp_stage() - return over-temperature stage
  * @chip:		Pointer to the qpnp_tm chip
  *
- * Return: stage (GEN1) or state (GEN2) on success, or errno on failure.
+ * Return: stage on success, or errno on failure.
  */
 static int qpnp_tm_get_temp_stage(struct qpnp_tm_chip *chip)
 {
+	u8 reg = 0;
 	int ret;
+
+	ret = qpnp_tm_read(chip, QPNP_TM_REG_STATUS, &reg);
+	if (ret < 0)
+		return ret;
+
+	return FIELD_GET(STATUS_GEN1_STAGE_MASK, reg);
+}
+
+/* This array maps from GEN2 alarm state to GEN1 alarm stage */
+static const unsigned int alarm_state_map[8] = {0, 1, 1, 2, 2, 3, 3, 3};
+
+/**
+ * qpnp_tm_get_gen2_temp_stage() - return over-temperature stage
+ * @chip:		Pointer to the qpnp_tm chip
+ *
+ * Return: stage on success, or errno on failure.
+ */
+static int qpnp_tm_gen2_get_temp_stage(struct qpnp_tm_chip *chip)
+{
 	u8 reg = 0;
+	int ret;
 
 	ret = qpnp_tm_read(chip, QPNP_TM_REG_STATUS, &reg);
 	if (ret < 0)
 		return ret;
 
-	if (chip->subtype == QPNP_TM_SUBTYPE_GEN1)
-		ret = reg & STATUS_GEN1_STAGE_MASK;
-	else
-		ret = (reg & STATUS_GEN2_STATE_MASK) >> STATUS_GEN2_STATE_SHIFT;
+	ret = FIELD_GET(STATUS_GEN2_STATE_MASK, reg);
 
-	return ret;
+	return alarm_state_map[ret];
 }
 
 /*
@@ -154,23 +177,16 @@ static int qpnp_tm_get_temp_stage(struct qpnp_tm_chip *chip)
  */
 static int qpnp_tm_update_temp_no_adc(struct qpnp_tm_chip *chip)
 {
-	unsigned int stage, stage_new, stage_old;
+	unsigned int stage_new, stage_old;
 	int ret;
 
 	WARN_ON(!mutex_is_locked(&chip->lock));
 
-	ret = qpnp_tm_get_temp_stage(chip);
+	ret = chip->data->get_temp_stage(chip);
 	if (ret < 0)
 		return ret;
-	stage = ret;
-
-	if (chip->subtype == QPNP_TM_SUBTYPE_GEN1) {
-		stage_new = stage;
-		stage_old = chip->stage;
-	} else {
-		stage_new = alarm_state_map[stage];
-		stage_old = alarm_state_map[chip->stage];
-	}
+	stage_new = ret;
+	stage_old = chip->stage;
 
 	if (stage_new > stage_old) {
 		/* increasing stage, use lower bound */
@@ -182,7 +198,7 @@ static int qpnp_tm_update_temp_no_adc(struct qpnp_tm_chip *chip)
 				- TEMP_STAGE_HYSTERESIS;
 	}
 
-	chip->stage = stage;
+	chip->stage = stage_new;
 
 	return 0;
 }
@@ -222,8 +238,8 @@ static int qpnp_tm_get_temp(struct thermal_zone_device *tz, int *temp)
 static int qpnp_tm_update_critical_trip_temp(struct qpnp_tm_chip *chip,
 					     int temp)
 {
-	long stage2_threshold_min = (*chip->temp_map)[THRESH_MIN][1];
-	long stage2_threshold_max = (*chip->temp_map)[THRESH_MAX][1];
+	long stage2_threshold_min = (*chip->data->temp_map)[THRESH_MIN][1];
+	long stage2_threshold_max = (*chip->data->temp_map)[THRESH_MAX][1];
 	bool disable_s2_shutdown = false;
 	u8 reg;
 
@@ -258,6 +274,8 @@ static int qpnp_tm_update_critical_trip_temp(struct qpnp_tm_chip *chip,
 	}
 
 skip:
+	memcpy(chip->temp_thresh_map, chip->data->temp_map[chip->thresh],
+		sizeof(chip->temp_thresh_map));
 	reg |= chip->thresh;
 	if (disable_s2_shutdown && !chip->require_s2_shutdown)
 		reg |= SHUTDOWN_CTRL1_OVERRIDE_S2;
@@ -295,6 +313,42 @@ static irqreturn_t qpnp_tm_isr(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
+static int qpnp_tm_configure_trip_temp(struct qpnp_tm_chip *chip)
+{
+	int crit_temp, ret;
+
+	mutex_unlock(&chip->lock);
+
+	ret = thermal_zone_get_crit_temp(chip->tz_dev, &crit_temp);
+	if (ret)
+		crit_temp = THERMAL_TEMP_INVALID;
+
+	mutex_lock(&chip->lock);
+
+	return qpnp_tm_update_critical_trip_temp(chip, crit_temp);
+}
+
+static const struct spmi_temp_alarm_data spmi_temp_alarm_data = {
+	.ops = &qpnp_tm_sensor_ops,
+	.temp_map = &temp_map_gen1,
+	.configure_trip_temps = qpnp_tm_configure_trip_temp,
+	.get_temp_stage = qpnp_tm_get_temp_stage,
+};
+
+static const struct spmi_temp_alarm_data spmi_temp_alarm_gen2_data = {
+	.ops = &qpnp_tm_sensor_ops,
+	.temp_map = &temp_map_gen1,
+	.configure_trip_temps = qpnp_tm_configure_trip_temp,
+	.get_temp_stage = qpnp_tm_gen2_get_temp_stage,
+};
+
+static const struct spmi_temp_alarm_data spmi_temp_alarm_gen2_rev1_data = {
+	.ops = &qpnp_tm_sensor_ops,
+	.temp_map = &temp_map_gen2_v1,
+	.configure_trip_temps = qpnp_tm_configure_trip_temp,
+	.get_temp_stage = qpnp_tm_gen2_get_temp_stage,
+};
+
 /*
  * This function initializes the internal temp value based on only the
  * current thermal stage and threshold. Setup threshold control and
@@ -305,7 +359,6 @@ static int qpnp_tm_init(struct qpnp_tm_chip *chip)
 	unsigned int stage;
 	int ret;
 	u8 reg = 0;
-	int crit_temp;
 
 	mutex_lock(&chip->lock);
 
@@ -316,26 +369,15 @@ static int qpnp_tm_init(struct qpnp_tm_chip *chip)
 	chip->thresh = reg & SHUTDOWN_CTRL1_THRESHOLD_MASK;
 	chip->temp = DEFAULT_TEMP;
 
-	ret = qpnp_tm_get_temp_stage(chip);
-	if (ret < 0)
+	stage = chip->data->get_temp_stage(chip);
+	if (stage < 0)
 		goto out;
-	chip->stage = ret;
-
-	stage = chip->subtype == QPNP_TM_SUBTYPE_GEN1
-		? chip->stage : alarm_state_map[chip->stage];
+	chip->stage = stage;
 
 	if (stage)
 		chip->temp = qpnp_tm_decode_temp(chip, stage);
 
-	mutex_unlock(&chip->lock);
-
-	ret = thermal_zone_get_crit_temp(chip->tz_dev, &crit_temp);
-	if (ret)
-		crit_temp = THERMAL_TEMP_INVALID;
-
-	mutex_lock(&chip->lock);
-
-	ret = qpnp_tm_update_critical_trip_temp(chip, crit_temp);
+	ret = chip->data->configure_trip_temps(chip);
 	if (ret < 0)
 		goto out;
 
@@ -439,10 +481,15 @@ static int qpnp_tm_probe(struct platform_device *pdev)
 	}
 
 	chip->subtype = subtype;
-	if (subtype == QPNP_TM_SUBTYPE_GEN2 && dig_major >= 1)
-		chip->temp_map = &temp_map_gen2_v1;
+
+	if (subtype == QPNP_TM_SUBTYPE_GEN1)
+		chip->data = &spmi_temp_alarm_data;
+	else if (subtype == QPNP_TM_SUBTYPE_GEN2 && dig_major >= 1)
+		chip->data = &spmi_temp_alarm_gen2_rev1_data;
+	else if (subtype == QPNP_TM_SUBTYPE_GEN2)
+		chip->data = &spmi_temp_alarm_gen2_data;
 	else
-		chip->temp_map = &temp_map_gen1;
+		return -ENODEV;
 
 	/*
 	 * Register the sensor before initializing the hardware to be able to
@@ -450,7 +497,7 @@ static int qpnp_tm_probe(struct platform_device *pdev)
 	 * before the hardware initialization is completed.
 	 */
 	chip->tz_dev = devm_thermal_of_zone_register(
-		&pdev->dev, 0, chip, &qpnp_tm_sensor_ops);
+		&pdev->dev, 0, chip, chip->data->ops);
 	if (IS_ERR(chip->tz_dev))
 		return dev_err_probe(&pdev->dev, PTR_ERR(chip->tz_dev),
 				     "failed to register sensor\n");
-- 
2.34.1


