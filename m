Return-Path: <linux-kernel+bounces-536293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 76676A47DDF
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 13:36:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C92C8169AD1
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 12:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC40E22D7B6;
	Thu, 27 Feb 2025 12:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iUy8cd1M"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D512122A7F6;
	Thu, 27 Feb 2025 12:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740659782; cv=none; b=IxQw56GvbH+4rnY07RAr1zlWfyd55obeLDfSrSk8jrwzqDbdgG08nGhO4uN9OlnTeMScZVE0z8WyemcYo3vgZcA590wePcpMEP1Vwz3Z5B8T4+TA9PHSg0D4BoD/6uC30mK+vv9YNTAuE9ug1uCAXwsdSf6fGnwVK4/4Rk3PO3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740659782; c=relaxed/simple;
	bh=gzrlI3NvliAeMzY2cR5gAtmOUHFIU5X+KgYZJE15a2U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nt4LtIhCe2ZNkAkXyIzBFGy3k6dhTryWygYg7997m992lucFCZ2wti0aeLlRKat7D4Cn2slwNSisoB+wiCM/CcMnmrSs9G988rXuonwvIltUDsmt484M+OL8oObByF4260wvDNEXJFM7sUht9bosnd0O/4MMH2r2mVkPuMz1WGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iUy8cd1M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEFF2C4CEE7;
	Thu, 27 Feb 2025 12:36:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740659782;
	bh=gzrlI3NvliAeMzY2cR5gAtmOUHFIU5X+KgYZJE15a2U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=iUy8cd1MrSbRfzLJcWrBGqRIq1CmJMJU47eFxswPs+H/mxAh8ay2Bmh8uO02Q4UAz
	 32QSBKv/+HK0karLOPiDcJYgkOaZLgTAgZvoorWglxhTzyOQyoGy+VXL+Kdij7RQFX
	 Kf4Qtb77lMz1JYue3OTfFZAuaWSBTwt6TEWlyB5PUQjxYLRxJLF4yGgKY4fihzJB+v
	 cklMY/65l+FTgnZYN0BEArrSty1UCVUWSmpmCQZ+iywWzm/KEH3YXdO/70EKTuJ90n
	 JizkKCTo54tcMU0F9W3lNUKaFSZCfMm5zxZgiTAXFqvgt+g7EodE12ecOtUK+lNomd
	 pdErpMZ2PcJtA==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Thu, 27 Feb 2025 13:35:12 +0100
Subject: [PATCH v5 3/4] rust: configfs: add a sample demonstrating configfs
 usage
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250227-configfs-v5-3-c40e8dc3b9cd@kernel.org>
References: <20250227-configfs-v5-0-c40e8dc3b9cd@kernel.org>
In-Reply-To: <20250227-configfs-v5-0-c40e8dc3b9cd@kernel.org>
To: Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
 Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <benno.lossin@proton.me>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Joel Becker <jlbec@evilplan.org>, 
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, 
 Fiona Behrens <me@kloenk.dev>, 
 Charalampos Mitrodimas <charmitro@posteo.net>, 
 Daniel Almeida <daniel.almeida@collabora.com>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Andreas Hindborg <a.hindborg@kernel.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=7360; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=gzrlI3NvliAeMzY2cR5gAtmOUHFIU5X+KgYZJE15a2U=;
 b=owEBbQKS/ZANAwAIAeG4Gj55KGN3AcsmYgBnwFwENgm3R24ZkxTGWcOD/P0IMW3hqMHyLRHS0
 CVMHcP6U+GJAjMEAAEIAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCZ8BcBAAKCRDhuBo+eShj
 d7BSD/4y7okTZ9NcETQJNgWB/ZAUywfauH+Grw0W6iTnYSOa/PkyWNZAyZA3IUG4yV/1nIf4bAi
 j0YxaOiWqqcSgoU7Jrqa9pVS/tUniTmj9p/3SQlCTq9vo+arm/ykSOffiVTRMjX98KIMaCraAuQ
 WLRUe9e/Rgl/Ml+pfJglK5xAj7iZTib4NqECSt/Vega34bW3+gPQwTM+CY2uWOrVpoEwXcTbc3k
 PFU8NqwPSdjnN4fuTWV202IAMWNSG9nTNjGVCBLUKa/T2kmA5cS5MAh82xT5WZT7W2zIN3o7o4z
 NgiOqoNVpGrlWQBtVR20lg33AdvzKmV+KWCCMzOvaSNtWmRSvOb+MWn3e4njgDUvBi//0CGnghM
 QxXqoMeUWY2cI9VnGsCjVpVMr6RoRS8Ip0L5cBRvXqaSmZYdlW/JsX9PPH6VWlTAcD1T9FQ9jt0
 xqhupr2uR1RxJ93dh/Zp/k1A/qtCeJUI8yKC27nbn03NjKAT+eZ6l7TwPu9yu+/OrRbnswRd5Oj
 ZXt3Qnz0CAvg6z05OUMRzv9myfvaSaajVdyytOrzdfiyKNX0fV0CMFps/3U7YCc2u1aJ3jt02VR
 gOFzJKgIi7LdrjUQmZdG2jBQ15noyk8ImcnTATn809uXoPxtX72CuIJAijX0uKnTsf5DsNSAKkB
 8YMPLzrAxH7/A4w==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Add a sample to the samples folder, demonstrating the intended use of the
