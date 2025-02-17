Return-Path: <linux-kernel+bounces-517532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 127E2A38218
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 12:43:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 192DC3A938E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 11:41:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98934218E8C;
	Mon, 17 Feb 2025 11:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="UpR15C+Q"
Received: from mail-10630.protonmail.ch (mail-10630.protonmail.ch [79.135.106.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 640E1218EB3
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 11:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739792450; cv=none; b=peTK0pKzRFfkEOPcoerBAAkheWI+29/RwPuNnB2+qcy2uu74d9XroUL6jrODqxuBbTpc2Uy/31lAR/UKBctXY8iFQNeuNmIPRB8ntbrAlnWedVGTw/G9EP54qxGA6I5WusqBpcKZnXlQBML6VajHArrcl/kFXY5a4yRyTrg1WUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739792450; c=relaxed/simple;
	bh=s1sFg0BpR/upBln1tAfZRAdV/ch/zLdux7JqlnHJ/uU=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QBCO/cwVEgvo/104Ro/leW31Mj33wegE7hVQWJl3xD5rvYUmVyQnqQjJR8qDXONmeBml7AyvTwqTh/+3ibe7r5Nku35qlxAhXRmu30VkvkqiXqLUAmjvItNEgXXvUm5Ejm6oxQMrM9DsPwFWER3WBjxGRJOXV32KpIR6ld7z8yA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=UpR15C+Q; arc=none smtp.client-ip=79.135.106.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1739792444; x=1740051644;
	bh=M6KBsb2eg3QP3nF7FnogUheeCJ2l8VAyS2xMRSPK0rc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=UpR15C+QjzK63cnAXRilJ5mTYGuGa6I9u43ZdhfX968x4UHH+MLL/8MjHXhpn2MUh
	 mwFN69awIWT6eW5zdTmfOVj4i7vXz4piz/oKJR4lRdATWZcANC94SjA05Vl1fs2Ast
	 LocbooUknO+JLo1g/AFqwJ1B1kIO7plPz6ZLLH/B+aYMvrfuDbUFtMpZRELawtKGnp
	 F/3uQISjlM9EgNFQWgLFwUg6e9Rn/DbyO2xQTQQsPa+LBmP3z4mczypGfGaEnYnTUv
	 KytOZjdj9v97W8WsBntI/LXxczYcLLxNyKM8JZVReFyB9/VTY3HZC0+aWpNQn/qdk5
	 PPSvyF27aorXA==
Date: Mon, 17 Feb 2025 11:40:38 +0000
To: Andreas Hindborg <a.hindborg@kernel.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Joel Becker <jlbec@evilplan.org>, Christoph Hellwig <hch@lst.de>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, Fiona Behrens <me@kloenk.dev>, Charalampos Mitrodimas <charmitro@posteo.net>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] rust: configfs: introduce rust support for configfs
Message-ID: <bfd79db6-bd79-4187-8577-3ae412f36f35@proton.me>
In-Reply-To: <87h64su8ux.fsf@kernel.org>
References: <20250207-configfs-v2-0-f7a60b24d38e@kernel.org> <20250207-configfs-v2-2-f7a60b24d38e@kernel.org> <S6DKlLVx4KKevl_q2zrW69Z7oS0jwyX4DXpDZrFiIy1lKo4VYHM52aDiV82c2yf52Ecr7t9FayuqBUPR9onvZA==@protonmail.internalid> <dd63fcde-ba4c-4a6e-9bde-1af5af37e91b@proton.me> <87h64su8ux.fsf@kernel.org>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 5f7e35791225fe74aa10f3c5a6d1d7d5f243c601
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 17.02.25 12:08, Andreas Hindborg wrote:
> "Benno Lossin" <benno.lossin@proton.me> writes:
>> On 07.02.25 15:41, Andreas Hindborg wrote:
>>> diff --git a/rust/kernel/configfs.rs b/rust/kernel/configfs.rs
>>> new file mode 100644
>>> index 0000000000000..9d4b381b9df89
>>> --- /dev/null
>>> +++ b/rust/kernel/configfs.rs
>>> @@ -0,0 +1,860 @@
>>> +// SPDX-License-Identifier: GPL-2.0
>>> +
>>> +//! `configfs` interface.
>>> +//!
>>> +//! `configfs` is an in-memory pseudo file system for configuration of=
 kernel
>>> +//! modules. Please see the [C documentation] for details and intended=
 use of
>>> +//! `configfs`.
>>> +//!
>>> +//! This module does not support the following `configfs` features:
>>> +//!
>>> +//! - Items. All group children are groups.
>>> +//! - Symlink support.
>>> +//! - `disconnect_notify` hook.
>>> +//! - Default groups.
>>
>> For lists like this, I usually end items except the last one with a
>> comma instead of a period.
>=20
> If that is the right way to do it, sure. It is actually funny that you
> notice, because I searched for input on how to typeset such a list, and
> some Microsoft typesetting site told me to do it like this when some
> items are sentences [1]. I am not a native English speaker, and I have
> no idea what the correct formatting is. Commas are not mentioned at the
> resource I found.

Since I'm also not a native speaker (and I don't really remember the
rules from school by name, but rather by heart and intuition only), I
don't really know. It just looked a bit strange to me (intuition
speaking) and so I commented on it. I don't really mind one way or the
other.

