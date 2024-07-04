Return-Path: <linux-kernel+bounces-241471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 218F4927BAD
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 19:11:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45BE41C22330
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 17:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C9681B47BF;
	Thu,  4 Jul 2024 17:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wn2diid4"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC9D51C2DCA
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 17:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720112948; cv=none; b=FLNJAN66jeE3XKgj1vD2SMoo7KM8tyxWrMT8qlszNX8tmikwwbtICaAD0HBJWHHhS1ku/Dlj+cDGOAESMd8hZjrY1FjmThJAXkm8GZpyDXBnxq+0tXVbuiZ2A2vxoculJdmwSbANcnfaqaBaQNjlZNy62+qQCYCMxlOY8gfZ348=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720112948; c=relaxed/simple;
	bh=o87Q6nrhXq+2epNBXh/xEE5xjiGWYWfou9Wo5ZW6Mxg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Oa7q3Jpi0Iq1xpR61e+xefshYQ++2Wk+fbpt09b9OCE3tAYlgeKaJOsSUf0eYehFvVh4u8np4oWazS2zGYuunY6lCsMtxxkqQIhuhGWb0QGnbK08XDeQNYaK/ctNktOwpr4a4xsrXCZJB2WBc2o63CyUvXU37isSki84MsUYDGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Wn2diid4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720112946;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IsEZYPUnJUrFTc5sYGJG2HQ1b8hAp+MrWs9/jDi7WD8=;
	b=Wn2diid4bURJYZQ/P6v0k3mI9lB76ktRVaUDv563FXrBwcZUdyMq0pPQd8lfor4dv7guxw
	2QF3twiyhUR3bZ/ke13x+/J2xQEgpjCAh/qDcnf/sqEP4Dnnl9t+DneH6y4n5wRhsyio9h
	bYsDji1yvRMzph0u3tHLAvligC/xaHc=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-150-4I8d-4W6PAaym0InC0Ihfw-1; Thu, 04 Jul 2024 13:09:04 -0400
X-MC-Unique: 4I8d-4W6PAaym0InC0Ihfw-1
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-52e982ace13so914596e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2024 10:09:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720112943; x=1720717743;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IsEZYPUnJUrFTc5sYGJG2HQ1b8hAp+MrWs9/jDi7WD8=;
        b=dQ9EMmVyd5SoPu+nAdaHgvXbObag3taKXw3mwHu0slW0nLRu63T5fSJduue95ffCTM
         ZtvfdD1UfX+WRMp46j04tz2nEOovGisdQbXjF5J2t2W8jSU5pInGKt3Zj2i52IkygFpG
         g3PXsabL34qX5q/POnUh3SPo3kKL4PgCxHi/tmTzGyJAzL9NDkQuFlJrVQEqnGxzbClS
         juyIJVFC5nDMuVSVhgnT/kpschobxO5ZEdoORrp4wWVrxW2TqlVt35e4fIV8bicQKJ3l
         Z2c9pRwmDHgMmzm/wG2cbFACGA7uy/BVt46Teu9muyAZYXanxEdEoUOPW3w7sWrNLP8v
         8gJw==
X-Forwarded-Encrypted: i=1; AJvYcCVVyNNKUoyTcIn4RwC5i8aJcxQT68raqChYIoThoZUowTLwCmlMycazi5dvpfwNjWD+h05+xQDghANv4ykxROHMffx4KfI+WTafpuFS
X-Gm-Message-State: AOJu0YzoIZjwY2NfLc8BHzhOSc9KvKgWBglualgo271fhsKYqrUKxipa
	U4LXFko75eVR+LlYZlJoreO5jPrLbScn3m9zCM8VXr/pLjIBu6Rou5/uVgihLnUSIEvFp0Hvun+
	Djp6qG8Z1AJewb+CJvFkz62YgbYui8oDExbEjuW7fBcnK4+8BNzqzqx3uKb/Dr/oFTxsv3Q==
X-Received: by 2002:a19:7501:0:b0:52c:c9cd:ebc3 with SMTP id 2adb3069b0e04-52ea06e3e43mr1409953e87.63.1720112942716;
        Thu, 04 Jul 2024 10:09:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHHEaZYFSL8J5jp11qG3WtnRhMrCxosPHJENTXOj/vhYDA1OWkwhTMXpmw5imfcG5/3gGCmgw==
X-Received: by 2002:a19:7501:0:b0:52c:c9cd:ebc3 with SMTP id 2adb3069b0e04-52ea06e3e43mr1409919e87.63.1720112942319;
        Thu, 04 Jul 2024 10:09:02 -0700 (PDT)
