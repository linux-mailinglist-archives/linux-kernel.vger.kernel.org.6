Return-Path: <linux-kernel+bounces-363752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 13D7F99C690
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 11:58:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 457861C227A4
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 09:58:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6155158A18;
	Mon, 14 Oct 2024 09:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="MawpbXIS"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9594F15687D
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 09:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728899892; cv=none; b=RAqByWENPYpBJBbXTyZeR2dXmCO5tJiJwUGHPZQg2IfRjGbK2JJK50KgW4B3Tf1z2LANF6zuTYzYUTFAC9vqOND7Hv8eFIpr/DGoiliccQxZXWK60CIe3IT0kG0zoPbdztdJsC09WXvxowyfy+rFmsh+hxKkvTurpy/rQVtiVHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728899892; c=relaxed/simple;
	bh=HM0ccwsGHjkMoAcPwBk4X+CHshxltsEjzQH2Pr2d7os=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cOifuwc8lXftItwjUrlqlohHMbPlXXBNglfL5zbX+QUKpl7lK6JgAkr2140v72O0Qchf2kP48fAwkCVFbWVmfWnZ25udQeqXGLxBoQ1F4yo5w74BlCvlOME83Aa5eusqhH1JV6Jxe5RGpi8d1JQ2oUE/ml4H/I6OztHA1pwqQxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=MawpbXIS; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-539d0929f20so3118734e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 02:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1728899889; x=1729504689; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FAStLPYToynMy9Jq53WVpfjQXdGeU8UZDvKj7xjnAkY=;
        b=MawpbXISoZ443ccgK9wMPjAqQUbqy3NTyyLbgf7iLjMqWYK0NxLELxB3IPxCYItXB7
         ZkYxZKDf6vO/L82MGjJCyNmsU+LbLhjHb8B8FgASVVjnSTG1Z+aWG3dYj++vAoSsiC93
         uOfsJRkSGKr6z7B6GwE6XyueSISflu+2FdXYCXJYOSfFuHjeSo1+UAKPbQqA43+Y0Md9
         FEmb5wUyl/D8WQp+Ozp0rm+KF9MDXxw1Cl9u6y4Hy3RHpOMAyMTbM4C65TguG4QsaiRN
         O6z1sfY8I+gj3jlUAk/qDFGkT3LL0x6ytNI4jOz/SybwDBF2EI+gMnwhivH1k3uCsslO
         lp6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728899889; x=1729504689;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FAStLPYToynMy9Jq53WVpfjQXdGeU8UZDvKj7xjnAkY=;
        b=n5hdbfmk2t0Ot7hUs2HvdUR3e9UX85zlxxj6wyDvgWcG/t1Rr5u2YjqT77QW6YDeCh
         dHoWvbJXMdOD52elwwA558tcYKNFn+mewBdBaMkpaeWUemotH/VNYEV0bW4tp7zSeSU7
         cQP15ZlAYL7Oix1wLSatSzBSYc+M1LIzGc+y0H1KQQvzWv+JSXBKfhehvK9tGFIsSAwk
         EVKXdPz1GuPpV2zXxXvkpGs/DHcKRkWXcXoS50o1mdHMutsT25EcESqGalGykmK+lCSg
         3cxyPv8ucCAWTddkQfw5WjcGelbXYajMPlYiPk6KiShAhzq25OE4TrvsKFK1i0aZnfpI
         hNHg==
X-Forwarded-Encrypted: i=1; AJvYcCX5taa7kXncK5tUPpNFUFz6sbWNMEYdieY8pms7ogwiYfzeF4ypTVl3+cvEBJNga4Fe74pYNuMvpEZqX0Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywzt8oXsOurBA1Hw6JYMM8UuK8zw4fnzyDzZnQcB5pWSJK0m8/f
	TUC1feYmfOEXeVneRz1D/MP7/1FW13kNBvG9E868C8UpLZWODQFRO79nXKNg8ADjbTRNSq9zpSE
	UdNtqWV+fXEiPUfFrJwAocnkt+dV8KCgDgynV8g==
