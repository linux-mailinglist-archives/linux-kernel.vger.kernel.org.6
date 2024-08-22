Return-Path: <linux-kernel+bounces-297282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F9D595B55C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 14:47:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB2D31C229DA
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 12:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3033E1CBE98;
	Thu, 22 Aug 2024 12:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="NNfYv65j"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05CB51CB141
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 12:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724330758; cv=none; b=eQVmL9Hr3PvAP3Py/Ta8221NqKyOOspRH25VC+Q8pisKZ/YpS9GNIExaPORRRyVTxKuAKDNsOnAnrfwVpTUTq3PsfO4SuNawNYqzuKGNJhAV7IbJI4c+9lYQLHUM7qw/EPdWUvuCF3t6jIHMrLd3Haj8UlsQTD8YM2OaLsNnaC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724330758; c=relaxed/simple;
	bh=8/hV1jC5oxgrduJTHz/yn/jLU0aRf8ZOOhyI5NvtZNI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=R35qWuNYbYceItM1c8AuCxkmk07Z3H7cGr+EuEXi5fz95X930fCGMZskZ3d9dFnlbf7FGW6gSLZCkZbccIV3BPCeDzCrIzlEdyRV7HQURbmzeVAK4LbvumGVdXgzVn/hscWKn+36glr6IQIbqO2MFNhujkBY7UXavRB/cxF0fYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=NNfYv65j; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-42816ca797fso5707055e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 05:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1724330753; x=1724935553; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e+KcG1T4hXzL+mbqT29U2Wh5Iq2V0XC85Ca2zKoID7Y=;
        b=NNfYv65joLPmUDKwQFbagWedyX2y6WMOwXJll9g98u09fOiZ24nZgWXLyJz1Lg+thD
         A0+0NCfZPllDYTqURoCVMj0XJdhvjO/8ZCd0XjJYhPpmSQEFR+d0LLxCcO+1ijM/vvc4
         Lb7CxCURDXL7gOjKrvyKc3o+y/QilN2i2IhqsAJHrxqH4lXKbccHc8z33JaooJgyND8o
         2gFqUbMTZqHPjuBxsi3rL9vGVFWh7cNbx7d+mwGY2hDqvWmfQqXJxO4Rsdc65h5tgeYU
         WZEWBdVcZqN2vTB5lxbckFwOhvPKgkfsCFVwukkAC+NU1Kr8uPut4veo1xd4U3pVxV1V
         HKHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724330753; x=1724935553;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e+KcG1T4hXzL+mbqT29U2Wh5Iq2V0XC85Ca2zKoID7Y=;
        b=ecxKgBHFcmkVgyQWYezkIaMyoYeJKy6YAi19rQqBtmSpGG0nbeLblT5fEds4OtmbB9
         JZ+jbn40zrtY8iEGEgsI4VxbNG17YhPfJ83eUntQD7cLXCOr7uR3nYjZTS/a4tVUFLNJ
         ViCE0tAMTGPwBWuHWMgSINVBzGUZlC8hUo+RyOnTUEK0HsBxxEu06+cV69/WC3GZi2bV
         QRuTKjm9ZFq5JUEupc259/Is++9Hgu1xJxCdwaI9CcTl23dARBlxSOel5DC/pEs3pr/B
         KzMWw+jp67P5pX4Jx7LxIXyFg6+lbEW8hC1np5WzF9YPUXFhPpZw5p0XtfjXCoFKWNlr
         XLgw==
X-Forwarded-Encrypted: i=1; AJvYcCXqjb2aJiCPfbIDKAzqrH68Yns+h59QbC1PT6dbp62nrqkTOE/wzxvBJTzGC7SHl4RjfV4Z+JKl6S7lzJ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpyhjCawPpB1JDHtqY4Ut1ki6jvBNJW3zrLhKYYBy9ZVboDii0
	tK7jhS5QkxN+XG6joY94NBpP5b6tjWp2P4qfZqDJ39OsnktQRdtxciGpX2DvNW4=
X-Google-Smtp-Source: AGHT+IGlidXYZzGZq7cpWwep1Kgg7I/ZWcxTht8w0og0Bna8uCzD9WVBMLjbnb3evDSrrrv3V8wIwA==
X-Received: by 2002:a05:600c:3c9e:b0:427:98b4:624b with SMTP id 5b1f17b1804b1-42abd2459f5mr43794195e9.24.1724330753046;
        Thu, 22 Aug 2024 05:45:53 -0700 (PDT)
