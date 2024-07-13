Return-Path: <linux-kernel+bounces-251254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20C679302B2
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 02:19:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A435B283565
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 00:19:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E74379DC;
	Sat, 13 Jul 2024 00:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ckINCUyn"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 752441849
	for <linux-kernel@vger.kernel.org>; Sat, 13 Jul 2024 00:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720829970; cv=none; b=dWF2eIjEGTopUEcU4bLuDC0h06OLPRsC9rxn1OMPr7oznlpN4aF05ohaFgBLsSNB/LhKgrzb5b0kdrMDV/33HIFCOFmG4Ph99FsHuGnfz2Fd9YRoqT9Ta4gIjR63zgPMCww+r4aKg4CubDMVIGeDpGfLQjrn1WWQMfjHC52e/fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720829970; c=relaxed/simple;
	bh=vLk9e6f6ZIdLgxWwuGIJRVBysmnMnaoOmXt9U6jRDOc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c+fTX4n5qkFiydALVHcxK4sCfH4mIj4WsvWLtSm3Dv+uTqzVdA24CrtrZng1twR7S1wWd8/y8LzmzgqD5PLnEeQwbZV+u8Rvo7cv+8Hlc0sfc8NaTb+fFr3VwFybpPc2a+F/606tCHcQ9Q5nUBgJqpUCccC4NlBEw5zwB4lDXQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ckINCUyn; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-70af22a9c19so2019656b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 17:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720829967; x=1721434767; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=X+BjHHa++K3M8o/jlc41ALJl1/CW2inFabQbWOCaWdc=;
        b=ckINCUyntskwm8pR0AdFY/2UVZwdhjyXLwbg1hsd0HQYYXdk+RM5jFDUCSvRlcP5VV
         RyV6PyuBbHZ8xtgauDe177XeSoEr/x9uRl7Tbwn5AvSo0BpzAhqfgmiv9HIJrofrtgXL
         2uMmhP6scXEBSVGy71atX8YMCabsnrzFllzcKlwQybRqXea9CsRMF0JPKi8oOT5+b+zh
         sia9p+xmBQSle0/EMyEh7vLi4kdx1iuaBU+Vvi1Jr4oiBAWe4XwJhA8iVMbMKpc5H3nG
         XbpQfdkVaKHQWEv1gP2tOnzf9Wrv8uMMjkmIDYkgmC2vqcN5Mp2KIdEKh4N5C7IAhOt3
         k0rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720829967; x=1721434767;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X+BjHHa++K3M8o/jlc41ALJl1/CW2inFabQbWOCaWdc=;
        b=X84dG9Oa5MFNa8CBiF2fw3qaLEbkeMNIFO2XgL7Vx3oJoEQU0C9S3KzPF9rkyKaY6y
         QoRr5OGPOyZXzg2C7ZBldb/GUoAxjdlmPFFKySlbIhfl2QTkmA8sBkbUWWBJxAYIpcoe
         F4YQipA1Uht7WdL+loRZEjDbNiT6bksvw4atYGjOMfngCSn5Bcz6kaFT5lSdEkcwwfKp
         BzT3NpfeTrqpZuac2E4EcdnnvzJZuJPqi8XpcaxZG99asjWbK4EOPhA5pj3xBwHg8wOf
         dr28x55RwUnJ989a7drXUyIKeuOeGehpt4/ZWJwVNRPksEg18k+7egF8u/7z9Aj/fgob
         wW4A==
X-Forwarded-Encrypted: i=1; AJvYcCU+KY0pLZN89xAjbFbIEbB0IxZLpT/enq9MpfnGB+kNDVmuEc87fWfcyu13LGqhqkvKZAJAnLNB/looipsVWkfRrE5B1S8dm9tp+Ori
X-Gm-Message-State: AOJu0YzWV0qwGdOYx4Fy/rLpmjVRvRjZXpIV7LETD6mldvPRyqH5f+5M
	LQagz6rOlYSTasO3LFfkb7p0sMOrBPBTVSmWNx/Dx1wT26Ohc2RUEth+P/IX
X-Google-Smtp-Source: AGHT+IGtU9FFfbvKDOtrT4DOn+QwTdztE3gXGyiQe7TNdTWb0IhA/vkZNYxvhzL3u5D4LDqMeSPNeQ==
X-Received: by 2002:a05:6a00:c95:b0:70b:5b21:6c2 with SMTP id d2e1a72fcca58-70b5b210967mr8844104b3a.31.1720829966681;
        Fri, 12 Jul 2024 17:19:26 -0700 (PDT)
Received: from localhost ([216.228.127.128])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b7ea794b7sm137312b3a.0.2024.07.12.17.19.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jul 2024 17:19:26 -0700 (PDT)
Date: Fri, 12 Jul 2024 17:19:23 -0700
From: Yury Norov <yury.norov@gmail.com>
To: Brian Norris <briannorris@chromium.org>
Cc: Nathan Chancellor <nathan@kernel.org>, llvm@lists.linux.dev,
	linux-kernel@vger.kernel.org, Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Kees Cook <kees@kernel.org>
