Return-Path: <linux-kernel+bounces-364907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C1AE99DAE7
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 02:53:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 760281F231BB
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 00:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9784F7CF16;
	Tue, 15 Oct 2024 00:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marek.ca header.i=@marek.ca header.b="UqGOUIkB"
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A3AD482DD
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 00:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728953606; cv=none; b=niQbnZmmQ2edCUFFOH8ITXRFtv4g1m5/gqkbKQAieN/wkLjNbesrpL4E6S+vKUZXy1Sjp4QLbUBXl1PkWvmlFP2CTCVk/mxvgd3MLJHcrid4Wwaq5ZJb7o90QNzhc5RCn/yEHq7vj2fxR2/+7rvvBlFJMwcZ+wVu/EE1htBdROw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728953606; c=relaxed/simple;
	bh=M9pSr77YpiD2gyGMSu3oZBYC1P5oFRrFGy32m9f1XkQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bPYStYTa6N4/vReo2EidHXOyZqycMN33eRHwkuwh0IBOQS3THMG3N/7+01b3SdzJlJcrJFfZXO92JObDDJe1z5ZRHQmQ6vJMDFB/FjAmGWBzFoZzrVMfy68t957TEzsEsc1chjh1Fq8tsuEePm+fOEYQMjUNpIj5zL5YNQOR8vM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marek.ca; spf=pass smtp.mailfrom=marek.ca; dkim=pass (2048-bit key) header.d=marek.ca header.i=@marek.ca header.b=UqGOUIkB; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marek.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marek.ca
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-50ce2aa412dso1478927e0c.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 17:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek.ca; s=google; t=1728953603; x=1729558403; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IWfViXixCZNOpw64qnGzSzSKYZcS6fQ7/2LaWhKIPDs=;
        b=UqGOUIkBG3Z48e8BJhFUf1c0a/75rpKX5uBsxk8Rv6khjXaSJOw1K8QnFIHtm5opdn
         czYTcKkhL3ormypt1L8TJJDamMx3/VX99niZVxAkTCgPlpqe8YQbv/QeBeWJQcHz4ZYX
         YJyZUj3BdBGwnWG/Y7Dt5iwJMsGOc9kmFGLZm3Dx1jwjXlNTu9cZDkdq7b9et4OEsgal
         fX6DtHsUurV0hQcOANmEpFLlc2Xj1mc8sTusUI1GbfELgLuZXnmeM33ZzEcvrzisG80B
         M1xCcvtQe2KFYM+12cm1NCPFHNfW/s1hvSbNeaYDBzp2aZ+CN4FUexV37cAHyooOAcF1
         19cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728953603; x=1729558403;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IWfViXixCZNOpw64qnGzSzSKYZcS6fQ7/2LaWhKIPDs=;
        b=hGpo30AGUrBS0/Y4JNk5NMW4c4Xf8AwxxQY4d4BhHJTmeqBBnGs+smATBWDl/e9e+c
         xDz+Z3xR7aSPXcjbfaBeSztfALElIhXqrk6mbQKCcMxMO52XPnUK7a395/vqzQJQ42lm
         gmdqN6ejnUxZoW+3NcqE/XtaR1fbA6UXxLuIzJLI41FucXYaaiLFRNlQQZPvrxsgwxwR
         zA9AwkLp4zCsMFe2SM39yzVnAVSb7xZvnNNkvuXRwo/1t4+WQkB/oQceEhG90SZI70tL
         QfKAXTJ5TAnIkSG8CXMa1LuvuaU1YKGDvJrazQPK31zhJeHrb2lHZ4JK6VfK0N+I2TZ0
         d+Iw==
X-Forwarded-Encrypted: i=1; AJvYcCXMd56hetDGni44oM8A21xOohBmkkGzEzKn8sjyLrEaRmLd3dp5zPBzgdYk/lCBYRNZv6WA6zt5eTwSVBc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDipNsqliqbBalh1U2FFiPutXil73dnPwFBrh4nt0NscoXG2Eq
	8yYAQ4+wJI3GTWeTcMuNj7GYcwyRZuX4fOvhcaA86VqVkBHWLMZ2xLzSqdZzVjo=
X-Google-Smtp-Source: AGHT+IGvbaoUJ4CRlMi5XS2flUCfSbsR4fRBcjNweqxMEcN4bKyqR12UxbpDWubEBGNcicnOeX9jhw==
X-Received: by 2002:a05:6122:268f:b0:50d:3ec1:1546 with SMTP id 71dfb90a1353d-50d3ec1165emr5612872e0c.4.1728953603262;
        Mon, 14 Oct 2024 17:53:23 -0700 (PDT)
