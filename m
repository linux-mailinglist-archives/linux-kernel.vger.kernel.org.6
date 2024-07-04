Return-Path: <linux-kernel+bounces-241469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 58324927BAB
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 19:11:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDF0D285BFB
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 17:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 031CB1B47B9;
	Thu,  4 Jul 2024 17:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TStZ87yH"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 896D61C093F
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 17:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720112940; cv=none; b=UcMVMS4NsPzh4p+lAwqkVeW6G8V6rnfpl4aawcug76D7hmBGYKYVo8iXR8fmvEKKqyW2wlunlJE2Jd4wyKhqeVTBRxharaOHtSxTzfKMfX6+AkKkLq9peB2HDS6P9KNofklQTsVbcm+jfDUVBoLpm6orTdjDpwzDWoW5RnI0Swk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720112940; c=relaxed/simple;
	bh=McNG3UaBL1ItOv7lUZeO9yWA3Gg998SyrEB81aiN71Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VJmm7qHX9et+wSlJxX5HwKcOOvN0ltnXy4jOTMs8Blt0DG1BgvLww7weo+Pu6VWg/tiMvVyjw4gtuN6ewGIHwJfqLCaNcQ+657MNzXoa8owq9YXo8g77j5kwlWZUOIfyq7nhOlk/VHc8vBskJdw2YNAmCHx6PjxF8hWnM9rDL+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TStZ87yH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720112937;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mFTJALd1uc5PTttR7ib6e5/dU6QO/4gG6Rje8Pwa4QE=;
	b=TStZ87yHjsjO3oIrf+632P5dtsT9EmwjVIVYQSzXHZ21Nj2dOfMLlFhSefGYR605kgi/BV
	TsXmv3lmvhFb8vamJNBivW5S3yO4MxcXlTC84LL/BPBQHEayrFwUPWkRsWpoqMJGBQEjg+
	zmwCDpleTNScO7Rt8vaFT02jpJGCAy4=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-491-XerJYlkCO8yx4Nb7Dx3krA-1; Thu, 04 Jul 2024 13:08:56 -0400
X-MC-Unique: XerJYlkCO8yx4Nb7Dx3krA-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2ee8f22ef7cso8485111fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2024 10:08:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720112935; x=1720717735;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mFTJALd1uc5PTttR7ib6e5/dU6QO/4gG6Rje8Pwa4QE=;
        b=XHpGuX3aw+JW9L2vS0IDWnpy+FwlnZXync8pLppeb6ge/7aqdfgq5bPVMSNTYdytKE
         aHTDRKX1vBuHngnmlozDSqKNTYotzxSRhm801KdBH5m1YRPhyCQ/7HLI76CT6TnZypDc
         fRBP35g5lmc/pNL11sfgp/sImXbThtHwlUxeQ3Ni9meodANcu3pr5jbkNxknzq57lQCh
         zfqrdxxh52SUS1ZcepZIbBZA7bCqMwR+8XXibVkNZI+C2yJuFDEOAOVjKT7MRjvUBRoD
         oYKfWGOi/fC4zU1Wgk/dH9Zs86RRT3bk8ArdXBvfXVe3kTlnYDe4aM0rAPJpZNcyc0eF
         PzLA==
X-Forwarded-Encrypted: i=1; AJvYcCW6R/0xofzRDMOWpaYAVnGICxpl3U5Yy2h1qXnelQCx1GXWlhNETkYsJlLhhviKh9K15Jdy98agaBSBKpFfV/5xxtYU7mEx/6noOkOQ
X-Gm-Message-State: AOJu0YzyNr25WSWR2VYN6kDATPDLa4V1/ZnZ+ZI8zCFY6SJQlwPhU+hd
	dyriLN5Tz/G6S6UtddxEYSsmNMvUDc9A4bKXD2PdW2qv5125WfTFPvwVoZxYEAX2rRFPo/BkF3b
	PdNMuy1QgqsmMYrIMsxjeSVM5mxXdSNXBzL2NrUles4DlgXTYa3hgP6ul579Pzw==
