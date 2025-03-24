Return-Path: <linux-kernel+bounces-573675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 18DFDA6DA91
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 13:58:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 910B318979F0
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 12:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3307425F985;
	Mon, 24 Mar 2025 12:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="b4CHAXw6"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94A0025EFB9
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 12:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742820802; cv=none; b=LGuocSSlWJeusX5rCwi2Xn8/VoCE684nSUCgBZGNL5phuADQWvmYTshW9/CZ0bgAeV9tclSWExitmpukfuoUR42CxAmJ+BkinhvuQsOaBncbLYfjKQPgH7YsTT40gp0UvkwroSmPQEXqhuS7lzlHRMLUYNsTtE7ziFkf0iqBtgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742820802; c=relaxed/simple;
	bh=KztbqaTR3tNBV6+5bYjxV8LYYV4Ce3mdYHKn0tcjJAQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SCKaNK0L86PjTXtFu7csxSvaVg5t1yzjyKEbtQzlCSPa7Br52OGXRUT8jP9U4yFLNAadwaRTt1wDYO4VSNwM/Mh3n5KnjJ8EiNuTGyZzmvTyVJ8Mi+yJe3hcAbGgti4h7vLRtpy2U/5ClYyPxysQ1hScax5iRUCRtbqg9/KPfM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=b4CHAXw6; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3978ef9a778so211378f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 05:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742820799; x=1743425599; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oDq573A1DEo78oa8q5EaQH/G4SAW0wK6UJ6KkottKQQ=;
        b=b4CHAXw6YRkSUMg8NDKncuFOO2DUu97CQSE78eI4m4DP35EhALmHLlTBMUT69eTuHl
         goH0F4u/hHcQzvZpBQDV21ekfoJtWO3MlUFhCmhewudA0I5NNRKEbCQ3Ea9YBC0xJUs9
         YZpw/HktFWz139PuVU6JJ7uDcPZl6qNQQGpz+xNujhmcUJhsYczU8cn8XbUVZyLjElLU
         Lk80ICXWiX3ZsPg+bmtPN3pyq5bJITzZ8LOvmvEOZkH3XaPAj+kkfI3POlD6xJ8eTZ7X
         wjCZpE/V5rS9xYLbGNG7y6kY7Mhd2n2/YjJsm5MI80CytwRFyccPuXxTQtxjnEYMQpxC
         CJfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742820799; x=1743425599;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oDq573A1DEo78oa8q5EaQH/G4SAW0wK6UJ6KkottKQQ=;
        b=kgPUJLHojU7FQDr23YFiXyh8B+IqDpGqoI6FHK/7gKq6VrEEICIFrqK+tzbxqvkIUz
         zD+IQcQg9PnZresQGwE+QLlCrwvFjihLyEnUKkme+1UbaeT+1pmidg9YQd+ytn1/1a1B
         qtz/R1GlJ3vOmJbjjPJNarIy9WEhjv6HwATBWP5dDc8dVn5n36i/AuHXThLO2JRHG26p
         WBYCwyD5TgAxvAFoTxBVOuo7/15gF4YGBy7kEPPPadVpU2Ob/Vd6g1aRbTq+R82zjos/
         93RUS6s7oxWzEaDCq+eddnv2TNRRYSRvgp9VcSX8SJa7Wt/46OWQjP9ygvf2CmfJuEVg
         LKFw==
X-Forwarded-Encrypted: i=1; AJvYcCU/owtBDpbKeF1nOQAJJLphmYlYZq5bvpMDdFxkAdAuGfLJ8SA+W3YwSKEvi8If87wYO7NjE0TAtbkvfxI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbmkNdVi6VE0YaLLEoGuWXvVSZ+flKfgjnrs76Do1KalS0h3K8
	0pV2bGonq/LoxO4SQnoTgeF45gT1j+GwGn23NDyOOlflaxQUNLhE93CIyyGI01U=
