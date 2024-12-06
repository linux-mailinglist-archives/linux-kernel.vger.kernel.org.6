Return-Path: <linux-kernel+bounces-435018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69E309E6E84
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 13:47:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF5B91887A96
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 12:43:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1484E2066C2;
	Fri,  6 Dec 2024 12:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DE0a3bPG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66B2C2036F3;
	Fri,  6 Dec 2024 12:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733488974; cv=none; b=MQ0z+OGpOgS1x0mHUiFG+Ni03+muOWS6+BGQ/qn0aNU+23fPubTeXtU7T/NmhUE4p7PNz9QUTe2z5loe99hRCFg67GPeKFBYJ1lpyHYXpLJ7aKzIbXCjBV2dha1T5HEXvEPKDdG1cGl3newf8r8TqkWB7N7uFQgpwylr+uMA0f0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733488974; c=relaxed/simple;
	bh=WFkpKiXyvQ59F/bCxcLhHbqQzdnF8Nx2WniZliuSybA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r1HXOVb970uX0osP3/CB42yIR1d85vNdKbKED59R0c/b7dh+E46SKfviHwKVVZ/FrjKUgu3iqKn3BKI++/CVGtNrmnuuvaNwYR7Lg/K9sRYl37ACl7cANAADwOmFYIpIKaUW3QQT1VGRovUXwonB+pLXRcI+ilceiaQahl9hvAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DE0a3bPG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EA29C4CED1;
	Fri,  6 Dec 2024 12:42:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733488974;
	bh=WFkpKiXyvQ59F/bCxcLhHbqQzdnF8Nx2WniZliuSybA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DE0a3bPGqAObx3iJSMPQZ6MAwgC8vB5Y6m7QdcN6s3rnH+xu64+/8Y0LzfBjSSDe5
	 1pUkXu+E4hmzoqWKgx11Vksm31z1+wii+CZHhxO0U6oq4Fc+lqRXVO9ufi6rJgEmJ2
	 SPG6nOMW/DesdRZ4nPCdjbIS+YixUdCCVZjo7qL0P+G379H+ny6FViMdxPGgHkCBn0
	 7ZBtyf3XNwFaTXcNUX/bnm5TW0ef2ZlB0AR2ItIBqdt6G1UcnsBf4L+vSGQONAWbIq
	 OUgKI/l4AloKTGEem/1AbILRUv6XqhYfzNqJTdaow2fNX3wym6pdh7N/JoMqGuM2vt
	 rlWY3pj/Wzbrg==
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
Subject: [PATCH v5 2/4] samples: rust: Provide example using the new Rust MiscDevice abstraction
Date: Fri,  6 Dec 2024 12:42:13 +0000
Message-ID: <20241206124218.165880-3-lee@kernel.org>
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
 samples/rust/rust_misc_device.rs | 79 ++++++++++++++++++++++++++++++++
 3 files changed, 90 insertions(+)
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
index 000000000000..c94b56c454fb
--- /dev/null
+++ b/samples/rust/rust_misc_device.rs
@@ -0,0 +1,79 @@
+// SPDX-License-Identifier: GPL-2.0
+
+// Copyright (C) 2024 Google LLC.
+
+//! Rust misc device sample.
+
+use kernel::{
+    c_str,
+    ioctl::_IO,
+    miscdevice::{MiscDevice, MiscDeviceOptions, MiscDeviceRegistration},
+    prelude::*,
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
+struct RustMiscDevice;
+
+#[vtable]
+impl MiscDevice for RustMiscDevice {
+    type Ptr = KBox<Self>;
+
+    fn open() -> Result<KBox<Self>> {
+        pr_info!("Opening Rust Misc Device Sample\n");
+
+        Ok(KBox::new(RustMiscDevice, GFP_KERNEL)?)
+    }
+
+    fn ioctl(
+        _device: <Self::Ptr as kernel::types::ForeignOwnable>::Borrowed<'_>,
+        cmd: u32,
+        _arg: usize,
+    ) -> Result<isize> {
+        pr_info!("IOCTLing Rust Misc Device Sample\n");
+
+        match cmd {
+            RUST_MISC_DEV_HELLO => pr_info!("Hello from the Rust Misc Device\n"),
+            _ => {
+                pr_err!("IOCTL not recognised: {}\n", cmd);
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
+        pr_info!("Exiting the Rust Misc Device Sample\n");
+    }
+}
-- 
2.47.0.338.g60cca15819-goog


