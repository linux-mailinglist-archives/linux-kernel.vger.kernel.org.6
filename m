Return-Path: <linux-kernel+bounces-554339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04F24A59665
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 14:32:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 255C516566E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 13:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0961A22ACDC;
	Mon, 10 Mar 2025 13:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="loGHcEf0"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 873E322A819
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 13:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741613548; cv=none; b=vCwPFCqpvXHRcokl5fyFU9BZC309mysL//jdnwZfiw749ORwGP3QhgBFc/XbLLg19KKe6IdDZiX/JsJwSmidIHnPBI9PsgVWgVmVNAcNhpv2xwcc3zVWnOTIqHj5fiVtWsh4k+sJvePApqZvVWFGNHn+Sr7iLKqo1xV8/rIKLPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741613548; c=relaxed/simple;
	bh=mLdxVos0hPyLd2bmuvUrymnzAJjvTnjjfAT+4GunGm8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dOqgh0epC4yznBwUZiK6hQgheyoR08ZvDHADvV4262cjPH4Kmw4OTQXGHNgJ4GuvGn2W1k9VO0B5xBpO3Ax5OraC8sOFw9SY76H/SrsqTrEHHtD2l/n8DXhytsbgjA1wgI/nN8L6sC72zlSHHybp2OTEE3YMs9/A8NDtdo1nxYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=loGHcEf0; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id B57503F5B0
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 13:32:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1741613536;
	bh=HaCDmfpp8ZRPXhUw4ZNlmKPznZLLlpm1APhqUxOUw6M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:In-Reply-To;
	b=loGHcEf0YAv1ppFDAeIRIRnx5q+dbD9a3fuw83OK50wvYOC00Pf62JnW3qgi9NGBM
	 OjmBE2kBej3NtHu1QIV8dQ2yx3sVM42XGwPhJtZujjgWiTEwv/1CSZMC9lWGisf9uf
	 oz/GS5ZpU2lH+/jHv/xH6fBrpm6tBMog2t0YVib/1Rtc5+bH7HrQhzH4MukSodpcqd
	 qKHR/hz23omI40dOzIcJhurftwH0WmLF11EsutTvOprCL26AbeCiBO6hgcukU8OM51
	 JBl2E/IZ5x2Zq+5dk4RK9s41WcOCP+BfAjyniuOZvxik0TuIfqeNCHpkCoPtoyF5Pg
	 s1r5RiEKcvSoQ==
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2ff7aecba07so5709848a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 06:32:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741613535; x=1742218335;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HaCDmfpp8ZRPXhUw4ZNlmKPznZLLlpm1APhqUxOUw6M=;
        b=Fcb+Di2/HhGmvqAOq3u0aVZ4IAZUZqI7nuFag747EiTsr3DMCEgOzYINVS0K7xbD8z
         7uj2o9sZSwm7xQeMtJIJyppu4aaVhPrdWz9NISBAGHHNYX8nrbkEZuGvrIXlPjv4TUhB
         2h938CYSV3CteVGMjwAgSbKgT2RNe0MOssNin9cThu2owGr/DIEGGDq38pwa8yNXVzvy
         yoQf6omuAKATAM0LqKnAxkOY+cRI+nzPy7kwqf9zXVJqSZV7IxlYh2tI8lEu8wY6n0mR
         MIlyM7BA+mULNuDMTXCiZ1ymPF2ec/X1fhe8fkzIzNJQDUR6m8AtlAqUWtFohD7YVIN1
         xasA==
X-Forwarded-Encrypted: i=1; AJvYcCVfK4394/fgzI+rqJ6xW+WhF1/ut0kGKQJdFTX0YHOOFeF6PaL6YZRZtAbzdIl2Q4QA6OtkF+4p+cUiBU0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuDvTZvyryTM44QPzTTttODc3cUc2/awNzvH45EpGFrA0SAMIk
	CLbhRredm0GMOr0BTaXbuemJ+6/QrtGbCeSVy4Ojxi7J4t1fpK4hkVMNJ1WqRqk8l66GsU/BdEY
	eko37Row+eIJfCuKOPcs28tPhm4Vhj1wFdATrwBO+ldOrw4YVU8dI7v1izIPugK4GYdLviiy4r1
	lbPw==
