Return-Path: <linux-kernel+bounces-363536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3300F99C3A0
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 10:41:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC2AD1F23DC1
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 08:41:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2922C15098B;
	Mon, 14 Oct 2024 08:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="BH1wREiB"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A3C1494A5
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 08:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728895294; cv=none; b=Dmok0Nq+tW2I95SBqM2XnWpNjKZ4CxRMIRgwEnuKnn+aIxBrDNXmCfpSjf77U8whwanBVDSNTGtwJJAQwys8/FjdfPyQwTG344MFpx7fHvtcoslHAymJE+JevXvrAOVGszwW1m4lkJ3uQmBQXz8ApDaZZOr6Q/Nl03g0lRL4CsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728895294; c=relaxed/simple;
	bh=9NtSWsa8AOPc9f/f2FUflXBAxHKqc2tUuUxTuXp2ak8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H21RzCJQFMB2tZJzaaK9CXr+XQOZcKefJICwxemRog/4GvowQH9i96mmTZ2TC3imU6hv9xeIoNCeGYU8X261KAAL6okQf3kXL6CikMvjk1Sr8URfW6pdoG5POxq0lDu31BuJRdkcdGTHEB0UgenaICYmF67ylU6oxpNmshozDdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=BH1wREiB; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-539e63c8678so1500156e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 01:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1728895291; x=1729500091; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hnbH1E9KCYAbTBfLOd6pUNJu2FQNFznGGWSpn2EtQmY=;
        b=BH1wREiB6fU23hC2S8liS/OrtQcDIFPMu0Tb8DOiD50jINOStf4yq2XqaInvhxAJLW
         jlvx42KeC2rbI8pRoBT7hlpMfSJcX8d7nAtRSAniL/kLVtWwj6fE4Db8ATLye0BNoNg/
         OQIysWC3crDDmnLeZrmy2KZkEcigEAEpnipzZRfqr2pY/JfSEz5VmPa/C1C5ldkrff+9
         PJgBAchdSeRwSXMOMtNRh3Iw1rBd129RK3zk40UuVZ0auUFDvzce2xTiswFnv2BlMcL1
         l9BeLxZG2RO/LGs4osjH9k4VSXr/pfZzapxqkfAN3eulvMI1PP+jz2/GUYVliS1r536g
         fNXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728895291; x=1729500091;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hnbH1E9KCYAbTBfLOd6pUNJu2FQNFznGGWSpn2EtQmY=;
        b=eJzQg+3f40rLYV+is53kuDT5rhDJa2kh1FVeI+EDxo6WtgPhMuzpw+RrcX1j3lc9N5
         OmlR0WUCzAmd1LCjwDBsCbxdkB0aMmLyIjy6xRDpog6UrSp1NlsQ5Glu4N5m/BfVXbHC
         HHanGFrnYy8MUKKiIoqRE6TWsFsscZUDDT5E2Cu0bkbqGAaeEvVz6tRyo9uOnMf2Pfsa
         UKniSvyilfCfn47SMwMfo6K8eed8fD9wrd6o8MfSwNnnqBp+sAFAu7z2K0Nu7g8LwEiH
         WmEI9kTjKez2PuU85+Sj8S/e5Hzk5aAsCx2HCvRkLUkqWG3z/NsIL7iz0AV1sZz7ozY+
         o7LQ==
X-Forwarded-Encrypted: i=1; AJvYcCWXMQQS2l6uZ1tY82Z2dq+vfKFSNbNbQ3EyjZUsFzjOjiV5hWOJ54xjFZVf48ixt1f2lPqFEZJVYvR/VgY=@vger.kernel.org
X-Gm-Message-State: AOJu0YygTpHklaz9NEPlef6Iy5IdekGyNCjQ7vQa9G/4MyVLrXcalWJb
	Lp7TCIhwZl5INPLTNiJm8myQAex48Lp0kK7F32wTnK7Dm4BdtDYXmEqJxFurVgnqZFFEtTt5Cpf
	aVifogoyxWiQNHjAriqPNJ3iKbJSTUWiy2WfMYg+UbznJRfaI
