Return-Path: <linux-kernel+bounces-317411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CC6496DDC4
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 17:19:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFFA41F22FD1
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 15:19:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFA6119CD12;
	Thu,  5 Sep 2024 15:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="D9EkiPVv"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFB13126F1E
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 15:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725549535; cv=none; b=i9zaoaxmlJVgYAoQahptbENPHsYLUqe8tqX9F9d0ejJTitKw1Sgn+ytH1eluZ9SKFd/UFy1LLhxC/5vkOcM6sixnppA1MOlFn8msJw9sBmLbQYJe3Szww9MT9B7BS78YcHPyg/hd+5rX1I7K1R7iPWazZ6PdT/Y1mmmd9AZAAxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725549535; c=relaxed/simple;
	bh=z/eAL85+Stkl1y4Ul6ptW+vDl8DzLb24T1aicacKSuY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bqrHcKjza3ZTxm4C0MWs8vaRoDH0L9ucoilm+z5emZaMVQ8gE5otTr1kY1YFRfyWHfedJdr5WuQIHKpZIb4GYkBtZSqw2MBwe+xOp75EduqRPFbri+PwcP3KGYRUZQqlMaO6kpYU7GFO+86iQlwivQm8s4E0JkZ1V7+kKwSrxFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=D9EkiPVv; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-428e0d184b4so7471025e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2024 08:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1725549531; x=1726154331; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J+pBsXxWmPsUINwVEM73NhnNRhkHrDQ3OXCzogbxm5A=;
        b=D9EkiPVv3LCsym5vjYXAIFlUN5kyy6dvw/9+ECYp2XJu5Wx6es2U1l2COl9x7F0Yex
         d1FsP7htfEtE6K4rYT8zURgGKVgdRisO+ERYWAOOZES1xAUeFy4GEjoiGnt2Fr4BOi/g
         sjlvrz3+Q+Cbl/uMYRkcFJusgkLYNdP34+3bcyoUpbOAr+9LAuFd6hXRuVYCQA1R/GKL
         qQA8mScxxNp/TUltF5re4ZVz1RsLwSzyiapXFBZm+p9Xy8upLgYt9YuFtb5YuDj7MW05
         fc+p/WRb8MpePthk2XKxCIQ8T9IOXC8VpoUuaqHMXDc2wKKQ1mBmHe8Uy5uY3Ve66rzi
         Qicg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725549531; x=1726154331;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J+pBsXxWmPsUINwVEM73NhnNRhkHrDQ3OXCzogbxm5A=;
        b=UVwbXU3DmaByFJpkrGPxx9MsUvWpxjB06v2e3NE3aqjH8DigfmyPf+W3pLDPR7APO2
         /4MAKXUcX+dUhrIP+VJOU4JUsfavYKdgm0rRVtqNna/e4bQ59Kr4B0etx4hzjE15HCgT
         SKOFvmULbz+SsapYaPWiKxWNgiDOeqJxbiWoeg0o8eWByLy1m1mVAxVA8LMKiSIHRUVM
         wYS5lmXE9SsaBj6chOvkjMdjdwg/kiN4N7AVb9/Y9nEZRAEcW0SmOS8UlaSV2wDC61Kx
         RLgE5pMjImMGhnSREevIiQDHZmgAI9h6uvdEUESt+AIlqOAISTiYZ9xQi1TS42Vdf3Um
         QfzA==
X-Forwarded-Encrypted: i=1; AJvYcCX3i3kKTAGIEzFyZ69IXG858Yckx7xdNbvKqhtjXnDkqyHKzc6+XVKJLHUv1EmC25Uu/Rim5WiAR2JiWsw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzG2lignZsgXRfG1Omefa4svlcz09OKABgf/uvPi4j1ng6iTWvi
	euZeLAtyRcYDnGUWe2s77YCNn8x7m7au70oS7Z4LGdKJF1rDl12oOHmo/mVvzvQ=
