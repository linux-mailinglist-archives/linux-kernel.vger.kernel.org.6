Return-Path: <linux-kernel+bounces-277447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFC2794A196
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 09:24:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49970285119
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 07:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EECD01C7B8A;
	Wed,  7 Aug 2024 07:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="UiREsEBy"
Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E201C6890
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 07:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723015435; cv=none; b=cn2VLhBzXCB/p5NFOd+sbmfJHmri4Db7g0aCBrphp+dwAS36/EG8aDn47U/pbVlbVllqwjRNAYbEa34iCaobbJDtGpAMByNCwIuIxesYX/cfIRPibzxosQ2CL5LcJR6T63o6Iz8E2/jl8R6j/CwO5uEqjeOTkBgVF92SE5j+HRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723015435; c=relaxed/simple;
	bh=xdGo4xSoahzawkf/UMWpDpfNeuykWh4zVfbIV78aXr4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b6PRXy5cSJ2czIzn8LwfWRw8GOF2GN4SHwm6vXGkyHDJ1EDelOLb3jNeMwUEXakDWwE4uTLw5a6D/caWv0/eM9wHzkpbGKev8ZVHaRKRoRD+ZvPs7gdhDblZbpEF6p5MpPUd2iCLpuinYKaUty0oWdItIQdLs9XLDsPGusj6ThA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=UiREsEBy; arc=none smtp.client-ip=185.70.40.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1723015431; x=1723274631;
	bh=xxaFpg0Ze3aE/zz773LrPtPLPWXfOgXdS9SauyJpIPY=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=UiREsEByLc3Xkbi86UfWyGqYHWtGWlWuGPEoKO/FEImNOI4LXISIq8TJ7C10IfSLK
	 Hx2e/NwfHQkSsN81/mPngQKx6QHZ+Ljw0xcvTDcjI0i8G295Yzt3tMfcM/nLToIVkT
	 6+S3y+exEc4ee4IbR0aFPIdM6fYFuY2mkcAtWZutvk8VdhCmWGveaFP1LlMfGwQ8b8
	 vGR/jDi40MxOPhC2li6hKwllQjP0GgEM6RK9ncMaQA9FJ+i82PhZFJie8wb8LtliZB
	 1hQ28VaKnAB0lKED1vfq4qSo2k0xWABixZ11g7DZLRL++tVVNimrxtptR6w3Mav8ey
	 ZlSR0PK7Xl9Dg==
