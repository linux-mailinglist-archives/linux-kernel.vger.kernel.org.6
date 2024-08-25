Return-Path: <linux-kernel+bounces-300452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 008D195E3CD
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 16:15:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 68D6AB216A7
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 14:15:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49FEA16F84A;
	Sun, 25 Aug 2024 14:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eww/IuEp"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA4815B56E
	for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2024 14:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724595281; cv=none; b=uFhkVZYYjClSOzhY+F+UT6B24VOf5DNXhAuc3V2hNTqMi+H6kwHizDL3s7y+y2IIcx2s3Dz2JdfEkpWkuszRvepoPTUTi5jyDiTG66iB+XH/1Q/l0A8ILwvbtEcvHshGOWhIMbPoU6TMbp73pG9h2QIQgMIV4KNptUR4ddChBO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724595281; c=relaxed/simple;
	bh=Y2ICy6i8eJmrbEAyf3hyy7lpPTY6kTvT6Il6a4okjDE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ryX22i6PFlVu1ulV3TqKBXFditPO2dOKpxBjCk4NclbSz4p7JoDNbzfanGWpxePIuth/Bny5SDlU+JbgDI2GWqPKCiJdrTkfR5sy3ftKNdVpmLSj/ImTl3d0iqHiZja6oEsfByI96uuWbxny9QFqpOp1VNQkojzLTJ2QOGeiPRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eww/IuEp; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-428e09ee91eso4317285e9.3
        for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2024 07:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724595278; x=1725200078; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LjmDAWPerVk/U3QbJF8rREKJaY7hIybSzXq0JV4YLzI=;
        b=eww/IuEp7BpQMYf1YilnRXxodzmQioe8oNFoRjtEP3j3IxX18JkEbaJNpMN7mOQmct
         Gngco0KCd+8uPONwFtPAp2m0ILX6LcBdHPmhMm9NPXfGuleDqEMKGOigEX541naylBvA
         SKp5BZNHDdNAtyNLk0RGuiWDeUjdSbGh3Fb0ul+FyK+XSZZ05u/lp/aYW4tQ8TN2DJb2
         gKG4sjswB7HqWrbgJ4lkFS1LO/rLUnz+GqZSnH3KI4bSShayvcnXOjAVtmS83Yt4zGFJ
         718h9YiCQmAGk1bw7iIEMFmQTZEGl5+lsKz/cdHXjUtmrumUCBLFhqwAoRFGdj+iA8gB
         ohIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724595278; x=1725200078;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LjmDAWPerVk/U3QbJF8rREKJaY7hIybSzXq0JV4YLzI=;
        b=LEGX8x5hQuGElol6gr0wZ2TDhex5jVQ8+qQEpI3gBzNPF7Ipdcr7yrLPPWqBvBKfrw
         9r7VwoHT0IGOntMWt6C830rdxEJkaXq+jTeRXyn0ix1S7Prk9nTU7onvl+fGZsi0S7B/
         HxSrOj3s/wkOsBH9Y2sgDHs14MWXoBugEy7G9I8rdkRd1Ut2HRgYJhIhpYhpaNXVgCkI
         9NGoxa+HDaxkDLHccZn3Xa4TvL6LWcMs5y/3dttQJyv6OuS9yF81vkqRunZl9XKKMv2z
         Vr1QZbf14yVYNV1tRrm/kqH9yf0HUK66BSO5lr0Ei34YbTHXrXOGhPpIOmvQWPKB7Mzr
         c59g==
X-Gm-Message-State: AOJu0Yy+5Jo7wGmN9l6tjOUmojaIeNIcq3oUYLYaKe58asf6QaBaqxvT
	am8umSsPDT3CvbFXF4NlhP5ybhl5uJSD+qJYAEFhCxGl+WLylgkw6/LBrzX/2y4=
X-Google-Smtp-Source: AGHT+IH4oX5sMG/q4v+zj6KRXeT4WvXHszuUwi0hhOxdOeHlPtcZUnDMGObVsUyIcqEn+TKymiOIXQ==
X-Received: by 2002:a05:600c:511a:b0:427:9f71:16bb with SMTP id 5b1f17b1804b1-42acca17489mr32308195e9.6.1724595278034;
        Sun, 25 Aug 2024 07:14:38 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.222.82])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ac5162347sm122556045e9.23.2024.08.25.07.14.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Aug 2024 07:14:37 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Sun, 25 Aug 2024 16:14:27 +0200
