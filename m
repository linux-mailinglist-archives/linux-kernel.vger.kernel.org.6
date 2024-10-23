Return-Path: <linux-kernel+bounces-378830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 024339AD5FF
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 23:00:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B472A283ECF
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 21:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B47181E5731;
	Wed, 23 Oct 2024 20:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="nCjgFh8k"
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60CE31FDFA3
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 20:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729717171; cv=none; b=XOs44eJuB8OaYJFH17UNOp8sW/rhJJ5dl71hZCd366eh1j+yxaOnIa6L2V+oDIYubKDlMtUQWfA1X4sHVqNbkodRX2nOj6siLHaV05mn++oJjWDN2qT6XA3DvJ7x018tOQUGnAT5PVXRTT2Y9QirzaVkhrl3+0hzuSkhzI1xPR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729717171; c=relaxed/simple;
	bh=/mOovntT5Qe8sUMdAxO+EkWWA3dOzhaFJ1YaLc6k+Ak=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CkqkieF8xHiC0zL+deXGI/qVsQ1VaBFwZgLJ824KVEPc9b0d5am0JU/ArNB8l510wNU7TXxAx7IQtZkoZAHtoTywBNqI6l8mTrp1ypK7YFwMaAxxX+Y6Aq/SJ5Dzp07EoybVjO0rpw4AvXkgpjgHVHdiShals7zHAZrfz3nAkbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=nCjgFh8k; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-5ebc1af9137so106644eaf.2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 13:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1729717167; x=1730321967; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EyHtfkBXgcKy8Q9+oyQnrUM8I5ww1iitltHtg1jsJVA=;
        b=nCjgFh8kEL6BDxn42ubkAI+3BVP6ITgTB74JlBrDSsvNIrCLRuXiosxTpPKOYxq3vc
         lN21UZ6zLO3SPSpTgLTxYtrwxy1Cpv1Ak1sRCjVWTzFDONwB8AkwFcWhWWF6vK+DJZJs
         YubpURtheHWzm8ah+nekFdi2G3ttHHFYsYjgdeiPSxZ15TeJR8s3fe69bZolj18aRiNY
         /WPpC+hIYy4ZwSb/4FeKf6tZ+zIDRe71/gBcZiqKpBeRXtkz9pBj7gj/pQHQz7qtWtli
         JWQp3hNPYl0ZFboW0bf8WtAtuIohe8kNzqo+91wNv63fyH0CzRt9YueRj+Xirp2oT7pL
         tI4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729717167; x=1730321967;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EyHtfkBXgcKy8Q9+oyQnrUM8I5ww1iitltHtg1jsJVA=;
        b=wxo6yQldliOoJYOMu0CtspvFELdz4JjBfKP5GddWyN4uL9D+/Z3F0ftil92GtZbgsV
         3OL1GUbNpIwjmTyVhWymbypU1Le86pIw6AptkX+aUvJuiiigWla0ran+Sn5cdgznkJiP
         mXbyUE0e2HUwvd4vVBqJ5/9ouo+vqZ6xmbRPUna0TmPHLDJbe6+yt0+KJ803N43IrK24
         y6Bf033mL4uVELQ2j6YbquzlLDQdoqZ8ecL9mQwuN0ErwJ1kka4ieF/q4bQ9JT42Cjqw
         Gniynget90f2UFglc/yNJoB46uy51+F8O01MSZXmzeMZsVHHfHoPqumVRZ75b8UQRWQ4
         uWXg==
X-Forwarded-Encrypted: i=1; AJvYcCXIQNrGSjjL2Va797NBOYBb+Jh8kej1ZV5lcAVvN7TOOSLr40p74/mYMtL7e202WTPS5YClsNUY3Nzab7M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxi6ga2/s/UvDLcAHTzZt52D3PcE7x+PdvrH8KbgnOI3vqUx6im
	CL4alh0pOd+zeh7apX59oDYl/vAHWn3Fv8w8R6jB+UuZ51xdYLpITiB1NOROl2w=
X-Google-Smtp-Source: AGHT+IHv8HCEhfnp0g05EVhJyJSYYG556S9c4IigSs3Y2hbEvK4bBM3BCxpVknjvtRLUcm1QtQH0QA==
X-Received: by 2002:a05:6820:60e:b0:5e7:caf5:ae1f with SMTP id 006d021491bc7-5ebee532b5emr3206665eaf.2.1729717167480;
        Wed, 23 Oct 2024 13:59:27 -0700 (PDT)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5ec02c2c157sm52730eaf.44.2024.10.23.13.59.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 13:59:26 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 23 Oct 2024 15:59:11 -0500
Subject: [PATCH RFC v4 04/15] spi: dt-bindings: add trigger-source.yaml
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241023-dlech-mainline-spi-engine-offload-2-v4-4-f8125b99f5a1@baylibre.com>
References: <20241023-dlech-mainline-spi-engine-offload-2-v4-0-f8125b99f5a1@baylibre.com>
In-Reply-To: <20241023-dlech-mainline-spi-engine-offload-2-v4-0-f8125b99f5a1@baylibre.com>
To: Mark Brown <broonie@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Lars-Peter Clausen <lars@metafoo.de>, David Jander <david@protonic.nl>, 
 Martin Sperl <kernel@martin.sperl.org>, linux-spi@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-iio@vger.kernel.org, linux-pwm@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.1

Add a new binding for SPI offload trigger sources.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---

v4 changes: new patch in v4.

FWIW, this is essentially identical to the leds trigger-source binding.
---
 .../devicetree/bindings/spi/trigger-source.yaml    | 28 ++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/trigger-source.yaml b/Documentation/devicetree/bindings/spi/trigger-source.yaml
new file mode 100644
index 000000000000..d64367726af2
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/trigger-source.yaml
@@ -0,0 +1,28 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/spi/trigger-source.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Trigger source providers for SPI offloads
+
+maintainers:
+  - David Lechner <dlechner@baylibre.com>
+
+description:
+  Each trigger source provider should be represented by a device tree node. It
+  may be e.g. a SPI peripheral chip or a clock source.
+
+properties:
+  '#trigger-source-cells':
+    description:
+      Number of cells in a source trigger. Typically 0 for nodes of simple
+      trigger sources. For nodes with more than one output signal, the first
+      cell be used to specify which output signal to use. If the same signal is
+      available on more than one pin, the second cell can be used to specify
+      which pin to use.
+    enum: [ 0, 1, 2 ]
+
+additionalProperties: true
+
+...

-- 
2.43.0


