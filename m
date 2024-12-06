Return-Path: <linux-kernel+bounces-435019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 01F1D9E6E81
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 13:47:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60F3A16CE0C
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 12:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30DEE206F19;
	Fri,  6 Dec 2024 12:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nXN01lXR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60B8B204084;
	Fri,  6 Dec 2024 12:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733488981; cv=none; b=KJs5isygF9l6EunCOgwUHQkLDcteU6h8/He64Ss3Jv1XlER9Tx0JK1IdKDU6oDn/MJp1em4Q4Xuh5XWdmuD56r6NssNwdyoqMaEGpjzqkomWcOYwNAwYyYNjY6AzRmZzA2NxEVzY1xveZQ2Zb867xKtsodmXhU8QDU9OjXviFMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733488981; c=relaxed/simple;
	bh=Py0FD2j7lVfnB2hl12X2dgn6g97O4lfXlXqlXQBJIKw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ohJ9JfpjQPwfn8BvRXq4MBw5RG+B7LKbCIVI56XA1Qb0g+GKhUcmTzoafMsX6d4dyYCjyhWecH7T1EcfBx6NzmaOTDY+nJ3XRRsusDkUFoFWMT3MQ/MluUPwA7vo7NoKty9ZYlsX3io+vfjiYO4fxIv4SpETxsQrkrvKh09M+dE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nXN01lXR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 742EDC4CED1;
	Fri,  6 Dec 2024 12:42:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733488981;
	bh=Py0FD2j7lVfnB2hl12X2dgn6g97O4lfXlXqlXQBJIKw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nXN01lXRCgfwOZDpqfUNZkEZLew1X4lj9qFzxf61lzNyoxXqEpfYFzVi5z+eIZ+Dv
	 GZHwSvHaOe3wtSdjryLxKz+m/WD0R/Mp1+K0q8mvPAKwpjZ833tU3XXjIcv7OYiDGk
	 8/LJ6nadLgxjdE+74yJYB5mFNV0cNrwioRfsuM4NBRFb9etGuiGPcJq3OJg1EvKKef
	 dXR4spcRmsst30g2omEVXVk7im9Lqr+W95yZYQvD4gqdnJ1DrNEhk3x9jfRcHXPtEB
	 xr43wS3+7mI3LP1RyTkhkZY01U0BT/ThkGl9U/0+yuKKemyuNn7l+x6DhzUuUExUmW
	 wH5U3zbuTe9tg==
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
Subject: [PATCH v5 3/4] sample: rust_misc_device: Demonstrate additional get/set value functionality
Date: Fri,  6 Dec 2024 12:42:14 +0000
Message-ID: <20241206124218.165880-4-lee@kernel.org>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
In-Reply-To: <20241206124218.165880-1-lee@kernel.org>
References: <20241206124218.165880-1-lee@kernel.org>
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
index c94b56c454fb..8145cf072640 100644
--- a/samples/rust/rust_misc_device.rs
+++ b/samples/rust/rust_misc_device.rs
@@ -4,14 +4,21 @@
 
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
 
 const RUST_MISC_DEV_HELLO: u32 = _IO('|' as u32, 0x80);
+const RUST_MISC_DEV_GET_VALUE: u32 = _IOR::<i32>('|' as u32, 0x81);
+const RUST_MISC_DEV_SET_VALUE: u32 = _IOW::<i32>('|' as u32, 0x82);
 
 module! {
     type: RustMiscDeviceModule,
@@ -41,39 +48,84 @@ fn init(_module: &'static ThisModule) -> impl PinInit<Self, Error> {
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


