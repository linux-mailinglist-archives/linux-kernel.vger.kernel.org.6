Return-Path: <linux-kernel+bounces-422909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 127269D9FCD
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 00:45:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F207B24141
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 23:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62BCE1E0B78;
	Tue, 26 Nov 2024 23:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JxG539p/"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F244C1DFE35
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 23:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732664679; cv=none; b=pw4dVRP6giHsoF/+SvU28QFiQCj8v+2sIYwOYZpiZChEoUKML9X63Hf/RPCDvIXAZvp3eI7gjsclobKXwsVlm5OqZHn3Ro8DwNFyPyCSVm1vDIHp9Cs4Ywa982/R18Egasndvr/SgKPhvrd3tgqX0ZB/NWALL+B/s8q/IEyeOZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732664679; c=relaxed/simple;
	bh=nVHGEOrRUdBNA5gRWj0sFzT9xtelcZ3Fgi3g7ZZhzww=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ClQUew+AO1t+FoQHZyIGaK+a6vtdp35fRymx0jg8XnZWyWMGSMliJi7Iy+2yUZqGpnRYSvVw0dnjRKG0mHmFqm2CIoFB9azrVl04qXdLcxY5Tm28bROY5ZIkzhhzNCMeLgmCFCP9NyqvyvWUGXVaHIXjXXdOV15j1rZBM248kcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JxG539p/; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4349f160d62so25772855e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 15:44:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732664676; x=1733269476; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QK080mMzdkSHpObUIjIterv6PuoIM1SQM8FNf9+Umao=;
        b=JxG539p/bnkKA/TwZTCcEQ7syyPsoN4yl43pdhfBegBFA+PKgVZhZdVR2Y2mPySnMN
         ENWByUqYgO9C0WRp8eJJKZ9TGUjQ7cxsNerfLjnsbI0ZZzOaT3yNT6AO57SGRIwuPEqV
         C3nfzjSQzWW6H0r/Zxq8RGwJ6iRW2kSeVBl1RG7Rr9oRxmam6LW7eZ/qd6neMQqHWkxp
         Tw7ehbmIhzQ9d6GbgStisa8NmDzARED90SfAeJv+jbzYP5ndHUggVD3RiaA7NhS+m8F/
         /mRkY195lWjO9SHEntCsA3vS7V+RJO9gqqLyNGNE1pnzq8RZIDQ72mpEeGwVB26F00g6
         wJJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732664676; x=1733269476;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QK080mMzdkSHpObUIjIterv6PuoIM1SQM8FNf9+Umao=;
        b=Blj1/pfB4EVLEzfgl+DI8pUNcJw+QPpyfhdpCTOkjPizHpR8B2tEjA+xflCnK6Dc4r
         plDc4CQf0b8xHfHnfTwbHkdf72mMn++s4PC5Y18Jfy6hEvsxpqUHdt3aWE459Vob+WZ1
         oXZJk1OIE3jbxwHoS7puLfokBN8xrDTFG7+NneQdRw+PUPCfClzzWhgVARV73RM7MKuJ
         DE4ZJ+yBUKIFSAKyDpMpL/Rk4qjCJeUiLtUoKXBJmyCWinz97sdXq5zUgwUqtZq2zXG/
         u+wBiBdMQvsFt9r2RvVfDCTt/ttjmwDSHSVU0f910qkVUMbiKY7qYR7X9OTcOEAItTXL
         d/ww==
X-Forwarded-Encrypted: i=1; AJvYcCUvo7OISXuAAHM89QJItxqnBHMpnmuIXNAcrNyiJIOQaXRUuXq/3Hd6WWwjOUtsHqFaRgEawqcRdzyNM2c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+0igWsl+LiqUcX+8k10AuW/XVPAJ2O4kd+FKJ+OMDS9h88dK9
	qQa77jO6L5zOls8Mqcug/9mqVm95P7VeL0NYh6jnJi70mJ6RWPWNFfZlNeqHZbI=
X-Gm-Gg: ASbGncubVuUgiY7kEZNmhPT0EdoDq9427DQRzEDOq3cFVC7CjO7zObA2XWaXjrEEvkV
	9u4l1qPEQDFg2le7F+1jdrRfFSV5wwa5Ap9SMxnJEgY5ToqY1GbSkaLF2LlDFdI4vy96fEkSy46
	v99NUalaghS6K1Px4imOKh7P9HYO/x6h5U9bFVDkuPTqpNw+ylh+9mEVuKw4Th6YqONxQxG05Vk
	3X48NmT/Z0W5zd1SPjJF9IijGD23oWabM1IjZEW9MxYyfIAAkzMkz/tJUE=
X-Google-Smtp-Source: AGHT+IGd+fjrVRUKvsVcA1pohdHvtSxuhDJA0UKE8GpD7PEO4QQLWsNHgyLqbxvvvkEfp+17KqBElA==
X-Received: by 2002:a05:600c:1d18:b0:434:9936:c823 with SMTP id 5b1f17b1804b1-434a9dc694fmr9606295e9.18.1732664676497;
        Tue, 26 Nov 2024 15:44:36 -0800 (PST)
Received: from [127.0.1.1] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3825fafe338sm14482899f8f.33.2024.11.26.15.44.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2024 15:44:35 -0800 (PST)
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Date: Tue, 26 Nov 2024 23:44:29 +0000
Subject: [PATCH v3 3/3] driver: clk: qcom: Support attaching subdomain list
 to multiple parents
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241126-b4-linux-next-24-11-18-clock-multiple-power-domains-v3-3-836dad33521a@linaro.org>
References: <20241126-b4-linux-next-24-11-18-clock-multiple-power-domains-v3-0-836dad33521a@linaro.org>
In-Reply-To: <20241126-b4-linux-next-24-11-18-clock-multiple-power-domains-v3-0-836dad33521a@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Bryan O'Donoghue <bryan.odonoghue@linaro.org>
X-Mailer: b4 0.15-dev-355e8

When a clock-controller has multiple power-domains we need to attach parent
GDSCs in that clock-controller as subdomains of each of the power-domains.

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


