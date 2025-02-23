Return-Path: <linux-kernel+bounces-527857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 021C4A4108B
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 18:42:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB7F0173303
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 17:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B0A715666B;
	Sun, 23 Feb 2025 17:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O+n5EXZs"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E42E81727;
	Sun, 23 Feb 2025 17:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740332552; cv=none; b=oRVqTw5zx0o+1PRtSwHKVqLvWqLHzOzky5/Y2zbA/Bc48BVIdrWrrMTwUzVocMCvyP868AFSNJoAxfX49ROGCRkij/o4Rl/C6dzibB8JI6RZ4hXjqqPNwq7j/8PxqXq0aPXqyYu8JmLzeyCubQnlu6XCOcXVOl8waMpSUjBaHnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740332552; c=relaxed/simple;
	bh=NvsboGZDQg2K6gbDOlFfp6AG8Dc0DEPLS28koKynLpw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=t31948mxXaaA0fVBiqlEE6WBxIyssNH5jskEQbINbFvP/grDVGSIHbke2/rIFc8SwaKMPoTyt8b/vMajxv3UlnVVa32lqruMq6wRUCIDWjD0lzIFSrY8RGdPUP+8z9B8qUU4GM90Sp8hbwMHghnGzyy4a7JaN4tOSjNh4qVbayI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O+n5EXZs; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2fbf77b2b64so7532572a91.2;
        Sun, 23 Feb 2025 09:42:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740332550; x=1740937350; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rPK9X6DcPZjak+3FAEnmi0RwUkfaASpRjIZbmzsOugI=;
        b=O+n5EXZs9QKp1Ly/p3mo0dHhiCUrJPI0aQLNeHFhKkqVQQLWKeA8g4/9j06h5Z5aSe
         KixdjukUx3JKNrvUe5g9dqLRAxhoONssFdOTj7KwYXVZTwlwghI19RSBD8QbKMwDWflK
         Wu9/xH6+0+PNO4eDtN+NiXUGc5y/UDCmHs/u5mIgdmQu55VbvUDFRn8B6wvxZaX/FAnE
         Cvb+XNJTaNJIAf1o8f7XNx5zdnvk//0EysDSzcOhWOMU5EjsSvSLBei1wUYZtr3IWRDT
         +rtHxnHahMkZC67YzOj7Hlf9XHImvHEKxdxIIBSERkKi8sx6l1AuMfBO+cyJSNBxdrnP
         kNww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740332550; x=1740937350;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rPK9X6DcPZjak+3FAEnmi0RwUkfaASpRjIZbmzsOugI=;
        b=SDvHBzYl16lsXH5NEF3lDT19ezKRkOjQr3ZY84EaubGB/bFg5mkBdEk6sSIECNvUul
         dgj54fhVIOAAXfxra+7vzhRF2IiqyKOMA9mJsd0BzmFtp+LwKd+WeetXTFGm0J+4Oead
         tjVrIKkp9qnCecTujAghKjMwZbbu8cVZ6Bw5GHR6/+2AcinrhV6gn3tXukN1FHz7B75e
         1Z3BxhnD44CG0ds9f9z5g0CQYwozIg4VD0SO2nZYEfaMnH/ki/Cws7DUdp1ldKeFzj57
         c2bdxgAEBLth/lYyOxTPma0++5mrECJce0Bd4ivQHNb175EsX9//J/iuFXGdgYvn5YvJ
         H2hw==
X-Forwarded-Encrypted: i=1; AJvYcCUYptO0J2NSOpdZlMganJgpSvQCqfqCQCnXgeFZFCaKOWhMbwX01753g3lFKFL38GBRywG2vT+y1pbcrSlMJi8=@vger.kernel.org, AJvYcCXXZ1TV7rcEBcoJdi7dceOKKpvxa8UpBTo9lOztB26vPTnrqYS5Gi3HZg4okt0DGs7lMCIhGnysIuJpEao=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAR6XxjT+kBg5rgIXa5YgdQceRAIXeu2XRL3lHMHgLZ3etnz08
	BHr23rAAHi/JQRYxOTVR86jd1cHVz3RaQh7A8Z95MzaZgUiU47aJ
X-Gm-Gg: ASbGncvvZxtAokz3l+TdE4xm2ru18sE+pzX0al7k92eNvm2t7NtuBrBxAKq+nldCc7d
	hNbZWCGOBajsFM4PrC9qr9IJnlix8q3QuXoeY4q8CX7GL8t2VNTvwTlmrZ1pDqoNGtTRdCOKzIg
	ehsmyDmXWf2js1y3oyDgl0E+Bskc2DGyr7TQDGmSXiHwvv7PsxNTr40zSHJ7ysct622okjwxlwM
	osYTBfd7rOC00+SchdW57hPpBDoZvzvr+ghLo9eicmEbDp6/a6Diftcdd8NlX7mYDXpncm7O1Qa
	snH1Y5qxrIWUA7Uf5DWY6LyxkfhGoMQjwQ==
