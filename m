Return-Path: <linux-kernel+bounces-305594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 676D99630EF
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 21:28:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 140BB283F37
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 19:28:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C4A01AB53F;
	Wed, 28 Aug 2024 19:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eDptW1rs"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 597D41AAE0F
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 19:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724873294; cv=none; b=keuuaXY3LaMrOqhSErfEMqxKa/Sm3plMfu/4aFXOxR7t3NZEq/mG2qUNnIpHOXkGyh0wj9DehF6nkLhRy08vNJkchb0Fd4p2adGYPQrLXXBkXaSWmtyBL4O93MZvDDdZyVQTlhw+rILetAaVGM5HcrHtfnN4AiItAUEvIcxLbzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724873294; c=relaxed/simple;
	bh=EyNRH6XWNjg2/v2sLkr52LfkcKoXYBEdmOqPWRYy9nY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SGUwTzi8g/KeNQIHdBhSs6D+94SOHRETf2VpI59skjvJetUzDs/0csG7Fj+WqtO5Y9MX24jiPoDbFwz29g/g9VzOdAaNOLS2QQTuDjBdbj3ANS+yWTWARGiMyfNuH5DBc96/0dEhAh4mkgGcZ7wc+t4V01DLXm4CJcynVFLwk8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eDptW1rs; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-7c3ebba7fbbso5081684a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 12:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724873292; x=1725478092; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=41vNKmWV0Fmo4MXQhPV0ZKp536FxHqIvBGLbGjrcGLI=;
        b=eDptW1rsQfABKPJnrashg7HlnDMuJx3yPTcwuzRveCQwW2zybd13uigmkyxfcyJ2YM
         gZkIUdtcyRWJtL5yFPNCA3rz0tXfypoRAEES4lYGui/mYDccmH9IGWJnrqPSlOEvFITk
         uGRyoOVzOJMrSa9YAbbGunvqM/E9yaEwq6iVh0qyKRqisQOh71odnieJ0eQILsl1ZYmk
         CSUywQlW36JqLff2J7Yp+Srqt1lzU4SqBNY8gJKw6N8PROM7jdEjLnK1bldorf7znDOm
         vqkGI2upKFvRbrN+PEq0BXt23nwjO8S3Er+/RPBGNEW9NBapJkKp8ld9Wzhre7WD9E7T
         aYkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724873292; x=1725478092;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=41vNKmWV0Fmo4MXQhPV0ZKp536FxHqIvBGLbGjrcGLI=;
        b=L6XJt2cXHr7PQpPH1RRt6JwA/gHfEqGDbGpG3BHAubAko8knEJ/XBOq3rgCn3qsahj
         RSlScviaQU/ZzC3l5m+IehYHoabrXLdSz+aIZVtIqmGXCFrybSHhPb0KsCf+Gf31ufRa
         t/fEDJw1c+auvLgGAgXB4/I1yWTZeJ/JEheSUI/NhyCrnzoYtweQMMntATDjl5jz332R
         BN3/QQ/wQGdTqbCRdMPGBFkbNvLEbGnUwf7Z5yb/CmaLT3pBmoUqpplD4kJ+O541XBKZ
         mhD2YnHGr3wqvEy0YVt/o2xaUsw9Z9KqyUX0eEL+F9nJYFUsQxz7ZP47DmkybqugVgxp
         VIDQ==
X-Forwarded-Encrypted: i=1; AJvYcCXAPaTzhKtfQN6YAiGw7xgnlh9Bdc2AKUc/JAcDi/UntRSYaYfEOtUEOQy7nYNSe60xgSBeqTEMX9p5OxQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUNYiVovBkxhLHelKpDhgYbQgSZ51uED20vEOCi0RFLwDollKH
	VC0Uj2kqgdXTuewY7wJKP7e6j/1wpBNXidlGDB90PMy7siypG8qAfwIHw4nGmJmP00xe2QXsSQ8
	44FJDHbjBD0rbtA4WIoq7qu5JpIE=
X-Google-Smtp-Source: AGHT+IHGKQRrrJKAWjVfpmgtEEps4m/S1EaPYltuzkTd89UmilZ0DIs4APB42zq9VQmfA4Lnvo50dt6R8J5UrG5K0ow=
X-Received: by 2002:a17:90b:46d8:b0:2d3:b55e:5f2 with SMTP id
 98e67ed59e1d1-2d8561a24f8mr404633a91.14.1724873292293; Wed, 28 Aug 2024
 12:28:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240828024813.1353572-1-aford173@gmail.com> <20240828024813.1353572-2-aford173@gmail.com>
 <Zs7kJ6vCDbxVvxU1@atmark-techno.com> <CAHCN7xLX1FPQFFBsgfd4Msa+y=KNay9M9q1fu=P1uuKZLacS4g@mail.gmail.com>
