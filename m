Return-Path: <linux-kernel+bounces-513113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB516A341B8
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 15:20:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73A943AB9B2
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 14:14:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 016C6281359;
	Thu, 13 Feb 2025 14:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="vQkUb4NM"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D99428134F
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 14:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739456040; cv=none; b=E6R72BLv4cv783lHUVryhcYQJPswX3l6PwZjZf1ZmbpP3EXuGM9iKuWVSaw1Mzs73bs584pK1JCoJESOUx6XUdCujDCDQXnk4fxWM8cqyXTikB+5mRPPW2zYYeTxkTWEmh/QYf68NwZucnP777AR2OxGlh04/nUJTm9TiELM4nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739456040; c=relaxed/simple;
	bh=TP85lmVRyE+KR4Zw2gnBylM2ia+0k0p9M/nWkIy+aN0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WUMolCsaxbMZPYJVlcVL4H3LxlfUfM1y3HiRxf5j1e31EyM/09tUcDb8juYi9YhbsdacODhyYMljMNo77ScCBpSi4TJ/7fQv5Ociak0+SRsBpE8dOyyZBdnLdnswTXFewIdQ61CzFZZxX5dX+5xg10b1fB90lIxglH/vrK8j2E4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=vQkUb4NM; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id E32573F31E
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 14:13:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1739456033;
	bh=ezUubHoO+1qqHLhPhiofskdHAd2A0O/l0XRXixs/i4o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:In-Reply-To;
	b=vQkUb4NM7THKfUgOi8S1KnPpMs21sUPGqVGFyKahWdgw46eBAphWic7y/PXNbfGUJ
	 5mm4LZ5J+z5ruXiumJkJuw5o2wwPjiJEHkBGyiW4xaeeZ7PI20x7Wswm7D+OMSiuRW
	 Ak1gQn/3GnMlM3UNU0AgwSNc6JFE5WUrp39idO3cvXtHFVI1sdKB6ugGsSzeHy3mzc
	 0FJK9VtTFQfWyaotIh/gzp1k2pw81+eLB3m6hOonszejT+DYCBWJq4VhCXejtkVQwT
	 q/ecOoJPqx0hBZ3TBX67fwuqpT+87u3+E9gBtmbViS9/QUY8Hrfwl70k1TkhF5+Nhm
	 AFLu2oJri2ECQ==
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-21f73260b22so20360635ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 06:13:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739456031; x=1740060831;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ezUubHoO+1qqHLhPhiofskdHAd2A0O/l0XRXixs/i4o=;
        b=VVAdZwqulEH5nX5HcXNW3/L4B8Qn3iLtEgI8DHu6pLkv+XpEiQlWR/dH68iXUvvWdL
         vWPyTmYnJ6cJeSQ6mTv/iAOn1SH9h2Gn0inEJrT/TeKnU6S6PeEarDHTSkk3HYur0zVi
         ZOSDRzQ/M7gNqJFmPmbSDsnv48SdkbntbWWF4IFgJ0ehngTwnZPsysLS/EE7dAJJX39e
         5WV1wCheUTAw2aYGxZwpIjW4qOm1VZ3jWLPH0XqfrhV8EdCyb5/ol3BT7hltDjU3aBL8
         XV49Ak2vhSO7v6TvM9OjWzBffEazBOn9HT+daPXD1fdIZPGU5EHXl/pxh3NdYL6x90IB
         FJRA==
X-Forwarded-Encrypted: i=1; AJvYcCVsMpAuwvy1uStosFsRL1lYvLw/Jtcinj1xChwRaYqFS+56Vt84+kQqgfDC6EC+sZsyZuw3UebU+p/nUJI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+M4hewWCoyxQTd2Ud/3eB05vzg2dENLPao/B5bteWPuGDs61E
	zLB/cfYc6GtCN1YsqD0SxymquNCA8x+lSMN9jCftDxRXiUHfms4IqZfeUJwL5eiKPdH6cKHebPU
	85+eNUXGz9BoqlQ2XsqYacT+LUZE0mjJB8UEn8e7Eso1cRodu132+bro89uToW7/4OuxvLNCiQ8
	GcMA==
X-Gm-Gg: ASbGncunt1EEJCeyS/VY+iBSY8Lwuo7IY4lm2/L0+su9IeIXLozn1LfPgt//fzv3rfT
	nqH1612d05T9t81KzE9CDq/6lmrEX42ulu6tQfXbSm78rLkFl4/RyMPyEHVxl1K85WYThh2vdeA
	k9Qw1Q2Y0Wp8Witk+5pFpLHj09QYYMv+oBvC/LR1289ALh/1dJrU3e8ZjNeHvlzdfv2cw3e5CIf
	XivZDrzc4Migaol1xyhdEmx90S4HXvvs1OCp0gizy4OfDaXa+4OC2hEAC2vxqbl/t8InQGqCYkW
	BJxQHls=
X-Received: by 2002:a17:903:943:b0:216:1cfa:2bbf with SMTP id d9443c01a7336-220bdfec94cmr132459965ad.35.1739456031457;
        Thu, 13 Feb 2025 06:13:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEMaVPpgVc0PI+Sn0mSucAhml0OxrBdgDSYOokgidXq4tAbh4IB7TO1Ki6OQiYG20YaQAk0vA==
X-Received: by 2002:a17:903:943:b0:216:1cfa:2bbf with SMTP id d9443c01a7336-220bdfec94cmr132459645ad.35.1739456031154;
        Thu, 13 Feb 2025 06:13:51 -0800 (PST)