X-Google-Smtp-Source: AGHT+IGDMPs+WuwkujboB8aBC0A0XweIGUJhfYmFBdbfdvYshC83WCgFobxuGCAkekocA75xpr6he/xZIebirsvZOrU=
X-Received: by 2002:ac2:4e07:0:b0:539:88f7:d3c4 with SMTP id
 2adb3069b0e04-539e5514af3mr2130101e87.29.1728895291043; Mon, 14 Oct 2024
 01:41:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241010-gpio-notify-in-kernel-events-v2-0-b560411f7c59@linaro.org>
 <20241010-gpio-notify-in-kernel-events-v2-2-b560411f7c59@linaro.org>
 <20241014015817.GA20620@rigel> <CAMRc=MewhPi3O6qM7E699gpwcegNiAsizioDjREn7cOM1xHevA@mail.gmail.com>
 <20241014083230.GA76995@rigel>
In-Reply-To: <20241014083230.GA76995@rigel>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 14 Oct 2024 10:41:20 +0200
Message-ID: <CAMRc=Mdq6ACsxW95+rinRYh-HAxtbWsT7KxDq1M+H4C8Q8zJ5A@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] gpio: cdev: prepare gpio_desc_to_lineinfo() for
 being called from atomic
To: Kent Gibson <warthog618@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 14, 2024 at 10:32=E2=80=AFAM Kent Gibson <warthog618@gmail.com>=
 wrote:
>
> On Mon, Oct 14, 2024 at 09:45:19AM +0200, Bartosz Golaszewski wrote:
> > On Mon, Oct 14, 2024 at 3:58=E2=80=AFAM Kent Gibson <warthog618@gmail.c=
om> wrote:
> > >
> > > On Thu, Oct 10, 2024 at 11:10:23AM +0200, Bartosz Golaszewski wrote:
> > > > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > > >
> > > > In order to prepare gpio_desc_to_lineinfo() to being called from at=
omic
> > > > context, add a new argument - bool atomic - which, if set, indicate=
s
> > > > that no sleeping functions must be called (currently: only
> > > > pinctrl_gpio_can_use_line()).
> > > >
> > > > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > > > ---
> > > >       unsigned long dflags;
> > > >       const char *label;
> > > > @@ -2402,9 +2402,13 @@ static void gpio_desc_to_lineinfo(struct gpi=
o_desc *desc,
> > > >           test_bit(FLAG_USED_AS_IRQ, &dflags) ||
> > > >           test_bit(FLAG_EXPORT, &dflags) ||
> > > >           test_bit(FLAG_SYSFS, &dflags) ||
> > > > -         !gpiochip_line_is_valid(guard.gc, info->offset) ||
> > > > -         !pinctrl_gpio_can_use_line(guard.gc, info->offset))
> > > > +         !gpiochip_line_is_valid(guard.gc, info->offset))
> > > >               info->flags |=3D GPIO_V2_LINE_FLAG_USED;
> > > > +
> > > > +     if (!atomic) {
> > > > +             if (!pinctrl_gpio_can_use_line(guard.gc, info->offset=
))
> > > > +                     info->flags |=3D GPIO_V2_LINE_FLAG_USED;
> > > > +     }
> > > >
> > >
> > > Should be else if.
> > >
> >
> > If we're not atomic, let's call pinctrl_gpio_can_use_line() and update
> > the flag accordingly. If we're in atomic, just don't do it. In any
> > case do the rest. Looks good to me, am I missing something?
> >
>
> Previously the preceding if short circuits and doesn't perform the
> pinctl check if ANY of the preceding checks are true.
> The pinctrl check should be in an else-if to get the same behaviour.
>
> I am refering to the if (!atomic), btw, not the if in its body.
> (that is why my comment is placed after the closing bracket)
>

Ok, got it.

Bartosz

