Return-Path: <linux-kernel+bounces-570343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C51C5A6AF1B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 21:24:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33549468544
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 20:24:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82A9622A819;
	Thu, 20 Mar 2025 20:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IkrbXpeu"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F9322A4FC
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 20:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742502260; cv=none; b=PsmumLOH/c3rclgyxxB/JageI9SUZuCGI5adyqRvnQsgSUIMFiB5pez5XAPdx6PljdZc0uZdbU3uoVpObq5CJDADoHiB6A85+fhxV+LMShZvcAn0MM8B/ke/cSHXoGBOgV5HMW3cejJxnFRAF92sS1IA04fyKPnxfGSZHlJtDlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742502260; c=relaxed/simple;
	bh=DNXVnMOqwb8fWB/J/SIbMZJRwIg2Q5PHwQoBAEHkhoQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CPHxyMduf+UAgT7N3A4H820UVVmZgsbFS0Y+ZH7lN/4ihf8vJ6QUt2Asmb8d0/F9ew2lX7RxnH/eAJSXduRjNOckxdrDZ4Hg6IMgiP+AY5tVctjHSzXXdtoHTEfpPKIaAtXRAt2+eqv3Zke2pRpDcRLUMITZ/bYBTyD6qAANnn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IkrbXpeu; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52KEns9T010960
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 20:24:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=egiacthqZDG
	pHiFeoWLEDtn1W1SQg/ufELhmV7ySKG4=; b=IkrbXpeuBHQF59MdyRW5Wu4gFjw
	ii3aId66w7asE94pdj9xS8aBwVe6fCog5kkfMiD/3wiDqzf5e9xAYmebj+xvfT6R
	wGh48RgphuSzfSUL/XjKumaesGV0Ewf3cSgTSb22MQWygZNkwlmpLncguAPlbgW+
	XSrMJEJBmu/r2qj9UMeLD8/i4xC59C1t7IlE9GRo13zZNRhASp/uwO0doOOSy5QC
	8PsWXXBmRtCdjEErUFPgAszw3QHZtrCPb5Io4f3/suKiB5kjVXN9ntqaQpvIiyXe
	QZcKFdid0bCVJkSHmwTMRL7aHun1qQLnLjAvmE07k/fVkvV5f1MyeoyeNkQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45fd1dqm5e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 20:24:17 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-22647ff3cf5so14443765ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 13:24:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742502256; x=1743107056;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=egiacthqZDGpHiFeoWLEDtn1W1SQg/ufELhmV7ySKG4=;
        b=Qu95tei3AxCMQw75nI0jF2cpkB+QWE29Q1RsLZ6VOqr38EcPqZLlnOym8Y+rUSMorz
         MId1QMhJAS5BlXjxF5xXHnYGweIqa914YuauVKxvKd5mdGYt1pyJLSfYZJnmLS4u+nVx
         0adjIxN1rO4If54q1vDaIVK37NCdrdyOBi3paedXs8OIwDMbNxve7agssd64CcfcuY4e
         VlGh72yeYm0LtReBGP6tO/57BWlvXuMxwT1C5LyCRPhud4TC8pEC78UV/uEB+79mFLiL
         2KqNsu47Oed+LCeQt3EsXdekdWJkWVZlzhHY7Ov1fQFycDn5hiM8lWaa4NnYDnNG9JB/
         JfCA==
X-Forwarded-Encrypted: i=1; AJvYcCXB2coqESAVNiLU1vqCuZMqMPaStz+3v3yeYyL1lvPVyB0hAWD7yv+E6cNbo6AJ/amwhrxco8GIyPGl9a0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0injY/vZtxIYYlYacEhFuWmHaFMl6/2Ba3es717WD9rTlya93
	bqz93TGi12cCq9koRf3QRi/tvydcNmknReOrRCZSBjFENS7GsXG5YUVrf7IH6WUaViiJl4Mtwci
	+B/vOKml8pQhmTU0xuXCfiq3dgkkKvaHhHRlcVrkX2Xc9LKUIO8A8lnAe0qsoT0M=
X-Gm-Gg: ASbGncub/izZ58jP8JlwYZoORn8dv1KTOl3P+ZWAO7vjAxSkZqD0456ngnA6gdVe22E
	afKLlzNqNTzYbX/VHIkMR7YcWvKfuNsmHP2+3aMoXsPfMzu8cC1sAqkEjlxSAlvJUykzgds9QAe
	bNUOVzah1m7qDECJwU5m5J1gAWAtRD4WdXQ5DU5erxWeFfjFcgW+ikTMZE8dUG9gbUnjNj4VGrp
	6XAsniT4478v2cRYvIVenFDce1nepr0jWGelP/h2kXtE2RIgvGbrrJCfOU42yCPtrnov4czZpeS
	f/sGJ5u+jFqIjlPG93Ku95txVCIWtjNBAP3Xy0Z4F0li4tNfzZ0kPUMetmlERTyyZ1fNeX3HwBX
	URck=
X-Received: by 2002:a05:6a00:928f:b0:736:34ff:be7 with SMTP id d2e1a72fcca58-73905a2762cmr1410685b3a.15.1742502256402;
        Thu, 20 Mar 2025 13:24:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH0JgEhdNyGDOq+wE1L4PhVpZdw5furaqQDaL73WBTBB6Ug6C2GuXYFgOxKakNTxeXNINsJsA==
