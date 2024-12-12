Return-Path: <linux-kernel+bounces-442753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84F129EE129
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 09:22:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA6C616312B
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 08:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A9CE20C03D;
	Thu, 12 Dec 2024 08:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qycEh1uQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE51558BA;
	Thu, 12 Dec 2024 08:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733991753; cv=none; b=smFCozxF9yROq6sLu+f0mnBmueTFlYTSK8Fli1y9NdFlv1Nvy+wJALk3z4Uv5pEU1Qv0dVwW8IBlBXV5QDvmWlBEkQ1PXh+taRmYum7WBr7Ozs7o4N8PiSP3So8d+yzxCXrHUMFDnt+tT0fUpp/Ly7+HdOu8Aa+4y5FqNaXFZkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733991753; c=relaxed/simple;
	bh=++lvcFwyWhMB1PFDWOngLLSKdXo8A3B5L3C6ilN7LtU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pVaZy62vCfyPnAOeB3+XbrOnbBT44JDVGlPq+pk769VEpuRM+hOlZf6YjzFBwMx7ztaaswD6wrCtAJnXqrarlYIOvxp03Ag+QXU2zKaFAxQ65ICGAjb5vshHTrXVDlM1AzWutz1SWWWN6vGqVLMQ4b7q/FgsfF1//FHMhqCPNk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qycEh1uQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 269C0C4CECE;
	Thu, 12 Dec 2024 08:22:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733991753;
	bh=++lvcFwyWhMB1PFDWOngLLSKdXo8A3B5L3C6ilN7LtU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=qycEh1uQ4AhvtaFefvByoIK2ha/fYJhsNX0qCd6MDW/ZbkhzUHi27p+FVCA4i7pd0
	 ssKCcj3S863/Tez0mMZ/o3rPx4JDO6ssT1XMEkbWENcD6BlBT/rRe98H9xVUjfeBWQ
	 KaIRBL97+QOM76iIB9LBhHuSIIcYSDheCYCLbuqtwqa+zV0uz4Vw8Xgj9qIGmvDF6j
	 WDUbaeJcFy8VnzoeQOyyBQxlDmSH0/1NB89esoKLja59YVoo6w1sBNJqTtCcYtpx0P
	 Xn14LSOp62tMA+snF4HEEFAAJ5OW+5WeAxxUKOWhD5vC+zWhhb6DakgmoN7tuckb6S
	 AVI0Mh2lWgOiA==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Tamir Duberstein" <tamird@gmail.com>
Cc: "Alice Ryhl" <aliceryhl@google.com>,  "Danilo Krummrich"
 <dakr@kernel.org>,  "Miguel Ojeda" <ojeda@kernel.org>,  "Alex Gaynor"
 <alex.gaynor@gmail.com>,  "Boqun Feng" <boqun.feng@gmail.com>,  "Gary Guo"
 <gary@garyguo.net>,  =?utf-8?Q?Bj=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,  "Benno
 Lossin" <benno.lossin@proton.me>,  "Trevor Gross" <tmgross@umich.edu>,
  =?utf-8?Q?Ma=C3=ADra?= Canal <mcanal@igalia.com>,  "Asahi Lina"
 <lina@asahilina.net>,
  <rust-for-linux@vger.kernel.org>,  <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v11 2/2] rust: xarray: Add an abstraction for XArray
