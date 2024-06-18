Return-Path: <linux-kernel+bounces-219789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0257790D7E4
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 17:55:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70F1C288EA7
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 15:50:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 817A64654D;
	Tue, 18 Jun 2024 15:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FeG73KYR"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0143678C91
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 15:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718725739; cv=none; b=UnebrcqiYJH4muzyjgsp6lG3KwrLclhHRaJvco9qihrYvlAkbAt1GYgSIp7B1CcS5JBYj27G32YSBhzEWNlOV2vDSlzcTdVG7qrwQlQQWDDPsEY4Vi8PQKSQJcUjnt5CpoX/2Ao7Ud+y4FvyYQHxNgaiDU73CV3aIpq5MC+L5LM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718725739; c=relaxed/simple;
	bh=uKdkar9T+buQ+rgXRjYk96RQ1pLgLS/s5OH1+LEQGf8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k08EDogiG5uMzP8gpXr62PFubAGgi6MfXxNKlYP0bbEIfNUzs//v9VFQH41PW26vj1a/OSYpkUAv5fRlLDNRq/CjJE8e9xozGfQTfRdiAX2TkyAdk/wcLnOshiyGclq+sNK4HwcVnQeFTFXrfDKWhs4k0fhivsLEWATYdIji/fY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FeG73KYR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718725736;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jbhl14xAYy/a54hqQydSy+Qa7m2sEEE4gFOceKt9vSQ=;
	b=FeG73KYRKdGrduDrdVeB3ZCqganNIKw+VIvBdibGgGUVLgabR2QqOPysyeBKFkBTrdlDwi
	gU1y4ZfGbD8s5sffT9ldprdGtwKlwJXj5Ur8L56JBx9J1wqKFJTjieDEMDBSK8N2bWhV98
	bFsWoEIOJ3eVOrhovDpmWhwYlsHe1Eg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-75-b7re5-DtOXiyusJP2msIPg-1; Tue, 18 Jun 2024 11:48:53 -0400
X-MC-Unique: b7re5-DtOXiyusJP2msIPg-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-35f142464b9so3394066f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 08:48:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718725732; x=1719330532;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jbhl14xAYy/a54hqQydSy+Qa7m2sEEE4gFOceKt9vSQ=;
        b=RkxWKw01GCoCClYNKwD85XsxEGoVdyjkdzFLcZl6wqctuVkY8prZv/f74nE2pUbOuL
         WKcChllskrLpo8xnpX6/Z+LKCWyEArwiPxZhVuRH3wTe6zwAzPcBDVeWLIUYYcYssK3p
         Z1Gk2ppWRz8Xn+pQnQ03oN/hx5ebxbxMApNy6+mkLZvJk46LHSXTUaTBpniMCdGRVVnm
         lS56i58SpdFaDiewdXZMs8AkQy+YF/FG5eSL7fmp6EIXdg4l2n72zQEWktLMHJa5fIi4
         ySqr6et9EYvpY1l1+strqBql1ihX1WVxZIFK0u7EczEGStn1bv9G7mAv87i0pNNar57W
         pajQ==
X-Forwarded-Encrypted: i=1; AJvYcCViMrp+p13/Kc+V/TaXNLI8mezhTM4RJbWJYbEZqy25OsVxiQCoYjmqn6E6go/16NQYfjr8WYNXrG09ttiHOfxEgj2FvKVaKgn7IBGe
X-Gm-Message-State: AOJu0Yws3UBXlesVzrxj22fGg4Y/xyfktQ5/x/EqXta9q1CZ42hCEtNg
	6AuPIbOPrZfA/QKwZCv4IrNFafN36bavrpET/VTAlgfsJHEQXC9GxVBXbP9HWmWYjLO7QCEu2n+
	5L9xYHORgZ6TYVtyvMu/X+e9wxkoawTV6OHtnL43ZWmcyk7+9MHmL5L3LmOWw8g==
X-Received: by 2002:a5d:66ce:0:b0:362:a876:6cc2 with SMTP id ffacd0b85a97d-362a8766e14mr643445f8f.6.1718725732396;
        Tue, 18 Jun 2024 08:48:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFdnbO11plzCAF10UelkIXmaa6jQbyBCnK6b7JzS6IBKVhFwAgOmsi2cQG5eQ/M+V5rPjuZ6Q==
X-Received: by 2002:a5d:66ce:0:b0:362:a876:6cc2 with SMTP id ffacd0b85a97d-362a8766e14mr643420f8f.6.1718725732039;
        Tue, 18 Jun 2024 08:48:52 -0700 (PDT)
Received: from cassiopeiae.. ([2a02:810d:4b3f:ee94:642:1aff:fe31:a19f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-362231c7ec0sm1497197f8f.29.2024.06.18.08.48.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 08:48:51 -0700 (PDT)
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
Subject: [PATCH v4 2/2] rust: add firmware abstractions
Date: Tue, 18 Jun 2024 17:48:35 +0200
Message-ID: <20240618154841.6716-3-dakr@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240618154841.6716-1-dakr@redhat.com>
References: <20240618154841.6716-1-dakr@redhat.com>
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
 drivers/base/firmware_loader/Kconfig |   7 ++
 rust/bindings/bindings_helper.h      |   1 +
 rust/kernel/firmware.rs              | 101 +++++++++++++++++++++++++++
 rust/kernel/lib.rs                   |   2 +
 4 files changed, 111 insertions(+)
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
index 000000000000..b55ea1b45368
--- /dev/null
+++ b/rust/kernel/firmware.rs
@@ -0,0 +1,101 @@
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
+/// Once requested, the `Firmware` backing buffer is not modified until it is freed when `Firmware`
+/// is dropped.
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


