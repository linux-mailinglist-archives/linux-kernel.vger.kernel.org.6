Return-Path: <linux-kernel+bounces-324482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7838F974D01
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 10:46:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C66F4B20E62
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 08:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D71F815B0FE;
	Wed, 11 Sep 2024 08:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="RNIEY2pl"
Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0145C52F9E;
	Wed, 11 Sep 2024 08:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726044382; cv=none; b=PnDLfL0Tz62Xx9Ox9gn7s5/QNJ/sKuf+NzpKMs7+D0h5q6sg2qjPWNn2qD78MjO7W5buDmTqMqil15fperOlMDAb3LSoQrKI4Rhvy/WUt0XYoxF9z+74C8uhiWe9VfwM7DOGKNcSwSXy7Z3T8IqX/eWP+COn1Qg5wFuUh44IBCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726044382; c=relaxed/simple;
	bh=TTHV4zVctrePkkvrqh7YikqOA/3lxVZ8aOvJBrzcoAM=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cwp8YFsniFceTkQNI/W3BYcrAJQt5WONahexvTWAhwFr7Hh2JLCG0N6sB0mKSKY/l2yBbg/yCqpPMVsO0NFfZwxDdDmjgM0zMAnH8T0aTZliDSSkRtb0Vry1h+/8631bolNOGodK6P3WKvXCpYY1nFViRS0dq2fnM7/Wi2F8aaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=RNIEY2pl; arc=none smtp.client-ip=185.70.40.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1726044377; x=1726303577;
	bh=34zMZyYnOjGwEsDtBreqI075Rfehln50WRz0u2TgMuY=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=RNIEY2pliTlOKVOROFGu4sfCi6Kn5721NaUGagNhLWbKOYt4WJEAGyDOAc7GqnL6K
	 1WyPMy/YVll2/Vr1ZhnoD9jzByjKzzEvmnyqdscHergtPaXVc9NFQl2jQVsIzCA7ux
	 3XLQHDsP+crndeDDrY5dg9WscKiyrlfVwudU/AXFAK1kMGwr0e+xLF7Oq/dS2i91Qw
	 nvITOijrD0TmWPbLkO2MWHCMhB3h3s7lZ7kYCgDqnLWYWJJQYnwizkj9mGjz6sqSF/
	 k3nskkkWsGaIN4Aq7DH5sLvDumzBq6aASAqiFheYfOf7nITVTvJ0XezpbKiTssh7rj
	 Bxl+FotNE+RoQ==
