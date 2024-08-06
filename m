Return-Path: <linux-kernel+bounces-276821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D4C99498CC
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 22:06:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52DF4285196
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 20:06:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA21813A26F;
	Tue,  6 Aug 2024 20:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="hUljjdFv"
Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D487E107
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 20:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722974787; cv=none; b=N2y0RMKvhPwuYxSbOZDLzDmQ5F7u+hhoyXLOK8psIkpfe9c/jELpQVMEzj+hnxE9ipnNFYGPYuefPVab7RvaN8SWIA7cLNyRqAb2HueVKjseWTV0H+9PMPk62i0M8hj7p6CmCdzJ0F0zR8HpP4SfWUDi3QWCx1bln2rimoUd4YI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722974787; c=relaxed/simple;
	bh=IKYOZbw4b3sfUQOjlQtHc6E9iRuq9IVXdRbGrKLaubE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Yf+N/C/kOi+PHSDei3T7DJcLRb/bz3x0wArEy4c0r2j2wwYnYv1r0Ajf2rxfEH4zfm8H44czkhI1PtlAgmLUSLALXKVzXcYqJStBF5TBz7NRZUjlOx7f6JntDjIMNkyeJuaphTA/2KeoCwOUPBYQqGKcCdqHPWq/M1LLJu0gsvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=hUljjdFv; arc=none smtp.client-ip=185.70.40.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1722974783; x=1723233983;
	bh=BEp+Ok7ns1khFFw/7oQ6W9g8MQDCUF+avxja+9dnehs=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=hUljjdFvml1sf897XAk4tlnzbuYPq8kOmc1veVP0bGzl1Zl0r69nWgnuPO0V6RJ5p
	 KvgK9TkGttfAvleiEbd6Ggf/N3O9xCvf336DmIhCTFAXhhDGrnYQOUKe0BqDL4PrqW
	 04KnUFPZTKmfZ84fD6r9/VloGzq+xXd4NbWnPkRzgQC4b+WXCEyZZd/RV3UE5bEqV4
	 BUP4ajmNNL+UcJ5f1LHs8jaeBx/4rPayiqnbi6R4I9PY6tIiDHV7/bflBoDB4ksDIv
	 kSorqBdUjrGdXZrnwZX6bTTaVQ8k8wyEHs9+0mtK66bVNji7YSDs2+7KbKBGQZ2hTh
	 aRmhBUUVh9YsA==
