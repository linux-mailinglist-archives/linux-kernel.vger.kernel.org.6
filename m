Return-Path: <linux-kernel+bounces-568767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B2BBA69A3D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 21:36:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEF3D1B62344
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 20:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D576214228;
	Wed, 19 Mar 2025 20:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fZ8RAw1N"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4993D1EC013;
	Wed, 19 Mar 2025 20:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742416512; cv=none; b=IhT6li2QoKQSd7rx2TKgzuGl8TWw0lwZQlX5CkYQbtfvYOiNjZRfHoMSFfwvIQNUbtlAi8gggID0ggjONtUoF2kxaj+PS4V1EWFtcMHhBGd1pc32NQLQMddLmYHxXah+sCyuDuhSnyrzapjIiNT0CfckbIqOKcSLIHLV5wrSUOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742416512; c=relaxed/simple;
	bh=ievfoTl3jyU3x62kz5hsaDxDJP+Kedl4LbqRU180iqw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JvLB40OFiB5ERyCAWtDbYU5AWVHW+6xWlUKneQnMn3taNspGrN/oSt2EvZt16xUGm8kX8cHxQbGBzq3xO7tLuoOoeacq3ouGpuAYFEne3uUSSltm0JMldtS13cUNj8VT8NM7QfsD1c0ujJ5XKYOHVoTPso/14xUXcqBXmdIl9fA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fZ8RAw1N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B03C3C4CEE4;
	Wed, 19 Mar 2025 20:35:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742416512;
	bh=ievfoTl3jyU3x62kz5hsaDxDJP+Kedl4LbqRU180iqw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fZ8RAw1NWANlnSuSGTQd+lqLKIvA1N/Nwi4T+agbzWiBmZrajv1uOP5Sgj/RHJAr1
	 hcUqycNxbsiWCbgLeg15N4fnm+9M5Qfs7ERHWBEFViDQePAOXrsCwiFk7znowmqZRS
	 x9NAsMZXWACwIyr1qOU2cm7/UVSr75X8A/N8Z4nNW42QTzWjsrYCLpX36rqH1hGg5k
	 aAQR3Y+ht5i+shn0RPKIcps0oLOp23Ho4Zq/2yUfZuQkDZkDCyn9iFfawmnk7Bqy89
	 Kj9a+dR5PKb6Eu5hL5iB+SODigtxJVOkkkTmmO5XVw/dUO3XLI3vBtV/XW8fVN6NA6
	 w3bUBXmi8hN0w==
From: Danilo Krummrich <dakr@kernel.org>
To: gregkh@linuxfoundation.org,
	rafael@kernel.org,
	ojeda@kernel.org,
	alex.gaynor@gmail.com,
	boqun.feng@gmail.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	benno.lossin@proton.me,
	a.hindborg@kernel.org,
	aliceryhl@google.com,
	tmgross@umich.edu,
	airlied@gmail.com,
	acourbot@nvidia.com,
	jhubbard@nvidia.com
Cc: linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH v3 3/5] rust: auxiliary: add auxiliary device / driver abstractions
Date: Wed, 19 Mar 2025 21:33:55 +0100
Message-ID: <20250319203455.132539-4-dakr@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250319203455.132539-1-dakr@kernel.org>
References: <20250319203455.132539-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement the basic auxiliary abstractions required to implement a
driver matching an auxiliary device.

The design and implementation is analogous to PCI and platform and is
based on the generic device / driver abstractions.

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 MAINTAINERS                     |   1 +
 rust/bindings/bindings_helper.h |   1 +
 rust/helpers/auxiliary.c        |  23 +++
 rust/helpers/helpers.c          |   1 +
 rust/kernel/auxiliary.rs        | 299 ++++++++++++++++++++++++++++++++
 rust/kernel/lib.rs              |   2 +
 6 files changed, 327 insertions(+)
 create mode 100644 rust/helpers/auxiliary.c
 create mode 100644 rust/kernel/auxiliary.rs

diff --git a/MAINTAINERS b/MAINTAINERS
index f5c7022937a7..0a737b28cdfa 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7114,6 +7114,7 @@ F:	include/linux/kobj*
 F:	include/linux/property.h
 F:	include/linux/sysfs.h
 F:	lib/kobj*
+F:	rust/kernel/auxiliary.rs
 F:	rust/kernel/device.rs
 F:	rust/kernel/device_id.rs
 F:	rust/kernel/devres.rs
diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index f46cf3bb7069..83026b6e53b2 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -7,6 +7,7 @@
  */
 
 #include <kunit/test.h>
+#include <linux/auxiliary_bus.h>
 #include <linux/blk-mq.h>
 #include <linux/blk_types.h>
 #include <linux/blkdev.h>
