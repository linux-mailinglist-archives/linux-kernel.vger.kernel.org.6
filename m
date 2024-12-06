Return-Path: <linux-kernel+bounces-434675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 35B6C9E69B0
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 10:07:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DBBD1886888
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 09:06:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C369D1F9EC7;
	Fri,  6 Dec 2024 09:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E/SdWkeJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0255122315;
	Fri,  6 Dec 2024 09:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733475947; cv=none; b=eOzhu5nScWKWtz6zYdKxntpUgvJClAgJNBtt0abR7svuulxtZ8kI7wD+WPk4DeQxJhaF83MVfvuMFuv4yNiSRf2f00E1A9E7d8MFlxXG1Il5HXFUD0cfYlvl0hfle3AYH7Wb7+ugT3w9Rnh+WUC4UDLRLxRdxOaTWp64ZHJrE+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733475947; c=relaxed/simple;
	bh=z8ZHUz6kwnp2IDcmZZ1KEAfTtpu9BEoMiALS4JhpqeQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=agvdDYrc+I6G5/3NVZ28Yz43OFhSCXdf0PCjUNnIWN/8nPNXTp4xv1p15kJGnAwvBxTdj3XYCI1kW9cnWZR81uGCUjGNyUF77Ta4ajOYqRBUqGCDG/Rkmm6mTo7vKUIEOz7+z5MhiawIuMSAuHAep5PjUbPomTcqRRq/Np1gToM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E/SdWkeJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9704C4CEDE;
	Fri,  6 Dec 2024 09:05:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733475946;
	bh=z8ZHUz6kwnp2IDcmZZ1KEAfTtpu9BEoMiALS4JhpqeQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=E/SdWkeJsffV/GLow5WUql0MRSsP/p7rVqQJF3M1yu64delUACGbkgwSyhNDiE4mv
	 NLE8xRHIMebHAxeqPqkOFrN7K4AjBc3MRvV7echU71z0azYo+ez5WmDteaKh9nrywN
	 sx3FlDsLNxiDwI0x51GI/xH7ixNU4StN+y2CndR5ZUejx4TgY871/Bs48d6MBpWqHI
	 U2LnMVtkIaKocIsAIYtlzKTRJl9urDzQsryYNsiZHHYiOvjGsltgYu0vgxE+p910gv
	 xD911AaLWVCgTpCc0hjKR2znpcfv/9+u/PEkQxq4jvfqkjUKNlNP9TCtYVv3O7QKOA
	 WGdUhhCJCCUrQ==
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
Subject: [PATCH v4 3/4] sample: rust_misc_device: Demonstrate additional get/set value functionality
Date: Fri,  6 Dec 2024 09:05:07 +0000
Message-ID: <20241206090515.752267-6-lee@kernel.org>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
In-Reply-To: <20241206090515.752267-1-lee@kernel.org>
References: <20241206090515.752267-1-lee@kernel.org>
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

#include <stdio.h>
#include <stdlib.h>
#include <errno.h>
#include <fcntl.h>
#include <unistd.h>
#include <sys/ioctl.h>

#define RUST_MISC_DEV_FAIL _IO('|', 0)
#define RUST_MISC_DEV_GET_VALUE _IOR('|', 7, int)
#define RUST_MISC_DEV_SET_VALUE _IOW('|', 8, int)
#define RUST_MISC_DEV_HELLO _IO('|', 9)

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
index 3837532d259e..02ef8780804e 100644
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
 
+const RUST_MISC_DEV_GET_VALUE: u32 = _IOR::<i32>('|' as u32, 7);
+const RUST_MISC_DEV_SET_VALUE: u32 = _IOW::<i32>('|' as u32, 8);
 const RUST_MISC_DEV_HELLO: u32 = _IO('|' as u32, 9);
 
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
                 return Err(ENOTTY);
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


