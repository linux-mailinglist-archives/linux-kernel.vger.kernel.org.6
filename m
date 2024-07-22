Return-Path: <linux-kernel+bounces-259432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 91805939619
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 00:02:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B52FB1C2184D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 22:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A2854C622;
	Mon, 22 Jul 2024 22:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="SLKqfzRj"
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 075D623DE
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 22:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721685690; cv=none; b=Qz9wiG6gzIbP5wsI4V5wUemD1jD60k96LKuIf9S4l+CYc6LJmak1E733E/0JIru5mYnfxItwUETQbxgM29LxXN9GKviEiYWa6XI+2o/5uO/WOoSMDobbdyIyHmSibEqKn2rPSWy2IscRU269C+ltwXZk3v0VswjsaUvjffd65oY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721685690; c=relaxed/simple;
	bh=/ru1Bf2H9W5Kc4MG8k98hW6Wdp+YW4glK8+b1cnQf0M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dJVXzXbx2tpacZkpxN6BHWByJ0UeneVSblQ8UbZdek0OJFKhubw7i7+QWaEejg74np3nuQRzIZkQR/IgHrlGf4pSjZjj7LKcEl28s95iwF3jlGOkE/eciD/es9I4VQasUbZ/2K6hgXSfeQ6k3GaWXtjrUPJevDLrq6jOGH3FR84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=SLKqfzRj; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-703d5b29e06so2039149a34.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 15:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1721685686; x=1722290486; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JAUt/ALexQ1OP269aBEvYCgpzgE08wFzuX6/YmuwpRo=;
        b=SLKqfzRjxDwjqOUfDwK4XoDQ0BrEtqMUVuPUjv8CfvaQd2kUDJHEgkBVRWXahZ2zC0
         SGUTZ52lfvyZYcxab7NsERSee2A9/2CvhTgjVMtEPj0EvGuX63I/86JfDj4tmYBTi7m9
         Ghw4rQBG+vfOh3r72cvGtT+3hRETI0qvoGo1BtVkZZUUWJYXnzE2tUgp+RFQ/yMAqLUY
         wU6dX2ao0KBRX/YsI+kbZ/vp2bp58st00Lk1KIK5YfoSW189DYqIBDAIq99YSYKfvErq
         eWIPUBcSkxnoXVWnmCuB2N3sHSPs/bw/L+gEqqsnOWtcdwrBI4WIeljHfoZaCXPWnERA
         06Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721685686; x=1722290486;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JAUt/ALexQ1OP269aBEvYCgpzgE08wFzuX6/YmuwpRo=;
        b=nlJsCQ1QiM/oXTYXDj/NaZWmp6ECREOevmhUe4Lp5tSnRCcj4R1hU5ixjfSA0ZnyMi
         RD/ZPYTuDXcu1i2eyndi7tf41eNvswAVaCI5MXPIsSbaK1+lkROtMUgS6PAeagsHJIVU
         AtgYUoYYC0VLM2d3TExnqam08MENO4Ij5wXzN2wZYLhFJvQPevXgiPDBZrTjRP6dskLa
         sYAnZsrn+AQB9EM+798DkgFEySDKpfLRPq7eEJx+Bx/YKbFa8g17V6/biG95sBeAUm+V
         NG6B2UaA4jjT/VNFRQPNzPDVTELkPo3cbaR014WeZbmQcs5ALoc26TnUnFxF9sieUZzI
         BGDg==
X-Forwarded-Encrypted: i=1; AJvYcCX1KNrEkseGb83sEL6pWU0nlVFhXawUwrSUZKb7/q8zA01LXqMHIUe4J8K0k5+F1Y3DQCcw9yd6tp+MXWN8X1gmhtfss06ascvwvwmh
X-Gm-Message-State: AOJu0YzxdEIh8hery5FbwVLlcbImDbhOSdqZjyZcbIom7sIj6d3ZEjtl
	jVIw/Ei8OHk0rezmvOSwuQLrN/B3YnCZ7fNrgOKHvaVp5OX2WNsPvnexKrXJRjc=
