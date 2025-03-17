Return-Path: <linux-kernel+bounces-564797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 507E7A65AD4
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 18:32:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6B13189C4F5
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 17:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70B0D1AC458;
	Mon, 17 Mar 2025 17:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T+N/DiNq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBB8A195808;
	Mon, 17 Mar 2025 17:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742232660; cv=none; b=czseI9+pFn61eGkqSzS47W7kXjMzz43Zp6/kvNqSYyBNaihj5mUtftEPPZbqT0dx3dF5neTolsgGrnyyz0pNkUpFY6KbQl5V8NB+XRkr691oYB8Z/7+xPJTc8mZCMpIv9Yk4pE5zqzynGD6lgOWQFrJnKG7sfxYIgw0RMCVnMPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742232660; c=relaxed/simple;
	bh=ZX7pJ9u3ms7hWD7fGIN1EPw0oBwWKwkhJubpGynx8DA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lOi7L6iIvhPiBjCxpSrn/cbBAbcib55ySTZNN5f4rbgl6VK0BKsRHShEi/n5Mf28nnOPVvi4I0Bm124cbH673Vr6FBovkA8a1FodC4NOeTOBRn1eJY2mu73pDTehP5itOJT8ll92fjkw7MnNBNhGv006O7vl9c0ruApfGC0v9+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T+N/DiNq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFAE6C4CEE3;
	Mon, 17 Mar 2025 17:30:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742232660;
	bh=ZX7pJ9u3ms7hWD7fGIN1EPw0oBwWKwkhJubpGynx8DA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T+N/DiNq6pse7XTZpeJJha+ohtOMro5318REbnAypMmkeqDXf3KE3mrd0NffkUdEm
	 RAx3xaLt5OiJx41yWjhH0WK/2ZIwJpea2O40x7+YPhwkb+0h7XidDgFGcgexi3Gp3T
	 m1CRz/M418oa8z/yE3+rcmRn7J3rD7MBbRxbaZI+YhAAOiS7fF7iKU8jCYTEDUt163
	 s3GpGwO3q9QvcYMaIyQGcxVcJ1W9peb8ci0TR7BovhzYbmFl7Z1T5BeZ0qqnrW+EJs
	 eEt1gB/9tEw+ZbFtbnruCqRBjqGt8o4UpxcQBMZaOZNfU8zLt6U6TirmOQpivce70L
	 MqMdDRCymonKw==
Date: Mon, 17 Mar 2025 18:30:55 +0100
From: Danilo Krummrich <dakr@kernel.org>
To: Benno Lossin <benno.lossin@proton.me>
Cc: Tamir Duberstein <tamird@gmail.com>, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rust: alloc: use `spare_capacity_mut` to reduce unsafe
Message-ID: <Z9hcT4KPwgtHmiTT@cassiopeiae>
References: <20250317-vec-push-use-spare-v1-1-7e025ef4ae14@gmail.com>
 <D8IM66U67XBD.28KWYO1XSF8ZQ@proton.me>
 <CAJ-ks9kq1cQ2-ZNzG9P4SBvk-AjXxT+na-89K33imB4fsCvu4A@mail.gmail.com>
 <Z9hXMcFVdF8MMusU@cassiopeiae>
 <D8IPQUN25M12.2CIZR4QHJ201N@proton.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <D8IPQUN25M12.2CIZR4QHJ201N@proton.me>

On Mon, Mar 17, 2025 at 05:22:15PM +0000, Benno Lossin wrote:
> On Mon Mar 17, 2025 at 6:09 PM CET, Danilo Krummrich wrote:
> > On Mon, Mar 17, 2025 at 10:39:05AM -0400, Tamir Duberstein wrote:
> >> On Mon, Mar 17, 2025 at 10:34 AM Benno Lossin <benno.lossin@proton.me> wrote:
> >> > On Mon Mar 17, 2025 at 12:42 PM CET, Tamir Duberstein wrote:
> >> > > Use `spare_capacity_mut` in the implementation of `push` to reduce the
> >> > > use of `unsafe`. Both methods were added in commit 2aac4cd7dae3 ("rust:
> >> > > alloc: implement kernel `Vec` type").
> >> > >
> >> > > Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> >> > > ---
> >> > >  rust/kernel/alloc/kvec.rs | 11 ++---------
> >> > >  1 file changed, 2 insertions(+), 9 deletions(-)
> >> > >
> >> > > diff --git a/rust/kernel/alloc/kvec.rs b/rust/kernel/alloc/kvec.rs
> >> > > index ae9d072741ce..d2bc3d02179e 100644
> >> > > --- a/rust/kernel/alloc/kvec.rs
> >> > > +++ b/rust/kernel/alloc/kvec.rs
> >> > > @@ -285,15 +285,8 @@ pub fn spare_capacity_mut(&mut self) -> &mut [MaybeUninit<T>] {
> >> > >      pub fn push(&mut self, v: T, flags: Flags) -> Result<(), AllocError> {
> >> > >          self.reserve(1, flags)?;
> >> > >
> >> > > -        // SAFETY:
> >> > > -        // - `self.len` is smaller than `self.capacity` and hence, the resulting pointer is
> >> > > -        //   guaranteed to be part of the same allocated object.
> >> > > -        // - `self.len` can not overflow `isize`.
> >> > > -        let ptr = unsafe { self.as_mut_ptr().add(self.len) };
> >> > > -
> >> > > -        // SAFETY:
> >> > > -        // - `ptr` is properly aligned and valid for writes.
> >> > > -        unsafe { core::ptr::write(ptr, v) };
> >> > > +        // The call to `reserve` was successful so the spare capacity is at least 1.
> >> > > +        self.spare_capacity_mut()[0].write(v);
> >> >
> >> > I think the code uses unsafe to avoid a bounds check, but I'm not 100%
> >> > sure. Danilo might remember more info.
> >
> > Yes, that was the justification to use unsafe calls instead.
> >
> > (This may also justify keeping dec_len() unsafe, since otherwise it would
> > introduce an additional boundary check for pop().)
> 
> If we use saturating_sub then we don't need a bounds check (at least on
> non-debug builds), right? 

	fn dec_len(&mut self, count: usize) -> &mut [T] {
	    self.len = self.len.saturating_sub(count);

	    // Potentially broken, since maybe `count > self.len`, hence need an
	    // additional check.
	    unsafe { slice::from_raw_parts_mut(self.as_mut_ptr().add(self.len), count) }
	}

