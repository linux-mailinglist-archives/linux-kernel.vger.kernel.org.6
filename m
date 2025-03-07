Return-Path: <linux-kernel+bounces-550917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B541A565C2
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 11:52:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 975F316CA91
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 10:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FD6F211A35;
	Fri,  7 Mar 2025 10:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="RE0CEpYq"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A7E6211A29
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 10:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741344737; cv=none; b=CfL75K0ocDLHNt1OaLnGeYXU7kF7BUEYTreJtivW5d5LZpS4isLbRJ3s3WzOmU9rrhLb1sUSkIFk8xnzK+QKEknFjL3+s4eainXxPAHu1psOvfGq+alLBEq4UgAX/8BzNvRcC547noO+n3UhilM9k61LeXDDpq9ZqChzS2g0j78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741344737; c=relaxed/simple;
	bh=UPiCGB7id3J1Lgv5V6c3KuQAx79xGzzqfArR+kR1p9s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MexTvN0lWvfWDTXD9n+fr89V6EuBNwZmJXgTQtJbl4ZPW4LzWcpIuGUYkzqNXb8c8J2cH4T31mJi9BbrX3VcQZNTApzgKQupW1200lgye7L2NsuuE08oyqZ4HUFoXG/1pyEyvMV0l2gNuCa12Sg9EajJRQqm84r8gL6jwmo0AtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=RE0CEpYq; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-30beef77634so7487861fa.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Mar 2025 02:52:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1741344732; x=1741949532; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=43iEn7JI+JVfImukURZDy+wlnZTduIdMuwCwHiHb2L4=;
        b=RE0CEpYqlv8/bp/HpxRm2R5y/7Itgyzq1j79ZmpZGp/tLrTN6svYbSDvNjQxvx0OLO
         qEH9K9jBMqaTtN6LXUFpxo2OP/SOVQ/NpTAk7vtFjm2RMKVCDuWRIOlp6yBKXYPZtzuV
         LMnUQ3D4puD0lddLoigvZspYoOb7RdPO/70i09/r/WuUvu/3l5uS7SKFVPBzjaiXx0Gs
         epYZsWvoEKtzYVyAlsK5yoJj1N7CsFhhpf5JiCbZ6vEdYg17on4ZREs77/fAJWBRqQer
         D+OzRjlkDrtrID9tViMZYMo85m0dqqdB9c1Uh4jlnVQbxkGhUYQWMrVg+/DfQ3RGeh2n
         V6iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741344733; x=1741949533;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=43iEn7JI+JVfImukURZDy+wlnZTduIdMuwCwHiHb2L4=;
        b=HTT/RdD0pAE1EHOaHq5uAvsqlpQFXS8QGIeFe3cH5hyTGyLrTKNbv6kE08mrixz8WN
         txMIk11vxQ4wCZYqLO12jxEsjawc2Gg73oILN/M1ZHvrHZMZzbNoMF5byrixWkE3KH9e
         j9VOjcu9wVy3ketMQ3nxc2L+wnc/J7O7kQbrPs8hk4qxtqCHnAsvF1KnB9xD4Ly6jYk9
         YFa2GZSufKr6E9SATRZqUnKDEgaYYlSc9w7YsPGy2mgEQ1x83p3Va2mSjbJk804OWVM6
         SUJeTarNOsGvrgVvc26wZF1C0K/gy+Z88LRCx38kWhnTRd5h07AE7osqez3rGaz0GA6z
         rEBA==
X-Forwarded-Encrypted: i=1; AJvYcCXcSXlRq/bJrjYDL3bUnLHyA21LUdGNb/DifaoiS4VFNbXMNuLoQVWMf6cIfn9f8HJKNuNlYoAdSI/1A8k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvaMHQE+4FNA9oV6k8oJKQxuc2/X9luk6+1Xf1GfgTJCWjwYHs
	8XKIbeLMNUIeTkjPUzVmQQjZxCMU8g4Yl3OwndqfkVKSH4SVbxK5tYjxAnTBih8mE0Ml+hwOttM
	KekdKCRq7vLIa4caAHseuOmt5rZYVO6D+MIhN8w==
X-Gm-Gg: ASbGncuTluCFg42RcZz3k6p/eiZUECccQeu6NqdDvIjGDRB6QPHZqwcUCGZHKnWRLc6
	V84Wo0L5ohWCTzJ4KGHFvx1D50Gu9WrCw+t4rFcrWOFYhOXECJMwuK+9y5m13BPI2pOJKgR2rEz
	DQ+gP5fSl2rI4sG2CcXpnG3hgYzg==
X-Google-Smtp-Source: AGHT+IHB3kK56vH8JV6/mkLBm8uqvR7p6MJCGGVmcvlyTK2KPum07gwr4GAktMuyL3uRXkIC0qo1105z0ZQF6RQulRM=
X-Received: by 2002:a05:651c:1546:b0:308:efa4:d277 with SMTP id
 38308e7fff4ca-30bf451a693mr10523131fa.15.1741344732515; Fri, 07 Mar 2025
 02:52:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250306-iio-driver-ad4052-v1-0-2badad30116c@analog.com> <20250306-iio-driver-ad4052-v1-3-2badad30116c@analog.com>
