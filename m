Return-Path: <linux-kernel+bounces-263440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B55D93D5DD
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 17:20:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F3D91C213F4
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 15:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0D8517BB27;
	Fri, 26 Jul 2024 15:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="cigl8/tE"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B71017838B
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 15:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722007221; cv=none; b=QHo8l6zHx9Qcs8+7opq48gmzcXoVwNryvwBQaRaA20PtK0HcxycWJff7sYiZF9D6Ha+uN53I8wiltQsIO9jYRJ/vStF10/Hy87LriMczBGftoTRk2GbCIyDa1G2Yd19GXas0E1G7WJT3TmlXJzca1KHrLxzPkUyOD1C0luN7qJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722007221; c=relaxed/simple;
	bh=Wssp4WjVtyj6iSp1oTG65Llzl3UO6tQh3DmSYdmkQDY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TS24vlgDSvJT5Ch47ce8VcUIMZmxHRbLaOjIssmkG1YnF5uh3XpNI/6M/h4jCMkrvHNng06tQV0HdC+7HbGCowCVpaAnFZMQAVuUblwgNFI0nHll6GB7pY0BvbB8u6l2wmHdNImOmSPgPoqbXF/LUfFss9/MzvXkkE/3hGXDwHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=cigl8/tE; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4266f3e0df8so16120015e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 08:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1722007218; x=1722612018; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F2skOjiFYKjk3dOreUHC9yqXYXSEw6vmwROIl1YBK1I=;
        b=cigl8/tE1FR8rcVO4v8ynSq5gJVi/hxDZ+q4yuQwHUTuFEWaH9dsgUDNTJjma6KbB+
         jxd5pNSVG8zMmah5KCKyRc3go1kgLRNQO+qXm3IDymNNQOGPAGBGCV9gDrrQzFnju4j5
         bExVWRgK0Cdx/4J/IHcOUYIhaMag7zMX0y+Dq9dK9bbOgLzInii9pTEX3AVOco7LdyOE
         3yesCCPsa1QHx6HJXyimPHqdGw+59HGvKoQ8HU+swujfBnxYfbPONfrKH3RtyqdgLmRl
         JI1DJRbukjjgkdLyxLTwOS/SGPMQfpjLyn4YF35Y4k9GtgjaDQRIjc6bBswk0dhDfqDG
         Jx/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722007218; x=1722612018;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F2skOjiFYKjk3dOreUHC9yqXYXSEw6vmwROIl1YBK1I=;
        b=iZhO1Im4JtyYaYp7yxYuwyUYSRbsWfJ9mT++IcuoFCSPvuDJoBqFtxGC7MkG7zmMU7
         2BbW8wKSdFk0aOzdAbWeTFSjNcN7Dak4Bz5V0XxasXmc1vNGR8je9rd6yDTx7I0b6Y+s
         Yso5OG2poG13VSNQoOcUkfaShGmkRA7Tp+2eoIY/gSWDZTwbIlJtqu2u2mVWOsnEOfjD
         6rFrfsD/v2Ab4XbeM4IHb3iLdr+by1jSufz7AfafjFPy663deBRGlRmpY011d4Dw7AFE
         /+naFzmBRfWvOm1tMvgighte7d9y4vjwp12xVkYvjSmVT1CsV5zeLjsmL028xuqD2U+j
         SCnQ==
X-Forwarded-Encrypted: i=1; AJvYcCUvEOeXmjZN11iCuE6k7ZCPo10FpsXEs0JipmB5N/lasXviiwrQ8q7d/qSKT3+OkOpjuEhQ+oZpxaWHnGAIIqkczUZKnUf35iiPHsSV
X-Gm-Message-State: AOJu0YyUuceqCyJ/F6FjwQ9ZpacWQ8EWtu1bUKBoxCgQQ+VpJb88FCrc
	/bWAUc4UKPBDcfdXiYn8ZjsE2d3fbnca5qgZQ2jE8Op0XBKPdwxDaraZ5h1hP4w=
X-Google-Smtp-Source: AGHT+IFhgXrEp98cIlHmXVzQ/og/JHDf0/4SqTgv+8Wp+IUqVkBwBEmreZ0CaMqoA9nNyRqqjl34Kg==
X-Received: by 2002:a05:600c:1383:b0:428:31c:5a52 with SMTP id 5b1f17b1804b1-42805787ddfmr44873045e9.29.1722007217794;
        Fri, 26 Jul 2024 08:20:17 -0700 (PDT)
Received: from [192.168.1.61] (2a02-842a-d52e-6101-6f8f-5617-c4b6-8627.rev.sfr.net. [2a02:842a:d52e:6101:6f8f:5617:c4b6:8627])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36b367c0338sm5500985f8f.1.2024.07.26.08.20.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 08:20:17 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Fri, 26 Jul 2024 17:20:06 +0200
Subject: [PATCH 1/5] dt-bindings: iio: adc: ad7380: add single-ended
 compatible parts
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240726-ad7380-add-single-ended-chips-v1-1-2d628b60ccd1@baylibre.com>
References: <20240726-ad7380-add-single-ended-chips-v1-0-2d628b60ccd1@baylibre.com>
In-Reply-To: <20240726-ad7380-add-single-ended-chips-v1-0-2d628b60ccd1@baylibre.com>
To: Michael Hennerich <michael.hennerich@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 David Lechner <dlechner@baylibre.com>, Lars-Peter Clausen <lars@metafoo.de>, 
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, 
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 Julien Stephan <jstephan@baylibre.com>
X-Mailer: b4 0.13.0

Adding ad7386/7/8 single-ended compatible parts, and the corresponding
ad7386-4/7-4/8-4 4 channels.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 Documentation/devicetree/bindings/iio/adc/adi,ad7380.yaml | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7380.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7380.yaml
index 899b777017ce..bd19abb867d9 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad7380.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7380.yaml
@@ -15,10 +15,17 @@ description: |
   * https://www.analog.com/en/products/ad7381.html
   * https://www.analog.com/en/products/ad7383.html
   * https://www.analog.com/en/products/ad7384.html
+  * https://www.analog.com/en/products/ad7386.html
+  * https://www.analog.com/en/products/ad7387.html
+  * https://www.analog.com/en/products/ad7388.html
   * https://www.analog.com/en/products/ad7380-4.html
   * https://www.analog.com/en/products/ad7381-4.html
   * https://www.analog.com/en/products/ad7383-4.html
   * https://www.analog.com/en/products/ad7384-4.html
+  * https://www.analog.com/en/products/ad7386-4.html
+  * https://www.analog.com/en/products/ad7387-4.html
+  * https://www.analog.com/en/products/ad7388-4.html
+
 
 $ref: /schemas/spi/spi-peripheral-props.yaml#
 
@@ -29,10 +36,16 @@ properties:
       - adi,ad7381
       - adi,ad7383
       - adi,ad7384
+      - adi,ad7386
+      - adi,ad7387
+      - adi,ad7388
       - adi,ad7380-4
       - adi,ad7381-4
       - adi,ad7383-4
       - adi,ad7384-4
+      - adi,ad7386-4
+      - adi,ad7387-4
+      - adi,ad7388-4
 
   reg:
     maxItems: 1

-- 
2.45.1


