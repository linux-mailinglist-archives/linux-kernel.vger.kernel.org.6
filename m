Return-Path: <linux-kernel+bounces-203876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 331038FE182
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 10:50:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E71B1C23BC4
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 08:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4CD8143728;
	Thu,  6 Jun 2024 08:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uGEgR/Ph"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00AA613E04C
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 08:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717663706; cv=none; b=SYNaq9BMU2g0pGHFFqOIPxHr3ymvBOMf7xt9so5ont+ATvXFbSRjA4ZS1tGbT3pKdmMOzRb9jdGoF9PUheTp45bYwKbIXqbfQEvp8ISlYVyeFoK0ZwkGYWWU8T3bhnJj0xVFbpW80ip/eton+9gSDRadDyvqLN262S+A6neCT/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717663706; c=relaxed/simple;
	bh=JAb6Muut5KHcHBna9lqyRERkBmnN5hdIffo6dmjjMoM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XwNGgD+WltDWEK9eUDNmCvSC4Bd9AQrVf7PhYjDMrLiyoUj9C8NLDHHej4KPjhKmmvPYh068n8CKTKCS2ysclGKBWraw+uEjaKTBZM2Q+luNVq8frY+/zMHmbnFaLUnEe+7eFgywkpA7QGH1DDt9IayEEq7Sb1QJsEM4kcg7FlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uGEgR/Ph; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4214fe0067fso8117825e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 01:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717663703; x=1718268503; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=whthHnnAV0riUU9YI5GKHGEVmsmBElqPPF6sWdWzQJE=;
        b=uGEgR/PhQn9z6cTE7bcqA3H2nZasZZUW00+Bx9FSdBnVfeLasIXziScDI2mgJSiZ6w
         LMNJ/J7n3wBHDtxSibyU/H0PcxK8VNVQi8l++RqvlZHQLZ8fvuEgSW1nFBQ3+xhJ4KrE
         U5vDOD8NdSr2QdAYcc9h97IIKG0dP47elQjVWgfDCBjWujzf7aMA1HpJvu8dvBa2YvIY
         tx0nFn0QGXcwUjE0uPsDxwHnFRxKJEBjcUDd3saf9ra1aHWZomnQDltO+m3qfDzGTkkT
         8VEQnoFYeYB2gY0PiYmzX93pPL82M/1sqHaTpg+Wiya1/3wdQPLoiDPm5MW7XvmhNcLr
         6GFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717663703; x=1718268503;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=whthHnnAV0riUU9YI5GKHGEVmsmBElqPPF6sWdWzQJE=;
        b=b9XRh8ButkulgjUlWz0pzWIdcO3SdlnDdqKB2+f4g9YUnMSuxgYrhPA6I/NQHBMdRx
         ZZwKuRF0Qcj3uBXS2YohOdZ3ZnJVlL7odzv2vHnU2x7vG9uOtxAHxLlWdfUaj/bDs/FO
         tc2Ro80u3cadHmqBkqHWrQAhpQsDIwinsRBHClwvymGny9mee411LKsqOzfTyu/YLhQS
         E9Rgbm2GDdod+ekySCeeni5WgBvweEXKJL8u9Gg277w99N5JfOziR5Z5pf8dAyAncNQk
         CTZykaJ47yVUJNqwkSNv+AKzEfRS/hCxi/1V7y09d1ua044ONEJVYB8uy3L1oVRo68EX
         LA+w==
X-Forwarded-Encrypted: i=1; AJvYcCV+4BNlGhG0zN3cbljpN1HxmqARP6VKR/4YRxbHQP0c/va3Z6bwgolFHIqGc/NM7BRg2vbpOdthEKU1600jEzRU7frRdp2caqe3UQDU
X-Gm-Message-State: AOJu0YwrTGBUxbFXRAHd4kihq/+7uXfjnnzyAi9FG1O5LhJD79uIWpD3
	Is7QYuAVPoPBr8QNkN5jSo6BbF/YEY42r5oTKbYfIw1+cbL7YvwSaqbQwxBbVaxhJPHBJqA2pUG
	o
X-Google-Smtp-Source: AGHT+IHu9gterr3sxhxkdqJc5Qs+YCT5HRh4tbwy1mr9JObTnqFltnf5YOEZ1L7+4uLq7kG+fY0Zsw==
X-Received: by 2002:a05:600c:3108:b0:419:d5cd:5ba with SMTP id 5b1f17b1804b1-421562c7de5mr43085835e9.7.1717663703498;
        Thu, 06 Jun 2024 01:48:23 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4215c2c690dsm14227445e9.34.2024.06.06.01.48.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 01:48:23 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Thu, 06 Jun 2024 10:48:16 +0200
