Return-Path: <linux-kernel+bounces-218294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DC9890BC2F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 22:31:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 949F3284789
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 20:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AEF41991DD;
	Mon, 17 Jun 2024 20:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h4G9U5bL"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B991990DA
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 20:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718656231; cv=none; b=uO2x391tx2In7OvFidxOcE3sxL2Lyb/aLEU03RtEo9jWd8Mtlboc0CHdzkLA5LoQEQINtZWVMR+sY1Yj350EfhbPsXOvtOzSXU+lg+0D7frinlmhlDAHuFTm8qbYV7I6423UnFPAZtW3BIApyXmeKs+VVy0blL4za+4Yu9q/KZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718656231; c=relaxed/simple;
	bh=B1mlD2gcDZn3WcFLN8earxzL3eEqpyTKvhmSVNGtGhM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y09aNZR5LJepYH+LBZIal67Ss7y5zksFtEaUz2fmw5JNCnnbaVGWmbT/A2XkrOxYQtsMeMs+8RdaFI8+0XyDgNvRTOurJ8bb2nJ8FdcE77g5SEWOQOy9xOqQ9iiZhSD0QKvQJY52/oQZ8pJeGkk6yV0zhvpzLhmYt2bDaMxKCc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h4G9U5bL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718656228;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PgQhmsr/qwpQV0Je5+W+RhOcNOfhN6QQb+s3cR1jcGU=;
	b=h4G9U5bLgEOPde+48arDL1SSpYzm+lRDif04NuvO4gAWvoGdUpwwQ8U5thEw/yhVi+OJGE
	CXISisVCkFWQfY5xk7AvjtSz80sJHuEukdCpyJ2yIOjJuZfgVcXJAFOae4cNwfS1rcTkUI
	OGAkbVpiUNaUbNwSv7YX1hF9YX0uJCc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-77-wdIQcScfOMeP9u7ir-l4vw-1; Mon, 17 Jun 2024 16:30:27 -0400
X-MC-Unique: wdIQcScfOMeP9u7ir-l4vw-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4217a6a00d8so31218755e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 13:30:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718656226; x=1719261026;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PgQhmsr/qwpQV0Je5+W+RhOcNOfhN6QQb+s3cR1jcGU=;
        b=G243U+ZS6xlCCZLVyOqQ8PaxZ+go/UBdYJ8UtFSYEgLpCpoeMCKxtsietOdWrFj7m+
         045IwFRIfDjelVoUVhb0n5kN+3K8dZiIqtF2YfNrmn+93Rmc/el8OcIQ1EdO/LL4rqUV
         K08G4X/Kz/7wDNoTsmtU/uQN+qvOi2VEpjPETvcNzScUgf+lARPySudPqZAKRljIh+DR
         CzZTdGxLcnf7n4Xn0SculiqyaDPM8a+c0s7JICOXEzYhDCLfx2uxnpGn2ZPRkl48aMXP
         khlkB/dWL8D7yWvF8cKL69UyBZ7UW0FrccG0ZlXOLzPLCjug4TErStzOwYcfR0HPxSF2
         rNrw==
X-Forwarded-Encrypted: i=1; AJvYcCUZT9SolSRcuFZ088iJqfM5waZRXOXIttkMFQIkaflS/vGf8k+bRDKfZVaf0OCW6cs+qB5JuqAvqBM3borz2nfcfRHe1OM7+YPskxiI
X-Gm-Message-State: AOJu0Yx6nJVEStOvodoQUSUG9RyHRiGitAK1dbEMS0BDPNGH5nKsK0Am
	7xUTTuzegX5sjDztdxzyjnPyqx8Ofiv7RrI8XO2XCyJ9KwB1UIQlWBVwjFbG9Ljp9AG+fIJImnV
	BmrpP2BteD0HK6QcbZ+h9HWVhmPmhAjYN9MYrlO0T4NsGiigLx1jTH+xhHBaE6Q==
X-Received: by 2002:a05:600c:2d8c:b0:422:140:f440 with SMTP id 5b1f17b1804b1-4230484adc9mr86367965e9.36.1718656225971;
        Mon, 17 Jun 2024 13:30:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGFEnB6x2MMZffzzdSjL8T8/a13bSO8sq6uqSY99yH4rtqsHFx2SMJS7ed+5la0ootKESeSwQ==
