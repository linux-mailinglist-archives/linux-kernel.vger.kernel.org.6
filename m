Return-Path: <linux-kernel+bounces-546388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8C24A4F9F8
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 10:27:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E6813A2F7E
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 09:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D2D5204C25;
	Wed,  5 Mar 2025 09:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="awQ2WJus"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C5C2045B0
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 09:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741166833; cv=none; b=d0BYbUCgBWsdfp5I+PFrf3UUKxqFgQ81t9IUw2/A7badZXshp08ZS4OObFsVFvujx90xiICzjItlXI90qovDgiTOea9nI7jI4GubcNLSDAKBMJ5bQ0gj/KJlyV6KvxB1/pZ+r54MmyngOoHXYVLfJ2uZUz/GcXLrhFcsf8ha5BI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741166833; c=relaxed/simple;
	bh=3mDFeB3Bpj3IOfRwlQRf3Grj75HR3nrndwXyWmM3Ob4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pFEgI2ZYH+prY4vd6PDfz0I8K35gGxiIT+zWigYPAnWHfCHmv77ha30xjIM/bUulJEguz5fppIBozuq2Mrc44ZyeFeAgFNW+hd752iqTVseCfDoyJd3burQ+F+ZI8FCFZEdVdwzS6gHP695e+PNPw7Y97pjGVPg8pyGNtA/mkUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=awQ2WJus; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43bc30adad5so19964495e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 01:27:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741166829; x=1741771629; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VaMa3tOr/8WS8V6AnlLw/eUNgZqrJVmxSDme9KtSQnA=;
        b=awQ2WJusxW6Ge0kv9C7Zju2JITr5EXSeephgcSpgRUB67uiBC2wUReZa/SrihqlmBV
         zMms2er4oICT6Quz/tBnkW/bMaNIjXMdxymm2mdhR9xfSuxVKM9ONClD/eluuDgTAG9Z
         cSTRS5qBoAatCwOyBW6idxIRVSxCnO+pKzcmP7MQ0TPj3qdmkaBJ8Q/LWpx+Y/szwxxZ
         LJpMWsH3PAH+QZGkJAJa1GPJ2b+1Y75T/DTdOUHiHu9jDRkjLhakyxdJWPiRbV2Wn6jw
         PqJzVJnpSRn6f7FKJcb4MvkK/ygd88eqJXzL8DmZTvV5KzE9q14qcQvpm1uWSxpYfF86
         iw7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741166829; x=1741771629;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VaMa3tOr/8WS8V6AnlLw/eUNgZqrJVmxSDme9KtSQnA=;
        b=kLfkMs4zh3b28gZ0T9x21wcy6LDkwO9kQsq+zQ7yuwqLTfPAmxQYd4E62Uz2MFhNsS
         kRITEmfUfpdkPet32Hb8OctdC1euIWU6PGpO0x8W+ilZCaWKtWIvF5RJS9AjnpZwVVy1
         KfYTCxwrx2IgdO+YR8vcKxhn3F6rDhZBFVPmpIETJn9pmRrwpauAPDt9cX/eAqu3Rd/q
         4CM+9FvGhpFnGHplMkJVE241f6GDJXI+67Y4LtvK1JparaxUxO6VzCEwdsnXBvPAxb6m
         mIJkF4VSsRhXHs73b1wztwIbL4mXDnSz19ud+oCeXyLHtPQPmSv/A58XbM3kF8MC3Fkt
         78+A==
X-Forwarded-Encrypted: i=1; AJvYcCXROC0ssJfw63hsucUVbK1C22kJ+7Ya2exWxHFVfq3G8zydhwMwQ9E0lx/Iuf3A3FckcBPwsgt1pRjt7v8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYLWgsVg9Et9+L4YeArmVsvnNBc22yrbnNTcrtz537gjGnYluz
	Y9eK7SdX8u39zDTrncQEBl1smEe7iXd2jYfNMPrxiIO5ID1brFQDRaC+Ml+IMsY=
