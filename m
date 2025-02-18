Return-Path: <linux-kernel+bounces-519426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B104A39CBD
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 14:03:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 932283A581B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 13:01:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4064B2676E8;
	Tue, 18 Feb 2025 13:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gjRa/E+2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E91B266F19;
	Tue, 18 Feb 2025 13:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739883696; cv=none; b=Vv83MODJD+1cDMh4awQUhrgyACzKF0Qt+mgIGooc5zWuQXK3SH7tQr9JsHP8bDKo/sa2Dn5kq3fSCnEEoWzA8sBoBTyhdLqVEJlZ96LxxQJL58j/sMhV0CcMzYWzkc3IyWCZCha05JBZ0yKR2oYoKTJ0K+NNqV96TOy1SIpbnqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739883696; c=relaxed/simple;
	bh=utOYMK9wxdhg7AQtrh9ChFcDPs7Qi9/RVDGLNBePUoU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GmMGaufLaFb81hbFOpt/F3rzaIRTKtc+jxwoERVWycZzvRVWXNGmBY8zm3EZUM+UnEedKfY8k9h2cChVgJvVEP8OwqmboyHHs5+0yy9P9nheJ2NA6tC2EnKVNFpi8vImVfW53Sp3vpK8XcxX4SCqyOnph2X65oVweLEmIQWsT8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gjRa/E+2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3238C4CEE6;
	Tue, 18 Feb 2025 13:01:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739883695;
	bh=utOYMK9wxdhg7AQtrh9ChFcDPs7Qi9/RVDGLNBePUoU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=gjRa/E+2VqZEgbzH2IgMG0bXv1F0TZo2/B/7EjgaTaATDR0bHPuo8ttuJ2KEKz4dD
	 CAyZ+mJLdlsRADqRWcgbmGFJz7czhJh4l5A9YSGt5P45UHMen0/Fqs8XnTdG5Ju7X5
	 CNLuEEVAuW1OUwnRb3jTpxSoZvXsl+NTFkwAf51kMJD7HDdOOAEqnLY4AKf7Xrk1x2
	 ic9u4eCz1IKgrVXlhd14yOrKoaU5SMK24FmkLpoCSZYf498Ks+wYutn8NKKbKx/LB4
	 syEytg4TCyMonsjmwn+UioSwq8SqL7cLZNfpVJegv/iFJt7re72n6UE10FrH+w8XCv
	 PriNDQ9yfUPwA==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Tue, 18 Feb 2025 13:57:18 +0100
Subject: [PATCH v3 3/4] rust: configfs: add a sample demonstrating configfs
 usage
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250218-configfs-v3-3-0e40c0778187@kernel.org>
References: <20250218-configfs-v3-0-0e40c0778187@kernel.org>
In-Reply-To: <20250218-configfs-v3-0-0e40c0778187@kernel.org>
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <benno.lossin@proton.me>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Peter Zijlstra <peterz@infradead.org>, 
 Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, 
 Waiman Long <longman@redhat.com>, Danilo Krummrich <dakr@kernel.org>, 
 Joel Becker <jlbec@evilplan.org>, Christoph Hellwig <hch@lst.de>, 
 Fiona Behrens <me@kloenk.dev>, 
 Charalampos Mitrodimas <charmitro@posteo.net>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=6453; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=utOYMK9wxdhg7AQtrh9ChFcDPs7Qi9/RVDGLNBePUoU=;
 b=owEBbQKS/ZANAwAIAeG4Gj55KGN3AcsmYgBntIPAMU1QnCc4uVHRNsgKlsG9VzjytL4o/H9Ga
 ZBI+WFxEPWJAjMEAAEIAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCZ7SDwAAKCRDhuBo+eShj
 d7aFD/4+0UNN7hgWFNnRmCkW5MpE/aRmgbio6dEkzdLSvbYwsvtOAIQdK/WSAmTaC4bJ853V0gU
 W1Vx6K0fqLhZD8LWvVwKMYydQN410+yFAx+mdXDWRzqdbZbAXagIV95uYUqJXMsfL9Orf5p4N43
 Kr6xRKTg3juscIwoq9Pm1T+FTy2rYR+XPbatVuCr5Odjl889i0oGeZKcTO+loSXCvmZqQ+UU+Lx
 DdtdI9uY3gCyuRsh0V15QQfZLd819hRpQG8Lp7SACGb2mXhlasNFkU0T8c4tP6Njygs3AXLWFbu
 OCeghUQ6lSiPQSpK0F2zO6PS4IZKpvmST3cD/U1p+2bzWIG6bSmLRVzczX+9P/Bx4CyDxErav60
 OX2/XNBHdmgoAAnLfcl2ZT0q/V1gynaqYQZZ6p9Y7oaoR1UJ9wL+1gr92YADf9xUQC7vAYAyiOk
 FDr9+NZyTOBNiqp16BA4TUJUuFmG6I9MHf6XJDu9r0K6sEaqgQFHqr8i5EVAIn8AmwDUKxGLjDT
 UILXqdDpLtFA+BPaZH/nDZO0gnPZW1aXZCQTfGYTBvH+rJAkJI+gsf+m03UpEvWL+lA3kjEYn8K
 EZR9Y0DuTNcTAUR+jfaqxAw331gmeNGKzTRysGd71SPLZXIFoG+DzFQnK/T0TD1KLtBCNinGS0G
 2BORAale5DTVCAA==
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
index 918dbead2c0b4..2f97bf9a7b4cc 100644
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
index 5a8ab0df0567c..72122f010cafc 100644
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
index 0000000000000..36a2c848a979a
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