X-Google-Smtp-Source: AGHT+IEDfJmnvH3AGtMuDSrJjOe6Vme5QZ0py5CUDcHx/T0AI4e8MB3X+k+USJFtWfj7+2E74/IkH7IDUn1ik4AAgMc=
X-Received: by 2002:a05:6512:3f19:b0:52f:1b08:d2d8 with SMTP id
 2adb3069b0e04-539d6c5b05cmr3439576e87.7.1728899888700; Mon, 14 Oct 2024
 02:58:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241010-gpio-notify-in-kernel-events-v2-0-b560411f7c59@linaro.org>
 <20241010-gpio-notify-in-kernel-events-v2-5-b560411f7c59@linaro.org>
 <20241014021140.GC20620@rigel> <CAMRc=MeoSnr-z=fmfRoTU-vdL_BAkTAE+0HiBaVUWmFG-bOTPw@mail.gmail.com>
 <20241014092450.GA101913@rigel> <CAMRc=Mdf8CLQDPL8RMyWPyx8362xS3jEBe4zM=JL_dzRgF5wow@mail.gmail.com>
 <20241014092955.GA105498@rigel> <CAMRc=MchnY==2vLFUaOEJSTqaLvimkyNSixNpqbPkNyzSGew9g@mail.gmail.com>
 <20241014095514.GA108314@rigel>
In-Reply-To: <20241014095514.GA108314@rigel>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 14 Oct 2024 11:57:57 +0200
Message-ID: <CAMRc=MebqvOTs=z7Zade1jvt3rsx28F4G3z4e9nvuKBwCukqAw@mail.gmail.com>
Subject: Re: [PATCH v2 5/6] gpiolib: switch the line state notifier to atomic
To: Kent Gibson <warthog618@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 14, 2024 at 11:55=E2=80=AFAM Kent Gibson <warthog618@gmail.com>=
 wrote:
>
> On Mon, Oct 14, 2024 at 11:32:24AM +0200, Bartosz Golaszewski wrote:
> > On Mon, Oct 14, 2024 at 11:30=E2=80=AFAM Kent Gibson <warthog618@gmail.=
com> wrote:
> > >
> > > On Mon, Oct 14, 2024 at 11:27:05AM +0200, Bartosz Golaszewski wrote:
> > > > On Mon, Oct 14, 2024 at 11:24=E2=80=AFAM Kent Gibson <warthog618@gm=
ail.com> wrote:
> > > > >
> > > > > On Mon, Oct 14, 2024 at 09:48:16AM +0200, Bartosz Golaszewski wro=
te:
> > > > > > On Mon, Oct 14, 2024 at 4:11=E2=80=AFAM Kent Gibson <warthog618=
@gmail.com> wrote:
> > > > > > > >
> > > > > > > > +     /*
> > > > > > > > +      * This is called from atomic context (with a spinloc=
k taken by the
> > > > > > > > +      * atomic notifier chain). Any sleeping calls must be=
 done outside of
> > > > > > > > +      * this function in process context of the dedicated =
workqueue.
> > > > > > > > +      *
> > > > > > > > +      * Let's gather as much info as possible from the des=
criptor and
> > > > > > > > +      * postpone just the call to pinctrl_gpio_can_use_lin=
e() until the work
> > > > > > > > +      * is executed.
> > > > > > > > +      */
> > > > > > > > +
> > > > > > >
> > > > > > > Should be in patch 4?  You aren't otherwise changing that fun=
ction here.
> > > > > > >
> > > > > >
> > > > > > Until this patch, the comment isn't really true, so I figured i=
t makes
> > > > > > more sense here.
> > > > > >
> > > > >
> > > > > So the validity of the comment depends on how the function is bei=
ng called?
> > > > > Then perhaps you should reword it as well.
> > > > >
> > > >
> > > > The validity of the comment depends on the type of the notifier use=
d.
> > > > As long as it's a blocking notifier, it's called with a mutex taken=
 -
> > > > it's process context. When we switch to the atomic notifier, this
> > > > function is now called with a spinlock taken, so it's considered
> > > > atomic.
> > > >
> > >
> > > Indeed - so the comment is brittle.
> > >
> >
> > I'm not sure what you're saying. We know it's an atomic notifier, we
> > assign this callback to the block and register by calling
> > atomic_notifier_chain_register(). I fail to see why you consider it
> > "brittle".
> >
>
>
> I realise that - I'm not sure how to rephrase.
> The comment is describing changes in behaviour that were added in a previ=
ous
> patch.  The comment should describe the change in behaviour there and in =
a
> generic way that is independent of the notifier chain type.  Tying it to =
the
> notifier chain type is what makes it brittle - if that is changed in the
> future then the comment becomes confusing or invalid.
>
> I'm not sure that adds anything to what I've already said.
> It isn't a deal breaker - just seems like poor form to me.
>

Ok, let me see what I can do for v3.

Bart

