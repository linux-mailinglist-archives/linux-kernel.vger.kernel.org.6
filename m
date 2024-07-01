Return-Path: <linux-kernel+bounces-236497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA1E891E302
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 16:58:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8107A28235B
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 14:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DE2816DC1E;
	Mon,  1 Jul 2024 14:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YrdZAIC/"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9526016D4D1
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 14:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719845816; cv=none; b=BcAL1LyLniLrr9VjtYztwRkcfEIvM968vAdkSiqpXIiEV+NXS/PLSKAOmLh/rrbBx/eV7jsfARjMDG3FDd5s3AFi2U+SYOIvbaC4I6IzkJhU8B7zyYQtZWgqLzIruVlXCVlVmmv4YqIeyNJPIRWlZL9O6pNFv5iNNL2OZETmkR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719845816; c=relaxed/simple;
	bh=lulhEHbDI9HXkLTpJhxhZ2CGZpInoFABmokVqba+H/o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eY4IsfJ7mYUYn+4Ya5THsOetvAmjfuY8jlTYvGJgaiwE/4M3PYlrvUnjzcPLGL6YZaM9jyA2XuJ/WjcYawooIWr2srN5+QE+aiYrv+6Yz8pK/qH1buWLvPMJvuq3aG57r9HccUHFmtgCuxKs2EEflsN+3FK7bXY7g453ZQbbXjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YrdZAIC/; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4257a390a4eso13657795e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2024 07:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719845812; x=1720450612; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NQf5Ish3Av0gD9Da5lEuRdMWHvRT8TUq9V7uM/AJGRM=;
        b=YrdZAIC/39f/WsQE9wNHbV+G5up555StfYHX9H9xxA7dCDWFLbyg+kOOuq74hefn1d
         cLxAq3wHee0WFMB7G6bN7Kf6DocH1S9f2CYoSEt4tZjNr5G8HfjhqPVKKsmeqs7plPOI
         8oN+QXe7Q6iDdM+eXxgdF6kYFTPHSeQGNUDVw8w9XrBT5W5hF5Q8jvsnphhlX3VDrME5
         Wo/2FX4LlFfqSwjEUWtfOLJb7pJBwhB8TBWtnia8Mv82yco0+jb2ZUXHvGGcs0tHjuTi
         ZwtiK5sm9d5kpLKwhQoXZbBylVrYNZa7PdGVurTpsT24tDzMsLypvMrMQ4qCTOtc+o1f
         oAeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719845812; x=1720450612;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NQf5Ish3Av0gD9Da5lEuRdMWHvRT8TUq9V7uM/AJGRM=;
        b=icEBTCMz85na1muW0ejp5HLkhe8J62XBdYWQITKVQkmQDwnMIF0c8Sngm2GFBr0dvU
         ISd/2bhehUQNryAXjndPlml1v0QTi2d+Ny6ZEVpuB8Kh1+KZgJAsJI3Qj+NM0bJ5C8R+
         UvWrfzxxUTfSw9rTiGcBuVuAwTcja+cQmPGOrNhbmDW5PRkjYIya5mb5XiQxvlqeZ8JS
         yTS4/5libQVjup6W5zFNgi4GHTVNKAJ2ut6lxJ2q7+fkrX8POW2lF+DPzHDWcEKDced9
         ry8YwHiFMQ99RRPBmdX2x1T9nfz2E7oTICUaKy4vcQL4fyw46G0rD9Ze9zOYZtsn34DO
         Qznw==
X-Forwarded-Encrypted: i=1; AJvYcCVqniMTjBuGNhhX7vgXiHRYvzIKmX432QLDoGbVFwjRslxJ/1cuVYLUlj+lfyX9fdhk0cbxYCrmpGSTcKIMVXhB6trADdiwAmbRZwsC
X-Gm-Message-State: AOJu0YzHacjuvI4xz0PI8bhxRgkPFaZLZIF4szs0nzx4WtT6eEFablB9
	lAyfy/N82VBgI8X9trWtvLlaGKzaushIulFP0iuMlEiTJuRMh8o34/513U8IOJPWAp+3x2roJdc
	j
X-Google-Smtp-Source: AGHT+IFuoYQlLRqQ9dWAaFITgP1ycNsICaOHlaVoLz1A7a/V/dTh0+2D6q5hqGRXA8gtFdGZaYA6dA==
X-Received: by 2002:a05:600c:1c88:b0:424:ab90:ecf0 with SMTP id 5b1f17b1804b1-4257a020ecdmr40982085e9.31.1719845812723;
        Mon, 01 Jul 2024 07:56:52 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4256b0c0f99sm160062915e9.41.2024.07.01.07.56.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 07:56:52 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Mon, 01 Jul 2024 16:56:40 +0200
