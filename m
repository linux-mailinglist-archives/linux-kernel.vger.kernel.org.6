Return-Path: <linux-kernel+bounces-241477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07A28927BB5
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 19:13:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B02282846E4
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 17:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEC7B1B5803;
	Thu,  4 Jul 2024 17:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="evwFRpip"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C2B31CFD43
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 17:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720112969; cv=none; b=mmikiisHok9bdJVpBWD54k8gQGsT8ISdhdqG5FUyXIRYoigKB30nY9XCZiexD+xiDAHhZMUvozPkelgRFRR5Un2oNICdc0+kdntb62sabLIjsyxnL6IDwvxlg8vMD8tmshZic/yutvOHtHYfsaJMb+wVlBlTIAsasSwecxkRx6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720112969; c=relaxed/simple;
	bh=unZd8SNo4EyBPZwAOYtJ6SCq7DPMNM2ujfeIqLeIoPs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PqCFr5L2cIKVq3zrn4ZIBUgg/2jlSDkCdCXRiEJnmxX0s52pDMrywByIhWNh8SUVVa2avSqkNnkdFVhHGi1NgaiAxfM8Ig6G0Eb+SFfSf3O0dkrU1ygxizyWt8wA8oDS866vQfiW6nHO2+VLONITIkKSta5R9NLdi+1lwUqk4jE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=evwFRpip; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720112966;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D0CT3DkkY+yNqCNHJuyWLBFD/Y9xzpFr8fJwqHRElVo=;
	b=evwFRpipyuYydY4UXdUQ2Ndyv6zSYPiV51CBHTlxl7eiKS2wO0Xx1hjsBVFbe7yHrpTBZL
	g/RUxFJ/rzBi5QPJrQCtDZyE4Ld4naIAN1mxzLprhqOV22PkJGY/gk4r6CBrDhbh38HZbY
	2/l1I2DCtQCTMagq3BcwGo0b3JOXPcw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-341-xQe3NCOdNMioEhgKTC0x9A-1; Thu, 04 Jul 2024 13:09:24 -0400
X-MC-Unique: xQe3NCOdNMioEhgKTC0x9A-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4256718144dso8258415e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2024 10:09:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720112963; x=1720717763;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D0CT3DkkY+yNqCNHJuyWLBFD/Y9xzpFr8fJwqHRElVo=;
        b=C97SbAwobycSvUN4mxTl4szh5u4yaSMppCzvroU4F4/sBYrnRY/3TddwZbiOQXvDG6
         CLT39PJ62acpGdx7UJWSdXRpUkXXmX1pI1E8KvfprWayEpYaPgEs4EFL7CmF2SQ6W1WJ
         lDc1/uuIhzhP5r53Wuik4FmOwWDuU4g6sSSNR5dtKKDdRsmJ0xxl+SlEYLmF8+g0Y2o6
         GMj05SWsvQxVi0ZFP7MnvFePQqMk3BP1cRaLgbdn+eFUNS6pdzszWw4R5QR6kDqGsm4R
         h7EU+CsoiiR6qwXvnuTZ7PnP8YmIf5EKHQl4rELlIZ176HkTnjM0kSZHh18vIfc4SbfU
         Mrnw==
X-Forwarded-Encrypted: i=1; AJvYcCV/JEa1pVH41sNMykUHZFJKfsNv048Kr/sQnbkQvUvxb75zEGP5VndMPhGQVMzAetlyspyIe4Vqrth26gEpbhZazYYlZO7zZS43zwnA
X-Gm-Message-State: AOJu0YwchAdVqeJrqG68WQLoNyJjy4Mya7jN66DX/m7C/S2wOQb244ms
	Jo3Z7YqrHO90RqA87ZxPyqme6h57ZziQHMA4a+eMubEREl88MOV3e8vBTeOzIZyIeGT+hMECcGB
	kVgqrzx+Dh3Sj/yrkR7VgBcu5cBKiGBFhETIvKN5lJOkqvKmjTQWOs8w+84bYbg==
X-Received: by 2002:a05:600c:12d2:b0:425:73ba:e012 with SMTP id 5b1f17b1804b1-4264a3bc309mr19751585e9.7.1720112962996;
        Thu, 04 Jul 2024 10:09:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFfh6LXgR2Un18etB/U4D4xFPGKtOmoSHMl3k9SXFcepz5JY5ESDnz4WGx8qOXEK4Bv7oGh0Q==
X-Received: by 2002:a05:600c:12d2:b0:425:73ba:e012 with SMTP id 5b1f17b1804b1-4264a3bc309mr19751375e9.7.1720112962569;
        Thu, 04 Jul 2024 10:09:22 -0700 (PDT)
