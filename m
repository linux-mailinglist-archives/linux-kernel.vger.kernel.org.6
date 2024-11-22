Return-Path: <linux-kernel+bounces-417960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F35B79D5B41
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 09:47:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8377A1F231C1
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 08:47:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 858AD1BD9C9;
	Fri, 22 Nov 2024 08:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qpTdVxqs"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF64F18BBB8
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 08:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732265245; cv=none; b=diq0ydbYHTz6eiM/lFjGXAIpFkIJhqoWp0BVY99yApZHk1d6mHjHjoOprIsO7mSeoIwv7TZ28zSaSqlu0Lv5xP3F0qdLMG3DJUP2fx6VwQwmT6MNgKP3d1JVtZaky6QwYBiJOrXC3EJWj5QO96wvM6NvI81ALvwhSrpaxRlsR/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732265245; c=relaxed/simple;
	bh=G1MWk72mRw+h3WXJVy6ye3Av0MJhoR/tJE+3z6J2JrI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PQZXQWmflJ1Xta84kkWmCA/9D8F3l0xtuWYvyo1v6wTDZyoA2wAF6RW9KReln5pyuVIr6b5Rzlwxw0Do3Pk9VKHiZgPoNZyBnh4x7cY6CqLmGBns6etDS4qhML04Xf6qJjNGS/LQkLHbTCo+MJYuvmFXl7l92lf7BeKUhEN3zbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qpTdVxqs; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2ea68cd5780so1566968a91.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 00:47:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732265243; x=1732870043; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+03aBTnrura1c2YnF2cQX1TsVP1XdwjrS64S7vuMeqI=;
        b=qpTdVxqs2UJNlw7T0qgbuzbp1AQG0fvZeqEvFROr+wkSrkk4MZjEyO13WaC2iRzuck
         vjX4296U8ZeCwFJGeyq8ZnmbpdROPmgDavnQ64AodAculOVI3HdyfFqEm7Zu7JYXE52s
         U5iiZ1F8ctYzvxUCIvo66HoAmfcQCf2XkVhu5MzCL3nHaj11ycQXZ/3fMbIOvYpjIicH
         3u5loeQ+USRFQevKNDVKtYRHmeacRanRi1RHPw811/ue7qwfwJe+b2UQtJHk8LAHsF+M
         da4mUoBYyhu/mV18hTJUyfob8Lc0m4kowXcMxl2cycMoDLqfw/LP5mBeBElQf1FzCMCG
         q7uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732265243; x=1732870043;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+03aBTnrura1c2YnF2cQX1TsVP1XdwjrS64S7vuMeqI=;
        b=YcEATAq1yORVlqkKMH6l6XCgys93vYWl47X9KfxZkMb3XHvVtb7FE4v75NlW1ic3pI
         z/pmtTGjuwBAtTvX6VnrrrdiBJL8PMXuS2BkM6v1cMlnmWXjS92yVfXKgXP04M9hBuNk
         MJGt7saXmHkLzOn2JvxadcbLIyIBjHHqO/xEtGGjPZ01c489KHmfivHZHxDlc+/LyYlG
         0/5fsgzhuoyjr2xxZZ/fqoWdrBDSVCKxPET9rTOp5wkixA6BPzmSVj0dgMPOUJoadY2K
         N5P1L3ydbsBCQdGittejxWUZNSLoPQNT60heTm4i2rzNmkl1+LJX90rSAFpQrvY64oAn
         +LLw==
X-Forwarded-Encrypted: i=1; AJvYcCWhwT6GNA270/SFcjv2V9Pk5GrAwxaBqzMtCb4L+7qfyj0zSsXSv9tzgEFR5yzprFyM2hNEwsZcrYHe2xA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRHSneU/zVOntEoR/hpYA+DcPTkdpSbUJA36SO4E0HkidHt+55
	wNYBn1aOArJf6AnmpO517ZZfWx9SxB6w43u46U6sWQcGcDnppsH+N7LHo2d0DSbG/kxYjiFv8p9
	RMGBFxWsshqhhuXvcG5fyptLVbnmyitTltbds
X-Gm-Gg: ASbGncub93MIYx67Eg3Lh0kyUlN1tAs8qthj9GIuAi/BC9FU3wxEin5SDxpAdMxcNNV
	fFNY9UZSQaz4tfiOJeKkK8fUX+YmCZBe5
