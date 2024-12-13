Return-Path: <linux-kernel+bounces-444863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C9439F0DA3
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 14:48:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1884B282534
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 13:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B1DE1E0E14;
	Fri, 13 Dec 2024 13:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t5KUZx7b"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B51A1E0DB3;
	Fri, 13 Dec 2024 13:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734097666; cv=none; b=dJkEJDpfW4H5XCAzm8g+iA3L3J/JSVCCY97/bLmohFHSYuMNomuVtzc08542768tekcpLaksc9qsg/mCXFR1/iGVwZWuvd6b6jInBXl7D2dE41ueEBvW4O2L+JqZKA/LdKYY557IMhEWLOgsQ/+a+3w3GweUvyYMgUWdgdP7s4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734097666; c=relaxed/simple;
	bh=FUDuPCGiIzTe7+Z+u/MBEryhDck/6gCbdCtn7XdUV+o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kFrJJ2VVoR0w9ND4Yc0r5kmfI5pJ1oqzK4mhU6nOaTQ+cFOLm23swT7fN5MzohHHzTt0kLNqo7XVnKd28d8+MUYL4EFsmOkKUKZz6Y2rPDfA1tF9mKM9lBFlWfMvcpg8PbfUQUeXsaq8gMNZItVg7sKO6ir8jEoEUD9HI1K8V/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t5KUZx7b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B5B8C4CED0;
	Fri, 13 Dec 2024 13:47:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734097666;
	bh=FUDuPCGiIzTe7+Z+u/MBEryhDck/6gCbdCtn7XdUV+o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=t5KUZx7bDD+J0+axWwiOWGixA4kgDsoo0+oFdn/KH0Zy5OW6f8PAZzGPpOgbMvWKf
	 r39Tb/4/P3VcEvgYXNYuE/61FLHN5MyMjmlZxRehlWvUSARi5lWMgB8NkbUPeDTjDA
	 3S4O6EfkbFBYiNcejxs0uXVOpy81u2fWpP07JPiwEv43kr/u29T9kG8WwVhGjsX2qy
	 WFDYAPSjT1ouHA24ALekobuyxtWpabW2TiSqt8CYXYAmFfh076w/1nkQan46yuS04o
	 BNi8ydaOIWK5P6+fAV/0kin1XrmgbHJWs+RrUMZwjGa2E5htFHx4gfNUnXQfzD7/NP
	 uD/GWJnpnXt6Q==
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
Subject: [PATCH v6 2/5] samples: rust: Provide example using the new Rust MiscDevice abstraction
Date: Fri, 13 Dec 2024 13:47:07 +0000
Message-ID: <20241213134715.601415-3-lee@kernel.org>
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

This sample driver demonstrates the following basic operations:

* Register a Misc Device
* Create /dev/rust-misc-device
* Provide open call-back for the aforementioned character device
* Operate on the character device via a simple ioctl()
* Provide close call-back for the character device

Signed-off-by: Lee Jones <lee@kernel.org>
---
 samples/rust/Kconfig             | 10 ++++
 samples/rust/Makefile            |  1 +
 samples/rust/rust_misc_device.rs | 87 ++++++++++++++++++++++++++++++++
 3 files changed, 98 insertions(+)
 create mode 100644 samples/rust/rust_misc_device.rs

diff --git a/samples/rust/Kconfig b/samples/rust/Kconfig
index b0f74a81c8f9..df384e679901 100644
--- a/samples/rust/Kconfig
+++ b/samples/rust/Kconfig
@@ -20,6 +20,16 @@ config SAMPLE_RUST_MINIMAL
 
 	  If unsure, say N.
 
+config SAMPLE_RUST_MISC_DEVICE
+	tristate "Misc device"
+	help
+	  This option builds the Rust misc device.
+
+	  To compile this as a module, choose M here:
+	  the module will be called rust_misc_device.
+
+	  If unsure, say N.
+
 config SAMPLE_RUST_PRINT
 	tristate "Printing macros"
 	help
