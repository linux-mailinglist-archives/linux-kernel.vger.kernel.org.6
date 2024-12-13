Return-Path: <linux-kernel+bounces-444864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A1809F0DA4
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 14:48:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFB7C188851C
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 13:48:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55FAD1E1A1F;
	Fri, 13 Dec 2024 13:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IRb47Kr9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF87B1E0DB3;
	Fri, 13 Dec 2024 13:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734097669; cv=none; b=kpYHXzoKTD3l4GVzUeS+q0J7ci+Yq+cpPHizwrWCy8cGk/B4pNqa2urO2WRwIErobV4+ZG2jGBF3u/nu/G916WL2Izx0JdMCGwA4ocikPbExLbfWsyWf3HyAIN5J1O6aeFX0eOU/TLrKhFXtsrZnjJjXxdLAJliR//w3uDgzQIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734097669; c=relaxed/simple;
	bh=gMScZr/PHM22TpsoMdi7V9GuENoPSrtgECRKdQYPiHE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eU8XeugdLovNUnidFiVfDEK0aHpt4jgfuPdTaYlEaBolp+2D8XJFY93PfkYg84GdCG58RGevjGBhvj8NBelCbIVJ35+76HgMqb57WH+SPQlXO4eyfQzXwx6JcD4o8734SBvVHduMy0uvfzWpKNQTUbpsOJULDFJ3aUJzNmwDtKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IRb47Kr9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 697AFC4CED2;
	Fri, 13 Dec 2024 13:47:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734097669;
	bh=gMScZr/PHM22TpsoMdi7V9GuENoPSrtgECRKdQYPiHE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IRb47Kr92U9I0DHpXrcp8QM8yHnfHguglLEQSHkoFsACwjW+Uype45Ux+n29GOW8U
	 ixfO5Bu3g9gbrHPXCZ5260QGaVEblML03iHdoPkompmWBMJXkYA8tlPH+lQkhwLvJJ
	 WUfxopokhP6hNSlH/zLufaaU5Ns5W0sNJDgA0j1cSCFvkof1qfq2hQLneihckxbWD7
	 7KlwTaSYQY65TNzQe/iJYZqYxeDoiYTopnFHCyBHxHtc/HJcHxumYeYgXLlHciTsxF
	 Q0KZIdhBhgTv8Imo4WWvUWEoJpE0L1W5sjoYgaqjBqufzsx8kc61pH9tE5LgIEHCpF
	 +5UtfnC4dAM0A==
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
Subject: [PATCH v6 3/5] samples: rust_misc_device: Demonstrate additional get/set value functionality
Date: Fri, 13 Dec 2024 13:47:08 +0000
Message-ID: <20241213134715.601415-4-lee@kernel.org>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
In-Reply-To: <20241213134715.601415-1-lee@kernel.org>
References: <20241213134715.601415-1-lee@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Expand the complexity of the sample driver by providing the ability to
get and set an integer.  The value is protected by a mutex.

Signed-off-by: Lee Jones <lee@kernel.org>
---
 samples/rust/rust_misc_device.rs | 89 +++++++++++++++++++++++++++-----
 1 file changed, 75 insertions(+), 14 deletions(-)

diff --git a/samples/rust/rust_misc_device.rs b/samples/rust/rust_misc_device.rs
index 324c3696ae3f..ae1474a451f1 100644
--- a/samples/rust/rust_misc_device.rs
+++ b/samples/rust/rust_misc_device.rs
@@ -4,17 +4,24 @@
 
 //! Rust misc device sample.
 
+use core::pin::Pin;
+
 use kernel::{
     c_str,
     device::Device,
     fs::File,
-    ioctl::_IO,
+    ioctl::{_IO, _IOC_SIZE, _IOR, _IOW},
     miscdevice::{MiscDevice, MiscDeviceOptions, MiscDeviceRegistration},
+    new_mutex,
     prelude::*,
+    sync::Mutex,
     types::ARef,
+    uaccess::{UserSlice, UserSliceReader, UserSliceWriter},
 };
 
 const RUST_MISC_DEV_HELLO: u32 = _IO('|' as u32, 0x80);
