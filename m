Return-Path: <linux-kernel+bounces-433661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 42DA99E5B59
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 17:27:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BCFB162B1C
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 16:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09191225790;
	Thu,  5 Dec 2024 16:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TPmD4oi/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63ABE221472;
	Thu,  5 Dec 2024 16:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733415951; cv=none; b=jBKaUHZm9K0aO8/h3rpDiB2ONscV+nKMSs+vMkAlZiEmfF3OwZfrRoJV1EqztVwdexJU6d7r825hbOJhnqznnizKyZkpf2skcZ/wDiS1JGZcDoZ8nmq13qiv0d/DT8n0r0iwSXgeG4EQm6singH/XjxKkh2qRokoO2ExISz2v+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733415951; c=relaxed/simple;
	bh=3+8P2k2Anmh2tITJXydjYEGNUs7ATo3i9o4frL4TSpE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D56uB3VLvEdT+C17IB0ChfubHRUzppcfcUsFNiUGuf/Rp7WLbBGvaNA2XfUPraKR1v3a5Pt9YM4De26UDxQYNSypPMLX+qL7VIRARid7uLIpvfvmFJsL/FM4Y/cnyfGt8Y9vETk1WbqzHBeGePXbUVZ3VrrWVXkua8BbbTu6Ato=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TPmD4oi/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3875EC4CED1;
	Thu,  5 Dec 2024 16:25:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733415950;
	bh=3+8P2k2Anmh2tITJXydjYEGNUs7ATo3i9o4frL4TSpE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TPmD4oi/kGmSLyHwK5VgDYwcmbyBX1xxpZZ9/iH4CMzyRVLOxJLeePz45ZpjVv2gz
	 XaHwKCztY0dN5wOufnGwxAx6wFeKQT/W6jyJegJ2Y1ZzS7TCJk4Mesf4wTfK/7ia81
	 7oM8nAVWqKIwJ+RTI7azXAGvsSQjYdDqwGxJXHwuAv7Pm1NitAW+h63R2i7Fclw36S
	 uqJ3p0TYTDh3sf1NYtrbzuacoGxP/Bbp5maB4nq4gyCmtmicugFXUkwpho1CASHYcT
	 yiHzlK+kpuVK3bRVYGOuApep20+uxzr+XkdEjB8DY6vAJdjg9+S3a9pCBSZ621ndRu
	 lIJthvgllgPSA==
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
Subject: [PATCH v3 3/5] samples: rust: Provide example using the new Rust MiscDevice abstraction
Date: Thu,  5 Dec 2024 16:25:20 +0000
Message-ID: <20241205162531.1883859-4-lee@kernel.org>
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
index 000000000000..f50925713f1a
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
+                return Err(ENOIOCTLCMD);
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


