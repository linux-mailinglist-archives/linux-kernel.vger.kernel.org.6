Return-Path: <linux-kernel+bounces-515525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14BDBA365E1
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 19:47:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C8CB1894573
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 18:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B30719FA93;
	Fri, 14 Feb 2025 18:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cn19R4Cq"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D22F819750B;
	Fri, 14 Feb 2025 18:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739558809; cv=none; b=HvMuz1KVry/xniejI08/29FbL8BYveNlBBoiLP6LkwrQ6n5LEZrzRw7JsnMjTlAOq6uZF80fjR/qPMSrbI0YglCW7xtvpmM1A+IU1goTAVytnKTF9iWb/JLnjNpo8pYXrxwbXzWY0iN5UbUaJrIbuK1I5yr6nOVt4n2JplEBv+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739558809; c=relaxed/simple;
	bh=tKW4TH+LAPY6Tur9AlHrWs1vDbIL8qmHHn4fMeFUVzU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DM0RpRAL0R0cChlqk/kqPIP37oBA59EXp2cYalHa0jqKla6eCPRmocidet6mAs6wguhh6gHx4HGPM/J4H1o22gSa7FGACLvs4xE9v24nQs0geePMPnbJNDc38g5fHT2WN0rCx0Ho1aCGqIFQSs3cLQSuxnyayhLDhSssEZ8Rpvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cn19R4Cq; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-220c665ef4cso36261645ad.3;
        Fri, 14 Feb 2025 10:46:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739558807; x=1740163607; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3AoyiB+ByqlTcNNpk1JUjsGL3GRg2563aZYap+mUJBM=;
        b=cn19R4CqUGa1DTSsPiQWi4cVb/3adnsb0CEfnwg8M2mirkrq7fBWg6Tl5J+oH+Hrw2
         DqvrPG3zNPdojXS+SyshbroqVKsK3j7O9quRL5AYWcq2BoQHQu9iYQ+FyEHNDqi5cwS0
         fj/WoSNXDNi7Jcq+RdZRDA82dAKE+S3ul4zuGk3EpAWIEv6+Okmq2Jgph1Ebsz8kfbdU
         R7m6RpIHAV8cci9EZeSYZvGnOtplebTqukjn5tKf9C2UKzowRWPN4V8YafKvzMCLXAxW
         vt45Y8v8iH3lcDhnKIe9gFL1HcNMSYKO8+c2818Iea/MA5PiKPDfVihav2ZUWXWW9MMO
         13HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739558807; x=1740163607;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3AoyiB+ByqlTcNNpk1JUjsGL3GRg2563aZYap+mUJBM=;
        b=Ps+BOizma4/qny0IVVgLUZ/W7XmF5zMJAyv+9mCNqQd/LHqzc/Y7W/K8QH7hhZ1FcO
         7Y6PwPlnqBiRrd11ASGE5SqlonislPNOeFO0dhN4h1aR//q4NHQBi5AKgwZQBr4mD44p
         IVsNr59RPpw5yANpdnP6NoPhzARVb0f7eiywJ1Yu9b7YX1B5WELCwTsghzMYMKVc7SiH
         Q5eLutycaRIlrbStHPkhsCgRL+y9BSwNcdDyYQikDCyRwBya6Nrk3x3o/RF0lo+Gqnsk
         52FmIM+uM89uBwabcJQb9XW8dBLGXpy43CcekoTVztPjNvsaop5K0df7vmhn/b7Vaxfo
         v9hA==
X-Forwarded-Encrypted: i=1; AJvYcCWJ1MrtC3i4NfhW9N/VtdnSKYSLiACn7ZexsDx/nITxH4kxZLybynBqp8YwA7bR3b7Vk5N+60kqQta+86Y=@vger.kernel.org, AJvYcCWbjRSstjYdNEq3i2U11Zn6r1Tb9FlBOQnGxEc/oqNQBk1wazFl2/P4P8+xPiAqLIa1DaCJfEdLf3LUZexsQWQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3Ix3aAqMYDHYvEi5qw13xWvpoRHMRtR293kqkD1AC7IGKjS62
	6ftDKiasqjHROZeGb74JEysJTRCiuGPE+YQTeDu5nvoGDyA6q+jM
