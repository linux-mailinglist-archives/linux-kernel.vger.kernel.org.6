Return-Path: <linux-kernel+bounces-203872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EB2D8FE17D
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 10:49:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0431D288B08
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 08:49:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64C6813E3E1;
	Thu,  6 Jun 2024 08:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qxBWD3Z9"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A494A13D521
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 08:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717663704; cv=none; b=Gr7eejQfO7A3EA5dds/0chEHdMCKgjLfNm1/SEbH2a6YVv9ta/gZxPtrikEEvBhIUGE20A+bgut7DyVmT9/o0VfxUHjPnQwk7PjBu2cbeFlrl5V0NvhAR/Hc7rl9MQJsCMNNTQzjRzkUVKJkDXMhqkXlZUhWO/BlVCfLD/z+pRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717663704; c=relaxed/simple;
	bh=EXGEWAhKpF7QnohcFYB5Y1PiMZfbRrYfXGdvRy+dRzk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=F8/syWWuow0wdggQih2tMlCEZwsru4QcYekHm7I7O4ZbzTg4nxzchx0rSFuwGYKt5iA0Y8A38/2D7ovtxQioc4g6nMeDOtdxg3mB9kkBluAhkfKY9+07LPwDrl5FQarFt+cOHLxrySq46kK7psmhIfuMOqMACxlCMF6tgaqwkaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qxBWD3Z9; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4213870aafdso8379455e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 01:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717663701; x=1718268501; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+IWuxffXrg4LQwBLFnoOeZEokseDHoUki1HFBLSFSBM=;
        b=qxBWD3Z9sXoMd+cQWeh0TDSqVqpCrp8yrvBTrk/rX0HTn1wrhZmWusHHN6PcXIm8kL
         ShkrLZjVew1rxNUhnE0ib9PzK82iIezY5DXP5YjIgBxD2IqO716+2t8xrCeiWFcENwFG
         Jz7e6McA+jhodwGXa2BwpKs9dm9Wj9HxoedsEGaO9s/YbSqua8CMMBWFypwxCbgXVvLR
         PAmb7QuMf7PuZY2dyI1mcTDWH7rDo5dgncUhQDXwGCEDoND7WLYYy5SNE/N3ftOMB30D
         ci/RrcuXDoM4/GG8BWGDiaGLxIxY1r+narjkEAWHtVeo1ex3J6KEguUAm0XhaR6Juho0
         k4Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717663701; x=1718268501;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+IWuxffXrg4LQwBLFnoOeZEokseDHoUki1HFBLSFSBM=;
        b=IOrbIFMACD5anMbd8Y5e4DoRh1S+GfIMReVjtazuwKNKKqfSnjJq8TZKNf7ypdmvW7
         ceFLmjxCdl4/D8w8zc07Tep59arIclL1AVhIiG92v3fJjqKg7f+grSsldGREBlETYrKI
         mn7/t5JVCg/CeHMR85jz9Kt4/WR0iIB1qOlmZRmQ/U/tsEFP7qxQIk0Xv8ujicz8poPw
         s6p9DJSfbO0KwaOnN2qWcyCU5MEYkg23a+2vH5afcAurBKNlyqAXIjPbCGpi7GOsogOr
         0AhkqpR4GuHLQqj81kuBglI9nFzClvt8EnPISfviaLGgT/3nM1WgKtA/kgg30RCYsU5r
         NATQ==
X-Forwarded-Encrypted: i=1; AJvYcCXu0Xsaa0aVcS9cl3iPlsPVupgE+2818JuOAYRSJgTZ981MGlmScQzbq0sxEniJR798nHgf173j+ex/OZfivvlwS49rYjZm2C5KUmVq
X-Gm-Message-State: AOJu0YwauOLJxsexuF8mAFfIH9uLsX+zC4VPcmD5jknao6aEsopvZ/J0
	wKahcOFHxKwmo6H+T2IX1URTE/ZtMNmoXgD6TPp7V0l8QDW00ooVCMT82r+X0DHnCtnfA8QbnJl
	u