Received: from cassiopeiae.. ([2a02:810d:4b3f:ee94:642:1aff:fe31:a19f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367a5a31a1asm301302f8f.7.2024.07.04.10.09.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 10:09:01 -0700 (PDT)
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
Subject: [PATCH 12/20] rust: alloc: remove `BoxExt` extension
Date: Thu,  4 Jul 2024 19:06:40 +0200
Message-ID: <20240704170738.3621-13-dakr@redhat.com>
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

Now that all existing `Box` users were moved to `KBox`, remove the
`BoxExt` extension.

Signed-off-by: Danilo Krummrich <dakr@redhat.com>
---
 rust/kernel/alloc.rs         |  1 -
 rust/kernel/alloc/box_ext.rs | 51 ------------------------------------
 rust/kernel/init.rs          | 34 +-----------------------
 rust/kernel/lib.rs           |  1 -
 rust/kernel/prelude.rs       |  4 +--
 rust/kernel/types.rs         | 23 ----------------
 6 files changed, 3 insertions(+), 111 deletions(-)
 delete mode 100644 rust/kernel/alloc/box_ext.rs

diff --git a/rust/kernel/alloc.rs b/rust/kernel/alloc.rs
index ff90cefad0ea..882a65212653 100644
--- a/rust/kernel/alloc.rs
+++ b/rust/kernel/alloc.rs
@@ -4,7 +4,6 @@
 
 #[cfg(not(any(test, testlib)))]
 pub mod allocator;
-pub mod box_ext;
 pub mod kbox;
 pub mod vec_ext;
 
diff --git a/rust/kernel/alloc/box_ext.rs b/rust/kernel/alloc/box_ext.rs
deleted file mode 100644
index 1aeae02c147e..000000000000
--- a/rust/kernel/alloc/box_ext.rs
+++ /dev/null
@@ -1,51 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-
-//! Extensions to [`Box`] for fallible allocations.
-
-use super::{AllocError, Flags};
-use alloc::boxed::Box;
-use core::mem::MaybeUninit;
-
-/// Extensions to [`Box`].
-pub trait BoxExt<T>: Sized {
-    /// Allocates a new box.
-    ///
-    /// The allocation may fail, in which case an error is returned.
-    fn new(x: T, flags: Flags) -> Result<Self, AllocError>;
-
-    /// Allocates a new uninitialised box.
-    ///
-    /// The allocation may fail, in which case an error is returned.
-    fn new_uninit(flags: Flags) -> Result<Box<MaybeUninit<T>>, AllocError>;
-}
-
-impl<T> BoxExt<T> for Box<T> {
-    fn new(x: T, flags: Flags) -> Result<Self, AllocError> {
-        let b = <Self as BoxExt<_>>::new_uninit(flags)?;
-        Ok(Box::write(b, x))
-    }
-
-    #[cfg(any(test, testlib))]
-    fn new_uninit(_flags: Flags) -> Result<Box<MaybeUninit<T>>, AllocError> {
-        Ok(Box::new_uninit())
-    }
-
-    #[cfg(not(any(test, testlib)))]
-    fn new_uninit(flags: Flags) -> Result<Box<MaybeUninit<T>>, AllocError> {
-        let ptr = if core::mem::size_of::<MaybeUninit<T>>() == 0 {
-            core::ptr::NonNull::dangling()
-        } else {
-            let alloc: &dyn super::Allocator = &super::allocator::Kmalloc;
-            let layout = core::alloc::Layout::new::<MaybeUninit<T>>();
-
-            // SAFETY: Memory is being allocated (first arg is null). The only other source of
-            // safety issues is sleeping on atomic context, which is addressed by klint. Lastly,
-            // the type is not a SZT (checked above).
-            alloc.alloc(layout, flags)?.cast()
-        };
-
-        // SAFETY: For non-zero-sized types, we allocate above using the global allocator. For
-        // zero-sized types, we use `NonNull::dangling`.
-        Ok(unsafe { Box::from_raw(ptr.as_ptr()) })
-    }
-}
diff --git a/rust/kernel/init.rs b/rust/kernel/init.rs
index b386bafd5f95..f59f502c3e0b 100644
--- a/rust/kernel/init.rs
+++ b/rust/kernel/init.rs
@@ -212,12 +212,11 @@
 //! [`pin_init!`]: crate::pin_init!
 
 use crate::{
-    alloc::{box_ext::BoxExt, AllocError, Flags, KBox},
+    alloc::{AllocError, Flags, KBox},
     error::{self, Error},
     sync::UniqueArc,
     types::{Opaque, ScopeGuard},
 };
-use alloc::boxed::Box;
 use core::{
     cell::UnsafeCell,
     convert::Infallible,
@@ -590,7 +589,6 @@ macro_rules! pin_init {
 /// # Examples
 ///
 /// ```rust
-/// # #![feature(new_uninit)]
 /// use kernel::{alloc::KBox, init::{self, PinInit}, error::Error};
 /// #[pin_data]
 /// struct BigBuf {
@@ -1155,36 +1153,6 @@ fn init<E>(init: impl Init<T, E>, flags: Flags) -> error::Result<Self>
     }
 }
 
-impl<T> InPlaceInit<T> for Box<T> {
-    #[inline]
-    fn try_pin_init<E>(init: impl PinInit<T, E>, flags: Flags) -> Result<Pin<Self>, E>
-    where
-        E: From<AllocError>,
-    {
-        let mut this = <Box<_> as BoxExt<_>>::new_uninit(flags)?;
-        let slot = this.as_mut_ptr();
-        // SAFETY: When init errors/panics, slot will get deallocated but not dropped,
-        // slot is valid and will not be moved, because we pin it later.
-        unsafe { init.__pinned_init(slot)? };
-        // SAFETY: All fields have been initialized.
-        Ok(unsafe { this.assume_init() }.into())
-    }
-
-    #[inline]
-    fn try_init<E>(init: impl Init<T, E>, flags: Flags) -> Result<Self, E>
-    where
-        E: From<AllocError>,
-    {
-        let mut this = <Box<_> as BoxExt<_>>::new_uninit(flags)?;
-        let slot = this.as_mut_ptr();
-        // SAFETY: When init errors/panics, slot will get deallocated but not dropped,
-        // slot is valid.
-        unsafe { init.__init(slot)? };
-        // SAFETY: All fields have been initialized.
-        Ok(unsafe { this.assume_init() })
-    }
-}
-
 impl<T> InPlaceInit<T> for KBox<T> {
     #[inline]
     fn try_pin_init<E>(init: impl PinInit<T, E>, flags: Flags) -> Result<Pin<Self>, E>
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index fbd91a48ff8b..f119bbde955b 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -14,7 +14,6 @@
 #![no_std]
 #![feature(coerce_unsized)]
 #![feature(dispatch_from_dyn)]
-#![feature(new_uninit)]
 #![feature(receiver_trait)]
 #![feature(unsize)]
 
diff --git a/rust/kernel/prelude.rs b/rust/kernel/prelude.rs
index d75c14234133..20112233d750 100644
--- a/rust/kernel/prelude.rs
+++ b/rust/kernel/prelude.rs
@@ -14,10 +14,10 @@
 #[doc(no_inline)]
 pub use core::pin::Pin;
 
-pub use crate::alloc::{box_ext::BoxExt, flags::*, vec_ext::VecExt, KBox};
+pub use crate::alloc::{flags::*, vec_ext::VecExt, KBox};
 
 #[doc(no_inline)]
-pub use alloc::{boxed::Box, vec::Vec};
+pub use alloc::vec::Vec;
 
 #[doc(no_inline)]
 pub use macros::{module, pin_data, pinned_drop, vtable, Zeroable};
diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
index 939ec27c584d..0b2a3ce538a6 100644
--- a/rust/kernel/types.rs
+++ b/rust/kernel/types.rs
@@ -4,7 +4,6 @@
 
 use crate::alloc::KBox;
 use crate::init::{self, PinInit};
-use alloc::boxed::Box;
 use core::{
     cell::UnsafeCell,
     marker::{PhantomData, PhantomPinned},
@@ -68,28 +67,6 @@ unsafe fn try_from_foreign(ptr: *const core::ffi::c_void) -> Option<Self> {
     }
 }
 
-impl<T: 'static> ForeignOwnable for Box<T> {
-    type Borrowed<'a> = &'a T;
-
-    fn into_foreign(self) -> *const core::ffi::c_void {
-        Box::into_raw(self) as _
-    }
-
-    unsafe fn borrow<'a>(ptr: *const core::ffi::c_void) -> &'a T {
-        // SAFETY: The safety requirements for this function ensure that the object is still alive,
-        // so it is safe to dereference the raw pointer.
-        // The safety requirements of `from_foreign` also ensure that the object remains alive for
-        // the lifetime of the returned value.
-        unsafe { &*ptr.cast() }
-    }
-
-    unsafe fn from_foreign(ptr: *const core::ffi::c_void) -> Self {
-        // SAFETY: The safety requirements of this function ensure that `ptr` comes from a previous
-        // call to `Self::into_foreign`.
-        unsafe { Box::from_raw(ptr as _) }
-    }
-}
-
 impl<T: 'static> ForeignOwnable for KBox<T> {
     type Borrowed<'a> = &'a T;
 
-- 
2.45.2


