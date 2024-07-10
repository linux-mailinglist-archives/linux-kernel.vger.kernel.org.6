Return-Path: <linux-kernel+bounces-247161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5202392CC03
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 09:37:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E1E21B2376D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 07:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68A2783CCB;
	Wed, 10 Jul 2024 07:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="jcnnFT/3"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D578083A0D
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 07:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720597011; cv=none; b=eRyx4+aHA6t9N1bfN385vocyFsUpjUzbhOxyzXQu7OGDqQ4Gx8RQkgCTUtgoElJ0WxhjvzHuxXnV1p8ya7GRJY8iXGYX+6nNr67LbwNHXnCIVSMB38+q6fxbeh8sMlDXS4ith/wtUP7WctI1N74ZC/7PpUsU7kS5EiYZ29DQzDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720597011; c=relaxed/simple;
	bh=A3kqLCCwUuJuzMrYfQCFrZqwKdRl1NzfEjEktKbftFI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mV1vz4CuApKwQIEA0GlJRa3u/U3xDk/88PZoHh3fHkoqFL91nxbzGpWkqJok9xZPiXrIEGGoDOiP6PiZr17dk5+N7QxMAYS4IZekJgwUb0uO0QRG4uBkhOwLWpmffSIUm39L8SfoG4R21YHFiG4R9fiSWrGBmL+UDwGS4iOmnP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=jcnnFT/3; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2ee910d6a9dso57348031fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 00:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1720597007; x=1721201807; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yanBj91mPN2P41yJnyEyGDttLBJBewn5PScwOilvMW4=;
        b=jcnnFT/3YIR931oXtiGQd4PYyao2fMkW7JGEwhlbv5PPNwVgPQBA6BJIpVqhMqQ+0S
         vFbINBS0Ehl3Oul81MW52vAOSO1UHUlLRyVBCGsdeuNBYiMcp2bPShzygbJukCs6RiMM
         ab1B5CEkyYimbrdMNppt6aRegaKB19j7GPW0EjbORbhDI/x00hQWSNshC4K4ZEMUlruA
         s3c3WtvEU3BCtErfTMPz4+Nh2rHA+KbqXotp5qBZv3jssU6BExYB9VNoD5braSU0BjUg
         +StWwkEwXu0MRKvWqsQyBRcD+K+6/zgmwR0RMCV6ZRut1LL/lEuX5fJ7yaykYqk66Xv4
         T+0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720597007; x=1721201807;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yanBj91mPN2P41yJnyEyGDttLBJBewn5PScwOilvMW4=;
        b=d/xGsSvvM8sMr/j2V6MHPP5jhUCYHmfNUfiWk1AtnexKzdAYa8lWsO7OuowNe+S0ic
         T0s5N9wGVXBMhkt2eYkAK59/aRIbCZ3r2NMH7N3yNEtm5YHklwG5Hdg/4DRCPoXzxTjz
         E6QsJFJ/gskcnzx9CN4Pc7CyWZ4ACIe6QGJcsN2lmCzxt/AlYY28Xr2KtoWgiCbOtq6K
         om7yZM9n5YcynDS4FPMSM/m3Os1QcfTWWSWcSREGDrgMvKgpllut72gDXqd9mHATOhu4
         wmjGkqZn1L6+t8ETnqWCzeJJ+DBk62i+E6l8S/MgT5nx9fFrxbebMclndWQwBuN503DN
         A6Vw==
X-Forwarded-Encrypted: i=1; AJvYcCU+k6fw6FWvIB4dAw0icSvvXTPulhncRZ0XCX5824SRVPzzhH8ugT6aXz3z5dZX9HPQIE1vJO5dFETKcrDLH8vVy2mDZTTxyaR6PP7v
X-Gm-Message-State: AOJu0YycG0sNpy+26ITstTRGVQvhDcYEggtJ175gFFU1nm6qIdTcc89T
	HGPB9GoBs123iL2I2mKpmKvrSeiCuThk3oqZa9MVIIHhN4pa8LqY8hpZPr+ebLQ0VrzwQupasmX
	SAkiOTX2PJugjB+5autvhw41NlpbvA70F4zccQw==
X-Google-Smtp-Source: AGHT+IHZs0FPfAia+36yPoydAdjKd9uUEK7NtYAlPQW74MVYfWi86+EAwL5XKt/IjF+VmJLBrmsbpZnns7Y+ARRSQXY=
X-Received: by 2002:a2e:9892:0:b0:2ec:1810:e50a with SMTP id
 38308e7fff4ca-2eeb3188dcdmr29378621fa.32.1720597006848; Wed, 10 Jul 2024
 00:36:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240710031108.2002416-1-nichen@iscas.ac.cn>
In-Reply-To: <20240710031108.2002416-1-nichen@iscas.ac.cn>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 10 Jul 2024 09:36:35 +0200
Message-ID: <CAMRc=Mc=z86zN-ReK9++piirOE6Wgeq6BnEy15Os5Fx7Lqazdw@mail.gmail.com>
Subject: Re: [PATCH] gpio: mc33880: Convert comma to semicolon
To: Chen Ni <nichen@iscas.ac.cn>
Cc: linus.walleij@linaro.org, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 10, 2024 at 5:12=E2=80=AFAM Chen Ni <nichen@iscas.ac.cn> wrote:
>
> Replace a comma between expression statements by a semicolon.
>
> Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
> ---
>  drivers/gpio/gpio-mc33880.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpio/gpio-mc33880.c b/drivers/gpio/gpio-mc33880.c
> index 94f6fefc011b..5fb357d7b78a 100644
> --- a/drivers/gpio/gpio-mc33880.c
> +++ b/drivers/gpio/gpio-mc33880.c
> @@ -99,7 +99,7 @@ static int mc33880_probe(struct spi_device *spi)
>
>         mc->spi =3D spi;
>
> -       mc->chip.label =3D DRIVER_NAME,
> +       mc->chip.label =3D DRIVER_NAME;
>         mc->chip.set =3D mc33880_set;
>         mc->chip.base =3D pdata->base;
>         mc->chip.ngpio =3D PIN_NUMBER;
> --
> 2.25.1
>

Good catch, would you mind adding a Fixes tag?

Bart

