Return-Path: <linux-kernel+bounces-513117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 762AEA341B0
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 15:19:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B9B616AD99
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 14:17:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93D7C281346;
	Thu, 13 Feb 2025 14:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="Mdu12z+t"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 104F9281355
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 14:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739456245; cv=none; b=A2/ZvkpShME27WY2LMHCms57dIgcBTRoH1HL1T3Hh9H3XZdpbIPS9wobMnySlnLMife9ldUXkAabpSZ5U24wiUZkomgLSd76Sbkai66w5gGRp30g/PHift0Hh3iHDuehL5kiLj7gT432+tKvnDyE1hAR8Cb4WglCxOOyvIgzTYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739456245; c=relaxed/simple;
	bh=b7VrcOU7oK8YTQhJRUnUa3IN6tl3MYeYj8nrKA8XOjE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CeJUBWF5NXhWd4ZozGqLB+rZcyrHgZUalifrXRtfZLsRXrj6/POUbkHdGuhUS5Mha9GoRTlr8hIPirU6jKWjHK3aZGSpXlGGv+WfcSIxflYNM5mE90RwtKEOH0VPCQt/vgDPHzyLFVe1bb87ZOsIUaHPFAQTBfvOZbYj0xsZKhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=Mdu12z+t; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 098583FE6F
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 14:17:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1739456242;
	bh=nS5XbWIMngQR391kF03GHPM/jrDd/f8Q40NauUQr+EQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:In-Reply-To;
	b=Mdu12z+trlY/mil9wqqEXxoI3aLZxVpoOxghzdjztdLMeajccappCblivKGEySBZA
	 1sG1H6ll24B2ESnp3noaNEAQUfhLABTB7Ur8xJnLk2M4HfXwZiUtPMPfMG9T1uB1cq
	 IAB7tcCWW+OzbYHroDvlSPpAFA/EFqWpKwzeXldn+3I7zToddWn52UeP6zKZS/V5JS
	 c//ufrKbPXxbhWTZhQhUb3ugWW9FFzyNA5+dLGooMuA488YFbXoHKUZmMol2bv3Dji
	 V946n1gjn7NAlWH/iUXUTrSpfn/aBzrCch8Bc96Btl5cXazSdQFN65FfURFam3KsFL
	 gMDDffw7taRJg==
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-220d9d98ea6so19705285ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 06:17:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739456240; x=1740061040;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nS5XbWIMngQR391kF03GHPM/jrDd/f8Q40NauUQr+EQ=;
        b=VrcSo8CNRI5w0z0z3VsJWrElV3Rhysa5PzUE3LGkl02krIp13bf2GnTewxDLOBg5h3
         FCvUCL2iL6s8GqmkXLvrmMdgbOhxUXifV4jt5Cbd69j5hlA1f9egWWZQP6dozqJbGfQy
         fU3mXtuDw9lYVcS83rmrREHUBH6GHNQV7PXKuF74/t5sS4RPd2qEpZ1IXCw6QI3lquN1
         4Vh3BVO0YM6zLixLWMvnQpDKTgL9keQTKNy2ljKN2xdzm9tUrkNl3JMnWHfGjFP301d4
         skyykwQKANaKt/k1G8X7K3uZ6fjgyxHOsQT31NZqyyp3WvNYRYLsqSz3GphCjJnEcWZD
         kNYA==
X-Forwarded-Encrypted: i=1; AJvYcCVtbgfFCh8UCOROmwmzCIQbKiInl1Rw+YwbQiYFkD5gDeccd1Eubn5cmIfLUbxTE1gZ7sOpPjZCvVasR00=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSt7nHhGqpFKuVdS9S/oNre/Cmite0ZeNHRpO0DwMs0ZR3sxMh
	9tykFuydCHKcLKWyGOgTqUuk2FwODJjuvKu5aNb28iSsEzjddljO+AuzMbNPbP19+tytJlyRoeJ
	5D+6hy/cqEWAkgDaHWZpJ0IjG9mmqFmulkwWiOLPCURwM6jV2Il7/UbjSirdDLx2NYlYtqR6DZL
	SmsQ==
X-Gm-Gg: ASbGnct7D305pflJgyvu3yWgPWZBLZTVD5apF9OTYnGiwBovg4dSyc3elR4xMvAEPvT
	eN7APn2GsxNiPmTjWYhi7zFQQduqwS17/mIfyomSlDgv98nbsx3fAQ7fNDyDj/R41EZRgS9+RVF
	t1FnTyjum0o758SxDg6+8ESbM2KAlz29G4By8bIluNi08IsGzeRJT2m+Ik9awQ1fNse0Dx2ncnR
	2JaxcA1f2w8jqWzEeM42PQ5eALYc5E0Vu5W6C76K9CBh1s3UPJMZ+d6zNKIIiYJJ90zVFYGWklB
	Zo0LvFQ=
X-Received: by 2002:a17:902:e84b:b0:216:7cde:51a with SMTP id d9443c01a7336-220d20e930dmr56663545ad.28.1739456240584;
        Thu, 13 Feb 2025 06:17:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEI90/3XbV0wlGO0YTPFUOWeqWNFQVomLPku4YtxNMRfN+eWQhSiqVG/zQ+9qp7rTnp+szq3g==