X-Google-Smtp-Source: AGHT+IHaIjLjXrMy3VJemKxbmP5jakK+SXN/0/GHcDeAnx7szWlGktubT7pG/EYr6NR7up134aoUbA==
X-Received: by 2002:a05:6a21:9015:b0:1f0:e90b:fdf3 with SMTP id adf61e73a8af0-1f0e90bfeb7mr2115759637.31.1740332549656;
        Sun, 23 Feb 2025 09:42:29 -0800 (PST)
Received: from linuxsimoes.. ([177.21.141.136])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-adb5aa21bbfsm17433834a12.74.2025.02.23.09.42.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Feb 2025 09:42:29 -0800 (PST)
From: Guilherme Giacomo Simoes <trintaeoitogc@gmail.com>
To: a.hindborg@kernel.org,
	alex.gaynor@gmail.com,
	aliceryhl@google.com,
	apw@canonical.com,
	arnd@arndb.de,
	aswinunni01@gmail.com,
	axboe@kernel.dk,
	benno.lossin@proton.me,
	bhelgaas@google.com,
	bjorn3_gh@protonmail.com,
	boqun.feng@gmail.com,
	dakr@kernel.org,
	dwaipayanray1@gmail.com,
	ethan.twardy@gmail.com,
	fujita.tomonori@gmail.com,
	gary@garyguo.net,
	gregkh@linuxfoundation.org,
	joe@perches.com,
	lukas.bulwahn@gmail.com,
	ojeda@kernel.org,
	pbonzini@redhat.com,
	tmgross@umich.edu,
	walmeida@microsoft.com
Cc: trintaeoitogc@gmail.com,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Subject: [PATCH V6 1/2] rust: module: change author to an array
Date: Sun, 23 Feb 2025 14:42:04 -0300
Message-Id: <20250223174205.48404-2-trintaeoitogc@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250223174205.48404-1-trintaeoitogc@gmail.com>
References: <20250223174205.48404-1-trintaeoitogc@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the module! macro, the author field is currently of type String.
Since modules can have multiple authors, this limitation prevents
specifying more than one.
Change the author field to Option<Vec<String>> to allow creating modules
with multiple authors. Additionally, rename the field from author to
authors to make it explicit that it can refer to multiple authors.  In
modules that use the author field, update its value to an array of
strings, and also rename it from author to authors.

Suggested-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Link: https://github.com/Rust-for-Linux/linux/issues/244
Signed-off-by: Guilherme Giacomo Simoes <trintaeoitogc@gmail.com>
---
 drivers/block/rnull.rs               |  2 +-
 drivers/net/phy/ax88796b_rust.rs     |  2 +-
 drivers/net/phy/qt2025.rs            |  2 +-
 rust/kernel/net/phy.rs               |  4 ++--
 rust/kernel/pci.rs                   |  2 +-
 rust/kernel/platform.rs              |  2 +-
 rust/macros/lib.rs                   |  6 +++---
 rust/macros/module.rs                | 12 +++++++-----
 samples/rust/rust_driver_faux.rs     |  2 +-
 samples/rust/rust_driver_pci.rs      |  2 +-
 samples/rust/rust_driver_platform.rs |  2 +-
 samples/rust/rust_minimal.rs         |  2 +-
 samples/rust/rust_misc_device.rs     |  2 +-
 samples/rust/rust_print_main.rs      |  2 +-
 14 files changed, 23 insertions(+), 21 deletions(-)

diff --git a/drivers/block/rnull.rs b/drivers/block/rnull.rs
index ddf3629d8894..d07e76ae2c13 100644
--- a/drivers/block/rnull.rs
+++ b/drivers/block/rnull.rs
@@ -27,7 +27,7 @@
 module! {
     type: NullBlkModule,
     name: "rnull_mod",
-    author: "Andreas Hindborg",
+    authors: ["Andreas Hindborg"],
     description: "Rust implementation of the C null block driver",
     license: "GPL v2",
 }
diff --git a/drivers/net/phy/ax88796b_rust.rs b/drivers/net/phy/ax88796b_rust.rs
index 8c7eb009d9fc..bc73ebccc2aa 100644
--- a/drivers/net/phy/ax88796b_rust.rs
+++ b/drivers/net/phy/ax88796b_rust.rs
@@ -19,7 +19,7 @@
         DeviceId::new_with_driver::<PhyAX88796B>()
     ],
     name: "rust_asix_phy",
-    author: "FUJITA Tomonori <fujita.tomonori@gmail.com>",
+    authors: ["FUJITA Tomonori <fujita.tomonori@gmail.com>"],
     description: "Rust Asix PHYs driver",
     license: "GPL",
 }
