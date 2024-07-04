Return-Path: <linux-kernel+bounces-241472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3A2F927BB2
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 19:12:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02F611C22113
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 17:12:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E84341C9ED9;
	Thu,  4 Jul 2024 17:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jSbDeIKS"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17E0F1B3F08
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 17:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720112957; cv=none; b=lNtaJ/PBlj2o6STP4s0yUgFUk503Uy/CMLkl1Ki7NrYGxqHiPkaT6oZdrtWpg0hwKhh3B4YvspfN6Xl+lONSc4j1k7b2l7ngil+A4aWX/B5QDpPSyiACfjkZ0A8qhwfnakBVCQdbyN9OV0tJBnwL2wcw6IpZZ6jMErP2zDrJZJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720112957; c=relaxed/simple;
	bh=oZ+Kffa+ZusYQvmQFj/KKP+hW54mb7jaO1sWCol6BqY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uS+VqeokTKBRjw7enqTNC7pT5jTAqq6VZ2LMl3ov0elUHYQkxEX9zlU+2CjbWJPmAXkraJioDo37d9S/bkqPY7JKh0tH8u5ChfL2DAwmxtP7y5+gd4UChhtzxcBzulK9svp23+h+bzT8E5/rzA0fBdGspbr9TwjWMdMb3n+P2y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jSbDeIKS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720112953;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h3os753SbfqzKgGGDKsUwcQmZvaE0TXjXE9ormHju54=;
	b=jSbDeIKSuympk+PcpSL/IQbxeWotEWwXMgaMEpnz4jvJNPD1J/fgLWl1gPdUYqoJl1yKV4
	psJ0Bud8LRUvTIGPZRtFtI+alZWqvhPTPHgst3wYuOk3BX4XaDtZUcW0WizmSuG7oA27fP
	+R0icC9BAS9kOOFWS9IP1sHqZfCXkDg=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-2-BF6tnMVuPdyONSswNLEF3A-1; Thu, 04 Jul 2024 13:09:09 -0400
X-MC-Unique: BF6tnMVuPdyONSswNLEF3A-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2ee90290a7aso10568511fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2024 10:09:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720112947; x=1720717747;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h3os753SbfqzKgGGDKsUwcQmZvaE0TXjXE9ormHju54=;
        b=clvSmSbPEfsdAMW0TtDp0ywGY6NCfoLuHf/kP+4sbLQkiSNrS25+ZwqYAhoCnS7lA+
         pAy1SC90LApOzpX5U86/fdXX/5Syvot4g8QYvVzwzw0f0eq3pAGT0L6cs1WymeKHpvTp
         qqTII5a4n2X01fdrhWnAXdiE0EI3GPIJYKoMd25NfUaGx5ufkYgCXdNtvkh4AZ6i0Wg3
         nUiYzpWmmNAD6mBaXQThzgKLJg/1d6RBi2bEMS6z87MMuXEL/eyQSRKfUlfZyVEFeiUy
         0PYSSgaqaNsCxroymb3oKg9+PIYMeqwWCKlyl/P6cwSyF08LXFIgppE+K4tjtQkW4eso
         qt5w==
X-Forwarded-Encrypted: i=1; AJvYcCWLYm7IqfvWg1poMUpAocwt/K2O3fHLhkOENoA2C9jUO0fad4RT5KiNmGtJKF/YJ2WTRxqHc3EenO8nqbdscj4NbaevLmmxFcKRLTSt
X-Gm-Message-State: AOJu0YzOTQwbCZwWwuQMb2Shxww/0183iWKgsbBm5K3FFrM8QyCK/AMX
	E9lFKHWy6/tvT2w9suXMahavg6wCd3By/cyfFqnh5FeQyIkquCPcWRbn5PO82iQvqXZtAiKb8Dz
	0y9mY3a6NnHSW/+kBwfTZJYonCVt8d2bLRkeSZ4hhaE3LcHgs6jryfEvIfnbVLA==
X-Received: by 2002:a05:651c:2209:b0:2ec:5f85:61c0 with SMTP id 38308e7fff4ca-2ee8ee212b1mr23322651fa.48.1720112947040;
        Thu, 04 Jul 2024 10:09:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG9Lf70Kg2a/722PZCeDhipNzzQHZf+40ZKS8SuAc7xOSzXMTQ+h2nQIGMDULoUis5F7hbyyA==
