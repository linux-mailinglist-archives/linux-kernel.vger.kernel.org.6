Return-Path: <linux-kernel+bounces-236496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 219A791E300
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 16:58:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5206B1C21814
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 14:58:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F12616D9B8;
	Mon,  1 Jul 2024 14:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NpfmZ74g"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50EBC16D4C0
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 14:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719845815; cv=none; b=Nfl7q8xK+YURRd7QfLD9NHs6ZMY0/RW9WZPrNNK82XKT6XiTYOkUsMl2/x85BhK2XNdzfJiwlpZ/gOO/0HljcZBCcMuDllepjeU9GuXsXlh6aFsZXgg8Z1XBt4XMb5q66L1GK48x82KEImAR4VXz7ChYMaq07FE5BLQk0XgUgIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719845815; c=relaxed/simple;
	bh=SrDosKmap1qHqwbZN81p8+TgKWBukS6DTItRBt59i+A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EoHxCMSsqSeKvFZ99NpUxU02ZCC8GUfSDq0gGxkw0CWCvwMN/fZl83PlKTqBepx9OUktOsyt6k6aFTeglsch4IP4gNBnrpLt+H7+0BENvgW6a+WBvcXDRSCRqxk/KYW9wFvpyAZrsk3bf36kEHRMp+CiGziryl2i6fLT7qbvIJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NpfmZ74g; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-424acfff613so28347875e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2024 07:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719845811; x=1720450611; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RsUHCrNvsKr1kdBukb0DCbmncyLmfrL3JXYTmXFdBlM=;
        b=NpfmZ74g5fCMFS3fJUxnzwGRMr2fBCDgQLNd1f+xKRGfNs2ZpS+KQFmE8Hqf45DDQR
         kAiiTTrjQl8uBDZ89WdKGJacxcBJYkLE+JC5oCRt/6mkhujbwCGMb/OOMffO6ozLEnKT
         y6ho1hT6KOV8wn3puZ6ABySplb1IHJ5egIAbNLOYSoWXJinAdvQCO6j9vGgTaSorxxzl
         Di7IUvHI+dIHJ4GMV7u+wDo7U0yu7Vc9IfGncIuytKdvxOTXVhlZfNlZuPLKTDKLrHRL
         wrHG0TKUnCWaiFEZ5EEO8WokopfHQDxi5Z8JZK2gZGSvathtXfJxeJc1yG4skg8guuXU
         /tSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719845811; x=1720450611;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RsUHCrNvsKr1kdBukb0DCbmncyLmfrL3JXYTmXFdBlM=;
        b=av/StBDgAU1qDBnr6AsNvfdIUXT4Q5XS82jWrWUVUyEHlJQQSbiA4UCZblxRwzlAhA
         Sg6gTj5G0he0ijfJj3A2pUuh3r9r1x8IcoWdjJYZevYAhUSeCXlLpy920YnTK7R/r+SP
         bexmv9XhciVVMbGl9QdaGJLsTsgVzIwiCO7y30ibh0/HZMiNqCXZpE4nuEBy3sCTmx9X
         dh5+oGAIw6VF0rdkY6+LUFBynk5/ZP64RX2/MFubUq6BRXkMiRxFeLZ/fZnKvVdcEHKP
         yqLb5+vShVWdwz/eQT06U3NYxHWlP7pc7/kPWz9U/aLdU/xsh8Veq3WLC0JO/inr55J/
         fiew==
X-Forwarded-Encrypted: i=1; AJvYcCXsahgH3anqLP3IyKEJM8tj6O3IxRIxDs0d69muKcaByYcaRU5YA8QhVBgv/LYf25H1ElW+/lsBnFSXq01LUdwBP8weVdXOiJkyGrvd
X-Gm-Message-State: AOJu0Yw6VyQQiqwSCLKjgZqo0vRRKpmI5CZRoGC67XMNVxKtv6GFMYRc
	4hdXZoIOWes6MzNyXCTVf3L4qg2b8MSO6vMIIbWQd7UC089psnSSkLKr3WtIH6fld3437NnMNB6
	Z
X-Google-Smtp-Source: AGHT+IEmqNIzKh8Lu6RZ6/4U5CX2P1NYzyEdM/Eu1XeQVHEX0sMUaOg1okVoBqrKIIsHkxzsu3DaIg==
X-Received: by 2002:a05:600c:181b:b0:424:c837:f54b with SMTP id 5b1f17b1804b1-4257a0270f4mr45205645e9.38.1719845811435;
        Mon, 01 Jul 2024 07:56:51 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4256b0c0f99sm160062915e9.41.2024.07.01.07.56.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 07:56:50 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Mon, 01 Jul 2024 16:56:39 +0200
