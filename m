Return-Path: <linux-kernel+bounces-241470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A59B927BAC
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 19:11:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E535FB20D6B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 17:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AA961B47C0;
	Thu,  4 Jul 2024 17:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CiqQHgjI"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5558B1C094E
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 17:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720112944; cv=none; b=ovgkm+eI/CedKk6/uAYkmH7FU9m7Hcxq3+WNemaxhJ613Nv2KZpiBK8dOAp02v8IzE6Jc9aN3wpf3lGS6rNivxcgt0CikML1dfHP/wX8vGER0LDbperelQQRc387Lu6jYpQpGEOtgTH+a+UtF0wOHGdv5xTDh9eGPirDlePo4j4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720112944; c=relaxed/simple;
	bh=QCzWpqZXmBuahkkczBh/8yo+05BdG/QuC+7cPjSB8w0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BQ/yj+NvVRAmFzsslaMEDaLyF8M9f2TMRQ/AZUfkPtCbIKhiuXOIY8zUaCdWZzMNaxzgjr+mUH5DQUrRmxYOo8nnEo0aykOMJGT/3meZNKiJBzBCYNnyJk1Mtt6XwYiW8HBvacWnRwhTqiBOisj/Z+fhmixNkwogWyfObApiYqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CiqQHgjI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720112941;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g9s5070EIudwtdEBvneHUeqtniI+V0KQfF9cleWjjcI=;
	b=CiqQHgjII67dV5nRHVEd+kTA5G3Z7b6xgGyoLFR/E05eyTWlO/e3bhvbmxzH2X+DyPmHES
	TEBCitudzeWchl/7r0gwmQnnhDLQPeokqy5a5WiM14JqOlzVEdvwnnFlfezwvqAGIs/1lG
	h7AsSYkbj+E8Vb9QfeJRJPjpTd6Q84g=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-347-A_OXf53cO5aIQgy6pHtGXg-1; Thu, 04 Jul 2024 13:09:00 -0400
X-MC-Unique: A_OXf53cO5aIQgy6pHtGXg-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-367960f4673so965832f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2024 10:09:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720112939; x=1720717739;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g9s5070EIudwtdEBvneHUeqtniI+V0KQfF9cleWjjcI=;
        b=XM3CKDWNKJ/9jc+/3/2F1wcv+s+u8TRq0gzbPAYejo+mVzcX0SCq7zI7pQYnK5u5yp
         sS94061NKPcwpgEHb8511XzK3jp5ZSk33u4S2C/iPt8DOeXMtMJPhiDBqAgFnyX5AHsn
         sfVi4/c05XRyouaKxHwFn+wArZz+4oOJFiY4C83h23KaxAYK4ilMBHUvv+T88iyfUDvr
         4LTcEIYxVB9KvtR3vgUQdbdtX4UjyFZELcQ1Rh+CEjrEnt9CWb8qkHF4Scj6BHxRxx0O
         Yu8RRjK7HQD2PHLq7Ft3WhKGQi3jH3yzkcgGGeTNQu+++VtOC07jCUCfUuQLkXDwZg4B
         4sQw==
X-Forwarded-Encrypted: i=1; AJvYcCVLy/h5pL/MYIxK6Bfl4bxGztvzMgIjfVUximBEMqKBT/rzIovXbuc43SkbrcaQM89Ml1R7iMYlhgpU35Zjq1f48fbRzQvgWGDqAx4A
X-Gm-Message-State: AOJu0YyuNi2kzymzdllA6qiKZTGO1mHTE/7cS/embcBtbOiGzvCVvQa9
	g6a2frSkLRgaBQjcc8r/gt1v5gDND0xSIiVZJv6alnhDqjzB8U1CfoY8YOoR/RosBcRXUwpNDaI
	Mi1sX/X67hsYMgQhvgPNLFUuHAk8VccIMay9FV/vpotN1P8B+Gg9uC/jqXIEiAg==
X-Received: by 2002:a5d:59a6:0:b0:362:ff95:5697 with SMTP id ffacd0b85a97d-3679f75c493mr2832106f8f.28.1720112938772;
        Thu, 04 Jul 2024 10:08:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGvo+JVFuD9+NbLH1cJElJK3pJX6a+WqzYw5UAxXNq6UQpzUuKacAQGH0kimps9i1070QxGeg==
