Return-Path: <linux-kernel+bounces-513112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 18A58A34191
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 15:15:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E1BB7A1D33
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 14:14:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 014E5281348;
	Thu, 13 Feb 2025 14:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="tuhiKUKc"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC1023A9BC
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 14:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739456005; cv=none; b=pr7cNrW0Idgv7TRXFBD/I0XlvwdzSpzLtv50wmEc4mYu7SDi3RWbpoSBGNpUG1nOpvI8fg0C62dqKEGwi68/zLNV39WdYWBOpZ7ES6qEW/Ye8J8XTq0RB/ezkl/x+6D4mcyoWQ4oFNKbyYIfVcjaRR6P+uiR7Ociqg4ZwI6BbMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739456005; c=relaxed/simple;
	bh=1AE/AsPkSseabBI+wh2PvqGe2nLuaypQ32OyGVYFAR4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mDkOYwQ6XqMg0JLKTrFHMCIxlT7hKv2+sX8sBBHBUb9I/Z4a8HiPoKVJfmiTcAUzvNSuxdxyp9te2kx/2PC1vyvTZkzs4bR74gE41ulKnkUbYEeH3GkjTiQGZBTu6uJEf69gTL6NxeMZSTmTmxJI0tSAKT03jbdP5pTugsaq2Do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=tuhiKUKc; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 670603F682
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 14:13:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1739456002;
	bh=2+kLF5rkSgLiqo+fczE/YSFAXYxJJU0YzdN5BTDcfZk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:In-Reply-To;
	b=tuhiKUKc//AoL8ktJeHpAypHNJHMpnFuBFwotQ0ZS65F1bEYalnbVhF5U4TmJThxX
	 ELMrLICcJpMYYsH8qN/nR2nM2PrzKZ9qzAjEFEXTOlwI0YQOphZEtomjC/IbrIgqic
	 DhRo21uS8DVSzqgsBSA5WNTejA11z4462pNryA3wG3NT1YR5F9Mc4LW/keZQLVeKd+
	 8Ccye5VXIbduRTNSuK+WSW4iwVJPUhdYBVVJDkwbtQrjJOz/qi65i9DyBbUswvTc7J
	 0eqDBntq0JWKop5VZL8YxlMUMVfNnj++fvKwL0Gloa4b6N81GMTvyMEycO361ZHumb
	 +ELDSwslduuNg==
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-21f68852b7bso28927455ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 06:13:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739456001; x=1740060801;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2+kLF5rkSgLiqo+fczE/YSFAXYxJJU0YzdN5BTDcfZk=;
        b=n7Xi1bx6F7wZhKw1iqeKDTwwGbutmCuSvDb32iselXwGnNK4Xy1DG+gtrI9+ZYN0GI
         TkS71wj16XcIPGTeJU1/F1+8T0QiIP7/g8aA9NOGDkgiNaSwMooz7m8tSJ5Yt75hjAwk
         OqBsowHeG4IM1uWwcexALnEC5j/I5e0ccGlr4sbqNgEvh4fYijqI6IxF5S05yapD8pXT
         q2IyTQGfBIJcQ6r4jppSGPVw+jXBdN/tYPXlbcaAQOFDB5WG/1q/rUz4q/hU0sRDMqLM
         SJjw/BMmy8xnYvxeeqsABFYqBJUsXuhcpiLm2nWf5db5cRpRfpkt0gvLbsyaZjoNi/2q
         A5hQ==
X-Forwarded-Encrypted: i=1; AJvYcCVsLspsJ3PDO8bwgTwslaX7iKEketjvQHc4nCCUEo/Ih03fSOgiiNQvkuVS/hb+FsP+XwV9SiFsKdAgBRU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGu39lrsTDi74laQtPpgZvbUKV8c4/0lkch/rTzs9uYP3KQS2B
	OcJ+65DnCCNkwm85K9L49hPQEFddC/FG3QqAUnAoAmI+GaPD334cK+FQ5ejlcq+AZy3tIp/WvCS
	HAXy1AUoX6uFNgfiOepVg/NfsUsMuhnid32s0NmipPcNlW5OlZQuJLyXyz94YTZ/kVtRp1S2ssg
	eyqA==
