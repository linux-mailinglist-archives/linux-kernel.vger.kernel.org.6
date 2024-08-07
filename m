Return-Path: <linux-kernel+bounces-277481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0276794A1FD
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 09:49:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 787861F22323
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 07:49:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 586181C8237;
	Wed,  7 Aug 2024 07:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="ESkrINZf"
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C0061B86F6
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 07:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723016981; cv=none; b=X8DhXoMMpmYJ5TerOn3qVeJa+VKmfnvGj1fn6UmiSFE8ByWap+aiwmq95V1L80MAEFCzd/wJVS6Ea7o5w4wggMhgpGDb8JTmCMz4dGCFExpTK2iXQov2H1TGkhH+gCi7t9BD+cpUOg9mHIvpr7IhYQhA+ocHTcT4+idrCnQPkRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723016981; c=relaxed/simple;
	bh=AtSMikYPbBsN7EX2uJCJNwoWIhOla1VNMORWy4ZE3Xs=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I+pc5wz5j4pt149mjnodFK8HQlTP2sysj6dvSnLl0ldo+SKl9yQlXdimejtq6pNVAWiiJbfUDIf7MTine+Mhic8UQxyf1HNVRSBjItB3tt1sllmEXU4Pckl8np8/0nIo81tKmnoYvnzw806WCeweaCAAPuPORar3Te0zj7CJqUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=ESkrINZf; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=jjo7okhk4bd5xlxwjvmqjlmsri.protonmail; t=1723016975; x=1723276175;
	bh=zBCPE3NGiGOjZc5Grmpw5CKSD7r3L/ZDXenfhDM3DkI=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=ESkrINZfeZgJ40myLSrpcPaj8TpL18NgGs60QGjNmpsPj46TAgOxbEQZYb7VF9d5B
	 EuKyFn7lCURfmu/iArCzZrN2A+uvpvRMgRcKu/cgWc4Hp9q6+JSgOp1BKJdV/zl3an
	 UeSrbQOWzlHFQGFqhwd3Ug3go/aqfOu6gJwYc5rKUaXJKN3T4V1vxZ7ofbrP0m5J3q
	 5KLi1TRaqkqG2xPKB79e3XdLXJ/upbv+z0gOKA32V2ibv6uqiZJcHv548yg9ZxWgbm
	 giWE8gE2/q0nUVz+es+n2nHuVP/5ffX3BIHnHjL9nt9JzhD4Tdgw3fw7CeKtq4kNCL
	 Z1plqIOjgXUfw==
