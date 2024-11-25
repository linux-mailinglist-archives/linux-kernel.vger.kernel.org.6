Return-Path: <linux-kernel+bounces-420371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C9CB9D79A3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 02:01:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35B25163253
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 01:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0545714F9F7;
	Mon, 25 Nov 2024 01:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="t44uWrVu"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 042BB18027
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 01:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732496421; cv=none; b=rul8Ma/+Gg/SeAelWkfxBJmulpJHpCJRUV5FJsF7R9MYZ8whwtN5WXjNpi0bxXx+ZE5CKx3V/y1i81RN187cFABdogNMY6L5kVtA+e//mFzbRzBzxYGglY+07F7QBh3l6szk+zLmQRBE38Wck0qCmOkXJfQfuai1vSygSkgjQtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732496421; c=relaxed/simple;
	bh=nVHGEOrRUdBNA5gRWj0sFzT9xtelcZ3Fgi3g7ZZhzww=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Y4Ko6/fWDS2oqF5ExEe/yeXrXz/lH3pDOmDo9ySqou03EU/ISSiPP+5NELUGVdn2taScnSYhSqmMLOs6FbvWhkFD2KwuJ8XGXDK4ylJgt1ImwkUU3QrDlpzg7hxJReGGCAwIpHTnMb7ku/jIRcDuY9LN7qjT61gHixNh5fXjet4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=t44uWrVu; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4315e62afe0so37369105e9.1
        for <linux-kernel@vger.kernel.org>; Sun, 24 Nov 2024 17:00:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732496418; x=1733101218; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QK080mMzdkSHpObUIjIterv6PuoIM1SQM8FNf9+Umao=;
        b=t44uWrVum9Ut576va3ZJx5qy6asn0uTI389pmQ7Sqomh5HnIj62sDIikyVcM92L+kX
         8ZavPiLQuKNvOnrFwvQ2kFpcdAPRTHLXEKx9GTOKB950XeTRtEE561hEa/cGIg0zsBVe
         WKUPoagDUbusnNCO/kXVqlJvKWQotOml/hUW1F0TKleOQWwjDAGOp/kXFqU4QW5emrCW
         AI4cfAzhpnQvGPxpY4CSUNE0CufM7algpPLCdALnJ8QabrDd22f4XGTk6aa225CRs1i4
         7oVCpGhYQTwSlOEpZFzV1+7Baqt0IwAABDl+kWOl8BSm/J5dy/aafNmuLhb4YwwkVKwb
         PkgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732496418; x=1733101218;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QK080mMzdkSHpObUIjIterv6PuoIM1SQM8FNf9+Umao=;
        b=veWOOCGA7Qqi1Dckos3D+aMsGJu2ayTsjlbxXH5yGRusHOmluW2qExjAUjSnjth8g8
         yc+kvqqdrUR5cpLFgA09jweEhB75L+6laDY4U/ZhCYztrdazStlO6I9BlbONznoSau7X
         ni/RRN+uI27n/acHd5IlQSxj1Rsok5/ENMlSf4KLk6nj1HHMdNYplvQ2HDf5R4DMu6cr
         ETfqMQ2ie61hCVGxCbfRHAtdo+aXwmtMeEKFJyivvomDjDhbEf7JJISJ52tmRgFAN18K
         dHNTJ5E9CtWgxgCpd6SchWrYvuzrvnE7JcI6WHuRGJ0zP//YZVNztG6SULGSfdCGCjQn
         BgoA==
X-Forwarded-Encrypted: i=1; AJvYcCWyxB7HJ5LpPR7EJCrN5SQQOVIaf+DLGZAHtnpQnPh5387olYTgRGel/b/AeXBZ2D9rEswh+OWa1TvYyso=@vger.kernel.org
X-Gm-Message-State: AOJu0YxR56K8H7ETjvQlaoxL/16amA4kXoYTbdfKTsRcz1X8Jhlyfs44
	CJOUcuWWwGW+EmseO4ObifRs9RiYzFASR6gs2QgIfA/Wl8EBBN/opONrJExGWq0=
X-Gm-Gg: ASbGncsG4VEK+CnwL9+VVjNE8CzwTLRrCNWwVRaHsvD84zup7GSS3nbzT/ed7Wg/hew
	AAADyUK6HNyxeLwnfXqRAtAUISeqASlJTfYzqHEPvQEgSqwWOd1FOg8WUY7T0azr8Om7mRkPTQ5
	D0AqX3blsDJbdidA9EX0lm7Vv6+f3MGSf7C4gMcGxqset0E4v4C/3NAGpk05ub5CgWnKaGgZ8iL
	JFsC7P8d1B0SXpbW3ST4dxpUaNq1LbMXhWPICADl5+Zl42g9X+VCGpHY5k=
X-Google-Smtp-Source: AGHT+IEAGlCilG8EQiX4eHWR9jCfgHPz1anIKZ3sLAgNmaQ9WHHp9Sq1Imvv7aOLcmrzWShE6SCeTg==
X-Received: by 2002:a05:600c:63d4:b0:434:9c60:95a3 with SMTP id 5b1f17b1804b1-4349c60c065mr33631055e9.11.1732496418308;
        Sun, 24 Nov 2024 17:00:18 -0800 (PST)
Received: from [127.0.1.1] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4349f0ba652sm24125125e9.40.2024.11.24.17.00.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Nov 2024 17:00:18 -0800 (PST)
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Date: Mon, 25 Nov 2024 01:00:14 +0000
Subject: [PATCH v2 3/3] driver: clk: qcom: Support attaching subdomain list
 to multiple parents
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241125-b4-linux-next-24-11-18-clock-multiple-power-domains-v2-3-a5e7554d7e45@linaro.org>
References: <20241125-b4-linux-next-24-11-18-clock-multiple-power-domains-v2-0-a5e7554d7e45@linaro.org>
In-Reply-To: <20241125-b4-linux-next-24-11-18-clock-multiple-power-domains-v2-0-a5e7554d7e45@linaro.org>
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


