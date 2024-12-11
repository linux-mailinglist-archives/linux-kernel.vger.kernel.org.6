Return-Path: <linux-kernel+bounces-441707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 019A59ED2D6
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 17:55:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71B13188AC76
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 16:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 884931DE897;
	Wed, 11 Dec 2024 16:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZiyioXtN"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 154E21D63CA
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 16:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733936079; cv=none; b=QAmXfkHJ4vx+2KA1rMhm9mMBGMSf9wvjj62JlGgfyWuT+5NW9b/a/kfF5mqmvzPu1CbF23DAnqwCv4U9CfllQrVu3i7cm2dTnDkEKgqxkQqg6bEYmLiY8nrDS344y/yVKRdiL3Ez4898TvpJ6xTGUx2UkDJXXeb+ZD/ga73CO6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733936079; c=relaxed/simple;
	bh=BCcVhjXqM/11poMT/N4HvI5IzpguMzkE/XgunRZ0xcw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LcwNDStXWanY8Smzj1VGcp/9ESYngJsNGwqUoBkbeul7wdcVlXdzOSh5Y0p99E8KpzSgz5JL1jnAxr88NH7e/6Z32ILMrO3Rn4nLj8Rd3I+gZaSuMjmJDQDlEbiovt1hlMkjx4QPZEoLBYzXWlx4INTEiA4CYgjLJxITrg5B1uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZiyioXtN; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a9a0ef5179dso1053198566b.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 08:54:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733936076; x=1734540876; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H3Aq0nsQUak92jzQ+dzMHRTGJEDpjujxd82cAU7SdLo=;
        b=ZiyioXtNISlbz54XwcZMzsOFdv54pbxF++l9vpZehqEE9OAQFjikPh7wyTsRTkuvjq
         jgXxTEcrRW834+4qF9oNiQzdw65WvQG4zJ11KKQCHcUB577rmbd5EqmHS6Umtt7irSzZ
         5u3H69oB1ARbPhSUPX5f0f7jIyfWWiqTT/m8KWTkNWAAMRBfTQixzk+VCiRe7Z42UvkN
         mLx1flUYmdaBwlgo1SzJ0NACbVgfgeYYegIn7ZqaOuE1gz9MkNnjtpJhl4IAs/ihTCRy
         DFFo2cciOA7XmN3Ls9Y65TKI1n/eqEwBDOxKq7qqCdb2Pt1CuWYUXKKYlrIhPi/NspTj
         Mn8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733936076; x=1734540876;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H3Aq0nsQUak92jzQ+dzMHRTGJEDpjujxd82cAU7SdLo=;
        b=YkUpxH4rT/N5thUtPumBk/uVa9YTMkTjWkbYmMhUT1N/I8aryOrkgW0k/FX2Lhz0RF
         AL7CHzMMGlq6NrYzt45k1d0PVAFy9vnmeFtfArdPQxJpM54wP0UsYBpYScvbXCGlE7bo
         BI627BlMsnKSRaU5zKBayqDvEptH6N32n99qLqAKMeL+hLlJKd2AlR9fZ6geAGZ14fuG
         53XA0vrCg5CRPunNU/tsUUe0mCTnoHgT+HCdVNx+D2aquyluTV8IDGXe1MV0X9Qf2zqL
         64iNqpAcZio6zNA8AimdvZIJ0zTqY1r7v2+Jowe6m4aJK1Z/JJBuMfLbWqhceMC6bspp
         qr3Q==
X-Forwarded-Encrypted: i=1; AJvYcCXWPI2uTYtrxgYpRyBfs6ahQiwvgKWUijsLAFPI3VUyzGnGghOyt88FEs1WoAdMZqlDQP1tXqJA+2JvJxU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4EPQCXGHoQhjTsP78XZbB7UYBnMS8MfPTbxY8oRpVv4eoT05Y
	S7AiUXUEWwBVrGHBnXn5olRoepJwarnJhOIHRwrtSHq3W0E0XvX5A33SP67Ak5w=
X-Gm-Gg: ASbGncssc3dIKfdLd79BUJVJxGgQ5ZEklhwoyI8lJQz6Cd1M4XQ865UgPV2DZ1sQ0rD
	alF9FrmJ5eRMvaE8q+z1j0J0vHA2QDgrwGA6/rAXT14Xr1e5635pWcusDpmRxH5mo6d5YOa+lAP
	qSalUDb7hoMCcOcDGlVleOphNZN0LdXYdH2qqx9PO3WnxDIRmZshrdkh1e+5xnFZWI3d9uf3VCM
	UwopWlDmkQt7BSIhi8BMUjF7DUieolbVPCHxQ/KppwVoRYwiU8a0xgsQzaRmRY=
X-Google-Smtp-Source: AGHT+IEGmnyW9beBMmVPguYzlZIsjQtmiTPL/wxqpdtxkv2SvAJyTXjCcC0PWY+7jCcfU3tEC9CUPA==
X-Received: by 2002:a17:906:9c0f:b0:aa6:75bd:eb5 with SMTP id a640c23a62f3a-aa6c1d028e9mr56988366b.57.1733936076512;
        Wed, 11 Dec 2024 08:54:36 -0800 (PST)
Received: from [127.0.1.1] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa66c646defsm651623866b.181.2024.12.11.08.54.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 08:54:36 -0800 (PST)
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Date: Wed, 11 Dec 2024 16:54:33 +0000
Subject: [PATCH v8 2/3] clk: qcom: common: Add support for power-domain
 attachment
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241211-b4-linux-next-24-11-18-clock-multiple-power-domains-v8-2-5d93cef910a4@linaro.org>
References: <20241211-b4-linux-next-24-11-18-clock-multiple-power-domains-v8-0-5d93cef910a4@linaro.org>
In-Reply-To: <20241211-b4-linux-next-24-11-18-clock-multiple-power-domains-v8-0-5d93cef910a4@linaro.org>
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
 drivers/clk/qcom/common.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/clk/qcom/common.c b/drivers/clk/qcom/common.c
index 33cc1f73c69d1f875a193aea0552902268dc8716..b79e6a73b53a4113ca324d102d7be5504a9fe85e 100644
--- a/drivers/clk/qcom/common.c
+++ b/drivers/clk/qcom/common.c
@@ -22,6 +22,7 @@ struct qcom_cc {
 	struct qcom_reset_controller reset;
 	struct clk_regmap **rclks;
 	size_t num_rclks;
+	struct dev_pm_domain_list *pd_list;
 };
 
 const
@@ -299,6 +300,10 @@ int qcom_cc_really_probe(struct device *dev,
 	if (!cc)
 		return -ENOMEM;
 
+	ret = devm_pm_domain_attach_list(dev, NULL, &cc->pd_list);
+	if (ret < 0 && ret != -EEXIST)
+		return ret;
+
 	reset = &cc->reset;
 	reset->rcdev.of_node = dev->of_node;
 	reset->rcdev.ops = &qcom_reset_ops;

-- 
2.45.2


