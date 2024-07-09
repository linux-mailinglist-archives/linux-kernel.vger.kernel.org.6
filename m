Return-Path: <linux-kernel+bounces-245841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02F2292BA55
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 15:02:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26AC51C23032
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 13:02:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8F901684A2;
	Tue,  9 Jul 2024 13:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jRXnZZRj"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4EB216C6A0
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 13:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720530011; cv=none; b=prcc2uFI0+1aF1PdvqBgK5p0qBG9Kx56EUZvp5f5udFprR6jIPpWsgVvGNKA2DOTeSVnVhF7EcLOX/D8IWj6MANgJWwV/3n6cnRPYfP6mdZ2FqY0YW7//1BAtVb57uk/XC2CuyJKplhmggHjNjLneRbHzcx2CTsYm628f7kbavE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720530011; c=relaxed/simple;
	bh=tbr6PgVNmRzkFl13kOpzZaHhhH1RUnpU3lH7vfxTRvg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=r1m/PdFAKVhxblp486QjtXME3yjYv483wvbOtqxZ/CwoY5+CrCdtERiAebQQSoxMZyWsKBhTH0/H+cNuIpGgVDbK5D11W9XVymWdQNZ0aiZs+wmfWex9A/sQ/X/NO2UQVcCSW9zfiQvxp1rBi28KHl1Qf81BLGNftdqoicLWP3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jRXnZZRj; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a77e6dd7f72so335332366b.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2024 06:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720530008; x=1721134808; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Gd8VbJ3ePG1fDwdnkHZrN6+gKJ9mBLGNqM6Qogu2910=;
        b=jRXnZZRj0sNah15/TCIcOrAk2WR1+mqUvhOqeDSlBuGh9Qx7dRFNqTfqAyzczRDtaI
         wTIBnoZpoe38jghCGyer7c+NFOHnTd54+nqxyPmuKBRcfIy1KjXuEKpDxYgGoTLhGVSt
         xMF5zV82bJChDSRIiuYCFtL4l13c7dcWmevCtZ3HFGghLiX4VFvIN9rx3ZBOfwr+hRnB
         3+JdooyXKqx/9WY+XfdKqRR6pg7Uup1NsA1Am5q79hhEoBcEO+FIz7jRy856IoSO1TjO
         c7qa/MGxCHvzDWq/d8wMaTkrDJNb9zb8Fe8VQet7px6wfS8s+/HPMoMVueWMaz8O8S+D
         HrOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720530008; x=1721134808;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gd8VbJ3ePG1fDwdnkHZrN6+gKJ9mBLGNqM6Qogu2910=;
        b=myI5SoG2jyAmenv6JcNBGoq3KdUkF7bfxzzDgeHIaxXm7aLMeLGISuC8E6MNOfqkNW
         JAhCihojskiq7X292IEgx1jCK5VAvQ45J27+xvltejKcQ7NDOoEl2wh69FxhFyN9u+Oy
         /zSAhy3PZchQ3Dj5Fp4kNlsH3dD96p8u0SQ1hpnfBcmTiiGCLc5KB/sGbAAv4//Kh4Jm
         lfPz8ZIXdaMpvCcD9CG4c1Wv2YdOr/U3+VTiMeiZizJFqhVimOpeLy7wUWQLhlCv0gzG
         jAb/rUetXpN1m0U5F/Gr3PnlpdxSm4Z3LUyMfoeFTx4LpmGa0QuHh6gfncV6dUYXFTGc
         eD7g==
X-Forwarded-Encrypted: i=1; AJvYcCVWf2pXlv3vO1E/w03dbmEsrRH2YM1KrMDy6FaGFCuUlqNlHiQGHlt3I+Pmxf6VLbpHaazFbv5EtYs3k9pchv9wrLHm2QvJXHKjALTG
X-Gm-Message-State: AOJu0YzAoyjEmtmwkKLZhRt5K/NEipO4J/f97OTkUTqLmhQngMeFI8/o
	Ha3KDyC7P06Ma6CiLNXn6iNCyoEFAZLaH6PTontwqgOZ0JFRgMgmVBQ695afJ/8=