diff --git a/rust/helpers/auxiliary.c b/rust/helpers/auxiliary.c
new file mode 100644
index 000000000000..0db3860d774e
--- /dev/null
+++ b/rust/helpers/auxiliary.c
@@ -0,0 +1,23 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/auxiliary_bus.h>
+
+void rust_helper_auxiliary_set_drvdata(struct auxiliary_device *adev, void *data)
+{
+	auxiliary_set_drvdata(adev, data);
+}
+
+void *rust_helper_auxiliary_get_drvdata(struct auxiliary_device *adev)
+{
+	return auxiliary_get_drvdata(adev);
+}
+
+void rust_helper_auxiliary_device_uninit(struct auxiliary_device *adev)
+{
+	return auxiliary_device_uninit(adev);
+}
+
+void rust_helper_auxiliary_device_delete(struct auxiliary_device *adev)
+{
+	return auxiliary_device_delete(adev);
+}
diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
index 0640b7e115be..d744af85e3b2 100644
--- a/rust/helpers/helpers.c
+++ b/rust/helpers/helpers.c
@@ -7,6 +7,7 @@
  * Sorted alphabetically.
  */
 
+#include "auxiliary.c"
 #include "blk.c"
 #include "bug.c"
 #include "build_assert.c"
diff --git a/rust/kernel/auxiliary.rs b/rust/kernel/auxiliary.rs
new file mode 100644
index 000000000000..1b8015bfca3e
--- /dev/null
+++ b/rust/kernel/auxiliary.rs
@@ -0,0 +1,299 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Abstractions for the auxiliary bus.
+//!
+//! C header: [`include/linux/auxiliary_bus.h`](srctree/include/linux/auxiliary_bus.h)
+
+use crate::{
+    bindings, container_of, device,
+    device_id::RawDeviceId,
+    driver,
+    error::{to_result, Result},
+    prelude::*,
+    str::CStr,
+    types::{ARef, ForeignOwnable, Opaque},
+    ThisModule,
+};
+use core::{
+    convert::TryFrom,
+    marker::PhantomData,
+    ops::Deref,
+    ptr::{addr_of, addr_of_mut, NonNull},
+};
+
+/// An adapter for the registration of auxiliary drivers.
+pub struct Adapter<T: Driver>(T);
+
+// SAFETY: A call to `unregister` for a given instance of `RegType` is guaranteed to be valid if
+// a preceding call to `register` has been successful.
+unsafe impl<T: Driver + 'static> driver::RegistrationOps for Adapter<T> {
+    type RegType = bindings::auxiliary_driver;
+
+    unsafe fn register(
+        adrv: &Opaque<Self::RegType>,
+        name: &'static CStr,
+        module: &'static ThisModule,
+    ) -> Result {
+        // SAFETY: It's safe to set the fields of `struct auxiliary_driver` on initialization.
+        unsafe {
+            (*adrv.get()).name = name.as_char_ptr();
+            (*adrv.get()).probe = Some(Self::probe_callback);
+            (*adrv.get()).remove = Some(Self::remove_callback);
+            (*adrv.get()).id_table = T::ID_TABLE.as_ptr();
+        }
+
+        // SAFETY: `adrv` is guaranteed to be a valid `RegType`.
+        to_result(unsafe {
+            bindings::__auxiliary_driver_register(adrv.get(), module.0, name.as_char_ptr())
+        })
+    }
+
+    unsafe fn unregister(adrv: &Opaque<Self::RegType>) {
+        // SAFETY: `adrv` is guaranteed to be a valid `RegType`.
+        unsafe { bindings::auxiliary_driver_unregister(adrv.get()) }
+    }
+}
+
+impl<T: Driver + 'static> Adapter<T> {
+    extern "C" fn probe_callback(
+        adev: *mut bindings::auxiliary_device,
+        id: *const bindings::auxiliary_device_id,
+    ) -> core::ffi::c_int {
+        // SAFETY: The auxiliary bus only ever calls the probe callback with a valid pointer to a
+        // `struct auxiliary_device`.
+        //
+        // INVARIANT: `adev` is valid for the duration of `probe_callback()`.
+        let adev = unsafe { &*adev.cast::<Device<device::Core>>() };
+
+        // SAFETY: `DeviceId` is a `#[repr(transparent)` wrapper of `struct auxiliary_device_id` and
+        // does not add additional invariants, so it's safe to transmute.
+        let id = unsafe { &*id.cast::<DeviceId>() };
+        let info = T::ID_TABLE.info(id.index());
+
+        match T::probe(adev, info) {
+            Ok(data) => {
+                // Let the `struct auxiliary_device` own a reference of the driver's private data.
+                // SAFETY: By the type invariant `adev.as_raw` returns a valid pointer to a
+                // `struct auxiliary_device`.
+                unsafe { bindings::auxiliary_set_drvdata(adev.as_raw(), data.into_foreign()) };
+            }
+            Err(err) => return Error::to_errno(err),
+        }
+
+        0
+    }
+
+    extern "C" fn remove_callback(adev: *mut bindings::auxiliary_device) {
+        // SAFETY: The auxiliary bus only ever calls the remove callback with a valid pointer to a
+        // `struct auxiliary_device`.
+        let ptr = unsafe { bindings::auxiliary_get_drvdata(adev) };
+
+        // SAFETY: `remove_callback` is only ever called after a successful call to
+        // `probe_callback`, hence it's guaranteed that `ptr` points to a valid and initialized
+        // `KBox<T>` pointer created through `KBox::into_foreign`.
+        let _ = unsafe { KBox::<T>::from_foreign(ptr) };
+    }
+}
+
+/// Declares a kernel module that exposes a single auxiliary driver.
+#[macro_export]
+macro_rules! module_auxiliary_driver {
+    ($($f:tt)*) => {
+        $crate::module_driver!(<T>, $crate::auxiliary::Adapter<T>, { $($f)* });
+    };
+}
+
+/// Abstraction for `bindings::auxiliary_device_id`.
+#[repr(transparent)]
+#[derive(Clone, Copy)]
+pub struct DeviceId(bindings::auxiliary_device_id);
+
+impl DeviceId {
+    /// Create a new [`DeviceId`] from name.
+    pub const fn new(modname: &'static CStr, name: &'static CStr) -> Self {
+        let name = name.as_bytes_with_nul();
+        let modname = modname.as_bytes_with_nul();
+
+        // TODO: Replace with `bindings::auxiliary_device_id::default()` once stabilized for
+        // `const`.
+        //
+        // SAFETY: FFI type is valid to be zero-initialized.
+        let mut id: bindings::auxiliary_device_id = unsafe { core::mem::zeroed() };
+
+        let mut i = 0;
+        while i < modname.len() {
+            id.name[i] = modname[i];
+            i += 1;
+        }
+
+        // Reuse the space of the NULL terminator.
+        id.name[i - 1] = b'.';
+
+        let mut j = 0;
+        while j < name.len() {
+            id.name[i] = name[j];
+            i += 1;
+            j += 1;
+        }
+
+        Self(id)
+    }
+}
+
+// SAFETY:
+// * `DeviceId` is a `#[repr(transparent)` wrapper of `auxiliary_device_id` and does not add
+//   additional invariants, so it's safe to transmute to `RawType`.
+// * `DRIVER_DATA_OFFSET` is the offset to the `driver_data` field.
+unsafe impl RawDeviceId for DeviceId {
+    type RawType = bindings::auxiliary_device_id;
+
+    const DRIVER_DATA_OFFSET: usize =
+        core::mem::offset_of!(bindings::auxiliary_device_id, driver_data);
+
+    fn index(&self) -> usize {
+        self.0.driver_data
+    }
+}
+
+/// IdTable type for auxiliary drivers.
+pub type IdTable<T> = &'static dyn kernel::device_id::IdTable<DeviceId, T>;
+
+/// Create a auxiliary `IdTable` with its alias for modpost.
+#[macro_export]
+macro_rules! auxiliary_device_table {
+    ($table_name:ident, $module_table_name:ident, $id_info_type: ty, $table_data: expr) => {
+        const $table_name: $crate::device_id::IdArray<
+            $crate::auxiliary::DeviceId,
+            $id_info_type,
+            { $table_data.len() },
+        > = $crate::device_id::IdArray::new($table_data);
+
+        $crate::module_device_table!("auxiliary", $module_table_name, $table_name);
+    };
+}
+
+/// The auxiliary driver trait.
+///
+/// Drivers must implement this trait in order to get an auxiliary driver registered.
+pub trait Driver {
+    /// The type holding information about each device id supported by the driver.
+    ///
+    /// TODO: Use associated_type_defaults once stabilized:
+    ///
+    /// type IdInfo: 'static = ();
+    type IdInfo: 'static;
+
+    /// The table of device ids supported by the driver.
+    const ID_TABLE: IdTable<Self::IdInfo>;
+
+    /// Auxiliary driver probe.
+    ///
+    /// Called when a new auxiliary device is added or discovered. Implementers should attempt
+    /// to initialize the device here.
+    fn probe(dev: &Device<device::Core>, id_info: &Self::IdInfo) -> Result<Pin<KBox<Self>>>;
+}
+
+/// The auxiliary device representation.
+///
+/// This structure represents the Rust abstraction for a C `struct auxiliary_device`. The
+/// implementation abstracts the usage of an already existing C `struct auxiliary_device` within
+/// Rust code that we get passed from the C side.
+///
+/// # Invariants
+///
+/// A [`Device`] instance represents a valid `struct auxiliary_device` created by the C portion of
+/// the kernel.
+#[repr(transparent)]
+pub struct Device<Ctx: device::DeviceContext = device::Normal>(
+    Opaque<bindings::auxiliary_device>,
+    PhantomData<Ctx>,
+);
+
+impl Device {
+    fn as_raw(&self) -> *mut bindings::auxiliary_device {
+        self.0.get()
+    }
+
+    /// Returns the auxiliary device' id.
+    pub fn id(&self) -> u32 {
+        // SAFETY: By the type invariant `self.as_raw()` is a valid pointer to a
+        // `struct auxiliary_device`.
+        unsafe { (*self.as_raw()).id }
+    }
+}
+
+impl Deref for Device<device::Core> {
+    type Target = Device;
+
+    fn deref(&self) -> &Self::Target {
+        let ptr: *const Self = self;
+
+        // CAST: `Device<Ctx>` is a transparent wrapper of `Opaque<bindings::auxiliary_device>`.
+        let ptr = ptr.cast::<Device>();
+
+        // SAFETY: `ptr` was derived from `&self`.
+        unsafe { &*ptr }
+    }
+}
+
+impl From<&Device<device::Core>> for ARef<Device> {
+    fn from(dev: &Device<device::Core>) -> Self {
+        (&**dev).into()
+    }
+}
+
+// SAFETY: Instances of `Device` are always reference-counted.
+unsafe impl crate::types::AlwaysRefCounted for Device {
+    fn inc_ref(&self) {
+        // SAFETY: The existence of a shared reference guarantees that the refcount is non-zero.
+        unsafe { bindings::get_device(self.as_ref().as_raw()) };
+    }
+
+    unsafe fn dec_ref(obj: NonNull<Self>) {
+        // CAST: `Self` a transparent wrapper of `bindings::auxiliary_device`.
+        let adev: *mut bindings::auxiliary_device = obj.cast().as_ptr();
+
+        // SAFETY: By the type invariant of `Self`, `adev` is a pointer to a valid
+        // `struct auxiliary_device`.
+        let dev = unsafe { addr_of_mut!((*adev).dev) };
+
+        // SAFETY: The safety requirements guarantee that the refcount is non-zero.
+        unsafe { bindings::put_device(dev) }
+    }
+}
+
+impl AsRef<device::Device> for Device {
+    fn as_ref(&self) -> &device::Device {
+        // SAFETY: By the type invariant of `Self`, `self.as_raw()` is a pointer to a valid
+        // `struct auxiliary_device`.
+        let dev = unsafe { addr_of_mut!((*self.as_raw()).dev) };
+
+        // SAFETY: `dev` points to a valid `struct device`.
+        unsafe { device::Device::as_ref(dev) }
+    }
+}
+
+impl TryFrom<&device::Device> for &Device {
+    type Error = kernel::error::Error;
+
+    fn try_from(dev: &device::Device) -> Result<Self, Self::Error> {
+        if dev.bus_type_raw() != addr_of!(bindings::auxiliary_bus_type) {
+            return Err(EINVAL);
+        }
+
+        // SAFETY: We've just verified that the bus type of `dev` equals
+        // `bindings::auxiliary_bus_type`, hence `dev` must be embedded in a valid
+        // `struct auxiliary_device`.
+        let adev = unsafe { container_of!(dev.as_raw(), bindings::auxiliary_device, dev) };
+
+        // SAFETY: `adev` is a valid pointer to a `struct auxiliary_device`.
+        Ok(unsafe { &*adev.cast() })
+    }
+}
+
+// SAFETY: A `Device` is always reference-counted and can be released from any thread.
+unsafe impl Send for Device {}
+
+// SAFETY: `Device` can be shared among threads because all methods of `Device`
+// (i.e. `Device<Normal>) are thread safe.
+unsafe impl Sync for Device {}
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index 398242f92a96..d9a2ca9d1f20 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -36,6 +36,8 @@
 pub use ffi;
 
 pub mod alloc;
+#[cfg(CONFIG_AUXILIARY_BUS)]
+pub mod auxiliary;
 #[cfg(CONFIG_BLOCK)]
 pub mod block;
 #[doc(hidden)]
-- 
2.48.1


