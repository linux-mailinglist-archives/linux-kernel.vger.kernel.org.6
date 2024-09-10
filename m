Return-Path: <linux-kernel+bounces-323804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C55A19743AF
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 21:50:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52DDD1F20978
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 19:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE72D1A7ADF;
	Tue, 10 Sep 2024 19:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="NwL46EJy"
Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7217E1A2576;
	Tue, 10 Sep 2024 19:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725997790; cv=none; b=jnN4pYVDq/PTmwE+W5SIujKmK6mVfjozQeTirrCXHM86XSgdx8PJG4xc0DzMi5XlFOt8XYAtHqKOvywFZ4iewDCE+M0/WYTJATSyeQd2VhaFZ39MhByJmk+UWImhAkgDjKbPZTQ5NDUwM4uVHJowr7DM87Z2/49dFLnkhFA+SFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725997790; c=relaxed/simple;
	bh=bD0vhkUxcynJyipBLvXyCHh0YaXgdiOAXsDiV8DAWlk=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rerDfLDTctnBX28Zhg7R+bk8bpCmgUz48jXCGbvqE1o9OJI1tuPG3oCsv8se+UI0cKWBb1LiLBpHbiFPcsV4yWRTZpVvIff3mCoJl6IEQl5SSq0gkDT+HcDiQTGW70+Aqvb/6tA7wTzad0s/4biyOM2cH8CUdmJV4syPhc/JVZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=NwL46EJy; arc=none smtp.client-ip=185.70.40.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1725997786; x=1726256986;
	bh=NBSy/ukMPUFq4hhiS8sTvxHbE6CJ6MpnNMDJG5LgNIA=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=NwL46EJyGnK9RO/wPG0QgZgUapyz8uQhsLe5hp23XfG3o3P70qLY+TGp4Mq5esA/U
	 dvUSlc/rKdk65qH+xS3enhxTXDnv3ns69MSaTd0OyrqJextYDhYCh/4OkBxifnnBtE
	 ankLDKvUMvDxTi4lZdwEPN/zB17Kht3X2DuIl5Mu5Hd8NOn4lQrvcKsgmbNLvImZWq
	 Bxm6/f00Xx7icAqwvJOkCKJ4idzXzr/idICUXgI9AGbzLooDkxXtC26zya5g8AVkhU
	 4lexie5ZO4dauIRbiTvRBL5gTYCCUWa0SmiWQclh3M2d6fFwtNknBY6gdJdAxplo5R
	 oiDW4hDSCRFCA==
Date: Tue, 10 Sep 2024 19:49:42 +0000
To: Danilo Krummrich <dakr@kernel.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, a.hindborg@samsung.com, aliceryhl@google.com, akpm@linux-foundation.org, daniel.almeida@collabora.com, faith.ekstrand@collabora.com, boris.brezillon@collabora.com, lina@asahilina.net, mcanal@igalia.com, zhiw@nvidia.com, cjia@nvidia.com, jhubbard@nvidia.com, airlied@redhat.com, ajanulgu@redhat.com, lyude@redhat.com, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v6 09/26] rust: alloc: implement kernel `Box`
Message-ID: <19d81a27-9600-4990-867c-624104e3ad83@proton.me>
In-Reply-To: <ZuCEneJeXcRo5qs8@pollux>
References: <20240816001216.26575-1-dakr@kernel.org> <20240816001216.26575-10-dakr@kernel.org> <0146cb78-5a35-4d6b-bc75-fed1fc0c270c@proton.me> <ZuCEneJeXcRo5qs8@pollux>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 47c1545a9cd7e38378def8282cdab552c864d3e8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10.09.24 19:40, Danilo Krummrich wrote:
> On Sat, Aug 31, 2024 at 05:39:07AM +0000, Benno Lossin wrote:
>> On 16.08.24 02:10, Danilo Krummrich wrote:
>>> +/// # Examples
>>> +///
>>> +/// ```
>>> +/// let b =3D KBox::<u64>::new(24_u64, GFP_KERNEL)?;
>>> +///
>>> +/// assert_eq!(*b, 24_u64);
>>> +/// # Ok::<(), Error>(())
>>> +/// ```
>>> +///
>>> +/// ```
>>> +/// # use kernel::bindings;
>>> +/// const SIZE: usize =3D bindings::KMALLOC_MAX_SIZE as usize + 1;
>>> +/// struct Huge([u8; SIZE]);
>>> +///
>>> +/// assert!(KBox::<Huge>::new_uninit(GFP_KERNEL | __GFP_NOWARN).is_err=
());
>>> +/// ```
>>
>> It would be nice if you could add something like "KBox can't handle big
>> allocations:" above this example, so that people aren't confused why
>> this example expects an error.
>=20
> I don't think that's needed, it's implied by
> `SIZE =3D=3D bindings::KMALLOC_MAX_SIZE + 1`.
>=20
> Surely, we could add it nevertheless, but it's not very precise to just s=
ay "big
> allocations". And I think this isn't the place for lengthy explanations o=
f
> `Kmalloc` behavior.

