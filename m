Return-Path: <linux-kernel+bounces-431382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B43E49E3C9C
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 15:21:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FB32161044
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 14:21:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B7171FDE05;
	Wed,  4 Dec 2024 14:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Aej1h0HG"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 546F81BD014
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 14:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733322110; cv=none; b=TKPD6DYgsCjZe6cm7Aqf0aHyCQPSPos13knX9nmRFILbzXlW26N3CnmT0g+ngEN0oGeY2evNyzbvYrDu7Uv2ykjmGAvR3gbsG6XnuLZdgxvRRqvUU1wOjAadgmgKOj9BF+Yt8ksAWg/4o+UVry4S3EIb1bT/EpehYH4SCCQ+GqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733322110; c=relaxed/simple;
	bh=24iJMNEALk3yeDjV3Bk01jcXq2XIIasf6iyqvQ2nmko=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ARu59TW+urKsjaCYB+NX+ysxR7TVnnsAEnFwcfRbX7aQfDH4SWdsosYeuqmTtWGgEeKfwG7rp/im6ZopU2lXw7rqXJmPokvJcMuNLGVq0tT3ij899ywhQOXS0HMYq/bC00y90stCgnkKINQzNmrNVaUV+vrKV+DI/YlimvMPZ2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Aej1h0HG; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-215810fff52so39633955ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 06:21:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733322108; x=1733926908; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gRP0LK379oO2c2wmV7bc4BGWSbNhwQ82H70Yc7kGYLE=;
        b=Aej1h0HGR0Qe+i5QKFdohUOei3Gd20ml95X4pwjVQs/ZKUgZmAw3DkWoZFX8cD0N31
         jqOcquq+Dqo484kCTOpGmG7f46gjg7KiOeKMmbFafG8mD+hE848pYGygVQ2VB1jZ3WaE
         jfzKa00NikJ3EL7YiqYa+Lky/NRUN/RGeEBaxVtyJWAj8BlgQZm4L0cM7Ct9NEm4EQmh
         8Z+DNDKyt8lcJPQ98WeLYFOL4XcHlH4iZNaSEUji3BKnJc0Zkfgsxip1gnomxAJIuM9w
         W2L+CYBVxWtAnSRf6STVQhrMMLZQw/HdXdx/6NCbcRyB+qEFX4433GYo/ZqIozSc+n7z
         BQiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733322108; x=1733926908;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gRP0LK379oO2c2wmV7bc4BGWSbNhwQ82H70Yc7kGYLE=;
        b=PkWeqreWMWo14mHNN1wiMKIfjDA78UFXhSdeHy3Pz0mA25/Gr5RI40aYmOXw88s2cd
         pz3RXH3suHuVHFEO9LxjhV9DyYXWX698rbaHsR/08Al3Fd8rOC7hcd+PlmZkuVnSnI0T
         j61HwjOA8vfj0T/LLq2pocrHNTOnD1xfvAX4gfrd3h8l3opFvxhRDmAkFXCLUc6zODkS
         p14x8B45aONvB8Zsyh1xDdgF8Kkf1JSA+epFjcvhTPV4Z3zgm9WNv6WrkgmJjHK2ozK5
         qSSqHGX6017PGOCPmNwQdk1PK/2eNnjJeRRtv605YlQYujLUMj4QPlT6f782+HayPjW8
         kiVg==
X-Forwarded-Encrypted: i=1; AJvYcCWQQ0Jw1w+jcr9wWO2Bt01ZRfhpYQPU8rfLnbssCyQnTwutIa0YZ0e0YUHb3rK4M2lMizwm/2gHVx6tNic=@vger.kernel.org
X-Gm-Message-State: AOJu0YynnuvgIkLUN0zUIw8yKoO3DILlb4XcpTGY0Qoywc6Ef5De6a1W
	x3iZJBUG0WesYqOYOz2Xu4tXM0ye6dzf8CeaDkwZ0gYinknf5eH/c6c96RJKqgk5RD8C6d0Ho1v
	T3cYu6zOIXZ0CK/bk2lVRf/oCcZ8=
