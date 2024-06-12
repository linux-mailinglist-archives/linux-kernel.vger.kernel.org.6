Return-Path: <linux-kernel+bounces-211107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BAFD904D33
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 09:55:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB42A283B37
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 07:55:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 723CE16C6B1;
	Wed, 12 Jun 2024 07:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=timesys-com.20230601.gappssmtp.com header.i=@timesys-com.20230601.gappssmtp.com header.b="Af/GNqtC"
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0133716B73F
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 07:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718178910; cv=none; b=RdCfajc14CoDf9G7wmRFEH0qHBNyskSQFwWYLkTFPNr/+phvJ1pQmtS69/3eLPk0tLb8TjjpTqash1uxHpwjobh6yrQ5OduCssRYgWdWmW4FfcX7Uue9g5/q5IUEjBZOlll8I3y/Iba0OcKB24XwpPwUcFirhZuqIe/ofmuwEUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718178910; c=relaxed/simple;
	bh=/jcoXUR9wDP6KAAPbxMnAdcj2368TaJUtRP9CxBQamU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p+NZsbgyRbuaqDR3bS/aLwM7sB39AIckkNL2lMwquFwZfQAtMYro7Xkycz+sFZ6a7/aqTWc1h8Vk0j60lWYyOrgkp5QpEt0+KS3betaUnGnfMHGMx4UOO3zyOthU6qq+j4dL3pdz/QHAuBQyKmWhIk/Jd0SV8x4dJl9X2fwMXrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=timesys.com; spf=pass smtp.mailfrom=timesys.com; dkim=pass (2048-bit key) header.d=timesys-com.20230601.gappssmtp.com header.i=@timesys-com.20230601.gappssmtp.com header.b=Af/GNqtC; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=timesys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=timesys.com
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-dfb0ccbd401so3844742276.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 00:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=timesys-com.20230601.gappssmtp.com; s=20230601; t=1718178908; x=1718783708; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s8zvLumEmzHSVfDBX+K3KODMcTb3eNmXQ7W6gFdSMig=;
        b=Af/GNqtCTkyI2n74kjCoTQa2O4IpWQO7pwNbUD4DMkqFjuLpI9PNJx/iQvPMBYlSfH
         fnmXHerNMpYuCmU2a2vAg8e+dDTHIaPf81ZBb02eOEUGLcJU6kYNJH+fKK0yDAtozCsK
         FIXehBzv509pz24GxQ+DbAw1GRwL1WIqb1Xe2oKZIAsnSQwKKwZh42j1EV1024pSfc5E
         0RdzQJViPhK4kIOqV1ELzknGGc7ZQaPoK+iXouEdU3ay5FD+N/xg7+Y5Fg7W4ARQdZ4L
         ayeaq9+kxnbIganHelSaDuund1F8A9NjBbNar7UmCT/GblIPv2eFJPAtiJu5CUafKHRa
         9XPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718178908; x=1718783708;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s8zvLumEmzHSVfDBX+K3KODMcTb3eNmXQ7W6gFdSMig=;
        b=PGK4vV9mkMJq0sZbiOY/6yAuEDUogJuFr9mV7N7bWdS3fPWYn/ZO5Ml0f0MUtxGwUJ
         vqaPDTO6iIuWKRlZBLqC2u6FjiIKUqjkXml7zY8QeLvZbZv370MQCCTb9BnKsG+olRgw
         /7KAHgG9zpQfa0M2twMXni6IxakDErIhOcYbUZk4MTceehKrufsgVeMw3vZqm9IpWpqH
         5sGxhkB0r7m+zY0njFeXn4Vg5WyCIL83fkcgcNZFdNdGDTuLEwkOVygNyM6SfRgKwW7p
         JuCFbTRNgx8ZSVoDscH0G4epeyHpUAQwL+kPs3zuDYttFhcxlV/onWXWjOoybGvS48t6
         O8SA==
X-Forwarded-Encrypted: i=1; AJvYcCVLCXPN8C6A+lRxy95g7N/sI8SlkbnYG7w+thMstwYAj1gCeUPT4p048WVa1974l1zDHzoYDTIfwnJmdXFKfV2KNrrTbVCt/nmvlzS5
X-Gm-Message-State: AOJu0YzPFvm2BGjy8Blk2a1FKxmEz+7kFfXGE7ClE0EA0Xytx3PFQN1E
	dUjSnZlS342g1i6XN0PCzxEPJkPSY61qNQ0cO7GtkTRrTd8eUGpQXN0xP8IU7P6eZwK7qg4DfhE
	rFT4WyyRYkQdrz8M8eTlzVW0t4cOnlJ2OUqyEBA==
X-Google-Smtp-Source: AGHT+IFPLy4bDjB26DeJ3OyETqud+YR8g7kmBRh3/NifyRwyRcvSuS2NJ859y2s2TX4hnMNdepvtl112sIycLjmhYjk=
X-Received: by 2002:a25:918a:0:b0:dfe:ed7:84be with SMTP id
 3f1490d57ef6-dfe67064dedmr951615276.25.1718178907988; Wed, 12 Jun 2024
 00:55:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240611094810.27475-1-piotr.wojtaszczyk@timesys.com> <Zmgor8accyAiUkUO@finisterre.sirena.org.uk>
In-Reply-To: <Zmgor8accyAiUkUO@finisterre.sirena.org.uk>
From: Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>
Date: Wed, 12 Jun 2024 09:54:57 +0200
Message-ID: <CAG+cZ05=w5KbxOOtpo99B=OHBaLNRKKJVrFT67CH1-6z1gP7ZA@mail.gmail.com>
Subject: Re: [Patch v2 1/2] ASoC: fsl: Add i2s and pcm drivers for LPC32xx CPUs
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Vladimir Zapolskiy <vz@mleia.com>, Russell King <linux@armlinux.org.uk>, Jaroslav Kysela <perex@perex.cz>, 
	Takashi Iwai <tiwai@suse.com>, Chancel Liu <chancel.liu@nxp.com>, Arnd Bergmann <arnd@arndb.de>, 
	Michael Ellerman <mpe@ellerman.id.au>, linux-sound@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org, 
	linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 11, 2024 at 12:36=E2=80=AFPM Mark Brown <broonie@kernel.org> wr=
ote:
> > +FREESCALE SOC LPC32XX SOUND DRIVERS
> > +M:   Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>
> > +L:   alsa-devel@alsa-project.org (moderated for non-subscribers)
> > +L:   linuxppc-dev@lists.ozlabs.org
> > +S:   Orphan
> > +F:   sound/soc/fsl/lpc3xxx-*
> > +
>
> It seems a bit odd to add yourself as a maintainer while also marking
> the driver as orphan?
Nautel Ltd agreed to maintain this driver, I will add them.

> > +     i2s_info_p->clk =3D devm_clk_get(dev, "i2s_clk");
> > +     if (IS_ERR(i2s_info_p->clk))
> > +             return dev_err_probe(dev, PTR_ERR(i2s_info_p->clk), "Can'=
t get clock\n");
> > +
> > +     i2s_info_p->clkrate =3D clk_get_rate(i2s_info_p->clk);
> > +     if (i2s_info_p->clkrate =3D=3D 0)
> > +             return dev_err_probe(dev, -EINVAL, "Invalid returned cloc=
k rate\n");
>
> Nothing ever enables this clock.
It's enabled in lpc3xxx_i2s_startup() and disabled in lpc3xxx_i2s_shutdown(=
).
When the clock is enabled the bit clock on I2S interface always runs.
So this is to avoid active clock when the interface isn't used.

--=20
Piotr Wojtaszczyk
Timesys