Date: Tue, 06 Aug 2024 20:04:30 +0000
To: Danilo Krummrich <dakr@kernel.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, a.hindborg@samsung.com, aliceryhl@google.com, akpm@linux-foundation.org, daniel.almeida@collabora.com, faith.ekstrand@collabora.com, boris.brezillon@collabora.com, lina@asahilina.net, mcanal@igalia.com, zhiw@nvidia.com, acurrid@nvidia.com, cjia@nvidia.com, jhubbard@nvidia.com, airlied@redhat.com, ajanulgu@redhat.com, lyude@redhat.com, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v4 01/28] rust: alloc: add `Allocator` trait
Message-ID: <52b1a806-48c7-4ae2-b78c-ca0e8bf5e1d7@proton.me>
In-Reply-To: <ZrJrzYXM9RffF4kf@pollux.localdomain>
References: <20240805152004.5039-1-dakr@kernel.org> <20240805152004.5039-2-dakr@kernel.org> <470b5f70-b592-43a7-81ba-c7f1c852b9f3@proton.me> <ZrJrzYXM9RffF4kf@pollux.localdomain>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 44ac63e58347b550cdf496d1eba7972a808d8028
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06.08.24 20:30, Danilo Krummrich wrote:
> On Tue, Aug 06, 2024 at 04:03:49PM +0000, Benno Lossin wrote:
>> On 05.08.24 17:19, Danilo Krummrich wrote:
>>> Add a kernel specific `Allocator` trait, that in contrast to the one in
>>> Rust's core library doesn't require unstable features and supports GFP
>>> flags.
>>>
>>> Subsequent patches add the following trait implementors: `Kmalloc`,
>>> `Vmalloc` and `KVmalloc`.
>>>
>>> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
>>> ---
>>>  rust/kernel/alloc.rs | 79 ++++++++++++++++++++++++++++++++++++++++++++
>>>  1 file changed, 79 insertions(+)
>>>
>>> diff --git a/rust/kernel/alloc.rs b/rust/kernel/alloc.rs
>>> index 1966bd407017..8a71a589469d 100644
>>> --- a/rust/kernel/alloc.rs
>>> +++ b/rust/kernel/alloc.rs
>>> @@ -11,6 +11,7 @@
>>>  /// Indicates an allocation error.
>>>  #[derive(Copy, Clone, PartialEq, Eq, Debug)]
>>>  pub struct AllocError;
>>> +use core::{alloc::Layout, ptr::NonNull};
>>>
>>>  /// Flags to be used when allocating memory.
>>>  ///
>>> @@ -86,3 +87,81 @@ pub mod flags {
>>>      /// small allocations.
>>>      pub const GFP_NOWAIT: Flags =3D Flags(bindings::GFP_NOWAIT);
>>>  }
>>> +
>>> +/// The kernel's [`Allocator`] trait.
>>> +///
>>> +/// An implementation of [`Allocator`] can allocate, re-allocate and f=
ree memory buffer described
>>> +/// via [`Layout`].
>>> +///
>>> +/// [`Allocator`] is designed to be implemented as a ZST; [`Allocator`=
] functions do not operate on
>>> +/// an object instance.
>>
>> This will prevent us from implementing arena-type allocators [^1]. Do we
>> want/need those?
>=20
> I'm not aware of any code in the kernel that does exactly this, but kmem_=
cache
> is rather close to that.
>=20
>> I have heard that some people use them in embedded systems, but I can't
>> say for sure. But this is a rather big design decision, so we should
>> discuss it now.
>>
>> [^1]: For those who don't know what I mean by that here is a quick
>> sketch (without handling flags and optimizations):
>>
>>     pub struct ArenaAlloc<const SIZE: usize> {
>>         memory: Opaque<[u8; SIZE]>,
>>         head: Cell<usize>,
>>     }
>>
>>     impl<const SIZE: usize> ArenaAlloc<SIZE> {
>>         pub fn new() -> Self {
>>             Self {
>>                 memory: Opaque::uninit(),
>>                 head: 0,
>>             }
>>         }
>>     }
>>
>>     impl<const SIZE: usize> Allocator for ArenaAlloc<SIZE> {
>>         fn alloc(&self, layout: Layout, _flags: Flags) -> Result<NonNull=
<u8>, AllocError> {
>>             let head =3D self.head.get();
>>             if head + layout.size() >=3D SIZE {
>>                 return Err(AllocError);
>>             }
>>             let ptr =3D self.memory.get();
>>             let ptr =3D ptr.cast::<u8>();
>>             let ptr =3D unsafe { ptr.add(head) };
>>             self.head.set(head + layout.size());
>>             unsafe { NonNull::new_unchecked(ptr) }
>>         }
>>
>>         unsafe fn realloc(
>>             &self,
>>             ptr: Option<NonNull<u8>>,
>>             old_layout: Layout, // Note that we also need `old_layout`!
>>             layout: Layout,
>>             flags: Flags
>>         ) -> Result<NonNull<u8>, AllocError> {
>>             let new =3D self.alloc(layout, flags)?;
>>             let Some(ptr) =3D ptr else { return Ok(new); };
>>             unsafe { core::ptr::copy_nonoverlapping(ptr.as_ptr(), new.as=
_ptr(), old_layout.size()) };
>>             self.free(ptr);
>>             Ok(new)
>>         }
>>
>>         fn free(&self, ptr: NonNull<u8>) { /* noop */ }
>>     }
>>
>>> +///
>>> +/// In order to be able to support `#[derive(SmartPointer)]` later on,=
 we need to avoid a design
>>> +/// that requires an `Allocator` to be instantiated, hence its functio=
ns must not contain any kind
>>> +/// of `self` parameter.
>>
>> Ah I see, so since `#[derive(SmartPointer)]` needs `Box` to only consist
>> of one non ZST field... I skimmed the RFC discussion and it seems like a
>> problem that *might* be solved in the future, but probably not in the
>> (very) near future. I guess this is just a bullet that we have to bite.
>> We can always have an `ArenaBox` that can deal with that (although
>> without `DispatchFromDyn`).
>> We should revisit this when `#[derive(SmartPointer)]` becomes advanced
>> enough.
>=20
> Agreed.

I opened https://github.com/Rust-for-Linux/linux/issues/1095 to track
this.

