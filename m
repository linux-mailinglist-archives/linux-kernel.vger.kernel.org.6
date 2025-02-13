Return-Path: <linux-kernel+bounces-512103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DB01A3340E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 01:35:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 066F1188A77E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 00:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C97CE4DA04;
	Thu, 13 Feb 2025 00:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hblWFaLz"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA42381AA
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 00:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739406940; cv=none; b=NvAc9C3xNM2HSsSNDTwdyrtGerrJCs9Rl+ChK8HQpIUo+aFrNlk4t9KJPGI3EEVrbew5O38jqjSYSCykODnHFOAOjerDaUJeTi+bxKbfh9H6YNAQYvyd9pFHRwe1Rdc+106Am6zsYNobt/33IwzJO3DZlOjehgLbMPdoDsEC0nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739406940; c=relaxed/simple;
	bh=EOVymAULE6kLF8YeY35yDIjWEcbIP+yZoW/WG8TfQT0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NreWnYVCf58ImKiMT26bGYAAZ1/Ol2PukEMXaMganSMSTNXHOfqDSlMI2eYGNBpPY6xpMHdD9hSYUNB98MK7df6VncrfIc5+RztrOPpG3S5fqc0pWSUMIHTB+9MlQiSukNU2iMp0GL0fjJ9Yu+e0XdbPoQGa50l+HjwrhHNGhU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hblWFaLz; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51CCq7Ax010521
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 00:35:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=gTyUuYhYRTX4j8dhX9yTaQ0IP/am6Xw0dpr
	kTVdPOno=; b=hblWFaLzCAap11G7lGMVQVreTDiyHWNp6PjQPp+bZyaW2r/pduf
	RMj+DkKktypVlq/7zOxsgfaNriy8MHjjC/YkN7AdEwR2wmtA/oXF1vvpe/50JHQp
	kYr2jYlTfklOIrfSUoucM0mjSpnfDxxrSG6dOqXxMVzH/2ep9HSR6YI8peMQe/vk
	2hebEarQSwDz5B0ewdeaBk9ZmlVcfWLd4gy+0oVxgjgdrUIKHq9suGz5vlQ8ViZ+
	nK44+Le14bZOTi7hgf58ui3+n6F65eAJxOYVyJnORA4lkGMfoByzGhH8zdVxDK0Y
	Xk4RZMWASQxvxdTGBAIkO157jYiFVr/vvlQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44qcs5hfbr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 00:35:37 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-220c86e46ebso4081535ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 16:35:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739406935; x=1740011735;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gTyUuYhYRTX4j8dhX9yTaQ0IP/am6Xw0dprkTVdPOno=;
        b=fNat0CDp1O7Hh7DoGPD+I7yQw5S6fva2yDTXDT31D8ZGU3E75RltQnEXfkXfbwdrwd
         i0JOQGz5yUNe0x+9Hk2455RK8UhUJx4ddQ8qo10s5dgXjCC2Fpj+9bzgtrDdW2ZrQDfE
         wJRS65zORr/ilejM1cBioZ6ZKaqSuZWkgzoJPZdrCEDcXjs6cf/Fb6+8IAIii0Lqh6Jq
         /7OY3MIOdEZlKzRX2LNmon/AgCNJmOFY/eRSf8o6W8Hm6sTjb5tZWvncPJNK5wDECPbm
         zrWRoFO+L7Xc+h+xXmocbsH67HVLsOf+mCIP6d/+kPy0IQ16FYR5jmGgVw1iVwr1DZ28
         6XjQ==
X-Forwarded-Encrypted: i=1; AJvYcCVTUfJiUqzFjI9X/8oo9V8cDxqT6eijD2dA8BFETioWz5qUrbxnDd+e3yCqcXsfAuUkJITtTJJJR5CD+mE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2cy66AE/wsKED5eXpyJNLPjAFtcB6KRWl6j7/eEPpIGRKxbGW
	NmN1Zo3L+JKbrA8I0YjXmQGcIdccSNGc5Oi3yA/MKmvNUn/RclW51SY3nK3ohZOcTsPKvgYee7g
	MhIK8K2KtYMDIENDi/jSYoudat/r/DYeRHec3BL70paRCCjPeGh9LVflu1OOUNKw=
X-Gm-Gg: ASbGnctqn8X3XP4X2fPdpemmEPxFfgxS76x1xX4SHB4BB46PSMpkcz7lDLa9VnX/Ua0
	XcB5V7Dz1bHqYV6QmwEdcxQ8CaOTDvvTDarp72JCfJukuijZPSvLJX2zaLgsFJJVOx0EKuyeCYP
	ssM3ttXB3shx1n195OwmOqtRL3lZ4L5ReXGKEk9NyGrZzTc9X96cOCQDxHFbAFLNyBENHrjY55e
	yT+Jx9H1aWHjHo4hA5ABqvoGmVBa8bMLiGR60X1vCJNz2bSCJx7MlKUb8J1AwFYoRgsCXKuqzcg
	rfZEvbQMfWNdSz6bzSomNHz/1ZsrQDpCSEQodiFWwZgEYToA6j6aCou9qVWq69BEoDtr
X-Received: by 2002:a05:6a21:3291:b0:1ee:3b8e:344e with SMTP id adf61e73a8af0-1ee5c8228b0mr10017700637.40.1739406935528;
        Wed, 12 Feb 2025 16:35:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGdOSmyuS1/Z18GxXR1yavoEapUcckTz6EmedzNfNydunkLDjxX+oWubtWLLVz+uL9PsDxlSg==
