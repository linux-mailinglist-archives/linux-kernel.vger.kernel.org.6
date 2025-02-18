Return-Path: <linux-kernel+bounces-519427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B93CA39CC1
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 14:03:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BB211753E6
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 13:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C59C268FC3;
	Tue, 18 Feb 2025 13:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YA7Tk6Ak"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A17D92676D7;
	Tue, 18 Feb 2025 13:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739883701; cv=none; b=pvmImi2lh323VSVDHhTKoUoQyklkB6bp7logsHHHKRBLxoEKE49mJpqScZQHLed5AILkjepDTvlG1FGrQhky7QmfWa+gMSsE5hI7PG0CL0+wLojsY4CWthp2NV/g+yBhdoervKyg9IdmJ942n5pBvmIzDJxViH2tfaDds/9EEe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739883701; c=relaxed/simple;
	bh=Y26I/JGBiSo0ZEQDmS9aR8Eu7fZy8Uy8E+e7r8m7XJ4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LkdlC54mtQc+cssGGAEwk3AHQ9TcbYeflsClH2+XxzoD7xqlr+V6+G92mbEQppxx4Tg9E0s2AJRfGiL4h1YaOdyG9bwIqRSRNwPQoqoHjc3K0kui8jc5Z4XzLDF/GBoumGrAjv156BPw50LzWo2xz3cnsOXS3xU9Ql9OaaR8hME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YA7Tk6Ak; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD8AEC4CEE2;
	Tue, 18 Feb 2025 13:01:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739883701;
	bh=Y26I/JGBiSo0ZEQDmS9aR8Eu7fZy8Uy8E+e7r8m7XJ4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=YA7Tk6AksvLoqnXt8E7VfQ+wVowdZ2viDjMa55gNOezjRXlNH+BmBqZrLrkhrvklC
	 1MWGQ0Gep+26xkza4/EFt6nXF5eScWXmibhHPtxfsTYf2XeFqIYSrnAIqSFW83Fotc
	 5ijsbsFReUlHjZuBQtBBPAL7XDFkZZyqYfIDUcR4Z7S8zGs9QXDvIwkWV0WF5KNHj1
	 dGTSAyox+01IRun+kMmGIm9fqEQi5k2VRkfUrrNukiIx0cTCNu5pdW5JTf/7KYcV9O
	 RIxonoZ36gIsJLOchpetjJpQxTsjxFu0ETFcSNCn2ZTwVfMS7p6FSUXARwfLf85k/o
	 qTIvm3iYoOqXg==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Tue, 18 Feb 2025 13:57:17 +0100
Subject: [PATCH v3 2/4] rust: configfs: introduce rust support for configfs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250218-configfs-v3-2-0e40c0778187@kernel.org>
References: <20250218-configfs-v3-0-0e40c0778187@kernel.org>
In-Reply-To: <20250218-configfs-v3-0-0e40c0778187@kernel.org>
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <benno.lossin@proton.me>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Peter Zijlstra <peterz@infradead.org>, 
 Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, 
 Waiman Long <longman@redhat.com>, Danilo Krummrich <dakr@kernel.org>, 
 Joel Becker <jlbec@evilplan.org>, Christoph Hellwig <hch@lst.de>, 
 Fiona Behrens <me@kloenk.dev>, 
 Charalampos Mitrodimas <charmitro@posteo.net>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=37157;
 i=a.hindborg@kernel.org; h=from:subject:message-id;
 bh=Y26I/JGBiSo0ZEQDmS9aR8Eu7fZy8Uy8E+e7r8m7XJ4=;
 b=owEBbQKS/ZANAwAIAeG4Gj55KGN3AcsmYgBntIO/PAL1oeYewbxsRUyi0PvmLNXqvQ0fhMpMm
 snNPrmk5piJAjMEAAEIAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCZ7SDvwAKCRDhuBo+eShj
 d/BhD/4n13DLGW3M+DhMzUwHwHIdjZ4oTT/uGOk1RQJvA6N0mUz41ZS4qk9GeCR8VA2WWPkF0XM
 t8nYEv/3uTN6+FD6C1d6SGY2WaQv54xo7d0df+bnKwJBJTPElh73cMTC30xbjoAlq61/uV4SZtV
 +tySn4w9VfFZLnGCSCyAiFRqA57Kle5CGpUFW/AAsAjV62+AmDtfxyijtGojeCLprYlJ5pe2IAR
 D2roOf11EX00Zf7sphiMa7qz2ph7fFdfE/a+KZ0iqrL0b8/ZaqIV4u5bmHwzs6LS+JDmLxAsbAd
 YWbRdD4xyL5oNiYnU6YUDw629IXAKRh4s2DHDZB78N0DC3jN+7WT2msua5yrzywpVg2vi89susX
 A7QdFDULJoSXTbgVQ98Pz+3SmpAf0HrMvrRSioNRUGSMjpN6bWuk9s/+o8ysdF85GNERwXU5iQl
 GoWWtnoUiIyNcs9CUHjpQQQhGkUe5FdVk4x8CvuOaZ5HMTUAtHK8gWBw8amSBY7HeE54FRmIBne
 uEdz+4VhKrqygdz1zGkTvwJAs6cGUmXc7sh/HyY0xesoCWjx2QbJL0OAGYDxyaX6VkbbrSUMake
 CmGIKdSAcDhxrr2tP/+gLtiMpsE6SzypMIxyMiw1p5SSzFLzrP80blPPht5XCo2D5B9KLDM+ux8
 96khaupJu78joxA==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