>>> +///
>>> +/// # Safety
>>> +///
>>> +/// Memory returned from an allocator must point to a valid memory buf=
fer and remain valid until
>>> +/// it is explicitly freed.
>>> +///
>>> +/// Any pointer to a memory buffer which is currently allocated must b=
e valid to be passed to any
>>> +/// other [`Allocator`] function of the same type. The same applies fo=
r a NULL pointer.
>>> +///
>>> +/// If `realloc` is called with:
>>> +///   - a size of zero, the given memory allocation, if any, must be f=
reed
>>> +///   - a NULL pointer, a new memory allocation must be created
>>> +pub unsafe trait Allocator {
>>> +    /// Allocate memory based on `layout` and `flags`.
>>> +    ///
>>> +    /// On success, returns a buffer represented as `NonNull<[u8]>` th=
at satisfies the layout
>>> +    /// constraints (i.e. minimum size and alignment as specified by `=
layout`).
>>> +    ///
>>> +    /// This function is equivalent to `realloc` when called with a NU=
LL pointer.
>>> +    fn alloc(layout: Layout, flags: Flags) -> Result<NonNull<[u8]>, Al=
locError> {
>>> +        // SAFETY: Passing a NULL pointer to `realloc` is valid by it'=
s safety requirements and asks
>>> +        // for a new memory allocation.
>>> +        unsafe { Self::realloc(None, layout, flags) }
>>> +    }
>>> +
>>> +    /// Re-allocate an existing memory allocation to satisfy the reque=
sted `layout`. If the
>>> +    /// requested size is zero, `realloc` behaves equivalent to `free`=
.
>>> +    ///
>>> +    /// If the requested size is larger than the size of the existing =
allocation, a successful call
>>> +    /// to `realloc` guarantees that the new or grown buffer has at le=
ast `Layout::size` bytes, but
>>> +    /// may also be larger.
>>> +    ///
>>> +    /// If the requested size is smaller than the size of the existing=
 allocation, `realloc` may or
>>> +    /// may not shrink the buffer; this is implementation specific to =
the allocator.
>>> +    ///
>>> +    /// On allocation failure, the existing buffer, if any, remains va=
lid.
>>> +    ///
>>> +    /// The buffer is represented as `NonNull<[u8]>`.
>>> +    ///
>>> +    /// # Safety
>>> +    ///
>>> +    /// `Some(ptr)` must point to an existing and valid memory allocat=
ion created by this allocator
>>
>> This is the wrong way around, `ptr: Option<NonNull<u8>>`, so
>> `Some(ptr): Option<Option<NonNull<u8>>>`. Instead I would write
>> "If `ptr =3D Some(p)`, then `p` must point to...".
>=20
> Yes, makes sense.
>=20
>>
>>> +    /// instance. The alignment encoded in `layout` must be smaller th=
an or equal to the alignment
>>> +    /// requested in the previous `alloc` or `realloc` call of the sam=
e allocation.
>>> +    ///
>>> +    /// Additionally, `ptr` is allowed to be `None`; in this case a ne=
w memory allocation is
>>> +    /// created.
>>> +    ///
>>> +    unsafe fn realloc(
>>> +        ptr: Option<NonNull<u8>>,
>>> +        layout: Layout,
>>> +        flags: Flags,
>>> +    ) -> Result<NonNull<[u8]>, AllocError>;
>>> +
>>> +    /// Free an existing memory allocation.
>>> +    ///
>>> +    /// # Safety
>>> +    ///
>>> +    /// `ptr` must point to an existing and valid memory allocation cr=
eated by this `Allocator`
>>> +    /// instance.
>>
>> Additionally, you need "The memory allocation at `ptr` must never again
>> be read from or written to.".
>=20
> I'm fine adding it, but I wonder if technically this is really required? =
The
> condition whether the pointer is ever accessed again in any way is not re=
levant
> in terms of being a precondition for `free` not causing UB, right?

I don't see how else we would find the mistake in the following code:

    let ptr =3D Box::into_raw(Box::<i32, Kmalloc>::new(42));
    // SAFETY: `ptr` came from `Box::into_raw` and thus is pointing to a
    // valid and existing memory allocation allocated by `Kmalloc`.
    unsafe { Kmalloc::free(ptr) };
    // SAFETY: `ptr` came from `Box::into_raw` and thus is pointing at a
    // valid `i32`.
    let v =3D unsafe { ptr.read() };

Also see the `from_raw` for our `Arc`:

    /// Recreates an [`Arc`] instance previously deconstructed via [`Arc::i=
nto_raw`].
    ///
    /// # Safety
    ///
    /// `ptr` must have been returned by a previous call to [`Arc::into_raw=
`]. Additionally, it
    /// must not be called more than once for each previous call to [`Arc::=
into_raw`].
    pub unsafe fn from_raw(ptr: *const T) -> Self {

That also requires that the function must not be called more than once.
This reminds me, I forgot to say that about `Box::from_raw`.

---
Cheers,
Benno


