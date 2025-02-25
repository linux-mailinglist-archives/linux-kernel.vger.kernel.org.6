Return-Path: <linux-kernel+bounces-531349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87768A43F69
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 13:30:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8A7D3B9B92
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 12:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3198064D;
	Tue, 25 Feb 2025 12:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T9iu7xTb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52894267F58;
	Tue, 25 Feb 2025 12:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740486609; cv=none; b=eD8E1GmF1/0R5EnlOdA0R7BGf+iK/EZ2wljGYLipxw+VqU+xsfjkhQbKqOTZ7GbxewpKX+pUBDr2We70am3G6UFYf783+vYZA+fME61faEtTNPWdIHZVjDlSFYd8SWY3BrrjdRIbwrmLZ6Wii8F2hhpTWAQGlIyQ1x/sm/TWVbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740486609; c=relaxed/simple;
	bh=qDd03zvPpVP9bgpL3wEKMqEVvDUL+H1bHMe7HXsVXfM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GQPJVVVQRu8Udi3dx8pAjg/pcwk2VUiA9D2FpaNzHUlHupfJg8kHDlSk2tRAbZ2ob8okkZGeDcsDbUCaxy4W+yRinc2szksEDRXOimosegoUzqUxQTpbHhF4j0RKxdK1fnK9p00mX7NkrWDYIJodvpSijrAhdNawGp95INPkfLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T9iu7xTb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 537CAC4CEDD;
	Tue, 25 Feb 2025 12:30:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740486608;
	bh=qDd03zvPpVP9bgpL3wEKMqEVvDUL+H1bHMe7HXsVXfM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=T9iu7xTb16lxmtMM2z1sP9UfOtAQ96ABPKWlU6L5reLEM/DocWYZzj0i6ai3iMoaW
	 X52FjUqm7SXd57V+MW+3RPx85rlHEW0fNAZMCbG9LOPCW+I3tG+cz2lHp+k+DuTMbl
	 DAIFjcY1eVFRxUvnE9/Hw7r0XpKGopkG78rl0dsx6MVdTE9AanDWgcIRhaPKX2Bbx9
	 FdyngbxNMUXOy7uUsysOHeE8Cqs+H1SDrfrk34AXiZQP22wqXxLLu59It74qrr6az/
	 rP6/i5hulYvEL9XMfwvlVW5rGNVBNVnxAk+8lCxu5uOhpqXnirwYmfiDpgO42/Mzn7
	 vQvR0M1wKZgQw==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Daniel Almeida" <daniel.almeida@collabora.com>
Cc: "Danilo Krummrich" <dakr@kernel.org>,  "Miguel Ojeda"
 <ojeda@kernel.org>,  "Alex Gaynor" <alex.gaynor@gmail.com>,  "Boqun Feng"
 <boqun.feng@gmail.com>,  "Gary Guo" <gary@garyguo.net>,  =?utf-8?Q?Bj?=
 =?utf-8?Q?=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,  "Benno Lossin" <benno.lossin@proton.me>,
  "Alice Ryhl" <aliceryhl@google.com>,  "Trevor Gross" <tmgross@umich.edu>,
  "Joel Becker" <jlbec@evilplan.org>,  "Christoph Hellwig" <hch@lst.de>,
  "Peter Zijlstra" <peterz@infradead.org>,  "Ingo Molnar"
 <mingo@redhat.com>,  "Will Deacon" <will@kernel.org>,  "Waiman Long"
 <longman@redhat.com>,  "Fiona Behrens" <me@kloenk.dev>,  "Charalampos
 Mitrodimas" <charmitro@posteo.net>,  <rust-for-linux@vger.kernel.org>,
  <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 2/4] rust: configfs: introduce rust support for configfs
