Return-Path: <linux-kernel+bounces-346640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EE7F98C710
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 22:56:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3F01285527
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 20:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E9E01CDFAF;
	Tue,  1 Oct 2024 20:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lHkhhNzp"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D2C31CC884;
	Tue,  1 Oct 2024 20:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727816184; cv=none; b=kNTkHtj9Ywz+0GTnte5LkTazwQmKNVX7JFOHPKVsDRMYQG8W3WLPW3Z7jR9ddQyV+wBPdV9BYCURaEDfcCuo0A1ulANWFdO/2hvoOZc5OG6ZztiaQ60ETdsSaenV7CzQrkHr91TnH+KP5Q56D8zdoghC8FsLfQY4ae5i6UVJShk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727816184; c=relaxed/simple;
	bh=TnoPK5vy/HQ/h0yyC+9UJLvDkuNScDo4GrCUuaAFIrY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RVR4eyDy3oooUA7/1NlZQXSC0sxHViNPhGnleYTTGDqM+8fXJZ7p68zCPQaXL//WpTUNxBhX6OrZWFMn2sh2urr+pMTMu+Yg538RZgiYMJ6pDAe98KZlKyN4dEOpoSt6YsF1KHe+OPWfJIJQ8dRTMNe1BgNY06tiInCw3h/PnJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lHkhhNzp; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-20aff65aa37so48334195ad.1;
        Tue, 01 Oct 2024 13:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727816182; x=1728420982; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hcoh2NOVEmiDU6V6Cjq+y5jb14+gxPDy5OJKbbM8C4E=;
        b=lHkhhNzpuEp8+BOCJMuphQFULP6NoQtx+lP7tmQ3fvSLNB0La4nzr37PnBHswi9uEs
         gFT5K1BEB3jMExDCl/nF+/4NdUdIf6//zboQMzsroU6X6TBWMr0xwb8/fKTjuDkamkGd
         LECyMPs8pX+krN27EiCmUzJTzIkvfJE8cszQxxuKMgdYcXA7NhiC7TdxEEN0537bKcBf
         mm8FQc4RsVD6XVPLZX1m00BDpj2vqC6Lx2XpwwuDaTw5UW0Cc6na7lXHu4ra82oW2bUF
         7HB05YtmQ3a2v+MIWRocPBAtqz1iwdai5nKa/W3eIhEnI2RHSXDwA7kq8/X5CZaWqDfM
         zxMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727816182; x=1728420982;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hcoh2NOVEmiDU6V6Cjq+y5jb14+gxPDy5OJKbbM8C4E=;
        b=ObjaHlGf0Rv3VJTcBX74H/ubJ+ZCN8vFA6lSHUD7irTD5BBkbu8Giw+dBYInij6lhz
         DmKrUCwR9cgF0fdqaK3B4AifDMmgBCJBWrpCEW7y1t5aEvYB+TzA5WaXOBY0xLs/B2R9
         9DV4VgeQlHKtuTDUu3td0PQ3uMzyK/1A3pZ7i6pwAAhA8zQ6V37jnMbEkm7PxF67BdFs
         BYvryjoYMbD+fCT6eLwjCRuNF5jE6vE3MiJJm1wteWOCvUs2sJ8xXUzjBABE9qVqoXKG
         BMuJM4p1vaSHyC658RhERsSz4iiyBiHI0M6beiHWiZE0U010pTRCmcGbYM4g46lA/uqz
         5pLw==
X-Forwarded-Encrypted: i=1; AJvYcCWInKSdkjYVEM02g5gjJbzS+tZUR9Sjb9jDVHtqhmEPcScNbSTLYl/lYG1NdN8uyPgM6fgdHKInMQJmwyw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtCbae+vudhf/8Fg8A0Npcivy9HgQaKSHcZim4o3cd7jiqvE1L
	Gjjfx5R3hYk772NFKcUvcLFwigUByvAUHzxrUOTgGa3/Av7EdftAYQ2WRx4H
X-Google-Smtp-Source: AGHT+IG35MSxo7TqDD6U9qu5WqARtVmZqqhMGPhWL4JFpBqgSaisUNjTOL866CRnhBHbI43Gj97UsA==
X-Received: by 2002:a17:903:32cc:b0:20b:9547:9b2d with SMTP id d9443c01a7336-20bc59f073amr11161415ad.2.1727816181741;
        Tue, 01 Oct 2024 13:56:21 -0700 (PDT)
