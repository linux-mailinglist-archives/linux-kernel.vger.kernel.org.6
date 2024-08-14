Return-Path: <linux-kernel+bounces-287120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E5CE952341
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 22:19:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1707228486E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 20:19:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0D781C9EB1;
	Wed, 14 Aug 2024 20:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CFohQz2r"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 321A81C8FC7
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 20:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723666695; cv=none; b=Rjnh4QU2p7b7Z359wxzN53Gmh2IBdOVkPctDUa6JXrJ6kIQI8kfzDqlXlInMIT/itMjb+lvJFY/AoLvX+kskeNMTfheVlaMQpor4ucy1NjjdIITfbhFAqXc7UwQR9qReVZ7+Sbk9SYWv1tmvNuv95l1Zt10OiJYHogTa6O8C2ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723666695; c=relaxed/simple;
	bh=YQ77G+F6IdQNQWI9oMD9x5sylTEBbYeJ2k7ilgFPfQ8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fs0eK8vo8cP6ZV8ll+GPYpISEROnzt3ev76KZoDcBxcFzqzGVXK5+ak8j/GiTmXo1Ly906ELzPcvEoZpA44ESVjp38svgr67AiHX2GfCWcEJbfyRs2zY/lE6DsAgwdOGc1sfPxzxT/Yc1nhJlF8XC8ylKqmpQcBv+a8nfiXevPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CFohQz2r; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-52f00ad303aso280733e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 13:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723666692; x=1724271492; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xkjRZzLoJToCwZbViB8DmZ/xiQRM8hrpZD3XvSuNVwg=;
        b=CFohQz2r6/xhEowlDfk/AnHpdJJjNFZg3OuUAy9hf6JuVBxlGJ/eHs7LzxMc/6IB9s
         Ri267SAQ/ZOdzkuN3MC7F9l63v66TNyYPe3rkjOw66XO4/LHAvss04FajC+hUISXBuJd
         JamB7XQ3nfQ7zyfR+VelC9YoXlPBwHSuI1vXvg5I6fChp8UK5lWKQYmBLExQjXwzTUzu
         ibvWGJc6rOjGRGfV132ilHHL/x4bVpew/PjlXhgwtj565O+KgpHa/tDDVbn+ahzbbz0T
         yox7UOcDTQwl16R87dOUnSr6cY5CPsZhdXwTsk+MxlYC9N8FeQq/SyErP8hssvF9RFwF
         gXWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723666692; x=1724271492;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xkjRZzLoJToCwZbViB8DmZ/xiQRM8hrpZD3XvSuNVwg=;
        b=tT0mmrmtwBEeT9lOkcoURwAlWWNOhbD4pVr86TCZqBxwpnfbkBMnzIBNgmLVoLB5/u
         F25zg70D6dq8MLRa5sn9Pr4/MAQfk31GvUX0aj3oW6RtSjYuG0B10ht4HYdH4EgiQG9x
         NBOmfkN6B2PO33H+2exjQtuqrhg3wjqQ1DkaYqGyDOhjvbXR3XVaiUcOfc5x7eJelPD0
         mtOu/ZkdLYeIi9ubP0MUanaIla+GcT2dg2sUP+mKOU6Nd0Egx364b0oTD2u/2XvoHfZ0
         VHQDQm5c9/N0pdoTLkCyy/x7XwnX3QRr+SGFvaPdtiTSmICUsKSfsJRHs40kWlIGZjqY
         2lAA==
X-Forwarded-Encrypted: i=1; AJvYcCXezuoz/lBFySKsx4wknQMpVgs2oRTZKiUkiENMyl3JPSMk1dmbcd9tkyJvdK/BnS8B3KM2bAGAP6yl5wuuDhBRM8t1bK2kkIkkTaNP
X-Gm-Message-State: AOJu0YwL9qP3bAk/5ds+S5Wr9NyUxmFnEYhQVerh0TtUvXFvfPj7Amqo
	QCFgVa8IigqIRWUG0Hn6kS8f8mUqzKy2mX1JNRxux1SyNv6EeJN8/KyD8ERYMXM=
X-Google-Smtp-Source: AGHT+IFBLTnGcya0gyF2QoAkwGE5TeVPZhJdxyZd9UXhkVvIm94NnLeJ+A7P0NhL9HSJ7hPR3FSg7g==
X-Received: by 2002:a05:6512:401f:b0:52c:daa7:8975 with SMTP id 2adb3069b0e04-532eda6bdbbmr2880373e87.18.1723666691633;
        Wed, 14 Aug 2024 13:18:11 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.215.209])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36e4ebd3631sm13623519f8f.110.2024.08.14.13.18.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 13:18:11 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 14 Aug 2024 22:17:52 +0200
