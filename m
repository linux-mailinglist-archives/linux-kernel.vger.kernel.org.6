Return-Path: <linux-kernel+bounces-434674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 788E09E69AF
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 10:06:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E123A1886A40
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 09:06:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 447241F942A;
	Fri,  6 Dec 2024 09:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZNT1yTKh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A13001F8AFD;
	Fri,  6 Dec 2024 09:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733475943; cv=none; b=KMVSS+nj129Y7OL+8nnTgUPEGZrFOBr2jaz/n3LzuyFs+MGyX81r+uvnaf0yHVtMlz4ouDzJ1uGOXzoxlYNDmutiskXyicA7U0s+myacE9rjns460C8negEQvE9PGG/2ct3BVMGWXbCAFy6Uc4ClOvbM53b/FCJfZ1N3OsoH8FA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733475943; c=relaxed/simple;
	bh=/vGNwkuzJwrok7OwiHWU6wXKpr+MGQsYZDS7oxldDSE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vbw/+4Nrjl6PgxAfZBgejrNhvUr5wOSLrZo6jgZhjG0CNgTieFsWiEn0/MmL2waCA+qYvR+zPIm5yRbsxru2SsQn/34WT9E9UmFqIXXaKw1mfuD02HzNQTKyj0/UzENEqw4FBu/1yJyaZ/cs077k4JZ3z2aTkPq+gozdQ4evqH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZNT1yTKh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C40A7C4CEDD;
	Fri,  6 Dec 2024 09:05:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733475943;
	bh=/vGNwkuzJwrok7OwiHWU6wXKpr+MGQsYZDS7oxldDSE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZNT1yTKhmoK5Bln6Fk9kNGFSKx562INp9fUkT10gscUkP7ILGKB5OcizGbloWxSbZ
	 km5ZkEzFdx/1RrTGBZ118hIdEYl4BgD44O97P6lYp6YGqgmGX0fDUPo0RrOJOE0E77
	 JjS1TEWt7ah3iN78hPfqYs29DHW8e8TSsUeUAqe/xZ7FrBxwTIhnO9YBAdgMkUcksE
	 RRdjfZDcM69q7uBzbqyg7+b3lGEtWR2jt+qYZCHoScrRCRopENrq1HGZhHLTXDrAtT
	 bWnzFKiV6Gi7+FbxP6krNlnjWsxT4SYeAoJ4KE5bom28ytcVmPvPqnC0L1AE1MisvE
	 KEYG9gRfp36cA==
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
Subject: [PATCH v4 2/4] samples: rust: Provide example using the new Rust MiscDevice abstraction
Date: Fri,  6 Dec 2024 09:05:06 +0000
Message-ID: <20241206090515.752267-5-lee@kernel.org>
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
 samples/rust/rust_misc_device.rs | 80 ++++++++++++++++++++++++++++++++
 3 files changed, 91 insertions(+)
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
index 000000000000..3837532d259e
--- /dev/null
+++ b/samples/rust/rust_misc_device.rs
@@ -0,0 +1,80 @@
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
+const RUST_MISC_DEV_HELLO: u32 = _IO('|' as u32, 9);
+
+module! {
+    type: RustMiscDeviceModule,
+    name: "rust_misc_device",
+    author: "Lee Jones",
+    description: "Rust misc device sample",
+    license: "GPL",
+}
+
+struct RustMiscDeviceModule {
+    _miscdev: Pin<KBox<MiscDeviceRegistration<RustMiscDevice>>>,
+}
+
+impl kernel::Module for RustMiscDeviceModule {
+    fn init(_module: &'static ThisModule) -> Result<Self> {
+        pr_info!("Initialising Rust Misc Device Sample\n");
+
+        let options = MiscDeviceOptions {
+            name: c_str!("rust-misc-device"),
+        };
+
+        Ok(Self {
+            _miscdev: KBox::pin_init(
+                MiscDeviceRegistration::<RustMiscDevice>::register(options),
+                GFP_KERNEL,
+            )?,
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


