Return-Path: <linux-kernel+bounces-442084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E282B9ED7D8
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 21:58:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91C4A167C43
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 20:58:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B502023A1A3;
	Wed, 11 Dec 2024 20:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="qo9T7lAb"
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1074023A199
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 20:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733950529; cv=none; b=dtkpNZDAOpyNg0Q8G6uCA4IuGj9qs+ZwcYnrCCiXNH+/V85WqntLyda428rC0Mx6bOSLp1nVsTzNJTuOj8N69QGCjikxdKt/S62stnNxtKs9jM7BbBvmgzNmQplJD8A6gE7gNk5EZHFBr1qRHiK+dcsBvZvPvmg2p6g3+EmuFZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733950529; c=relaxed/simple;
	bh=CqimUPw8uuk68aDc8uu2IsObRv6iG6n7TTJVVOiBWN0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SfpmQiIVONBq1QpjheQ6YinUBZTmWoGdAJYT6sU7xvXXpHANbN1JhN9Ae7GA+p5OSx4HonkbE0eMePQY4thqgPyBLF6jq4iTcQBk/GWnnYGhY9DvJ5ZxCOeADQuPIy17i9DtAUnmDV8g2j6r3O8EBYcYaJR2SDPxXD/BpqFP4xE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=qo9T7lAb; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3eb40876bbfso1110618b6e.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 12:55:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1733950526; x=1734555326; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F+0eqdGrTj7PVGAdUgO4EyyvRg3ifAOTsfeDd6RHAXU=;
        b=qo9T7lAbw6AgDAbRz4c82O1kZt4TUhA062+NejzpEZ/rNEArkpFHH2g70H/nhLzZ+u
         aseJkAwKJv4Ypmdl6Fi10xV3VZNeITiidDKZW8DwzkFFytq9P1c6aqhwUZR4uvrNGhKq
         Tf9k/txwgNYZvTf5QwKNbUyiTF3ueoEJTFvIzcZXdvTgQHQKMAI2Mu0Ezo40kCXg1tK4
         QuE74EDH3molCjTq1hIgtZZdO+1Ai3co1VGPCwbZXWu59TZ/9/+oMbtD/WZ681uCRMd4
         Vh2/a9Dt7gXPiQLnXTR6v0i6I0z2qQPYV8jia61C74wWJFRctwlGvoRYtemoJxlav+3O
         p9MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733950526; x=1734555326;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F+0eqdGrTj7PVGAdUgO4EyyvRg3ifAOTsfeDd6RHAXU=;
        b=bPakdvMxvgXpqMyRAXyCeUAXxUU0Y/bpp+5twMCnZFUhlrsDHnMycn6mJTTMOVgAnT
         EBW+vQJJavNxC/nUY5t4jgW1yc5lDVmXoxwuyijR1XquvxhtdwbKh8ae/MLpQG0bCEnX
         knS+ttwHUR4trBYzzw2YSvRG6qRi54uuAGMtM0m6beHzU2u/J9FRGuIbcO2f0BSTXbYl
         eCfRvRy3id8JIx7iJlY375wVIl5sHjfAYPRLAF1lGLasZNHd1WyISo3aGL6gyRek12Kn
         cxWvNsmN9IeDbje6EuYmj7TlS7XcVbN9JEC6Hb6YacGwDzM9/b0JoqMuqI2eRaD/eUbm
         4EXw==
X-Forwarded-Encrypted: i=1; AJvYcCVPfrzBac29jZp4XVL2M/zspTUvYtf7GXZCLe/wZdD/eWXyW/sCwBmdyLBN9XuO3bORxyKmJh9k5q98MF4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw44Jjk+ce22BRyezgWMUjaPcAUrRpBd5dRvOA60IOt6Q0DiR3L
	OJFL72OQqa9A+ThrmGojuBsgC1XNXPGhIIGBk9HCJ24hxYMdvJehwa6wDblCr+M=
X-Gm-Gg: ASbGncsFUfDv7nm9yr7hOxLn41E9qAdpNOwRUaAmVVpRw2ZdiP0jzC+JoZ+Yt50GAhD
	GI2drvRiR66i2PJQ4rObNKzvjCqxng4sREuhNhWVwlth9YnBWBmpfgBFVJ5s83NoeITK8r0DtZ1
	KH2Tze653VHiK3sRcz60kEtYUW+v0gvYKydL1OCFeLT75KQZ4kbhgKUsLqd9e5kQFYE5jc+OSiX
	RWkd4KnGiLRZ6kYK4SUlJ2xfFK/VSl63c3AeoaTtjGHp6ADdhu6d4cnWWZbui+MUIFB8XlPz61g
	MMcxWQWrNg==
X-Google-Smtp-Source: AGHT+IHsptMs0bdpB7TMIMS2sikrd60fAQmzA2ksoYkV+2JBISwTwL8cHuShB0rt9AANJARUZXD9AA==
X-Received: by 2002:a05:6808:398b:b0:3ea:5ef1:c95 with SMTP id 5614622812f47-3eb85c47143mr2389366b6e.25.1733950526016;
        Wed, 11 Dec 2024 12:55:26 -0800 (PST)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-71def651fb2sm1888288a34.27.2024.12.11.12.55.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 12:55:24 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 11 Dec 2024 14:54:52 -0600
