Return-Path: <linux-kernel+bounces-344218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FE3198A691
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 16:04:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02CE61C21F73
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 14:04:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AE9B18FDDB;
	Mon, 30 Sep 2024 14:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="ii5mTUaw"
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36DFC848E;
	Mon, 30 Sep 2024 14:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727705060; cv=none; b=sgdFQq//P09FMLQr41+COmPQUxYbkRONHuQsP0yjyynkcOagmq5Dwf8E49dZmPCsK5HKB4lR+cwuBknz5ZYbHsAwqrXf8b7W/DXEEv7nfFH8zHBYaxAlEtXNazqDMy2N51dg+JhGK8UT+TZWQO1fpBEPp9t+1Qora5PBldh1rnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727705060; c=relaxed/simple;
	bh=DkiIyYqe/y/28oveuc6XQ1bi80q/O7JJrwNfG6Cufks=;
	h=Date:To:From:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BO0IaepgELsh3b7KXfAteODlIhqCka66iPkisn1EMytCIHl9dQIuJDe00xdnw2S7r8NzTw9es6cBcHYi/IvtDwVdHGDHw572ziSven1p2fJIF8pXoDEo0d+GiOkWSnkFs+MIPeVeqbc7WGRk/oG62PNCX8v+IIy7Vwfvzu0eoFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=ii5mTUaw; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=yw5nwged4jd6hisz6c6aeuwbei.protonmail; t=1727705051; x=1727964251;
	bh=AKF+9PLOtZ3inttQHvGzN0pX4cfjXoP+IlE3WJSpAq4=;
	h=Date:To:From:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=ii5mTUaw6UHBXjWV/b/wTzCOrZEl/5ZlF6F9NmBH4aIMHda3rMGM/ZbRMeVwSuXbY
	 n5xrDQC1HnvcpSYW5oz5iN+ABgX11LuHGArfsI/zO4TGAgZvr4sExax7PA2eaF7Vh1
	 AhvtaaN4nLsX4XnX1LU90kL7bjJtOQC48t1XstmBBVhaob1tfJjG32D2kXIHf12lrH
	 izQ5UdTBzPctKXnSAoVztFQSvWQsFJTZeZ5HGjOQgZor9h/4VlU108DQ4rJgFYZ0Bb
	 MDcpv0mwnItBY1y3KrL9TEh3o2fBek9Di0uFZF6dWXLwd5S6rP6ele9gJ+rqpkZBa7
	 aMGqo9iDtGz4w==
Date: Mon, 30 Sep 2024 14:04:06 +0000
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Greg KH <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
From: Benno Lossin <benno.lossin@proton.me>
Subject: Re: [PATCH v2 1/2] rust: add untrusted data abstraction
Message-ID: <254496ac-bc5f-4622-99c4-9e2ada27e069@proton.me>
In-Reply-To: <ZvU6JQEN_92nPH4k@phenom.ffwll.local>
References: <20240925205244.873020-1-benno.lossin@proton.me> <20240925205244.873020-2-benno.lossin@proton.me> <ZvU6JQEN_92nPH4k@phenom.ffwll.local>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 7b0a779bb177ff9ad4af23d49f87489eaf67c158
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 26.09.24 12:40, Simona Vetter wrote:
> On Wed, Sep 25, 2024 at 08:53:05PM +0000, Benno Lossin wrote:
>> +    /// Sets the underlying untrusted value.
>> +    ///
>> +    /// # Examples
>> +    ///
>> +    /// ```
>> +    /// use kernel::validate::Untrusted;
>> +    ///
>> +    /// let mut untrusted =3D Untrusted::new(42);
>> +    /// untrusted.write(24);
>> +    /// ```
>> +    pub fn write(&mut self, value: impl Init<T>) {
>> +        let ptr: *mut T =3D &mut self.0 .0;
>> +        // SAFETY: `ptr` came from a mutable reference and the value is=
 overwritten before it is
>> +        // read.
>> +        unsafe { ptr::drop_in_place(ptr) };
>> +        // SAFETY: `ptr` came from a mutable reference and the initiali=
zer cannot error.
>> +        match unsafe { value.__init(ptr) } {
>> +            Ok(()) =3D> {}
>> +        }
>> +    }
>=20
> So I think this doesn't work for a few reasons:
>=20
> - there's a lot of unsafe both here and when using this (even without
>   MaybeUninit), at least if I understand things correctly. And forcing
>   unsafe for something that inheritedly does not break any of the rust
>   memory safety rules feels silly.
>=20
> - it also looks awkward, because you have the special versions
>   write_uninit and write_uninit_slice, and imo if our write isn't good
>   enought to just work with abritrary box/container types, it's not good.
>=20
> - it doesn't actually work for one of the main uaccess.rs use-cases beyon=
d
>   just enabling the current interface. Example in pseudo-rust:
>=20
>   struct IoctlParams {
>       input: u32,
>       ouptut: u32,
>   }
>=20
>   The thing is that ioctl that use the struct approach like drm does, use
>   the same struct if there's both input and output paramterers, and
>   furthermore we are not allowed to overwrite the entire struct because
>   that breaks ioctl restarting. So the flow is roughly
>=20
>   let userptr : UserSlice;
>   let params : Untrusted<IoctlParams>;
>=20
>   userptr.read(params));
>=20
>   // validate params, do something interesting with it params.input
>=20
>   // this is _not_ allowed to overwrite params.input but must leave it
>   // unchanged
>=20
>   params.write(|x| { x.output =3D 42; });
>=20
>   userptr.write(params);
>=20
>   Your current write doesn't allow this case, and I think that's not good
>   enough.

