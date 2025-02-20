Return-Path: <linux-kernel+bounces-522872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A6C0A3CF76
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 03:48:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 630C9189B85B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 02:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48DE363A9;
	Thu, 20 Feb 2025 02:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="KEBBTN/Z"
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05181288D6
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 02:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740019676; cv=none; b=nl8zyGIGYiBRujp2FoXu96I4PxVxxKENeBul+XDyRnOQL6QPjYp/SELul+S32Tv2MtfaJ3utwdoRanQybHaP3/aaozUiCVkVEu2SjSyqoQAT5aTSJiEF0cxmNbuc9MxkHNZFSFsNdylA4DmAvUY1MjrJ3uw3F4MjI94LHVZf9JU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740019676; c=relaxed/simple;
	bh=2VvfnmXlr34dHXG/P3XG6letow4wupZdh48hZ5+IiwM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q+7RA62ajiJ1V/FwQhCx7/UhV2QSvoC2q30NZwnwv482/FaZWinbEOdp6HSPXO2GReteDoCMHX54q3uMD6P8SGhRkG1y7BX6XqRPIXD3jxMYZeGoeAhzTrRrtozk5mgdFvYMwvoAzMEULGhcEzwwtLF58Zcjl0QHqvoDjlfr6d8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=KEBBTN/Z; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-6efe4324f96so3812227b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 18:47:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1740019673; x=1740624473; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xvp9vC0eMH1pKGCb8lxYuIWBY9DYcdV7nU72B3skZ6Y=;
        b=KEBBTN/ZusaqxikmKmtLJnqMTtn4ks+InMoAoMQoSXfjcWbUXEJWrU71azbGzZWIKt
         XkxJGZxDgXnPNNwQP9/EuSU/snNUOLtpzB+9tCAkQ+4GFC225CyN6utG2wrGMV24iswW
         XImPoWeHp6qpJiQREq151HSEkhFC14g783qHwlmmPgiMiU/EjvsGEsWodP1iOs0r7H6U
         S/3wfzsHWRA3G+vaCMIk/RPDZnr0xNAd+tJslrX0DZZJdFDewokMsIhH5KeS4WEbJjbk
         wncznDiIyLMq8wnBb2GlAdgEnz/vPoNIXlOF+aU7/aOCjiFteuvOXKW45a6794TkHWCF
         /I5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740019673; x=1740624473;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xvp9vC0eMH1pKGCb8lxYuIWBY9DYcdV7nU72B3skZ6Y=;
        b=YHighuDIXP3xkG5oeObpd2d/onwOc7+TqUy6BhBVnN6jyscNW5DICQZHYB3MIQVvJG
         6YD8qwAR9o77Yut77JURO09qIJTOkZsyYz4EodZbcJAfkI+BeoY9q+mkywUMuJW9EQpp
         n5jBdy7H+7FVB9ZzZlqwkBoxWHWiF+n74xr6fhSBEv7a2siJb8Vg3Vum4l8uM2z4DFgn
         Gy4PSUx4QukHszWOoLFC4zLdBifGg0/iQ2FwdrF7ck6WZbjmrVYJQoGeunJoQjXq9IA9
         RRpiGWhGs2DTUCzdTFz5iJViQJvyW4dcO01ErtciGdtZ9kI/cBwDuIxK/zDmOH2Hm4MU
         duKQ==
X-Forwarded-Encrypted: i=1; AJvYcCX1jG8o9HTrpclMIQpEUsorzLbn+//5QlXaA70wsn1JDiG8KS7l83Xo9P97foAOV59hdbE9KR8kdb6muIA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrnlkERIutG9eQrhETUlMB6CgBTncaOSkfBLKZimlS63gsaFdF
	0BYoyChxa49BPsD+fPuQaSA7H1oRNwIJCgW6SFbjFSvjm6HYhh4nYcutRcKoc0tP1EhHlUCfgp/
	CvEws3WvrxAji3hWTWTKIpdD8TQUzT4tiom6HUA==
