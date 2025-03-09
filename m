Return-Path: <linux-kernel+bounces-553265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C00DFA58693
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 18:57:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C272A7A404C
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 17:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B2161EF395;
	Sun,  9 Mar 2025 17:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J68GrS83"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40C371EEE0;
	Sun,  9 Mar 2025 17:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741543058; cv=none; b=CsTeD+ufNf4y+KhshyQMBXC/TGHDdueIeeozkLzDIprBlX3AAH7lQvmoIRilg8RccyyQd/IUWBG+CQ6cOJl9otzWZ0W84ZuMhK3r6Ahz1BCvKvo79NfeZQnjJbWZwkX63OKOam2jf/zgbAguWRpiakwRb0y/9qbBITxMxE6a7lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741543058; c=relaxed/simple;
	bh=JyfmwxfkhDQWHiwgvjB+4jZD9oKTfxClcnB8sh3GvKI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VPGmQqXvwaWX8vRwuzXEDoTL1aoSpSbRSK0/EciTfQDUECzj5hpadow9ALVPRoIe1BYmhahooVvdqqxvRLEwl0v/83hNvUqGtA1HFvfqmvsfIWtLJu131J/vdaTN8sVjs/6y72RoOnnM9g+u25y4T/Mjn76p/FRdy6HX25KSPNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J68GrS83; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-22398e09e39so60448965ad.3;
        Sun, 09 Mar 2025 10:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741543053; x=1742147853; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5tE39xgV6/KwKFHWvHCsh8kdiR8Jp34269cQhzUG4M8=;
        b=J68GrS83DU3ND687GZORJTdLMofyzo3qF53qxaQs8n/Fl9D7FObZH32c+2FuM22cjE
         72NoDLRGtrosqsW1CpqzPRwq6KzLhhCSn/iAYClYam6DDdMY9L2X2DRlgwoZbCu1B6eT
         UE/0ozQaS22vdf+qc0ul+QPtTveoCL5PW8742VmSXDcrwyagJI1Jr29iKnPrqcoAiDG5
         l42Mc/dEnbvQtMJiIMnI1rJte5GtSCBHiuq7jlYcwyxxh2DI3Pcutx5i108CZaDvhtkQ
         R5AvqPlP8AKpVNBjbTDKdSPzAtaPjCtB7IPPCiodLGGehNWyTg1aYhLe3PEmIHvTMT5I
         uCvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741543053; x=1742147853;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5tE39xgV6/KwKFHWvHCsh8kdiR8Jp34269cQhzUG4M8=;
        b=VZqie5RKG+UzNPyz5JFOl7LUh5EDPBzA3Ej8TrpFpO7JIwIUkP24SQ3THRiqTZ6cm+
         YK+6LH1DL7kcq1sR7q054fJl//yjkLzMAH6J2V2QoYZuAHqbrCbMVFYtjrx7t+RXgUq3
         34qxKIofGnP/RHa5JKnnLOUtJxQI323DGOjbmB+yV0Vq+oqpzYFbDUy5dpqg/mtJ5i7f
         awbkAKo/Wa/wTBjgY45ilG1VI21b1dgV77X1YWpaUSs7GkhCbe42kuxav4mPfoU3nPeg
         XDjekpwPXPd2c2kVvnQNh3nUzml3ahn9SfOVvOZaIU1AJhpMMtdskPyP/kqOZC6MDL6T
         9jvA==
X-Forwarded-Encrypted: i=1; AJvYcCUisshKhW18Qp/+Vuse1pwm0ZDPs4rO44os1ZKd1Ny+93b1CV7rwu3KFhuMHvrfYEuqj9Xze2yhzXkLvfEqmPM=@vger.kernel.org, AJvYcCXNB7fwty4aTaA2UuNJFYhewb0gPJdkSBtjt/5Zp21Kp763vXjr0UQvGEKALbEy1Bz1T5DEC9rUbGTOxic=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvYiEhZsiFnBYdqR6He7aKRk82nKefdkZ5gHA4ZfsI3HWC/Upx
	QyCYDQeuohL/R5ZCfTPiiYyd4L4NADbpvyRlG+yn84VVqwF9iwCx
X-Gm-Gg: ASbGncv0KTU1ADBPwdqAj98zHytDTbE2RcjEMvdsodfofTnTGs2bamqtahfBTl2Cs1A
	7jvYbht9t+BgVM/PU1sV+BvlUt1hzVa/yZsDLTjNWL9YIGqUBhlYjJeO78b827+FJfZwj6+yRSF
	SNER/ral6DoYCh/6V+UwBUkRdw5pQ1FYDkHVpPQovmeI32aDN5bwdkgJ+29iPtOdvS8vs+dM0YD
	oA5ZnARgLPh1Pfd1ga5oljZkATSIxx3xHv14ah4aSkLvdFG1ZcaK6sYEXwg188EKfKRaoTMwqzO
	ibPojquKc8SRMS42Wh8aMOw2ixoYiG8bYIHCmafeQDY6aS07qvyOJToYu3n56qA=
X-Google-Smtp-Source: AGHT+IFOhgvAcQT5DCLx8A3LfXsTB9h6JtOpQzqVzw3Q2GufFPipku7mN87Wq1Dv9tCRZ3MBwDdgdw==
X-Received: by 2002:a17:902:e802:b0:220:da88:2009 with SMTP id d9443c01a7336-22428c12f78mr159958355ad.45.1741543053377;
        Sun, 09 Mar 2025 10:57:33 -0700 (PDT)
Received: from linuxsimoes.. ([187.120.156.44])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-224109e944csm62675505ad.74.2025.03.09.10.57.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Mar 2025 10:57:32 -0700 (PDT)
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
Subject: [PATCH V9 1/2] rust: module: change author to an array
Date: Sun,  9 Mar 2025 14:57:11 -0300
Message-Id: <20250309175712.845622-2-trintaeoitogc@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250309175712.845622-1-trintaeoitogc@gmail.com>
References: <20250309175712.845622-1-trintaeoitogc@gmail.com>
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
Reviewed-by: Charalampos Mitrodimas <charmitro@posteo.net>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>
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


