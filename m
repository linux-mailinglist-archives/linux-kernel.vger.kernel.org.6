Return-Path: <linux-kernel+bounces-517479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 49A8AA3815B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 12:09:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27B0D7A31AE
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 11:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 112EE2135C7;
	Mon, 17 Feb 2025 11:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oOuv5/Y6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A34F216600;
	Mon, 17 Feb 2025 11:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739790526; cv=none; b=Dv+2CSMTFEFzME/fF47O3R09oyFKQBDjhh5dWF55p2PJ1RSfEU7gXUlDUfvpOg8hP2rNpys3/FaobNz5PdJFhScoJDqJIT7lA6dMEalDA+U+8yBudcu8b0+gPoS14rCZLPJIYK8OSY02OE5eWjXIyC0ukkQCfaWHJuuArlft7Wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739790526; c=relaxed/simple;
	bh=a2fwjbgyRHUdkihZsSLXZpLhQd3dv20UOrfRE7ma31s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JZqlevlMf923TNwu1rYOuUtai3l7cN86Vpxfe2DajdReWs68LEqwCu96DvhNwAsAyIyq8vL8Ht68YgDD/xMh5eN7GkF1l9GkE23QsBxMos2nZvWIqeDLuG2/xZr4JEVfHEEys1FwlJStCMC0AXoNnq5jByBf+nQDubcdhr62fC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oOuv5/Y6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA7EEC4CED1;
	Mon, 17 Feb 2025 11:08:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739790526;
	bh=a2fwjbgyRHUdkihZsSLXZpLhQd3dv20UOrfRE7ma31s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=oOuv5/Y69XC1nDcMUkg+BaonhJCmwztp5lsPQcWVvZmoaHdfIYqYKVZhM7rOw6dKy
	 rvt17odptvXusZkqAy480wJyQSzYqIQU9QqkHih2DLH2H8T4lJGz87ewI/VOdpX48b
	 WJpTkOr/JkfnUePqMSA2tpr5PlUmQY1y1FUryr4K4CAsFF0rpPKSYCF6tPWhlX9cJv
	 WL4hvnjU1CA7fhhHp2rABPoNH48ZN5OMDPfSkZGGmW9/izvZIoG5o6Yyel0rEKjeMe
	 p40GeVTVChKHptJQMb/zb/UN4Xyi05Zpf7q7cTSicGjhKEFislMcZJgZJKUUF5WF5a
	 DtKqA6rBgXJ6w==
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
In-Reply-To: <dd63fcde-ba4c-4a6e-9bde-1af5af37e91b@proton.me> (Benno Lossin's
	message of "Mon, 17 Feb 2025 02:17:16 +0000")
References: <20250207-configfs-v2-0-f7a60b24d38e@kernel.org>
	<20250207-configfs-v2-2-f7a60b24d38e@kernel.org>
	<S6DKlLVx4KKevl_q2zrW69Z7oS0jwyX4DXpDZrFiIy1lKo4VYHM52aDiV82c2yf52Ecr7t9FayuqBUPR9onvZA==@protonmail.internalid>
	<dd63fcde-ba4c-4a6e-9bde-1af5af37e91b@proton.me>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Mon, 17 Feb 2025 12:08:22 +0100
Message-ID: <87h64su8ux.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

"Benno Lossin" <benno.lossin@proton.me> writes:

> On 07.02.25 15:41, Andreas Hindborg wrote:
>> This patch adds a rust API for configfs, thus allowing rust modules to u=
se
>> configfs for configuration. The implementation is a shim on top of the C
>> configfs implementation allowing safe use of the C infrastructure from
>> rust.
>>
>> The patch enables the `const_mut_refs` feature on compilers before rustc
>> 1.83. The feature was stabilized in rustc 1.83 and is not required to be
>> explicitly enabled on later versions.
>>
>> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
>>
>> ---
>>
>> This patch is a direct dependency for `rnull`, the rust null block drive=
r.
>> ---
>>  rust/bindings/bindings_helper.h |   1 +
>>  rust/helpers/mutex.c            |   5 +
>>  rust/kernel/configfs.rs         | 860 +++++++++++++++++++++++++++++++++=
+++++++
>>  rust/kernel/lib.rs              |   2 +
>>  samples/rust/Kconfig            |  11 +
>>  samples/rust/Makefile           |   1 +
>>  samples/rust/rust_configfs.rs   | 186 +++++++++
>
> Can you move the sample into its own patch?

