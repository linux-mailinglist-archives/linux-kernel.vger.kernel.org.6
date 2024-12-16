Return-Path: <linux-kernel+bounces-447515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43CD59F33A9
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 15:52:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6DD818886E7
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 14:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 433AA13EFF3;
	Mon, 16 Dec 2024 14:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XpN+neue"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 789B641C94;
	Mon, 16 Dec 2024 14:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734360652; cv=none; b=iI1brUPqkUL1UfoCt+ol1CjMNoP0JXbqKMtIvWPwel53eJ1brKzfPxGOenB9uj7HnNfDWmlL7Qac5PMew7pbz4/OvyJdW9Tz+6sLPmJtDjAn8XkYb0cqmKE9BBRI7dRES4cKbsiWx7r9SGfvr+V8XaOm5KWwMQStnAwjtWCDO1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734360652; c=relaxed/simple;
	bh=SpOyFr604TyCPZ97y4iKHmgf4xMBlupcNw2iCHFL5ww=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=ELrtR99L3cMVCKaxgZjkmkN65y6YGLpR6k5OQBSioGQug/E609QTb/DLdjvhm2jLfBOHkz7P8XNPhqCYZIsYyLRMqqvGpjq38pwjZ4hEeHZx7Btau42rTK9UKK153W1IPBcjyEiZxURZsBhtATB/k7A2anXsX4sN1W9CR+dHJIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XpN+neue; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1F69C4CED0;
	Mon, 16 Dec 2024 14:50:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734360652;
	bh=SpOyFr604TyCPZ97y4iKHmgf4xMBlupcNw2iCHFL5ww=;
	h=From:To:Cc:Subject:In-Reply-To:Date:References:From;
	b=XpN+neuex2xSDDR85zpJ3rX/3hBClc+5x4BAjtifdn2jaIifCPN0mp+49NLkw9Uq2
	 WXxiG/gjZgJr6S2RLIi4lVwZViLeaUsUldK4Z4H2zN8Bip9reiH9P5ZpYcQey2YHBI
	 d34ORfm51N/mrKoLBc1ugCKXWY+kSY21Jk4AS6TGrGRsL2hwnb9LCcwm7DWOvkrqJd
	 QwYK7/z3Kwe2Gu1tg7UgP2W7Ob7YxeXktZQU4rlTMbTSLa6n1QN8uvmIwJ3iw3wUK/
	 I4HxIGpGqZ9KIWUIO3FK+SjgvEf3HdCRbeZz1zNGyyINHFMTHWkvuQ5Fd45j1C2HaL
	 TYBqbajFyzxSA==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Alice Ryhl" <aliceryhl@google.com>
Cc: "Miguel Ojeda" <ojeda@kernel.org>,  "Matthew Wilcox"
 <willy@infradead.org>,  "Lorenzo Stoakes" <lorenzo.stoakes@oracle.com>,
  "Vlastimil Babka" <vbabka@suse.cz>,  "John Hubbard"
 <jhubbard@nvidia.com>,  "Liam R. Howlett" <Liam.Howlett@oracle.com>,
  "Andrew Morton" <akpm@linux-foundation.org>,  "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>,  "Arnd Bergmann" <arnd@arndb.de>,
  "Christian Brauner" <brauner@kernel.org>,  "Jann Horn"
 <jannh@google.com>,  "Suren Baghdasaryan" <surenb@google.com>,  "Alex
 Gaynor" <alex.gaynor@gmail.com>,  "Boqun Feng" <boqun.feng@gmail.com>,
  "Gary Guo" <gary@garyguo.net>,  =?us-ascii?Q?=3D=3Fus-ascii=3FQ=3F=3D3D?=
 =?us-ascii?Q?=3D3Fus-ascii=3D3FQ=3D3F=3D3D3D=3F=3D_=3D=3Fus-ascii=3FQ=3F?=
 =?us-ascii?Q?=3D3D3Fus-ascii=3D3D3FQ=3D3D3F=3D3D3D3D=3D3F=3D3D=5F=3D3D=3D?=
 =?us-ascii?Q?3Fus-ascii=3D3FQ=3D3F=3F=3D_=3D=3Fus-ascii=3FQ=3F=3D3D3D3Fut?=
 =?us-ascii?Q?f-8=3D3D3D3FQ=3D3D3D3FBj=3D3D3D3DC3=3D3D3F=3D3D3D=3D5F=3D3D3?=
 =?us-ascii?Q?D=3D3D3=3F=3D_=3D=3Fus-ascii=3FQ=3FFus-ascii=3D3D3FQ=3D3D3F?=
 =?us-ascii?Q?=3D3F=3D3D=5F=3D3D=3D3Fus-ascii=3D3FQ=3D3F=3D3D3D3DB6rn=3F?=
 =?us-ascii?Q?=3D_=3D=3Fus-ascii=3FQ=3F=3D3D3D3F=3D3D3D3D=3D3D3F=3D3D3D=3D?=
 =?us-ascii?Q?3F=3D3D=3F=3D?= Roy Baron
 <bjorn3_gh@protonmail.com>,  "Benno Lossin" <benno.lossin@proton.me>,
  "Trevor Gross" <tmgross@umich.edu>,  <linux-kernel@vger.kernel.org>,
  <linux-mm@kvack.org>,  <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH v11 1/8] mm: rust: add abstraction for struct mm_struct
