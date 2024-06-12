Return-Path: <linux-kernel+bounces-211101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A2919904D1D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 09:49:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B52B01C24454
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 07:49:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76C7616B73F;
	Wed, 12 Jun 2024 07:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=timesys-com.20230601.gappssmtp.com header.i=@timesys-com.20230601.gappssmtp.com header.b="V/KAydYX"
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B810516B736
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 07:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718178549; cv=none; b=jZW9VQb57RvNfI7iABcS49HHQsLWYv9qkVWWnVLBawjMkIUz/fCdQCR5RncQFA2veKY5mQj+5BmjuEPwNIzbn+0gHFmz6vSMTjMhAULH/SAAT862IRdF1DA/5q1peIa4k2qzju0uK0Gzv9l2fD8rGS0Xd4voFMQ2lrIxm6IsgoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718178549; c=relaxed/simple;
	bh=3wDlt0rm1YoJeMtoYXnJF3HN3gpF6lAx5EVTQ33RwdQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E2qr6if1t43i4ywPEd9LWV/6NcUt9o+7hknap48U45QVKXNgk97dCwuJcg8q3rlfQ2rA6azGPMb4oDrF3EuRpCZwDSfyM9Z1+IcxZVAKTnwNZBYcXy1e9Nu0V4iIkKU1faaHjQe/nQTgdxi9j94+3uBu+oNbT4k7yxI0ffN9eyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=timesys.com; spf=pass smtp.mailfrom=timesys.com; dkim=pass (2048-bit key) header.d=timesys-com.20230601.gappssmtp.com header.i=@timesys-com.20230601.gappssmtp.com header.b=V/KAydYX; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=timesys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=timesys.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6aedd5167d1so10584416d6.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 00:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=timesys-com.20230601.gappssmtp.com; s=20230601; t=1718178547; x=1718783347; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QLcH5YJaXuB/7MGBHEHfOlicw3pcEYZxxPQWbcZpzrg=;
        b=V/KAydYXeMFwlSSFalIpZBavr/GbX3ePysa9Db3w85YChaHtRYfUaqYTNCm7VE3T0u
         PPPFve/A8qZjO+GnteX7XhMEa5yL8h4CIp/4k0LO7XVnffEDRi+oilzry0VSXb9Qn9ME
         R1TaHZ1X9OA6iFm8UkOfr/jRLB/uZyy2HrgUGDZzlNBjOXMsKpnhafTkRzt0MTyY2ksd
         wht85LtIjhC05JzdJd8HEHCDoWgFj8QKPY09mq8v9+78pIl0cHss3cFdvo+0EMulQGzX
         e/WG5D4ogtPGdITOXswqyEf3D1V7wPPgG37xEwrpNmueETAdyjLiqvcjomzdGiiDKn+/
         ENkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718178547; x=1718783347;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QLcH5YJaXuB/7MGBHEHfOlicw3pcEYZxxPQWbcZpzrg=;
        b=N6nB/KXKN88k/Dhm+vMS0poowRvmXA4wcTDb9Dy50mbg2YIrkEw3W7k90KUvLwMVMk
         kqM6TQDdyTZW7kBXpSLq2KiujCQcxzUMhPibPWNeUb9W13BkTYn/vtCXrCCF0KRRk5F0
         P7/sBSCDrw0qPTcWcaxbwyw0m4vWBvj1inwAQescJYCMVOGXdOJKpxbi5UFBcgoU+T+c
         uUZU+ffZggbvRXZHT1ZqxeUmyGqb95slcx5CqMUw9vWH2DbP7rmFVw+FYbAN2OpBSPut
         OT8DBptkZ2rMjqonmHXv0M3CyuVaXAA2OuTSyjUCmAGJm5vbGHYFXXbjaUrPB+sariuI
         e8yg==
X-Forwarded-Encrypted: i=1; AJvYcCWYRCatenjtD2wpLLeLwZtJOMcX68arHqGVQzoBqKsTbZTiSe3Ujz6XWMeE8Xwidns6HaRvXRZBuTX4vw1uAucd/FjLsU6dcwCh2FCi
X-Gm-Message-State: AOJu0YwdlGG58T4fBJ0srfvhkJR4pGtxM6iDmF8+dZMquyjc2V9w3BZp
	zxokrf6fODlcTjCgIFM8eYg9/GSS0A42lGJ/we/tUtUPFGunacISVV9BadeD4FHl1DV4/vK4Bt2
	Mhkbvzm+CqowT9ZR5vxu/rsnoA6MXr7IJyQRl/g==
X-Google-Smtp-Source: AGHT+IFeCV50FnVEaMqclrtqDNFKqc6xUL0MAu5JUv82YAmzpGH5pe7N5VXTefcxSlBdNwkvmPPJIXMcRjw3+tCTj+0=
X-Received: by 2002:a05:6214:460e:b0:6b0:6b78:e608 with SMTP id
 6a1803df08f44-6b19230ddb2mr12311056d6.31.1718178546635; Wed, 12 Jun 2024
 00:49:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240611094810.27475-1-piotr.wojtaszczyk@timesys.com> <6cd2897f-a61d-4351-abac-714bae2ab154@kernel.org>
In-Reply-To: <6cd2897f-a61d-4351-abac-714bae2ab154@kernel.org>
From: Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>
Date: Wed, 12 Jun 2024 09:48:55 +0200
Message-ID: <CAG+cZ06kf-n339XHnOiOzSECNkxVLYVw5UvtiWZwkDx5VFHa8A@mail.gmail.com>
Subject: Re: [Patch v2 1/2] ASoC: fsl: Add i2s and pcm drivers for LPC32xx CPUs
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Vladimir Zapolskiy <vz@mleia.com>, Russell King <linux@armlinux.org.uk>, Jaroslav Kysela <perex@perex.cz>, 
	Takashi Iwai <tiwai@suse.com>, Chancel Liu <chancel.liu@nxp.com>, Arnd Bergmann <arnd@arndb.de>, 
	Michael Ellerman <mpe@ellerman.id.au>, linux-sound@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org, 
	linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 11, 2024 at 12:15=E2=80=AFPM Krzysztof Kozlowski <krzk@kernel.o=
rg> wrote:
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index aacccb376c28..7616f61d6327 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -8909,6 +8909,13 @@ S:     Maintained
> >  F:   sound/soc/fsl/fsl*
> >  F:   sound/soc/fsl/imx*
> >
> > +FREESCALE SOC LPC32XX SOUND DRIVERS
> > +M:   Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>
> > +L:   alsa-devel@alsa-project.org (moderated for non-subscribers)
> > +L:   linuxppc-dev@lists.ozlabs.org
> > +S:   Orphan
>
> Not sure if we want it in the first place. Why would we like to support
> orphaned drivers? Sorry, if there is no one to care about it, then it
> should not be merged.
>
I contacted Nautel Ltd they agreed to maintain this driver so I will add
J.M.B. Downing <jonathan.downing@nautel.com>
as a maintainer.

> > +static int lpc32xx_i2s_remove(struct platform_device *pdev)
> > +{
> > +     return 0;
> > +}
>
> You did not respond to comment about this. Drop.
I will remove empty functions

--
Piotr Wojtaszczyk
Timesys

