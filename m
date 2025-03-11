Return-Path: <linux-kernel+bounces-556295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A9842A5C3C1
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 15:27:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F94D1893981
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 14:27:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1FA325D53E;
	Tue, 11 Mar 2025 14:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FZp307yP"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BB9F25BAB7
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 14:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741703164; cv=none; b=khy2eCAC03aFwbHSXWr50ptstNkZTl9A38drNV4c99mQM/f1HzmeLetBhyWBkQ5jmGm2jAg8kcgrT597txod8X6NplvsZwAOSuOQ1n8zKVUuqkK247dmYnjyts5S4ewU/yyhMVzEhHqkm+k/+rQEukY6genPwaS97g6iSTgRPcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741703164; c=relaxed/simple;
	bh=wrUCwsyJRmjP/dsv9Wg9msOH5X59Uyr1+r3sd7reY1c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FeXPRnKeSi+rByetBgalzEfl8BiSFisCCfDt7Jhn4DLM+KSqKDqrkPvrd4HbAJ3ecCWdNf5ysDzK1gAVUI/tw0Q80A/LM9jLUK/FQTrhkQA10rVsE8+r8m4ZT+59AQ5D+YFdmguMTLIwM7yDMxU1pLhdjaqB9nyUSmQUkLqE68I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FZp307yP; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-43947979ce8so25470995e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 07:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741703160; x=1742307960; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=XAQ1FUliBVYkaAD+n9y8S+Mp9b1382qcZiMQ8LUAODU=;
        b=FZp307yPjMWkHDl1QCazn0FazdFTszJkCW7uytV+SertkCQTINQ981XxmyPJZCzByG
         NEEuDrrzB9uD1FyChDR0PYgB2cl9UDSYAClAfXoRHXcpm4PZc0UZg9Tc7E9hKl+H1oNz
         kis3Ak6sPEGH1DnHrjcbbLAOAVh6ifa4I4npXbLLlCY7vwzpgwm/lAQPfBbpDhINw7iH
         n3uI9ngH5N7Bd1EqwmF0sq0WGsrihpbHRIbVMUo80IFo6EgCvXPoQSZ+7ZXTkxnW9oMA
         PgduFFOMK8jh63c9hiELKVF34khupoH55SBbLiP5KzBuazcPLeWyzUmpZFdszAsz5ugP
         X30A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741703160; x=1742307960;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XAQ1FUliBVYkaAD+n9y8S+Mp9b1382qcZiMQ8LUAODU=;
        b=ln7U18XPlfA2d8+3VFfGHf63kPRu3SG/kWEEatahmKDCdY+fjeeIRMGNXORAhTEO+k
         MEWL7hV0jxKK0xF3Z1wz71ThMQBnrSTfG7lILNyfMDV7aAr3EUTh84Idaa9SxF1DwyVq
         M/+VLV9SdYP9UgLzJ+9ELgGZ6U352pj82OFgUSuzZMQABHvB3ZYP+c+StgUm0MUr6W7m
         KanDvzpKF/wCyJaMXi+33nhCrRIo1qcRDzZx+WRm62hxNpFDEXxKukk5WMt+fLHqduxU
         Pta6+v3vk5ErN5dFoICtSk/UzjHP3dShxpXvSA0NcJI9Wt7C9cBuzjesSZrJ8/VYsEYY
         NIlA==
X-Forwarded-Encrypted: i=1; AJvYcCWYDBE5aFi5RNAmBYfIuy1c4+SnuEKYxIEWdIEKOiYvaNB3ScVKCSeyXrbAVpamXN4X1o7zs5Pv9G1nfsE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuAVKZVyPWAswQbyVIDvqu2SMFgg1vU3IeuRo2NASDVt37/T67
	kp52zl8xe3k4xQ37zXS0cc/n1AsVXN6mGvGy+6McXltGvA9VT3k76fE7GjVmV2PRGM4qPhi4vdK
	ap+v82Tqos612Kw==
