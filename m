Return-Path: <linux-kernel+bounces-234059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DCFD91C199
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 16:50:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E628F286C6C
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 14:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27DB41C9ECC;
	Fri, 28 Jun 2024 14:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="QqHyZxc8"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4B5B1C2306
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 14:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719586125; cv=none; b=DfgfH4as0Nc/lmVEulS8tYVuq9vwtRTUnkUptqEMMIkSTpSYVCgufkfOnGkQ9jkrqTaVxCS4NewqUsyxFkco87ZymvLeaCYQhJ8tXrAVWQh+V/L4zcE0Sk3bktSPuzPWy9ZC5TOe1/epSQvRy8LK9xfxWBzuy04grJEdfnZPVbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719586125; c=relaxed/simple;
	bh=Me4ZAZeXpUEgoNz5XwlIttAMsS1eKUVKhBdpA0oqJm0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OM12D8jcnQn42f89v4KOIpc+scQLyM9wQCb+oj5UqxFKs3OnN2b/u1B6xU00NAip2tuZ3C5IbvPOMqN/RPWC6BaCQIFuKP2R80ZwJoQDNAhtD9/EBknwYi0ORR8WwSTJL1LVXaY0S24WDh1ihqgcrnTKesQruDoziMIwvNx4kzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=QqHyZxc8; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-52e743307a2so891613e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 07:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1719586121; x=1720190921; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bXjkAZmosXV+EptKqWsfwFwF90aKrgxPO7Zqi4uv4Ng=;
        b=QqHyZxc8wpMmzLDhsjgX+4llEEm2rKzls2vcfl9Xlv6DxVA5XZqXB3s4PVUTYLbfGL
         xPWz5NYwEFSgijSnJBnEDEIwRsOfc79621g8T+034Y7pZskERdqxKuJknIuBrnFfzZR4
         qpxxTmIevj8CJW348DgwUD2POJ8Se46WgOmyD8R+km3+faxmM8dm2uaSSTEMlxAV3K41
         NyOzHKj0+Iy43yEO1BVcv9mV8t7mBCK9ar3QIqxpEwEALPgOUfla/XS9PTFc0Q55JsDS
         FtLVg/aKlNVK1c+1mMI/ASJLLRwUSXzFsgBBv/hfjNF1AAO2FwE4KzBNA5q8Mg5FzbUz
         msqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719586121; x=1720190921;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bXjkAZmosXV+EptKqWsfwFwF90aKrgxPO7Zqi4uv4Ng=;
        b=GbHF1yP/XUF4Pnt7cf1284RYNP06kVC++ejm7M+8xyb7XEwWLtRrXZfXTdZXztN4qb
         JbSzVR/tmeN1QuwqcH0o5HjUj4Ql6yuo1ruBq/Pe0dlDk7rNE0hVwLFV58QO71m4KCwg
         2DcHhC891/BNWUQ+CjcXga7RxP0tne9qBJfmCS6CEng5oHsvzO517ZwtltH2qUoJ0XQQ
         m3GaWMCAW8Dvj8bMnjZ/7o7mFtKOp/7fbWz6QyOAwqw/MHnE969uqYaCUsqG4JXISxDe
         rlyDOrTcpEO4n8JvK9g+9R2EGQX/Wy0ANM3ikgtfu3Nl80ShglNZ/KrDzl1XOKDRFG/p
         o4fQ==
X-Forwarded-Encrypted: i=1; AJvYcCWDeEMbmG0A7lA1/ymgSQ/PA5lkuiH/90P788oFbGTVQORd7henlGsKKhwoky2tF0CIOfsBn+6c9lmiXZsZUTlr/zp1n1V9HnuRlzTN
X-Gm-Message-State: AOJu0YxGUwNqucPx0bb58lH1eRsRp2hBs3fmHaDHspnnUXDQwlvqI5y3
	02gvZfLInvmcHhzjbUJULUHxeZKIAL9RAj2K2gizvDgi4Rt/WWxSDZt16/zDzR4=
X-Google-Smtp-Source: AGHT+IErmCGJZr2n4zpPLQZf3axGy/KUUX5Ydi0z351aU/tY57diUN1hIBUy4+GUORXAl8m4HkV7Ow==
X-Received: by 2002:a19:5f56:0:b0:52c:dd2f:2f2b with SMTP id 2adb3069b0e04-52ce1862743mr12666981e87.66.1719586120617;
        Fri, 28 Jun 2024 07:48:40 -0700 (PDT)
Received: from [127.0.1.1] (frhb82016ds.ikexpress.com. [185.246.87.17])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4256af55c0asm37972575e9.15.2024.06.28.07.48.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 07:48:40 -0700 (PDT)
From: Guillaume Stols <gstols@baylibre.com>
Date: Fri, 28 Jun 2024 14:48:23 +0000
Subject: [PATCH v2 05/10] dt-bindings: iio: adc: adi,ad7606: add supply
 properties
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240628-cleanup-ad7606-v2-5-96e02f90256d@baylibre.com>
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

Add voltage supplies

Signed-off-by: Guillaume Stols <gstols@baylibre.com>
---
 Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml
index 509970922cda..a1c38a5812f7 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml
@@ -35,6 +35,15 @@ properties:
 
   avcc-supply: true
 
+  vdrive-supply:
+    description:
+      Determines the voltage level at which the interface logic pins will
+      operate.
+
+  refin-supply:
+    description:
+      The voltage supply for optional external reference voltage.
+
   interrupts:
     description:
       The BUSY pin falling edge indicates that the conversion is over, and thus
@@ -106,9 +115,11 @@ required:
   - reg
   - spi-cpha
   - avcc-supply
+  - vdrive-supply
   - interrupts
   - adi,conversion-start-gpios
 
+
 allOf:
   - $ref: /schemas/spi/spi-peripheral-props.yaml#
 
@@ -130,6 +141,7 @@ examples:
             spi-cpha;
 
             avcc-supply = <&adc_vref>;
+            vdrive-supply = <&vdd_supply>;
 
             interrupts = <25 IRQ_TYPE_EDGE_FALLING>;
             interrupt-parent = <&gpio>;

-- 
2.34.1