Received: from localhost.localdomain ([187.120.154.170])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20b37e0d733sm73410295ad.122.2024.10.01.13.56.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 13:56:21 -0700 (PDT)
From: Guilherme Giacomo Simoes <trintaeoitogc@gmail.com>
To: trintaeoitogc@gmail.com,
	gregkh@linuxfoundation.org,
	rafael@kernel.org,
	ojeda@kernel.org,
	alex.gaynor@gmail.com,
	boqun.feng@gmail.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	benno.lossin@proton.me,
	aliceryhl@google.com,
	mcgrof@kernel.org,
	russ.weight@linux.dev,
	dakr@redhat.com,
	a.hindborg@kernel.org
Cc: rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] rust: device: change the from_raw() function
Date: Tue,  1 Oct 2024 17:56:03 -0300
Message-ID: <20241001205603.106278-1-trintaeoitogc@gmail.com>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function Device::from_raw() increments a refcount by a call to
bindings::get_device(ptr). This can be confused because usually
from_raw() functions don't increment a refcount.
Hence, rename Device::from_raw() to avoid confuion with other "from_raw"
semantics.

The new name of function should be "get_device" to be consistent with
the function get_device() already exist in .c files.

This function body also changed, because the `into()` will convert the
`&'a Device` into `ARef<Device>` and also call `inc_ref` from the
`AlwaysRefCounted` trait implemented for Device.

Signed-off-by: Guilherme Giacomo Simoes <trintaeoitogc@gmail.com>
---
differences from v1 to v2:
 - remove the 0/1 patch
 - refactor get_device() function

differences from v2:
- fix the place of changelog.

The motivation from this change was will discussion in:
https://rust-for-linux.zulipchat.com/#narrow/stream/291566-Library/topic/Inconsistency.20of.20.60from_raw.60.2E

I would like to thanks for Greg <gregkh@linuxfoundation.org>, Danilo
<dakr@kernel.org> and Alice <aliceryhl@google.com> for help me with this
patch.
---
 rust/kernel/device.rs   | 15 +++------------
 rust/kernel/firmware.rs |  2 +-
 2 files changed, 4 insertions(+), 13 deletions(-)

diff --git a/rust/kernel/device.rs b/rust/kernel/device.rs
index 851018eef885..c8199ee079ef 100644
--- a/rust/kernel/device.rs
+++ b/rust/kernel/device.rs
@@ -51,18 +51,9 @@ impl Device {
     ///
     /// It must also be ensured that `bindings::device::release` can be called from any thread.
     /// While not officially documented, this should be the case for any `struct device`.
-    pub unsafe fn from_raw(ptr: *mut bindings::device) -> ARef<Self> {
-        // SAFETY: By the safety requirements, ptr is valid.
-        // Initially increase the reference count by one to compensate for the final decrement once
-        // this newly created `ARef<Device>` instance is dropped.
-        unsafe { bindings::get_device(ptr) };
-
-        // CAST: `Self` is a `repr(transparent)` wrapper around `bindings::device`.
-        let ptr = ptr.cast::<Self>();
-
-        // SAFETY: `ptr` is valid by the safety requirements of this function. By the above call to
-        // `bindings::get_device` we also own a reference to the underlying `struct device`.
-        unsafe { ARef::from_raw(ptr::NonNull::new_unchecked(ptr)) }
+    pub unsafe fn get_device(ptr: *mut bindings::device) -> ARef<Self> {
+        // SAFETY: By the safety requirements ptr is valid
+        unsafe { Self::as_ref(ptr) }.into()
     }
 
     /// Obtain the raw `struct device *`.
diff --git a/rust/kernel/firmware.rs b/rust/kernel/firmware.rs
index dee5b4b18aec..13a374a5cdb7 100644
--- a/rust/kernel/firmware.rs
+++ b/rust/kernel/firmware.rs
@@ -44,7 +44,7 @@ fn request_nowarn() -> Self {
 ///
 /// # fn no_run() -> Result<(), Error> {
 /// # // SAFETY: *NOT* safe, just for the example to get an `ARef<Device>` instance
-/// # let dev = unsafe { Device::from_raw(core::ptr::null_mut()) };
+/// # let dev = unsafe { Device::get_device(core::ptr::null_mut()) };
 ///
 /// let fw = Firmware::request(c_str!("path/to/firmware.bin"), &dev)?;
 /// let blob = fw.data();
-- 
2.46.2