X-Gm-Gg: ASbGncvM54XI3IO97i1NPhpJOfNAtiHKZUphZ5Ap9NPOsGFn4DU1RMjqNGAvkxqA38Y
	DGjRy10DGpv1knFYpwon06BBfLCLE2mEj0VK7FrJA9STqwT+UsVawYTNv+QR/EuCSK2cyT7SLoH
	0YQLRY/HLVCz5RlBQp5MwiYVZgoGvXrv2ctqfkjBZzZR7it2ISBl4RQMJnUzyo4fXc4ZihqPx9P
	yKvryyESDKjCQIgZjbTSuJcJvPUY/prJYUCmiTBhNW0YS8Mtpr3EsBTCSooAfaaWIayHgIPuV8I
	9IfHQfV/T3dWsJsFUg==
X-Received: by 2002:a17:90b:394d:b0:2fe:a545:4c84 with SMTP id 98e67ed59e1d1-2ff7cf13eddmr17068166a91.34.1741613535215;
        Mon, 10 Mar 2025 06:32:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGHz263sGPsYQaHEeN0+wO5Ne+rOpPHxsfXurrvf0VqTDGXjQ+3335KRj6Lff0lJoRAFMdhBw==
X-Received: by 2002:a17:90b:394d:b0:2fe:a545:4c84 with SMTP id 98e67ed59e1d1-2ff7cf13eddmr17068137a91.34.1741613534819;
        Mon, 10 Mar 2025 06:32:14 -0700 (PDT)
Received: from localhost ([240f:74:7be:1:55b0:de12:de5a:26cc])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ff4e7747aesm9740634a91.20.2025.03.10.06.32.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 06:32:14 -0700 (PDT)
Date: Mon, 10 Mar 2025 22:32:12 +0900
From: Koichiro Den <koichiro.den@canonical.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-gpio@vger.kernel.org, geert+renesas@glider.be, 
	linus.walleij@linaro.org, maciej.borzecki@canonical.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 0/9] Introduce configfs-based interface for
 gpio-aggregator
Message-ID: <oedikhiegt3iqj7xg4vtfhlqxihicd7bdtaglk73q2m3c42zla@roh336fpkszm>
References: <20250224143134.3024598-1-koichiro.den@canonical.com>
 <CAMRc=Me9_EvVj2U-wGWjoVyH_igZBtUs1ymtE=4_r2EkSBAAcA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=Me9_EvVj2U-wGWjoVyH_igZBtUs1ymtE=4_r2EkSBAAcA@mail.gmail.com>