> [1] https://www.microsoft.com/en-us/microsoft-365-life-hacks/writing/punc=
tuating-bullet-point-lists
>=20
>>
>>> +//!
>>> +//! See the [rust_configfs.rs] sample for a full example use of this m=
odule.
>>
>> It could also be useful to just put the example directly here into the
>> docs instead of/additionally to having it as a sample.
>=20
> I don't think we should duplicate the code. As long as the link works, I
> think having it separately is fine.

When I'm coding in my editor and read some docs directly in it, it often
is annoying to find a link, because then I have to open the docs in my
web-browser.
I understand that you don't want to duplicate the code (and it also is a
bit too much for a short example), so how about having a simpler
example? Maybe with only a single operation that has no associated data
(use `()`)?

>>> +//!
>>> +//! C header: [`include/linux/configfs.h`](srctree/include/linux/confi=
gfs.h)
>>> +//!
>>> +//! [C documentation]: srctree/Documentation/filesystems/configfs.rst
>>> +//! [rust_configfs.rs]: srctree/samples/rust/rust_configfs.rs
>>> +
>>> +use crate::alloc::flags;
>>> +use crate::container_of;
>>> +use crate::page::PAGE_SIZE;
>>> +use crate::prelude::*;
>>> +use crate::str::CString;
>>> +use crate::sync::Arc;
>>> +use crate::types::ForeignOwnable;
>>> +use crate::types::Opaque;
>>> +use core::cell::UnsafeCell;
>>> +use core::marker::PhantomData;
>>> +use core::ptr::addr_of;
>>> +use core::ptr::addr_of_mut;
>>
>> I usually would import this like so:
>>
>>     use crate::{
>>         alloc::flags,
>>         container_of,
>>         page::PAGE_SIZE,
>>         prelude::*,
>>         str::CString,
>>         sync::Arc,
>>         types::{ForeignOwnable, Opaque},
>>     };
>>     use core::{
>>         cell::UnsafeCell,
>>         marker::PhantomData,
>>         ptr::{addr_of, addr_of_mut},
>>     };
>>
>> To me this is more readable.
>=20
> I disagree with that. I don't think what you suggest is easier to read,
> and it is much more difficult to work with when rebasing and merging
> things. This was discussed elsewhere in the past without reaching a
> conclusion. I think we should come to a consensus on what style we
> should adopt for the imports.

Yeah for rebasing it is annoying... I think we discussed at some point
of maybe having a script that automatically merges imports, but that
runs into the issue of keeping all of them, which might not be
necessary, because the code below doesn't use everything...
We should discuss this on a more general basis.=20

To me the merged form is more readable, because I can better see at a
glance what things are used from where. But maybe that is just due to
familiarity with it.

Created an issue to track this: https://github.com/Rust-for-Linux/linux/iss=
ues/1143