diff --git a/samples/rust/Makefile b/samples/rust/Makefile
index c1a5c1655395..ad4b97a98580 100644
--- a/samples/rust/Makefile
+++ b/samples/rust/Makefile
@@ -2,6 +2,7 @@
 ccflags-y += -I$(src)				# needed for trace events
 
 obj-$(CONFIG_SAMPLE_RUST_MINIMAL)		+= rust_minimal.o
+obj-$(CONFIG_SAMPLE_RUST_MISC_DEVICE)		+= rust_misc_device.o
 obj-$(CONFIG_SAMPLE_RUST_PRINT)			+= rust_print.o
 
 rust_print-y := rust_print_main.o rust_print_events.o
diff --git a/samples/rust/rust_misc_device.rs b/samples/rust/rust_misc_device.rs
new file mode 100644
index 000000000000..324c3696ae3f
--- /dev/null
+++ b/samples/rust/rust_misc_device.rs
@@ -0,0 +1,87 @@
+// SPDX-License-Identifier: GPL-2.0
+
+// Copyright (C) 2024 Google LLC.
+
+//! Rust misc device sample.
+
+use kernel::{
+    c_str,
+    device::Device,
+    fs::File,
+    ioctl::_IO,
+    miscdevice::{MiscDevice, MiscDeviceOptions, MiscDeviceRegistration},
+    prelude::*,
+    types::ARef,
+};
+
+const RUST_MISC_DEV_HELLO: u32 = _IO('|' as u32, 0x80);
+
+module! {
+    type: RustMiscDeviceModule,
+    name: "rust_misc_device",
+    author: "Lee Jones",
+    description: "Rust misc device sample",
+    license: "GPL",
+}
+
+#[pin_data]
+struct RustMiscDeviceModule {
+    #[pin]
+    _miscdev: MiscDeviceRegistration<RustMiscDevice>,
+}
+
+impl kernel::InPlaceModule for RustMiscDeviceModule {
+    fn init(_module: &'static ThisModule) -> impl PinInit<Self, Error> {
+        pr_info!("Initialising Rust Misc Device Sample\n");
+
+        let options = MiscDeviceOptions {
+            name: c_str!("rust-misc-device"),
+        };
+
+        try_pin_init!(Self {
+            _miscdev <- MiscDeviceRegistration::register(options),
+        })
+    }
+}
+
+struct RustMiscDevice {
+    dev: ARef<Device>,
+}
+
+#[vtable]
+impl MiscDevice for RustMiscDevice {
+    type Ptr = KBox<Self>;
+
+    fn open(_file: &File, misc: &MiscDeviceRegistration<Self>) -> Result<KBox<Self>> {
+        let dev = ARef::from(misc.device());
+
+        dev_info!(dev, "Opening Rust Misc Device Sample\n");
+
+        Ok(KBox::new(RustMiscDevice { dev }, GFP_KERNEL)?)
+    }
+
+    fn ioctl(
+        me: <Self::Ptr as kernel::types::ForeignOwnable>::Borrowed<'_>,
+        _file: &File,
+        cmd: u32,
+        _arg: usize,
+    ) -> Result<isize> {
+        dev_info!(me.dev, "IOCTLing Rust Misc Device Sample\n");
+
+        match cmd {
+            RUST_MISC_DEV_HELLO => dev_info!(me.dev, "Hello from the Rust Misc Device\n"),
+            _ => {
+                dev_err!(me.dev, "-> IOCTL not recognised: {}\n", cmd);
+                return Err(ENOTTY);
+            }
+        }
+
+        Ok(0)
+    }
+}
+
+impl Drop for RustMiscDevice {
+    fn drop(&mut self) {
+        dev_info!(self.dev, "Exiting the Rust Misc Device Sample\n");
+    }
+}
-- 
2.47.1.613.gc27f4b7a9f-goog


