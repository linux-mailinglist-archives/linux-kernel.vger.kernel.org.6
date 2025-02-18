Return-Path: <linux-kernel+bounces-519666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C9BBBA3A060
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 15:49:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34060188981F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 14:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7D9526A0D2;
	Tue, 18 Feb 2025 14:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="OvK8TTvn"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 623E426AA8E
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 14:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739889909; cv=none; b=d9o1+pi1VbXAUOuWO836cNpBqSfV7SEIznXAbQqQA0XHO5WfH3m4AnYAXi95sbGnGfRxLgJ/QtmtsXu/3pzZBc6S5YaueAvsBbFs1uLorNktQlILIm6Da8r2eeLF0aoQ9eMn/B7VLbUxsYihAkrGvpS4t5F9mkJi17p6lwiMbiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739889909; c=relaxed/simple;
	bh=NbvVt7BZF1i5sDpL0YhX6xjDp5pujBMRRwFAm4iHKtQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u9BQSNY/BUFzN0WUCLC28NaJWyBAyNxGhOpqviwKE8V2GoxM6kjdOXKn1w7MnAeduAmluLAcK+9sCGMNNw/x2eEouZ5uVIu057vWxmte2cg6zoKa+8zypyZbvANUeCGh5K2Vv/HB1E7RFXOCqivZDiPyatL6roo4TMrI9PyAHgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=OvK8TTvn; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 398583F296
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 14:44:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1739889898;
	bh=2wnnPPobX2+s1VhoPCe771be48GL2/WpZ73Ug6pSCno=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:In-Reply-To;
	b=OvK8TTvnopKxfjLtGqL/qstq7ieSwR1kugcidusdbC1AUNn3deRkxdjD+Hwgvh3B4
	 sRyGbcnEGHltrkskp8fdahPjs6ent7AmJ8twqjH8m/VbAKDll2Hegqbfj+6Sr+JZ9T
	 6M34Ke/6Q2QqhLnts511gEVwsgIPZ+LxCdFJ5VZyV8wbt+P6AYVegu7Rs2DdmsSwJr
	 FkkLHvKZSMgRHc4N4PnsnxJ6K4fgghVw6kUjWnAF4CQ/bAl0k2WvX3oMRtAi917Vuj
	 WiUJZhbZfSaorvOAClv2OdfNfAH3/uZ9NJZlru9ABSG44eNiR2/tUxN4AB08gd3m8v
	 OhzkGXRLRIhQQ==
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2f46b7851fcso17771209a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 06:44:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739889895; x=1740494695;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2wnnPPobX2+s1VhoPCe771be48GL2/WpZ73Ug6pSCno=;
        b=lmhRAzyWDw0QCGtqZKZk2eWe8vVIQEr2B97UbKgJzz6mRNikc8zBGoOVGg5dhZauKy
         2cdkK8zT6xpbha6Jh5oXqcp63efAY7cn8N3F981W6jGSU1lVfvkUIK2U/5H5fcBd5n5w
         s+KFIwD/hpQAdg8sBYeG+9tGRytu2jZ43tqqqAKEkw2mp9bixctUMv3ClWqU8i4hG/2+
         SIuTL0lRPHxeae6jKCfraXLG2AUvIgoEaY1gq7tdwMXqMnJgl7slRClAYW1nI7Jj4cHE
         IawKVspnj1QbB9Y30Nq/kD5vsyld0jnclyyWcEsJpawZ/dKf5KJpyDUaFn2hli75kuBA
         qZsQ==
X-Forwarded-Encrypted: i=1; AJvYcCWuPPIrAKT+j+BfFOa5ZrUSeclnTpK5/zLZPhEg2xGBMjwCqEcaM4PRuo6tYi5bldiOtwmwykuk/434mlA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLG0NU3wnl1VP/hcO+2vvXT9YJ+9bHvLuWTLvFqvZwBtuSMzl/
	mt4/6aCG8eYEe2SMyyIjJd2tj4/ypK+SOvaXX7TnsHtbh15knleHSFA84b5aPETRLrXXGB90n0J
	+ryBXOo9nDvRLNyyBpaW508dwXuYQud5VLWf6ZWSu5n1ZwRh0IlVDGqF5BpiNhVDgMs0h/tJzyn
	f+cw==