X-Gm-Gg: ASbGncueb/zUNygXhBvWNLanA8Qn1dmMhfWpWWVjK+IVxiIMgSJOZDQg/wgB46eHYJR
	twBaQat9Yl9mCgwRRaY/qTgpwQepqSkyST2jRICqj3fXCWLbHXTsl78TcVuxZR5S/WNmkqw2MYM
	EphVrx7lz/EOWkgKlIk4KaCUjqHy6sUYMRc7d0c9zEAjUjExsNtAEWwSwHtdIYx2i0XNJL/IWM+
	G2cF+t2xhja4+HaKwUQ0xV3Qr7NCnEt42Ev4TFu8ozdXuh3NT6Ps2fInsfsDLuYYp/D/VYxPk0m
	5/Pc5o4=
X-Received: by 2002:a17:902:c949:b0:215:9642:4d7a with SMTP id d9443c01a7336-220bb549c13mr127075245ad.0.1739456001001;
        Thu, 13 Feb 2025 06:13:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG+6zs49M6gIxhUhV5iCA4V7nz6hQfz8nMDkXeY3LDocSmpDY11OSi671TMUo2n19ACuaX3gA==
X-Received: by 2002:a17:902:c949:b0:215:9642:4d7a with SMTP id d9443c01a7336-220bb549c13mr127074865ad.0.1739456000686;
        Thu, 13 Feb 2025 06:13:20 -0800 (PST)
Received: from localhost ([240f:74:7be:1:5439:d90c:a342:e2bb])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d556d468sm12688925ad.167.2025.02.13.06.13.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 06:13:20 -0800 (PST)
Date: Thu, 13 Feb 2025 23:13:18 +0900
From: Koichiro Den <koichiro.den@canonical.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-gpio@vger.kernel.org, brgl@bgdev.pl, linus.walleij@linaro.org, 
	maciej.borzecki@canonical.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 04/10] gpio: aggregator: add read-write 'name'
 attribute
Message-ID: <u5ymxczuu6xa2zhuoebasysham34fqokg52rmspropouxgkgaz@w52wq77dpxvw>
References: <20250203031213.399914-1-koichiro.den@canonical.com>
 <20250203031213.399914-5-koichiro.den@canonical.com>
 <CAMuHMdXnST1Y3oxEz_r59urauZ42nrtL5P4+rnPEsgiKgENOOg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdXnST1Y3oxEz_r59urauZ42nrtL5P4+rnPEsgiKgENOOg@mail.gmail.com>

On Wed, Feb 12, 2025 at 03:27:50PM GMT, Geert Uytterhoeven wrote:
> Hi Den,
> 
> On Mon, 3 Feb 2025 at 04:12, Koichiro Den <koichiro.den@canonical.com> wrote:
> > Previously, there is no way to assign names to GPIO lines exported
> > through an aggregator.
> >
> > Allow users to set custom line names via a 'name' attribute.
> >
> > Signed-off-by: Koichiro Den <koichiro.den@canonical.com>
> 
> Thanks for your patch!
> 
> > --- a/drivers/gpio/gpio-aggregator.c
> > +++ b/drivers/gpio/gpio-aggregator.c
> > @@ -63,6 +63,8 @@ struct gpio_aggregator_line {
> >         /* Line index within the aggregator device */
> >         int idx;
> >
> > +       /* Custom name for the virtual line */
> > +       char *name;
> 
> This can be const.

Will fix in v3.

> 
> >         /* GPIO chip label or line name */
> >         char *key;
> 
> Actually this can be const, too.

Will fix in v3.

> 
> >         /* Can be negative to indicate lookup by line name */
> > @@ -678,6 +680,44 @@ gpio_aggr_line_key_store(struct config_item *item, const char *page,
> >
> >  CONFIGFS_ATTR(gpio_aggr_line_, key);
> >
> > +static ssize_t
> > +gpio_aggr_line_name_show(struct config_item *item, char *page)
> > +{
> > +       struct gpio_aggregator_line *line = to_gpio_aggregator_line(item);
> > +       struct gpio_aggregator *aggr = line->parent;
> > +
> > +       guard(mutex)(&aggr->lock);
> > +
> > +       return sprintf(page, "%s\n", line->name ?: "");
> 
> sysfs_emit()

Will fix in v3.

Thanks!

Koichiro

> 
> > +}
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

