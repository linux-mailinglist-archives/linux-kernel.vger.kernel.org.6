Return-Path: <linux-kernel+bounces-363684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3046599C59B
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 11:27:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 612081C224B2
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 09:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABED4155A5D;
	Mon, 14 Oct 2024 09:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="EJKDG6UP"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87489155303
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 09:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728898042; cv=none; b=Cn//fy6EdjLvZ3P+cg18i7kzBO1cdiWQawqYE/MBPu+p+NW7xxLrUp1OEWPk2F0fqWqr5NlUog79LQDmQOIAKJeGU7qGD6/BG8siL+nDnjdmJFrJz9bcHDB9QlQ9HAfiJGnvbfx5sl8VO/c5swLxIgMyvFMjAyRFC5JbQejg9PQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728898042; c=relaxed/simple;
	bh=RLtYvFRuk9lYiQ1rd0UFz8zzOi0ojdtc7BzzAYN0QkA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MdSsGcv0BxGGg+J6E4WDIyyO2vKuYA85LnFBZ2X7gdWPChhWHChc4dd6eZtlzDVO0IlpOQkV/l73l5tMNoz/gwgDs6SNufTOEUzM5JxK41s5o2M9Qsi7ZpdO2v49KztXpEF7VmxFdMIcQ65IAxSFp7G29arp1PGG/28TQtYPuL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=EJKDG6UP; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-539f1292a9bso1047507e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 02:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1728898037; x=1729502837; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G+TuNkmbXB+MqThBZZwfvpAIuzuM5X5n98y4VdOfpp0=;
        b=EJKDG6UPIUyB/29esQvQ9160qaUR5k+1KwpJ12rDiXcN5tRTQ++97/pZdFw4BIE56l
         Xm1lPkjUvrDyMx+gSjAQkBj4zXXlmR2cLdKfJfo09g/g7m0iZCoZ3cN4xknFnXD3EQMI
         NoynC65yonXyFRU6PyEUoSd/yq8c9u330waU7s96r8Yxl3cDlN1RLx/in9bDqvxa55IE
         b/zeY4nNto9PTGDO/j24c/R5axRxVdpfdyHEf0bdcT2ESU9g9weFbDZr6JqLqslTsvnK
         u9fPuEjqSnk+fGGMPjKi4uRh0kPgFPjX5QVuDxLBfZArAblScGPajQ6qTnuy/5rVeEQ+
         ePMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728898037; x=1729502837;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G+TuNkmbXB+MqThBZZwfvpAIuzuM5X5n98y4VdOfpp0=;
        b=pEMxrCYVuPeatm6uyIUvblgby6nRaLcTUMOJVeOI1NEFwgwHTolAr9ApAHbaDHalQK
         XOkLIY9PHcKjiMAX8jI2I98GzUGvHHDzSm3p3DpwNoGQzk7RaTr92AjXIeT6u8NZ7ZTV
         IdcHIDQODbWHW5ePgSvJ7gn7mEJ2lohFzVPvumliGHjHV920gmOUCME0rSjVNuC/1nfq
         mJOOAhjxw3m38FQoUoeAi/MSxM2T0LdtKi3vUMjkYM5GRtKz4AGUYP7q+TmdAZFn2Aws
         eIKS5P5BkKuZUqf1WfuUHTzEPKXLgS5X9I6rXtXmF1nXv+Vktr7insj/cXI1ZEu1ik5x
         Jbvg==
X-Forwarded-Encrypted: i=1; AJvYcCXPK4nrxSuwwwDdLGUnDxK5CQql7zujis2hSuZ7vUuJeHXfoRpD0N4srG3QVRIfWIlSI6cxAEBMs+lmGv8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGYJkKsBpJyf+Y9O23K8Se3c7tv/hy7KNGoEnIkwOVG2PlRFBO
	i998N4Hnuady+vrIuI2D7LYagg9v98AscsEnIh7kWn+Zb1EKQ8WzN6PtGlUtdkduM56bm7es1xG
	fFAzwoKhFWZeWwiGYD4pRrlPoB6yW1Zgny3JE4+n596zeunBk
X-Google-Smtp-Source: AGHT+IEQzPc/luiBKL2Q67RNmdhX7q7RpG7nNKQwF4RGkGFmyjOw6JwzgYAdv3hs1dqdu5nf3DAWvQN2dJo41lmq/CU=
X-Received: by 2002:a05:6512:3a8d:b0:52c:8979:9627 with SMTP id
 2adb3069b0e04-539da3b68eamr5416787e87.3.1728898037578; Mon, 14 Oct 2024
 02:27:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241010-gpio-notify-in-kernel-events-v2-0-b560411f7c59@linaro.org>
 <20241010-gpio-notify-in-kernel-events-v2-5-b560411f7c59@linaro.org>
 <20241014021140.GC20620@rigel> <CAMRc=MeoSnr-z=fmfRoTU-vdL_BAkTAE+0HiBaVUWmFG-bOTPw@mail.gmail.com>
 <20241014092450.GA101913@rigel>
In-Reply-To: <20241014092450.GA101913@rigel>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 14 Oct 2024 11:27:05 +0200
Message-ID: <CAMRc=Mdf8CLQDPL8RMyWPyx8362xS3jEBe4zM=JL_dzRgF5wow@mail.gmail.com>
Subject: Re: [PATCH v2 5/6] gpiolib: switch the line state notifier to atomic
To: Kent Gibson <warthog618@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 14, 2024 at 11:24=E2=80=AFAM Kent Gibson <warthog618@gmail.com>=
 wrote:
>
> On Mon, Oct 14, 2024 at 09:48:16AM +0200, Bartosz Golaszewski wrote:
> > On Mon, Oct 14, 2024 at 4:11=E2=80=AFAM Kent Gibson <warthog618@gmail.c=
om> wrote:
> > > >
> > > > +     /*
> > > > +      * This is called from atomic context (with a spinlock taken =
by the
> > > > +      * atomic notifier chain). Any sleeping calls must be done ou=
tside of
> > > > +      * this function in process context of the dedicated workqueu=
e.
> > > > +      *
> > > > +      * Let's gather as much info as possible from the descriptor =
and
> > > > +      * postpone just the call to pinctrl_gpio_can_use_line() unti=
l the work
> > > > +      * is executed.
> > > > +      */
> > > > +
> > >
> > > Should be in patch 4?  You aren't otherwise changing that function he=
re.
> > >
> >
> > Until this patch, the comment isn't really true, so I figured it makes
> > more sense here.
> >
>
> So the validity of the comment depends on how the function is being calle=
d?
> Then perhaps you should reword it as well.
>

The validity of the comment depends on the type of the notifier used.
As long as it's a blocking notifier, it's called with a mutex taken -
it's process context. When we switch to the atomic notifier, this
function is now called with a spinlock taken, so it's considered
atomic.

Bart

