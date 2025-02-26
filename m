Return-Path: <linux-kernel+bounces-534734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D5D69A46A8B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 20:02:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC7D91889ADE
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 19:02:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF70D237A3C;
	Wed, 26 Feb 2025 19:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T5gfAUUb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D0F1236A62;
	Wed, 26 Feb 2025 19:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740596512; cv=none; b=fZ1g9jObfik8AEVkWCfTJfg70uXzTEwy94QYH5ryVB4yhFp9/NIs7iwQwUyfNcmQg3vQ0QhrpqvKpetV1KNZ0pRRzNRYokG1fmVqUnRhPZfdqlRF/z6aRG0uizoZoe3qfiaCjp5/xcC/7alN3/5dd7/n7apTTbXS518pRyTai5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740596512; c=relaxed/simple;
	bh=ZavhooIcwXA2/2iXbrmuGez/yntrxrRs2Hst/J88bDs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UzaO0ymD4PXin5TXJ/8UC2+rgXBCRqsASQFWUA6MLCBuQC1oXsJyIpgzpsIL6sPR0lQFtONsjhQUjlHxK2B2WVR+pGV0rFS/wr1H0blyESXvVaMxEkNTq2BwJxPLEaVHDPfEu4cIP3PjZvIz/3lTzDM2cBSntd9sVrnLOoVPSC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T5gfAUUb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75335C4CED6;
	Wed, 26 Feb 2025 19:01:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740596511;
	bh=ZavhooIcwXA2/2iXbrmuGez/yntrxrRs2Hst/J88bDs=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=T5gfAUUb+8ZQlb+uipRQPsHEsi3tdg6QqfzmN6I3BZmHx8LzuLn36Z8niR2gnPdqV
	 HedtbdX/k63U2sR9aRQ3fMcB9YxhzS/npl5VBuqjxTy8AZz0UPO8mT/FJJQEUfPNIy
	 sI4ybmHBQ4CT7pCA8tBl/4LBJQEl3s5jjYzbKVvp6f+SRNVjYtuGXaLLMAo2NxYDxf
	 xRf9ZYTivjVcbnAIzOryQwCew/lBcnB0G1ePrnCg6p3VYapNvXjlVrHpppeJ8aYSuW
	 BM14mPg/zTgQtYFQzHL6dYlgArpGAs+r0Vydv3kukce2BBUUoboBsL5dM1vaV69tJ8
	 5ynPTBqRiw6vA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 17756CE04E3; Wed, 26 Feb 2025 11:01:51 -0800 (PST)
Date: Wed, 26 Feb 2025 11:01:51 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Ralf Jung <post@ralfj.de>, Alice Ryhl <aliceryhl@google.com>,
	Ventura Jack <venturajack85@gmail.com>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Gary Guo <gary@garyguo.net>, airlied@gmail.com,
	boqun.feng@gmail.com, david.laight.linux@gmail.com, ej@inai.de,
	gregkh@linuxfoundation.org, hch@infradead.org, hpa@zytor.com,
	ksummit@lists.linux.dev, linux-kernel@vger.kernel.org,
	miguel.ojeda.sandonis@gmail.com, rust-for-linux@vger.kernel.org
Subject: Re: C aggregate passing (Rust kernel policy)
Message-ID: <1fec6b96-8aae-4bda-8daf-892247882885@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <CAFJgqgRygssuSya_HCdswguuj3nDf_sP9y2zq4GGrN1-d7RMRw@mail.gmail.com>
 <20250222141521.1fe24871@eugeo>
 <CAFJgqgSG4iZE12Yg6deX3_VYSOLxkm5yr5yu25HxN+y4wPD5bg@mail.gmail.com>
 <6pwjvkejyw2wjxobu6ffeyolkk2fppuuvyrzqpigchqzhclnhm@v5zhfpmirk2c>
 <CAHk-=wgq1DvgNVoodk7JKc6BuU1m9UnoN+k=TLtxCAL7xTP=Dg@mail.gmail.com>
 <CAFJgqgSqMO724SQxinNqVGCGc7=ibUvVq-f7Qk1=S3A47Mr-ZQ@mail.gmail.com>
 <CAH5fLgh7Be0Eg=7UipL7PXqeV1Jq-1rpMJRa_sBkeiOgA7W9Cg@mail.gmail.com>
 <CAHk-=wgJQAPaYubnD3YNu8TYCLmmqs89ET4xE8LAe2AVFc_q9A@mail.gmail.com>
 <5d7363b0-785c-4101-8047-27cb7afb0364@ralfj.de>
 <CAHk-=wh=8sqvB-_TkwRnvL7jVA_xKbzsy9VH-GR93brSxTp60w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wh=8sqvB-_TkwRnvL7jVA_xKbzsy9VH-GR93brSxTp60w@mail.gmail.com>

On Wed, Feb 26, 2025 at 09:59:41AM -0800, Linus Torvalds wrote:
> On Wed, 26 Feb 2025 at 05:54, Ralf Jung <post@ralfj.de> wrote:
> >
> >      The only approach we know that we can actually
> > pull through systematically (in the sense of "at least in principle, we can
> > formally prove this correct") is to define the "visible behavior" of the source
> > program, the "visible behavior" of the generated assembly, and promise that they
> > are the same.
> 
> That's literally what I ask for with that "naive" code generation, you
> just stated it much better.
> 
> I think some of the C standards problems came from the fact that at
> some point the standards people decided that the only way to specify
> the language was from a high-level language _syntax_ standpoint.
> 
> Which is odd, because a lot of the original C semantics came from
> basically a "this is how the result works". It's where a lot of the
> historical C architecture-defined (and undefined) details come from:
> things like how integer division rounding happens, how shifts bigger
> than the word size are undefined, etc. But most tellingly, it's how
> "volatile" was defined.
> 
> I suspect that what happened is that the C++ people hated the volatile
> definition *so* much (because of how they changed what an "access"
> means), that they then poisoned the C standards body against
> specifying behavior in terms of how the code *acts*, and made all
> subsequent C standards rules be about some much more abstract
> higher-level model that could not ever talk about actual code
> generation, only about syntax.

Yes, they really do seem to want something that can be analyzed in a
self-contained manner, without all of the mathematical inconveniences
posed by real-world hardware.  :-(

> And that was a fundamental shift, and not a good one.
> 
> It caused basically insurmountable problems for the memory model
> descriptions. Paul McKenney tried to introduce the RCU memory model
> requirements into the C memory model discussion, and it was entirely
> impossible. You can't describe memory models in terms of types and
> syntax abstractions. You *have* to talk about what it means for the
> actual code generation.

My current thought is to take care of dependency ordering with our
current coding standards combined with external tools to check these
[1], but if anyone has a better idea, please do not keep it a secret!

							Thanx, Paul

[1] https://people.kernel.org/paulmck/the-immanent-deprecation-of-memory_order_consume

