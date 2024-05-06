Return-Path: <linux-kernel+bounces-170040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 385678BD0FC
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 17:04:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 691921C219C6
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 15:04:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDF6613CFA5;
	Mon,  6 May 2024 15:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="av4sU+M2"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C6291534E5
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 15:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715007865; cv=none; b=PjhZ+EZeuOe43S0L7C5DbHAfmPPnVZ5N87GxpNzcZoQBBTtN03dF5GkaNgbkENt0hS3VNf5DOaQ1xKzQQk8KGbL8+MJz9AKSaLhDQ/vTlarkmLjpsWVPJsacOO0lFIWTO5nZHd/L5fC0MvnOKO2co++ExZJ6/Qa6IbPJcKF0LuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715007865; c=relaxed/simple;
	bh=43qt58Cc+4V7oWJGTmVtsNFw1630vbmzXiVtgfxHZ9s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UtIXzb6glH1u/7kAtFDWZnCcD80oMnTDdlMyRt6FzMljkiXApxOWDnaH+fKbeGaWw5uLZ1FQ6x+z3wRCurU0As8/Kpd/LBTMVw5T/U7QCGW/SbV+49KaflH6DXuwtT0jV1VBHa7ZHdhhPQYyupP9iDD8DVkMzrIrOhM+f9IAFcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=av4sU+M2; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2e1fa2ff499so35215021fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2024 08:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1715007861; x=1715612661; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BFec+QhZVtPI2j0gseBfhUAnbpkhg51VBLT9XPfNp7Y=;
        b=av4sU+M2cwLP1+ctSZeFcJ24IEbNCcZhTbr6ujAlMcrSLsr8WSpVSIU+5jnpZE0ziD
         e7Lkpsg2qMHkfKZYQ1dsCfgLEJw4K0i2qU6rJiCjT27S9aBuKT599LKQaVgcaWhtyEIL
         bIHXCkfSPao2fLQ95+2LNfB9loFxEjf8teduUxcsVzIPxRhMOChJnXJHXb3W9AsQH6fy
         LgQvSoGnAcFSSqv/jkdBPKzpZFhP8otH+yDK/KHAHveFgRWHoaDKYMtU41sJA1rTTxVm
         fKnBbh43TVl0zG/GjFppT8JlRkfEnkjpn6p+Do+dyCORsLjmca9actAmQX6zcKzVs6Me
         nqMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715007861; x=1715612661;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BFec+QhZVtPI2j0gseBfhUAnbpkhg51VBLT9XPfNp7Y=;
        b=mO9YNm64WNpy+BFIjuLoYEao1C3S5xW0R+4pPDsA3ZGM6YQ9ygEHSj3GpQPmZ7wBBk
         npWayhm/W9u3XOwJW13QsvQju303uloTvMOeNOQ76eh9C0xvHOa/ioqzn5wqgjmKyCQB
         nTLFnSzyuh2rvN2B9RvtvVoAqIsEBibvxYaYCIEIknWATl9JGVyWOYiEo5suYWFaGiGW
         wqSsKAtl0fu3Ve1SlrolBQn6K2cwv9WcSUdkTDY8nCycl3q578iV2YiEXsTTQJ4V6rVK
         /PdpEU13DszYfhEIzwxmiqehex+E9vJ7QOqO2tlbyMhuqHli1jaagXMh0Otr5d/LS89J
         sP7Q==
X-Forwarded-Encrypted: i=1; AJvYcCX7/NlfvTjDG5krEM4e16wf6WYO+1sMtsrgVceLqQsvDhLiyY40ghvlDd3BKfa9mHYG2pmmRw2oO7sg7y9Zdi/mCWd6T9srcqJgNWH1
X-Gm-Message-State: AOJu0YwsZoUQljMNS2v5BO8TvH0kWX8JpSJ21l7DPDJCkqXgvkD+N1TJ
	3z8/yCPlDPojXAd3WlSL2L47I3b/1mVVYAqdTstE8DQg5uqfChXCCRb00holKtB61bmh420kx8O
	okvggZpdAog4D89t+vDtFLuTv0On1ucarnWJzYA==
X-Google-Smtp-Source: AGHT+IE0vUSq8J6yKmSvaFFAdn6z7ifFbvsSoTCfxPZW/BeGP4Fa/21CucscczMKZdBQTPg58bCo90Wa29WlJdmyQeA=
X-Received: by 2002:a2e:9a8b:0:b0:2e3:331e:e33d with SMTP id
 p11-20020a2e9a8b000000b002e3331ee33dmr1247843lji.11.1715007861327; Mon, 06
 May 2024 08:04:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240501-adding-new-ad738x-driver-v6-0-3c0741154728@baylibre.com>
 <20240501-adding-new-ad738x-driver-v6-9-3c0741154728@baylibre.com> <20240506151725.10cf025e@jic23-huawei>
In-Reply-To: <20240506151725.10cf025e@jic23-huawei>
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 6 May 2024 10:04:10 -0500
Message-ID: <CAMknhBFx-KVPRbm1xmKeU8ZaA7qt_c0_6eiUT-5kqTWVAvf3hw@mail.gmail.com>
Subject: Re: [PATCH RFC v6 09/10] iio: adc: ad7380: add support for rolling
 average oversampling mode
To: Jonathan Cameron <jic23@kernel.org>
Cc: Julien Stephan <jstephan@baylibre.com>, Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, kernel test robot <lkp@intel.com>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 6, 2024 at 9:17=E2=80=AFAM Jonathan Cameron <jic23@kernel.org> =
wrote:
>
> On Wed, 01 May 2024 16:55:42 +0200
> Julien Stephan <jstephan@baylibre.com> wrote:
>
> > Adds support for rolling average oversampling mode.
> >
> > Rolling oversampling mode uses a first in, first out (FIFO) buffer of
> > the most recent samples in the averaging calculation, allowing the ADC
> > throughput rate and output data rate to stay the same, since we only ne=
ed
> > to take only one sample for each new conversion.
> >
> > The FIFO length is 8, thus the available oversampling ratios are 1, 2, =
4, 8
> > in this mode (vs 1,  2, 4, 8, 16, 32 for the normal average)
>
> Ah. I should have read on!
>
> >
> > In order to be able to change the averaging mode, this commit also adds
> > the new "oversampling_mode" and "oversampling_mode_available" custom
> > attributes along with the according documentation file in
> > Documentation/ABI/testing/sysfs-bus-iio-adc-ad7380 since no standard
> > attributes correspond to this use case.
>
> This comes to the comment I stuck in the previous patch.
>
> To most people this is not a form of oversampling because the data rate
> remains unchanged. It's a cheap low pass filter (boxcar) Google pointed m=
e at:
> https://dsp.stackexchange.com/questions/9966/what-is-the-cut-off-frequenc=
y-of-a-moving-average-filter
>
> in_voltage_low_pass_3db_frequency would be the most appropriate standard
> ABI for this if we do treat it as a low pass filter control.
>
> I'm not necessarily saying we don't want new ABI for this, but I would
> like to consider the pros and cons of just using the 3db frequency.
>
> So would that work for this part or am I missing something?
>

I like the idea. But from the link, it looks like the 3dB frequency
depends on the sampling frequency which is unknown (e.g. could come
from hrtimer trigger).

Would it be reasonable to calculate the 3db frequency at the max
sample rate that the chip allows and just use those numbers?