Received: from localhost ([240f:74:7be:1:5439:d90c:a342:e2bb])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d545cf8fsm12827245ad.152.2025.02.13.06.13.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 06:13:50 -0800 (PST)
Date: Thu, 13 Feb 2025 23:13:49 +0900
From: Koichiro Den <koichiro.den@canonical.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-gpio@vger.kernel.org, brgl@bgdev.pl, linus.walleij@linaro.org, 
	maciej.borzecki@canonical.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 05/10] gpio: aggregator: expose custom line names to
 forwarder gpio_chip
Message-ID: <6ypcmewxmod2cu3j5ksbmvsisgr4qhsagwowiawitof2ll4npa@syrhmqagrtlo>
References: <20250203031213.399914-1-koichiro.den@canonical.com>
 <20250203031213.399914-6-koichiro.den@canonical.com>
 <CAMuHMdVAiuvxD4ydtsWfWXBhHLDJz66Ay8w15WHr278OnB=ZKg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdVAiuvxD4ydtsWfWXBhHLDJz66Ay8w15WHr278OnB=ZKg@mail.gmail.com>

On Wed, Feb 12, 2025 at 03:44:46PM GMT, Geert Uytterhoeven wrote:
> Hi Den-san,
> 
> Thanks for your patch!
> 
> On Mon, 3 Feb 2025 at 04:12, Koichiro Den <koichiro.den@canonical.com> wrote:
> > Previously, GPIO lines in the aggregator had empty names. Now that the
> 
> That is only true for aggregators created through the sysfs interface,
> right?  When created from DT, gpio-line-names is already supported:
> https://elixir.bootlin.com/linux/v6.13.2/source/Documentation/admin-guide/gpio/gpio-aggregator.rst#L72

You're absolutely right, I'll fix this commit message, along with the
needless codes you mentioned below.

> 
> > configfs interface supports custom names, update the GPIO forwarder to
> > use them.
> >
> > Signed-off-by: Koichiro Den <koichiro.den@canonical.com>
> 
> > --- a/drivers/gpio/gpio-aggregator.c
> > +++ b/drivers/gpio/gpio-aggregator.c
> > @@ -425,6 +425,20 @@ static int gpiochip_fwd_setup_delay_line(struct device *dev, struct gpio_chip *c
> >  }
> >  #endif /* !CONFIG_OF_GPIO */
> >
> > +static int gpiochip_fwd_line_names(struct device *dev, const char **names, int len)
> > +{
> > +       int num = device_property_string_array_count(dev, "gpio-line-names");
> > +       if (!num)
> > +               return 0;
> > +       if (num > len) {
> > +               pr_warn("gpio-line-names contains %d lines while %d expected",
> > +                       num, len);
> > +               num = len;
> > +       }
> > +       return device_property_read_string_array(dev, "gpio-line-names",
> > +                                                names, num);
> > +}
> > +
> >  /**
> >   * gpiochip_fwd_create() - Create a new GPIO forwarder
> >   * @dev: Parent device pointer
> > @@ -447,6 +461,7 @@ static struct gpiochip_fwd *gpiochip_fwd_create(struct device *dev,
> >  {
> >         const char *label = dev_name(dev);
> >         struct gpiochip_fwd *fwd;
> > +       const char **line_names;
> >         struct gpio_chip *chip;
> >         unsigned int i;
> >         int error;
> > @@ -458,6 +473,16 @@ static struct gpiochip_fwd *gpiochip_fwd_create(struct device *dev,
> >
> >         chip = &fwd->chip;
> >
> > +       if (!dev_of_node(dev)) {
> > +               line_names = devm_kcalloc(dev, sizeof(*line_names), ngpios, GFP_KERNEL);
> 
> So this is always allocated, even when no names are specified?

Yes. This is unreasonable. I'll fix this in v3. Thanks.

> 
> > +               if (!line_names)
> > +                       return ERR_PTR(-ENOMEM);
> > +
> > +               error = gpiochip_fwd_line_names(dev, line_names, ngpios);
> > +               if (error < 0)
> > +                       return ERR_PTR(-ENOMEM);
> > +       }
> > +
> >         /*
> >          * If any of the GPIO lines are sleeping, then the entire forwarder
> >          * will be sleeping.
> > @@ -491,6 +516,9 @@ static struct gpiochip_fwd *gpiochip_fwd_create(struct device *dev,
> >         chip->ngpio = ngpios;
> >         fwd->descs = descs;
> >
> > +       if (!dev_of_node(dev))
> > +               chip->names = line_names;
> > +
> 
> Do you actually need to collect the names yourself?
> Below, the driver does:
> 
>      error = devm_gpiochip_add_data(dev, chip, fwd);
> 
> and gpiochip_add_data_with_key() already calls gpiochip_set_names()
> to retrieve the names from the gpio-line-names property.
> What is missing to make that work?

Thanks for pointing it out. It was just my oversight. I'll drop the
needless parts in v3.

> 
> >         if (chip->can_sleep)
> >                 mutex_init(&fwd->mlock);
> >         else
> > @@ -530,10 +558,40 @@ to_gpio_aggregator_line(struct config_item *item)
> >         return container_of(group, struct gpio_aggregator_line, group);
> >  }
> >
> > +static struct fwnode_handle *aggr_make_device_swnode(struct gpio_aggregator *aggr)
> > +{
> > +       char **line_names __free(kfree) = NULL;
> 
> const (needed when gpio_aggregator_line.name becomes const)

Will fix in v3.

Thank you!

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

