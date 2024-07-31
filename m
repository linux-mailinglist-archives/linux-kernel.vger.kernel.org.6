Return-Path: <linux-kernel+bounces-268772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CAD094291D
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 10:26:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E1501C218B5
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 08:26:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 162C01A8BE6;
	Wed, 31 Jul 2024 08:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=timesys-com.20230601.gappssmtp.com header.i=@timesys-com.20230601.gappssmtp.com header.b="IVu7w6Ed"
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33FC01A7F92
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 08:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722414366; cv=none; b=ZM91/Ca2LXXQObnrYowg8H13ErPp/ly5v0ZE02xvr3QHOvSHdqJcvMI+kHEchfJAkyjqWCzp6939T58tAIpZyX+Dhg3cZG3Rbnlm5RvnslN5eIZ0usQawRMqUgLW4vf60HctutrTcP6Vptww4QiIEjjYyQTFTOeZBzFjqBzcF8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722414366; c=relaxed/simple;
	bh=tAC3ug/LGqAdm2YEhAedFZNCwyk2NGSC0+F1U6scVTk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ircPgJRm6tih4sCYTt3AsTY154ucPPSYCMsiEqLeQLv65Ik/7lqAVv+X6R7M6Qw9+bXmQ/o68kPqeuBtShdNiN00JjclmIzg8ay9OKb+K29RT5GCHbE0JhbMUP4R1HahP+oe1Amxx1D/UKbelkoC3Dm5Fgaq0yApJlgs53CFnOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=timesys.com; spf=pass smtp.mailfrom=timesys.com; dkim=pass (2048-bit key) header.d=timesys-com.20230601.gappssmtp.com header.i=@timesys-com.20230601.gappssmtp.com header.b=IVu7w6Ed; arc=none smtp.client-ip=209.85.222.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=timesys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=timesys.com
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-821db15a930so1644468241.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 01:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=timesys-com.20230601.gappssmtp.com; s=20230601; t=1722414362; x=1723019162; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DFjJ7n63paZS6uSG42PXEZWs1JHtvlpu1J7pCHV1MaA=;
        b=IVu7w6Ed6g7vZqHOo5KjS/8XW5dDLZcltfDNvyt18ajCx4Tov99PhxiYy8I332RWeW
         5gKisO4AFbWdGc4EGFHviRB/t6Rkqr8vV3f5z2HDP3Vo+UdxwX06FKBF3KBmRB0DOmML
         vgywV/rmorxcHnyjn7V3v4Kpik+jWDqdko7ZvsYNvdGo9w72I8ZVxHTbchW2/9s2UNii
         FbXQ+asuzXroKbut/PXg7YozCgvdozZ3D0QdGxafV/WoD3OpCuaVLAC/vFY9zjuVs8Yz
         8ffumjhOXAJpEBk1FgHgu7K3NPsH4Eyv8kAfS2/EAbbcO44q6S/adCdCchKPvanUN5xm
         PoTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722414362; x=1723019162;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DFjJ7n63paZS6uSG42PXEZWs1JHtvlpu1J7pCHV1MaA=;
        b=H0EII9/3qDIW8uDLXhPuZKXOPqEigRGzsru4p2hbm/KHYVAO8/BtIMEhwyTflaU3w5
         Wvrblyyh9bLN6K7dYT7qofM7S1LufnP7wtz99jf+Gz8l/Q6kWsRc6ELizdxKyomgA93b
         cfVr0jyI4wFYa/uYfTKHoZRBuY8LwO4AYFJX08YdfLb/ohoeLoECD+IM+pcCPNkkovl3
         4VqKpIH+nGrGlzwh9xV3L6iBzhoAX8Z+AUUW0pW6n/kuKWNWEX7G/oGQ+sfJtBXf4Au5
         JSPaVhFrv3nwJPZ2bkLrkNDO50Cm1dEvtryQvEZ6bzIXthpNg0iqxENmeZ/hHftbgD86
         ojSQ==
X-Forwarded-Encrypted: i=1; AJvYcCXE0YRLNUdFZ2I1z2l9hxThBbXfinwGIM5zUk7raFeU6RS6PXjSWCiZTgsv6e/2VWoh6gYiR8z50iLJ1FCTsEG9Pv0ss9YJH90UIaCo
X-Gm-Message-State: AOJu0YyXpUys30Zdfbz8hAHHffB2a3Il0LxxphTq/xyJM8vL1G0vLqcv
	1exFyuaSOPShN7hhYp7I86DSqH1df6nQslwkIsciwqW6NEgJjmKuiuJAG9M0YiNOLFiOTnOYQHO
	j1k4giSBo3SJnxtaySxcpfkm+8tNJTGxHTMeS6g==
X-Google-Smtp-Source: AGHT+IEZQxKOD7qrEVQxXh0yoroOagYvbnV14lRkkP0QqCJaL1USQW1bT0weUmb2OMtTj4zK11JciNIw6TA8x5ATMzI=
X-Received: by 2002:a05:6102:390b:b0:492:a7e5:df9 with SMTP id
 ada2fe7eead31-493faa417bfmr15098391137.17.1722414362030; Wed, 31 Jul 2024
 01:26:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240731022949.135016-1-yuehaibing@huawei.com>
In-Reply-To: <20240731022949.135016-1-yuehaibing@huawei.com>
From: Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>
Date: Wed, 31 Jul 2024 10:25:51 +0200
Message-ID: <CAG+cZ05LGBsNODyAaApS1uoPXPh7Cchp8utm_AAWoM09HZzOzw@mail.gmail.com>
Subject: Re: [PATCH -next] ASoC: fsl: lpc3xxx-i2s: Remove set but not used
 variable 'savedbitclkrate'
To: Yue Haibing <yuehaibing@huawei.com>
Cc: jonathan.downing@nautel.com, vz@mleia.com, lgirdwood@gmail.com, 
	broonie@kernel.org, perex@perex.cz, tiwai@suse.com, 
	alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org, 
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 31, 2024 at 4:39=E2=80=AFAM Yue Haibing <yuehaibing@huawei.com>=
 wrote:
>
> The variable savedbitclkrate is assigned and never used, so can be remove=
d.
>
> sound/soc/fsl/lpc3xxx-i2s.c:42:13: warning: variable =E2=80=98savedbitclk=
rate=E2=80=99 set but not used [-Wunused-but-set-variable]
>
> Fixes: 0959de657a10 ("ASoC: fsl: Add i2s and pcm drivers for LPC32xx CPUs=
")
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
> ---
>  sound/soc/fsl/lpc3xxx-i2s.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/sound/soc/fsl/lpc3xxx-i2s.c b/sound/soc/fsl/lpc3xxx-i2s.c
> index af995ca081a3..62ef624d6dd4 100644
> --- a/sound/soc/fsl/lpc3xxx-i2s.c
> +++ b/sound/soc/fsl/lpc3xxx-i2s.c
> @@ -39,7 +39,7 @@ static void __lpc3xxx_find_clkdiv(u32 *clkx, u32 *clky,=
 int freq, int xbytes, u3
>  {
>         u32 i2srate;
>         u32 idxx, idyy;
> -       u32 savedbitclkrate, diff, trate, baseclk;
> +       u32 diff, trate, baseclk;
>
>         /* Adjust rate for sample size (bits) and 2 channels and offset f=
or
>          * divider in clock output
> @@ -53,14 +53,12 @@ static void __lpc3xxx_find_clkdiv(u32 *clkx, u32 *clk=
y, int freq, int xbytes, u3
>
>         /* Find the best divider */
>         *clkx =3D *clky =3D 0;
> -       savedbitclkrate =3D 0;
>         diff =3D ~0;
>         for (idxx =3D 1; idxx < 0xFF; idxx++) {
>                 for (idyy =3D 1; idyy < 0xFF; idyy++) {
>                         trate =3D (baseclk * idxx) / idyy;
>                         if (abs(trate - i2srate) < diff) {
>                                 diff =3D abs(trate - i2srate);
> -                               savedbitclkrate =3D trate;
>                                 *clkx =3D idxx;
>                                 *clky =3D idyy;
>                         }
> --
> 2.34.1
>

Looks good, thanks.

--=20
Piotr Wojtaszczyk
Timesys

