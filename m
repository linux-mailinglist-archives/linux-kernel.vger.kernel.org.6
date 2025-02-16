Return-Path: <linux-kernel+bounces-516600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FFB6A3747C
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 14:15:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC785188E245
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 13:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18739191F83;
	Sun, 16 Feb 2025 13:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="wPUoO9x9"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5141618DB21
	for <linux-kernel@vger.kernel.org>; Sun, 16 Feb 2025 13:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739711732; cv=none; b=EDcYUiJSITzdnGtOT1owQX5liNO10t8qBsCzyf81Zrfj1JIJnGTTzhMK+XNIKZs+6gTsDPe5pgF7Q7xEydMCUWZ801TM8JCd+BP0T/8DD8AfUcTswcXz9SxbteXvfuupyz3vJZFxXBHllIn37scqhHawnhsBK1+iRfxkXUW0Qbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739711732; c=relaxed/simple;
	bh=o70ZZ/eh4kdMuS3XCYccOWzVzQeMchm5hKpjUFMIUew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=crLMtXGLWH7gvM51Nt/fRE9lrsYCCnlHQ0xdstzvJ1859HPOOk5tp3egy/OH1DHXtGrchCMylb7kbywQ5NBfk7Dbzake6kZ8+kAuFb6fwaq6IjoNO7cerTI2wNonW6xXQGfxkTc/+qAeJHEXK3CfpoI9cWtZ3vCgw1S7Ewprveg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=wPUoO9x9; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id B86023F29B
	for <linux-kernel@vger.kernel.org>; Sun, 16 Feb 2025 13:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1739711727;
	bh=hnAPKX4mqEzgwnyKau85qrKV3RXzF1Ci3iRxabK6JEo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:In-Reply-To;
	b=wPUoO9x9NBsVrRjw4x39qzeOE/CLw5tXeMCev2vmhPBjXdx293fK35uM2S6/UH0zh
	 JK/HPC2n/HI4tAWxys4nzIttznSEYI0OV7GtnEQ7NtJ/yFuP7wxxikNe5Qck0nm0DN
	 kFRRo/FC54OXHG2TIbd6fhaAdQ3YXQhqTJksd6ScjsoPlC5Q/9DhQFOhAyY2wf5wqx
	 JilriO8jQUQgd4vYr0tOIY9zl9iPUnvoqnymP/aYPEgvG/GAC86WDs47dUYcHXq5x+
	 FfHEOdUNvDOZ2LCl7AGlKWuVwpui8xSiBPJKkRvpsPTxik2t00mKcBzKD63EWxF9Ym
	 GL/rpW0lPOhDQ==
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-221063a808dso18061155ad.1
        for <linux-kernel@vger.kernel.org>; Sun, 16 Feb 2025 05:15:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739711726; x=1740316526;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hnAPKX4mqEzgwnyKau85qrKV3RXzF1Ci3iRxabK6JEo=;
        b=OTfrtIC5do1oUmmFCL99J8gNI6ma+gvFJj3D4Hb3kKTSTR5zmnzhFtoz4g2uqBpnnc
         OEETjl8GZ1LeGsVHh9dLbKB+pC8mpy53z5xKpUUviw7q/RKuAPIJefmIhwn6bSIU/y0o
         HCWcoqYVJ0G3g1iaqvZjxRTim1PvcUsYAjJbyqx6nJcNs2Vvl6bsyKeB8pvV+YweRiBA
         w2TiFrZOyChdrRQ2xJyhI0ooc+T2FXmVxFY/ZhasMSp5y3wHyhDhhuLbpEWZ802ivKDl
         q32sEs5NnT36FvPeISg7AmR0uK104D2LgM14sd4JLBGvdp6Dx/87TtTtNBT93SuwKKrf
         oA8w==
X-Forwarded-Encrypted: i=1; AJvYcCUgC85eM/sEd1ZEbKS5jWt/GqsuJ/r/3WCLuDYirdmxMWuVPO3S/eO4ioIL2oDz+2BGnDGg7+E+m434iOo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxdbEfl/LsYyHpZFR+DZVbq3SofTLkFu93tgx54XZfn469QUED
	leyO4Bl1PrQpxkG81aVud4MTzodRCfERk4A7YSuAQRFUDgsEyDcIqKzx+HXNeGIkPoG36CryMuq
	OfSU+W6YDU+2FNqfc+WA4NyGuuo3dH54uh/OqdQelpJzo51bry/piJoHvXJjexn2gqfsGItjAjJ
	63vcTxWPtIUw==
X-Gm-Gg: ASbGncsTVwu3FE1+8l/DiqfW8fLeFmQcEyR9chiGk4OQdybn1L/rF/8sHQ1Tf7Bee+4
	R+1F/f6FazPz9aU3K4JelJ+byutxxlgSR0EbFYhe4/pGanIOE+4DZmHeIVtfkkPdv5+McAvxt+t
	SxohTUyp7chEeBhSGrxre48qQRmeuApJPGPC/mhQgz86pcUJ9stO0f7THutEi4kDPoKaPl51MnP
	9Q4jNpMlkLOWWAcRQ8jUUR4RMW/j+p5Ra4Wwy6Yr8iHgshAr837iRm22Y22O+MpDnSWGpbyVdHT
	kAB+ghU=
