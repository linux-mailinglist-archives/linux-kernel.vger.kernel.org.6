Return-Path: <linux-kernel+bounces-513905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 31F80A3500F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 22:04:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96E8F16B781
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 21:04:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E155266B7D;
	Thu, 13 Feb 2025 21:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="G4lIXjpW"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61A46266198
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 21:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739480649; cv=none; b=CdVZzQK21J5cuRy8WFOtfYbC3GSY/NZCadkzbwEbti+Vu9sH60spxiUOzKKID9Rf5cVqUkd7B7BttH+3/Fm8XRvJhPCUEXRwlgztveOOpvQSMWv95jckmq15bSQC2oQUSDDsxfMgVZqb7lr52dlXaRjDXhRsrXdFpiQyQ9eYPp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739480649; c=relaxed/simple;
	bh=Hm34EcCZY7Nya6IWrGgD3q/+JNM1BPaGd40TDCxo+LM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DCb0IMDJBpmYo96X+6jfS8W1gAIXezpEBwKBmyWZqNEFLEZIfsrwhkwisKT2bRfQILzAqRRrhRZ2OUiBvVkT5lhkhX4U/0RKN0FHRnUQ2fSDh2XuI4k8oX00IzYjV19XG3+53cjLP0FPdpv4ai0abKMcqj9nz6ejLTou33wIfAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=G4lIXjpW; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51DKHNjo001789
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 21:04:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=/E2f4sNa5dJ
	1J/+u/sCAiw4E4qFHfywaLempWlQrqbI=; b=G4lIXjpWbUU5RKfBQ/y4NncLt/G
	E0J85o1BuM3mk2EWd5+Sk9EXLpYI/SoEudUG7XpMsK6H+AsHJ7LnBG9BSdHG+fHi
	FMmfXqpjd+1rgNPg4MqFAOo0Cp7hQHiHBS5OaoyjM8r8VrT8YGckhykJeqCdxWTj
	pKc8NuCFhcKAmnzkyoJSJp/GiuKT+i0G/B/0kbHBYiAWLn+EZwZPgANzOPfvkb7+
	R+GisppLdtNJ/oiUX7Zna/ruzj7Gjjs4XB+lnhn9CcgQK+pm9KC5ncSy6m0ObgYY
	l6nCQRDBM91Ib3ugWoadoHXruulywezBt2g3HHl7o58AajwX//ChzDDmffg==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44semp9mu0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 21:04:07 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-220e7d654acso9088465ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 13:04:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739480646; x=1740085446;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/E2f4sNa5dJ1J/+u/sCAiw4E4qFHfywaLempWlQrqbI=;
        b=wi06lqwLyTMderaw1nhHVKXXKrHb2GRh/5hm8Cs4LcNA+TL2hCJIzkatuCKmVZyuE2
         dyfgF77zZMA3+NMvtM51QZiaYD4cGPbAiDHxRNcwqCPMnLrDDQ2cikLoSp3pQuCD8cvb
         bUpigOSAl9DewjWSL7ST9ClPvWGg1033sjcusrrR/Uapiln4I/ikBtXE9aSrq0xsIyS5
         fR5VE3IctmxvF46s6rlKsxEm58uY18JF2/2edEej2Uj7KsRlv4PwAF2idLcvaNNKYt8y
         4h5X4z7owsSX3IQag83lKxuEOicOcTO9p0/UZiSLedwKBZuPGJ0aauh+UFWbD9B7QCJq
         YA3Q==
X-Forwarded-Encrypted: i=1; AJvYcCVUF2WLoUNuw+MD63DbW959cErkb//vedqH8G2Cb+7dsZ9xMUMnQEf3GIHHV2V7WNt5o/bcWY2n/zyzwlQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0fM70acJVMq4+XsPvLcH6e1sqigNc+jfYzYM4jjZgQr/1kkI+
	Ih6PiQG/voNO/g5b4ldM/n5RgAVE7incGoIjx78IjWksLz82+rVgTw50meqcNbNxz25UyMHVnuQ
	Ur4H11or4OUGXrd6jV/uqPFAMkcAViSYcTxkm/1OIbaHx/bb8cO37Q8SmdRF8rUE=
X-Gm-Gg: ASbGncsFUGVDVsPGa7P3v3j+XXfQGeA/vh/FdeRX3lHcEQ8hfzwdKWePWVQVhva4lkP
	CMV2GipXeHWlqHGALIcR73YqYdSYBfpfZhl9K7zUNzDMEwD6omc0b4f+PqnsfWAI4gkeKt+3nkp
	iFLcOpNRJiPQpqe+XnowD/tmxEDYkTSTiWWjDYHgHNaiSzaE4dWXsNouelHr73KW3/+CxWaK0w6
	BfpwoVniL5nVhJ5pHhciD4pFx7qcNV39HsIfFvdGZ15VmzRF5bHGB2Sdy91UD9+AZVz3PQCggUL
	7MbPbCHcAiF0W7WLNawtur1OzdB/npHPRbXsXC1cl9Y5D9AP+XQe9TBB230GDpR8kebf
X-Received: by 2002:a17:902:f689:b0:21f:98fc:8414 with SMTP id d9443c01a7336-220d35e2297mr70289395ad.26.1739480646257;
        Thu, 13 Feb 2025 13:04:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFgZkxefzAh1dnDM8xO5GuAGXCpKBllT6VbOz2bGnH6gN5UaFfTD4wPjuQFCzfXfUFkHcgqag==
