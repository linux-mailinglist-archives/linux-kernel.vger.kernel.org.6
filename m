Return-Path: <linux-kernel+bounces-374035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BA369A60EC
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 12:01:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB55C28458A
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 10:01:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71D651E4924;
	Mon, 21 Oct 2024 10:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="uG4HMIYH"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F22BC1E0DD4
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 10:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729504818; cv=none; b=ERynRc8JeQVGz/RQf/70ti/OuyjkdofMM/unRCqbKxSXijwyiq4o9334Rt7dYU7C7NI3s9EvKgLz7v/65yYjwbrsjSGSKiFPVpRB6u08CLeOC+wXLdE9scMhgFKRVwZSN4lU4otvBa86lGkGSpyM6eE33pumNsE4lmQSFgsGo3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729504818; c=relaxed/simple;
	bh=lSphsV781DEEO5eZXZe+5WCVeSRk48zEv06wI90qIyM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jO8exUsxgFS9Z1TE+TvM8LXSdakTDAMX5ZYK4PMeov7OCMvPddZD1Xjnk8VY7mcEWnc8U68M5sTXjJTfiCulAJeJcdZsRQy+goR6jiEivle3BLe34OzQQnSgwmrUgRX4u5zzRJbMPXLow3iJ/0NYYWeQOnrzwK8htqiVHzRQnCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=uG4HMIYH; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4315abed18aso39105605e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 03:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1729504813; x=1730109613; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fKrQZwpLn/eCRDsZpuyk3NH+ActJifA9aPIUH7Z4gH0=;
        b=uG4HMIYHnTaU2/0N85QSfn20l2Kbb8LfTtb+VONpXzJR5YIZwjD/AbNEKhloEtZGui
         gBYhAhVtXqw2dqxs/P5ll9lMGi2DtRgQGG6oZsmvENBHMbef3PWeuM8QyYJ6eUfGAf50
         E+TvQDHFz3I1IFKloHPTc1CyGIx4QbrWXB7eo44NTuCTi6YU7c2luYRF05FcmVpdvvQf
         6BydyInKuX9/1bLNjcjCfW/YJ3t1pJZ/0R8n30ddbQ5KPbNR0l8VjCRALKdY556TajSE
         Fcplm9HSL+dggg+IueBHuFG0UaWf5S+9POMB7XyaJxLKmer1fzGBlxRNJUcayLYZg7b9
         qB6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729504813; x=1730109613;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fKrQZwpLn/eCRDsZpuyk3NH+ActJifA9aPIUH7Z4gH0=;
        b=E/uTisrGG8Px4k0J0sNWLg32O9xKpHvvpnGWFpPlGDYaTiq8rneKOKk0klHopI/fhI
         RdWDjfk4BW2Q7nS6SnYKCUfPQoh1tl/hK+/EicG6g1/xFyeH8OZ6G7iEawCk6dSEDg/7
         patpXMOdHI0AYWObsMg8fVONhWIAQcgx72D8CwIDUio6kN2ty2k8H/UQLaiUrp97XGUm
         gb07nN5W9bYCyM6j7KCXQeSxupjZsiByZpIVIQwKyQyqHtxWVPVXr/S69GHt48tWrp5b
         NiHy3Sf8cCGqvqDCKuHxcoqCpVdmaYo/zi3n9EiQCYgg6h1ryWqSFETPUUJoxbZ8wvv1
         BgTw==
X-Forwarded-Encrypted: i=1; AJvYcCWoiruSqMABlrwciDlgE09efDvc3MOoe9cVvnx9E/9zdvIm4TIxFa1WAffpTRJG2kKO08n8Cca6AL6Qfkg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYEErpVuLEP8sTIsAt+Ap2sd4+0nsOfrH2aZ9/bXsWDjRsbOXf
	I6QW0+mgptDPSRohnE+9epKwwtKhBUpU+UqIn42ww59c+ZEAiz973z870KVO7N0=
X-Google-Smtp-Source: AGHT+IH1e5STM6w/t/+OThujXJlwLR1a0UQlVFBhiPO3a/AoXIdCcxa112WnOGMIDZef+UCO5tSY2g==
X-Received: by 2002:a05:600c:1c0d:b0:42f:7ed4:4c25 with SMTP id 5b1f17b1804b1-4316164d809mr90175855e9.14.1729504813198;
        Mon, 21 Oct 2024 03:00:13 -0700 (PDT)
Received: from [192.168.1.64] (2a02-842a-d52e-6101-6fd0-06c4-5d68-f0a5.rev.sfr.net. [2a02:842a:d52e:6101:6fd0:6c4:5d68:f0a5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4316f58bbaasm52375995e9.23.2024.10.21.03.00.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 03:00:12 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Mon, 21 Oct 2024 12:00:09 +0200
Subject: [PATCH v2 1/5] dt-bindings: iio: adc: ad7380: fix ad7380-4
 reference supply
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241021-ad7380-fix-supplies-v2-1-2ca551b3352a@baylibre.com>
References: <20241021-ad7380-fix-supplies-v2-0-2ca551b3352a@baylibre.com>
In-Reply-To: <20241021-ad7380-fix-supplies-v2-0-2ca551b3352a@baylibre.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 David Lechner <dlechner@baylibre.com>, Jonathan Cameron <jic23@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Conor Dooley <conor.dooley@microchip.com>, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-doc@vger.kernel.org, 
 Julien Stephan <jstephan@baylibre.com>
X-Mailer: b4 0.14.2

ad7380-4 is the only device from ad738x family that doesn't have an
internal reference. Moreover its external reference is called REFIN in
the datasheet while all other use REFIO as an optional external
reference. If refio-supply is omitted the internal reference is
used.

Fix the binding by adding refin-supply and makes it required for
ad7380-4 only.

Fixes: 1a291cc8ee17 ("dt-bindings: iio: adc: ad7380: add support for ad738x-4 4 channels variants")
Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 .../devicetree/bindings/iio/adc/adi,ad7380.yaml     | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7380.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7380.yaml
index bd19abb867d98d46bdd1c9e0c197e10f06979204..0065d650882489e21b952bb9fb25f1e3a070ee68 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad7380.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7380.yaml
@@ -67,6 +67,10 @@ properties:
       A 2.5V to 3.3V supply for the external reference voltage. When omitted,
       the internal 2.5V reference is used.
 
+  refin-supply:
+    description:
+      A 2.5V to 3.3V supply for external reference voltage, for ad7380-4 only.
+
   aina-supply:
     description:
       The common mode voltage supply for the AINA- pin on pseudo-differential
@@ -135,6 +139,23 @@ allOf:
         ainc-supply: false
         aind-supply: false
 
+  # ad7380-4 uses refin-supply as external reference.
+  # All other chips from ad738x family use refio as optional external reference.
+  # When refio-supply is omitted, internal reference is used.
+  - if:
+      properties:
+        compatible:
+          enum:
+            - adi,ad7380-4
+    then:
+      properties:
+        refio-supply: false
+      required:
+        - refin-supply
+    else:
+      properties:
+        refin-supply: false
+
 examples:
   - |
     #include <dt-bindings/interrupt-controller/irq.h>

-- 
2.47.0


