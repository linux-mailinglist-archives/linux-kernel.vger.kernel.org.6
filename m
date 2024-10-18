Return-Path: <linux-kernel+bounces-371658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AFA669A3DF9
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 14:15:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 704E7282D3A
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 12:15:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D0224207A;
	Fri, 18 Oct 2024 12:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G2uIDxnQ"
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FD9842077;
	Fri, 18 Oct 2024 12:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729253743; cv=none; b=sBbt9WdzG05R2/cpEKUulcw2wJUmuYeLEndolft38oyHxdY5GDmrQJA+uYKPaxA12WLueD4dSXj9XbyeLxihz1OLznO9KOxzyyG/jm8sf3aj8F+vXaWNjcYbrmDFil8b+0fPZfDa6lN+PD31oOcuUo4VNHfh5pjQPGIgQMAPk18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729253743; c=relaxed/simple;
	bh=IE5eND4JS389Mg64lkLSdqShAg+vwI2qRCJ1rs2mbGU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RhNJFiBkcMrrf+AArJSfMg214tb4SXkzQpNsllA3nHVE3ygYrkZIHq66fXE/ETc0jyYAbtnlzQmNI3ZMNCaqC8JqIbXEpduT9k4N5Deb9bt/MPEzJ5s9Z1bF58JKY96YAEpoKzeCZmYwnX6imbsvExllXxvKiI1kIXYWL3l9uhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G2uIDxnQ; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4608da1bea5so13069421cf.1;
        Fri, 18 Oct 2024 05:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729253741; x=1729858541; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=20pjU3e//rgq26Yi05Ys1N4I2o5U5qD7ybOOR7293q4=;
        b=G2uIDxnQpuBwUgWhgo8zozCqGk9kiKfHCRgd2rwA9t0AdTqJe0I+14JCkCTBhtqZ0H
         osORUaYfQrUe5jsVQQ4tnX9D9l1Bf09hC8H+K9EWglrUuiUbAec+YxeHaqdKxKO4IRho
         X0yV9M5fkylaa3MQ0OahdeB66W/EVgAOrYBRbyWax0w0moDZTqMWahBj3cIU2Ngt8zvb
         tjvqMox/t/HoVEgI+a+v4x4/Tepnmr3QYAj3o0r7y8txOX3g21458MUhJhVPdvbAMR4c
         Vi0BONgpmcck8n1+wflhJYcxfCbc6/pI1p6XZgJ37I3yVzOhFwSP63JLuHgFh96kdQen
         V5GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729253741; x=1729858541;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=20pjU3e//rgq26Yi05Ys1N4I2o5U5qD7ybOOR7293q4=;
        b=O/mix2MH3tzsSM9xnilPj9hXrMdCHMu8PcV9koReyvOPyZSdivgyS89YOC3TdsSBbq
         j0bkZp9G6KsRJ35YHkEIMw9VvVsuO9Hijf88CGevkYxp/0/NqUOGPzpL+QAxrB+Ea826
         pYG3dZuPqEHNqbpxI4XrUBPU+dwgfJkcNm2q2QZ9hePe8jjhKyIJ6VQSKYgyvINvIbpr
         9QwEdcrhBOcv8fNMz5PprRJIboA+OLm3xdskf027mnIQLxEZbuY9QSj8srgYSbjWlozq
         /DCvo8gjA7zB8zM98YCfPqwmn5XWtp2zFLWqrhxzWFmbw0WU9Kb7CwK6HDvb6ugO43It
         rsOQ==
X-Forwarded-Encrypted: i=1; AJvYcCUJFEduUYIoYDzfkgXErp9oYkz9FZcsnD4XYUFRLXh1monzyh6qD6RGjJwmdtfDxl+cz9ecKrJFdFdCSmE=@vger.kernel.org, AJvYcCWPrTaqfdwfFJSa9kurEbHn4VdIl2zhQ1KUYBDfey+HJtH01i39jFda5tcDsir/WqJd85i9WNAEpYde3vF7@vger.kernel.org, AJvYcCXboH3wgffKNN4B53gqI4FWGZC6boNHZxlXwp0ZC11TedtYapEjFaiogqNHfp/hUTrv/6KHGQdjDRUE@vger.kernel.org
X-Gm-Message-State: AOJu0YwlDw/dOwsc8bBoyx1R2AeSk+XG+HFp0LPIZMLnC6CE1tnAEHsC
	XMuq0ogNIFR5zLbxtQc1qhukFG8cOBwzoamS9scr9cYk4g3mVvbJVuNyuMsXRx5TXSIusR4NVKw
	pAPxQAPNk8BYkRY/mHoHP7xkQqZc=