Received: from [127.0.0.1] ([2a01:e0a:448:76e0:8da6:6d6d:c8ed:16c5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ac514e269sm24032195e9.2.2024.08.22.05.45.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 05:45:52 -0700 (PDT)
From: Esteban Blanc <eblanc@baylibre.com>
Date: Thu, 22 Aug 2024 14:45:22 +0200
Subject: [PATCH 6/6] docs: iio: ad4030: add documentation
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240822-eblanc-ad4630_v1-v1-6-5c68f3327fdd@baylibre.com>
References: <20240822-eblanc-ad4630_v1-v1-0-5c68f3327fdd@baylibre.com>
In-Reply-To: <20240822-eblanc-ad4630_v1-v1-0-5c68f3327fdd@baylibre.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Nuno Sa <nuno.sa@analog.com>, 
 Jonathan Corbet <corbet@lwn.net>
Cc: Michael Hennerich <michael.hennerich@analog.com>, 
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, David Lechner <dlechner@baylibre.com>, 
 linux-doc@vger.kernel.org, Esteban Blanc <eblanc@baylibre.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openssh-sha256; t=1724330743; l=5098;
 i=eblanc@baylibre.com; s=yubikey; h=from:subject:message-id;
 bh=8/hV1jC5oxgrduJTHz/yn/jLU0aRf8ZOOhyI5NvtZNI=;
 b=U1NIU0lHAAAAAQAAAhcAAAAHc3NoLXJzYQAAAAMBAAEAAAIBALJZcW6pLD4ksSdWnXd5r65Ze
 5Qc5pH7+DmmbKJasOXeVYRPFEmnORS7pwhURG11AMVFmnCVYWj+wPYrbCEeM7XKfO4oQzc66kYB
 7y0RrFwjoWKofytjI026zV5b2pn1JAItgu0Ijth+TSa6KVOTSXqqiVzOTDM1WL0hAIIzpkhE3Vt
 AVJrFDsh/nWed9OpeSS+S6e3ZxyJtlnhqbVIemcDmjwMihtFgTKeJWlxP7KGY/RQKPF/Ef7pS+O
 AckOrxuqGKvpOiNVCmuQEUQM0+r4uvwtja4zRSl+huqW+g1nLyReoZPzFwfJWREd+89dtTJTXN7
 xmmFNdX6KzRKBLVw1RY/R3mhAd+MkrdiNaRNKj+LO1QIxPoW90cPG9WpdVDUZf1VxhdciB6Hlxn
 lfEDFuCxU0n5H+kC4eiZvw+c9D4xX7iVdjPTMEaE6GBQNnMncdljBwA5NVN8WcaUhnAQnq7qhcz
 85L2Br7MPqe3q3J/PHIe0nHO56j7tTY6cFFs/ckqcQSTJigh2rA7InN1d7GqZFLzlewRTGaCY+M
 93d7DCIuxTxJWRpVm7NW1FBeX6d00+dAcQ/dS+jmA3kcdRoWtH160jmmYYvOgrsQTcMIQrPtK+B
 rULRmmIvEIJMF5UfNmxruWmWn6MM/xeejTNszoKqrORpbr7q3BnkKt2y/KdAAAABnBhdGF0dAAA
 AAAAAAAGc2hhNTEyAAACFAAAAAxyc2Etc2hhMi01MTIAAAIABSG0ktK7ZMQWGu1+uSw9h2ii21j
 AVWCVke/PehbapdM+q0HpQM8j6sz/URuLO6KYA7uig2Vdv1VzuVht/FGJsJMDTJs5Rb2AUw3qsy
 cDwGbfgqzyE7d2mVIEB50mTBBt0/lOF3CAQpN98V4UyD98xSHcUoGyhdF+Qnpd04+a5Ve5X//1Z
 m/1nU5h5kESF0XkJoxdSDwe2NNDwbW/8Q0JCCEK+Tt93cutNi63ls9LAtWc+k1aUyfznGA2NrvK
 tWkU0eMTo6po/wj3WVpzZbDZ41kNcbyLorgnv5YW8leff7SxhuNCQjhR72gpVIyTTYDz+V6x/Dq
 EFxWjMcCu2ZXlDLrHm9e3fjV+totUj+0X2T8cST3aQKfRj/CpZoAJZMpgv2R8y62LRwhNKKHr8f
 O8YSDCZFzvO08T0GDu382O7Xqxw91nFNP0TWLExb2texbpQ82S1hurl719p7/2SGdk5QZ5nPrP/
 rS3houvJLoU1c+L+/dmaUhvrB/s+TgMBXyinWtnB8gYrlPbbB2FT+3lER43j2/RP0G3gAP9O0e4
 EH7by0UcwliEsa3vmhoB8HY1DQIL1edvo5nQ+2kyKY/iBsis1oXWb4dIaU0fGY/DnF1Wt8CUryD
 OXH6B4u6HCByXi/R8wRC0+2ZJr9nQWCFBYlbO/4Eqczzwihbl8XYZU10=
X-Developer-Key: i=eblanc@baylibre.com; a=openssh;
 fpr=SHA256:LOxhPHcL6HLuSaOVHuI2Yq7hvD2blbngN1ohWi2rJOw

This adds a new page to document how to use the ad4030 ADC driver

Signed-off-by: Esteban Blanc <eblanc@baylibre.com>
---
 Documentation/iio/ad4030.rst | 129 +++++++++++++++++++++++++++++++++++++++++++
 Documentation/iio/index.rst  |   1 +
 MAINTAINERS                  |   1 +
 3 files changed, 131 insertions(+)

diff --git a/Documentation/iio/ad4030.rst b/Documentation/iio/ad4030.rst
new file mode 100644
index 000000000000..56e0ba58b127
--- /dev/null
+++ b/Documentation/iio/ad4030.rst
@@ -0,0 +1,129 @@
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
+* `AD4630-16 <https://www.analog.com/AD4630-16>`_
+* `AD4630-24 <https://www.analog.com/AD4630-24>`_
+* `AD4632-16 <https://www.analog.com/AD4632-16>`_
+* `AD4632-24 <https://www.analog.com/AD4632-24>`_
+
+IIO channels
+============
+
+Each "device" channel as described in the datasheet is split in 2 IIO channels,
+in the following order:
+
+- One channel for the differential data
+- One channel for the common byte.
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
+As such the wiring is the same as `One lane mode`.
+
+SPI Clock mode
+--------------
+
+Only the SPI clocking mode is supported.
+
+Output modes
+------------
+
+There is more exposed IIO channels than channels as describe in the devices
+datasheet. This is due to the `Differential data + 8-bit common-mode` encoding
+2 types of information in one conversion result. As such a "device" channel
+provides 2 IIO channels, one for the differential data and one for the common
+byte.
+
+Differential data
+^^^^^^^^^^^^^^^^^
+
+This mode is selected when:
+
+- Only differential channels are selected
+- Oversampling attribute is set to 1
+
+Differential data + common-mode
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+This mode is selected when:
+
+- Differential and common-mode channels are selected
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
+- Only differential channels are selected
+- Oversampling attribute is greater than 1
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
+device tree to see if the `reset-gpio` is populated. If not present, the driver
+will fallback to a software reset by wiring to the device's registers.
+
+Unimplemented features
+----------------------
+
+- ``BUSY`` indication
+- Additional wiring modes
+- Additional clock modes
+- Differential data 16-bits + common-mode for 24-bits chips
+
diff --git a/Documentation/iio/index.rst b/Documentation/iio/index.rst
index dfcf9618568a..61faf3a60da6 100644
--- a/Documentation/iio/index.rst
+++ b/Documentation/iio/index.rst
@@ -19,6 +19,7 @@ Industrial I/O Kernel Drivers
    :maxdepth: 1
 
    ad4000
+   ad4030
    ad4695
    ad7380
    ad7944
diff --git a/MAINTAINERS b/MAINTAINERS
index 6a5a0e7b7a51..4a076a48648a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -420,6 +420,7 @@ R:	Esteban Blanc <eblanc@baylibre.com>
 S:	Supported
 W:	https://ez.analog.com/linux-software-drivers
 F:	Documentation/devicetree/bindings/iio/adc/adi,ad4030.yaml
+F:	Documentation/iio/ad4030.c
 F:	drivers/iio/adc/ad4030.c
 
 AD5110 ANALOG DEVICES DIGITAL POTENTIOMETERS DRIVER

-- 
2.44.1