In-Reply-To: <118A2077-91B6-485F-AA5F-03D54AC5771C@collabora.com> (Daniel
	Almeida's message of "Tue, 25 Feb 2025 07:53:19 -0300")
References: <20250224-configfs-v4-0-9af9b5e611f6@kernel.org>
	<20250224-configfs-v4-2-9af9b5e611f6@kernel.org>
	<lOoYh91-WphgZiaB1UWmZfYfG8hcG7pCydLGcO6VmeHOfZir-M4jz0KEO2AUMTkugvDLkvKw-M4Kl40xG8sgvg==@protonmail.internalid>
	<F1FA8DA8-A54D-49B1-BE8F-2B0DE14F4899@collabora.com>
	<87plj6wcz3.fsf@kernel.org>
	<Qb0gTp0yipgyPUH5_OOewMKao_hniHD2k1C4li2QpXqETWNHRjBzMt8q4bxwIr3_r1mqxJ2Tx2D8rS7EDak_2w==@protonmail.internalid>
	<118A2077-91B6-485F-AA5F-03D54AC5771C@collabora.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Tue, 25 Feb 2025 13:29:57 +0100
Message-ID: <8734g2w6ka.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

"Daniel Almeida" <daniel.almeida@collabora.com> writes:

[...]

>>>> +
>>>> +impl<Data> Group<Data> {
>>>> +    /// Create an initializer for a new group.
>>>> +    ///
>>>> +    /// When instantiated, the group will appear as a directory with =
the name
>>>> +    /// given by `name` and it will contain attributes specified by `=
item_type`.
>>>> +    pub fn new(
>>>> +        name: CString,
>>>
>>> Is it me or this can be simply &CStr? `config_item_set_name` either cop=
ies into an internal
>>> buffer or allocates, so I see no reason to pass an owned type here.
>>
>> This function returns an initializer that would be bound by the lifetime
>> of the reference you pass in. That in turn has a very negative effect on
>> the ergonomics of the function, as it would limit the places you can
>> call it and still satisfy lifetime requirements.
>>
>> We could pass in a borrow and create an owned instance from the borrow,
>> then move the owned value into the initializer. But I think taking an
>> owned parameter in the first place is better.
>
>
> Do you mean that the CString is used to guarantee that the string is aliv=
e when the initializer
> actually runs?

Exactly.

>
> If so, I did not consider that. Please disregard this comment then.

OK.

>
>>
>> [...]
>>
>>>> +
>>>> +/// # Safety
>>>> +///
>>>> +/// `this` must be a valid pointer.
>>>> +///
>>>> +/// If `this` does not represent the root group of a `configfs` subsy=
stem,
>>>> +/// `this` must be a pointer to a `bindings::config_group` embedded i=
n a
>>>> +/// `Group<Parent>`.
>>>> +///
>>>> +/// Otherwise, `this` must be a pointer to a `bindings::config_group`=
 that
>>>> +/// is embedded in a `bindings::configfs_subsystem` that is embedded =
in a
>>>> +/// `Subsystem<Parent>`.
>>>> +unsafe fn get_group_data<'a, Parent>(this: *mut bindings::config_grou=
p) -> &'a Parent {
>>>> +    // SAFETY: `this` is a valid pointer.
>>>> +    let is_root =3D unsafe { (*this).cg_subsys.is_null() };
>>>> +
>>>> +    if !is_root {
>>>> +        // SAFETY: By C API contact, `this` is a pointer to a
>>>> +        // `bindings::config_group` that we passed as a return value =
in from
>>>> +        // `make_group`. Such a pointer is embedded within a `Group<P=
arent>`.
>>>
>>> This phrase is confusing.
>>
>> I am not sure how to rephrase it to be less confusing. The pointer is
>> the thing returned from `make_group`. `make_group` would only return a
>> pointer into a `Group<Parent>`.
>
> The problem is this: "that we passed as a return value in from=E2=80=9D, =
to pass something as a return value
> is already hard to parse, and when you reach the =E2=80=9Cin from=E2=80=
=9D part, it becomes even harder.
>
> Just say a variation of what you said above, that is perfectly understand=
able.
>
> What about:
>
> ```
>
> `this` is a pointer to a `bindings::config_group` that was returned from =
a call to `make_group`. The pointer is known
> to be embedded within a `Group<Parent>`.
>
> ```

How is this:

        // SAFETY: By C API contact,`this` was returned from a call to
        // `make_group`. The pointer is known to be embedded within a
        // `Group<Parent>`.

[...]

>>>> +
>>>> +/// A `configfs` attribute.
>>>> +///
>>>> +/// An attribute appears as a file in configfs, inside a folder that =
represent
>>>> +/// the group that the attribute belongs to.
>>>> +#[repr(transparent)]
>>>> +pub struct Attribute<const ID: u64, O, Data> {
>>>
>>> The first thing I thought here is =E2=80=9Cwhat is O?!"
>>
>> Would you prefer a rename to "Operations"? I was told to not add trait
>> bounds on the struct, because it is not necessary.
>
> I=E2=80=99d prefer Operations, yes.
>
>>
>>>
>>>> +    attribute: Opaque<bindings::configfs_attribute>,
>>>> +    _p: PhantomData<(O, Data)>,
>>>> +}
>>>> +
>>>> +// SAFETY: We do not provide any operations on `Attribute`.
>>>> +unsafe impl<const ID: u64, O, Data> Sync for Attribute<ID, O, Data> {}
>>>> +
>>>> +// SAFETY: Ownership of `Attribute` can safely be transferred to othe=
r threads.
>>>> +unsafe impl<const ID: u64, O, Data> Send for Attribute<ID, O, Data> {}
>>>> +
>>>> +impl<const ID: u64, O, Data> Attribute<ID, O, Data>
>>>> +where
>>>> +    O: AttributeOperations<ID, Data =3D Data>,
>>>
>>> I recommend renaming =E2=80=9CO" into something that denotes this bound=
 better.
>>>
>>> It can be terse as appropriate, but simply =E2=80=9CO=E2=80=9D is a bit=
 *too terse* .
>>
>> Right, I agree. However, other reviewers have argued negatively about
>> using 4 letters for the "Data" bound, since generic type parameters are
>> often just single capital letters.
>
> This is a convention, that is all. As a person trying to make sense of th=
is code, Data was *much*
> more informative than T or U, or etc. Same for `Parent`.
>
> If you see things like:
>
> ```
> impl<Data> Subsystem<Data>
> ```
>
> You already know it=E2=80=99s a type parameter. If you click on Data, ass=
uming LSP support, it will also tell
> you that.
>
> This code is already a bit hard to follow as is, let=E2=80=99s make sure =
that the types actually aid in its
> comprehension and not the other way around, please.

I would agree. I believe Benno was arguing that it is difficult to see
what identifiers are generic type parameters when they are words rather
than letters.

[...]

>>>> +/// A list of attributes.
>>>> +///
>>>> +/// This type is used to construct a new [`ItemType`]. It represents =
a list of
>>>> +/// [`Attribute`] that will appear in the directory representing a [`=
Group`].
>>>> +/// Users should not directly instantiate this type, rather they shou=
ld use the
>>>> +/// [`kernel::configfs_attrs`] macro to declare a static set of attri=
butes for a
>>>> +/// group.
>>>> +#[repr(transparent)]
>>>> +pub struct AttributeList<const N: usize, Data>(
>>>> +    UnsafeCell<[*mut kernel::ffi::c_void; N]>,
>>>
>>> For the sake of maintainability, can you provide some docs on this type?
>>>
>>> For example, what is the c_void here?
>>
>> As per the docstring above, is a list of `Attribute`. I can expand it a =
bit:
>>
>> /// Users should not directly instantiate this type, rather they should =
use the
>> /// [`kernel::configfs_attrs`] macro to declare a static set of attribut=
es for a
>> /// group.
>> +///
>> +/// # Note
>> +///
>> +/// This type is constructed statically at compile time and is by the
>> +/// [`kernel::configfs_attrs`] macro.
>> #[repr(transparent)]
>> pub struct AttributeList<const N: usize, Data>(
>> +    /// Null terminated Array of pointers to `Attribute`. The type is `=
c_void`
>> +    /// to conform to the C API.
>
> Yes this is much better :)

Let's go with that then.

[...]

>>>> +                $(
>>>> +                    static [< $data:upper _TPE >]:
>>>> +                        $crate::configfs::ItemType<$container, $data>=
  =3D
>>>> +                            $crate::configfs::ItemType::<$container, =
$data>::
>>>> +                            new_with_child_ctor::<N, $child>(
>>>> +                                &THIS_MODULE, &[<$ data:upper _ATTRS =
>]
>>>> +                            );
>>>> +                )?
>>>> +
>>>> +                & [< $data:upper _TPE >]
>>>> +            }
>>>> +        }
>>>> +    };
>>>> +
>>>> +}
>>>
>>> Andreas, just a suggestion for the sake of maintainability, can you add=
 some docs to this macro?
>>>
>>> I think you=E2=80=99ll agree that there is a *lot* going on here.
>>>
>>> In fact, this patch is a bit complex, so kudos on making it work in a v=
ery simple way for the callers.
>>
>> I could write a small wall of text and do some step by step expansion of
>> the macro. But I would rather not, since we are soon (TM) going to have
>> `syn` and `quote`, and all this horror will go away.
>
> Ok, your call.
>
>>
>> One way to help parsing this mess, is using the "expand macro" feature
>> of `rust-analyzer` in an editor and looking at the expanded code.
>
> I wonder if that can=E2=80=99t be pasted inline with the docs for a trivi=
al use of the macro?
>
> I will take the verbosity *any day* over trying to figure out what is goi=
ng on
> manually here.
>
> Or you can wait for syn and quote, as you said, that=E2=80=99s OK.
>
> By the way, with the somewhat limited support for rust-analyzer in the ke=
rnel,
> I wonder whether that is in fact possible. Things are much more restricte=
d for
> non-Cargo projects.

It is working for me at least. I build the rust-project.json with `make
rust-analyzer`. I build out of tree, so I have to move the file to the
source tree manually. No additional steps required.


Best regards,
Andreas Hindborg