Received: from cassiopeiae.. ([2a02:810d:4b3f:ee94:642:1aff:fe31:a19f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4264a2fc8bcsm30974125e9.44.2024.07.04.10.09.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 10:09:22 -0700 (PDT)
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
Subject: [PATCH 17/20] rust: alloc: remove `VecExt` extension
Date: Thu,  4 Jul 2024 19:06:45 +0200
Message-ID: <20240704170738.3621-18-dakr@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240704170738.3621-1-dakr@redhat.com>
References: <20240704170738.3621-1-dakr@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that all existing `Vec` users were moved to `KVec`, remove the
`VecExt` extension.

Signed-off-by: Danilo Krummrich <dakr@redhat.com>
---
 rust/kernel/alloc.rs         |   1 -
 rust/kernel/alloc/vec_ext.rs | 185 -----------------------------------
 rust/kernel/prelude.rs       |   5 +-
 3 files changed, 1 insertion(+), 190 deletions(-)
 delete mode 100644 rust/kernel/alloc/vec_ext.rs

diff --git a/rust/kernel/alloc.rs b/rust/kernel/alloc.rs
index e6a5d65e0c48..178f556aa7b0 100644
--- a/rust/kernel/alloc.rs
+++ b/rust/kernel/alloc.rs
@@ -6,7 +6,6 @@
 pub mod allocator;
 pub mod kbox;
 pub mod kvec;
-pub mod vec_ext;
 
 #[cfg(any(test, testlib))]
 pub mod allocator_test;
diff --git a/rust/kernel/alloc/vec_ext.rs b/rust/kernel/alloc/vec_ext.rs
deleted file mode 100644
index bf277976ed38..000000000000
--- a/rust/kernel/alloc/vec_ext.rs
+++ /dev/null
@@ -1,185 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-
-//! Extensions to [`Vec`] for fallible allocations.
-
-use super::{AllocError, Flags};
-use alloc::vec::Vec;
-use core::ptr;
-
-/// Extensions to [`Vec`].
-pub trait VecExt<T>: Sized {
-    /// Creates a new [`Vec`] instance with at least the given capacity.
-    ///
-    /// # Examples
-    ///
-    /// ```
-    /// let v = Vec::<u32>::with_capacity(20, GFP_KERNEL)?;
-    ///
-    /// assert!(v.capacity() >= 20);
-    /// # Ok::<(), Error>(())
-    /// ```
-    fn with_capacity(capacity: usize, flags: Flags) -> Result<Self, AllocError>;
-
-    /// Appends an element to the back of the [`Vec`] instance.
-    ///
-    /// # Examples
-    ///
-    /// ```
-    /// let mut v = Vec::new();
-    /// v.push(1, GFP_KERNEL)?;
-    /// assert_eq!(&v, &[1]);
-    ///
-    /// v.push(2, GFP_KERNEL)?;
-    /// assert_eq!(&v, &[1, 2]);
-    /// # Ok::<(), Error>(())
-    /// ```
-    fn push(&mut self, v: T, flags: Flags) -> Result<(), AllocError>;
-
-    /// Pushes clones of the elements of slice into the [`Vec`] instance.
-    ///
-    /// # Examples
-    ///
-    /// ```
-    /// let mut v = Vec::new();
-    /// v.push(1, GFP_KERNEL)?;
-    ///
-    /// v.extend_from_slice(&[20, 30, 40], GFP_KERNEL)?;
-    /// assert_eq!(&v, &[1, 20, 30, 40]);
-    ///
-    /// v.extend_from_slice(&[50, 60], GFP_KERNEL)?;
-    /// assert_eq!(&v, &[1, 20, 30, 40, 50, 60]);
-    /// # Ok::<(), Error>(())
-    /// ```
-    fn extend_from_slice(&mut self, other: &[T], flags: Flags) -> Result<(), AllocError>
-    where
-        T: Clone;
-
-    /// Ensures that the capacity exceeds the length by at least `additional` elements.
-    ///
-    /// # Examples
-    ///
-    /// ```
-    /// let mut v = Vec::new();
-    /// v.push(1, GFP_KERNEL)?;
-    ///
-    /// v.reserve(10, GFP_KERNEL)?;
-    /// let cap = v.capacity();
-    /// assert!(cap >= 10);
-    ///
-    /// v.reserve(10, GFP_KERNEL)?;
-    /// let new_cap = v.capacity();
-    /// assert_eq!(new_cap, cap);
-    ///
-    /// # Ok::<(), Error>(())
-    /// ```
-    fn reserve(&mut self, additional: usize, flags: Flags) -> Result<(), AllocError>;
-}
-
-impl<T> VecExt<T> for Vec<T> {
-    fn with_capacity(capacity: usize, flags: Flags) -> Result<Self, AllocError> {
-        let mut v = Vec::new();
-        <Self as VecExt<_>>::reserve(&mut v, capacity, flags)?;
-        Ok(v)
-    }
-
-    fn push(&mut self, v: T, flags: Flags) -> Result<(), AllocError> {
-        <Self as VecExt<_>>::reserve(self, 1, flags)?;
-        let s = self.spare_capacity_mut();
-        s[0].write(v);
-
-        // SAFETY: We just initialised the first spare entry, so it is safe to increase the length
-        // by 1. We also know that the new length is <= capacity because of the previous call to
-        // `reserve` above.
-        unsafe { self.set_len(self.len() + 1) };
-        Ok(())
-    }
-
-    fn extend_from_slice(&mut self, other: &[T], flags: Flags) -> Result<(), AllocError>
-    where
-        T: Clone,
-    {
-        <Self as VecExt<_>>::reserve(self, other.len(), flags)?;
-        for (slot, item) in core::iter::zip(self.spare_capacity_mut(), other) {
-            slot.write(item.clone());
-        }
-
-        // SAFETY: We just initialised the `other.len()` spare entries, so it is safe to increase
-        // the length by the same amount. We also know that the new length is <= capacity because
-        // of the previous call to `reserve` above.
-        unsafe { self.set_len(self.len() + other.len()) };
-        Ok(())
-    }
-
-    #[cfg(any(test, testlib))]
-    fn reserve(&mut self, additional: usize, _flags: Flags) -> Result<(), AllocError> {
-        Vec::reserve(self, additional);
-        Ok(())
-    }
-
-    #[cfg(not(any(test, testlib)))]
-    fn reserve(&mut self, additional: usize, flags: Flags) -> Result<(), AllocError> {
-        let alloc: &dyn super::Allocator = &super::allocator::Kmalloc;
-        let len = self.len();
-        let cap = self.capacity();
-
-        if cap - len >= additional {
-            return Ok(());
-        }
-
-        if core::mem::size_of::<T>() == 0 {
-            // The capacity is already `usize::MAX` for SZTs, we can't go higher.
-            return Err(AllocError);
-        }
-
-        // We know cap is <= `isize::MAX` because `Layout::array` fails if the resulting byte size
-        // is greater than `isize::MAX`. So the multiplication by two won't overflow.
-        let new_cap = core::cmp::max(cap * 2, len.checked_add(additional).ok_or(AllocError)?);
-        let layout = core::alloc::Layout::array::<T>(new_cap).map_err(|_| AllocError)?;
-
-        let (old_ptr, len, cap) = destructure(self);
-
-        // We need to make sure that `ptr` is either NULL or comes from a previous call to
-        // `krealloc_aligned`. A `Vec<T>`'s `ptr` value is not guaranteed to be NULL and might be
-        // dangling after being created with `Vec::new`. Instead, we can rely on `Vec<T>`'s capacity
-        // to be zero if no memory has been allocated yet.
-        let ptr = if cap == 0 { ptr::null_mut() } else { old_ptr };
-
-        // SAFETY: `ptr` is valid because it's either NULL or comes from a previous call to
-        // `krealloc_aligned`. We also verified that the type is not a ZST.
-        match unsafe { alloc.realloc(ptr.cast(), cap, layout, flags) } {
-            Ok(ptr) => {
-                // SAFETY: `ptr` has been reallocated with the layout for `new_cap` elements.
-                // `new_cap` is greater than `cap`, so it continues to be >= `len`.
-                unsafe { rebuild(self, ptr.as_ptr().cast(), len, new_cap) };
-                Ok(())
-            }
-            Err(err) => {
-                // SAFETY: We are just rebuilding the existing `Vec` with no changes.
-                unsafe { rebuild(self, old_ptr, len, cap) };
-                Err(err)
-            }
-        }
-    }
-}
-
-#[cfg(not(any(test, testlib)))]
-fn destructure<T>(v: &mut Vec<T>) -> (*mut T, usize, usize) {
-    let mut tmp = Vec::new();
-    core::mem::swap(&mut tmp, v);
-    let mut tmp = core::mem::ManuallyDrop::new(tmp);
-    let len = tmp.len();
-    let cap = tmp.capacity();
-    (tmp.as_mut_ptr(), len, cap)
-}
-
-/// Rebuilds a `Vec` from a pointer, length, and capacity.
-///
-/// # Safety
-///
-/// The same as [`Vec::from_raw_parts`].
-#[cfg(not(any(test, testlib)))]
-unsafe fn rebuild<T>(v: &mut Vec<T>, ptr: *mut T, len: usize, cap: usize) {
-    // SAFETY: The safety requirements from this function satisfy those of `from_raw_parts`.
-    let mut tmp = unsafe { Vec::from_raw_parts(ptr, len, cap) };
-    core::mem::swap(&mut tmp, v);
-}
diff --git a/rust/kernel/prelude.rs b/rust/kernel/prelude.rs
index 0ee3f0d203e2..0836394ddab8 100644
--- a/rust/kernel/prelude.rs
+++ b/rust/kernel/prelude.rs
@@ -14,10 +14,7 @@
 #[doc(no_inline)]
 pub use core::pin::Pin;
 
-pub use crate::alloc::{flags::*, vec_ext::VecExt, KBox, KVec};
-
-#[doc(no_inline)]
-pub use alloc::vec::Vec;
+pub use crate::alloc::{flags::*, KBox, KVec};
 
 #[doc(no_inline)]
 pub use macros::{module, pin_data, pinned_drop, vtable, Zeroable};
-- 
2.45.2


