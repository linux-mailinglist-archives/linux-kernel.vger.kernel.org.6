Return-Path: <linux-kernel+bounces-381419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DEBC9AFEF3
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 11:51:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D2B32859CE
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 09:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 475EA1D45FC;
	Fri, 25 Oct 2024 09:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Ft5xk7zE"
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24C9D1D8E1A
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 09:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729849863; cv=none; b=HFvurS3vmN9AbXjQwlHGYD6zHVSIXUXHtx5bJUYL9QJ1iAeI5B8BAvSVbQS70IcPTrSzWkqWehE10nrap9UDK9zJZ4oHMCEnm+100vBxeYDRG7gN/EQq9GTZz/CHQn2u/ondqEEZ9mV4myIGoMWAvPQiX84zW+0DOWgpVgpnyv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729849863; c=relaxed/simple;
	bh=ojKSNyD2EVe/IEDwrN7wNa8IQCtyeU4dv9gi0XQu3WA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IYrfQfC5x32YlqaK4did683u3ZQwngsGayN7TSs8aaNytuaJN7oLGWGYaD/Z8p40VJ2ttyrKLHGqO3/QUU7qRFie/u1TvRebxXB59uC1rKqM3UH0BGLOC/Zu+q0G5rCS6JpOz2HIDHsJdBWuRCrZaC0N/l6XeLDqWpkQiiLoBJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Ft5xk7zE; arc=none smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-43169902057so18379065e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 02:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1729849858; x=1730454658; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6D/EkgzRCNFr6KoXbaTUBYL2k31iFO9iPQDbeDyGB5w=;
        b=Ft5xk7zE3nekx2+aWnDPPFJ+Ft9/CgUtKSUPaAaDiNRcI5lJ0XZGDHgzSy7S/yOk2z
         7gWKcyBmbM3+HSIVOGoTbpMKQZu18/EywWFk9CNqeTAZLOFEJRTba37JbTvKTtXwsTNK
         E08/AMGEC8RLxWKEUBXWiHGkHqyZ8wBa1NZ3kdmnOQF3nrBkRYB/YpsaDeHKFBVG/zTd
         FRknN6C12GH3njC8U7OGWfAtZsgMonMk7KASVA8xMnUpMXbKg/FLTqrTxz0alD0G6U/e
         6eAV1AEnNRCpRW5AHjmbEBLrNMUlOWifMkI+ikQZUapmUzDEBNEgyduRXfsa+xZcFXKj
         UUfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729849858; x=1730454658;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6D/EkgzRCNFr6KoXbaTUBYL2k31iFO9iPQDbeDyGB5w=;
        b=Bdn/hnnbIyThCR56QIOUVffId1ZJy+RDVFNHfAw9l1tlLGIom/JqVimJ5mrvEEAe8b
         lpkN30ILeeYNaWKA27Hcceru+wzNdWoM8BboOf9iW257QmSeiuI96lc+arqbdYWSABUl
         ZCj+Au/9NlZro791vU9SPtD6TR91sicrtl9WbRNo/wjr7reZs5eywniHasPXppfIcXWS
         yMgymnX4al/lfGylfoPIivE+0m3C/KmmR2j9kRtJIgMgNhBdOCAorQaUl5ydKbpcqDkt
         Ru8SRJ7/0ulWgJOdHcOxIYrc4yDlSUNvZMfXSYLdJwf6znhIgwIsji+N1FNTs8KNyNrq
         rt2Q==
X-Forwarded-Encrypted: i=1; AJvYcCUswmDSRw5L9ALta630yfgcTVQwi8/qvpk+C5ACHF/ciiGjurpdY5pTgIzapQE+zbnRYErVzLvJi2VuHsY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtKsqljRH9PR8yDL0RgTC/RCFQtIAoUd9UPxQqdeiUON/SS9X6
	G+GVh58cSOG680ztvoFpjsgkGK5FMzOvdrm+zdZN87rgS8dgMa0x1awScHA3ABU=
X-Google-Smtp-Source: AGHT+IE114LR0WTlntFSwYvAPrjadnxcQND4J2U/6Kz2h7quT6UCFbT41wRpZHjBSlJ4bfiRzrBrrg==
X-Received: by 2002:a05:600c:35cd:b0:430:4db0:3fef with SMTP id 5b1f17b1804b1-4318415a2eemr70391325e9.15.1729849858237;
        Fri, 25 Oct 2024 02:50:58 -0700 (PDT)