In-Reply-To: <20241211-vma-v11-1-466640428fc3@google.com> (Alice Ryhl's
	message of "Wed, 11 Dec 2024 10:37:05 +0000")
Date: Mon, 16 Dec 2024 12:31:55 +0100
Message-ID: <878qsfdftg.fsf@kernel.org>
References: <20241211-vma-v11-0-466640428fc3@google.com>
	<ZzO0HNA5jlZZgU1ib_SP36HWHny8QNidES3cXM_ogVTtqArMPzPfDlQCFslPrZAVESJzfzFOVfOkoZHKiG-ivQ==@protonmail.internalid>
	<20241211-vma-v11-1-466640428fc3@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Alice Ryhl" <aliceryhl@google.com> writes:

> These abstractions allow you to reference a `struct mm_struct` using
> both mmgrab and mmget refcounts. This is done using two Rust types:
>
> * Mm - represents an mm_struct where you don't know anything about the
>   value of mm_users.
> * MmWithUser - represents an mm_struct where you know at compile time
>   that mm_users is non-zero.
>
> This allows us to encode in the type system whether a method requires
> that mm_users is non-zero or not. For instance, you can always call
> `mmget_not_zero` but you can only call `mmap_read_lock` when mm_users is
> non-zero.
>
> It's possible to access current->mm without a refcount increment, but
> that is added in a later patch of this series.
>
> Acked-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com> (for mm bits)
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
>  rust/helpers/helpers.c |   1 +
>  rust/helpers/mm.c      |  39 +++++++++
>  rust/kernel/lib.rs     |   1 +
>  rust/kernel/mm.rs      | 219 +++++++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 260 insertions(+)
>
> diff --git a/rust/kernel/mm.rs b/rust/kernel/mm.rs
> new file mode 100644
> index 000000000000..84cba581edaa
> --- /dev/null
> +++ b/rust/kernel/mm.rs
> @@ -0,0 +1,219 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +// Copyright (C) 2024 Google LLC.
> +
> +//! Memory management.

Could you add a little more context here?

> +//!
> +//! C header: [`include/linux/mm.h`](srctree/include/linux/mm.h)
> +
> +use crate::{
> +    bindings,
> +    types::{ARef, AlwaysRefCounted, NotThreadSafe, Opaque},
> +};
> +use core::{ops::Deref, ptr::NonNull};
> +
> +/// A wrapper for the kernel's `struct mm_struct`.

Could you elaborate the data structure use case? When do I need it, what
does it do?

