Return-Path: <linux-kernel+bounces-284858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3553195060F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 15:10:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E75A8281736
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 13:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBEC61E4A4;
	Tue, 13 Aug 2024 13:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YmJiT4p9"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C2A619B3EC
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 13:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723554605; cv=none; b=umA6RPnJ/cdL9ZkAS8cHTUVn7MMJXYukx/A2so7+/vFg/mXw0Gj/QNNy0bp2Q25ivjPR1zBcsmy75KjiaeqAAtM8Up3uh7u9oPAke6jSiZFCmSuf9j0LAK/hwoMch472j0IYMv+f9xikbDgFHBADUQ688s+olDAK2grriiyTOq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723554605; c=relaxed/simple;
	bh=BwejMU6ZUIgz8lGX+Skc7VtQTPN1+y9vWUPFbkYCZ50=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=U35ourfv3kcmgqzMsJJWY0Vlyc8nbdIyiSG4VaLgx+EthNwAXaNWVXkIL57UoA6A8rcwkoioktLqPsV6qSFA7eEba8ZeNGkh0V4AtdTv8RqcpDfyME6OYVJnol5HYoCgJc+DzntnjuvZEJ8lOjuXaULetFkfpP206Jm64zwfaos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YmJiT4p9; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3683f56b9bdso3651639f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 06:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723554602; x=1724159402; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vYV2yBaiU1eNGbD5nUDJdPAfLsrnpN3FqBevnmPD6R8=;
        b=YmJiT4p9Sksy3//JzDs6wwKUuycBR+SK82sG0RfK2JmwVyF3EMZDzxUw7ZKOf4qJF4
         Ok/Dj04HCTkoZXT7j3v0aLE+5OQ8uvqYrO2Xg+rbkXkORQArOs8yDUEqB6oQ0PFB5gem
         v5AUCQeIZFZGTDY3Z7Spf8Oudo6ey0yX62nesqKv14nyUqNacyNi/cEKswntuzaxzzHB
         qV6FxugPS0mY67nkaMREXZ3wAslhRxniKttXmLFHiR7g0GRuiugA7iMaS3Di8doMPkyE
         gcdjeAiqhALhqY4GCm+gdqKmbkHoiRBuKvg5EF7yXiEIahjo005TAvKnkZJhoplbePoa
         JsKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723554602; x=1724159402;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vYV2yBaiU1eNGbD5nUDJdPAfLsrnpN3FqBevnmPD6R8=;
        b=UDwYLqJDwRBSzBAgWRLLipRtOcWrBwyRVzmw10XjHIWSIQ5x38IhNV00gelpjSo3Dy
         hBY+FJ+5/Yv7d29qi/e7+Z/vBnrADdcjASKCDIOBSKVySL3i5hAsd6Jm69QIrugYnCCY
         WEaxz6DN7agSOo9LTXZo8BD/tWWQdYajOMwuwnCmei/Q9bW3yjpeTrFLCHzNFh3AdEPa
         KxT6Yd+kZmmflADBhNZ9sI9l6WTGN++UZ6ptVCN9xK2fmHcLVPlPgTCQxbS9H+2XKAF2
         pVl5InMKVSEoGSVHse+dKaKOSV60bG9AQIdsmSyhgWHfN/0RVOwBZOzX6rRVw5d5PVN6
         /7Uw==
X-Forwarded-Encrypted: i=1; AJvYcCXLOPemu69p3vXubPz05PHKTT5qF9YJM7Qo7zRGZJifw3MCLyppaJfo3bbFQvXnc6LTo9y/duPgwwtqzG4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxT4lmlEF+wr8w2YpWZTRAKo58w8YrES8KcDZCJSzUZQONAofRL
	XYtFQZfhNh10HrV+hbU6WGEeWibaglnkCRqE7gEPaksrrRAZ+/bwPuKjNhJpET0=
X-Google-Smtp-Source: AGHT+IHEtXM/0I0GAyREg5EKER0DYF7+YSxuj3da4+f2SEaAk7GsANHFPwX5vhUb957YGIRTjSasUA==
X-Received: by 2002:a5d:6dca:0:b0:367:8aa2:d41f with SMTP id ffacd0b85a97d-3716cd32235mr2372644f8f.51.1723554602500;
        Tue, 13 Aug 2024 06:10:02 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.215.209])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36e4c938280sm10305003f8f.36.2024.08.13.06.10.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 06:10:01 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Tue, 13 Aug 2024 15:09:47 +0200
