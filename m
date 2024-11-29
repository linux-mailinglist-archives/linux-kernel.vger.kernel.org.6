Return-Path: <linux-kernel+bounces-420370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67BDF9D799F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 02:00:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E204282339
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 01:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E31042A97;
	Mon, 25 Nov 2024 01:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zsM+dZC2"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FBE15227
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 01:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732496420; cv=none; b=OR/uixnSOYH2hFBh3Z6UUaTcoPhJbuTFkmF0JHwBEaduMtxlUqXmthew9mIkaijADspp4Awd6dq8CNv0S3m1MlQzEjpceme+kMxSc9hnnqdw2qJM8EHRHDjtWN6E9yIdSsmlA+m43LnQ69/59h4/FBXL0NJ2oZtGFznwDPRq8UI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732496420; c=relaxed/simple;
	bh=8Q0dwsJu+wk/Jd4PxCG5iT9YNajXnxbY7a6LSSkbWlo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WgusY21o+JBufz546wuaJ9/eWNFSqYbPn/C1JCej+izsHa/i1vaQjtVJsLDpIruNrOsdO5PVPJjr3JJsnFGEvq6ZoS3ESyjFXO7KIUUkFDQGph92ERIs1FZWSqQZDzIq9UyspUxpiIrtHqEOIUtiuJBERmLl3G/0um+BE8+OpYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zsM+dZC2; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-431695fa98bso33054615e9.3
        for <linux-kernel@vger.kernel.org>; Sun, 24 Nov 2024 17:00:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732496417; x=1733101217; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4r5j9bVIpoqg4wTF7W56XBSdumsviU7AiOzIE1c3fKA=;
        b=zsM+dZC2Ymuw3k1AmPflBZ7MuOIi6uI5JXLoiXoS6Umso9KQ3XpdS/lz/UfXsRfHTV
         1ALB0FmUHByQmkpuBQwhhzxoh3avCNo1FxpqfsvZqj8BjGS4HqRYXRBs6YAj4y5N9KCB
         OD0uS2qZhjUojrC0gqHwzw2Hh3mfI6LEM4fldy2xi0l9+wjcX3f5OpmY+elZC0ZeC7zE
         ELN91D17hgpTzaZaUuglhjwXO4GtXhaZ9i1lNshyGlKcgposrjr+oP5Dny7pIMhzLD3v
         UAn64OG/JW0JUgFXcM+5zVH6+HCyovbI0ToKtTGKojvnmvmkFN1Y1IsnzAqap1U6HtNo
         8Ssg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732496417; x=1733101217;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4r5j9bVIpoqg4wTF7W56XBSdumsviU7AiOzIE1c3fKA=;
        b=A4RR+lZK+qnuBwtgRMOKsX2dZxBiJLDKVKG9nGsaSgfLhtARprFMDjhXSv9/0f7E93
         A77eMp5iZm/Gz5G/tGe0Kez5UN4iK9dcimbfsK7x+p8SGn9JpNC95OyvIISK79hMcUAc
         0lx+7jMM2vnCHx4ulLD46sX4EoUpXH5hYSeyCFD2lMBYQ4fAZuOG7u0BTGXi+8h5lF3R
         4r4RUgaL5zIyHfwu/TGBHCIvZRssB8uG3/uUZRykRnhZtGSfT0MqWRQf6T2KCPMOqVea
         Ay0n3jU4Di+A5KrvvcgPAX9A28veoXc09JCh3HFQ8jR/jNOuvqyKatvkCtY6BsOvkysP
         0d8w==
X-Forwarded-Encrypted: i=1; AJvYcCVgwDgVDUE83V8Dv2nsbVouQub14Np1Zg5J17jQVj+KYFl94CF9GNDqnDu1LFBaJhXyYzasQN3H/KYPdrM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOsKER779r9bmuZLS/uvYiqZP1PAsQJTlGe7UupvvhEM4eyzZ6
	3Kg9vl0RcZU0zm+2GbqcR04m7alf5Ya4K1yEiAuLnow3wcIXl7MdhNK2hajS0po=
X-Gm-Gg: ASbGncthTfNpcfKXASY59ppFXXTyT4omx/cgOQbVeIfmS1yykCIjieIaZ37ONGU7XGn
	oJSfjsqMPED706otoDjjEzH2yQQZmHHVsz1G7l6X5IVNWHp48b3t+bgXGw4pklzF9k67282fWOA
	bFVe+cxzLWp3kocl3gL9uAvesUCWYuLqoRqsGCb7jrfPOtUVGZlZhXrSO9O8Px8iek581hLNvus
	67tQdu3zXW41I6f5w9UM5d3kSykW9u0o9IxhRu3RTSQqL8qly2cMFj0aPg=
X-Google-Smtp-Source: AGHT+IE7C4rzp6H5XjRK7kkrwv5Z20pcz/Okn4VpbMU59v7Nvy+i01J+Hd+znMgP3Rc8mDIlgmvz0Q==
X-Received: by 2002:a05:600c:3d8d:b0:431:4e25:fe42 with SMTP id 5b1f17b1804b1-433ce4e9e39mr85434635e9.32.1732496416711;
        Sun, 24 Nov 2024 17:00:16 -0800 (PST)
Received: from [127.0.1.1] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4349f0ba652sm24125125e9.40.2024.11.24.17.00.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Nov 2024 17:00:15 -0800 (PST)
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Date: Mon, 25 Nov 2024 01:00:13 +0000
Subject: [PATCH v2 2/3] clk: qcom: common: Add support for power-domain
 attachment
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241125-b4-linux-next-24-11-18-clock-multiple-power-domains-v2-2-a5e7554d7e45@linaro.org>
References: <20241125-b4-linux-next-24-11-18-clock-multiple-power-domains-v2-0-a5e7554d7e45@linaro.org>
In-Reply-To: <20241125-b4-linux-next-24-11-18-clock-multiple-power-domains-v2-0-a5e7554d7e45@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Bryan O'Donoghue <bryan.odonoghue@linaro.org>
X-Mailer: b4 0.15-dev-355e8

Right now we support one power-domain per which power clock controller.
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