Yes.

[...]

>> diff --git a/rust/kernel/configfs.rs b/rust/kernel/configfs.rs
>> new file mode 100644
>> index 0000000000000..9d4b381b9df89
>> --- /dev/null
>> +++ b/rust/kernel/configfs.rs
>> @@ -0,0 +1,860 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +
>> +//! `configfs` interface.
>> +//!
>> +//! `configfs` is an in-memory pseudo file system for configuration of =
kernel
>> +//! modules. Please see the [C documentation] for details and intended =
use of
>> +//! `configfs`.
>> +//!
>> +//! This module does not support the following `configfs` features:
>> +//!
>> +//! - Items. All group children are groups.
>> +//! - Symlink support.
>> +//! - `disconnect_notify` hook.
>> +//! - Default groups.
>
> For lists like this, I usually end items except the last one with a
> comma instead of a period.

If that is the right way to do it, sure. It is actually funny that you
notice, because I searched for input on how to typeset such a list, and
some Microsoft typesetting site told me to do it like this when some
items are sentences [1]. I am not a native English speaker, and I have
no idea what the correct formatting is. Commas are not mentioned at the
resource I found.

[1] https://www.microsoft.com/en-us/microsoft-365-life-hacks/writing/punctu=
ating-bullet-point-lists

>
>> +//!
>> +//! See the [rust_configfs.rs] sample for a full example use of this mo=
dule.
>
> It could also be useful to just put the example directly here into the
> docs instead of/additionally to having it as a sample.

I don't think we should duplicate the code. As long as the link works, I
think having it separately is fine.

>
>> +//!
>> +//! C header: [`include/linux/configfs.h`](srctree/include/linux/config=
fs.h)
>> +//!
>> +//! [C documentation]: srctree/Documentation/filesystems/configfs.rst
>> +//! [rust_configfs.rs]: srctree/samples/rust/rust_configfs.rs
>> +
>> +use crate::alloc::flags;
>> +use crate::container_of;
>> +use crate::page::PAGE_SIZE;
>> +use crate::prelude::*;
>> +use crate::str::CString;
>> +use crate::sync::Arc;
>> +use crate::types::ForeignOwnable;
>> +use crate::types::Opaque;
>> +use core::cell::UnsafeCell;
>> +use core::marker::PhantomData;
>> +use core::ptr::addr_of;
>> +use core::ptr::addr_of_mut;
>
> I usually would import this like so:
>
>     use crate::{
>         alloc::flags,
>         container_of,
>         page::PAGE_SIZE,
>         prelude::*,
>         str::CString,
>         sync::Arc,
>         types::{ForeignOwnable, Opaque},
>     };
>     use core::{
>         cell::UnsafeCell,
>         marker::PhantomData,
>         ptr::{addr_of, addr_of_mut},
>     };
>
> To me this is more readable.

I disagree with that. I don't think what you suggest is easier to read,
and it is much more difficult to work with when rebasing and merging
things. This was discussed elsewhere in the past without reaching a
conclusion. I think we should come to a consensus on what style we
should adopt for the imports.