Subject: [PATCH 09/12] arm64: dts: amlogic: c3: use correct compatible for
 gpio_intc node
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240606-topic-amlogic-upstream-bindings-fixes-dts-v1-9-62e812729541@linaro.org>
References: <20240606-topic-amlogic-upstream-bindings-fixes-dts-v1-0-62e812729541@linaro.org>
In-Reply-To: <20240606-topic-amlogic-upstream-bindings-fixes-dts-v1-0-62e812729541@linaro.org>
To: Kevin Hilman <khilman@baylibre.com>, 
 Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1360;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=JAb6Muut5KHcHBna9lqyRERkBmnN5hdIffo6dmjjMoM=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBmYXfNVIBKe2IvSZ6gQuVXIN5vKTJ3pwx4qJvciHA0
 3AAwnYCJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZmF3zQAKCRB33NvayMhJ0QqjD/
 98Nzxe2ojQV6/tCKNgn41bVNKl6EeN2XuOF8cgyikF4ikKDLr3ZXy2up1mw7VOhMf01UbwSjgr1C4P
 piW84JnlGWrLfXCpayYik2PNUIdiukP0GML4QSFI3ocSm4R3X8Ckym73SJ0OiPSmrZ+RLk1VjMle3Y
 S1+Woo5F8rZyqTm7dsUU6zrc9QALRO+Kq8YxJGDsjtgtCvIg77bfVxeEc6NuIhPLJLM0aofdPX1xsL
 rvnbM/3srKQJowTvAHnLJ/zwqH7bkjUWMQtBs4VeOW5RxRSZ26GATIOnFMzxWYCPgZflqGm4vYjQrG
 5b+FwpjdiLceVA9K3bOVzexw5ZQShZlq+CNkurR71kKkKtUHtqAui4ZhlhhJAFHLR6deX9pkEa6rgl
 Pz9iQkbeEcFZVv8koL2ayhN4h8TNvZ3J9Ea5U7vE/nNHE/1QugpUhPg6uB8KMU6u4gP08ScHoWapCP
 SFHCwJJ686Syjqs1v4teMvOlxosixnc3UKc5ehxN8kE7K15z/ulxkMkP6SoRaG2n4nc7WVOvBQDDZx
 5Dm32dCvBr4cyUu/4pUu+lyCOw/gyC5YYEwie3Dmzj3Aju7kmo0owozHrCJAYMwZIV8lOs5l8f9O76
 hGj3E9qnpgegW8OFm+BBo5IjuxETEBf93ahUQVJT1DATJWw8kjiZyRnkkT7Q==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

This fixes the following:
interrupt-controller@4080: compatible: 'oneOf' conditional failed, one must be fixed:
	['amlogic,meson-gpio-intc', 'amlogic,c3-gpio-intc'] is too long
	'amlogic,meson-gpio-intc' is not one of ['amlogic,meson8-gpio-intc', 'amlogic,meson8b-gpio-intc', 'amlogic,meson-gxbb-gpio-intc', 'amlogic,meson-gxl-gpio-intc', 'amlogic,meson-axg-gpio-intc', 'amlogic,meson-g12a-gpio-intc', 'amlogic,meson-sm1-gpio-intc', 'amlogic,meson-a1-gpio-intc', 'amlogic,meson-s4-gpio-intc', 'amlogic,c3-gpio-intc', 'amlogic,t7-gpio-intc']
	'amlogic,meson-gpio-intc' was expected

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm64/boot/dts/amlogic/amlogic-c3.dtsi | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/amlogic-c3.dtsi b/arch/arm64/boot/dts/amlogic/amlogic-c3.dtsi
index 32a754fe7990..f8fb060c49ae 100644
--- a/arch/arm64/boot/dts/amlogic/amlogic-c3.dtsi
+++ b/arch/arm64/boot/dts/amlogic/amlogic-c3.dtsi
@@ -111,8 +111,7 @@ gpio: bank@4000 {
 			};
 
 			gpio_intc: interrupt-controller@4080 {
-				compatible = "amlogic,meson-gpio-intc",
-					     "amlogic,c3-gpio-intc";
+				compatible = "amlogic,c3-gpio-intc", "amlogic,meson-gpio-intc";
 				reg = <0x0 0x4080 0x0 0x0020>;
 				interrupt-controller;
 				#interrupt-cells = <2>;

-- 
2.34.1