Date: Wed, 11 Sep 2024 08:46:11 +0000
To: Danilo Krummrich <dakr@kernel.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, a.hindborg@samsung.com, aliceryhl@google.com, akpm@linux-foundation.org, daniel.almeida@collabora.com, faith.ekstrand@collabora.com, boris.brezillon@collabora.com, lina@asahilina.net, mcanal@igalia.com, zhiw@nvidia.com, cjia@nvidia.com, jhubbard@nvidia.com, airlied@redhat.com, ajanulgu@redhat.com, lyude@redhat.com, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v6 13/26] rust: alloc: implement kernel `Vec` type
Message-ID: <1ecebc7f-a1a5-488b-832c-40471fa3e61e@proton.me>
In-Reply-To: <ZuDh3arCtEK66uxB@pollux>
References: <20240816001216.26575-1-dakr@kernel.org> <20240816001216.26575-14-dakr@kernel.org> <fe19f450-ddb4-4f50-a016-9f213b22f633@proton.me> <ZuDh3arCtEK66uxB@pollux>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 6a9244cdd4ff465f6a6d470cfb1f6a82be4ea609
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 11.09.24 02:18, Danilo Krummrich wrote:
> On Tue, Sep 10, 2024 at 07:32:06PM +0000, Benno Lossin wrote:
>> On 16.08.24 02:10, Danilo Krummrich wrote:
>>> +    ($elem:expr; $n:expr) =3D> (
>>> +        {
>>> +            $crate::alloc::KVec::from_elem($elem, $n, GFP_KERNEL)
>>
>> Hmm, could it be that one might want to use `kvec!` without
>> `GFP_KERNEL`?
>> Or add additional flags, eg __GFP_ZERO?
>=20
> Pretty unlikely, I'd say. __GFP_ZERO in particular wouldn't make much sen=
se,
> since the macro enforces initialization anyways.
>=20
> Maybe something like GFP_ATOMIC, but I expect this to be uncommon enough =
to not
> consider this for this macro for now.

SGTM

>> If you think that supporting this is not immediately necessary or if
>> this is too much for this patchset, then we can also postpone it (maybe
>> it could be a good-first-issue). Do you keep a list of future
>> improvements for the new allocator API somewhere? If not, then I think
>> we should create one (best place would be the issue tracker on GH).
>=20
> I would only add it if it turns out to be a common need. As mentioned, I =
don't
> expect it to be.
>=20
> I'd rather keep issues in the source tree. For instance, DRM has them in
> '/Documentation/gpu/todo.rst'.

But then you need to submit patches to change them... That sounds like a
hassle and we already have the precedent to use the github issue
tracker. It is also much better for discoverability for people outside
of the kernel.

>>> +        }
>>> +    );
>>> +    ($($x:expr),+ $(,)?) =3D> (
>>> +        {
>>> +            match $crate::alloc::KBox::new_uninit(GFP_KERNEL) {
>>> +                Ok(b) =3D> Ok($crate::alloc::KVec::from($crate::alloc:=
:KBox::write(b, [$($x),+]))),
>>> +                Err(e) =3D> Err(e),
>>> +            }
>>> +        }
>>> +    );
>>> +}
>>> +
>>> +/// The kernel's [`Vec`] type.
>>> +///
>>> +/// A contiguous growable array type with contents allocated with the =
kernel's allocators (e.g.
>>> +/// `Kmalloc`, `Vmalloc` or `KVmalloc`), written `Vec<T, A>`.
>>
>> New folks might get confused as to which allocator they should choose.
>> Do we have a sensible default for `Vec`?
>=20
> Then they should read the documentation about the kernel's allocators. We
> already link them in rust/kernel/alloc/allocator.rs.
>=20
>> If yes, then we at least should document that here. We might also want
>> to make it the default value for the generic parameter.
>> This is also a good idea for `Box`.
>=20
> If we really want a default it should be `Kmalloc`, but I really think we=
 should
> force people to make an explicit decision and think about it and don't ju=
st go
> with whatever default.
>=20
> It makes it also easier to grep for things. :)

SGTM

