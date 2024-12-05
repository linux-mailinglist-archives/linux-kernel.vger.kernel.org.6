Return-Path: <linux-kernel+bounces-433662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E1BE9E5B5A
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 17:27:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DC3E1886717
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 16:27:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A286226EC5;
	Thu,  5 Dec 2024 16:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VwUwmZAM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B381B222565;
	Thu,  5 Dec 2024 16:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733415953; cv=none; b=AWtVv47ms0tJgXGXd4SVDaVLmBcN1Ue4BAquf6lRd4VfWaQ6ghouc4syHR0pNtMzK7CAbSzNPeLkclGG5hDdnuyEzQ3atnMhBMXCK6a30PR5X6p9SWrD1DdDi4Pnhk+pl5vUI/kekTGldFytbdruPpuLyW6ym4N536KUVYCjqmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733415953; c=relaxed/simple;
	bh=rNO/zBPeJJmilX3vGIpUePq0l+fx97aSIbCzfNre5kg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IX8JRifJajE9hqKq6eF+y+aGnWAX7PBEXsBnevK8Frea0Z+1s9xbgHg8GSQet+/8U1J0caCRzuK2pTs59spOZsEtCi/OA96pZBP/JLzUxP9sFq6t8knSrQQpE6xCTPOFt9TfY4JxPI7HfDVvn1GrUaVCsoWQH176ZaCvJc7j76g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VwUwmZAM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E34CC4CEDC;
	Thu,  5 Dec 2024 16:25:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733415953;
	bh=rNO/zBPeJJmilX3vGIpUePq0l+fx97aSIbCzfNre5kg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VwUwmZAMBPhd9RcqL/D9jc9gNrq+pfLOI8LZp38rt6cxwGVHIpFua2El4uFTiYmch
	 Izlz3FjStKlcsvsX8XfGZR9Cpl7A9vHGzIe9tCq9mVL7hpklvpL8AUmxQicu+Mdfm5
	 ATTdyn8gp3uxt+0L30hcAhMhn246SHq3ZXUs4z0KWK4vCVEb+5DI+ofpJxSHgGjtFl
	 2g4nE8JOSOrOIl0Lj/SWcEH5NkYPewvwggqzlTIL5BfztxVbeHcFzkEjfD7MNcWb0f
	 Wv8f+XG9pfs0Zx07pGxna9QszWvghKvDZertA8uddhPGPDwBhplMQBga/nTp4iBE3r
	 nV2RXjLeWNKeg==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org
Cc: linux-kernel@vger.kernel.org,
	arnd@arndb.de,
	gregkh@linuxfoundation.org,
	ojeda@kernel.org,
	alex.gaynor@gmail.com,
	boqun.feng@gmail.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	benno.lossin@proton.me,
	a.hindborg@kernel.org,
	aliceryhl@google.com,
	tmgross@umich.edu,
	rust-for-linux@vger.kernel.org
Subject: [PATCH v3 4/5] sample: rust_misc_device: Demonstrate additional get/set value functionality
Date: Thu,  5 Dec 2024 16:25:21 +0000
Message-ID: <20241205162531.1883859-5-lee@kernel.org>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
In-Reply-To: <20241205162531.1883859-1-lee@kernel.org>
References: <20241205162531.1883859-1-lee@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Expand the complexity of the sample driver by providing the ability to
get and set an integer.  The value is protected by a mutex.

Here is a simple userspace program that fully exercises the sample
driver's capabilities.

