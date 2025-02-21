Return-Path: <linux-kernel+bounces-526432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A18BA3FEA4
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 19:22:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39B5F1888414
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 18:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF2AE2512DE;
	Fri, 21 Feb 2025 18:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a280yu3U"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2073F1D5AA7;
	Fri, 21 Feb 2025 18:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740162148; cv=none; b=SvB+6oi1zPvVIu2mfyxrfanUpbvbmeVtR3ER0lWBWO7TAtJSc7O0C5U9Wy+OnWwRlLgB+N3TH02fvPzvg0qkpQ8TNmN5Yvy9iqkiIdOKRmxX/MgsyzcKEGELFn1t+RBYMZQqd0oMOPq0XrQEDnsj+yckjI60rDkf9GQsEc5DuRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740162148; c=relaxed/simple;
	bh=j49I5wA9J0ZZQnVzg6vNKboZgmNFrZvlly3Q5rj+TMo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gGIE3Kl9RwKSmZLDtfbMS8v7ix/yRUm08HuiGfqgoFdlpF5nzmzhTfbUh9+yL6B+pRMJ3Lhpd/zfYwelh8SxpVURJsTkftIOYfeDxq/UNVSK/Xhkjjl1anYLBc087kjqMAFDfB6FzEua1ZMqbU+zZ2Rc7LWkONPrc1EJrCH0KqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a280yu3U; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-220bfdfb3f4so55403255ad.2;
        Fri, 21 Feb 2025 10:22:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740162145; x=1740766945; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HdO9tVpvAE97bC++aynlan+kCE72STAqZAbZPqphi60=;
        b=a280yu3U0QMOJ6BH5nACb0ywrefLigzfDE/QywV+aYR7JWUVFCz4oDYkeDTbRBoxXH
         zcWw8iM99DMpsl9u6JlXC+elBnhU1kfjI9ML9oKOc559uh57WXqgtQnJx3A0zsKOyB7c
         aQ+kupEhlcKUfoso9n9ZvWHRatbO7IsnCFVjI889z5kPyvGm8bXsD+i5PNCSERX0ZL7o
         a964LmffBYwM5b54LBeVh3zdvuGmKlaZFU22s2Ft8DDjG1bOW123jCClrWk2wAFa0Edu
         KD0FlCZjPCbIw7JRdt1HfHl4Bo35ymG9BHOMoIv+GtVT9eKiO2Aw+GzGN+lkFmTUhm/q
         Qs8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740162145; x=1740766945;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HdO9tVpvAE97bC++aynlan+kCE72STAqZAbZPqphi60=;
        b=YMmhUC7eu/pXOj40Qyb9ZbRqNXYoPTimqMy5we3LEuM4cuwrXK+jbZ3LposeKZbJyX
         rzdijudmjktCuBu4t8W9fWAb7Nn7yECqcdGR8a1iQLDsYVlM/CBQjQNcSGu8dqjB+CUF
         B/jsDLX0gDEW/dZCOyogLaIHBVoZ0O1XbF63L2JAlR1xAps28NkK96+Qm45UmOydlDch
         JzA0biHpYuAVcJr7nffeh9tQxUWNGN/9b0YXWFSpvVLEPsgUPLeVTOVbMgXCNpT58ia4
         WKvVyALnYqL560dtCWdaiJyIGRgWNLKU0naMrtJskcHCz5qnO069ixyDIYq8kLO9fwT9
         Qv5g==
X-Forwarded-Encrypted: i=1; AJvYcCU8276tQYxi63DHTuSMojRt+1V8PZPLu/ZyekeLVxhjhx9cNAzsmMPlCrQPzbJ9NzXZAt8I1f8IwMWJy50=@vger.kernel.org, AJvYcCWfWsWEu06MF4/7k2lvgXJRL1RVrMHAN+OSYh7L+KqrIxCVlkG6eCxKk6AZZczZahCbKwC580M1BehtCMQt0Cg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2l65FYsDC9eMVYdyT+ExX6MIswwLccXYdFcxVeOlxJDlbRV2w
	4OitdK2VXQJRlCf4i5BZu2nnm8DY6jmVxlcsHhua8uv4uD0bzxE2
X-Gm-Gg: ASbGncsCZT80wZVvSmZNqABLsbsryPI0/3Vz+MO1C/+S/XiAPcVhLtMG6f+TSorXmPX
	j3o14sNi2/+Yy21oR2xbALg3QYx58BqgezRHWo7aqOaH5+UJ7cJF0km3LDKG7ORytD9vasaUY+b
	zI8T/0USrJvKG/9eMb1mBMfXvYgSVsMU2cJLZPDZExFRT6ZwkKORUDXUv7v9dr+LmAYEFQwqo3j
	QOf6dFH1mytk+HBJfinJ81kbcCzW1ru5gdOJS3+d4XefcHiaPGKORhj3ITp8HvX++NogGAMiKP8
	/B7PhuDnu8N7efJ5VOWuD/cRJoFDIOuA9Q==
X-Google-Smtp-Source: AGHT+IGolpOrZQiwWCSA7ydTZmRGAXVhLFfZwU/R/LbLwlfvqor1ZlcAVXGBbHRkS0TSTA7ogK20mA==
X-Received: by 2002:a05:6a20:144f:b0:1ee:66f6:87e6 with SMTP id adf61e73a8af0-1eef3d96f97mr8115222637.31.1740162145307;
        Fri, 21 Feb 2025 10:22:25 -0800 (PST)
Received: from linuxsimoes.. ([177.21.141.136])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-adb5a52aefbsm14767948a12.62.2025.02.21.10.22.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 10:22:25 -0800 (PST)
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
Subject: [PATCH V4 1/2] rust: module: change author to an array
Date: Fri, 21 Feb 2025 15:21:41 -0300
Message-Id: <20250221182142.42134-2-trintaeoitogc@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250221182142.42134-1-trintaeoitogc@gmail.com>
References: <20250221182142.42134-1-trintaeoitogc@gmail.com>
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
 rust/kernel/net/phy.rs               |  4 ++--
 rust/kernel/pci.rs                   |  2 +-
 rust/macros/lib.rs                   |  6 +++---
 rust/macros/module.rs                | 12 +++++++-----
 samples/rust/rust_driver_faux.rs     |  2 +-
 samples/rust/rust_driver_pci.rs      |  2 +-
 samples/rust/rust_driver_platform.rs |  2 +-
 samples/rust/rust_minimal.rs         |  2 +-
 samples/rust/rust_misc_device.rs     |  2 +-
 samples/rust/rust_print_main.rs      |  2 +-
 11 files changed, 20 insertions(+), 18 deletions(-)

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