X-Gm-Gg: ASbGncuOO3i6ZPb8KcU5ASqpOsMvSrA3bD7jzkE0a4tuuVkFRZYdEli0k1sttwZ7znU
	OiylDWP03vejh8hUjGKZe4mMuscRcXj8vyN8+zJX1SzeVnsDl6Z1rwDKWOR+ub+Fe9GOPJfrq9p
	A=
X-Google-Smtp-Source: AGHT+IHpbcrdwizdZDEB2LKzf3t7N+L1gh7l/lSw8IgK31mOcpbcfuefgyvG7Eg9yB90MSd4D8fYOSrYNFEZa4g738Y=
X-Received: by 2002:a05:690c:64c8:b0:6f7:ac3f:d589 with SMTP id
 00721157ae682-6fbbb7eafa8mr5012217b3.36.1740019672877; Wed, 19 Feb 2025
 18:47:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250217055843.19799-1-nick.hu@sifive.com> <889918c4-51ae-4216-9374-510e4cbdc3f1@intel.com>
In-Reply-To: <889918c4-51ae-4216-9374-510e4cbdc3f1@intel.com>
From: Nick Hu <nick.hu@sifive.com>
Date: Thu, 20 Feb 2025 10:47:40 +0800
X-Gm-Features: AWEUYZmjzhqzQbHmf9_A5Yil9YBABlCV2QtiQWGg09MoFGZlPCm-Nzx5MY3mUGU
Message-ID: <CAKddAkBZWZqY+-TERah+Q+WUfkqzcpFMA=ySSuTxxBjfP7tKZg@mail.gmail.com>
Subject: Re: [PATCH] net: axienet: Set mac_managed_pm
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Michal Simek <michal.simek@amd.com>, 
	Russell King <linux@armlinux.org.uk>, Francesco Dolcini <francesco.dolcini@toradex.com>, 
	Praneeth Bajjuri <praneeth@ti.com>, Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jacob

On Thu, Feb 20, 2025 at 7:29=E2=80=AFAM Jacob Keller <jacob.e.keller@intel.=
com> wrote:
>
>
>
> On 2/16/2025 9:58 PM, Nick Hu wrote:
> Nit: subject should include the "net" prefix since this is clearly a bug
> fix.
>
I've added the 'net' prefix to the subject 'net: axienet: Set
mac_managed_pm'. Is there something I'm missing?

> > The external PHY will undergo a soft reset twice during the resume proc=
ess
> > when it wake up from suspend. The first reset occurs when the axienet
> > driver calls phylink_of_phy_connect(), and the second occurs when
> > mdio_bus_phy_resume() invokes phy_init_hw(). The second soft reset of t=
he
> > external PHY does not reinitialize the internal PHY, which causes issue=
s
> > with the internal PHY, resulting in the PHY link being down. To prevent
> > this, setting the mac_managed_pm flag skips the mdio_bus_phy_resume()
> > function.
> >
> > Fixes: a129b41fe0a8 ("Revert "net: phy: dp83867: perform soft reset and=
 retain established link"")
> > Signed-off-by: Nick Hu <nick.hu@sifive.com>
> > ---
>
> Otherwise, the fix seems correct to me.
>
> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
>
> >  drivers/net/ethernet/xilinx/xilinx_axienet_main.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/driver=
s/net/ethernet/xilinx/xilinx_axienet_main.c
> > index 2ffaad0b0477..2deeb982bf6b 100644
> > --- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> > +++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> > @@ -3078,6 +3078,7 @@ static int axienet_probe(struct platform_device *=
pdev)
> >
> >       lp->phylink_config.dev =3D &ndev->dev;
> >       lp->phylink_config.type =3D PHYLINK_NETDEV;
> > +     lp->phylink_config.mac_managed_pm =3D true;
> >       lp->phylink_config.mac_capabilities =3D MAC_SYM_PAUSE | MAC_ASYM_=
PAUSE |
> >               MAC_10FD | MAC_100FD | MAC_1000FD;
> >
>

Regards,
Nick

