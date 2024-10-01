Return-Path: <linux-kernel+bounces-346362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5A4C98C3B2
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 18:44:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A36A1F23BDE
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 16:44:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D2131CB52C;
	Tue,  1 Oct 2024 16:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="frqGzVwW"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A5ED1CB50B;
	Tue,  1 Oct 2024 16:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727801054; cv=none; b=U5SrI1dRzu9k3hn/thaXPAUU7GNgnlNzEI6+38g/NKXQMCbowZlsjpLGP2nN3ynodsC1fF5RHyZz1SEQ4Fza7yhp5qYfKomIqk1/4J3yf7Z1sC7rPk7xR2SFvG8ZIBpMSHqWHrGzoHaTsh9sYxWLI7qkcqEfyXhAEkRcSAAUUbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727801054; c=relaxed/simple;
	bh=A1GbC6QnT2skV8EXhJYflowW0fqzy73KH+1reknAW6I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=S2T7SMSSviAtNPRPmb4BNeCJglavEPRcf8v/Tz7qrhTv7eEohK/5hP7vOvNAefrE22BK2oFTWZ/ERIkDivK7ybdsIawogC+efAE6VJ5gslT7oPsBOoyyeMLujBHpi7mHzRAz/y64rFMJzi4OwG6QXhzIf5+MIsxaP96elnG2S1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=frqGzVwW; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-20b90ab6c19so23092075ad.0;
        Tue, 01 Oct 2024 09:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727801052; x=1728405852; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LfjVhA7MkxoHvYBqjh/+pkRp4gETm6MyBR8RlXaOZmM=;
        b=frqGzVwWAegqr4KwcWnLS7bqxjCQUF52AbjYlPjpRF4Ml/8IJM4g2FkyFdzD5YuvDj
         yrQJ3mJ3NFRusGxJPEfOzdLHyK3bcPtbGbNrwGmuvc5wMbf0OkZATT16wlxS8vbBUM+v
         q5KAN/V67ULfwRqIIZcAr1WUgXBzytQ3G3tx7BTSkkrKMqEEnMVZvoFG7HCsON2R87p6
         CfmGUhugVLlbskF5GId613g6PCIyMFenOmDEf47RMjMCuXoLDNUk4eIHFmTpyeH91yQy
         34EMeyEWodABn6QKSdmGG72lNQyQmubCdOnmU5XEkqmSEcMvmhT2q0l5A3MMnLjJ0Kum
         aaqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727801052; x=1728405852;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LfjVhA7MkxoHvYBqjh/+pkRp4gETm6MyBR8RlXaOZmM=;
        b=uRY/enOylE8nSUBjNQi5YQoqpZNVIFOf9RC6ZBBqM2FN96JXU19QbEKO/5zKhEpgcg
         kD1VB3CjA1UFbQTR0AGB+54eOf2Kphrak/cIAqXtDm4zQhM7x+u1Epi5u5fvzSpodSfG
         J177sP60MzJurqpk8ge/0+RXA2w7T4W0JSiyKu/NnxiqWZ7N1/HICw9cyJbhO0BiZeNN
         PGs4UX57COl4AxsOhje/6F+Dp8K/NZ2H0Cv7EObp/XD3UVX96yE6ULNVy5waDKc7Jmuv
         qSdWg9GKL0RD5u0f4yvn5pyLQTuwcrMTLjsliSI0jHz4I2b2viuzSr63vYPhqsLDo8/L
         vx8g==
X-Forwarded-Encrypted: i=1; AJvYcCUZo3tCTR9Q5VEE1HdLvRyAmZuM3j++EAyGZX6mN2lOU7PhsxrmnftOXzYGCZe1DOnCZAvxwaPY0IKpuFE=@vger.kernel.org, AJvYcCX7ZHDzqkhcnBzBJv95whuA/l9W4wo087PIwQAEWMmN6Bm0fzWG7VZXzR8fTADNJArJC0Bozi6VFxpiFXZN4QE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRG5J36CBsMZ+5t7ETy2LO2JgHP+HeLt8A7HtkA5fTlbD0kyJ8
	7O1EhZxMakST45t4tD4bk8WZnWbdli6fPdEy0X2ms8zR68/2qfCE
X-Google-Smtp-Source: AGHT+IHJ4giTGRHviX2+3G97ljjXYHc2Mz3pY+I4usklioRWwLGPguiJVH23MR3lk+MsAdV/8gTxGQ==
X-Received: by 2002:a17:902:7481:b0:20b:b40b:345a with SMTP id d9443c01a7336-20bc5ae972fmr2464195ad.52.1727801052384;
        Tue, 01 Oct 2024 09:44:12 -0700 (PDT)
Received: from localhost.localdomain ([187.120.154.170])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20b37e328f4sm71628165ad.194.2024.10.01.09.44.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 09:44:12 -0700 (PDT)
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
Subject: [PATCH v2] rust: device: change the from_raw() function
Date: Tue,  1 Oct 2024 13:43:38 -0300
Message-ID: <20241001164355.104918-1-trintaeoitogc@gmail.com>
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

differences from v1:
- this version don't have 0/1 patch anymore.
- this version contains a refactor get_device() function

The motivation from this change was will discussion in:
https://rust-for-linux.zulipchat.com/#narrow/stream/291566-Library/topic/Inconsistency.20of.20.60from_raw.60.2E

I would like to thanks for Greg <gregkh@linuxfoundation.org>, Danilo
<dakr@kernel.org> and Alice <aliceryhl@google.com> for help me with this
patch.

2.46.2


