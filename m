Return-Path: <linux-kernel+bounces-531014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 68EAEA43B09
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 11:15:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FCED19C4DA4
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 10:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97BB72641C6;
	Tue, 25 Feb 2025 10:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gr/WQLwv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FA612144BF;
	Tue, 25 Feb 2025 10:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740478304; cv=none; b=eqmjQTZsKvVJyG2P2X/uM8sdrC1l9lRNrQ3gHa02Hwil66mg7iKpEQKRH7ofz4XA4Vp1CZ6e5GT9vLiYfT0uSyVyqaPsF78Q7157duqMKRT24iHl2xD0mvdFLRedT9QAQUP641Iat4OQarPDIes3ZKipjNvndCAATDGH5wRzq6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740478304; c=relaxed/simple;
	bh=4hgr0njwlzvqgZD/rEnuryyLfaj0ir6DP4scBWhVmBk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XsbyiX2rlVDQnw2zOd7FSznFL24TT9e+lVkF6IExgD/jepdsx914Sp0s33GQrvfxzwnQeqlTiHp+kcCD8Vu9Hz5Npf/hORbfiX/q4dcYvdnRZR4Fke3GQP4mbVHoVrPGb9Pfz90HQVcv6vhtbLbXTgTxZbIJmrI24odsBYnlfss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gr/WQLwv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EFF6C4CEE7;
	Tue, 25 Feb 2025 10:11:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740478304;
	bh=4hgr0njwlzvqgZD/rEnuryyLfaj0ir6DP4scBWhVmBk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=gr/WQLwv1IpmfV6w5WwlvPOGpTiAaotc0fJGIlLxuvOzF3MhfXug59GGrIK6VF+IU
	 ltkFfNMqXY+A+Z7f3j2u8flfbUopH6L8ImVStpgldXdHx4FfJ19VCJvM/wKcnjECec
	 nb1+GhhdeS1LTN8FApTFb8E9Y0dtQ6HoH0BJn3L60S966FnR4gnhXubRsl7i66W7nj
	 bOQYSUP2Ft09yFrk02/PLRLyp46hadqrJWWKAw/O7RWvKO+mQsLF4JMaqS3UiTjY/k
	 xFvntUvDzoKpwS/eUT26432Z76rW5qP+6PfWcqLX0niUThZ3GMTa+8cOYOWJlfZTcu
	 oFwn2F12KytSA==
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
In-Reply-To: <F1FA8DA8-A54D-49B1-BE8F-2B0DE14F4899@collabora.com> (Daniel
	Almeida's message of "Mon, 24 Feb 2025 19:30:13 -0300")
References: <20250224-configfs-v4-0-9af9b5e611f6@kernel.org>
	<20250224-configfs-v4-2-9af9b5e611f6@kernel.org>
	<lOoYh91-WphgZiaB1UWmZfYfG8hcG7pCydLGcO6VmeHOfZir-M4jz0KEO2AUMTkugvDLkvKw-M4Kl40xG8sgvg==@protonmail.internalid>
	<F1FA8DA8-A54D-49B1-BE8F-2B0DE14F4899@collabora.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Tue, 25 Feb 2025 11:11:28 +0100
Message-ID: <87plj6wcz3.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

"Daniel Almeida" <daniel.almeida@collabora.com> writes:

> Hi Andreas,
>
>> On 24 Feb 2025, at 10:21, Andreas Hindborg <a.hindborg@kernel.org> wrote:
>>
>> This patch adds a rust API for configfs, thus allowing rust modules to u=
se
>> configfs for configuration. The implementation is a shim on top of the C
>> configfs implementation allowing safe use of the C infrastructure from
>> rust.
>>
>> The patch enables the `const_mut_refs` feature on compilers before rustc
>
> Where?

Not any more! It was merged with `IdArray`, and apparently it did not
make a conflict when I rebased. I'll drop this paragraph.

[...]

>> +
>> +impl<Data> Group<Data> {
>> +    /// Create an initializer for a new group.
>> +    ///
>> +    /// When instantiated, the group will appear as a directory with th=
e name
>> +    /// given by `name` and it will contain attributes specified by `it=
em_type`.
>> +    pub fn new(
>> +        name: CString,
>
> Is it me or this can be simply &CStr? `config_item_set_name` either copie=
s into an internal
> buffer or allocates, so I see no reason to pass an owned type here.

This function returns an initializer that would be bound by the lifetime
of the reference you pass in. That in turn has a very negative effect on
the ergonomics of the function, as it would limit the places you can
call it and still satisfy lifetime requirements.

We could pass in a borrow and create an owned instance from the borrow,
then move the owned value into the initializer. But I think taking an
owned parameter in the first place is better.

[...]

>> +
>> +/// # Safety
>> +///
>> +/// `this` must be a valid pointer.
>> +///
>> +/// If `this` does not represent the root group of a `configfs` subsyst=
em,
>> +/// `this` must be a pointer to a `bindings::config_group` embedded in a
>> +/// `Group<Parent>`.
>> +///
>> +/// Otherwise, `this` must be a pointer to a `bindings::config_group` t=
hat
>> +/// is embedded in a `bindings::configfs_subsystem` that is embedded in=
 a
>> +/// `Subsystem<Parent>`.
>> +unsafe fn get_group_data<'a, Parent>(this: *mut bindings::config_group)=
 -> &'a Parent {
>> +    // SAFETY: `this` is a valid pointer.
>> +    let is_root =3D unsafe { (*this).cg_subsys.is_null() };
>> +
>> +    if !is_root {
>> +        // SAFETY: By C API contact, `this` is a pointer to a
>> +        // `bindings::config_group` that we passed as a return value in=
 from
>> +        // `make_group`. Such a pointer is embedded within a `Group<Par=
ent>`.
>
> This phrase is confusing.

I am not sure how to rephrase it to be less confusing. The pointer is
the thing returned from `make_group`. `make_group` would only return a
pointer into a `Group<Parent>`.


[...]

>> +    /// # Safety
>> +    ///
>> +    /// If `this` does not represent the root group of a `configfs` sub=
system,
>> +    /// `this` must be a pointer to a `bindings::config_group` embedded=
 in a
>> +    /// `Group<Parent>`.
>> +    ///
>> +    /// Otherwise, `this` must be a pointer to a `bindings::config_grou=
p` that
>> +    /// is embedded in a `bindings::configfs_subsystem` that is embedde=
d in a
>> +    /// `Subsystem<Parent>`.
>> +    ///
>> +    /// `item` must point to a `bindings::config_item` within a
>> +    /// `bindings::config_group` within a `Group<Child>`.
>> +    unsafe extern "C" fn drop_item(
>> +        this: *mut bindings::config_group,
>> +        item: *mut bindings::config_item,
>> +    ) {
>> +        // SAFETY: By function safety requirements of this function, th=
is call
>> +        // is safe.
>> +        let parent_data =3D unsafe { get_group_data(this) };
>> +
>> +        // SAFETY: By function safety requirements, `item` is embedded =
in a
>> +        // `config_group`.
>> +        let c_child_group_ptr =3D
>> +            unsafe { kernel::container_of!(item, bindings::config_group=
, cg_item) };
>
> nit: container_of is already in scope

Thanks!

[...]

>> +
>> +/// A `configfs` attribute.
>> +///
>> +/// An attribute appears as a file in configfs, inside a folder that re=
present
>> +/// the group that the attribute belongs to.
>> +#[repr(transparent)]
>> +pub struct Attribute<const ID: u64, O, Data> {
>
> The first thing I thought here is =E2=80=9Cwhat is O?!"

Would you prefer a rename to "Operations"? I was told to not add trait
bounds on the struct, because it is not necessary.

>
>> +    attribute: Opaque<bindings::configfs_attribute>,
>> +    _p: PhantomData<(O, Data)>,
>> +}
>> +
>> +// SAFETY: We do not provide any operations on `Attribute`.
>> +unsafe impl<const ID: u64, O, Data> Sync for Attribute<ID, O, Data> {}
>> +
>> +// SAFETY: Ownership of `Attribute` can safely be transferred to other =
threads.
>> +unsafe impl<const ID: u64, O, Data> Send for Attribute<ID, O, Data> {}
>> +
>> +impl<const ID: u64, O, Data> Attribute<ID, O, Data>
>> +where
>> +    O: AttributeOperations<ID, Data =3D Data>,
>
> I recommend renaming =E2=80=9CO" into something that denotes this bound b=
etter.
>
> It can be terse as appropriate, but simply =E2=80=9CO=E2=80=9D is a bit *=
too terse* .

Right, I agree. However, other reviewers have argued negatively about
using 4 letters for the "Data" bound, since generic type parameters are
often just single capital letters.

I will draw attention to the the Rust API guidelines[1] which allow
`UpperCamelCase` names .

@Benno, you had a different opinion, can you weigh in?

[1] https://rust-lang.github.io/api-guidelines/naming.html

[...]

>> +    /// Create a new attribute.
>> +    ///
>> +    /// The attribute will appear as a file with name given by `name`.
>> +    pub const fn new(name: &'static CStr) -> Self {
>> +        Self {
>> +            attribute: Opaque::new(bindings::configfs_attribute {
>> +                ca_name: name as *const _ as _,

Let's get rid of this `as _` cast.

>> +                ca_owner: core::ptr::null_mut(),
>> +                ca_mode: 0o660,
>
> Shouldn=E2=80=99t `ca_mode` be somehow taken as an input? Also, can we ge=
t rid of the literal here?

That would be a nice addition for a follow up series.

>
>> +                show: Some(Self::show),
>> +                store: if O::HAS_STORE {
>> +                    Some(Self::store)
>> +                } else {
>> +                    None
>> +                },
>> +            }),
>> +            _p: PhantomData,
>> +        }
>> +    }
>> +}
>> +
>> +/// Operations supported by an attribute.
>> +///
>> +/// Implement this trait on type and pass that type as generic paramete=
r when
>> +/// creating an [`Attribute`]. The type carrying the implementation ser=
ve no
>> +/// purpose other than specifying the attribute operations.
>> +#[vtable]
>> +pub trait AttributeOperations<const ID: u64 =3D 0> {
>
> I assume that this ID parameter is to allow for multiple implementations,=
 like we currently do
> for the Workqueue? If so, can you mention this in the docs?

Absolutely.

>
>> +    /// The type of the object that contains the field that is backing =
the
>> +    /// attribute for this operation.
>> +    type Data;
>> +
>> +    /// Renders the value of an attribute.
>> +    ///
>> +    /// This function is called by the kernel to read the value of an a=
ttribute.
>> +    ///
>> +    /// Implementations should write the rendering of the attribute to =
`page`
>> +    /// and return the number of bytes written.
>> +    fn show(data: &Self::Data, page: &mut [u8; PAGE_SIZE]) -> Result<us=
ize>;
>> +
>> +    /// Stores the value of an attribute.
>> +    ///
>> +    /// This function is called by the kernel to update the value of an=
 attribute.
>> +    ///
>> +    /// Implementations should parse the value from `page` and update i=
nternal
>> +    /// state to reflect the parsed value.
>> +    fn store(_data: &Self::Data, _page: &[u8]) -> Result {
>> +        kernel::build_error!(kernel::error::VTABLE_DEFAULT_ERROR)
>> +    }
>> +}
>> +
>> +/// A list of attributes.
>> +///
>> +/// This type is used to construct a new [`ItemType`]. It represents a =
list of
>> +/// [`Attribute`] that will appear in the directory representing a [`Gr=
oup`].
>> +/// Users should not directly instantiate this type, rather they should=
 use the
>> +/// [`kernel::configfs_attrs`] macro to declare a static set of attribu=
tes for a
>> +/// group.
>> +#[repr(transparent)]
>> +pub struct AttributeList<const N: usize, Data>(
>> +    UnsafeCell<[*mut kernel::ffi::c_void; N]>,
>
> For the sake of maintainability, can you provide some docs on this type?
>
> For example, what is the c_void here?

As per the docstring above, is a list of `Attribute`. I can expand it a bit:

 /// Users should not directly instantiate this type, rather they should us=
e the
 /// [`kernel::configfs_attrs`] macro to declare a static set of attributes=
 for a
 /// group.
+///
+/// # Note
+///
+/// This type is constructed statically at compile time and is by the
+/// [`kernel::configfs_attrs`] macro.
 #[repr(transparent)]
 pub struct AttributeList<const N: usize, Data>(
+    /// Null terminated Array of pointers to `Attribute`. The type is `c_v=
oid`
+    /// to conform to the C API.
     UnsafeCell<[*mut kernel::ffi::c_void; N]>,
     PhantomData<Data>,
 );


Does that work?

>
>> +    PhantomData<Data>,
>> +);
>> +
>> +// SAFETY: Ownership of `AttributeList` can safely be transferred to ot=
her threads.
>> +unsafe impl<const N: usize, Data> Send for AttributeList<N, Data> {}
>> +
>> +// SAFETY: We do not provide any operations on `AttributeList` that nee=
d synchronization.
>> +unsafe impl<const N: usize, Data> Sync for AttributeList<N, Data> {}
>> +
>> +impl<const N: usize, Data> AttributeList<N, Data> {
>> +    /// # Safety
>> +    ///
>> +    /// This function can only be called by the `configfs_attrs`
>> +    /// macro.
>
> Well, a pub function can be called from anywhere in the crate. Maybe `sho=
uld` would be more
> appropriate? I assume you want to tell people to not call this
> directly.

Yes, it is in the safety requirements section of an unsafe function. But
you are right "can" is not the right word. I think "must" is appropriate.

> Otherwise I=E2=80=99m left wondering
> whether there is some magic going on that I=E2=80=99m unaware of to make =
what you said possible.

No magic, it is a prerequisite for calling, something you would have to
justify in the safety comment at the call site.

>
>> +    #[doc(hidden)]
>> +    pub const unsafe fn new() -> Self {
>> +        Self(UnsafeCell::new([core::ptr::null_mut(); N]), PhantomData)
>> +    }
>> +
>> +    /// # Safety
>> +    ///
>> +    /// This function can only be called by the `configfs_attrs`
>> +    /// macro.
>> +    #[doc(hidden)]
>> +    pub const unsafe fn add<
>> +        const I: usize,
>> +        const ID: u64,
>> +        O: AttributeOperations<ID, Data =3D Data>,
>> +    >(
>> +        &'static self,
>> +        attribute: &'static Attribute<ID, O, Data>,
>> +    ) {
>
> Can you convert this into a where clause? IMHO it will be much easier to =
read, given how the
> function args got formatted here.

Sure. Const types cannot go in where clause, but formatting is better
with the bound on "O" moved.

[...]

>> +                $(
>> +                    static [< $data:upper _TPE >]:
>> +                        $crate::configfs::ItemType<$container, $data>  =
=3D
>> +                            $crate::configfs::ItemType::<$container, $d=
ata>::
>> +                            new_with_child_ctor::<N, $child>(
>> +                                &THIS_MODULE, &[<$ data:upper _ATTRS >]
>> +                            );
>> +                )?
>> +
>> +                & [< $data:upper _TPE >]
>> +            }
>> +        }
>> +    };
>> +
>> +}
>
> Andreas, just a suggestion for the sake of maintainability, can you add s=
ome docs to this macro?
>
> I think you=E2=80=99ll agree that there is a *lot* going on here.
>
> In fact, this patch is a bit complex, so kudos on making it work in a ver=
y simple way for the callers.

I could write a small wall of text and do some step by step expansion of
the macro. But I would rather not, since we are soon (TM) going to have
`syn` and `quote`, and all this horror will go away.

One way to help parsing this mess, is using the "expand macro" feature
of `rust-analyzer` in an editor and looking at the expanded code.

>
>> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
>> index 496ed32b0911..ec84653ab8c7 100644
>> --- a/rust/kernel/lib.rs
>> +++ b/rust/kernel/lib.rs
>> @@ -40,6 +40,8 @@
>> pub mod block;
>> #[doc(hidden)]
>> pub mod build_assert;
>> +#[cfg(CONFIG_CONFIGFS_FS)]
>> +pub mod configfs;
>> pub mod cred;
>> pub mod device;
>> pub mod device_id;
>>
>> --
>> 2.47.0
>>
>>
>
> I=E2=80=99ll probably do another pass here later, there=E2=80=99s a lot t=
o unpack.

Appreciate it! Thanks for the comments!


Best regards,
Andreas Hindborg




