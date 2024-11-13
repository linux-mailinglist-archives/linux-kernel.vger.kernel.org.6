Return-Path: <linux-kernel+bounces-408038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6029D9C79E0
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 18:23:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5B9DB31774
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 16:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E5502022E4;
	Wed, 13 Nov 2024 16:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="E5GH72FM"
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 306841F80C1
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 16:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731516932; cv=none; b=HPOlS4xJAlUGvkcorPT7B1vgwD2lMdfBnwZQUQ4alY0aheN0VN1TE2vRvWhbEgjPVWy31Yy4E8TXtuag5U54IoO0NPwYWJtOlBz0gHiaAOaLcSNnjdacEpLlRFiWQfFjaHj6ItCscKW6s5FsKqJva3AzBO+dlIUADXbLGbODs0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731516932; c=relaxed/simple;
	bh=tJhHuhEOPc+XxXPxuHFH6d3Rhg17ntIx28rsYimScsg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RuN6BSE73CN2PTRJo8kjerjg6tsJCMZ6l02rChiSOR7nAmXEAMRO8RbkmC++hRmYLJN8EP1aLd92yqcnBC4WxYPuqJ6ZXIjx+Rnrzr7D7QhH8upXbGM6hnJPMMBNZ/3ZgNObTJ4XHvIuplPEgLY3g7TCTyejtybDXxTpgdRhQ2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=E5GH72FM; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3e602994635so4622708b6e.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 08:55:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1731516930; x=1732121730; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AGwF3u8hl2KH+X74wkxGcK2CGFXP/y9NLjPy/zZ23Ks=;
        b=E5GH72FMwSBf79vOmhp5MNcWPDDifDOHlOVkhV1ZOyd+Cg35Bxp99bu9/4+I4QYBPT
         WbQ7wmBVsSGQKOdGcIJf9UhXvrgRj6ujEH5ZZxsRRkpSNxsThkbgAqEn0GYtfHFyiiMy
         Ero9POUp86nDo2XkMfKwzYlx9IlGhALFhZHgX0d3AISauaSMg0jMpXQIqI5htRj3bMtt
         L/wihcMC8tRPIkbkB97CY1CYy8sKhTCBUgqNCl+PhaOkogxAdtw8xC0UeJ+lTHU5KxNj
         aN+n8suf8v8MpcycaoeTUZgsAI2scq7AA7teXl85qa0z9+mIABqelX+h6DRblp/uY6ES
         UP5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731516930; x=1732121730;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AGwF3u8hl2KH+X74wkxGcK2CGFXP/y9NLjPy/zZ23Ks=;
        b=lpTz7V6ThKpVOI1bhPUzOJwAsKgFNmKkgOUhdG7z1xqGbogT9FCtllZIVIukb5NqzD
         kWkz0o0wMks83dJst9Q4aLO28gwrhQGYtfXG9iV8csSPpaOJ0w0PNI61rIv9bxXj9U3I
         wBMnM93eMFPWmro60Or00PrzbPMRBgdhg5tqn4+clz8B+kOFTIbgwYG/HAEEsA24eyPs
         ah+VHE8oLPkF7SPtS4FcP9pt7Hn3G53LQegDYX/UjNr5rMZjuCYLiw3xsYqF2E8NC4Yg
         TlMxm5ixZl9ptjAelOpcfNgjXT9KsGZOtZopiU9n+hBfVyqEjXPr7icgXkQzcJRh31qz
         QTrA==
X-Forwarded-Encrypted: i=1; AJvYcCVEuTWRUq56Y1MVirA9iwQldMqwoqZ5I5njQ4LixuTJw97i9yj3ZLobrP2H6T/jKncf3A3qJysbUjIUTWQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjuqVf8ZXpjuK65VP6J9LwUZqbmEcdhwWxOefXz3KUGAKYmukn
	97xqaVUjEWVIzZbdyVzBRgc6ozxM5083ZqkZ9hQmMtcsck4UDil4ux8srk9u1YA=
X-Google-Smtp-Source: AGHT+IGZTsB2S8+H3+Yo8Y32ji6Fa9pcSs0trVZgwEr27F+OXOgWiSX2di5TeK5mA1VMRkRfPOioLQ==
X-Received: by 2002:a05:6870:9e0c:b0:288:e7f2:e9f9 with SMTP id 586e51a60fabf-295e8d516a4mr3417291fac.11.1731516930191;
        Wed, 13 Nov 2024 08:55:30 -0800 (PST)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-295e8fe5c61sm873432fac.23.2024.11.13.08.55.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 08:55:28 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 13 Nov 2024 10:55:20 -0600
Subject: [PATCH 2/2] dt-bindings: iio: adc: adi,ad4695: change include path
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241113-iio-adc-ad4695-move-dt-bindings-header-v1-2-aba1f0f9b628@baylibre.com>
References: <20241113-iio-adc-ad4695-move-dt-bindings-header-v1-0-aba1f0f9b628@baylibre.com>
In-Reply-To: <20241113-iio-adc-ad4695-move-dt-bindings-header-v1-0-aba1f0f9b628@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Michael Hennerich <michael.hennerich@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Jonathan Corbet <corbet@lwn.net>, linux-iio@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.1

Change the include path for the adi,ad4695.h header since it has been
moved to the include/dt-bindings/iio/adc/ directory.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 Documentation/devicetree/bindings/iio/adc/adi,ad4695.yaml | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad4695.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad4695.yaml
index 310f046e139f..7d2229dee444 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad4695.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad4695.yaml
@@ -134,8 +134,9 @@ patternProperties:
         description:
           Describes the common mode channel for single channels. 0xFF is REFGND
           and OxFE is COM. Macros are available for these values in
-          dt-bindings/iio/adi,ad4695.h. Values 1 to 15 correspond to INx inputs.
-          Only odd numbered INx inputs can be used as common mode channels.
+          dt-bindings/iio/adc/adi,ad4695.h. Values 1 to 15 correspond to INx
+          inputs. Only odd numbered INx inputs can be used as common mode
+          channels.
         enum: [1, 3, 5, 7, 9, 11, 13, 15, 0xFE, 0xFF]
         default: 0xFF
 
@@ -209,7 +210,7 @@ unevaluatedProperties: false
 examples:
   - |
     #include <dt-bindings/gpio/gpio.h>
-    #include <dt-bindings/iio/adi,ad4695.h>
+    #include <dt-bindings/iio/adc/adi,ad4695.h>
 
     spi {
         #address-cells = <1>;

-- 
2.43.0


