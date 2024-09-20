Return-Path: <linux-kernel+bounces-334125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F93A97D2D8
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 10:38:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A64EB20D55
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 08:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C263D139D13;
	Fri, 20 Sep 2024 08:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AkMrzAu7"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 690647DA87
	for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 08:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726821492; cv=none; b=nw4//hRPIf6JaNZ6Zzn1WJsAQAf3ShlX/ghZLcHmk/jE6Wnc/tgnT6eO72JyL5fh4lYv7b1hQmKprHGjLYAV0NajrPGYsa/AktUm829WdvMjHfasDU6YSqr+dZlgy4TlA9RXVEbVeOoxHf+OvzyMDFVKN58JcQkkMKp+hCkDf+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726821492; c=relaxed/simple;
	bh=j4Lbv6zNfqApM1V0yGgeKWlfIsHLow2v2D7sYIjkoo0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RzMeDe8ol7ysEJXiEg0g3INgAn6N38iJhbsXw137DXenD3tm2h7J0JGK2IVb6XDPkvxlkpmXtemYqu6YCddxHSzNyfX6M/K82y4yk+EwblZXhvgU8zCasaUchalS25WnwcNtu4cet5xEIxHKZZtNjHKFPpD1ghw00D4PWoqNo58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AkMrzAu7; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-42cba8340beso17507555e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 01:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726821489; x=1727426289; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gT2RF7jns1eZm4iFgSUdoY+bcOaQqGhahQcgK59xcso=;
        b=AkMrzAu7yrWitnkC3UKoT/+1rXM/yE7DLYRKOswCD2y+FdUSbYKa57Sl7LKPfgbPqY
         /VvR2TQzcoarN7I1Tp2Pfiwig0c3lQKPiQ30+yLmhpWTWIWL5QVcDFDgCYqZdzPmenOk
         wlbM0bBOJpL0QDHcLrLTl53VwrkF93la0V/6XG8q7Ev6fxiAyUVALhm7xR1P9YBBiR73
         P8sMlYcnD0AUNb+r1Y446jKV13UzVevRgqPj3adrhHky3OiPW7wpY2MTy1q+2By9xdXO
         GLYpgVvJJGjQD4tVaD+gO7oKZfPZF514qvLwVSfsBCXxVAILnO8RKW6AKFX3+DEncqwe
         iNSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726821489; x=1727426289;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gT2RF7jns1eZm4iFgSUdoY+bcOaQqGhahQcgK59xcso=;
        b=ieTkqcgg2vXG9CSq/zSmqycQgBez9gm4Xspt/RjQNmk7XeKe9Xjhi6mEOs8eaYZPCR
         B8RGAroYVOCMdK3jEgCEbLTSbuF4UxMLVASsRHPRgyuSj0hBqrm0S0K0+cI0JgJxOZ3Y
         5tBuC4tdvXvGyY7dpZUCNKJe/oOC1nDzaGEEBJtVGUsuSLHUM1+SmyphcV7s72RbMDQ6
         aQ6dKCRqH2nikkotuGblHJ62/qH/nmqceKy1OVwexCi9yaDQOmDMGsyYoZLIF72KPzfH
         2xjto5Mqj1BXzWB6bsvWNpbsBPthRu0MmOkbTXe1kHkKCh0l3Nk4DTdF/RwaZ2Lh86Ky
         Ki4w==
X-Forwarded-Encrypted: i=1; AJvYcCXcwOaXayqSOim2PV8nPgD3RA58ukL4UAxOJNA7FNoLpG1sleBvyNDHWpq+mhgjOLLxH2+T/yNTOvjzsnY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiM3Pxhj13+BPE6QCmvxYtbf7x4OaFxZOn+R1AJdFjlUpyZ49Q
	bPTArc500XV+zq+L5zfg6VcCWZhO5qJ5F9FL4zNRW42C2iIq6vnnl854gYInn6U=
