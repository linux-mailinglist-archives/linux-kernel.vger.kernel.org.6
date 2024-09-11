Return-Path: <linux-kernel+bounces-325123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E50A9975543
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 16:28:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FB1A1C226EE
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 14:28:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 484F619F12F;
	Wed, 11 Sep 2024 14:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=beagleboard-org.20230601.gappssmtp.com header.i=@beagleboard-org.20230601.gappssmtp.com header.b="xAQcDEpZ"
Received: from mail-pj1-f68.google.com (mail-pj1-f68.google.com [209.85.216.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 667C919E973
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 14:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726064877; cv=none; b=i1+MjlJ4GrPxq/NoBMEy16VXo/REuxPA4WZQPg9+dQhweeikPUtGpOxTyNEQX/ivHQs7Ya/CQ2qedeWfirPC5OENKYGZ3Kut5HQ+LcKACo8vCsew5WlZFu+RrKCMcYoRfC2n6wrTVY6MxCevpn8vZwC8+FEG6NsGFG1lb4IJRE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726064877; c=relaxed/simple;
	bh=lKm/kwthrWk+of54TAxNb7rE2mtE7ZvfrrXhQMNpFmY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CshnavFBG714IAx0yZS8qT6Aa0rZ/7sASQRWifXyjHvK6aHYQ7K9BZKxUx5r12Dwm81rgiS/qhTJLpF7IIO888fb5B8+s3v4blZ8T5jz6ACrkmxIXjzPopXCRrUzwOml6nVzgYyOlcqbVGthkVCejgAFGqPlh34GAjdfnMt214s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=beagleboard.org; spf=fail smtp.mailfrom=beagleboard.org; dkim=pass (2048-bit key) header.d=beagleboard-org.20230601.gappssmtp.com header.i=@beagleboard-org.20230601.gappssmtp.com header.b=xAQcDEpZ; arc=none smtp.client-ip=209.85.216.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=beagleboard.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=beagleboard.org
Received: by mail-pj1-f68.google.com with SMTP id 98e67ed59e1d1-2d89229ac81so5392063a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 07:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=beagleboard-org.20230601.gappssmtp.com; s=20230601; t=1726064875; x=1726669675; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YOaH7wUDUVg3jrdLcJDpY4x/GyOxkGNywptNXtNYkIM=;
        b=xAQcDEpZfPCJIskIYUbFYT0Y0Ahj3NehbB2eQsJR/wbTvfcyMEKIsrF8SXS5aJxjZl
         1gHkTww9T1rr7wFNGBz6nO8gRcv7iE4hS8qmvdePYy1LFbAEVqGM1D/kC8cwrkqv5ksb
         eLtNxaeWgbDn+d03IbXuAMNP0MDBZAJ5u0tGrrIi0x+ywX+Pqd2fenn4hbi0ROv3r3De
         ZOlb2GxxKUFoNNTKVF2RDz4GRT4I7sr+zsX+Pub4H9EOuHI6qWeesx5nNL9jio+xfF2Z
         aBwQRCh3JM06VYOGNhZBG4G+ba8lp/esvsdaftY2XjUqredHSh1WGiswgxprg51nEg9w
         bXoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726064875; x=1726669675;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YOaH7wUDUVg3jrdLcJDpY4x/GyOxkGNywptNXtNYkIM=;
        b=C3ZIeX8dao3icAdep+5zelZuuZinzlPGylDUsr+eQqC+xPi2vR5rOBTuNvwMPM19YU
         yXhiu9tKLIikiCcdXi+gAJjsoJd9MrcMDwXEPGScddNhfvTVeA/hOBnQXy7nuRWxmSbY
         8QwZ9XP0NbsHqTwGpFiBAAMOKEe5xBBRF3Bmzm2DM7luiXOSSXrFvSn2zZRz/DAVnr0e
         tBRGwRf3zno1Mg1BQI/qsBR0dlujaVosg024u3lz6QvySiDuXwntNuCLqF5PGixJkIhT
         FWGYia+fjxW1af+5h2Rk8hfdXG63FyX3EC/MKajTDouSfquySHAI+QhIgJqix+hF10fO
         9Nug==
X-Gm-Message-State: AOJu0YwUbXMn3QIdVU6P8lTOtVaG7Kg8CVcoM8sXgwTAr3iAjFGVI8e4
	7WkhiRvzo4CD6M5yT6glbezvPYjdGZ1OJ78KtcCNVmoAc7LBey9B8FY1HSCglA==
X-Google-Smtp-Source: AGHT+IETD8NcWXEwrzRI7PfUQkX1aQcbeJI3Z+n8OukCsjjngyEPaWbX125rUDAAT6JvWnPjmRzDnw==
X-Received: by 2002:a17:90a:8a15:b0:2d8:99c4:3cd9 with SMTP id 98e67ed59e1d1-2dad4de1392mr20248004a91.3.1726064874446;
        Wed, 11 Sep 2024 07:27:54 -0700 (PDT)
Received: from [172.16.118.100] ([103.15.228.94])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2dadbfe46c9sm10639116a91.11.2024.09.11.07.27.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 07:27:54 -0700 (PDT)
From: Ayush Singh <ayush@beagleboard.org>
Date: Wed, 11 Sep 2024 19:57:18 +0530
Subject: [PATCH 1/8] rust: kernel: Add Platform device and driver
 abstractions
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240911-mikrobus-dt-v1-1-3ded4dc879e7@beagleboard.org>
References: <20240911-mikrobus-dt-v1-0-3ded4dc879e7@beagleboard.org>
In-Reply-To: <20240911-mikrobus-dt-v1-0-3ded4dc879e7@beagleboard.org>
To: fabien.parent@linaro.org, d-gole@ti.com, lorforlinux@beagleboard.org, 
 jkridner@beagleboard.org, robertcnelson@beagleboard.org, 
 Andrew Davis <afd@ti.com>, Miguel Ojeda <ojeda@kernel.org>, 
 Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <benno.lossin@proton.me>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Derek Kiernan <derek.kiernan@amd.com>, 
 Dragan Cvetic <dragan.cvetic@amd.com>, Arnd Bergmann <arnd@arndb.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Nishanth Menon <nm@ti.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Ayush Singh <ayush@beagleboard.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=14880;
 i=ayush@beagleboard.org; h=from:subject:message-id;
 bh=zkzVPkQfS9LodBPXtJMr2bHYTVhX/BFEg3r5ta8DpxE=;
 b=owEBbQKS/ZANAwAIAQXO9ceJ5Vp0AcsmYgBm4ajV037slacrW67oDDENCopdqoaSn9E7y3hl3
 pM9wPh0T8KJAjMEAAEIAB0WIQTfzBMe8k8tZW+lBNYFzvXHieVadAUCZuGo1QAKCRAFzvXHieVa
 dOYHD/wN0sTYbOCHvDxME4ZMoLGPRMqCTb20jASqA7kv2/98kyksK6fRt57d8xDjMebjJEMTP2o
 zSUbg2hJ+S1vJVaMOMR23MciQnzUZ46EBrYvobIUEsjnmXp2luajua1SbR99DuYEI7Gh99byLhX
 CUE4z6eqjEVsjp9LPaJjFlRKPm1dG77PJQMGBWh1RRUT6xEwDN5kcPjjfPQCVV2mo+KAMPXeLDp
 bHYVYpcmt+Vk89jH0Qq9hD4/knDp9Eoid/hmz6/0lsP1Ia6IVScDsJP1CQNb9x9yPHG7BNkxef6
 0tdPDnETf636G4efv0UuuoFpfq4lm7txZBWJgnqdvmQmYLQjmVrdr0TRA22sNX6htvIB2jhPLn1
 niVYpkJjvpRlHw1F8oWzrVExalYu5tbVwlQdo4JVjnQO7Lywl2pDrL3CDxr06C2Sw4ZOXMnscdc
 SP9jBNLq2fHQUxGSuK6lXEdNfuHQ3nWc3T6/MYIL6NOviYOMZjPc+kHRl8nv48DpYha/Uy/ISBx
 A2Y92b5KeXXXtOcU4ElbvLOTLxWU7PoKRka6xzF/0OVmIj2sNPZSkIIajHjEAcYmel6/XjDW3PR
 ovh7Qj2JLU05teSMqCNe8yb2W7H4zmlTf31BvjMfjJ4mwcNX8zfRf3XQ86XGNbM+wdP3eEhIWww
 re7PSfNtMph7Esw==
X-Developer-Key: i=ayush@beagleboard.org; a=openpgp;
 fpr=DFCC131EF24F2D656FA504D605CEF5C789E55A74

From: Fabien Parent <fabien.parent@linaro.org>

Ports Platform device and driver abstractions from Fabien's tree [0].

These abstractions do not depend on any generic driver registration and
id table. Instead, the minimal abstractions have been implemented
specifically for platform subsystem taking heavy inspiration from the
existing phy device and driver abstractions.

[0]: https://github.com/Fabo/linux/commits/fparent/rust-platform

Signed-off-by: Fabien Parent <fabien.parent@linaro.org>
Signed-off-by: Ayush Singh <ayush@beagleboard.org>
---
 rust/bindings/bindings_helper.h |   1 +
 rust/kernel/lib.rs              |   1 +
 rust/kernel/platform.rs         | 380 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 382 insertions(+)

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index ae82e9c941af..10cbcdd74089 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -16,6 +16,7 @@
 #include <linux/jiffies.h>
 #include <linux/mdio.h>
 #include <linux/phy.h>
+#include <linux/platform_device.h>
 #include <linux/refcount.h>
 #include <linux/sched.h>
 #include <linux/slab.h>
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index b5f4b3ce6b48..b3a318fde46c 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -42,6 +42,7 @@
 #[cfg(CONFIG_NET)]
 pub mod net;
 pub mod page;
+pub mod platform;
 pub mod prelude;
 pub mod print;
 pub mod rbtree;
diff --git a/rust/kernel/platform.rs b/rust/kernel/platform.rs
new file mode 100644
index 000000000000..de28429f5551
--- /dev/null
+++ b/rust/kernel/platform.rs
@@ -0,0 +1,380 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Platform devices and drivers.
+//!
+//! Also called `platformdev`, `pdev`.
+//!
+//! C header: [`include/linux/platform_device.h`](../../../../include/linux/platform_device.h)
+
+use core::{marker::PhantomData, pin::Pin, ptr::addr_of_mut};
+
+use macros::vtable;
+
+use crate::{
+    bindings, device,
+    error::{from_result, Result},
+    str::CStr,
+    types::Opaque,
+};
+
+/// A platform device.
+///
+/// # Invariants
+///
+/// The field `ptr` is non-null and valid for the lifetime of the object.
+#[repr(transparent)]
+pub struct Device(Opaque<bindings::platform_device>);
+
+impl Device {
+    /// Creates a new [`Device`] instance from a raw pointer.
+    ///
+    /// # Safety
+    ///
+    /// For the duration of `'a`,
+    /// - the pointer must point at a valid `platform_device`, and the caller
+    ///   must be in a context where all methods defined on this struct
+    ///   are safe to call.
+    unsafe fn from_raw<'a>(ptr: *mut bindings::platform_device) -> &'a mut Self {
+        // CAST: `Self` is a `repr(transparent)` wrapper around `bindings::platform_device`.
+        let ptr = ptr.cast::<Self>();
+        // SAFETY: by the function requirements the pointer is valid and we have unique access for
+        // the duration of `'a`.
+        unsafe { &mut *ptr }
+    }
+
+    /// Returns id of the platform device.
+    pub fn id(&self) -> i32 {
+        let platformdev = self.0.get();
+        // SAFETY: By the type invariants, we know that `self.ptr` is non-null and valid.
+        unsafe { (*platformdev).id }
+    }
+}
+
+impl AsRef<device::Device> for Device {
+    fn as_ref(&self) -> &device::Device {
+        let platformdev = self.0.get();
+        // SAFETY: By the type invariants, we know that `self.ptr` is non-null and valid.
+        unsafe { device::Device::as_ref(addr_of_mut!((*platformdev).dev)) }
+    }
+}
+
+/// An adapter for the registration of a Platform driver.
+struct Adapter<T: Driver> {
+    _p: PhantomData<T>,
+}
+
+impl<T: Driver> Adapter<T> {
+    /// # Safety
+    ///
+    /// `pdev` must be passed by the corresponding callback in `platform_driver`.
+    unsafe extern "C" fn probe_callback(pdev: *mut bindings::platform_device) -> core::ffi::c_int {
+        from_result(|| {
+            // SAFETY: This callback is called only in contexts
+            // where we can exclusively access `platform_device` because
+            // it's not published yet, so the accessors on `Device` are okay
+            // to call.
+            let dev = unsafe { Device::from_raw(pdev) };
+            T::probe(dev)?;
+            Ok(0)
+        })
+    }
+
+    /// # Safety
+    ///
+    /// `pdev` must be passed by the corresponding callback in `platform_driver`.
+    unsafe extern "C" fn remove_callback(pdev: *mut bindings::platform_device) {
+        // SAFETY: This callback is called only in contexts
+        // where we can exclusively access `platform_device` because
+        // it's not published yet, so the accessors on `Device` are okay
+        // to call.
+        let dev = unsafe { Device::from_raw(pdev) };
+        T::remove(dev);
+    }
+}
+
+/// Driver structure for a particular Platform driver.
+///
+/// Wraps the kernel's [`struct platform_driver`].
+/// This is used to register a driver for a particular PHY type with the kernel.
+///
+/// # Invariants
+///
+/// `self.0` is always in a valid state.
+///
+/// [`struct platform_driver`]: srctree/include/linux/platform.h
+#[repr(transparent)]
+pub struct DriverVTable(Opaque<bindings::platform_driver>);
+
+// SAFETY: `DriverVTable` doesn't expose any &self method to access internal data, so it's safe to
+// share `&DriverVTable` across execution context boundaries.
+unsafe impl Sync for DriverVTable {}
+
+impl DriverVTable {
+    /// Creates a [`DriverVTable`] instance from [`Driver`].
+    ///
+    /// This is used by [`module_platform_driver`] macro to create a static array of `phy_driver`.
+    ///
+    /// [`module_platform_driver`]: crate::module_platform_driver
+    pub const fn new<T: Driver, const C: usize>(match_tbl: &'static DeviceIdTable<C>) -> Self {
+        let drv = Opaque::new(bindings::platform_driver {
+            probe: if T::HAS_PROBE {
+                Some(Adapter::<T>::probe_callback)
+            } else {
+                None
+            },
+            __bindgen_anon_1: bindings::platform_driver__bindgen_ty_1 {
+                remove: if T::HAS_REMOVE {
+                    Some(Adapter::<T>::remove_callback)
+                } else {
+                    None
+                },
+            },
+            driver: create_device_driver::<T, C>(match_tbl),
+            // SAFETY: The rest is zeroed out to initialize `struct platform_driver`.
+            ..unsafe { core::mem::MaybeUninit::<bindings::platform_driver>::zeroed().assume_init() }
+        });
+
+        DriverVTable(drv)
+    }
+}
+
+const fn create_device_driver<T: Driver, const C: usize>(
+    match_tbl: &'static DeviceIdTable<C>,
+) -> bindings::device_driver {
+    bindings::device_driver {
+        name: T::NAME.as_char_ptr(),
+        of_match_table: match_tbl.get(),
+        // SAFETY: The rest is zeroed out to initialize `struct device_driver`.
+        ..unsafe { core::mem::MaybeUninit::<bindings::device_driver>::zeroed().assume_init() }
+    }
+}
+
+/// A platform driver.
+#[vtable]
+pub trait Driver {
+    /// The friendly name
+    const NAME: &'static CStr;
+
+    /// Sets up device-specific structures during discovery.
+    fn probe(_dev: &mut Device) -> Result;
+
+    /// Clean up device-specific structures during removal.
+    fn remove(_dev: &mut Device);
+}
+
+/// Registration structure for Platform driver.
+///
+/// Registers [`DriverVTable`] instance with the kernel. It will be unregistered when dropped.
+///
+/// # Invariants
+///
+/// The `driver` is currently registered to the kernel via `__platform_driver_register`.
+pub struct Registration(Pin<&'static DriverVTable>);
+
+// SAFETY: The only action allowed in a `Registration` instance is dropping it, which is safe to do
+// from any thread because `platform_drivers_unregister` can be called from any thread context.
+unsafe impl Send for Registration {}
+
+impl Registration {
+    /// Registers a Platform driver.
+    pub fn new(drv: Pin<&'static DriverVTable>, m: &'static crate::ThisModule) -> Registration {
+        unsafe {
+            bindings::__platform_driver_register(drv.0.get(), m.0);
+        }
+
+        Self(drv)
+    }
+}
+
+impl Drop for Registration {
+    fn drop(&mut self) {
+        unsafe { bindings::platform_driver_unregister(self.0 .0.get()) }
+    }
+}
+
+/// An identifier for Platform devices.
+///
+/// Represents the kernel's [`struct of_device_id`]. This is used to find an appropriate
+/// Platform driver.
+///
+/// [`struct of_device_id`]: srctree/include/linux/mod_devicetable.h
+pub struct DeviceId(&'static CStr);
+
+impl DeviceId {
+    /// A zeroed [`struct of_device_id`] used to signify end of of_device_id array.
+    ///
+    /// [`struct of_device_id`]: srctree/include/linux/mod_devicetable.h
+    pub const ZERO: bindings::of_device_id = bindings::of_device_id {
+        // SAFETY: The rest is zeroed out to initialize `struct of_device_id`.
+        ..unsafe { core::mem::MaybeUninit::<bindings::of_device_id>::zeroed().assume_init() }
+    };
+
+    /// Create new instance
+    pub const fn new(s: &'static CStr) -> Self {
+        Self(s)
+    }
+
+    const fn compatible(&self) -> [i8; 128] {
+        let compatible = self.0.as_bytes_with_nul();
+        let mut comp = [0i8; 128];
+        let mut i = 0;
+
+        while i < compatible.len() {
+            comp[i] = compatible[i] as _;
+            i += 1;
+        }
+
+        comp
+    }
+
+    // macro use only
+    #[doc(hidden)]
+    pub const fn to_rawid(&self) -> bindings::of_device_id {
+        let comp = self.compatible();
+
+        bindings::of_device_id {
+            compatible: comp,
+            // SAFETY: The rest is zeroed out to initialize `struct of_device_id`.
+            ..unsafe { core::mem::MaybeUninit::<bindings::of_device_id>::zeroed().assume_init() }
+        }
+    }
+}
+
+/// An array of identifiers for platform driver
+#[repr(transparent)]
+pub struct DeviceIdTable<const C: usize>([bindings::of_device_id; C]);
+
+impl<const C: usize> DeviceIdTable<C> {
+    /// Create a new instance
+    pub const fn new(ids: [bindings::of_device_id; C]) -> Self {
+        Self(ids)
+    }
+
+    /// Returns a raw pointer to static table.
+    pub const fn get(&'static self) -> *const bindings::of_device_id {
+        self.0.as_ptr()
+    }
+}
+
+// SAFETY: `DeviceIdTable` is only used in C side behind a *const pointer, and thus remains
+// immutable and thus can be shared across execution context boundaries.
+unsafe impl<const C: usize> Sync for DeviceIdTable<C> {}
+
+/// Declares a kernel module for Platform drivers.
+///
+/// This creates a static [`struct platform_driver`] and registers it. It also creates an array of
+/// [`struct of_device_id`] for matching the driver to devicetree device.
+///
+/// [`struct platform_driver`]: srctree/include/linux/platform.h
+/// [`struct of_device_id`]: srctree/include/linux/mod_devicetable.h
+///
+/// # Examples
+///
+/// ```
+/// # mod module_platform_driver_sample {
+/// use kernel::c_str;
+/// use kernel::platform::{self, DeviceId};
+/// use kernel::prelude::*;
+///
+/// kernel::module_platform_driver! {
+///     driver: PlatformSimple,
+///     of_table: [DeviceId::new(c_str!("platform-simple"))],
+///     name: "rust_sample_platform",
+///     author: "Rust for Linux Contributors",
+///     description: "Rust sample Platform driver",
+///     license: "GPL",
+/// }
+///
+/// struct PlatformSimple;
+///
+/// #[vtable]
+/// impl platform::Driver for PlatformSimple {
+///     const NAME: &'static CStr = c_str!("PlatformSimple");
+/// }
+/// # }
+/// ```
+///
+/// This expands to the following code:
+///
+/// ```ignore
+/// use kernel::c_str;
+/// use kernel::platform::{self, DeviceId};
+/// use kernel::prelude::*;
+///
+///
+/// struct Module {
+///     _reg: $crate::platform::Registration,
+/// }
+///
+/// module! {
+///     type: Module,
+///     name: "rust_sample_platform",
+///     author: "Rust for Linux Contributors",
+///     description: "Rust sample Platform driver",
+///     license: "GPL",
+/// }
+///
+/// const _: () = {
+///     static OF_TABLE: $crate::platform::DeviceIdTable = $crate::platform::DeviceIdTable<2>([
+///         (DeviceId::new(c_str!("platform-simple"))).to_rawid(),
+///         $crate::platform::DeviceId::ZERO,
+///     ]);
+///     static DRIVER: $crate::platform::DriverVTable =
+///         $crate::platform::DriverVTable::new::<MikrobusDriver, 2>(&OF_TABLE);
+///     impl $crate::Module for Module {
+///         fn init(module: &'static ThisModule) -> Result<Self> {
+///             let reg =
+///                 $crate::platform::Registration::new(
+///                     ::core::pin::Pin::static_ref(&DRIVER), module);
+///             Ok(Module { _reg: reg })
+///         }
+///     }
+/// }
+///
+/// struct PlatformSimple;
+///
+/// #[vtable]
+/// impl platform::Driver for PlatformSimple {
+///     const NAME: &'static CStr = c_str!("PlatformSimple");
+/// }
+/// ```
+#[macro_export]
+macro_rules! module_platform_driver {
+    (@replace_expr $_t:tt $sub:expr) => {$sub};
+
+    (@count_devices $($x:expr),*) => {
+        0usize $(+ $crate::module_platform_driver!(@replace_expr $x 1usize))*
+    };
+
+    (driver: $driver:ident, of_table: [$($of_id:expr),+ $(,)?], $($f:tt)*) => {
+        struct Module {
+            _reg: $crate::platform::Registration,
+        }
+
+        $crate::prelude::module! {
+            type: Module,
+            $($f)*
+        }
+
+        const _: () = {
+            // SAFETY: C will not read off the end of this constant since the last element is zero.
+            static OF_TABLE: $crate::platform::DeviceIdTable<
+                {$crate::module_platform_driver!(@count_devices $($of_id),+) + 1} > =
+                $crate::platform::DeviceIdTable::new(
+                    [$($of_id.to_rawid()),*, $crate::platform::DeviceId::ZERO]);
+
+            static DRIVER: $crate::platform::DriverVTable =
+                $crate::platform::DriverVTable::new::<
+                    $driver, {$crate::module_platform_driver!(@count_devices $($of_id),+) + 1}
+                >(&OF_TABLE);
+
+            impl $crate::Module for Module {
+                fn init(module: &'static ThisModule) -> Result<Self> {
+                    let reg = $crate::platform::Registration::new(
+                        ::core::pin::Pin::static_ref(&DRIVER), module);
+                    Ok(Module { _reg: reg })
+                }
+            }
+        };
+    };
+}

-- 
2.46.0