X-Received: by 2002:a2e:be0e:0:b0:2ec:500c:b2e1 with SMTP id 38308e7fff4ca-2ee8ed3d2dbmr19484661fa.5.1720112934772;
        Thu, 04 Jul 2024 10:08:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHUtRKIuXsXzgO71ukyPTu4WnPhBOEE1r6DXR7c0mh98Dk6Ws6lY6iJdhRoHSBBCF6WbDIvwg==
X-Received: by 2002:a2e:be0e:0:b0:2ec:500c:b2e1 with SMTP id 38308e7fff4ca-2ee8ed3d2dbmr19484331fa.5.1720112934307;
        Thu, 04 Jul 2024 10:08:54 -0700 (PDT)
Received: from cassiopeiae.. ([2a02:810d:4b3f:ee94:642:1aff:fe31:a19f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4264a21cba6sm31134675e9.22.2024.07.04.10.08.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 10:08:53 -0700 (PDT)
From: Danilo Krummrich <dakr@redhat.com>
To: ojeda@kernel.org,
	alex.gaynor@gmail.com,
	wedsonaf@gmail.com,
	boqun.feng@gmail.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	benno.lossin@proton.me,
	a.hindborg@samsung.com,
	aliceryhl@google.com
Cc: daniel.almeida@collabora.com,
	faith.ekstrand@collabora.com,
	boris.brezillon@collabora.com,
	lina@asahilina.net,
	mcanal@igalia.com,
	zhiw@nvidia.com,
	acurrid@nvidia.com,
	cjia@nvidia.com,
	jhubbard@nvidia.com,
	airlied@redhat.com,
	ajanulgu@redhat.com,
	lyude@redhat.com,
	linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	Danilo Krummrich <dakr@redhat.com>
Subject: [PATCH 10/20] rust: alloc: implement `KBox`
Date: Thu,  4 Jul 2024 19:06:38 +0200
Message-ID: <20240704170738.3621-11-dakr@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240704170738.3621-1-dakr@redhat.com>
References: <20240704170738.3621-1-dakr@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

`KBox` provides the simplest way to allocate memory for a generic type
with one of the kernel's allocators, e.g. `Kmalloc`, `Vmalloc` or
`KVmalloc`.

In contrast to `Box`, `KBox` considers the kernel's GFP flags for all
appropriate functions, always reports allocation failures through
`Result<_, AllocError>` and remains independent from unstable features.

Signed-off-by: Danilo Krummrich <dakr@redhat.com>
---
 rust/kernel/alloc.rs      |   3 +
 rust/kernel/alloc/kbox.rs | 319 ++++++++++++++++++++++++++++++++++++++
 rust/kernel/init.rs       |  32 +++-
 rust/kernel/prelude.rs    |   2 +-
 rust/kernel/types.rs      |  23 +++
 5 files changed, 377 insertions(+), 2 deletions(-)
 create mode 100644 rust/kernel/alloc/kbox.rs

diff --git a/rust/kernel/alloc.rs b/rust/kernel/alloc.rs
index 46ebdd059c92..ff90cefad0ea 100644
--- a/rust/kernel/alloc.rs
+++ b/rust/kernel/alloc.rs
@@ -5,6 +5,7 @@
 #[cfg(not(any(test, testlib)))]
 pub mod allocator;
 pub mod box_ext;
+pub mod kbox;
 pub mod vec_ext;
 
 #[cfg(any(test, testlib))]
@@ -13,6 +14,8 @@
 #[cfg(any(test, testlib))]
 pub use self::allocator_test as allocator;
 
+pub use self::kbox::KBox;
+
 /// Indicates an allocation error.
 #[derive(Copy, Clone, PartialEq, Eq, Debug)]
 pub struct AllocError;
diff --git a/rust/kernel/alloc/kbox.rs b/rust/kernel/alloc/kbox.rs
new file mode 100644
index 000000000000..69976fd1d518
--- /dev/null
+++ b/rust/kernel/alloc/kbox.rs
@@ -0,0 +1,319 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Implementation of [`KBox`].
+
+use super::{allocator::Kmalloc, AllocError, Allocator, Flags};
+use core::fmt;
+use core::mem::ManuallyDrop;
+use core::mem::MaybeUninit;
+use core::ops::{Deref, DerefMut};
+use core::pin::Pin;
+use core::ptr;
+use core::result::Result;
+
+use crate::types::Unique;
+
+/// The kernel's `Box` type named [`KBox`].
+///
+/// `KBox` provides the simplest way to allocate memory for a generic type with one of the kernel's
+/// allocators, e.g. `Kmalloc`, `Vmalloc` or `KVmalloc`.
+///
+/// For non-zero-sized values, a [`KBox`] will use the given allocator `A` for its allocation. If
+/// no specific `Allocator` is requested, [`KBox`] will default to `Kmalloc`.
+///
+/// It is valid to convert both ways between a [`KBox`] and a raw pointer allocated with any
+/// `Allocator`, given that the `Layout` used with the allocator is correct for the type.
+///
+/// For zero-sized values the [`KBox`]' pointer must be `dangling_mut::<T>`; no memory is
+/// allocated.
+///
+/// So long as `T: Sized`, a `Box<T>` is guaranteed to be represented as a single pointer and is
+/// also ABI-compatible with C pointers (i.e. the C type `T*`).
+///
+/// # Invariants
+///
+/// The [`KBox`]' pointer always properly aligned and either points to memory allocated with `A` or,
+/// for zero-sized types, is a dangling pointer.
+///
+/// # Examples
+///
+/// ```
+/// let b = KBox::new(24_u64, GFP_KERNEL)?;
+///
+/// assert_eq!(*b, 24_u64);
+///
+/// # Ok::<(), Error>(())
+/// ```
+///
+/// ```
+/// use kernel::alloc::allocator::KVmalloc;
+///
+/// struct Huge([u8; 1 << 24]);
+///
+/// assert!(KBox::<Huge, KVmalloc>::new_uninit_alloc(KVmalloc, GFP_KERNEL).is_ok());
+/// ```
+pub struct KBox<T: ?Sized, A: Allocator = Kmalloc>(Unique<T>, A);
+
+impl<T, A> KBox<T, A>
+where
+    T: ?Sized,
+    A: Allocator,
+{
+    /// Constructs a `KBox<T, A>` from a raw pointer.
+    ///
+    /// # Safety
+    ///
+    /// `raw` must point to valid memory, previously allocated with `A`, and at least the size of
+    /// type `T`.
+    #[inline]
+    pub const unsafe fn from_raw_alloc(raw: *mut T, alloc: A) -> Self {
+        // SAFETY: Safe by the requirements of this function.
+        KBox(unsafe { Unique::new_unchecked(raw) }, alloc)
+    }
+
+    /// Consumes the `KBox<T, A>`, returning a wrapped raw pointer and the allocator it was
+    /// allocated with.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// let x = KBox::new(24, GFP_KERNEL)?;
+    /// let (ptr, alloc) = KBox::into_raw_alloc(x);
+    /// let x = unsafe { KBox::from_raw_alloc(ptr, alloc) };
+    ///
+    /// assert_eq!(*x, 24);
+    ///
+    /// # Ok::<(), Error>(())
+    /// ```
+    pub fn into_raw_alloc(self) -> (*mut T, A) {
+        let b = ManuallyDrop::new(self);
+        let alloc = unsafe { ptr::read(&b.1) };
+        (b.0.as_ptr(), alloc)
+    }
+
+    /// Consumes the `KBox<T>`, returning a wrapped raw pointer.
+    #[inline]
+    pub fn into_raw(self) -> *mut T {
+        self.into_raw_alloc().0
+    }
+
+    /// Consumes and leaks the `KBox<T>`, returning a mutable reference, &'a mut T.
+    #[inline]
+    pub fn leak<'a>(b: Self) -> &'a mut T
+    where
+        T: 'a,
+    {
+        // SAFETY: `KBox::into_raw` always returns a properly aligned and dereferenceable pointer
+        // which points to an initialized instance of `T`.
+        unsafe { &mut *KBox::into_raw(b) }
+    }
+
+    /// Converts a `KBox<T>` into a `Pin<KBox<T>>`.
+    #[inline]
+    pub fn into_pin(b: Self) -> Pin<Self>
+    where
+        A: 'static,
+    {
+        // SAFETY: It's not possible to move or replace the insides of a `Pin<KBox<T>>` when
+        // `T: !Unpin`, so it's safe to pin it directly without any additional requirements.
+        unsafe { Pin::new_unchecked(b) }
+    }
+}
+
+impl<T, A> KBox<MaybeUninit<T>, A>
+where
+    A: Allocator,
+{
+    /// Converts to `KBox<T, A>`.
+    ///
+    /// # Safety
+    ///
+    /// As with MaybeUninit::assume_init, it is up to the caller to guarantee that the value really
+    /// is in an initialized state. Calling this when the content is not yet fully initialized
+    /// causes immediate undefined behavior.
+    pub unsafe fn assume_init(self) -> KBox<T, A> {
+        let (raw, alloc) = KBox::into_raw_alloc(self);
+        // SAFETY: Reconstruct the `KBox<MaybeUninit<T>, A>` as KBox<T, A> now that has been
+        // initialized. `raw` and `alloc` are safe by the invariants of `KBox`.
+        unsafe { KBox::from_raw_alloc(raw as *mut T, alloc) }
+    }
+
+    /// Writes the value and converts to `KBox<T, A>`.
+    pub fn write(mut boxed: Self, value: T) -> KBox<T, A> {
+        (*boxed).write(value);
+        // SAFETY: We've just initialized `boxed`'s value.
+        unsafe { boxed.assume_init() }
+    }
+}
+
+impl<T> KBox<T> {
+    /// Allocates memory with `Kmalloc` and then places `x` into it.
+    ///
+    /// This doesn’t actually allocate if T is zero-sized.
+    pub fn new(x: T, flags: Flags) -> Result<Self, AllocError> {
+        let b = Self::new_uninit(flags)?;
+        Ok(KBox::write(b, x))
+    }
+
+    /// Constructs a new `KBox<T>` with uninitialized contents.
+    #[inline]
+    pub fn new_uninit(flags: Flags) -> Result<KBox<MaybeUninit<T>>, AllocError> {
+        Self::new_uninit_alloc(Kmalloc, flags)
+    }
+
+    /// Constructs a new `Pin<KBox<T>>`. If `T` does not implement [`Unpin`], then `x` will be
+    /// pinned in memory and unable to be moved.
+    #[inline]
+    pub fn pin(x: T, flags: Flags) -> Result<Pin<KBox<T>>, AllocError> {
+        Ok(KBox::new(x, flags)?.into())
+    }
+}
+
+impl<T> KBox<T>
+where
+    T: ?Sized,
+{
+    /// Constructs a `KBox<T>` from a raw pointer.
+    ///
+    /// # Safety
+    ///
+    /// `raw` must point to valid memory, previously allocated with the `Kmalloc`, and at least the
+    /// size of type `T`.
+    #[inline]
+    pub const unsafe fn from_raw(raw: *mut T) -> Self {
+        // SAFETY: Validity of `raw` is guaranteed by the safety preconditions of this function.
+        KBox(unsafe { Unique::new_unchecked(raw) }, Kmalloc)
+    }
+}
+
+impl<T, A> KBox<T, A>
+where
+    A: Allocator,
+{
+    fn is_zst() -> bool {
+        core::mem::size_of::<T>() == 0
+    }
+
+    /// Allocates memory with the allocator `A` and then places `x` into it.
+    ///
+    /// This doesn’t actually allocate if T is zero-sized.
+    pub fn new_alloc(x: T, alloc: A, flags: Flags) -> Result<Self, AllocError> {
+        let b = Self::new_uninit_alloc(alloc, flags)?;
+        Ok(KBox::write(b, x))
+    }
+
+    /// Constructs a new `KBox<T, A>` with uninitialized contents.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// use kernel::alloc::allocator::Kmalloc;
+    ///
+    /// let b = KBox::<u64>::new_uninit_alloc(Kmalloc, GFP_KERNEL)?;
+    /// let b = KBox::write(b, 24);
+    ///
+    /// assert_eq!(*b, 24_u64);
+    ///
+    /// # Ok::<(), Error>(())
+    /// ```
+    pub fn new_uninit_alloc(alloc: A, flags: Flags) -> Result<KBox<MaybeUninit<T>, A>, AllocError> {
+        let ptr = if Self::is_zst() {
+            Unique::dangling()
+        } else {
+            let layout = core::alloc::Layout::new::<MaybeUninit<T>>();
+            let ptr = alloc.alloc(layout, flags)?;
+
+            ptr.cast().into()
+        };
+
+        Ok(KBox(ptr, alloc))
+    }
+
+    /// Constructs a new `Pin<KBox<T, A>>`. If `T` does not implement [`Unpin`], then `x` will be
+    /// pinned in memory and unable to be moved.
+    #[inline]
+    pub fn pin_alloc(x: T, alloc: A, flags: Flags) -> Result<Pin<KBox<T, A>>, AllocError>
+    where
+        A: 'static,
+    {
+        Ok(Self::new_alloc(x, alloc, flags)?.into())
+    }
+}
+
+impl<T, A> From<KBox<T, A>> for Pin<KBox<T, A>>
+where
+    T: ?Sized,
+    A: Allocator,
+    A: 'static,
+{
+    /// Converts a `KBox<T>` into a `Pin<KBox<T>>`. If `T` does not implement [`Unpin`], then
+    /// `*boxed` will be pinned in memory and unable to be moved.
+    ///
+    /// This conversion does not allocate on the heap and happens in place.
+    ///
+    /// This is also available via [`KBox::into_pin`].
+    ///
+    /// Constructing and pinning a `KBox` with <code><Pin<KBox\<T>>>::from([KBox::new]\(x))</code>
+    /// can also be written more concisely using <code>[KBox::pin]\(x)</code>.
+    /// This `From` implementation is useful if you already have a `KBox<T>`, or you are
+    /// constructing a (pinned) `KBox` in a different way than with [`KBox::new`].
+    fn from(b: KBox<T, A>) -> Self {
+        KBox::into_pin(b)
+    }
+}
+
+impl<T, A> Deref for KBox<T, A>
+where
+    T: ?Sized,
+    A: Allocator,
+{
+    type Target = T;
+
+    fn deref(&self) -> &T {
+        // SAFETY: `self.0` is always properly aligned, dereferenceable and points to an initialized
+        // instance of `T`.
+        unsafe { self.0.as_ref() }
+    }
+}
+
+impl<T, A> DerefMut for KBox<T, A>
+where
+    T: ?Sized,
+    A: Allocator,
+{
+    fn deref_mut(&mut self) -> &mut T {
+        // SAFETY: `self.0` is always properly aligned, dereferenceable and points to an initialized
+        // instance of `T`.
+        unsafe { self.0.as_mut() }
+    }
+}
+
+impl<T, A> fmt::Debug for KBox<T, A>
+where
+    T: ?Sized + fmt::Debug,
+    A: Allocator,
+{
+    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
+        fmt::Debug::fmt(&**self, f)
+    }
+}
+
+impl<T, A> Drop for KBox<T, A>
+where
+    T: ?Sized,
+    A: Allocator,
+{
+    fn drop(&mut self) {
+        let ptr = self.0.as_ptr();
+
+        // SAFETY: We need to drop `self.0` in place, before we free the backing memory.
+        unsafe { core::ptr::drop_in_place(ptr) };
+
+        // SAFETY: `ptr` is always properly aligned, dereferenceable and points to an initialized
+        // instance of `T`.
+        if unsafe { core::mem::size_of_val(&*ptr) } != 0 {
+            // SAFETY: `ptr` was previously allocated with `self.1`.
+            unsafe { self.1.free(ptr.cast()) };
+        }
+    }
+}
diff --git a/rust/kernel/init.rs b/rust/kernel/init.rs
index 68605b633e73..b34c8127b76d 100644
--- a/rust/kernel/init.rs
+++ b/rust/kernel/init.rs
@@ -211,7 +211,7 @@
 //! [`pin_init!`]: crate::pin_init!
 
 use crate::{
-    alloc::{box_ext::BoxExt, AllocError, Flags},
+    alloc::{box_ext::BoxExt, AllocError, Flags, KBox},
     error::{self, Error},
     sync::UniqueArc,
     types::{Opaque, ScopeGuard},
@@ -1183,6 +1183,36 @@ fn try_init<E>(init: impl Init<T, E>, flags: Flags) -> Result<Self, E>
     }
 }
 
