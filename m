Return-Path: <linux-kernel+bounces-424924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ABEB9DBB58
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 17:38:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3E53280D6E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 16:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D46701C1741;
	Thu, 28 Nov 2024 16:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PxoYXPUI"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E6241C07E3
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 16:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732811891; cv=none; b=UD54JHUV7HUep2b4VmQQCK/rwOlIjCgLeo4H6d9fo47NAyJ4fVcdkzrDH275dAQGp9FYKWvILoeGmupJ8H2QyF5t+xTvFzFIu66AE9HbD/InGCVZmmH2Sv9Z8yAEBB4r8VRDgfPYMn08wim5K2mt/wSkLbPeCmWG7OTQ/gr1qLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732811891; c=relaxed/simple;
	bh=/f9lA72X/ORQ7pcy2S3XGqJGhHnwd9S3RJbZG1bW+c8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ghyli+fk9NlYytfWf5ycAR7kLZZEwfQFMBQY0bc4BBPOyYRCyMkVslzhOLSchMDzvYazwFzYm3RPKioT2ucVxLIYcset2I0CnzJM38J1myLY7gHIaIO1BhrGYslcUe2epCu0mU7mGWKVfI/z0X6fiwDeydnLJ7piTl/NJkTKHz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PxoYXPUI; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-434a1833367so6354485e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 08:38:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732811888; x=1733416688; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fkkZ+w95DsCr21/2mV7KTwZ4aDH2tLnISRljFlMlIBg=;
        b=PxoYXPUI2vBwj5FTDqqQCmGmNSYCPOv+3OTuZj4NOhvUldU+BRXkF8kEL0y0EeexvF
         330m4w1uZW/sKFTHe3CkiTzqI6/QQXZAKZ6eJrPm7lqRUEKU6eJ+Q0zv+z5eav4vABYS
         sg33teNekAy09mhny1pvTTC9RKhycOH+3aghu5SYOuzR7ZBMWx8vUW4XTBs4jRYyhEZf
         A1jaGQ20qpinp7Ec2rXjb9NiOPrPFhtLjyCA2wDjqONZX95yzFJeKUQMEtaUuyW0OO7R
         BQ1IAICUp8+spyONjdNozW8ebtslP9x8IGKBM02QDSsdPzOjx4WdQ24AzuCsMvijMDXp
         5Idw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732811888; x=1733416688;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fkkZ+w95DsCr21/2mV7KTwZ4aDH2tLnISRljFlMlIBg=;
        b=J5SR87X6OITnw2cdGghMxtmkYEyriXo/MBCeOqSMwRziH2pVsZP2tGv+m+rmnYY2n6
         EMp0nNVohEXClXy/6JQCFjeq06kEJbYMEfxgtC5JNW5/gncu2gmweNtvHunPL98c7IMF
         EKOo8uP/t07XxobnrfIi1421UWPiWRu37PLL6ZmvwbAPM/L3zzZI3pj86X0kPUJfvxSw
         pYlGe4SKW4LSr//FN2lZgn3n6bhXyfuXzMViOyxlj9NZ8xJZlwagSg+zRF/UFm2OZlc8
         tcyeEjhueG7rLDIzEDB96XyVX6JxPIilbv1TLN76HOSSJRAZqkFhIJoMiE2/0uQX5Jre
         SgLA==
X-Forwarded-Encrypted: i=1; AJvYcCXtwI4WUqHlusw++568d1FGNTG4nyY8kdAduntCDdXReEnIXOOUwbaTOfWqBHV47fe7e61dgXx5uxanc2k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLv5139VIAU86NOFpHMioP3R+3dR/4BYoetIvqW/rBciwIpVhH
	yitrDx3oghgFrhmvBcHbCfeHoea4SPnVkZ5MIPZtAoX+FNqJZe79i/hP4ge+nao=
X-Gm-Gg: ASbGncud1hje1Sf3sG/xl4YGOqXV7L2vZuAMwcRy4vq98auG6hySRqwovFAxBTwZJr5
	vP0cWuxozigcTvxZcQOEN3fbtg/JyZiwNHP7vT/WnXl9Md+l7NmM5gusQtHbHsf5eOfju47n3pi
	1bfnJWSTLfFreQgaUKTq5fvQVqtaKMG+l7ILq6e/6G6IkeVO5w6et5/Tya3pJQdmB3sTqDSICjR
	SgfwZNTFil01wMQuvEurMCJcXapVndY2AUmE84/v7cs4Fb7KjeokWcrfQc=
X-Google-Smtp-Source: AGHT+IFZ0tfqwMWMoYCA98m42itlZm4kdOIHsdPFaXo48Zatt+TaoryezMrflvGllQJI70tUdXCUig==
X-Received: by 2002:a05:600c:1908:b0:434:9f77:e1dd with SMTP id 5b1f17b1804b1-434afb9ff7dmr34087765e9.5.1732811884986;
        Thu, 28 Nov 2024 08:38:04 -0800 (PST)
Received: from [127.0.1.1] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434aa78c202sm57990155e9.26.2024.11.28.08.38.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2024 08:38:04 -0800 (PST)
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Date: Thu, 28 Nov 2024 16:38:01 +0000
Subject: [PATCH v5 2/3] clk: qcom: common: Add support for power-domain
 attachment
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241128-b4-linux-next-24-11-18-clock-multiple-power-domains-v5-2-ca2826c46814@linaro.org>
References: <20241128-b4-linux-next-24-11-18-clock-multiple-power-domains-v5-0-ca2826c46814@linaro.org>
In-Reply-To: <20241128-b4-linux-next-24-11-18-clock-multiple-power-domains-v5-0-ca2826c46814@linaro.org>
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
 drivers/clk/qcom/common.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/clk/qcom/common.c b/drivers/clk/qcom/common.c
index 33cc1f73c69d1f875a193aea0552902268dc8716..e6a024e95ab5f4b0776ffc6c7b3bebfbebb007fd 100644
--- a/drivers/clk/qcom/common.c
+++ b/drivers/clk/qcom/common.c
@@ -22,6 +22,7 @@ struct qcom_cc {
 	struct qcom_reset_controller reset;
 	struct clk_regmap **rclks;
 	size_t num_rclks;
+	struct dev_pm_domain_list *pd_list;
 };
 
 const
@@ -294,11 +295,19 @@ int qcom_cc_really_probe(struct device *dev,
 	struct clk_regmap **rclks = desc->clks;
 	size_t num_clk_hws = desc->num_clk_hws;
 	struct clk_hw **clk_hws = desc->clk_hws;
+	struct dev_pm_domain_attach_data pd_data = {
+		.pd_names = 0,
+		.num_pd_names = 0,
+	};
 
 	cc = devm_kzalloc(dev, sizeof(*cc), GFP_KERNEL);
 	if (!cc)
 		return -ENOMEM;
 
+	ret = devm_pm_domain_attach_list(dev, &pd_data, &cc->pd_list);
+	if (ret < 0 && ret != -EEXIST)
+		return ret;
+
 	reset = &cc->reset;
 	reset->rcdev.of_node = dev->of_node;
 	reset->rcdev.ops = &qcom_reset_ops;

-- 
2.45.2


