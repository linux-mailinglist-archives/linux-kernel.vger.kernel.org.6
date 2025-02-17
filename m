Return-Path: <linux-kernel+bounces-517591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CEFFA382D2
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 13:20:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A3873AC207
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 12:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2038421A42D;
	Mon, 17 Feb 2025 12:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dLKjsTFU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F9DB16C850;
	Mon, 17 Feb 2025 12:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739794842; cv=none; b=LwPq5uQ1j9Ex7/WqRICbwJQy1NdZrLgGRUIM9S2+McI2PElDao37GG9AwmWTHiEH8kWBtgf50gTOKD6smp9Lnu6cJYplB+ruLQm+eVEKzNC0LsgiKH4tQsemxVAYgup/Ty8o4OMOtrElkFLC8jAAeLXFh7lbgzde63p4plvapW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739794842; c=relaxed/simple;
	bh=h1Bfqgxjx8u7FMEXSkKUMTZXl7RfIXTcrb6aOyIOuDU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Rs01B7X1+ct9uih3jFawHI1vaacHtlyHtMkXMGeFdPHwmWl0dIfQEUsNJF0Yml8k/rRiYXGf42qNks4PGDM1eOA5wJWS5szYevS4zRDS4HaRuaIaCHrYwKS3jStUZ75QYtyh8W4dKL3ce3QBRr9sRXbcNFZ617xJziqtffABE7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dLKjsTFU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91395C4CED1;
	Mon, 17 Feb 2025 12:20:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739794841;
	bh=h1Bfqgxjx8u7FMEXSkKUMTZXl7RfIXTcrb6aOyIOuDU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=dLKjsTFUfyhI/mkkghtYMlhuKLjx5MeUCBJmFt5336MHjRMBJticrlB0TM2RoAM0+
	 A+pQ9wFXYiR20Eympr8kVEkLiKpQ2OYsbN639bDV/zZoYOHoofjzj7AZ3VFvzT5L3c
	 qeFt8UhNRFTrOpnVzZaAQhZhMggrQjsqQzhsJz2MDfcQtCVnbpJ9UAGUYfykC2B0ff
	 l4wedaDQ+U/yIUFR3y8TVg4ghHSGwf0l5gSjG4CnyPu6IeoVSwHNuTf7hWdR4nEs2r
	 YosAQpMslq+Ni0FLri5DeTQ4sXE3CL0hfeKoZjCKwQnDj9PQRZbYCQlpdagq/46ozp
	 HMhT8PFM3TSLg==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Benno Lossin" <benno.lossin@proton.me>
Cc: "Danilo Krummrich" <dakr@kernel.org>,  "Miguel Ojeda"
 <ojeda@kernel.org>,  "Alex Gaynor" <alex.gaynor@gmail.com>,  "Boqun Feng"
 <boqun.feng@gmail.com>,  "Gary Guo" <gary@garyguo.net>,  =?utf-8?Q?Bj?=
 =?utf-8?Q?=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,  "Alice Ryhl" <aliceryhl@google.com>,  "Trevor
 Gross" <tmgross@umich.edu>,  "Joel Becker" <jlbec@evilplan.org>,
  "Christoph Hellwig" <hch@lst.de>,  "Peter Zijlstra"
 <peterz@infradead.org>,  "Ingo Molnar" <mingo@redhat.com>,  "Will Deacon"
 <will@kernel.org>,  "Waiman Long" <longman@redhat.com>,  "Fiona Behrens"
 <me@kloenk.dev>,  "Charalampos Mitrodimas" <charmitro@posteo.net>,
  <rust-for-linux@vger.kernel.org>,  <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/3] rust: configfs: introduce rust support for configfs
In-Reply-To: <bfd79db6-bd79-4187-8577-3ae412f36f35@proton.me> (Benno Lossin's
	message of "Mon, 17 Feb 2025 11:40:38 +0000")
References: <20250207-configfs-v2-0-f7a60b24d38e@kernel.org>
	<20250207-configfs-v2-2-f7a60b24d38e@kernel.org>
	<S6DKlLVx4KKevl_q2zrW69Z7oS0jwyX4DXpDZrFiIy1lKo4VYHM52aDiV82c2yf52Ecr7t9FayuqBUPR9onvZA==@protonmail.internalid>
	<dd63fcde-ba4c-4a6e-9bde-1af5af37e91b@proton.me>
 <87h64su8ux.fsf@kernel.org>
	<Kkrr23DbfvS1nChcwAfhrogDdCOO92FQ2-9JUCab-_6CREP4iBX8k1KuxaJb-yv_ErGv9TbzDWwBZHvaszFS7w==@protonmail.internalid>
	<bfd79db6-bd79-4187-8577-3ae412f36f35@proton.me>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Mon, 17 Feb 2025 13:20:19 +0100
Message-ID: <87bjv0u5j0.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