X-Received: by 2002:a05:651c:2209:b0:2ec:5f85:61c0 with SMTP id 38308e7fff4ca-2ee8ee212b1mr23322221fa.48.1720112946421;
        Thu, 04 Jul 2024 10:09:06 -0700 (PDT)
Received: from cassiopeiae.. ([2a02:810d:4b3f:ee94:642:1aff:fe31:a19f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3675a103d00sm18993136f8f.99.2024.07.04.10.09.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 10:09:05 -0700 (PDT)
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
Subject: [PATCH 13/20] rust: alloc: implement `KVec`
Date: Thu,  4 Jul 2024 19:06:41 +0200
Message-ID: <20240704170738.3621-14-dakr@redhat.com>
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

`KVec` provides a contiguous growable array type (such as `Vec`) with
contents allocated with the kernel's allocators (e.g. `Kmalloc`,
`Vmalloc` or `KVmalloc`).

In contrast to `Vec`, `KVec` considers the kernel's GFP flags for all
appropriate functions, always reports allocation failures through
`Result<_, AllocError>` and remains independent from unstable features.

Signed-off-by: Danilo Krummrich <dakr@redhat.com>
---
 rust/kernel/alloc.rs      |   2 +
 rust/kernel/alloc/kbox.rs |  16 +-
 rust/kernel/alloc/kvec.rs | 605 ++++++++++++++++++++++++++++++++++++++
 rust/kernel/prelude.rs    |   2 +-
 4 files changed, 623 insertions(+), 2 deletions(-)
 create mode 100644 rust/kernel/alloc/kvec.rs

diff --git a/rust/kernel/alloc.rs b/rust/kernel/alloc.rs
index 882a65212653..3a0195d23bb4 100644
--- a/rust/kernel/alloc.rs
+++ b/rust/kernel/alloc.rs
@@ -5,6 +5,7 @@
 #[cfg(not(any(test, testlib)))]
 pub mod allocator;
 pub mod kbox;
+pub mod kvec;
 pub mod vec_ext;
 
 #[cfg(any(test, testlib))]
@@ -14,6 +15,7 @@
 pub use self::allocator_test as allocator;
 
 pub use self::kbox::KBox;
+pub use self::kvec::KVec;
 
 /// Indicates an allocation error.
 #[derive(Copy, Clone, PartialEq, Eq, Debug)]
diff --git a/rust/kernel/alloc/kbox.rs b/rust/kernel/alloc/kbox.rs
index 69976fd1d518..3cb2d12f7c39 100644
--- a/rust/kernel/alloc/kbox.rs
+++ b/rust/kernel/alloc/kbox.rs
@@ -2,7 +2,7 @@
 
 //! Implementation of [`KBox`].
 
-use super::{allocator::Kmalloc, AllocError, Allocator, Flags};
+use super::{allocator::Kmalloc, AllocError, Allocator, Flags, KVec};
 use core::fmt;
 use core::mem::ManuallyDrop;
 use core::mem::MaybeUninit;
@@ -120,6 +120,20 @@ pub fn into_pin(b: Self) -> Pin<Self>
     }
 }
 
+impl<T, A, const N: usize> KBox<[T; N], A>
+where
+    A: Allocator,
+{
+    /// Convert a `KBox<[T], A>` to a `KVec<T, A>`.
+    pub fn into_vec(self) -> KVec<T, A> {
+        let len = self.len();
+        unsafe {
+            let (ptr, alloc) = self.into_raw_alloc();
+            KVec::from_raw_parts_alloc(ptr as _, len, len, alloc)
+        }
+    }
+}
+
 impl<T, A> KBox<MaybeUninit<T>, A>
 where
     A: Allocator,