>
>> +
>> +/// A `configfs` subsystem.
>> +///
>> +/// This is the top level entrypoint for a `configfs` hierarchy. To reg=
ister
>> +/// with configfs, embed a field of this type into your kernel module s=
truct.
>> +#[pin_data(PinnedDrop)]
>> +pub struct Subsystem<Data> {
>
> Usually, we don't have multi-character generics, any specific reason
> that you chose `Data` here over `T` or `D`?

Yes, I find it more descriptive. The patch set went through quite a bit
of evolution, and the generics got a bit complicated in earlier
iterations, which necessitated more descriptive generic type parameter
names. It's not so bad in this version after I restricted the pointer
type to just `Arc`, but I still think that using a word rather a single
letter makes the code easier to comprehend at first pass.

Also, using a word is allowed as per the API guideline document [2]:

      > concise UpperCamelCase, usually single uppercase letter: T

https://rust-lang.github.io/api-guidelines/naming.html

>
>> +    #[pin]
>> +    subsystem: Opaque<bindings::configfs_subsystem>,
>> +    #[pin]
>> +    data: Data,
>> +}
>> +
>> +// SAFETY: We do not provide any operations on `Subsystem`.
>> +unsafe impl<Data> Sync for Subsystem<Data> {}
>> +
>> +// SAFETY: Ownership of `Subsystem` can safely be transferred to other =
threads.
>> +unsafe impl<Data> Send for Subsystem<Data> {}
>> +
>> +impl<Data> Subsystem<Data> {
>> +    /// Create an initializer for a [`Subsystem`].
>> +    ///
>> +    /// The subsystem will appear in configfs as a directory name given=
 by
>> +    /// `name`. The attributes available in directory are specified by
>> +    /// `item_type`.
>> +    pub fn new(
>> +        name: &'static CStr,
>> +        item_type: &'static ItemType<Subsystem<Data>, Data>,
>> +        data: impl PinInit<Data, Error>,
>> +    ) -> impl PinInit<Self, Error> {
>> +        try_pin_init!(Self {
>> +            subsystem <- kernel::init::zeroed().chain(
>> +                |place: &mut Opaque<bindings::configfs_subsystem>| {
>> +                    // SAFETY: All of `place` is valid for write.
>> +                    unsafe {
>> +                        addr_of_mut!((*place.get()).su_group.cg_item.ci=
_name )
>> +                            .write(name.as_ptr().cast_mut().cast())
>> +                    };
>> +                    // SAFETY: All of `place` is valid for write.
>> +                    unsafe {
>> +                        addr_of_mut!((*place.get()).su_group.cg_item.ci=
_type)
>> +                            .write(item_type.as_ptr())
>> +                    };
>> +                    // SAFETY: We initialized the required fields of `p=
lace.group` above.
>> +                    unsafe { bindings::config_group_init(&mut (*place.g=
et()).su_group) };
>> +                    // SAFETY: `place.su_mutex` is valid for use as a m=
utex.
>> +                    unsafe { bindings::__mutex_init(
>> +                        &mut (*place.get()).su_mutex,
>> +                        kernel::optional_name!().as_char_ptr(),
>> +                        kernel::static_lock_class!().as_ptr())
>
> Formatting for this code is weird.
>
> (since this is inside of the `try_pin_init!` macro, rustfmt doesn't
> format it, since `<-` isn't part of rust syntax, so it doesn't know what
> to do. I usually fix this by replacing all `<-` with `:`, format and
> then change things back)

Such is the perils of macros. I'll try to go over it again. Perhaps we
could make `rustfmt` understand `<-`?

>
> Also, is there no function in C that does all of this initialization for
> you?

I might be able to do a little better. There is a C function that takes
care of initialization of `ci_name` and `ci_type` as well. I can't
recall if there was a particular reason for not using it, but I'll
check.

We have to initialize the mutex explicitly. I think the reason for not
doing that implicitly C side is to allow it to be statically
initialized.

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
>> +        item_type: &'static ItemType<Group<Data>, Data>,
>> +        data: impl PinInit<Data, Error>,
>> +    ) -> impl PinInit<Self, Error> {
>> +        try_pin_init!(Self {
>> +            group <- kernel::init::zeroed().chain(|v: &mut Opaque<bindi=
ngs::config_group>| {
>> +                let place =3D v.get();
>> +                let name =3D name.as_bytes_with_nul().as_ptr();
>> +                // SAFETY: It is safe to initialize a group once it has=
 been zeroed.
>> +                unsafe {
>> +                    bindings::config_group_init_type_name(place, name a=
s _, item_type.as_ptr())
>
> Can you replace the `as _` cast with a `.cast()`?

=F0=9F=91=8D

[...]

>> +unsafe fn get_group_data<'a, Parent>(this: *mut bindings::config_group)=
 -> &'a Parent {
>> +    // TODO
>
> Missed this todo?

Thanks. It was referring to a missing safety comment that was later put
in place.

>
>> +    // SAFETY: `this` is a valid pointer.
>> +    let is_root =3D unsafe { (*this).cg_subsys.is_null() };
>> +
>> +    if !is_root {
>> +        // SAFETY: By C API contact, `this` is a pointer to a
>> +        // `bindings::config_group` that we passed as a return value in=
 from
>> +        // `make_group`. Such a pointer is embedded within a `Group<Par=
ent>`.
>> +        unsafe { &(*Group::<Parent>::container_of(this)).data }
>> +    } else {
>> +        // SAFETY: By C API contract, `this` is a pointer to the
>> +        // `bindings::config_group` field within a `Subsystem<Parent>`.
>> +        unsafe { &(*Subsystem::container_of(this)).data }
>> +    }
>> +}
>> +
>> +struct GroupOperationsVTable<Parent, Child>(PhantomData<(Parent, Child)=
>)
>
> Generic names?

I prefer descriptive names. I don't really see the point of replacing
with `P,C`. It would not be better.

>
>> +where
>> +    Parent: GroupOperations<Child =3D Child>;
>
> No need to put this where bound on the struct definition (it is only
> needed if the struct impls `Drop`).

Right.

[...]

>> +
>> +/// Operations implemented by `configfs` groups that can create subgrou=
ps.
>> +///
>> +/// Implement this trait on structs that embed a [`Subsystem`] or a [`G=
roup`].
>> +#[vtable]
>> +pub trait GroupOperations {
>> +    /// The parent data object type.
>> +    ///
>> +    /// The implementer of this trait is this kind of data object. Shou=
ld be set
>> +    /// to `Self`.
>> +    type Parent;
>
> If it should be set to `Self`, why does this even exist? If there are
> cases where it isn't supposed to be `Self`, it would be good to put them
> into the docs.

Good point. I'll remove the type and use `&self` at relevant places
instead.

>
>> +
>> +    /// The child data object type.
>> +    ///
>> +    /// This group will create subgroups (subdirectories) backed by thi=
s kind of
>> +    /// object.
>> +    type Child: 'static;
>> +
>> +    /// The kernel will call this method in response to `mkdir(2)` in t=
he
>> +    /// directory representing `this`.
>
> This doesn't really read like a first line description of this function,
> how about putting "Creates a new subgroup." as the first line?

Good call.

>
>> +    ///
>> +    /// To accept the request to create a group, implementations should
>> +    /// instantiate a `CHLD` and return a `CPTR` to it. To prevent crea=
tion,
>
> Is there a typo in `CHLD`? What do you mean by "return a `CPTR` to it"?

Sorry, it's from an older iteration of the patch set. I'll update the
sentence. Looking forward to the day where the compiler can use AI to
type check the docs :)

>
>> +    /// return a suitable error.
>> +    fn make_group(
>> +        this: &Self::Parent,
>> +        name: &CStr,
>> +    ) -> Result<impl PinInit<Group<Self::Child>, Error>>;
>> +
>> +    /// The kernel will call this method before the directory represent=
ing
>> +    /// `_child` is removed from `configfs`.
>
> Same thing about the one-line description, how about (with the name
> changed below): "Prepares the given group for removal from configfs.".

=F0=9F=91=8D

>
>> +    ///
>> +    /// Implementations can use this method to do house keeping before
>> +    /// `configfs` drops its reference to `Child`.
>> +    fn drop_item(
>
> `drop` doesn't really fit here, I think something like `unlink_item`
> fits better, since the child isn't actually dropped after this function
> returns.

Yea, I know. But the function is called `drop_item` on the C side of
things. Usually we keep the C names.

>
>> +        _this: &Self::Parent,
>> +        _child: <Arc<Group<Self::Child>> as ForeignOwnable>::Borrowed<'=
_>,
>
> Just write ArcBorrow<'_, Group<Self::Child>> instead of the above?

Right. An earlier version of the patch set was generic over the pointer
type, allowing use of Box as well. The bounds became sort of wild, so I
figured limiting to `Arc` is probably fine.

>
>> +    ) {
>> +        kernel::build_error!(kernel::error::VTABLE_DEFAULT_ERROR)
>> +    }
>> +}
>> +
>> +/// A `configfs` attribute.
>> +///
>> +/// An attribute appear as a file in configfs, inside a folder that rep=
resent
>
> Typo: appear -> appears

=F0=9F=91=8D

>

[...]

>> +/// Operations supported by an attribute.
>> +///
>> +/// Implement this trait on type and pass that type as generic paramete=
r when
>> +/// creating an [`Attribute`]. The type carrying the implementation ser=
ve no
>> +/// purpose other than specifying the attribute operations.
>> +#[vtable]
>> +pub trait AttributeOperations<const ID: u64 =3D 0> {
>> +    /// The type of the object that contains the field that is backing =
the
>> +    /// attribute for this operation.
>> +    type Data;
>> +
>> +    /// This function is called by the kernel to read the value of an a=
ttribute.
>
> "Reads the value of an attribute.".

=F0=9F=91=8D

>
>> +    ///
>> +    /// Implementations should write the rendering of the attribute to =
`page`
>> +    /// and return the number of bytes written.
>> +    fn show(data: &Self::Data, page: &mut [u8; PAGE_SIZE]) -> Result<us=
ize>;
>
> Why is this not named `read` or `load`? If the C equivalent is `show`,
> then it's fine, but otherwise I wouldn't understand why it's show/store
> as opposed to load/store or read/write.

Yes, also here naming is derived from the C counterpart. The vtable item
is called `show`.

>
>> +
>> +    /// This function is called by the kernel to update the value of an=
 attribute.
>
> Again first line doc here.

=F0=9F=91=8D

>
>> +    ///
>> +    /// Implementations should parse the value from `page` and update i=
nternal
>> +    /// state to reflect the parsed value. Partial writes are not suppo=
rted and
>> +    /// implementations should expect the full page to arrive in one wr=
ite
>> +    /// operation.
>
> I don't understand what you're trying to say with the last sentence.

I will remove the comment, it does not make sense here. I picked it up
from C docs. It refers to how the function is exposed to user space.
Usually writes to files are processed in chunks, and file systems cannot
expect that all data written to a file will be passed in a single
function call.

>
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
>> +    #[doc(hidden)]
>
> I normally put attributes after the documentation.

Ok =F0=9F=91=8D

>
>> +    /// # Safety
>> +    ///
>> +    /// This function can only be called by expanding the `configfs_att=
rs`
>
> s/expanding//

Ok.

>
>> +    /// macro.
>> +    pub const unsafe fn new() -> Self {
>> +        Self(UnsafeCell::new([core::ptr::null_mut(); N]), PhantomData)
>> +    }
>> +
>> +    #[doc(hidden)]
>> +    /// # Safety
>> +    ///
>> +    /// This function can only be called by expanding the `configfs_att=
rs`
>
> s/expanding//

Ok.

>
>> +    /// macro.
>> +    pub const unsafe fn add<
>> +        const I: usize,
>> +        const ID: u64,
>> +        O: AttributeOperations<ID, Data =3D Data>,
>> +    >(
>> +        &'static self,
>> +        attribute: &'static Attribute<ID, O, Data>,
>> +    ) {
>> +        if I >=3D N - 1 {
>> +            kernel::build_error!("Invalid attribute index");
>> +        }
>> +
>> +        // SAFETY: This function is only called through `configfs_attrs=
`. This
>
> s/through `configfs_attrs`/through the `configfs_attrs` macro/

Ok.

>

[...]

>> +impl_item_type!(Subsystem<Data>);
>> +impl_item_type!(Group<Data>);
>> +
>> +impl<Container, Data> ItemType<Container, Data> {
>> +    fn as_ptr(&self) -> *const bindings::config_item_type {
>> +        self.item_type.get()
>> +    }
>> +}
>> +
>> +/// Define a list of configfs attributes statically.
>> +#[macro_export]
>> +macro_rules! configfs_attrs {
>
> I see you've joined the dark side of declarative macros!
>
> This seems like a prime candidate for replacing with a proc-macro when
> we have syn :)

Yes, I found myself wishing for `syn` very much while writing this.

>
>> +    (
>> +        container: $container:ty,
>> +        data: $data:ty,
>> +        attributes: [
>> +            $($name:ident: $attr:literal,)*
>
> This syntax always requires a trailing comma. Most (IIRC all, but not
> 100% sure) Rust syntax allows you to omit it, so it would be odd if it
> were not the case here. You can have an optional trailing comma via:
>
>     $($name:ident: $attr:literal),* $(,)?
>
> But as soon as you give the tokens off to the internals of the macro, I
> would recommend sticking to always having a trailing comma or no
> trailing comma.

Makes sense, I will fix that. Perhaps after the array square brackets as we=
ll.

>
>> +        ],
>> +    ) =3D> {
>> +        $crate::configfs_attrs!(
>> +            count:
>> +            @container($container),
>> +            @data($data),
>> +            @child(),
>> +            @no_child(x),
>> +            @attrs($($name $attr)*),
>> +            @eat($($name $attr,)*),
>> +            @assign(),
>> +            @cnt(0usize),
>> +        )
>> +    };
>> +    (
>> +        container: $container:ty,
>> +        data: $data:ty,
>> +        child: $child:ty,
>> +        attributes: [
>> +            $($name:ident: $attr:literal,)*
>
> Ditto.
>
>> +        ],
>> +    ) =3D> {
>> +        $crate::configfs_attrs!(
>> +            count:
>> +            @container($container),
>> +            @data($data),
>> +            @child($child),
>> +            @no_child(),
>> +            @attrs($($name $attr)*),
>> +            @eat($($name $attr,)*),
>> +            @assign(),
>> +            @cnt(0usize),
>> +        )
>> +    };
>> +    (count:
>> +     @container($container:ty),
>> +     @data($data:ty),
>> +     @child($($child:ty)?),
>> +     @no_child($($no_child:ident)?),
>> +     @attrs($($aname:ident $aattr:literal)*),
>> +     @eat($name:ident $attr:literal, $($rname:ident $rattr:literal,)*),
>> +     @assign($($assign:block)*),
>> +     @cnt($cnt:expr),
>> +    ) =3D> {
>> +        $crate::configfs_attrs!(
>> +            count:
>> +            @container($container),
>> +            @data($data),
>> +            @child($($child)?),
>> +            @no_child($($no_child)?),
>> +            @attrs($($aname $aattr)*),
>> +            @eat($($rname $rattr,)*),
>> +            @assign($($assign)* {
>> +                const N: usize =3D $cnt;
>> +                // SAFETY: We are expanding `configfs_attrs`.
>
> This safety comment is doing a lot of heavy lifting, since it is not at
> all obvious what the below unsafe function will resolve to... Seems also
> a hassle to put a full comment here explaining that
> `[< $data:upper _ATTRS >]` is defined by the macro below and that it is
> of type `AttributeList` etc... But maybe we should.

I mean, I can put a comment saying that this will expand to a call to `Attr=
ibute::add`?

>
>> +                unsafe {
>> +                    $crate::macros::paste!( [< $data:upper _ATTRS >])
>> +                        .add::<N, $attr, _>(
>> +                            & $crate::macros::paste!( [< $data:upper _ =
$name:upper _ATTR >])
>> +                        )
>> +                };
>> +            }),
>
> You can merge the two `paste!` invocations into one:

Is that better?

>
>     @assign($($assign)* {
>         const N: usize =3D $cnt;
>         $crate::macros::paste! {
>             // SAFETY: see above comment
>             unsafe {
>                 [< $data:upper _ATTRS >].add::<N, $attr, _>(
>                     &[< $data:upper _ $name:upper _ATTR >]
>                 );
>             }
>         }
>     }),
>
>> +            @cnt(1usize + $cnt),
>> +        )
>> +    };
>> +    (count:
>> +     @container($container:ty),
>> +     @data($data:ty),
>> +     @child($($child:ty)?),
>> +     @no_child($($no_child:ident)?),
>> +     @attrs($($aname:ident $aattr:literal)*),
>> +     @eat(),
>> +     @assign($($assign:block)*),
>> +     @cnt($cnt:expr),
>> +    ) =3D>
>> +    {
>> +        $crate::configfs_attrs!(
>> +            final:
>> +            @container($container),
>> +            @data($data),
>> +            @child($($child)?),
>> +            @no_child($($no_child)?),
>> +            @attrs($($aname $aattr)*),
>> +            @assign($($assign)*),
>> +            @cnt($cnt),
>> +        )
>> +    };
>> +    (final:
>> +     @container($container:ty),
>> +     @data($data:ty),
>> +     @child($($child:ty)?),
>> +     @no_child($($no_child:ident)?),
>> +     @attrs($($name:ident $attr:literal)*),
>> +     @assign($($assign:block)*),
>> +     @cnt($cnt:expr),
>> +    ) =3D>
>> +    {
>> +        {
>> +            $(
>> +                $crate::macros::paste!{
>
> Again you can coalesce all of the `paste!` invocations into a single one
> spanning the entire output of this macro branch.

Is that better? I actually tried to keep them smaller.

>
>> +                    // SAFETY: We are expanding `configfs_attrs`.
>> +                    static [< $data:upper _ $name:upper _ATTR >]:
>> +                      $crate::configfs::Attribute<$attr, $data, $data> =
=3D
>> +                        unsafe {
>> +                            $crate::configfs::Attribute::new(c_str!(::c=
ore::stringify!($name)))
>> +                        };
>> +                }
>> +            )*
>> +
>> +
>> +            const N: usize =3D $cnt + 1usize;
>
> Why do we need an additional copy? To have a zero entry at the end for C
> to know it's the end of the list? If so, a comment here would be very
> helpful.

Yes, we need space for a null terminator. I'll add a comment.

We actually have a static check to make sure that we not missing this.

>
>> +            $crate::macros::paste!{
>> +                // SAFETY: We are expanding `configfs_attrs`.
>> +                static [< $data:upper _ATTRS >]:
>> +                  $crate::configfs::AttributeList<N, $data> =3D
>> +                    unsafe { $crate::configfs::AttributeList::new() };
>> +            }
>> +
>> +            $($assign)*
>> +
>> +            $(
>> +                $crate::macros::paste!{
>> +                    const [<$no_child:upper>]: bool =3D true;
>> +                };
>> +
>> +                $crate::macros::paste!{
>> +                    static [< $data:upper _TPE >] : $crate::configfs::I=
temType<$container, $data>  =3D
>> +                        $crate::configfs::ItemType::<$container, $data>=
::new::<N>(
>> +                            &THIS_MODULE, &[<$ data:upper _ATTRS >]
>> +                        );
>> +                }
>> +            )?
>> +
>> +            $(
>> +                $crate::macros::paste!{
>> +                    static [< $data:upper _TPE >]:
>> +                      $crate::configfs::ItemType<$container, $data>  =3D
>> +                        $crate::configfs::ItemType::<$container, $data>=
::new_with_child_ctor::
>> +                    <N, $child>(
>> +                        &THIS_MODULE, &[<$ data:upper _ATTRS >]
>> +                    );
>> +                }
>> +            )?
>> +
>> +            &$crate::macros::paste!( [< $data:upper _TPE >] )
>> +        }
>> +    };
>> +
>> +}
>
> I tested if multiple invocations of this macro can shadow each other and
> the answer is no. So wrapping a const with `{}` makes it inaccessible to
> the outside which is exactly what we need here.
> The macro looks quite good!

Well you can guess where the inspiration came from :)

>

[...]

>> diff --git a/samples/rust/rust_configfs.rs b/samples/rust/rust_configfs.=
rs
>> new file mode 100644
>> index 0000000000000..fe896e66efb41
>> --- /dev/null
>> +++ b/samples/rust/rust_configfs.rs
>> @@ -0,0 +1,186 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +
>> +//! Rust configfs sample.
>> +
>> +use kernel::alloc::flags;
>> +use kernel::c_str;
>> +use kernel::configfs;
>> +use kernel::configfs_attrs;
>> +use kernel::new_mutex;
>> +use kernel::prelude::*;
>> +use kernel::sync::Mutex;
>
> Would merge the imports here too (rust-analyzer has a code-action for
> that btw).

I prefer it like this.

>
>> +
>> +module! {
>> +    type: RustConfigfs,
>> +    name: "rust_configfs",
>> +    author: "Rust for Linux Contributors",
>> +    description: "Rust configfs sample",
>> +    license: "GPL",
>> +}
>> +
>> +#[pin_data]
>> +struct RustConfigfs {
>> +    #[pin]
>> +    config: configfs::Subsystem<Configuration>,
>> +}
>> +
>> +#[pin_data]
>> +struct Configuration {
>> +    message: &'static CStr,
>> +    #[pin]
>> +    bar: Mutex<(KBox<[u8; 4096]>, usize)>,
>> +}
>> +
>> +impl Configuration {
>> +    fn new() -> impl PinInit<Self, Error> {
>> +        try_pin_init!(Self {
>> +            message: c_str!("Hello World\n"),
>> +            bar <- new_mutex!((KBox::new([0;4096], flags::GFP_KERNEL)?,=
0)),
>
> s/;/; /
> s/,0/, 0/

=F0=9F=91=8D


Thanks for the detailed review!


Best regards,
Andreas Hindborg



