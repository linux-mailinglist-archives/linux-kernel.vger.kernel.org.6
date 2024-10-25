Return-Path: <linux-kernel+bounces-382652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 138BC9B1179
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 23:10:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7703AB20AED
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 21:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67E5421C2EB;
	Fri, 25 Oct 2024 21:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xc39/tj7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 907A621C2CB;
	Fri, 25 Oct 2024 21:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729890369; cv=none; b=VpysDHUzUQLESubNIs3NFAZq114MSrc0+4MVojlLfiWfi20lsd1w6WAorxjh6UliaLHHHbcreuj+EHL3D7ToTrZCnmWLMat74RGJ/eFz8IV2xToReynYyE2bJMwR8Ev579jC9YQTWbTaXpXWEIJ0EmnTgAOtQm8Jp5k/njMsOaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729890369; c=relaxed/simple;
	bh=MTv3LxsYyRYwz6lTAAdJU1iMPfscHo0zUbDJdr9/tPE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nQ65oF98wDFpjd4cM5sf3SXJ473X6I0FFijNojs48b54UhyCDh9XbueMBkpuK/a1HJGzT26lBUCjf5qAfN9xiPTEnivXv3KeE3jfrPtcannXR/qvv6Xwlv0ZnOp5A6lRk4GmT1zk/eqZDYDTWxVU4Kh6jvz4k+m3dEDIVzRUEt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xc39/tj7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5659AC4CEC3;
	Fri, 25 Oct 2024 21:06:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729890369;
	bh=MTv3LxsYyRYwz6lTAAdJU1iMPfscHo0zUbDJdr9/tPE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Xc39/tj7V0/xyo2Ny5kW6277FYTDGBXRrQgo3QM9930swS359mf8Pt1jFmdGHFNzL
	 xC+ly3PfrC0lROCuN+EhJ73RETsRdosFuDmtZcB63ISlnHQ2yiCEC9OV/0UcM5Femd
	 U//kP3o3289YzFDwo5Q2IoNW02VZH4awhZvTJRxjJUSrehMZNbB/4uV5AH71dUwq2f
	 fU3JFXpTUEcJXYku5WREtweixVnpWAGPWnP4xHfGdWhOq+2mLqZyoelKTzzoyqanZC
	 K69MEacxBRUR8cxPfOR79gA0SXU/TVQU8sx5O5GAK9TYjXpcTLvRc3/hRdj9fy+nGl
	 232arYqmMWSeA==
From: "Rob Herring (Arm)" <robh@kernel.org>
Date: Fri, 25 Oct 2024 16:05:47 -0500
Subject: [PATCH RFC 2/3] rust: Add bindings for device properties
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241025-rust-platform-dev-v1-2-0df8dcf7c20b@kernel.org>
References: <20241025-rust-platform-dev-v1-0-0df8dcf7c20b@kernel.org>
In-Reply-To: <20241025-rust-platform-dev-v1-0-0df8dcf7c20b@kernel.org>
To: Saravana Kannan <saravanak@google.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
 Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <benno.lossin@proton.me>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
 Dirk Behme <dirk.behme@gmail.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 rust-for-linux@vger.kernel.org
X-Mailer: b4 0.15-dev

The device property API is a firmware agnostic API for reading
properties from firmware (DT/ACPI) devices nodes and swnodes.

While the C API takes a pointer to a caller allocated variable/buffer,
the rust API is designed to return a value and can be used in struct
initialization. Rust generics are also utilized to support different
sizes of properties (e.g. u8, u16, u32).

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
Not sure if we need the KVec variant, but I kept it as that was my first
pass attempt. Most callers are filling in some value in a driver data
struct. Sometimes the number of elements is not known, so the caller
calls to get the array size, allocs the correct size buffer, and then
reads the property again to fill in the buffer.

I have not implemented a wrapper for device_property_read_string(_array)
because that API is problematic for dynamic DT nodes. The API just
returns pointer(s) into the raw DT data. We probably need to return a
copy of the string(s) instead for rust.

After property accessors, next up is child node accessors/iterators.
---
 rust/bindings/bindings_helper.h |   1 +
 rust/kernel/device.rs           | 145 +++++++++++++++++++++++++++++++++++++++-
 2 files changed, 145 insertions(+), 1 deletion(-)

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index 217c776615b9..65717cc20a23 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -19,6 +19,7 @@
 #include <linux/pci.h>
 #include <linux/phy.h>
 #include <linux/platform_device.h>
+#include <linux/property.h>
 #include <linux/refcount.h>
 #include <linux/sched.h>
 #include <linux/slab.h>
diff --git a/rust/kernel/device.rs b/rust/kernel/device.rs
index 0c28b1e6b004..bb66a28df890 100644
--- a/rust/kernel/device.rs
+++ b/rust/kernel/device.rs
@@ -5,10 +5,14 @@
 //! C header: [`include/linux/device.h`](srctree/include/linux/device.h)
 
 use crate::{
+    alloc::KVec,
     bindings,
+    error::{to_result, Result},
+    prelude::*,
+    str::CStr,
     types::{ARef, Opaque},
 };
