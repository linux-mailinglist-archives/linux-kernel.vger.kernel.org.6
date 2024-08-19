Return-Path: <linux-kernel+bounces-292233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C579D956CD8
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 16:12:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7ACAF282A2D
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 14:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF61F16D9AC;
	Mon, 19 Aug 2024 14:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="aQWOEsnR"
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BDF3166F21
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 14:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724076718; cv=none; b=Cob9nwxUZeZa2hj0s57MgqGdH4RX7jf1N3dlFYaWilbL/g3OHbgpaNsmTUoWqVXHBhdBGDGHxANkwobDTYYtzresEBAOqDvGLkzFx4d6ZzzLuFSbVK1E2ItjgGhSQsAPj1s+7NdWj8ubF3jZn2tEOwuTpB4/yPJOVtgu5cZYF1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724076718; c=relaxed/simple;
	bh=GKmFo3bmFk2IVwRE7ksCrTnyul2s0DsTqMziI0uIR6M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nSIchOmIcD4vCTtswi8U08/QhhoxmOjA2cvfXNqyj3HYrcZm9JyovRksh2xzSxyS0ZG6occbINT5C0q1BjG/h3NfcdWeI+jz8gDfVVFeEf5ZbyyuMW1G2Rwi9GFtHeVqbl+XvtpVgSqB4qcJFg1gteC4Wap6ESSk/JZioYoX3l4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=aQWOEsnR; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-70943b07c2cso2457470a34.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 07:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1724076715; x=1724681515; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/5uzNUVmRh9vWTdDmOIKmWFbEDxFk4bBzY+xGs2C1kM=;
        b=aQWOEsnRVgx4NUH/d82ZLeikFMG8N6Vx0BIJui0g596QAoWdC3Ls/iwpTAKU2bSmYW
         my3cHwGuPpD2pBbuZtX2UFdt8M2LnBk0Ljjh9/6OFJP9ggK3j9jjhSL/BNYEEfU1wWwX
         6NHXesHxeQPyU0Vl4WOyfkPHPGUwwIxCEAnoAATuGUdBcyhqg9wKcJACe6rbByQUPhWW
         /vfMex1RTYMT2qCHnJKZaJZi2YM2NzKUcB4ybV/NzyX+uFBuY/xuFQeItptLYVABi4tH
         kTWjcfh/QZUqH69O/kiW3JrImpMGqPO8yYW98ZUnDE/PYR+eLmEdOnN0ZSdCWIMs2MDl
         UG4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724076715; x=1724681515;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/5uzNUVmRh9vWTdDmOIKmWFbEDxFk4bBzY+xGs2C1kM=;
        b=CwGkI5kgrwA2o9+BByx/3dqaTKWnbEs1wy2Oz347RHiIwfcT+4zEi1tiA/AUVlV5E7
         FnoUgMUvemBC4cqAsLTzlxu5B/VwjhsTRhpmDwwsvhdXeiujvLznU7mwKQ6Ngr3X081/
         AnWsOQNaHBBAB5duDuc+ra8IHMd1vCLql/i13Fr2CkARhRFdjDMqh4IICK/6yz97VJJo
         fCcobbH2RYqhcFu/b2xaK1fFbK9TfA096ieOYl/57MSl2NHRJ1HtJDfQmZHY/1vRxWuA
         DqWO60DVp8EycKL3DoAYrYrTQvZk9yUJurduU+0pesE6Wlhtm4qpts7yDJyhO+uLXZm3
         Cp8g==
X-Forwarded-Encrypted: i=1; AJvYcCWdzmhmY+Jb2u40luXyfcsAqoaX/ZAgKVdXP5SCXo2sy9Qo8ryNcOAmos76sWNrgs0CLfSFIrJpZ5jqDbIOuhLluAZ6mpk9zRtHcIwO
X-Gm-Message-State: AOJu0Yw/NXuQkjPW2+aCfOFee6HB7KQ9SgCND1RWSs/6VtKR/n6YSYgZ
	ekbh4jmxvtPwaTid8bL+sXif0McrTKk3HkZPkXJDMSUFbMEoUkyVcY+IZHkjhTI=
X-Google-Smtp-Source: AGHT+IEIDxFNslUnjaNjQfcTGoFfsRx/9iiQtZEblfA8o9JXy5NKux1Ci5S8rTzmYKFjgqPFesW3cQ==
X-Received: by 2002:a05:6830:92a:b0:703:6434:aba8 with SMTP id 46e09a7af769-70cac7c6020mr13267546a34.0.1724076714622;
        Mon, 19 Aug 2024 07:11:54 -0700 (PDT)
