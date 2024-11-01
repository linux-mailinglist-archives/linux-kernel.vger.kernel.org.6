Return-Path: <linux-kernel+bounces-392356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E0DBF9B9304
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 15:22:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72A7A1F23190
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 14:22:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EF3C184542;
	Fri,  1 Nov 2024 14:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="rRGg3KDT"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7826D1A7060
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 14:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730470883; cv=none; b=k59mgVtLnzvm/ranhtKFSjEriu/7dil3Px/anre6YVlMzFwetXTMakVmXZ8gTIZpfOFhOO+tVbbsZu2TD88sGu9B8nHmbNgeE9WgtUjgUfWKA5/E38dV1QDHnLwV2pUsvlnu5cQpzZ88cwno+noVuJRBzDXnL7uBKBrCA3wc5Og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730470883; c=relaxed/simple;
	bh=16LXyBzDHfmU+yXXn54ZZmrWOVgxwgGv8ljrr4Ned+U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JOs7ZaYkoK32hnpR9nknGtwEqr+DejOxt5o99wYqkZpCkjCq/ezGz5LVEAuNuU9ZhczRWiA6ii/MDtCZewYl9ZDq5oZANQhmGgXkufvwV0ImhLv5WzIFf3nlv2V7bhNFBxwj26mr4m1CCm7NmtpJeOEy/LLSZnVay1p23qAVjDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=rRGg3KDT; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2fb3c3d5513so18439161fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2024 07:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1730470880; x=1731075680; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I+Xe0vA9b/GygARc/iiIPaC4qB7rwu85y64Y3iUm8bU=;
        b=rRGg3KDTMWKTnBIDKriw4VURF9V6JxuqJSWG++LGXEe6WUDVSR+RLj8RZNomPTkfry
         8XE4bHRWFoyX0mKc9fq8bCUE/c4s5wn2gYXJsvAe57EOaafgFP3NL7mTpHVuX8MOPdeq
         +gfKTlFKeXvBSN7YP9YnbkYNDJgvcPmb9itM/5JjZsST/WXRrzhdXmO0gzrlvp/liIze
         u7wd3kyxjvJQ4/o0uuyqffoorTmUcsyMTM27oKDNQ92Fvjwznu2tXc6YnThuWbVOsy8A
         rB2GAjcuMVH9cCJ0QO/Q1vA0jSBLNGwCiiSnOntM1ssgK2BMgY8dhmpmt9LCsVy4dSua
         0E0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730470880; x=1731075680;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I+Xe0vA9b/GygARc/iiIPaC4qB7rwu85y64Y3iUm8bU=;
        b=jdqfVIuAd/jkcDLqvNHnZWlhDsK4hCkgKbMVr/JEkRJS3q4/2mftzgBVX9UB+IZt08
         5A1nzIOX6jHKIuzKg3xAgycmzrcYhrFt0rlx7/dOx2IruTl8BDWhUopItpo7h1n7FAkP
         UG9LSnNWbK/ggxWtkvMt806LofwLb4VuN+exxN3PVBwCTCmycXHGAKTgtXCdwqenRB/f
         zwWDlTWD1Xk5pEVbL6JUD27sH7WISNXK+F5JMYRpYl4zlxTsP1nO5i7saWj+7IlebSZ/
         98QotxvWV9e6T+5zy44FBmN9+aj5wxkLvK/IzLN5MaHMPijjvcLw9X6Y2Lr1Z3m4o96H
         TTBw==
X-Gm-Message-State: AOJu0YyiOQCMrlYbJ8i3UggJFXmqxHbUieyPV0PTNmO7zrlxf3W+ZHG5
	W09duxucN5ba72ishzbppyC3WY8WcSNz6+P3ct85/mRDIcP222HyVVOPLRmBXk9CvUPLhU0vWh+
	OYDNRVIMNFUT8ZQFpD4NB3w8whtjQJypdAoyqGdwiQrKXpYpf
X-Google-Smtp-Source: AGHT+IGswmPAFLw0rjYNS7CTFOcB+mCYX9kONlwsyD+LIoDXCYYwRCEhT8CyQ/R60M37KpwrhbwPZARfEFKhRGGE94k=
X-Received: by 2002:a2e:a58f:0:b0:2fb:51a2:4f63 with SMTP id
 38308e7fff4ca-2fdecbf1a46mr40720671fa.34.1730470879424; Fri, 01 Nov 2024
 07:21:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014122551.116491-1-brgl@bgdev.pl> <CAMRc=MfscDCr8mdxSiC8zWUgdzdqLCo3=PKhuWhWueGoq_c82w@mail.gmail.com>
In-Reply-To: <CAMRc=MfscDCr8mdxSiC8zWUgdzdqLCo3=PKhuWhWueGoq_c82w@mail.gmail.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 1 Nov 2024 15:21:08 +0100
Message-ID: <CAMRc=MehYdep3YvfDjZPmut4d2uKq+Cb5tQecJCQMjAEJxSdTw@mail.gmail.com>
Subject: Re: [PATCH] mux: constify mux class
To: Peter Rosin <peda@axentia.se>
Cc: linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 24, 2024 at 9:08=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl>=
 wrote:
>
> On Mon, Oct 14, 2024 at 2:25=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.p=
l> wrote:
> >
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > All class functions used here take a const pointer to the class
> > structure so we can make the struct itself constant.
> >
> > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > ---
> >  drivers/mux/core.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/mux/core.c b/drivers/mux/core.c
> > index 78c0022697ec..02be4ba37257 100644
> > --- a/drivers/mux/core.c
> > +++ b/drivers/mux/core.c
> > @@ -42,7 +42,7 @@ struct mux_state {
> >         unsigned int state;
> >  };
> >
> > -static struct class mux_class =3D {
> > +static const struct class mux_class =3D {
> >         .name =3D "mux",
> >  };
> >
> > --
> > 2.43.0
> >
>
> Gentle ping.
>
> Bart

Peter,

Your email doesn't bounce so I assume you are getting this. Any reason
why this simple change is not being picked up?

Bart