On Mon, Mar 10, 2025 at 11:19:40AM GMT, Bartosz Golaszewski wrote:
> On Mon, Feb 24, 2025 at 3:31 PM Koichiro Den <koichiro.den@canonical.com> wrote:
> >
> > This patch series introduces a configfs-based interface to gpio-aggregator
> > to address limitations in the existing 'new_device' interface.
> >
> > The existing 'new_device' interface has several limitations:
> >
> >   Issue#1. No way to determine when GPIO aggregator creation is complete.
> >   Issue#2. No way to retrieve errors when creating a GPIO aggregator.
> >   Issue#3. No way to trace a GPIO line of an aggregator back to its
> >            corresponding physical device.
> >   Issue#4. The 'new_device' echo does not indicate which virtual
> >            gpiochip<N> was created.
> >   Issue#5. No way to assign names to GPIO lines exported through an
> >            aggregator.
> >
> > Although Issue#1 to #3 could technically be resolved easily without
> > configfs, using configfs offers a streamlined, modern, and extensible
> > approach, especially since gpio-sim and gpio-virtuser already utilize
> > configfs.
> >
> > This v5 patch series includes 9 patches:
> >
> >   Patch#1: Fix an issue that was spotted during v3 preparation.
> >   Patch#2: Reorder functions to prepare for configfs introduction.
> >   Patch#3: Add aggr_alloc() to reduce code duplication.
> >   Patch#4: Introduce basic configfs interface. Address Issue#1 to #4.
> >   Patch#5: Address Issue#5.
> >   Patch#6: Prepare for Patch#7.
> >   Patch#7: Expose devices created with sysfs to configfs.
> >   Patch#8: Suppress deferred probe for purely configfs-based aggregators.
> >   Patch#9: Documentation for the new configfs interface.
> >
> > N.B. This v5 is based on the latest gpio/for-next commit as of writing this:
> >      * 45af02f06f69 ("gpio: virtuser: convert to use dev-sync-probe utilities")
> >
> >
> > v4->v5 changes:
> >   - Rebased off of the latest gpio/for-next, that includes the patch series:
> >     "Add synchronous fake device creation utility for GPIO drivers"
> >     (https://lore.kernel.org/all/20250221133501.2203897-1-koichiro.den@canonical.com/)
> >
> > v3->v4 changes:
> >   - Splitted off the introduction of gpio-pseudo.[ch] and conversions.
> >   - Reordered commits to place a fix commit first.
> >   - Squashed the trivial update for gpio-aggregator's conversion to gpio-pseudo
> >     into the primary commit "gpio: aggregator: introduce basic configfs interface"
> >     as it is only meaningful when combined.
> >
> > v2->v3 changes:
> >   - Addressed feedback from Bartosz:
> >     * Factored out the common mechanism for synchronizing platform device
> >       probe by adding gpio-pseudo.[ch].
> >     * Renamed "_auto." prefix to "_sysfs." for auto-generated
> >       configfs entries corresponding to sysfs-created devices.
> >     * Squashed v2 Patch#3 into its predecessor.
> >   - Addressed feedback from Geert:
> >     * Factored out duplicate code in struct gpio_aggregator initialization
> >       by adding gpio_alloc()/gpio_free() functions. Note that v2 Patch#7
> >       was dropped for other reasons as mentioned below, so aggr_free() in
> >       v3 is unrelated to the same-named function in v2.
> >     * Removed redundant parsing of gpio-line-names and unnecessary
> >       chip->names assignments; squashed v2 Patch#4 + v2 Patch#5 into v3
> >       Patch#9.
> >     * Updated to use sysfs_emit().
> >     * Updated Kconfig (select CONFIGFS_FS).
> >     * Fixed typos, coding style issues, missing const qualifiers, and other
> >       minor issues.
> >   - Resolved an issue that was spotted during v3 preparation. See Patch#2.
> >   - Reordered resource initialization order in gpio_aggregator_init() to
> >     both eliminate a potential race condition (as noted in the source code
> >     comment) and simplify the code. See Patch#8. This enabled:
> >     * Removal of v2 Patch#7.
> >     * Merging of aggr_unregister_lines() and aggr_free_lines() into a
> >       unified function.
> >   - Disabled 'delete_device' functionality for devices created via configfs
> >     for simplicity. It was mistakenly allowed in v2 and proved buggy. See
> >     Patch #8.
> >
> > RFC->v2 changes:
> >   - Addressed feedback from Bartosz:
> >     * Expose devices created with sysfs to configfs.
> >     * Drop 'num_lines' attribute.
> >     * Fix bugs and crashes.
> >     * Organize internal symbol prefixes more cleanly.
> >   - Split diffs for improved reviewability.
> >   - Update kernel doc to reflect the changes.
> >
> > v4: https://lore.kernel.org/all/20250217143531.541185-1-koichiro.den@canonical.com/
> > v3: https://lore.kernel.org/all/20250216125816.14430-1-koichiro.den@canonical.com/
> > v2: https://lore.kernel.org/all/20250203031213.399914-1-koichiro.den@canonical.com/
> > RFC (v1): https://lore.kernel.org/linux-gpio/20250129155525.663780-1-koichiro.den@canonical.com/T/#u
> >
> >
> > *** BLURB HERE ***
> >
> > Koichiro Den (9):
> >   gpio: aggregator: protect driver attr handlers against module unload
> >   gpio: aggregator: reorder functions to prepare for configfs
> >     introduction
> >   gpio: aggregator: add aggr_alloc()/aggr_free()
> >   gpio: aggregator: introduce basic configfs interface
> >   gpio: aggregator: add 'name' attribute for custom GPIO line names
> >   gpio: aggregator: rename 'name' to 'key' in aggr_parse()
> >   gpio: aggregator: expose aggregator created via legacy sysfs to
> >     configfs
> >   gpio: aggregator: cancel deferred probe for devices created via
> >     configfs
> >   Documentation: gpio: document configfs interface for gpio-aggregator
> >
> >  .../admin-guide/gpio/gpio-aggregator.rst      |  107 ++
> >  drivers/gpio/Kconfig                          |    2 +
> >  drivers/gpio/gpio-aggregator.c                | 1129 ++++++++++++++---
> >  3 files changed, 1050 insertions(+), 188 deletions(-)
> >
> > --
> > 2.45.2
> >
> 
> I did some more testing as I want to pick it up for v6.15 but I now
> noticed that we're hitting the lockdep_assert_held(&aggr->lock) splat
> in aggr_line_add(). Could you please look into it?

Thanks. Could you share with me a sample splat?

Koichiro

> 
> Bartosz

