Return-Path: <linux-kernel+bounces-563011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 350FAA635A6
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 13:42:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F950189114C
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 12:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7A4E1A5BB1;
	Sun, 16 Mar 2025 12:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ac6A//Sr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF701A314D;
	Sun, 16 Mar 2025 12:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742128965; cv=none; b=srkNvSqW11qPx1suzROWkO6UmqxvfePBQkfOitnni1O2jULL7I89E70DpMHRw5LIv2RSq+2c1/PB+y088a0MAerkROYseDiMqz0zaKnvVhtNAEoNzYUPKD8cXAlzzd2kKT3WfUE4RHTbeuDipTSH8Unvb/emRb2nLf7sZsws4EQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742128965; c=relaxed/simple;
	bh=xAYKZ2GH1Y6EihYmg2Dwo/ja48mVVaN+tmE3v0F1EhI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QxOtspwWU8Z322YfRd3li0OCObWxfWh1Em/0khN47iNPaJckjynKq8pI3YuIgpqfB5Fz07/CXeNiW0hLD3MovRfnEFnqW7rrP/aNrIhM7Dgmx02NeSTjL95aL1NXRkMDr19iJtjnunzLBLG/7HX1peD3CxKl6WTrkufpT4bCfYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ac6A//Sr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 350E0C4CEDD;
	Sun, 16 Mar 2025 12:42:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742128963;
	bh=xAYKZ2GH1Y6EihYmg2Dwo/ja48mVVaN+tmE3v0F1EhI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ac6A//Sr2GnnY9HKpfmxdf3spSlYuh1qWE2aerO/g344Rr8yoiWrOKE+selJfBjov
	 5jkoph2WGeLtBxCC7Xp2iwPCuV7GLG/frW4UkPxtWXIsfBWZcB9Uvq6Rup36LMAaMG
	 thoOzyodZLmfoeg0kD1++KCV4kliOSB4r3/2PTPQWQ6aXrFIJL/BlvUZwsakSuj8Uv
	 kijkYzSbR+xI0dSe2OOCzSL8XlBof7Vs/xhiDZHEmAbD21CKnFXoAe2AdY6zHUubhV
	 yPkmqRAmv/GIASoYfbco2YykCQgmk6261mSNz7GE9UlGkOYCwSTYNc1vk9VtKQAxGW
	 5WIZ/SL17Mwjw==
Date: Sun, 16 Mar 2025 13:42:38 +0100
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
Message-ID: <Z9bHPtYhT0HZ_dS0@pollux>
References: <D8F7D2RPRVAO.2EF39MZXM6FPR@proton.me>
 <D8F8E4PBHK7O.399Y83M1L3XK3@nvidia.com>
 <D8F91L51P2EA.2FBHGJYSV06HY@proton.me>
 <Z9L-Z4Aw64Hi5Lj8@pollux>
 <D8FBUHBNPIEL.5A8GOEMPJSEA@proton.me>
 <D8GWCWYM15WI.3II7R71LIAEI9@nvidia.com>
 <Z9WL-95sJ0DCpaPa@pollux>
 <D8GWQXK312SX.2RI3EOHM1QGG3@nvidia.com>
 <D8H11HOL93UD.31F853PYJA9U2@proton.me>
 <D8HOP09FU367.2MVDRQ5G0OPV@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D8HOP09FU367.2MVDRQ5G0OPV@nvidia.com>

On Sun, Mar 16, 2025 at 09:20:03PM +0900, Alexandre Courbot wrote:
> On Sun Mar 16, 2025 at 2:48 AM JST, Benno Lossin wrote:
> > On Sat Mar 15, 2025 at 3:26 PM CET, Alexandre Courbot wrote:
> >> On Sat Mar 15, 2025 at 11:17 PM JST, Danilo Krummrich wrote:
> >>> On Sat, Mar 15, 2025 at 11:07:44PM +0900, Alexandre Courbot wrote:
> >>>> I suppose drivers could add their own macros to do that automatically
> >>>> and reduce code verbosity, at the cost of less cohesion across drivers.
> >>>> Guess I'll go with that if I cannot come with anything better.
> >>>
> >>> Maybe we could do something more specific but yet generic on top (for the
> >>> use-case above), but we still can't assume the exact error code a driver wants
> >>> to derive from failing try_access(). So, maybe a driver specific wrapper is
> >>> indeed what you want on top of what this patch provides.
> >>
> >> So be it! It's not that bad and more flexible in the end.
> >
> > You could have the following signature:
> >
> >     fn try_access_with<R>(&self, on_vacant: Error, f: impl FnOnce(&T) -> Result<R>) -> Result<R>;
> >
> > That will use the `on_vacant` error instead of hard coding ENXIO. But
> > maybe it's better to just have such a wrapper in drivers that actually
> > need it (ie even with the concrete error specified and not a parameter).
> > You'll know better through actually trying to write a driver.
> 
> Yeah, having the extra on_vacant parameter would require callers to
> specify the error they need every time, where it is supposed to be
> a per-driver constant.

I think the signature proposed by Benno is useful, since even specific drivers
may return a different error code depending on the semantic context of where
this call fails.

> So I guess a per-driver macro or wrapper would be more ergonomic in the end.

I think this makes sense as an addition on top of the above.