X-Google-Smtp-Source: AGHT+IGuWCaXZ/ObQnICIEAQHJbPOg0EjyYDPnmTnt9i4wKh7ZomfYywEjSRg/G2c4JYj8HYTBA/Zg==
X-Received: by 2002:a05:6870:4714:b0:261:fd5:aa34 with SMTP id 586e51a60fabf-263ab54f89amr4628410fac.30.1721685685764;
        Mon, 22 Jul 2024 15:01:25 -0700 (PDT)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-708f60a55e1sm1719911a34.11.2024.07.22.15.01.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jul 2024 15:01:25 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: Mark Brown <broonie@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	=?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Cc: David Lechner <dlechner@baylibre.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	David Jander <david@protonic.nl>,
	Martin Sperl <kernel@martin.sperl.org>,
	linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org
Subject: [PATCH RFC v3 0/9] spi: axi-spi-engine: add offload support
Date: Mon, 22 Jul 2024 16:57:07 -0500
Message-ID: <20240722-dlech-mainline-spi-engine-offload-2-v3-0-7420e45df69b@baylibre.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.14.0
Content-Transfer-Encoding: 8bit

There is a recap at the end of this cover letter for those not familiar
with the previous discussions. For those that are, we'll get right to
the changes since the last version.

In RFC v2, most of the discussion was around the DT bindings, so that
is what has mostly changed since then. I think we mostly settled on
what properties are needed and where they should go. There are probably
still some details to work out (see PATCH 5/9 for more discussion) but
I think we have the big-picture stuff figured out.

Here is the actual devicetree used for testing to show how it all
comes together:

	trigger_clk: adc-trigger-clock {
		compatible = "pwm-clock";
		#clock-cells = <0>;
		#trigger-source-cells = <0>;
		pwms = <&adc_trigger 0 10000>;
	};

	...

	axi_spi_engine_0: spi@44a00000 {
		compatible = "adi,axi-spi-engine-1.00.a";
		reg = <0x44a00000 0x1000>;
		interrupt-parent = <&intc>;
		interrupts = <0 56 IRQ_TYPE_LEVEL_HIGH>;
		clocks = <&clkc 15>, <&spi_clk>;
		clock-names = "s_axi_aclk", "spi_clk";

		/* offload-specific properties */
		#spi-offload-cells = <1>;
		dmas = <&rx_dma 0>;
		dma-names = "offload0-rx";
		trigger-sources = <&trigger_clk>;

		#address-cells = <1>;
		#size-cells = <0>;

		ad7986: adc@0 {
			compatible = "adi,ad7986";
			reg = <0>;
			spi-max-frequency = <111111111>; /* 9 ns period */
			adi,spi-mode = "single";
			avdd-supply = <&eval_u12>;
			dvdd-supply = <&eval_u12>;
			vio-supply = <&eval_u3>;
			bvdd-supply = <&eval_u10>;
			ref-supply = <&eval_u5>;
			turbo-gpios = <&gpio0 87 GPIO_ACTIVE_HIGH>;

			spi-offloads = <&axi_spi_engine_0 0>;
		};
	};

A working branch complete with extra hacks can be found at [1].

Also, I took a detour looking into what it would take to get Martin
Sperl's Raspberry Pi DMA offload proof-of-concept [2] updated to work
with this. This way we could have a second user to help guide the
design process. Given all of the SPI hardware quirks on that platform
and the unsolved technical issues, like how to get accurate time delays
and how to work around the 32-bit DMA word limitation, it would be more
work than I have time for (at least without someone sponsoring the work).

[1]: https://github.com/dlech/linux/tree/axi-spi-engine-offload-v3
[2]: https://github.com/msperl/spi-bcm2835/blob/refactor_dmachain_for_prepared_messages/spi-bcm2835dma.c

---
Changes in v3:
- See individual patches for more detailed changes.
- Reworked DT bindings to have things physically connected to the SPI
  controller be properties of the SPI controller and use more
  conventional provider/consumer properties.
- Added more SPI APIs for peripheral drivers to use to get auxillary
  offload resources, like triggers.