X-Google-Smtp-Source: AGHT+IGpEJspEE1OibnEPSpHi4iqebk7O0m+JrAMMgFjlCrzoCa6aFob7IDclcbw3xcJu4gwEKGLXO3fgzsFKqhmXHo=
X-Received: by 2002:a17:90b:33c5:b0:2ea:b2a5:932b with SMTP id
 98e67ed59e1d1-2eb0e5284c5mr2598825a91.17.1732265242815; Fri, 22 Nov 2024
 00:47:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241122081257.1776925-1-dirk.behme@de.bosch.com>
In-Reply-To: <20241122081257.1776925-1-dirk.behme@de.bosch.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Fri, 22 Nov 2024 09:47:09 +0100
Message-ID: <CAH5fLghrgnr_ok5deSAi0JnbWFoWG-4de2K_Hg8qHytyEp_y7w@mail.gmail.com>
Subject: Re: [PATCH RFC v2 1/1] rust: Add bindings for device properties
To: Dirk Behme <dirk.behme@de.bosch.com>
Cc: Saravana Kannan <saravanak@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Rob Herring <robh@kernel.org>, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 22, 2024 at 9:13=E2=80=AFAM Dirk Behme <dirk.behme@de.bosch.com=
> wrote:
>
> From: "Rob Herring (Arm)" <robh@kernel.org>
>
> The device property API is a firmware agnostic API for reading
> properties from firmware (DT/ACPI) devices nodes and swnodes.
>
> While the C API takes a pointer to a caller allocated variable/buffer,

nit: "caller-allocated" or "to a variable/buffer allocated by the caller"

> the rust API is designed to return a value and can be used in struct
> initialization. Rust generics are also utilized to support different
> sizes of properties (e.g. u8, u16, u32).
>
> To build and run the Examples as `rustdoc` tests the kernel Kconfig
> options `CONFIG_OF` and `CONFIG_OF_UNITTEST` need to be enabled
> additionally. Besides the default `rustdoc` test options
> `CONFIG_KUNIT` and `CONFIG_RUST_KERNEL_DOCTESTS`. This even works
> on non-ARM architectures as a test device tree is built into the
> kernel, then.
>
> The Integer trait is proposed by Alic Ryhl [1].

typo ;)

>
> Link: https://lore.kernel.org/rust-for-linux/CAH5fLgiXPZqKpWSSNdx-Ww-E9h2=
tOLcF3_8Y4C_JQ0eU8EMwFw@mail.gmail.com/ [1]
> Co-developed-by: Dirk Behme <dirk.behme@de.bosch.com>
> Signed-off-by: Dirk Behme <dirk.behme@de.bosch.com>
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>
> This is an update of Rob's initial patch
>
> https://lore.kernel.org/rust-for-linux/20241025-rust-platform-dev-v1-0-0d=
f8dcf7c20b@kernel.org/
>
> condensed in one patch (see below). Rob's initial cover
> letter still stands, esp. the part regarding the dependency
> on Danilo's PCI and platform device series [2].
>
> Changes in v2:
>
> * Move the major parts to property.rs
> * Use the Integer Trait proposed by Alice
> * Use MaybeUninit proposed by Alex
> * Use Option<> to distinguish between optional and mandatory properties
>   proposed by Rob
> * Introduce a FwProperty trait. The prefix 'Fw' reads as 'Firmware'.
>   Just 'Property' seems to be conflicting with existing.
> * Add some rustdoc documentation and Examples (based on Danilo's
>   platform sample module). With that I squashed the test device tree
>   changes into this patch as we don't need to change Danilo's platform
>   sample any more. That change is trivial. Please let me know if you
>   rather like a separate patch for it.
> * Some more I most probably missed to mention ;)
>
> It would be nice to get some improvement hints for the FIXMEs :)

See below :)