X-Google-Smtp-Source: AGHT+IE5iYFX6WbTBCf8hPKKmvc2byWHvUXMxBGORLFXUMBKGWVjztPI3IQQ7+Y9YV7SsSQ/lBAm2w==
X-Received: by 2002:a05:600c:444d:b0:424:a7f1:ba2 with SMTP id 5b1f17b1804b1-42e74480c34mr32809545e9.17.1726821488647;
        Fri, 20 Sep 2024 01:38:08 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e7540e2c1sm43099165e9.2.2024.09.20.01.38.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2024 01:38:08 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Fri, 20 Sep 2024 10:38:03 +0200
Subject: [PATCH v2 1/3] dt-bindings: mmc: controller: allow node name to be
 named slot@*
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240920-topic-amlogic-arm32-upstream-bindings-fixes-convert-meson-mx-sdio-v2-1-5aa8bdfe01af@linaro.org>
References: <20240920-topic-amlogic-arm32-upstream-bindings-fixes-convert-meson-mx-sdio-v2-0-5aa8bdfe01af@linaro.org>
In-Reply-To: <20240920-topic-amlogic-arm32-upstream-bindings-fixes-convert-meson-mx-sdio-v2-0-5aa8bdfe01af@linaro.org>
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Kevin Hilman <khilman@baylibre.com>, 
 Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=822;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=j4Lbv6zNfqApM1V0yGgeKWlfIsHLow2v2D7sYIjkoo0=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBm7TRtOO5ZDGB2QmQUkPJ/06kTzIWKKiisCP4shXUQ
 InsXEMyJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZu00bQAKCRB33NvayMhJ0e2nD/
 9IWH1wZJU9XdD6gMI2xMEZU8T0xA9K+1KFRbOZVINbrRwYyTirYYoTlr3Xm8nG6AJ7LXYMa8QLahEw
 9U7ToR/R/hBkPgUyTbYdpkLxsahke9cMoCgPiiO6XKceTjn+YHkOx5RVOCt/n/Suj1sxZXenLO7tAn
 ztn7BAmhv42WPi0Z6+6gqekvb2Yro7qJLFCvScppDy3MUeYRAq6gNqfjkUuWorrPg45lMkFVcjD+RN
 PPaqGpZcSg3+r5slvgETedy5DUwt0qPG4WupRFtfBrZ0JSI2tUE5MtRSLkAWGO0aghjCFcoqrKDxdb
 goO5xpfV3aapOLYmzF+VaSGCtMoJQyETFJ5UbnjPSZZL7uKM1wkcpS7pVpG/gFs3pwxTYb4u3zKq5B
 wiQFNSLylTCparrRpM3p/ttLUJWqKrz6tv6Bvulda8v95d71BPn1O9xofO/AOR+sL2weGWs9g0HESg
 3qPSTlC5RWI9wrY/7F3tdWGcZ4K6GbrWKXxLf1pWcv63Hj82CETY+mt6ku8cNfChUSX1itt3Lz19oh
 Qeh074UwOJ+ivJ+pHI5dFrQhDFLnhRkl5OvqTSj3ec2AkW3dHDUxYYi69r2Os1zhr1LSrTOOsUfWdI
 uz5/RuAmJ4pMcld9lwSnU9WGNcBZUmwoVy0rDB6jeOkJ+zlp+ky7hp00ZLOg==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

In preparation of supporting the mmc-slot subnode, allow
the nodename to be either mmc@ or mmc-slot@

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 Documentation/devicetree/bindings/mmc/mmc-controller.yaml | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mmc/mmc-controller.yaml b/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
index 58ae298cd2fc..f797c32ea688 100644
--- a/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
+++ b/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
@@ -20,7 +20,9 @@ description: |
 
 properties:
   $nodename:
-    pattern: "^mmc(@.*)?$"
+    oneOf:
+      - pattern: "^mmc(@.*)?$"
+      - pattern: "^slot(@.*)?$"
 
   "#address-cells":
     const: 1

-- 
2.34.1