-use core::{fmt, ptr};
+use core::{fmt, mem::size_of, ptr};
 
 #[cfg(CONFIG_PRINTK)]
 use crate::c_str;
@@ -189,6 +193,145 @@ unsafe fn printk(&self, klevel: &[u8], msg: fmt::Arguments<'_>) {
             )
         };
     }
+
+    /// Returns if a firmware property `name` is true or false
+    pub fn property_read_bool(&self, name: &CStr) -> bool {
+        unsafe { bindings::device_property_present(self.as_raw(), name.as_ptr() as *const i8) }
+    }
+
+    /// Returns if a firmware string property `name` has match for `match_str`
+    pub fn property_match_string(&self, name: &CStr, match_str: &CStr) -> Result<usize> {
+        let ret = unsafe {
+            bindings::device_property_match_string(
+                self.as_raw(),
+                name.as_ptr() as *const i8,
+                match_str.as_ptr() as *const i8,
+            )
+        };
+        to_result(ret)?;
+        Ok(ret as usize)
+    }
+
+    /// Returns firmware property `name` scalar value
+    ///
+    /// Valid types are i8, u8, i16, u16, i32, u32, i64, u64
+    pub fn property_read<T: Copy>(&self, name: &CStr) -> Result<T> {
+        let mut val: [T; 1] = unsafe { core::mem::zeroed() };
+
+        Self::_property_read_array(&self, name, &mut val)?;
+        Ok(val[0])
+    }
+
+    /// Returns firmware property `name` array values
+    ///
+    /// Valid types are i8, u8, i16, u16, i32, u32, i64, u64
+    pub fn property_read_array<T, const N: usize>(&self, name: &CStr) -> Result<[T; N]> {
+        let mut val: [T; N] = unsafe { core::mem::zeroed() };
+
+        Self::_property_read_array(self, name, &mut val)?;
+        Ok(val)
+    }
+
+    fn _property_read_array<T>(&self, name: &CStr, val: &mut [T]) -> Result {
+        match size_of::<T>() {
+            1 => to_result(unsafe {
+                bindings::device_property_read_u8_array(
+                    self.as_raw(),
+                    name.as_ptr() as *const i8,
+                    val.as_ptr() as *mut u8,
+                    val.len(),
+                )
+            })?,
+            2 => to_result(unsafe {
+                bindings::device_property_read_u16_array(
+                    self.as_raw(),
+                    name.as_ptr() as *const i8,
+                    val.as_ptr() as *mut u16,
+                    val.len(),
+                )
+            })?,
+            4 => to_result(unsafe {
+                bindings::device_property_read_u32_array(
+                    self.as_raw(),
+                    name.as_ptr() as *const i8,
+                    val.as_ptr() as *mut u32,
+                    val.len(),
+                )
+            })?,
+            8 => to_result(unsafe {
+                bindings::device_property_read_u64_array(
+                    self.as_raw(),
+                    name.as_ptr() as *const i8,
+                    val.as_ptr() as *mut u64,
+                    val.len(),
+                )
+            })?,
+            _ => return Err(EINVAL),
+        }
+        Ok(())
+    }
+
+    pub fn property_read_array_vec<T>(&self, name: &CStr, len: usize) -> Result<KVec<T>> {
+        let mut val: KVec<T> = KVec::with_capacity(len, GFP_KERNEL)?;
+
+        // SAFETY: len always matches capacity
+        unsafe { val.set_len(len) }
+        Self::_property_read_array::<T>(&self, name, val.as_mut_slice())?;
+        Ok(val)
+    }
+
+    /// Returns array length for firmware property `name`
+    ///
+    /// Valid types are i8, u8, i16, u16, i32, u32, i64, u64
+    pub fn property_count_elem<T>(&self, name: &CStr) -> Result<usize> {
+        let ret;
+
+        match size_of::<T>() {
+            1 => {
+                ret = unsafe {
+                    bindings::device_property_read_u8_array(
+                        self.as_raw(),
+                        name.as_ptr() as *const i8,
+                        ptr::null_mut(),
+                        0,
+                    )
+                }
+            }
+            2 => {
+                ret = unsafe {
+                    bindings::device_property_read_u16_array(
+                        self.as_raw(),
+                        name.as_ptr() as *const i8,
+                        ptr::null_mut(),
+                        0,
+                    )
+                }
+            }
+            4 => {
+                ret = unsafe {
+                    bindings::device_property_read_u32_array(
+                        self.as_raw(),
+                        name.as_ptr() as *const i8,
+                        ptr::null_mut(),
+                        0,
+                    )
+                }
+            }
+            8 => {
+                ret = unsafe {
+                    bindings::device_property_read_u64_array(
+                        self.as_raw(),
+                        name.as_ptr() as *const i8,
+                        ptr::null_mut(),
+                        0,
+                    )
+                }
+            }
+            _ => return Err(EINVAL),
+        }
+        to_result(ret)?;
+        Ok(ret.try_into().unwrap())
+    }
 }
 
 // SAFETY: Instances of `Device` are always reference-counted.

-- 
2.45.2