int main() {
  int value, new_value;
  int fd, ret;

  // Open the device file
  printf("Opening /dev/rust-misc-device for reading and writing\n");
  fd = open("/dev/rust-misc-device", O_RDWR);
  if (fd < 0) {
    perror("open");
    return errno;
  }

  // Make call into driver to say "hello"
  printf("Calling Hello\n");
  ret = ioctl(fd, RUST_MISC_DEV_HELLO, NULL);
  if (ret < 0) {
    perror("ioctl: Failed to call into Hello");
    close(fd);
    return errno;
  }

  // Get initial value
  printf("Fetching initial value\n");
  ret = ioctl(fd, RUST_MISC_DEV_GET_VALUE, &value);
  if (ret < 0) {
    perror("ioctl: Failed to fetch the initial value");
    close(fd);
    return errno;
  }

  value++;

  // Set value to something different
  printf("Submitting new value (%d)\n", value);
  ret = ioctl(fd, RUST_MISC_DEV_SET_VALUE, &value);
  if (ret < 0) {
    perror("ioctl: Failed to submit new value");
    close(fd);
    return errno;
  }

  // Ensure new value was applied
  printf("Fetching new value\n");
  ret = ioctl(fd, RUST_MISC_DEV_GET_VALUE, &new_value);
  if (ret < 0) {
    perror("ioctl: Failed to fetch the new value");
    close(fd);
    return errno;
  }

  if (value != new_value) {
    printf("Failed: Committed and retrieved values are different (%d - %d)\n", value, new_value);
    close(fd);
    return -1;
  }

  // Call the unsuccessful ioctl
  printf("Attempting to call in to an non-existent IOCTL\n");
  ret = ioctl(fd, RUST_MISC_DEV_FAIL, NULL);
  if (ret < 0) {
    perror("ioctl: Succeeded to fail - this was expected");
  } else {
    printf("ioctl: Failed to fail\n");
    close(fd);
    return -1;
  }

  // Close the device file
  printf("Closing /dev/rust-misc-device\n");
  close(fd);

  printf("Success\n");
  return 0;
}

And here is the output (manually spliced together):

USERSPACE: Opening /dev/rust-misc-device for reading and writing
KERNEL: rust_misc_device: Opening Rust Misc Device Sample
USERSPACE: Calling Hello
KERNEL: rust_misc_device: IOCTLing Rust Misc Device Sample
KERNEL: rust_misc_device: -> Hello from the Rust Misc Device
USERSPACE: Fetching initial value
KERNEL: rust_misc_device: IOCTLing Rust Misc Device Sample
KERNEL: rust_misc_device: -> Copying data to userspace (value: 0)
USERSPACE: Submitting new value (1)
KERNEL: rust_misc_device: IOCTLing Rust Misc Device Sample
KERNEL: rust_misc_device: -> Copying data from userspace (value: 1)
USERSPACE: Fetching new value
KERNEL: rust_misc_device: IOCTLing Rust Misc Device Sample
KERNEL: rust_misc_device: -> Copying data to userspace (value: 1)
USERSPACE: Attempting to call in to an non-existent IOCTL
KERNEL: rust_misc_device: IOCTLing Rust Misc Device Sample
KERNEL: rust_misc_device: -> IOCTL not recognised: 20992
USERSPACE: ioctl: Succeeded to fail - this was expected: Inappropriate ioctl for device
USERSPACE: Closing /dev/rust-misc-device
KERNEL: rust_misc_device: Exiting the Rust Misc Device Sample
USERSPACE: Success

Signed-off-by: Lee Jones <lee@kernel.org>
---
 samples/rust/rust_misc_device.rs | 82 ++++++++++++++++++++++++++------
 1 file changed, 67 insertions(+), 15 deletions(-)

diff --git a/samples/rust/rust_misc_device.rs b/samples/rust/rust_misc_device.rs
index f50925713f1a..2d40e2bb7a59 100644
--- a/samples/rust/rust_misc_device.rs
+++ b/samples/rust/rust_misc_device.rs
@@ -4,13 +4,20 @@
 
 //! Rust misc device sample.
 
+use core::pin::Pin;
+
 use kernel::{
     c_str,
-    ioctl::_IO,
+    ioctl::{_IO, _IOC_SIZE, _IOR, _IOW},
     miscdevice::{MiscDevice, MiscDeviceOptions, MiscDeviceRegistration},
+    new_mutex,
     prelude::*,
+    sync::Mutex,
+    uaccess::{UserSlice, UserSliceReader, UserSliceWriter},
 };
 
