Return-Path: <linux-kernel+bounces-346189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E02B98C106
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 17:04:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE01D1F23F6B
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 15:04:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D8301CCB27;
	Tue,  1 Oct 2024 15:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xfh3owNs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04CC41CC8B9;
	Tue,  1 Oct 2024 15:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727794882; cv=none; b=OBRb8wHNru/un2jlsXM3VfSO7fEvn/KhTrHaAuCrsXTHwRYqqUNf3gFh936oOMZ2iya/hMP39wun0QEzldStWGzZC13tVSDzbsPWGmxJgGUViI2Qn4Jthw/jtz1C1vG846cSJS1qxzLymN5k2n2r2UJOTH4J8FbKW3oBpdXZ0q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727794882; c=relaxed/simple;
	bh=kutKwLZsnU8bVf7wfBchbdlBBLTYMY46/fD4vuQR9YE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TJM4A3PGTa4WtgoMa6YlTykfNkUvTuK7ECFD429PGHvojTwRQg2sdvdzD5m6x0ix4Pzh9yZ+NlV+Ys33l1zi/XpY1N4Ar8c47c1GVL3mB7Z0gusKPx3uLFrxXQPTJuNl6jbiedpBsdzWOCemZGwt40zJPNNEIYJ+esuOXhvUXDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xfh3owNs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5E62C4CEC6;
	Tue,  1 Oct 2024 15:01:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727794881;
	bh=kutKwLZsnU8bVf7wfBchbdlBBLTYMY46/fD4vuQR9YE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Xfh3owNsF6BKl1myePFCW+EYNfeWUasV8xx5t36g87EVa+86w1XpHI7devlVbyRzN
	 O+qUYwHD5z0RQEPtmv3jyVeu7g4eIaLuy6qhfem5FV8i4X7CjoPvzHN37Ei+Sz54MH
	 JcUs4ffFeZwCxS6zc3n77IsYdjNAzmSI4HgNcrjo/UcNBEIhrSdUnCEwJQ9C+5b3F+
	 /CPMnkCsFZo5HwGuFIGJgZfcIc+7RcpKjoCif5IhRPZCgjxCNKXOF/BXE9TlJ7quOp
	 KdZRJxSPzKlNYqaXMvwY9bGbcZ84mHDss0sCC95F+faVWtX5b4ZamP0A4kWXgEbf2L
	 t9Ht3meZiEWRg==
From: Danilo Krummrich <dakr@kernel.org>
To: ojeda@kernel.org,
	alex.gaynor@gmail.com,
	wedsonaf@gmail.com,
	boqun.feng@gmail.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	benno.lossin@proton.me,
	a.hindborg@samsung.com,
	aliceryhl@google.com,
	akpm@linux-foundation.org
Cc: daniel.almeida@collabora.com,
	faith.ekstrand@collabora.com,
	boris.brezillon@collabora.com,
	lina@asahilina.net,
	mcanal@igalia.com,
	zhiw@nvidia.com,
	cjia@nvidia.com,
	jhubbard@nvidia.com,
	airlied@redhat.com,
	ajanulgu@redhat.com,
	lyude@redhat.com,
	linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-mm@kvack.org,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH v8 12/29] rust: treewide: switch to our kernel `Box` type
Date: Tue,  1 Oct 2024 16:59:47 +0200
Message-ID: <20241001150008.183102-13-dakr@kernel.org>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20241001150008.183102-1-dakr@kernel.org>
References: <20241001150008.183102-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that we got the kernel `Box` type in place, convert all existing
`Box` users to make use of it.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Benno Lossin <benno.lossin@proton.me>
Reviewed-by: Gary Guo <gary@garyguo.net>
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 drivers/block/rnull.rs            |  4 +--
 rust/kernel/init.rs               | 51 ++++++++++++++++---------------
 rust/kernel/init/__internal.rs    |  2 +-
 rust/kernel/rbtree.rs             | 49 ++++++++++++++++-------------
 rust/kernel/sync/arc.rs           | 17 +++++------
 rust/kernel/sync/condvar.rs       |  4 +--
 rust/kernel/sync/lock/mutex.rs    |  2 +-
 rust/kernel/sync/lock/spinlock.rs |  2 +-
 rust/kernel/workqueue.rs          | 20 ++++++------
 rust/macros/lib.rs                |  6 ++--
 10 files changed, 81 insertions(+), 76 deletions(-)

