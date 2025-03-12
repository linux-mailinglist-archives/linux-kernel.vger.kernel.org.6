Return-Path: <linux-kernel+bounces-557105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9645DA5D3BE
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 01:28:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30198172F66
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 00:28:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B81EB1519A0;
	Wed, 12 Mar 2025 00:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VBiBzxNs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03ED11482F2;
	Wed, 12 Mar 2025 00:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741739290; cv=none; b=fHmLpdpOe32gD75fyGpHWVy31z3btmr5eeoq/gojIZhohIaMQ+aRu/+715OdoTAUet73KFRX8qamWptJPRLVi9xkvX8J81a5Z1D+v95Src+KNjicAlixwU6C7WiGpVci+3ItJ66vO6HpGcPbcFm/sZEHUa4qvJwzdz34RVSqMsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741739290; c=relaxed/simple;
	bh=vSGacgpTJ7Vf5exs6CcFX/ptRjtp9i/3KpX9vrs1jF0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BMC6mdKvnGXTWmtxwESySR8Z2I1soMkNLxN03UXIzYa10xx+Dk0QRBSMxootr/VRkOmL9+wmY8vy3gnEdpzJPFqoXDK/i5GOhPVjwwNnX/tnzS/rK8GuiqGyO3ZD3/3T018G0P4Kzp8BUEbyERhdecgr4UtKChJ04/NBu7HD9zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VBiBzxNs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 100B2C4CEEC;
	Wed, 12 Mar 2025 00:28:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741739289;
	bh=vSGacgpTJ7Vf5exs6CcFX/ptRjtp9i/3KpX9vrs1jF0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VBiBzxNslj4A62V+LehQs3TBaG2etiX6nUnzx0ddGX3S/qdw427qXKHbJvYfknkqa
	 Vx3fReuhaDIHTSA6zAojqVTi+OfZ//++kzV6LtDtpmEGstr5sY9nLCwjCSOXwB+2zU
	 gP4xRCA/wqVdIHbS7/tUJaaYXx8qVhxLUeSAOQkgXufLDZhTu2HssV7OdjBiDYYXtx
	 1DLiMtuMHcskGy/i/vUC+EWFOQ4QQ4airtAiq3xM6s8+lDa61LO0ItSfaxwMPouN6H
	 AyZaPfH3v6U77UQJnjGrBpGU6kceXrmxlf/sqzRIN/O/nuWqtfD++nycCRb0jBrDLI
	 NyfP3dZYq+GCw==
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
Subject: [PATCH 3/4] rust: auxiliary: add auxiliary registration
Date: Wed, 12 Mar 2025 01:19:09 +0100
Message-ID: <20250312002741.453350-4-dakr@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250312002741.453350-1-dakr@kernel.org>
References: <20250312002741.453350-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement the `auxiliary::Registration` type, which provides an API to
create and register new auxiliary devices in the system.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/auxiliary.rs | 80 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 79 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/auxiliary.rs b/rust/kernel/auxiliary.rs
index 3bdd690990aa..275dffc64a02 100644
--- a/rust/kernel/auxiliary.rs
+++ b/rust/kernel/auxiliary.rs
@@ -14,7 +14,7 @@
     types::{ARef, ForeignOwnable, Opaque},
     ThisModule,
 };
-use core::ptr::addr_of_mut;
+use core::ptr::{addr_of_mut, NonNull};
 
 /// An adapter for the registration of auxiliary drivers.
 pub struct Adapter<T: Driver>(T);
@@ -224,6 +224,16 @@ pub fn id(&self) -> u32 {
         // `struct auxiliary_device`.
         unsafe { (*self.as_raw()).id }
     }
+
+    extern "C" fn release(dev: *mut bindings::device) {
+        // SAFETY: By the type invariant `self.0.as_raw` is a pointer to the `struct device`
+        // embedded in `struct auxiliary_device`.
+        let adev = unsafe { container_of!(dev, bindings::auxiliary_device, dev) }.cast_mut();
+
+        // SAFETY: `adev` points to the memory that has been allocated in `Registration::new`, via
+        // `KBox::new(Opaque::<bindings::auxiliary_device>::zeroed(), GFP_KERNEL)`.
+        let _ = unsafe { KBox::<Opaque<bindings::auxiliary_device>>::from_raw(adev.cast()) };
+    }
 }
 
 impl AsRef<device::Device> for Device {
@@ -231,3 +241,71 @@ fn as_ref(&self) -> &device::Device {
         &self.0
     }
 }
+
+/// The registration of an auxiliary device.
+///
+/// This type represents the registration of a [`struct auxiliary_device`]. When an instance of this
+/// type is dropped, its respective auxiliary device will be unregistered from the system.
+///
+/// # Invariants
+///
+/// `self.0` always holds a valid pointer to an initialized and registered
+/// [`struct auxiliary_device`].
+pub struct Registration(NonNull<bindings::auxiliary_device>);
+
+impl Registration {
+    /// Create and register a new auxiliary device.
+    pub fn new(parent: &device::Device, name: &CStr, id: u32, modname: &CStr) -> Result<Self> {
+        let boxed = KBox::new(Opaque::<bindings::auxiliary_device>::zeroed(), GFP_KERNEL)?;
+        let adev = boxed.get();
+
+        // SAFETY: It's safe to set the fields of `struct auxiliary_device` on initialization.
+        unsafe {
+            (*adev).dev.parent = parent.as_raw();
+            (*adev).dev.release = Some(Device::release);
+            (*adev).name = name.as_char_ptr();
+            (*adev).id = id;
+        }
+
+        // SAFETY: `adev` is guaranteed to be a valid pointer to a `struct auxiliary_device`,
+        // which has not been initialized yet.
+        unsafe { bindings::auxiliary_device_init(adev) };
+
+        // Now that `adev` is initialized, leak the `Box`; the corresponding memory will be freed
+        // by `Device::release` when the last reference to the `struct auxiliary_device` is dropped.
+        let _ = KBox::into_raw(boxed);
+
+        // SAFETY:
+        // - `adev` is guaranteed to be a valid pointer to a `struct auxiliary_device`, which has
+        //   been initialialized,
+        // - `modname.as_char_ptr()` is a NULL terminated string.
+        let ret = unsafe { bindings::__auxiliary_device_add(adev, modname.as_char_ptr()) };
+        if ret != 0 {
+            // SAFETY: `adev` is guaranteed to be a valid pointer to a `struct auxiliary_device`,
+            // which has been initialialized.
+            unsafe { bindings::auxiliary_device_uninit(adev) };
+
+            return Err(Error::from_errno(ret));
+        }
+
+        // SAFETY: `adev` is guaranteed to be non-null, since the `KBox` was allocated successfully.
+        //
+        // INVARIANT: The device will remain registered until `auxiliary_device_delete()` is called,
+        // which happens in `Self::drop()`.
+        Ok(Self(unsafe { NonNull::new_unchecked(adev) }))
+    }
+}
+
+impl Drop for Registration {
+    fn drop(&mut self) {
+        // SAFETY: By the type invariant of `Self`, `self.0.as_ptr()` is a valid registered
+        // `struct auxiliary_device`.
+        unsafe { bindings::auxiliary_device_delete(self.0.as_ptr()) };
+
+        // This drops the reference we acquired through `auxiliary_device_init()`.
+        //
+        // SAFETY: By the type invariant of `Self`, `self.0.as_ptr()` is a valid registered
+        // `struct auxiliary_device`.
+        unsafe { bindings::auxiliary_device_uninit(self.0.as_ptr()) };
+    }
+}
-- 
2.48.1


