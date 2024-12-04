Return-Path: <linux-kernel+bounces-431923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D6499E42C7
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 19:03:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECCE516AEA2
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 18:03:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEAD7206F20;
	Wed,  4 Dec 2024 17:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qaMPiLts"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0686F2066F3;
	Wed,  4 Dec 2024 17:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733334400; cv=none; b=Uts15xBj8pKIuTvcs2Pe0qcAZ029UQ0bqn5plC2mW8N5Q/qA9oYeuXCR9ffIx4A/FoQm/kal0BRO/oSYOpT5+pY/XDfft/attbfNT19buflMwbaj+a3etcqE9omwo7TV/Fh3JSgA8cZgByBx4vSIQIRn6vk948xQMovu7rJM904=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733334400; c=relaxed/simple;
	bh=YB2YBH7TC53ANMnuE8rK00k+mOwziftx74ay5B3fiBM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sf54D6PH4SvW9zIPae2SQ4nH8GdZ7y2D8EphZXgspWzf0LvCKKnOxd22Eh/mntnGgOCBhLoEhXVIrA8EjoDcC5nOCDvphLeY1IipW2PWpubyrQ0/BhSIxtQb6efDWYRqzW0Qf3TC0pxnCbWkWmZ5aS3ZVPVZn71PRFMhvK57xvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qaMPiLts; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0090EC4CEE0;
	Wed,  4 Dec 2024 17:46:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733334399;
	bh=YB2YBH7TC53ANMnuE8rK00k+mOwziftx74ay5B3fiBM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qaMPiLtspWAylhBwORzrKAZJbOTdZnOexbfaqRYvpUJ4XP2qoI2C1xJFqpbrALYYW
	 kYRCUDOqhjiOrFISgUhBgaWnbp3odIitGmGwdrOSqeho10MBpNADHmh9TGljBnYSyx
	 AqRtvEOW9rcxfFVu2K5lnP3e9QmL3WhHXEJepPmVCjhZPa1cQjOwFSG5ZKGaXfme+7
	 XbnRvYpj84h4ppeteVWCCHWfCGKmqNytz78pAP1XfO/YrAgw7iQc4XLcniNKMm0hy5
	 ceYwqqITGWKDB6TZue4YXT5U2UxC6GGGaX9J0jef5VTwe6wT1fReqbaTMZDNiPKEhv
	 xouxI6paiP3wg==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org
Cc: linux-kernel@vger.kernel.org,
	ojeda@kernel.org,
	alex.gaynor@gmail.com,
	boqun.feng@gmail.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	benno.lossin@proton.me,
	a.hindborg@kernel.org,
	aliceryhl@google.com,
	tmgross@umich.edu,
	rust-for-linux@vger.kernel.org,
	gregkh@linuxfoundation.org
Subject: [PATCH 2/2] sample: rust_misc_device: Demonstrate additional get/set value functionality
Date: Wed,  4 Dec 2024 17:46:25 +0000
Message-ID: <20241204174627.1151288-2-lee@kernel.org>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
In-Reply-To: <20241204174627.1151288-1-lee@kernel.org>
References: <20241204174627.1151288-1-lee@kernel.org>
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

Signed-off-by: Lee Jones <lee@kernel.org>
---
 samples/rust/rust_misc_device.rs | 82 ++++++++++++++++++++++++--------
 1 file changed, 62 insertions(+), 20 deletions(-)

diff --git a/samples/rust/rust_misc_device.rs b/samples/rust/rust_misc_device.rs
index 5f1b69569ef7..9c041497d881 100644
--- a/samples/rust/rust_misc_device.rs
+++ b/samples/rust/rust_misc_device.rs
@@ -2,13 +2,20 @@
 
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
@@ -40,45 +47,80 @@ fn init(_module: &'static ThisModule) -> Result<Self> {
     }
 }
 
-struct RustMiscDevice;
+struct Inner {
+    value: i32,
+}
 
-impl RustMiscDevice {
-    fn new() -> Self {
-        Self
-    }
+#[pin_data(PinnedDrop)]
+struct RustMiscDevice {
+    #[pin]
+    inner: Mutex<Inner>,
 }
 
 #[vtable]
 impl MiscDevice for RustMiscDevice {
-    type Ptr = KBox<Self>;
+    type Ptr = Pin<KBox<Self>>;
 
-    fn open() -> Result<KBox<Self>> {
+    fn open() -> Result<Pin<KBox<Self>>> {
         pr_info!("Opening Rust Misc Device Sample\n");
 
-        Ok(KBox::new(RustMiscDevice::new(), GFP_KERNEL)?)
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
 
-        match cmd {
-            RUST_MISC_DEV_HELLO => pr_info!("Hello from the Rust Misc Device\n"),
+        let size = _IOC_SIZE(cmd);
+
+        let _ = match cmd {
+            RUST_MISC_DEV_GET_VALUE => device.get_value(UserSlice::new(arg, size).writer())?,
+            RUST_MISC_DEV_SET_VALUE => device.set_value(UserSlice::new(arg, size).reader())?,
+            RUST_MISC_DEV_HELLO => device.hello()?,
             _ => {
-                pr_err!("IOCTL not recognised: {}\n", cmd);
+                pr_err!("-> IOCTL not recognised: {}\n", cmd);
                 return Err(EINVAL);
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
+
+        pr_info!("-> Copying data to userspace (value: {})\n", &guard.value);
+
+        writer.write::<i32>(&guard.value)?;
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


