Return-Path: <linux-kernel+bounces-562478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E89BDA62941
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 09:48:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8299C7A4E9C
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 08:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4422B198833;
	Sat, 15 Mar 2025 08:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V6GqGhtc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5BD42AD25
	for <linux-kernel@vger.kernel.org>; Sat, 15 Mar 2025 08:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742028485; cv=none; b=GGPoC9ybKS6Idmk3ZidXtcMKcY95wpnYuHayw9j6SuPsb/GKlyA1Eqe8VJT35nLuv706bYwsc6lSP6/3tjt6R891EytFRKqpah8m0+X4RQtU0r6+opnMmOR8gzHNnhuEyIgmrCDj92pL+7Jl/6o4VykgjdNKaUriC4qpNa8eCXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742028485; c=relaxed/simple;
	bh=I3UoMnUAqiwm7sJa0MWAGmg5WXQ+2VYpaL1vO0czda4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BOYeIfgtgnW/nnKLXnSauik6CACLPFCQ0Kq3fD8ZNMvQm7cANp6fg8q8CP+5XYs3LA7U1bltB34EQ8iqQtIprwdpubc0REazJ8n7UEE3bEJWMFQqcq7MgjwXg1obQsTwpftXUHo3fztyUbce0OhnWy0850SSYrUfIo/Cewet9UI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V6GqGhtc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0415FC4CEE5;
	Sat, 15 Mar 2025 08:48:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742028485;
	bh=I3UoMnUAqiwm7sJa0MWAGmg5WXQ+2VYpaL1vO0czda4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V6GqGhtcxIWjVmkRqfm+oN6HAJu7cEtLlU29HgBNb9iRBgT+IM/VoBnSEGMZmY940
	 aTrp2KaJfvU5HqTENP7MeA24tXZg3y/Wtnfqhr3kvi0GmYdwhukP/uGNNWC5Do0qYn
	 gCtrbdV42bWY8Y1LVX1GdM5T5E5JtuT5zee5t94HDcvsVK98af3OsmtXZ0n7Lfa0hi
	 jJcmoDzZ3DSP4WnuCRSxlQ4Usty9JuIu5HJXKrTgbMcoqvdrZjXtMoSqCPMhLibwnz
	 5Q7j7mN8oKV6trr+4N2Kfu7drz1h3OqK1CIL9+BvpO6GOodk/tMe5jDDyWZydU6e0k
	 onW/C5uybzrow==
Date: Sat, 15 Mar 2025 09:47:59 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
	linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
	Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>,
	Uros Bizjak <ubizjak@gmail.com>,
	Andrew Cooper <andrew.cooper3@citrix.com>
Subject: Re: [PATCH 14/20] x86/barrier: Use alternative_io() in 32-bit
 barrier functions
Message-ID: <Z9U-v5aVdVkaVEgV@gmail.com>
References: <cover.1741988314.git.jpoimboe@kernel.org>
 <1c2fe7f93c4dd8a87c2e1fa8b780a8a2968be445.1741988314.git.jpoimboe@kernel.org>
 <CAHk-=wjtvTPERDdrok2kDrSSFBjqHCCNVff95VVxhvP6wCC6jg@mail.gmail.com>
 <CAHk-=whH5bHRYB12aAcb=nK7erOmOSo6o2FXjHtxObWumFANHA@mail.gmail.com>
 <jdcd4zoezsi7beoak43dqzkxnel7hqdhtyqbf4cqr6rvs3qfyf@i2qhxrld5p5l>
 <CAHk-=wj_F4_uTMQ2w7M7TRJqn9dx+LEifuvkvqd_ODSbMU-U3g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wj_F4_uTMQ2w7M7TRJqn9dx+LEifuvkvqd_ODSbMU-U3g@mail.gmail.com>


* Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Fri, 14 Mar 2025 at 14:09, Josh Poimboeuf <jpoimboe@kernel.org> wrote:
> >
> > Thing is, we still have alternative(), which is also an asm wrapper, but
> > it's for when the caller doesn't care about adding any constraints.
> >
> > So the "_io()" distinguishes from that.
> 
> .. but I think it does so very badly because "io" really means
> something else entirely in absolutely all other contexts.

Yeah, alternative_io() is really a misnomer we should fix.

As a minor side note, it's *doubly* a misnomer, because 'io' mixes up 
the defined 'o/i' order of the output/input constraints:

  arch/x86/include/asm/alternative.h:#define alternative_io(oldinstr, newinstr, ft_flags, output, input...)       \

So it should have been alternative_oi().


> And it really makes no sense as "io", since it doesn't take inputs and
> outputs, it takes inputs, outputs AND CLOBBERS.
> 
> So it would make more sense to call it "ioc", but that's just obvious
> nonsense, and "ioc" is already taken as a globally recognized
> shorthand for "corruption in sports".

lol ...

> So "ioc" is bad too, but that should make you go "Oh, 'io' is _doubly_
> nonsensical".
> 
> Ergo: I think "asm" would be a better distinguishing marker, withg the
> plain "alternative()" being used for particularly simple asms.

Yeah, alternative_asm() or alternative_opts(). Anything but '_io()' :-)

Thanks,

	Ingo

