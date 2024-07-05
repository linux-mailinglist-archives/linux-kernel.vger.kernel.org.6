Return-Path: <linux-kernel+bounces-242267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CAB489285AC
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 11:53:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FB94283D13
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 09:53:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00C00147C91;
	Fri,  5 Jul 2024 09:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hKoOW4Ir"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C44F1148837
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 09:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720173124; cv=none; b=H+9M4a9avUa9LFdaLSWvMNHNndACb8fPMlMrHh4MGkgt3oeQp3XZi4pdAZ+iaW3PNWYMW7c04OejUCq0bOMn8o8qUFaaWd7CpAkHu+WRf4IW19ast+TCWzW3j1Xm/7sxaoWKSN2JNYgxdsjuiU4MCr+NaolXZ+l0uZuLAHq4Gnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720173124; c=relaxed/simple;
	bh=c0XiyTVpABMLT9+EMpR818Up3xsjTqaFTXr9Uw3kjSg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pXpO/ErmN9tdJNHZegTqOohY+az20KayNCVajqSkN5h/ti4RuyvKpNvXpdzNpcanvxn712ne1FVn+MX1/F5vKM4DwJJa6qrDegZ2yCabLqi6kkRoHZAFz6LjdXX1nXyTK2gHo9JB56aXB6C1YmZnSYk91tFxNA3pGrZs2rgb2WM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hKoOW4Ir; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-52ea7d2a039so248000e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jul 2024 02:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720173120; x=1720777920; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sX94G3G6DNIVjmJouBvjfOrzcAghl2zsNWK4O0NrzTs=;
        b=hKoOW4IrggnLnUOUwWhsTHK97cf3P0j/XJ8z2MAjhmkde5jmYW+lTIyYRTfbqV4Rfv
         FflJsJWj6J3bsqVuZaJGOTkz0Wri8I+tumiiWWalojxu1b9c5AmyeuHmJaT1IEaLwDVE
         +xrokrZj/MIHoBNyFU9RrR/tnsD7Iw/VnKvFC/9UmbYMXRR5k3LJhOj0Z4YjPUKpHb7B
         pnr6wrGSec8QrRwrPDxKAFGkgCW5pT9ON/6aitOOPKF5qF8axuPBSWhRjO3UFD552UUk
         APDTX57CiMEyiK2OgdfnWxACxsWBAdfT7UUDrgcpFnHNQJ6EY9m67lM/5IxGq3KjuMER
         qqIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720173120; x=1720777920;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sX94G3G6DNIVjmJouBvjfOrzcAghl2zsNWK4O0NrzTs=;
        b=nf9PUMi4BrutIe2CDFYMLb3FtmMhgwCopBRb3rHc5nvWZUaiUkgBhz13XBD/Leom46
         AnjYmqIzClVRFDWTYCdh7tvAYwSyWpNzjqB8QVbaKDiyQdYGCjsEDCXNJLvLmPp9m96u
         oeyzCGKYCJhhmxlU/0S1Uv8id62Lrl7PgnnqmTHsy+xtJpSbj57N3z8zmfP22Okh2/9D
         mqCFf3JKI9t+69N42TrAtopheVmqKXZdaFKD65Dl2GtjkFlyyjFgAgoxSDyyYTmWoo52
         fLxgFBx+yagV5zGyf6rkbWf7aH4wmfSbVDqjdvIcP4KMkYh92/sAeypzTxUCMGx0Z2OW
         WMwg==
X-Forwarded-Encrypted: i=1; AJvYcCXqfeCaPrxlrWFV42K5OZ+luR6QNbDDRRfXzJluxruIAJpj1borcDdsmulke+dEctCP32YkeXd5GYMFr4SOnxEvr/twnhgerxwG8Omh
X-Gm-Message-State: AOJu0YxrpTcc4iLKrLsdQilAtVViyH4jT1/BUPT/NiI/8sYEutbnhIw7
	LciFF2yqfBAUhZapOG7entZJ2VV5xvSDiWSnIX/9ZM2f2lAq0pygn230ErGUHmw=
X-Google-Smtp-Source: AGHT+IF+cdoYkQWC4AuXm4t1/MTS6fIyqRyTkQRHT2EwhR1xN1harUysDUC1D2zux95zBTvcXoiJEw==
X-Received: by 2002:a19:a412:0:b0:52c:d6d7:9dd0 with SMTP id 2adb3069b0e04-52ea06327a6mr2528352e87.20.1720173120019;
        Fri, 05 Jul 2024 02:52:00 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4264a1d1650sm55528995e9.2.2024.07.05.02.51.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 02:51:59 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Fri, 05 Jul 2024 11:51:22 +0200
