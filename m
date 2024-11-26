Return-Path: <linux-kernel+bounces-422908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 625F59D9FCA
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 00:45:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7EB8B23B62
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 23:45:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C60D1E04AD;
	Tue, 26 Nov 2024 23:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="f6AKDNje"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13CE61DFE36
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 23:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732664677; cv=none; b=UPQx9aP3TfHBgILB+as9BdNpJfhAEa5Q0fv20gY2OEtTfkThBiGCOY6yvUpknfggifdac7JgGIxElaLqyMNWZLKtxfXcdEfDEjjQKCh0Nq1iG+8odSKlrGf4WDeYbc87KDONSEQEd8PFmk4Hp82TOXVFo6kl0K+VUidHjDP29RE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732664677; c=relaxed/simple;
	bh=9DcDIgyiPEQQcegeEN1oWtNvqOat5t+dI1L4z5w/npc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jXcH1ZRzh+j5M/lB7YDuK64DHXjks9lDfHmY3tCWZyqxffM1AbLHd/vBd22amWqZ6KXabdKdcTn+OukNoYGJ45tdsJkAM6Wd/CVqXHrd7l0EZSutVEVcBcFWITRtgLJkOPdsXlIkZLcJ+9MLzTv1a/o/KAQuvJ/fUsejlBSzXV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=f6AKDNje; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-382442b7d9aso4704286f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 15:44:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732664674; x=1733269474; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6CvPt8QMHcz942A3Oqz3/N9DPxj3tCNq+0xhS6ngyuw=;
        b=f6AKDNjeC/ddGcJ/pTrP7RqmpxnNaWdSofMYY3TPXNbF6hvkg2of2rKa+C/GSW6vjv
         1RpNC3zm24hAhgBtMYpuS5yw1/4wgsw8q6cLrEdBu6mfyWb+Dw60om71rEIDXWRX3tKl
         YTOc0PLpO/QnFAe0jXk5kEjZqzd3RZXEWS+vb4egTeOurBFnMD+FNO0XRr06vFHH73Y/
         2Q+a2bBF+EEVOP0Oh+hHKUx6HxDwWA8mCcGoUCyhbAPfIYBjWmjr6kFViBQmCEXoFoO0
         qMMMoJf+hYMoA0cS9BaV6mYied2HpNCRbEm2e6FQwYoFytnngRksEp2aPwoX/VSnGkeO
         lGzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732664674; x=1733269474;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6CvPt8QMHcz942A3Oqz3/N9DPxj3tCNq+0xhS6ngyuw=;
        b=cszC4n++UzPBtcSH2rYnobok7THnqqdUf5F44HnxxVxpefGlXEzfgZs7DRds0+F5z0
         p4Er7SlHvLw/i4OoEI9EDN+nnbW/ThgU++JqcuTz0ndLoI4zak62vd6sG5PC9DPBeQ2Y
         6R6VWwVHsnNlnn0wCESrYcOkNkgVuUxOQ//MzayqztQVwoX+8HrNsL4T1FMuaO6rjjkh
         E8sCDBmGIPrfLNd7lYVbv60Ts//0seyuBl/pQ0xZ48bEu/mm8qFjEk8FZ/4skvZAhpTv
         YE/Mjpk8I2VqN0Z5XcxqUkAQsY8rbUQuD7L/Nebjx55CZLOR1B9v4+cPr5XGiFniOXPI
         n4Wg==
X-Forwarded-Encrypted: i=1; AJvYcCW1mboYEMPchsiFaqGj0bAyOhnbLidZBcA3BMW3mAv4AvG3PgKoLaLkS6D6P7yWKf58RdteMSYaJSbPbSM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZZrqbKTfoHf1DnYFnT1qgpp4okDZ37p03GUvBKXaZ5B4JPqb8
	dslo0OahWjWOhUrMf42PNxvtWaEdthXlwmDV6deGEohHXCLr4uYxTF1c1gDwIIc=
