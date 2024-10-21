Return-Path: <linux-kernel+bounces-374345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41B0C9A68CA
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 14:41:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBFF71F22BC0
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 12:41:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BA871F6678;
	Mon, 21 Oct 2024 12:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Yxr5h/Ff"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B9D1F1317
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 12:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729514499; cv=none; b=GRDFksXqDo/X09jsu2EgUL6srfWohwRpftZgkSbfoi6fQ64bdYB5Oinmth1IN7oxcjMQ8tMPwGZHo3Y3JJZDFpwf06tbsCAhDIqY8PCpcuQszNC5bMfNE0qBM9Qe4/TbmQ+zXi9KvJQggMJfdj1bzUJJ655aakZ0yRIksxxWXGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729514499; c=relaxed/simple;
	bh=MA2oG/y7V1+Goz7xziXlVN+hyrEb/+ZFaEcTpQoHM1s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KDZZFnlkJRrQqN7fRJHoFaO8znO/ppQeWF3T2LVuGNg28dOxTsDsMQpKPwEJJ1zWsqyVwZJLojTqgNxOEWTE+y25priqeXE+ouByy52XWrQ5mGlR1E0jV5ACyRPOHrZ6eiHTV14Pbt3OqsDrEp1wcnCic89ECeTunFQTE1ms14k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Yxr5h/Ff; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4315eac969aso25550675e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 05:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1729514495; x=1730119295; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y3Jl9+VGm0G8JZ+DzIDolKuvv4I1MhBsGUOVMggicwA=;
        b=Yxr5h/FfwZ6IUm8geIWFhpNPKKC4d/rD6b9jqx6pGrYZECLz5KwP5yiDJUe5VrTVPH
         viSGuwFqQEBYxII+o+8wNeKRCGTC44K5veYDXs2Yjb98U2enlTpRfHKmzGtqAlUKsZ41
         Dl5lkdPrq7kSsdYYRQH600jYFN+xLKnM96UsxMXGtBZSTCiAiWbFOqBwJNtd9t1u1g/x
         kHNUPyGOjqIM7kfNQWUS8+ceyc1vDoWrenLXnLKRzFCqyNT/HE5dOWcUaHUVza0EkYxO
         DDu2L7AT9WdujHXfxytUKQL3jkx2+oQ5rZPcEDXMtrZyw9Df4T8+FKUbQbLkYNHyagC9
         qsvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729514495; x=1730119295;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y3Jl9+VGm0G8JZ+DzIDolKuvv4I1MhBsGUOVMggicwA=;
        b=axrLiF4ScVrR2hiFDgtFUAy7HjL5x5ybCgJ5DVHETCuZ9AyFZyOkXRNLo1ILuYgZUp
         394vtgBhua8QghCDpGssSLzXFrBdNjaqWuSl7othJ+l+Qmh2PHpLJGoFsBlG98dZhyE0
         CfrmSguohjSOzOcJekcIfxOYZzEkE5S1wVl9zvQ2CThWFivESABdGKjM5TJOj9nYTI+X
         NlpfUpYVdjf6oDMnS4ya3h0MvLQaSGrF+lSnkuFS9wI+o2bW+toKXVixviai4M/f99Vf
         dshRfvB1O3qbaS1qaxZ0C27inZLz7+HHx5eiuiVs0rqJIUyNqGfzC3uW41KO9sCg38IB
         /wyw==
X-Forwarded-Encrypted: i=1; AJvYcCXyg2I2VNlWjRQ396hGy6yej84NPf9CzFlDi4KztgwuSVWzwQ2grBcyRrJQg9DNUjP8lLPnaiEjmGYiT9w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGoQ5iSVcg+lU+MXSU0Rx+9aWRGsLKYBM+07ONzOCO6f9EOaIh
	o66D+HrUkSDRiBkPj/tMBOKvbp3qnY8h8++WuwdJA4JHfz8Tw5oL5IVG/dc1rk4=
X-Google-Smtp-Source: AGHT+IHWlkM2lfCYEbSbmqjvJghyTw+fp9hkebV+FYxfQgZd4RTfiOnVfHkx3yQ31eE+adj8hPAFfQ==
X-Received: by 2002:a05:600c:1c95:b0:42c:ae4e:a96c with SMTP id 5b1f17b1804b1-4316168f5dbmr73647185e9.16.1729514494798;
        Mon, 21 Oct 2024 05:41:34 -0700 (PDT)
Received: from [127.0.1.1] (host-82-61-199-210.retail.telecomitalia.it. [82.61.199.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4316f5cc88esm55996075e9.46.2024.10.21.05.41.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 05:41:34 -0700 (PDT)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Date: Mon, 21 Oct 2024 14:40:11 +0200
Subject: [PATCH v7 1/8] dt-bindings: iio: dac: ad3552r: add iio backend
 support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241021-wip-bl-ad3552r-axi-v0-iio-testing-v7-1-969694f53c5d@baylibre.com>
References: <20241021-wip-bl-ad3552r-axi-v0-iio-testing-v7-0-969694f53c5d@baylibre.com>
In-Reply-To: <20241021-wip-bl-ad3552r-axi-v0-iio-testing-v7-0-969694f53c5d@baylibre.com>
To: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Olivier Moysan <olivier.moysan@foss.st.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, dlechner@baylibre.com, 
 Mark Brown <broonie@kernel.org>, 
 Angelo Dureghello <adureghello@baylibre.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.14.1

From: Angelo Dureghello <adureghello@baylibre.com>

There is a version of AXI DAC IP block (for FPGAs) that provides
a physical QSPI bus for AD3552R and similar chips, so supporting
spi-controller functionalities.

For this case, the binding is modified to include some additional
properties.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
---
 Documentation/devicetree/bindings/iio/dac/adi,ad3552r.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad3552r.yaml b/Documentation/devicetree/bindings/iio/dac/adi,ad3552r.yaml
index 41fe00034742..2d2561a52683 100644
--- a/Documentation/devicetree/bindings/iio/dac/adi,ad3552r.yaml
+++ b/Documentation/devicetree/bindings/iio/dac/adi,ad3552r.yaml
@@ -60,6 +60,12 @@ properties:
     $ref: /schemas/types.yaml#/definitions/uint32
     enum: [0, 1, 2, 3]
 
+  io-backends:
+    description: The iio backend reference.
+      Device can be optionally connected to the "axi-ad3552r IP" fpga-based
+      QSPI + DDR (Double Data Rate) controller to reach high speed transfers.
+    maxItems: 1
+
   '#address-cells':
     const: 1
 
@@ -128,6 +134,7 @@ patternProperties:
           - custom-output-range-config
 
 allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
   - if:
       properties:
         compatible:

-- 
2.45.0.rc1


