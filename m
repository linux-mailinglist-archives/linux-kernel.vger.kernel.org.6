Return-Path: <linux-kernel+bounces-390074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DCA99B752D
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 08:18:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33B6D286527
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 07:18:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B5BB14D456;
	Thu, 31 Oct 2024 07:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="LlMyQyNf"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 978281487C1
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 07:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730359076; cv=none; b=rZeb1kQKMJA1ZABYIEnNqCNuvGFtQmgNPAnTIe/HPWeZm2ejVOoexLL8wONw49Ix/gtsSoi3sDOQlflR7yE9aSjvCRc1VwtZuLzrNQfkQj+RmVQiWTOHH92JVfRei1pH41zoAOKdUeiOUOXU4nphYai1Mk6bUp/D8vDd0pp0UkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730359076; c=relaxed/simple;
	bh=xu4vcOByqa0T+o0Mtg/VMSPa5suwUETcqrDuyfDGNgQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WDHMEp1I007Lv0wGMcqxfTNNaMoB9cs0/elMVAQ8YcNB/Ea7VsQF5b7+NIHWfModrnZRl/eZEMk8o5a9+IHTCXdnpuArGoMS9ZFX4zN4l7aueOZ2sde5B1fLWtmOtoYGyyrflJJhCLSnd+dVbA2PMdYun/8ucvnLdq+JCKHkdRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=LlMyQyNf; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-37d6a2aa748so343581f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 00:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1730359071; x=1730963871; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m6z7u9n04i1CD+dVrnwMZN3subLaG04bfZd3Fni/4JM=;
        b=LlMyQyNfYnMucYPqFikZvNwyXYu4Yd4ozfSFZTRxmq3hBmBHZgDZpzf1Pevq7xwQb0
         2sl6nlXojLiVtjy4LhsNSxTYYKrK5Yhhlmt/1PZ5hXY4WZ70wABFA15EHH6jp/ObSSo+
         01foXQyha3AV4txE76kCG1zE2CagYyhHOT+y42WeOk4sTHNRWKT9R2foD4PTjS8D879J
         Xd9oJHKyFh9JOv9+dIq4ek9bIdD+jGmPrSHtl9PbQOcnBRkgTqCDAnQL/c09ZTZz1v6c
         kqxpZ+poh6Kktjhl5wAJV4FUzwTQMuoFys996EaRZdnkMen/7NNn7PM9jgC88GlQCD49
         iZgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730359071; x=1730963871;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m6z7u9n04i1CD+dVrnwMZN3subLaG04bfZd3Fni/4JM=;
        b=A0nA8bilh/FJf2ePYJYcWmw0a15rteCQsRT3S7Qhhid4ambJhO1Z2dIKMhfczdafcL
         XZ7u3MfwBwyOiVdTAb/I+lm5rUhX8wYlNvLBjnkGW0nlUPnSw8OZIcZqYyR16XgUhb+o
         6Ka6RuKw52xMemUlqMPFvC2KJcYc+GrQ78BrkaqP0HV+JW97PDPaxQyX4ZDpXJBa/Gvb
         XKr/jy8BVa+hwSkTvA+RYIHlCIQFIobBWVS235T3wRhCBJAi5HedUbu6KIQgBHZwyMyx
         PeOhk62TRk6rzKS4YPZWTwv4ZjHYP5vwLZWdKblMIsOOtI4H37F1GO/aFjqZIq0aP+QS
         Gm0g==
X-Forwarded-Encrypted: i=1; AJvYcCW45SJq8rhh9vyfPoatio9+W8qwuQeVnn8DB3RVU0rTlyMv5oh2Ip6NY6dNQLqpibFMDzf0ZDBm+EeDS3Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoVau7ttW5gBY3tAP/XmEnsj0Q8tm6nBRtLrcWX939MTUrJ3PC
	NR4ewhqu5xaYtMYIV9Tj4dPaPpb5Kqa4af0VRkg081zRx4MKSmsCbrRtQtTgucA=
X-Google-Smtp-Source: AGHT+IHqsSrRK3WaqLyPzOG0cz8hA2PrJwrsarp3k2DUiOAi+1UO9m3fvc3ksKyJ1vyEA2H50edTtA==
X-Received: by 2002:adf:e543:0:b0:37d:54d0:1f20 with SMTP id ffacd0b85a97d-38061158e30mr12973741f8f.24.1730359070881;
        Thu, 31 Oct 2024 00:17:50 -0700 (PDT)
Received: from axelh-ThinkPad-T450s.home (lfbn-nic-1-251-169.w2-15.abo.wanadoo.fr. [2.15.94.169])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c113e694sm1187547f8f.86.2024.10.31.00.17.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 00:17:50 -0700 (PDT)
From: ahaslam@baylibre.com
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	nuno.sa@analog.com,
	dlechner@baylibre.com
Cc: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Axel Haslam <ahaslam@baylibre.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 1/6] dt-bindings: iio: dac: ad5791: Add optional reset, clr and ldac gpios
Date: Thu, 31 Oct 2024 08:17:41 +0100
Message-Id: <20241031071746.848694-2-ahaslam@baylibre.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241031071746.848694-1-ahaslam@baylibre.com>
References: <20241031071746.848694-1-ahaslam@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Axel Haslam <ahaslam@baylibre.com>

Depending on board layout, the ad57xx may need control of reset, clear,
and ldac pins by the host driver. Add optional bindings for these gpios.

Reviewed-by: David Lechner <dlechner@baylibre.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Axel Haslam <ahaslam@baylibre.com>
---
 .../devicetree/bindings/iio/dac/adi,ad5791.yaml   | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad5791.yaml b/Documentation/devicetree/bindings/iio/dac/adi,ad5791.yaml
index c81285d84db7..fe664378c966 100644
--- a/Documentation/devicetree/bindings/iio/dac/adi,ad5791.yaml
+++ b/Documentation/devicetree/bindings/iio/dac/adi,ad5791.yaml
@@ -31,6 +31,17 @@ properties:
       gain of two configuration.
     type: boolean
 
+  reset-gpios:
+    maxItems: 1
+
+  clear-gpios:
+    maxItems: 1
+
+  ldac-gpios:
+    description:
+      LDAC pin to be used as a hardware trigger to update the DAC channels.
+    maxItems: 1
+
 required:
   - compatible
   - reg
@@ -44,6 +55,7 @@ unevaluatedProperties: false
 
 examples:
   - |
+    #include <dt-bindings/gpio/gpio.h>
     spi {
         #address-cells = <1>;
         #size-cells = <0>;
@@ -53,6 +65,9 @@ examples:
             reg = <0>;
             vss-supply = <&dac_vss>;
             vdd-supply = <&dac_vdd>;
+            reset-gpios = <&gpio_bd 16 GPIO_ACTIVE_LOW>;
+            clear-gpios = <&gpio_bd 17 GPIO_ACTIVE_LOW>;
+            ldac-gpios = <&gpio_bd 18 GPIO_ACTIVE_HIGH>;
         };
     };
 ...
-- 
2.34.1