In-Reply-To: <CAJ-ks9=oyLSkqAsAkO5VSM9js2G2AFvvrA-qHRKNYnsZyUx=mA@mail.gmail.com>
 (Tamir
	Duberstein's message of "Wed, 11 Dec 2024 10:41:05 -0500")
References: <20241203-rust-xarray-bindings-v11-0-58a95d137ec2@gmail.com>
	<20241203-rust-xarray-bindings-v11-2-58a95d137ec2@gmail.com>
	<CAH5fLgjPir8LfzfouBd3PYBvfCkWgQEw+im-=Vo7z8kBmFLtrw@mail.gmail.com>
	<dGt7iLkZMZ5kn-_LRirlwzFd9IS8guo5pt05gJotd_eQ21vyK0hA064W0VCA75N51sHgTlRUiSEEv_p-ANe-LA==@protonmail.internalid>
	<CAJ-ks9=oyLSkqAsAkO5VSM9js2G2AFvvrA-qHRKNYnsZyUx=mA@mail.gmail.com>
Date: Thu, 12 Dec 2024 09:22:21 +0100
Message-ID: <87jzc5e2f6.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

"Tamir Duberstein" <tamird@gmail.com> writes:

> On Wed, Dec 11, 2024 at 10:04=E2=80=AFAM Alice Ryhl <aliceryhl@google.com=
> wrote:
>>
>> > +    fn iter(&self) -> impl Iterator<Item =3D core::ptr::NonNull<T::Po=
intedTo>> + '_ {
>> > +        // TODO: Remove when https://lore.kernel.org/all/202409132130=
41.395655-5-gary@garyguo.net/ is applied.
>> > +        const MAX: core::ffi::c_ulong =3D core::ffi::c_ulong::MAX;
>>
>> I think you can use kernel::ffi::c_ulong already. Enough things were
>> merged in 6.13 for that to work. If you import kernel::ffi::c_ulong at
>> the top of this file, then you can just do c_ulong::MAX in the
>> function calls below.
>
> This isn't about using kernel::ffi::c_ulong; it's about using
> usize::MAX. I'll clarify the comment and change this to use
> kernel::ffi::c_ulong for now.
>
>> > +        let mut index =3D 0;
>> > +
>> > +        // SAFETY: `self.xa` is always valid by the type invariant.
>> > +        iter::once(unsafe {
>> > +            bindings::xa_find(self.xa.get(), &mut index, MAX, binding=
s::XA_PRESENT)
>> > +        })
>> > +        .chain(iter::from_fn(move || {
>> > +            // SAFETY: `self.xa` is always valid by the type invarian=
t.
>> > +            Some(unsafe {
>> > +                bindings::xa_find_after(self.xa.get(), &mut index, MA=
X, bindings::XA_PRESENT)
>> > +            })
>> > +        }))
>> > +        .map_while(|ptr| core::ptr::NonNull::new(ptr.cast()))
>>
>> You use core::ptr::NonNull in many places. Consider importing it.
>
> Will do.
>
>> > +    /// Stores an entry in the array.
>> > +    ///
>> > +    /// May drop the lock if needed to allocate memory, and then reac=
quire it afterwards.
>> > +    ///
>> > +    /// On success, returns the entry which was previously at the giv=
en index.
>> > +    ///
>> > +    /// On failure, returns the entry which was attempted to be store=
d.
>> > +    pub fn store(
>> > +        &mut self,
>> > +        index: usize,
>> > +        value: T,
>> > +        gfp: alloc::Flags,
>> > +    ) -> Result<Option<T>, (T, Error)> {
>>
>> We can see in your examples that this return type is inconvenient.
>> Perhaps it would be better to make a new error type containing a T and
>> an Error, and implement From so that the question mark can convert
>> directly to Error (throwing away the T).
>
> Will do.
>
>> > +// SAFETY: It is safe to send `XArray<T>` to another thread when the =
underlying `T` is `Send`
>> > +// because XArray is thread-safe and all mutation operations are sync=
hronized.
>> > +unsafe impl<T: ForeignOwnable + Send> Send for XArray<T> {}
>> > +
>> > +// SAFETY: It is safe to send `&XArray<T>` to another thread when the=
 underlying `T` is `Sync`
>> > +// because it effectively means sharing `&T` (which is safe because `=
T` is `Sync`); additionally, it
>> > +// needs `T` to be `Send` because any thread that has a `&XArray<T>` =
may lock it and get a
>> > +// `Guard<T>` on that thread, so the thread may ultimately access `T`=
 using a mutable reference, for
>> > +// example, using `get_mut` or `remove`.
>> > +unsafe impl<T: ForeignOwnable + Send + Sync> Sync for XArray<T> {}
>>
>> I don't think Sync is needed due to the spinlock.
>
> Agreed. How's this phrasing for the comment?
>
> // SAFETY: It is safe to send `&XArray<T>` to another thread when the
> underlying `T` is `Send`
> // because any thread that has a `&XArray<T>` may lock it and get a
> `Guard<T>` on that thread, so
> // the thread may ultimately access `T` using a mutable borrow, for
> example, using `get_mut` or
> // `remove`. It is not necessary for `T` to be `Sync` because access
> to immutable borrows of `T` is
> // also synchronized through `Guard<T>`.

I don't think we need the last paragraph. How about this:

SAFETY: It is safe to send `&XArray<T>` to another thread when the
underlying `T` is `Send` because operations on the `XArray` are
synchronized internally, and all access to `T` owned by the `XArray` is
exclusive under the internal `XArray` lock.


Best regards,
Andreas Hindborg




