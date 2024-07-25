Return-Path: <linux-kernel+bounces-262483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F41F93C791
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 19:13:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB8DD282D56
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 17:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38A0019D8A7;
	Thu, 25 Jul 2024 17:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MTRaO65A"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9716019AD8B
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 17:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721927586; cv=none; b=B4dcRNemXAoiTjAekFoK4lj5jeJIdha1fV9ijpuKkzrF+21uGjwbbaG8HjS9EKGYAGShILHJyxNSj/ZvM5SjJ/eoWMCDYd0z8aimt3G2D6v+BO06QEcaZXHOxiijnQFy0SZJbYvBl8LKtPbfW90sxumQ0OKKbQOEiLIzBo4WJ2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721927586; c=relaxed/simple;
	bh=wOUCo27BqX6vHh5Z9R76o9tSjf6tkq9xO1s0YkU3m+o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hE5Er56RsZR5JoaK/b8UGHIJ5IJbCRYoaJLvELrQEQABcjazQtMixp2G/TjfBNuXcYC+zdMTr0L32EmqbAvuKhYwMAmmEJj70r8MKkdvUB5bu9rPYVzQY/2Ct6fWSN330sxxqlODyz34+1YhJ4VdBT5n0FpTwQniuStujFsOsIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=MTRaO65A; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a7ab76558a9so140169366b.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 10:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1721927582; x=1722532382; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NjrU16gk7V5PUkFrLMr6PZnUJ6/u63NLBDO5kUa3PxY=;
        b=MTRaO65AsUX2/71fk58YUIIHM+togo10POuwvTnWKWpugzq2mL/y5Fn10t0rnRhlzS
         tYqTJsJMBpayqSYJMPG5J5heTJOucyNuI+mq3xXsJj3kjH8d7rqWa1aIrOo1DgTLPVfj
         Lbqz2Cz61zochpOkHDXxipghJnUsmnt0zTnaw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721927582; x=1722532382;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NjrU16gk7V5PUkFrLMr6PZnUJ6/u63NLBDO5kUa3PxY=;
        b=FMYy1bVn4pqVBh+xRumyHTKotEozY/GzfRsBnCkXhbDVibh9Z6CSJa5uy9djutzRJ8
         0bohOCZ/DkMEfrltLNLg5n598GUTThf7qaqjkFeB8Z5hwdLN/dwzuDwiYg5wB4s5FhOo
         LRafOESL7rRQG/meOFhxFsHMRVuEBE/UmxG0QjC15R0KOzhq5aAcFlGqOSkaaJ2Pz7Ad
         0VjJAyV02gqW2he0rMioHlbd8dPEwYpAwdvHLKGyoCZC5YvRJLhUasXBgGJjLyAeHFKC
         2H0xOrw0dGybyi+7n70VtsjJENWsSyG/ETAlO96xwB+iHQ6ddSAb7oIc9iswZci+q1X4
         DMtA==
X-Forwarded-Encrypted: i=1; AJvYcCXNEVOEIMFaAl4oIHrRwXO43Bl0O9ZdvGr758x6W/tuicMyts45NvOP5D2/Yt7BPUOoiJOTHkwo4r+9NJCgVEOl8rLKU/IXqP0ax7HY
X-Gm-Message-State: AOJu0Yzyclc6UeCMNxmKJBFZl5iGQYoggR0reZRfdoVyV5cgMNMWXPOE
	elfmRinrV9eWJLznPqC+arvoqpSwBbim6fKhKQls/q/UlKrXVVtyjn8fksJVbqzynq54afUX4vk
	CqA==
X-Google-Smtp-Source: AGHT+IGT5WduXpIstJYnc26XiPdPv2H/C0T7tYVlgI7ujMGB/l74yw2zFdIa9MhFQQw4tcFhC3Jmdg==
X-Received: by 2002:a17:907:3fa4:b0:a7a:a138:dbc6 with SMTP id a640c23a62f3a-a7ac44dc5acmr433042066b.8.1721927582061;
        Thu, 25 Jul 2024 10:13:02 -0700 (PDT)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com. [209.85.128.43])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acab23f62sm92003966b.16.2024.07.25.10.13.01
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jul 2024 10:13:01 -0700 (PDT)
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-427fc9834deso2345e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 10:13:01 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVkw8kuuwjY1UVD0HEC61FCX53cwtAuxSPaeyrr013hJ65ZTZ4E35Xf81KTcN5e7FvvPpbMUKFTF+Z6TDfGX+QpXhWqF6s5RbfFwex2
X-Received: by 2002:a05:600c:4f09:b0:41a:444b:e1d9 with SMTP id
 5b1f17b1804b1-42804ba9b91mr1640015e9.4.1721927580731; Thu, 25 Jul 2024
 10:13:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240724122447.284165-1-tejasvipin76@gmail.com>
 <20240724122447.284165-3-tejasvipin76@gmail.com> <877cdakdq9.fsf@intel.com> <20240725-psychedelic-benevolent-muskrat-c7fd57@houat>
