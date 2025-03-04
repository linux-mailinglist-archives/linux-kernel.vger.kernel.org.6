Return-Path: <linux-kernel+bounces-544490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AF9EDA4E18F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 15:47:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E07947A4E24
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 14:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 009C025F96D;
	Tue,  4 Mar 2025 14:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="rdj8m4rS"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFAAA2755F6
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 14:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741099527; cv=none; b=natbhNyw4WVpVD9WSo9ngzvhYwmWY7v8kid7Fmw5mkCsGePYn3YWu/zNMFFyIITFjB4cHqxJlZuIbe2ZSjZGf+ODBTqq/2dHJiSynpykgPXfrsVSermX0hluSUpxIHq+Mwr+oEQu4eXKZi7PPYjt3qKxubMtWlRp2CmO91vQAvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741099527; c=relaxed/simple;
	bh=jKdpkROggTpGv8i7lEqCeoDnoMhE9yvTEkBnneKoX/o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PHB0YKCmNT8lejiLUuvbJ2FE36BhDBogg3+v7g7quW6iCcRzv3Kkh7qrLpAdCzhQAkj2P+xBbeiSSSlp7LjPTwKnrNbu3Dl8YCLluThnmU79YVNFu9lfrrmFJiJuGWeo46zUSnPnzrw7mMH3SOvlKwvcczQ24zLyqm0egGQJszM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=rdj8m4rS; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-30795988ebeso61764321fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 06:45:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1741099522; x=1741704322; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TETrHFzeOASenqMV9S9QwkBZdWbDaJ44vy3Vca6/dVU=;
        b=rdj8m4rSLSJKTDoGbzAdjQsZ3OS+JQmMqW3laXfGaj2lRh17o2j0JK/1P/RPvSYPj+
         54VONGuvrWWINZs68Wh3cW4v2/kcYyiW4XxRny9pL3T+ngO/SYK1dTrWE+hRmd8TCW2a
         Usuwt4U+GghZqCUoRxcNb2iqwq6dTMZP3cc7Tx/ymm5ctquH467NBFazrR9E74AjNTOD
         dowkJOSNFAR9OOThiCmAmNF5Jdjht0qtuCx9VsrH9n5HpOc1LAxgB4p8IG4yXRRBIHq9
         MnKm8oC6X1HK5HFIKWVQ9HihrVHHmYoVjN4AohwahRuqkSeaJKWLl4UZdlr/Vk+Nw20t
         +Hgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741099522; x=1741704322;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TETrHFzeOASenqMV9S9QwkBZdWbDaJ44vy3Vca6/dVU=;
        b=wbUnaQMxmL8Mx1j6l68pb+1WFrzvzHoG5iQIbljLDLOBAj0PTqu86/RTy9chSIxsxk
         TDafpSc3Ld8jz/eZtCY68PGhKU8iyMRZotNyEAiUJfVu5tE4nPZiP01NDsFCZ1ES7n16
         RldFtQ2JQAB+3LXUuAlQm+5NF4POPkn5uiW2tOd8bgl/4efqOgjNqVbO6WjQGMPnJEbC
         i38nuWDwczFqg3Rri9M1WbuxQkdWVUNGHIlrxU8MaS9uCuKZbI0/ef9TgZW5dUAKzdNY
         nC3f7mrUSD/P8SrPet1Xu5j59/NNLYJj5G0ilUc7He+FmkBLbSzYw3Tnc69K00gQI+6x
         N7Rg==
X-Forwarded-Encrypted: i=1; AJvYcCX31uwBFunVhdArXKxw6CJl+oRzAGTQ5G0PBhXxOPathkirb5Y1zjRForat+9B/S+2kREDu/QD9NsYmh/4=@vger.kernel.org
X-Gm-Message-State: AOJu0YycEnP1VZ4Tuj3rrpmUZUWaup8r6l9uonoK7P77m6KZgaHy3GI3
	ZNIzY24nRNJzYUKXvtyhbrze75xD8P9zNs/HOtZr6SKGixjSpmSa3uCBBd1JcajAqF8YUfz4lT1
	2XCxs8JM0lmSs+jSS22MI1PCNNUP0Dozh/yS00w==
X-Gm-Gg: ASbGncsEIKu3jJPu02bp9InTm6FUoD8DaJuMOTkPzvglRp512hUIdok6LLB1/gaIwPJ
	y1DDS3TFApCRYjyV7gMPHCa5UOcL6NynG9cPld6WhRYgve1beJ9DG9qOjiILmA6+ITr+dgnotb5
	ed9w1CVHB84c2DWLyZKdoYLn3n0g==
X-Google-Smtp-Source: AGHT+IETKuyPMVM5CdYgZm14hIMgbe8X/D5820Fs21Iu8QTNB9GUGUO3MUy3gVkpuL3W82B4uH6iGXTKzY4qdWaX2WU=
X-Received: by 2002:a2e:91c3:0:b0:30b:9813:b00c with SMTP id
 38308e7fff4ca-30b9813b714mr64990571fa.27.1741099521825; Tue, 04 Mar 2025
 06:45:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250304-wip-bl-spi-offload-ad7380-v2-0-0fef61f2650a@baylibre.com>
 <20250304-wip-bl-spi-offload-ad7380-v2-2-0fef61f2650a@baylibre.com>
