Return-Path: <linux-kernel+bounces-256421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D534D934E31
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 15:30:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 904522825F9
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 13:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1375A13E039;
	Thu, 18 Jul 2024 13:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="S8Bifhxd"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2E559457
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 13:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721309413; cv=none; b=Jb9TsnEOgCX/gCrUgKinQLqXGJNH9XnbSxiza8PwHSG2j7UdhVF2nIiz1imDLy6WwQLeSHU4f8MIFsAKeN44Np0cDQr1Qe9uGDmOwCjb0D/lVc3FWBfpR6bPHjKNYWYgOz9jl+vL00i01Ihu3z+9Yv4gMTGDQFxG9hTq4aWpArY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721309413; c=relaxed/simple;
	bh=6g2JocoVjYFSu+FazwfDkrN2qhaXz++L7gwGS37uF74=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eULOOwZLhwsJ/dPHFdVCIyhYLOXlPdIG3HnsGhRxuLNZLkkAJ8QMdlAoOZ262ew4lSS0QThZwi5Or6wapMR2oN4opk0FKOxTCDfsAH8kGAqbEAdlLyTQ89ByeSfKsk5hWhf0hoMs8dGGAJD5wQFs90Z6IawnP+Mje3Va64ojP38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=S8Bifhxd; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2eecb63de15so10814501fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 06:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1721309410; x=1721914210; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YT1la3hOSgpRfRsWHpzvZruTBiRkfm0GB/f007d38Pc=;
        b=S8BifhxdTrOJBqtoJOjAEJS9nRWvQXIHP+Rahvw+x3ign9n8WEeiBtU4A7RPyAvpKi
         vuDVqKjWiWLMMu/gH/ko8OgFDFdFbQ5NcuDMCpydSNESqjypHDYu5Nlfa6fMT6/8Q71f
         MA3OdHkBYdSHh8KuBpD8hr/rspRsiAUP3vjuzgruV4T5eaMNEr72ip6rorqvUTj8WmwS
         U+TmoDCcxnmhO3CowEtxD0aGFs4ubupkv0P2PVGwj9Dkvwthks99lwBuzXWAJuf4fcFc
         ZQ/gpSWimk7GwuIr2pAdyc64nt1Z34q4Jo1/5aZmGTYoQ0m2bGDIj5Y/exM3UIl4wAdC
         2D6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721309410; x=1721914210;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YT1la3hOSgpRfRsWHpzvZruTBiRkfm0GB/f007d38Pc=;
        b=dUe5NM1sbGAg8Ogra0DxtVn5DqpPIo05tgrZlp8udfg3j12sNFEYIAS0l1g4gxLtjO
         U/CCDvMohmKXBm9TyW5VQ6uZ9A1w503pXD6wRCKcotq4to8emORSzNBlCHj2NQi8K/Ho
         6HsAOC5KV+2AUcsqbWa9iJSTP4B1i2mOv6SBSCbh1zaUiAUEKL4eG1Qz/EEOad66DLSu
         r6iCCKqcymbGkDn0ps8Rd45NkMgmBeO3/cAQxd+FsWnTzXotq10x/hNPMXWsSFTQn/eV
         Bf9Zlig7+qLnVw7yg1NFTxFFTummAkQxQyv9k/Lk2Erot935hdR0ZwWWVWlDtnoHkIoJ
         2F/Q==
X-Forwarded-Encrypted: i=1; AJvYcCVVAasyztPg1vNp1XCr4f9VbhNubNZ8ypjjywsYU5B///EFSwMw7uQkgAbU+s5cJ5L31asY5vK6YZdM0BuqqsBReGVhXGbYV4yKl9SW
X-Gm-Message-State: AOJu0Yy6oTLcm44NJUOpSwD0JyunDXydQh2wmeVn8U1TeQa3rEJgE4bm
	uhTdTY7T9CtOCN/xa9pUkpefrh9IbtxPZkA3bVofhmRjgVwoRtykBPWko2mMJGa9/rAZKD+2PRP
	jgcMKoJI/7A6nYZ9PlbU7bnz10wIEIjZJgjU15g==