X-Gm-Gg: ASbGnctB5c/ejMgoc1uZ212cdjTygk3S6ZX5F3ISbgirD7RHut65GoKLuVwsYkRiZwe
	m4dRXW2ympU5aKxkNKAUbw4uPIrq8KBxyQsRdKz7UWe+9fb/B3a5YTdeNoma5mWenHokNVwRH8S
	FHvi0DRZaWGzemw6teyMkGwUQWLhsO/9BEkBlLpXcE5ZpFZDMyDMCy3/hiK7OgyBNDHBdVaFGY/
	qLm6QztNGhPQK57NXT7n46e/SEi1WKVZ3AJV5tpWUss1KjYDeujLCYQrQBtZUVzOMN2/ZoqqmcX
	xhtcIybkOIGhSCR3Cea6hflAPHspV53gt9o5w7QTwYwUWs8qwU4glaSXKA==
X-Google-Smtp-Source: AGHT+IEyXr4XfE4jQQNiBxD85qyqtlDpxh8WZZdKdE91l17CgQn/QudC/yJi3NGWG6c+9LLhlw/Xcg==
X-Received: by 2002:a5d:6c61:0:b0:38d:be5e:b2a7 with SMTP id ffacd0b85a97d-3997f937550mr4866832f8f.10.1742820799028;
        Mon, 24 Mar 2025 05:53:19 -0700 (PDT)
Received: from krzk-bin.. ([178.197.198.86])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3997f9efd61sm11017167f8f.91.2025.03.24.05.53.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 05:53:18 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Kim Seer Paller <kimseer.paller@analog.com>,
	Anshul Dalal <anshulusr@gmail.com>,
	Ramona Gradinariu <ramona.gradinariu@analog.com>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Robert Budai <robert.budai@analog.com>,
	Petre Rodan <petre.rodan@subdimension.ro>,
	Andreas Klinger <ak@it-klinger.de>,
	Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/2] dt-bindings: iio: Use unevaluatedProperties for SPI devices
Date: Mon, 24 Mar 2025 13:53:13 +0100
Message-ID: <20250324125313.82226-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250324125313.82226-1-krzysztof.kozlowski@linaro.org>
References: <20250324125313.82226-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

SPI devices should use unevaluatedProperties:false instead of
additionalProperties:false, to allow any SPI device properties listed in
spi-peripheral-props.yaml.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/iio/dac/adi,ad3552r.yaml      | 2 +-
 Documentation/devicetree/bindings/iio/dac/adi,ltc2664.yaml      | 2 +-
 Documentation/devicetree/bindings/iio/dac/adi,ltc2672.yaml      | 2 +-
 .../devicetree/bindings/iio/dac/microchip,mcp4821.yaml          | 2 +-
 Documentation/devicetree/bindings/iio/dac/rohm,bd79703.yaml     | 2 +-
 Documentation/devicetree/bindings/iio/imu/adi,adis16550.yaml    | 2 +-
 .../devicetree/bindings/iio/pressure/honeywell,hsc030pa.yaml    | 2 +-
 .../devicetree/bindings/iio/pressure/honeywell,mprls0025pa.yaml | 2 +-
 8 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad3552r.yaml b/Documentation/devicetree/bindings/iio/dac/adi,ad3552r.yaml
index 2d2561a52683..547044b8e246 100644
--- a/Documentation/devicetree/bindings/iio/dac/adi,ad3552r.yaml
+++ b/Documentation/devicetree/bindings/iio/dac/adi,ad3552r.yaml
@@ -217,7 +217,7 @@ required:
   - reg
   - spi-max-frequency
 
-additionalProperties: false
+unevaluatedProperties: false
 
 examples:
   - |
diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ltc2664.yaml b/Documentation/devicetree/bindings/iio/dac/adi,ltc2664.yaml
index 33490853497b..1aece3392b77 100644
--- a/Documentation/devicetree/bindings/iio/dac/adi,ltc2664.yaml
+++ b/Documentation/devicetree/bindings/iio/dac/adi,ltc2664.yaml
@@ -144,7 +144,7 @@ required:
 allOf:
   - $ref: /schemas/spi/spi-peripheral-props.yaml#
 