In-Reply-To: <CAHCN7xLX1FPQFFBsgfd4Msa+y=KNay9M9q1fu=P1uuKZLacS4g@mail.gmail.com>
From: Adam Ford <aford173@gmail.com>
Date: Wed, 28 Aug 2024 14:28:00 -0500
Message-ID: <CAHCN7xJtw2JakEtvD31dCKvpanzu6Pxbc0S81rDurYbVp5g_aA@mail.gmail.com>
Subject: Re: [RFC 2/2] phy: freescale: fsl-samsung-hdmi: Support dynamic
 integer divider
To: Dominique Martinet <dominique.martinet@atmark-techno.com>
Cc: linux-phy@lists.infradead.org, linux-imx@nxp.com, festevam@gmail.com, 
	frieder.schrempf@kontron.de, aford@beaconembedded.com, 
	Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, 
	Marco Felsch <m.felsch@pengutronix.de>, Lucas Stach <l.stach@pengutronix.de>, 
	linux-kernel@vger.kernel.org, Makoto Sato <makoto.sato@atmark-techno.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 28, 2024 at 9:11=E2=80=AFAM Adam Ford <aford173@gmail.com> wrot=
e:
>
> On Wed, Aug 28, 2024 at 3:47=E2=80=AFAM Dominique Martinet
> <dominique.martinet@atmark-techno.com> wrote:
> >
> > Adam Ford wrote on Tue, Aug 27, 2024 at 09:48:02PM -0500:
> > > There is currently a look-up table for a variety of resolutions.
> > > Since the phy has the ability to dynamically calculate the values
> > > necessary to use the intger divider which should allow more
> > > resolutions without having to update the look-up-table.  If the
> > > integer calculator cannot get an exact frequency, it falls back
> > > to the look-up-table.  Because the LUT algorithm does some
> > > rounding, I did not remove integer entries from the LUT.
> >
> > Thank you!
> >
> > We're still running 5.10 so I backported the driver as of it's current
> > state first (that part works), unfortunately our 51.2MHz display does
> > not work with this.
> >
> > After phy_clk_round_rate() not round the pixel clock to the table value=
s
> > (otherwise we'd only get rounded values), and making phy_clk_set_rate()
> > pass the requested `rate` instead of using the next smaller cfg->pixclk=
,
> > the display no longer comes up.

It looks like I need to update phy_clk_round_rate to calculate the
integer clock value there as well and if it's not possible to reach
the desired value, fall back to the LUT.

I likely won't get that done today, but I'll try.

adam
>
> Do you want me to create a table entry for 51.2MHz?  I am pretty sure
> the integer engine can handle it.  I'll investigate what's calling
> phy_clk_round_rate to see if we can use the PMS calcualtor to avoid
> the look-up table.
>
>
> >
> > It comes up with the values obtained for 50.4MHz (next closest value),
> > which also has an exact match so uses the integer divider this patch
> > computes instead of the table values, but not with the 51.2MHz it
> > requests...
> > I'm afraid at this point I don't know how to debug that further without
> > getting a scope out (I don't know if the soc isn't generating something
> > correct or if the display actually doesn't like the frequency it
> > requests?! the later could be checked by plugging it in to another PC
> > that might support that frequency...), and that is going to take quite =
a
> > while...
> >
> > Hopefully Frieder will have more success with his displays?
> > It could also be very well due to some of the differences with our 5.10
> > tree, sorry about that.
> >
> > >  static int fsl_samsung_hdmi_phy_configure(struct fsl_samsung_hdmi_ph=
y *phy,
> > >                                         const struct phy_config *cfg)
> > >  {
> > > +     u32 desired_clock =3D cfg->pixclk * 5;
> >
> > (I don't really understand where that `* 5` comes from, but I guess it'=
s
> > expected? works for other display and neighbor frequency anyway...)
>
> When I looked at the LUT entries for the clock rates that don't need
> the fractional divider, I noted the clock rate was 5x the pix clock.
> This was consistent for each entry.  Even when the fractional divider
> was used, it appeared that the clock rate was 5x the pix clk.  Because
> the PMS calculator I wrote is expecting a clock rate, I just
> multiplied by 5 here instead of inside the PMS calculator.
>
> adam
> >
> > Thanks,
> > --
> > Dominique
> >
> >

