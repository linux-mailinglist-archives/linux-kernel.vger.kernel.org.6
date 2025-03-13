Return-Path: <linux-kernel+bounces-559832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BFB60A5FA64
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 16:49:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D1833B640C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 15:48:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E133D268FE9;
	Thu, 13 Mar 2025 15:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ri95nqXX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A885523A;
	Thu, 13 Mar 2025 15:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741880941; cv=none; b=Kw7V1FGrZFmfidZk2tg7uge7FpWuQ6/V7RHOlyirbj/5ApAIS0md5kNCCvXqSuoenRF4bHtdaxIlJkiQT2bti+7JLggW2Qj8gogCkVcl+QI3M/RsqRRUiv+GTSuQDiBs3uVCr/HlKabLDWWgyKzpEb+S67vCIcKkZKNhMPkHIbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741880941; c=relaxed/simple;
	bh=KOtUKVYArSvSjd+bgQSYpEBlLmiI7To92Pb6LyNe5us=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fgjD9zvEdSw3W0VANa1wlbt/NjOp6XHxo64W5hgsdg89fmU74vZ7wEXJ7Qc0SUkNSDgLlHYxawcfJ4ACfKv8MbIjABy+JGgkhwzYbZ2W1ZFkVWjnRauTOuErscLGbaSPx7WIH5nhQ8IOv7FcfT3e1YpRvBKGRFmHukRjXk1Sz0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ri95nqXX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53087C4CEDD;
	Thu, 13 Mar 2025 15:48:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741880940;
	bh=KOtUKVYArSvSjd+bgQSYpEBlLmiI7To92Pb6LyNe5us=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ri95nqXXFZzrKT6wOvjqkbyhpXF6uSp/JUcsWxiWRPkv4UeRyCw0s+RiJROzdHQNf
	 3/PlOO9ADUocL+5I17B6O3Era+bX1aQiGZGCFgdq7ZRVxZj2TO/Fe/UIf86xb5kE54
	 Rb0FcC7xweXsarlp6p2mopNAMCl2QWoCZLsWag5XHbG2cjz18tZ2156DPE8KSAktk5
	 jv4Z9EvDjXeoM3QtB3RBSxC4d/IQry0Z/l1B6sTFYGL3x2BUNg1d21NFebXajj0C1S
	 HzfQvnjYIFjqbCzuqybCimbf0aG2dm8Na1wQwzDJ8je5X1AA8lqgeTuNn62y/wuD8d
	 7cc3RjhxWAZMA==
Date: Thu, 13 Mar 2025 16:48:55 +0100
From: Danilo Krummrich <dakr@kernel.org>
To: Benno Lossin <benno.lossin@proton.me>
Cc: Alexandre Courbot <acourbot@nvidia.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rust/revocable: add try_with() convenience method
Message-ID: <Z9L-Z4Aw64Hi5Lj8@pollux>
References: <20250313-try_with-v1-1-adcae7ed98a9@nvidia.com>
 <D8F7D2RPRVAO.2EF39MZXM6FPR@proton.me>
 <D8F8E4PBHK7O.399Y83M1L3XK3@nvidia.com>
 <D8F91L51P2EA.2FBHGJYSV06HY@proton.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D8F91L51P2EA.2FBHGJYSV06HY@proton.me>

On Thu, Mar 13, 2025 at 03:38:55PM +0000, Benno Lossin wrote:
> On Thu Mar 13, 2025 at 4:08 PM CET, Alexandre Courbot wrote:
> > On Thu Mar 13, 2025 at 11:19 PM JST, Benno Lossin wrote:
> >> Would it make sense to not use `Result` here and continue with `Option`?
> >
> > We would have to return an Option<Result<R>> in this case. The current
> > code folds the closure's Result into the one of the guard's acquisition
> > for convenience.
> >
> > Actually, I don't think I have ever used try_access() a single time
> > without converting its returned Option into a Result. Wouldn't it make
> > sense to do the opposite, i.e. make try_access() return Err(ENXIO) when
> > the guard cannot be acquired and document this behavior?
> 
> Sure, if you're always doing
> 
>     let guard = rev.try_access().ok_or(ENXIO)?;
> 
> Then it makes sense from my view, maybe Danilo has some other argument
> for why `Option` is better.

Most of the time I think we indeed want to derive an Err() if try_access()
fails, but not with a specific error code. The error code depends on the context
of where the revocable is used (e.g. for I/O mappings), but it also depends on
the driver semantics.

