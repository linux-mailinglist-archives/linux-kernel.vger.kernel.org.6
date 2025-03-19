Return-Path: <linux-kernel+bounces-567331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3D17A684A2
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 06:38:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC197420AF5
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 05:38:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 928C924EF6F;
	Wed, 19 Mar 2025 05:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="s4/TiABS"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F3E20F060
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 05:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742362710; cv=none; b=I5vO255I/oCojkrmpNgNYJCIFeP3UG9/p5IddRA3qaWTOJVgEzJBxXiHMlYw/9eR9YzM+EYcdLE03JWJky8Smkrwx1TNjb8LhTsMBu7xr8lRt4hATf7SbDf8zOSET2has013Bqx/ohFJZTnl8CDQsWtb7gGkEO8jtpgbNXPPAR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742362710; c=relaxed/simple;
	bh=dYbD7ElbtMWIpFpO2nDHVLUAiljWLpzrUTfbbZi5d1E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lhTCObOeSHhKUEN2uKHTBGmKxbkjP0nOEr7pNrXJiUDZNqkQI9zdxiLFQIt5BLU9HTHq3hEQV3QKMTxOJRn+9jZ2X1/2aN40X5AuPRZOB1wjFi0kSW4QxI9itBrLvZm0WmdUx1KBejXiXUAY5A6/rGNN/83MtjqLH/851VKoPRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=s4/TiABS; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5e033c2f106so9065758a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 22:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742362706; x=1742967506; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Sus4gSJU+xZ+2CemlxDEjCXjhG8aiYHNZQAdXRIuTA0=;
        b=s4/TiABSlL7xkudnYgpV4ffy7tWa6pC88PK81xsL/ST76y7TAvGctOFc6w2RjkRzEe
         njxCVPUw5o0Njb2GAieMnquk7hqhHPWVgnrlytzMX3uSYJUZzhNmPLv2hC3NzY7NesGP
         +EPMsDzfC9F5c2Ctfw5rnGrWCuKUhWj/V7Wf/BjbU+Ma+ljkh2IFWoA0EPGf2qnWIpcj
         eJHQensgHr6VV/Ov4Rca6pPAv3/ALfW574VSQY75vRGfGocA/WTBALGS94kYzgV7M5Qu
         60wstPwVcH8XdxBh7Pvt39msviMgMoiQFBrMUlsLpr1XobDFrfuBrFmQ+qe5QWDmfQ1E
         k2Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742362706; x=1742967506;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sus4gSJU+xZ+2CemlxDEjCXjhG8aiYHNZQAdXRIuTA0=;
        b=oxHRrN5ZCXYLPZ1bvT16lWp3uWXbNoKksESDMWRJm5vx6P5f1FN84Uq/mHqCtzkfG8
         lzZkdlT+uyBojTLfcRfGApgsJZeN/LxzlADVLy9Y3sOOBdXOKybm06QVCvUpktnKcPIF
         okVIhqyUnFgvhMeSE6Md6yrOXu2WCmaVu9v1ZbnMoxIXsEBxcpNqkkmKlOrwyxXXtjN2
         lSvFW4yMTuxCN5TjfcxsKQBNM7ABVTMgRX6qw0fSQDqzcdiT/hFXPtysW0GP5UWVVpyx
         qhz53EFis0e24mS4zLD8ayY5SXJ65OLHGRIAtft1mtJp9g05Nj8xXeMUWxzK6C13mF72
         uR8w==
X-Forwarded-Encrypted: i=1; AJvYcCV6RgX1KZl8qCrmyR/pFgtRpw1N+YfAr4W0rL8+EkWN7S7qa9FrGu9E5/UIFk+JjQqDr/LBwS83KY6I6IQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0SEPRqOpfsxsz14wI09es48Tdz42w/xWkhehrdwQGHt0sJN5l
	TfBffIBZrkMBapq5L1m6b+nWwSktln/d/sUaJEPWihSZAjTPwBQf/ogDD/PhnT4=
