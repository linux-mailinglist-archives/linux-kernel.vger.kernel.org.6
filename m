Return-Path: <linux-kernel+bounces-551140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30077A5689A
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 14:14:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B7CD16F288
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 13:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96C0621A44D;
	Fri,  7 Mar 2025 13:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KKC0m/f5"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF0D421A43B;
	Fri,  7 Mar 2025 13:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741353270; cv=none; b=P7yfrdDG07Q80zMP4z7K1RM1IdWQVazl6v8k8EUut55PoT6ur2cFcFCDZ00QqwzZWWoFJgqWsmtM66V1YqrLrwKpM9nzbx5yo6nJYzt3tbfIpLLVPwoWokRJVJvZJeiuiTJj2kLwqO6Tzstr8dGJrzOd962G7Ama7qooJr32mL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741353270; c=relaxed/simple;
	bh=NvsboGZDQg2K6gbDOlFfp6AG8Dc0DEPLS28koKynLpw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CfWYACY8W5ounkvnLho0rjkBR/g3GF/2UGDZQSwwbcOcMyBn0RdwPZaLaFzovU+ob4Bzyl6OEbYAqW0fScnKVXVYW3Pae+YTWn4EAoefPM6O8sePCeCe+llBV9Sl1nP4D3Fkm07V4XJB3vEZYqMMc88NTgc9SV2f5ZfRAl9a9cE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KKC0m/f5; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2ff694d2d4dso2626470a91.0;
        Fri, 07 Mar 2025 05:14:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741353268; x=1741958068; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rPK9X6DcPZjak+3FAEnmi0RwUkfaASpRjIZbmzsOugI=;
        b=KKC0m/f5WoIckLYGKLYdZxkA8LkF1ANlvTiILiqYj587gxCCeAVjUlOIE/t0VbmIUM
         ekerf5bZq59NZFFNRPwpa3YV+jNhGRDfdq52ErYNgN8CftCgthibcZRtuWpOgIShgLFd
         1qRk+gn7vEHlcGU8k0W/jyfL3dlr/GWFCUAY0oGfbU9jRm852mY3bjhT4b1oKUT0S7Yo
         LHcbnIn9cjQXHuBLjiormHL3FD5pXnmS4e8eJNYyKD/08nGmCMwPeGG+6NbI5MKImK7V
         JCFV9icjTwbFh6WeUmeJWoKfjw6/p6esE4z1a3BjNx/jza/JQQsSWSTN/VnKeSnirRSr
         /wng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741353268; x=1741958068;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rPK9X6DcPZjak+3FAEnmi0RwUkfaASpRjIZbmzsOugI=;
        b=aZrYVUBD5FAp5es7+xXAWocjfR3XCEZ69xXtMqJ6vXBJRavcEkwyLm0Rx1lrLMIQCh
         /aTLAmZAO56yEQlyEV5WTpkYPp9wa0rkGX9KHG9FJUzbPod5ufLlbg2qUqGf8AmqkOOy
         tk66xFsbCnJ2uehJ9l5S2+tu6hQWVYhSdqx7zKj5ZhzbtsfV1lQ4wDMEigGwuE30lDDy
         7IFy+Iqj0lXoGZoKivcB5c4QpWeAu6eglq1YLd5dUqypFxp8aMguzqt/j4LmbSLlFcDr
         mHxFEf2kMVCqasTrUerUNaREyHxHmg1z/8R/7Q9jYJ6g8hL3EVVAS5llXzvc1Qbcy9LE
         bClg==
X-Forwarded-Encrypted: i=1; AJvYcCWm/WH3qQQJbrlRngwoqeZcDx4AcGFO5W4JtnhEWzHhIcyT5NpLxdqBdEEY3998WxUOBfzAKQKI1AuawF1K+bs=@vger.kernel.org, AJvYcCXgWVuQOVLqJNmORreHkNbQVuuszyp9KLScpAE63DbC+0z1fVT3tnPR4XCK46V9b05uDOcUGyvRMjAGNDw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNf3IcbHjrlPuTSqx15sLVW2kSbK20oMjrUuyryAX+cBi+XOEq
	nPZCcQq9GErM55ybxUL1M6BGY7tNAVgEKplWJZqKnZWRYK2yHYsvwAqX73FM
X-Gm-Gg: ASbGncvJoeKoWGKcalh2yNHnRv3FcpEowC+KdooEbMpVROk1dHMSmDge6vw3EnjO74K
	YkK+f+4fBcjhyhvL+5zLe9rj8xVlwABhQ+HQW7Of1C/C1pIOMhf8XhRZAWeyZPFWAYZaBE7ua6D
	szDH5HIiKt0IMn/KocORj7fYDydvfrj9hr1AmFY4n3nT3f/b19y0Jo9q9Z5xjdJBBixTc7m7Qrf
	TaInDjFKhXDGU0dYhmFVFiiLH4YBNlBjor+fowUTXuy7zu8SOdIO22dyUTdNSSbDxOqp/WCj1rv
	A3yjdA+XCRr6i5iAvHPkeXePURs0kHOC60Ed8UkmF01aAAI7Vwda
X-Google-Smtp-Source: AGHT+IGWoRF3Dqzu+JKL6bylmz5e0XGkN5KRmJYXx91gZ/QfWRtIFfDbpEjcFIqSreMJX+PPWrdP7w==
X-Received: by 2002:a17:90b:2d82:b0:2fe:7fea:ca34 with SMTP id 98e67ed59e1d1-2ff7cf134b7mr4769660a91.32.1741353267939;
        Fri, 07 Mar 2025 05:14:27 -0800 (PST)
Received: from linuxsimoes.. ([187.120.156.44])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ff693e7358sm2965708a91.30.2025.03.07.05.14.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 05:14:27 -0800 (PST)
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
	walmeida@microsoft.com,
	charmitro@posteo.net
Cc: trintaeoitogc@gmail.com,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Subject: [PATCH V7 1/2] rust: module: change author to an array
Date: Fri,  7 Mar 2025 10:14:00 -0300
Message-Id: <20250307131401.638820-2-trintaeoitogc@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250307131401.638820-1-trintaeoitogc@gmail.com>
References: <20250307131401.638820-1-trintaeoitogc@gmail.com>
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


