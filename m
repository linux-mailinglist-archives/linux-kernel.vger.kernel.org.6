Return-Path: <linux-kernel+bounces-423668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E1239DAB1C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 16:54:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19DEF1653ED
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 15:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FCB5201002;
	Wed, 27 Nov 2024 15:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zh4qRu+A"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BD5720013F
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 15:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732722844; cv=none; b=q6FAT26KQZnTseONZbw+txqpcJPQe33sWRp+o7nIr/qEPBT0LCQmLfNf/pBIFr1pyokftJSugLH1VKSLmpUQ3FznTg2mvEF1DVSWKttg45JXQGJf9bF910CWYmcgHpWjlC0JRK3W/eR/uliCjkgPHPCW/PH6g75nQjmrYvcUc7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732722844; c=relaxed/simple;
	bh=Ywkm3VwcyiDMElgsGMcoFl6BepYTnvnsF0yyoau73Mg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jgeehpDs4c2Dvp+GH+wCY1XICpN5hMzLsQOI0P3XbGy097Q8qBzhGZMAElkEmqfHefBNZD9J16CyVO78PLLE3pfKWgRs/wGyWIacnfUv3DLpsWy9LNitGioFPq7ImgbdO+DBwO4lMcp2pECKhr8Ht3NFqk7jJCUMdSBMSxMWgG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zh4qRu+A; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-434a0fd9778so28282915e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 07:54:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732722841; x=1733327641; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UT/CPunlwVk5ZkGQuMziuZnIeQTUwhReTxXK1l1Fb64=;
        b=zh4qRu+A6mQAYGALO3hlzJFiLhhHJSbtk5WElGZwth8wnKcZbh2bbFPGeRbmtuh/7Q
         UJWR4CAQ22gIBFwY4OZKG0AgGhwNhfPtJXi29ywajDfYYP+g8xx3BQ1gPLKNnVr3bIoo
         Ngss/fA8HKaRT8X7wgJvkovLQtczV7zTt9MbWZ236DVEzoYV5DOu0T5N0dsg0ldkMuwB
         xH6ZbOGjB/qZwySUglKvs0ReLnJXmvguFKlY5uurtz+4HZSMSE3BQWq8HSvan0yH/AYS
         e7ov/isqE/X+OFeXnuu9pU5xrlBwxIAZnn0Nh58C0/EF5A5IlKTFT8++ToEoHOWntnIz
         IJKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732722841; x=1733327641;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UT/CPunlwVk5ZkGQuMziuZnIeQTUwhReTxXK1l1Fb64=;
        b=iICgtx/Jd7d0y9zI7ZKZtqUyVdcJKSkQeRHiob8R9wEnhuzLWjW77v9HSqTmneE/qW
         +pgFwBoLlFtECPBxLhk0IT5gDnJIhgCEP4ykbuHXFLHQTs+eG8rqDg4I1O1oIXs6GbpJ
         dO0TV+DCVCgfg+Rbati5jSJ36WxVXzVdvWlzNJR8kPgAF9zaFO5K7FVYYuZ/zun8lZUH
         4w8VQA8U1Lo/305n4EfAuhu6nZe+JEKIZdYHkspmZI7XqfPHGU3zNVRZYT8htB8hd7AY
         YqS/tQISR1JgBC4d8LGpKQX1PVGbAUizWsoac2wjf+igrgU0d83WIE63xvSAiJa4OiY6
         trOQ==
X-Forwarded-Encrypted: i=1; AJvYcCUzfSnhuyoJpgtJ1Ppt7HEoL1nQQXeOaJoi95i92xcXN8QgWAWxr962xlO+KdQC5nKyuNmZ+f3oonmypKI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYNShLjRmuBezvFcwSLctQ2z23PH5IvQzO8WlxsfoGX+RKX40E
	8WfN05sdD9kNeCyvWrsFbuyXRG0AOljyNukOhGIxC2cs/3hcM7ZYC+670ogNTVI=
X-Gm-Gg: ASbGncuiI2xAKx0jUPdHIONYGTls3r+hVP4bnI/LZBO/74tGh4PCD7sYOe1gLPogeNs
	SaX1PT1flIyQGxm010VIV2TgEN9EUZQi0UWWRjtmNbJCeeP3Fq3dBTZh3/3GmzWFHSY9N2GRu8d
	TKq2jXVrFudCeesua16JjjLIXUS5+5X24BYA8GB+gKG3EaFd1GzOsR2f4/wOPBDDHeihTkQoyTV
	Du34oCLsGsY/z5qanF58sy+jnMLjC3KNDYyhxHRndw5lNRGhZV3UpMECoE=
X-Google-Smtp-Source: AGHT+IGDG8qG9rsBaONX6nB7eV/I9WRbD1faH0/jeMqgzVvK1/j0F2ptVvBE6XgwNFfeg2ucdMBr/A==
X-Received: by 2002:a05:600c:3b25:b0:431:5632:448b with SMTP id 5b1f17b1804b1-434a9df26c0mr28909725e9.25.1732722841551;
        Wed, 27 Nov 2024 07:54:01 -0800 (PST)
Received: from [127.0.1.1] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434aa7d1a90sm24795235e9.32.2024.11.27.07.54.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 07:54:01 -0800 (PST)
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Date: Wed, 27 Nov 2024 15:53:56 +0000
Subject: [PATCH v4 3/3] clk: qcom: Support attaching GDSCs to multiple
 parents
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241127-b4-linux-next-24-11-18-clock-multiple-power-domains-v4-3-4348d40cb635@linaro.org>
References: <20241127-b4-linux-next-24-11-18-clock-multiple-power-domains-v4-0-4348d40cb635@linaro.org>
In-Reply-To: <20241127-b4-linux-next-24-11-18-clock-multiple-power-domains-v4-0-4348d40cb635@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Bryan O'Donoghue <bryan.odonoghue@linaro.org>
X-Mailer: b4 0.15-dev-355e8