- Link to v2: https://lore.kernel.org/r/20240510-dlech-mainline-spi-engine-offload-2-v2-0-8707a870c435@baylibre.com

---

As a recap, here is the background and end goal of this series:

The AXI SPI Engine is a SPI controller that has the ability to record a
series of SPI transactions and then play them back using a hardware
trigger. This allows operations to be performed, repeating many times,
without any CPU intervention. This is needed for achieving high data
rates (millions of samples per second) from ADCs and DACs that are
connected via a SPI bus.

The offload hardware interface consists of a trigger input and a data
output for the RX data. These are connected to other hardware external
to the SPI controller.

To record one or more transactions, commands and TX data are written
to memories in the controller (RX buffer is not used since RX data gets
streamed to an external sink). This sequence of transactions can then be
played back when the trigger input is asserted.

This series includes core SPI support along with the first SPI
controller (AXI SPI Engine) and SPI peripheral (AD7944 ADC) that use
them. This enables capturing analog data at 2 million samples per
second.

The hardware setup looks like this:

+-------------------------------+   +------------------+
|                               |   |                  |
|  SOC/FPGA                     |   |  AD7944 ADC      |
|  +---------------------+      |   |                  |
|  | AXI SPI Engine      |      |   |                  |
|  |             SPI Bus ============ SPI Bus          |
|  |                     |      |   |                  |
|  |  +---------------+  |      |   |                  |
|  |  | Offload 0     |  |      |   +------------------+
|  |  |   RX DATA OUT > > > >   |
|  |  |    TRIGGER IN < < <  v  |
|  |  +---------------+  | ^ v  |
|  +---------------------+ ^ v  |
|  | AXI PWM             | ^ v  |
|  |                 CH0 > ^ v  |
|  +---------------------+   v  |
|  | AXI DMA             |   v  |
|  |                 CH0 < < <  |
|  +---------------------+      |
|                               |
+-------------------------------+

To: Mark Brown <broonie@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>
To: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>
To: Conor Dooley <conor+dt@kernel.org>
To: Nuno Sá <nuno.sa@analog.com>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>
Cc: David Jander <david@protonic.nl>
Cc: Martin Sperl <kernel@martin.sperl.org>
Cc:  <linux-spi@vger.kernel.org>
Cc:  <devicetree@vger.kernel.org>
Cc:  <linux-kernel@vger.kernel.org>
Cc:  <linux-iio@vger.kernel.org>

---
David Lechner (9):
      spi: dt-bindings: add spi-offload properties
      spi: add basic support for SPI offloading
      spi: add support for hardware triggered offload
      spi: add offload TX/RX streaming APIs
      spi: dt-bindings: axi-spi-engine: document spi-offloads
      spi: axi-spi-engine: implement offload support
      iio: buffer-dmaengine: generalize requesting DMA channel
      dt-bindings: iio: adc: adi,ad7944: add SPI offload properties
      iio: adc: ad7944: add support for SPI offload

 .../devicetree/bindings/iio/adc/adi,ad7944.yaml    |   3 +
 .../bindings/spi/adi,axi-spi-engine.yaml           |  41 +++
 .../devicetree/bindings/spi/spi-controller.yaml    |   5 +
 .../bindings/spi/spi-peripheral-props.yaml         |  11 +
 drivers/iio/adc/ad7944.c                           | 173 ++++++++++-
 drivers/iio/buffer/industrialio-buffer-dmaengine.c |  39 ++-
 drivers/iio/dac/adi-axi-dac.c                      |   3 +-
 drivers/spi/spi-axi-spi-engine.c                   | 341 ++++++++++++++++++++-
 drivers/spi/spi.c                                  | 226 +++++++++++++-
 include/linux/iio/buffer-dmaengine.h               |  11 +-
 include/linux/spi/spi.h                            | 169 ++++++++++
 11 files changed, 989 insertions(+), 33 deletions(-)
---
base-commit: 7a891f6a5000f7658274b554cf993dd56aa5adbc
change-id: 20240510-dlech-mainline-spi-engine-offload-2-afce3790b5ab