I see. One thing that makes this API work better is field projections
(it's a rust language feature for which we do have a PoC macro
implementation and which I am working on getting into the language):
To only overwrite a part of a struct you would do

    params->output.write(42);

The `->` syntax "projects" the `output` field, turning
`Untrusted<IoctlParams>` into `Untrusted<u32>`.

I think that this would solve your problem with the API. (we probably
need a stop gap solution though until field projections are part of the
language).

>   The one I propsed in private does:
>=20
>   Untrusted<T>::write(&mut self, Fn(&mut T)->())
>=20
>   It's not perfect because it allows you to do other stuff than writing,
>   but it's still pretty good by limiting any potentially dangerous code t=
o
>   the provided closure. And with these of protection apis we need to
>   strike the right balance between as much protection as possible while
>   still allowing users to get the job done.

Ideally I would like to avoid exposing the value.

>   Now I guess you can do this with your write too using a copy constructo=
r
>   approach, but that will result in less efficient code and it's probably
>   also too much functional programming design for kernel developers to
>   cope with.

Agreed.

>> +
>> +    /// Turns a slice of untrusted values into an untrusted slice of va=
lues.
>> +    pub fn transpose_slice(slice: &[Untrusted<T>]) -> &Untrusted<[T]>
>> +    where
>> +        T: Sized,
>> +    {
>> +        let ptr =3D slice.as_ptr().cast::<T>();
>> +        // SAFETY: `ptr` and `len` come from the same slice reference.
>> +        let slice =3D unsafe { slice::from_raw_parts(ptr, slice.len()) =
};
>> +        Untrusted::new_ref(slice)
>> +    }
>> +
>> +    /// Turns a slice of uninitialized, untrusted values into an untrus=
ted slice of uninitialized
>> +    /// values.
>> +    pub fn transpose_slice_uninit(
>> +        slice: &[MaybeUninit<Untrusted<T>>],
>> +    ) -> &Untrusted<[MaybeUninit<T>]>
>=20
> So these and some of the related functions to handle slice of box vs box
> of slice feel a bit awkward. I think we can do better if we rename
> Untrusted and Unvalidated to UntrustedBox and UnvalidatedBox, and then
> make Untrusted and Unvalidated traits, with implementations for
> UntrustedBox<T>, [Untrusted<T>], and all the others we want.

Hmm that might work for `Untrusted`, I will see how that looks. For
`Unvalidated` I am less confident.

> I expect that in the future we'll get more boxes with special semantics
> that we want to use together with Untrusted, not just [] and MaybeUninit.
> One example would be when the Untrusted data is shared with userspace
> (mmap()ed into both kernel and userspace for example for a ringbuffer), i=
n
> which case the data is both Untrusted but also SharedUnsafe or whatever
> we'll call memory that's fundamentally breaking the rust memory model
> because there's no exclusive access (userspace can always do whatever it
> feels like), and all access has to go through at least
> READ_ONCE/WRITE_ONCE from the C side, or often even full blown atomics.