X-Received: by 2002:a05:6a21:3291:b0:1ee:3b8e:344e with SMTP id adf61e73a8af0-1ee5c8228b0mr10017655637.40.1739406935153;
        Wed, 12 Feb 2025 16:35:35 -0800 (PST)
Received: from hu-amelende-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7324254627dsm61269b3a.3.2025.02.12.16.35.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 16:35:34 -0800 (PST)
From: Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>
To: lee@kernel.org, pavel@kernel.org, andersson@kernel.org,
        krzysztof.kozlowski@linaro.org
Cc: morf3089@gmail.com, u.kleine-koenig@pengutronix.de,
        marijn.suijten@somainline.org, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Zejiong Huang <zejiongh@qti.qualcomm.com>
Subject: [PATCH] leds: rgb: leds-qcom-lpg: Add support for 6-bit PWM resolution
Date: Wed, 12 Feb 2025 16:35:33 -0800
Message-Id: <20250213003533.1684131-1-anjelique.melendez@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: P9aT0Or9Ha5Z75h9vr058oPS1-IwjIZD
X-Proofpoint-GUID: P9aT0Or9Ha5Z75h9vr058oPS1-IwjIZD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-12_08,2025-02-11_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 mlxlogscore=999 phishscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0
 adultscore=0 clxscore=1011 mlxscore=0 priorityscore=1501 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2501170000
 definitions=main-2502130002

Currently, driver only allows for PWM modules to use 9-bit resolution.
However, PWM modules can support 6-bit and 9-bit resolution. Add support
for 6-bit resolution.

Suggested-by: Zejiong Huang <zejiongh@qti.qualcomm.com>
Signed-off-by: Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>
---
 drivers/leds/rgb/leds-qcom-lpg.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/leds/rgb/leds-qcom-lpg.c b/drivers/leds/rgb/leds-qcom-lpg.c
index f3c9ef2bfa57..4e5c56ded1f0 100644
--- a/drivers/leds/rgb/leds-qcom-lpg.c
+++ b/drivers/leds/rgb/leds-qcom-lpg.c
@@ -24,6 +24,7 @@
 #define LPG_PATTERN_CONFIG_REG	0x40
 #define LPG_SIZE_CLK_REG	0x41
 #define  PWM_CLK_SELECT_MASK	GENMASK(1, 0)
+#define  PWM_SIZE_SELECT_MASK	BIT(2)
 #define  PWM_CLK_SELECT_HI_RES_MASK	GENMASK(2, 0)
 #define  PWM_SIZE_HI_RES_MASK	GENMASK(6, 4)
 #define LPG_PREDIV_CLK_REG	0x42
@@ -412,8 +413,8 @@ static int lpg_lut_sync(struct lpg *lpg, unsigned int mask)
 static const unsigned int lpg_clk_rates[] = {0, 1024, 32768, 19200000};
 static const unsigned int lpg_clk_rates_hi_res[] = {0, 1024, 32768, 19200000, 76800000};
 static const unsigned int lpg_pre_divs[] = {1, 3, 5, 6};
-static const unsigned int lpg_pwm_resolution[] =  {9};
-static const unsigned int lpg_pwm_resolution_hi_res[] =  {8, 9, 10, 11, 12, 13, 14, 15};
+static const unsigned int lpg_pwm_resolution[] = {6, 9};
+static const unsigned int lpg_pwm_resolution_hi_res[] = {8, 9, 10, 11, 12, 13, 14, 15};
 
 static int lpg_calc_freq(struct lpg_channel *chan, uint64_t period)
 {
@@ -436,12 +437,12 @@ static int lpg_calc_freq(struct lpg_channel *chan, uint64_t period)
 	 * period = --------------------------
 	 *                   refclk
 	 *
-	 * Resolution = 2^9 bits for PWM or
+	 * Resolution = 2^{6 or 9} bits for PWM or
 	 *              2^{8, 9, 10, 11, 12, 13, 14, 15} bits for high resolution PWM
 	 * pre_div = {1, 3, 5, 6} and
 	 * M = [0..7].
 	 *
-	 * This allows for periods between 27uS and 384s for PWM channels and periods between
+	 * This allows for periods between 3uS and 384s for PWM channels and periods between
 	 * 3uS and 24576s for high resolution PWMs.
 	 * The PWM framework wants a period of equal or lower length than requested,
 	 * reject anything below minimum period.
@@ -558,7 +559,7 @@ static void lpg_apply_freq(struct lpg_channel *chan)
 		val |= GENMASK(5, 4);
 		break;
 	case LPG_SUBTYPE_PWM:
-		val |= BIT(2);
+		val |= FIELD_PREP(PWM_SIZE_SELECT_MASK, chan->pwm_resolution_sel);
 		break;
 	case LPG_SUBTYPE_HI_RES_PWM:
 		val |= FIELD_PREP(PWM_SIZE_HI_RES_MASK, chan->pwm_resolution_sel);
@@ -1276,7 +1277,7 @@ static int lpg_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
 		resolution = lpg_pwm_resolution_hi_res[FIELD_GET(PWM_SIZE_HI_RES_MASK, val)];
 	} else {
 		refclk = lpg_clk_rates[FIELD_GET(PWM_CLK_SELECT_MASK, val)];
-		resolution = 9;
+		resolution = lpg_pwm_resolution[FIELD_GET(PWM_SIZE_SELECT_MASK, val)];
 	}
 
 	if (refclk) {
-- 
2.34.1


