Return-Path: <linux-kernel+bounces-514932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A3269A35D97
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 13:24:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B9C93ACCD9
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 12:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB031263F39;
	Fri, 14 Feb 2025 12:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Lf164Ph0"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6542E264A60
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 12:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739535804; cv=none; b=MiWkN/S/pRyzkTkuRye0LF45jP1UfICCwjJtwALY0uG95GuXNewhiKDe5gS6UcNiUBbFFzrI98dkswiqUdj2xGw8CCcffbbBthEVZ0rQg46gnaYC2StEjAiSTGiGm4mKFSiGbSzNcOddoERptOzqJORH4IjVYTyY2M1EvHV8hKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739535804; c=relaxed/simple;
	bh=hLiMZnuu+3C1+GXOKrJYlOPcy9O1KcJ4GWq7/HNkeVo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dveHGxuRnw+wX7wUKpnSGbSyvE6dmeTnA+YV47hjQ6vdsi62KlXDdea8AjTenyaiTc61TPj7lQdBElZPNY3tuBmlDMMM2rNYsakuiTq+SjdIOSZQr1vpnWD88tKOW4gqM4HGp647hhgKZIE80YIkeJ2hvTQnYLiCW/6qEyEG20s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Lf164Ph0; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43948021a45so20819575e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 04:23:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1739535799; x=1740140599; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8wsvYUn1m2oa3GrMllWdEUhN26YtAgD7V53pe75Koy0=;
        b=Lf164Ph0151nUn4EIIEZMqIa9wnJ2VZ6dxPr8nc7fe4LqYQjnL1/GyUlZ1Xb5greAF
         rWA9MXOLkIokLJVHB3gvDdSZNK2FHoxZNJv+e1P8UwAJuZDfHr9O/uLIlguxnHWKJ2f5
         NM6WYEkCOx5escV5s9ihTfA2+qvdiNhNrDKjsgn+kQkWOJuzP3MkYciqxomy4Ph1lv5+
         BTy1GqI5TBVcBF4raytOXaWvgIYsiOHKOhzNZmRHgKS20giC+FvP2Td1Thlu52pDuAfX
         I9D4AoHBEANOlCNYQg6r8Aq5T3XoTEQkVmVMNRgIeqZiBkJ86sNtPv2L4o+PQIgRswXZ
         kXjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739535799; x=1740140599;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8wsvYUn1m2oa3GrMllWdEUhN26YtAgD7V53pe75Koy0=;
        b=Fsh30u44cil7P5DgLEqbdZVIH4EQq2LSCZMC1EZVEjvGpWYJWHFJvYEbvLVKh9VrvL
         KxRowKhwxHPOtOHOMz9JbRXCGq8rnyvnMucyRqIF8aNwonSYfYBk06AMfKQflGxKMobn
         IJaJjNcShBYZySUDKTBzjE8jTFTPKUxanGUSrvikYXV2tjPEaXQVQn9qHmlteB5AZUn4
         MICVbiKiIOKOTJ0FLXAdZabgucMODsILh05hg4jMSS8n4A5BJjGfaJLzRwwPJVziy49d
         iAdCu+h4f5/qSYKwb65houhXKZzb35AphzgjHlbpIw0leKYNA3yw+tNAMJpR7G3+r+cX
         HLxA==
X-Forwarded-Encrypted: i=1; AJvYcCXtgw4eqQv7TGHsbGqJjfkcbEPS8gAQkWEeXqIJYz+Bb9nMZXWHMn9L9VzGXxSaujftIZp5l5ApoY9FyB8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNgDfYpGdwcHrWHsQm3WtS2qT4/Qv0f7WPACvfifjvZ/2ArAym
	pprXUveZWCs0AV7Bu2dHiquEMdYcuSZuJIJbJ+w0dV5UNA78J/wwPgZxgQ+s+9c=
X-Gm-Gg: ASbGncvyk+iFu59QPMLBeMv1MckU+6tLptZoOH/BhsbyAUFse6x4dnD2SCqxOyIgyOf
	30f2gVMPY3OypxkUrqQuAa7rLuVvbHHu1CzQWKKZNLe8C3kBdDYX6ElroN2kewvcDUWIaMXxC9G
	hLpDzTl7zULrCiLF0UPQ/TYU6UR2ppXPb6Kp+0zMN1i+NC3PdPXTOYFneLtEAend2QiTf7R7jD6
	PgavQP3YMcicynRhKfUMGautTSdd2hjK+nhXkBmlOv8kw3G3Pj9Q3aX1wtXPK6LB8CBUXKYfcOv
	KfP9/RL0WQ6UoFcIE9uSi/F5BHmxccbPYtMT0YsZs/JmgC02icSOtFh5b/AfOT4I+115pAnL
