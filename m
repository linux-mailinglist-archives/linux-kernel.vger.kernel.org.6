Return-Path: <linux-kernel+bounces-246437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C39892C1B0
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 19:06:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B1971C22683
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 17:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A7AE1B6A5A;
	Tue,  9 Jul 2024 16:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20230601.gappssmtp.com header.i=@thegoodpenguin-co-uk.20230601.gappssmtp.com header.b="Pw79TF4h"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D231B5828
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 16:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720542979; cv=none; b=qbsatAYCKQ5zr0YyFFlQrcwcRdulXR2Xs8bEMA+FoRecSMDjfcVrK1X4u16Vwx/9dF3f+yzxMYeqtDf65UTHGMsd/L62YCMeMvfGgt6ZEAFMiLQUXPgRyYkFdW/nZrbioH0TjG9XEMwkFNMSqLZq4N22v7z6f1yBLsSY5/iHfHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720542979; c=relaxed/simple;
	bh=ItL4uvIkdhh1jRGs6ZnpdeR1LEYIkQNtrnHCjT2YARc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BRguPVV3VzFHwGvXPfJifRTPQ1Sx6WpE5rvPyUrRPt7fp4BN29YB9giZwoaJmZ6xnkvnygzImgSAKcyrdJb0ZysXEpWHrxyUSHMbIBWeMLoY+C3Pd9BMpF+pg5jeyr3iwFi19dB+dI7kscRRvDdvvIERaJ9z1+ycqXiqHcUnGAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk; spf=pass smtp.mailfrom=thegoodpenguin.co.uk; dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20230601.gappssmtp.com header.i=@thegoodpenguin-co-uk.20230601.gappssmtp.com header.b=Pw79TF4h; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thegoodpenguin.co.uk
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4266dc7591fso13090555e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2024 09:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thegoodpenguin-co-uk.20230601.gappssmtp.com; s=20230601; t=1720542976; x=1721147776; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8HRtSE7ElocyPb9s2Ec2T4yKtfRZBFcwgkAnhr1p+nA=;
        b=Pw79TF4hiuBbRjazedWcBN2c0MBNWEdk00OPv/3uIRK7upVyzOpuzK9MMDdEdYwqii
         svPyh5PQbjh1q7TuXgZEz0hId0CooKWUBm72urk3RzVAq9SSbB7+WR6j2OOEcxyPpTJh
         +OYOCfa1VLTckskCQO9DRcovItsHou+uKNNAVpA5Ubu/L1PoZCiLxAj81KN8qym/9UmS
         4PT/Z4XyBH5+VfeJmdKjtMB20H3Zicgsh70L9+U/FMdaaGoc7m4S3+eBnWOhGspuMjug
         rrx48YZTig5m6I7P+6Yfz4M5BXBvqMWFN9l09tYQVmNOxmnlY4EMoqpkq+CoUA1kbvXz
         jE4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720542976; x=1721147776;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8HRtSE7ElocyPb9s2Ec2T4yKtfRZBFcwgkAnhr1p+nA=;
        b=PLX+dKJZ6lghKql3PJgAsPPkxK9LWN58TQrRdNZy226f3urQTos5GC53XSuhG+MSN4
         eaGdcoKClix6UZ9yEhYX75AGz6OOhsB4GCUohKMsGGH33BpwmDYx8ItVETiw/1AwDTE5
         fLgDIiisRtRDDIwZ+q2plicXXPMTD814PICzYYTbK5S/BYzmI8+/DPoMivBqp0bJZSLN
         Dvh48S68uxrXJB+lEIZa83UQGmJJBZ1vnzj/NSnWk4pLWEQlwCz5bqvBnsCqPS0BYVyP
         2sI7EU5lAWL1Zx/VcdhXdo0js3RmV3cBI5pQqo3Crbt35wwe3ykBby60W6g8wQKMzKTR
         PgZQ==
