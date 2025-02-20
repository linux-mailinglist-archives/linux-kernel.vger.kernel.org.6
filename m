Return-Path: <linux-kernel+bounces-524202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2D6CA3E07E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 17:23:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F033519C34F3
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 16:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61EF32066C1;
	Thu, 20 Feb 2025 16:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bmtcvvJ+"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF771F1521;
	Thu, 20 Feb 2025 16:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740068415; cv=none; b=acbJ12K9fg5ZNkry4heI8DGDzKuTDx7jd5fCH/pb+hhirzvObVT95CE9j6B0zIpLjTprW/ne2qVJDp0VtC+mrLg6y6/2UGEEm1mnUARKPPXN0vBN7GMEUVZQjiHBZH/aYX1nDmW9QEDZD2FW/O0Lldl1lvTvrS3lXyfajjZrUXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740068415; c=relaxed/simple;
	bh=4cDqNmayQUdKr8uDiJ1UR81pYo0A4k0A2thyrxtwI9g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=N6ygg9RyNYXFupVtKWc57Q3ja4Hp21BBK7kY895qCaPN6JAq1vgF09AjgrY2+SGGQYrJMSTep/Srfnns2i+Z/90WNweAA3BOsQEngeQRbzEhUoFtld0IQD4SDwtDWdhmbFtInkBbCcHshicSdERiqFmdFQwvXzwstXMN9Gueo+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bmtcvvJ+; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-220ecbdb4c2so29680085ad.3;
        Thu, 20 Feb 2025 08:20:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740068413; x=1740673213; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=80RkjWb0QgyuebLouunjzNOxx/sMfImn9rNTeqSYLhE=;
        b=bmtcvvJ+hWjfu8oll+5gqA57xwBsKj6aUFqfreq4eVvs0D5FzEm00aZTPw8HM3Rm0L
         ouEZOBcR79HTD3QduvtSuON+q28lcQq5Eo7L9jQmeZdIAdDcxlmiAcMboDj1M6zPDVMz
         8zYsqdmrsSp/E3fBjvgwIKvRQgTauFliMP1g4S1a2ASQv/qmqcfPeINJLY63UXdoHlc3
         XjRJMh8y1445BZUUEn39ydzsumZWCUDXTm1TE+s+Xo6aK/Wojk3nKVVFWOXm+tdsUY9o
         +J1d5kk6ZcG8SW9DwVEfADagn5J9WYGx0VThH1+SgEQddD5icGluQ7JE8tDTN49jljI4
         kChQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740068413; x=1740673213;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=80RkjWb0QgyuebLouunjzNOxx/sMfImn9rNTeqSYLhE=;
        b=BYzQUJiRFAsHyUK/NHkonyPGKAsRxYpbEAeAwbU/yJbp+J3zQ1C61IJMfvCGQ3eFwM
         ZbC+ec4B7es2C8kgCUzQ9burpGPhUcKWqGxmqQKh9QW0hd1YyIscL3WGu3ffkZ7W6IcH
         lFy3GjAXzKasq/ymHYigYybWDpYOVvVeN4JNybs9vn1Z+GqNqaPV1gngUlYrthi2Zls8
         E/ngBnjQ+/ioy63ZlqJwzRp0MpfweewLZenvfNjUnHvhyB4WWe6d8KLLhDrDlwK5OH/G
         /qVWWTomxncGA/dLYrz/6wRcgXYzRQbCQbLhV7eJfAEDY5JBaIaNcD+GLpleBDMkJUiL
         pzEQ==
X-Forwarded-Encrypted: i=1; AJvYcCXMa6j/KXrCDIW31QfY1+c/jbwNLjZGeiyn+iG7tN3hJCjTUyMRn1amxABDcB05vkBg5ntarlgiUykSA/ZqKiI=@vger.kernel.org, AJvYcCXN2NTeZmDRxswStWA7Ue9pMqxD0hmNJ3HEz/uUpAyssnDMv7E/nm66VJKaPhZR6Oo3VmaQyvlky9Y7Qh0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzB+QK545AExwHMsFMdtId1WismUG9BWNKrE+gEzVTaz1/N9Qdv
	4EDCcyu2OXBn8/DmpSXiuH4bCdKrQwBCSHOk1J4dFHAOKxod2eBq
X-Gm-Gg: ASbGncvOZig+cIv5pbpy1dOLMuLZnOeR9KsM88IvmRoxOWK4rbuXc5XBEBfR0kwDHHM
	FQuEYwS4fM8D5D1WmNkePAKPZKi3OVG3toX57sIGBJoNotVwfUhkBdzVHM5cXjJW1PBeW58Q4AP
	+juwUSkpmOcY4ELBYMwK7flyvYpXtUrOb8y4DTAe6Ab8EpSLJclBOv232g5KRm7hRZ6WIBXgVXo
	qTDfuGKMzFZJ+15OSoP0Ch49113frk94dOAM9nxDoAwVaJ9/uDOtT7OfR4GfuuNw4Xu2pgUPQ1s
	2+sR1Lzvq7+XwdWD/keeaB0=
X-Google-Smtp-Source: AGHT+IEewydMRUrml5TxMB84gBMP31ciuqEiIjAHev3XWeYiny1ydqjoRXGZpN8NXpLaZ3S5J7bhUQ==
X-Received: by 2002:a17:902:d58b:b0:21f:dbb:20a6 with SMTP id d9443c01a7336-221040ab935mr398205165ad.33.1740068412956;
        Thu, 20 Feb 2025 08:20:12 -0800 (PST)
Received: from linuxsimoes.. ([177.21.141.136])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d7a540aasm120910545ad.245.2025.02.20.08.20.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 08:20:12 -0800 (PST)
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
Subject: [PATCH V3 1/2] rust: module: change author to an array
Date: Thu, 20 Feb 2025 13:19:50 -0300
Message-Id: <20250220161951.844367-2-trintaeoitogc@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250220161951.844367-1-trintaeoitogc@gmail.com>
References: <20250220161951.844367-1-trintaeoitogc@gmail.com>
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
 samples/rust/rust_driver_pci.rs      |  2 +-
 samples/rust/rust_driver_platform.rs |  2 +-
 samples/rust/rust_minimal.rs         |  2 +-
 samples/rust/rust_misc_device.rs     |  2 +-
 samples/rust/rust_print_main.rs      |  2 +-
 10 files changed, 19 insertions(+), 17 deletions(-)

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