>>> +///
>>> +/// For non-zero-sized values, a [`Vec`] will use the given allocator =
`A` for its allocation. For
>>> +/// the most common allocators the type aliases `KVec`, `VVec` and `KV=
Vec` exist.
>>> +///
>>> +/// For zero-sized types the [`Vec`]'s pointer must be `dangling_mut::=
<T>`; no memory is allocated.
>>> +///
>>> +/// Generally, [`Vec`] consists of a pointer that represents the vecto=
r's backing buffer, the
>>> +/// capacity of the vector (the number of elements that currently fit =
into the vector), it's length
>>> +/// (the number of elements that are currently stored in the vector) a=
nd the `Allocator` type used
>>> +/// to allocate (and free) the backing buffer.
>>> +///
>>> +/// A [`Vec`] can be deconstructed into and (re-)constructed from it's=
 previously named raw parts
>>> +/// and manually modified.
>>> +///
>>> +/// [`Vec`]'s backing buffer gets, if required, automatically increase=
d (re-allocated) when elements
>>> +/// are added to the vector.
>>> +///
>>> +/// # Invariants
>>> +///
>>> +/// The [`Vec`] backing buffer's pointer is always properly aligned an=
d either points to memory
>>> +/// allocated with `A` or, for zero-sized types, is a dangling pointer=
.
>>
>> Just use `self.ptr` instead of "backing buffer".
>>
>>> +///
>>> +/// The length of the vector always represents the exact number of ele=
ments stored in the vector.
>>
>> Same here, `self.len`.
>>
>>> +///
>>> +/// The capacity of the vector always represents the absolute number o=
f elements that can be stored
>>
>> Ditto.
>>
>>> +/// within the vector without re-allocation. However, it is legal for =
the backing buffer to be
>>> +/// larger than `size_of<T>` times the capacity.
>>> +///
>>> +/// The `Allocator` type `A` of the vector is the exact same `Allocato=
r` type the backing buffer was
>>> +/// allocated with (and must be freed with).
>>
>> Please turn this into a bullet-point list.
>=20
> Is this a rule? Do we want to make it one?

I am trying to make it one with my safety standard.

>>> +pub struct Vec<T, A: Allocator> {
>>> +    ptr: NonNull<T>,
>>> +    /// Represents the actual buffer size as `cap` times `size_of::<T>=
` bytes.
>>> +    ///
>>> +    /// Note: This isn't quite the same as `Self::capacity`, which in =
contrast returns the number of
>>> +    /// elements we can still store without reallocating.
>>> +    ///
>>> +    /// # Invariants
>>> +    ///
>>> +    /// `cap` must be in the `0..=3Disize::MAX` range.
>>> +    cap: usize,
>>> +    len: usize,
>>> +    _p: PhantomData<A>,
>>> +}



>>> +    /// Creates a new, empty Vec<T, A>.
>>> +    ///
>>> +    /// This method does not allocate by itself.
>>> +    #[inline]
>>> +    pub const fn new() -> Self {
>>> +        Self {
>>> +            ptr: NonNull::dangling(),
>>> +            cap: 0,
>>> +            len: 0,
>>> +            _p: PhantomData::<A>,
>>> +        }
>>> +    }
>>> +
>>> +    /// Returns a slice of `MaybeUninit<T>` for the remaining spare ca=
pacity of the vector.
>>
>> Returns
>=20
> Hm?

Forgot to finish that sentence, since I couldn't really pinpoint what
exactly I wanted to change. Just ignore it.

>>> +    pub fn spare_capacity_mut(&mut self) -> &mut [MaybeUninit<T>] {
>>> +        // SAFETY: The memory between `self.len` and `self.capacity` i=
s guaranteed to be allocated
>>> +        // and valid, but uninitialized.
>>> +        unsafe {
>>> +            slice::from_raw_parts_mut(
>>> +                self.as_mut_ptr().add(self.len) as *mut MaybeUninit<T>=
,
>>> +                self.capacity() - self.len,
>>> +            )
>>> +        }



>>> +    ///
>>> +    /// Otherwise:
>>> +    ///
>>> +    /// - `ptr` must have been allocated with the allocator `A`.
>>> +    /// - `ptr` must satisfy or exceed the alignment requirements of `=
T`.
>>> +    /// - `ptr` must point to memory with a size of at least `size_of:=
:<T>` times the `capacity`
>>> +    ///    bytes.
>>
>> Just write "`size_of::<T>() * capacity` bytes".
>>
>>> +    /// - The allocated size in bytes must not be larger than `isize::=
MAX`.
>>
>> Should we make this a safety requirement of `Allocator`? I think this is
>> generally the maximum size other allocated things can have anyways.
>=20
>=20
>=20
>>
>>> +    /// - `length` must be less than or equal to `capacity`.
>>> +    /// - The first `length` elements must be initialized values of ty=
pe `T`.
>>> +    ///
>>> +    /// It is also valid to create an empty `Vec` passing a dangling p=
ointer for `ptr` and zero for
>>> +    /// `cap` and `len`.
>>
>> Can you make this last sentence part of the `if` chain that you have
>> above (ie the one started with "If `T` is a ZST:").
>=20
> But `T` isn't necessarily a ZST, but it may be.

I originally meant adding an "else if" part that checks for empty
capacity. But you could just add that to the if at the top ie "If
`capacity =3D=3D 0` or `T` is a ZST".

>> Just to experiment with the suggestion from Kangrejos to use Rust as the
>> language for safety documentation, here is what it could look like (we
>> should discuss it more before we start using it):
>>
>>     /// # Safety
>>     ///
>>     /// ```ignore
>>     /// assert!(ptr.is_aligned_to(align_of::<T>()));
>>     /// assert!(!ptr.is_null());
>>     /// assert!(length <=3D capacity);
>>     /// if capacity !=3D 0 && size_of::<T>() !=3D 0 {
>>     ///     assert!(A::did_allocate(ptr));
>>     ///     assert!(size_of::<T>() * capacity <=3D A::layout_of(ptr).len=
());
>>     ///     assert!(is_initialized(ptr::slice_from_raw_parts(ptr, length=
)));
>>     /// }
>>     /// ```
>>
>> I really like how this looks! We might want to add labels/names to each
>> of the conditions and then one could use those in the justifications. A
>> tool could then read those and match them to the requirements of the
>> unsafe operation.
>=20
> I need to think about this a bit more, but at a first glance I think I li=
ke it.
>=20
> The tool would ideally be the compiler itself...

Yes! There is the contracts draft PR that might add support for
this: https://github.com/rust-lang/rust/pull/128045

---
Cheers,
Benno


