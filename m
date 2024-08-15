Return-Path: <linux-kernel+bounces-287899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40AF6952DEF
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 14:12:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B18801F248C5
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 12:12:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0E9017C983;
	Thu, 15 Aug 2024 12:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="2rJq4wM5"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC5BC178CCF
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 12:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723723929; cv=none; b=BSZjSnjK5OBU2I+N1sti8VnL+I7Os/zHF8fpGgQ+DyV3ttCvf1CTM1VxS7fMwZaX4RtmdBpVQoQCdVCj8naj87moyaUKsrbKEogfCQB+cxJDcz+kve2cuziLg5muo9RPFiq+dAETyv3BDOeqk+Q+e+BdPbBF3k6lYm23Urk5+00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723723929; c=relaxed/simple;
	bh=cwZh/t6PTsAHn+9WQxZBnLBvMyUdjRRDOwKT+TpDcdY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VBYV4YjOYajXOa1z91kASOuep4wZjZt1Cwy0oJaOGaguoIghHdx8Cs5qXwTOdOz5VExQYQo2uOKYiNZwuXcgMesfptzoQEhiCt+37XhbdrKQ4dpuceGAV9Q1/o+QaivmxeDRkDgwFCjwpoueH6L6QtWcfq3Zh4EKqQiH+tVbIeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=2rJq4wM5; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3683329f787so468426f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 05:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1723723925; x=1724328725; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KmzCGQhj8OJq5H6Rk1aaVdY9d2NxnBFrZh6OEVj8AIA=;
        b=2rJq4wM5sM5B8z5GCUyW0ho3HWC+XbhkZZ4DtvA3++cKCcpzz1Y3LMMgUarP2o5IrB
         uDeX/WTJNMPW9wLA7qL7VG0pEtu7mCvGtdqW7w99xu3wk1ngU+Cyem5wge7KEvreaEE7
         6N8knl+x5Lfx0r1sXJNovK3n1d7iKk6UuoiNOaRBh5kkzR5goBxUn00Q0J62ElnEcczw
         cnR7K11cl+sHSrCwT1pXav2XUpgk2LN17UXk7oKeJYSoKlAeq9sgbtqyFLcFJ6tjBrgp
         NheaRB3S2jxEvZoom+roNn5Dh2orVeynAw4xxX5JI+7jBra197LbaODieeg507VRYGnz
         lAtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723723925; x=1724328725;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KmzCGQhj8OJq5H6Rk1aaVdY9d2NxnBFrZh6OEVj8AIA=;
        b=o5wIJJVsHZ61u+InGfs/p59RDC3sesgW5ACTAOcGxD5OlJWwO8+6h5Nl1ZgtefrbWL
         asF7jsBfujlkEPT0TERdMXiDmSFLLM+DaV4aIMbQIGJE3Kx49tAx75FrFhZeM1UzilGv
         yxOlF+/wpIrv2wXO8fEMyEam22oxzZLVslr7G0rueStcIjIjdFj1Mutrj2tn6FU+D+WH
         RkrVXDy8Grgh0S6APU2H+Kp0WuQN/Xt7zZTsvA8ylHoP0su3Sa/Qgys+kjBbHNShc3cP
         I7HSlDN5FhjUYNNDcKHx+Xo6rA8YpjRLLLlK8CXzCBYUrV1tNXKotP/elmcUhYuBMMZo
         XS0w==
X-Forwarded-Encrypted: i=1; AJvYcCWqthnrm/OKv/5yf4BS/bWdMMqHPRzVT0I6l9NKEPDFh4GJ4DxCLaHr1+DXKnpN1zqIJvkmiGzBsW+zGZRJYqDkFs2jyRCwP2JB6m0y
X-Gm-Message-State: AOJu0Yw5vKvJGFvqrf3tQL/K2YktKptgxtBqeaOIJZxpAVwjMO1VJTRe
	2bU66Yd3Mbcs3vrQoBC/qITV6yUBGfwIu56rScAmk1GBvf3eu1nnVrIS0brEBDVzrhZhnaC+AO4
	V