> Trying to use the assert_eq!() fails with
>
> error[E0425]: cannot find value `__DOCTEST_ANCHOR` in this scope
>     --> rust/doctests_kernel_generated.rs:4252:102
>      |
> 4252 |             kernel::kunit_assert_eq!("rust_doctest_kernel_property=
_rs_0", "rust/kernel/property.rs", __DOCTEST_ANCHOR - 150, $left, $right);
>      |                                                                   =
                                   ^^^^^^^^^^^^^^^^ not found in this scope
> ...
> 4369 | assert_eq!(idx, Ok(0)); // FIXME: How to build this?
>      | ---------------------- in this macro invocation
>      |
>      =3D note: this error originates in the macro `assert_eq` (in Nightly=
 builds, run with -Z macro-backtrace for more info)
>
>   CC      drivers/base/firmware_loader/main.o
>   CC      kernel/module/main.o
> error: aborting due to 1 previous error
>
> [2] https://lore.kernel.org/all/20241022213221.2383-1-dakr@kernel.org/

I don't know about this one.

> +/// A trait for integer types.
> +///
> +/// This trait limits [`FromBytes`] and [`AsBytes`] to integer types onl=
y. Excluding the
> +/// array types. The integer types are `u8`, `u16`, `u32`, `u64`, `usize=
`, `i8`, `i16`,
> +/// `i32`, `i64` and `isize`. Additionally, the size of these types is e=
ncoded in the
> +/// `IntSize` enum.
> +trait Integer: FromBytes + AsBytes + Copy {
> +    /// The size of the integer type.
> +    const SIZE: IntSize;
> +}

This trait should be unsafe with a safety requirement saying that SIZE
must be correct.

Is it intentional that Integer is a private trait? I guess you're
using it as an implementation detail of FwProperty? It would be nice
to mention that 128-bit ints are intentionally not included here.

> +/// The sizes of the integer types. Either 8, 16, 32 or 64 bits.
> +enum IntSize {
> +    /// 8 bits
> +    S8,
> +    /// 16 bits
> +    S16,
> +    /// 32 bits
> +    S32,
> +    /// 64 bits
> +    S64,
> +}
> +
> +macro_rules! impl_int {
> +    ($($typ:ty),* $(,)?) =3D> {$(
> +        impl Integer for $typ {
> +            const SIZE: IntSize =3D match size_of::<Self>() {
> +                1 =3D> IntSize::S8,
> +                2 =3D> IntSize::S16,
> +                4 =3D> IntSize::S32,
> +                8 =3D> IntSize::S64,
> +                _ =3D> panic!("invalid size"),
> +            };
> +        }
> +    )*};
> +}
> +
> +impl_int! {
> +    u8, u16, u32, u64, usize,
> +    i8, i16, i32, i64, isize,
> +}
> +
> +/// Reads an array of integers from the device firmware.
> +fn read_array<T: Integer>(
> +    device: &Device,
> +    name: &CStr,
> +    val: Option<&mut [MaybeUninit<T>]>,
> +) -> Result<usize> {
> +    let (ptr, len) =3D match val {
> +        // The read array data case.
> +        Some(val) =3D> (val.as_mut_ptr(), val.len()),
> +        // The read count case.
> +        None =3D> (core::ptr::null_mut(), 0_usize),
> +    };
> +    let ret =3D match T::SIZE {
> +        // SAFETY: `device_property_read_u8_array` is called with a vali=
d device pointer and name.
> +        IntSize::S8 =3D> unsafe {
> +            bindings::device_property_read_u8_array(
> +                device.as_raw(),
> +                name.as_ptr() as *const i8,
> +                ptr as *mut u8,
> +                len,

Instead of using the i8 type for the name, you should be using
crate::ffi::c_char. Actually, in this case, you can also use
`name.as_char_ptr()` instead, which requires no cast.

> +        },
> +        // SAFETY: `device_property_read_u16_array` is called with a val=
id device pointer and name.
> +        IntSize::S16 =3D> unsafe {
> +            bindings::device_property_read_u16_array(
> +                device.as_raw(),
> +                name.as_ptr() as *const i8,
> +                ptr as *mut u16,
> +                len,
> +            )
> +        },
> +        // SAFETY: `device_property_read_u32_array` is called with a val=
id device pointer and name.
> +        IntSize::S32 =3D> unsafe {
> +            bindings::device_property_read_u32_array(
> +                device.as_raw(),
> +                name.as_ptr() as *const i8,
> +                ptr as *mut u32,
> +                len,
> +            )
> +        },
> +        // SAFETY: `device_property_read_u64_array` is called with a val=
id device pointer and name.
> +        IntSize::S64 =3D> unsafe {
> +            bindings::device_property_read_u64_array(
> +                device.as_raw(),
> +                name.as_ptr() as *const i8,
> +                ptr as *mut u64,
> +                len,
> +            )
> +        },
> +    };
> +    to_result(ret)?;
> +    Ok(ret.try_into()?)
> +}

[...]

> +/// *Note*: To build and run below examples as `rustdoc` tests the addit=
ional kernel
> +/// Kconfig options `CONFIG_OF` and `CONFIG_OF_UNITTEST` need to be enab=
led. This
> +/// even works on non-ARM architectures as a test device tree is built i=
nto the
> +/// kernel, then.

Incomplete sentence?

Does this mean that running kunit without those options enabled
results in an error?

> +/// The above examples intentionally don't print any error messages (e.g=
. with `dev_err!()`).
> +/// The called abstractions already print error messages if needed what =
is considered to be
> +/// sufficient. The goal is to be less verbose regarding error messages.

typo: "if needed, which is"

> +pub trait FwProperty: Sized {
> +    /// Reads a property from the device.
> +    fn read_property(device: &Device, name: &CStr, default: Option<Self>=
) -> Result<Self>;
> +
> +    /// Gets the properties element count.
> +    fn count_elem(device: &Device, name: &CStr) -> Result<usize>;
> +
> +    /// Returns if a firmware string property `name` has match for `matc=
h_str`.
> +    fn match_string(device: &Device, name: &CStr, match_str: &CStr) -> R=
esult<usize> {

As far as I can tell, you never override this implementation anywhere.
In that case, it shouldn't be a trait method. You can just put its
implementation directly in property_match_string.

> +        // SAFETY: `device_property_match_string` is called with a valid=
 device pointer and name.
> +        let ret =3D unsafe {
> +            bindings::device_property_match_string(
> +                device.as_raw(),
> +                name.as_ptr() as *const i8,
> +                match_str.as_ptr() as *const i8,
> +            )

Ditto here about i8.

> +    /// Gets the properties element count.
> +    // FIXME: Could this be made to be a build time error?
> +    fn count_elem(device: &Device, _name: &CStr) -> Result<usize> {

Yes, you should create two traits:

pub trait FwPropertyRead: Sized {
    fn read_property(device: &Device, name: &CStr, default:
Option<Self>) -> Result<Self>;
}

pub trait FwPropertyCount: Sized {
    fn count_elem(device: &Device, name: &CStr) -> Result<usize>;
}

Then don't implement FwPropertyCount for types that can't be counted.

I wonder if it also makes more sense to split FwPropertyRead into two trait=
s:
FwPropertyReadMandatory
FwPropertyReadOptional
to handle the boolean case?

> +impl<T: Integer + Copy> FwProperty for T {
> +    fn read_property(device: &Device, name: &CStr, default: Option<Self>=
) -> Result<Self> {
> +        let mut val: [MaybeUninit<T>; 1] =3D [const { MaybeUninit::unini=
t() }; 1];
> +        match read_array(device, name, Some(&mut val)) {
> +            // SAFETY: `read_array` returns with valid data
> +            Ok(_) =3D> Ok(unsafe { mem::transmute_copy(&val[0]) }),

This can be simplified:

fn read_property(device: &Device, name: &CStr, default: Option<Self>)
-> Result<Self> {
    let mut val: MaybeUninit<T> =3D MaybeUninit::uninit();
    match read_array(device, name, Some(core::array::from_mut(&mut val))) {
        // SAFETY: `read_array` returns with valid data
        Ok(()) =3D> Ok(val.assume_init()),

> +impl<T: Integer, const N: usize> FwProperty for [T; N] {
> +    fn read_property(device: &Device, name: &CStr, default: Option<Self>=
) -> Result<Self> {
> +        let mut val: [MaybeUninit<T>; N] =3D [const { MaybeUninit::unini=
t() }; N];
> +        match read_array(device, name, Some(&mut val)) {
> +            // SAFETY: `read_array` returns with valid data
> +            Ok(_) =3D> Ok(unsafe { mem::transmute_copy(&val) }),

I don't think this one can avoid transmute_copy, though.

Alice

