Return-Path: <linux-kernel+bounces-286707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9CF5951E0D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 17:05:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAE92282324
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 15:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 371DA1B8E98;
	Wed, 14 Aug 2024 15:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="J9i4ww6n"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF8BB1B86C6
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 15:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723647870; cv=none; b=WfsYpLIP3PAfDPxj4zmy5dW1gMZsQOBkk7kVlLZQ1Y+odV4GVDTj0SwPiXfqrY3YW94pjJo+g0Y4xlRCgxzMPbiFwlsugYOgoqPA53vHetM4YeMo7BF63gY0G3OqUpdk/vpAbDCOQg9ISRmnd7YHmV2f/U64z9R/x8JJdGhYM/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723647870; c=relaxed/simple;
	bh=eOLW+7XCSrgYl8oNaIQs1U9NSlOctUB76u7J7/B21Wk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NY6TTY1VHej2uk2QScTMfHRdS7Hx6jsI42BtQDZiFats4DqV5bTtaKY+YeacITNnwaDRcqnFIo5jyOuWGes2SE8RX6/14/sXnP6LQaKBWGtPqfqMzZSMqBraKYQ275X4Y/2nQlI6MUQi6NtB3b+h9oSrYLqW8LQUDxhoKVu4qyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=J9i4ww6n; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5314c6dbaa5so6612342e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 08:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723647867; x=1724252667; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9KwtbTNhxK6QLwV2KuYR/1Wk3sxaWn7bUkVHDhGR+MM=;
        b=J9i4ww6njmjJjZgXFqzGWUSMo/f7dCMJhAjoOfjSa7W1CUIkWhxHzGxxh3V7F6cuiq
         hXfGRbeSa3dBTa5yc9igyzQqrqSPn7Uf6lsj/tKXUOYyLUz/+69m3k8rHZmbK/7C6awF
         nOpH0gt2OGVtNXFA7b+RuP63Vvlsd1KFCNfQ3qDAGjopxuCwXMCWZ0C+BloUs4JlVxTL
         feyMwBJ58WJ+OFAguSWLPGWDzAVpjevA/z7syLSTZ1eBjH/K/9CDiOr3/8SsBJfpdDFy
         ivwZBp7oc8FwoSUJFFKi1Cx5UCoa9s1e3kJaunDVbml5/UJf8Cc/QL6eeV/GHU9ZXzvc
         vwEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723647867; x=1724252667;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9KwtbTNhxK6QLwV2KuYR/1Wk3sxaWn7bUkVHDhGR+MM=;
        b=aap0BDhY8NCAT8uO1h942kh3xr1nvJzd8lBdcBbOXXVV2+FB79BNeCHIU72w2hZJdr
         yWbfTITqxR/acPqytg/HW7HgAHDCdLJdKFbk4LCMH9njcKkO+/3hc0+F5UNz/Tc5Xexe
         VJFz3DtWGl10IkSvtXbHINWzHU4FxDMUB3OZf9fw4Awu72Jr2ELXYcEd+wTu7tOS7PIL
         W5aAWjwTku7PJ8TUA9JooJ7x2BFkMOCjeK+tYTc2RzHNXAqEZVcVQ3qu7hH/EY/exVFU
         fm2pyzulogQWGZBvJve4XSUl6vvdflqDtwCyPYcmF1D0ETAlyG55Jxx3O/rmorIDS6Y1
         7fvQ==
X-Gm-Message-State: AOJu0YziQEUGrgZdLmpFIGUT5CQuHL9fG/2JnuIU/X9cb6E/KYu950FE
	tKZXwUyFWiAOMdtbPk6g+c3nxkiZZh2r4gH+kwEYiPS456uK4/pTP6uilZvvP+s=
X-Google-Smtp-Source: AGHT+IHWzR0X1/chVI5nyA1bbHhSLG/im51ue7HmP59m16YndqKv/URofmBboXJLf4NWv6CumXY1WQ==
X-Received: by 2002:a05:6512:128a:b0:52c:f3fa:86c with SMTP id 2adb3069b0e04-532edba1f04mr2399025e87.18.1723647866779;
        Wed, 14 Aug 2024 08:04:26 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.215.209])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429ded7cfbasm22313425e9.45.2024.08.14.08.04.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 08:04:26 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 14 Aug 2024 17:04:09 +0200