In-Reply-To: <20250304-wip-bl-spi-offload-ad7380-v2-2-0fef61f2650a@baylibre.com>
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 4 Mar 2025 15:45:10 +0100
X-Gm-Features: AQ5f1JpGYBLGOoxbrmddIe3_7MKUmgER6V4l4XNFfg4pNtoeYf3XgHXjFSF6e-E
Message-ID: <CAMknhBFfjo_bWZ7=9LD10y02WTVanCYhQpMNk834k8P3iQ_uFw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] docs: iio: ad7380: add SPI offload support
To: Angelo Dureghello <adureghello@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Jonathan Corbet <corbet@lwn.net>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 4, 2025 at 10:39=E2=80=AFAM Angelo Dureghello
<adureghello@baylibre.com> wrote:
>
> Document SPI offload support for the ad7380 driver.
>
> Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> ---
>  Documentation/iio/ad7380.rst | 54 +++++++++++++++++++++++++++++++++++---=
------
>  1 file changed, 43 insertions(+), 11 deletions(-)
>
> diff --git a/Documentation/iio/ad7380.rst b/Documentation/iio/ad7380.rst
> index cff688bcc2d9601a9faf42d5e9c217486639ca66..e593ab6037b0da4cebfad1483=
13f21cca7f00fd4 100644
> --- a/Documentation/iio/ad7380.rst
> +++ b/Documentation/iio/ad7380.rst
> @@ -142,21 +142,21 @@ Example for AD7386/7/8 (2 channels parts):
>  .. code-block::
>
>            IIO   | AD7386/7/8
> -                |         +----------------------------
> -                |         |     _____        ______
> -                |         |    |     |      |      |
> +                |         +----------------------------
> +                |         |     _____        ______
> +                |         |    |     |      |      |
>         voltage0 | AinA0 --|--->|     |      |      |
> -                |         |    | mux |----->| ADCA |---
> +                |         |    | mux |----->| ADCA |---
>         voltage2 | AinA1 --|--->|     |      |      |
> -                |         |    |_____|      |_____ |
> -                |         |     _____        ______
> -                |         |    |     |      |      |
> +                |         |    |_____|      |_____ |
> +                |         |     _____        ______
> +                |         |    |     |      |      |
>         voltage1 | AinB0 --|--->|     |      |      |
> -                |         |    | mux |----->| ADCB |---
> +                |         |    | mux |----->| ADCB |---
>         voltage3 | AinB1 --|--->|     |      |      |
> -                |         |    |_____|      |______|
> -                |         |
> -                |         +----------------------------
> +                |         |    |_____|      |______|
> +                |         |
> +                |         +----------------------------
>

It looks like this is just cleaning up whitespace, so should be in a
separate patch.

>
>  When enabling sequencer mode, the effective sampling rate is divided by =
two.
> @@ -169,6 +169,38 @@ gain is selectable from device tree using the ``adi,=
gain-milli`` property.
>  Refer to the typical connection diagrams section of the datasheet for pi=
n
>  wiring.
>
> +
> +SPI offload support
> +-------------------
> +
> +To be able to achieve the maximum sample rate, the driver can be used wi=
th the
> +`AXI SPI Engine`_ to provide SPI offload support.
> +
> +.. _AXI SPI Engine: http://analogdevicesinc.github.io/hdl/projects/ad738=
x_fmc/index.html
> +
> +When SPI offload is being used, some attributes will be different.
> +
> +* ``in_voltage-voltage_sampling_frequency`` attribute is added for setti=
ng the
> +  sample rate.
> +* ``in_voltage-voltage_sampling_frequency_available`` attribute is added=
 for
> +  querying the max sample rate.
> +* ``timestamp`` channel is removed.
> +* Buffer data format may be different compared to when offload is not us=
ed,
> +  e.g. the ``buffer0/in_voltage0-voltage1_type`` and the
> +  ``buffer0/in_voltage2-voltage3_type`` attributes.
> +
> +.. seealso:: `SPI offload support`_

This is referring to the same section, so doesn't make sense here.

> +
> +Effective sample rate for buffered reads
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +Using SPI offload, the PWM generator drives the starting of the conversi=
on by
> +executing the pre-recorded SPI transfer at each PWM cycle, asserting CS =
and
> +reading the previous available sample values for all channels.
> +Default sample rate is set to a quite low frequency, to allow oversampli=
ng x32,
> +user is then reponsible to adjust ``in_voltage-voltage_sampling_frequenc=
y`` for

s/reponsible/responsible/

> +the specific case.

Another important thing to mention here is that for single-ended chips
where we have 2 banks of simultaneous inputs, if at least one channel
from each bank is enabled in a buffered read, the effective sample
rate will be 1/2 of what ``in_voltage-voltage_sampling_frequency``
says because a separate conversion needs to be done for each bank.

> +
>  Unimplemented features
>  ----------------------
>
>
> --
> 2.48.1
>