Date: Wed, 07 Aug 2024 07:23:48 +0000
To: Danilo Krummrich <dakr@kernel.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, a.hindborg@samsung.com, aliceryhl@google.com, akpm@linux-foundation.org, daniel.almeida@collabora.com, faith.ekstrand@collabora.com, boris.brezillon@collabora.com, lina@asahilina.net, mcanal@igalia.com, zhiw@nvidia.com, acurrid@nvidia.com, cjia@nvidia.com, jhubbard@nvidia.com, airlied@redhat.com, ajanulgu@redhat.com, lyude@redhat.com, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v4 06/28] rust: alloc: implement `Vmalloc` allocator
Message-ID: <64498fd9-b3f1-46f4-aebe-e5ff65634a86@proton.me>
In-Reply-To: <ZrJzJyj7kej0hA0p@pollux.localdomain>
References: <20240805152004.5039-1-dakr@kernel.org> <20240805152004.5039-7-dakr@kernel.org> <9c144953-819d-44fa-9bb5-af6fa93a5042@proton.me> <ZrJzJyj7kej0hA0p@pollux.localdomain>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 1280b02a83101c11cf2e540fcb2f068fe473cd92
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06.08.24 21:01, Danilo Krummrich wrote:
> On Tue, Aug 06, 2024 at 05:00:24PM +0000, Benno Lossin wrote:
>> On 05.08.24 17:19, Danilo Krummrich wrote:
>>> Implement `Allocator` for `Vmalloc`, the kernel's virtually contiguous
>>> allocator, typically used for larger objects, (much) larger than page
>>> size.
>>>
>>> All memory allocations made with `Vmalloc` end up in `vrealloc()`.
>>>
>>> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
>>> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
>>> ---
>>>  rust/helpers.c                      |  7 +++++++
>>>  rust/kernel/alloc/allocator.rs      | 32 +++++++++++++++++++++++++++++
>>>  rust/kernel/alloc/allocator_test.rs |  1 +
>>>  3 files changed, 40 insertions(+)
>>>
>>> diff --git a/rust/helpers.c b/rust/helpers.c
>>> index 9f7275493365..7406943f887d 100644
>>> --- a/rust/helpers.c
>>> +++ b/rust/helpers.c
>>> @@ -33,6 +33,7 @@
>>>  #include <linux/sched/signal.h>
>>>  #include <linux/slab.h>
>>>  #include <linux/spinlock.h>
>>> +#include <linux/vmalloc.h>
>>>  #include <linux/wait.h>
>>>  #include <linux/workqueue.h>
>>>
>>> @@ -199,6 +200,12 @@ void *rust_helper_krealloc(const void *objp, size_=
t new_size, gfp_t flags)
>>>  }
>>>  EXPORT_SYMBOL_GPL(rust_helper_krealloc);
>>>
>>> +void *rust_helper_vrealloc(const void *p, size_t size, gfp_t flags)
>>> +{
>>> +=09return vrealloc(p, size, flags);
>>> +}
>>> +EXPORT_SYMBOL_GPL(rust_helper_vrealloc);
>>> +
>>>  /*
>>>   * `bindgen` binds the C `size_t` type as the Rust `usize` type, so we=
 can
>>>   * use it in contexts where Rust expects a `usize` like slice (array) =
indices.
>>> diff --git a/rust/kernel/alloc/allocator.rs b/rust/kernel/alloc/allocat=
or.rs
>>> index c6ad1dd59dd0..bb55895cbd03 100644
>>> --- a/rust/kernel/alloc/allocator.rs
>>> +++ b/rust/kernel/alloc/allocator.rs
>>> @@ -9,6 +9,7 @@
>>>
>>>  use crate::alloc::{AllocError, Allocator};
>>>  use crate::bindings;
>>> +use crate::pr_warn;
>>>
>>>  /// The contiguous kernel allocator.
>>>  ///
>>> @@ -16,6 +17,12 @@
>>>  /// `bindings::krealloc`.
>>>  pub struct Kmalloc;
>>>
>>> +/// The virtually contiguous kernel allocator.
>>> +///
>>> +/// The vmalloc allocator allocates pages from the page level allocato=
r and maps them into the
>>> +/// contiguous kernel virtual space.
>>> +pub struct Vmalloc;
>>
>> One thing that I should also have mentioned for `Kmalloc`, do we want
>> these types to also have values? I don't think that we need them to be,
>> so we could declare them as `pub enum Vmalloc {}`.
>=20
> What the difference? Would `pub enum Vmalloc {}` be better for some reaso=
n?

It doesn't make a huge difference, it doesn't allow you to create a
value of type `Vmalloc` (as there are no values of that type). So
you can't accidentally use the type where it shouldn't be used.
If we use `pub struct Vmalloc;`, then you can do this:

    let a =3D Vmalloc;

you can't really do anything with it (as there are no methods on that
type), but it might be confusing for people.

>>> @@ -141,6 +153,26 @@ unsafe fn alloc_zeroed(&self, layout: Layout) -> *=
mut u8 {
>>>      }
>>>  }
>>>
>>> +unsafe impl Allocator for Vmalloc {
>>> +    unsafe fn realloc(
>>> +        ptr: Option<NonNull<u8>>,
>>> +        layout: Layout,
>>> +        flags: Flags,
>>> +    ) -> Result<NonNull<[u8]>, AllocError> {
>>> +        let realloc =3D ReallocFunc::vrealloc();
>>> +
>>> +        // TODO: Support alignments larger than PAGE_SIZE.
>>> +        if layout.align() > bindings::PAGE_SIZE {
>>> +            pr_warn!("Vmalloc does not support alignments larger than =
PAGE_SIZE yet.\n");
>>> +            return Err(AllocError);
>>> +        }
>>> +
>>> +        // SAFETY: If not `None`, `ptr` is guaranteed to point to vali=
d memory, which was previously
>>> +        // allocated with this `Allocator`.
>>> +        unsafe { realloc.call(ptr, layout, flags) }
>>
>> I am a bit confused, for `Kmalloc`, you manually returned
>> `NonNull::dangling` when allocating a zero-sized allocation, but here
>> you don't?
>>
>=20
> I do, it's the exact same implementation for krealloc(), vrealloc() and
> kvrealloc(). That why I added the `ReallocFunc` abstraction.

Oh yeah, my bad.

---
Cheers
Benno