X-Received: by 2002:a17:902:f689:b0:21f:98fc:8414 with SMTP id d9443c01a7336-220d35e2297mr70288985ad.26.1739480645828;
        Thu, 13 Feb 2025 13:04:05 -0800 (PST)
Received: from hu-amelende-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220dacfc769sm14339375ad.201.2025.02.13.13.04.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 13:04:05 -0800 (PST)
From: Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>
To: amitk@kernel.org, thara.gopinath@gmail.com, rafael@kernel.org,
        daniel.lezcano@linaro.org
Cc: rui.zhang@intel.com, lukasz.luba@arm.com, david.collins@oss.qualcomm.com,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] thermal: qcom-spmi-temp-alarm: enable stage 2 shutdown when required
Date: Thu, 13 Feb 2025 13:04:00 -0800
Message-Id: <20250213210403.3396392-2-anjelique.melendez@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: d28oyB4RcRJQeQNpisAPbfO9ahanZHrS
X-Proofpoint-GUID: d28oyB4RcRJQeQNpisAPbfO9ahanZHrS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-13_08,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 mlxscore=0 bulkscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0
 impostorscore=0 malwarescore=0 mlxlogscore=999 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2501170000
 definitions=main-2502130148

From: David Collins <david.collins@oss.qualcomm.com>

Certain TEMP_ALARM GEN2 PMIC peripherals need over-temperature
stage 2 automatic PMIC partial shutdown to be enabled in order to
avoid repeated faults in the event of reaching over-temperature
stage 3.  Modify the stage 2 shutdown control logic to ensure that
stage 2 shutdown is enabled on all affected PMICs.  Read the
digital major and minor revision registers to identify these
PMICs.

Signed-off-by: David Collins <david.collins@oss.qualcomm.com>
Signed-off-by: Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>
---
 drivers/thermal/qcom/qcom-spmi-temp-alarm.c | 32 +++++++++++++++++++--
 1 file changed, 30 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/qcom/qcom-spmi-temp-alarm.c b/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
index c2d59cbfaea9..b2077ff9fe73 100644
--- a/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
+++ b/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
  * Copyright (c) 2011-2015, 2017, 2020, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2024, Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #include <linux/bitops.h>
@@ -16,6 +17,7 @@
 
 #include "../thermal_hwmon.h"
 
+#define QPNP_TM_REG_DIG_MINOR		0x00
 #define QPNP_TM_REG_DIG_MAJOR		0x01
 #define QPNP_TM_REG_TYPE		0x04
 #define QPNP_TM_REG_SUBTYPE		0x05
@@ -71,6 +73,7 @@ struct qpnp_tm_chip {
 	struct device			*dev;
 	struct thermal_zone_device	*tz_dev;
 	unsigned int			subtype;
+	unsigned int			dig_revision;
 	long				temp;
 	unsigned int			thresh;
 	unsigned int			stage;
@@ -78,6 +81,7 @@ struct qpnp_tm_chip {
 	/* protects .thresh, .stage and chip registers */
 	struct mutex			lock;
 	bool				initialized;
+	bool				require_s2_shutdown;
 
 	struct iio_channel		*adc;
 	const long			(*temp_map)[THRESH_COUNT][STAGE_COUNT];
@@ -255,7 +259,7 @@ static int qpnp_tm_update_critical_trip_temp(struct qpnp_tm_chip *chip,
 
 skip:
 	reg |= chip->thresh;
-	if (disable_s2_shutdown)
+	if (disable_s2_shutdown && !chip->require_s2_shutdown)
 		reg |= SHUTDOWN_CTRL1_OVERRIDE_S2;
 
 	return qpnp_tm_write(chip, QPNP_TM_REG_SHUTDOWN_CTRL1, reg);
@@ -350,7 +354,7 @@ static int qpnp_tm_probe(struct platform_device *pdev)
 {
 	struct qpnp_tm_chip *chip;
 	struct device_node *node;
-	u8 type, subtype, dig_major;
+	u8 type, subtype, dig_major, dig_minor;
 	u32 res;
 	int ret, irq;
 
@@ -403,6 +407,30 @@ static int qpnp_tm_probe(struct platform_device *pdev)
 		return dev_err_probe(&pdev->dev, ret,
 				     "could not read dig_major\n");
 
+	ret = qpnp_tm_read(chip, QPNP_TM_REG_DIG_MINOR, &dig_minor);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "could not read dig_minor\n");
+		return ret;
+	}
+
+	chip->dig_revision = (dig_major << 8) | dig_minor;
+
+	if (chip->subtype == QPNP_TM_SUBTYPE_GEN2) {
+		/*
+		 * Check if stage 2 automatic partial shutdown must remain
+		 * enabled to avoid potential repeated faults upon reaching
+		 * over-temperature stage 3.
+		 */
+		switch (chip->dig_revision) {
+		case 0x0001:
+		case 0x0002:
+		case 0x0100:
+		case 0x0101:
+			chip->require_s2_shutdown = true;
+			break;
+		}
+	}
+
 	if (type != QPNP_TM_TYPE || (subtype != QPNP_TM_SUBTYPE_GEN1
 				     && subtype != QPNP_TM_SUBTYPE_GEN2)) {
 		dev_err(&pdev->dev, "invalid type 0x%02x or subtype 0x%02x\n",
-- 
2.34.1