X-Gm-Gg: ASbGncv9XzzAgXTZlP3+VrErRoJZQhZCry6VEMYBkYEsmQVGVN7Pz5ufOXAm/kjfLFj
	nHNiXX/v60RNBqJ115ku86NvBJMkoMI7DLYVYlCCgWhpRX5UjVQjZ0z1gYAzn9KIvbp+fpx2XSn
	iznD/uMzGCJHJeYvQfrH6+WnDBRQOPrN9tJgN+EgYCFNCYkfFlPzGTQDv9ZYr4YwgxT9hCUfzDV
	jo0bHWhjStkwmHoKa1SHundd9/XpkWPUFLL1QQlCFDteCixqjPWu4iBLfXszBBVzemCDTdZvy6o
	Dq/0F4l2ExF/cMADvPc7u5fO
X-Google-Smtp-Source: AGHT+IGNJdsTANpgQB9CUn3wHqXnjo+MVrHilYvKJLz9u8VJDAtfjsY4CYzy6l8JTiWrQLPvH4bnMg==
X-Received: by 2002:a05:6a00:1488:b0:730:949d:2d32 with SMTP id d2e1a72fcca58-73261799882mr761323b3a.6.1739558806844;
        Fri, 14 Feb 2025 10:46:46 -0800 (PST)
Received: from linuxsimoes.. ([187.120.159.118])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73242546841sm3438637b3a.1.2025.02.14.10.46.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 10:46:46 -0800 (PST)
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
Subject: [PATCH V2 1/2] rust: module: change author to be a array
Date: Fri, 14 Feb 2025 15:45:49 -0300
Message-Id: <20250214184550.120775-2-trintaeoitogc@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250214184550.120775-1-trintaeoitogc@gmail.com>
References: <20250214184550.120775-1-trintaeoitogc@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the module! macro, the author field has a string type. Once that the
modules can has more than one author, this is impossible in the current
scenary.
Change the author field for accept a array string type and enable module
creations with more than one author.
In modules that use the author field, change its value to a string
array.

Suggested-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Link: https://github.com/Rust-for-Linux/linux/issues/244
Signed-off-by: Guilherme Giacomo Simoes <trintaeoitogc@gmail.com>
---
 drivers/block/rnull.rs           | 2 +-
 rust/kernel/net/phy.rs           | 4 ++--
 rust/kernel/pci.rs               | 2 +-
 rust/macros/lib.rs               | 4 ++--
 rust/macros/module.rs            | 8 +++++---
 samples/rust/rust_driver_pci.rs  | 2 +-
 samples/rust/rust_minimal.rs     | 2 +-
 samples/rust/rust_misc_device.rs | 2 +-
 samples/rust/rust_print_main.rs  | 2 +-
 9 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/drivers/block/rnull.rs b/drivers/block/rnull.rs
index ddf3629d8894..cb133993f27f 100644
--- a/drivers/block/rnull.rs
+++ b/drivers/block/rnull.rs
@@ -27,7 +27,7 @@
 module! {
     type: NullBlkModule,
     name: "rnull_mod",
-    author: "Andreas Hindborg",
+    author: ["Andreas Hindborg"],
     description: "Rust implementation of the C null block driver",
     license: "GPL v2",
 }
