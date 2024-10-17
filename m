Return-Path: <linux-kernel+bounces-369989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B51CD9A2557
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 16:43:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 633861F21787
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 14:43:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3E0E1DE4ED;
	Thu, 17 Oct 2024 14:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="PTcsCFaS"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B5E61DE3AC
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 14:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729176208; cv=none; b=ZZ3NQiqlQ4tXDtDyYOirbW74TNKjcUCZaicHHleTzDd5cHv0s87rYzyBSrfl3AvDbp5SGtGusgDn13SNbI610hB6+RptC60NAm5F/FEM2x1KBSg76Nfhg3ZiLT6p5tyUR+VT3pRO5CasAjZgwxSmnYFR3a/KAGWGcPpHBrvvaIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729176208; c=relaxed/simple;
	bh=UjBFYKe60ecOXdv/EykcvXPrGJPVLEqALNLtsIb1yDc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tDdD+AnjmYrLvRGYeYgBI8/eem5CYvPB+d2c2WA5zljL5gkdcgRDMq4YRAzUeXDqXT45AajnEP6NlE42emuzchdLBJ2esC8NxaSvFiP6Cdlrrip3H/eKEAn50Mw03FUVrgEFiqnmu55mP6iyAcBxwwt/KJfjIl5hpHs28q8jH1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=PTcsCFaS; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2fb4af0b6beso18204071fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 07:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1729176201; x=1729781001; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xlFEzHaazLnpmF9YqMx0KYtmHI6sgbTNFiorl3kdp7s=;
        b=PTcsCFaSGo+wRAy3ny+EjVjVfWGYSa5vuuWjsOc0VnPB6xdzTxx5PMRWvcs11Bpcgl
         OE1SezJHTr02NX2cChV9NTmraulSbXoVPhXBvHPXmdfo3qxgS969yUXRQoTnOkyKuigO
         JpvbiopYV8crez5ft9PbAydckLhYYsHzfeaeDygbAQHlWoZ9B/KefY2Sxt2PdUp0YR2z
         FoVwhp8uHvpuRzjKNlMqLEt5V2veQenSnVm/gkoM81i/s2GuqZfptI7ja/5It2aO0imz
         mszFouQ7wVQBObfkiytvysdt490X5fcxZihaairbguFnSdmjrQA6Z3JKaTR6EFVIBx5O
         IZmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729176201; x=1729781001;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xlFEzHaazLnpmF9YqMx0KYtmHI6sgbTNFiorl3kdp7s=;
        b=cS5q4IZ3VHhpx7fcE18NfARVQjogo/LyPiu6FbsXH3oNdZeCJfO1v1InIKKd4QK2sS
         p93ALruSZPb9ncPqen98uSNvDWeiXlFbIG5Q6n55dsZeg70TTAAmNp/wAomuZYTszJOn
         h6IcgzkjUi/E1EwSvE4/csX0OdINgwILJMJWEGjgOv2e3hP8nLSuVl4ksPhDpFRsNMcw
         w8WoBH/mhy0Xe/knJS8eBzGmdZHjMoRweHjFs4RrAAdk0ItfxZ9KG933fLLs6jRty3wO
         A4z8M45CldmaaB2sFjjF4tZc9Jf0m2JMYiZl98XtocveLua+xpF00Puv/1H96NAG/pde
         cY3w==
X-Forwarded-Encrypted: i=1; AJvYcCVwPdGY7NCflCDixUe+0h7c1MhfjaVoa6Gd3X3Mp8spC5Fn4S4lLS4sH7H8jgwd7h/XMW+oWyomrcE08wg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDrBqZB/yEmESO1b0nbxexm6m54cYEyUI2HjKv6NpfNtj4SbXa
	dIzZAWCC+RG1WGBx6C4Jbp1UYQaDSqPzhbooV301rmbWUF8kvq9/hld2TCHCS8RImVbYZ5Prjre
	+MH68zmXQWtiUYi+7cnuPjhkfO+cq2ZkboKqBC0xXtVf7Sz0t
X-Google-Smtp-Source: AGHT+IFmNvFbz6qDkOnZvEFCx23p5SEWvvIyIIPpGOef8u5mkEu6REsm1UGa3oQmTEYp5G2voSMspTUWw/JZrRP36Zc=
X-Received: by 2002:a05:651c:1506:b0:2fb:62ad:89fa with SMTP id
 38308e7fff4ca-2fb62ad8e1dmr63534141fa.45.1729176201033; Thu, 17 Oct 2024
 07:43:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241017-gpio-notify-in-kernel-events-v4-0-64bc05f3be0c@linaro.org>
 <20241017-gpio-notify-in-kernel-events-v4-3-64bc05f3be0c@linaro.org>
 <20241017124418.GA221864@rigel> <CAMRc=Md=6WkwJRt7-7K0fTqOUMz3EzzOGLPbiq2SEw1+1Acc4A@mail.gmail.com>
 <20241017141605.GA242458@rigel>
In-Reply-To: <20241017141605.GA242458@rigel>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 17 Oct 2024 16:43:09 +0200
Message-ID: <CAMRc=MfYZKPg5oF1bSZKzDPapRLhTLWyKPSxf2b6Du5zwTzz8A@mail.gmail.com>
Subject: Re: [PATCH v4 3/8] gpio: cdev: go back to storing debounce period in
 the GPIO descriptor
To: Kent Gibson <warthog618@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 17, 2024 at 4:16=E2=80=AFPM Kent Gibson <warthog618@gmail.com> =
wrote:
>
> On Thu, Oct 17, 2024 at 04:13:14PM +0200, Bartosz Golaszewski wrote:
> > On Thu, Oct 17, 2024 at 2:44=E2=80=AFPM Kent Gibson <warthog618@gmail.c=
om> wrote:
> > >
> > > On Thu, Oct 17, 2024 at 10:14:11AM +0200, Bartosz Golaszewski wrote:
> > > > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > > >
> > > > @@ -1047,7 +925,7 @@ static int debounce_setup(struct line *line, u=
nsigned int debounce_period_us)
> > > >       /* try hardware */
> > > >       ret =3D gpiod_set_debounce(line->desc, debounce_period_us);
> > > >       if (!ret) {
> > > > -             line_set_debounce_period(line, debounce_period_us);
> > > > +             WRITE_ONCE(line->desc->debounce_period_us, debounce_p=
eriod_us);
> > > >               return ret;
> > > >       }
> > >
> > > Not related to this change, but this check looks redundant to me - th=
e same
> > > is performed where debounce_setup() is called.
> > >
> > > Want a patch to remove it?
> > >
> > > Cheers,
> > > Kent.
> >
> > Sure! Can you rebase it on top of my series?
> >
>
> Will do - once patch 8 is sorted - so v5?

I will send it out tomorrow.

Bart

