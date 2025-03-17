Return-Path: <linux-kernel+bounces-564756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A5608A65A4F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 18:19:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD4201896550
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 17:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61DCC1AAA1E;
	Mon, 17 Mar 2025 17:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W6MY5att"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B99E819F13F;
	Mon, 17 Mar 2025 17:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742231351; cv=none; b=dv0iOL011K2L8BfFnZjHy28AHoVkVnoKSc8Zs1oumWEgm9F8ythM2kMpjpSKhag9rAoYfydrUISrH6bJggs4SJbMwuaFXm5KUoXxC7AVKhQC0zs8n4UfThSpqRkqRF2dvS3N6ORAmjYd0PalbX9umM4wrPvRCz6HJWB5hm/6k5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742231351; c=relaxed/simple;
	bh=A1jL+peMSeOFcHU5ac/T5X7kFEtj+k/4Qol4NnZA+ts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oRFIlO0Ir7FZzWzKv8c2t7YRv1L5L/vPf7pNU8T6DgvQUrO7dKQPD05HDb1cqOQt9+CkvMYngpDmHuDWmBaKN4ply/SKBelEf2XbUSTUAhCbXL9V5nobhnVdrNf+j1P1Zw14JtPUiZtTWGl1vDf/WywzRyBLrUT3F3BfMpeDQnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W6MY5att; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDA53C4CEE3;
	Mon, 17 Mar 2025 17:09:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742231351;
	bh=A1jL+peMSeOFcHU5ac/T5X7kFEtj+k/4Qol4NnZA+ts=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W6MY5attizH0WsAMY3CAiD0Yt81ww/OJLwJpMj7vuE00gUIJSlOVx4zD8gywcuPh2
	 6KJi/jg9GoiYb9t6437l4Z4ncbXW1mW5o+a2zzqzQEpPymgDBsdgEpyPa7FIWWJJoY
	 EgKNW/N+HgMFrvxjERewJv/LwJrvElLdCcFuuGsTQHgjhU/YgcLkHdK5J2aJMZO/vF
	 k4OVfGFZlFBvMjnIyBgbFHZ1TKIhrqvh8i7ro2MvtV7n6e5EesqbPCiauQniWRFCPB
	 Q4gqKMRQPfz9pzrgIHAgSMxyQNfHijNXZ+Snby9pSGpqNyuVudH8uN0X1FboqNM++1
	 UoQE/2LDulqDw==
Date: Mon, 17 Mar 2025 18:09:05 +0100
From: Danilo Krummrich <dakr@kernel.org>
To: Tamir Duberstein <tamird@gmail.com>
Cc: Benno Lossin <benno.lossin@proton.me>, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rust: alloc: use `spare_capacity_mut` to reduce unsafe
Message-ID: <Z9hXMcFVdF8MMusU@cassiopeiae>
References: <20250317-vec-push-use-spare-v1-1-7e025ef4ae14@gmail.com>
 <D8IM66U67XBD.28KWYO1XSF8ZQ@proton.me>
 <CAJ-ks9kq1cQ2-ZNzG9P4SBvk-AjXxT+na-89K33imB4fsCvu4A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJ-ks9kq1cQ2-ZNzG9P4SBvk-AjXxT+na-89K33imB4fsCvu4A@mail.gmail.com>

On Mon, Mar 17, 2025 at 10:39:05AM -0400, Tamir Duberstein wrote:
> On Mon, Mar 17, 2025 at 10:34 AM Benno Lossin <benno.lossin@proton.me> wrote:
> >
> > On Mon Mar 17, 2025 at 12:42 PM CET, Tamir Duberstein wrote:
> > > Use `spare_capacity_mut` in the implementation of `push` to reduce the
> > > use of `unsafe`. Both methods were added in commit 2aac4cd7dae3 ("rust:
> > > alloc: implement kernel `Vec` type").
> > >
> > > Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> > > ---
> > >  rust/kernel/alloc/kvec.rs | 11 ++---------
> > >  1 file changed, 2 insertions(+), 9 deletions(-)
> > >
> > > diff --git a/rust/kernel/alloc/kvec.rs b/rust/kernel/alloc/kvec.rs
> > > index ae9d072741ce..d2bc3d02179e 100644
> > > --- a/rust/kernel/alloc/kvec.rs
> > > +++ b/rust/kernel/alloc/kvec.rs
> > > @@ -285,15 +285,8 @@ pub fn spare_capacity_mut(&mut self) -> &mut [MaybeUninit<T>] {
> > >      pub fn push(&mut self, v: T, flags: Flags) -> Result<(), AllocError> {
> > >          self.reserve(1, flags)?;
> > >
> > > -        // SAFETY:
> > > -        // - `self.len` is smaller than `self.capacity` and hence, the resulting pointer is
> > > -        //   guaranteed to be part of the same allocated object.
> > > -        // - `self.len` can not overflow `isize`.
> > > -        let ptr = unsafe { self.as_mut_ptr().add(self.len) };
> > > -
> > > -        // SAFETY:
> > > -        // - `ptr` is properly aligned and valid for writes.
> > > -        unsafe { core::ptr::write(ptr, v) };
> > > +        // The call to `reserve` was successful so the spare capacity is at least 1.
> > > +        self.spare_capacity_mut()[0].write(v);
> >
> > I think the code uses unsafe to avoid a bounds check, but I'm not 100%
> > sure. Danilo might remember more info.

Yes, that was the justification to use unsafe calls instead.

(This may also justify keeping dec_len() unsafe, since otherwise it would
introduce an additional boundary check for pop().)

> 
> We could use `slice::get_unchecked_mut` here to retain the same
> guarantee of no bounds check. That would still be one fewer unsafe
> blocks.

Sounds reasonable.