In-Reply-To: <20240725-psychedelic-benevolent-muskrat-c7fd57@houat>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 25 Jul 2024 10:12:46 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WbXdnM4or3Ae+nYoQW1Sce0jP6FWtCHShsALuEFNhiww@mail.gmail.com>
Message-ID: <CAD=FV=WbXdnM4or3Ae+nYoQW1Sce0jP6FWtCHShsALuEFNhiww@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/mipi-dsi: Change multi functions to use quiet
 member of mipi_dsi_multi_context
To: Maxime Ripard <mripard@kernel.org>
Cc: Jani Nikula <jani.nikula@linux.intel.com>, Tejas Vipin <tejasvipin76@gmail.com>, 
	maarten.lankhorst@linux.intel.com, tzimmermann@suse.de, airlied@gmail.com, 
	daniel@ffwll.ch, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Jul 25, 2024 at 1:28=E2=80=AFAM Maxime Ripard <mripard@kernel.org> =
wrote:
>
> On Wed, Jul 24, 2024 at 06:32:14PM GMT, Jani Nikula wrote:
> > On Wed, 24 Jul 2024, Tejas Vipin <tejasvipin76@gmail.com> wrote:
> > > Changes all the multi functions to check if the current context requi=
res
> > > errors to be printed or not using the quiet member.
> > >
> > > Signed-off-by: Tejas Vipin <tejasvipin76@gmail.com>
> > > ---
> > >  drivers/gpu/drm/drm_mipi_dsi.c | 20 ++++++++++++++++++++
> > >  1 file changed, 20 insertions(+)
> > >
> > > diff --git a/drivers/gpu/drm/drm_mipi_dsi.c b/drivers/gpu/drm/drm_mip=
i_dsi.c
> > > index a471c46f5ca6..cbb77342d201 100644
> > > --- a/drivers/gpu/drm/drm_mipi_dsi.c
> > > +++ b/drivers/gpu/drm/drm_mipi_dsi.c
> > > @@ -814,6 +814,8 @@ void mipi_dsi_generic_write_multi(struct mipi_dsi=
_multi_context *ctx,
> > >     ret =3D mipi_dsi_generic_write(dsi, payload, size);
> > >     if (ret < 0) {
> > >             ctx->accum_err =3D ret;
> > > +           if (ctx->quiet)
> > > +                   return;
> > >             dev_err(dev, "sending generic data %*ph failed: %d\n",
> > >                     (int)size, payload, ctx->accum_err);
> >
> > A maintainability nitpick. Imagine someone wishing to add some more
> > error handling here. Or something else after the block.
> >
> > IMO the dev_err() should be wrapped in if (!ctx->quiet) instead of
> > adding an early return.
> >
> > Ditto everywhere.
>
> I'm not even sure why we need that parameter in the first place.
>
> Like, what's the expected use of that parameter? Is it supposed to be
> set in users of that function?
>
> If so, wouldn't it prevent any sort of meaningful debugging if some
> drivers set it and some don't?
>
> It looks to me like you're reimplementing drm.debug.

I can explain how we got here and maybe you can explain how it should
be designed differently.

1. The majority of MIPI panels drivers just have a pile of commands
that need to be sent during panel init time. Each time you send a
command it technically can fail but it's very unlikely. In order to
make things debuggable in the unlikely case of failure, you want a
printout about which command failed. In order to avoid massive numbers
of printouts in each driver you want the printout in the core. This is
the impetus behind the "_multi" functions that were introduced
recently and I think most people who have looked at converted drivers
are pretty pleased. The functions are readable/non-bloated but still
check for errors and print messages in the right place.

2. As Tejas was adding more "_multi" variants things were starting to
feel a bit awkward. Dmitry proposed [1] that maybe the answer was that
we should work to get rid of the non-multi variants and then we don't
need these awkward wrappers.

3. The issue with telling everyone to use the "_multi" variants is
that they print the error message for you. While this is the correct
default behavior and the correct behavior for the vast majority of
users, I can imagine there being a legitimate case where a driver
might not want error messages printed. I don't personally know of a
case, but in my experience there's always some case where you're
dealing with weird hardware and the driver knows that a command has a
high chance of failure. Maybe the driver will retry or maybe it'll
detect /handle the error, but the idea is that the driver wouldn't
want a printout.

Said another way: I think of the errors of these MIPI initialization
functions a lot like errors allocating memory. By default kmalloc()
reports an error so all drivers calling kmalloc() don't need to print,
but if your driver specifically knows that an allocation failure is
likely and it knows how to handle it then it can pass a flag to tell
the core kernel not to print.


So I guess options are:

a) Accept what Tejas is doing here as reasonable.

b) Don't accept what Tejas is doing here and always keep the "_multi"
functions as wrappers.

c) Declare that, since there are no known cases where we want to
suppress the error printouts, that suppressing the error printouts is
a "tomorrow" problem. We transition everyone to _multi but don't
provide a way to suppress the printouts.

d) Declare that the _multi functions are terrible and undo all the
recent changes. Hopefully we don't do this. :-P


[1] https://lore.kernel.org/r/p7fahem6egnooi5org4lv3gtz2elafylvlnyily7buvzc=
pv2qh@vssvpfci3lwn