diff --git a/drivers/net/phy/qt2025.rs b/drivers/net/phy/qt2025.rs
index 1ab065798175..520daeb42089 100644
--- a/drivers/net/phy/qt2025.rs
+++ b/drivers/net/phy/qt2025.rs
@@ -26,7 +26,7 @@
         phy::DeviceId::new_with_driver::<PhyQT2025>(),
     ],
     name: "qt2025_phy",
-    author: "FUJITA Tomonori <fujita.tomonori@gmail.com>",
+    authors: ["FUJITA Tomonori <fujita.tomonori@gmail.com>"],
     description: "AMCC QT2025 PHY driver",
     license: "GPL",
     firmware: ["qt2025-2.0.3.3.fw"],
diff --git a/rust/kernel/net/phy.rs b/rust/kernel/net/phy.rs
index bb654a28dab3..a59469c785e3 100644
--- a/rust/kernel/net/phy.rs
+++ b/rust/kernel/net/phy.rs
@@ -790,7 +790,7 @@ const fn as_int(&self) -> u32 {
 ///         DeviceId::new_with_driver::<PhySample>()
 ///     ],
 ///     name: "rust_sample_phy",
-///     author: "Rust for Linux Contributors",
+///     authors: ["Rust for Linux Contributors"],
 ///     description: "Rust sample PHYs driver",
 ///     license: "GPL",
 /// }
@@ -819,7 +819,7 @@ const fn as_int(&self) -> u32 {
 /// module! {
 ///     type: Module,
 ///     name: "rust_sample_phy",
-///     author: "Rust for Linux Contributors",
+///     authors: ["Rust for Linux Contributors"],
 ///     description: "Rust sample PHYs driver",
 ///     license: "GPL",
 /// }
diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index 4c98b5b9aa1e..f7b2743828ae 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -103,7 +103,7 @@ extern "C" fn remove_callback(pdev: *mut bindings::pci_dev) {
 /// kernel::module_pci_driver! {
 ///     type: MyDriver,
 ///     name: "Module name",
-///     author: "Author name",
+///     authors: ["Author name"],
 ///     description: "Description",
 ///     license: "GPL v2",
 /// }
diff --git a/rust/kernel/platform.rs b/rust/kernel/platform.rs
index 50e6b0421813..1297f5292ba9 100644
--- a/rust/kernel/platform.rs
+++ b/rust/kernel/platform.rs
@@ -101,7 +101,7 @@ fn of_id_table() -> Option<of::IdTable<Self::IdInfo>> {
 /// kernel::module_platform_driver! {
 ///     type: MyDriver,
 ///     name: "Module name",
-///     author: "Author name",
+///     authors: ["Author name"],
 ///     description: "Description",
 ///     license: "GPL v2",
 /// }
diff --git a/rust/macros/lib.rs b/rust/macros/lib.rs
index d61bc6a56425..7ce1cb891dfb 100644
--- a/rust/macros/lib.rs
+++ b/rust/macros/lib.rs
@@ -36,7 +36,7 @@
 /// module!{
 ///     type: MyModule,
 ///     name: "my_kernel_module",
-///     author: "Rust for Linux Contributors",
+///     authors: ["Rust for Linux Contributors"],
 ///     description: "My very own kernel module!",
 ///     license: "GPL",
 ///     alias: ["alternate_module_name"],
@@ -69,7 +69,7 @@
 /// module!{
 ///     type: MyDeviceDriverModule,
 ///     name: "my_device_driver_module",
-///     author: "Rust for Linux Contributors",
+///     authors: ["Rust for Linux Contributors"],
 ///     description: "My device driver requires firmware",
 ///     license: "GPL",
 ///     firmware: ["my_device_firmware1.bin", "my_device_firmware2.bin"],
@@ -88,7 +88,7 @@
 /// # Supported argument types
 ///   - `type`: type which implements the [`Module`] trait (required).
 ///   - `name`: ASCII string literal of the name of the kernel module (required).
-///   - `author`: string literal of the author of the kernel module.
+///   - `authors`: array of ASCII string literals of the authors of the kernel module.
 ///   - `description`: string literal of the description of the kernel module.
 ///   - `license`: ASCII string literal of the license of the kernel module (required).
 ///   - `alias`: array of ASCII string literals of the alias names of the kernel module.
diff --git a/rust/macros/module.rs b/rust/macros/module.rs
index cdf94f4982df..db16f0af0855 100644
--- a/rust/macros/module.rs
+++ b/rust/macros/module.rs
@@ -94,7 +94,7 @@ struct ModuleInfo {
     type_: String,
     license: String,
     name: String,
-    author: Option<String>,
+    authors: Option<Vec<String>>,
     description: Option<String>,
     alias: Option<Vec<String>>,
     firmware: Option<Vec<String>>,
@@ -107,7 +107,7 @@ fn parse(it: &mut token_stream::IntoIter) -> Self {
         const EXPECTED_KEYS: &[&str] = &[
             "type",
             "name",
-            "author",
+            "authors",
             "description",
             "license",
             "alias",
@@ -135,7 +135,7 @@ fn parse(it: &mut token_stream::IntoIter) -> Self {
             match key.as_str() {
                 "type" => info.type_ = expect_ident(it),
                 "name" => info.name = expect_string_ascii(it),
-                "author" => info.author = Some(expect_string(it)),
+                "authors" => info.authors = Some(expect_string_array(it)),
                 "description" => info.description = Some(expect_string(it)),
                 "license" => info.license = expect_string_ascii(it),
                 "alias" => info.alias = Some(expect_string_array(it)),
@@ -183,8 +183,10 @@ pub(crate) fn module(ts: TokenStream) -> TokenStream {
     let info = ModuleInfo::parse(&mut it);
 
     let mut modinfo = ModInfoBuilder::new(info.name.as_ref());
-    if let Some(author) = info.author {
-        modinfo.emit("author", &author);
+    if let Some(authors) = info.authors {
+        for author in authors {
+            modinfo.emit("authors", &author);
+        }
     }
     if let Some(description) = info.description {
         modinfo.emit("description", &description);
diff --git a/samples/rust/rust_driver_faux.rs b/samples/rust/rust_driver_faux.rs
index 048c6cb98b29..378bab4b587d 100644
--- a/samples/rust/rust_driver_faux.rs
+++ b/samples/rust/rust_driver_faux.rs
@@ -7,7 +7,7 @@
 module! {
     type: SampleModule,
     name: "rust_faux_driver",
-    author: "Lyude Paul",
+    authors: ["Lyude Paul"],
     description: "Rust faux device sample",
     license: "GPL",
 }
diff --git a/samples/rust/rust_driver_pci.rs b/samples/rust/rust_driver_pci.rs
index 1fb6e44f3395..364a0660a743 100644
--- a/samples/rust/rust_driver_pci.rs
+++ b/samples/rust/rust_driver_pci.rs
@@ -104,7 +104,7 @@ fn drop(&mut self) {
 kernel::module_pci_driver! {
     type: SampleDriver,
     name: "rust_driver_pci",
-    author: "Danilo Krummrich",
+    authors: ["Danilo Krummrich"],
     description: "Rust PCI driver",
     license: "GPL v2",
 }
diff --git a/samples/rust/rust_driver_platform.rs b/samples/rust/rust_driver_platform.rs
index 8120609e2940..f7a0f1b29d1d 100644
--- a/samples/rust/rust_driver_platform.rs
+++ b/samples/rust/rust_driver_platform.rs
@@ -43,7 +43,7 @@ fn drop(&mut self) {
 kernel::module_platform_driver! {
     type: SampleDriver,
     name: "rust_driver_platform",
-    author: "Danilo Krummrich",
+    authors: ["Danilo Krummrich"],
     description: "Rust Platform driver",
     license: "GPL v2",
 }
diff --git a/samples/rust/rust_minimal.rs b/samples/rust/rust_minimal.rs
index 4aaf117bf8e3..1fc7a1be6b6d 100644
--- a/samples/rust/rust_minimal.rs
+++ b/samples/rust/rust_minimal.rs
@@ -7,7 +7,7 @@
 module! {
     type: RustMinimal,
     name: "rust_minimal",
-    author: "Rust for Linux Contributors",
+    authors: ["Rust for Linux Contributors"],
     description: "Rust minimal sample",
     license: "GPL",
 }
diff --git a/samples/rust/rust_misc_device.rs b/samples/rust/rust_misc_device.rs
index 40ad7266c225..d3785e7c0330 100644
--- a/samples/rust/rust_misc_device.rs
+++ b/samples/rust/rust_misc_device.rs
@@ -116,7 +116,7 @@
 module! {
     type: RustMiscDeviceModule,
     name: "rust_misc_device",
-    author: "Lee Jones",
+    authors: ["Lee Jones"],
     description: "Rust misc device sample",
     license: "GPL",
 }
diff --git a/samples/rust/rust_print_main.rs b/samples/rust/rust_print_main.rs
index 7e8af5f176a3..8ea95e8c2f36 100644
--- a/samples/rust/rust_print_main.rs
+++ b/samples/rust/rust_print_main.rs
@@ -8,7 +8,7 @@
 module! {
     type: RustPrint,
     name: "rust_print",
-    author: "Rust for Linux Contributors",
+    authors: ["Rust for Linux Contributors"],
     description: "Rust printing macros sample",
     license: "GPL",
 }
-- 
2.34.1