Received: from localhost.localdomain (modemcable125.110-19-135.mc.videotron.ca. [135.19.110.125])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cc22910f0bsm1213956d6.16.2024.10.14.17.53.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 17:53:22 -0700 (PDT)
From: Jonathan Marek <jonathan@marek.ca>
To: linux-arm-msm@vger.kernel.org
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
	linux-rtc@vger.kernel.org (open list:REAL TIME CLOCK (RTC) SUBSYSTEM),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 1/5] rtc: pm8xxx: implement qcom,no-alarm flag for non-HLOS owned alarm
Date: Mon, 14 Oct 2024 20:47:26 -0400
Message-ID: <20241015004945.3676-2-jonathan@marek.ca>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20241015004945.3676-1-jonathan@marek.ca>
References: <20241015004945.3676-1-jonathan@marek.ca>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Qualcomm x1e80100 firmware sets the ownership of the RTC alarm to ADSP.
Thus writing to RTC alarm registers and receiving alarm interrupts is not
possible.

Add a qcom,no-alarm flag to support RTC on this platform.

Signed-off-by: Jonathan Marek <jonathan@marek.ca>
---
 drivers/rtc/rtc-pm8xxx.c | 44 +++++++++++++++++++++++++++-------------
 1 file changed, 30 insertions(+), 14 deletions(-)

diff --git a/drivers/rtc/rtc-pm8xxx.c b/drivers/rtc/rtc-pm8xxx.c
index c32fba550c8e0..1e78939625622 100644
--- a/drivers/rtc/rtc-pm8xxx.c
+++ b/drivers/rtc/rtc-pm8xxx.c
@@ -61,6 +61,7 @@ struct pm8xxx_rtc {
 	struct rtc_device *rtc;
 	struct regmap *regmap;
 	bool allow_set_time;
+	bool no_alarm;
 	int alarm_irq;
 	const struct pm8xxx_rtc_regs *regs;
 	struct device *dev;
@@ -473,9 +474,14 @@ static int pm8xxx_rtc_probe(struct platform_device *pdev)
 	if (!rtc_dd->regmap)
 		return -ENXIO;
 
-	rtc_dd->alarm_irq = platform_get_irq(pdev, 0);
-	if (rtc_dd->alarm_irq < 0)
-		return -ENXIO;
+	rtc_dd->no_alarm = of_property_read_bool(pdev->dev.of_node,
+						 "qcom,no-alarm");
+
+	if (!rtc_dd->no_alarm) {
+		rtc_dd->alarm_irq = platform_get_irq(pdev, 0);
+		if (rtc_dd->alarm_irq < 0)
+			return -ENXIO;
+	}
 
 	rtc_dd->allow_set_time = of_property_read_bool(pdev->dev.of_node,
 						      "allow-set-time");
@@ -503,7 +509,8 @@ static int pm8xxx_rtc_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, rtc_dd);
 
-	device_init_wakeup(&pdev->dev, 1);
+	if (!rtc_dd->no_alarm)
+		device_init_wakeup(&pdev->dev, 1);
 
 	rtc_dd->rtc = devm_rtc_allocate_device(&pdev->dev);
 	if (IS_ERR(rtc_dd->rtc))
@@ -512,27 +519,36 @@ static int pm8xxx_rtc_probe(struct platform_device *pdev)
 	rtc_dd->rtc->ops = &pm8xxx_rtc_ops;
 	rtc_dd->rtc->range_max = U32_MAX;
 
-	rc = devm_request_any_context_irq(&pdev->dev, rtc_dd->alarm_irq,
-					  pm8xxx_alarm_trigger,
-					  IRQF_TRIGGER_RISING,
-					  "pm8xxx_rtc_alarm", rtc_dd);
-	if (rc < 0)
-		return rc;
+	if (!rtc_dd->no_alarm) {
+		rc = devm_request_any_context_irq(&pdev->dev, rtc_dd->alarm_irq,
+						  pm8xxx_alarm_trigger,
+						  IRQF_TRIGGER_RISING,
+						  "pm8xxx_rtc_alarm", rtc_dd);
+		if (rc < 0)
+			return rc;
+	}
 
 	rc = devm_rtc_register_device(rtc_dd->rtc);
 	if (rc)
 		return rc;
 
-	rc = dev_pm_set_wake_irq(&pdev->dev, rtc_dd->alarm_irq);
-	if (rc)
-		return rc;
+	if (!rtc_dd->no_alarm) {
+		rc = dev_pm_set_wake_irq(&pdev->dev, rtc_dd->alarm_irq);
+		if (rc)
+			return rc;
+	} else {
+		clear_bit(RTC_FEATURE_ALARM, rtc_dd->rtc->features);
+	}
 
 	return 0;
 }
 
 static void pm8xxx_remove(struct platform_device *pdev)
 {
-	dev_pm_clear_wake_irq(&pdev->dev);
+	struct pm8xxx_rtc *rtc_dd = platform_get_drvdata(pdev);
+
+	if (!rtc_dd->no_alarm)
+		dev_pm_clear_wake_irq(&pdev->dev);
 }
 
 static struct platform_driver pm8xxx_rtc_driver = {
-- 
2.45.1