Subject: [PATCH 4/5] reset: lpc18xx: simplify with dev_err_probe()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240825-reset-cleanup-scoped-v1-4-03f6d834f8c0@linaro.org>
References: <20240825-reset-cleanup-scoped-v1-0-03f6d834f8c0@linaro.org>
In-Reply-To: <20240825-reset-cleanup-scoped-v1-0-03f6d834f8c0@linaro.org>
To: Philipp Zabel <p.zabel@pengutronix.de>, 
 Antoine Tenart <atenart@kernel.org>, 
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, 
 Damien Le Moal <dlemoal@kernel.org>, 
 Palmer Dabbelt <palmerdabbelt@google.com>, 
 Vladimir Zapolskiy <vz@mleia.com>
Cc: linux-kernel@vger.kernel.org, Damien Le Moal <damien.lemoal@wdc.com>, 
 linux-riscv@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1258;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=Y2ICy6i8eJmrbEAyf3hyy7lpPTY6kTvT6Il6a4okjDE=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmyzxFI6hGTgYTOceLNliLoQr+EYniA1tKa5FfQ
 hePW63+vNOJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZss8RQAKCRDBN2bmhouD
 17zzEACJcEdPayjkZvjjh2zSab3uEfc5NqZ4zTN6mSFqJoL5NzpvECKDgVsGtZwP2ra2wuQgDbc
 B5dfhfLe3E+Y735zsz4tHVXpY+PxkNZC8GSEVyl2Ox48Jz0reWf17m199ANdf30Wx2GXs/VKvit
 S/2SwK7rwLXJIVYEWADM6VMNbyGQjVfM6H1fVzpkCwEFWyuofywykuRlPszFT7wWwAOYhiWd57d
 m3PZjW4FICPbwLWDnwidm1cWe3dkeZrg46zVHTgP4JOiZHTca6a016dcRh63UjzG6TtbgUsltCg
 eIfyqzmHVS3ncCxx7uayrxoMcFQdKEXk5DmpX5oYotPp54PF8v5wFDw4sXuDfghny98AMwrer0x
 h4y/OoviFaO/wVVPLGeyQIA8/LnYdCqaYN9B6axrS3Lb4I/5hEWi7vh24Sf8DfhfGysMBwNPfX8
 XzUuRkxphPFewdQp0RF+EfNbrFYOCViaHdlcQFEOrz6PkIzUC8Z2yoQPCNPJgmS8K+Cu53oYSBL
 mqmyD0U+++0K4lJSG7D6spDq/ClqaWE+PwwzR43K5HU6oY8gPAJlmIroZ/wZy8OZVG9Kl+bPapY
 iGzqFEFYtnXXO/IY9yhxytGqXD6lKeruYOwmy6JWYrFLDvOxQz4o83ASiJm/a3MHFFMDxpzwTp1
 2Ag8sVPJwTGJSaw==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Use dev_err_probe() to avoid dmesg flood on actual defer.  This makes
the code also simpler.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/reset/reset-lpc18xx.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/reset/reset-lpc18xx.c b/drivers/reset/reset-lpc18xx.c
index 28fb85772b3e..e7896e3f1851 100644
--- a/drivers/reset/reset-lpc18xx.c
+++ b/drivers/reset/reset-lpc18xx.c
@@ -151,16 +151,14 @@ static int lpc18xx_rgu_probe(struct platform_device *pdev)
 		return PTR_ERR(rc->base);
 
 	rc->clk_reg = devm_clk_get(&pdev->dev, "reg");
-	if (IS_ERR(rc->clk_reg)) {
-		dev_err(&pdev->dev, "reg clock not found\n");
-		return PTR_ERR(rc->clk_reg);
-	}
+	if (IS_ERR(rc->clk_reg))
+		return dev_err_probe(&pdev->dev, PTR_ERR(rc->clk_reg),
+				     "reg clock not found\n");
 
 	rc->clk_delay = devm_clk_get(&pdev->dev, "delay");
-	if (IS_ERR(rc->clk_delay)) {
-		dev_err(&pdev->dev, "delay clock not found\n");
-		return PTR_ERR(rc->clk_delay);
-	}
+	if (IS_ERR(rc->clk_delay))
+		return dev_err_probe(&pdev->dev, PTR_ERR(rc->clk_delay),
+				     "delay clock not found\n");
 
 	ret = clk_prepare_enable(rc->clk_reg);
 	if (ret) {

-- 
2.43.0