When a clock-controller has multiple power-domains we need to attach
parent GDSCs in that clock-controller as subdomains of each of the
power-domains.

Testing on the x1e80100 reference shows that both power-domains need to be
switched on for the GDSCs in the clock-controller to work. Some open
questions remain.

1. Should there be a hirearchy of power-domains in the clock-controller.
2. If there should be no hirearchy should the parent GDSC inside the
   clock-controller attach to each power-domain in the clock-controller.
3. If there are multiple parent GDSCs in a clock-controller do we attach
   those top-level GDSCs to each controller power-domain.
4. Finally should performance-states be applied equally across those
   power-domains.

It may be if we see more clock-controllers with multiple power-domains that
some mixture of these questions will need to be implemented for specific
hardware. Right now the approach taken here is to attach the
clock-controller GDSC parent to each clock-controller power-domain.

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/clk/qcom/common.c |  1 +
 drivers/clk/qcom/gdsc.c   | 35 +++++++++++++++++++++++++++++++++++
 drivers/clk/qcom/gdsc.h   |  1 +
 3 files changed, 37 insertions(+)

diff --git a/drivers/clk/qcom/common.c b/drivers/clk/qcom/common.c
index 7727295c57c8f6672d46d2380e1ff5ec2ac68d42..58a8397eefe51da237a4285d4e7cee967e19948f 100644
--- a/drivers/clk/qcom/common.c
+++ b/drivers/clk/qcom/common.c
@@ -338,6 +338,7 @@ int qcom_cc_really_probe(struct device *dev,
 		scd->dev = dev;
 		scd->scs = desc->gdscs;
 		scd->num = desc->num_gdscs;
+		scd->pd_list = cc->pd_list;
 		ret = gdsc_register(scd, &reset->rcdev, regmap);
 		if (ret)
 			return ret;
diff --git a/drivers/clk/qcom/gdsc.c b/drivers/clk/qcom/gdsc.c
index 4fc6f957d0b846cc90e50ef243f23a7a27e66899..cb4afa6d584899f3dafa380d5e01be6de9711737 100644
--- a/drivers/clk/qcom/gdsc.c
+++ b/drivers/clk/qcom/gdsc.c
@@ -506,6 +506,36 @@ static int gdsc_init(struct gdsc *sc)
 	return ret;
 }
 
+static int gdsc_add_subdomain_list(struct dev_pm_domain_list *pd_list,
+				   struct generic_pm_domain *subdomain)
+{
+	int i, ret;
+
+	for (i = 0; i < pd_list->num_pds; i++) {
+		struct device *dev = pd_list->pd_devs[i];
+		struct generic_pm_domain *genpd = pd_to_genpd(dev->pm_domain);
+
+		ret = pm_genpd_add_subdomain(genpd, subdomain);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static void gdsc_remove_subdomain_list(struct dev_pm_domain_list *pd_list,
+				       struct generic_pm_domain *subdomain)
+{
+	int i;
+
+	for (i = 0; i < pd_list->num_pds; i++) {
+		struct device *dev = pd_list->pd_devs[i];
+		struct generic_pm_domain *genpd = pd_to_genpd(dev->pm_domain);
+
+		pm_genpd_remove_subdomain(genpd, subdomain);
+	}
+}
+
 int gdsc_register(struct gdsc_desc *desc,
 		  struct reset_controller_dev *rcdev, struct regmap *regmap)
 {
@@ -558,6 +588,9 @@ int gdsc_register(struct gdsc_desc *desc,
 			ret = pm_genpd_add_subdomain(scs[i]->parent, &scs[i]->pd);
 		else if (!IS_ERR_OR_NULL(dev->pm_domain))
 			ret = pm_genpd_add_subdomain(pd_to_genpd(dev->pm_domain), &scs[i]->pd);
+		else if (desc->pd_list)
+			ret = gdsc_add_subdomain_list(desc->pd_list, &scs[i]->pd);
+
 		if (ret)
 			return ret;
 	}
@@ -580,6 +613,8 @@ void gdsc_unregister(struct gdsc_desc *desc)
 			pm_genpd_remove_subdomain(scs[i]->parent, &scs[i]->pd);
 		else if (!IS_ERR_OR_NULL(dev->pm_domain))
 			pm_genpd_remove_subdomain(pd_to_genpd(dev->pm_domain), &scs[i]->pd);
+		else if (desc->pd_list)
+			gdsc_remove_subdomain_list(desc->pd_list, &scs[i]->pd);
 	}
 	of_genpd_del_provider(dev->of_node);
 }
diff --git a/drivers/clk/qcom/gdsc.h b/drivers/clk/qcom/gdsc.h
index 1e2779b823d1c8ca077c9b4cd0a0dbdf5f9457ef..dd843e86c05b2f30e6d9e978681580016333839d 100644
--- a/drivers/clk/qcom/gdsc.h
+++ b/drivers/clk/qcom/gdsc.h
@@ -80,6 +80,7 @@ struct gdsc_desc {
 	struct device *dev;
 	struct gdsc **scs;
 	size_t num;
+	struct dev_pm_domain_list *pd_list;
 };
 
 #ifdef CONFIG_QCOM_GDSC

-- 
2.45.2