Subject: [PATCH v6 15/17] doc: iio: ad4695: add SPI offload support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241211-dlech-mainline-spi-engine-offload-2-v6-15-88ee574d5d03@baylibre.com>
References: <20241211-dlech-mainline-spi-engine-offload-2-v6-0-88ee574d5d03@baylibre.com>
In-Reply-To: <20241211-dlech-mainline-spi-engine-offload-2-v6-0-88ee574d5d03@baylibre.com>
To: Mark Brown <broonie@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Cc: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Lars-Peter Clausen <lars@metafoo.de>, David Jander <david@protonic.nl>, 
 Martin Sperl <kernel@martin.sperl.org>, linux-spi@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-iio@vger.kernel.org, linux-pwm@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2

Document SPI offload support for the ad4695 driver.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---

v6 changes:
* Fixed double "all"
* Don't abbreviate "sampling_frequency" attribute names for clarity.

v5 changes: new patch in v5
---
 Documentation/iio/ad4695.rst | 68 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/Documentation/iio/ad4695.rst b/Documentation/iio/ad4695.rst
index 9ec8bf466c15bf94cbae2ebdb61875f66af1264f..ead0faadff4b5aede2a34bac52e103e375da6f21 100644
--- a/Documentation/iio/ad4695.rst
+++ b/Documentation/iio/ad4695.rst
@@ -47,6 +47,36 @@ In this mode, CNV and CS are tied together and there is a single SDO line.
 To use this mode, in the device tree, omit the ``cnv-gpios`` and
 ``spi-rx-bus-width`` properties.
 
+SPI offload wiring
+^^^^^^^^^^^^^^^^^^
+
+When used with a SPI offload, the supported wiring configuration is:
+
+.. code-block::
+
+    +-------------+         +-------------+
+    |    GP0/BUSY |-------->| TRIGGER     |
+    |          CS |<--------| CS          |
+    |             |         |             |
+    |     ADC     |         |     SPI     |
+    |             |         |             |
+    |         SDI |<--------| SDO         |
+    |         SDO |-------->| SDI         |
+    |        SCLK |<--------| SCLK        |
+    |             |         |             |
+    |             |         +-------------+
+    |         CNV |<-----+--| PWM         |
+    |             |      +--| GPIO        |
+    +-------------+         +-------------+
+
+In this case, both the ``cnv-gpios`` and  ``pwms`` properties are required.
+The ``#trigger-source-cells = <2>`` property is also required to connect back
+to the SPI offload. The SPI offload will have ``trigger-sources`` property
+with cells to indicate the busy signal and which GPx pin is used, e.g
+``<&ad4695 AD4695_TRIGGER_EVENT_BUSY AD4695_TRIGGER_PIN_GP0>``.
+
+.. seealso:: `SPI offload support`_
+
 Channel configuration
 ---------------------
 
@@ -158,6 +188,27 @@ Unimplemented features
 - GPIO support
 - CRC support
 
+SPI offload support
+===================
+
+To be able to achieve the maximum sample rate, the driver can be used with the
+`AXI SPI Engine`_ to provide SPI offload support.
+
+.. _AXI SPI Engine: http://analogdevicesinc.github.io/hdl/projects/ad469x_fmc/index.html
+
+.. seealso:: `SPI offload wiring`_
+
+When SPI offload is being used, some attributes will be different.
+
+* ``trigger`` directory is removed.
+* ``in_voltage0_sampling_frequency`` attributes are added for setting the sample
+  rate.
+* ``in_voltage0_sampling_frequency_available`` attributes are added for querying
+  the max sample rate.
+* ``timestamp`` channel is removed.
+* Buffer data format may be different compared to when offload is not used,
+  e.g. the ``buffer0/in_voltage0_type`` attribute.
+
 Device buffers
 ==============
 
@@ -165,3 +216,20 @@ This driver supports hardware triggered buffers. This uses the "advanced
 sequencer" feature of the chip to trigger a burst of conversions.
 
 Also see :doc:`iio_devbuf` for more general information.
+
+Effective sample rate for buffered reads
+----------------------------------------
+
+When SPI offload is not used, the sample rate is determined by the trigger that
+is manually configured in userspace. All enabled channels will be read in a
+burst when the trigger is received.
+
+When SPI offload is used, the sample rate is configured per channel. All
+channels will have the same rate, so only one ``in_voltageY_sampling_frequency``
+attribute needs to be set. Since this rate determines the delay between each
+individual conversion, the effective sample rate for each sample is actually
+the sum of the periods of each enabled channel in a buffered read. In other
+words, it is the value of the ``in_voltageY_sampling_frequency`` attribute
+divided by the number of enabled channels. So if 4 channels are enabled, with
+the ``in_voltageY_sampling_frequency`` attributes set to 1 MHz, the effective
+sample rate is 250 kHz.

-- 
2.43.0