diff --git a/drivers/block/rnull.rs b/drivers/block/rnull.rs
index b0227cf9ddd3..5de7223beb4d 100644
--- a/drivers/block/rnull.rs
+++ b/drivers/block/rnull.rs
@@ -32,7 +32,7 @@
 }
 
 struct NullBlkModule {
-    _disk: Pin<Box<Mutex<GenDisk<NullBlkDevice>>>>,
+    _disk: Pin<KBox<Mutex<GenDisk<NullBlkDevice>>>>,
 }
 
 impl kernel::Module for NullBlkModule {
@@ -47,7 +47,7 @@ fn init(_module: &'static ThisModule) -> Result<Self> {
             .rotational(false)
             .build(format_args!("rnullb{}", 0), tagset)?;
 
-        let disk = Box::pin_init(new_mutex!(disk, "nullb:disk"), flags::GFP_KERNEL)?;
+        let disk = KBox::pin_init(new_mutex!(disk, "nullb:disk"), flags::GFP_KERNEL)?;
 
         Ok(Self { _disk: disk })
     }
diff --git a/rust/kernel/init.rs b/rust/kernel/init.rs
index a17ac8762d8f..e057b374f255 100644
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
@@ -68,7 +68,7 @@
 //! #     a <- new_mutex!(42, "Foo::a"),
 //! #     b: 24,
 //! # });
-//! let foo: Result<Pin<Box<Foo>>> = Box::pin_init(foo, GFP_KERNEL);
+//! let foo: Result<Pin<KBox<Foo>>> = KBox::pin_init(foo, GFP_KERNEL);
 //! ```
 //!
 //! For more information see the [`pin_init!`] macro.
@@ -93,14 +93,14 @@
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
@@ -211,7 +211,7 @@
 //! [`pin_init!`]: crate::pin_init!
 
 use crate::{
-    alloc::{box_ext::BoxExt, AllocError, Flags},
+    alloc::{box_ext::BoxExt, AllocError, Flags, KBox},
     error::{self, Error},
     sync::Arc,
     sync::UniqueArc,
@@ -298,7 +298,7 @@ macro_rules! stack_pin_init {
 /// struct Foo {
 ///     #[pin]
 ///     a: Mutex<usize>,
-///     b: Box<Bar>,
+///     b: KBox<Bar>,
 /// }
 ///
 /// struct Bar {
@@ -307,7 +307,7 @@ macro_rules! stack_pin_init {
 ///
 /// stack_try_pin_init!(let foo: Result<Pin<&mut Foo>, AllocError> = pin_init!(Foo {
 ///     a <- new_mutex!(42),
-///     b: Box::new(Bar {
+///     b: KBox::new(Bar {
 ///         x: 64,
 ///     }, GFP_KERNEL)?,
 /// }));
@@ -324,7 +324,7 @@ macro_rules! stack_pin_init {
 /// struct Foo {
 ///     #[pin]
 ///     a: Mutex<usize>,
-///     b: Box<Bar>,
+///     b: KBox<Bar>,
 /// }
 ///
 /// struct Bar {
@@ -333,7 +333,7 @@ macro_rules! stack_pin_init {
 ///
 /// stack_try_pin_init!(let foo: Pin<&mut Foo> =? pin_init!(Foo {
 ///     a <- new_mutex!(42),
-///     b: Box::new(Bar {
+///     b: KBox::new(Bar {
 ///         x: 64,
 ///     }, GFP_KERNEL)?,
 /// }));
@@ -392,7 +392,7 @@ macro_rules! stack_try_pin_init {
 ///     },
 /// });
 /// # initializer }
-/// # Box::pin_init(demo(), GFP_KERNEL).unwrap();
+/// # KBox::pin_init(demo(), GFP_KERNEL).unwrap();
 /// ```
 ///
 /// Arbitrary Rust expressions can be used to set the value of a variable.
@@ -462,7 +462,7 @@ macro_rules! stack_try_pin_init {
 /// #         })
 /// #     }
 /// # }
-/// let foo = Box::pin_init(Foo::new(), GFP_KERNEL);
+/// let foo = KBox::pin_init(Foo::new(), GFP_KERNEL);
 /// ```
 ///
 /// They can also easily embed it into their own `struct`s:
@@ -594,7 +594,7 @@ macro_rules! pin_init {
 /// use kernel::{init::{self, PinInit}, error::Error};
 /// #[pin_data]
 /// struct BigBuf {
-///     big: Box<[u8; 1024 * 1024 * 1024]>,
+///     big: KBox<[u8; 1024 * 1024 * 1024]>,
 ///     small: [u8; 1024 * 1024],
 ///     ptr: *mut u8,
 /// }
@@ -602,7 +602,7 @@ macro_rules! pin_init {
 /// impl BigBuf {
 ///     fn new() -> impl PinInit<Self, Error> {
 ///         try_pin_init!(Self {
-///             big: Box::init(init::zeroed(), GFP_KERNEL)?,
+///             big: KBox::init(init::zeroed(), GFP_KERNEL)?,
 ///             small: [0; 1024 * 1024],
 ///             ptr: core::ptr::null_mut(),
 ///         }? Error)
@@ -694,16 +694,16 @@ macro_rules! init {
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
@@ -814,8 +814,8 @@ macro_rules! assert_pinned {
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
@@ -894,7 +894,7 @@ fn pin_chain<F>(self, f: F) -> ChainPinInit<Self, F, T, E>
 }
 
 /// An initializer returned by [`PinInit::pin_chain`].
-pub struct ChainPinInit<I, F, T: ?Sized, E>(I, F, __internal::Invariant<(E, Box<T>)>);
+pub struct ChainPinInit<I, F, T: ?Sized, E>(I, F, __internal::Invariant<(E, KBox<T>)>);
 
 // SAFETY: The `__pinned_init` function is implemented such that it
 // - returns `Ok(())` on successful initialization,
@@ -920,8 +920,8 @@ unsafe fn __pinned_init(self, slot: *mut T) -> Result<(), E> {
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
@@ -993,7 +993,7 @@ fn chain<F>(self, f: F) -> ChainInit<Self, F, T, E>
 }
 
 /// An initializer returned by [`Init::chain`].
-pub struct ChainInit<I, F, T: ?Sized, E>(I, F, __internal::Invariant<(E, Box<T>)>);
+pub struct ChainInit<I, F, T: ?Sized, E>(I, F, __internal::Invariant<(E, KBox<T>)>);
 
 // SAFETY: The `__init` function is implemented such that it
 // - returns `Ok(())` on successful initialization,
@@ -1077,8 +1077,9 @@ pub fn uninit<T, E>() -> impl Init<MaybeUninit<T>, E> {
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
@@ -1451,7 +1452,7 @@ macro_rules! impl_zeroable {
     //
     // In this case we are allowed to use `T: ?Sized`, since all zeros is the `None` variant.
     {<T: ?Sized>} Option<NonNull<T>>,
-    {<T: ?Sized>} Option<Box<T>>,
+    {<T: ?Sized>} Option<KBox<T>>,
 
     // SAFETY: `null` pointer is valid.
     //
diff --git a/rust/kernel/init/__internal.rs b/rust/kernel/init/__internal.rs
index 13cefd37512f..b31f498f4f8e 100644
--- a/rust/kernel/init/__internal.rs
+++ b/rust/kernel/init/__internal.rs
@@ -102,7 +102,7 @@ fn make_closure<F, O, E>(self, f: F) -> F
     }
 }
 
-pub struct AllData<T: ?Sized>(PhantomData<fn(Box<T>) -> Box<T>>);
+pub struct AllData<T: ?Sized>(PhantomData<fn(KBox<T>) -> KBox<T>>);
 
 impl<T: ?Sized> Clone for AllData<T> {
     fn clone(&self) -> Self {
diff --git a/rust/kernel/rbtree.rs b/rust/kernel/rbtree.rs
index 25eb36fd1cdc..a63d4b0fe485 100644
--- a/rust/kernel/rbtree.rs
+++ b/rust/kernel/rbtree.rs
@@ -7,7 +7,6 @@
 //! Reference: <https://docs.kernel.org/core-api/rbtree.html>
 
 use crate::{alloc::Flags, bindings, container_of, error::Result, prelude::*};
-use alloc::boxed::Box;
 use core::{
     cmp::{Ord, Ordering},
     marker::PhantomData,
@@ -497,7 +496,7 @@ fn drop(&mut self) {
             // but it is not observable. The loop invariant is still maintained.
 
             // SAFETY: `this` is valid per the loop invariant.
-            unsafe { drop(Box::from_raw(this.cast_mut())) };
+            unsafe { drop(KBox::from_raw(this.cast_mut())) };
         }
     }
 }
@@ -764,7 +763,7 @@ pub fn remove_current(self) -> (Option<Self>, RBTreeNode<K, V>) {
         // point to the links field of `Node<K, V>` objects.
         let this = unsafe { container_of!(self.current.as_ptr(), Node<K, V>, links) }.cast_mut();
         // SAFETY: `this` is valid by the type invariants as described above.
-        let node = unsafe { Box::from_raw(this) };
+        let node = unsafe { KBox::from_raw(this) };
         let node = RBTreeNode { node };
         // SAFETY: The reference to the tree used to create the cursor outlives the cursor, so
         // the tree cannot change. By the tree invariant, all nodes are valid.
@@ -809,7 +808,7 @@ fn remove_neighbor(&mut self, direction: Direction) -> Option<RBTreeNode<K, V>>
             // point to the links field of `Node<K, V>` objects.
             let this = unsafe { container_of!(neighbor, Node<K, V>, links) }.cast_mut();
             // SAFETY: `this` is valid by the type invariants as described above.
-            let node = unsafe { Box::from_raw(this) };
+            let node = unsafe { KBox::from_raw(this) };
             return Some(RBTreeNode { node });
         }
         None
@@ -1035,7 +1034,7 @@ fn next(&mut self) -> Option<Self::Item> {
 /// It contains the memory needed to hold a node that can be inserted into a red-black tree. One
 /// can be obtained by directly allocating it ([`RBTreeNodeReservation::new`]).
 pub struct RBTreeNodeReservation<K, V> {
-    node: Box<MaybeUninit<Node<K, V>>>,
+    node: KBox<MaybeUninit<Node<K, V>>>,
 }
 
 impl<K, V> RBTreeNodeReservation<K, V> {
@@ -1043,7 +1042,7 @@ impl<K, V> RBTreeNodeReservation<K, V> {
     /// call to [`RBTree::insert`].
     pub fn new(flags: Flags) -> Result<RBTreeNodeReservation<K, V>> {
         Ok(RBTreeNodeReservation {
-            node: <Box<_> as BoxExt<_>>::new_uninit(flags)?,
+            node: KBox::new_uninit(flags)?,
         })
     }
 }
@@ -1059,14 +1058,15 @@ impl<K, V> RBTreeNodeReservation<K, V> {
     /// Initialises a node reservation.
     ///
     /// It then becomes an [`RBTreeNode`] that can be inserted into a tree.
-    pub fn into_node(mut self, key: K, value: V) -> RBTreeNode<K, V> {
-        self.node.write(Node {
-            key,
-            value,
-            links: bindings::rb_node::default(),
-        });
-        // SAFETY: We just wrote to it.
-        let node = unsafe { self.node.assume_init() };
+    pub fn into_node(self, key: K, value: V) -> RBTreeNode<K, V> {
+        let node = KBox::write(
+            self.node,
+            Node {
+                key,
+                value,
+                links: bindings::rb_node::default(),
+            },
+        );
         RBTreeNode { node }
     }
 }
@@ -1076,7 +1076,7 @@ pub fn into_node(mut self, key: K, value: V) -> RBTreeNode<K, V> {
 /// The node is fully initialised (with key and value) and can be inserted into a tree without any
 /// extra allocations or failure paths.
 pub struct RBTreeNode<K, V> {
-    node: Box<Node<K, V>>,
+    node: KBox<Node<K, V>>,
 }
 
 impl<K, V> RBTreeNode<K, V> {
@@ -1088,7 +1088,9 @@ pub fn new(key: K, value: V, flags: Flags) -> Result<RBTreeNode<K, V>> {
 
     /// Get the key and value from inside the node.
     pub fn to_key_value(self) -> (K, V) {
-        (self.node.key, self.node.value)
+        let node = KBox::into_inner(self.node);
+
+        (node.key, node.value)
     }
 }
 
@@ -1110,7 +1112,7 @@ impl<K, V> RBTreeNode<K, V> {
     /// may be freed (but only for the key/value; memory for the node itself is kept for reuse).
     pub fn into_reservation(self) -> RBTreeNodeReservation<K, V> {
         RBTreeNodeReservation {
-            node: Box::drop_contents(self.node),
+            node: KBox::drop_contents(self.node),
         }
     }
 }
@@ -1161,7 +1163,7 @@ impl<'a, K, V> RawVacantEntry<'a, K, V> {
     /// The `node` must have a key such that inserting it here does not break the ordering of this
     /// [`RBTree`].
     fn insert(self, node: RBTreeNode<K, V>) -> &'a mut V {
-        let node = Box::into_raw(node.node);
+        let node = KBox::into_raw(node.node);
 
         // SAFETY: `node` is valid at least until we call `Box::from_raw`, which only happens when
         // the node is removed or replaced.
@@ -1235,21 +1237,24 @@ pub fn remove_node(self) -> RBTreeNode<K, V> {
             // SAFETY: The node was a node in the tree, but we removed it, so we can convert it
             // back into a box.
             node: unsafe {
-                Box::from_raw(container_of!(self.node_links, Node<K, V>, links).cast_mut())
+                KBox::from_raw(container_of!(self.node_links, Node<K, V>, links).cast_mut())
             },
         }
     }
 
     /// Takes the value of the entry out of the map, and returns it.
     pub fn remove(self) -> V {
-        self.remove_node().node.value
+        let rb_node = self.remove_node();
+        let node = KBox::into_inner(rb_node.node);
+
+        node.value
     }
 
     /// Swap the current node for the provided node.
     ///
     /// The key of both nodes must be equal.
     fn replace(self, node: RBTreeNode<K, V>) -> RBTreeNode<K, V> {
-        let node = Box::into_raw(node.node);
+        let node = KBox::into_raw(node.node);
 
         // SAFETY: `node` is valid at least until we call `Box::from_raw`, which only happens when
         // the node is removed or replaced.
@@ -1265,7 +1270,7 @@ fn replace(self, node: RBTreeNode<K, V>) -> RBTreeNode<K, V> {
         // - `self.node_ptr` produces a valid pointer to a node in the tree.
         // - Now that we removed this entry from the tree, we can convert the node to a box.
         let old_node =
-            unsafe { Box::from_raw(container_of!(self.node_links, Node<K, V>, links).cast_mut()) };
+            unsafe { KBox::from_raw(container_of!(self.node_links, Node<K, V>, links).cast_mut()) };
 
         RBTreeNode { node: old_node }
     }
diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
index 3021f30fd822..d7adbad7d3b4 100644
--- a/rust/kernel/sync/arc.rs
+++ b/rust/kernel/sync/arc.rs
@@ -17,13 +17,12 @@
 //! [`Arc`]: https://doc.rust-lang.org/std/sync/struct.Arc.html
 
 use crate::{
-    alloc::{box_ext::BoxExt, AllocError, Flags},
+    alloc::{AllocError, Flags, KBox},
     bindings,
     init::{self, InPlaceInit, Init, PinInit},
     try_init,
     types::{ForeignOwnable, Opaque},
 };
-use alloc::boxed::Box;
 use core::{
     alloc::Layout,
     fmt,
@@ -204,11 +203,11 @@ pub fn new(contents: T, flags: Flags) -> Result<Self, AllocError> {
             data: contents,
         };
 
-        let inner = <Box<_> as BoxExt<_>>::new(value, flags)?;
+        let inner = KBox::new(value, flags)?;
 
         // SAFETY: We just created `inner` with a reference count of 1, which is owned by the new
         // `Arc` object.
-        Ok(unsafe { Self::from_inner(Box::leak(inner).into()) })
+        Ok(unsafe { Self::from_inner(KBox::leak(inner).into()) })
     }
 }
 
@@ -401,8 +400,8 @@ fn drop(&mut self) {
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
@@ -647,7 +646,7 @@ pub fn new(value: T, flags: Flags) -> Result<Self, AllocError> {
     /// Tries to allocate a new [`UniqueArc`] instance whose contents are not initialised yet.
     pub fn new_uninit(flags: Flags) -> Result<UniqueArc<MaybeUninit<T>>, AllocError> {
         // INVARIANT: The refcount is initialised to a non-zero value.
-        let inner = Box::try_init::<AllocError>(
+        let inner = KBox::try_init::<AllocError>(
             try_init!(ArcInner {
                 // SAFETY: There are no safety requirements for this FFI call.
                 refcount: Opaque::new(unsafe { bindings::REFCOUNT_INIT(1) }),
@@ -657,8 +656,8 @@ pub fn new_uninit(flags: Flags) -> Result<UniqueArc<MaybeUninit<T>>, AllocError>
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
index 2b306afbe56d..2081932bb4b9 100644
--- a/rust/kernel/sync/condvar.rs
+++ b/rust/kernel/sync/condvar.rs
@@ -70,8 +70,8 @@ macro_rules! new_condvar {
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
index 30632070ee67..f8f6d530db7d 100644
--- a/rust/kernel/sync/lock/mutex.rs
+++ b/rust/kernel/sync/lock/mutex.rs
@@ -58,7 +58,7 @@ macro_rules! new_mutex {
 /// }
 ///
 /// // Allocate a boxed `Example`.
-/// let e = Box::pin_init(Example::new(), GFP_KERNEL)?;
+/// let e = KBox::pin_init(Example::new(), GFP_KERNEL)?;
 /// assert_eq!(e.c, 10);
 /// assert_eq!(e.d.lock().a, 20);
 /// assert_eq!(e.d.lock().b, 30);
diff --git a/rust/kernel/sync/lock/spinlock.rs b/rust/kernel/sync/lock/spinlock.rs
index ea5c5bc1ce12..a9096a4dc42a 100644
--- a/rust/kernel/sync/lock/spinlock.rs
+++ b/rust/kernel/sync/lock/spinlock.rs
@@ -56,7 +56,7 @@ macro_rules! new_spinlock {
 /// }
 ///
 /// // Allocate a boxed `Example`.
-/// let e = Box::pin_init(Example::new(), GFP_KERNEL)?;
+/// let e = KBox::pin_init(Example::new(), GFP_KERNEL)?;
 /// assert_eq!(e.c, 10);
 /// assert_eq!(e.d.lock().a, 20);
 /// assert_eq!(e.d.lock().b, 30);
diff --git a/rust/kernel/workqueue.rs b/rust/kernel/workqueue.rs
index 553a5cba2adc..94318472507f 100644
--- a/rust/kernel/workqueue.rs
+++ b/rust/kernel/workqueue.rs
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
@@ -565,7 +565,7 @@ unsafe fn __enqueue<F>(self, queue_work_on: F) -> Self::EnqueueOutput
     }
 }
 
-unsafe impl<T, const ID: u64> WorkItemPointer<ID> for Pin<Box<T>>
+unsafe impl<T, const ID: u64> WorkItemPointer<ID> for Pin<KBox<T>>
 where
     T: WorkItem<ID, Pointer = Self>,
     T: HasWork<T, ID>,
@@ -576,7 +576,7 @@ unsafe impl<T, const ID: u64> WorkItemPointer<ID> for Pin<Box<T>>
         // SAFETY: This computes the pointer that `__enqueue` got from `Arc::into_raw`.
         let ptr = unsafe { T::work_container_of(ptr) };
         // SAFETY: This pointer comes from `Arc::into_raw` and we've been given back ownership.
-        let boxed = unsafe { Box::from_raw(ptr) };
+        let boxed = unsafe { KBox::from_raw(ptr) };
         // SAFETY: The box was already pinned when it was enqueued.
         let pinned = unsafe { Pin::new_unchecked(boxed) };
 
@@ -584,7 +584,7 @@ unsafe impl<T, const ID: u64> WorkItemPointer<ID> for Pin<Box<T>>
     }
 }
 
-unsafe impl<T, const ID: u64> RawWorkItem<ID> for Pin<Box<T>>
+unsafe impl<T, const ID: u64> RawWorkItem<ID> for Pin<KBox<T>>
 where
     T: WorkItem<ID, Pointer = Self>,
     T: HasWork<T, ID>,
@@ -598,9 +598,9 @@ unsafe fn __enqueue<F>(self, queue_work_on: F) -> Self::EnqueueOutput
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
diff --git a/rust/macros/lib.rs b/rust/macros/lib.rs
index a626b1145e5c..ab93111a048c 100644
--- a/rust/macros/lib.rs
+++ b/rust/macros/lib.rs
@@ -243,7 +243,7 @@ pub fn concat_idents(ts: TokenStream) -> TokenStream {
 /// struct DriverData {
 ///     #[pin]
 ///     queue: Mutex<Vec<Command>>,
-///     buf: Box<[u8; 1024 * 1024]>,
+///     buf: KBox<[u8; 1024 * 1024]>,
 /// }
 /// ```
 ///
@@ -252,7 +252,7 @@ pub fn concat_idents(ts: TokenStream) -> TokenStream {
 /// struct DriverData {
 ///     #[pin]
 ///     queue: Mutex<Vec<Command>>,
-///     buf: Box<[u8; 1024 * 1024]>,
+///     buf: KBox<[u8; 1024 * 1024]>,
 ///     raw_info: *mut Info,
 /// }
 ///
@@ -282,7 +282,7 @@ pub fn pin_data(inner: TokenStream, item: TokenStream) -> TokenStream {
 /// struct DriverData {
 ///     #[pin]
 ///     queue: Mutex<Vec<Command>>,
-///     buf: Box<[u8; 1024 * 1024]>,
+///     buf: KBox<[u8; 1024 * 1024]>,
 ///     raw_info: *mut Info,
 /// }
 ///
-- 
2.46.1


