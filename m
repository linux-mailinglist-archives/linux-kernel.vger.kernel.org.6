Return-Path: <linux-kernel+bounces-321373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 622BD9719C6
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 14:47:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BDA32859A6
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 12:46:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47E361B78FA;
	Mon,  9 Sep 2024 12:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i2C522qs"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E721ACDE6
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 12:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725886014; cv=none; b=F2Px4xfGt0gKh8perXfc3tKg10CkQ81X/USblRSiNaLlUWz0GODaXyLeJXE8I97VoU2SzpOrLKXwzm+yzKjNPYYm5RM1eykfZ1zbw9jfglSRZpHTz20Zi49UbpMWI4atLpoIQcmLvS4EdqlI/VfU7xLmw+HwDmJWWLAWdhlD68Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725886014; c=relaxed/simple;
	bh=1f+Jy8+dVYC2WkECYMR5IblI/bGZHGPa2Hb8JbpM7+g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n8qVxZ3aLg7k+tjFc7muPBG8s8teDjI5c7SRAHhkI+9m+xyVW+oBWX3u2WSFACDMrWIzXUlvWgbdNWkm9RVu3Fpr/32ARoqH8CM2dzjVgGxtX8ISm9uS1svwihYMu+77/Oc+CE0YuTw+3yxmvUo+2b0doEsO+Jm7wxDDj2S2cAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i2C522qs; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2daaa9706a9so3300700a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2024 05:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725886012; x=1726490812; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CmsSXtXoT0LjaKLXoUsKwFJIQHJ/ks4Ou/9C9lMCcY0=;
        b=i2C522qsv/o7YW7Rw6AeHLLEZ1uvpqPW+MX8w1BVzloaRUX3218fW84qst9Yi+gXTv
         5DxyKDMSfyGjnAwHQRhGs9E/1pCHZLVUekAu4UH8bkfTPlFWlLSHps3gYZu50q0b7N7o
         VW91Xoo8OT3TYB/RYKTe5tHQjTSoBGlP1vt8QSE4kDI4Vu5jv+kSnkk8rkBPk/lM65Q3
         QyVjx8bhEe1M53kFWbPmyhDrfKWsCT5dV7tlNLsDyHWxd7dCZCQBYphc890vR8UY+OcA
         dH/nPShZfqYSAsu/RZMxJ+/Qfp35k54qaOfoL381fhOIyZc/AkbPxUMp9igs2aCYmKKc
         Nj4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725886012; x=1726490812;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CmsSXtXoT0LjaKLXoUsKwFJIQHJ/ks4Ou/9C9lMCcY0=;
        b=pGzfXVVjHAJAP4IoF4rE74LEdDqqOI2yB5Th/I4H6Kkc7c8vXmbFB0tyLEWnGRrqTm
         CCxGaA1wwG2KbfqrfwU0xULnr/OYbTpO+KIgGkL1/XtMH7EhqlT04UMdFENZUpb98LhI
         Ix3+yFnfK4TulsIqH5G/u/om0wx0aJctG78Ax8iCjYkZWZEpldP2opP7GISv+rjoUNIA
         2enpxskSAciBmy1urwI2RdbJq4zQ+T7zS7yFP2x/V0krTqh5zi19J5a3rVT5acap2uGP
         W7laHtnjqO25aqMdRyHJ2T6LUSdJbp2Eb+CPaDGjPISSwXpQk+HcgaHOheVDInAPPRyN
         2gVg==
X-Forwarded-Encrypted: i=1; AJvYcCXyTHTeb4c8gGENifZqv+zWiUd8M6pGE6ey9yB7GIG3DVC7KwuCJXsw+CS5bQ8po4rLxt9/4N4NKkwLkto=@vger.kernel.org
X-Gm-Message-State: AOJu0YyX+CL6qv7kG7/NCJp5mlcyXzktNCJBwS0DZ74Xrwt3j5B9LvOh
	PgA+fh3SS7jAoZiFTcutaPiMrVZvFPz4lYdAbzx4HBTuucnw/4c1woh1g+uFVFZN4LNZ41QtNl+
	o53t71O62p+mafhC9cOcUZm9kipE=