Received: from [127.0.1.1] (host-79-41-194-153.retail.telecomitalia.it. [79.41.194.153])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431935f6df1sm12895085e9.35.2024.10.25.02.50.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 02:50:56 -0700 (PDT)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Date: Fri, 25 Oct 2024 11:49:35 +0200
Subject: [PATCH v8 2/8] dt-bindings: iio: dac: adi-axi-dac: add ad3552r axi
 variant
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241025-wip-bl-ad3552r-axi-v0-iio-testing-v8-2-74ca7dd60567@baylibre.com>
References: <20241025-wip-bl-ad3552r-axi-v0-iio-testing-v8-0-74ca7dd60567@baylibre.com>
In-Reply-To: <20241025-wip-bl-ad3552r-axi-v0-iio-testing-v8-0-74ca7dd60567@baylibre.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Olivier Moysan <olivier.moysan@foss.st.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>, 
 dlechner@baylibre.com, Angelo Dureghello <adureghello@baylibre.com>
X-Mailer: b4 0.14.1

From: Angelo Dureghello <adureghello@baylibre.com>

Add a new compatible and related bindigns for the fpga-based
"ad3552r" AXI IP core, a variant of the generic AXI DAC IP.

The AXI "ad3552r" IP is a very similar HDL (fpga) variant of the
generic AXI "DAC" IP, intended to control ad3552r and similar chips,
mainly to reach high speed transfer rates using a QSPI DDR
(dobule-data-rate) interface.

The ad3552r device is defined as a child of the AXI DAC, that in
this case is acting as an SPI controller.

Note, #io-backend is present because it is possible (in theory anyway)
to use a separate controller for the control path than that used
for the datapath.

Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
---
 .../devicetree/bindings/iio/dac/adi,axi-dac.yaml   | 69 +++++++++++++++++++++-
 1 file changed, 66 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/dac/adi,axi-dac.yaml b/Documentation/devicetree/bindings/iio/dac/adi,axi-dac.yaml
index a55e9bfc66d7..1adba9aceeb1 100644
--- a/Documentation/devicetree/bindings/iio/dac/adi,axi-dac.yaml
+++ b/Documentation/devicetree/bindings/iio/dac/adi,axi-dac.yaml
@@ -19,11 +19,13 @@ description: |
   memory via DMA into the DAC.
 
   https://wiki.analog.com/resources/fpga/docs/axi_dac_ip
+  https://analogdevicesinc.github.io/hdl/library/axi_ad3552r/index.html
 
 properties:
   compatible:
     enum:
       - adi,axi-dac-9.1.b
+      - adi,axi-ad3552r
 
   reg:
     maxItems: 1
@@ -36,7 +38,14 @@ properties:
       - const: tx
 
   clocks:
-    maxItems: 1
+    minItems: 1
+    maxItems: 2
+
+  clock-names:
+    items:
+      - const: s_axi_aclk
+      - const: dac_clk
+    minItems: 1
 
   '#io-backend-cells':
     const: 0
@@ -47,7 +56,29 @@ required:
   - reg
   - clocks
 
-additionalProperties: false
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: adi,axi-ad3552r
+    then:
+      $ref: /schemas/spi/spi-controller.yaml#
+      properties:
+        clocks:
+          minItems: 2
+        clock-names:
+          minItems: 2
+      required:
+        - clock-names
+    else:
+      properties:
+        clocks:
+          maxItems: 1
+        clock-names:
+          maxItems: 1
+
+unevaluatedProperties: false
 
 examples:
   - |
@@ -57,6 +88,38 @@ examples:
         dmas = <&tx_dma 0>;
         dma-names = "tx";
         #io-backend-cells = <0>;
-        clocks = <&axi_clk>;
+        clocks = <&clkc 15>;
+        clock-names = "s_axi_aclk";
+    };
+
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    axi_dac: spi@44a70000 {
+        compatible = "adi,axi-ad3552r";
+        reg = <0x44a70000 0x1000>;
+        dmas = <&dac_tx_dma 0>;
+        dma-names = "tx";
+        #io-backend-cells = <0>;
+        clocks = <&clkc 15>, <&ref_clk>;
+        clock-names = "s_axi_aclk", "dac_clk";
+
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        dac@0 {
+            compatible = "adi,ad3552r";
+            reg = <0>;
+            reset-gpios = <&gpio0 92 GPIO_ACTIVE_HIGH>;
+            io-backends = <&axi_dac>;
+            spi-max-frequency = <20000000>;
+
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            channel@0 {
+                reg = <0>;
+                adi,output-range-microvolt = <(-10000000) (10000000)>;
+            };
+        };
     };
 ...

-- 
2.45.0.rc1