X-Gm-Gg: ASbGncvfIYZ1RKdOX/kaUbYhLzEjgaPB1yea6Gj9THHCa3eWWxhLU9CRhlBXBSW4w61
	ZgfbT6uxE2cOsR/Te/BNXWeE/WQqel68=
X-Google-Smtp-Source: AGHT+IEhQp50zTrtMghVbxKM6Ou+CIF3ijU487pVYVEw9sK5K7QfwReJj5ycsmTPECwvl95PID2IRePOADM6FuNTzJw=
X-Received: by 2002:a17:902:ecc5:b0:215:8f2e:eeda with SMTP id
 d9443c01a7336-215bd26a3fbmr73008755ad.52.1733322108412; Wed, 04 Dec 2024
 06:21:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241026132014.73050-1-aford173@gmail.com>
In-Reply-To: <20241026132014.73050-1-aford173@gmail.com>
From: Adam Ford <aford173@gmail.com>
Date: Wed, 4 Dec 2024 08:21:37 -0600
Message-ID: <CAHCN7xKH40UiLq3XaBA40B2uhvRadhPGLTWqqtLBaVNQJC=9nw@mail.gmail.com>
Subject: Re: [PATCH V2 1/3] phy: freescale: fsl-samsung-hdmi: Expand Integer
 divider range
To: linux-phy@lists.infradead.org
Cc: aford@beaconembedded.com, sandor.yu@nxp.com, 
	Frieder Schrempf <frieder.schrempf@kontron.de>, Vinod Koul <vkoul@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, 
	Dominique Martinet <dominique.martinet@atmark-techno.com>, 
	Marco Felsch <m.felsch@pengutronix.de>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
	Lucas Stach <l.stach@pengutronix.de>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 26, 2024 at 8:20=E2=80=AFAM Adam Ford <aford173@gmail.com> wrot=
e:
>
> The Integer divder uses values of P,M, and S to determine the PLL
> rate.  Currently, the range of M was set based on a series of
> table entries where the range was limited.  Since the ref manual
> shows it is 8-bit wide, expand the range to be up to 255.
>
> Signed-off-by: Adam Ford <aford173@gmail.com>
> Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>

Vinod,

Do you have any feedback on this series?  RC1 is available, and it
would be nice to see this series merged soon unless you have changes
you want implemented.

Thank you,

adam
> ---
> V2:  Fix typo in comment
>
> diff --git a/drivers/phy/freescale/phy-fsl-samsung-hdmi.c b/drivers/phy/f=
reescale/phy-fsl-samsung-hdmi.c
> index 2c8038864357..412c03b7dcd6 100644
> --- a/drivers/phy/freescale/phy-fsl-samsung-hdmi.c
> +++ b/drivers/phy/freescale/phy-fsl-samsung-hdmi.c
> @@ -406,16 +406,15 @@ static unsigned long fsl_samsung_hdmi_phy_find_pms(=
unsigned long fout, u8 *p, u1
>                                 continue;
>
>                         /*
> -                        * TODO: Ref Manual doesn't state the range of _m
> -                        * so this should be further refined if possible.
> -                        * This range was set based on the original value=
s
> -                        * in the lookup table
> +                        * The Ref manual doesn't explicitly state the ra=
nge of M,
> +                        * but it does show it as an 8-bit value, so reje=
ct
> +                        * any value above 255.
>                          */
>                         tmp =3D (u64)fout * (_p * _s);
>                         do_div(tmp, 24 * MHZ);
> -                       _m =3D tmp;
> -                       if (_m < 0x30 || _m > 0x7b)
> +                       if (tmp > 255)
>                                 continue;
> +                       _m =3D tmp;
>
>                         /*
>                          * Rev 2 of the Ref Manual states the
> --
> 2.45.2
>