+const RUST_MISC_DEV_GET_VALUE: u32 = _IOR::<i32>('R' as u32, 7);
+const RUST_MISC_DEV_SET_VALUE: u32 = _IOW::<i32>('R' as u32, 8);
 const RUST_MISC_DEV_HELLO: u32 = _IO('R' as u32, 9);
 
 module! {
@@ -42,39 +49,84 @@ fn init(_module: &'static ThisModule) -> Result<Self> {
     }
 }
 
-struct RustMiscDevice;
+struct Inner {
+    value: i32,
+}
+
+#[pin_data(PinnedDrop)]
+struct RustMiscDevice {
+    #[pin]
+    inner: Mutex<Inner>,
+}
 
 #[vtable]
 impl MiscDevice for RustMiscDevice {
-    type Ptr = KBox<Self>;
+    type Ptr = Pin<KBox<Self>>;
 
-    fn open() -> Result<KBox<Self>> {
+    fn open() -> Result<Pin<KBox<Self>>> {
         pr_info!("Opening Rust Misc Device Sample\n");
 
-        Ok(KBox::new(RustMiscDevice, GFP_KERNEL)?)
+        KBox::try_pin_init(
+            try_pin_init! {
+                RustMiscDevice { inner <- new_mutex!( Inner{ value: 0_i32 } )}
+            },
+            GFP_KERNEL,
+        )
     }
 
-    fn ioctl(
-        _device: <Self::Ptr as kernel::types::ForeignOwnable>::Borrowed<'_>,
-        cmd: u32,
-        _arg: usize,
-    ) -> Result<isize> {
+    fn ioctl(device: Pin<&RustMiscDevice>, cmd: u32, arg: usize) -> Result<isize> {
         pr_info!("IOCTLing Rust Misc Device Sample\n");
 
+        let size = _IOC_SIZE(cmd);
+
         match cmd {
-            RUST_MISC_DEV_HELLO => pr_info!("Hello from the Rust Misc Device\n"),
+            RUST_MISC_DEV_GET_VALUE => device.get_value(UserSlice::new(arg, size).writer())?,
+            RUST_MISC_DEV_SET_VALUE => device.set_value(UserSlice::new(arg, size).reader())?,
+            RUST_MISC_DEV_HELLO => device.hello()?,
             _ => {
-                pr_err!("IOCTL not recognised: {}\n", cmd);
+                pr_err!("-> IOCTL not recognised: {}\n", cmd);
                 return Err(ENOIOCTLCMD);
             }
-        }
+        };
 
         Ok(0)
     }
 }
 
-impl Drop for RustMiscDevice {
-    fn drop(&mut self) {
+#[pinned_drop]
+impl PinnedDrop for RustMiscDevice {
+    fn drop(self: Pin<&mut Self>) {
         pr_info!("Exiting the Rust Misc Device Sample\n");
     }
 }
+
+impl RustMiscDevice {
+    fn set_value(&self, mut reader: UserSliceReader) -> Result<isize> {
+        let new_value = reader.read::<i32>()?;
+        let mut guard = self.inner.lock();
+
+        pr_info!("-> Copying data from userspace (value: {})\n", new_value);
+
+        guard.value = new_value;
+        Ok(0)
+    }
+
+    fn get_value(&self, mut writer: UserSliceWriter) -> Result<isize> {
+        let guard = self.inner.lock();
+        let value = guard.value;
+
+        // Refrain from calling write() on a locked resource
+        drop(guard);
+
+        pr_info!("-> Copying data to userspace (value: {})\n", &value);
+
+        writer.write::<i32>(&value)?;
+        Ok(0)
+    }
+
+    fn hello(&self) -> Result<isize> {
+        pr_info!("-> Hello from the Rust Misc Device\n");
+
+        Ok(0)
+    }
+}
-- 
2.47.0.338.g60cca15819-goog


