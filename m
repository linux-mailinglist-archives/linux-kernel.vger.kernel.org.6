Return-Path: <linux-kernel+bounces-217439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EB1990AF9C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 15:39:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BEC41C217E4
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 13:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A25B419AD5B;
	Mon, 17 Jun 2024 13:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="E+gpl1EW"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF0F219AD58
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 13:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718630561; cv=none; b=eeN20VeD8ci+llWtipKdWTsVxIDtB/dBtJ7sCHO658da9/yKqIIGdQxkTUGu3w25CuZvm+bXFfK1iVGVTsHP6K2WKRE2gC7TEp3jlpCN7PMAJVoJ1TV5vVVBdiHYi/XJKJhfwn5OOsqaib2wBwhnWeapFHuykKh1uxl+ISR2ds4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718630561; c=relaxed/simple;
	bh=x2/TWbf4pMW/7B3jUbR49NyBzVBSJJKoqAkbb4uuZqs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TPkM2OHCYhecj06L56cqZPBHYoOcoszrJEqziN+d3q/xCrU+LwIiEZ9qC5++CDTd+WPT3oZ1XEQZTV4Co5SFA0A8hIqjwhtaxvAjg5ChPekpbM3be0CqrjFziQnaeHgbeX6b/Dv2Li6GiY6e9n56K99kuhQkTpdYJTsVljBKsLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=E+gpl1EW; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2ebeefb9a7fso59260401fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 06:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1718630555; x=1719235355; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2ZbiqmECcZY8mamkHFgAOvFj2yp3N5y/XiTKfM4Svdg=;
        b=E+gpl1EWGFhN9DRUzAdWNdoTkmKLT9eYD5xha9LrD87RAmtXDphi+hqmeciGHNR8gM
         EUrsPaMxIrklw2gNLQ4WaC1+MYwwb+ZXHWs6TLUynFZzUjRV3P8wL2yUX0MlbkKhWMFG
         MEnmnij/3KpPImi85WHJXNgBsnaeNgzr4CTEdMCWU2lm/lPMrlvAbRcUk47lalloAaCh
         b3gpn+zrfHPsvKwpbz/Ovllpz08Owyx5xWGXfGk/p/IWjsN97lmRa2L4qAR1QbadbYgX
         /YGUD5f9iMKNEWi78irsYe23lIs+0iACmwl6UC2b5AUt175uqeBgCPJJ9HLs6CRM5P0G
         mKBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718630555; x=1719235355;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2ZbiqmECcZY8mamkHFgAOvFj2yp3N5y/XiTKfM4Svdg=;
        b=ROFOmC4RIbchJ2XFCdmmMD5uF4BL/yB+HP/MIhj2Ibfj56MzbbU3K1mHzsr1noO6di
         2DslXwQlp0NWLYaAqKNjAMWNM3re79Wx8Fz0FfAgTJwsR3CH/XQXIxo5yAtRDIYt1qjV
         5RaCEPMgV/bDZWYGmyQtGwqOFZodxWx2OOU57sLtZhuivnBG3aO7svVPlRIDouFqmXJ/
         aLvmWSs8GPfkWOvvkmTBekMNtg+/ythnpE0+87HR9omGID5hl7IHkbXcSzuUG3CMf/vg
         kkT00Gbsgkm4k3WnN4Kz5dn4iAozErs77rjg9ObhgV16Yhg2wxMg7baYixjaNXniu7BV
         pRZQ==
X-Forwarded-Encrypted: i=1; AJvYcCWfuSVBzgVvOuRJuo4SFlDDiAymn/jwAr0DncjgLwYbo62E6DfuHE68YmsrVPtazhVM3pjJ0fOvGpkKRU5mq894OI6q+JEIXEk5TVNt
X-Gm-Message-State: AOJu0YwqvXHQkqhgo1USPmOkvjjeypUOuLyW5Sy2TmfY7Z/vCWlsK408
	u1OgnuIrLANL7y3/NwIxRGdhzuYkgnTgsL3J2rGedyHKe7Sg1l3eyIycUFP3YMFLi4Beln3Ciyn
	d57cVZ/NoBMbpGW7XsK5gQT/qx6svhQKkc71UJw==
X-Google-Smtp-Source: AGHT+IFTPp5MCmbl5JG32vigsgybvL3dycGFvRHZv60p5LHQHldYQWcRVTiphDUMaheGmt7QEUHyx14Mo+lEkfgLk3w=
X-Received: by 2002:a2e:9a8b:0:b0:2ec:c8:2755 with SMTP id 38308e7fff4ca-2ec0e5d085amr58381091fa.24.1718630554747;
 Mon, 17 Jun 2024 06:22:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240612-iio-adc-ref-supply-refactor-v2-0-fa622e7354e9@baylibre.com>
 <20240612-iio-adc-ref-supply-refactor-v2-1-fa622e7354e9@baylibre.com>
 <20240615130858.22043725@jic23-huawei> <dbf947a3-3d3b-4686-a707-a813b6a4ce5a@gmail.com>
In-Reply-To: <dbf947a3-3d3b-4686-a707-a813b6a4ce5a@gmail.com>
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 17 Jun 2024 08:22:23 -0500
Message-ID: <CAMknhBFJ01Xu69Arvd3S=dbADGFmzaYKm2XBtw_CtnjtYwnnew@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] iio: adc: ad7192: use devm_regulator_get_enable_read_voltage
To: Alisa-Dariana Roman <alisadariana@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Marcelo Schmitt <marcelo.schmitt1@gmail.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Mark Brown <broonie@kernel.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 17, 2024 at 4:35=E2=80=AFAM Alisa-Dariana Roman
<alisadariana@gmail.com> wrote:
>
> On 15.06.2024 15:08, Jonathan Cameron wrote:
> > On Wed, 12 Jun 2024 16:03:05 -0500
> > David Lechner <dlechner@baylibre.com> wrote:
> >
> >> This makes use of the new devm_regulator_get_enable_read_voltage()
> >> function to reduce boilerplate code.
> >>
> >> Error messages have changed slightly since there are now fewer places
> >> where we print an error. The rest of the logic of selecting which
> >> supply to use as the reference voltage remains the same.
> >>
> >> Also 1000 is replaced by MILLI in a few places for consistency.
> >>
> >> Signed-off-by: David Lechner <dlechner@baylibre.com>
> >
> > Complicated bit of code, but seems correct.
> > However, it crossed with Alisa-Dariana switching adding a
> > struct device *dev =3D &spi->dev to probe() that I picked up earlier
> > today.
> >
> > I could unwind that but given Alisa-Dariana has a number of
> > other patches on this driver in flight, I'd like the two of you
> > to work out the best resolution between you.  Maybe easiest option
> > is that Alisa-Dariana sends this a first patch of the next
> > series I should pick up.
> >
> > Thanks,
> >
> > Jonathan
> I will add this patch to my series and send it shortly.
>
> Kind regards,
> Alisa-Dariana Roman.

Great, thanks!

