Return-Path: <linux-kernel+bounces-234057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F186691C18B
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 16:49:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 210D81C238B6
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 14:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D96F1C68B9;
	Fri, 28 Jun 2024 14:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="BLG46gih"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D70791C0DD6
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 14:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719586124; cv=none; b=RmDjRGLW+abArr+/stJ0nRRoMu4hGogzvGyePcFhfs7iFE/zGWSm88MW6Ci3AYb1dD45HwhyxRW7mbTdQLW7vAWW4kbYis4io/5DW1aIhP8SxSCc1AFr+qxOQmMDAaRJxQEh7+EFqJev4tRW3uWrmlhV8zVGEJeiByTJNtb71mQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719586124; c=relaxed/simple;
	bh=pbVttNwmh0wXwB2M+J1lmKxK6g4AGHnPIqH7k9p554I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=X+R1fzQO/dgrdO10EPiwbQV2U5Ndr1htqTqtZiFEkPIUN56qejZ7QMJMXmafNwobasIhbhAnYIAqfoTX5ClAr5vO2LGnIRYmdE8KPmsRWRC/iTe0i6D4iHMnffrCBE1vkBZjfbmvOdAobWJDFLIlBahMxh6s+wi5S9AfVXSeMv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=BLG46gih; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-42562a984d3so5456945e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 07:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1719586120; x=1720190920; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=twxKpEjx0LE+O9asNVqI6nlOWrql2lHpjBPHpnXyihY=;
        b=BLG46gihePOXsJ3H7nGHUOJ0B604VwZfR2b5mwP+toKSM5XCTpfZJqU2ALfSv6Vds2
         OL/d6rkU0GWcQwcDKHlv8/InkUIY8fmLc9gCuv6vgfRgMzrZUX1bBOu8lVYnfBLHufBt
         A5MsqMQM/zA6xUem8O9xLE2qcXBVI1cVS7x0e4z1K6maA7swthZbtcsTaJyXV1XgOF34
         9IjOxw4qEz+cu0f7d80z3lsbzPz26rkPhwM56WyULxAlNWw1P2DR616hyxbMs+X8g40E
         Y/1YGTOwhQossZ4u2FQb1kNAzPCVL9OMIQaPnG503xBlDStVDW1Qp1Zgz6qn+MkC/ZgN
         VyiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719586120; x=1720190920;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=twxKpEjx0LE+O9asNVqI6nlOWrql2lHpjBPHpnXyihY=;
        b=mdDa9y3Z40I5tLT76s/LlYRKYgEA6d5pKVH/5gm0P1G53yefEiIRbeCP6RmhxoSk+s
         qoXc6g5OCg5yWPMCIy8wJrKCLgjLLuxudrW8z2pyoS4uKdXkHQZP64D4BZ2QwJzF8zEo
         +MwpdBGG39FdiqKTX/8b/WmOJG7stzQHIQgnmCyOW6lcj079P1yPa98C1gGM6BEi9/04
         3Qru6I5UPEl3S7wIS0Dssim47ORzjMGmwa7k3gLN3aHtFZOJrK22AuGdWKN3An1/RGcM
         K6EGcEGDKBp9yKuswy1QRxT2Vir+9eft1k6fRxObphvYkE9JalemLQ3WeYe607s39rtU
         797g==
X-Forwarded-Encrypted: i=1; AJvYcCUTvJChMETi/36TTP+sZNinVk/Mj8p0+Ysrj3FoH0A8lRrVM64RRnKMgV94G5biaeaOAmkmkj1ECqu5BZlqz7TW0mVQWFUk/0/CcvXN
X-Gm-Message-State: AOJu0YzmVsn9ae5lrrB3H2e9kG6MqDDYnVEOFu6elIEmFa99lBKwD5aw
	Od+/eXc4SUNyAfOm7JqOu9JiXu205IKyi90Vsf6DRpkUHOXfJTPBwvL5DFepEqc=
X-Google-Smtp-Source: AGHT+IGDEJSqJJFi40+Iyz/doQiUT5xclEpI4r6XNNik0aXkd7H1+HKugVHcbyzlEMT+fDZMYSh51w==
X-Received: by 2002:a05:600c:929:b0:425:65c5:79b4 with SMTP id 5b1f17b1804b1-42565c57b9amr38442305e9.26.1719586120001;
        Fri, 28 Jun 2024 07:48:40 -0700 (PDT)
