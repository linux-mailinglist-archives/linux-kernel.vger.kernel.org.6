Return-Path: <linux-kernel+bounces-560382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F52DA60359
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 22:21:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67CC13A82BF
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 21:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF3DC1F4CB6;
	Thu, 13 Mar 2025 21:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Hy9mTsMI"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 673471F471D
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 21:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741900903; cv=none; b=e5g8TPm3EEUPeiZ9qXqPgfnv/S+T3w01FmFC5KIuguP8ya9ITfCpa24kboJUPLLsPBLWNd+AIWDO+n4cK9f2VqMpxTB8esojEARHAYVYsMe9CVJV5iFO/MuFkzLm1meSWJeG0Eoz5TdmSwyHGmcU1jF3FA6KZafNqRLtjUDq+gI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741900903; c=relaxed/simple;
	bh=bxwRGhp1n0pI0/lcXsC1uFENkA1yhmJSWsvPZhEto9M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=XpHXxtK6IXd+BT03DyGJzCZcpTekKOsdU9lLCLCwsK65qS0l95mzfkkUyk/YHOsnmRw18ZohJArmuL8/4Gmuq3bwRX4nC3iJEvYbAewzgHF/9XfC96lic6nZSnd4PY/J7oVhHVa7JhBc4JF8Z2IbB/MRPXvJV94V6eoATNY+ztw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Hy9mTsMI; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52DLGV8W028043
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 21:21:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=sc2tdTqGtA5fEOw5t3e1Qi
	cFcw5LIwEMfE0xdIoaMts=; b=Hy9mTsMI0ApadFr/gtOT8wGCpEQspH9O1Phqqk
	R6DlGp9a0t1vudbh2u9TlItieYDKOVY1YWuGm1dC6MItWi/CBIn6AogLvnjUlIl7
	5G0sZRtLVUKA6aSx1cjMN8oHVzOnAwShyHJQM7b7fChSKPXjxLpopukMDkbnx7Aj
	PB+DW2SuXtmGTD8MjstFbLOQQipOJbAxWIaWzz0+IlRApBGd4ajzk8xx/qObiWWT
	sLXp9o5ESfJ0okaswAtw4wNLtW2i6b367kAH9vwLW2q/k1/afUj6C/TnOTR2aRTm
	p+70npb03WJtt912BCAWb99L0BePBrMa/i216FczDmreOGwg==
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com [209.85.210.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45au2py61x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 21:21:40 +0000 (GMT)
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-72bbb1899b4so25608a34.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 14:21:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741900899; x=1742505699;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sc2tdTqGtA5fEOw5t3e1QicFcw5LIwEMfE0xdIoaMts=;
        b=Cj1AdHxmkHBpZnjaHzk4IrV37h9+yslE/aRiXPC3Sbumf7qiyaCvSxEixIGh8F7F39
         CDIPPAS3dM0PHMuSvtKSwPyKnnfdKCwhM8LrCwTuOxsO31ujHIADxGkHU6GaRwpH/qJ3
         Kd95FFZlJrnU2Rgo6pHLDJp1IqUG4yliuEYF62C+y1dG/Zt73hk4yaBftkNmCvUO+s1N
         +MYyywGhNdMHd+qEGhmRLse7K9955xL12JkLHSWEMI4s5B4l+QJCT3sJseyr/irDKOJQ
         OsbWNqbz+X2JgisTNkTh0wXstdxBIC4xU1XAXbp9EJh6CjPx2QytVl7qrRLDZW09AF/K
         fjRw==
X-Forwarded-Encrypted: i=1; AJvYcCVLlT9BbCfAErNJjAZvyowUuSRhBcMgj45rJ7mwv2R5BV0cgAJi39A20tZT44bQN5m6TNFAnwQT6L7/87E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyen9KH+RQKXTqDxE+P7AlFV7mcK3+FTrpsE3pGw6Q6LD+GhIR4
	al2OyMYH73hUxeyRbqy/ayHIQMekBDDrPra4fLyqhyI+pH3ZLQ0Fd4m0khENwLWE4WZZggNtJav
	6l7J5k7+PIoO1Xc8dzZdijdHjTv9y5wAwXwp2KZNDAqJt8q5EOYYCR2HQAKMPXDE=
X-Gm-Gg: ASbGncuVZ4vpGh7P4mmtq9bv7wjRJ5gDC7hwyB1UhQHz51IK1/RhTer6zwQhc9fsQp9
	r2OB9LwSxAcd4YWHKxSC8gIlBAekWjqWTRYC1eXbWyFbBCi65YMSwqESzm5J+DBFRCGiMaLDpG9
	KNDYv7S3QZPcvxBQB0HOwDMR//bZl1/V9afnAfk39a0RASudRq6I/XN9ZFT8c3JTQ95YRfjxuBx
	pL8OjbF/+8SSJ1tFwWrnTlSAiU9uVQL+0UNhLiQD6dyg+Nzj/q4ftQHVhfVksfLWaDcBKSONKiz
	+we/l4j9eXPNlONQU6OXq/PH85Rj21mcioUbZnuz9JcmHvYjKRyvHrmePg40uKmCe5LzoaZ26th
	4EaOPQXBgv+6VkwM=
X-Received: by 2002:a05:6830:4905:b0:72a:1625:ef11 with SMTP id 46e09a7af769-72b9b593d8cmr7658943a34.27.1741900899382;
        Thu, 13 Mar 2025 14:21:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFSJfSSomTC3SCdbcrgeOpL44R+cUJ/sgfFjrWaSF6qXtM2EgPsMKfh4s/9jEulvEPGOITeDg==
X-Received: by 2002:a05:6830:4905:b0:72a:1625:ef11 with SMTP id 46e09a7af769-72b9b593d8cmr7658927a34.27.1741900899001;
        Thu, 13 Mar 2025 14:21:39 -0700 (PDT)
Received: from [192.168.86.65] (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2c670f86a17sm478881fac.6.2025.03.13.14.21.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 14:21:38 -0700 (PDT)
From: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
Date: Thu, 13 Mar 2025 14:27:27 -0700
Subject: [PATCH] pinctrl: qcom: tlmm-test: Validate irq_enable delivers
 edge irqs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250313-tlmm-test-disabled-irq-delivered-v1-1-f0be903732ac@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAL5N02cC/x3NQQ6CMBBG4auQWTtJCxKUqxgXrf2VSQroTENMC
 He3cflt3tvJoAKjsdlJsYnJulT4U0OPKSwvsKRqal3bu853XPI8c4EVTmIhZiQW/XBClg1aFdz
 QX6L353gF1cxb8ZTvf3G7H8cPwud4nnIAAAA=
X-Change-ID: 20250313-tlmm-test-disabled-irq-delivered-a0758b114b9e
To: Bjorn Andersson <andersson@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Cc: Douglas Anderson <dianders@chromium.org>,
        Stephan Gerhold <stephan.gerhold@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2379;
 i=bjorn.andersson@oss.qualcomm.com; h=from:subject:message-id;
 bh=bxwRGhp1n0pI0/lcXsC1uFENkA1yhmJSWsvPZhEto9M=;
 b=owEBgwJ8/ZANAwAIAQsfOT8Nma3FAcsmYgBn003G2C9slR48Upk3nATcOyK7ugL3Dasv72Zrc
 Ggcd/i3JqKJAkkEAAEIADMWIQQF3gPMXzXqTwlm1SULHzk/DZmtxQUCZ9NNxhUcYW5kZXJzc29u
 QGtlcm5lbC5vcmcACgkQCx85Pw2ZrcVLTA/8CBpkKNPjbvMqFrVl/S2Oogv2nA49C9YOM9prNGh
 dhu9KoK73LDA7Oxn7nAGNigeEgvbpYq0wkT4c4ZYn+kF0zDiw+NwzNL7vXJOGk9YfFNdz+Z1ceo
 Klicq4sQM+yo2tOrThul7pxbNOITiRg9dUeA6vJDZr44nf3+Ej82x1EFSKGDJLEgfOGbeE0gL9L
 ClZhez2hmFXWrUWOPQzt0+vKOF3+B2yhgYswaeOogtT7b8LoWPff8mRrpWvaUH0Nw2tgwUCI+Cd
 4che8RE60va7HiY41JWhn2uUzkICEqqNyHvhLWmPcp1ba3Ur0u6XDLdL1OTW2R1/IYL9QM3/qEI
 4nN8JlVdBwfJHYUVylQL+3Jclx1F1ECBKKTX6Ur361ojmLJQkQUWzglrLHS7QJz62Lv+H94T486
 8ymFVLKrIJaM6ttQ054D96IL+S219QoIZ4D2+t91yPQj/PHe8bRl2wpceOggjpiOmzTxu31/7rd
 oMIZ+twN7dbC5JvcNXt9TKf+6Fo4ZSvFhyF0qq5m9+A1tGtvgMmIRwVNxYR8ZeyAY6Vs+a5duh2
 Zf5bnVC8XYYomIOKJUeLv818BH2Sf1Zif5fpz7V0VSGhCzbKuAEVCnMcsyltIPg7+9pueBV/wMP
 pezNPdwuPWymGDtyL00dbTTfrtVXiUMlYMjJclTxOSCY=
X-Developer-Key: i=bjorn.andersson@oss.qualcomm.com; a=openpgp;
 fpr=05DE03CC5F35EA4F0966D5250B1F393F0D99ADC5
X-Authority-Analysis: v=2.4 cv=P506hjAu c=1 sm=1 tr=0 ts=67d34c64 cx=c_pps a=z9lCQkyTxNhZyzAvolXo/A==:117 a=DaeiM5VmU20ml6RIjrOvYw==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=EUspDBNiAAAA:8 a=qPeax27BKI-lfaCsB2gA:9 a=QEXdDO2ut3YA:10
 a=EyFUmsFV_t8cxB2kMr4A:22
X-Proofpoint-GUID: AvsT7LygVfngTiptmtFljuftVGk0s2aD
X-Proofpoint-ORIG-GUID: AvsT7LygVfngTiptmtFljuftVGk0s2aD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-13_10,2025-03-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 mlxscore=0 spamscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 suspectscore=0 malwarescore=0 mlxlogscore=999 lowpriorityscore=0
 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503130164

In commit 'cf9d052aa600 ("pinctrl: qcom: Don't clear pending interrupts
when enabling")' Doug establishes an expectation that edge interrupts
occurring while an interrupt is disabled should be delivered once the
interrupt is enabled again.

Implement a test to validate that this is the case.

Signed-off-by: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
---
 drivers/pinctrl/qcom/tlmm-test.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/drivers/pinctrl/qcom/tlmm-test.c b/drivers/pinctrl/qcom/tlmm-test.c
index 9c31798b3c08b59ba9a77454a297ac6630cf829f..fd02bf3a76cbccd290735f77f19dfb26730be679 100644
--- a/drivers/pinctrl/qcom/tlmm-test.c
+++ b/drivers/pinctrl/qcom/tlmm-test.c
@@ -506,6 +506,42 @@ static void tlmm_test_thread_falling_in_handler(struct kunit *test)
 	KUNIT_ASSERT_EQ(test, atomic_read(&priv->thread_count), 10);
 }
 
+/*
+ * Validate that edge interrupts occurring while irq is disabled is delivered
+ * once the interrupt is reenabled.
+ */
+static void tlmm_test_rising_while_disabled(struct kunit *test)
+{
+	struct tlmm_test_priv *priv = test->priv;
+	unsigned int after_edge;
+	unsigned int before_edge;
+
+	priv->intr_op = TLMM_TEST_COUNT;
+	atomic_set(&priv->thread_op_remain, 10);
+
+	tlmm_output_low();
+
+	tlmm_test_request_hard_irq(test, IRQF_TRIGGER_RISING);
+	msleep(20);
+
+	disable_irq(tlmm_suite.irq);
+	before_edge = atomic_read(&priv->intr_count);
+
+	tlmm_output_high();
+	msleep(20);
+	after_edge = atomic_read(&priv->intr_count);
+
+	msleep(20);
+	enable_irq(tlmm_suite.irq);
+	msleep(20);
+
+	free_irq(tlmm_suite.irq, priv);
+
+	KUNIT_ASSERT_EQ(test, before_edge, 0);
+	KUNIT_ASSERT_EQ(test, after_edge, 0);
+	KUNIT_ASSERT_EQ(test, atomic_read(&priv->intr_count), 1);
+}
+
 static int tlmm_test_init(struct kunit *test)
 {
 	struct tlmm_test_priv *priv;
@@ -609,6 +645,7 @@ static struct kunit_case tlmm_test_cases[] = {
 	KUNIT_CASE(tlmm_test_thread_low),
 	KUNIT_CASE(tlmm_test_thread_rising_in_handler),
 	KUNIT_CASE(tlmm_test_thread_falling_in_handler),
+	KUNIT_CASE(tlmm_test_rising_while_disabled),
 	{}
 };
 

---
base-commit: 9fbcd7b32bf7c0a5bda0f22c25df29d00a872017
change-id: 20250313-tlmm-test-disabled-irq-delivered-a0758b114b9e

Best regards,
-- 
Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>