Rust configfs API.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 samples/rust/Kconfig          |  11 +++
 samples/rust/Makefile         |   1 +
 samples/rust/rust_configfs.rs | 192 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 204 insertions(+)

diff --git a/samples/rust/Kconfig b/samples/rust/Kconfig
index 918dbead2c0b..2f97bf9a7b4c 100644
--- a/samples/rust/Kconfig
+++ b/samples/rust/Kconfig
@@ -10,6 +10,17 @@ menuconfig SAMPLES_RUST
 
 if SAMPLES_RUST
 
+config SAMPLE_RUST_CONFIGFS
+	tristate "Configfs sample"
+	depends on CONFIGFS_FS
+	help
+	  This option builds the Rust configfs sample.
+
+	  To compile this as a module, choose M here:
+	  the module will be called rust_configfs.
+
+	  If unsure, say N.
+
 config SAMPLE_RUST_MINIMAL
 	tristate "Minimal"
 	help
diff --git a/samples/rust/Makefile b/samples/rust/Makefile
index 5a8ab0df0567..72122f010caf 100644
--- a/samples/rust/Makefile
+++ b/samples/rust/Makefile
@@ -6,6 +6,7 @@ obj-$(CONFIG_SAMPLE_RUST_MISC_DEVICE)		+= rust_misc_device.o
 obj-$(CONFIG_SAMPLE_RUST_PRINT)			+= rust_print.o
 obj-$(CONFIG_SAMPLE_RUST_DRIVER_PCI)		+= rust_driver_pci.o
 obj-$(CONFIG_SAMPLE_RUST_DRIVER_PLATFORM)	+= rust_driver_platform.o
+obj-$(CONFIG_SAMPLE_RUST_CONFIGFS)		+= rust_configfs.o
 
 rust_print-y := rust_print_main.o rust_print_events.o
 