"Benno Lossin" <benno.lossin@proton.me> writes:

> On 17.02.25 12:08, Andreas Hindborg wrote:

[...]

>>>
>>>> +//!
>>>> +//! See the [rust_configfs.rs] sample for a full example use of this =
module.
>>>
>>> It could also be useful to just put the example directly here into the
>>> docs instead of/additionally to having it as a sample.
>>
>> I don't think we should duplicate the code. As long as the link works, I
>> think having it separately is fine.
>
> When I'm coding in my editor and read some docs directly in it, it often
> is annoying to find a link, because then I have to open the docs in my
> web-browser.
> I understand that you don't want to duplicate the code (and it also is a
> bit too much for a short example), so how about having a simpler
> example? Maybe with only a single operation that has no associated data
> (use `()`)?

Sure, we can do that.

>
>>>> +//!
>>>> +//! C header: [`include/linux/configfs.h`](srctree/include/linux/conf=
igfs.h)
>>>> +//!
>>>> +//! [C documentation]: srctree/Documentation/filesystems/configfs.rst
>>>> +//! [rust_configfs.rs]: srctree/samples/rust/rust_configfs.rs
>>>> +
>>>> +use crate::alloc::flags;
>>>> +use crate::container_of;
>>>> +use crate::page::PAGE_SIZE;
>>>> +use crate::prelude::*;
>>>> +use crate::str::CString;
>>>> +use crate::sync::Arc;
>>>> +use crate::types::ForeignOwnable;
>>>> +use crate::types::Opaque;
>>>> +use core::cell::UnsafeCell;
>>>> +use core::marker::PhantomData;
>>>> +use core::ptr::addr_of;
>>>> +use core::ptr::addr_of_mut;
>>>
>>> I usually would import this like so:
>>>
>>>     use crate::{
>>>         alloc::flags,
>>>         container_of,
>>>         page::PAGE_SIZE,
>>>         prelude::*,
>>>         str::CString,
>>>         sync::Arc,
>>>         types::{ForeignOwnable, Opaque},
>>>     };
>>>     use core::{
>>>         cell::UnsafeCell,
>>>         marker::PhantomData,
>>>         ptr::{addr_of, addr_of_mut},
>>>     };
>>>
>>> To me this is more readable.
>>
>> I disagree with that. I don't think what you suggest is easier to read,
>> and it is much more difficult to work with when rebasing and merging
>> things. This was discussed elsewhere in the past without reaching a
>> conclusion. I think we should come to a consensus on what style we
>> should adopt for the imports.
>
> Yeah for rebasing it is annoying... I think we discussed at some point
> of maybe having a script that automatically merges imports, but that
> runs into the issue of keeping all of them, which might not be
> necessary, because the code below doesn't use everything...
> We should discuss this on a more general basis.
>
> To me the merged form is more readable, because I can better see at a
> glance what things are used from where. But maybe that is just due to
> familiarity with it.
>
> Created an issue to track this: https://github.com/Rust-for-Linux/linux/i=
ssues/1143

Cool =F0=9F=91=8D

>
>>>> +
>>>> +/// A `configfs` subsystem.
>>>> +///
>>>> +/// This is the top level entrypoint for a `configfs` hierarchy. To r=
egister
>>>> +/// with configfs, embed a field of this type into your kernel module=
 struct.