X-Received: by 2002:a05:6a00:928f:b0:736:34ff:be7 with SMTP id d2e1a72fcca58-73905a2762cmr1410638b3a.15.1742502255805;
        Thu, 20 Mar 2025 13:24:15 -0700 (PDT)
Received: from hu-amelende-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7390600b9b1sm249308b3a.76.2025.03.20.13.24.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 13:24:15 -0700 (PDT)
From: Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>
To: amitk@kernel.org, thara.gopinath@gmail.com, rafael@kernel.org,
        daniel.lezcano@linaro.org
Cc: rui.zhang@intel.com, lukasz.luba@arm.com, david.collins@oss.qualcomm.com,
        srinivas.kandagatla@linaro.org, stefan.schmidt@linaro.org,
        quic_tsoni@quicinc.com, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmitry.baryshkov@linaro.org
Subject: [PATCH v3 3/5 RESEND] thermal: qcom-spmi-temp-alarm: Prepare to support additional Temp Alarm subtypes
Date: Thu, 20 Mar 2025 13:24:06 -0700
Message-Id: <20250320202408.3940777-4-anjelique.melendez@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250320202408.3940777-1-anjelique.melendez@oss.qualcomm.com>
References: <20250320202408.3940777-1-anjelique.melendez@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: m1VXYcEBut1Xs0iNlrwJ60EaAU3LTyOQ
X-Proofpoint-GUID: m1VXYcEBut1Xs0iNlrwJ60EaAU3LTyOQ
X-Authority-Analysis: v=2.4 cv=T52MT+KQ c=1 sm=1 tr=0 ts=67dc7971 cx=c_pps a=cmESyDAEBpBGqyK7t0alAg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=Vs1iUdzkB0EA:10 a=EUspDBNiAAAA:8 a=7un5503AD7E7R8fKnWkA:9 a=RVmHIydaz68A:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-20_07,2025-03-20_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 impostorscore=0 priorityscore=1501 bulkscore=0 mlxscore=0 clxscore=1015
 mlxlogscore=999 lowpriorityscore=0 phishscore=0 spamscore=0 malwarescore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503200131

In preparation to support newer temp alarm subtypes, add the "ops" and
"configure_trip_temps" references to spmi_temp_alarm_data. This will
allow for each Temp Alarm subtype to define its own
thermal_zone_device_ops and properly configure thermal trip temperature.

Signed-off-by: Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>
---
 drivers/thermal/qcom/qcom-spmi-temp-alarm.c | 38 ++++++++++++++-------
 1 file changed, 26 insertions(+), 12 deletions(-)

diff --git a/drivers/thermal/qcom/qcom-spmi-temp-alarm.c b/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
index 1cc9369ca9e1..514772e94a28 100644
--- a/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
+++ b/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
  * Copyright (c) 2011-2015, 2017, 2020, The Linux Foundation. All rights reserved.
- * Copyright (c) 2024, Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2024-2025, Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #include <linux/bitfield.h>
@@ -71,8 +71,10 @@ static const long temp_map_gen2_v1[THRESH_COUNT][STAGE_COUNT] = {
 struct qpnp_tm_chip;
 
 struct spmi_temp_alarm_data {
+	const struct thermal_zone_device_ops *ops;
 	const long (*temp_map)[THRESH_COUNT][STAGE_COUNT];
 	int (*get_temp_stage)(struct qpnp_tm_chip *chip);
+	int (*configure_trip_temps)(struct qpnp_tm_chip *chip);
 };
 
 struct qpnp_tm_chip {
@@ -312,18 +314,39 @@ static irqreturn_t qpnp_tm_isr(int irq, void *data)
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
 static const struct spmi_temp_alarm_data spmi_temp_alarm_data = {
+	.ops = &qpnp_tm_sensor_ops,
 	.temp_map = &temp_map_gen1,
+	.configure_trip_temps = qpnp_tm_configure_trip_temp,
 	.get_temp_stage = qpnp_tm_gen1_get_temp_stage,
 };
 
 static const struct spmi_temp_alarm_data spmi_temp_alarm_gen2_data = {
+	.ops = &qpnp_tm_sensor_ops,
 	.temp_map = &temp_map_gen1,
+	.configure_trip_temps = qpnp_tm_configure_trip_temp,
 	.get_temp_stage = qpnp_tm_gen2_get_temp_stage,
 };
 
 static const struct spmi_temp_alarm_data spmi_temp_alarm_gen2_rev1_data = {
+	.ops = &qpnp_tm_sensor_ops,
 	.temp_map = &temp_map_gen2_v1,
+	.configure_trip_temps = qpnp_tm_configure_trip_temp,
 	.get_temp_stage = qpnp_tm_gen2_get_temp_stage,
 };
 
@@ -336,7 +359,6 @@ static int qpnp_tm_init(struct qpnp_tm_chip *chip)
 {
 	int ret;
 	u8 reg = 0;
-	int crit_temp;
 
 	mutex_lock(&chip->lock);
 
@@ -355,15 +377,7 @@ static int qpnp_tm_init(struct qpnp_tm_chip *chip)
 	if (chip->stage)
 		chip->temp = qpnp_tm_decode_temp(chip, chip->stage);
 
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
 
@@ -483,7 +497,7 @@ static int qpnp_tm_probe(struct platform_device *pdev)
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