diff --git a/samples/rust/rust_configfs.rs b/samples/rust/rust_configfs.rs
new file mode 100644
index 000000000000..9c0989072a8f
--- /dev/null
+++ b/samples/rust/rust_configfs.rs
@@ -0,0 +1,192 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Rust configfs sample.
+
+use kernel::alloc::flags;
+use kernel::c_str;
+use kernel::configfs;
+use kernel::configfs_attrs;
+use kernel::new_mutex;
+use kernel::page::PAGE_SIZE;
+use kernel::prelude::*;
+use kernel::sync::Mutex;
+
+module! {
+    type: RustConfigfs,
+    name: "rust_configfs",
+    author: "Rust for Linux Contributors",
+    description: "Rust configfs sample",
+    license: "GPL",
+}
+
+#[pin_data]
+struct RustConfigfs {
+    #[pin]
+    config: configfs::Subsystem<Configuration>,
+}
+
+#[pin_data]
+struct Configuration {
+    message: &'static CStr,
+    #[pin]
+    bar: Mutex<(KBox<[u8; PAGE_SIZE]>, usize)>,
+}
+
+impl Configuration {
+    fn new() -> impl PinInit<Self, Error> {
+        try_pin_init!(Self {
+            message: c_str!("Hello World\n"),
+            bar <- new_mutex!((KBox::new([0; PAGE_SIZE], flags::GFP_KERNEL)?, 0)),
+        })
+    }
+}
+
+impl kernel::InPlaceModule for RustConfigfs {
+    fn init(_module: &'static ThisModule) -> impl PinInit<Self, Error> {
+        pr_info!("Rust configfs sample (init)\n");
+
+        // Define a subsystem with the data type `Configuration`, two
+        // attributes, `message` and `bar` and child group type `Child`. `mkdir`
+        // in the directory representing this subsystem will create directories
+        // backed by the `Child` type.
+        let item_type = configfs_attrs! {
+            container: configfs::Subsystem<Configuration>,
+            data: Configuration,
+            child: Child,
+            attributes: [
+                message: 0,
+                bar: 1,
+            ],
+        };
+
+        try_pin_init!(Self {
+            config <- configfs::Subsystem::new(
+                c_str!("rust_configfs"), item_type, Configuration::new()
+            ),
+        })
+    }
+}
+
+#[vtable]
+impl configfs::GroupOperations for Configuration {
+    type Child = Child;
+
+    fn make_group(&self, name: &CStr) -> Result<impl PinInit<configfs::Group<Child>, Error>> {
+        // Define a group with data type `Child`, one attribute `baz` and child
+        // group type `GrandChild`. `mkdir` in the directory representing this
+        // group will create directories backed by the `GrandChild` type.
+        let tpe = configfs_attrs! {
+            container: configfs::Group<Child>,
+            data: Child,
+            child: GrandChild,
+            attributes: [
+                baz: 0,
+            ],
+        };
+
+        Ok(configfs::Group::new(name.try_into()?, tpe, Child::new()))
+    }
+}
+
+#[vtable]
+impl configfs::AttributeOperations<0> for Configuration {
+    type Data = Configuration;
+
+    fn show(container: &Configuration, page: &mut [u8; PAGE_SIZE]) -> Result<usize> {
+        pr_info!("Show message\n");
+        let data = container.message;
+        page[0..data.len()].copy_from_slice(data);
+        Ok(data.len())
+    }
+}
+
+#[vtable]
+impl configfs::AttributeOperations<1> for Configuration {
+    type Data = Configuration;
+
+    fn show(container: &Configuration, page: &mut [u8; PAGE_SIZE]) -> Result<usize> {
+        pr_info!("Show bar\n");
+        let guard = container.bar.lock();
+        let data = guard.0.as_slice();
+        let len = guard.1;
+        page[0..len].copy_from_slice(&data[0..len]);
+        Ok(len)
+    }
+
+    fn store(container: &Configuration, page: &[u8]) -> Result {
+        pr_info!("Store bar\n");
+        let mut guard = container.bar.lock();
+        guard.0[0..page.len()].copy_from_slice(page);
+        guard.1 = page.len();
+        Ok(())
+    }
+}
+
+// `pin_data` cannot handle structs without braces.
+#[pin_data]
+struct Child {}
+
+impl Child {
+    fn new() -> impl PinInit<Self, Error> {
+        try_pin_init!(Self {})
+    }
+}
+
+#[vtable]
+impl configfs::GroupOperations for Child {
+    type Child = GrandChild;
+
+    fn make_group(&self, name: &CStr) -> Result<impl PinInit<configfs::Group<GrandChild>, Error>> {
+        // Define a group with data type `GrandChild`, one attribute `gz`. As no
+        // child type is specified, it will not be possible to create subgroups
+        // in this group, and `mkdir`in the directory representing this group
+        // will return an error.
+        let tpe = configfs_attrs! {
+            container: configfs::Group<GrandChild>,
+            data: GrandChild,
+            attributes: [
+                gc: 0,
+            ],
+        };
+
+        Ok(configfs::Group::new(
+            name.try_into()?,
+            tpe,
+            GrandChild::new(),
+        ))
+    }
+}
+
+#[vtable]
+impl configfs::AttributeOperations<0> for Child {
+    type Data = Child;
+
+    fn show(_container: &Child, page: &mut [u8; PAGE_SIZE]) -> Result<usize> {
+        pr_info!("Show baz\n");
+        let data = c"Hello Baz\n".to_bytes();
+        page[0..data.len()].copy_from_slice(data);
+        Ok(data.len())
+    }
+}
+
+// `pin_data` cannot handle structs without braces.
+#[pin_data]
+struct GrandChild {}
+
+impl GrandChild {
+    fn new() -> impl PinInit<Self, Error> {
+        try_pin_init!(Self {})
+    }
+}
+
+#[vtable]
+impl configfs::AttributeOperations<0> for GrandChild {
+    type Data = GrandChild;
+
+    fn show(_container: &GrandChild, page: &mut [u8; PAGE_SIZE]) -> Result<usize> {
+        pr_info!("Show grand child\n");
+        let data = c"Hello GC\n".to_bytes();
+        page[0..data.len()].copy_from_slice(data);
+        Ok(data.len())
+    }
+}

-- 
2.47.0



