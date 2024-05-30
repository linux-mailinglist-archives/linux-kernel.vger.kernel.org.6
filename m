Return-Path: <linux-kernel+bounces-195160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3937C8D485F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 11:23:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E31A6284396
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 09:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F820176ADB;
	Thu, 30 May 2024 09:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="fii79ogI"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 396D6152527
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 09:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717060937; cv=none; b=Bo6u/sijwJ6LxnRZYsbMa5MidobmpYoHBRQ2PcTjvX1FvfZk2fgHClEF5oEPk3ng6TWqtYQQwENbz+oQGVYIPtMCGbUu4/8Qxlyti8lMwnX5pCkX0KDMYhjc7QZDhT7h1xtCL22Q018xNuWMYh5N62mM+L47hMr36xhm2d73wt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717060937; c=relaxed/simple;
	bh=qOALaBFtiFKu1Kyw1uTvIGvPyHrAyxbJXFr9phnkPyY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ocbhb/kbQGtkgnH2pRMbuh/9dXhtaQnyumAyMMHi6vsLOMdO/pfmrAOb87ByxTNqpYluRq7LNVpIpQeNmNG2n32YRMMuBnnGz8K8OUtk/76dqvBSb6slO8IMu7/RgTGlEH6zP0mJA7mwmQTaDHsNM9Gpfbs+GZHloADkT/GMF+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=fii79ogI; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2ea829329c7so6370691fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 02:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1717060934; x=1717665734; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m/z6JrsczbGlJdeagCzokQ7NOChpkizM9tHLk7nwYHc=;
        b=fii79ogIkC7xdQ1nsc6mICrncqiHNkHV8jApegjieRDlTLV9ThjAUQm2XM7riBUT9S
         9+1egyZekVeo5VhlqLN3tn2SzD0QH7E+SJAx454M9YbasrQQ12dUVCOSzwOoVvSC4pFR
         UZcXjJ/ULNmP1GZ229seLXhThI0HMVAiWS5uTYRyZYI9+RO9jIcUWrbqrKbuXoh+tARk
         6RpkKOC49RIKt/4BAf62EAnxpPbOte9dOyxfDLoOXnAO9xWp5r3jw+IRcUo5bPA4Dq4C
         AZJJVlb66Ba6NBG3kQrZMms8EK6ftju6AKQM2WR2gH9ARy6Hsgj8KBMiEn7a1yJ1y7og
         cLrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717060934; x=1717665734;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m/z6JrsczbGlJdeagCzokQ7NOChpkizM9tHLk7nwYHc=;
        b=Ik0ApHJ0f3yaIT7ZDc7xW5hUfM+2M/zsIIjh41x9gI9vh4v4+TJuOu8DF3tFq5JEvA
         rk5PVqKKZp3UlitGFDWN6JfxlgJyPQtpnA1g4a7ym2JC94Cxy+U8gq7RZkJ4B4b7V7xC
         V/6NY2FDrovGlcpQGRGVg2thtmt1QZ8+HvO3TNv6m8P6AEymse49HNljAcT7y6k6O8DS
         kQAOmsTUsExXhvTBqR43Xc8n1nC/prHk7roISZ6zZJxC0TBldKIll9OqmFiOj5FcAAF2
         DfUqtPfDuGcFrvJjMsKyqLxkfq1TutU8FlL+9kb0E4hVbwfJontwoO4HEAlUQdjSLhgT
         /7Kg==
X-Forwarded-Encrypted: i=1; AJvYcCWK6qL2pDHLkYvwLslgHl1M4J2H44qG4A24HQjvqHDy1YTZUo4J63ty1jg5I+GganH5cpj5QT8lWCuF+KAdJj7/VpOHS7GeKZC7RDAl
X-Gm-Message-State: AOJu0YzSFSY7+/5ZQe7+BoGk5031zovg8mY78TzZibM/ngDhEnA1Mda9
	iLxqILtlgbIwNKmXdvBKS+Hs09RJdfXfHcCPYYaaQ+xbxkvFzm4X5uc23Oxn7t7x60nY8uHa8Wn
	ThB9YrH6KKNStXaO0RGpsrh60AA/eXheswczV3A==
X-Google-Smtp-Source: AGHT+IGRJ3Rf6Gezxv9hcamuYQlhVWVAgV+Pbef78MTY3m0hnhXDE53keEkjqkBHl1Toem6mykR6y8+l+5Vju2z3wBI=
X-Received: by 2002:a2e:87d4:0:b0:2ea:8027:a6a7 with SMTP id
 38308e7fff4ca-2ea8488ac29mr6544131fa.50.1717060933982; Thu, 30 May 2024
 02:22:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240527132345.13956-1-ilpo.jarvinen@linux.intel.com>
In-Reply-To: <20240527132345.13956-1-ilpo.jarvinen@linux.intel.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 30 May 2024 11:22:02 +0200
Message-ID: <CAMRc=MdWLzA=PYJg_6pq-doZ807S2w4Lo6SyLMkbVi41zdzzTg@mail.gmail.com>
Subject: Re: [PATCH 1/2] gpio: amd8111: Convert PCIBIOS_* return codes to errnos
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Dmitry Baryshkov <dbaryshkov@gmail.com>, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 27, 2024 at 3:23=E2=80=AFPM Ilpo J=C3=A4rvinen
<ilpo.jarvinen@linux.intel.com> wrote:
>
> amd_gpio_init() uses pci_read_config_dword() that returns PCIBIOS_*
> codes. The return code is then returned as is but amd_gpio_init() is
> a module init function that should return normal errnos.
>
> Convert PCIBIOS_* returns code using pcibios_err_to_errno() into normal
> errno before returning it from amd_gpio_init().
>
> Fixes: f942a7de047d ("gpio: add a driver for GPIO pins found on AMD-8111 =
south bridge chips")
> Cc: stable@vger.kernel.org

I dropped these.

Bart

> Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> ---
>  drivers/gpio/gpio-amd8111.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpio/gpio-amd8111.c b/drivers/gpio/gpio-amd8111.c
> index 6f3ded619c8b..3377667a28de 100644
> --- a/drivers/gpio/gpio-amd8111.c
> +++ b/drivers/gpio/gpio-amd8111.c
> @@ -195,8 +195,10 @@ static int __init amd_gpio_init(void)
>
>  found:
>         err =3D pci_read_config_dword(pdev, 0x58, &gp.pmbase);
> -       if (err)
> +       if (err) {
> +               err =3D pcibios_err_to_errno(err);
>                 goto out;
> +       }
>         err =3D -EIO;
>         gp.pmbase &=3D 0x0000FF00;
>         if (gp.pmbase =3D=3D 0)
> --
> 2.39.2
>