X-Google-Smtp-Source: AGHT+IH8X7syBO/BR94wku7hfOlNXYhoSadQYVQ/hyX3LTlizGhCLEDVYfRSWty4zN9vf03B+L910ZT+M2/N6SM=
X-Received: from wmbbe11.prod.google.com ([2002:a05:600c:1e8b:b0:43c:f482:222])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3143:b0:43c:fe90:1282 with SMTP id 5b1f17b1804b1-43d01bdbac8mr51871555e9.7.1741703160581;
 Tue, 11 Mar 2025 07:26:00 -0700 (PDT)
Date: Tue, 11 Mar 2025 14:25:12 +0000
In-Reply-To: <20250311-iov-iter-v1-0-f6c9134ea824@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250311-iov-iter-v1-0-f6c9134ea824@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=8113; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=wrUCwsyJRmjP/dsv9Wg9msOH5X59Uyr1+r3sd7reY1c=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBn0EfxJH+IABQmDdLn38Mk4R76y27qEBjJKm65Y
 aG7qXtCIJqJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZ9BH8QAKCRAEWL7uWMY5
 Rn+oD/42n0z0SD+PdVC5NR+ZfVL4W3oeFFdAg7N2bnebrHCnrlLaQw4peRCitr6iJaMbiwLKAsw
 WSGE3kGs7xPtrn4SIGPI5y4xU32AJUYyRGi7wswlmreWq+4r68TmsfW8+JY3l5GsrFxRbA5T0H4
 vp3hXn4uCSIj5pblg3c0lu7GLTbqn4/761ctDpz7G0qD0hDQ8RdpFu87nCiX5COiGZRNy7qOVuA
 eIwmNhOugYhtpboYxmMP+nijjoq8Zkpjpchc/8PboDqcvafM3HxndMcPwmS7XA+YDDExS8s+VHl
 dK7Ka23FoRqfGmTTr9sthJxtGU/2GiXKcbr+pQsa2az05OyvFyMOsQ2IK3bBCi2TEVmCTYNHCQn
 0N20KYmmOAWcy3PUkMYR0sdhBZaa1Wodo2xXHbJPERruDdpXNKUeRLDJjy/RuIT1GngAvZNeJLA
 M7JdhaPEAzRArDqpqvhFTsGsikfH9KBA07va+kX8s3XFCNPInE8XkmCTkP34YY0ly0qPbIzBhdk
 pQrCq7/2767EOtxI1wYPXRuKeXeyljmdqqU1nSYWLK78zgnuxCkmvb4ZnhF7AON3R+AdtaOuHHn
 ZLf6hGQ6FGvjrxyO3I/7uE1qrjmoWqUbiXfcR1Hks0f36KyOk+70NnxDko4W6A6oFO8zVhKKs46 OBUsrNt/Y4Y4Sbw==
X-Mailer: b4 0.14.2
Message-ID: <20250311-iov-iter-v1-1-f6c9134ea824@google.com>
Subject: [PATCH 1/5] rust: iov: add iov_iter abstractions for ITER_SOURCE
From: Alice Ryhl <aliceryhl@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Arnd Bergmann <arnd@arndb.de>, Miguel Ojeda <ojeda@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Matthew Maurer <mmaurer@google.com>, Lee Jones <lee@kernel.org>, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="utf-8"

This adds abstractions for the iov_iter type in the case where
data_source is ITER_SOURCE. This will make Rust implementations of
fops->write_iter possible.

This series only has support for using existing IO vectors created by C
code. Additional abstractions will be needed to support the creation of
IO vectors in Rust code.

These abstractions make the assumption that `struct iov_iter` does not
have internal self-references, which implies that it is valid to move it
between different local variables, and that you can make a copy of it to
get two IO vectors into the same buffers.

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/kernel/iov.rs | 170 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 rust/kernel/lib.rs |   1 +
 2 files changed, 171 insertions(+)

