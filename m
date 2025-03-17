Return-Path: <linux-kernel+bounces-564403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C6C3A65428
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 15:46:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9340B3AA504
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 14:46:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF24B2417F2;
	Mon, 17 Mar 2025 14:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="Wtb81bW1"
Received: from mail-24416.protonmail.ch (mail-24416.protonmail.ch [109.224.244.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F24D54652
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 14:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742222804; cv=none; b=b7R9cWpFT0w2oLDqiXVm67zxSQ+KdYjpvvGnD30nYUhrwLYu5+v1KBu1unR/cYSW44cqj59xMUKqogXa1XP1UfNEji0FhpqmAlax9Qfe4QpBPJZEofUQ015YSRx+X44oeyZ4h3usxFuwmb2wtOi5u5Zeriz3/HSn2kHEa8nifNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742222804; c=relaxed/simple;
	bh=dBrC1u0IiUOyDfFTSQe3LuUdm91RasyufM6i//hsVp8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W9K44afU5/upznbeYBH5Qdbbl0loW0JJmwwRByERm93ssScI7JmG2qJkyumkTSvvHCs/+jSaSA81Ni2y8cYAg99x5gHi2bh60ve0JEMfCZ7FGufgdKe66mwRTiv887UdKbFy1sT0taqDu64c4ru3/lBfwc6WHhk0buu2/dvHJzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=Wtb81bW1; arc=none smtp.client-ip=109.224.244.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1742222794; x=1742481994;
	bh=QY+djW/K3/3fwrxQnWk5eIq6mklf+YPdlaYKCGAZlxE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=Wtb81bW1n4BY/CP+BVk766mWLsb/m3xGn2EFocEA56KUW2Hd4+Da/lQRKfWc/N8fW
	 zYHg2Kx+JlIPcDTXEbwmaokAM9Yz5HwXI1jnGe01vg42hLM8vlN6ApY2bBJVvC+u8i
	 Om1delJfOJUfZb4yyBTarHovfYcnnAT9jLZTnikPc4d2JIUstx8zVM0g22RV0gI4i2
	 CoNgGm6hy/P8NamSteO5XRQNCvVm4zuT6W1j2wG9SLsVZfYC7MxFJeNvxB0W/x+IUO
	 5AZ/ZNhkfhDb85Dxd8Ie05mNvK35oSRSJ/t2CUre06zn2BYkkCqKSoYe09eH8fvBnk
	 G3RuG4K1gaOFg==
Date: Mon, 17 Mar 2025 14:46:30 +0000
To: Tamir Duberstein <tamird@gmail.com>, Alice Ryhl <aliceryhl@google.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Danilo Krummrich <dakr@kernel.org>, Andrew Ballance <andrewjballance@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] rust: alloc: replace `Vec::set_len` with `inc_len`
Message-ID: <D8IMFM8UTOV6.1EYIRMPNAZ7I7@proton.me>
In-Reply-To: <CAJ-ks9nSNweaSCVAruo-zWxMAFKcRxcJRScV06NRNBoeEZggfA@mail.gmail.com>
References: <20250316-vec-set-len-v1-0-60f98a28723f@gmail.com> <20250316-vec-set-len-v1-1-60f98a28723f@gmail.com> <D8IGB61NVPBT.1I3IZYPVPIEMU@proton.me> <Z9f96iXE0xxj8th7@google.com> <CAJ-ks9nSNweaSCVAruo-zWxMAFKcRxcJRScV06NRNBoeEZggfA@mail.gmail.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 3b514c4267c74f0f38a70d821dda0b9b73e4ab0c
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon Mar 17, 2025 at 12:25 PM CET, Tamir Duberstein wrote:
> On Mon, Mar 17, 2025 at 6:48=E2=80=AFAM Alice Ryhl <aliceryhl@google.com>=
 wrote:
>>
>> On Mon, Mar 17, 2025 at 09:58:35AM +0000, Benno Lossin wrote:
>> > On Sun Mar 16, 2025 at 11:32 PM CET, Tamir Duberstein wrote:
>> > > Rename `set_len` to `inc_len` and simplify its safety contract.
>> > > ---
>> > >  rust/kernel/alloc/kvec.rs | 19 +++++++++----------
>> > >  rust/kernel/str.rs        |  2 +-
>> > >  rust/kernel/uaccess.rs    |  2 +-
>> > >  3 files changed, 11 insertions(+), 12 deletions(-)
>> > >
>> > > diff --git a/rust/kernel/alloc/kvec.rs b/rust/kernel/alloc/kvec.rs
>> > > index ae9d072741ce..d43a1d609434 100644
>> > > --- a/rust/kernel/alloc/kvec.rs
>> > > +++ b/rust/kernel/alloc/kvec.rs
>> > > @@ -183,17 +183,16 @@ pub fn len(&self) -> usize {
>> > >          self.len
>> > >      }
>> > >
>> > > -    /// Forcefully sets `self.len` to `new_len`.
>> > > +    /// Increments `self.len` by `additional`.
>> >
>> > I would keep the "Forcefully".
>
> Why? Is it possible to set it any other way?

Yeah when `truncate` and `resize` land. It conveys that this is a
low-level operation.

>> > >      ///
>> > >      /// # Safety
>> > >      ///
>> > > -    /// - `new_len` must be less than or equal to [`Self::capacity`=
].
>> > > -    /// - If `new_len` is greater than `self.len`, all elements wit=
hin the interval
>> > > -    ///   [`self.len`,`new_len`) must be initialized.
>> > > +    /// - `self.len + additional` must be less than or equal to [`S=
elf::capacity`].
>> > > +    /// - All elements within the interval [`self.len`,`self.len + =
additional`) must be initialized.
>> > >      #[inline]
>> > > -    pub unsafe fn set_len(&mut self, new_len: usize) {
>> > > -        debug_assert!(new_len <=3D self.capacity());
>> > > -        self.len =3D new_len;
>> > > +    pub unsafe fn inc_len(&mut self, additional: usize) {
>> > > +        debug_assert!(self.len() + additional <=3D self.capacity())=
;
>> >
>> > What if this overflows? Do we always have overflow debugging on when
>> > debug assertions are enabled? If yes, then this is fine.
>>
>> I don't think we do.
>
> Rearranged as
>
>         debug_assert!(additional <=3D self.capacity() - self.len());

LGTM

> It should be impossible for this to underflow because capacity must be
>>=3D len. Interestingly this isn't a documented invariant, but it is
> relied upon by `spare_capacity_mut`.

Oh yeah that should be an invariant. Feel free to open an issue or send
a patch.

>> > > diff --git a/rust/kernel/str.rs b/rust/kernel/str.rs
>> > > index 28e2201604d6..005713839e9e 100644
>> > > --- a/rust/kernel/str.rs
>> > > +++ b/rust/kernel/str.rs
>> > > @@ -840,7 +840,7 @@ pub fn try_from_fmt(args: fmt::Arguments<'_>) ->=
 Result<Self, Error> {
>> > >
>> > >          // SAFETY: The number of bytes that can be written to `f` i=
s bounded by `size`, which is
>> > >          // `buf`'s capacity. The contents of the buffer have been i=
nitialised by writes to `f`.
>> > > -        unsafe { buf.set_len(f.bytes_written()) };
>> > > +        unsafe { buf.inc_len(f.bytes_written()) };
>> >
>> > This change seems wrong unless the code was wrong to begin with.
>> >
>> > Otherwise the change looks good.
>>
>> The buffer has length zero as it was just created with:
>>
>> let mut buf =3D KVec::with_capacity(size, GFP_KERNEL)?;

Ahh, I didn't look at the context. Makes sense.

> Indeed. Added to the commit message.

Thanks.

---
Cheers,
Benno


