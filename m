Return-Path: <linux-kernel+bounces-529162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F042AA42085
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 14:26:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80664172C72
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 13:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 895DE254871;
	Mon, 24 Feb 2025 13:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eF7FF3Bt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE6E19D8BE;
	Mon, 24 Feb 2025 13:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740403409; cv=none; b=s2s28uQYzrF1kCctGbG6cEaF1RMJ/6Jl4xDehrXuT/yOzU376xA6KorfOOxT0bzEn2ToylJrNchTqSe7JOSt7qMf+R8o6rklPHKzIhjBig3it0AMbhmUl6Hr90PaxkOpIGsV3Jjr0qg+dGDs7fCf3dPLDoQ8iWWEWbGMqB/C4lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740403409; c=relaxed/simple;
	bh=otL8qnjlip9+uUZetH2yJjYrOd8m4ifjYcTxxT7VZwY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=K1zXFEHkpq+q5gRLATL+0MoIRGYqZHPbi7LzpIOptMgTMdzhgOOVGBiFM/lLGqM8Z0MFQXMtKd2h90h9YbZe/L5cfRVi4y172olq5OsoUKgTkrQxu4LCQn7UDxqfYYJSLz+DLahc4bZLY9UT8cfHi+DDeObx3nbfL2/faP8DkZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eF7FF3Bt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67A3BC4CED6;
	Mon, 24 Feb 2025 13:23:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740403409;
	bh=otL8qnjlip9+uUZetH2yJjYrOd8m4ifjYcTxxT7VZwY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=eF7FF3Bt712Qhq5XiFG7I4j0TBw0p2hkYgLkK3BRylDwVMGedCi2+qA+crGvHbsc4
	 QFJfjjgC5BE5wCOkci4IjqddPAJBSt28AMnnvJ6yK1rywfVyq/sbt6VEkO0xtWPDiP
	 nilEbIEgMfud4iX84YumCvFzYVSWBNlAp2Z7DkEyO2FalfFN5ziJiflukDObVlTJmO
	 U20NM5sLkaNFPRbw4kBt2P7N9pd/2soY1vzfuV8mLJ0oTDD3QkuXpphTOPyK++hMAw
	 CpUmyixyZ8XukCFWCGvsEMlP33YPjibh0PrVVO6pIcuSEFcnG53+GQhtixwn3gbYro
	 StuEJMK/ahnIg==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Mon, 24 Feb 2025 14:21:53 +0100
Subject: [PATCH v4 3/4] rust: configfs: add a sample demonstrating configfs
 usage
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250224-configfs-v4-3-9af9b5e611f6@kernel.org>
References: <20250224-configfs-v4-0-9af9b5e611f6@kernel.org>
In-Reply-To: <20250224-configfs-v4-0-9af9b5e611f6@kernel.org>
To: Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
 Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <benno.lossin@proton.me>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Joel Becker <jlbec@evilplan.org>, 
 Christoph Hellwig <hch@lst.de>, Peter Zijlstra <peterz@infradead.org>, 
 Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, 
 Waiman Long <longman@redhat.com>, Fiona Behrens <me@kloenk.dev>, 
 Charalampos Mitrodimas <charmitro@posteo.net>, 
 Daniel Almeida <daniel.almeida@collabora.com>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Andreas Hindborg <a.hindborg@kernel.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=6447; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=otL8qnjlip9+uUZetH2yJjYrOd8m4ifjYcTxxT7VZwY=;
 b=owEBbQKS/ZANAwAIAeG4Gj55KGN3AcsmYgBnvHJ4zCRWFkBVtZJzM5npHVoAndyA7slVLRbEQ
 I5RYlkbRI+JAjMEAAEIAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCZ7xyeAAKCRDhuBo+eShj
 d5LqD/9nZ97+EJf4Z8oycCR3vaz7rWJXOpmijX9jy5x9EDZKi3OhVou2WPZQMkNSoMQFBWVXF8Z
 qIWRWBAN6vcTJ6VUk1uAuqo4zAF13h2sywuMdfL2dFMI7P+o/6i8NcPDNR4Jh4ZUQdTd4fRmeDn
 m32u2EzgaG7YFQ2zsF6UTmkpGlJ/CGok5NkT7s81bZTu2lFYRxTfguE7pgEhLzFSjyHkMlQhZeA
 e90PsqSfYWELDK5RySqmknH/pEgr+8zmNcP9nge2X1dWZsNgGqBi6DR7Dk4n8fGLGtV/S+QJatZ
 qrXTVyNqDGOya0ukfPMvt4svVsX0FUeEXEfvNTPk0xSDQCnYbs922u+tOV8Aj6WD6+htIR6i2zF
 zRhHwbErNXfoS4mvCvVocAZGrlLGDpaJEokwLZtjP3hMQfwPlkpG4Me6CaeBKZIQ8p+u8Wep6wX
 RiN0wnChLi9A9+pYEjmY/Nh/plGvAaI67oJF93e3uupZKfTQ6gegB4CnBS++55WNMFegY/ZJ2aR
 Vm2hwqD08u8X7n1E5gMj9JqGk5ZFnrjCSLx6svUqKbfk1yc0LGRuldSnqHMAgSqaeP5/cxGagmI
 8v8Ack54H9CcuCBht36sbBI9siJ2JJloPRrnYL58BxjcN48CnUMBX32PWwmCA+TusPJH8sUt6iY
 REhswEwez7qA52A==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Add a sample to the samples folder, demonstrating the intended use of the
rust configfs API.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 samples/rust/Kconfig          |  11 +++
 samples/rust/Makefile         |   1 +
 samples/rust/rust_configfs.rs | 179 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 191 insertions(+)

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
index 000000000000..36a2c848a979
--- /dev/null
+++ b/samples/rust/rust_configfs.rs
@@ -0,0 +1,179 @@
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
+        pr_info!("Show baz\n");
+        let data = c"Hello GC\n".to_bytes();
+        page[0..data.len()].copy_from_slice(data);
+        Ok(data.len())
+    }
+}

-- 
2.47.0