>>> +
>>> +/// A `configfs` subsystem.
>>> +///
>>> +/// This is the top level entrypoint for a `configfs` hierarchy. To re=
gister
>>> +/// with configfs, embed a field of this type into your kernel module =
struct.
>>> +#[pin_data(PinnedDrop)]
>>> +pub struct Subsystem<Data> {
>>
>> Usually, we don't have multi-character generics, any specific reason
>> that you chose `Data` here over `T` or `D`?
>=20
> Yes, I find it more descriptive. The patch set went through quite a bit
> of evolution, and the generics got a bit complicated in earlier
> iterations, which necessitated more descriptive generic type parameter
> names. It's not so bad in this version after I restricted the pointer
> type to just `Arc`, but I still think that using a word rather a single
> letter makes the code easier to comprehend at first pass.

Makes sense. I'm not opposed to it, but I am a bit cautious, because one
disadvantage with using multi-character names for generics is that one
cannot easily see if a type is a generic or not. Maybe that is not as
important as I think it could be, but to me it seems useful.

What do the others think?

> Also, using a word is allowed as per the API guideline document [2]:
>=20
>       > concise UpperCamelCase, usually single uppercase letter: T
>=20
> https://rust-lang.github.io/api-guidelines/naming.html
>=20
>>
>>> +    #[pin]
>>> +    subsystem: Opaque<bindings::configfs_subsystem>,
>>> +    #[pin]
>>> +    data: Data,
>>> +}
>>> +
>>> +// SAFETY: We do not provide any operations on `Subsystem`.
>>> +unsafe impl<Data> Sync for Subsystem<Data> {}
>>> +
>>> +// SAFETY: Ownership of `Subsystem` can safely be transferred to other=
 threads.