Subject: [PATCH 7/7] ARM: dts: marvell: orion: align LED node name with
 bindings
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240701-dts-marvell-cleanup-v1-7-4773bd20691a@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3014;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=lulhEHbDI9HXkLTpJhxhZ2CGZpInoFABmokVqba+H/o=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmgsOpTixCygCACa26/Ig9SNDnBxhrjatBdht+K
 3quMnNm3yKJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZoLDqQAKCRDBN2bmhouD
 19McD/9JoJH1/47Ibse8yXq5ZQrHqBFbdg/aRfFIFNiriij2A6v4YY2hWO50iWr4K6f8gRaKhIC
 nasnu5umdaYkTDXGzQL1kEAVnJ4t3VwyZga9PUsrm9eUfV7cIvTz2lj+OYIoQU1kY1Ei6IgRA3H
 4o1zaQ5tdtxmAyNGOf6j3Jw3Ie+9yHdvJ96/GZ+JknCWi6VV5WBea78i/0+YU//r+f8Bvp7kjYN
 dsOCP8duMYZ0U0NZb1MgSX4lFc0vN8GZsQ3PmY3Pnfp0ALC/8IOdqahgvS0e67YXjBrnKG5ozRg
 uCfLlNGVJ5r6X67Ftj9lMGJ5wqOqE+tKcgstllUqCaJ2X1Jy3sIC/54jpw0LY7P2XDTpim9V/ZU
 MHgq2LFfQEdY5FkLkVbyrFvOQhtidDk17t+HZBE9vJkH/V3a9PVEKIF5CqdsjnVdLcvNOzGFXFz
 WTTUKCScF9zNDqhqVwCMgRgfpWO6iiVM85fLgYW21paImgl99ZOJrzJ0Z8ClWDTkYXPdsqdA5RR
 LNhM8efXnN94m7Ijoh3G/I08uLEK3uiMHbnN3Bkhw3DrwyQGpEdbRV8ib8wP5fNTxysdZZreUZ8
 oL+F9ROB2CEcKBe2PAkAZNH24gM9ZmzyoVtRxT7/P5+RnhTDw5HeoeGA7/Xa99sUTFCw5jtXxe8
 XJ+DIrZg1rzUJIA==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Bindings expect the LED node names to follow certain pattern, see
dtbs_check warnings:

  orion5x-lswsgl.dtb: gpio-leds: led-alarm: Unevaluated properties are not allowed ('gpio' was unexpected)

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/marvell/orion5x-lacie-ethernet-disk-mini-v2.dts | 2 +-
 arch/arm/boot/dts/marvell/orion5x-linkstation-lschl.dts           | 2 +-
 arch/arm/boot/dts/marvell/orion5x-lswsgl.dts                      | 8 ++++----
 arch/arm/boot/dts/marvell/orion5x-rd88f5182-nas.dts               | 2 +-
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm/boot/dts/marvell/orion5x-lacie-ethernet-disk-mini-v2.dts b/arch/arm/boot/dts/marvell/orion5x-lacie-ethernet-disk-mini-v2.dts
index a7586370b1d5..f81acb9b7223 100644
--- a/arch/arm/boot/dts/marvell/orion5x-lacie-ethernet-disk-mini-v2.dts
+++ b/arch/arm/boot/dts/marvell/orion5x-lacie-ethernet-disk-mini-v2.dts
@@ -52,7 +52,7 @@ gpio-leds {
 		pinctrl-0 = <&pmx_power_led>;
 		pinctrl-names = "default";
 
-		led@1 {
+		led-1 {
 			label = "power:blue";
 			gpios = <&gpio0 16 GPIO_ACTIVE_LOW>;
 		};
diff --git a/arch/arm/boot/dts/marvell/orion5x-linkstation-lschl.dts b/arch/arm/boot/dts/marvell/orion5x-linkstation-lschl.dts
index 624b737a8be4..79fee048c900 100644
--- a/arch/arm/boot/dts/marvell/orion5x-linkstation-lschl.dts
+++ b/arch/arm/boot/dts/marvell/orion5x-linkstation-lschl.dts
@@ -90,7 +90,7 @@ amber-info-led {
 			gpios = <&gpio0 3 GPIO_ACTIVE_LOW>;
 		};
 
-		func {
+		func-led {
 			label = "lschl:func:blue:top";
 			gpios = <&gpio0 17 GPIO_ACTIVE_LOW>;
 		};
diff --git a/arch/arm/boot/dts/marvell/orion5x-lswsgl.dts b/arch/arm/boot/dts/marvell/orion5x-lswsgl.dts
index 802cd6ff6169..e0da406c430f 100644
--- a/arch/arm/boot/dts/marvell/orion5x-lswsgl.dts
+++ b/arch/arm/boot/dts/marvell/orion5x-lswsgl.dts
@@ -102,22 +102,22 @@ gpio-leds {
 			     &pmx_led_power>;
 		pinctrl-names = "default";
 
-		alarm {
+		led-alarm {
 			label = "lswsgl:alarm:red";
 			gpios = <&gpio0 2 GPIO_ACTIVE_LOW>;
 		};
 
-		info {
+		led-info {
 			label = "lswsgl:info:amber";
 			gpios = <&gpio0 3 GPIO_ACTIVE_LOW>;
 		};
 
-		func {
+		led-func {
 			label = "lswsgl:func:blue:top";
 			gpios = <&gpio0 9 GPIO_ACTIVE_LOW>;
 		};
 
-		power {
+		led-power {
 			label = "lswsgl:power:blue:bottom";
 			gpios = <&gpio0 14 GPIO_ACTIVE_LOW>;
 			default-state = "on";
diff --git a/arch/arm/boot/dts/marvell/orion5x-rd88f5182-nas.dts b/arch/arm/boot/dts/marvell/orion5x-rd88f5182-nas.dts
index fd78aa02a3c5..75ab913b21e5 100644
--- a/arch/arm/boot/dts/marvell/orion5x-rd88f5182-nas.dts
+++ b/arch/arm/boot/dts/marvell/orion5x-rd88f5182-nas.dts
@@ -32,7 +32,7 @@ gpio-leds {
 		pinctrl-0 = <&pmx_debug_led>;
 		pinctrl-names = "default";
 
-		led@0 {
+		led-0 {
 			label = "rd88f5182:cpu";
 			linux,default-trigger = "heartbeat";
 			gpios = <&gpio0 0 GPIO_ACTIVE_HIGH>;

-- 
2.43.0


