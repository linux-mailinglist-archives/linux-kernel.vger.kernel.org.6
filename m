Return-Path: <linux-kernel+bounces-300516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C5B2C95E4A9
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 20:06:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6464D1F214A8
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 18:06:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 414621714C4;
	Sun, 25 Aug 2024 18:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CEFKMERZ"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4BF216F262
	for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2024 18:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724609156; cv=none; b=pDT2rc+ja46B8Cxm8O1bdRZA2g35PKhvSjcYwbcaDNFpJ9VzkEsgXHJltP3YrqlmDD/kHhHDKnane889EpuU+3peYUPCE8BmKZZc5nVm07/1BAQ6lwPSXqiIZtk0aDLPRsdEM4/EK3MFH9rGxDUgGWUe9PyBJkav99GDJsRp2yE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724609156; c=relaxed/simple;
	bh=gLo2MRTXsFeq02SUdCwpMzugi/rrrP2OWGn4eDr68Nw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=imSd1j2w7Rx/zeDeb+mpNtMDpYZOQHFVtJT4dHpgiYsjgKl+qeBki99kG0xPJVG5aSeGbu+MiDvMVKnN0WoVAUWlrJw1YxESfI8ODJO6brDaADtB22Goy11C6J0HFzEgdwIXq7eGd5pDMsl6X89mQrHcvMQFbYQPzFpHc4j6xVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CEFKMERZ; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4281da2cdaeso5557055e9.2
        for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2024 11:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724609153; x=1725213953; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Px08219UxWUPNfHVakRaFgAR3n14DqjgVtECE2v++7A=;
        b=CEFKMERZyVMQ+uUOTlEJ8XSnN1XfUzJAYCDWzmghnULNlR4vwpz6bwFSnQmUsS8KXw
         QtoyB7P+4OcTv/G+U5vysJDMzC7qy25lc5KGd3BnAXwWIe1Y5nLTmyN5ycGXWz/fRDaL
         6+3msKzpkFU+qry3oRwV5dh0qMMyVafPCJVl4B3N8RhyPHCzrjiqFzbRH73rjoRkfXR8
         eRhzXgQzRU4OuYZmFkZuJaDUeEC7DNc9YCb7KJOKG8mD0zP1JYn8BsD7gRc8LucGzaKJ
         /Mepl/GpvVGn+zQuHuw1yDkczje+flVtH1CfYsTQj5gyVutX3gDHIwI9+YNutwinXCrV
         R06A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724609153; x=1725213953;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Px08219UxWUPNfHVakRaFgAR3n14DqjgVtECE2v++7A=;
        b=kFhT+mYbrO6Easr1iCFiTDFoJrHAC6xdnSTneqvKNVkA13CHfJyMLiY6z8Wy9czPLt
         IonnLT32PQz57+x7BR/cjNbFOxIdgerwVZ8QVnCybIhdogxEGloTVRpdKFGcnOZqLkB7
         U8QyZZ5Mc3/lnGdOJ/lGKooNtkHKc7ZIph2B3O7DOJAbzb+u/yGr+HSjtPMJnwRiM/TA
         +idZ/mlrFQ4wISjvZPL7mDPExCyNBsvF7vb04nXEE97kM1PI6+cuBgPLkSGoNxY/yGSP
         o1rFPurPNwRhhIjLI2T7VTUQCIDApWIEEfVEIJii5a7AyX1zPMYyUX6WV9sAz4XuCDM0
         5Tkw==
X-Forwarded-Encrypted: i=1; AJvYcCVvb7u3udHTbnMtae5jHXRX9oeMV/OnE3q23YquOfNC+t63x75cBQfa1Vyij0OffF8zborpSCj18eFGbjY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7Jzf8HG+ICssACLLFXiLanup7ZeQCzawMs+UX7tQTw6GXzzIg
	GOW1AMMs/C6PKQq7V7IgvOfTUyU88i6p//zqcGVgO0Bu9213i9iEFC8PIv7Epdw=
X-Google-Smtp-Source: AGHT+IEOT5xXGWdNvfDQNreEbDE2fIXiA0ElOhNl5gFlct2Dn9/6HfSzNT2X0our2pg7Lo1zqVH7UQ==
X-Received: by 2002:a05:600c:1c0a:b0:427:9f6c:e4bc with SMTP id 5b1f17b1804b1-42acca11e53mr35783945e9.5.1724609153076;
        Sun, 25 Aug 2024 11:05:53 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.222.82])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37311dca113sm6438736f8f.16.2024.08.25.11.05.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Aug 2024 11:05:52 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Sun, 25 Aug 2024 20:05:23 +0200