In-Reply-To: <20250306-iio-driver-ad4052-v1-3-2badad30116c@analog.com>
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 7 Mar 2025 11:52:01 +0100
X-Gm-Features: AQ5f1JoiUtEQ4jvbbzJp6JsM_Z5iT3lzE5Y0UsgAtaayiupCCfLSsOBfI0fpWNs
Message-ID: <CAMknhBFiZZUtCkTjQ=AVSgwqe=wCkMnqAmaTqvW_X6fm1OKuYA@mail.gmail.com>
Subject: Re: [PATCH 3/4] docs: iio: new docs for ad4052 driver
To: Jorge Marques <jorge.marques@analog.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 6, 2025 at 3:04=E2=80=AFPM Jorge Marques <jorge.marques@analog.=
com> wrote:
>
> This adds a new page to document how to use the ad4052 ADC driver.
>
> Signed-off-by: Jorge Marques <jorge.marques@analog.com>
> ---
>  Documentation/iio/ad4052.rst | 93 ++++++++++++++++++++++++++++++++++++++=
++++++
>  MAINTAINERS                  |  1 +
>  2 files changed, 94 insertions(+)
>
> diff --git a/Documentation/iio/ad4052.rst b/Documentation/iio/ad4052.rst
> new file mode 100644
> index 0000000000000000000000000000000000000000..cf0cbd60d0a48ea52f74ea02f=
de659fcdba61aa1
> --- /dev/null
> +++ b/Documentation/iio/ad4052.rst
> @@ -0,0 +1,93 @@
> +.. SPDX-License-Identifier: GPL-2.0-only
> +
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +AD4052 driver
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +ADC driver for Analog Devices Inc. AD4052 and similar devices.
> +The module name is ``ad4052``.
> +
> +Supported devices
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +The following chips are supported by this driver:
> +
> +* `AD4050 <https://www.analog.com/AD4050>`_
> +* `AD4052 <https://www.analog.com/AD4052>`_
> +* `AD4056 <https://www.analog.com/AD4056>`_
> +* `AD4058 <https://www.analog.com/AD4058>`_
> +
> +Wiring modes
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +The ADC uses SPI 4-wire mode, and contain two programmable GPIOs and
> +a CNV pin.
> +
> +The CNV pin is exposed as the ``cnv-gpios`` and triggers a ADC conversio=
n.
> +GP1 is ADC conversion ready signal and GP0 Threshold event interrupt, bo=
th
> +exposed as interrupts.
> +
> +Omit ``cnv-gpios`` and tie CNV and CS together to use the rising edge
> +of the CS as the CNV signal.
> +
> +Device attributes
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +The ADC contain only one channels, and the following attributes:
> +
> +.. list-table:: Driver attributes
> +   :header-rows: 1
> +
> +   * - Attribute
> +     - Description
> +   * - ``in_voltage0_raw``
> +     - Raw ADC voltage value
> +   * - ``in_voltage0_oversampling_ratio``
> +     - Enable the device's burst averaging mode to over sample using
> +       the internal sample rate.
> +   * - ``in_voltage0_oversampling_ratio_available``
> +     - List of available oversampling values. Value 0 disable the burst
> +       averaging mode.
> +   * - ``sample_rate``
> +     - Device internal sample rate used in the burst averaging mode.
> +   * - ``sample_rate_available``
> +     - List of available sample rates.

Why not using the standard sampling_frequency[_available] attributes?

> +
> +Threshold events
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +The ADC supports a monitoring mode to raise threshold events.
> +The driver supports a single interrupt for both rising and falling
> +readings.
> +
> +During monitor mode, the device is busy since other transactions
> +require to put the device in configuration mode first.

This isn't so clear to me. Is this saying that events do not work
while doing a buffered read? Do you need to do need to read the
in_voltage0_raw input to trigger an event?

> +
> +Low-power mode
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +The device enters low-power mode on idle to save power.
> +Enabling an event puts the device out of the low-power since the ADC
> +autonomously samples to assert the event condition.
> +
> +SPI offload support
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +To be able to achieve the maximum sample rate, the driver can be used wi=
th the
> +`AXI SPI Engine`_ to provide SPI offload support.
> +
> +.. _AXI SPI Engine: http://analogdevicesinc.github.io/hdl/projects/ad405=
2_ardz/index.html

This diagram show a PWM connected to the CNV pin on the ADC, but I
didn't see a pwms property in the DT bindings to describe this.

> +
> +When SPI offload is being used, additional attributes are present:
> +
> +.. list-table:: Additional attributes
> +   :header-rows: 1
> +
> +   * - Attribute
> +     - Description
> +   * - ``in_voltage0_sampling_frequency``
> +     - Set the sampling frequency.
> +   * - ``in_voltage0_sampling_frequency_available``
> +     - Get the sampling frequency range.
> +
> +The scan type is different when the buffer with offload support is enabl=
ed.
> diff --git a/MAINTAINERS b/MAINTAINERS
> index fef8adaee888d59e1aa3b3592dda5a8bea0b7677..312b2cf94b8f06298b1cbe597=
5ee32e2cf9a74d8 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1322,6 +1322,7 @@ M:        Jorge Marques <jorge.marques@analog.com>
>  S:     Supported
>  W:     https://ez.analog.com/linux-software-drivers
>  F:     Documentation/devicetree/bindings/iio/adc/adi,ad4052.yaml
> +F:     Documentation/iio/ad4052.rst
>
>  ANALOG DEVICES INC AD4130 DRIVER
>  M:     Cosmin Tanislav <cosmin.tanislav@analog.com>
>
> --
> 2.48.1
>

I didn't have time to read the full datasheet or look at the driver
code yet, but can do that next week.

