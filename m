Return-Path: <linux-kernel+bounces-208696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 56B4B902836
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 20:04:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B008B1F220B2
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 18:04:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5D2F14EC73;
	Mon, 10 Jun 2024 18:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VoUWEp07"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6375C14E2EA
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 18:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718042619; cv=none; b=DR47eNNfJhjkPaG/aeOlDU7OpcICtRO/fq3PvlQDdPp/o+pa3e5TaoS7JM0CMBzpc66y3kYoC9/aj1xFwZ+XenBaj15tp6oDOyaUIZdYSqeRm7juNz6fElNRPSL54gpoXI0w8MVHZ3yJFgRSNrpjPbZGgV7wW9RyqieOxJAeShU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718042619; c=relaxed/simple;
	bh=uo7uJNZ3epcfm6pUCaHZJk3wrGW8HkLdKy1yzy9H64k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sI8SOWoHJmdTFEx+n87bapGI59FlQIY1Ta5d9oJ5lqqTAxOs+ME0zmGifh8qxxN1ahxiOYn8/xZ+u0jAmRoSxT/rO1psynEEmIb9vL5Va/ehwd2kIVHuPgjO+0/sj7HSLGCNJGnN533NG5m8KGkNRSVC+itJZ5GevHjGzfUkGhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VoUWEp07; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718042616;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ko/751Ih42xdNXKctrEpP8bOTHpEg6/LHScfPoHYDW4=;
	b=VoUWEp07vu4CGYumVHgAySp0Ak+xaNsUsXjzvIixs2Zh+HWjdicDxY9AOye4qsoasEvVOy
	xppQeKihYJHlZuQGIXpkPqqhfGgJQM8Crm1L9FZ4nxCJkUzoBXU5ZvfGo2E2+HwHanG8Bw
	c5dVYOz8ecB1ZdH9ckWgVLJYD81T1Fk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-554-3_kKfLCOMSWKEvQ5CqluEQ-1; Mon, 10 Jun 2024 14:03:34 -0400
X-MC-Unique: 3_kKfLCOMSWKEvQ5CqluEQ-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-35f271c5b17so124683f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 11:03:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718042614; x=1718647414;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ko/751Ih42xdNXKctrEpP8bOTHpEg6/LHScfPoHYDW4=;
        b=LCIR86+TBeTZXSsd2DTZ6cZ8elxO/dP/cyMz5ZzQab3C5+0YLanjWbdwVLfagy7U84
         M2ZVoT+AkcJDNnb2ZgL9liClu8qLvIpCwmCPkZZdg3Pvjx+rRjFuGw+clWI6djdttvcR
         Cz7nfe2vrVO9s9ezC+HNHWTJ1ChGoTMMh6imrgCEFRnELCcjr7u0AF/+vxZ/2oRXOrBE
         3ldzlm2jfoJoTpXSv4DFtQrAt+4VfZ/ZS0DH1mAmjKIIIldzeD0o2oK+VipKTf+qN9Mw
         nWPdy1yofPernM/n+6wg5Jc33Xd5ImpiJcQ4xtNv4Wg4hUPRZwrYjQTmo4VM2SNpjqd3
         +q7Q==
X-Forwarded-Encrypted: i=1; AJvYcCW78V9EgHwREEQki616jhJMh/lLiOqmN2PNs1Axc3AiCSyYjXOubfUPa5WBZue3WY4IYuJVMBXbCCyu8CxPU1lLRMIqoBgewHAg/GLk
X-Gm-Message-State: AOJu0Yw0BOJSoL2LWO79f5BGIMeQtHL8wZrriIJbttEGFWbIRAz506pl
	AVImYpP+JIjSKiRYIFbQLn8vv3xvWZTbtUf6VQJxPRjgZ1u7PszsskpY25CdGsH9cV1+E971gK/
	1DYXaT3zsYfQi+pUOVkeA+Q8vTyLS2X1cIMqIC8ZiDFU7d323WbTy8GaOVs57wA==
