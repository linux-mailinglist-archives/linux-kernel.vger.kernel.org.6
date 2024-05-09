Return-Path: <linux-kernel+bounces-173913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A1528C0779
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 00:54:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 993C8282FBF
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 22:54:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 676DE39AC3;
	Wed,  8 May 2024 22:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JivcEIfD"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AE9A23778
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 22:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715208879; cv=none; b=b3rUBd/cUJwjoXX4RdQT1fi/mOQATDeI8SU/XPaRiCZxj6XxzJvYRnkoZpnV0evzjsmyaD8USPBWAwAnI0+0Vahdeu8OyRhixihLwqAha+HnJ9015z/JhU1eIvngZT787L+x8auaxFZ27j2rQAdAxaOy5OWqW8+wqxhQR/yUxNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715208879; c=relaxed/simple;
	bh=gyQ55hQgJIIwlukOBDSk95pxDialupoX6yg1FkBruGA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NVbjQTOUchu7aU3UahkkGAs0d4FODQaZQUyckf1i/zFFaSw5eg85whUCw+ZeGqx/PTHfVQ9fxAIEWufA70eZNQK7tjTt80VBJ9bDAeDaf8F+BuFj4wVOIeORaFi70zrE5JPqcXOpZaEnfPA4Uj/55i3vSFTVHSUByAZgWgfJ/bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=JivcEIfD; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1ec4dc64c6cso1519105ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2024 15:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715208877; x=1715813677; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3u1Pl3pGa/v+VPDPwQjOTFukEhJKGI8Aryv6GP6qkbs=;
        b=JivcEIfDN4SmAShCubZEgvTmd/oQjxHrN/cGzs1+XcoXHyL8ncWuRVwse+AcxZ2gAF
         FH/n1CT79VmXsCr/3JJ2RbRt2rKwbh0mtVMuo6euPpTl/Sb90CAS6aPMBbkFFbHOz2cJ
         N73Svg2p5b5aP7ZfV2+bCVJXMFhCoJsEe0e5U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715208877; x=1715813677;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3u1Pl3pGa/v+VPDPwQjOTFukEhJKGI8Aryv6GP6qkbs=;
        b=A9z4LRFWByI0KEUZKqDU3ko/BqaobJzs0l5qKnae7j7G2Au/wy9Y0lp2T4RWgJrFIk
         HKxgsJSOgI+hnfUeaJ5cd3n/wMSzm+ydf8r8ejd6wsut5AT0oJxglXB+lQm1v7AHrj/M
         keY2vt8wpCNAW474wumaD0mgkjBEzKXMRGGNDXDodJBDkESvKS7MQ0ZyyPmvLRzWdW+5
         ZY+5gw8xE07XknvbSR0WBpq7y3cLmgqjMrwf6RJkQ5hqGcCiZgBaEWDGuN17/h+D0l1d
         VzjDnjHPY22czTHpwjY1wtdhjX65W1U3bErWym5ZqzEfwKKME/5BBNDaBq9YLp47QYAJ
         OG2A==
X-Forwarded-Encrypted: i=1; AJvYcCUsqtnawFjgVBPzUQopi91RMAegj7KGugRDIKxjj3cvgXla9IwexghpfrsDWtiVhtC79eYqyPIZUznO2F0WtNR6BNh0Zi21YK+QMrOA
X-Gm-Message-State: AOJu0YwGrqqHS3RtuFdWUanqkTWvM7hrMmnZotzG6qoC0t4Nm9YM33zz
	bc8DZzJThPMJnGqMndURkXGtrrikTXPnNYb5XVGPFgWOOgcrHEmTV8017b+NxA==
X-Google-Smtp-Source: AGHT+IF5qLS8MIZu8bkrdkM2TSnYV54A1dmV9tmHQoSYXNzqgbagdmzZsQoufeCX4B3wWJs7UZAp1w==
X-Received: by 2002:a17:902:c947:b0:1e8:4ad9:cbdf with SMTP id d9443c01a7336-1eeb0187168mr50075185ad.13.1715208877180;
        Wed, 08 May 2024 15:54:37 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0b9d1899sm714405ad.21.2024.05.08.15.54.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 15:54:36 -0700 (PDT)