>>>> +#[pin_data(PinnedDrop)]
>>>> +pub struct Subsystem<Data> {
>>>
>>> Usually, we don't have multi-character generics, any specific reason
>>> that you chose `Data` here over `T` or `D`?
>>
>> Yes, I find it more descriptive. The patch set went through quite a bit
>> of evolution, and the generics got a bit complicated in earlier
>> iterations, which necessitated more descriptive generic type parameter
>> names. It's not so bad in this version after I restricted the pointer
>> type to just `Arc`, but I still think that using a word rather a single
>> letter makes the code easier to comprehend at first pass.
>
> Makes sense. I'm not opposed to it, but I am a bit cautious, because one
> disadvantage with using multi-character names for generics is that one
> cannot easily see if a type is a generic or not. Maybe that is not as
> important as I think it could be, but to me it seems useful.

If you use an editor with semantic highlighting, you can style the
generic identifiers. I am currently trying out Helix, and that is
unfortunately on of the features it is missing. Can't have it all I
guess.

>
> What do the others think?
>
>> Also, using a word is allowed as per the API guideline document [2]:
>>
>>       > concise UpperCamelCase, usually single uppercase letter: T
>>
>> https://rust-lang.github.io/api-guidelines/naming.html
>>
>>>
>>>> +    #[pin]
>>>> +    subsystem: Opaque<bindings::configfs_subsystem>,
>>>> +    #[pin]
>>>> +    data: Data,
>>>> +}
>>>> +
>>>> +// SAFETY: We do not provide any operations on `Subsystem`.
>>>> +unsafe impl<Data> Sync for Subsystem<Data> {}
>>>> +
>>>> +// SAFETY: Ownership of `Subsystem` can safely be transferred to othe=
r threads.
>>>> +unsafe impl<Data> Send for Subsystem<Data> {}
>>>> +
>>>> +impl<Data> Subsystem<Data> {
>>>> +    /// Create an initializer for a [`Subsystem`].
>>>> +    ///
>>>> +    /// The subsystem will appear in configfs as a directory name giv=
en by
>>>> +    /// `name`. The attributes available in directory are specified by
>>>> +    /// `item_type`.
>>>> +    pub fn new(
>>>> +        name: &'static CStr,
>>>> +        item_type: &'static ItemType<Subsystem<Data>, Data>,
>>>> +        data: impl PinInit<Data, Error>,
>>>> +    ) -> impl PinInit<Self, Error> {
>>>> +        try_pin_init!(Self {
>>>> +            subsystem <- kernel::init::zeroed().chain(
>>>> +                |place: &mut Opaque<bindings::configfs_subsystem>| {
>>>> +                    // SAFETY: All of `place` is valid for write.
>>>> +                    unsafe {
>>>> +                        addr_of_mut!((*place.get()).su_group.cg_item.=
ci_name )
>>>> +                            .write(name.as_ptr().cast_mut().cast())
>>>> +                    };
>>>> +                    // SAFETY: All of `place` is valid for write.
>>>> +                    unsafe {
>>>> +                        addr_of_mut!((*place.get()).su_group.cg_item.=
ci_type)
>>>> +                            .write(item_type.as_ptr())
>>>> +                    };
>>>> +                    // SAFETY: We initialized the required fields of =
`place.group` above.
>>>> +                    unsafe { bindings::config_group_init(&mut (*place=
get()).su_group) };
>>>> +                    // SAFETY: `place.su_mutex` is valid for use as a=
 mutex.
>>>> +                    unsafe { bindings::__mutex_init(
>>>> +                        &mut (*place.get()).su_mutex,
>>>> +                        kernel::optional_name!().as_char_ptr(),
>>>> +                        kernel::static_lock_class!().as_ptr())
>>>
>>> Formatting for this code is weird.
>>>
>>> (since this is inside of the `try_pin_init!` macro, rustfmt doesn't
>>> format it, since `<-` isn't part of rust syntax, so it doesn't know what
>>> to do. I usually fix this by replacing all `<-` with `:`, format and
>>> then change things back)
>>
>> Such is the perils of macros. I'll try to go over it again. Perhaps we
>> could make `rustfmt` understand `<-`?
>
> There have been several discussions about teaching rustfmt custom macro
> rules, but I don't think that such a feature exists.
>
>>> Also, is there no function in C that does all of this initialization for
>>> you?
>>
>> I might be able to do a little better. There is a C function that takes
>> care of initialization of `ci_name` and `ci_type` as well. I can't
>> recall if there was a particular reason for not using it, but I'll
>> check.
>
> Just checking that we don't miss an initialization function, since that
> makes it easier to maintain the code.

Yea, I think I can use the other version that takes name and type.

[...]

>>>> +                unsafe {
>>>> +                    $crate::macros::paste!( [< $data:upper _ATTRS >])
>>>> +                        .add::<N, $attr, _>(
>>>> +                            & $crate::macros::paste!( [< $data:upper =
_ $name:upper _ATTR >])
>>>> +                        )
>>>> +                };
>>>> +            }),
>>>
>>> You can merge the two `paste!` invocations into one:
>>
>> Is that better?
>
> I feel it is. You trade one indentation level for having less characters
> in the body. To me that is worth it, because then I don't have to ignore
> the `$crate::macros::paste!` characters.

I'll give it a shot.

[...]

>>>> +                    // SAFETY: We are expanding `configfs_attrs`.
>>>> +                    static [< $data:upper _ $name:upper _ATTR >]:
>>>> +                      $crate::configfs::Attribute<$attr, $data, $data=
> =3D
>>>> +                        unsafe {
>>>> +                            $crate::configfs::Attribute::new(c_str!(:=
:core::stringify!($name)))
>>>> +                        };
>>>> +                }
>>>> +            )*
>>>> +
>>>> +
>>>> +            const N: usize =3D $cnt + 1usize;
>>>
>>> Why do we need an additional copy? To have a zero entry at the end for C
>>> to know it's the end of the list? If so, a comment here would be very
>>> helpful.
>>
>> Yes, we need space for a null terminator. I'll add a comment.
>>
>> We actually have a static check to make sure that we not missing this.
>
> Where is this static check?

In `Attribute::add`:

        if I >=3D N - 1 {
            kernel::build_error!("Invalid attribute index");
        }



Best regards,
Andreas Hindborg



