Return-Path: <linux-kernel+bounces-363406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2B5399C1EA
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 09:48:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C9A21F22A7D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 07:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9495314AD2E;
	Mon, 14 Oct 2024 07:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="hFVdaVSm"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D191146A72
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 07:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728892111; cv=none; b=ANpr5hpib+Wxj9Fys6Zd3W67g0DV8F3jm6Rh6Lsb+FA4FLlXUAjQ9XWsc4zI5k9gHsO6bd5XDrRzeivU/7lEVWpu8oqYXkTMHJYoKWBnWIlXOknmZB6xX4CkoGh0upt1yiYRTQAOt5pU/9W6rvW6MEuYtJf/TakeeOMpvRzcjbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728892111; c=relaxed/simple;
	bh=upEQUkYCFV1oHJzp9bR0zgTsOO8SYuJcCVkih8ztM1Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H6o+JAgNZDiL/Yid68MqvVNU3hNbsksEjWVuUP3EmOe/eJGfrPqJZ2IXRZeV2fEB1v/wnhMwLgAeI4Yjcml9qgEImEbPnZJT00YUgfObAlk+ZNERvTX/Izmji8joBXeyly1a12IXcUfdKMtBsb8X9Ri40ID6qq/JPWhPjzxPL8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=hFVdaVSm; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-539983beb19so4199881e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 00:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1728892107; x=1729496907; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iO0qmb5fFaS9ZoOrx/2QCeJGDKpLdz16K/FEngmHUvY=;
        b=hFVdaVSmuN+2stppOmy87Wbtj5aZjvQlvnprFnFmcKnM4kIOrbmC1rHKv7zyvqHCW9
         kJbGdCbjDqllCaPc37/FLXfa6tKzBM2qoKfupDdcq58T8WemFgQH/6ImM5xqBjWxUaT0
         y9zlkgltzX8/SAbKSuTumdBemk0A/yL0oC+3tiKrUf4+G8/WUyJ26aaSZwgzIUga08wg
         1/GBZzwnQSHfT8nwq7qxvZHiH/aSie0FJIew30Laf/dP6pLmwHtwavOKr90zQVU+QMZ9
         8WDOp+8bhRyL3M7LjJ9XTQQiQ6eghPPlCPr1xETepihxCOg1U2vg2CCuWdIJyDxpqpuZ
         qEiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728892107; x=1729496907;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iO0qmb5fFaS9ZoOrx/2QCeJGDKpLdz16K/FEngmHUvY=;
        b=Zrc60wAbOswyJtDzVj2Hv+wQgRJwAWkLDf5msVhoLn1naSl+SN0hOz3ZIrCxWVevLC
         iqcGi2fTEw8qq25xDZReRyblHnTiyf0xtzH9TKXp29n07dur6KvcPGfALm6g4V9hC3Ii
         w4plUqZRa1K/prHPthKGp0n+yJopHHjd2/F1CJ1mFV6PsTz32h3QTSciaKw+V3wy89Ni
         pKMOYTv3m/pyujjkwi5NlogmJ4hVvctHiNJN7QX4/xF0GyyvCM/LVqIGn63rAZcHV5jH
         Wp8XHP2wKex84V2Niekf6jOetMOY7ckGtTscCN/A8D/mQH2wfMTblytB4QqU4+czZH+P
         Y+XQ==
X-Forwarded-Encrypted: i=1; AJvYcCVSJsLGUeBQiSIUmjsGqj2Q2RyAlyTma3C4JPM4zM1YPBb+/e2uKEUsyFmHakngsYoW/yETbZ/iMwg2LlY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyosw28jDYxrqqNE4c+/2Nq160EVWaU1/TYjW7+7DF/C+pVRmn8
	aVfcv2IdMJFKND0O6b+ZrpS4kZrB39plrVvepqBBh9dLrhcxDJ2XJlzvs1apPXnlz4Tx3C9RdK0
	iT5Z9EXdAKVrn2X+RP5v3HSKfYIEcMXdjcf71+g==
X-Google-Smtp-Source: AGHT+IEaaSunZ6gUh3hegbA9fiDYoPVMZ9khBUiKHCQtjENpWK/DXfFqz6e7LMXXcZPy6PPz25DZFi5RAM4eYExh368=
X-Received: by 2002:ac2:4c4c:0:b0:539:8e77:9129 with SMTP id
 2adb3069b0e04-539da583e0fmr4525672e87.44.1728892107581; Mon, 14 Oct 2024
 00:48:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241010-gpio-notify-in-kernel-events-v2-0-b560411f7c59@linaro.org>
 <20241010-gpio-notify-in-kernel-events-v2-5-b560411f7c59@linaro.org> <20241014021140.GC20620@rigel>
In-Reply-To: <20241014021140.GC20620@rigel>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 14 Oct 2024 09:48:16 +0200
Message-ID: <CAMRc=MeoSnr-z=fmfRoTU-vdL_BAkTAE+0HiBaVUWmFG-bOTPw@mail.gmail.com>
Subject: Re: [PATCH v2 5/6] gpiolib: switch the line state notifier to atomic
To: Kent Gibson <warthog618@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 14, 2024 at 4:11=E2=80=AFAM Kent Gibson <warthog618@gmail.com> =
wrote:
> >
> > +     /*
> > +      * This is called from atomic context (with a spinlock taken by t=
he
> > +      * atomic notifier chain). Any sleeping calls must be done outsid=
e of
> > +      * this function in process context of the dedicated workqueue.
> > +      *
> > +      * Let's gather as much info as possible from the descriptor and
> > +      * postpone just the call to pinctrl_gpio_can_use_line() until th=
e work
> > +      * is executed.
> > +      */
> > +
>
> Should be in patch 4?  You aren't otherwise changing that function here.
>

Until this patch, the comment isn't really true, so I figured it makes
more sense here.

Bart

