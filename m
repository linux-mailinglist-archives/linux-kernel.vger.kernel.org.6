Return-Path: <linux-kernel+bounces-564016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 129D7A64C16
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 12:16:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66960169B2B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 11:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 454E52356D0;
	Mon, 17 Mar 2025 11:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K5l1nkp/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F3F442069;
	Mon, 17 Mar 2025 11:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742210166; cv=none; b=iw3i6AStOwloYmGANdoLcpemurIRoIA1YUl2mtmrXegGPe+8jtRu92zWBs90yFlnPDLU5Z6AFCQQte2VlxEpoqtSXmlWpe1Mxn2kz6QL5kENPufHb5PCVVg0CxF9wNhQ0h2mXLRV8rgFoYmc8h01xABmE2VhveDk3PWCUVKqYzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742210166; c=relaxed/simple;
	bh=OaMOFq+Tfv3lDS5eZ6Buv2ayrywSEXFmvlYWNCSt1nY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H6trcVpcYowMHDJD5MZaeVWGzznDi9JKxy1qL53R42EOZwIa0f6KIFBoGyYrnwwJ8VJUU4pz0XyD6F2fwbeHW6Vc96BOrAlgrdkJRTsBZk9rDFXSlaO1db3fGUG3v/YAP+4KfBsn+KGzHHbebmRIZchSyALZ49CUON28uSb5IwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K5l1nkp/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E9D0C4CEE3;
	Mon, 17 Mar 2025 11:16:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742210166;
	bh=OaMOFq+Tfv3lDS5eZ6Buv2ayrywSEXFmvlYWNCSt1nY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=K5l1nkp/YS6nGYbNPBoLd12N8u0FdLmg1Hjj4nEUYhx+dRbQQBsppNX9w7tu95Uhp
	 6On9MvFi0xk8TKRKYA/9ZDzLNwTOTHc2Rq1PSstfu8621eqVWR3wNCyJY/F7GuXzbd
	 TSI0eSg3Ujr7qXp4amCG/9faawxd9CbaBWlcVy2WV1GEjGHc+0ZSUq3mF1yskyP1Ve
	 Eb6fyjYCtA2Gm+70zdDT0YDGA1GTbv/FymUA1Uwcwp7gxJ3YEyhOUIYbo5NwJ+qXT6
	 jC0UKOD03Z9N4qpzNHgKoeaXTaRBKFDwePoiwHIxvSgQYRsquzjBE+B03JInmfXg1H
	 fB7iMf8ynziLA==
Date: Mon, 17 Mar 2025 12:16:00 +0100
From: Danilo Krummrich <dakr@kernel.org>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Tamir Duberstein <tamird@gmail.com>,
	Andrew Ballance <andrewjballance@gmail.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] rust: alloc: replace `Vec::set_len` with `inc_len`
Message-ID: <Z9gEcDRDLTd4Svp7@pollux>
References: <20250316-vec-set-len-v1-0-60f98a28723f@gmail.com>
 <20250316-vec-set-len-v1-1-60f98a28723f@gmail.com>
 <Z9f-Z15bSh8MA1wJ@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9f-Z15bSh8MA1wJ@google.com>

On Mon, Mar 17, 2025 at 10:50:15AM +0000, Alice Ryhl wrote:
> On Sun, Mar 16, 2025 at 06:32:00PM -0400, Tamir Duberstein wrote:
> > Rename `set_len` to `inc_len` and simplify its safety contract.
> 
> You're missing a Signed-off-by tag.
> 
> >  rust/kernel/alloc/kvec.rs | 19 +++++++++----------
> >  rust/kernel/str.rs        |  2 +-
> >  rust/kernel/uaccess.rs    |  2 +-
> >  3 files changed, 11 insertions(+), 12 deletions(-)
> > 
> > diff --git a/rust/kernel/alloc/kvec.rs b/rust/kernel/alloc/kvec.rs
> > index ae9d072741ce..d43a1d609434 100644
> > --- a/rust/kernel/alloc/kvec.rs
> > +++ b/rust/kernel/alloc/kvec.rs
> > @@ -183,17 +183,16 @@ pub fn len(&self) -> usize {
> >          self.len
> >      }
> >  
> > -    /// Forcefully sets `self.len` to `new_len`.
> > +    /// Increments `self.len` by `additional`.
> >      ///
> >      /// # Safety
> >      ///
> > -    /// - `new_len` must be less than or equal to [`Self::capacity`].
> > -    /// - If `new_len` is greater than `self.len`, all elements within the interval
> > -    ///   [`self.len`,`new_len`) must be initialized.
> > +    /// - `self.len + additional` must be less than or equal to [`Self::capacity`].
> > +    /// - All elements within the interval [`self.len`,`self.len + additional`) must be initialized.
> >      #[inline]
> > -    pub unsafe fn set_len(&mut self, new_len: usize) {
> > -        debug_assert!(new_len <= self.capacity());
> > -        self.len = new_len;
> > +    pub unsafe fn inc_len(&mut self, additional: usize) {
> > +        debug_assert!(self.len() + additional <= self.capacity());
> > +        self.len += additional;
> 
> I guess we could use an INVARIANT: comment here.

Yeah, I fixed that up in a separate patch. I'm fine with Tamir picking it up or
doing it himself in a new one, etc. But I think this patch should only focus on
the rename.