Received: from [127.0.1.1] (d24-150-219-207.home.cgocable.net. [24.150.219.207])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-454c0186bf4sm17630871cf.83.2024.08.19.07.11.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 07:11:54 -0700 (PDT)
From: Trevor Gamblin <tgamblin@baylibre.com>
Date: Mon, 19 Aug 2024 10:11:45 -0400
Subject: [PATCH v3 3/3] docs: iio: new docs for ad7625 driver
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240819-ad7625_r1-v3-3-75d5217c76b5@baylibre.com>
References: <20240819-ad7625_r1-v3-0-75d5217c76b5@baylibre.com>
In-Reply-To: <20240819-ad7625_r1-v3-0-75d5217c76b5@baylibre.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 David Lechner <dlechner@baylibre.com>, 
 Uwe Kleine-Konig <u.kleine-koenig@baylibre.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 Trevor Gamblin <tgamblin@baylibre.com>
X-Mailer: b4 0.14.1

Add documentation for the AD7625/AD7626/AD7960/AD7961 ADCs.

Signed-off-by: Trevor Gamblin <tgamblin@baylibre.com>
---
 Documentation/iio/ad7625.rst | 91 ++++++++++++++++++++++++++++++++++++++++++++
 MAINTAINERS                  |  1 +
 2 files changed, 92 insertions(+)

diff --git a/Documentation/iio/ad7625.rst b/Documentation/iio/ad7625.rst
new file mode 100644
index 000000000000..61761e3b75c3
--- /dev/null
+++ b/Documentation/iio/ad7625.rst
@@ -0,0 +1,91 @@
+.. SPDX-License-Identifier: GPL-2.0-only
+
+====================
+AD7625 driver
+====================
+
+ADC driver for Analog Devices Inc. AD7625, AD7626, AD7960, and AD7961
+devices. The module name is ``ad7625``.
+
+Supported devices
+=================
+
+The following chips are supported by this driver:
+
+* `AD7625 <https://www.analog.com/AD7625>`_
+* `AD7626 <https://www.analog.com/AD7626>`_
+* `AD7960 <https://www.analog.com/AD7960>`_
+* `AD7961 <https://www.analog.com/AD7961>`_
+
+The driver requires use of the Pulsar LVDS HDL project:
+
+* `Pulsar LVDS HDL <http://analogdevicesinc.github.io/hdl/projects/pulsar_lvds/index.html>`_
+
+To trigger conversions and enable subsequent data transfer, the devices
+require coupled PWM signals with a phase offset.
+
+Supported features
+==================
+
+Conversion control modes
+------------------------
+
+The driver currently supports one of two possible LVDS conversion control methods.
+
+Echoed-Clock interface mode
+^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+.. code-block::
+
+                                                +----------------+
+                     +xxxxxxxxxxxxxxxxxxxxxxxxxx| CNV            |
+                     X                          |                |
+                     v                          |    HOST        |
+          +----------------------------+        |                |
+          |      CNV+/CNV-   DCO+/DCO- |xxxxxxx>| CLK_IN         |
+          |                            |        |                |
+          |                            |        |                |
+          |       AD7625         D+/D- |xxxxxxx>| DATA_IN        |
+          |                            |        |                |
+          |                            |        |                |
+          |                  CLK+/CLK- |<xxxxxxx| CLK & CLK_GATE |
+          +----------------------------+        |                |
+                                                +----------------+
+
+Reference voltage
+-----------------
+
+Three possible reference voltage sources are supported:
+
+- Internal reference (only available on AD7625 and AD7626)
+- External reference and internal buffer
+- External reference
+
+The source is determined by the device tree. If ``ref-supply`` is present, then
+the external reference is used. If ``refin-supply`` is present, then the internal
+buffer is used. If neither is present, then the internal reference is used.
+
+Unimplemented features
+----------------------
+
+- Self-clocked mode
+
+
+Device attributes
+=================
+
+The AD762x is a fully-differential ADC and has the following attributes:
+
++---------------------------------------+--------------------------------------------------------------+
+| Attribute                             | Description                                                  |
++=======================================+==============================================================+
+| ``scale``                             | Scale factor to convert raw value from buffered reads to mV. |
++---------------------------------------+--------------------------------------------------------------+
+
+
+Device buffers
+==============
+
+This driver supports IIO triggered buffers.
+
+See :doc:`iio_devbuf` for more information.
diff --git a/MAINTAINERS b/MAINTAINERS
index a90972e1c5c5..97c9b03e1cf0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1268,6 +1268,7 @@ S:	Supported
 W:	https://ez.analog.com/linux-software-drivers
 W:	http://analogdevicesinc.github.io/hdl/projects/pulsar_lvds/index.html
 F:	Documentation/devicetree/bindings/iio/adc/adi,ad7625.yaml
+F:	Documentation/iio/ad7625.rst
 F:	drivers/iio/adc/ad7625.c
 
 ANALOG DEVICES INC AD7768-1 DRIVER

-- 
2.39.2