This patch adds a rust API for configfs, thus allowing rust modules to use
configfs for configuration. The implementation is a shim on top of the C
configfs implementation allowing safe use of the C infrastructure from
rust.

The patch enables the `const_mut_refs` feature on compilers before rustc
1.83. The feature was stabilized in rustc 1.83 and is not required to be
explicitly enabled on later versions.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>

---

This patch is a direct dependency for `rnull`, the rust null block driver.
---
 rust/bindings/bindings_helper.h |   1 +
 rust/helpers/mutex.c            |   5 +
 rust/kernel/configfs.rs         | 938 ++++++++++++++++++++++++++++++++++++++++
 rust/kernel/lib.rs              |   2 +
 4 files changed, 946 insertions(+)

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index 55354e4dec14e..d115a770306f6 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -10,6 +10,7 @@
 #include <linux/blk-mq.h>
 #include <linux/blk_types.h>
 #include <linux/blkdev.h>
+#include <linux/configfs.h>
 #include <linux/cred.h>
 #include <linux/errname.h>
 #include <linux/ethtool.h>
diff --git a/rust/helpers/mutex.c b/rust/helpers/mutex.c
index 06575553eda5c..3e9b910a88e9b 100644
--- a/rust/helpers/mutex.c
+++ b/rust/helpers/mutex.c
@@ -17,3 +17,8 @@ void rust_helper_mutex_assert_is_held(struct mutex *mutex)
 {
 	lockdep_assert_held(mutex);
 }