X-Google-Smtp-Source: AGHT+IHznlnIPkcD1o9NThG4Pn7268Gn9GiD6LokW8b2HqLdTDhxkp1K0M7XBv6+w0jbPY3BaPJt8cM+9Prcjg21UIk=
X-Received: by 2002:ac8:5a01:0:b0:45f:bca0:b8d2 with SMTP id
 d75a77b69052e-460aed53cfemr26349851cf.20.1729253741145; Fri, 18 Oct 2024
 05:15:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241016-cs42l84-v1-0-8d7e9d437d2d@gmail.com> <20241016-cs42l84-v1-2-8d7e9d437d2d@gmail.com>
 <abe88a18-28fb-40e5-8bd2-3fde5de9cb56@sirena.org.uk>
In-Reply-To: <abe88a18-28fb-40e5-8bd2-3fde5de9cb56@sirena.org.uk>
From: James Calligeros <jcalligeros99@gmail.com>
Date: Fri, 18 Oct 2024 22:15:29 +1000
Message-ID: <CAHgNfTwGM8tEsp5SfYp2XmqN2qC557kGyuDwCJfcoxpc7wGSOQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] ASoC: cs42l84: Add new codec driver
To: Mark Brown <broonie@kernel.org>
Cc: =?UTF-8?Q?Martin_Povi=C5=A1er?= <povik+lin@cutebit.org>, 
	David Rhodes <david.rhodes@cirrus.com>, Richard Fitzgerald <rf@opensource.cirrus.com>, 
	Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, asahi@lists.linux.dev, 
	linux-sound@vger.kernel.org, patches@opensource.cirrus.com, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Hector Martin <marcan@marcan.st>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Mark,

On Wed, Oct 16, 2024 at 10:23=E2=80=AFPM Mark Brown <broonie@kernel.org> wr=
ote:
> > +static const struct regmap_config cs42l84_regmap =3D {
> > +     .reg_bits =3D 16,
> > +     .val_bits =3D 8,
> > +
> > +     .volatile_reg =3D cs42l84_volatile_register,
> > +
> > +     .max_register =3D 0xffff,
>
> Does that register actually exist?

It is likely that the highest register is the ID register, which would matc=
h
CS42L42. Setting that here does not break anything.

> > +static int cs42l84_mute_stream(struct snd_soc_dai *dai, int mute, int =
stream)
> > +{
> > +     struct snd_soc_component *component =3D dai->component;
> > +     struct cs42l84_private *cs42l84 =3D snd_soc_component_get_drvdata=
(component);
> > +     unsigned int regval;
> > +     int ret;
>
> > +                             ret =3D regmap_read_poll_timeout(cs42l84-=
>regmap,
> > +                                                            CS42L84_PL=
L_LOCK_STATUS,
> > +                                                            regval,
> > +                                                            (regval & =
CS42L84_PLL_LOCK_STATUS_LOCKED),
> > +                                                            CS42L84_PL=
L_LOCK_POLL_US,
> > +                                                            CS42L84_PL=
L_LOCK_TIMEOUT_US);
> > +                             if (ret < 0)
> > +                                     dev_warn(component->dev, "PLL fai=
led to lock: %d\n", ret);
>
> This is too heavyweight for a mute operation, do you really need one?

Unfortunately it seems that way. This was carried over directly from CS42L4=
2,
and as the comment in the function states, the internal power supply
will discharge
itself and crash the chip if the PLL is set up before any of the interfaces
are fully enabled. This is corroborrated by the CS42L42 datasheet. I've spe=
nt
some time today trying to work around this, but trying to sequence and enab=
le
the PLL anywhere more sensible either causes the chip to crash or causes
audible clock jitter artefacts.

Regards,
James

