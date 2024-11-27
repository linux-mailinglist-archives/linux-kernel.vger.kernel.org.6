Return-Path: <linux-kernel+bounces-423667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF3E69DAB19
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 16:54:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95C2E281EEF
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 15:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73C27200BA1;
	Wed, 27 Nov 2024 15:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FoRdU7N4"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 131A320012B
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 15:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732722843; cv=none; b=sPARLJbGvFzz8ITimj0GPHQQZA/oD2ktXyKVnbPibgyonxz61SYvYwbs+rmlKuAo+zEzXiCGy3GTKDEWMUlSN9EDZIzBScMV6yDaWBQluYWOmVye26v/Ku5G+K9vjT/+ROFLlwwyuROWyPOPJk2iW0VSf9UXTjelNwidZjXmhwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732722843; c=relaxed/simple;
	bh=9DcDIgyiPEQQcegeEN1oWtNvqOat5t+dI1L4z5w/npc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=q9vXS95/dI+bQWkwtY4srOh/K4CV/1dPyXfRDJeNvyDQbGieyzux7lfDlSZ5JpKA8x6sUGZiXQyAq41eWnoSg3wzHLTYLvprFij/pnrHFTYzSU4Bygio0TAeBSQY+dVRIXn8U8td3v2mv0O3QFQIXpwkoavbEqM2TruWTo7loyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FoRdU7N4; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-434a1fe2b43so25808575e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 07:54:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732722840; x=1733327640; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6CvPt8QMHcz942A3Oqz3/N9DPxj3tCNq+0xhS6ngyuw=;
        b=FoRdU7N4z/bLNPK3GWhdHpF9I8Qjhg4eE2sv7C1vvXSV44Z+qhWG+ODL5NanTIqJId
         K5CwNYkVDDWNDQPvMsHTR/WPK7pTDvC45CJpyz7N0D9H7FOFALQRF7tnJppyv6BYkgZR
         FHybeX5QOhZyVYI1aTE/8s0U7p0HR+p0jFAUelc3gXfxldExMJZt82DfAdvUPrKoT4aZ
         QwJvJmZxZMO6WRFwHI9j0SXMrvlhBkncVUH4fIKSaiuNsyxbrekra1rvRZ4CdafX47sF
         uSqpFIKPkHyPqnli7bDVhdhGp41CIEeKZdn3U7l9aTN5zV81Wr+BZyV19dzLw1xCmGjV
         Y1wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732722840; x=1733327640;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6CvPt8QMHcz942A3Oqz3/N9DPxj3tCNq+0xhS6ngyuw=;
        b=dgvP6EAr7AIc7BhUd9MHmOz9eidF+VBmEt3D76RHVR9cx4Lb/MPZn39paj1cPNC3dg
         k/DLqR+ubP09f1aB1FF07A/H7xsF3dz3xON4sJ0Ly9XseHnyxcc4MfjwNSew3VIZcFkr
         JhUHKv3WVyOEYkABcLbVj782nQS8iMgyjHHceUM+VgR7U9LiikQzgK3JlF3oqO8M3Ltl
         Cx3lbHf1TLQbsoenCmP0iLsDuuPaQcTbgNSWyZJWodq8+/7yJ1rSmjwyKAIBeeUM8dRB
         RHX3YE7Y5tY7RlbukU9R3EHxwOO+w4IAN2LjMudJAAKZRqQwDaUJeKPBt7K4CN5yoR/Y
         nS2Q==
X-Forwarded-Encrypted: i=1; AJvYcCXx2Mluhrj6nDAwy4zs8dyUwocUnSUi0rb7kJ/DMGnIqDZrCIWouasAclxmpGT9EezpaZV642S2yyv9nG0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVg0nXpkP67BJ9m6VbhW3xZDoO/bSjWljyuv9jzM0Hdy0/maxw
	smn4UXpOGQsFWugZkQVNkJulGxxrO92yD+tSBoGn1byBAysI+2RlhMCNVD6ytFwMXEIw2rHb6Vu
	j1AQ=
X-Gm-Gg: ASbGncsq2c8Xz37Lv4AoPqAPet+gWqX/z5JiYmQNXV+ISTR1TApnqUpHt/hlygxarkB
	mRC859gHvjVBF17PtxtN0myNihtKKh5y090UoqpMOXRvfqvfm/c/Klt4EppLjgXgraQlmdbWpTf
	uB93ji5dgvetj0YcDHe/0ZDYHzfu1rSVG0wl5YEpg9MRFf2pQ9SEoiGDz14+UF0xBcz6xlB30xX
	NSgtB7tGPBb2UKVFh+Am78MkaZ7G7kD/M1f5F1UTV9tMjP7yI+zPRQPMHE=
X-Google-Smtp-Source: AGHT+IHGDQZYsAgi8Ipqt/f4XhqJRd2WRzf+LxuX9QIopr2zx3rLNuUzg/Jh4dFa9IVL5CZPYN2lfw==
X-Received: by 2002:a05:600c:444f:b0:434:a5bc:7103 with SMTP id 5b1f17b1804b1-434a9dce666mr31055245e9.19.1732722840401;
        Wed, 27 Nov 2024 07:54:00 -0800 (PST)
Received: from [127.0.1.1] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434aa7d1a90sm24795235e9.32.2024.11.27.07.53.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 07:54:00 -0800 (PST)
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Date: Wed, 27 Nov 2024 15:53:55 +0000
Subject: [PATCH v4 2/3] clk: qcom: common: Add support for power-domain
 attachment
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241127-b4-linux-next-24-11-18-clock-multiple-power-domains-v4-2-4348d40cb635@linaro.org>
References: <20241127-b4-linux-next-24-11-18-clock-multiple-power-domains-v4-0-4348d40cb635@linaro.org>
In-Reply-To: <20241127-b4-linux-next-24-11-18-clock-multiple-power-domains-v4-0-4348d40cb635@linaro.org>
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