X-Received: by 2002:a5d:59a6:0:b0:362:ff95:5697 with SMTP id ffacd0b85a97d-3679f75c493mr2832086f8f.28.1720112938332;
        Thu, 04 Jul 2024 10:08:58 -0700 (PDT)
Received: from cassiopeiae.. ([2a02:810d:4b3f:ee94:642:1aff:fe31:a19f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36789d5ec1csm7097040f8f.37.2024.07.04.10.08.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 10:08:57 -0700 (PDT)
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
Subject: [PATCH 11/20] rust: treewide: switch to `KBox`
Date: Thu,  4 Jul 2024 19:06:39 +0200
Message-ID: <20240704170738.3621-12-dakr@redhat.com>
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

Now that we got `KBox` in place, convert all existing `Box` users to
`KBox`.

Signed-off-by: Danilo Krummrich <dakr@redhat.com>
---
 rust/kernel/init.rs               | 62 ++++++++++++++++---------------
 rust/kernel/init/__internal.rs    |  2 +-
 rust/kernel/sync/arc.rs           | 17 ++++-----
 rust/kernel/sync/condvar.rs       |  5 ++-
 rust/kernel/sync/lock/mutex.rs    |  3 +-
 rust/kernel/sync/lock/spinlock.rs |  3 +-
 rust/kernel/workqueue.rs          | 22 +++++------
 7 files changed, 59 insertions(+), 55 deletions(-)

diff --git a/rust/kernel/init.rs b/rust/kernel/init.rs
index b34c8127b76d..b386bafd5f95 100644
--- a/rust/kernel/init.rs
+++ b/rust/kernel/init.rs
@@ -13,7 +13,7 @@
 //! To initialize a `struct` with an in-place constructor you will need two things:
 //! - an in-place constructor,
 //! - a memory location that can hold your `struct` (this can be the [stack], an [`Arc<T>`],
-//!   [`UniqueArc<T>`], [`Box<T>`] or any other smart pointer that implements [`InPlaceInit`]).
+//!   [`UniqueArc<T>`], [`KBox<T>`] or any other smart pointer that implements [`InPlaceInit`]).
 //!
 //! To get an in-place constructor there are generally three options:
 //! - directly creating an in-place constructor using the [`pin_init!`] macro,
@@ -56,6 +56,7 @@
 //!
 //! ```rust
 //! # #![allow(clippy::disallowed_names)]
+//! # use kernel::alloc::KBox;
 //! # use kernel::sync::{new_mutex, Mutex};
 //! # use core::pin::Pin;
 //! # #[pin_data]
@@ -68,7 +69,7 @@
 //! #     a <- new_mutex!(42, "Foo::a"),
 //! #     b: 24,
 //! # });
-//! let foo: Result<Pin<Box<Foo>>> = Box::pin_init(foo, GFP_KERNEL);
+//! let foo: Result<Pin<KBox<Foo>>> = KBox::pin_init(foo, GFP_KERNEL);
 //! ```
 //!
 //! For more information see the [`pin_init!`] macro.
@@ -88,19 +89,19 @@
 //!
 //! ```rust
 //! # #![allow(clippy::disallowed_names)]
-//! # use kernel::{sync::Mutex, new_mutex, init::PinInit, try_pin_init};
+//! # use kernel::{alloc::KBox, sync::Mutex, new_mutex, init::PinInit, try_pin_init};
 //! #[pin_data]
 //! struct DriverData {
 //!     #[pin]
 //!     status: Mutex<i32>,
-//!     buffer: Box<[u8; 1_000_000]>,
+//!     buffer: KBox<[u8; 1_000_000]>,
 //! }
 //!
 //! impl DriverData {
 //!     fn new() -> impl PinInit<Self, Error> {
 //!         try_pin_init!(Self {
 //!             status <- new_mutex!(0, "DriverData::status"),
-//!             buffer: Box::init(kernel::init::zeroed(), GFP_KERNEL)?,
+//!             buffer: KBox::init(kernel::init::zeroed(), GFP_KERNEL)?,
 //!         })
 //!     }
 //! }
@@ -292,12 +293,12 @@ macro_rules! stack_pin_init {
 /// # #![allow(clippy::disallowed_names)]
 /// # use kernel::{init, pin_init, stack_try_pin_init, init::*, sync::Mutex, new_mutex};
 /// # use macros::pin_data;
-/// # use core::{alloc::AllocError, pin::Pin};
+/// # use core::{alloc::{AllocError, KBox}, pin::Pin};
 /// #[pin_data]
 /// struct Foo {
 ///     #[pin]
 ///     a: Mutex<usize>,
-///     b: Box<Bar>,
+///     b: KBox<Bar>,
 /// }
 ///
 /// struct Bar {
@@ -306,7 +307,7 @@ macro_rules! stack_pin_init {
 ///
 /// stack_try_pin_init!(let foo: Result<Pin<&mut Foo>, AllocError> = pin_init!(Foo {
 ///     a <- new_mutex!(42),
-///     b: Box::new(Bar {
+///     b: KBox::new(Bar {
 ///         x: 64,
 ///     }, GFP_KERNEL)?,
 /// }));
@@ -318,12 +319,12 @@ macro_rules! stack_pin_init {
 /// # #![allow(clippy::disallowed_names)]
 /// # use kernel::{init, pin_init, stack_try_pin_init, init::*, sync::Mutex, new_mutex};
 /// # use macros::pin_data;
-/// # use core::{alloc::AllocError, pin::Pin};
+/// # use core::{alloc::{AllocError, KBox}, pin::Pin};
 /// #[pin_data]
 /// struct Foo {
 ///     #[pin]
 ///     a: Mutex<usize>,
-///     b: Box<Bar>,
+///     b: KBox<Bar>,
 /// }
 ///
 /// struct Bar {
@@ -332,7 +333,7 @@ macro_rules! stack_pin_init {
 ///
 /// stack_try_pin_init!(let foo: Pin<&mut Foo> =? pin_init!(Foo {
 ///     a <- new_mutex!(42),
-///     b: Box::new(Bar {
+///     b: KBox::new(Bar {
 ///         x: 64,
 ///     }, GFP_KERNEL)?,
 /// }));
@@ -368,7 +369,7 @@ macro_rules! stack_try_pin_init {
 ///
 /// ```rust
 /// # #![allow(clippy::disallowed_names)]
-/// # use kernel::{init, pin_init, macros::pin_data, init::*};
+/// # use kernel::{alloc::KBox, init, pin_init, macros::pin_data, init::*};
 /// # use core::pin::Pin;
 /// #[pin_data]
 /// struct Foo {
@@ -391,7 +392,7 @@ macro_rules! stack_try_pin_init {
 ///     },
 /// });
 /// # initializer }
-/// # Box::pin_init(demo(), GFP_KERNEL).unwrap();
+/// # KBox::pin_init(demo(), GFP_KERNEL).unwrap();
 /// ```
 ///
 /// Arbitrary Rust expressions can be used to set the value of a variable.
@@ -440,7 +441,7 @@ macro_rules! stack_try_pin_init {
 ///
 /// ```rust
 /// # #![allow(clippy::disallowed_names)]
-/// # use kernel::{init, pin_init, macros::pin_data, init::*};
+/// # use kernel::{alloc::KBox, init, pin_init, macros::pin_data, init::*};
 /// # use core::pin::Pin;
 /// # #[pin_data]
 /// # struct Foo {
@@ -461,7 +462,7 @@ macro_rules! stack_try_pin_init {
 /// #         })
 /// #     }
 /// # }
-/// let foo = Box::pin_init(Foo::new(), GFP_KERNEL);
+/// let foo = KBox::pin_init(Foo::new(), GFP_KERNEL);
 /// ```
 ///
 /// They can also easily embed it into their own `struct`s:
@@ -590,10 +591,10 @@ macro_rules! pin_init {
 ///
 /// ```rust
 /// # #![feature(new_uninit)]
-/// use kernel::{init::{self, PinInit}, error::Error};
+/// use kernel::{alloc::KBox, init::{self, PinInit}, error::Error};
 /// #[pin_data]
 /// struct BigBuf {
-///     big: Box<[u8; 1024 * 1024 * 1024]>,
+///     big: KBox<[u8; 1024 * 1024 * 1024]>,
 ///     small: [u8; 1024 * 1024],
 ///     ptr: *mut u8,
 /// }
@@ -601,7 +602,7 @@ macro_rules! pin_init {
 /// impl BigBuf {
 ///     fn new() -> impl PinInit<Self, Error> {
 ///         try_pin_init!(Self {
-///             big: Box::init(init::zeroed(), GFP_KERNEL)?,
+///             big: KBox::init(init::zeroed(), GFP_KERNEL)?,
 ///             small: [0; 1024 * 1024],
 ///             ptr: core::ptr::null_mut(),
 ///         }? Error)
@@ -693,16 +694,16 @@ macro_rules! init {
 /// # Examples
 ///
 /// ```rust
-/// use kernel::{init::{PinInit, zeroed}, error::Error};
+/// use kernel::{alloc::KBox, init::{PinInit, zeroed}, error::Error};
 /// struct BigBuf {
-///     big: Box<[u8; 1024 * 1024 * 1024]>,
+///     big: KBox<[u8; 1024 * 1024 * 1024]>,
 ///     small: [u8; 1024 * 1024],
 /// }
 ///
 /// impl BigBuf {
 ///     fn new() -> impl Init<Self, Error> {
 ///         try_init!(Self {
-///             big: Box::init(zeroed(), GFP_KERNEL)?,
+///             big: KBox::init(zeroed(), GFP_KERNEL)?,
 ///             small: [0; 1024 * 1024],
 ///         }? Error)
 ///     }
@@ -745,8 +746,8 @@ macro_rules! try_init {
 /// A pin-initializer for the type `T`.
 ///
 /// To use this initializer, you will need a suitable memory location that can hold a `T`. This can
-/// be [`Box<T>`], [`Arc<T>`], [`UniqueArc<T>`] or even the stack (see [`stack_pin_init!`]). Use the
-/// [`InPlaceInit::pin_init`] function of a smart pointer like [`Arc<T>`] on this.
+/// be [`KBox<T>`], [`Arc<T>`], [`UniqueArc<T>`] or even the stack (see [`stack_pin_init!`]). Use
+/// the [`InPlaceInit::pin_init`] function of a smart pointer like [`Arc<T>`] on this.
 ///
 /// Also see the [module description](self).
 ///
@@ -825,7 +826,7 @@ fn pin_chain<F>(self, f: F) -> ChainPinInit<Self, F, T, E>
 }
 
 /// An initializer returned by [`PinInit::pin_chain`].
-pub struct ChainPinInit<I, F, T: ?Sized, E>(I, F, __internal::Invariant<(E, Box<T>)>);
+pub struct ChainPinInit<I, F, T: ?Sized, E>(I, F, __internal::Invariant<(E, KBox<T>)>);
 
 // SAFETY: The `__pinned_init` function is implemented such that it
 // - returns `Ok(())` on successful initialization,
@@ -854,8 +855,8 @@ unsafe fn __pinned_init(self, slot: *mut T) -> Result<(), E> {
 /// An initializer for `T`.
 ///
 /// To use this initializer, you will need a suitable memory location that can hold a `T`. This can
-/// be [`Box<T>`], [`Arc<T>`], [`UniqueArc<T>`] or even the stack (see [`stack_pin_init!`]). Use the
-/// [`InPlaceInit::init`] function of a smart pointer like [`Arc<T>`] on this. Because
+/// be [`KBox<T>`], [`Arc<T>`], [`UniqueArc<T>`] or even the stack (see [`stack_pin_init!`]). Use
+/// the [`InPlaceInit::init`] function of a smart pointer like [`Arc<T>`] on this. Because
 /// [`PinInit<T, E>`] is a super trait, you can use every function that takes it as well.
 ///
 /// Also see the [module description](self).
@@ -927,7 +928,7 @@ fn chain<F>(self, f: F) -> ChainInit<Self, F, T, E>
 }
 
 /// An initializer returned by [`Init::chain`].
-pub struct ChainInit<I, F, T: ?Sized, E>(I, F, __internal::Invariant<(E, Box<T>)>);
+pub struct ChainInit<I, F, T: ?Sized, E>(I, F, __internal::Invariant<(E, KBox<T>)>);
 
 // SAFETY: The `__init` function is implemented such that it
 // - returns `Ok(())` on successful initialization,
@@ -1013,8 +1014,9 @@ pub fn uninit<T, E>() -> impl Init<MaybeUninit<T>, E> {
 /// # Examples
 ///
 /// ```rust
-/// use kernel::{error::Error, init::init_array_from_fn};
-/// let array: Box<[usize; 1_000]> = Box::init::<Error>(init_array_from_fn(|i| i), GFP_KERNEL).unwrap();
+/// use kernel::{alloc::KBox, error::Error, init::init_array_from_fn};
+/// let array: KBox<[usize; 1_000]> =
+///     KBox::init::<Error>(init_array_from_fn(|i| i), GFP_KERNEL).unwrap();
 /// assert_eq!(array.len(), 1_000);
 /// ```
 pub fn init_array_from_fn<I, const N: usize, T, E>(
@@ -1351,7 +1353,7 @@ macro_rules! impl_zeroable {
     //
     // In this case we are allowed to use `T: ?Sized`, since all zeros is the `None` variant.
     {<T: ?Sized>} Option<NonNull<T>>,
-    {<T: ?Sized>} Option<Box<T>>,
+    {<T: ?Sized>} Option<KBox<T>>,
 
     // SAFETY: `null` pointer is valid.
     //
diff --git a/rust/kernel/init/__internal.rs b/rust/kernel/init/__internal.rs
index db3372619ecd..dfb2204918c7 100644
--- a/rust/kernel/init/__internal.rs
+++ b/rust/kernel/init/__internal.rs
@@ -102,7 +102,7 @@ fn make_closure<F, O, E>(self, f: F) -> F
     }
 }
 
-pub struct AllData<T: ?Sized>(PhantomData<fn(Box<T>) -> Box<T>>);
+pub struct AllData<T: ?Sized>(PhantomData<fn(KBox<T>) -> KBox<T>>);
 
 impl<T: ?Sized> Clone for AllData<T> {
     fn clone(&self) -> Self {
diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
index 3673496c2363..b5c84995d7d2 100644
--- a/rust/kernel/sync/arc.rs
+++ b/rust/kernel/sync/arc.rs
@@ -16,13 +16,12 @@
 //! [`Arc`]: https://doc.rust-lang.org/std/sync/struct.Arc.html
 
 use crate::{
-    alloc::{box_ext::BoxExt, AllocError, Flags},
+    alloc::{AllocError, Flags, KBox},
     error::{self, Error},
     init::{self, InPlaceInit, Init, PinInit},
     try_init,
     types::{ForeignOwnable, Opaque},
 };
-use alloc::boxed::Box;
 use core::{
     alloc::Layout,
     fmt,
@@ -203,11 +202,11 @@ pub fn new(contents: T, flags: Flags) -> Result<Self, AllocError> {
             data: contents,
         };
 
-        let inner = <Box<_> as BoxExt<_>>::new(value, flags)?;
+        let inner = KBox::new(value, flags)?;
 
         // SAFETY: We just created `inner` with a reference count of 1, which is owned by the new
         // `Arc` object.
-        Ok(unsafe { Self::from_inner(Box::leak(inner).into()) })
+        Ok(unsafe { Self::from_inner(KBox::leak(inner).into()) })
     }
 
     /// Use the given initializer to in-place initialize a `T`.
@@ -422,8 +421,8 @@ fn drop(&mut self) {
         if is_zero {
             // The count reached zero, we must free the memory.
             //
-            // SAFETY: The pointer was initialised from the result of `Box::leak`.
-            unsafe { drop(Box::from_raw(self.ptr.as_ptr())) };
+            // SAFETY: The pointer was initialised from the result of `KBox::leak`.
+            unsafe { drop(KBox::from_raw(self.ptr.as_ptr())) };
         }
     }
 }
@@ -668,7 +667,7 @@ pub fn new(value: T, flags: Flags) -> Result<Self, AllocError> {
     /// Tries to allocate a new [`UniqueArc`] instance whose contents are not initialised yet.
     pub fn new_uninit(flags: Flags) -> Result<UniqueArc<MaybeUninit<T>>, AllocError> {
         // INVARIANT: The refcount is initialised to a non-zero value.
-        let inner = Box::try_init::<AllocError>(
+        let inner = KBox::try_init::<AllocError>(
             try_init!(ArcInner {
                 // SAFETY: There are no safety requirements for this FFI call.
                 refcount: Opaque::new(unsafe { bindings::REFCOUNT_INIT(1) }),
@@ -678,8 +677,8 @@ pub fn new_uninit(flags: Flags) -> Result<UniqueArc<MaybeUninit<T>>, AllocError>
         )?;
         Ok(UniqueArc {
             // INVARIANT: The newly-created object has a refcount of 1.
-            // SAFETY: The pointer from the `Box` is valid.
-            inner: unsafe { Arc::from_inner(Box::leak(inner).into()) },
+            // SAFETY: The pointer from the `KBox` is valid.
+            inner: unsafe { Arc::from_inner(KBox::leak(inner).into()) },
         })
     }
 }
diff --git a/rust/kernel/sync/condvar.rs b/rust/kernel/sync/condvar.rs
index 2b306afbe56d..700dcda58fb1 100644
--- a/rust/kernel/sync/condvar.rs
+++ b/rust/kernel/sync/condvar.rs
@@ -44,6 +44,7 @@ macro_rules! new_condvar {
 /// The following is an example of using a condvar with a mutex:
 ///
 /// ```
+/// use kernel::alloc::KBox;
 /// use kernel::sync::{new_condvar, new_mutex, CondVar, Mutex};
 ///
 /// #[pin_data]
@@ -70,8 +71,8 @@ macro_rules! new_condvar {
 /// }
 ///
 /// /// Allocates a new boxed `Example`.
-/// fn new_example() -> Result<Pin<Box<Example>>> {
-///     Box::pin_init(pin_init!(Example {
+/// fn new_example() -> Result<Pin<KBox<Example>>> {
+///     KBox::pin_init(pin_init!(Example {
 ///         value <- new_mutex!(0),
 ///         value_changed <- new_condvar!(),
 ///     }), GFP_KERNEL)
diff --git a/rust/kernel/sync/lock/mutex.rs b/rust/kernel/sync/lock/mutex.rs
index 30632070ee67..e19481cf0a2c 100644
--- a/rust/kernel/sync/lock/mutex.rs
+++ b/rust/kernel/sync/lock/mutex.rs
@@ -34,6 +34,7 @@ macro_rules! new_mutex {
 /// contains an inner struct (`Inner`) that is protected by a mutex.
 ///
 /// ```
+/// use kernel::alloc::KBox;
 /// use kernel::sync::{new_mutex, Mutex};
 ///
 /// struct Inner {
@@ -58,7 +59,7 @@ macro_rules! new_mutex {
 /// }
 ///
 /// // Allocate a boxed `Example`.
-/// let e = Box::pin_init(Example::new(), GFP_KERNEL)?;
+/// let e = KBox::pin_init(Example::new(), GFP_KERNEL)?;
 /// assert_eq!(e.c, 10);
 /// assert_eq!(e.d.lock().a, 20);
 /// assert_eq!(e.d.lock().b, 30);
diff --git a/rust/kernel/sync/lock/spinlock.rs b/rust/kernel/sync/lock/spinlock.rs
index ea5c5bc1ce12..dfb74dfefafe 100644
--- a/rust/kernel/sync/lock/spinlock.rs
+++ b/rust/kernel/sync/lock/spinlock.rs
@@ -32,6 +32,7 @@ macro_rules! new_spinlock {
 /// contains an inner struct (`Inner`) that is protected by a spinlock.
 ///
 /// ```
+/// use kernel::alloc::KBox;
 /// use kernel::sync::{new_spinlock, SpinLock};
 ///
 /// struct Inner {
@@ -56,7 +57,7 @@ macro_rules! new_spinlock {
 /// }
 ///
 /// // Allocate a boxed `Example`.
-/// let e = Box::pin_init(Example::new(), GFP_KERNEL)?;
+/// let e = KBox::pin_init(Example::new(), GFP_KERNEL)?;
 /// assert_eq!(e.c, 10);
 /// assert_eq!(e.d.lock().a, 20);
 /// assert_eq!(e.d.lock().b, 30);
diff --git a/rust/kernel/workqueue.rs b/rust/kernel/workqueue.rs
index 1cec63a2aea8..e1a1606267ed 100644
--- a/rust/kernel/workqueue.rs
+++ b/rust/kernel/workqueue.rs
@@ -130,7 +130,7 @@
 //!
 //! C header: [`include/linux/workqueue.h`](srctree/include/linux/workqueue.h)
 
-use crate::alloc::{AllocError, Flags};
+use crate::alloc::{AllocError, Flags, KBox};
 use crate::{prelude::*, sync::Arc, sync::LockClassKey, types::Opaque};
 use core::marker::PhantomData;
 
@@ -216,7 +216,7 @@ pub fn try_spawn<T: 'static + Send + FnOnce()>(
             func: Some(func),
         });
 
-        self.enqueue(Box::pin_init(init, flags).map_err(|_| AllocError)?);
+        self.enqueue(KBox::pin_init(init, flags).map_err(|_| AllocError)?);
         Ok(())
     }
 }
@@ -239,9 +239,9 @@ fn project(self: Pin<&mut Self>) -> &mut Option<T> {
 }
 
 impl<T: FnOnce()> WorkItem for ClosureWork<T> {
-    type Pointer = Pin<Box<Self>>;
+    type Pointer = Pin<KBox<Self>>;
 
-    fn run(mut this: Pin<Box<Self>>) {
+    fn run(mut this: Pin<KBox<Self>>) {
         if let Some(func) = this.as_mut().project().take() {
             (func)()
         }
@@ -297,7 +297,7 @@ unsafe fn __enqueue<F>(self, queue_work_on: F) -> Self::EnqueueOutput
 
 /// Defines the method that should be called directly when a work item is executed.
 ///
-/// This trait is implemented by `Pin<Box<T>>` and [`Arc<T>`], and is mainly intended to be
+/// This trait is implemented by `Pin<KBox<T>>` and [`Arc<T>`], and is mainly intended to be
 /// implemented for smart pointer types. For your own structs, you would implement [`WorkItem`]
 /// instead. The [`run`] method on this trait will usually just perform the appropriate
 /// `container_of` translation and then call into the [`run`][WorkItem::run] method from the
@@ -329,7 +329,7 @@ pub unsafe trait WorkItemPointer<const ID: u64>: RawWorkItem<ID> {
 /// This trait is used when the `work_struct` field is defined using the [`Work`] helper.
 pub trait WorkItem<const ID: u64 = 0> {
     /// The pointer type that this struct is wrapped in. This will typically be `Arc<Self>` or
-    /// `Pin<Box<Self>>`.
+    /// `Pin<KBox<Self>>`.
     type Pointer: WorkItemPointer<ID>;
 
     /// The method that should be called when this work item is executed.
@@ -563,7 +563,7 @@ unsafe fn __enqueue<F>(self, queue_work_on: F) -> Self::EnqueueOutput
     }
 }
 
-unsafe impl<T, const ID: u64> WorkItemPointer<ID> for Pin<Box<T>>
+unsafe impl<T, const ID: u64> WorkItemPointer<ID> for Pin<KBox<T>>
 where
     T: WorkItem<ID, Pointer = Self>,
     T: HasWork<T, ID>,
@@ -574,7 +574,7 @@ unsafe impl<T, const ID: u64> WorkItemPointer<ID> for Pin<Box<T>>
         // SAFETY: This computes the pointer that `__enqueue` got from `Arc::into_raw`.
         let ptr = unsafe { T::work_container_of(ptr) };
         // SAFETY: This pointer comes from `Arc::into_raw` and we've been given back ownership.
-        let boxed = unsafe { Box::from_raw(ptr) };
+        let boxed = unsafe { KBox::from_raw(ptr) };
         // SAFETY: The box was already pinned when it was enqueued.
         let pinned = unsafe { Pin::new_unchecked(boxed) };
 
@@ -582,7 +582,7 @@ unsafe impl<T, const ID: u64> WorkItemPointer<ID> for Pin<Box<T>>
     }
 }
 
-unsafe impl<T, const ID: u64> RawWorkItem<ID> for Pin<Box<T>>
+unsafe impl<T, const ID: u64> RawWorkItem<ID> for Pin<KBox<T>>
 where
     T: WorkItem<ID, Pointer = Self>,
     T: HasWork<T, ID>,
@@ -596,9 +596,9 @@ unsafe fn __enqueue<F>(self, queue_work_on: F) -> Self::EnqueueOutput
         // SAFETY: We're not going to move `self` or any of its fields, so its okay to temporarily
         // remove the `Pin` wrapper.
         let boxed = unsafe { Pin::into_inner_unchecked(self) };
-        let ptr = Box::into_raw(boxed);
+        let ptr = KBox::into_raw(boxed);
 
-        // SAFETY: Pointers into a `Box` point at a valid value.
+        // SAFETY: Pointers into a `KBox` point at a valid value.
         let work_ptr = unsafe { T::raw_get_work(ptr) };
         // SAFETY: `raw_get_work` returns a pointer to a valid value.
         let work_ptr = unsafe { Work::raw_get(work_ptr) };
-- 
2.45.2