X-Google-Smtp-Source: AGHT+IGalqseq3iSUyoZ1rDpRKcx8jiSTVA95CddC3u6Wzo2fIiN7QpZR/sxDIygQnEaSIhb84DOGA==
X-Received: by 2002:a05:600c:4254:b0:421:55e6:d4fe with SMTP id 5b1f17b1804b1-421562e7748mr38548195e9.19.1717663701048;
        Thu, 06 Jun 2024 01:48:21 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4215c2c690dsm14227445e9.34.2024.06.06.01.48.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 01:48:20 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Thu, 06 Jun 2024 10:48:13 +0200
Subject: [PATCH 06/12] arm64: dts: amlogic: g12a-u200: drop invalid
 sound-dai-cells
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240606-topic-amlogic-upstream-bindings-fixes-dts-v1-6-62e812729541@linaro.org>
References: <20240606-topic-amlogic-upstream-bindings-fixes-dts-v1-0-62e812729541@linaro.org>
In-Reply-To: <20240606-topic-amlogic-upstream-bindings-fixes-dts-v1-0-62e812729541@linaro.org>
To: Kevin Hilman <khilman@baylibre.com>, 
 Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=798;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=EXGEWAhKpF7QnohcFYB5Y1PiMZfbRrYfXGdvRy+dRzk=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBmYXfMxNcVWAzCvmfhczk/oa52KNH8pz/V974sJxZP
 zqYfDwqJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZmF3zAAKCRB33NvayMhJ0Rq8EA
 Cu8y+nE/eTc41AHaN4QELvpQlLweEg095Ph0hOo2cdNBpmZ4KJTAF9JavC985V9svwTtKY9mB3wxPN
 tZo8p+6s0z7IVzxtlnxGw4wY1bVudbvxU8Xgp4Pfn+IvV+d8UKOKNNrGLZ3Db3pUaOFRis+1qR2tI0
 p+sqNS/LwW5kbXzwgStosHdh4cR6s98BD7RNb65dMCkGr5fQwpaPs7vzNpNz2smvoiJtAAqWC2v62G
 w/8hTjqDyD+gh2dl4abMQtAM+lOLNtnezkoOBJ9HCIP7Ewd/Jq4m26wPo6t7a2M6NGOF+euSzOxCqV
 xDRzPWIoXrL46RUhF3fN8244TrlDww9mwFYVTf9NMlwsrUrZKaj17RA65sbe8RGbKykL4Jtqif9CNW
 DIiqaYqxdnBnVcXoyZS7MEm8hoCEcUZHM4pdXdq49POIYJBK+L3fekQMK07OToNPvC9u+Kx2DJjKRF
 ddIO1yHtCEDZAgi5YF7bxGn+sHXVyxs8niOg7upYzS0gs57AIAlOfSaUipkG5nRoiT5rRYqIu/jW+m
 HjH0QTjM4CRcsDnuV2aIVN7/bzjU2NGr5RlJ1j5wQx2uEfXy9rm0zGiaFHpKkj9m+p7ESvldLwiKRQ
 qqYeFOpOJ/bqRBTnbygUt6h1MtE/8/jlmOxo/RWHfrakoyfp+gtvOTxS0SkA==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

This fixes the following:
audio-amplifier-0: '#sound-dai-cells' does not match any of the regexes: 'pinctrl-[0-9]+'

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm64/boot/dts/amlogic/meson-g12a-u200.dts | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a-u200.dts b/arch/arm64/boot/dts/amlogic/meson-g12a-u200.dts
index 17c38bb3368c..e0f15d824249 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12a-u200.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-g12a-u200.dts
@@ -24,7 +24,6 @@ dioo2133: audio-amplifier-0 {
 		compatible = "simple-audio-amplifier";
 		enable-gpios = <&gpio_ao GPIOAO_2 GPIO_ACTIVE_HIGH>;
 		VCC-supply = <&vcc_5v>;
-		#sound-dai-cells = <0>;
 		sound-name-prefix = "10U2";
 	};
 

-- 
2.34.1


