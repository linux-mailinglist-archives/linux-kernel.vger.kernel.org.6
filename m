Return-Path: <linux-kernel+bounces-176324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 851468C2E05
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 02:50:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F016A1F22EB5
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 00:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED173134BD;
	Sat, 11 May 2024 00:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="I+AF6YZv"
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF0968F5C
	for <linux-kernel@vger.kernel.org>; Sat, 11 May 2024 00:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715388601; cv=none; b=AVSieAhNY7J73yiiXm9wybFegPCrXE8l6Uqd9dSir99GQAYQOgaaCNmruhzX5AtpcNlK1p0s8XzYQidZG7UciY6gr/OOpApLCoOMRlsXMVG3Mkr1RX0wScyaZgjpdrcLAq49EMoTuQ1nIaSDYYa8jEu46m839iQRqS9Wq/EnNRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715388601; c=relaxed/simple;
	bh=QslN9hiRjif2714MLfUNTy1aeizyH8JMJMB6mPnzuPI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i9hI2ZX/lfs7U+/0qVptT/vbOYUdUxWHTAetE7F7rdTGeGZe2pYu/vD/tJ72jK11gz9SsL2OMN+nrvmo21GumB3kxywzwl1pUQcYaHuaDf9KCIk95ZkN99jiECeJv71SLEd5+d8ct1F2uw1m9GEofx+cRBaQrswYJuFvMLxFgW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=I+AF6YZv; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5b27999f889so1014457eaf.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 17:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1715388597; x=1715993397; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wm1JDIpGQ3/Aqds3KMjjWWOJUYPSXntTpGvlaeWf3LY=;
        b=I+AF6YZvb0ZGtqfxIrQkw4wQE744NHHGfeUB2+wEHvD43mTYqJ2ZarJQdW3ERqrwVb
         3216460M4XoEsbjvfOhcjNtYa8MFESqGPiOEp3agpE3GpURId0+YTxVSvgIsNrAveWRR
         Kur18iuO86itQz2qZ6VL75LlRHdL3Bw+3dN9qmYJbkW7wLBgxYc/ky5l8GlZegY17jLl
         Czsb9EOBKyWCTJwsUxYGYRWgVsmVsvTNyKmY+40iD3jY3xHkohN1/9uooJy3Y+boag2g
         Y8qUg5Z4Mc1gQODqpnXEPy0eq246RoJX6kKrCtQOc62uR2+2uQkE6q1BS2N5t4XBN4WE
         55iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715388597; x=1715993397;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wm1JDIpGQ3/Aqds3KMjjWWOJUYPSXntTpGvlaeWf3LY=;
        b=JBxUFzzpN5F1ugGkpuXBO+Je2FJA19SOj3JbbvEo9QUx2E+WgfFTEoteJzCxKoXOSy
         5FsprEJaDjUR8jEwcaQ12W8wPVXjuD84cGt+EHr/rV8e+7TstAOQhGsLg+/43epysVOr
         elMLzA3qkFjmCUf6LRsJz94MfNsBYU/+GMENs0ORlZXXqgrahOjHMi5cWdmjoPnrLRBJ
         DrebckEJTRwhU+AbaA0qfn46J2owUiCDShXsP5AOXcHlYM/sagpnX8XB7LEBnQMX+b1J
         uGLdQN8nupwmRjMs7Q7PlYWIf9zNdq2/UpLDxG+u3ELqE/4X65W2AnOUyCGJ1bf+u+E2
         0Hcg==
X-Forwarded-Encrypted: i=1; AJvYcCWsPln58/EAncAFtrWS1kKu+KKVZVlMJVnOSHTNRrpRAllCpgT8/aMuOCIKf/hLosrEBR/Cu0JJliiZ91Y9EIfDQH0CX8TOpHkKeRub
X-Gm-Message-State: AOJu0Yy8IfH5CVBhNPWwhkfIrnAK+WVo5lNTTGrhctwpQ/BdwBVu6bVF
	BGiXuxooe749GQ2eBoFRzoGS4a+L+yWRmj30j5SUO0M65litC1w6FHL720Yos6I=
X-Google-Smtp-Source: AGHT+IHIlPJpLdkHvfVzDbw2X1xtwQanIP+eKehd+NyrLExBkWOAZfON5byOulKnrHpJ4Pdp/WT0fg==
X-Received: by 2002:a4a:907:0:b0:5af:4b39:b7e0 with SMTP id 006d021491bc7-5b2815cd612mr4164258eaf.0.1715388597084;
        Fri, 10 May 2024 17:49:57 -0700 (PDT)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5b29015a3dbsm321132eaf.46.2024.05.10.17.49.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 May 2024 17:49:56 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: Mark Brown <broonie@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	=?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Cc: David Lechner <dlechner@baylibre.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	David Jander <david@protonic.nl>,
	Martin Sperl <kernel@martin.sperl.org>,
	linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org
Subject: [PATCH RFC v2 1/8] spi: dt-bindings: spi-peripheral-props: add spi-offloads property
Date: Fri, 10 May 2024 19:44:24 -0500
Message-ID: <20240510-dlech-mainline-spi-engine-offload-2-v2-1-8707a870c435@baylibre.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240510-dlech-mainline-spi-engine-offload-2-v2-0-8707a870c435@baylibre.com>
References: <20240510-dlech-mainline-spi-engine-offload-2-v2-0-8707a870c435@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.4
Content-Transfer-Encoding: 8bit

This adds a new property to the spi-peripheral-props binding for use
with peripherals connected to controllers that support offloading.

Here, offloading means that the controller has the ability to perform
complex SPI transactions without CPU intervention in some shape or form.

This property will be used to assign controller offload resources to
each peripheral that needs them. What these resources are will be
defined by each specific controller binding.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---

v2 changes:

In v1, instead of generic SPI bindings, there were only controller-
specific bindings, so this is a new patch.

In the previous version I also had an offloads object node that described
what the offload capabilities were but it was suggested that this was
not necessary/overcomplicated. So I've gone to the other extreme and
made it perhaps over-simplified now by requiring all information about
how each offload is used to be encoded in a single u32.

We could of course consider using #spi-offload-cells instead for
allowing encoding multiple parameters for each offload instance if that
would be preferable.

I also considered adding spi-offload-names that could be used as sort
of a compatible string (more of an interface name really) in case some
peripherals may want to support more than 1 specialized type of offload.
---
 .../devicetree/bindings/spi/spi-peripheral-props.yaml          | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
index 15938f81fdce..32991a2d2264 100644
--- a/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
+++ b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
@@ -113,6 +113,16 @@ properties:
     minItems: 2
     maxItems: 4
 
+  spi-offloads:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    description:
+      Array of controller offload instances that are reserved for use by the
+      peripheral device. The semantic meaning of the values of the array
+      elements is defined by the controller. For example, it could be a simple
+      0-based index of the offload instance, or it could be a bitfield where
+      a few bits represent the assigned hardware trigger, a few bits represent
+      the assigned RX stream, etc.
+
   st,spi-midi-ns:
     description: |
       Only for STM32H7, (Master Inter-Data Idleness) minimum time

-- 
2.43.2