X-Forwarded-Encrypted: i=1; AJvYcCV3w3obasblL0H7Or7sDCPz/XAvpHXw3OBqRMSE2ibcwOMNOWC0Aa5xHY0yfpLj2B4/+Yle9DAS6hsfbZc3AP3M2+7FRwXCt5GYB9IN
X-Gm-Message-State: AOJu0YzQu9F3/pFNoPsbzcjNGeaJDfWf/0byeGYlnzAyOylOKY4EwVku
	jjI5X+f8YtSIXAxKX0qU8sgGjgeIUj2GaFoUnbL2TSl21yfSQQzO6vIV+6Gn45E=
X-Google-Smtp-Source: AGHT+IETr8XN0/O9JF5+DBaWnGcvE3gQDl7ItMQh7aMsnMD0Gz/C8H117oTNJUT8VMlxueOXjpYr0Q==
X-Received: by 2002:a05:600c:22d1:b0:426:6388:d59f with SMTP id 5b1f17b1804b1-426705cf367mr21531335e9.1.1720542976245;
        Tue, 09 Jul 2024 09:36:16 -0700 (PDT)
Received: from carbon.local (aztw-29-b2-v4wan-166913-cust1764.vm26.cable.virginm.net. [82.37.38.229])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4266f6f5f25sm48897745e9.26.2024.07.09.09.36.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 09:36:15 -0700 (PDT)
From: Joshua Felmeden <jfelmeden@thegoodpenguin.co.uk>
Date: Tue, 09 Jul 2024 17:36:10 +0100
Subject: [PATCH 1/2] dt-bindings: iio: humidity: add ENS21x sensor family
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240709-ens21x-v1-1-678521433cdd@thegoodpenguin.co.uk>
References: <20240709-ens21x-v1-0-678521433cdd@thegoodpenguin.co.uk>
In-Reply-To: <20240709-ens21x-v1-0-678521433cdd@thegoodpenguin.co.uk>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Joshua Felmeden <jfelmeden@thegoodpenguin.co.uk>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720542974; l=1730;
 i=jfelmeden@thegoodpenguin.co.uk; s=20240709; h=from:subject:message-id;
 bh=ItL4uvIkdhh1jRGs6ZnpdeR1LEYIkQNtrnHCjT2YARc=;
 b=i0Q19sdObnH8XCAyjRpVQ0waAoUyBtTgTe62PP/NLyKcJbrquOwEidb3DyfDTG1PyzM/nLvZQ
 pH7SA4OPUaRAIH5D5FPUvzbJ0EbSYwLDO6PcnMdiDqDKzmEpaOBE68t
X-Developer-Key: i=jfelmeden@thegoodpenguin.co.uk; a=ed25519;
 pk=tePkZ5iJ3ejQ2O3vjhsj7GrLYcyJN1o1sMT3IEXvKo0=

Add device tree documentation for ENS21x family of temperature and
humidity sensors

Signed-off-by: Joshua Felmeden <jfelmeden@thegoodpenguin.co.uk>
---
 .../bindings/iio/humidity/sciosense,ens21x.yaml    | 50 ++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/humidity/sciosense,ens21x.yaml b/Documentation/devicetree/bindings/iio/humidity/sciosense,ens21x.yaml
new file mode 100644
index 000000000000..3140349a58b8
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/humidity/sciosense,ens21x.yaml
@@ -0,0 +1,50 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/humidity/sciosense,ens21x.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ScioSense ENS21x temperature and humidity sensor
+
+maintainers:
+  - Joshua Felmeden <jfelmeden@thegoodpenguin.co.uk>
+
+description: |
+  Temperature and Humidity sensor.
+
+  Datasheet:
+    https://www.sciosense.com/wp-content/uploads/2024/04/ENS21x-Datasheet.pdf
+    https://www.sciosense.com/wp-content/uploads/2023/12/ENS210-Datasheet.pdf
+
+properties:
+  compatible:
+    enum:
+      - sciosense,ens210
+      - sciosense,ens210a
+      - sciosense,ens211
+      - sciosense,ens212
+      - sciosense,ens213a
+      - sciosense,ens215
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    i2c {
+       #address-cells = <1>;
+       #size-cells = <0>;
+
+       temperature-sensor@43 {
+           compatible = "sciosense,ens210";
+           reg = <0x43>;
+       };
+    };
+...
+

-- 
2.39.2