X-Google-Smtp-Source: AGHT+IEbGIOFR16Gu1KgKoWgRq+sOlXFPXD2d0oLOy3ZdnJRcNKoYTkm5RRFB1N8wm740uDm1DeA3A==
X-Received: by 2002:a05:6000:10f:b0:368:d0d:a5d6 with SMTP id ffacd0b85a97d-371777e47edmr3608074f8f.50.1723723924673;
        Thu, 15 Aug 2024 05:12:04 -0700 (PDT)
Received: from [127.0.1.1] (frhb82016ds.ikexpress.com. [185.246.87.17])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37189897926sm1365082f8f.87.2024.08.15.05.12.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 05:12:04 -0700 (PDT)
From: Guillaume Stols <gstols@baylibre.com>
Date: Thu, 15 Aug 2024 12:11:55 +0000
Subject: [PATCH 1/8] dt-bindings: iio: adc: ad7606: Make corrections on spi
 conditions
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240815-ad7606_add_iio_backend_support-v1-1-cea3e11b1aa4@baylibre.com>
References: <20240815-ad7606_add_iio_backend_support-v1-0-cea3e11b1aa4@baylibre.com>
In-Reply-To: <20240815-ad7606_add_iio_backend_support-v1-0-cea3e11b1aa4@baylibre.com>
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Michael Hennerich <michael.hennerich@analog.com>, 
 linux-fbdev@vger.kernel.org, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-doc@vger.kernel.org, 
 Guillaume Stols <gstols@baylibre.com>, 
 20240705211452.1157967-2-u.kleine-koenig@baylibre.com, 
 20240712171821.1470833-2-u.kleine-koenig@baylibre.com, 
 cover.1721040875.git.u.kleine-koenig@baylibre.com, aardelean@baylibre.com
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1723723923; l=1468;
 i=gstols@baylibre.com; s=20240417; h=from:subject:message-id;
 bh=cwZh/t6PTsAHn+9WQxZBnLBvMyUdjRRDOwKT+TpDcdY=;
 b=yeCoKWpDjHevYEwDjsK5Y8EdnkRjt/hXioQekXkONYv+DWh369A26wYcTT/cqxJ6KW3yqxkhx
 mnpuXzTpNJ4CWLNMlSg8mhrnwJpOGn1sr0vHvJbQj85Pyqe/Hu/EFEo
X-Developer-Key: i=gstols@baylibre.com; a=ed25519;
 pk=XvMm5WHuV67sGYOJZqIYzXndbaJOlNd8Q6li6vnb4Cs=

The SPI conditions are not always required, because there is also a
parallel interface. The way used to detect that the SPI interface is
used is to check if the reg value is between 0 and 256.
There is also a correction on the spi-cpha that is not required when SPI
interface is selected, while spi-cpol is.

Signed-off-by: Guillaume Stols <gstols@baylibre.com>
---
 .../devicetree/bindings/iio/adc/adi,ad7606.yaml         | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml
index 69408cae3db9..c0008d36320f 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml
@@ -117,15 +117,26 @@ properties:
 required:
   - compatible
   - reg
-  - spi-cpha
   - avcc-supply
   - vdrive-supply
   - interrupts
   - adi,conversion-start-gpios
 
-allOf:
-  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+# This checks if reg is a chipselect so the device is on an SPI
+# bus, the if-clause will fail if reg is a tuple such as for a
+# platform device.
+if:
+  properties:
+    reg:
+      minimum: 0
+      maximum: 256
+then:
+  allOf:
+    - $ref: /schemas/spi/spi-peripheral-props.yaml#
+    - required:
+        - spi-cpol
 
+allOf:
   - if:
       properties:
         compatible:

-- 
2.34.1