I don't think that we need to wrap that in `Untrusted`, instead the type
representing shared data between kernel and userspace should return
`Untrusted<u8>` instead of `u8`.

> And that memory is not MaybeUninit, because we have to initialize it
> before userspace can mmap it, for otherwise it's an information leak and
> hence security issue.
>=20
> tldr; I think going with traits for Untrusted and Unvalidated here will b=
e
> worth it, even if a bit more pain at first. Plus cleaner interfaces.
>=20
>> +    where
>> +        T: Sized,
>> +    {
>> +        let ptr =3D slice.as_ptr().cast::<MaybeUninit<T>>();
>> +        // SAFETY: `ptr` and `len` come from the same mutable slice ref=
erence.
>> +        let slice =3D unsafe { slice::from_raw_parts(ptr, slice.len()) =
};
>> +        Untrusted::new_ref(slice)
>> +    }

[...]

>> +/// Validates untrusted data.
>> +///
>> +/// # Examples
>> +///
>> +/// The simplest way to validate data is to just implement `Validate<&U=
nvalidated<[u8]>>` for the
>> +/// type that you wish to validate:
>> +///
>> +/// ```
>> +/// use kernel::{
>> +///     error::{code::EINVAL, Error},
>> +///     str::{CStr, CString},
>> +///     validate::{Unvalidated, Validate},
>> +/// };
>> +///
>> +/// struct Data {
>> +///     flags: u8,
>> +///     name: CString,
>> +/// }
>> +///
>> +/// impl Validate<&Unvalidated<[u8]>> for Data {
>> +///     type Err =3D Error;
>> +///
>> +///     fn validate(unvalidated: &Unvalidated<[u8]>) -> Result<Self, Se=
lf::Err> {
>> +///         let raw =3D unvalidated.raw();
>> +///         let (&flags, name) =3D raw.split_first().ok_or(EINVAL)?;
>> +///         let name =3D CStr::from_bytes_with_nul(name)?.to_cstring()?=
;
>> +///         Ok(Data { flags, name })
>> +///     }
>> +/// }
>> +/// ```
>> +///
>> +/// This approach copies the data and requires allocation. If you want =
to avoid the allocation and
>> +/// copying the data, you can borrow from the input like this:
>> +///
>> +/// ```
>> +/// use kernel::{
>> +///     error::{code::EINVAL, Error},
>> +///     str::CStr,
>> +///     validate::{Unvalidated, Validate},
>> +/// };
>> +///
>> +/// struct Data<'a> {
>> +///     flags: u8,
>> +///     name: &'a CStr,
>> +/// }
>> +///
>> +/// impl<'a> Validate<&'a Unvalidated<[u8]>> for Data<'a> {
>> +///     type Err =3D Error;
>> +///
>> +///     fn validate(unvalidated: &'a Unvalidated<[u8]>) -> Result<Self,=
 Self::Err> {
>> +///         let raw =3D unvalidated.raw();
>> +///         let (&flags, name) =3D raw.split_first().ok_or(EINVAL)?;
>> +///         let name =3D CStr::from_bytes_with_nul(name)?;
>> +///         Ok(Data { flags, name })
>> +///     }
>> +/// }
>> +/// ```
>> +///
>> +/// If you need to in-place validate your data, you currently need to r=
esort to `unsafe`:
>> +///
>> +/// ```
>> +/// use kernel::{
>> +///     error::{code::EINVAL, Error},
>> +///     str::CStr,
>> +///     validate::{Unvalidated, Validate},
>> +/// };
>> +/// use core::mem;
>> +///
>> +/// // Important: use `repr(C)`, this ensures a linear layout of this t=
ype.
>> +/// #[repr(C)]
>> +/// struct Data {
>> +///     version: u8,
>> +///     flags: u8,
>> +///     _reserved: [u8; 2],
>> +///     count: u64,
>> +///     // lots of other fields...
>> +/// }
>> +///
>> +/// impl Validate<&Unvalidated<[u8]>> for &Data {
>> +///     type Err =3D Error;
>> +///
>> +///     fn validate(unvalidated: &Unvalidated<[u8]>) -> Result<Self, Se=
lf::Err> {
>> +///         let raw =3D unvalidated.raw();
>> +///         if raw.len() < mem::size_of::<Data>() {
>> +///             return Err(EINVAL);
>> +///         }
>> +///         // can only handle version 0
>> +///         if raw[0] !=3D 0 {
>> +///             return Err(EINVAL);
>> +///         }
>> +///         // version 0 only uses the lower 4 bits of flags
>> +///         if raw[1] & 0xf0 !=3D 0 {
>> +///             return Err(EINVAL);
>> +///         }
>> +///         let ptr =3D raw.as_ptr();
>> +///         // CAST: `Data` only contains integers and has `repr(C)`.
>> +///         let ptr =3D ptr.cast::<Data>();
>> +///         // SAFETY: `ptr` came from a reference and the cast above i=
s valid.
>> +///         Ok(unsafe { &*ptr })
>> +///     }
>> +/// }
>> +/// ```
>> +///
>> +/// To be able to modify the parsed data, while still supporting zero-c=
opy, you can implement
>> +/// `Validate<&mut Unvalidated<[u8]>>`:
>> +///
>> +/// ```
>> +/// use kernel::{
>> +///     error::{code::EINVAL, Error},
>> +///     str::CStr,
>> +///     validate::{Unvalidated, Validate},
>> +/// };
>> +/// use core::mem;
>> +///
>> +/// // Important: use `repr(C)`, this ensures a linear layout of this t=
ype.
>> +/// #[repr(C)]
>> +/// struct Data {
>> +///     version: u8,
>> +///     flags: u8,
>> +///     _reserved: [u8; 2],
>> +///     count: u64,
>> +///     // lots of other fields...
>> +/// }
>> +///
>> +/// impl Validate<&mut Unvalidated<[u8]>> for &Data {
>> +///     type Err =3D Error;
>=20
> I think we should make that one the default, but not sure that's doable
> with associated types instead of generics.

There is the `associated_type_defaults` unstable feature:=20
https://github.com/rust-lang/rust/issues/29661

But I actually think that we should get away from making the `Error`
type the return error of Rust functions. It's much better to have
function-specific errors, since they can be more descriptive. In cases
where we have to return to userspace or C, sure use the existing
`Error`.

> The input parameter should definitely default to the output paramter,
> because often they're just exactly the same e.g. when validating ioctl
> input structures.

I don't understand what you mean by this? The input parameter has to be
some sort of `..Untrusted..` and the output shouldn't have that.

> On this version you've also left out the in-place validation (originally
> validate_bytes), but we can add that later on when a need arises I guess.
> Or do you think it's just not a good idea in general?

This version supports in-place validation, this example and the one
above showcase how you would implement `Validate` in that case.

You can then call `.vaildate()` on an `&[mut ]Unvalidated<[u8]>` and you
get a `&Data` that borrows from the unvalidated data without copying the
data.

---
Cheers,
Benno

>> +///
>> +///     fn validate(unvalidated: &mut Unvalidated<[u8]>) -> Result<Self=
, Self::Err> {
>> +///         let raw =3D unvalidated.raw_mut();
>> +///         if raw.len() < mem::size_of::<Data>() {
>> +///             return Err(EINVAL);
>> +///         }
>> +///         match raw[0] {
>> +///             0 =3D> {},
>> +///             1 =3D> {
>> +///                 // version 1 implicitly sets the first bit.
>> +///                 raw[1] |=3D 1;
>> +///             },
>> +///             // can only handle version 0 and 1
>> +///             _ =3D> return Err(EINVAL),
>> +///         }
>> +///         // version 0 and 1 only use the lower 4 bits of flags
>> +///         if raw[1] & 0xf0 !=3D 0 {
>> +///             return Err(EINVAL);
>> +///         }
>> +///         if raw[1] =3D=3D 0 {}
>> +///         let ptr =3D raw.as_ptr();
>> +///         // CAST: `Data` only contains integers and has `repr(C)`.
>> +///         let ptr =3D ptr.cast::<Data>();
>> +///         // SAFETY: `ptr` came from a reference and the cast above i=
s valid.
>> +///         Ok(unsafe { &*ptr })
>> +///     }
>> +/// }
>> +/// ```
>> +pub trait Validate<I: ValidateInput>: Sized {
>> +    /// Validation error.
>> +    type Err;
>> +
>> +    /// Validate the given untrusted data and parse it into the output =
type.
>> +    fn validate(unvalidated: I) -> Result<Self, Self::Err>;
>> +}


