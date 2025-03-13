Return-Path: <linux-kernel+bounces-558716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D4A1A5E9ED
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 03:25:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FF1B177BCC
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 02:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E65941547F5;
	Thu, 13 Mar 2025 02:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GoREUbwN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45BB214F104;
	Thu, 13 Mar 2025 02:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741832718; cv=none; b=Do8BSe7Xze+1wa0tHaT3IQlToAkQiMY9w8UOK3KTVtew2kY3HMYW3t1mcoybtPLxn/i/pJBTfPeRYTdLXugeFgntcqOqOMLvwjnHXTebNXFWjXSheFxBN7BM8uOotM92HMAXxX7oI/BEPIHyyQyGFNTKAKb9T99vPn47pxgGFD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741832718; c=relaxed/simple;
	bh=mRjn7t2jHMHtB96VgOXZtXcTYYnXiNhOPeFk/L6/47M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MrZeI3kK6WoZPlOEiDRP69dqHnACMNcBjhX1YAg+iMS1u6Ql5ah5QymKtGMYhqXo300Az6ONdo+71kuFdaHfW7p6TMKCiObPXniiswpFnlmOCQpek7ICBRNz7qdC6c61o1vqTX0L7vpYmRur8XzNCelA+sn5G4NEJt34V6Bcp2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GoREUbwN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C83B8C4CEED;
	Thu, 13 Mar 2025 02:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741832718;
	bh=mRjn7t2jHMHtB96VgOXZtXcTYYnXiNhOPeFk/L6/47M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GoREUbwN+wsBYSLOL+Z9nnauvNf0NQh2IgaCaS1s2LbAeJqyj1NgtD78sroKAOuqo
	 v/6SiTglJyWphx+VuMkEg7C+2qLdFRlc5/OgtWggAJapXkpRwu17Po8MjNs2jv/byb
	 xWRY7Cd3I4Ssp44f7fSto0ahEYYVlwKRhOSmExYMB2pZsmIyh8Bs6stMMHo0DznOQP
	 AbYwwnwkReUwP+NrkoZsPO8D6Pcl6YVHKoiYMC4bs69lm1+5dKfhhrt1tCWnpA5so2
	 2+ia4izMFoO4ueRjKlhyOCLTFmlp9MUpLLYe8epLCGw5mMLFvrFSmVucMPxUH0FmIQ
	 C5M3DVg2kg9/w==
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
Subject: [PATCH v2 3/4] rust: auxiliary: add auxiliary registration
Date: Thu, 13 Mar 2025 03:23:52 +0100
Message-ID: <20250313022454.147118-4-dakr@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250313022454.147118-1-dakr@kernel.org>
References: <20250313022454.147118-1-dakr@kernel.org>
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
index e453f821f7cb..fc4bb5388a9b 100644
--- a/rust/kernel/auxiliary.rs
+++ b/rust/kernel/auxiliary.rs
@@ -5,7 +5,7 @@
 //! C header: [`include/linux/auxiliary_bus.h`](srctree/include/linux/auxiliary_bus.h)
 
 use crate::{
-    bindings, device,
+    bindings, container_of, device,
     device_id::RawDeviceId,
     driver,
     error::{to_result, Result},
@@ -219,6 +219,16 @@ pub fn id(&self) -> u32 {
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
 
 impl Deref for Device<device::Core> {
@@ -265,3 +275,71 @@ fn as_ref(&self) -> &device::Device {
         unsafe { device::Device::as_ref(dev) }
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