> +///
> +/// Since `mm_users` may be zero, the associated address space may not exist anymore. You can use
> +/// [`mmget_not_zero`] to be able to access the address space.
> +///
> +/// The `ARef<Mm>` smart pointer holds an `mmgrab` refcount. Its destructor may sleep.
> +///
> +/// # Invariants
> +///
> +/// Values of this type are always refcounted using `mmgrab`.
> +///
> +/// [`mmget_not_zero`]: Mm::mmget_not_zero
> +#[repr(transparent)]
> +pub struct Mm {

Could we come up with a better name? `MemoryMap` or `MemoryMapping`?. You
use `MMapReadGuard` later.

> +    mm: Opaque<bindings::mm_struct>,
> +}
> +
> +// SAFETY: It is safe to call `mmdrop` on another thread than where `mmgrab` was called.
> +unsafe impl Send for Mm {}
> +// SAFETY: All methods on `Mm` can be called in parallel from several threads.
> +unsafe impl Sync for Mm {}
> +
> +// SAFETY: By the type invariants, this type is always refcounted.
> +unsafe impl AlwaysRefCounted for Mm {
> +    #[inline]
> +    fn inc_ref(&self) {
> +        // SAFETY: The pointer is valid since self is a reference.
> +        unsafe { bindings::mmgrab(self.as_raw()) };
> +    }
> +
> +    #[inline]
> +    unsafe fn dec_ref(obj: NonNull<Self>) {
> +        // SAFETY: The caller is giving up their refcount.
> +        unsafe { bindings::mmdrop(obj.cast().as_ptr()) };
> +    }
> +}
> +
> +/// A wrapper for the kernel's `struct mm_struct`.
> +///
> +/// This type is like [`Mm`], but with non-zero `mm_users`. It can only be used when `mm_users` can
> +/// be proven to be non-zero at compile-time, usually because the relevant code holds an `mmget`
> +/// refcount. It can be used to access the associated address space.
> +///
> +/// The `ARef<MmWithUser>` smart pointer holds an `mmget` refcount. Its destructor may sleep.
> +///
> +/// # Invariants
> +///
> +/// Values of this type are always refcounted using `mmget`. The value of `mm_users` is non-zero.
> +#[repr(transparent)]
> +pub struct MmWithUser {
> +    mm: Mm,
> +}
> +
> +// SAFETY: It is safe to call `mmput` on another thread than where `mmget` was called.
> +unsafe impl Send for MmWithUser {}
> +// SAFETY: All methods on `MmWithUser` can be called in parallel from several threads.
> +unsafe impl Sync for MmWithUser {}
> +
> +// SAFETY: By the type invariants, this type is always refcounted.
> +unsafe impl AlwaysRefCounted for MmWithUser {
> +    #[inline]
> +    fn inc_ref(&self) {
> +        // SAFETY: The pointer is valid since self is a reference.
> +        unsafe { bindings::mmget(self.as_raw()) };
> +    }
> +
> +    #[inline]
> +    unsafe fn dec_ref(obj: NonNull<Self>) {
> +        // SAFETY: The caller is giving up their refcount.
> +        unsafe { bindings::mmput(obj.cast().as_ptr()) };
> +    }
> +}
> +
> +// Make all `Mm` methods available on `MmWithUser`.
> +impl Deref for MmWithUser {
> +    type Target = Mm;
> +
> +    #[inline]
> +    fn deref(&self) -> &Mm {
> +        &self.mm
> +    }
> +}
> +
> +// These methods are safe to call even if `mm_users` is zero.
> +impl Mm {
> +    /// Call `mmgrab` on `current.mm`.
> +    #[inline]
> +    pub fn mmgrab_current() -> Option<ARef<Mm>> {
> +        // SAFETY: It's safe to get the `mm` field from current.
> +        let mm = unsafe {
> +            let current = bindings::get_current();
> +            (*current).mm
> +        };
> +
> +        if mm.is_null() {
> +            return None;
> +        }
> +
> +        // SAFETY: The value of `current->mm` is guaranteed to be null or a valid `mm_struct`. We
> +        // just checked that it's not null. Furthermore, the returned `&Mm` is valid only for the
> +        // duration of this function, and `current->mm` will stay valid for that long.
> +        let mm = unsafe { Mm::from_raw(mm) };
> +
> +        // This increments the refcount using `mmgrab`.
> +        Some(ARef::from(mm))
> +    }
> +
> +    /// Returns a raw pointer to the inner `mm_struct`.
> +    #[inline]
> +    pub fn as_raw(&self) -> *mut bindings::mm_struct {
> +        self.mm.get()
> +    }
> +
> +    /// Obtain a reference from a raw pointer.
> +    ///
> +    /// # Safety
> +    ///
> +    /// The caller must ensure that `ptr` points at an `mm_struct`, and that it is not deallocated
> +    /// during the lifetime 'a.
> +    #[inline]
> +    pub unsafe fn from_raw<'a>(ptr: *const bindings::mm_struct) -> &'a Mm {
> +        // SAFETY: Caller promises that the pointer is valid for 'a. Layouts are compatible due to
> +        // repr(transparent).
> +        unsafe { &*ptr.cast() }
> +    }
> +
> +    /// Calls `mmget_not_zero` and returns a handle if it succeeds.
> +    #[inline]
> +    pub fn mmget_not_zero(&self) -> Option<ARef<MmWithUser>> {
> +        // SAFETY: The pointer is valid since self is a reference.
> +        let success = unsafe { bindings::mmget_not_zero(self.as_raw()) };
> +
> +        if success {
> +            // SAFETY: We just created an `mmget` refcount.
> +            Some(unsafe { ARef::from_raw(NonNull::new_unchecked(self.as_raw().cast())) })
> +        } else {
> +            None
> +        }
> +    }
> +}

Nit: could we put the impl next to the struct definition?


Best regards,
Andreas Hindborg