X-Received: by 2002:a05:6000:2c2:b0:35f:1835:3a62 with SMTP id ffacd0b85a97d-35f18353c74mr5628315f8f.35.1718042613662;
        Mon, 10 Jun 2024 11:03:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGRjRL00cNynGjzhv5Ncbfra3TprBtbnWt4hfvsVgE5SGzuiZzJ0gnNTax6xVQ+ug9rSsbqwA==
X-Received: by 2002:a05:6000:2c2:b0:35f:1835:3a62 with SMTP id ffacd0b85a97d-35f18353c74mr5628275f8f.35.1718042613322;
        Mon, 10 Jun 2024 11:03:33 -0700 (PDT)
Received: from cassiopeiae.. ([2a02:810d:4b3f:ee94:642:1aff:fe31:a19f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35f1aed74cesm6273814f8f.112.2024.06.10.11.03.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 11:03:32 -0700 (PDT)
From: Danilo Krummrich <dakr@redhat.com>
To: gregkh@linuxfoundation.org,
	rafael@kernel.org,
	mcgrof@kernel.org,
	russell.h.weight@intel.com,
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
Subject: [PATCH v2 2/2] rust: add firmware abstractions
Date: Mon, 10 Jun 2024 20:02:28 +0200
Message-ID: <20240610180318.72152-3-dakr@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240610180318.72152-1-dakr@redhat.com>
References: <20240610180318.72152-1-dakr@redhat.com>
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
 rust/bindings/bindings_helper.h |   1 +
 rust/kernel/firmware.rs         | 107 ++++++++++++++++++++++++++++++++
 rust/kernel/lib.rs              |   1 +
 3 files changed, 109 insertions(+)
 create mode 100644 rust/kernel/firmware.rs

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
index 000000000000..7ff4c325f670
--- /dev/null
+++ b/rust/kernel/firmware.rs
@@ -0,0 +1,107 @@
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
+/// use kernel::firmware::Firmware;
+///
+/// let fw = Firmware::request("path/to/firmware.bin", dev.as_ref())?;
+/// driver_load_firmware(fw.data());
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
+    /// Send a request for a firmware with platform-fw fallback. See also
+    /// `bindings::firmware_request_platform`.
+    pub fn request_platform(name: &CStr, dev: &Device) -> Result<Self> {
+        Self::request_internal(name, dev, bindings::firmware_request_platform)
+    }
+
+    /// Send a request for a firmware directly without usermode helper. See also
+    /// `bindings::request_firmware_direct`.
+    pub fn request_direct(name: &CStr, dev: &Device) -> Result<Self> {
+        Self::request_internal(name, dev, bindings::request_firmware_direct)
+    }
+
+    fn as_raw(&self) -> *mut bindings::firmware {
+        self.0.as_ptr()
+    }
+
+    /// Returns the size of the requested firmware in bytes.
+    pub fn size(&self) -> usize {
+        // SAFETY: Safe as by the type invariant.
+        unsafe { (*self.as_raw()).size }
+    }
+
+    /// Returns the requested firmware as `&[u8]`.
+    pub fn data(&self) -> &[u8] {
+        // SAFETY: Safe as by the type invariant. Additionally, `bindings::firmware` guarantees, if
+        // sucessfully requested, that `bindings::firmware::data` has a size of
+        // `bindings::firmware::size` bytes.
+        unsafe { core::slice::from_raw_parts((*self.as_raw()).data, self.size()) }
+    }
+}
+
+impl Drop for Firmware {
+    fn drop(&mut self) {
+        // SAFETY: Safe as by the type invariant.
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
index dd1207f1a873..5307aa45bb8d 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -30,6 +30,7 @@
 mod build_assert;
 pub mod device;
 pub mod error;
+pub mod firmware;
 pub mod init;
 pub mod ioctl;
 #[cfg(CONFIG_KUNIT)]
-- 
2.45.1