X-Received: by 2002:a17:902:d507:b0:21f:14c1:d58e with SMTP id d9443c01a7336-22103efa6eemr91512165ad.1.1739711726042;
        Sun, 16 Feb 2025 05:15:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHTJRxMLwkP4nrDZnf1LTivfef8s+rZp9SUdHThfOjJwzI32QbUFyDKIttrXzbE8h5r+Jl3eA==
X-Received: by 2002:a17:902:d507:b0:21f:14c1:d58e with SMTP id d9443c01a7336-22103efa6eemr91511635ad.1.1739711725630;
        Sun, 16 Feb 2025 05:15:25 -0800 (PST)
Received: from localhost ([240f:74:7be:1:eaa9:d394:f21d:ee9f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d55908a7sm56330185ad.240.2025.02.16.05.15.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Feb 2025 05:15:25 -0800 (PST)
Date: Sun, 16 Feb 2025 22:15:23 +0900
From: Koichiro Den <koichiro.den@canonical.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, linux-gpio@vger.kernel.org, 
	linus.walleij@linaro.org, maciej.borzecki@canonical.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 09/10] gpio: aggregator: cancel deferred probe for
 devices created via configfs
Message-ID: <5mffw5s3p5biu726cfn6hrgcxiamawxz4qna4jajww3evoievd@itffjdnhijxb>
References: <20250203031213.399914-1-koichiro.den@canonical.com>
 <20250203031213.399914-10-koichiro.den@canonical.com>
 <CAMRc=Meb633zVgemPSeNtnm8oJmk=njcr2CQQbD5UJd=tBC5Zg@mail.gmail.com>
 <CAMuHMdU24x9pxEjBHTKxySxwr-L+iKXSUNFxpM9hvaSTNAWDuQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMuHMdU24x9pxEjBHTKxySxwr-L+iKXSUNFxpM9hvaSTNAWDuQ@mail.gmail.com>

On Wed, Feb 12, 2025 at 04:49:07PM GMT, Geert Uytterhoeven wrote:
> Hi Bartosz,
> 
> On Tue, 4 Feb 2025 at 14:14, Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> > On Mon, Feb 3, 2025 at 4:12 AM Koichiro Den <koichiro.den@canonical.com> wrote:
> > > For aggregators initialized via configfs, write 1 to 'live' waits for
> > > probe completion and returns an error if the probe fails, unlike the
> > > legacy sysfs interface, which is asynchronous.
> > >
> > > Since users control the liveness of the aggregator device and might be
> > > editting configurations while 'live' is 0, deferred probing is both
> > > unnatural and unsafe.
> > >
> > > Cancel deferred probe for purely configfs-based aggregators when probe
> > > fails.
> > >
> > > Signed-off-by: Koichiro Den <koichiro.den@canonical.com>
> 
> > > --- a/drivers/gpio/gpio-aggregator.c
> > > +++ b/drivers/gpio/gpio-aggregator.c
> > > @@ -1313,7 +1313,6 @@ static struct attribute *gpio_aggregator_attrs[] = {
> > >  };
> > >  ATTRIBUTE_GROUPS(gpio_aggregator);
> > >
> > > -
> > >  /*
> > >   *  GPIO Aggregator platform device
> > >   */
> > > @@ -1342,8 +1341,22 @@ static int gpio_aggregator_probe(struct platform_device *pdev)
> > >
> > >         for (i = 0; i < n; i++) {
> > >                 descs[i] = devm_gpiod_get_index(dev, NULL, i, GPIOD_ASIS);
> > > -               if (IS_ERR(descs[i]))
> > > +               if (IS_ERR(descs[i])) {
> > > +                       /*
> > > +                        * Deferred probing is not suitable when the aggregator
> > > +                        * is created by userspace. They should just retry later
> > > +                        * whenever they like. For device creation via sysfs,
> > > +                        * error is propagated without overriding for backward
> > > +                        * compatibility. .prevent_deferred_probe is kept unset
> > > +                        * for other cases.
> > > +                        */
> > > +                       if (!init_via_sysfs && !dev_of_node(dev) &&
> > > +                           descs[i] == ERR_PTR(-EPROBE_DEFER)) {
> > > +                               pr_warn("Deferred probe canceled for creation by userspace.\n");
> > > +                               return -ENODEV;
> > > +                       }
> > >                         return PTR_ERR(descs[i]);
> > > +               }
> > >         }
> > >
> > >         features = (uintptr_t)device_get_match_data(dev);
> >
> > Geert, what do you think about making the sysfs interface synchronous
> > instead? I would argue it's actually more logical as the user will
> > instinctively expect the aggregator to be ready after write() to
> > new_device returns.
> 
> On one hand, I agree that it would make some scenarios simpler, and
> let us propagate an error code to the sysfs writer in case of failure.
> 
> On the other hand, it would change user behavior. Currently people can
> configure a GPIO aggregator, and load the driver module for the parent
> gpiochip later, relying on deferred probing to bring up everything
> when it is ready.

Thank you both for your insights, Bartosz and Geert. I've just sent v3
(https://lore.kernel.org/all/20250216125816.14430-1-koichiro.den@canonical.com/)
which retains the current behavior, to not suprise anyone now.
I'm now considering whether we might eventually deprecate the sysfs
interface in the future. Doing so could simplify the codebase and bring it
in line with gpio-sim and gpio-virtuser.

Thanks,

Koichiro

> 
> I2C's new_device is also synchronous.
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> -- 
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds

