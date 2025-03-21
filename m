Return-Path: <linux-kernel+bounces-570657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BC9BA6B309
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 03:37:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14E8F189FA3F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 02:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5ED31E4110;
	Fri, 21 Mar 2025 02:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="kOqfawuj"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B211E2607
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 02:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742524662; cv=none; b=i/bhY6mW1mV/Ifswb/JbOVwOsqm5KOTQU1ZfP8xoN1ysf0Q5ImgduQxdbL4FYhhuECjRA6XKQ7EVumrCykpVorgQ7wvfad+WLhkK4n1vTucTDOVfYc5etlUQuhRgCOQDWZdZgFKZXm/pM405yAqQq8ll7c3kyERevMC5Au7aQxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742524662; c=relaxed/simple;
	bh=NzL5MhoyxILoggYXwncLpBDKP6RUCP+scqKZXIhJJXA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QrgQsfoTT3F1ckq8slcAMj/4AhLGK5b6NqLF5Idh3xqkpimgjDPRldZKKaSdRsABU5MFtjluvPID1ZbefEJCjGf0q7f5a0WlHOMJLdA+B1tkB6qWdFt9hxuZjVscmfKYAmzkRMsChaemOala5BvCZ9NhtvFikWPU8bKZM0jnAaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=kOqfawuj; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 0884C3F22B
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 02:37:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1742524653;
	bh=/TiJpfdGOANNODirv3oI1N0gAlEn2jC9qPa08xzAIEE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:In-Reply-To;
	b=kOqfawujIVX5EAil70LGoFJQlkHBigluq7zraY7wB3rNgfvCYo5lbqKsSUs1zxGGC
	 yU3fnw2fdjPMSZD5+ewde5ssKHWgsFkzmYMSJLWRgo1BxdoIJcSfsB5tG4zpjweWq4
	 OR8wzUAX5vVgs/Sj1bTDp/80UEwV9vKNSF7FpczbyGuSGVF9/OXhie6jKAhoSP+FQl
	 kArFgLqoCx/bMOnz2B/Io2hF6yDvsRW5XbbqM04AnW9Zn6x3YOW+05UWy11+BI29S0
	 3LoNyPl3KYThrYdX1Hf9WN2z6UCBueuaR9RmzL7qrEjDRDrHxejM1NJ0RutaYlcV9U
	 lhYgoTJ0p89LQ==
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2ff8c5d185aso4354695a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 19:37:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742524651; x=1743129451;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/TiJpfdGOANNODirv3oI1N0gAlEn2jC9qPa08xzAIEE=;
        b=qa1NMoK0/aGYB2p5h5UgVMtbVVapTDfuwIZf60DIm6nWsbgY3TMv1x+DZ4hJRPdL2b
         HqR0rZyZ/wl7oTwWVMY9jLcW1ZXhsF7uMPLLS/vg7MHm8ueq8oW7twArqQIvjdrbYJ+g
         NGe0Zdk0wDPk8VZVL3mCQEdqFArAVXUvzTI+TrvMieukuSgRnUhjcen0bGcvnjS0Qrc5
         pSPgDLcGuhBM85h77jFITA29RIsA+diLPvlIj6H1INasqixZLrs3GD7kq3k9hRQyu8Hr
         21U/ps31n83XEZnBsyz/uSIJLkamM4oY6PpFXW2J6KdfLI+MediZQjnRPXQXnoUsPgNb
         kwzg==
X-Forwarded-Encrypted: i=1; AJvYcCU8GF9JBcsBilgGeGwHhVlZ+VUzIvJ5yMnaa0Mh3a0HlxDvoj2cfRlsmqD+ZOCx8eZMXIEQBdlczXv6ly0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhmdaWv8zeTuULX+EMKXjb0gs1RjQia1ScJr+eqPOh9Qefmy7b
	yPHBI0wHkdIGQvkcp/cTXmRJqoSzCZy3j/h8CxuVwVNDBGZaWAaoYxm1+Q4m95FemVUopehsXmR
	N/gdwd63KiawyLo35yL2+xFtEAFnLAj3OsIJE0/sEC5O19Ybd1QXLp8JacEC4/FisHEiCfNXvdm
	dJWw==
X-Gm-Gg: ASbGnctxcNkS+V/eoFr6c/ZLQsJH19mz96uI51cDOCiOYKuXyTzNWLOsjBiscd/WM9w
	VA7Md/STQipF0NIFp+qhh0CgL2J6dGuBdSMk2wEdvw3f9ewr3i8YwqF8B6+W+asvTMY2PgsIrer
	vny0QuAFBnYeAPi1ChAfB94oEmAugy7teAdFfYLqrv2vOBVCY8TmJWvrrGGxfX1pf3z9SnzLSKU
	eHmgq0vMpy5/mlNeZodRjKfyUmOtW6UPtGD8ghBrFVL6cutkRft99yNzqEAg2G+JlxRulxFP8um
	zcKOKnz4VNKXgGJkdw==
X-Received: by 2002:a05:6a21:6e43:b0:1ee:e24d:8fe3 with SMTP id adf61e73a8af0-1fe42f358d7mr2755643637.10.1742524651647;
        Thu, 20 Mar 2025 19:37:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHvh8o1abtTk5AEN91MvJywHrX4XvpZuDt/ZutsnhnUVS0aKDkLwlwV0igeqbDfx4zZcjJy2w==
X-Received: by 2002:a05:6a21:6e43:b0:1ee:e24d:8fe3 with SMTP id adf61e73a8af0-1fe42f358d7mr2755616637.10.1742524651297;
        Thu, 20 Mar 2025 19:37:31 -0700 (PDT)
Received: from localhost ([240f:74:7be:1:2dba:1af7:27b6:24fd])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7390617fa4bsm612699b3a.157.2025.03.20.19.37.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 19:37:30 -0700 (PDT)
Date: Fri, 21 Mar 2025 11:37:29 +0900
From: Koichiro Den <koichiro.den@canonical.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-gpio@vger.kernel.org, geert+renesas@glider.be, 
	linus.walleij@linaro.org, maciej.borzecki@canonical.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 3/9] gpio: aggregator: add aggr_alloc()/aggr_free()
Message-ID: <llbybv6dpkfrtir75dveqnphrj6nuephvkoyywy6tx6vfbunl2@ft5io3thby6v>
References: <20250315164123.1855142-1-koichiro.den@canonical.com>
 <20250315164123.1855142-4-koichiro.den@canonical.com>
 <CAMRc=Md8nB1U--qcZxpcKVzxTcON2hi-pmsUKFn+aBEqHuBzcQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=Md8nB1U--qcZxpcKVzxTcON2hi-pmsUKFn+aBEqHuBzcQ@mail.gmail.com>

On Thu, Mar 20, 2025 at 04:51:04PM GMT, Bartosz Golaszewski wrote:
> On Sat, Mar 15, 2025 at 5:41 PM Koichiro Den <koichiro.den@canonical.com> wrote:
> >
> > Prepare for the upcoming configfs interface. These functions will be
> > used by both the existing sysfs interface and the new configfs
> > interface, reducing code duplication.
> >
> > No functional change.
> >
> > Signed-off-by: Koichiro Den <koichiro.den@canonical.com>
> > ---
> >  drivers/gpio/gpio-aggregator.c | 58 +++++++++++++++++++++-------------
> >  1 file changed, 36 insertions(+), 22 deletions(-)
> >
> > diff --git a/drivers/gpio/gpio-aggregator.c b/drivers/gpio/gpio-aggregator.c
> > index e026deb4ac64..2692a31e01ac 100644
> > --- a/drivers/gpio/gpio-aggregator.c
> > +++ b/drivers/gpio/gpio-aggregator.c
> > @@ -36,12 +36,41 @@
> >  struct gpio_aggregator {
> >         struct gpiod_lookup_table *lookups;
> >         struct platform_device *pdev;
> > +       int id;
> >         char args[];
> >  };
> >
> >  static DEFINE_MUTEX(gpio_aggregator_lock);     /* protects idr */
> >  static DEFINE_IDR(gpio_aggregator_idr);
> >
> > +static int aggr_alloc(struct gpio_aggregator **aggr, size_t arg_size)
> > +{
> > +       struct gpio_aggregator *new __free(kfree) = NULL;
> > +       int ret;
> > +
> > +       new = kzalloc(sizeof(*new) + arg_size, GFP_KERNEL);
> 
> Please prefer declaring the auto variable and initializing it at the
> same time. Should be:
> 
> struct gpio_aggregator *new __free(kfree) = kzalloc(...);

Thanks for the review. Should I send v7 for this change?

Koichiro

> 
> > +       if (!new)
> > +               return -ENOMEM;
> > +
> > +       mutex_lock(&gpio_aggregator_lock);
> 
> If adding new code, please use lock guards.
> 
> Bart