Subject: [PATCH 1/6] soc: qcom: apr: simplify with scoped for each OF child
 loop
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240813-b4-cleanup-h-of-node-put-other-v1-1-cfb67323a95c@linaro.org>
References: <20240813-b4-cleanup-h-of-node-put-other-v1-0-cfb67323a95c@linaro.org>
In-Reply-To: <20240813-b4-cleanup-h-of-node-put-other-v1-0-cfb67323a95c@linaro.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
 Banajit Goswami <bgoswami@quicinc.com>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1394;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=BwejMU6ZUIgz8lGX+Skc7VtQTPN1+y9vWUPFbkYCZ50=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmu1sf7WFjqKtqbnO/o4IKv/eNdOe1rxw8n+MXW
 V6xxEWEnqOJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZrtbHwAKCRDBN2bmhouD
 11T1EACOn5uWT6CrmTfB2xyhTbC2MNwPQUICTvz64hAaEmeUl7lnqitjw4SEnJYJ7g5AMu7kt/e
 cNiVSP7xKl/6h5qbl0u1wdaQNPlhQ4ateDxP+X5SQBN5kSsuWcOzAENTBZupjo1cFhOYOa9X77A
 +8DMfXJZznJcMzWfKHVN/spGMyvGablCdileKkoJGtjYmhmWThN7D9z42+QB0du2e921go9fMzp
 Io/wsmtWzimOd4E08/JFiVoK9jeoKATne2GYbJTvyvSn/XKAt662X8UFSm9Q1Elna9HyeVZLk82
 TN9LoFNn1K/XG0+08mhyxuNTMFc+B2/8zt34OWIR0VOFSunlh4PIZzgP0WA+ChjHNc3gLSH7lGH
 O+pxC3ks4aUqOdmvt26XBse1wvzcLh6gx4vR0YJA/8oDETijzhBqtuvZqElb/GINXmYhLorCCQS
 4VySRPgKG2obt6y9zPps6U2ex5Z/5TrFFbmJSCM6fKZ631hyVczy76QG6nGkx7VtV3fZhbDe7/s
 Y8dEc5TCSMJd4W1DgezIzxeDiN8mF87zTJ0oj5uD6B0DIueTahdu2JlTCCxqow2FJim11nGrHS0
 rUmI4XjaXCPdZ4buW/dGENZF93AyP0GtONfuKIKUcMnCSNpB1IdvcAzQyfjBLEVTLfWO2sIJrps
 8S+vyqL5BNINP2w==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Use scoped for_each_child_of_node_scoped() when iterating over device
nodes to make code a bit simpler.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/soc/qcom/apr.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/soc/qcom/apr.c b/drivers/soc/qcom/apr.c
index 4fbff3a890e2..a956c407ce03 100644
--- a/drivers/soc/qcom/apr.c
+++ b/drivers/soc/qcom/apr.c
@@ -485,11 +485,10 @@ static int of_apr_add_pd_lookups(struct device *dev)
 {
 	const char *service_name, *service_path;
 	struct packet_router *apr = dev_get_drvdata(dev);
-	struct device_node *node;
 	struct pdr_service *pds;
 	int ret;
 
-	for_each_child_of_node(dev->of_node, node) {
+	for_each_child_of_node_scoped(dev->of_node, node) {
 		ret = of_property_read_string_index(node, "qcom,protection-domain",
 						    0, &service_name);
 		if (ret < 0)
@@ -499,14 +498,12 @@ static int of_apr_add_pd_lookups(struct device *dev)
 						    1, &service_path);
 		if (ret < 0) {
 			dev_err(dev, "pdr service path missing: %d\n", ret);
-			of_node_put(node);
 			return ret;
 		}
 
 		pds = pdr_add_lookup(apr->pdr, service_name, service_path);
 		if (IS_ERR(pds) && PTR_ERR(pds) != -EALREADY) {
 			dev_err(dev, "pdr add lookup failed: %ld\n", PTR_ERR(pds));
-			of_node_put(node);
 			return PTR_ERR(pds);
 		}
 	}

-- 
2.43.0