Date: Wed, 07 Aug 2024 07:49:31 +0000
To: Danilo Krummrich <dakr@kernel.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, a.hindborg@samsung.com, aliceryhl@google.com, akpm@linux-foundation.org, daniel.almeida@collabora.com, faith.ekstrand@collabora.com, boris.brezillon@collabora.com, lina@asahilina.net, mcanal@igalia.com, zhiw@nvidia.com, acurrid@nvidia.com, cjia@nvidia.com, jhubbard@nvidia.com, airlied@redhat.com, ajanulgu@redhat.com, lyude@redhat.com, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v4 09/28] rust: alloc: implement kernel `Box`
Message-ID: <012f5a12-2408-4658-8318-55fa8d4285e1@proton.me>
In-Reply-To: <ZrKrMrg5E85y7jkj@pollux>
References: <20240805152004.5039-1-dakr@kernel.org> <20240805152004.5039-10-dakr@kernel.org> <a1c1e273-2d40-4114-b3b9-f27c73e3d122@proton.me> <ZrKrMrg5E85y7jkj@pollux>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 89a4322e2e9b2beb7319ac037bd5ea01485a6b59
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07.08.24 01:01, Danilo Krummrich wrote:
> On Tue, Aug 06, 2024 at 07:47:17PM +0000, Benno Lossin wrote:
>> On 05.08.24 17:19, Danilo Krummrich wrote:
>>> `Box` provides the simplest way to allocate memory for a generic type
>>> with one of the kernel's allocators, e.g. `Kmalloc`, `Vmalloc` or
>>> `KVmalloc`.
>>>
>>> In contrast to Rust's `Box` type, the kernel `Box` type considers the
>>> kernel's GFP flags for all appropriate functions, always reports
>>> allocation failures through `Result<_, AllocError>` and remains
>>> independent from unstable features.
>>>
>>> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
>>> ---
>>>  rust/kernel/alloc.rs      |   6 +
>>>  rust/kernel/alloc/kbox.rs | 330 ++++++++++++++++++++++++++++++++++++++
>>>  rust/kernel/init.rs       |  35 +++-
>>>  rust/kernel/prelude.rs    |   2 +-
>>>  rust/kernel/types.rs      |  56 +++++++
>>>  5 files changed, 427 insertions(+), 2 deletions(-)
>>>  create mode 100644 rust/kernel/alloc/kbox.rs
>>>
>>> diff --git a/rust/kernel/alloc.rs b/rust/kernel/alloc.rs
>>> index 942e2755f217..d7beaf0372af 100644
>>> --- a/rust/kernel/alloc.rs
>>> +++ b/rust/kernel/alloc.rs
>>> @@ -5,6 +5,7 @@
>>>  #[cfg(not(any(test, testlib)))]
>>>  pub mod allocator;
>>>  pub mod box_ext;
>>> +pub mod kbox;
>>>  pub mod vec_ext;
>>>
>>>  #[cfg(any(test, testlib))]
>>> @@ -13,6 +14,11 @@
>>>  #[cfg(any(test, testlib))]
>>>  pub use self::allocator_test as allocator;
>>>
>>> +pub use self::kbox::Box;
>>> +pub use self::kbox::KBox;
>>> +pub use self::kbox::KVBox;
>>> +pub use self::kbox::VBox;
>>> +
>>>  /// Indicates an allocation error.
>>>  #[derive(Copy, Clone, PartialEq, Eq, Debug)]
>>>  pub struct AllocError;
>>> diff --git a/rust/kernel/alloc/kbox.rs b/rust/kernel/alloc/kbox.rs
>>> new file mode 100644
>>> index 000000000000..4a4379980745
>>> --- /dev/null
>>> +++ b/rust/kernel/alloc/kbox.rs
>>> @@ -0,0 +1,330 @@
>>> +// SPDX-License-Identifier: GPL-2.0
>>> +
>>> +//! Implementation of [`Box`].
>>> +
>>> +use super::{AllocError, Allocator, Flags};
>>> +use core::fmt;
>>> +use core::marker::PhantomData;
>>> +use core::mem::ManuallyDrop;
>>> +use core::mem::MaybeUninit;
>>> +use core::ops::{Deref, DerefMut};
>>> +use core::pin::Pin;
>>> +use core::result::Result;
>>> +
>>> +use crate::types::Unique;
>>> +
>>> +/// The kernel's [`Box`] type.
>>> +///
>>> +/// `Box` provides the simplest way to allocate memory for a generic t=
ype with one of the kernel's
>>> +/// allocators, e.g. `Kmalloc`, `Vmalloc` or `KVmalloc`.
>>> +///
>>> +/// For non-zero-sized values, a [`Box`] will use the given allocator =
`A` for its allocation. For
>>> +/// the most common allocators the type aliases `KBox`, `VBox` and `KV=
Box` exist.
>>> +///
>>> +/// It is valid to convert both ways between a [`Box`] and a raw point=
er allocated with any
>>> +/// `Allocator`, given that the `Layout` used with the allocator is co=
rrect for the type.
>>> +///
>>> +/// For zero-sized values the [`Box`]' pointer must be `dangling_mut::=
<T>`; no memory is allocated.
>>
>> Why do we need this to be in the docs?
>=20
> Probably not - do you suggest to remove it entirely? Otherwise, where do =
you
> think we should move it?

I would remove it, since it's just implementation detail and
allocator-dependent.

>>> +impl<T, A> Box<T, A>
>>> +where
>>> +    T: ?Sized,
>>> +    A: Allocator,
>>> +{
>>> +    /// Constructs a `Box<T, A>` from a raw pointer.
>>> +    ///
>>> +    /// # Safety
>>> +    ///
>>> +    /// `raw` must point to valid memory, previously allocated with `A=
`, and at least the size of
>>> +    /// type `T`.
>>
>> With this requirement and the invariant on `Box`, I am lead to believe
>> that you can't use this for ZSTs, since they are not allocated with `A`.
>> One solution would be to adjust this requirement. But I would rather use
>> a different solution: we move the dangling pointer stuff into the
>> allocator and also call it when `T` is a ZST (ie don't special case them
>> in `Box` but in the impls of `Allocator`). That way this can stay as-is
>> and the part about ZSTs in the invariant can be removed.
>=20
> Actually, we already got that. Every zero sized allocation will return a
> dangling pointer. However, we can't call `Allocator::free` with (any) dan=
gling
> pointer though.

The last part is rather problematic in my opinion, since the safety
requirements of the functions in `Allocator` don't ensure that you're
not allowed to do it. We should make it possible to free dangling
pointers that were previously "allocated" by the allocator (ie returned
by `realloc`).
Maybe we do need an `old_layout` parameter for that (that way we can
also `debug_assert_eq!(old_layout.align(), new_layout.align())`).

>>> +    {
>>> +        Ok(Self::new(x, flags)?.into())
>>> +    }
>>> +
>>> +    /// Drops the contents, but keeps the allocation.
>>> +    ///
>>> +    /// # Examples
>>> +    ///
>>> +    /// ```
>>> +    /// let value =3D KBox::new([0; 32], GFP_KERNEL)?;
>>> +    /// assert_eq!(*value, [0; 32]);
>>> +    /// let value =3D KBox::drop_contents(value);
>>> +    /// // Now we can re-use `value`:
>>> +    /// let value =3D KBox::write(value, [1; 32]);
>>> +    /// assert_eq!(*value, [1; 32]);
>>> +    /// # Ok::<(), Error>(())
>>> +    /// ```
>>> +    pub fn drop_contents(this: Self) -> Box<MaybeUninit<T>, A> {
>>> +        let ptr =3D Box::into_raw(this);
>>> +        // SAFETY: `ptr` is valid, because it came from `Box::into_raw=
`.
>>> +        unsafe { core::ptr::drop_in_place(ptr) };
>>> +        // SAFETY: `ptr` is valid, because it came from `Box::into_raw=
`.
>>> +        unsafe { Box::from_raw(ptr.cast()) }
>>> +    }
>>
>> I don't particularly care in this instance, but you just took my patch
>> and folded it into your own without asking me or specifying it in the
>> commit message. In general I would have assumed that you just put the
>> entire patch into the series (with correct From:... etc).
>=20
> When I asked about this in [1] my understanding was that we expect [1] to=
 land
> prior to this series. So, I'm just anticipating a future rebase where I m=
ove
> this code from box_ext.rs to kbox.rs, just like Alice suggested for her
> "ForeignOwnable for Pin<crate::alloc::Box<T, A>>" implementation.
>=20
> I also understand your later reply, where you said: "[...] then you can j=
ust
> include it when you remove the `BoxExit` trait." as confirmation.
>=20
> Probably that's a misunderstanding though. Sorry if that's the case.

Yeah what I meant by that was you base it on top and then move it from
the `BoxExt` trait over to `Box` in a correctly attributed patch. As I
said above, I don't really mind in this case, since it's trivial, so no
worries. Just a heads-up for occasions where it is non-trivial.

> [1] https://lore.kernel.org/lkml/24a8d381-dd13-4d19-a736-689b8880dbe1@pro=
ton.me/
>=20
>>
>>> +}
>>> +
>>> +impl<T, A> From<Box<T, A>> for Pin<Box<T, A>>
>>> +where
>>> +    T: ?Sized,
>>> +    A: Allocator,
>>> +    A: 'static,
>>> +{
>>> +    /// Converts a `Box<T>` into a `Pin<Box<T>>`. If `T` does not impl=
ement [`Unpin`], then
>>> +    /// `*boxed` will be pinned in memory and unable to be moved.
>>> +    ///
>>> +    /// This conversion does not allocate on the heap and happens in p=
lace.
>>> +    ///
>>> +    /// This is also available via [`Box::into_pin`].
>>> +    ///
>>> +    /// Constructing and pinning a `Box` with <code><Pin<Box\<T>>>::fr=
om([Box::new]\(x))</code>
>>> +    /// can also be written more concisely using <code>[Box::pin]\(x)<=
/code>.
>>> +    /// This `From` implementation is useful if you already have a `Bo=
x<T>`, or you are
>>> +    /// constructing a (pinned) `Box` in a different way than with [`B=
ox::new`].
>>
>> This also looks very much like something from the stdlib...
>=20
> Yeah, I'll replace that.
>=20
>>
>>> +    fn from(b: Box<T, A>) -> Self {
>>> +        Box::into_pin(b)
>>> +    }
>>> +}
>>> +
>>> +impl<T, A> Deref for Box<T, A>
>>> +where
>>> +    T: ?Sized,
>>> +    A: Allocator,
>>> +{
>>> +    type Target =3D T;
>>> +
>>> +    fn deref(&self) -> &T {
>>> +        // SAFETY: `self.0` is always properly aligned, dereferenceabl=
e and points to an initialized
>>> +        // instance of `T`.
>>
>> If `T` is a ZST, then it is not dereferenceable.
>=20
> Why not? If `T` is a ZST `self.0` is `Unique::<T>::dangling()`. So, in th=
e end
> this is the same as `NonNull::<T>::dangling().as_ref()`.

You are right, I just looked at [1] again and they define
dereferenceable as "the memory range of the given size starting at the
pointer must all be within the bounds of a single allocated object", for
a zero-sized allocation, this holds vacuously.

[1]: https://doc.rust-lang.org/core/ptr/index.html#safety

>>> +        unsafe { self.0.as_ref() }
>>> +    }
>>> +}
>>> +
>>> +impl<T, A> DerefMut for Box<T, A>
>>> +where
>>> +    T: ?Sized,
>>> +    A: Allocator,
>>> +{
>>> +    fn deref_mut(&mut self) -> &mut T {
>>> +        // SAFETY: `self.0` is always properly aligned, dereferenceabl=
e and points to an initialized
>>> +        // instance of `T`.
>>> +        unsafe { self.0.as_mut() }
>>> +    }
>>> +}
>>> +
>>> +impl<T, A> fmt::Debug for Box<T, A>
>>> +where
>>> +    T: ?Sized + fmt::Debug,
>>> +    A: Allocator,
>>> +{
>>> +    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
>>> +        fmt::Debug::fmt(&**self, f)
>>> +    }
>>> +}
>>> +
>>> +impl<T, A> Drop for Box<T, A>
>>> +where
>>> +    T: ?Sized,
>>> +    A: Allocator,
>>> +{
>>> +    fn drop(&mut self) {
>>> +        let ptr =3D self.0.as_ptr();
>>> +
>>> +        // SAFETY: `ptr` is always properly aligned, dereferenceable a=
nd points to an initialized
>>> +        // instance of `T`.
>>> +        let size =3D unsafe { core::mem::size_of_val(&*ptr) };
>>
>> 1. `size_of_val` is not `unsafe`.
>=20
> Right, but dereferencing the `ptr` is unsafe.
>=20
>> 2. why not use `&*self` instead of using the raw pointer? (then move the
>>    let binding below this line)
>=20
> If we ever support non-ZST `Allocator`s using `self` would not always eva=
luate
> to the correct size. I think evaluating the size of `T` rather than `Box<=
T>` is
> the correct thing to do.

I mean use `Box::deref` (that's what `&*self` should do), you don't need
to repeat the same SAFETY comment when it already is wrapped by a safe
function.

---
Cheers,
Benno


