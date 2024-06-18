Return-Path: <linux-kernel+bounces-219574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF73E90D4E2
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 16:27:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 151781C234E0
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 14:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F1281AC22C;
	Tue, 18 Jun 2024 14:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="xj0YLYiX"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0F6816EB58
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 14:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718719361; cv=none; b=LeB0wPZsxi/Ib6dc0Gbm3Z14/T2nzW04GiQU54RJSEc9hYaQD170YFaatjUBl4FY1VgHrTKzfMtPoBkGLsAB5iGSo0mvcEudjeNE0HJKUSRBgefE2EwbMozGb0YbDalrAA4v5JPKJG5gjN/3RYQiisnLq9JNyZIM6egwrUcmn+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718719361; c=relaxed/simple;
	bh=Dg4uCUMceVWgsRkJ2KhN7U4MEvxhzasTmCDw03bT0EE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Jcog20GkG1OAEylHxqPL91u19umGwsWjtsXsUg6n4OpOWv9HJ2+omOX1XBZhWYZaXL7WKTodVs0JXlBEX4PURyXMKA045KHz6qXbzDbeDMHsNs+GzzkxVtntD6CZ7aya/B20P9I8vh/56uwV5jo8INyq/nlFAPyXYSUz+CXs/ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=xj0YLYiX; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-424746705bbso1707435e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 07:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1718719357; x=1719324157; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UGD/hgLLXAT/g5axsjVVgJLnf9y+tbpA9Y5GEUxIfgU=;
        b=xj0YLYiXLHxV4U/303CDwBc/IzVZDtF2GumC9oprxLUqcu/hVOAorem9Hs1ImxPZfJ
         QE4RRw6mB/4gUMIq/aWrd5e+bGDDwk8yTTNNkVt2n8pAkcnYSqRYqFFEdKEnq1m5Twqz
         T4D5hOUK4POcbZq/dweQ2yf6pW721TP/d4vgTXuDM6vI3Y3O4pCShNfm6KD0Oxdw9Wr+
         XjeWHehc6i6wBDfn6ZvvIR47kMJJIES4Ju2CbWH3rIH24CRR7ZEN9olmhah16kNb95vR
         1hbuwGLBiXCXdiKEgJ3e40Kjs2QCRum12IVwJQlLX0CZk607QdErt90OKegHkkuEMdhL
         NK6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718719357; x=1719324157;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UGD/hgLLXAT/g5axsjVVgJLnf9y+tbpA9Y5GEUxIfgU=;
        b=tppk8wzCginexotC/Tihw7q09iaMX/zC25TFhDBUlnx3vwQjIVKwy1f7Xk+xIy9tbQ
         Hj5XCZ2xDp1jgBHMObiKGqYyFweUcKZU+I6tqiMBkFXEg5a2WnWbwFgwtXaZHsWEB5+U
         WgPJDtWeVSBH92foPbULKnYiZty7WY+rsye10R98pnSkbAZwVTmwW1Jl5fzMF5M5KmOc
         LAKnRuGRQ2WwK357IoJHiOPjPoT5qjolSnVRWI8llZQPmELKjKoPde4gcZhAqH5Lgmvj
         zrR5r6+TTizCiszKQ5TM+bOXnJKDIbJF2XLGpBG2THigf6b+SjrZNUFC5+E8cJmlcqLk
         HFxw==
X-Forwarded-Encrypted: i=1; AJvYcCXknPCVThTqLGkGBTw00RW10EnwAHBKfqWHfuvvT7Hnvd2CSRRzvBYnYrrQWhxIs5GkP3d/mExt6VDJFgnCM7oVvHOzAp/jsxU5Pv0G
X-Gm-Message-State: AOJu0Yz9fKYvKkIOYf2yvFi3nNwdhjPfzkXWDvGk6XX7HFgJk5ReG9vG
	qx/NXxji10LHuNBlK0aoHFerQUjOrtCtJ2JNeELHwwExJYxSB9pVSQ1P9biJCfI=
X-Google-Smtp-Source: AGHT+IHFuggadGWzuwPQ5BQ96caDqox/xXR0j4uFJ20Kej5bsP8G8KLJpvUeKbdPACifYPBZrEKCOg==
X-Received: by 2002:a05:6000:1e90:b0:35f:1c3c:56b8 with SMTP id ffacd0b85a97d-3607a76242emr8887364f8f.36.1718719357245;
        Tue, 18 Jun 2024 07:02:37 -0700 (PDT)
Received: from [127.0.1.1] (frhb82016ds.ikexpress.com. [185.246.87.17])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-360750f22absm14412546f8f.79.2024.06.18.07.02.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 07:02:36 -0700 (PDT)
From: Guillaume Stols <gstols@baylibre.com>
Date: Tue, 18 Jun 2024 14:02:37 +0000
Subject: [PATCH 5/9] dt-bindings: iio: adc: adi,ad7606: add conditions
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240618-cleanup-ad7606-v1-5-f1854d5c779d@baylibre.com>
References: <20240618-cleanup-ad7606-v1-0-f1854d5c779d@baylibre.com>
In-Reply-To: <20240618-cleanup-ad7606-v1-0-f1854d5c779d@baylibre.com>
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

Since the driver supports several parts that present differences in
their layout and behaviour, it is necessary to describe the differences
from one chip to another.

Signed-off-by: Guillaume Stols <gstols@baylibre.com>
---
 .../devicetree/bindings/iio/adc/adi,ad7606.yaml    | 50 +++++++++++++++++++++-
 1 file changed, 48 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml
index e480c9a7c7ca..65d6ca5843d7 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml
@@ -55,7 +55,8 @@ properties:
       Must be the device tree identifier of the CONVST pin(s). This logic input
       is used to initiate conversions on the analog input channels. As the line
       is active high, it should be marked GPIO_ACTIVE_HIGH.
-    maxItems: 1
+    minItems: 1
+    maxItems: 2
 
   reset-gpios:
     description:
@@ -91,7 +92,8 @@ properties:
       GPIO_ACTIVE_HIGH. On the AD7616, there are 2 pins, and if the 2 pins are
       tied to a logic high, software mode is enabled, otherwise one of the 3
       possible range values is selected.
-    maxItems: 1
+    minItems: 1
+    maxItems: 2
 
   adi,oversampling-ratio-gpios:
     description:
@@ -123,6 +125,50 @@ required:
 allOf:
   - $ref: /schemas/spi/spi-peripheral-props.yaml#
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: adi,ad7616
+    then:
+      properties:
+        adi,first-data-gpios: false
+        standby-gpios: false
+        adi,range-gpios:
+          maxItems: 2
+    else:
+      properties:
+        adi,range-gpios:
+          maxItems: 1
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - adi,ad7605-4
+              - adi,ad7616
+    then:
+      properties:
+        adi,oversampling-ratio-gpios: false
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - adi,ad7605-4
+              - adi,ad7606-4
+              - adi,ad7606-6
+              - adi,ad7606-8
+    then:
+      properties:
+        adi,sw-mode: false
+    else:
+      properties:
+        adi,conversion-start-gpios:
+          maxItems: 1
+
 unevaluatedProperties: false
 
 examples:

-- 
2.34.1