>>> +unsafe impl<Data> Send for Subsystem<Data> {}
>>> +
>>> +impl<Data> Subsystem<Data> {
>>> +    /// Create an initializer for a [`Subsystem`].
>>> +    ///
>>> +    /// The subsystem will appear in configfs as a directory name give=
n by
>>> +    /// `name`. The attributes available in directory are specified by
>>> +    /// `item_type`.
>>> +    pub fn new(
>>> +        name: &'static CStr,
>>> +        item_type: &'static ItemType<Subsystem<Data>, Data>,
>>> +        data: impl PinInit<Data, Error>,
>>> +    ) -> impl PinInit<Self, Error> {
>>> +        try_pin_init!(Self {
>>> +            subsystem <- kernel::init::zeroed().chain(
>>> +                |place: &mut Opaque<bindings::configfs_subsystem>| {
>>> +                    // SAFETY: All of `place` is valid for write.
>>> +                    unsafe {
>>> +                        addr_of_mut!((*place.get()).su_group.cg_item.c=
i_name )
>>> +                            .write(name.as_ptr().cast_mut().cast())
>>> +                    };
>>> +                    // SAFETY: All of `place` is valid for write.
>>> +                    unsafe {
>>> +                        addr_of_mut!((*place.get()).su_group.cg_item.c=
i_type)
>>> +                            .write(item_type.as_ptr())
>>> +                    };
>>> +                    // SAFETY: We initialized the required fields of `=
place.group` above.
>>> +                    unsafe { bindings::config_group_init(&mut (*place.=
get()).su_group) };
>>> +                    // SAFETY: `place.su_mutex` is valid for use as a =
mutex.
>>> +                    unsafe { bindings::__mutex_init(
>>> +                        &mut (*place.get()).su_mutex,
>>> +                        kernel::optional_name!().as_char_ptr(),
>>> +                        kernel::static_lock_class!().as_ptr())
>>
>> Formatting for this code is weird.
>>
>> (since this is inside of the `try_pin_init!` macro, rustfmt doesn't
>> format it, since `<-` isn't part of rust syntax, so it doesn't know what
>> to do. I usually fix this by replacing all `<-` with `:`, format and
>> then change things back)
>=20
> Such is the perils of macros. I'll try to go over it again. Perhaps we
> could make `rustfmt` understand `<-`?

There have been several discussions about teaching rustfmt custom macro
rules, but I don't think that such a feature exists.

>> Also, is there no function in C that does all of this initialization for
>> you?
>=20
> I might be able to do a little better. There is a C function that takes
> care of initialization of `ci_name` and `ci_type` as well. I can't
> recall if there was a particular reason for not using it, but I'll
> check.

Just checking that we don't miss an initialization function, since that
makes it easier to maintain the code.

> We have to initialize the mutex explicitly. I think the reason for not
> doing that implicitly C side is to allow it to be statically
> initialized.

I see.

>>> +    ///
>>> +    /// Implementations can use this method to do house keeping before
>>> +    /// `configfs` drops its reference to `Child`.
>>> +    fn drop_item(
>>
>> `drop` doesn't really fit here, I think something like `unlink_item`
>> fits better, since the child isn't actually dropped after this function
>> returns.
>=20
> Yea, I know. But the function is called `drop_item` on the C side of
> things. Usually we keep the C names.

Makes sense.

>>> +impl_item_type!(Subsystem<Data>);
>>> +impl_item_type!(Group<Data>);
>>> +
>>> +impl<Container, Data> ItemType<Container, Data> {
>>> +    fn as_ptr(&self) -> *const bindings::config_item_type {
>>> +        self.item_type.get()
>>> +    }
>>> +}
>>> +
>>> +/// Define a list of configfs attributes statically.
>>> +#[macro_export]
>>> +macro_rules! configfs_attrs {
>>
>> I see you've joined the dark side of declarative macros!
>>
>> This seems like a prime candidate for replacing with a proc-macro when
>> we have syn :)
>=20
> Yes, I found myself wishing for `syn` very much while writing this.

Now you know my pain :) :) :)

>>> +    (
>>> +        container: $container:ty,
>>> +        data: $data:ty,
>>> +        attributes: [
>>> +            $($name:ident: $attr:literal,)*
>>
>> This syntax always requires a trailing comma. Most (IIRC all, but not
>> 100% sure) Rust syntax allows you to omit it, so it would be odd if it
>> were not the case here. You can have an optional trailing comma via:
>>
>>     $($name:ident: $attr:literal),* $(,)?
>>
>> But as soon as you give the tokens off to the internals of the macro, I
>> would recommend sticking to always having a trailing comma or no
>> trailing comma.
>=20
> Makes sense, I will fix that. Perhaps after the array square brackets as =
well.

Yeah that too.

>>> +        ],
>>> +    ) =3D> {
>>> +        $crate::configfs_attrs!(
>>> +            count:
>>> +            @container($container),
>>> +            @data($data),
>>> +            @child(),
>>> +            @no_child(x),
>>> +            @attrs($($name $attr)*),
>>> +            @eat($($name $attr,)*),
>>> +            @assign(),
>>> +            @cnt(0usize),
>>> +        )
>>> +    };
>>> +    (
>>> +        container: $container:ty,
>>> +        data: $data:ty,
>>> +        child: $child:ty,
>>> +        attributes: [
>>> +            $($name:ident: $attr:literal,)*
>>
>> Ditto.
>>
>>> +        ],
>>> +    ) =3D> {
>>> +        $crate::configfs_attrs!(
>>> +            count:
>>> +            @container($container),
>>> +            @data($data),
>>> +            @child($child),
>>> +            @no_child(),
>>> +            @attrs($($name $attr)*),
>>> +            @eat($($name $attr,)*),
>>> +            @assign(),
>>> +            @cnt(0usize),
>>> +        )
>>> +    };
>>> +    (count:
>>> +     @container($container:ty),
>>> +     @data($data:ty),
>>> +     @child($($child:ty)?),
>>> +     @no_child($($no_child:ident)?),
>>> +     @attrs($($aname:ident $aattr:literal)*),
>>> +     @eat($name:ident $attr:literal, $($rname:ident $rattr:literal,)*)=
,
>>> +     @assign($($assign:block)*),
>>> +     @cnt($cnt:expr),
>>> +    ) =3D> {
>>> +        $crate::configfs_attrs!(
>>> +            count:
>>> +            @container($container),
>>> +            @data($data),
>>> +            @child($($child)?),
>>> +            @no_child($($no_child)?),
>>> +            @attrs($($aname $aattr)*),
>>> +            @eat($($rname $rattr,)*),
>>> +            @assign($($assign)* {
>>> +                const N: usize =3D $cnt;
>>> +                // SAFETY: We are expanding `configfs_attrs`.
>>
>> This safety comment is doing a lot of heavy lifting, since it is not at
>> all obvious what the below unsafe function will resolve to... Seems also
>> a hassle to put a full comment here explaining that
>> `[< $data:upper _ATTRS >]` is defined by the macro below and that it is
>> of type `AttributeList` etc... But maybe we should.
>=20
> I mean, I can put a comment saying that this will expand to a call to `At=
tribute::add`?

Yeah that would be good.

>>> +                unsafe {
>>> +                    $crate::macros::paste!( [< $data:upper _ATTRS >])
>>> +                        .add::<N, $attr, _>(
>>> +                            & $crate::macros::paste!( [< $data:upper _=
 $name:upper _ATTR >])
>>> +                        )
>>> +                };
>>> +            }),
>>
>> You can merge the two `paste!` invocations into one:
>=20
> Is that better?

I feel it is. You trade one indentation level for having less characters
in the body. To me that is worth it, because then I don't have to ignore
the `$crate::macros::paste!` characters.

>=20
>>
>>     @assign($($assign)* {
>>         const N: usize =3D $cnt;
>>         $crate::macros::paste! {
>>             // SAFETY: see above comment
>>             unsafe {
>>                 [< $data:upper _ATTRS >].add::<N, $attr, _>(
>>                     &[< $data:upper _ $name:upper _ATTR >]
>>                 );
>>             }
>>         }
>>     }),
>>
>>> +            @cnt(1usize + $cnt),
>>> +        )
>>> +    };
>>> +    (count:
>>> +     @container($container:ty),
>>> +     @data($data:ty),
>>> +     @child($($child:ty)?),
>>> +     @no_child($($no_child:ident)?),
>>> +     @attrs($($aname:ident $aattr:literal)*),
>>> +     @eat(),
>>> +     @assign($($assign:block)*),
>>> +     @cnt($cnt:expr),
>>> +    ) =3D>
>>> +    {
>>> +        $crate::configfs_attrs!(
>>> +            final:
>>> +            @container($container),
>>> +            @data($data),
>>> +            @child($($child)?),
>>> +            @no_child($($no_child)?),
>>> +            @attrs($($aname $aattr)*),
>>> +            @assign($($assign)*),
>>> +            @cnt($cnt),
>>> +        )
>>> +    };
>>> +    (final:
>>> +     @container($container:ty),
>>> +     @data($data:ty),
>>> +     @child($($child:ty)?),
>>> +     @no_child($($no_child:ident)?),
>>> +     @attrs($($name:ident $attr:literal)*),
>>> +     @assign($($assign:block)*),
>>> +     @cnt($cnt:expr),
>>> +    ) =3D>
>>> +    {
>>> +        {
>>> +            $(
>>> +                $crate::macros::paste!{
>>
>> Again you can coalesce all of the `paste!` invocations into a single one
>> spanning the entire output of this macro branch.
>=20
> Is that better? I actually tried to keep them smaller.

Yeah I think so (see above).

>>> +                    // SAFETY: We are expanding `configfs_attrs`.
>>> +                    static [< $data:upper _ $name:upper _ATTR >]:
>>> +                      $crate::configfs::Attribute<$attr, $data, $data>=
 =3D
>>> +                        unsafe {
>>> +                            $crate::configfs::Attribute::new(c_str!(::=
core::stringify!($name)))
>>> +                        };
>>> +                }
>>> +            )*
>>> +
>>> +
>>> +            const N: usize =3D $cnt + 1usize;
>>
>> Why do we need an additional copy? To have a zero entry at the end for C
>> to know it's the end of the list? If so, a comment here would be very
>> helpful.
>=20
> Yes, we need space for a null terminator. I'll add a comment.
>=20
> We actually have a static check to make sure that we not missing this.

Where is this static check?

>>> +            $crate::macros::paste!{
>>> +                // SAFETY: We are expanding `configfs_attrs`.
>>> +                static [< $data:upper _ATTRS >]:
>>> +                  $crate::configfs::AttributeList<N, $data> =3D
>>> +                    unsafe { $crate::configfs::AttributeList::new() };
>>> +            }
>>> +
>>> +            $($assign)*
>>> +
>>> +            $(
>>> +                $crate::macros::paste!{
>>> +                    const [<$no_child:upper>]: bool =3D true;
>>> +                };
>>> +
>>> +                $crate::macros::paste!{
>>> +                    static [< $data:upper _TPE >] : $crate::configfs::=
ItemType<$container, $data>  =3D
>>> +                        $crate::configfs::ItemType::<$container, $data=
>::new::<N>(
>>> +                            &THIS_MODULE, &[<$ data:upper _ATTRS >]
>>> +                        );
>>> +                }
>>> +            )?
>>> +
>>> +            $(
>>> +                $crate::macros::paste!{
>>> +                    static [< $data:upper _TPE >]:
>>> +                      $crate::configfs::ItemType<$container, $data>  =
=3D
>>> +                        $crate::configfs::ItemType::<$container, $data=
>::new_with_child_ctor::
>>> +                    <N, $child>(
>>> +                        &THIS_MODULE, &[<$ data:upper _ATTRS >]
>>> +                    );
>>> +                }
>>> +            )?
>>> +
>>> +            &$crate::macros::paste!( [< $data:upper _TPE >] )
>>> +        }
>>> +    };
>>> +
>>> +}
>>
>> I tested if multiple invocations of this macro can shadow each other and
>> the answer is no. So wrapping a const with `{}` makes it inaccessible to
>> the outside which is exactly what we need here.
>> The macro looks quite good!
>=20
> Well you can guess where the inspiration came from :)

Glad that that was helpful to you :)

---
Cheers,
Benno