Subject: [PATCH 6/7] ARM: dts: marvell: orion5x-lswsgl: use 'gpios'
 property for LEDs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240701-dts-marvell-cleanup-v1-6-4773bd20691a@linaro.org>
References: <20240701-dts-marvell-cleanup-v1-0-4773bd20691a@linaro.org>
In-Reply-To: <20240701-dts-marvell-cleanup-v1-0-4773bd20691a@linaro.org>
To: Andrew Lunn <andrew@lunn.ch>, 
 Gregory Clement <gregory.clement@bootlin.com>, 
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1266;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=SrDosKmap1qHqwbZN81p8+TgKWBukS6DTItRBt59i+A=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmgsOo52DMHYvFkxcBePY3Llxu+r5mkmHz3B2jW
 gUj7B2onLiJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZoLDqAAKCRDBN2bmhouD
 12xdD/sHkxSwaK3wAj9bJIFQd3SxEZXMuhG3VHlejfhkDTDqCGJ/tDwTn3Kb6/i7OvydZs5xVD8
 Jqz1uAb7w9U1PAKN1tpNLdLH5yJZYa/N7daMCP/T1K9b82GUE1Ok1kzhlamuzu+G9j4GiZQ/1/K
 SYWvJrnoZk/0WRIZ27P/UAqVoQ7l3K1OHBngBCAx/zbOcaDWhSeXh5wMgBSxP1b/2kSaIIUh5g+
 EHnaTSyJ9+XW/iJDr3N1EEx8PlGRz860TXJIobzaBTY+K+EYciNz4+2xXMhGd3YxVH1VUg3WzWv
 XXsxWl0L1hbJwEEFEoyE+OnTgrMv57MQKcC5Y8Ww5w4mVsS/nQubbhDi9T+gMpxkgtVKa2KXJFv
 kDb9h6gdIPfzqUvDbU3LhLuDHpOG9JWtVtDEJf+4PfaycfNCjyiw2oRKHcGlSJSKOA+KIJky/8J
 fPFSySO4nk+KujrpPQn1EV5rNsmrMHm6s7zuhx1ZB6tePzDsfo1xISx92V0ug/ieWTvB1BWSiCO
 omLydkmrFmTBfNcNNyxuBelJuKobwj6VPj/GxdccsaT+4Cfdm7/Ri1FSiU9t/V4vgbApBdW9Qwh
 4v3ECsVbkQOaAF4JKshTTbfMVQzpmFcDcL2AzBr5Dlcdfa9lqqEjEW0vPRQu3rQB24poyEgAp5E
 8E3FyOAFyk4dCLQ==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

The 'gpio' property in GPIO LEDs is deprecated, as reported by
dtbs_check:

  orion5x-lswsgl.dtb: gpio-leds: led-alarm: Unevaluated properties are not allowed ('gpio' was unexpected)

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/marvell/orion5x-lswsgl.dts | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/marvell/orion5x-lswsgl.dts b/arch/arm/boot/dts/marvell/orion5x-lswsgl.dts
index 35dffb24b8b5..802cd6ff6169 100644
--- a/arch/arm/boot/dts/marvell/orion5x-lswsgl.dts
+++ b/arch/arm/boot/dts/marvell/orion5x-lswsgl.dts
@@ -104,22 +104,22 @@ gpio-leds {
 
 		alarm {
 			label = "lswsgl:alarm:red";
-			gpio = <&gpio0 2 GPIO_ACTIVE_LOW>;
+			gpios = <&gpio0 2 GPIO_ACTIVE_LOW>;
 		};
 
 		info {
 			label = "lswsgl:info:amber";
-			gpio = <&gpio0 3 GPIO_ACTIVE_LOW>;
+			gpios = <&gpio0 3 GPIO_ACTIVE_LOW>;
 		};
 
 		func {
 			label = "lswsgl:func:blue:top";
-			gpio = <&gpio0 9 GPIO_ACTIVE_LOW>;
+			gpios = <&gpio0 9 GPIO_ACTIVE_LOW>;
 		};
 
 		power {
 			label = "lswsgl:power:blue:bottom";
-			gpio = <&gpio0 14 GPIO_ACTIVE_LOW>;
+			gpios = <&gpio0 14 GPIO_ACTIVE_LOW>;
 			default-state = "on";
 		};
 	};

-- 
2.43.0


