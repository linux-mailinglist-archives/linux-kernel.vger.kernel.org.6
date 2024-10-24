Return-Path: <linux-kernel+bounces-380586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA6939AF303
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 21:55:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D6C7284485
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 19:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62FC01FE0F6;
	Thu, 24 Oct 2024 19:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RbBbn434"
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F6B719CC09
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 19:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729799687; cv=none; b=hwlzH/ZGNX8fWqZkWx2LBvXRYWLuKiOtJ7eJyoLw8wGuGRl2FKztDjZkKq93hPsHw9V1vjqMo4OxDfNi8WFkg9Qca5ScBF43KqwbzrB38SlEUwLQtHw9MKzxH4KNlr4mWNv9Klo9DtpHtUJEAhia6CZxVjG7jkzPPMsdalDQhWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729799687; c=relaxed/simple;
	bh=017JTj+baslXlAKfez7r/+5XllDUx+IWvlfPfoSSLlc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lQwv3O73D0EvFJ9e3Xh1DsYxwbDS27yYAAP3C6BRmCbqYH24tay7PZmeZQK0wupdEOqeylVNKGji1kbitL4ijlrWBjmSlP/ro+1hknYQsftxileOMCNLOJYsmL9X0EwIfDQQJs4/ePl0K4fCeaufa0eqR2n0mKKE0XxdIQSk5t8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RbBbn434; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2e2bb1efe78so879570a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 12:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729799685; x=1730404485; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H6btlO4rTxTbySffuChxG+Q78iU2PQqXsvGT+i6As9o=;
        b=RbBbn434V10kje2ilV1EdiUTWgrNIVyIW41xhfsj7fJCljMMmej+SqFbHn5NSqwTT8
         o7OByyAfFHEgAkejYDp+kV0DAbzVPhMiC5k/BAsV6rHcKWZJn/vi2VTwHDWYcs1kMR5W
         KqB9QU9rVePC2Q4uhFpezQManz3oEvhgWXUJUSOFOW7rRPVVt9DSQieTAky4jvMxpVhO
         YVOkYFdF2DR5o8klGVuwNRg4IWs7t8w4VEhZhVnELA/C52EqDHws7lMnpzkdBvcju+ON
         MNmHUv2G5bIR0+k/9W25qoshgrKnltG9iJdrlmzCm5tE9GTv3TGJ//My8biYzUxS5VLI
         wrOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729799685; x=1730404485;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H6btlO4rTxTbySffuChxG+Q78iU2PQqXsvGT+i6As9o=;
        b=cKTTEfUBwLALO7x2rs/rsq9eZ6313muroHvtzSNR8//P42O4+JPvBpqlUYtTvbovhb
         AcJnr31yeUD849a9Zrpe6Xr9kcR1lcrJ0AqIZWY4XJjCa45uy23Ga5n9+LuwGV6uHkzU
         3wbmElkTBaATjJ6+Tht5j3KsPqRNL4njH8Nnbypxofvh8l8wOvbSHupip505HVIEgoxb
         fuC2ImFXweOa4tuoOrJ07e2fkL/3zYVnvDo+yoPCAVXhNdy9/eQ0WsxGdQxxb8IWSHr9
         2hCo2zSXoac4rwIJ37gFb79OjRsIv+SjxiiFkz9iv0ROtAsOFe50Lcf0Ic0TUYujiXVh
         ojog==
X-Forwarded-Encrypted: i=1; AJvYcCVSWvUfZWIzHSgm+N1nXV2bFZtXvH2FKLDnMAGktJ5tv8m3MO7X+vMO1EtohT7iISn8IQJBGBYikRq7abg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0WnlyHgatr1P05Ux51Py3dJqfqMlev4JCpIHKlejROw/Ca7G5
	Gqrdu/zyi31JqexqYwCTSDlfLGBCe1WhEDNMrmf/lMhvM+pxPSMHZYS2PuALHWIoSsFcfbPvK01
	tfc4+gUGlvTMY8Uaz4NqnBR6UN3oQaLUj2KEKi0SPk0Z/BoWkKzOA
X-Google-Smtp-Source: AGHT+IEZe4a7sXjUVZ1g40C5xm0toQVzQcYskBppsd310orSYzO1cUJbRsSaBhbHxySEkF8qihj/AQqnh12YERHaM6Y=
X-Received: by 2002:a17:90a:4d87:b0:2e0:7e80:2011 with SMTP id
 98e67ed59e1d1-2e77e828515mr5032932a91.16.1729799684990; Thu, 24 Oct 2024
 12:54:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014122849.118766-1-brgl@bgdev.pl> <CAJZ5v0gAzZTa_TuQiFr1D7hKHw0eYF28s3ZBOv2ZFZTTC-Md8Q@mail.gmail.com>
In-Reply-To: <CAJZ5v0gAzZTa_TuQiFr1D7hKHw0eYF28s3ZBOv2ZFZTTC-Md8Q@mail.gmail.com>
From: Saravana Kannan <saravanak@google.com>
Date: Thu, 24 Oct 2024 12:54:06 -0700
Message-ID: <CAGETcx9GfFsfWymBvXHs7F0S_mvK=eCy=q8-gBu1UPm9QzNVgQ@mail.gmail.com>
Subject: Re: [PATCH] driver core: constify devlink class
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 24, 2024 at 12:45=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.o=
rg> wrote:
>
> On Mon, Oct 14, 2024 at 2:28=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.p=
l> wrote:
> >
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > The devlink class object is never modified and can be made constant.
> >
> > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> Acked-by: Rafael J. Wysocki <rafael@kernel.org>

Acked-by: Saravana Kannan <saravanak@google.com>

-Saravana

>
> > ---
> >  drivers/base/core.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/base/core.c b/drivers/base/core.c
> > index a84a7b952cfd..0e618d675792 100644
> > --- a/drivers/base/core.c
> > +++ b/drivers/base/core.c
> > @@ -553,7 +553,7 @@ void device_link_wait_removal(void)
> >  }
> >  EXPORT_SYMBOL_GPL(device_link_wait_removal);
> >
> > -static struct class devlink_class =3D {
> > +static const struct class devlink_class =3D {
> >         .name =3D "devlink",
> >         .dev_groups =3D devlink_groups,
> >         .dev_release =3D devlink_dev_release,
> > --
> > 2.43.0
> >