X-Gm-Gg: ASbGnctHE0/64MxXvNlPUhb7rNvFUuXWz1gxaQaekTrXwVl4R7ahzL3H857yUYx3vFa
	yrJYYHDPg80TiFXQdy0aVtcB3uCgNTJVB0v95dRxGzEoTTzIZet4wDXOuYWpb79rIm/D2a4C73U
	Twk5IvhJI6/pXdD23pcVgIhTMCWkAzuNouiQTeI6A5ZTb8ZhKNtnK90JTwMKXCssqNByMVVerqS
	EFkN6xrLWhtyRPox11nfWQQyKKbKRCQ99BUG8B5sQ6a8DR8qbzE1jvCTUVpW79ex6xAs2ntgmc9
	GNABhBE=
X-Received: by 2002:a17:90b:3c82:b0:2fa:13f7:960 with SMTP id 98e67ed59e1d1-2fc40f0e9dbmr22090218a91.13.1739889895160;
        Tue, 18 Feb 2025 06:44:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IESbv8ZqGzwl13GA+Js7FWx5Lo/XTUtgadox++6SX63lhnE16lduw+yIem+lsV7vCbgIXUszw==
X-Received: by 2002:a17:90b:3c82:b0:2fa:13f7:960 with SMTP id 98e67ed59e1d1-2fc40f0e9dbmr22090187a91.13.1739889894839;
        Tue, 18 Feb 2025 06:44:54 -0800 (PST)
Received: from localhost ([240f:74:7be:1:ad3a:e902:d78b:b8fa])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fbf999b5ddsm12120512a91.37.2025.02.18.06.44.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 06:44:54 -0800 (PST)
Date: Tue, 18 Feb 2025 23:44:52 +0900
From: Koichiro Den <koichiro.den@canonical.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-gpio@vger.kernel.org, brgl@bgdev.pl, linus.walleij@linaro.org, 
	maciej.borzecki@canonical.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] gpio: pseudo: common helper functions for pseudo
 gpio devices
Message-ID: <osk442flgow3px5jilhrn57xm2ha5wyrsnjae2mz4ht2dvgg2t@e7bzgjqawgik>
References: <20250217142758.540601-1-koichiro.den@canonical.com>
 <20250217142758.540601-2-koichiro.den@canonical.com>
 <CAMuHMdWSBXHE9t2pMV+9iZRzrTUGVG+dnxxOMWbVF+HeCpt-xA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMuHMdWSBXHE9t2pMV+9iZRzrTUGVG+dnxxOMWbVF+HeCpt-xA@mail.gmail.com>

On Tue, Feb 18, 2025 at 02:24:32PM GMT, Geert Uytterhoeven wrote:
> Hi Den-san,
> 
> On Mon, 17 Feb 2025 at 15:28, Koichiro Den <koichiro.den@canonical.com> wrote:
> > Both gpio-sim and gpio-virtuser share a mechanism to instantiate a
> > platform device and wait synchronously for probe completion.
> > With gpio-aggregator adopting the same approach in a later commit for
> > its configfs interface, it's time to factor out the common code.
> >
> > Add gpio-pseudo.[ch] to house helper functions used by all the pseudo
> > GPIO device implementations.
> >
> > No functional change.
> >
> > Signed-off-by: Koichiro Den <koichiro.den@canonical.com>
> 
> Thanks for your patch!
> 
> > --- /dev/null
> > +++ b/drivers/gpio/gpio-pseudo.c
> 
> > +int pseudo_gpio_register(struct pseudo_gpio_common *common,
> > +                        struct platform_device_info *pdevinfo)
> > +{
> > +       struct platform_device *pdev;
> > +       char *name;
> > +
> > +       name = kasprintf(GFP_KERNEL, "%s.%u", pdevinfo->name, pdevinfo->id);
> > +       if (!name)
> > +               return -ENOMEM;
> > +
> > +       common->driver_bound = false;
> > +       common->name = name;
> > +       reinit_completion(&common->probe_completion);
> > +       bus_register_notifier(&platform_bus_type, &common->bus_notifier);
> > +
> > +       pdev = platform_device_register_full(pdevinfo);
> > +       if (IS_ERR(pdev)) {
> > +               bus_unregister_notifier(&platform_bus_type, &common->bus_notifier);
> > +               kfree(common->name);
> 
> On arm32:
> error: implicit declaration of function ‘kfree’
> 
> Adding #include <linux/slab.h> fixes that.
> Probably you want to include a few more, to avoid relying on
> implicit includes.

Thank you for pointing that out!

Koichiro

> 
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

