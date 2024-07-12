Return-Path: <linux-kernel+bounces-251155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC44B930152
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 22:42:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DADC1F239E6
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 20:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 655A9450EE;
	Fri, 12 Jul 2024 20:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GvBAImIl"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E84FA2C879
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 20:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720816946; cv=none; b=nDKWEyUIRmT5cD5KU1NJEQrcvxNqvqBzx8ZPPNc9JnTrBhJlpNoR1r4AVbWCmodSJ0K+5mQItofa9IFqFLQjve3DEyUq+xpiB2XfLsvV62UJRNH0U3eNmCuIJY4pgLe0F8+Zi3F+6r2uODkzcOrUmigR8eDs3ZoGBAfE89Nl1x4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720816946; c=relaxed/simple;
	bh=k7jEmWRTi+s3vPIVbUx+yD39cMsEEr49hfKeqgI5KtY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tsuyETL4W0068cgX7Vn05BiqUGF+Vuwt7tA8g2XV5f/7NHkK8AHXcpGWFv5DbFzkeXzsluER8wxxW+0ABTbPfmoDTiAynOTF5GugrwucA6pcPv+1Scw6B3nk7q5YWa5d+lrt7xO/WQQV/Ex8AdQ6c3bab/ZtBipw829uEK5mkKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=GvBAImIl; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2c9785517c0so1921240a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 13:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1720816944; x=1721421744; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=x9wp47OYngyliTTYyLDXi2nd3567NMYaCV1L/AeO+f4=;
        b=GvBAImIlpjvXwrxHt9qps4ieR+Msvwwtmq+TTxgLhlLzjTpzs4oCrmM2RGOIE9rgFc
         qxWvOw3ihv21PfugOTb9ljFYmcM1pML6lG2zVMw7yVA/c6obHBkQiAzV4gYrM2GWEWKt
         szXGqPcnN0dleMUbRtkAFkWoMenEjMixns/yc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720816944; x=1721421744;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x9wp47OYngyliTTYyLDXi2nd3567NMYaCV1L/AeO+f4=;
        b=s5uUfebAk9UC99t49jTJb+jymBZQZ6RwHtxJGc9ZZSNOxKicmwp38T+GN6PuU0WsKS
         3DcdwTtLPfabjAfC91BkwqLiZUH42Za+kxUtPtg/MTjE/iKlM9DlDCkvZQCo3Q3hNzl6
         vPhy2EJ2pCergcF3KWRHWyaZadpx6bwQpw85WhHb5UAeyjesKOKWc4oVV+sVnaNgOZWw
         hPrEIlgRrtlNdwXvvuYOyKOnbWu0NhLvrxIjYyj9gu97UrVnrcQhLV2oeTO/hvR1ia6m
         /jLO+38Q+ViI9u7tQon87c+dAPlXOFTHJbCn6jRLkkN/aflULiKGY6EhGMqlUken5scb
         3Gvg==
X-Forwarded-Encrypted: i=1; AJvYcCXwQ3T4edSe/YAoFBmLuzJciNexveSAQQwfM4cotmZ0nzfhQqG1n452KzQ4tbjmxYt/dAYsxLV8mKzY/AP4/KhrNsS7GBjnYEQVXnOL
X-Gm-Message-State: AOJu0YzlolYLcP5P05+okga9Eg7w7tQbSkLu95VSz67gL+zvME9x1FeS
	b9+2N6tFRaKdt5/dRWqwO6aKNsMpOIe/BztTGrlH8ZFlRovtRI1xePuQdNaxUQ==
X-Google-Smtp-Source: AGHT+IFr5zH5TRdT/VLvqM+j6Yr6A7tkJwV8KD3X7qbjk/0ENcQSdTA/lPpfJWLjb4epqt3DQPWS8g==
X-Received: by 2002:a17:90b:189:b0:2c8:6793:456 with SMTP id 98e67ed59e1d1-2ca35a59631mr11588678a91.0.1720816944113;
        Fri, 12 Jul 2024 13:42:24 -0700 (PDT)
Received: from localhost ([2620:15c:9d:2:7546:30be:53d8:7f93])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-2cacd2d08d5sm2005727a91.6.2024.07.12.13.42.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jul 2024 13:42:23 -0700 (PDT)
Date: Fri, 12 Jul 2024 13:42:22 -0700
From: Brian Norris <briannorris@chromium.org>
To: Yury Norov <yury.norov@gmail.com>
Cc: Nathan Chancellor <nathan@kernel.org>, llvm@lists.linux.dev,
	linux-kernel@vger.kernel.org, Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Kees Cook <kees@kernel.org>
Subject: Re: [PATCH v2] bitmap: Switch from inline to __always_inline
Message-ID: <ZpGVLl7NQZScd8aH@google.com>
References: <20240711163732.1837271-1-briannorris@chromium.org>
 <ZpFhv5VSYZ6jnsd4@yury-ThinkPad>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZpFhv5VSYZ6jnsd4@yury-ThinkPad>

Hi Yury,

