Return-Path: <linux-kernel+bounces-562606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD509A62E05
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 15:17:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF29C17A833
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 14:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 849CD1F9F79;
	Sat, 15 Mar 2025 14:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RqNevD47"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D527D63CB;
	Sat, 15 Mar 2025 14:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742048257; cv=none; b=tcxaF9r0gW0izmcsQfQBG2MeecFGr14mWN4JT5ZrZ4qzn5IGbKSwAY2XzBRivPIFoo94efl7n5fW5IMZW6j+vtJlL5Nj6mzCHR1OPYRAglGw5e2rJVQDJW0JcKbahfoQivmcFEjIW46q9PY+FodjL5X71bkRELw0rqUjeVrzTv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742048257; c=relaxed/simple;
	bh=KRcS9wOSRMV4aA3wgBjXvZZhpoC987DC2y7k5Ra2Zkc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q+pBsZWao8KXL9J3bORUK3wpdy7OY8D8Iyez3c048mCJHO8Ayb2SxbY6BvSxWd0cLmqccjtNLlq/63DUFbm80hBmE9H5qTUOV3g8Jb+t9zq1s8wjR8q9qihxvHUPFJ0L6rD9gjiCkqnEUJIpNsJoes+Z7RJ6I8gS+25psecefKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RqNevD47; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE5D6C4CEE5;
	Sat, 15 Mar 2025 14:17:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742048256;
	bh=KRcS9wOSRMV4aA3wgBjXvZZhpoC987DC2y7k5Ra2Zkc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RqNevD47UQk7/moG12bxH0pFAJtjkSqOhiAr7gJ+/IR3oEqjMquPmBaocza/rS6au
	 4oXqiumb+nBYKN4DL2k4vmYTGUZJ7kFMrozGP8M62rdmTCPNt1owGxLTy5RhVRba14
	 KkdBQluMBKtQUsUMvsAKRuIgZiLyNxBvWWIFPWi+jB/G587KDC6wyv8VS2cGgnZRL9
	 XgKimTaFl5Q/t5u5F+ehU8RAY5cCxDFNf9RkNTVvEzIDtsxcEM2DukkMrFq/+4q6gw
	 02CZG4kXRLLQ+YtSPdYWTKV8uu4CbUm7njA2Vx2yKUWaR9RNzvHvnAqhOMWNLYkE2x
	 Nhh/8b5VAtUTw==
Date: Sat, 15 Mar 2025 15:17:31 +0100
From: Danilo Krummrich <dakr@kernel.org>
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: Benno Lossin <benno.lossin@proton.me>, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rust/revocable: add try_with() convenience method
Message-ID: <Z9WL-95sJ0DCpaPa@pollux>
References: <20250313-try_with-v1-1-adcae7ed98a9@nvidia.com>
 <D8F7D2RPRVAO.2EF39MZXM6FPR@proton.me>
 <D8F8E4PBHK7O.399Y83M1L3XK3@nvidia.com>
 <D8F91L51P2EA.2FBHGJYSV06HY@proton.me>
 <Z9L-Z4Aw64Hi5Lj8@pollux>
 <D8FBUHBNPIEL.5A8GOEMPJSEA@proton.me>
 <D8GWCWYM15WI.3II7R71LIAEI9@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D8GWCWYM15WI.3II7R71LIAEI9@nvidia.com>

On Sat, Mar 15, 2025 at 11:07:44PM +0900, Alexandre Courbot wrote:
> On Fri Mar 14, 2025 at 2:50 AM JST, Benno Lossin wrote:
> > On Thu Mar 13, 2025 at 4:48 PM CET, Danilo Krummrich wrote:
> >> On Thu, Mar 13, 2025 at 03:38:55PM +0000, Benno Lossin wrote:
> >>> On Thu Mar 13, 2025 at 4:08 PM CET, Alexandre Courbot wrote:
> >>> > On Thu Mar 13, 2025 at 11:19 PM JST, Benno Lossin wrote:
> >>> >> Would it make sense to not use `Result` here and continue with `Option`?
> >>> >
> >>> > We would have to return an Option<Result<R>> in this case. The current
> >>> > code folds the closure's Result into the one of the guard's acquisition
> >>> > for convenience.
> >>> >
> >>> > Actually, I don't think I have ever used try_access() a single time
> >>> > without converting its returned Option into a Result. Wouldn't it make
> >>> > sense to do the opposite, i.e. make try_access() return Err(ENXIO) when
> >>> > the guard cannot be acquired and document this behavior?
> >>> 
> >>> Sure, if you're always doing
> >>> 
> >>>     let guard = rev.try_access().ok_or(ENXIO)?;
> >>> 
> >>> Then it makes sense from my view, maybe Danilo has some other argument
> >>> for why `Option` is better.
> >>
> >> Most of the time I think we indeed want to derive an Err() if try_access()
> >> fails, but not with a specific error code. The error code depends on the context
> >> of where the revocable is used (e.g. for I/O mappings), but it also depends on
> >> the driver semantics.
> >
> > In that case a single function with this signature would make sense:
> >
> >     fn access_with<R>(&self, f: impl FnOnce(&T) -> R) -> Option<R>;
> >
> > If there are common usages that always return the same error code, then
> > we could add them as functions with `Result`.
> 
> Yeah the more I think about it the more this seems to make sense,
> from a strictly logical point of view.
> 
> Where I am still on the fence is that the goal is also to reduce the
> friction introduced by the Revocable business, which a large driver
> might need to interact with hundreds of times. If the user wants the
> callback to return a Result, then this method will return an
> Option<Result>. One would then need to ok_or the Option, then flatten
> the two results, which is a bit verbose.

I think you see this from the perspective of one specific usecase, i.e.
Devres<T>, where T dereferences to Io, right?

> I suppose drivers could add their own macros to do that automatically
> and reduce code verbosity, at the cost of less cohesion across drivers.
> Guess I'll go with that if I cannot come with anything better.

Maybe we could do something more specific but yet generic on top (for the
use-case above), but we still can't assume the exact error code a driver wants
to derive from failing try_access(). So, maybe a driver specific wrapper is
indeed what you want on top of what this patch provides.