Fair point, nevertheless I find examples a bit more useful, when the
intention behind them is not only given as code.

>>> +///
>>> +/// ```
>>> +/// # use kernel::bindings;
>>> +/// const SIZE: usize =3D bindings::KMALLOC_MAX_SIZE as usize + 1;
>>> +/// struct Huge([u8; SIZE]);
>>> +///
>>> +/// assert!(KVBox::<Huge>::new_uninit(GFP_KERNEL).is_ok());
>>> +/// ```
>>
>> Similarly, you could then say above this one "Instead use either `VBox`
>> or `KVBox`:"
>>
>>> +///
>>> +/// # Invariants
>>> +///
>>> +/// The [`Box`]' pointer is always properly aligned and either points =
to memory allocated with `A`
>>
>> Please use `self.0` instead of "[`Box`]'".
>>
>>> +/// or, for zero-sized types, is a dangling pointer.
>>
>> Probably "dangling, well aligned pointer.".
>=20
> Does this add any value? For ZSTs everything is "well aligned", isn't it?

ZSTs can have alignment and then unaligned pointers do exist for them
(and dereferencing them is UB!):

    #[repr(align(64))]
    struct Token;

    fn main() {
        let t =3D 64 as *mut Token;
        let t =3D unsafe { t.read() }; // this is fine.
        let t =3D 4 as *mut Token;
        let t =3D unsafe { t.read() }; // this is UB, see below for miri's =
output
    }

Miri complains:

    error: Undefined Behavior: accessing memory based on pointer with align=
ment 4, but alignment 64 is required
     --> src/main.rs:8:22
      |
    8 |     let t =3D unsafe { t.read() }; // this is UB, see below for mir=
i's output
      |                      ^^^^^^^^ accessing memory based on pointer wit=
h alignment 4, but alignment 64 is required
      |
      =3D help: this indicates a bug in the program: it performed an invali=
d operation, and caused Undefined Behavior
      =3D help: see https://doc.rust-lang.org/nightly/reference/behavior-co=
nsidered-undefined.html for further information
      =3D note: BACKTRACE:
      =3D note: inside `main` at src/main.rs:8:22: 8:30

>>> +#[repr(transparent)]
>>> +pub struct Box<T: ?Sized, A: Allocator>(NonNull<T>, PhantomData<A>);


>>> +impl<T, A> Box<T, A>
>>> +where
>>> +    T: ?Sized,
>>> +    A: Allocator,
>>> +{
>>> +    /// Creates a new `Box<T, A>` from a raw pointer.
>>> +    ///
>>> +    /// # Safety
>>> +    ///
>>> +    /// For non-ZSTs, `raw` must point at an allocation allocated with=
 `A`that is sufficiently
>>> +    /// aligned for and holds a valid `T`. The caller passes ownership=
 of the allocation to the
>>> +    /// `Box`.
>>
>> You don't say what must happen for ZSTs.
>=20
> Because we don't require anything for a ZST, do we?

We require a non-null, well aligned pointer (see above).

---
Cheers,
Benno

>>> +    #[inline]
>>> +    pub const unsafe fn from_raw(raw: *mut T) -> Self {
>>> +        // INVARIANT: Validity of `raw` is guaranteed by the safety pr=
econditions of this function.
>>> +        // SAFETY: By the safety preconditions of this function, `raw`=
 is not a NULL pointer.
>>> +        Self(unsafe { NonNull::new_unchecked(raw) }, PhantomData::<A>)
>>> +    }


