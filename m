Return-Path: <linux-kernel+bounces-232695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A22C91AD28
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 18:49:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBC7A1C24D2C
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 16:49:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FF59E56A;
	Thu, 27 Jun 2024 16:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="icXFnF0X"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31B1B198E66
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 16:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719506948; cv=none; b=Zi97sSpkTIdlCESTcW9NaKGZT5c6YwlCc0gsEOBjTP2VNfEXiRJVg4j4Sc3xI7GzhYxUINrTXsdbmzuyv1iNZ/T1xd94AgL0MjGT60ylBeB8IPCSii/laNW/npX6iioyzeMIb/K5P+d/9BlF2tgTCoCJq/wg7eY6Iqj3uyMdcY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719506948; c=relaxed/simple;
	bh=c/4fRIUAemDzS10rHlCgLgOeocikZUevNTeZx2WBQIY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZwjJqxS7Yetvs8hkFfSHyWBTwMbwu9SZ2UqIegYWzUh/KwfnIQ6aO72kWES62TQWtBF3NgoebrX3I7kRYI6qUGf/LELP3B6mLeI/5i6NxcXGEEtEL3+r7nMuLes/JSkDcG6HusSG1t8zA8356UXfpjy2NPGghX1z3dgySDOsKKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=icXFnF0X; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7065a2f4573so4957229b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 09:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1719506945; x=1720111745; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xxcFEOlgMZdT3jwSPBKvbM2Hel/+xTILb1M8DFKl18Y=;
        b=icXFnF0XlfKUfiIZ/77bLs1A3mXy6ePVUmXg12nm7iyhegg3eaUYMQrRzMeNFYSCiV
         cBFQT39vLeCEZ87AkDiE5osHoixilxUyya7iFfh0fRE+trmHKp3ZG5YpG/sOG7BGZxSS
         K8FYkC3F+cPwOqYVvHyCTQ80NSK47YsND442ERHkNxEsNYdBxrE40o+cT5wZFGSxw/xo
         KLUY6eEa1EJl3gJ4WmfgbsWoyt3F3AmocCwLdsQ3VISzaxZ76fSwYRWTObHmrnXhxkuW
         3pu8yEm516lxU5V1HE7Z7b3nYO4k66kQMLICbuUdNxn7SSQZUQ0H8SnlzagkhhwQnbbL
         Vrog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719506945; x=1720111745;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xxcFEOlgMZdT3jwSPBKvbM2Hel/+xTILb1M8DFKl18Y=;
        b=iV2nNiQ2DKF5oFH5XAYB9Y9prYPBJU8lSkubftYZxFKOXhmtknGavAPKRERZMxAw1G
         75GcqF3twzKSlFhgJCFBD5RGDHtUjk0Hc9Yh6V1plfUWuv4ng6+XRodO823UnwW/zFcH
         hNuqQWRLFDwuTO5fRsVrPc/TYWaaQid66opiAAx4t7dr8n1JI/41jD/tIoPm0G3ldr/w
         NCrojiiSBmzZNk7PslsuZ9wh+pqJpg05kLyhAqVzUfaV4mXDwojOyLrSMiabpNGG1Jp0
         tT+u/xuYCQSLBv8lmRoti2CYmwAMD+4l+D36mW9TJuWjN2zkrmJ4vALJu63sdlmuo+HY
         BoQA==
X-Forwarded-Encrypted: i=1; AJvYcCXVFJqrz99X7lzGK0mZ/q1nSIzlyviCi9JRtXHGNdWmcBcCuJ43Dc6wmvYz0br2xTCvT6bmMKc/Y6IHB8V3d9NMZ6t++iUC2xzwJ0c8
X-Gm-Message-State: AOJu0Yy1zF7xuvjS4BUvMfRlB9Ns8XFqSkMwd+Y3rxrstfyYPVxjIX7V
	K/ieAEunP3ZhLEb1DLlm4cVg3EJdg4u2qpo1xW+PiQA2VCMMUyQkNjLVmgAm71NwQnjlnwoveWo
	Ma3ovVSeTu7EwU7Zo9o2yp15D7qzbJ/lW7nMzLg==
X-Google-Smtp-Source: AGHT+IGuCIcGgabVY++a4Em4rrMpQkk20usuUoDxNeZRMIEMY4XnKjgZq6XSJV5vH34NogeLq+vOfcgAhpt92ibkLbw=
X-Received: by 2002:a05:6a20:3d8b:b0:1be:c4e6:ed40 with SMTP id
 adf61e73a8af0-1bec4e6ee22mr5759856637.51.1719506945413; Thu, 27 Jun 2024
 09:49:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240627113018.25083-1-brgl@bgdev.pl> <20240627113018.25083-4-brgl@bgdev.pl>
 <ea452581-c903-4106-b912-d307f74f773d@lunn.ch>
In-Reply-To: <ea452581-c903-4106-b912-d307f74f773d@lunn.ch>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 27 Jun 2024 18:48:51 +0200
Message-ID: <CAMRc=Memf-fwY2iRXNDz7M4337PcH7quAZ7GHgjauj+Og8PwbQ@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 3/3] net: phy: aquantia: add support for aqr115c
To: Andrew Lunn <andrew@lunn.ch>
Cc: Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 27, 2024 at 6:22=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Thu, Jun 27, 2024 at 01:30:17PM +0200, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > Add support for a new model to the Aquantia driver. This PHY supports
> > Overlocked SGMII mode with 2.5G speeds.
> >
> > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > ---
> >  drivers/net/phy/aquantia/aquantia_main.c | 39 +++++++++++++++++++++++-
> >  1 file changed, 38 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/net/phy/aquantia/aquantia_main.c b/drivers/net/phy=
/aquantia/aquantia_main.c
> > index 974795bd0860..98ccefd355d5 100644
> > --- a/drivers/net/phy/aquantia/aquantia_main.c
> > +++ b/drivers/net/phy/aquantia/aquantia_main.c
> > @@ -29,6 +29,7 @@
> >  #define PHY_ID_AQR113        0x31c31c40
> >  #define PHY_ID_AQR113C       0x31c31c12
> >  #define PHY_ID_AQR114C       0x31c31c22
> > +#define PHY_ID_AQR115C       0x31c31c33
> >  #define PHY_ID_AQR813        0x31c31cb2
> >
> >  #define MDIO_PHYXS_VEND_IF_STATUS            0xe812
> > @@ -111,7 +112,6 @@ static u64 aqr107_get_stat(struct phy_device *phyde=
v, int index)
> >       int len_h =3D stat->size - len_l;
> >       u64 ret;
> >       int val;
> > -
> >       val =3D phy_read_mmd(phydev, MDIO_MMD_C22EXT, stat->reg);
> >       if (val < 0)
> >               return U64_MAX;
>
> White space change. And that blank line is actually wanted to separate
> the variables from the code.
>

Ah, this is accidental, thanks for catching it.

Bart

>     Andrew
>
> ---
> pw-bot: cr

