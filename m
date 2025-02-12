Return-Path: <linux-kernel+bounces-511814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC1F0A33012
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 20:49:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53588162150
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 19:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2C8F1FFC74;
	Wed, 12 Feb 2025 19:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IamDUGbQ"
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9638E1FCF62;
	Wed, 12 Feb 2025 19:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739389757; cv=none; b=aDCZf71fYJc5lGjm0EgF+f3RMft13ttO0Zww+SA/RQ7oXglyliKBg5pzb+52xBWJ5IlHEdM1GarYvB+sYGziraVGgCqU0/vKLo57VT4Za+0ZTCDAsZjTyUMW2P3Ve/mHcE7bPTF8y8hc4lNGIgeyQkaP3LrZ0cISI+mpQekyg00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739389757; c=relaxed/simple;
	bh=o1Hy988BGmmOUc77xzcDN6OL/Tg0tHFDBsl4Xf8tEuo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Xq8WXb28YsrQ3/6FlcUH/2evvdc7fDDFyKrqqHEhPhsx0i3/oU1gkuryIw9wUrrZFoaD8dHVeJgQd+STfKTvwPxi8rT4AlCbeTZgQRfYxSii/ws4QstHHXdKxqIVMb1BdEO//vG0TbmL5TmVPv1g/Wfx3bPAL43rjAxDQv8z27U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IamDUGbQ; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3f1c94936c5so59414b6e.1;
        Wed, 12 Feb 2025 11:49:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739389754; x=1739994554; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ttvv+NN1LHx8dcxpDRZPhTxULy7AvxHbdwGTApEI6Mg=;
        b=IamDUGbQv5pZEU1p9PAP5JwWpr6s7W6SlIWwyFZdzB21hvall0i17UrOjSZ2nuHgMf
         4t7qEfOKdNHVDuFwjvT2tfb0xtVB+9TAVzfeNv7vT6A8KOc/oYd3Q1xKqcZVBKv1DH23
         RigDhv43LuyQQmTZLG3KlVR6yyTzYDES/b05grViqIhNoTzYp6Ebwh13fBZ1xgSBFSBJ
         O9vZQ4zqkXzHOiVOAg5NnG1e0tORBpcwVceCbPSAuR5/xf/GVxQcSne27NJdf0dsGGHP
         /LMz0tmPse3C1uWekwyE3wFuJ/1Eb1i4zSXWhayZt8TeWiaiOXRcQPdxCY3Xo3qQlYEA
         zDWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739389754; x=1739994554;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ttvv+NN1LHx8dcxpDRZPhTxULy7AvxHbdwGTApEI6Mg=;
        b=t8BRAb/vFXVtEARXwuMOCD9I/ETIynolVyRorDTuO/sl4VVEZOkxqUzkY/uo/sR2mP
         e+lkCJEvk8xoQdAtpNOl9o14SX6TsYRW7C1MXPuf5YTsJaUKLW2eXjzXZAH6/my13eS/
         LEvRXJWqhgjsJfx6Q9q23DNq9JyYOMltA6Si4b2m1gQp+SKJV4LuRFKvpViHb0gTnAE+
         Xh5vpH/nZGkvpfiiQ12r/VZ6D+eluX3KFNggb0Rg38XDOzU5UI6UdhMobeyLu9oNPGWa
         ZVZ34L8tG7BxKZtlJUhKQpEPiaDIGUdlbTSWKoO23TJPoI1pwrO3xdLdUPdGbcKeNgp1
         kQqg==
X-Forwarded-Encrypted: i=1; AJvYcCUOt6pzctR26w7d6hsIqzeRKmm7nfw3G1IRJV1qXTMiprhOL+Hdcp07+dF/hCQQ/6AYuti7kZqyfoaIdaQ=@vger.kernel.org, AJvYcCXZOr6jQLiKgODh9BjUv4jvNBA0pz+eZoGbhyikz5FiSi6a/A7xQjV0zmq1A1OdejZuO6YOnqAG0LcC6SJxRIM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXauSBDDTLYVAIGhvNJdeenMBqIdVnTE8g5HiusRqOZ5+xWToR
	NxiP79fW0A32EMpk57BR6ZpJfjhfVNpQ3uPvR6qQppTA0gZ0T7KnoIA81EyF
X-Gm-Gg: ASbGncv24k2BWhFFRi9u3GJx5eTBJLTTcBo7vgfT6LNftNI2pFmuycjqxvOUwmOa3VX
	jQBHtDhuxi3p1Ryw89OAVpihTi+Tjn3qaUwJ3g1QHSH6K1FxTqK+6/1HmZvXKQV9bIi/JnUzmuR
	ciQO8fxwRT1fTbglLpRNeU4a1gdw5veE+Qb3EGSetMEZGFwflehexaCZdzOmtsOTXbYAodW7pEt
	/ANVeHFtdXhBYuW2eZXmqEZggIPwWVXaIg+OZJsmUG5PVjV0SNWvj8fvjf/i+lWe1xMhJUyCzJK
	U85/ZYAk3SAJEof+yac6EwOh
X-Google-Smtp-Source: AGHT+IEDGOiAzw3Z3o/Luu8hb3OX8McS41+AMc32wNUDUKJKPmV7gUP8GOB9oIAMzXekQJDb1uWHMg==
X-Received: by 2002:a05:6808:221d:b0:3f3:b153:c231 with SMTP id 5614622812f47-3f3d9172043mr144058b6e.17.1739389754510;
        Wed, 12 Feb 2025 11:49:14 -0800 (PST)
Received: from linuxsimoes.. ([187.120.154.251])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3f389ea921dsm4542328b6e.3.2025.02.12.11.49.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 11:49:13 -0800 (PST)
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
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] rust: macros: change author field to array
Date: Wed, 12 Feb 2025 16:48:56 -0300
Message-Id: <20250212194857.192057-1-trintaeoitogc@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The author field don't accept multiples authors. Since this is
necessary, in commit 84703117fd98 ("rust: module: change author to be a
array") was change the author field for accept a string array.
In modules that use the author field, change its value to a string
array.

Signed-off-by: Guilherme Giacomo Simoes <trintaeoitogc@gmail.com>
---
 drivers/block/rnull.rs           | 2 +-
 rust/kernel/net/phy.rs           | 4 ++--
 rust/kernel/pci.rs               | 2 +-
 rust/macros/lib.rs               | 4 ++--
 samples/rust/rust_driver_pci.rs  | 2 +-
 samples/rust/rust_minimal.rs     | 2 +-
 samples/rust/rust_misc_device.rs | 2 +-
 samples/rust/rust_print_main.rs  | 2 +-
 8 files changed, 10 insertions(+), 10 deletions(-)

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


