Return-Path: <linux-kernel+bounces-304613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE494962282
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 10:48:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B6B928228E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 08:48:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3BF515D5B9;
	Wed, 28 Aug 2024 08:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b="TIondvqP";
	dkim=pass (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b="ahCF2cI8"
Received: from gw2.atmark-techno.com (gw2.atmark-techno.com [35.74.137.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC3018030
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 08:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.74.137.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724834879; cv=none; b=h3/7tGMjLKk6g2v0GPXo1Je9gk3w4EUsIY+NgJmYv99tkv6p8CRLEJcNxM9By3V1IFq6OxqEQnqy0TTWuXhV11bglfrrk3TUyrgpxRHKCYuIgt7ik/QvJK7RLM9i9X9VT+nWvR86MBkKTVDc447yi946H74YKKWRk15wa7TsRos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724834879; c=relaxed/simple;
	bh=6pfs4i4vDripwVzKrOUHAThf6XujiPM6U5bZyFKdLrc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CfwO0qeHcJDNkx+Ej3IJjzyTqEB3g3ag3XIlYnPvpBE1YwPXgV+d5QW8TuAD+CVrg4l7FhoGhASDIyNF1zVguqHxhjuTKrAoj+73AHqer9Rxj/Sle1aY4NXucDsiDxppqMOeAnoD9nqniYHdw0TXpzEbklQAB3cozyKXQtCarfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=atmark-techno.com; spf=pass smtp.mailfrom=atmark-techno.com; dkim=pass (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b=TIondvqP; dkim=pass (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b=ahCF2cI8; arc=none smtp.client-ip=35.74.137.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=atmark-techno.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atmark-techno.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=atmark-techno.com;
	s=gw2_bookworm; t=1724834871;
	bh=6pfs4i4vDripwVzKrOUHAThf6XujiPM6U5bZyFKdLrc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TIondvqP02EmwVDIat/KpfaxjKUFAWSxUqlz23Od0SErB5d4A5+Jh0RlKOONnhDLD
	 Ox8RV3oXZFgmPicxboRx514iApcv14ouYwm7VP+E2uIu9phQXNM04rP5dWlU/kk27w
	 Ime4G0OpCYbQpnGp5a5Tcqy0pcXFpyi38fPpzjVemZNm5gbyusin/EguSs4dFLid0J
	 KEJC331wNP4YSpemMD2FVA5ePOIdVYHTh4I7Ku3euHhG8IKYlsmg78HWhnjTSYcOhB
	 6jPKRNjRaARrgxdEPTvkMdE4no8QKpjzhe/mZzjvj1RIpD3fqQKCppi4n+6uui1KC4
	 W3yL8V/Mmg5lA==
Received: from gw2.atmark-techno.com (localhost [127.0.0.1])
	by gw2.atmark-techno.com (Postfix) with ESMTP id 36E5B4AB
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 17:47:51 +0900 (JST)
Authentication-Results: gw2.atmark-techno.com;
	dkim=pass (2048-bit key; unprotected) header.d=atmark-techno.com header.i=@atmark-techno.com header.a=rsa-sha256 header.s=google header.b=ahCF2cI8;
	dkim-atps=neutral
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by gw2.atmark-techno.com (Postfix) with ESMTPS id D0D444AB
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 17:47:49 +0900 (JST)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2d45935fed4so8261452a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 01:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atmark-techno.com; s=google; t=1724834869; x=1725439669; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pAldl2xCzAsh3Cj6QcqFR8+ZE1/v9SHjhlqKHvRmHc8=;
        b=ahCF2cI8TZJOxyXXAhVi7lBmvCkN3YIvX972gsgb49OMD9fsWQycSUHdShArNzyI/q
         xaxTa40qrTtejHa8bHzDTPb084BuaoInDj9OmoYm0DJf4jkcXGPRzpmt+YdQHHu8XeM2
         wjYpS2OKDzGcV6kz6JjYE3FnxRzfo1LUpwOgrhZJbY8u5vwnPt37x6ablv8GaObWDd52
         VxzZWEekE/+vAkN4WWvorsWb0v4KjPFXuneFUw01FjBJRLqm9ScBGNS5NYpu2468elWz
         wLK8+HqJSNnHwW7l+61LBBpqoAYpVskjBAhaveJFBi5VI434RPD50RsMMWDpUgfVQlkT
         chHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724834869; x=1725439669;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pAldl2xCzAsh3Cj6QcqFR8+ZE1/v9SHjhlqKHvRmHc8=;
        b=cNLoEVXlD/j6xPJl0J0xb2lzrYDA4onqYYt3TZvh7M0dh3fgpRNeVhUsznAgl0BfYB
         Q9iTtferdKdSG8Pzvueqa3ift0FqA5VG3Zv7JKQQAaptvfMPGjN0U8IDz1ReKITnuAsw
         W+vMt7l1rbtwlBRaGwxxzDtB08vW6lWpzHXm68j1ja6GuaXcs+wi/v7XtmyJ+xa+3JIZ
         f+kIf4fdiCYcM5A7S+0gFiknmjOvfjuiP0+w89yx70cw4KXPQCnRD5hUiJyDVaERIRrE
         THHu1P4Gb5CEwzLK8X+PwHfb4dU9QMuG28KQZYGz7qBnte0+aMxRwNKMlchHIrFYj0Ge
         51eA==
X-Forwarded-Encrypted: i=1; AJvYcCWa9i4PmOl8LTLxVl8HMRlTqIKLw8jIzkt5AwvRsMVgmYTU9ZUp6pINuyy5gzKa5mC0pEfg/cB2wjJ1kwk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPTwMU7/pKu8VTQ+ATXejPl6V/2swXF2XIZ0iW2J2BhRKVsbUY
	oqAlsQD/wKoxG4E4WUmJIJElMibDJ60Dib0WZXfHPsW7U0520SaTaVODiUJxaxUAILRnQC3OhxF
	zkliX1Mf4N/Zj32Mt9zS71+CVIzs1WmuHWdYSFC8pF2JoManvP4B/o/0v8L52ulY=
X-Received: by 2002:a17:90b:1b0a:b0:2c9:80cd:86b4 with SMTP id 98e67ed59e1d1-2d646bf64c2mr14792069a91.11.1724834868854;
        Wed, 28 Aug 2024 01:47:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFdjQnPKPR912NnK2N/SqoeL4fXzUu88nk0g3dQyz5864cBxHSptKcI63bsrGMeiRP1XSHdMw==
X-Received: by 2002:a17:90b:1b0a:b0:2c9:80cd:86b4 with SMTP id 98e67ed59e1d1-2d646bf64c2mr14792050a91.11.1724834868531;
        Wed, 28 Aug 2024 01:47:48 -0700 (PDT)
Received: from pc-0182.atmarktech (103.131.189.35.bc.googleusercontent.com. [35.189.131.103])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d8446f35eesm1119665a91.47.2024.08.28.01.47.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Aug 2024 01:47:47 -0700 (PDT)
Received: from martinet by pc-0182.atmarktech with local (Exim 4.96)
	(envelope-from <martinet@pc-zest>)
	id 1sjELC-00CmWk-05;
	Wed, 28 Aug 2024 17:47:46 +0900
Date: Wed, 28 Aug 2024 17:47:35 +0900
From: Dominique Martinet <dominique.martinet@atmark-techno.com>
To: Adam Ford <aford173@gmail.com>
Cc: linux-phy@lists.infradead.org, linux-imx@nxp.com, festevam@gmail.com,
	frieder.schrempf@kontron.de, aford@beaconembedded.com,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Marco Felsch <m.felsch@pengutronix.de>,
	Lucas Stach <l.stach@pengutronix.de>, linux-kernel@vger.kernel.org,
	Makoto Sato <makoto.sato@atmark-techno.com>
Subject: Re: [RFC 2/2] phy: freescale: fsl-samsung-hdmi: Support dynamic
 integer divider
Message-ID: <Zs7kJ6vCDbxVvxU1@atmark-techno.com>
References: <20240828024813.1353572-1-aford173@gmail.com>
 <20240828024813.1353572-2-aford173@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240828024813.1353572-2-aford173@gmail.com>

Adam Ford wrote on Tue, Aug 27, 2024 at 09:48:02PM -0500:
> There is currently a look-up table for a variety of resolutions.
> Since the phy has the ability to dynamically calculate the values
> necessary to use the intger divider which should allow more
> resolutions without having to update the look-up-table.  If the
> integer calculator cannot get an exact frequency, it falls back
> to the look-up-table.  Because the LUT algorithm does some
> rounding, I did not remove integer entries from the LUT.

Thank you!

We're still running 5.10 so I backported the driver as of it's current
state first (that part works), unfortunately our 51.2MHz display does
not work with this.

After phy_clk_round_rate() not round the pixel clock to the table values
(otherwise we'd only get rounded values), and making phy_clk_set_rate()
pass the requested `rate` instead of using the next smaller cfg->pixclk,
the display no longer comes up.

It comes up with the values obtained for 50.4MHz (next closest value),
which also has an exact match so uses the integer divider this patch
computes instead of the table values, but not with the 51.2MHz it
requests...
I'm afraid at this point I don't know how to debug that further without
getting a scope out (I don't know if the soc isn't generating something
correct or if the display actually doesn't like the frequency it
requests?! the later could be checked by plugging it in to another PC
that might support that frequency...), and that is going to take quite a
while...

Hopefully Frieder will have more success with his displays?
It could also be very well due to some of the differences with our 5.10
tree, sorry about that.

>  static int fsl_samsung_hdmi_phy_configure(struct fsl_samsung_hdmi_phy *phy,
>  					  const struct phy_config *cfg)
>  {
> +	u32 desired_clock = cfg->pixclk * 5;

(I don't really understand where that `* 5` comes from, but I guess it's
expected? works for other display and neighbor frequency anyway...)

Thanks,
-- 
Dominique



