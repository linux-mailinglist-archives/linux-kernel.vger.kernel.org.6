Return-Path: <linux-kernel+bounces-344712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5669398AD33
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 21:47:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C7CC28194F
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 19:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6630219DF44;
	Mon, 30 Sep 2024 19:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mq+eXGmG"
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59FB119D89D;
	Mon, 30 Sep 2024 19:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727725645; cv=none; b=MH84N30RSYjPPaqb0yvhCYUd26IoFrSBz2Jx3PPcu7xOfw8fCvTR7WNmYw6k94fPh+ocEDjsx1qgvw4p7WxWLIjGgyKCcuuv96W0rShtAqkkzAhJ3Uuqx/9n3Ua0xPlFP+hUWEHaVGr3EpO0XIdsHWthEk7+Xq+DrNunf0EZJeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727725645; c=relaxed/simple;
	bh=sxcppYaRbHhRyOcuZmVQWPdFD3fnyQS83Gt2V170qgk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bFJO1yERSartDWUxN3ktSkeFgJAcHo8aU7ceBW1EiI9UMCWWaW29skiTD6PEmECTRGxXMkzknIAmp8QbFFMtZWlkZGNwcCJ7UBZv6fR8bnDHvT+TkA4NH2AHph3KRBgNwxtXb7COetYWpexTzu+1J2dvBoQc+4btq1E39wyNWLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mq+eXGmG; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-82cd872755dso226172239f.1;
        Mon, 30 Sep 2024 12:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727725643; x=1728330443; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6gJTEuf7OWEGmW0qcsJKgwiTCztB/8THVBLUbjncmTE=;
        b=mq+eXGmGot1Fu1P6x961BJNjw7uPj+XGTZKaEA9sqHU/a+blVXY+y7dJ3eCAl/wxss
         V+xM9PV+lDGhpXH700whCGv/FgA9mXZ6oaW+/EoHv2gXMVIhX2aP4NJte1WfrWpjSocT
         LdE12UESxnjtGycaFP3FGZwtNE90hi0ic0Yygkw+Z09V2MPBr8JfFkPkzA5o+M8Ed7WW
         1oQ/V28T6upx9yYFshs3lLmn46m8KhdOcnqG9SLJ+yhoxRiclbil2qEzMsRtp5fjP2CU
         uXZaBDb1cF3QKcbx5cGwxYrD1mPZlAma2QdkKDmSY9k6FXDme+QYpf6AxiXXvZq94ctX
         Orwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727725643; x=1728330443;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6gJTEuf7OWEGmW0qcsJKgwiTCztB/8THVBLUbjncmTE=;
        b=ROHojMbkxaOdxMGOH9BQjLFNd2o/X9cusrh2gjG3DsRf8vzMXiOAumfBgC+13wyeoO
         Fv59i+Yh1Lui0GwLq2sBGsRXVS691jQBwTTVkxKdYdHetRmuDpPWmYFoINN/83APsd/A
         PddkYNNOKIRf0/rZPH5pelQ/SQ2H9g3lSoM7Ry7cGt6/kFuNLLMl8G5vOnIKdBPKgtdY
         80hqiSCDEnp1Pd9oUrVtBwTVJJKT6o78OLpylkmVXYe0c/Cp7iOO2XGlhSfOl+Lz5gsf
         wWssQp+Fqv8/eB6J3YvMrlXw4nrf62dmaeSO3bYyYqP3Ojl31PxjxKE7h4qy2AT0E7gD
         gStQ==
X-Forwarded-Encrypted: i=1; AJvYcCUVvylJi1p/9WED5JIhcXBvZfRb/k3BcR55nkDHPiJ2hnCr+bYooonaLw1NbSAjghVCaODSP5+nqJvmX7A=@vger.kernel.org, AJvYcCWSlsVbC/Nvj+rHW75NF9VbP8/lJBoom+widRs/AbEtaCMC1dmhHIVbXwjI6Z+q36lNUmKN1wVTacQYjelFN8A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3WNm5Of78agdC1i51S5IB2LVOmB2HrQmh3xi5otTQyawrsLq0
	0lGpJN0Hpwac4Omk+cU2GWTsNpOeemqJEn2WvIyNIIwzE0cgWk00
X-Google-Smtp-Source: AGHT+IE0OodzvI56j+JSvUOWvYL/YuO3miNejNj7r+Z+ulsuC1qlO8SMAM/Sa8yE5Wh3/wXfN8I3AQ==
X-Received: by 2002:a05:6e02:12ee:b0:3a3:445d:f711 with SMTP id e9e14a558f8ab-3a344fc8ff7mr139017445ab.0.1727725643305;
        Mon, 30 Sep 2024 12:47:23 -0700 (PDT)
Received: from localhost.localdomain ([187.120.154.170])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7e6db2c5d68sm6908082a12.39.2024.09.30.12.47.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 12:47:23 -0700 (PDT)
From: Guilherme Giacomo Simoes <trintaeoitogc@gmail.com>
To: gregkh@linuxfoundation.org,
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
Cc: Guilherme Giacomo Simoes <trintaeoitogc@gmail.com>,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] rust: device: change the from_raw() function
Date: Mon, 30 Sep 2024 16:46:34 -0300
Message-ID: <20240930194637.98260-1-trintaeoitogc@gmail.com>
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

The motivation from this change was will discussion in:
https://rust-for-linux.zulipchat.com/#narrow/stream/291566-Library/topic/Inconsistency.20of.20.60from_raw.60.2E

I would like to thanks for Greg <gregkh@linuxfoundation.org>, Danilo
<dakr@kernel.org> and Alice <aliceryhl@google.com> for help me with this
patch.

2.46.2