X-Gm-Gg: ASbGncvH8q+K1TL/WHel8KCq5eDgwSNAtzSjMnvGTuV1zGu73oXEsl3+ZPE8LMBl3Pm
	fpEoJ5lwj68cluCxp244xuZbd8uFgpyhosNYNWUsD+UbnLJQobMZJZADcj3iYBMMx7Q4bHOyGAq
	csyLjoebfgunv5cKKNXdFjUIlWAibDPlde/bwzgZGr0r02TXUehRjmeSxoSEEXAhHg2sLHL9cG9
	cXEmIXWpRc7CoXtOZ0FMkYOqCqwg05ZEj1Uri5YrtxTuBIQKMnz8LCrf/WJvA6y/VmjHdKvvgr4
	T2L6FZRnfk40yOcWKiem2U+n5jxFC3GD6esr8/vkRkCajcFWPw==
X-Google-Smtp-Source: AGHT+IE3mizAOsnSuTtcbkO82OvTIYaM5IjOsyfCaEaBUlwqBcpm21mf2Z2/NNT65xir9k5CCr442Q==
X-Received: by 2002:a05:600c:4750:b0:439:9e8b:228e with SMTP id 5b1f17b1804b1-43bd29c42c8mr13412085e9.20.1741166829098;
        Wed, 05 Mar 2025 01:27:09 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-43bd426d069sm11942015e9.3.2025.03.05.01.27.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 01:27:08 -0800 (PST)
Date: Wed, 5 Mar 2025 12:27:04 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Marco Elver <elver@google.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Alexander Potapenko <glider@google.com>,
	Arnd Bergmann <arnd@arndb.de>, Bart Van Assche <bvanassche@acm.org>,
	Bill Wendling <morbo@google.com>, Boqun Feng <boqun.feng@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Eric Dumazet <edumazet@google.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Ingo Molnar <mingo@kernel.org>, Jann Horn <jannh@google.com>,
	Jiri Slaby <jirislaby@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Josh Triplett <josh@joshtriplett.org>,
	Justin Stitt <justinstitt@google.com>, Kees Cook <kees@kernel.org>,
	Kentaro Takeda <takedakn@nttdata.co.jp>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
	Thomas Gleixner <tglx@linutronix.de>,
	Uladzislau Rezki <urezki@gmail.com>,
	Waiman Long <longman@redhat.com>, Will Deacon <will@kernel.org>,
	kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev, rcu@vger.kernel.org,
	linux-crypto@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH v2 01/34] compiler_types: Move lock checking attributes
 to compiler-capability-analysis.h
Message-ID: <b6af185f-0109-4f98-a2d7-ab8f716e21a5@stanley.mountain>
References: <20250304092417.2873893-1-elver@google.com>
 <20250304092417.2873893-2-elver@google.com>
 <f76a48fe-09da-41e0-be2e-e7f1b939b7e3@stanley.mountain>
 <Z8gVyLIU71Fg1QWK@elver.google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8gVyLIU71Fg1QWK@elver.google.com>

On Wed, Mar 05, 2025 at 10:13:44AM +0100, Marco Elver wrote:
> On Wed, Mar 05, 2025 at 11:36AM +0300, Dan Carpenter wrote:
> > On Tue, Mar 04, 2025 at 10:21:00AM +0100, Marco Elver wrote:
> > > +#ifndef _LINUX_COMPILER_CAPABILITY_ANALYSIS_H
> > > +#define _LINUX_COMPILER_CAPABILITY_ANALYSIS_H
> > > +
> > > +#ifdef __CHECKER__
> > > +
> > > +/* Sparse context/lock checking support. */
> > > +# define __must_hold(x)		__attribute__((context(x,1,1)))
> > > +# define __acquires(x)		__attribute__((context(x,0,1)))
> > > +# define __cond_acquires(x)	__attribute__((context(x,0,-1)))
> > > +# define __releases(x)		__attribute__((context(x,1,0)))
> > > +# define __acquire(x)		__context__(x,1)
> > > +# define __release(x)		__context__(x,-1)
> > > +# define __cond_lock(x, c)	((c) ? ({ __acquire(x); 1; }) : 0)
> > > +
> > 
> > The other thing you might want to annotate is ww_mutex_destroy().
> 
> We can add an annotation to check the lock is not held:
> 

Sorry, my email was bad.

I haven't actually tried your patch at all.  I have locking check in
Smatch so I'm just basing this on the things that I did...
https://github.com/error27/smatch/blob/master/smatch_locking.c
This isn't a mandatory thing.  Whatever happens we're going to end up
doing dozens of patches all over the kernel later.

I thought you could destroy a mutex regardless or whether it was held
or not.  I was getting false positives which said that we should drop
the lock on error but actually the mutex is destroyed on that path so it
doesn't matter.

regards,
dan carpenter


