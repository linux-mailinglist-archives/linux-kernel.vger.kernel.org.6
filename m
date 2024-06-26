Return-Path: <linux-kernel+bounces-230414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19D84917C83
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 11:28:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45F461C227FB
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 09:28:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B62AC16C696;
	Wed, 26 Jun 2024 09:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="N6XKig5Q"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 492A516B38B;
	Wed, 26 Jun 2024 09:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719394128; cv=none; b=U3OoCk0XKKQq/lTxUUVy7TpLo8U0gf1aL0C6KXlbgbBR86lWpfSUemVSJsEaaZ8CYn0yU9V7GJi6opOTyScTUejpHzFf4HojZBb0gSGilWhJRZF7eL7ZhYq+FD8oJHSKakhMloA0cFsxIYKb5lGCvmKcEwuQhIs7MPIWKz/Sypg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719394128; c=relaxed/simple;
	bh=am7KpuWkuWjMaKCiDOY/BZ5BIrHVZ/2CdIfvMqaOKds=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cUB7P6wPkjm7eO0HG7Ma9VxifbOoauXG7+VoUnUsG6uYKADBs5PI9Bj7yNSlODvTkD0g0DN+XYAeRLsu151UwCtbBBlcRHZi4lGjGnXAgl32WD5Uaou4Z5Xs1MFviMuKNOJTEWVzgb7Y1Dzb9q/nvb0Vdq1b6YovDtNq/lH3NOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=N6XKig5Q; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=NoZpBOHy6NH1NQrOP00Iv13cqQtxZjFCv3ThtrZ0QBI=; b=N6XKig5Q9C4OdOhY4RABaejZIC
	MdBh9eL7zfVI7T5ws75SKusUbLskMUQlpsOidMoWE7XLpm9mh32ad/VG0oK1YlTPFyTtE3h+g8ftc
	LdafLrrZVZrVg9QDcYUP0385ok4apZavrxzvCUSKBUcGK9lDWs7PlaxcK5wlLMvh7wh/sXcaD8ZfG
	fAVQUmMUJh7WM8yXfLv4IhYw0s0i8/h1R9wc6wA4lD1GjY6CrbTdIp8yguK8JmT9UazvJyfa2NQ84
	GFya5HB+6tkOtWcN/IxUz1btK7KpWaYe8DRMyLF8AYTwsM+PquwjLo8JMbvocS8h8G6HyRy9e+dQL
	pLq34+kQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sMOxG-0000000C7iG-24cY;
	Wed, 26 Jun 2024 09:28:42 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id B8FD630057C; Wed, 26 Jun 2024 11:28:41 +0200 (CEST)
Date: Wed, 26 Jun 2024 11:28:41 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Uros Bizjak <ubizjak@gmail.com>, kernel test robot <lkp@intel.com>,
	oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>
Subject: Re: arch/x86/include/asm/cmpxchg_32.h:149:9: error: inline assembly
 requires more registers than available
Message-ID: <20240626092841.GC31592@noisy.programming.kicks-ass.net>
References: <CAFULd4YVOwxQ4JDaOdscX_vtJsqJBJ5zhd0RtXXutW=Eqh29Qw@mail.gmail.com>
 <CAHk-=wg1h4w_m=Op1U4JsyDjsvqG0Kw1EOVMQ+=5GX_XytdorQ@mail.gmail.com>
 <CAFULd4YR-VkAOKiS5yxSUYi0YMzY1p=pkYe4dOkgFs+A=9AFFA@mail.gmail.com>
 <CAHk-=wi_KMO_rJ6OCr8mAWBRg-irziM=T9wxGC+J1VVoQb39gw@mail.gmail.com>
 <CAHk-=whPqqZVSeJiQsMvsAxtAmtR9iAuB4gg_1sUK2D-uBPpLw@mail.gmail.com>
 <CAFULd4YAeF7=q7DYUh016kabxS8b32qRbFqDBJQrvLq6RjwEVg@mail.gmail.com>
 <CAHk-=wiHo2YeA=TOUf8vxFLOc0+BoH8USaiT25fnX2ynXbrZkg@mail.gmail.com>
 <CAHk-=wgdCs0883dpvZpyna76q9eVcTMvvUVAaBuJMPyrgOhNig@mail.gmail.com>
 <CAFULd4ZW23_RNye6YGbsT0Uo-vOQBM_tBbSJRhh=0HZzXuC_8Q@mail.gmail.com>
 <CAHk-=wiWEgSo2Tb_bih7mnS27zAPL+RGg_7yX4qK1f710-j-Ng@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiWEgSo2Tb_bih7mnS27zAPL+RGg_7yX4qK1f710-j-Ng@mail.gmail.com>

On Tue, Jun 25, 2024 at 11:31:05AM -0700, Linus Torvalds wrote:

> The thing is, when cmpxchg doesn't fail, then oldp should already be "old", no?

Correct.

> I mean, by the very definition, atomic_try_cmpxchg() can *not* be
> successful if the new value didn't match the old one.
> 
> I mean, just look at the very doc you point to - the "definition" is
> 
>   bool atomic_try_cmpxchg(atomic_t *ptr, int *oldp, int new)
>   {
>     int ret, old = *oldp;
>     ret = atomic_cmpxchg(ptr, old, new);
>     if (ret != old)
>       *oldp = ret;
>     return ret == old;
>   }
> 
> iow, it only returns success of "ret == old", and "old" by definition
> is "the contents of oldp".
> 
> (Here "oldp" is a local variable, not something that can be changing).
> 
> So I *think* the whole
> 
>     if (ret != old)
>       *oldp = ret;
> 
> is actually counter-productive, and could/should be just that simpler
> unconditional *oldp = ret, 

IIRC the reason I added that conditional is because at the time the GCC
compiler I tried it on generated slightly better code like this.

ISTR it emitting some superfluous assignments with the unconditional
store variant. Typically what seemed to happen is that since the
cmpxchg() user would have a loop termination on ret == old, it was able
to recognise it only needed that assignment in the failure case. Without
the condition on it would also do that assignment in the success case.

But yeah, otherwise it doesn't matter.