-additionalProperties: false
+unevaluatedProperties: false
 
 examples:
   - |
diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ltc2672.yaml b/Documentation/devicetree/bindings/iio/dac/adi,ltc2672.yaml
index c8c434c10643..3c8e5781e42c 100644
--- a/Documentation/devicetree/bindings/iio/dac/adi,ltc2672.yaml
+++ b/Documentation/devicetree/bindings/iio/dac/adi,ltc2672.yaml
@@ -124,7 +124,7 @@ required:
 allOf:
   - $ref: /schemas/spi/spi-peripheral-props.yaml#
 
-additionalProperties: false
+unevaluatedProperties: false
 
 examples:
   - |
diff --git a/Documentation/devicetree/bindings/iio/dac/microchip,mcp4821.yaml b/Documentation/devicetree/bindings/iio/dac/microchip,mcp4821.yaml
index 0dc577c33918..26011b5639d8 100644
--- a/Documentation/devicetree/bindings/iio/dac/microchip,mcp4821.yaml
+++ b/Documentation/devicetree/bindings/iio/dac/microchip,mcp4821.yaml
@@ -64,7 +64,7 @@ required:
   - reg
   - vdd-supply
 
-additionalProperties: false
+unevaluatedProperties: false
 
 examples:
   - |
diff --git a/Documentation/devicetree/bindings/iio/dac/rohm,bd79703.yaml b/Documentation/devicetree/bindings/iio/dac/rohm,bd79703.yaml
index 941a49c93943..188b00333dfb 100644
--- a/Documentation/devicetree/bindings/iio/dac/rohm,bd79703.yaml
+++ b/Documentation/devicetree/bindings/iio/dac/rohm,bd79703.yaml
@@ -43,7 +43,7 @@ required:
 allOf:
   - $ref: /schemas/spi/spi-peripheral-props.yaml#
 
-additionalProperties: false
+unevaluatedProperties: false
 
 examples:
   - |
diff --git a/Documentation/devicetree/bindings/iio/imu/adi,adis16550.yaml b/Documentation/devicetree/bindings/iio/imu/adi,adis16550.yaml
index a4c273c7a67f..cf5324de4fd6 100644
--- a/Documentation/devicetree/bindings/iio/imu/adi,adis16550.yaml
+++ b/Documentation/devicetree/bindings/iio/imu/adi,adis16550.yaml
@@ -53,7 +53,7 @@ required:
 allOf:
   - $ref: /schemas/spi/spi-peripheral-props.yaml#
 
-additionalProperties: false
+unevaluatedProperties: false
 
 examples:
   - |
diff --git a/Documentation/devicetree/bindings/iio/pressure/honeywell,hsc030pa.yaml b/Documentation/devicetree/bindings/iio/pressure/honeywell,hsc030pa.yaml
index 89977b9f01cf..412c7bcc310f 100644
--- a/Documentation/devicetree/bindings/iio/pressure/honeywell,hsc030pa.yaml
+++ b/Documentation/devicetree/bindings/iio/pressure/honeywell,hsc030pa.yaml
@@ -102,7 +102,7 @@ required:
 allOf:
   - $ref: /schemas/spi/spi-peripheral-props.yaml
 
-additionalProperties: false
+unevaluatedProperties: false
 
 dependentSchemas:
   honeywell,pmin-pascal:
diff --git a/Documentation/devicetree/bindings/iio/pressure/honeywell,mprls0025pa.yaml b/Documentation/devicetree/bindings/iio/pressure/honeywell,mprls0025pa.yaml
index 6994b30015bd..c756aa863103 100644
--- a/Documentation/devicetree/bindings/iio/pressure/honeywell,mprls0025pa.yaml
+++ b/Documentation/devicetree/bindings/iio/pressure/honeywell,mprls0025pa.yaml
@@ -115,7 +115,7 @@ allOf:
         honeywell,pmin-pascal: false
         honeywell,pmax-pascal: false
 
-additionalProperties: false
+unevaluatedProperties: false
 
 examples:
   - |
-- 
2.43.0