+
+void rust_helper_mutex_destroy(struct mutex *lock)
+{
+	mutex_destroy(lock);
+}
diff --git a/rust/kernel/configfs.rs b/rust/kernel/configfs.rs
new file mode 100644
index 0000000000000..fd19ddd209b1a
--- /dev/null
+++ b/rust/kernel/configfs.rs
@@ -0,0 +1,938 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! `configfs` interface.
+//!
+//! `configfs` is an in-memory pseudo file system for configuration of kernel
+//! modules. Please see the [C documentation] for details and intended use of
+//! `configfs`.
+//!
+//! This module does not support the following `configfs` features:
+//!
+//! - Items. All group children are groups.
+//! - Symlink support.
+//! - `disconnect_notify` hook.
+//! - Default groups.
+//!
+//! See the [rust_configfs.rs] sample for a full example use of this module.
+//!
+//! C header: [`include/linux/configfs.h`](srctree/include/linux/configfs.h)
+//!
+//! # Example
+//!
+//! ```ignore
+//! use kernel::alloc::flags;
+//! use kernel::c_str;
+//! use kernel::configfs_attrs;
+//! use kernel::configfs;
+//! use kernel::new_mutex;
+//! use kernel::page::PAGE_SIZE;
+//! use kernel::sync::Mutex;
+//! use kernel::ThisModule;
+//!
+//! #[pin_data]
+//! struct RustConfigfs {
+//!     #[pin]
+//!     config: configfs::Subsystem<Configuration>,
+//! }
+//!
+//! impl kernel::InPlaceModule for RustConfigfs {
+//!     fn init(_module: &'static ThisModule) -> impl PinInit<Self, Error> {
+//!         pr_info!("Rust configfs sample (init)\n");
+//!
+//!         let item_type = configfs_attrs! {
+//!             container: configfs::Subsystem<Configuration>,
+//!             data: Configuration,
+//!             attributes: [
+//!                 message: 0,
+//!                 bar: 1,
+//!             ],
+//!         };
+//!
+//!         try_pin_init!(Self {
+//!             config <- configfs::Subsystem::new(
+//!                 c_str!("rust_configfs"), item_type, Configuration::new()
+//!             ),
+//!         })
+//!     }
+//! }
+//!
+//! #[pin_data]
+//! struct Configuration {
+//!     message: &'static CStr,
+//!     #[pin]
+//!     bar: Mutex<(KBox<[u8; PAGE_SIZE]>, usize)>,
+//! }
+//!
+//! impl Configuration {
+//!     fn new() -> impl PinInit<Self, Error> {
+//!         try_pin_init!(Self {
+//!             message: c_str!("Hello World\n"),
+//!             bar <- new_mutex!((KBox::new([0; PAGE_SIZE], flags::GFP_KERNEL)?, 0)),
+//!         })
+//!     }
+//! }
+//!
+//! #[vtable]
+//! impl configfs::AttributeOperations<0> for Configuration {
+//!     type Data = Configuration;
+//!
+//!     fn show(container: &Configuration, page: &mut [u8; PAGE_SIZE]) -> Result<usize> {
+//!         pr_info!("Show message\n");
+//!         let data = container.message;
+//!         page[0..data.len()].copy_from_slice(data);
+//!         Ok(data.len())
+//!     }
+//! }
+//!
+//! #[vtable]
+//! impl configfs::AttributeOperations<1> for Configuration {
+//!     type Data = Configuration;
+//!
+//!     fn show(container: &Configuration, page: &mut [u8; PAGE_SIZE]) -> Result<usize> {
+//!         pr_info!("Show bar\n");
+//!         let guard = container.bar.lock();
+//!         let data = guard.0.as_slice();
+//!         let len = guard.1;
+//!         page[0..len].copy_from_slice(&data[0..len]);
+//!         Ok(len)
+//!     }
+//!
+//!     fn store(container: &Configuration, page: &[u8]) -> Result {
+//!         pr_info!("Store bar\n");
+//!         let mut guard = container.bar.lock();
+//!         guard.0[0..page.len()].copy_from_slice(page);
+//!         guard.1 = page.len();
+//!         Ok(())
+//!     }
+//! }
+//! ```
+//!
+//! [C documentation]: srctree/Documentation/filesystems/configfs.rst
+//! [rust_configfs.rs]: srctree/samples/rust/rust_configfs.rs
+
+use crate::alloc::flags;
+use crate::container_of;
+use crate::page::PAGE_SIZE;
+use crate::prelude::*;
+use crate::str::CString;
+use crate::sync::Arc;
+use crate::sync::ArcBorrow;
+use crate::types::ForeignOwnable;
+use crate::types::Opaque;
+use core::cell::UnsafeCell;
+use core::marker::PhantomData;
+use core::ptr::addr_of;
+use core::ptr::addr_of_mut;
+
+/// A `configfs` subsystem.
+///
+/// This is the top level entrypoint for a `configfs` hierarchy. To register
+/// with configfs, embed a field of this type into your kernel module struct.
+#[pin_data(PinnedDrop)]
+pub struct Subsystem<Data> {
+    #[pin]
+    subsystem: Opaque<bindings::configfs_subsystem>,
+    #[pin]
+    data: Data,
+}
+
+// SAFETY: We do not provide any operations on `Subsystem`.
+unsafe impl<Data> Sync for Subsystem<Data> {}
+
+// SAFETY: Ownership of `Subsystem` can safely be transferred to other threads.
+unsafe impl<Data> Send for Subsystem<Data> {}
+
+impl<Data> Subsystem<Data> {
+    /// Create an initializer for a [`Subsystem`].
+    ///
+    /// The subsystem will appear in configfs as a directory name given by
+    /// `name`. The attributes available in directory are specified by
+    /// `item_type`.
+    pub fn new(
+        name: &'static CStr,
+        item_type: &'static ItemType<Subsystem<Data>, Data>,
+        data: impl PinInit<Data, Error>,
+    ) -> impl PinInit<Self, Error> {
+        try_pin_init!(Self {
+            subsystem <- kernel::init::zeroed().chain(
+                |place: &mut Opaque<bindings::configfs_subsystem>| {
+                    // SAFETY: We initialized the required fields of `place.group` above.
+                    unsafe {
+                        bindings::config_group_init_type_name(
+                            &mut (*place.get()).su_group,
+                            name.as_ptr(),
+                            item_type.as_ptr(),
+                        )
+                    };
+
+                    // SAFETY: `place.su_mutex` is valid for use as a mutex.
+                    unsafe {
+                        bindings::__mutex_init(
+                            &mut (*place.get()).su_mutex,
+                            kernel::optional_name!().as_char_ptr(),
+                            kernel::static_lock_class!().as_ptr(),
+                        )
+                    }
+                    Ok(())
+                }
+            ),
+            data <- data,
+        })
+        .pin_chain(|this| {
+            crate::error::to_result(
+                // SAFETY: We initialized `this.subsystem` according to C API contract above.
+                unsafe { bindings::configfs_register_subsystem(this.subsystem.get()) },
+            )
+        })
+    }
+}
+
+#[pinned_drop]
+impl<Data> PinnedDrop for Subsystem<Data> {
+    fn drop(self: Pin<&mut Self>) {
+        // SAFETY: We registered `self.subsystem` in the initializer returned by `Self::new`.
+        unsafe { bindings::configfs_unregister_subsystem(self.subsystem.get()) };
+        // SAFETY: We initialized the mutex in `Subsystem::new`.
+        unsafe { bindings::mutex_destroy(addr_of_mut!((*self.subsystem.get()).su_mutex)) };
+    }
+}
+
+/// Trait that allows offset calculations for structs that embed a
+/// `bindings::config_group`.
+///
+/// Users of the `configfs` API should not need to implement this trait.
+///
+/// # Safety
+///
+/// - Implementers of this trait must embed a `bindings::config_group`.
+/// - Methods must be implemented according to method documentation.
+pub unsafe trait HasGroup<Data> {
+    /// Return the address of the `bindings::config_group` embedded in `Self`.
+    ///
+    /// # Safety
+    ///
+    /// - `this` must be a valid allocation of at least the size of `Self`.
+    unsafe fn group(this: *const Self) -> *const bindings::config_group;
+
+    /// Return the address of the `Self` that `group` is embedded in.
+    ///
+    /// # Safety
+    ///
+    /// - `group` must point to the `bindings::config_group` that is embedded in
+    ///   `Self`.
+    unsafe fn container_of(group: *const bindings::config_group) -> *const Self;
+}
+
+// SAFETY: `Subsystem<Data>` embeds a field of type `bindings::config_group`
+// within the `subsystem` field.
+unsafe impl<Data> HasGroup<Data> for Subsystem<Data> {
+    unsafe fn group(this: *const Self) -> *const bindings::config_group {
+        // SAFETY: By impl and function safety requirement this projection is in bounds.
+        unsafe { addr_of!((*(*this).subsystem.get()).su_group) }
+    }
+
+    unsafe fn container_of(group: *const bindings::config_group) -> *const Self {
+        // SAFETY: By impl and function safety requirement this projection is in bounds.
+        let c_subsys_ptr = unsafe { container_of!(group, bindings::configfs_subsystem, su_group) };
+        let opaque_ptr = c_subsys_ptr.cast::<Opaque<bindings::configfs_subsystem>>();
+        // SAFETY: By impl and function safety requirement, `opaque_ptr` and the
+        // pointer it returns, are within the same allocation.
+        unsafe { container_of!(opaque_ptr, Subsystem<Data>, subsystem) }
+    }
+}
+
+/// A `configfs` group.
+///
+/// To add a subgroup to `configfs`, pass this type as `ctype` to
+/// [`crate::configfs_attrs`] when creating a group in [`GroupOperations::make_group`].
+#[pin_data]
+pub struct Group<Data> {
+    #[pin]
+    group: Opaque<bindings::config_group>,
+    #[pin]
+    data: Data,
+}
+
+impl<Data> Group<Data> {
+    /// Create an initializer for a new group.
+    ///
+    /// When instantiated, the group will appear as a directory with the name
+    /// given by `name` and it will contain attributes specified by `item_type`.
+    pub fn new(
+        name: CString,
+        item_type: &'static ItemType<Group<Data>, Data>,
+        data: impl PinInit<Data, Error>,
+    ) -> impl PinInit<Self, Error> {
+        try_pin_init!(Self {
+            group <- kernel::init::zeroed().chain(|v: &mut Opaque<bindings::config_group>| {
+                let place = v.get();
+                let name = name.as_bytes_with_nul().as_ptr();
+                // SAFETY: It is safe to initialize a group once it has been zeroed.
+                unsafe {
+                    bindings::config_group_init_type_name(place, name.cast(), item_type.as_ptr())
+                };
+                Ok(())
+            }),
+            data <- data,
+        })
+    }
+}
+
+// SAFETY: `Group<Data>` embeds a field of type `bindings::config_group`
+// within the `group` field.
+unsafe impl<Data> HasGroup<Data> for Group<Data> {
+    unsafe fn group(this: *const Self) -> *const bindings::config_group {
+        Opaque::raw_get(
+            // SAFETY: By impl and function safety requirements this field
+            // projection is within bounds of the allocation.
+            unsafe { addr_of!((*this).group) },
+        )
+    }
+
+    unsafe fn container_of(group: *const bindings::config_group) -> *const Self {
+        let opaque_ptr = group.cast::<Opaque<bindings::config_group>>();
+        // SAFETY: By impl and function safety requirement, `opaque_ptr` and
+        // pointer it returns will be in the same allocation.
+        unsafe { container_of!(opaque_ptr, Self, group) }
+    }
+}
+
+/// # Safety
+///
+/// `this` must be a valid pointer.
+///
+/// If `this` does not represent the root group of a `configfs` subsystem,
+/// `this` must be a pointer to a `bindings::config_group` embedded in a
+/// `Group<Parent>`.
+///
+/// Otherwise, `this` must be a pointer to a `bindings::config_group` that
+/// is embedded in a `bindings::configfs_subsystem` that is embedded in a
+/// `Subsystem<Parent>`.
+unsafe fn get_group_data<'a, Parent>(this: *mut bindings::config_group) -> &'a Parent {
+    // SAFETY: `this` is a valid pointer.
+    let is_root = unsafe { (*this).cg_subsys.is_null() };
+
+    if !is_root {
+        // SAFETY: By C API contact, `this` is a pointer to a
+        // `bindings::config_group` that we passed as a return value in from
+        // `make_group`. Such a pointer is embedded within a `Group<Parent>`.
+        unsafe { &(*Group::<Parent>::container_of(this)).data }
+    } else {
+        // SAFETY: By C API contract, `this` is a pointer to the
+        // `bindings::config_group` field within a `Subsystem<Parent>`.
+        unsafe { &(*Subsystem::container_of(this)).data }
+    }
+}
+
+struct GroupOperationsVTable<Parent, Child>(PhantomData<(Parent, Child)>);
+
+impl<Parent, Child> GroupOperationsVTable<Parent, Child>
+where
+    Parent: GroupOperations<Child = Child>,
+    Child: 'static,
+{
+    /// # Safety
+    ///
+    /// `this` must be a valid pointer.
+    ///
+    /// If `this` does not represent the root group of a `configfs` subsystem,
+    /// `this` must be a pointer to a `bindings::config_group` embedded in a
+    /// `Group<Parent>`.
+    ///
+    /// Otherwise, `this` must be a pointer to a `bindings::config_group` that
+    /// is embedded in a `bindings::configfs_subsystem` that is embedded in a
+    /// `Subsystem<Parent>`.
+    ///
+    /// `name` must point to a null terminated string.
+    unsafe extern "C" fn make_group(
+        this: *mut bindings::config_group,
+        name: *const kernel::ffi::c_char,
+    ) -> *mut bindings::config_group {
+        // SAFETY: By function safety requirements of this function, this call
+        // is safe.
+        let parent_data = unsafe { get_group_data(this) };
+
+        let group_init = match Parent::make_group(
+            parent_data,
+            // SAFETY: By function safety requirements, name points to a null
+            // terminated string.
+            unsafe { CStr::from_char_ptr(name) },
+        ) {
+            Ok(init) => init,
+            Err(e) => return e.to_ptr(),
+        };
+
+        let child_group = <Arc<Group<Child>> as InPlaceInit<Group<Child>>>::try_pin_init(
+            group_init,
+            flags::GFP_KERNEL,
+        );
+
+        match child_group {
+            Ok(child_group) => {
+                let child_group_ptr = child_group.into_foreign();
+                // SAFETY: We allocated the pointee of `child_ptr` above as a
+                // `Group<Child>`.
+                unsafe { Group::<Child>::group(child_group_ptr) }.cast_mut()
+            }
+            Err(e) => e.to_ptr(),
+        }
+    }
+
+    /// # Safety
+    ///
+    /// If `this` does not represent the root group of a `configfs` subsystem,
+    /// `this` must be a pointer to a `bindings::config_group` embedded in a
+    /// `Group<Parent>`.
+    ///
+    /// Otherwise, `this` must be a pointer to a `bindings::config_group` that
+    /// is embedded in a `bindings::configfs_subsystem` that is embedded in a
+    /// `Subsystem<Parent>`.
+    ///
+    /// `item` must point to a `bindings::config_item` within a
+    /// `bindings::config_group` within a `Group<Child>`.
+    unsafe extern "C" fn drop_item(
+        this: *mut bindings::config_group,
+        item: *mut bindings::config_item,
+    ) {
+        // SAFETY: By function safety requirements of this function, this call
+        // is safe.
+        let parent_data = unsafe { get_group_data(this) };
+
+        // SAFETY: By function safety requirements, `item` is embedded in a
+        // `config_group`.
+        let c_child_group_ptr =
+            unsafe { kernel::container_of!(item, bindings::config_group, cg_item) };
+        // SAFETY: By function safety requirements, `c_child_group_ptr` is
+        // embedded within a `Group<Child>`.
+        let r_child_group_ptr = unsafe { Group::<Child>::container_of(c_child_group_ptr) };
+
+        if Parent::HAS_DROP_ITEM {
+            Parent::drop_item(
+                parent_data,
+                // SAFETY: We called `into_foreign` to produce `r_child_group_ptr` in
+                // `make_group`. There are not other borrows of this pointer in existence.
+                unsafe {
+                    <Arc<Group<Child>> as ForeignOwnable>::borrow(r_child_group_ptr.cast_mut())
+                },
+            );
+        }
+
+        // SAFETY: By C API contract, we are required to drop a refcount on
+        // `item`.
+        unsafe { bindings::config_item_put(item) };
+    }
+
+    const VTABLE: bindings::configfs_group_operations = bindings::configfs_group_operations {
+        make_item: None,
+        make_group: Some(Self::make_group),
+        disconnect_notify: None,
+        drop_item: Some(Self::drop_item),
+        is_visible: None,
+        is_bin_visible: None,
+    };
+}
+
+struct ItemOperationsVTable<Container, Data>(PhantomData<(Container, Data)>);
+
+impl<Data> ItemOperationsVTable<Group<Data>, Data>
+where
+    Data: 'static,
+{
+    /// # Safety
+    ///
+    /// `this` must be a pointer to a `bindings::config_group` embedded in a
+    /// `Group<Parent>`.
+    ///
+    /// This function will destroy the pointee of `this`. The pointee of `this`
+    /// must not be accessed after the function returns.
+    unsafe extern "C" fn release(this: *mut bindings::config_item) {
+        // SAFETY: By function safety requirements, `this` is embedded in a
+        // `config_group`.
+        let c_group_ptr = unsafe { kernel::container_of!(this, bindings::config_group, cg_item) };
+        // SAFETY: By function safety requirements, `c_group_ptr` is
+        // embedded within a `Group<Data>`.
+        let r_group_ptr = unsafe { Group::<Data>::container_of(c_group_ptr) };
+
+        // SAFETY: We called `into_foreign` on `r_group_ptr` in
+        // `make_group`.
+        let pin_self =
+            unsafe { <Arc<Group<Data>> as ForeignOwnable>::from_foreign(r_group_ptr.cast_mut()) };
+        drop(pin_self);
+    }
+
+    const VTABLE: bindings::configfs_item_operations = bindings::configfs_item_operations {
+        release: Some(Self::release),
+        allow_link: None,
+        drop_link: None,
+    };
+}
+
+impl<Data> ItemOperationsVTable<Subsystem<Data>, Data> {
+    const VTABLE: bindings::configfs_item_operations = bindings::configfs_item_operations {
+        release: None,
+        allow_link: None,
+        drop_link: None,
+    };
+}
+
+/// Operations implemented by `configfs` groups that can create subgroups.
+///
+/// Implement this trait on structs that embed a [`Subsystem`] or a [`Group`].
+#[vtable]
+pub trait GroupOperations {
+    /// The child data object type.
+    ///
+    /// This group will create subgroups (subdirectories) backed by this kind of
+    /// object.
+    type Child: 'static;
+
+    /// Creates a new subgroup.
+    ///
+    /// The kernel will call this method in response to `mkdir(2)` in the
+    /// directory representing `this`.
+    ///
+    /// To accept the request to create a group, implementations should
+    /// return an initializer of a `Group<Self::Child>`. To prevent creation,
+    /// return a suitable error.
+    fn make_group(&self, name: &CStr) -> Result<impl PinInit<Group<Self::Child>, Error>>;
+
+    /// Prepares the group for removal from configfs.
+    ///
+    /// The kernel will call this method before the directory representing
+    /// `_child` is removed from `configfs`.
+    ///
+    /// Implementations can use this method to do house keeping before
+    /// `configfs` drops its reference to `Child`.
+    fn drop_item(&self, _child: ArcBorrow<'_, Group<Self::Child>>) {
+        kernel::build_error!(kernel::error::VTABLE_DEFAULT_ERROR)
+    }
+}
+
+/// A `configfs` attribute.
+///
+/// An attribute appears as a file in configfs, inside a folder that represent
+/// the group that the attribute belongs to.
+#[repr(transparent)]
+pub struct Attribute<const ID: u64, O, Data> {
+    attribute: Opaque<bindings::configfs_attribute>,
+    _p: PhantomData<(O, Data)>,
+}
+
+// SAFETY: We do not provide any operations on `Attribute`.
+unsafe impl<const ID: u64, O, Data> Sync for Attribute<ID, O, Data> {}
+
+// SAFETY: Ownership of `Attribute` can safely be transferred to other threads.
+unsafe impl<const ID: u64, O, Data> Send for Attribute<ID, O, Data> {}
+
+impl<const ID: u64, O, Data> Attribute<ID, O, Data>
+where
+    O: AttributeOperations<ID, Data = Data>,
+{
+    /// # Safety
+    ///
+    /// `item` must be embedded in a `bindings::config_group`.
+    ///
+    /// If `item` does not represent the root group of a `configfs` subsystem,
+    /// the group must be embedded in a `Group<Data>`.
+    ///
+    /// Otherwise, the group must be a embedded in a
+    /// `bindings::configfs_subsystem` that is embedded in a `Subsystem<Data>`.
+    ///
+    /// `page` must point to a writable buffer of size at least [`PAGE_SIZE`].
+    unsafe extern "C" fn show(
+        item: *mut bindings::config_item,
+        page: *mut kernel::ffi::c_char,
+    ) -> isize {
+        let c_group: *mut bindings::config_group =
+        // SAFETY: By function safety requirements, `item` is embedded in a
+        // `config_group`.
+            unsafe { container_of!(item, bindings::config_group, cg_item) }.cast_mut();
+
+        // SAFETY: The function safety requirements for this function satisfy
+        // the conditions for this call.
+        let data: &Data = unsafe { get_group_data(c_group) };
+
+        // SAFETY: By function safety requirements, `page` is writable for `PAGE_SIZE`.
+        let ret = O::show(data, unsafe { &mut *(page as *mut [u8; PAGE_SIZE]) });
+
+        match ret {
+            Ok(size) => size as isize,
+            Err(err) => err.to_errno() as isize,
+        }
+    }
+
+    /// # Safety
+    ///
+    /// `item` must be embedded in a `bindings::config_group`.
+    ///
+    /// If `item` does not represent the root group of a `configfs` subsystem,
+    /// the group must be embedded in a `Group<Data>`.
+    ///
+    /// Otherwise, the group must be a embedded in a
+    /// `bindings::configfs_subsystem` that is embedded in a `Subsystem<Data>`.
+    ///
+    /// `page` must point to a readable buffer of size at least `size`.
+    unsafe extern "C" fn store(
+        item: *mut bindings::config_item,
+        page: *const kernel::ffi::c_char,
+        size: usize,
+    ) -> isize {
+        let c_group: *mut bindings::config_group =
+        // SAFETY: By function safety requirements, `item` is embedded in a
+        // `config_group`.
+            unsafe { container_of!(item, bindings::config_group, cg_item) }.cast_mut();
+
+        // SAFETY: The function safety requirements for this function satisfy
+        // the conditions for this call.
+        let data: &Data = unsafe { get_group_data(c_group) };
+
+        let ret = O::store(
+            data,
+            // SAFETY: By function safety requirements, `page` is readable
+            // for at least `size`.
+            unsafe { core::slice::from_raw_parts(page.cast(), size) },
+        );
+
+        match ret {
+            Ok(()) => size as isize,
+            Err(err) => err.to_errno() as isize,
+        }
+    }
+
+    /// Create a new attribute.
+    ///
+    /// The attribute will appear as a file with name given by `name`.
+    pub const fn new(name: &'static CStr) -> Self {
+        Self {
+            attribute: Opaque::new(bindings::configfs_attribute {
+                ca_name: name as *const _ as _,
+                ca_owner: core::ptr::null_mut(),
+                ca_mode: 0o660,
+                show: Some(Self::show),
+                store: if O::HAS_STORE {
+                    Some(Self::store)
+                } else {
+                    None
+                },
+            }),
+            _p: PhantomData,
+        }
+    }
+}
+
+/// Operations supported by an attribute.
+///
+/// Implement this trait on type and pass that type as generic parameter when
+/// creating an [`Attribute`]. The type carrying the implementation serve no
+/// purpose other than specifying the attribute operations.
+#[vtable]
+pub trait AttributeOperations<const ID: u64 = 0> {
+    /// The type of the object that contains the field that is backing the
+    /// attribute for this operation.
+    type Data;
+
+    /// Renders the value of an attribute.
+    ///
+    /// This function is called by the kernel to read the value of an attribute.
+    ///
+    /// Implementations should write the rendering of the attribute to `page`
+    /// and return the number of bytes written.
+    fn show(data: &Self::Data, page: &mut [u8; PAGE_SIZE]) -> Result<usize>;
+
+    /// Stores the value of an attribute.
+    ///
+    /// This function is called by the kernel to update the value of an attribute.
+    ///
+    /// Implementations should parse the value from `page` and update internal
+    /// state to reflect the parsed value.
+    fn store(_data: &Self::Data, _page: &[u8]) -> Result {
+        kernel::build_error!(kernel::error::VTABLE_DEFAULT_ERROR)
+    }
+}
+
+/// A list of attributes.
+///
+/// This type is used to construct a new [`ItemType`]. It represents a list of
+/// [`Attribute`] that will appear in the directory representing a [`Group`].
+/// Users should not directly instantiate this type, rather they should use the
+/// [`kernel::configfs_attrs`] macro to declare a static set of attributes for a
+/// group.
+#[repr(transparent)]
+pub struct AttributeList<const N: usize, Data>(
+    UnsafeCell<[*mut kernel::ffi::c_void; N]>,
+    PhantomData<Data>,
+);
+
+// SAFETY: Ownership of `AttributeList` can safely be transferred to other threads.
+unsafe impl<const N: usize, Data> Send for AttributeList<N, Data> {}
+
+// SAFETY: We do not provide any operations on `AttributeList` that need synchronization.
+unsafe impl<const N: usize, Data> Sync for AttributeList<N, Data> {}
+
+impl<const N: usize, Data> AttributeList<N, Data> {
+    /// # Safety
+    ///
+    /// This function can only be called by the `configfs_attrs`
+    /// macro.
+    #[doc(hidden)]
+    pub const unsafe fn new() -> Self {
+        Self(UnsafeCell::new([core::ptr::null_mut(); N]), PhantomData)
+    }
+
+    /// # Safety
+    ///
+    /// This function can only be called by the `configfs_attrs`
+    /// macro.
+    #[doc(hidden)]
+    pub const unsafe fn add<
+        const I: usize,
+        const ID: u64,
+        O: AttributeOperations<ID, Data = Data>,
+    >(
+        &'static self,
+        attribute: &'static Attribute<ID, O, Data>,
+    ) {
+        // We need a space at the end of our list for a null terminator.
+        if I >= N - 1 {
+            kernel::build_error!("Invalid attribute index");
+        }
+
+        // SAFETY: This function is only called through the `configfs_attrs`
+        // macro. This ensures that we are evaluating the function in const
+        // context when initializing a static. As such, the reference created
+        // below will be exclusive.
+        unsafe {
+            (&mut *self.0.get())[I] = (attribute as *const Attribute<ID, O, Data>)
+                .cast_mut()
+                .cast()
+        };
+    }
+}
+
+/// A representation of the attributes that will appear in a [`Group`] or
+/// [`Subsystem`].
+///
+/// Users should not directly instantiate objects of this type. Rather, they
+/// should use the [`kernel::configfs_attrs`] macro to statically declare the
+/// shape of a [`Group`] or [`Subsystem`].
+#[pin_data]
+pub struct ItemType<Container, Data> {
+    #[pin]
+    item_type: Opaque<bindings::config_item_type>,
+    _p: PhantomData<(Container, Data)>,
+}
+
+// SAFETY: We do not provide any operations on `ItemType` that need synchronization.
+unsafe impl<Container, Data> Sync for ItemType<Container, Data> {}
+
+// SAFETY: Ownership of `ItemType` can safely be transferred to other threads.
+unsafe impl<Container, Data> Send for ItemType<Container, Data> {}
+
+macro_rules! impl_item_type {
+    ($tpe:ty) => {
+        impl<Data> ItemType<$tpe, Data> {
+            #[doc(hidden)]
+            pub const fn new_with_child_ctor<const N: usize, Child>(
+                owner: &'static ThisModule,
+                attributes: &'static AttributeList<N, Data>,
+            ) -> Self
+            where
+                Data: GroupOperations<Child = Child>,
+                Child: 'static,
+            {
+                Self {
+                    item_type: Opaque::new(bindings::config_item_type {
+                        ct_owner: owner.as_ptr(),
+                        ct_group_ops: (&GroupOperationsVTable::<Data, Child>::VTABLE as *const _)
+                            as *mut _,
+                        ct_item_ops: (&ItemOperationsVTable::<$tpe, Data>::VTABLE as *const _)
+                            as *mut _,
+                        ct_attrs: attributes as *const _ as _,
+                        ct_bin_attrs: core::ptr::null_mut(),
+                    }),
+                    _p: PhantomData,
+                }
+            }
+
+            #[doc(hidden)]
+            pub const fn new<const N: usize>(
+                owner: &'static ThisModule,
+                attributes: &'static AttributeList<N, Data>,
+            ) -> Self {
+                Self {
+                    item_type: Opaque::new(bindings::config_item_type {
+                        ct_owner: owner.as_ptr(),
+                        ct_group_ops: core::ptr::null_mut(),
+                        ct_item_ops: (&ItemOperationsVTable::<$tpe, Data>::VTABLE as *const _)
+                            as *mut _,
+                        ct_attrs: attributes as *const _ as _,
+                        ct_bin_attrs: core::ptr::null_mut(),
+                    }),
+                    _p: PhantomData,
+                }
+            }
+        }
+    };
+}
+
+impl_item_type!(Subsystem<Data>);
+impl_item_type!(Group<Data>);
+
+impl<Container, Data> ItemType<Container, Data> {
+    fn as_ptr(&self) -> *const bindings::config_item_type {
+        self.item_type.get()
+    }
+}
+
+/// Define a list of configfs attributes statically.
+#[macro_export]
+macro_rules! configfs_attrs {
+    (
+        container: $container:ty,
+        data: $data:ty,
+        attributes: [
+            $($name:ident: $attr:literal),* $(,)?
+        ] $(,)?
+    ) => {
+        $crate::configfs_attrs!(
+            count:
+            @container($container),
+            @data($data),
+            @child(),
+            @no_child(x),
+            @attrs($($name $attr)*),
+            @eat($($name $attr,)*),
+            @assign(),
+            @cnt(0usize),
+        )
+    };
+    (
+        container: $container:ty,
+        data: $data:ty,
+        child: $child:ty,
+        attributes: [
+            $($name:ident: $attr:literal),* $(,)?
+        ] $(,)?
+    ) => {
+        $crate::configfs_attrs!(
+            count:
+            @container($container),
+            @data($data),
+            @child($child),
+            @no_child(),
+            @attrs($($name $attr)*),
+            @eat($($name $attr,)*),
+            @assign(),
+            @cnt(0usize),
+        )
+    };
+    (count:
+     @container($container:ty),
+     @data($data:ty),
+     @child($($child:ty)?),
+     @no_child($($no_child:ident)?),
+     @attrs($($aname:ident $aattr:literal)*),
+     @eat($name:ident $attr:literal, $($rname:ident $rattr:literal,)*),
+     @assign($($assign:block)*),
+     @cnt($cnt:expr),
+    ) => {
+        $crate::configfs_attrs!(
+            count:
+            @container($container),
+            @data($data),
+            @child($($child)?),
+            @no_child($($no_child)?),
+            @attrs($($aname $aattr)*),
+            @eat($($rname $rattr,)*),
+            @assign($($assign)* {
+                const N: usize = $cnt;
+                // The following macro text expands to a call to `Attribute::add`.
+                // SAFETY: We are expanding `configfs_attrs`.
+                unsafe {
+                    $crate::macros::paste!(
+                        [< $data:upper _ATTRS >]
+                            .add::<N, $attr, _>(&[< $data:upper _ $name:upper _ATTR >])
+                    )
+                };
+            }),
+            @cnt(1usize + $cnt),
+        )
+    };
+    (count:
+     @container($container:ty),
+     @data($data:ty),
+     @child($($child:ty)?),
+     @no_child($($no_child:ident)?),
+     @attrs($($aname:ident $aattr:literal)*),
+     @eat(),
+     @assign($($assign:block)*),
+     @cnt($cnt:expr),
+    ) =>
+    {
+        $crate::configfs_attrs!(
+            final:
+            @container($container),
+            @data($data),
+            @child($($child)?),
+            @no_child($($no_child)?),
+            @attrs($($aname $aattr)*),
+            @assign($($assign)*),
+            @cnt($cnt),
+        )
+    };
+    (final:
+     @container($container:ty),
+     @data($data:ty),
+     @child($($child:ty)?),
+     @no_child($($no_child:ident)?),
+     @attrs($($name:ident $attr:literal)*),
+     @assign($($assign:block)*),
+     @cnt($cnt:expr),
+    ) =>
+    {
+        $crate::macros::paste!{
+            {
+                $(
+                    // SAFETY: We are expanding `configfs_attrs`.
+                    static [< $data:upper _ $name:upper _ATTR >]:
+                        $crate::configfs::Attribute<$attr, $data, $data> =
+                            unsafe {
+                                $crate::configfs::Attribute::new(c_str!(::core::stringify!($name)))
+                            };
+                )*
+
+
+                // We need space for a null terminator.
+                const N: usize = $cnt + 1usize;
+
+                // SAFETY: We are expanding `configfs_attrs`.
+                static [< $data:upper _ATTRS >]:
+                $crate::configfs::AttributeList<N, $data> =
+                    unsafe { $crate::configfs::AttributeList::new() };
+
+                $($assign)*
+
+                $(
+                    const [<$no_child:upper>]: bool = true;
+
+                    static [< $data:upper _TPE >] : $crate::configfs::ItemType<$container, $data>  =
+                        $crate::configfs::ItemType::<$container, $data>::new::<N>(
+                            &THIS_MODULE, &[<$ data:upper _ATTRS >]
+                        );
+                )?
+
+                $(
+                    static [< $data:upper _TPE >]:
+                        $crate::configfs::ItemType<$container, $data>  =
+                            $crate::configfs::ItemType::<$container, $data>::
+                            new_with_child_ctor::<N, $child>(
+                                &THIS_MODULE, &[<$ data:upper _ATTRS >]
+                            );
+                )?
+
+                & [< $data:upper _TPE >]
+            }
+        }
+    };
+
+}
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index 496ed32b0911a..ec84653ab8c7a 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -40,6 +40,8 @@
 pub mod block;
 #[doc(hidden)]
 pub mod build_assert;
+#[cfg(CONFIG_CONFIGFS_FS)]
+pub mod configfs;
 pub mod cred;
 pub mod device;
 pub mod device_id;

-- 
2.47.0