Subject: [PATCH 5/7] regulator: qcom-rpmh: Simplify with scoped for each OF
 child loop
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240814-cleanup-h-of-node-put-regulator-v1-5-87151088b883@linaro.org>
References: <20240814-cleanup-h-of-node-put-regulator-v1-0-87151088b883@linaro.org>
In-Reply-To: <20240814-cleanup-h-of-node-put-regulator-v1-0-87151088b883@linaro.org>
To: Matti Vaittinen <mazziesaccount@gmail.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Krzysztof Kozlowski <krzk@kernel.org>, Sudeep Holla <sudeep.holla@arm.com>, 
 Cristian Marussi <cristian.marussi@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, arm-scmi@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1376;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=eOLW+7XCSrgYl8oNaIQs1U9NSlOctUB76u7J7/B21Wk=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmvMdrmXbX+7wxh+iBPMjSGusVfyVLcDmyopVEi
 Nu88lC7I1yJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZrzHawAKCRDBN2bmhouD
 18SWD/9IPpuPdYyOE7Twj4hDzgTcOT9AIVyIT41gFT4Y4Z6jo8XeP+z5bovXs/kpHX3pEuzFq3h
 eyPfwoxpaUuIEY+UhO0808X6GZwdGqofvuRisDO6osxa11w+CVPKGqW5xJ6gUmOaXdoWUN4x12I
 TUDwvuGTZQ77KyG+cLBAovMp/YjDe+uqnkv9SHxh503dnBrEAanMsX7rtsWbywnhNmQc3MSdEYP
 MB3mZnzVxYepZNmDi6tBK6iz26Uc0sb3PX8nJQG9GsHN/M+OB42VMGegkPoxEB6eFAhbvkwtGjd
 hk95FjI2jS2r0psjHIo5+bUtUlZxlg1A/caT03HoixwHlXCv1I+R2VzgoHsw/mIxhItu+quTRI8
 uBclKP91xKYg+M/+tAnFz+zwNuHUyT+JwYciz37mWfkYTnfdglfLz80ksdY7QiE9SNCqBHJmmU2
 rlg9dHV8D5v9enKX6juMfbToc81LfN5HRCj2AFIH14lptzs0matpmHQWwR8r+lTimxzPQjQfGs7
 4l9dtaYw8lcUPoWkRWWuy0V8eAwBjPh3JvdCL0Xi5VRgMp9BnqE/Vjni6DsVjMqcQ7gB0Jl23Gd
 wFkfK/kUNyJsQhXHmCppXV7SqODs0xCQ+cDpPLlgjokumG6D2SrLNi1+VPyIq93YuB9teHEAOLm
 X97Wj0+Qwn62jew==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Use scoped for_each_available_child_of_node_scoped() when iterating over
device nodes to make code a bit simpler.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/regulator/qcom-rpmh-regulator.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/regulator/qcom-rpmh-regulator.c b/drivers/regulator/qcom-rpmh-regulator.c
index 80e304711345..6b4cb7ba49c7 100644
--- a/drivers/regulator/qcom-rpmh-regulator.c
+++ b/drivers/regulator/qcom-rpmh-regulator.c
@@ -1537,7 +1537,6 @@ static int rpmh_regulator_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	const struct rpmh_vreg_init_data *vreg_data;
-	struct device_node *node;
 	struct rpmh_vreg *vreg;
 	const char *pmic_id;
 	int ret;
@@ -1552,19 +1551,15 @@ static int rpmh_regulator_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	for_each_available_child_of_node(dev->of_node, node) {
+	for_each_available_child_of_node_scoped(dev->of_node, node) {
 		vreg = devm_kzalloc(dev, sizeof(*vreg), GFP_KERNEL);
-		if (!vreg) {
-			of_node_put(node);
+		if (!vreg)
 			return -ENOMEM;
-		}
 
 		ret = rpmh_regulator_init_vreg(vreg, dev, node, pmic_id,
 						vreg_data);
-		if (ret < 0) {
-			of_node_put(node);
+		if (ret < 0)
 			return ret;
-		}
 	}
 
 	return 0;

-- 
2.43.0


