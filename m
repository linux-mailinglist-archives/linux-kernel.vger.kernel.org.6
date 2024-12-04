Return-Path: <linux-kernel+bounces-431921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EE4D9E42C6
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 19:03:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DADB916AE47
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 18:03:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 716F82066E3;
	Wed,  4 Dec 2024 17:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HBl+Lj/v"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC6632066CE;
	Wed,  4 Dec 2024 17:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733334395; cv=none; b=jeTL5pyQOt92Tadq+nqBnLaGLnRBuFUd+Q4plXSPxFpaupcBdbPdd9f6AmsB60VfDht/W0JVjHpJheBWx0AF52TXqH3oEV7VxMbLTR73Dxiy0hFWDEWG/i3LGgFo90G0EsiL7N/hRjjnu0ynXMqbjozhWVTwZCrweHorUHTyCw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733334395; c=relaxed/simple;
	bh=F0BY97kC01D0tVL/a3R3NDyHwQffFD6fAFOe6yb2nP0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ApOfm8mhWwxDeqkFkIl+d5U5loEZJUYzlh7d1zQ2HN3nvHtBRqiqTAb9AQa6nyX8f0qGjVgeED0dlF8kmtj52X+USktbgR3L/8uEftrUtQ/enPhyByflYK3B1GAExGwKTWLZ4wvqzoLXqs64AU8Ugv0ACW+AnW+xdj5pv8QtvbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HBl+Lj/v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB1D0C4CED1;
	Wed,  4 Dec 2024 17:46:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733334395;
	bh=F0BY97kC01D0tVL/a3R3NDyHwQffFD6fAFOe6yb2nP0=;
	h=From:To:Cc:Subject:Date:From;
	b=HBl+Lj/v8xpiK7lbBG5aKB+3EkJw/zh37aS6KT3OvesrRMt1IbpUAPD5G/e9PLig9
	 31mrRaduvuokldrySnyr7UDuoM/vUqwGSYlmv5DaA/5GMdjQdsNybLj/CGeXt/mKZu
	 JMSloB20mB1Fcd9tLBsiT2tzxzKAKeMZAm6ALObd0Xf5HnS5+5YDf9p5uJiqkC53uS
	 UuUnwUUgladMJ0uVv4qsaSJPonWCS8SOwPteTey/wlcdUvQOWnnfsJCYswa2hvJHFu
	 zDqUp2ROMX3tQxaNxWWSkUSOYFNtOuFUoM6yiyWpQG7yaAWtNmzgaui3NP9HQBd5a0
	 eKiQN3D5ZYw1g==
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
Subject: [PATCH 1/2] samples: rust: Provide example using the new Rust MiscDevice abstraction
Date: Wed,  4 Dec 2024 17:46:24 +0000
Message-ID: <20241204174627.1151288-1-lee@kernel.org>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
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
* Open the aforementioned character device
* Operate on the character device via a simple ioctl()
* Close the character device

Signed-off-by: Lee Jones <lee@kernel.org>
---
 samples/rust/Kconfig             | 10 ++++
 samples/rust/Makefile            |  1 +
 samples/rust/rust_misc_device.rs | 84 ++++++++++++++++++++++++++++++++
 3 files changed, 95 insertions(+)
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
index 000000000000..5f1b69569ef7
--- /dev/null
+++ b/samples/rust/rust_misc_device.rs
@@ -0,0 +1,84 @@
+// SPDX-License-Identifier: GPL-2.0
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
+const RUST_MISC_DEV_HELLO: u32 = _IO('R' as u32, 9);
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
+impl RustMiscDevice {
+    fn new() -> Self {
+        Self
+    }
+}
+
+#[vtable]
+impl MiscDevice for RustMiscDevice {
+    type Ptr = KBox<Self>;
+
+    fn open() -> Result<KBox<Self>> {
+        pr_info!("Opening Rust Misc Device Sample\n");
+
+        Ok(KBox::new(RustMiscDevice::new(), GFP_KERNEL)?)
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
+                return Err(EINVAL);
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