On Fri, Jul 12, 2024 at 10:02:55AM -0700, Yury Norov wrote:
> On Thu, Jul 11, 2024 at 09:37:11AM -0700, Brian Norris wrote:
> > Based on recent discussions, it seems like a good idea to inline the
> > bitmap functions which make up cpumask*() implementations, as well as a
> > few other bitmap users, to ensure the inlining doesn't break in the
> > future and produce the same problems, as well as to give the best chance
> > that the intended small_const_nbits() optimizations carry through.
> 
> small_const_nbits() optimization always carries through. As far as I
> understand this things, the problem is that inliner may make a (wrong)
> no-go decision before unwinding the small_const_nbits() part.
> 
> small_const_nbits() always leads to eliminating either inline or outline
> code, but inliner seemingly doesn't understand it. This leads to having
> those tiny functions uninlined.

I think we're more or less saying the same thing -- if for whatever
reason the compiler doesn't inline, then these will never be "small
consts", and therefore the machinery effectively "doesn't carry
through".

Per previous discussions, there are many reasons a compiler may ignore
the 'inline' hint.

> But I'm not sure about that and don't know how to check what happens
> under the compilers' hood. Can compiler gurus please clarify?
> 
> > This change has been previously proposed in the past as:
> > 
> >   Subject: [PATCH 1/3] bitmap: switch from inline to __always_inline
> >   https://lore.kernel.org/all/20221027043810.350460-2-yury.norov@gmail.com/
> > 
> > In the end, this looks like a rebase of Yury's work, although
> > technically it's a rewrite.
> 
> I like it more, when it's split onto several patches. We already have
> my bitmap.h rework and your cpumask.h one with their own reasonable
> motivations. Can you keep that patch structure please? Then, we can add

I'm not quite sure what you mean. I imitated the patch structure of your
patch 1 that I linked, which had the following file-diff list:

 include/linux/bitmap.h   |  46 ++++++-------
 include/linux/cpumask.h  | 144 +++++++++++++++++++--------------------
 include/linux/find.h     |  40 +++++------
 include/linux/nodemask.h |  86 +++++++++++------------

Are you suggesting I should split that into 2 (one for cpumask and one
for the rest)?

> separate patches for find.h and nodemask.h. If rebasing the old bitmap.h
> patch isn't clean and takes some effort, feel free to add your
> co-developed-by.

I don't really care who gets authorship, but I did manually rewrite it,
since there were enough conflicts, and it's basically scriptable. Feel
free to suggest which Author/S-o-b/Co-developed combo makes sense for
that, and I can adopt it in v3 :)

> > According to bloat-o-meter, my vmlinux decreased in size by a total of
> > 1538 bytes (-0.01%) with this change.
> > 
> > [0] CONFIG_HOTPLUG_PARALLEL=y ('select'ed for x86 as of [1]) and
> >     CONFIG_GCOV_PROFILE_ALL.
> > 
> > [1] commit 0c7ffa32dbd6 ("x86/smpboot/64: Implement
> >     arch_cpuhp_init_parallel_bringup() and enable it")
> > 
> > Cc: Yury Norov <yury.norov@gmail.com>
> > Signed-off-by: Brian Norris <briannorris@chromium.org>
> 
> So... This whole optimization is only worth the reviewer's time if we
> can prove it's sustainable across different compilers and configurations.
> 
> Just saying that under some particular config it works, brings little
> value for those who are not interested in that config. Moreover, if
> one enables GCOV, he likely doesn't care much about the .text size.
> And for those using release configs, it only brings uncertainty.

I think I partially disagree. If it's neutral for one compiler but
helpful for the other, that's still a win. But otherwise, I agree we
should have some accounting of diversity -- not just a single test.

> Let's test it broader? We've got 2 main compilers - gcc and llvm, and
> at least two configurations that may be relevant: defconfig and your
> HOTPLUG_PARALLEL + GCOV_PROFILE_ALL. And it would be nice to prove
> that the optimization is sustainable across compiler versions.
> 
> I have the following table in mind:
> 
>            defconfig   your conf  
> GCC    9 |  -1900    |           |
> CLANG 13 |           |           |
> GCC   13 |           |           |
> CLANG 18 |  -100     |  -1538    |
> 
> The defconfig nubmers above are from my past experiments. And you can
> add more configs/compilers, of course.

Perhaps I wasn't too clear, but I was actually testing a few things:

* my ChromeOS-y build, with gcov and clang -- to ensure the section
  mismatch warning/error disappears
* a pure mainline / semi-defaults build (which happened to use my host
  distro's gcc 13), to do size comparisons. I also happened to enable
  gcov in the currently-posted experiments.

But agreed, I can get a larger matrix with a bit more specifity in my
commit log. TBD on the ease of getting a Clang 13 or GCC 9 toolchain,
but I think I can convince my distro to provide them.

> > --- a/include/linux/bitmap.h
> > +++ b/include/linux/bitmap.h
> > @@ -203,7 +203,7 @@ unsigned long bitmap_find_next_zero_area_off(unsigned long *map,
> >   * the bit offset of all zero areas this function finds is multiples of that
> >   * power of 2. A @align_mask of 0 means no alignment is required.
> >   */
> > -static inline unsigned long
> > +static __always_inline unsigned long
> >  bitmap_find_next_zero_area(unsigned long *map,
> >  			   unsigned long size,
> >  			   unsigned long start,
> 
> Let's split them such that return type would be at the same line as
> the function name. It would help to distinguish function declaration
> from invocations in grep output:

Ack. I thought I was being consistent with existing cpumask.h style, but
I got this set wrong. Will fix.

Brian

