Return-Path: <linux-kernel+bounces-363459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E9E999C2BE
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 10:14:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21E45B244BF
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 08:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2459714D428;
	Mon, 14 Oct 2024 08:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="vWDEEk7O"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 504E21534FB
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 08:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728893654; cv=none; b=IEbz5PnV9DLZ+xUHHNpOfLRXArCDu9yzV0S6P0LqM9oK4/hPTYWXLJ8kIGyfzbVaEJUr/zm7r+/gk7SE/tM+uUMst9c1hM2c/7H4YnjgYqWzQjb1ueVVN8XpXXltEDD6+vEo3zAN58JI9pFbGLiR25CV2bQlnK76Qa1/hfL28KY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728893654; c=relaxed/simple;
	bh=kDeKtA48vlIstldhcaMnAGLV9wwoJYEqb8JMCFUeUoY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bFjmNdDXIp2Em4QxVZFIB+mv1bh1Ccri9k2xn6iZCmSd66WPnFoujVtG/7dxXOeoyK7a7885oh5dsBWUtTD83DoJs2Qm4v46U4aHJEHeeD1Li4uwUqkGGVDDYQo0ENkCVCVOe1MKZymQhMmIALu/dri8aMnqqkM9v4VHhQ8nzOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=vWDEEk7O; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-539f4d8ef84so858733e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 01:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1728893650; x=1729498450; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KwU602zOXCbu4j31YwMdMD6lR63QBoFZv++MYJ4Nm8M=;
        b=vWDEEk7OuWuLnSosLKjVZvj9GCX5rhI3jNUAVhEXVVxGZzfdF0o4IzFnX47fjNafy7
         x4RW41ynlxtHRmbBNZ0CEZYclRcNXTyOfSbzfyUmi/R49qXowSDW2rOb3NXcGyF6UY71
         9OoJu5IlWyzPoiJg86TadHHD5F+QDmMa3Jm4PUp5zO/w7G/Dz1peJHm+VZm846RJWVhT
         BUZHqxiUumKbT5NYwdFeX1M48bsuZ8oVZHq1IB1HoL8S855z6HIEjR3P4HEG/AStkuKL
         SRcgbpahSDCqZxt2/K3xhMVJRgUCFaEb1joTERj18+h+d1yAPFuQfjm+UE8Dq4MPdSnZ
         7QEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728893650; x=1729498450;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KwU602zOXCbu4j31YwMdMD6lR63QBoFZv++MYJ4Nm8M=;
        b=RqgaYXPh/7FSVx3SdmBRr0FmZyoFUJvlUjd9iynm1cVrPIN4AcRcW/SMGS6YG2+5+H
         teRIzmI61zXj4Ip/vlRmh/L6b+pxjx6WTsIrfPoIx51J+4QUG7ecMUW6pk/bQ6XT2njA
         XuXT08R3H1xgPNUSJM5F/suzh9USuedsM+tqaX52/3gObK8NcJcK8H2BnbjkLjlmIc0e
         Ysb0zeTmsiTWLbnUtUkTaqwsqtQbyjerzHGf4cDPQqJtYOuQXrC0LuTnmkzaQSiCN8aH
         4p+DyDoIuZENQCJk4ipELwhsjH+lX/W/N7jbNXn0T9rkU8hoPD69X5EiuVKG4zcfmM6Y
         5ONg==
X-Forwarded-Encrypted: i=1; AJvYcCXM+MJzNVPvDPkvDSPtyOstYBBDRP1E0GS28020EGuMCuP4JDQ0KyALdOGfNM3Ma/QOT0gV+uEO4vY0IQU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGa/cN3B0YMiJLJebu/3xV038zxELXbv2kTo4bkNV28VEObYms
	zzmNsj7ouX8XpdO76oP4+SDkb7St0uIJwKqXhVjX4OoK9NtdlYtKUAIrrQD45zYfqhnGiuIlY8E
	YnHVPLUWkuii6f3SVGRCvj5S8R+YR1ItFnY7Ppg==
X-Google-Smtp-Source: AGHT+IGvqtA7VIzCWrsC1qte6LpHBfjaHr3QOEo5IRja8a19prdnTOQ6bMD+Sa5w163pTMP2XSnG/50il0qtDLS8Bik=
X-Received: by 2002:a05:6512:3d23:b0:533:4689:973c with SMTP id
 2adb3069b0e04-539da4e0b49mr3981750e87.23.1728893650339; Mon, 14 Oct 2024
 01:14:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241010-gpio-notify-in-kernel-events-v2-0-b560411f7c59@linaro.org>
 <20241010-gpio-notify-in-kernel-events-v2-6-b560411f7c59@linaro.org> <20241014022433.GD20620@rigel>
In-Reply-To: <20241014022433.GD20620@rigel>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 14 Oct 2024 10:13:59 +0200
Message-ID: <CAMRc=MddUUx-iDUWY53nStzt9nutRzB=EkGyaHa+e37Wm+10+A@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] gpiolib: notify user-space about in-kernel line
 state changes
To: Kent Gibson <warthog618@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 14, 2024 at 4:24=E2=80=AFAM Kent Gibson <warthog618@gmail.com> =
wrote:
>
> On Thu, Oct 10, 2024 at 11:10:27AM +0200, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > We currently only notify user-space about line config changes that are
> > made from user-space. Any kernel config changes are not signalled.
> >
> > Let's improve the situation by emitting the events closer to the source=
.
> > To that end let's call the relevant notifier chain from the functions
> > setting direction, gpiod_set_config(), gpiod_set_consumer_name() and
> > gpiod_toggle_active_low(). This covers all the options that we can
> > inform the user-space about. We ignore events which don't have
> > corresponding flags exported to user-space on purpose - otherwise the
> > user would see a config-changed event but the associated line-info woul=
d
> > remain unchanged.
> >
> > gpiod_direction_output/input() can be called from any context.
> > Fortunately, we now emit line state events using an atomic notifier
> > chain, so it's no longer an issue.
> >
> > Let's also add non-notifying wrappers around the direction setters in
> > order to not emit superfluous reconfigure events when requesting the
> > lines as the initial config should be part of the request notification.
> >
>
> So lines requested from kernel space will result in a LINE_REQUESTED and
> then a series of LINE_CHANGED_CONFIG?  Whereas for lines requested from
> userspace those will be collapsed into the one LINE_REQUESTED event?

No, why? I added the notification about the request to
gpiod_find_and_request() which is called by all the kernel getters and
it already configures all the flags without emitting events and calls
the non-notify variant of the direction setter. When a kernel driver
requests a GPIO, I only see a single event UNLESS after the
gpiod_get() call returns, it sets direction or changes config - just
like user-space.

Bart

> That's not ideal, but I realise making the rest of the kernel behave as
> per cdev would be non-trivial, so ok - it all comes out in the wash.
> And it is clearly better than nothing.
>
> Cheers,
> Kent.
>