Subject: [PATCH 2/4] soc: versatile: realview: fix memory leak during
 device remove
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240825-soc-dev-fixes-v1-2-ff4b35abed83@linaro.org>
References: <20240825-soc-dev-fixes-v1-0-ff4b35abed83@linaro.org>
In-Reply-To: <20240825-soc-dev-fixes-v1-0-ff4b35abed83@linaro.org>
To: Linus Walleij <linus.walleij@linaro.org>, Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1269;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=gLo2MRTXsFeq02SUdCwpMzugi/rrrP2OWGn4eDr68Nw=;
 b=kA0DAAoBwTdm5oaLg9cByyZiAGbLcnij66rKNDQtIYEA/f6SQA3a3xsRiZyOLMcWfi9UNQw/9
 IkCMwQAAQoAHRYhBN3SYig9ERsjO264qME3ZuaGi4PXBQJmy3J4AAoJEME3ZuaGi4PXiaQP/36v
 XoZ+079iF8+XR3eHzzetL+GsXUMs7VVe8Z7VjIbpeWaqoiaCGLFlFjDWVQjJu9/wxPW5Fpi5qZb
 93SXGFvnX4nL8n3TyKzCWnLRN0zV0LUQmo87Wf27T/JpSD9FJ37vChPQKdxPrXL7ZlgwVgyKHNM
 i2CG6bt17mvx8xux1a+QBTmlHFzpYVBkRwHtwQLyp3S88q/QPseosKB841/9b0bSrO6gRwVp0j6
 gDd4xYZyEY2yCKRvJ/9ROQhXsrwMTcYPRC6VhLh1UwG5Uyk35e4+KE0dzO72fL7/F4vfN6m/Z7L
 VtenMv7B6zRR5beMseJKW/GlWMQiNfj+oSASbrZCd0qGOng0uPPnf1wiUXFrU/QuN68Bab4N5uM
 PLNkSTRj+E+C431Ol6ymM0NyZ9DdrctHOeWzSn6F0PVj5uAeBycy2wHLC1e8pquVOkui/mD7xc5
 vgu3dTsKu0OmPjuwmwM7kGph8hUO8UwDd/DvkQbcg8WOvloa0j7vBdlipbvf2WAliJKDb8vFTq6
 +9fwT554fce37h+MT0+6JtNUIY6u8pOU1kQ7nDfmPrSsW2zVOTO2aznPzkpOnXjnHR4LqqiJuWZ
 qM/caLV1KxpuT5QT9Nmff3YG8NAwvcoGjsWgkV4IwoJd4TCEOyDJ+PlEn5iGemw1xx0WMCwf4LC
 4sdAw
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

If device is unbound, the memory allocated for soc_dev_attr should be
freed to prevent leaks.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/soc/versatile/soc-realview.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/soc/versatile/soc-realview.c b/drivers/soc/versatile/soc-realview.c
index c6876d232d8f..d304ee69287a 100644
--- a/drivers/soc/versatile/soc-realview.c
+++ b/drivers/soc/versatile/soc-realview.c
@@ -93,7 +93,7 @@ static int realview_soc_probe(struct platform_device *pdev)
 	if (IS_ERR(syscon_regmap))
 		return PTR_ERR(syscon_regmap);
 
-	soc_dev_attr = kzalloc(sizeof(*soc_dev_attr), GFP_KERNEL);
+	soc_dev_attr = devm_kzalloc(&pdev->dev, sizeof(*soc_dev_attr), GFP_KERNEL);
 	if (!soc_dev_attr)
 		return -ENOMEM;
 
@@ -106,10 +106,9 @@ static int realview_soc_probe(struct platform_device *pdev)
 	soc_dev_attr->family = "Versatile";
 	soc_dev_attr->custom_attr_group = realview_groups[0];
 	soc_dev = soc_device_register(soc_dev_attr);
-	if (IS_ERR(soc_dev)) {
-		kfree(soc_dev_attr);
+	if (IS_ERR(soc_dev))
 		return -ENODEV;
-	}
+
 	ret = regmap_read(syscon_regmap, REALVIEW_SYS_ID_OFFSET,
 			  &realview_coreid);
 	if (ret)

-- 
2.43.0