X-Google-Smtp-Source: AGHT+IFlZwGom4Cm6D/yzMCO68xfKb+hvi2jTDlVGTvtty+HgV5mjKDUlfhjUX/StKdrcO0SHS8dY7nKIHi377iDFF8=
X-Received: by 2002:a2e:a16e:0:b0:2ec:1ce8:9a7d with SMTP id
 38308e7fff4ca-2ef05c5736cmr16130801fa.4.1721309410027; Thu, 18 Jul 2024
 06:30:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240708075023.14893-1-brgl@bgdev.pl> <20240708075023.14893-4-brgl@bgdev.pl>
 <7c0140be-4325-4005-9068-7e0fc5ff344d@nvidia.com> <CAMRc=McF93F6YsQ+eT9oOe+c=2ZCQ3rBdj+-3Ruy8iO1B-syjw@mail.gmail.com>
In-Reply-To: <CAMRc=McF93F6YsQ+eT9oOe+c=2ZCQ3rBdj+-3Ruy8iO1B-syjw@mail.gmail.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 18 Jul 2024 15:29:59 +0200
Message-ID: <CAMRc=Mc=8Sa76TOZujMMZcaF2Dc8OL_HKo=gXuj-YALaH4zKHg@mail.gmail.com>
Subject: Re: [RESEND PATCH net-next v3 3/4] net: phy: aquantia: wait for the
 GLOBAL_CFG to start returning real values
To: Jon Hunter <jonathanh@nvidia.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Russell King <linux@armlinux.org.uk>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, Brad Griffis <bgriffis@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 18, 2024 at 3:04=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl>=
 wrote:
>
> On Thu, Jul 18, 2024 at 2:23=E2=80=AFPM Jon Hunter <jonathanh@nvidia.com>=
 wrote:
> >
> >
> > With the current -next and mainline we are seeing the following issue o=
n
> > our Tegra234 Jetson AGX Orin platform ...
> >
> >   Aquantia AQR113C stmmac-0:00: aqr107_fill_interface_modes failed: -11=
0
> >   tegra-mgbe 6800000.ethernet eth0: __stmmac_open: Cannot attach to PHY=
 (error: -110)
> >
> >
> > We have tracked it down to this change and looks like our PHY does not
> > support 10M ...
> >
> > $ ethtool eth0
> > Settings for eth0:
> >          Supported ports: [  ]
> >          Supported link modes:   100baseT/Full
> >                                  1000baseT/Full
> >                                  10000baseT/Full
> >                                  1000baseKX/Full
> >                                  10000baseKX4/Full
> >                                  10000baseKR/Full
> >                                  2500baseT/Full
> >                                  5000baseT/Full
> >
> > The following fixes this for this platform ...
> >
> > diff --git a/drivers/net/phy/aquantia/aquantia_main.c b/drivers/net/phy=
/aquantia/aquantia_main.c
> > index d12e35374231..0b2db486d8bd 100644
> > --- a/drivers/net/phy/aquantia/aquantia_main.c
> > +++ b/drivers/net/phy/aquantia/aquantia_main.c
> > @@ -656,7 +656,7 @@ static int aqr107_fill_interface_modes(struct phy_d=
evice *phydev)
> >          int i, val, ret;
> >
> >          ret =3D phy_read_mmd_poll_timeout(phydev, MDIO_MMD_VEND1,
> > -                                       VEND1_GLOBAL_CFG_10M, val, val =
!=3D 0,
> > +                                       VEND1_GLOBAL_CFG_100M, val, val=
 !=3D 0,
> >                                          1000, 100000, false);
> >          if (ret)
> >                  return ret;
> >
> >
> > However, I am not sure if this is guaranteed to work for all?
>
> Ah cr*p. No, I don't think it is. We should take the first supported
> mode for a given PHY I think.
>

TBH I only observed the issue on AQR115C. I don't have any other model
to test with. Is it fine to fix it by implementing
aqr115_fill_interface_modes() that would first wait for this register
to return non-0 and then call aqr107_fill_interface_modes()?

Bartosz