diff --git a/rust/kernel/iov.rs b/rust/kernel/iov.rs
new file mode 100644
index 0000000000000000000000000000000000000000..4498f65e1f65bd964909810c020db3a9f8fae389
--- /dev/null
+++ b/rust/kernel/iov.rs
@@ -0,0 +1,170 @@
+// SPDX-License-Identifier: GPL-2.0
+
+// Copyright (C) 2025 Google LLC.
+
+//! IO vectors.
+//!
+//! C headers: [`include/linux/iov_iter.h`](srctree/include/linux/iov_iter.h),
+//! [`include/linux/uio.h`](srctree/include/linux/uio.h)
+
+use crate::{bindings, prelude::*, types::Opaque};
+use core::{marker::PhantomData, mem::MaybeUninit, slice};
+
+const ITER_SOURCE: bool = bindings::ITER_SOURCE != 0;
+const ITER_DEST: bool = bindings::ITER_DEST != 0;
+
+// Compile-time assertion for the above constants.
+const _: () = {
+    if ITER_SOURCE == ITER_DEST {
+        panic!("ITER_DEST and ITER_SOURCE should be different.");
+    }
+};
+
+/// An IO vector that acts as a source of data.
+///
+/// # Invariants
+///
+/// Must hold a valid `struct iov_iter` with `data_source` set to `ITER_SOURCE`. The buffers
+/// referenced by the IO vector must be valid for reading for the duration of `'data`.
+///
+/// Note that if the IO vector is backed by a userspace pointer, it is always considered valid for
+/// reading.
+#[repr(transparent)]
+pub struct IovIterSource<'data> {
+    iov: Opaque<bindings::iov_iter>,
+    /// Represent to the type system that this value contains a pointer to readable data it does
+    /// not own.
+    _source: PhantomData<&'data [u8]>,
+}
+
+// SAFETY: This struct is essentially just a fancy `std::io::Cursor<&[u8]>`, and that type is safe
+// to send across thread boundaries.
+unsafe impl<'data> Send for IovIterSource<'data> {}
+// SAFETY: This struct is essentially just a fancy `std::io::Cursor<&[u8]>`, and that type is safe
+// to share across thread boundaries.
+unsafe impl<'data> Sync for IovIterSource<'data> {}
+
+impl<'data> IovIterSource<'data> {
+    /// Obtain an `IovIterSource` from a raw pointer.
+    ///
+    /// # Safety
+    ///
+    /// * For the duration of `'iov`, the `struct iov_iter` must remain valid and must not be
+    ///   accessed except through the returned reference.
+    /// * For the duration of `'data`, the buffers backing this IO vector must be valid for
+    ///   reading.
+    #[track_caller]
+    #[inline]
+    pub unsafe fn from_raw<'iov>(ptr: *mut bindings::iov_iter) -> &'iov mut IovIterSource<'data> {
+        // SAFETY: The caller ensures that `ptr` is valid.
+        let data_source = unsafe { (*ptr).data_source };
+        assert_eq!(data_source, ITER_SOURCE);
+
+        // SAFETY: The caller ensures the struct invariants for the right durations.
+        unsafe { &mut *ptr.cast::<IovIterSource<'data>>() }
+    }
+
+    /// Access this as a raw `struct iov_iter`.
+    #[inline]
+    pub fn as_raw(&mut self) -> *mut bindings::iov_iter {
+        self.iov.get()
+    }
+
+    /// Returns the number of bytes available in this IO vector.
+    ///
+    /// Note that this may overestimate the number of bytes. For example, reading from userspace
+    /// memory could fail with EFAULT, which will be treated as the end of the IO vector.
+    #[inline]
+    pub fn len(&self) -> usize {
+        // SAFETY: It is safe to access the `count` field.
+        unsafe {
+            (*self.iov.get())
+                .__bindgen_anon_1
+                .__bindgen_anon_1
+                .as_ref()
+                .count
+        }
+    }
+
+    /// Returns whether there are any bytes left in this IO vector.
+    ///
+    /// This may return `true` even if there are no more bytes available. For example, reading from
+    /// userspace memory could fail with EFAULT, which will be treated as the end of the IO vector.
+    #[inline]
+    pub fn is_empty(&self) -> bool {
+        self.len() == 0
+    }
+
+    /// Advance this IO vector by `bytes` bytes.
+    ///
+    /// If `bytes` is larger than the size of this IO vector, it is advanced to the end.
+    #[inline]
+    pub fn advance(&mut self, bytes: usize) {
+        // SAFETY: `self.iov` is a valid IO vector.
+        unsafe { bindings::iov_iter_advance(self.as_raw(), bytes) };
+    }
+
+    /// Advance this IO vector backwards by `bytes` bytes.
+    ///
+    /// # Safety
+    ///
+    /// The IO vector must not be reverted to before its beginning.
+    #[inline]
+    pub unsafe fn revert(&mut self, bytes: usize) {
+        // SAFETY: `self.iov` is a valid IO vector, and `bytes` is in bounds.
+        unsafe { bindings::iov_iter_revert(self.as_raw(), bytes) };
+    }
+
+    /// Read data from this IO vector.
+    ///
+    /// Returns the number of bytes that have been copied.
+    #[inline]
+    pub fn copy_from_iter(&mut self, out: &mut [u8]) -> usize {
+        // SAFETY: We will not write uninitialized bytes to `out`.
+        let out = unsafe { &mut *(out as *mut [u8] as *mut [MaybeUninit<u8>]) };
+
+        self.copy_from_iter_raw(out).len()
+    }
+
+    /// Read data from this IO vector and append it to a vector.
+    ///
+    /// Returns the number of bytes that have been copied.
+    #[inline]
+    pub fn copy_from_iter_vec<A: Allocator>(
+        &mut self,
+        out: &mut Vec<u8, A>,
+        flags: Flags,
+    ) -> Result<usize> {
+        out.reserve(self.len(), flags)?;
+        let len = self.copy_from_iter_raw(out.spare_capacity_mut()).len();
+        // SAFETY: The next `len` bytes of the vector have been initialized.
+        unsafe { out.set_len(out.len() + len) };
+        Ok(len)
+    }
+
+    /// Read data from this IO vector into potentially uninitialized memory.
+    ///
+    /// Returns the sub-slice of the output that has been initialized. If the returned slice is
+    /// shorter than the input buffer, then the entire IO vector has been read.
+    #[inline]
+    pub fn copy_from_iter_raw(&mut self, out: &mut [MaybeUninit<u8>]) -> &mut [u8] {
+        // SAFETY: `out` is valid for `out.len()` bytes.
+        let len =
+            unsafe { bindings::_copy_from_iter(out.as_mut_ptr().cast(), out.len(), self.as_raw()) };
+
+        // SAFETY: We just initialized the first `len` bytes of `out`.
+        unsafe { slice::from_raw_parts_mut(out.as_mut_ptr().cast(), len) }
+    }
+}
+
+impl<'data> Clone for IovIterSource<'data> {
+    #[inline]
+    fn clone(&self) -> IovIterSource<'data> {
+        // SAFETY: This duplicates the bytes inside the `Opaque` value exactly. Since `struct
+        // iov_iter` does not have any internal self references, that is okay.
+        //
+        // Since this IO vector only reads from the backing buffers, having multiple IO vectors to
+        // the same source can't lead to data races on the backing buffers.
+        unsafe { core::ptr::read(self) }
+    }
+}
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index 398242f92a961c3a445d681c65449047a847968a..de9d6e797953cb69637eef127997b1f357f3f90b 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -53,6 +53,7 @@
 pub mod init;
 pub mod io;
 pub mod ioctl;
+pub mod iov;
 pub mod jump_label;
 #[cfg(CONFIG_KUNIT)]
 pub mod kunit;

-- 
2.49.0.rc0.332.g42c0ae87b1-goog