X-Gm-Gg: ASbGncvxHIrGuje+QjwwZFNNZ+biJMXPtgrHfT4gUN4l/LJmn9You6J3lIERz2OiHOR
	MwPoDUyWh4/kqNfJ8Anc5Wd+o4clAY2vOQbfgbjtXnBMQWw8Y9JfBNHGuZmepe4+nyDyMbZCyj4
	Tp4z6BLbRpAvAlvNdEDgTQ/1xaEeq7sHCU7E5Ai1gQmkLp2Y9Loaoqm3wNSd4EfOSvtrK3ljFX/
	9XzjH6ayMhPlQ3Wj1autFHdA9JUICihva1PM/s1N0Jdr6P6IOo648OLYWo=
X-Google-Smtp-Source: AGHT+IE+Oglm7E2t7Ut5iZpBl+SAvEqAXWb/9nqHNfrjK8E3TwWYDWN8olld0Ah29+gOrPXAKM3mBQ==
X-Received: by 2002:a5d:5888:0:b0:382:4378:4652 with SMTP id ffacd0b85a97d-385c6edd47bmr520166f8f.45.1732664674376;
        Tue, 26 Nov 2024 15:44:34 -0800 (PST)
Received: from [127.0.1.1] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3825fafe338sm14482899f8f.33.2024.11.26.15.44.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2024 15:44:34 -0800 (PST)
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Date: Tue, 26 Nov 2024 23:44:28 +0000
Subject: [PATCH v3 2/3] clk: qcom: common: Add support for power-domain
 attachment
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241126-b4-linux-next-24-11-18-clock-multiple-power-domains-v3-2-836dad33521a@linaro.org>
References: <20241126-b4-linux-next-24-11-18-clock-multiple-power-domains-v3-0-836dad33521a@linaro.org>
In-Reply-To: <20241126-b4-linux-next-24-11-18-clock-multiple-power-domains-v3-0-836dad33521a@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Bryan O'Donoghue <bryan.odonoghue@linaro.org>
X-Mailer: b4 0.15-dev-355e8

Right now we support one power-domain per clock controller.
These single power-domains are switched on by the driver platform logic.

However when we have multiple power-domains attached to a clock-controller
that list of power-domains must be handled outside of driver platform
logic.

Use devm_pm_domain_attach_list() to automatically hook the list of given
power-domains in the dtsi for the clock-controller driver.

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/clk/qcom/common.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/clk/qcom/common.c b/drivers/clk/qcom/common.c
index 33cc1f73c69d1f875a193aea0552902268dc8716..7727295c57c8f6672d46d2380e1ff5ec2ac68d42 100644
--- a/drivers/clk/qcom/common.c
+++ b/drivers/clk/qcom/common.c
@@ -22,6 +22,7 @@ struct qcom_cc {
 	struct qcom_reset_controller reset;
 	struct clk_regmap **rclks;
 	size_t num_rclks;
+	struct dev_pm_domain_list *pd_list;
 };
 
 const
@@ -283,6 +284,21 @@ static int qcom_cc_icc_register(struct device *dev,
 						     desc->num_icc_hws, icd);
 }
 
+static int qcom_cc_pds_attach(struct device *dev, struct qcom_cc *cc)
+{
+	struct dev_pm_domain_attach_data pd_data = {
+		.pd_names = 0,
+		.num_pd_names = 0,
+	};
+	int ret;
+
+	ret = devm_pm_domain_attach_list(dev, &pd_data, &cc->pd_list);
+	if (ret < 0 && ret != -EEXIST)
+		return ret;
+
+	return 0;
+}
+
 int qcom_cc_really_probe(struct device *dev,
 			 const struct qcom_cc_desc *desc, struct regmap *regmap)
 {
@@ -299,6 +315,10 @@ int qcom_cc_really_probe(struct device *dev,
 	if (!cc)
 		return -ENOMEM;
 
+	ret = qcom_cc_pds_attach(dev, cc);
+	if (ret)
+		return ret;
+
 	reset = &cc->reset;
 	reset->rcdev.of_node = dev->of_node;
 	reset->rcdev.ops = &qcom_reset_ops;

-- 
2.45.2