+const RUST_MISC_DEV_GET_VALUE: u32 = _IOR::<i32>('|' as u32, 0x81);
+const RUST_MISC_DEV_SET_VALUE: u32 = _IOW::<i32>('|' as u32, 0x82);
 
 module! {
     type: RustMiscDeviceModule,
@@ -44,44 +51,98 @@ fn init(_module: &'static ThisModule) -> impl PinInit<Self, Error> {
     }
 }
 
+struct Inner {
+    value: i32,
+}
+
+#[pin_data(PinnedDrop)]
 struct RustMiscDevice {
+    #[pin]
+    inner: Mutex<Inner>,
     dev: ARef<Device>,
 }
 
 #[vtable]
 impl MiscDevice for RustMiscDevice {
-    type Ptr = KBox<Self>;
+    type Ptr = Pin<KBox<Self>>;
 
-    fn open(_file: &File, misc: &MiscDeviceRegistration<Self>) -> Result<KBox<Self>> {
+    fn open(_file: &File, misc: &MiscDeviceRegistration<Self>) -> Result<Pin<KBox<Self>>> {
         let dev = ARef::from(misc.device());
 
         dev_info!(dev, "Opening Rust Misc Device Sample\n");
 
-        Ok(KBox::new(RustMiscDevice { dev }, GFP_KERNEL)?)
+        KBox::try_pin_init(
+            try_pin_init! {
+                RustMiscDevice {
+                    inner <- new_mutex!( Inner{ value: 0_i32 } ),
+                    dev: dev,
+                }
+            },
+            GFP_KERNEL,
+        )
     }
 
-    fn ioctl(
-        me: <Self::Ptr as kernel::types::ForeignOwnable>::Borrowed<'_>,
-        _file: &File,
-        cmd: u32,
-        _arg: usize,
-    ) -> Result<isize> {
+    fn ioctl(me: Pin<&RustMiscDevice>, _file: &File, cmd: u32, arg: usize) -> Result<isize> {
         dev_info!(me.dev, "IOCTLing Rust Misc Device Sample\n");
 
+        let size = _IOC_SIZE(cmd);
+
         match cmd {
-            RUST_MISC_DEV_HELLO => dev_info!(me.dev, "Hello from the Rust Misc Device\n"),
+            RUST_MISC_DEV_GET_VALUE => me.get_value(UserSlice::new(arg, size).writer())?,
+            RUST_MISC_DEV_SET_VALUE => me.set_value(UserSlice::new(arg, size).reader())?,
+            RUST_MISC_DEV_HELLO => me.hello()?,
             _ => {
                 dev_err!(me.dev, "-> IOCTL not recognised: {}\n", cmd);
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
         dev_info!(self.dev, "Exiting the Rust Misc Device Sample\n");
     }
 }
+
+impl RustMiscDevice {
+    fn set_value(&self, mut reader: UserSliceReader) -> Result<isize> {
+        let new_value = reader.read::<i32>()?;
+        let mut guard = self.inner.lock();
+
+        dev_info!(
+            self.dev,
+            "-> Copying data from userspace (value: {})\n",
+            new_value
+        );
+
+        guard.value = new_value;
+        Ok(0)
+    }
+
+    fn get_value(&self, mut writer: UserSliceWriter) -> Result<isize> {
+        let guard = self.inner.lock();
+        let value = guard.value;
+
+        // Free-up the lock and use our locally cached instance from here
+        drop(guard);
+
+        dev_info!(
+            self.dev,
+            "-> Copying data to userspace (value: {})\n",
+            &value
+        );
+
+        writer.write::<i32>(&value)?;
+        Ok(0)
+    }
+
+    fn hello(&self) -> Result<isize> {
+        dev_info!(self.dev, "-> Hello from the Rust Misc Device\n");
+
+        Ok(0)
+    }
+}
-- 
2.47.1.613.gc27f4b7a9f-goog