Received: from [127.0.1.1] (frhb82016ds.ikexpress.com. [185.246.87.17])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4256af55c0asm37972575e9.15.2024.06.28.07.48.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 07:48:39 -0700 (PDT)
From: Guillaume Stols <gstols@baylibre.com>
Date: Fri, 28 Jun 2024 14:48:22 +0000
Subject: [PATCH v2 04/10] dt-bindings: iio: adc: adi,ad7606: improve
 descriptions
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240628-cleanup-ad7606-v2-4-96e02f90256d@baylibre.com>
References: <20240628-cleanup-ad7606-v2-0-96e02f90256d@baylibre.com>
In-Reply-To: <20240628-cleanup-ad7606-v2-0-96e02f90256d@baylibre.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Beniamin Bia <beniamin.bia@analog.com>, 
 Stefan Popa <stefan.popa@analog.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Michael Hennerich <michael.hennerich@analog.com>, 
 linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Guillaume Stols <gstols@baylibre.com>, jstephan@baylibre.com, 
 dlechner@baylibre.com
X-Mailer: b4 0.14.0

Reword a few descriptions, and normalize the text width to 80 characters.

Signed-off-by: Guillaume Stols <gstols@baylibre.com>
---
 .../devicetree/bindings/iio/adc/adi,ad7606.yaml    | 33 +++++++++++++---------
 1 file changed, 20 insertions(+), 13 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml
index 32caa9fc00e4..509970922cda 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml
@@ -36,6 +36,9 @@ properties:
   avcc-supply: true
 
   interrupts:
+    description:
+      The BUSY pin falling edge indicates that the conversion is over, and thus
+      new data is available.
     maxItems: 1
 
   adi,conversion-start-gpios:
@@ -48,8 +51,9 @@ properties:
   reset-gpios:
     description:
       Must be the device tree identifier of the RESET pin. If specified, it will
-      be asserted during driver probe. As the line is active high, it should be
-      marked GPIO_ACTIVE_HIGH.
+      be asserted during driver probe. On the AD7606x, as the line is active
+      high, it should be marked GPIO_ACTIVE_HIGH. On the AD7616, as the line is
+      active low, it should be marked GPIO_ACTIVE_LOW.
     maxItems: 1
 
   standby-gpios:
@@ -62,36 +66,39 @@ properties:
 
   adi,first-data-gpios:
     description:
-      Must be the device tree identifier of the FRSTDATA pin.  The FRSTDATA
+      Must be the device tree identifier of the FRSTDATA pin. The FRSTDATA
       output indicates when the first channel, V1, is being read back on either
-      the parallel, byte or serial interface.  As the line is active high, it
+      the parallel, byte or serial interface. As the line is active high, it
       should be marked GPIO_ACTIVE_HIGH.
     maxItems: 1
 
   adi,range-gpios:
     description:
-      Must be the device tree identifier of the RANGE pin. The polarity on this
+      Must be the device tree identifier of the RANGE pin. The state on this
       pin determines the input range of the analog input channels. If this pin
       is tied to a logic high, the analog input range is ±10V for all channels.
-      If this pin is tied to a logic low, the analog input range is ±5V for all
-      channels. As the line is active high, it should be marked
+      On the AD760X, if this pin is tied to a logic low, the analog input range
+      is ±5V for all channels. As the line is active high, it should be marked
       GPIO_ACTIVE_HIGH.
     maxItems: 1
 
   adi,oversampling-ratio-gpios:
     description:
       Must be the device tree identifier of the over-sampling mode pins. As the
-      line is active high, it should be marked GPIO_ACTIVE_HIGH.
+      line is active high, it should be marked GPIO_ACTIVE_HIGH. On the AD7606X
+      parts that support it, if all 3 pins are tied to a logic high, software
+      mode is enabled.
     maxItems: 3
 
   adi,sw-mode:
     description:
-      Software mode of operation, so far available only for ad7616 and ad7606b.
+      Software mode of operation, so far available only for AD7616 and AD7606b.
       It is enabled when all three oversampling mode pins are connected to high
-      level. The device is configured by the corresponding registers. If the
-      adi,oversampling-ratio-gpios property is defined, then the driver will set
-      the oversampling gpios to high. Otherwise, it is assumed that the pins are
-      hardwired to VDD.
+      level for the AD7606B, or all two range selection pins are connected to
+      high level for the AD7616. The device is configured by the corresponding
+      registers. If the adi,oversampling-ratio-gpios property is defined, then
+      the driver will set the oversampling gpios to high. Otherwise, it is
+      assumed that the pins are hardwired to VDD.
     type: boolean
 
 required:

-- 
2.34.1


