Return-Path: <linux-kernel+bounces-568768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6810BA69A3E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 21:36:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3ABBA981B3A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 20:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F4D421A44C;
	Wed, 19 Mar 2025 20:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jD/7F8qb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56CCF219E93;
	Wed, 19 Mar 2025 20:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742416516; cv=none; b=Lo0DF3ZhlIPFNkR0qDEIS3LZYvapLNDK+6XIskWbOFC5YwiTQXAQX9joX0iAPL+UFruJXdSmhlyVuq1GCy7rDrnCjBYcWrBjIC6L56e4wFDYfC4obh+ZKgCF6McylIIM6gRM21xoce1EESbj4oz5+2Tyeo9ALx+k6HTTDTu1xRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742416516; c=relaxed/simple;
	bh=q6o/iQcyfsiCVyTovpMftSB8oe4JG/TbhOJ0ASGnH1c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CaeMqG3JFVVaOqeiI3LrNz3rezLFOle+ZziVSLqHDeVWXLZH4Ty3p+gqGDVJ6qz9TckqZx7To5/qRHeFwJfzGoY8LIYKvR6sMlt9I45RSwDqp5TDBdfhEftIJTe7glGDHZDyXqhOnh5lYGEMBE48//xmZZWJ6RSAAuPwtTyK67c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jD/7F8qb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 926E8C4CEEC;
	Wed, 19 Mar 2025 20:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742416515;
	bh=q6o/iQcyfsiCVyTovpMftSB8oe4JG/TbhOJ0ASGnH1c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jD/7F8qbLouHwfN1DpcYjZIvdUQBNzK1sg2zzgAS0VOdP9bsU2Nbvu7/8W0inYuyM
	 D0K4CMBIbLggC8A3qjjqYxJnvNfNxRIcxoVsnN3k/1d3n6WupE7to+kPevDg+Zkd4U
	 NvHE6DF68LVeqp8P7Ru+Iq+h4AU+kNpa16f8l9djuWykDlxtW6jE77EnduXvWnXYKq
	 AaMDnD6fY4w5MNMc6ErmhC/K5p39RxlBgsONa1EPo2XodwcjUtjrNZCEALD6ssRFXt
	 s00FjLfwmx4cT88pP8SvMcEeq8pDuba3DpldgDleSFNO9Pb0y3GRIGWSofT2MjnILu
	 DWSoWZlDhjW/A==
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
Subject: [PATCH v3 4/5] rust: auxiliary: add auxiliary registration
Date: Wed, 19 Mar 2025 21:33:56 +0100
Message-ID: <20250319203455.132539-5-dakr@kernel.org>
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

Implement the `auxiliary::Registration` type, which provides an API to
create and register new auxiliary devices in the system.

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/auxiliary.rs | 84 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 84 insertions(+)

diff --git a/rust/kernel/auxiliary.rs b/rust/kernel/auxiliary.rs
index 1b8015bfca3e..ff69fde760d8 100644
--- a/rust/kernel/auxiliary.rs
+++ b/rust/kernel/auxiliary.rs
@@ -220,6 +220,16 @@ pub fn id(&self) -> u32 {
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
@@ -297,3 +307,77 @@ unsafe impl Send for Device {}
 // SAFETY: `Device` can be shared among threads because all methods of `Device`
 // (i.e. `Device<Normal>) are thread safe.
 unsafe impl Sync for Device {}
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
+
+// SAFETY: A `Registration` of a `struct auxiliary_device` can be released from any thread.
+unsafe impl Send for Registration {}
+
+// SAFETY: `Registration` does not expose any methods or fields that need synchronization.
+unsafe impl Sync for Registration {}
-- 
2.48.1