Subject: [PATCH 6/7] thermal: tegra: Simplify with scoped for each OF child
 loop
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240814-b4-cleanup-h-of-node-put-thermal-v1-6-7a1381e1627e@linaro.org>
References: <20240814-b4-cleanup-h-of-node-put-thermal-v1-0-7a1381e1627e@linaro.org>
In-Reply-To: <20240814-b4-cleanup-h-of-node-put-thermal-v1-0-7a1381e1627e@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Amit Kucheria <amitk@kernel.org>, 
 Thara Gopinath <thara.gopinath@gmail.com>, 
 Thierry Reding <thierry.reding@gmail.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>, 
 Vasily Khoruzhick <anarsoul@gmail.com>, Yangtao Li <tiny.windzz@gmail.com>, 
 Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-tegra@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1312;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=YQ77G+F6IdQNQWI9oMD9x5sylTEBbYeJ2k7ilgFPfQ8=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmvRD0Uv2gIpoxw3AgnRAtAC5oTD5MfWuAAy6MR
 qcBoFqy1iuJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZr0Q9AAKCRDBN2bmhouD
 19dHD/9eRslHl0yrXWMvonXIYEU5aEQSHMM0XgCRLTnVked6pf6HwBPQGeyaYpOayo+jBu1YaoN
 9ggsn1t9lMMffIn1oBi2S4rrPBhHyyP8UrDhJDupL792vu/KFAs6/HLUK4ah9609D95mfv2ePtB
 8XpC/8F6zROMEiF2VgkadRRC3JMHdQJuaALjSa1wkq6ZSdlnVgR6FNjrqcxyZvfT/vALKcWg0fP
 eJVPuxGSWYsM+eNaKHOSXQxmiPIl5aPLX9WNF8AarOA0QcE9ZespUnNU7zVt7H5Vd6oub82wQKS
 CPfDaz04mWXZGKo8SDcQiv1rIH5i9tVBVD45rhfVf+p6W9xrgtpM9R5nRiOp3l8ZlYUmjFOeKba
 1VCvSMI/+FS79wS9DXlucXO2rLT/R00sYiw0/LZxfYYV4Fa/qiv1cMojSs8q1UBlrL2FU1afl4L
 /Mhsk+jpNgxZ6BurlyqyuTwF8m51/MAFUpqtJg3iETODr9Wr37h2CYbY6tN+TR/vzps87QYhXeL
 +bGDk90v/GXw/rApcyVhu4R9TBqQ4eaz5GwGMwrv8XnmIgTevChp5lW/X8s6JFqHf1lXbZsGeXi
 nYNqRcsj4LaLtiQkubKHuD3DD2Hu/geb+8TeewAzL0k5u1j7nPgeScyABlkiPWJime+1PMpB3La
 nRb2h2ztHHppy6w==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Use scoped for_each_child_of_node_scoped() when iterating over device
nodes to make code a bit simpler.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/thermal/tegra/soctherm.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/tegra/soctherm.c b/drivers/thermal/tegra/soctherm.c
index a023c948afbd..ff4eedb553fb 100644
--- a/drivers/thermal/tegra/soctherm.c
+++ b/drivers/thermal/tegra/soctherm.c
@@ -1651,7 +1651,7 @@ static void soctherm_init_hw_throt_cdev(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct tegra_soctherm *ts = dev_get_drvdata(dev);
-	struct device_node *np_stc, *np_stcc;
+	struct device_node *np_stc;
 	const char *name;
 	int i;
 
@@ -1668,7 +1668,7 @@ static void soctherm_init_hw_throt_cdev(struct platform_device *pdev)
 		return;
 	}
 
-	for_each_child_of_node(np_stc, np_stcc) {
+	for_each_child_of_node_scoped(np_stc, np_stcc) {
 		struct soctherm_throt_cfg *stc;
 		struct thermal_cooling_device *tcd;
 		int err;
@@ -1683,7 +1683,6 @@ static void soctherm_init_hw_throt_cdev(struct platform_device *pdev)
 
 		if (stc->init) {
 			dev_err(dev, "throttle-cfg: %s: redefined!\n", name);
-			of_node_put(np_stcc);
 			break;
 		}
 

-- 
2.43.0


