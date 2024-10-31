Return-Path: <linux-kernel+bounces-390492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CAF89B7A93
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 13:33:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0489FB21A67
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 12:33:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3448819DF7D;
	Thu, 31 Oct 2024 12:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="bS4eSJFL"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB24819CD17
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 12:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730377919; cv=none; b=j0USzOYPyO+ZPt1HRNUXt1ON/etRCFyjix/3cVdEhDsdgYiE9dQkecSfJ3nC0jRt+WvkM154IM7Y1NUXQKqNOmD8rKmH/u+UT0otRM3yGfsYV++oH5wh4rNU8HTbxPV6ffCoXk6z0vnquSxxAR14zYceq77FB4okWWo62cXn4wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730377919; c=relaxed/simple;
	bh=T/djKhs3eOqv5IVnSAIQZAs48CA6GiCxz5tnmaGumhE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NZ9Nbndu6glhe9s/uFqfLnj9QwsoYwmMd2kvhfrFLUGFl4i1/FGEM847HMbyescNqGwociHmGQmsnCyxSwoIJo/R7SNKtX4ga/mlo7S6NwKAV2PWb8T7suiuBWxRLYg8uVrUXjD2EPIrpaR/LlKvwoh0Ea6EtKIRwamOKdHVDns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=bS4eSJFL; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-539f58c68c5so1603644e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 05:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1730377915; x=1730982715; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RE8URFCScbHjW3Ww89/nIojvIj3WPenPaGkYQwybHKw=;
        b=bS4eSJFL+xA6HCPSrt4P+6x7V3bGJ6ua2Dwfb4jXFh2pp0HSfOZjobwf//FaH/j6Y2
         ERGI85hZFcSxZI7u0Gg4W3zo0GXC5dWI4tZFhEIx1jgegtR1mygG7a7z3FIZp3aL4E10
         cwhLl5MZXuJOdsgNsXjKbWljY6365It6W0vqRvrKSNkBbb3PDWb8wQJnlFisE99gox3B
         ok4lU9NhMbmMVlYX0IO3no7qjFwCyGE+0UEv6GFVHb5zqe2mmpHojepa4iKrqJlK1Kur
         5vzQUn0ts5ZKbvn9O7rkvd5agxny18yCclFbvyggb5zNJo04YfnncHzKh+MuSgegj/PJ
         oxnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730377915; x=1730982715;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RE8URFCScbHjW3Ww89/nIojvIj3WPenPaGkYQwybHKw=;
        b=hKWgogkIYD4TVopIfoS9hZa3VtvULTRg0CfHUE+rQYsh9ub9LwCsDDSD6Qr2q8uePX
         /BvisbbRZ+IuSAcDbEe+v1nHFyloT+71n+5MyZ0Vl4Rn9rqQSFwIUfA+uLzXBMDvxJxp
         B5cwZnsadkYTSia7v5qq7h1makCgiRcg+Grr9wB1EsKn58+yllcZKQHgzH3bfY5hDujN
         CP94bNM2jAqQDOewB6WMzgg7Svd03Duzsl9qWVyBelaKcIh3oY50WtEyptApedm337kV
         bIAp6VMf5ZE3+U2zC0i+xBfk4ilfWHIEcXhM7cTRpmye1puRMEYUyBIDi7gFP5yXL/fd
         P9dg==
X-Forwarded-Encrypted: i=1; AJvYcCV/sLByrtOqymbFl2it82ycXK/P09mkgRTMiWc6ktZJyApB30aPTQaFzzCEOsNNrvOYTj2ED55hDNBFdIU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyXS2g5M81QUSj96fnD5y9UJ1u0SfgdMCFKPuQLs84by53I0PN
	HheR8q+Jv9SQ02TAZsZrzctKxivLzvJOiLRvGBqYu7caL4p+Lgncmika6avqdA0+wwBx97AV13U
	endgYtZrhXqM8MS+fM5+jEn7M305Xljjn3Popzw==
X-Google-Smtp-Source: AGHT+IHk7/0knJa3on/RkBSjr4sydPYQGOXPjSErqohkzIytwrPwnqVQz+9RzJVNaVnusME5Ujvc/JRlrB8fG2nRpiU=
X-Received: by 2002:a05:6512:3d06:b0:52c:deb9:904b with SMTP id
 2adb3069b0e04-53b3491e062mr16246470e87.38.1730377914826; Thu, 31 Oct 2024
 05:31:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014122849.118766-1-brgl@bgdev.pl> <CAJZ5v0gAzZTa_TuQiFr1D7hKHw0eYF28s3ZBOv2ZFZTTC-Md8Q@mail.gmail.com>
 <CAGETcx9GfFsfWymBvXHs7F0S_mvK=eCy=q8-gBu1UPm9QzNVgQ@mail.gmail.com>
In-Reply-To: <CAGETcx9GfFsfWymBvXHs7F0S_mvK=eCy=q8-gBu1UPm9QzNVgQ@mail.gmail.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 31 Oct 2024 13:31:43 +0100
Message-ID: <CAMRc=MdxxfhXw8JP9We5Ty_gpiU+G9mUD2mgfPoQm8gaE=CX=A@mail.gmail.com>
Subject: Re: [PATCH] driver core: constify devlink class
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Saravana Kannan <saravanak@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 24, 2024 at 9:54=E2=80=AFPM Saravana Kannan <saravanak@google.c=
om> wrote:
>
> On Thu, Oct 24, 2024 at 12:45=E2=80=AFPM Rafael J. Wysocki <rafael@kernel=
.org> wrote:
> >
> > On Mon, Oct 14, 2024 at 2:28=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev=
.pl> wrote:
> > >
> > > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > >
> > > The devlink class object is never modified and can be made constant.
> > >
> > > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > Acked-by: Rafael J. Wysocki <rafael@kernel.org>
>
> Acked-by: Saravana Kannan <saravanak@google.com>
>
> -Saravana
>
> >
> > > ---
> > >  drivers/base/core.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/base/core.c b/drivers/base/core.c
> > > index a84a7b952cfd..0e618d675792 100644
> > > --- a/drivers/base/core.c
> > > +++ b/drivers/base/core.c
> > > @@ -553,7 +553,7 @@ void device_link_wait_removal(void)
> > >  }
> > >  EXPORT_SYMBOL_GPL(device_link_wait_removal);
> > >
> > > -static struct class devlink_class =3D {
> > > +static const struct class devlink_class =3D {
> > >         .name =3D "devlink",
> > >         .dev_groups =3D devlink_groups,
> > >         .dev_release =3D devlink_dev_release,
> > > --
> > > 2.43.0
> > >

Greg, can you pick this one up please?

Bart