X-Google-Smtp-Source: AGHT+IGMtKkHEjH1/QBXvm71HwV6HrgYuJ8pRKgPHpUaa29RWeMdklaPHmHLjNcPgTRqGi+NronBag==
X-Received: by 2002:a05:600c:1c0d:b0:429:994:41ae with SMTP id 5b1f17b1804b1-42c7b59e84cmr109955125e9.2.1725549530949;
        Thu, 05 Sep 2024 08:18:50 -0700 (PDT)
Received: from [127.0.1.1] (host-95-233-232-76.retail.telecomitalia.it. [95.233.232.76])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-374c1de81b2sm14031076f8f.30.2024.09.05.08.18.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 08:18:50 -0700 (PDT)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Date: Thu, 05 Sep 2024 17:17:31 +0200
Subject: [PATCH v2 1/9] dt-bindings: iio: dac: ad3552r: add io-backend
 property
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240905-wip-bl-ad3552r-axi-v0-iio-testing-v2-1-87d669674c00@baylibre.com>
References: <20240905-wip-bl-ad3552r-axi-v0-iio-testing-v2-0-87d669674c00@baylibre.com>
In-Reply-To: <20240905-wip-bl-ad3552r-axi-v0-iio-testing-v2-0-87d669674c00@baylibre.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Olivier Moysan <olivier.moysan@foss.st.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, David Lechner <dlechner@baylibre.com>, 
 Angelo Dureghello <adureghello@baylibre.com>
X-Mailer: b4 0.14.1

From: Angelo Dureghello <adureghello@baylibre.com>

There is a version AXI DAC IP block (for FPGAs) that provides
a physical bus for AD3552R and similar chips. This can be used
instead of a typical SPI controller to be able to use the chip
in ways that typical SPI controllers are not capable of.

The binding is modified so that either the device is a SPI
peripheral or it uses an io-backend.

Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
---
 .../devicetree/bindings/iio/dac/adi,ad3552r.yaml   | 42 ++++++++++++++++++++--
 1 file changed, 40 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad3552r.yaml b/Documentation/devicetree/bindings/iio/dac/adi,ad3552r.yaml
index fc8b97f82077..a6ce863ca93c 100644
--- a/Documentation/devicetree/bindings/iio/dac/adi,ad3552r.yaml
+++ b/Documentation/devicetree/bindings/iio/dac/adi,ad3552r.yaml
@@ -60,12 +60,30 @@ properties:
     $ref: /schemas/types.yaml#/definitions/uint32
     enum: [0, 1, 2, 3]
 
+  io-backends:
+    description: The iio backend reference.
+      An example backend can be found at
+        https://analogdevicesinc.github.io/hdl/library/axi_ad3552r/index.html
+    maxItems: 1
+
   '#address-cells':
     const: 1
 
   '#size-cells':
     const: 0
 
+if:
+  required:
+    - reg
+
+then:
+  $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+  properties:
+    io-backends: false
+
+  required: [ spi-max-frequency ]
+
 patternProperties:
   "^channel@([0-1])$":
     type: object
@@ -207,8 +225,6 @@ allOf:
 
 required:
   - compatible
-  - reg
-  - spi-max-frequency
 
 additionalProperties: false
 
@@ -238,4 +254,26 @@ examples:
             };
         };
     };
+
+  - |
+    backend: axi_dac@44a70000 {
+        compatible = "adi,axi-dac-ad3552r";
+        reg = <0x44a70000 0x1000>;
+        dmas = <&dac_tx_dma 0>;
+        dma-names = "tx";
+        #io-backend-cells = <0>;
+        clocks = <&ref_clk>;
+        dac {
+            compatible = "adi,ad3552r";
+            reset-gpios = <&gpio0 92 1>;
+            io-backends = <&backend>;
+            #address-cells = <1>;
+            #size-cells = <0>;
+            channel@0 {
+                reg = <0>;
+                adi,output-range-microvolt = <(-10000000) (10000000)>;
+            };
+        };
+    };
+
 ...

-- 
2.45.0.rc1


