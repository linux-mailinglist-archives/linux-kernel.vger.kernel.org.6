Return-Path: <linux-kernel+bounces-561181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87B69A60E5F
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 11:12:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C394517F1EC
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 10:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63C9E1F3B9C;
	Fri, 14 Mar 2025 10:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gOkoCSjL"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 629DF1F560B
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 10:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741947076; cv=none; b=BOk+Rn11c3M+Jo5RSg7hiQvsqjBjYQSO3vGYDf1z0uPQO/TtEakyPhFmRG6SycBQbmoeIb7EJymxdq+36b9KrVPrakzAQz3cp+2P3M2F9KW3FIJMq3yeCBuHt7uBJp1+kDJPrVCiXVuQ+ukrOMhEeki1xqAfGr1V2npzQamE4Gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741947076; c=relaxed/simple;
	bh=3ahzH7sLMBPla+F2Y8AvwvjAYSJ5VvM8xfAY5mAjYis=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=c2Fy5xiJ5Vo36fFFFGlRix+Sk4Jhi7uEb23m44FeZPscE8Eu4Oou5GHfeubwfG8qkYBpYdLJnTp+AorBU/7ynNEJIldGDGVaHBEGWz71VvWZhJ577eQY/hTDRHh0Mn/K7sNt35Kj+xNKeNHk30vS78Y41Axk1OuQAjt7OrEupNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gOkoCSjL; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43d0782d787so17894715e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 03:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741947073; x=1742551873; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yaoaIY6mq6HjtY7Y1s7vhYdY4pp2YI7DLVfhzEAcBtQ=;
        b=gOkoCSjLCUWrZCYIPDCFuPq6s46O0vg4d/nytOiZPDRT4J3ICCqWSAfZ/WPR8/yGT5
         TGg4s+e9tunM0nqgtEcR17YMz5PPc+AuwiaefWKJVrZag+J2oH4BAHOf7HD2SY0Wlg62
         YZcTvJXidf5tAPZbjA242Tua4dDNlX9F06ML9wUwcnklDOTGhxGqdZ9jABC+qmBM+Gld
         NoSiV3/XaN6AA5u4vCei+SenXswKKAI+pwJ8VWouTQmdA0X7T4/Pi5aAtBJfwBr/wzr8
         T8uWEBJTq/yetlU5ePGAMnaVnaBy8N1QHJWxouXs+QsOmDBmJ+5A2l6vjGpenDtSxF3H
         bGOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741947073; x=1742551873;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yaoaIY6mq6HjtY7Y1s7vhYdY4pp2YI7DLVfhzEAcBtQ=;
        b=uKthVVMZTbh6p37PSdH+SmwdJJoAvhb6vAXnvrs85pbn55R5iwW2O37sorTT6yKRsD
         bW7rH/cMPtydQp5gHX4wP0kXohhOMCiV7dQvmpB0OHmW4DtmzqfJG+Fg8pAQIhuIi8k3
         cRb66CjQTPKkFm/Qn4Wao64jnHFgeyrZ0GC9hYUuWdC96PI5Iv5shcSKwSu3XV+Yxzqf
         yP2MNeoc2TzlvOPoSfZclMh/tr82xqCcGq7KFTp2/edoQTZPxVwDMq83w0yQN95sbqk1
         tA4FBBJqMtudAfsjIngWzNanhkV8uZVwW1KdHnIeddM5GC2aU8U8kWbWEhhpJQ+66wxp
         lOgg==
X-Forwarded-Encrypted: i=1; AJvYcCXWnKHCx3FiKefMKXxvjNUdJrDPA9bSdsVOxvWRSvD1dY+McR79L+MGmp7CSjD+/Xf3wCZTKWWzMxpx7pE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3lcKeN+o1GjHa884Ne0GBEssRcNBO0GuGje6Prit3vgFKx72N
	npbN9O9He/vQL0TYAv+RWE6b4VQ+NDSKI6pAd8Zaa1Qs7K3drMTBwKt3IBlwp9I=
X-Gm-Gg: ASbGncv1yVP848gbWqs1I4kLsVTOHzOWPJIplbFx5ptVun1+/1sI1P0X8e9DdC/1Bts
	WsT/MOXX4lJj0rQD9+Wa82fFMOr6cH+g/rC+Q10fLAX2lxlPurYOoqThsuIwwtdkyOyDyNiA89K
	m+7X46U9UogI5AuvMFVZkwqT1IcyUElpMbs5YvJ7n4DBCrFDm1HY0tT1FAJ15G6qgdB77VvmAwn
	tlSMZYa9XRTx0GFgFo90DaJL5kXJkD/TP/Yh2eJZ1c2EXDK+XFYvgESVEuIPxa4TIQoSynfgkMJ
	Fq6z8Xdcuyp+slGhvQiW2tftk15k5wbHj4EwOVxqiQelcBoeZg==
X-Google-Smtp-Source: AGHT+IEZV7Q1QnjasExKNihgSsImAvSjr+KfxLj4uhGOe3kxwV0Balcqir0mcbZRaWbeyfUh4B2wSQ==
X-Received: by 2002:a5d:64cf:0:b0:38f:2efb:b829 with SMTP id ffacd0b85a97d-3971f5113f7mr2060911f8f.50.1741947072761;
        Fri, 14 Mar 2025 03:11:12 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-395cb40fa30sm5082312f8f.68.2025.03.14.03.11.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 03:11:12 -0700 (PDT)
Date: Fri, 14 Mar 2025 13:11:09 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH next] mmc: renesas_sdhi: fix error code in
 renesas_sdhi_probe()
Message-ID: <dc39e555-8ef7-4a39-9253-65bcf3e50c01@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

If devm_regulator_register() fails then propagate the error code.  Don't
return success.

Fixes: fae80a99dc03 ("mmc: renesas_sdhi: Add support for RZ/G3E SoC")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/mmc/host/renesas_sdhi_core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
index 396fa2816a15..fa6526be3638 100644
--- a/drivers/mmc/host/renesas_sdhi_core.c
+++ b/drivers/mmc/host/renesas_sdhi_core.c
@@ -1178,6 +1178,7 @@ int renesas_sdhi_probe(struct platform_device *pdev,
 		of_node_put(rcfg.of_node);
 		if (IS_ERR(rdev)) {
 			dev_err(dev, "regulator register failed err=%ld", PTR_ERR(rdev));
+			ret = PTR_ERR(rdev);
 			goto efree;
 		}
 		priv->rdev = rdev;
-- 
2.47.2