diff --git a/rust/kernel/alloc/kvec.rs b/rust/kernel/alloc/kvec.rs
new file mode 100644
index 000000000000..7ec898657832
--- /dev/null
+++ b/rust/kernel/alloc/kvec.rs
@@ -0,0 +1,605 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Implementation of [`KVec`].
+
+use super::{allocator::Kmalloc, AllocError, Allocator, Flags};
+use crate::types::Unique;
+use core::{
+    fmt,
+    mem::{ManuallyDrop, MaybeUninit},
+    ops::Deref,
+    ops::DerefMut,
+    ops::Index,
+    ops::IndexMut,
+    ptr, slice,
+    slice::SliceIndex,
+};
+
+/// Create a [`KVec`] containing the arguments.
+///
+/// # Examples
+///
+/// ```
+/// use kernel::alloc::{flags::*, KVec};
+///
+/// let mut v = kernel::kvec![];
+/// v.push(1, GFP_KERNEL).unwrap();
+/// assert_eq!(v, [1]);
+///
+/// let mut v = kernel::kvec![1; 3]?;
+/// v.push(4, GFP_KERNEL).unwrap();
+/// assert_eq!(v, [1, 1, 1, 4]);
+///
+/// let mut v = kernel::kvec![1, 2, 3]?;
+/// v.push(4, GFP_KERNEL).unwrap();
+/// assert_eq!(v, [1, 2, 3, 4]);
+///
+/// # Ok::<(), Error>(())
+/// ```
+#[macro_export]
+macro_rules! kvec {
+    () => (
+        {
+            $crate::alloc::KVec::new()
+        }
+    );
+    ($elem:expr; $n:expr) => (
+        {
+            $crate::alloc::KVec::from_elem(
+                $elem, $n,
+                $crate::alloc::allocator::Kmalloc,
+                GFP_KERNEL
+            )
+        }
+    );
+    ($($x:expr),+ $(,)?) => (
+        {
+            match $crate::alloc::KBox::new([$($x),+], GFP_KERNEL) {
+                Ok(b) => Ok($crate::alloc::KBox::into_vec(b)),
+                Err(e) => Err(e),
+            }
+        }
+    );
+}
+
+/// The kernel's `Vec` type named [`KVec`].
+///
+/// A contiguous growable array type with contents allocated with the kernel's allocators (e.g.
+/// `Kmalloc`, `Vmalloc` or `KVmalloc`, written `KVec<T, A>`.
+///
+/// For non-zero-sized values, a [`KVec`] will use the given allocator `A` for its allocation. If
+/// no specific `Allocator` is requested, [`KVec`] will default to `Kmalloc`.
+///
+/// For zero-sized types the [`KVec`]'s pointer must be `dangling_mut::<T>`; no memory is allocated.
+///
+/// Generally, [`KVec`] consists of a pointer that represents the vector's backing buffer, the
+/// capacity of the vector (the number of elements that currently fit into the vector), it's length
+/// (the number of elements that are currently stored in the vector) and the `Allocator` used to
+/// allocate (and free) the backing buffer.
+///
+/// A [`KVec`] can be deconstructed into and (re-)constructed from it's previously named raw parts
+/// and manually modified.
+///
+/// [`KVec`]'s backing buffer gets, if required, automatically increased (re-allocated) when
+/// elements are added to the vector.
+///
+/// # Invariants
+///
+/// The [`KVec`] backing buffer's pointer always properly aligned and either points to memory
+/// allocated with `A` or, for zero-sized types, is a dangling pointer.
+///
+/// The length of the vector always represents the exact number of elements stored in the vector.
+///
+/// The capacity of the vector always represents the absolute number of elements that can be stored
+/// within the vector without re-allocation. However, it is legal for the backing buffer to be
+/// larger than `size_of<T>` times the capacity.
+///
+/// The `Allocator` of the vector is the exact allocator the backing buffer was allocated with (and
+/// must be freed with).
+pub struct KVec<T, A: Allocator = Kmalloc> {
+    ptr: Unique<T>,
+    /// Never used for ZSTs; it's `capacity()`'s responsibility to return usize::MAX in that case.
+    ///
+    /// # Safety
+    ///
+    /// `cap` must be in the `0..=isize::MAX` range.
+    cap: usize,
+    len: usize,
+    alloc: A,
+}
+
+impl<T> KVec<T> {
+    /// Create a new empty `KVec` with no memory allocated yet.
+    #[inline]
+    pub const fn new() -> Self {
+        Self::new_alloc(Kmalloc)
+    }
+
+    /// Creates a new [`KVec`] instance with at least the given capacity.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// use kernel::alloc::{flags::*, KVec};
+    ///
+    /// let v = KVec::<u32>::with_capacity(20, GFP_KERNEL)?;
+    ///
+    /// assert!(v.capacity() >= 20);
+    /// # Ok::<(), Error>(())
+    /// ```
+    #[inline]
+    pub fn with_capacity(capacity: usize, flags: Flags) -> Result<Self, AllocError> {
+        Self::with_capacity_alloc(capacity, Kmalloc, flags)
+    }
+}
+
+impl<T, A> KVec<T, A>
+where
+    A: Allocator,
+{
+    #[inline]
+    fn is_zst() -> bool {
+        core::mem::size_of::<T>() == 0
+    }
+
+    fn buffer_size(capacity: usize) -> Result<usize, AllocError> {
+        if Self::is_zst() {
+            Ok(0)
+        } else {
+            capacity
+                .checked_mul(core::mem::size_of::<T>())
+                .ok_or(AllocError)
+        }
+    }
+
+    /// Returns a reference to the underlying allocator.
+    #[inline]
+    pub fn allocator(&self) -> &A {
+        &self.alloc
+    }
+
+    /// Returns the total number of elements the vector can hold without
+    /// reallocating.
+    pub fn capacity(&self) -> usize {
+        if Self::is_zst() {
+            usize::MAX
+        } else {
+            self.cap
+        }
+    }
+
+    /// Returns the number of elements in the vector, also referred to
+    /// as its 'length'.
+    #[inline]
+    pub fn len(&self) -> usize {
+        self.len
+    }
+
+    /// Forces the length of the vector to new_len.
+    ///
+    /// # Safety
+    ///
+    /// - `new_len` must be less than or equal to [`Self::capacity()`].
+    /// - The elements at `old_len..new_len` must be initialized.
+    #[inline]
+    pub unsafe fn set_len(&mut self, new_len: usize) {
+        self.len = new_len;
+    }
+
+    /// Extracts a slice containing the entire vector.
+    ///
+    /// Equivalent to `&s[..]`.
+    #[inline]
+    pub fn as_slice(&self) -> &[T] {
+        self
+    }
+
+    /// Extracts a mutable slice of the entire vector.
+    ///
+    /// Equivalent to `&mut s[..]`.
+    #[inline]
+    pub fn as_mut_slice(&mut self) -> &mut [T] {
+        self
+    }
+
+    /// Returns an unsafe mutable pointer to the vector's buffer, or a dangling
+    /// raw pointer valid for zero sized reads if the vector didn't allocate.
+    #[inline]
+    pub fn as_mut_ptr(&self) -> *mut T {
+        self.ptr.as_ptr()
+    }
+
+    /// Returns a raw pointer to the slice's buffer.
+    #[inline]
+    pub fn as_ptr(&self) -> *const T {
+        self.as_mut_ptr()
+    }
+
+    /// Returns `true` if the vector contains no elements.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// use kernel::alloc::{flags::*, KVec};
+    ///
+    /// let mut v = KVec::new();
+    /// assert!(v.is_empty());
+    ///
+    /// v.push(1, GFP_KERNEL);
+    /// assert!(!v.is_empty());
+    /// ```
+    #[inline]
+    pub fn is_empty(&self) -> bool {
+        self.len() == 0
+    }
+
+    /// Like `new`, but parameterized over the choice of allocator for the returned `KVec`.
+    #[inline]
+    pub const fn new_alloc(alloc: A) -> Self {
+        Self {
+            ptr: Unique::dangling(),
+            cap: 0,
+            len: 0,
+            alloc,
+        }
+    }
+
+    fn spare_capacity_mut(&mut self) -> &mut [MaybeUninit<T>] {
+        // Note:
+        // This method is not implemented in terms of `split_at_spare_mut`,
+        // to prevent invalidation of pointers to the buffer.
+        unsafe {
+            slice::from_raw_parts_mut(
+                self.as_mut_ptr().add(self.len) as *mut MaybeUninit<T>,
+                self.capacity() - self.len,
+            )
+        }
+    }
+
+    /// Appends an element to the back of the [`KVec`] instance.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// use kernel::alloc::{flags::*, KVec};
+    ///
+    /// let mut v = KVec::new();
+    /// v.push(1, GFP_KERNEL)?;
+    /// assert_eq!(&v, &[1]);
+    ///
+    /// v.push(2, GFP_KERNEL)?;
+    /// assert_eq!(&v, &[1, 2]);
+    /// # Ok::<(), Error>(())
+    /// ```
+    pub fn push(&mut self, v: T, flags: Flags) -> Result<(), AllocError> {
+        KVec::reserve(self, 1, flags)?;
+        let s = self.spare_capacity_mut();
+        s[0].write(v);
+
+        // SAFETY: We just initialised the first spare entry, so it is safe to increase the length
+        // by 1. We also know that the new length is <= capacity because of the previous call to
+        // `reserve` above.
+        unsafe { self.set_len(self.len() + 1) };
+        Ok(())
+    }
+
+    /// Creates a new [`KVec`] instance with at least the given capacity.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// use kernel::alloc::{allocator::Kmalloc, flags::*, KVec};
+    ///
+    /// let v = KVec::<u32, _>::with_capacity_alloc(20, Kmalloc, GFP_KERNEL)?;
+    ///
+    /// assert!(v.capacity() >= 20);
+    /// # Ok::<(), Error>(())
+    /// ```
+    pub fn with_capacity_alloc(
+        capacity: usize,
+        alloc: A,
+        flags: Flags,
+    ) -> Result<Self, AllocError> {
+        let mut v = KVec::new_alloc(alloc);
+
+        Self::reserve(&mut v, capacity, flags)?;
+
+        Ok(v)
+    }
+
+    /// Pushes clones of the elements of slice into the [`KVec`] instance.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// use kernel::alloc::{allocator::Kmalloc, flags::*, KVec};
+    ///
+    /// let mut v = KVec::new_alloc(Kmalloc);
+    /// v.push(1, GFP_KERNEL)?;
+    ///
+    /// v.extend_from_slice(&[20, 30, 40], GFP_KERNEL)?;
+    /// assert_eq!(&v, &[1, 20, 30, 40]);
+    ///
+    /// v.extend_from_slice(&[50, 60], GFP_KERNEL)?;
+    /// assert_eq!(&v, &[1, 20, 30, 40, 50, 60]);
+    /// # Ok::<(), Error>(())
+    /// ```
+    pub fn extend_from_slice(&mut self, other: &[T], flags: Flags) -> Result<(), AllocError>
+    where
+        T: Clone,
+    {
+        self.reserve(other.len(), flags)?;
+        for (slot, item) in core::iter::zip(self.spare_capacity_mut(), other) {
+            slot.write(item.clone());
+        }
+
+        // SAFETY: We just initialised the `other.len()` spare entries, so it is safe to increase
+        // the length by the same amount. We also know that the new length is <= capacity because
+        // of the previous call to `reserve` above.
+        unsafe { self.set_len(self.len() + other.len()) };
+        Ok(())
+    }
+
+    /// Creates a KVec<T, A> directly from a pointer, a length, a capacity, and an allocator.
+    ///
+    /// # Safety
+    ///
+    /// This is highly unsafe, due to the number of invariants that aren’t checked:
+    ///
+    /// - `ptr` must be currently allocated via the given allocator `alloc`.
+    /// - `T` needs to have the same alignment as what `ptr` was allocated with. (`T` having a less
+    ///   strict alignment is not sufficient, the alignment really needs to be equal to satisfy the
+    ///   `dealloc` requirement that memory must be allocated and deallocated with the same layout.)
+    /// - The size of `T` times the `capacity` (i.e. the allocated size in bytes) needs to be
+    ///   smaller or equal the size the pointer was allocated with.
+    /// - `length` needs to be less than or equal to `capacity`.
+    /// - The first `length` values must be properly initialized values of type `T`.
+    /// - The allocated size in bytes must be no larger than `isize::MAX`. See the safety
+    ///   documentation of `pointer::offset`.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// let mut v = kernel::kvec![1, 2, 3]?;
+    /// v.reserve(1, GFP_KERNEL)?;
+    ///
+    /// let (mut ptr, mut len, cap, alloc) = v.into_raw_parts_alloc();
+    ///
+    /// unsafe { ptr.add(len).write(4) };
+    /// len += 1;
+    ///
+    /// let v = unsafe { KVec::from_raw_parts_alloc(ptr, len, cap, alloc) };
+    ///
+    /// assert_eq!(v, [1, 2, 3, 4]);
+    ///
+    /// # Ok::<(), Error>(())
+    /// ```
+    pub unsafe fn from_raw_parts_alloc(
+        ptr: *mut T,
+        length: usize,
+        capacity: usize,
+        alloc: A,
+    ) -> Self {
+        let cap = if Self::is_zst() { 0 } else { capacity };
+
+        Self {
+            ptr: unsafe { Unique::new_unchecked(ptr) },
+            cap,
+            len: length,
+            alloc,
+        }
+    }
+
+    /// Decomposes a `KVec<T, A>` into its raw components: (`pointer`, `length`, `capacity`,
+    /// `allocator`).
+    pub fn into_raw_parts_alloc(self) -> (*mut T, usize, usize, A) {
+        let me = ManuallyDrop::new(self);
+        let len = me.len();
+        let capacity = me.capacity();
+        let ptr = me.as_mut_ptr();
+        let alloc = unsafe { ptr::read(me.allocator()) };
+        (ptr, len, capacity, alloc)
+    }
+
+    /// Ensures that the capacity exceeds the length by at least `additional` elements.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// use kernel::alloc::{allocator::Kmalloc, flags::*, KVec};
+    ///
+    /// let mut v = KVec::new_alloc(Kmalloc);
+    /// v.push(1, GFP_KERNEL)?;
+    ///
+    /// v.reserve(10, GFP_KERNEL)?;
+    /// let cap = v.capacity();
+    /// assert!(cap >= 10);
+    ///
+    /// v.reserve(10, GFP_KERNEL)?;
+    /// let new_cap = v.capacity();
+    /// assert_eq!(new_cap, cap);
+    ///
+    /// # Ok::<(), Error>(())
+    /// ```
+    pub fn reserve(&mut self, additional: usize, flags: Flags) -> Result<(), AllocError> {
+        let len = self.len();
+        let cap = self.capacity();
+
+        if cap - len >= additional {
+            return Ok(());
+        }
+
+        if Self::is_zst() {
+            // The capacity is already `usize::MAX` for SZTs, we can't go higher.
+            return Err(AllocError);
+        }
+
+        // We know cap is <= `isize::MAX` because `Layout::array` fails if the resulting byte size
+        // is greater than `isize::MAX`. So the multiplication by two won't overflow.
+        let new_cap = core::cmp::max(cap * 2, len.checked_add(additional).ok_or(AllocError)?);
+        let layout = core::alloc::Layout::array::<T>(new_cap).map_err(|_| AllocError)?;
+
+        // We need to make sure that `ptr` is either NULL or comes from a previous call to
+        // `realloc_flags`. A `KVec<T, A>`'s `ptr` value is not guaranteed to be NULL and might be
+        // dangling after being created with `KVec::new`. Instead, we can rely on `KVec<T, A>`'s
+        // capacity to be zero if no memory has been allocated yet.
+        let ptr = if cap == 0 {
+            ptr::null_mut()
+        } else {
+            self.as_mut_ptr()
+        };
+
+        // SAFETY: `ptr` is valid because it's either NULL or comes from a previous call to
+        // `krealloc_aligned`. We also verified that the type is not a ZST.
+        let ptr = unsafe {
+            self.alloc
+                .realloc(ptr.cast(), Self::buffer_size(cap)?, layout, flags)
+        }?;
+
+        self.ptr = ptr.cast().into();
+        self.cap = new_cap;
+
+        Ok(())
+    }
+}
+
+impl<T: Clone, A: Allocator> KVec<T, A> {
+    /// Extend the vector by `n` clones of value.
+    pub fn extend_with(&mut self, n: usize, value: T, flags: Flags) -> Result<(), AllocError> {
+        self.reserve(n, flags)?;
+
+        unsafe {
+            let mut ptr = self.as_mut_ptr().add(self.len());
+
+            // Write all elements except the last one
+            for _ in 1..n {
+                ptr::write(ptr, value.clone());
+                ptr = ptr.add(1);
+            }
+
+            if n > 0 {
+                // We can write the last element directly without cloning needlessly
+                ptr::write(ptr, value);
+            }
+        }
+
+        // SAFETY: `self.reserve` not bailing out with an error guarantees that we're not
+        // exceeding the capacity of this `KVec`.
+        unsafe { self.set_len(self.len() + n) };
+
+        Ok(())
+    }
+
+    /// Create a new `KVec<T, A> and extend it by `n` clones of value.
+    pub fn from_elem(value: T, n: usize, alloc: A, flags: Flags) -> Result<Self, AllocError> {
+        let mut v = Self::with_capacity_alloc(n, alloc, flags)?;
+
+        v.extend_with(n, value, flags)?;
+
+        Ok(v)
+    }
+}
+
+impl<T, A> Drop for KVec<T, A>
+where
+    A: Allocator,
+{
+    fn drop(&mut self) {
+        // SAFETY: We need to drop the vector's elements in place, before we free the backing
+        // memory.
+        unsafe {
+            core::ptr::drop_in_place(core::ptr::slice_from_raw_parts_mut(
+                self.as_mut_ptr(),
+                self.len,
+            ))
+        };
+
+        // If `cap == 0` we never allocated any memory in the first place.
+        if self.cap != 0 {
+            // SAFETY: `self.ptr` was previously allocated with `self.alloc`.
+            unsafe { self.alloc.free(self.as_mut_ptr().cast()) };
+        }
+    }
+}
+
+impl<T> Default for KVec<T> {
+    #[inline]
+    fn default() -> Self {
+        Self::new()
+    }
+}
+
+impl<T: fmt::Debug, A: Allocator> fmt::Debug for KVec<T, A> {
+    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
+        fmt::Debug::fmt(&**self, f)
+    }
+}
+
+impl<T, A> Deref for KVec<T, A>
+where
+    A: Allocator,
+{
+    type Target = [T];
+
+    #[inline]
+    fn deref(&self) -> &[T] {
+        unsafe { slice::from_raw_parts(self.as_ptr(), self.len) }
+    }
+}
+
+impl<T, A> DerefMut for KVec<T, A>
+where
+    A: Allocator,
+{
+    #[inline]
+    fn deref_mut(&mut self) -> &mut [T] {
+        unsafe { slice::from_raw_parts_mut(self.as_mut_ptr(), self.len) }
+    }
+}
+
+impl<T: Eq, A> Eq for KVec<T, A> where A: Allocator {}
+
+impl<T, I: SliceIndex<[T]>, A> Index<I> for KVec<T, A>
+where
+    A: Allocator,
+{
+    type Output = I::Output;
+
+    #[inline]
+    fn index(&self, index: I) -> &Self::Output {
+        Index::index(&**self, index)
+    }
+}
+
+impl<T, I: SliceIndex<[T]>, A> IndexMut<I> for KVec<T, A>
+where
+    A: Allocator,
+{
+    #[inline]
+    fn index_mut(&mut self, index: I) -> &mut Self::Output {
+        IndexMut::index_mut(&mut **self, index)
+    }
+}
+
+macro_rules! __impl_slice_eq {
+    ([$($vars:tt)*] $lhs:ty, $rhs:ty $(where $ty:ty: $bound:ident)?) => {
+        impl<T, U, $($vars)*> PartialEq<$rhs> for $lhs
+        where
+            T: PartialEq<U>,
+            $($ty: $bound)?
+        {
+            #[inline]
+            fn eq(&self, other: &$rhs) -> bool { self[..] == other[..] }
+        }
+    }
+}
+
+__impl_slice_eq! { [A1: Allocator, A2: Allocator] KVec<T, A1>, KVec<U, A2> }
+__impl_slice_eq! { [A: Allocator] KVec<T, A>, &[U] }
+__impl_slice_eq! { [A: Allocator] KVec<T, A>, &mut [U] }
+__impl_slice_eq! { [A: Allocator] &[T], KVec<U, A> }
+__impl_slice_eq! { [A: Allocator] &mut [T], KVec<U, A> }
+__impl_slice_eq! { [A: Allocator] KVec<T, A>, [U] }
+__impl_slice_eq! { [A: Allocator] [T], KVec<U, A> }
+__impl_slice_eq! { [A: Allocator, const N: usize] KVec<T, A>, [U; N] }
+__impl_slice_eq! { [A: Allocator, const N: usize] KVec<T, A>, &[U; N] }
diff --git a/rust/kernel/prelude.rs b/rust/kernel/prelude.rs
index 20112233d750..0ee3f0d203e2 100644
--- a/rust/kernel/prelude.rs
+++ b/rust/kernel/prelude.rs
@@ -14,7 +14,7 @@
 #[doc(no_inline)]
 pub use core::pin::Pin;
 
-pub use crate::alloc::{flags::*, vec_ext::VecExt, KBox};
+pub use crate::alloc::{flags::*, vec_ext::VecExt, KBox, KVec};
 
 #[doc(no_inline)]
 pub use alloc::vec::Vec;
-- 
2.45.2