Subject: [PATCH RESEND 03/22] dt-bindings: thermal:
 allwinner,sun8i-a83t-ths: reference thermal-sensor schema
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240705-dt-bindings-thermal-allof-v1-3-554061b52fbc@linaro.org>
References: <20240705-dt-bindings-thermal-allof-v1-0-554061b52fbc@linaro.org>
In-Reply-To: <20240705-dt-bindings-thermal-allof-v1-0-554061b52fbc@linaro.org>
To: Daniel Lezcano <daniel.lezcano@linaro.org>, 
 Zhang Rui <rui.zhang@intel.com>, Rob Herring <robh@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Guillaume La Roque <glaroque@baylibre.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>, 
 Fabio Estevam <festevam@gmail.com>
Cc: linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, imx@lists.linux.dev, 
 linux-tegra@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-renesas-soc@vger.kernel.org, linux-rockchip@lists.infradead.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 Florian Fainelli <f.fainelli@gmail.com>, 
 linux-rpi-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 Vasily Khoruzhick <anarsoul@gmail.com>, 
 Conor Dooley <conor.dooley@microchip.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1580;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=c0XiyTVpABMLT9+EMpR818Up3xsjTqaFTXr9Uw3kjSg=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmh8ImyihnA5Unad+tgAIYwIL8zn4DXK/FwOQcP
 pn+9KtbW2eJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZofCJgAKCRDBN2bmhouD
 14EDD/9R3GhWyejZrRKYg1VskD4rihePQWBSAL9MpEwdP8qSNWedYZoSCrTCGXDyr0I1UZn6dHg
 AgeF1KwhkQED5bKmFkL1afLfdppDN5zKG5O+6xzIVD0AeGk/1s6rTJY2g9Bx0nPJWT47/VJTNC+
 EK9SWoxfsHyZzyQgvWSrN1KNK6ZpSdiAXZ4qt8Hy2c/69v+0Ln5qsN/h9qk3AMmNk5p+Cx/begm
 zhnvKluexhqmwtfxuhuidO5gdpqNy75A6Kb3fhOvfhkhGScJGNGaWBKBz2zgA0Sa4ePQbnp5S4o
 AgBFMadaYYZa78grqVywbeV1niuDtPfcbWw/lMBFqGOThwzE1euxdDJaBhuj05wnuQSlU/FbwH4
 9SVWGF9srqBZlFmmd3khXFRFAa3ZCQjBvOx29bj4q+eMEEjiCBzsl4aNIwD16i8KhQbv1HOZt03
 gLUF2oN9bNl1+yk7c8HgruM88GLjaqpn0cBJmMf++N0OH5SWRADDU5beynVaZNp1VjD0Pgn5ieG
 TodWbk25QOMJHplaa3j5cb1lp4yDvPIUSZtdS6FenMOUhNTJ9OOrzp7hrz5+4qUjwYWemRPvb2v
 UypuFnk/8iRLrCcYdjPCZohp8CrIUuF63Dvr/44R1xef7oq8DTHeuavgg/wBWMSoHChyhnW9QbM
 OQOqu2vFEKib9Uw==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Device is a thermal sensor and it requires '#thermal-sensor-cells', so
reference the thermal-sensor.yaml to simplify it and bring the
common definition of '#thermal-sensor-cells' property.

Reviewed-by: Vasily Khoruzhick <anarsoul@gmail.com>
Acked-by: Chen-Yu Tsai <wens@csie.org>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/thermal/allwinner,sun8i-a83t-ths.yaml       | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/thermal/allwinner,sun8i-a83t-ths.yaml b/Documentation/devicetree/bindings/thermal/allwinner,sun8i-a83t-ths.yaml
index 6b3aea6d73b0..dad8de900495 100644
--- a/Documentation/devicetree/bindings/thermal/allwinner,sun8i-a83t-ths.yaml
+++ b/Documentation/devicetree/bindings/thermal/allwinner,sun8i-a83t-ths.yaml
@@ -10,6 +10,8 @@ maintainers:
   - Vasily Khoruzhick <anarsoul@gmail.com>
   - Yangtao Li <tiny.windzz@gmail.com>
 
+$ref: thermal-sensor.yaml#
+
 properties:
   compatible:
     enum:
@@ -55,7 +57,6 @@ properties:
     maxItems: 1
     description: phandle to device controlling temperate offset SYS_CFG register
 
-  # See Documentation/devicetree/bindings/thermal/thermal-sensor.yaml for details
   "#thermal-sensor-cells":
     enum:
       - 0
@@ -135,9 +136,8 @@ required:
   - compatible
   - reg
   - interrupts
-  - '#thermal-sensor-cells'
 
-additionalProperties: false
+unevaluatedProperties: false
 
 examples:
   - |

-- 
2.43.0