diff --git a/rust/kernel/net/phy.rs b/rust/kernel/net/phy.rs
index bb654a28dab3..b179ac3a8d00 100644
--- a/rust/kernel/net/phy.rs
+++ b/rust/kernel/net/phy.rs
@@ -790,7 +790,7 @@ const fn as_int(&self) -> u32 {
 ///         DeviceId::new_with_driver::<PhySample>()
 ///     ],
 ///     name: "rust_sample_phy",
-///     author: "Rust for Linux Contributors",
+///     author: ["Rust for Linux Contributors"],
 ///     description: "Rust sample PHYs driver",
 ///     license: "GPL",
 /// }
@@ -819,7 +819,7 @@ const fn as_int(&self) -> u32 {
 /// module! {
 ///     type: Module,
 ///     name: "rust_sample_phy",
-///     author: "Rust for Linux Contributors",
+///     author: ["Rust for Linux Contributors"],
 ///     description: "Rust sample PHYs driver",
 ///     license: "GPL",
 /// }
diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index 4c98b5b9aa1e..1218eaa7be02 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -103,7 +103,7 @@ extern "C" fn remove_callback(pdev: *mut bindings::pci_dev) {
 /// kernel::module_pci_driver! {
 ///     type: MyDriver,
 ///     name: "Module name",
-///     author: "Author name",
+///     author: ["Author name"],
 ///     description: "Description",
 ///     license: "GPL v2",
 /// }
diff --git a/rust/macros/lib.rs b/rust/macros/lib.rs
index d61bc6a56425..8d74e18caf96 100644
--- a/rust/macros/lib.rs
+++ b/rust/macros/lib.rs
@@ -36,7 +36,7 @@
 /// module!{
 ///     type: MyModule,
 ///     name: "my_kernel_module",
-///     author: "Rust for Linux Contributors",
+///     author: ["Rust for Linux Contributors"],
 ///     description: "My very own kernel module!",
 ///     license: "GPL",
 ///     alias: ["alternate_module_name"],
@@ -69,7 +69,7 @@
 /// module!{
 ///     type: MyDeviceDriverModule,
 ///     name: "my_device_driver_module",
-///     author: "Rust for Linux Contributors",
+///     author: ["Rust for Linux Contributors"],
 ///     description: "My device driver requires firmware",
 ///     license: "GPL",
 ///     firmware: ["my_device_firmware1.bin", "my_device_firmware2.bin"],
diff --git a/rust/macros/module.rs b/rust/macros/module.rs
index cdf94f4982df..09265d18b44d 100644
--- a/rust/macros/module.rs
+++ b/rust/macros/module.rs
@@ -94,7 +94,7 @@ struct ModuleInfo {
     type_: String,
     license: String,
     name: String,
-    author: Option<String>,
+    author: Option<Vec<String>>,
     description: Option<String>,
     alias: Option<Vec<String>>,
     firmware: Option<Vec<String>>,
@@ -135,7 +135,7 @@ fn parse(it: &mut token_stream::IntoIter) -> Self {
             match key.as_str() {
                 "type" => info.type_ = expect_ident(it),
                 "name" => info.name = expect_string_ascii(it),
-                "author" => info.author = Some(expect_string(it)),
+                "author" => info.author = Some(expect_string_array(it)),
                 "description" => info.description = Some(expect_string(it)),
                 "license" => info.license = expect_string_ascii(it),
                 "alias" => info.alias = Some(expect_string_array(it)),
@@ -184,7 +184,9 @@ pub(crate) fn module(ts: TokenStream) -> TokenStream {
 
     let mut modinfo = ModInfoBuilder::new(info.name.as_ref());
     if let Some(author) = info.author {
-        modinfo.emit("author", &author);
+        for author in author {
+            modinfo.emit("author", &author);
+        }
     }
     if let Some(description) = info.description {
         modinfo.emit("description", &description);
diff --git a/samples/rust/rust_driver_pci.rs b/samples/rust/rust_driver_pci.rs
index 1fb6e44f3395..5784677c797b 100644
--- a/samples/rust/rust_driver_pci.rs
+++ b/samples/rust/rust_driver_pci.rs
@@ -104,7 +104,7 @@ fn drop(&mut self) {
 kernel::module_pci_driver! {
     type: SampleDriver,
     name: "rust_driver_pci",
-    author: "Danilo Krummrich",
+    author: ["Danilo Krummrich"],
     description: "Rust PCI driver",
     license: "GPL v2",
 }
diff --git a/samples/rust/rust_minimal.rs b/samples/rust/rust_minimal.rs
index 4aaf117bf8e3..74279c3bd039 100644
--- a/samples/rust/rust_minimal.rs
+++ b/samples/rust/rust_minimal.rs
@@ -7,7 +7,7 @@
 module! {
     type: RustMinimal,
     name: "rust_minimal",
-    author: "Rust for Linux Contributors",
+    author: ["Rust for Linux Contributors"],
     description: "Rust minimal sample",
     license: "GPL",
 }
diff --git a/samples/rust/rust_misc_device.rs b/samples/rust/rust_misc_device.rs
index 40ad7266c225..e840c12005cc 100644
--- a/samples/rust/rust_misc_device.rs
+++ b/samples/rust/rust_misc_device.rs
@@ -116,7 +116,7 @@
 module! {
     type: RustMiscDeviceModule,
     name: "rust_misc_device",
-    author: "Lee Jones",
+    author: ["Lee Jones"],
     description: "Rust misc device sample",
     license: "GPL",
 }
diff --git a/samples/rust/rust_print_main.rs b/samples/rust/rust_print_main.rs
index 7e8af5f176a3..f6d51b0884fb 100644
--- a/samples/rust/rust_print_main.rs
+++ b/samples/rust/rust_print_main.rs
@@ -8,7 +8,7 @@
 module! {
     type: RustPrint,
     name: "rust_print",
-    author: "Rust for Linux Contributors",
+    author: ["Rust for Linux Contributors"],
     description: "Rust printing macros sample",
     license: "GPL",
 }
-- 
2.34.1