Date: Wed, 8 May 2024 15:54:36 -0700
From: Kees Cook <keescook@chromium.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Justin Stitt <justinstitt@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Mark Rutland <mark.rutland@arm.com>,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [RFC] Mitigating unexpected arithmetic overflow
Message-ID: <202405081354.B0A8194B3C@keescook>
References: <202404291502.612E0A10@keescook>
 <CAHk-=wi5YPwWA8f5RAf_Hi8iL0NhGJeL6MN6UFWwRMY8L6UDvQ@mail.gmail.com>
 <202405081144.D5FCC44A@keescook>
 <CAHk-=wjeiGb1UxCy6Q8aif50C=wWDX9Pgp+WbZYrO72+B1f_QA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjeiGb1UxCy6Q8aif50C=wWDX9Pgp+WbZYrO72+B1f_QA@mail.gmail.com>

On Wed, May 08, 2024 at 01:07:38PM -0700, Linus Torvalds wrote:
> On Wed, 8 May 2024 at 12:45, Kees Cook <keescook@chromium.org> wrote:
> >
> > On Wed, May 08, 2024 at 10:52:44AM -0700, Linus Torvalds wrote:
> > > Example:
> > >
> > >    static inline u32 __hash_32_generic(u32 val)
> > >    {
> > >         return val * GOLDEN_RATIO_32;
> > >    }
> >
> > But what about:
> >
> > static inline u32 __item_offset(u32 val)
> > {
> >         return val * ITEM_SIZE_PER_UNIT;
> > }
> 
> What about it? I'm saying that your tool NEEDS TO BE SMART ENOUGH to
> see the "what about".

This is verging on omniscience, though. Yes, some amount of additional
reasoning can be applied under certain conditions (though even that would
still require some kind of annotation), but GCC can't even reliably figure
out if a variable is unused in a single function. We're not going to be
able to track overflow tainting throughout the code base in a useful
fashion.

> IOW, exactly the same as "a+b < a". Yes, "a+b" might wrap around, but
> if the use is to then compare it with one of the addends, then clearly
> such a wrap-around is fine.

Yes, but it is an absolutely trivial example: it's a single expression
with only 2 variables. Proving that the value coming in from some
protocol that is passed through and manipulated by countless layers of the
kernel before it gets used inappropriately is not a reasonably solvable
problem. But we can get at the root cause: the language (and our use of
it) needs to change to avoid the confused calculation in the first place.

> A tool that doesn't look at how the result is used, and just blindly
> says "wrap-around error" is a tool that I think is actively
> detrimental.

I do hear what you're saying here. I think you're over-estimating the
compiler's abilities. And as I mentioned in the RFC, finding known bad
cases to protect is the reverse of what we want for coverage: we want
to _not_ cover the things we know to be _safe_. So we want to find
(via compiler or annotation) the cases where overflow is _expected_.

> We already expect a lot of kernel developers. We should not add on to
> that burden because of your pet project.

I think it's a misunderstanding to consider this a pet project. C's lack
of overflow intent has spawned entire language ecosystems in reaction.
There are entire classes of flaws that exist specifically because of this
kind of confusion in C. It is the topic of countless PhD research efforts.

People who care about catching overflows can slowly add the type
annotations over the next many years, and we'll reach reasonable coverage
soon enough. It doesn't seem onerous: I'm not asking that people even
do it themselves (though I'd love the help), I'm just trying to find
acceptance for annotations about where the sanitizer can ignore overflow.

> Put another way: I'm putting the onus on YOU to make sure your pet
> project is the "Yogi Bear" of pet projects - smarter than the average
> bear.

Sure, but if the bar is omniscience, that's not a path forward.

I haven't really heard a viable counterproposal here. Let me try something
more concrete: how would you propose we systemically solve flaws like
the one fixed below? And note that the first fix was incomplete and it
took 8 years before it got fully fixed:

	a723968c0ed3 ("perf: Fix u16 overflows")               (v4.3)
	382c27f4ed28 ("perf: Fix perf_event_validate_size()")  (v6.7)

Because the kernel didn't catch when the u16 overflowed, it allowed for
kernel memory content exposure to userspace. And that's just the place
that it got noticed. With the struct holding the u16 is referenced in
360 different source files, it's not always a trivial analysis. But,
for example, the sanitizer not finding a "wraps" annotation on the
perf_event::read_size variable would have caught it immediately on
overflow.

And I mean this _kind_ of bug; not this bug in particular. I'm just
using it as a hopefully reasonable example of the complexity level we
need to solve under.

-Kees

-- 
Kees Cook