X-Received: by 2002:a17:902:e84b:b0:216:7cde:51a with SMTP id d9443c01a7336-220d20e930dmr56663145ad.28.1739456240255;
        Thu, 13 Feb 2025 06:17:20 -0800 (PST)
Received: from localhost ([240f:74:7be:1:5439:d90c:a342:e2bb])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d5585072sm12749195ad.211.2025.02.13.06.17.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 06:17:19 -0800 (PST)
Date: Thu, 13 Feb 2025 23:17:18 +0900
From: Koichiro Den <koichiro.den@canonical.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-gpio@vger.kernel.org, brgl@bgdev.pl, linus.walleij@linaro.org, 
	maciej.borzecki@canonical.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 10/10] Documentation: gpio: document configfs
 interface for gpio-aggregator
Message-ID: <ylkqzw7u2mb24kow32xz6t37e56gcoqhztwzvl4wfrz4peuj6d@lf6i4whx4hbf>
References: <20250203031213.399914-1-koichiro.den@canonical.com>
 <20250203031213.399914-11-koichiro.den@canonical.com>
 <CAMuHMdXBJhpWht4eo569h0kdY+evi=JTgMQtccUxf2X+tX-QPQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdXBJhpWht4eo569h0kdY+evi=JTgMQtccUxf2X+tX-QPQ@mail.gmail.com>

On Wed, Feb 12, 2025 at 04:55:24PM GMT, Geert Uytterhoeven wrote:
> Hi Den-san.
> 
> On Mon, 3 Feb 2025 at 04:14, Koichiro Den <koichiro.den@canonical.com> wrote:
> > Add documentation for the newly added configfs-based interface for GPIO
> > aggregator.
> >
> > Signed-off-by: Koichiro Den <koichiro.den@canonical.com>
> 
> Thanks for your patch!
> 
> > --- a/Documentation/admin-guide/gpio/gpio-aggregator.rst
> > +++ b/Documentation/admin-guide/gpio/gpio-aggregator.rst
> > @@ -69,6 +69,99 @@ write-only attribute files in sysfs.
> >                     $ echo gpio-aggregator.0 > delete_device
> >
> >
> > +Aggregating GPIOs using Configfs
> > +--------------------------------
> > +
> > +**Group:** ``/config/gpio-aggregator``
> > +
> > +    This is the root directory of the gpio-aggregator configfs tree.
> > +
> > +**Group:** ``/config/gpio-aggregator/<example-name>``
> > +
> > +    This directory represents a GPIO aggregator device. You can assign any
> > +    name to ``<example-name>`` (e.g., ``agg0``), except names starting with
> > +    ``_auto`` prefix, which are reserved for auto-generated configfs
> > +    entries corresponding to devices created via Sysfs.
> > +
> > +**Attribute:** ``/config/gpio-aggregator/<example-name>/live``
> > +
> > +    The ``live`` attribute allows to trigger the actual creation of the device
> > +    once it's fully configured. The accepted values are: ``1`` to enable the
> > +    virtual device and ``0`` to disable and tear it down.
> 
> As the code uses kstrtobool(), it accepts variants of
> yes/true/on/no/false/off, too.

Thanks for pointing that out. I'll modify this part.

> 
> > +
> > +**Attribute:** ``/config/gpio-aggregator/<example-name>/dev_name``
> > +
> > +    The read-only ``dev_name`` attribute exposes the name of the device as it
> > +    will appear in the system on the platform bus (e.g. ``gpio-aggregator.0``).
> > +    This is useful for identifying a character device for the newly created
> > +    aggregator. If it's ``gpio-aggregator.0``,
> > +    ``/sys/devices/platform/gpio-aggregator.0/gpiochipX`` path tells you that the
> > +    GPIO device id is ``X``.
> > +
> > +You must create subdirectories for each virtual line you want to
> > +instantiate, named exactly as ``line0``, ``line1``, ..., ``lineY``, when
> > +you want to instantiate ``Y+1`` (Y >= 0) lines.  Configure all lines before
> > +activating the device by setting ``live`` to 1.
> > +
> > +**Group:** ``/config/gpio-aggregator/<example-name>/<lineY>/``
> > +
> > +    This directory represents a GPIO line to include in the aggregator.
> > +
> > +**Attribute:** ``/config/gpio-aggregator/<example-name>/<lineY>/key``
> > +
> > +**Attribute:** ``/config/gpio-aggregator/<example-name>/<lineY>/offset``
> > +
> > +    If ``offset`` is >= 0:
> > +        * ``key`` specifies the name of the chip this GPIO belongs to
> > +        * ``offset`` specifies the line offset within that chip.
> > +    If ``offset`` is <0:
> 
> Missing space before 0.
> Please add "(default)", so the user knows he can skip writing to this
> file when specifying a GPIO line name.

That makes sense. Thanks for the review!

Koichiro

> 
> > +        * ``key`` needs to specify the GPIO line name.
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