X-Gm-Gg: ASbGncs7p6OlwCATYeiwjgutOY5h0sOc0JBKpIgXpiTRlnRaepoXdwdXfd+ngRyb/NH
	+W2cM32aVUzTltqPjAfIHaSIfMBjbDj+plCz8wGKzr061akkI9rl6xAciYcy9wfrgIOOPiOZXQo
	3Jd2zU3AcUzH+RcuvjyZXLoshXiQJYlOLEGdmD6G6p2+OZCyoNSEVfvOGNyvS29wEdkdhdzfzYy
	q+FIfKyGGpACiDtmSRFA60fu1kY83kxHupaeOsO6pwm4LyAonWyfef8KX4vohwJUIDGxONkUINP
	Ky7tu+3F5Nx58XFUbHKJnugx6oE+CjzlmEUrNTq3noHRNMe5Xw8JCYYwUpvaByQoe776P73A35G
	ubD14RZPRCJAoVWsmmBuNXjvof7Kv8xynBV1uZrw=
X-Google-Smtp-Source: AGHT+IHrn2C9WLboMGGXgsOlvqqsrQueINwlBYIC5HbnjUBRvOCY+qEiAJm+UPf+gUneCwQHFhXSew==
X-Received: by 2002:a05:6402:2106:b0:5de:dfde:c8b1 with SMTP id 4fb4d7f45d1cf-5eb80cca862mr1173125a12.4.1742362706356;
        Tue, 18 Mar 2025 22:38:26 -0700 (PDT)
Received: from puffmais.c.googlers.com (8.239.204.35.bc.googleusercontent.com. [35.204.239.8])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e81692e6d4sm8511817a12.9.2025.03.18.22.38.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 22:38:25 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Wed, 19 Mar 2025 05:38:24 +0000
Subject: [PATCH v2 2/2] firmware: exynos-acpm: silence EPROBE_DEFER error
 on boot
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250319-acpm-fixes-v2-2-ac2c1bcf322b@linaro.org>
References: <20250319-acpm-fixes-v2-0-ac2c1bcf322b@linaro.org>
In-Reply-To: <20250319-acpm-fixes-v2-0-ac2c1bcf322b@linaro.org>
To: Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>
Cc: Peter Griffin <peter.griffin@linaro.org>, 
 Will McVicker <willmcvicker@google.com>, kernel-team@android.com, 
 linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
X-Mailer: b4 0.14.2

This driver emits error messages when client drivers are trying to get
an interface handle to this driver here before this driver has
completed _probe().

Given this driver returns -EPROBE_DEFER in that case, this is not an
error and shouldn't be emitted to the log, similar to how
dev_err_probe() behaves, so just remove them.

This change also allows us to simplify the logic around releasing of
the acpm_np handle.

Fixes: a88927b534ba ("firmware: add Exynos ACPM protocol driver")
Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
issue is in linux-next only afaics at this stage, as driver is not
merged into Linus' tree yet
---
 drivers/firmware/samsung/exynos-acpm.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/firmware/samsung/exynos-acpm.c b/drivers/firmware/samsung/exynos-acpm.c
index a85b2dbdd9f0d7b1f327f54a0a283e4f32587a98..04c73692383b17ace33e95ce9534101bc68f089e 100644
--- a/drivers/firmware/samsung/exynos-acpm.c
+++ b/drivers/firmware/samsung/exynos-acpm.c
@@ -680,24 +680,17 @@ static const struct acpm_handle *acpm_get_by_phandle(struct device *dev,
 		return ERR_PTR(-ENODEV);
 
 	pdev = of_find_device_by_node(acpm_np);
-	if (!pdev) {
-		dev_err(dev, "Cannot find device node %s\n", acpm_np->name);
-		of_node_put(acpm_np);
-		return ERR_PTR(-EPROBE_DEFER);
-	}
-
 	of_node_put(acpm_np);
+	if (!pdev)
+		return ERR_PTR(-EPROBE_DEFER);
 
 	acpm = platform_get_drvdata(pdev);
 	if (!acpm) {
-		dev_err(dev, "Cannot get drvdata from %s\n",
-			dev_name(&pdev->dev));
 		platform_device_put(pdev);
 		return ERR_PTR(-EPROBE_DEFER);
 	}
 
 	if (!try_module_get(pdev->dev.driver->owner)) {
-		dev_err(dev, "Cannot get module reference.\n");
 		platform_device_put(pdev);
 		return ERR_PTR(-EPROBE_DEFER);
 	}

-- 
2.49.0.rc1.451.g8f38331e32-goog