Subject: Re: [PATCH v2] bitmap: Switch from inline to __always_inline
Message-ID: <ZpHIC0gWwkbKGk5H@yury-ThinkPad>
References: <20240711163732.1837271-1-briannorris@chromium.org>
 <ZpFhv5VSYZ6jnsd4@yury-ThinkPad>
 <ZpGVLl7NQZScd8aH@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZpGVLl7NQZScd8aH@google.com>

> > I like it more, when it's split onto several patches. We already have
> > my bitmap.h rework and your cpumask.h one with their own reasonable
> > motivations. Can you keep that patch structure please? Then, we can add
> 
> I'm not quite sure what you mean. I imitated the patch structure of your
> patch 1 that I linked, which had the following file-diff list:
> 
>  include/linux/bitmap.h   |  46 ++++++-------
>  include/linux/cpumask.h  | 144 +++++++++++++++++++--------------------
>  include/linux/find.h     |  40 +++++------
>  include/linux/nodemask.h |  86 +++++++++++------------
> 
> Are you suggesting I should split that into 2 (one for cpumask and one
> for the rest)?

I think the best way would be make a separate patch for each file:

1. find.h - because all others include it for find_bit() functions.
2. bitmap.h - pick my existing patch.
3. cpumasks.h - pick your existing patch.
4. nodemask.h - just the last piece.
 
> > separate patches for find.h and nodemask.h. If rebasing the old bitmap.h
> > patch isn't clean and takes some effort, feel free to add your
> > co-developed-by.
> 
> I don't really care who gets authorship, but I did manually rewrite it,

I do care about authorship. Not for vanity reasons, but because author
is the first person to blame in case there's a reason to blame.

> since there were enough conflicts, and it's basically scriptable. Feel
> free to suggest which Author/S-o-b/Co-developed combo makes sense for
> that, and I can adopt it in v3 :)

Can you keep my authorship and commit message for bitmap.h please, and
make sure that all the functions are __always_inline now? If you have
to re-write it, Co-developed-by is a proper tag.

> > > According to bloat-o-meter, my vmlinux decreased in size by a total of
> > > 1538 bytes (-0.01%) with this change.
> > > 
> > > [0] CONFIG_HOTPLUG_PARALLEL=y ('select'ed for x86 as of [1]) and
> > >     CONFIG_GCOV_PROFILE_ALL.
> > > 
> > > [1] commit 0c7ffa32dbd6 ("x86/smpboot/64: Implement
> > >     arch_cpuhp_init_parallel_bringup() and enable it")
> > > 
> > > Cc: Yury Norov <yury.norov@gmail.com>
> > > Signed-off-by: Brian Norris <briannorris@chromium.org>
> > 
> > So... This whole optimization is only worth the reviewer's time if we
> > can prove it's sustainable across different compilers and configurations.
> > 
> > Just saying that under some particular config it works, brings little
> > value for those who are not interested in that config. Moreover, if
> > one enables GCOV, he likely doesn't care much about the .text size.
> > And for those using release configs, it only brings uncertainty.
> 
> I think I partially disagree. If it's neutral for one compiler but
> helpful for the other, that's still a win. But otherwise, I agree we
> should have some accounting of diversity -- not just a single test.

Sure, I just want to make sure this wouldn't bloat common sane configs.
+/- 100 bytes is a negligible noise. +2M for defconfig is not.

> > Let's test it broader? We've got 2 main compilers - gcc and llvm, and
> > at least two configurations that may be relevant: defconfig and your
> > HOTPLUG_PARALLEL + GCOV_PROFILE_ALL. And it would be nice to prove
> > that the optimization is sustainable across compiler versions.
> > 
> > I have the following table in mind:
> > 
> >            defconfig   your conf  
> > GCC    9 |  -1900    |           |
> > CLANG 13 |           |           |
> > GCC   13 |           |           |
> > CLANG 18 |  -100     |  -1538    |
> > 
> > The defconfig nubmers above are from my past experiments. And you can
> > add more configs/compilers, of course.
> 
> Perhaps I wasn't too clear, but I was actually testing a few things:
> 
> * my ChromeOS-y build, with gcov and clang -- to ensure the section
>   mismatch warning/error disappears
> * a pure mainline / semi-defaults build (which happened to use my host
>   distro's gcc 13), to do size comparisons. I also happened to enable
>   gcov in the currently-posted experiments.
> 
> But agreed, I can get a larger matrix with a bit more specifity in my
> commit log. TBD on the ease of getting a Clang 13 or GCC 9 toolchain,
> but I think I can convince my distro to provide them.

It looks like minimum Clang version is 14. The rest is good.

Thanks,
Yury

> > > --- a/include/linux/bitmap.h
> > > +++ b/include/linux/bitmap.h
> > > @@ -203,7 +203,7 @@ unsigned long bitmap_find_next_zero_area_off(unsigned long *map,
> > >   * the bit offset of all zero areas this function finds is multiples of that
> > >   * power of 2. A @align_mask of 0 means no alignment is required.
> > >   */
> > > -static inline unsigned long
> > > +static __always_inline unsigned long
> > >  bitmap_find_next_zero_area(unsigned long *map,
> > >  			   unsigned long size,
> > >  			   unsigned long start,
> > 
> > Let's split them such that return type would be at the same line as
> > the function name. It would help to distinguish function declaration
> > from invocations in grep output:
> 
> Ack. I thought I was being consistent with existing cpumask.h style, but
> I got this set wrong. Will fix.
> 
> Brian