X-Google-Smtp-Source: AGHT+IEDQWC5tiIRz+2R7TgH92zpBtRkZ3QohO4W65JuSWaGXT5oTXw9QVJsqMSAksmdsVyR8mmEPw==
X-Received: by 2002:adf:f28d:0:b0:38d:d8b2:cf0a with SMTP id ffacd0b85a97d-38dea288854mr10774854f8f.31.1739535799285;
        Fri, 14 Feb 2025 04:23:19 -0800 (PST)
Received: from [127.0.0.1] (amontpellier-556-1-148-206.w109-210.abo.wanadoo.fr. [109.210.4.206])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f259f7b68sm4424654f8f.85.2025.02.14.04.23.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 04:23:18 -0800 (PST)
From: Esteban Blanc <eblanc@baylibre.com>
Date: Fri, 14 Feb 2025 13:22:36 +0100
Subject: [PATCH v4 6/6] docs: iio: ad4030: add documentation
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250214-eblanc-ad4630_v1-v4-6-135dd66cab6a@baylibre.com>
References: <20250214-eblanc-ad4630_v1-v4-0-135dd66cab6a@baylibre.com>
In-Reply-To: <20250214-eblanc-ad4630_v1-v4-0-135dd66cab6a@baylibre.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc: Michael Hennerich <michael.hennerich@analog.com>, 
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 Esteban Blanc <eblanc@baylibre.com>
X-Mailer: b4 0.14.2

This adds a new page to document how to use the ad4030 ADC driver

Signed-off-by: Esteban Blanc <eblanc@baylibre.com>
---
 Documentation/iio/ad4030.rst | 181 +++++++++++++++++++++++++++++++++++++++++++
 Documentation/iio/index.rst  |   1 +
 MAINTAINERS                  |   1 +
 3 files changed, 183 insertions(+)