X-Google-Smtp-Source: AGHT+IEnYPHu+DclcXKCQRMpkx1L5NfLXxIStiOuqt20xBcgi2mEQBkdbBME1/YQ3ICjAFgL7tzuyJS3kLgZXx9qWks=
X-Received: by 2002:a17:90b:32c9:b0:2d8:840b:9654 with SMTP id
 98e67ed59e1d1-2dad511829amr9609405a91.34.1725886012395; Mon, 09 Sep 2024
 05:46:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240904233100.114611-1-aford173@gmail.com> <20240904233100.114611-5-aford173@gmail.com>
 <ZtpMPCHBnEgtkBWp@atmark-techno.com> <CAHCN7xLo1RgkUPTdTpCtKjnT7w=gPDCfe_ZEbKj0joVvLG02Dw@mail.gmail.com>
 <ada922ea-b307-4ccf-9e2d-9a2a08fb97c1@fris.de> <Ztvbd4XqY95YMAZd@atmark-techno.com>
In-Reply-To: <Ztvbd4XqY95YMAZd@atmark-techno.com>
From: Adam Ford <aford173@gmail.com>
Date: Mon, 9 Sep 2024 07:46:41 -0500
Message-ID: <CAHCN7xLvFkcFhE51fGXumoin4FWON2ZQ7duXJX40kkqK_ugXgw@mail.gmail.com>
Subject: Re: [PATCH V6 4/5] phy: freescale: fsl-samsung-hdmi: Use closest divider
To: Dominique Martinet <dominique.martinet@atmark-techno.com>
Cc: Frieder Schrempf <frieder@fris.de>, linux-phy@lists.infradead.org, linux-imx@nxp.com, 
	festevam@gmail.com, frieder.schrempf@kontron.de, aford@beaconembedded.com, 
	Sandor.yu@nxp.com, Vinod Koul <vkoul@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Marco Felsch <m.felsch@pengutronix.de>, 
	Lucas Stach <l.stach@pengutronix.de>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 6, 2024 at 11:50=E2=80=AFPM Dominique Martinet
<dominique.martinet@atmark-techno.com> wrote:
>
> Frieder Schrempf wrote on Fri, Sep 06, 2024 at 10:28:59PM +0200:
> > I think I managed to get behind the calculation of the fractional-n div=
ider
> > parameters. I came up with a spreadsheet to calculate the output freque=
ncy
> > from existing register values and I have a crude Python script that can=
 be
> > used to search for parameters for a given pixel clock.
> >
> > I tested this with three different non-CEA-861 pixel clock values (supp=
orted
> > by my HDMI USB grabber) for which the integer PLL yielded deviations >0=
.5%.
> > With the new LUT entries those modes work now.
> >
> > I will clean things up a bit and then share what I have. I hope that th=
is
> > allows anyone to calculate parameters for their non-standard displays i=
f
> > required.
> >
> > If someone feels extra motivated they could try to calculate the fracti=
onal
> > parameters at runtime. However I'm not sure that this is feasible. The
> > numerical computation of a large number of parameters is quite heavy an=
d
> > it's probably not easy to strip the algorithm down to something that ca=
n be
> > run on the target without too much overhead.
>
> I think keeping the LUT is perfectly fine if we know where the values
> come from - perhaps having your python program in a comment above the
> LUT so anyone can check the values match?
>
> My main problem with the LUT is just that -- there's no way of
> checking. If the values come from somewhere sensible and can be verified
> I think it makes sense to keep it to fill the holes where the integer
> divider isn't enough.
>
> > > This way, the calling function can determine if it needs to be
> > > multiplied by 5.  I haven't fully determined how the fractional
> > > calculator determines what frequency it wants for a target frequency,
> > > and using the values for P, M and S from the fractional divider
> > > doesn't seem to always yield 5x like they did for the table entries
> > > using the integer divider.
> >
> > For what I found out the factor of 5 always applies. For the integer pa=
rt
> > and also for the fractional part.
>
> In that case I'm definitely in favor of moving it inside the function as
> part of the calculation

I'll do a V7 with the 5x factor moved into the integer calculator.
I'll also try to rearrange the flow a bit as you requested.  Depending
on how much changes, I may strip off any s-o-b notes.
I was traveling over the weekend and I'm likely traveling the next
weekends, so I will try to get to it this week before I go, but I
can't promise anything quickly.

adam

>
> Thank you both!
> --
> Dominique