X-Google-Smtp-Source: AGHT+IEjW/UsJohNSfeBsSugxbsviw/3TGejetmmkt90XFqWU53RnQehbG4JwQcqefAPiYe5iS5BSw==
X-Received: by 2002:a17:906:4715:b0:a77:c525:5c70 with SMTP id a640c23a62f3a-a780b6b1901mr177894266b.32.1720530008418;
        Tue, 09 Jul 2024 06:00:08 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a780a6e157bsm76643166b.80.2024.07.09.06.00.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 06:00:07 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Tue, 09 Jul 2024 14:59:38 +0200
Subject: [PATCH 08/12] thermal/drivers/imx: simplify with dev_err_probe()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240709-thermal-probe-v1-8-241644e2b6e0@linaro.org>
References: <20240709-thermal-probe-v1-0-241644e2b6e0@linaro.org>
In-Reply-To: <20240709-thermal-probe-v1-0-241644e2b6e0@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Amit Kucheria <amitk@kernel.org>, 
 Thara Gopinath <thara.gopinath@gmail.com>
Cc: linux-pm@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-samsung-soc@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-msm@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=860;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=tbr6PgVNmRzkFl13kOpzZaHhhH1RUnpU3lH7vfxTRvg=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmjTRDz6ULAooyIR/nRlEWHSnnlmjdSZ27//W+I
 SA+eptt/ICJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZo00QwAKCRDBN2bmhouD
 18ObD/9y04bIJtYRViQ9nSmrQCT/Z+mpv9+By83hpVNivTpZFLo7X8j/m3es1Qyl47e1LALCIhR
 1PoBYYYc08ic70bYofzLn021hBdarIWbETDTWaUWnZEzYq7D5gVtaESAPW886+9QfegseTa/zfF
 Llw37q8hOvQLlfxBY3ev9Alwwq3MJDzWYUkVjy4G5kLChtPglSU/Uyjpr8wBkSTlhB5QRJT6pL1
 oUYaAh+6R/brIWgvGBO362D3FT4T8h4g9/0Nt5Od+UFbhKT3UIWyymmip8XpP4N+Gls5ncV69TN
 kDfJsQNrrbfHAZa9DyqdLMKaVWAWGMrKNsdHl2PAc6m6wH7xvDRbkFpstRhSgsprC+n/Ee5+znq
 UPkhh3bs+qdYtz8ClFuVjQu3CYcnwklAbf7bbUVticdukTNt2s3QUtu7gOyC/kjJAmnWfJtlJ42
 8752DAdOe/aDz8VZGjxLAKfRZSrPKPOJ+JU+AiwBx5Z4SdHPaf9DUuaKs32DKjPNpJ3nP88JGv0
 /Dyi2loHDCxJtagwisIoFgvNOOQfUWzJdLBa2S68arOgq8jfABTo7byEvx790PwTuWD5hxXkaV/
 fj/5iuQ9RFc4Her0dpjLSXHGxcrPWG8vDFxT+wIhyzSdDvTK+qPUe9SNAA4AQ/Ft4IU5ZSYijBI
 fi85lsTR8VGHGpQ==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Error handling in probe() can be a bit simpler with dev_err_probe().

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/thermal/imx_thermal.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/thermal/imx_thermal.c b/drivers/thermal/imx_thermal.c
index 05c24be5343f..432d21cbd2b3 100644
--- a/drivers/thermal/imx_thermal.c
+++ b/drivers/thermal/imx_thermal.c
@@ -679,9 +679,7 @@ static int imx_thermal_probe(struct platform_device *pdev)
 
 	data->thermal_clk = devm_clk_get(dev, NULL);
 	if (IS_ERR(data->thermal_clk)) {
-		ret = PTR_ERR(data->thermal_clk);
-		if (ret != -EPROBE_DEFER)
-			dev_err(dev, "failed to get thermal clk: %d\n", ret);
+		ret = dev_err_probe(dev, PTR_ERR(data->thermal_clk), "failed to get thermal clk\n");
 		goto legacy_cleanup;
 	}
 

-- 
2.43.0