X-Received: by 2002:a05:600c:2d8c:b0:422:140:f440 with SMTP id 5b1f17b1804b1-4230484adc9mr86367725e9.36.1718656225662;
        Mon, 17 Jun 2024 13:30:25 -0700 (PDT)
Received: from cassiopeiae.. ([2a02:810d:4b3f:ee94:642:1aff:fe31:a19f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-422f6127c6fsm168658825e9.24.2024.06.17.13.30.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 13:30:25 -0700 (PDT)
From: Danilo Krummrich <dakr@redhat.com>
To: gregkh@linuxfoundation.org,
	rafael@kernel.org,
	mcgrof@kernel.org,
	russ.weight@linux.dev,
	ojeda@kernel.org,
	alex.gaynor@gmail.com,
	wedsonaf@gmail.com,
	boqun.feng@gmail.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	benno.lossin@proton.me,
	a.hindborg@samsung.com,
	aliceryhl@google.com,
	airlied@gmail.com,
	fujita.tomonori@gmail.com,
	pstanner@redhat.com,
	ajanulgu@redhat.com,
	lyude@redhat.com
Cc: rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Danilo Krummrich <dakr@redhat.com>
Subject: [PATCH v3 2/2] rust: add firmware abstractions
Date: Mon, 17 Jun 2024 22:29:41 +0200
Message-ID: <20240617203010.101452-3-dakr@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240617203010.101452-1-dakr@redhat.com>
References: <20240617203010.101452-1-dakr@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add an abstraction around the kernels firmware API to request firmware
images. The abstraction provides functions to access the firmware's size
and backing buffer.

The firmware is released once the abstraction instance is dropped.

Signed-off-by: Danilo Krummrich <dakr@redhat.com>
---
 drivers/base/firmware_loader/Kconfig |  7 ++
 rust/bindings/bindings_helper.h      |  1 +
 rust/kernel/firmware.rs              | 98 ++++++++++++++++++++++++++++
 rust/kernel/lib.rs                   |  2 +
 4 files changed, 108 insertions(+)
 create mode 100644 rust/kernel/firmware.rs

diff --git a/drivers/base/firmware_loader/Kconfig b/drivers/base/firmware_loader/Kconfig
index 5ca00e02fe82..a03701674265 100644
--- a/drivers/base/firmware_loader/Kconfig
+++ b/drivers/base/firmware_loader/Kconfig
@@ -37,6 +37,13 @@ config FW_LOADER_DEBUG
 	  SHA256 checksums to the kernel log for each firmware file that is
 	  loaded.
 
+config RUST_FW_LOADER_ABSTRACTIONS
+	bool "Rust Firmware Loader abstractions"
+	depends on RUST
+	depends on FW_LOADER=y
+	help
+	  This enables the Rust abstractions for the firmware loader API.
+
 if FW_LOADER
 
 config FW_LOADER_PAGED_BUF
diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index ddb5644d4fd9..18a3f05115cb 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -9,6 +9,7 @@
 #include <kunit/test.h>
 #include <linux/errname.h>
 #include <linux/ethtool.h>
+#include <linux/firmware.h>
 #include <linux/jiffies.h>
 #include <linux/mdio.h>
 #include <linux/phy.h>
diff --git a/rust/kernel/firmware.rs b/rust/kernel/firmware.rs
new file mode 100644
index 000000000000..05a4f84cfd42
--- /dev/null
+++ b/rust/kernel/firmware.rs
@@ -0,0 +1,98 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Firmware abstraction
+//!
+//! C header: [`include/linux/firmware.h`](srctree/include/linux/firmware.h")
+
+use crate::{bindings, device::Device, error::Error, error::Result, str::CStr};
+use core::ptr::NonNull;
+
+// One of the following: `bindings::request_firmware`, `bindings::firmware_request_nowarn`,
+// `firmware_request_platform`, `bindings::request_firmware_direct`
+type FwFunc =
+    unsafe extern "C" fn(*mut *const bindings::firmware, *const i8, *mut bindings::device) -> i32;
+
+/// Abstraction around a C `struct firmware`.
+///
+/// This is a simple abstraction around the C firmware API. Just like with the C API, firmware can
+/// be requested. Once requested the abstraction provides direct access to the firmware buffer as
+/// `&[u8]`. The firmware is released once [`Firmware`] is dropped.
+///
+/// # Invariants
+///
+/// The pointer is valid, and has ownership over the instance of `struct firmware`.
+///
+/// # Examples
+///
+/// ```
+/// # use kernel::{c_str, device::Device, firmware::Firmware};
+///
+/// # // SAFETY: *NOT* safe, just for the example to get an `ARef<Device>` instance
+/// # let dev = unsafe { Device::from_raw(core::ptr::null_mut()) };
+///
+/// let fw = Firmware::request(c_str!("path/to/firmware.bin"), &dev).unwrap();
+/// let blob = fw.data();
+/// ```
+pub struct Firmware(NonNull<bindings::firmware>);
+
+impl Firmware {
+    fn request_internal(name: &CStr, dev: &Device, func: FwFunc) -> Result<Self> {
+        let mut fw: *mut bindings::firmware = core::ptr::null_mut();
+        let pfw: *mut *mut bindings::firmware = &mut fw;
+
+        // SAFETY: `pfw` is a valid pointer to a NULL initialized `bindings::firmware` pointer.
+        // `name` and `dev` are valid as by their type invariants.
+        let ret = unsafe { func(pfw as _, name.as_char_ptr(), dev.as_raw()) };
+        if ret != 0 {
+            return Err(Error::from_errno(ret));
+        }
+
+        // SAFETY: `func` not bailing out with a non-zero error code, guarantees that `fw` is a
+        // valid pointer to `bindings::firmware`.
+        Ok(Firmware(unsafe { NonNull::new_unchecked(fw) }))
+    }
+
+    /// Send a firmware request and wait for it. See also `bindings::request_firmware`.
+    pub fn request(name: &CStr, dev: &Device) -> Result<Self> {
+        Self::request_internal(name, dev, bindings::request_firmware)
+    }
+
+    /// Send a request for an optional firmware module. See also
+    /// `bindings::firmware_request_nowarn`.
+    pub fn request_nowarn(name: &CStr, dev: &Device) -> Result<Self> {
+        Self::request_internal(name, dev, bindings::firmware_request_nowarn)
+    }
+
+    fn as_raw(&self) -> *mut bindings::firmware {
+        self.0.as_ptr()
+    }
+
+    /// Returns the size of the requested firmware in bytes.
+    pub fn size(&self) -> usize {
+        // SAFETY: Safe by the type invariant.
+        unsafe { (*self.as_raw()).size }
+    }
+
+    /// Returns the requested firmware as `&[u8]`.
+    pub fn data(&self) -> &[u8] {
+        // SAFETY: Safe by the type invariant. Additionally, `bindings::firmware` guarantees, if
+        // successfully requested, that `bindings::firmware::data` has a size of
+        // `bindings::firmware::size` bytes.
+        unsafe { core::slice::from_raw_parts((*self.as_raw()).data, self.size()) }
+    }
+}
+
+impl Drop for Firmware {
+    fn drop(&mut self) {
+        // SAFETY: Safe by the type invariant.
+        unsafe { bindings::release_firmware(self.as_raw()) };
+    }
+}
+
+// SAFETY: `Firmware` only holds a pointer to a C `struct firmware`, which is safe to be used from
+// any thread.
+unsafe impl Send for Firmware {}
+
+// SAFETY: `Firmware` only holds a pointer to a C `struct firmware`, references to which are safe to
+// be used from any thread.
+unsafe impl Sync for Firmware {}
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index dd1207f1a873..7707cb013ce9 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -30,6 +30,8 @@
 mod build_assert;
 pub mod device;
 pub mod error;
+#[cfg(CONFIG_RUST_FW_LOADER_ABSTRACTIONS)]
+pub mod firmware;
 pub mod init;
 pub mod ioctl;
 #[cfg(CONFIG_KUNIT)]
-- 
2.45.1


