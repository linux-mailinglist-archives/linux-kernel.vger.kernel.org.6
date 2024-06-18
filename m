Return-Path: <linux-kernel+bounces-220145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7D0290DD6D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 22:25:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D44A01C21F83
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 20:25:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25D421741E9;
	Tue, 18 Jun 2024 20:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qXXXbIE+"
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7538039AEC
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 20:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718742338; cv=none; b=YIP8Jb+WqymNPeeoDb4kz6vVG/b4yOUMeGGyKQ0VBrgEn3o2GjrKDN5m8PgKYgx34QxaMpxNoF17ZIiM4sU4acP0AoLEAQw1UgPA6vkB9N16HXTiyN0HGqYIvsAzrzlkbqbB16fbJ3HjliFtiIKLG8ovlulrtSmci/GDJhbxr6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718742338; c=relaxed/simple;
	bh=YRwOsnVFLe6p/kcwQwqv47N4rgTeTPM2k+Ln+QF8Fh0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UN6eMpkFHmsNzwpcA0lyiX2Uvh00aR4yfzeMMk/mZyqj3dX8QKelGDLaNvJoUNq5jN9+O0ZfPsXIr1tgGpS4VLwRj5EEEepY9BmnI5+dY0YgZopyRSWjuHPftfxkwKAe8xx04LPf35Ky6FY7yAWdVXysMHhlMr7AHcLJwbuywik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qXXXbIE+; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-6312f1f83d9so44265347b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 13:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718742334; x=1719347134; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w90+p3jzlFRMUniSo2b8ogKD0Fur+lnhSGZA3lnaqUs=;
        b=qXXXbIE+NKRMPRbDJwPrtNn5CmdceaKOHH5JlhyyOQlJKlNuQGoJ4mGPoe1VMNZKcU
         6Vi/ekRKMExenrWocUrnrXnSc1vWoRQq+AAGVybfWkfN+pgH9l4jOGPuMuI6eXeaZRzb
         XQCZlrvX+VpNACZDxILsOiOjELsyZmmSmp87DiK6KxbnhTB7MRWlwTSaRTK+JHhwcQTt
         Ol7AB/Xrv1uib6sDl+LwoD3L3c0WNrFyzy3X2dT8AOj8sooho/3dgT+K64j8SAut96NO
         ad4LNaHr8toHP98dw/9jGzMUpAUcrOeURfOz1pUGagpMPEU67nC+zZjib9XRUxi8ehTW
         WTOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718742334; x=1719347134;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w90+p3jzlFRMUniSo2b8ogKD0Fur+lnhSGZA3lnaqUs=;
        b=fSxkVXCqqa6vYd1NLN3Tg8S+lIz+ZQUkFzVMhmqxA1RXFxXTzd4PnADZUdEoFMaV/5
         0WVv3qxadxYaNyHBKo7UivvvebSUrM+eQ8XS/va6QAPzBjXPEoJvdrFJ4g0tH6toUXHA
         6uuzN6G05VuaCNUmZ5gMZQ3RzrAMcLs3oeJhFmqrUINhQZlKIeEVCKwfmy6KNAXifkJq
         MCzioh64ZLadeDEBJfdkbKPubkNKJaHCOxgK0YE8p6rSfRnMr8WO+tNooU3/DTba2hkN
         9ta66BzDjJmf3YYfz/Wqhu2MNBJJrFmXtTo4Dsh/hKjQglmcN5jEAiMnwmFOIsh27jZE
         4bGQ==
X-Forwarded-Encrypted: i=1; AJvYcCW5sPp9q/PH8ZKiXeMmPQ9SeQAC89lPmj3REtWs0880WGeFElRj8Pd97183ai55lBKuHj5WnzYhorcxvWuI0ZZsMDcFszN8ZLXVVDsL
X-Gm-Message-State: AOJu0Yz9g4bGhNx2QNeJ4yH2LlO1NHZ68AVIW6F+4Y8fUyEIB3U1/AgY
	h0OtuCVYqQOWtYjbh/g8rqHouWSXWF5d5Jh4DmhIQpmgMJrDMBuPGSJADG3XC+tcE+8P0Bu1p9T
	AU4BvJ5GLWhLb11rY5FfiuyO1rJ2jOFtJ/hgHcw==
X-Google-Smtp-Source: AGHT+IGpLhokgo384YPPtzeum2gZbC5i+iA9FZlR28A17rfQt8gwax2e5rYT0RauGBa3Y+2aEIDe9j1FBX0e6anXkkM=
X-Received: by 2002:a81:7e0d:0:b0:62f:37c9:77bc with SMTP id
 00721157ae682-63a8ac68875mr9831877b3.0.1718742334043; Tue, 18 Jun 2024
 13:25:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240618003743.2975-1-semen.protsenko@linaro.org>
 <20240618003743.2975-7-semen.protsenko@linaro.org> <94d50353-15ba-4769-bd98-57f4430f5fc2@kernel.org>
In-Reply-To: <94d50353-15ba-4769-bd98-57f4430f5fc2@kernel.org>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Tue, 18 Jun 2024 15:25:23 -0500
Message-ID: <CAPLW+4mHA4GHHX8TQa-CvMkYBU8me=q=cxKXLWwypGxpOtMpCQ@mail.gmail.com>
Subject: Re: [PATCH 6/7] hwrng: exynos: Enable Exynos850 support
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: =?UTF-8?Q?=C5=81ukasz_Stelmach?= <l.stelmach@samsung.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Olivia Mackall <olivia@selenic.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	Alim Akhtar <alim.akhtar@samsung.com>, linux-samsung-soc@vger.kernel.org, 
	linux-crypto@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 18, 2024 at 1:39=E2=80=AFAM Krzysztof Kozlowski <krzk@kernel.or=
g> wrote:
>
> On 18/06/2024 02:37, Sam Protsenko wrote:
> > Add Exynos850 compatible and its driver data. It's only possible to
> > access TRNG block via SMC calls in Exynos850, so specify that fact usin=
g
> > QUIRK_SMC in the driver data.
> >
> > Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> > ---
> >  drivers/char/hw_random/exynos-trng.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/drivers/char/hw_random/exynos-trng.c b/drivers/char/hw_ran=
dom/exynos-trng.c
> > index 98b7a8ebb909..3368a08df9ce 100644
> > --- a/drivers/char/hw_random/exynos-trng.c
> > +++ b/drivers/char/hw_random/exynos-trng.c
> > @@ -333,6 +333,9 @@ static DEFINE_SIMPLE_DEV_PM_OPS(exynos_trng_pm_ops,=
 exynos_trng_suspend,
> >  static const struct of_device_id exynos_trng_dt_match[] =3D {
> >       {
> >               .compatible =3D "samsung,exynos5250-trng",
> > +     }, {
> > +             .compatible =3D "samsung,exynos850-trng",
> > +             .data =3D (void *)QUIRK_SMC,
>
> Probably this (and in previous patch) should be called flags, not
> quirks. Quirks are for work-arounds.
>

Thanks for the quick review! Will submit v2 soon with all the comments
addressed.


> Best regards,
> Krzysztof
>