+impl<T> InPlaceInit<T> for KBox<T> {
+    #[inline]
+    fn try_pin_init<E>(init: impl PinInit<T, E>, flags: Flags) -> Result<Pin<Self>, E>
+    where
+        E: From<AllocError>,
+    {
+        let mut this = KBox::<_>::new_uninit(flags)?;
+        let slot = this.as_mut_ptr();
+        // SAFETY: When init errors/panics, slot will get deallocated but not dropped,
+        // slot is valid and will not be moved, because we pin it later.
+        unsafe { init.__pinned_init(slot)? };
+        // SAFETY: All fields have been initialized.
+        Ok(unsafe { this.assume_init() }.into())
+    }
+
+    #[inline]
+    fn try_init<E>(init: impl Init<T, E>, flags: Flags) -> Result<Self, E>
+    where
+        E: From<AllocError>,
+    {
+        let mut this = KBox::<_>::new_uninit(flags)?;
+        let slot = this.as_mut_ptr();
+        // SAFETY: When init errors/panics, slot will get deallocated but not dropped,
+        // slot is valid.
+        unsafe { init.__init(slot)? };
+        // SAFETY: All fields have been initialized.
+        Ok(unsafe { this.assume_init() })
+    }
+}
+
 impl<T> InPlaceInit<T> for UniqueArc<T> {
     #[inline]
     fn try_pin_init<E>(init: impl PinInit<T, E>, flags: Flags) -> Result<Pin<Self>, E>
diff --git a/rust/kernel/prelude.rs b/rust/kernel/prelude.rs
index b37a0b3180fb..d75c14234133 100644
--- a/rust/kernel/prelude.rs
+++ b/rust/kernel/prelude.rs
@@ -14,7 +14,7 @@
 #[doc(no_inline)]
 pub use core::pin::Pin;
 
-pub use crate::alloc::{box_ext::BoxExt, flags::*, vec_ext::VecExt};
+pub use crate::alloc::{box_ext::BoxExt, flags::*, vec_ext::VecExt, KBox};
 
 #[doc(no_inline)]
 pub use alloc::{boxed::Box, vec::Vec};
diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
index 281327ea2932..939ec27c584d 100644
--- a/rust/kernel/types.rs
+++ b/rust/kernel/types.rs
@@ -2,6 +2,7 @@
 
 //! Kernel types.
 
+use crate::alloc::KBox;
 use crate::init::{self, PinInit};
 use alloc::boxed::Box;
 use core::{
@@ -89,6 +90,28 @@ unsafe fn from_foreign(ptr: *const core::ffi::c_void) -> Self {
     }
 }
 
+impl<T: 'static> ForeignOwnable for KBox<T> {
+    type Borrowed<'a> = &'a T;
+
+    fn into_foreign(self) -> *const core::ffi::c_void {
+        KBox::into_raw(self) as _
+    }
+
+    unsafe fn borrow<'a>(ptr: *const core::ffi::c_void) -> &'a T {
+        // SAFETY: The safety requirements for this function ensure that the object is still alive,
+        // so it is safe to dereference the raw pointer.
+        // The safety requirements of `from_foreign` also ensure that the object remains alive for
+        // the lifetime of the returned value.
+        unsafe { &*ptr.cast() }
+    }
+
+    unsafe fn from_foreign(ptr: *const core::ffi::c_void) -> Self {
+        // SAFETY: The safety requirements of this function ensure that `ptr` comes from a previous
+        // call to `Self::into_foreign`.
+        unsafe { KBox::from_raw(ptr as _) }
+    }
+}
+
 impl ForeignOwnable for () {
     type Borrowed<'a> = ();
 
-- 
2.45.2