diff --git a/Documentation/iio/ad4030.rst b/Documentation/iio/ad4030.rst
new file mode 100644
index 0000000000000000000000000000000000000000..41ce5ca5c710c46a0995d1b127fa1c10fca4c1eb
--- /dev/null
+++ b/Documentation/iio/ad4030.rst
@@ -0,0 +1,181 @@
+.. SPDX-License-Identifier: GPL-2.0-only
+
+=============
+AD4030 driver
+=============
+
+ADC driver for Analog Devices Inc. AD4030 and similar devices. The module name
+is ``ad4030``.
+
+
+Supported devices
+=================
+
+The following chips are supported by this driver:
+
+* `AD4030-24 <https://www.analog.com/AD4030-24>`_
+* `AD4032-24 <https://www.analog.com/AD4032-24>`_
+* `AD4630-16 <https://www.analog.com/AD4630-16>`_
+* `AD4630-24 <https://www.analog.com/AD4630-24>`_
+* `AD4632-16 <https://www.analog.com/AD4632-16>`_
+* `AD4632-24 <https://www.analog.com/AD4632-24>`_
+
+IIO channels
+============
+
+Each "hardware" channel as described in the datasheet is split in 2 IIO
+channels:
+
+- One channel for the differential data
+- One channel for the common byte.
+
+The possible IIO channels depending on the numbers of "hardware" channel are:
+
++------------------------------------+------------------------------------+
+| 1 channel ADC                      | 2 channels ADC                     |
++====================================+====================================+
+| - voltage0-voltage1 (differential) | - voltage0-voltage1 (differential) |
+| - voltage2 (common-mode)           | - voltage2-voltage3 (differential) |
+|                                    | - voltage4 (common-mode)           |
+|                                    | - voltage5 (common-mode)           |
++------------------------------------+------------------------------------+
+
+Labels
+------
+
+For ease of use, the IIO channels provide a label. For a differential channel,
+the label is ``differentialN`` where ``N`` is the "hardware" channel id. For a
+common-mode channel, the label is ``common-modeN`` where ``N`` is the
+"hardware" channel id.
+
+The possible labels are:
+
++-----------------+-----------------+
+| 1 channel ADC   | 2 channels ADC  |
++=================+=================+
+| - differential0 | - differential0 |
+| - common-mode0  | - differential1 |
+|                 | - common-mode0  |
+|                 | - common-mode1  |
++-----------------+-----------------+
+
+Supported features
+==================
+
+SPI wiring modes
+----------------
+
+The driver currently supports the following SPI wiring configurations:
+
+One lane mode
+^^^^^^^^^^^^^
+
+In this mode, each channel has its own SDO line to send the conversion results.
+At the moment this mode can only be used on AD4030 which has one channel so only
+one SDO line is used.
+
+.. code-block::
+
+    +-------------+         +-------------+
+    |     ADC     |         |     HOST    |
+    |             |         |             |
+    |         CNV |<--------| CNV         |
+    |          CS |<--------| CS          |
+    |         SDI |<--------| SDO         |
+    |        SDO0 |-------->| SDI         |
+    |        SCLK |<--------| SCLK        |
+    +-------------+         +-------------+
+
+Interleaved mode
+^^^^^^^^^^^^^^^^
+
+In this mode, both channels conversion results are bit interleaved one SDO line.
+As such the wiring is the same as `One lane mode`_.
+
+SPI Clock mode
+--------------
+
+Only the SPI clocking mode is supported.
+
+Output modes
+------------
+
+There are more exposed IIO channels than channels as describe in the devices
+datasheet. This is due to the `Differential data + common-mode`_ encoding
+2 types of information in one conversion result. As such a "device" channel
+provides 2 IIO channels, one for the differential data and one for the common
+byte.
+
+Differential data
+^^^^^^^^^^^^^^^^^
+
+This mode is selected when:
+
+- Only differential channels are enabled in a buffered read
+- Oversampling attribute is set to 1
+
+Differential data + common-mode
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+This mode is selected when:
+
+- Differential and common-mode channels are enabled in a buffered read
+- Oversampling attribute is set to 1
+
+For the 24-bits chips, this mode is also available with 16-bits differential
+data but is not selectable yet.
+
+Averaged differential data
+^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+This mode is selected when:
+
+- Only differential channels are selected enabled in a buffered read
+- Oversampling attribute is greater than 1
+
+Digital Gain and Offset
+-----------------------
+
+Each differential data channel has a 16-bits unsigned configurable hardware
+gain applied to it. By default it's equal to 1. Note that applying gain can
+cause numerical saturation.
+
+Each differential data channel has a signed configurable hardware offset.
+For the ADCs ending in ``-24``, the gain is encoded on 24-bits.
+Likewise, the ADCs ending in ``-16`` have a gain encoded on 16-bits. Note that
+applying an offset can cause numerical saturation.
+
+The final differential data returned by the ADC is computed by first applying
+the gain, then the offset.
+
+The gain is controlled by the ``calibscale`` IIO attribute while the offset is
+controlled by the ``calibbias`` attribute.
+
+Reference voltage
+-----------------
+
+The chip supports an external reference voltage via the ``REF`` input or an
+internal buffered reference voltage via the ``REFIN`` input. The driver looks
+at the device tree to determine which is being used. If ``ref-supply`` is
+present, then the external reference voltage is used and the internal buffer is
+disabled. If ``refin-supply`` is present, then the internal buffered reference
+voltage is used.
+
+Reset
+-----
+
+Both hardware and software reset are supported. The driver looks first at the
+device tree to see if the ``reset-gpio`` is populated.
+If not present, the driver will fallback to a software reset by wiring to the
+device's registers.
+
+Unimplemented features
+----------------------
+
+- ``BUSY`` indication
+- Additional wiring modes
+- Additional clock modes
+- Differential data 16-bits + common-mode for 24-bits chips
+- Overrange events
+- Test patterns
+
diff --git a/Documentation/iio/index.rst b/Documentation/iio/index.rst
index 5710f5b9e9582befb6dfa9d72c4fae8cae8ddeb7..2d334be2b7f29a82916a03d808bc0cb38e5a2252 100644
--- a/Documentation/iio/index.rst
+++ b/Documentation/iio/index.rst
@@ -19,6 +19,7 @@ Industrial I/O Kernel Drivers
    :maxdepth: 1
 
    ad4000
+   ad4030
    ad4695
    ad7380
    ad7606
diff --git a/MAINTAINERS b/MAINTAINERS
index bfb739c2f5f4ef9182c9789c797e63a93ab08080..364cfc6e8cc6f99b32319e5344c66b2b578bc5d5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1314,6 +1314,7 @@ L:	linux-iio@vger.kernel.org
 S:	Supported
 W:	https://ez.analog.com/linux-software-drivers
 F:	Documentation/devicetree/bindings/iio/adc/adi,ad4030.yaml
+F:	Documentation/iio/ad4030.rst
 F:	drivers/iio/adc/ad4030.c
 
 ANALOG DEVICES INC AD4130 DRIVER

-- 
2.47.2


