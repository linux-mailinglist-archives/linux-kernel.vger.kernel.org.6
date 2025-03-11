Return-Path: <linux-kernel+bounces-556296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 70435A5C3C3
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 15:27:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2B9E170D6E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 14:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 144DA25D8E2;
	Tue, 11 Mar 2025 14:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BmlBXMoo"
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED2A25D52E
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 14:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741703166; cv=none; b=nNK9D4LhSVA8pzlb47ykaU09zIvNatdpFH1GU8r5qKBTYeR0pGxg+/pJNLGXg7pl91I61pFof2fGUdoyaGIlHSHDKIgZQ7P0MImbodLXSg37yELB3lnbmc3lzB4pxfosh8ExA8AwaGOwSENGaikGy4Ezrz7gEP89leJ8cBuQwYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741703166; c=relaxed/simple;
	bh=YLDJfnUbMN1PwSSNtSoEcVZjewJZ9nhxstVqcUUfZU4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=t/GpMsWsDjgD4RUGroOk2P2N89uePWSoMshuwRZkHTpopIu+6zvuPtq61OKJuPlNm4xzJlVuBceqwhRuXZRYezQ4D+2RwElhys13K/hAs22r+VgY6UQlWlleeYyuTB2MlifvZArc0L1B/55ACEP0h6bPX+yz9MFrj/aA2/vmHEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BmlBXMoo; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-3913b2d355fso1183841f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 07:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741703162; x=1742307962; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+J030Kyqth9TY6nINgFDo0/N/i2k+o/+joXPh9/zVi4=;
        b=BmlBXMoo823cAaVz81GY0ngfTN6JGtmTcJmLekB9/fbj2pZYH3/Y8e57ggEPWSfh5+
         7zrGPMDeD26io277z7eyuotCavjv03+DOuuLPShHs37G4e6gMnprJm4kz+xaWmon6jex
         i8aaRNZliQnGsx5KgvE5Nk0/agzdy8HqWxCrSban87R10l63Qy19EDZ0OfpF6irXUNNX
         XntolFDcebC5EOWXq292ZA1Hco/4q92OmLOEqELOdGMQ6xuPaFOiRb8l82Mjp01YvfZc
         fDiq7HEBt6hGUcmjFTN51G38mV9iblY8uwtSjEzTDPsgPL6l6g7gMqd3/SSsSxBxkJh/
         S7yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741703162; x=1742307962;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+J030Kyqth9TY6nINgFDo0/N/i2k+o/+joXPh9/zVi4=;
        b=MLaEgW09c91ffMQRUOjGDJVpAROSlKMcVUd9eTM/jIjm9xTEYema+V00r52b9lj0SR
         5qeAZiXmiyz9pmLOj/otKBLM/TGeDl4rK2o7MQIYHRL9ytwxapneNbobXXdMfOkl68ZL
         AYJC+uUNTO5R6/XKWpczIwzTlGbNESlL+D7KCLy9gNRQYVIifORzVbMilOXAGKBqz9Ej
         mBT0NDdV9QK3cc6D8R32mzcfgFBAh1TyyhzHJkRuFCFGjD+t7xYiUmz11KxltmdJErt2
         04dUVtW0m6mrcKWyVBg5jw19G9Cqh/vPqsH4tnYJqVHt4t+Rl5EmrwPmBixqZCz/Ne1s
         PQ9w==
X-Forwarded-Encrypted: i=1; AJvYcCU0rUsqQK43c4h4X7HMEJul6HwUd/5UP0239MX0dAdkc+LV7mUi6QVdD2iDVp35S6MPKzHHcR/OBnRXlKY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXZR0joV6EE1HEvgdnWC86SIvgcywRmokVB06Q0LOUDQ53dot2
	EhC/eQDboz0EkeVkW1QNAHX9QGafnydwdfYMKoy3pkvBn2VRTOkZ3mg3f8pJmpQDIcYZ5pjtpHx
	6dWIqokG7Pdv56w==
X-Google-Smtp-Source: AGHT+IHmbq82GGxty29vT8Uza98u35Lktry3y1xJZcFthZ7iY977TvqFf+tzaHDmXSDUdlpUsvzgA+97d1MfYXo=
X-Received: from wmsp38.prod.google.com ([2002:a05:600c:1da6:b0:43c:ef7b:ffac])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:adf:8c09:0:b0:391:3915:cfea with SMTP id ffacd0b85a97d-3913915d3c9mr8648946f8f.38.1741703162695;
 Tue, 11 Mar 2025 07:26:02 -0700 (PDT)
Date: Tue, 11 Mar 2025 14:25:13 +0000
In-Reply-To: <20250311-iov-iter-v1-0-f6c9134ea824@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250311-iov-iter-v1-0-f6c9134ea824@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=6910; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=YLDJfnUbMN1PwSSNtSoEcVZjewJZ9nhxstVqcUUfZU4=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBn0Efy8S2nLnvPlcyMYs0sRA9jDZb3mq3JHX0HW
 rjIbWRaB4mJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZ9BH8gAKCRAEWL7uWMY5
 RnlhEAC5oIsPkR6N6esg79N9/AScNuI3L0Qv59iOW4Jf7SxCmlMv/eWg1QNmZIHh9M0W+4UhRza
 GhwckskXL3mUJAmVCqdBT79xRNpRoqOZ+W2S4eUfLdUMnnT0srNcbzgwFt4Q8dWnLjp+Q3116NW
 m9Ux+vB9p2fNUi5ru+t32WlZ5zs9Prg74WtC23Le+6ombUpJf51M9iB4vNBjodRQjmn1v3UqAP9
 M0jD10jA7bSoeBYPsiq8LsGB7mFAnYwwtrMclmU47XM/1R/Vn9ijrc/TjfDANwuvKnliO50YTBN
 JyVRj8dlHuRQrfZk9uoTzluIEms8QbRrjQMJcxUUOHzU1C3XyutFet48mbyeSL9FEyBwFXyPTq1
 UAOSoeqitvD9UgfckOwItxEavPOhT70xfUQ85U2+kOWg/K6VJ0XczoAALU6QvJatAf1Qfh2ZyaV
 Cy+e5VanSqaV1svTKNiYptP7H24d4J/AtPXhSAbR5vqF4ellPVXlhNNE4RsRQ8eZTHvDAj0YJ72
 l/LOCiwykl+7gRpfi9KvIhkiJZGtlYmD1An/SXHKhuNGL6uD1TvozyQKsf6cYYngTBJmFAbP1za
 eojmMsE2hBwfvL7ooVmLGT3vwfC1aViJ29hoiIVg2Jx+gpmWgiRlnSuou8WHrM8MoMCh29QK56L ht8Mwtcs6s+3lbw==
X-Mailer: b4 0.14.2
Message-ID: <20250311-iov-iter-v1-2-f6c9134ea824@google.com>
Subject: [PATCH 2/5] rust: iov: add iov_iter abstractions for ITER_DEST
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
data_source is ITER_DEST. This will make Rust implementations of
fops->read_iter possible.

This series only has support for using existing IO vectors created by C
code. Additional abstractions will be needed to support the creation of
IO vectors in Rust code.

These abstractions make the assumption that `struct iov_iter` does not
have internal self-references, which implies that it is valid to move it
between different local variables, and that you can make a copy of it to
get two IO vectors into the same buffers.

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/kernel/iov.rs | 140 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 139 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/iov.rs b/rust/kernel/iov.rs
index 4498f65e1f65bd964909810c020db3a9f8fae389..dc32c27c5c76d059562fd7c6b9d4b178a8ea7c81 100644
--- a/rust/kernel/iov.rs
+++ b/rust/kernel/iov.rs
@@ -7,7 +7,12 @@
 //! C headers: [`include/linux/iov_iter.h`](srctree/include/linux/iov_iter.h),
 //! [`include/linux/uio.h`](srctree/include/linux/uio.h)
 
-use crate::{bindings, prelude::*, types::Opaque};
+use crate::{
+    alloc::{Allocator, Flags},
+    bindings,
+    prelude::*,
+    types::Opaque,
+};
 use core::{marker::PhantomData, mem::MaybeUninit, slice};
 
 const ITER_SOURCE: bool = bindings::ITER_SOURCE != 0;
@@ -168,3 +173,136 @@ fn clone(&self) -> IovIterSource<'data> {
         unsafe { core::ptr::read(self) }
     }
 }
+
+/// An IO vector that acts as a destination for data.
+///
+/// # Invariants
+///
+/// Must hold a valid `struct iov_iter` with `data_source` set to `ITER_DEST`. The buffers
+/// referenced by the IO vector must be valid for writing for the duration of `'data`.
+///
+/// Note that if the IO vector is backed by a userspace pointer, it is always considered valid for
+/// writing.
+#[repr(transparent)]
+pub struct IovIterDest<'data> {
+    iov: Opaque<bindings::iov_iter>,
+    /// Represent to the type system that this value contains a pointer to writable data it does
+    /// not own.
+    _source: PhantomData<&'data mut [u8]>,
+}
+
+// SAFETY: This struct is essentially just a fancy `std::io::Cursor<&mut [u8]>`, and that type is
+// safe to send across thread boundaries.
+unsafe impl<'data> Send for IovIterDest<'data> {}
+// SAFETY: This struct is essentially just a fancy `std::io::Cursor<&mut [u8]>`, and that type is
+// safe to share across thread boundaries.
+unsafe impl<'data> Sync for IovIterDest<'data> {}
+
+impl<'data> IovIterDest<'data> {
+    /// Obtain an `IovIterDest` from a raw pointer.
+    ///
+    /// # Safety
+    ///
+    /// * For the duration of `'iov`, the `struct iov_iter` must remain valid and must not be
+    ///   accessed except through the returned reference.
+    /// * For the duration of `'data`, the buffers backing this IO vector must be valid for
+    ///   writing.
+    #[track_caller]
+    #[inline]
+    pub unsafe fn from_raw<'iov>(ptr: *mut bindings::iov_iter) -> &'iov mut IovIterDest<'data> {
+        // SAFETY: The caller ensures that `ptr` is valid.
+        let data_source = unsafe { (*ptr).data_source };
+        assert_eq!(data_source, ITER_DEST);
+
+        // SAFETY: The caller ensures the struct invariants for the right durations.
+        unsafe { &mut *ptr.cast::<IovIterDest<'data>>() }
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
+    /// Write data to this IO vector.
+    ///
+    /// Returns the number of bytes that were written. If this is shorter than the provided slice,
+    /// then no more bytes can be written.
+    #[inline]
+    pub fn copy_to_iter(&mut self, input: &[u8]) -> usize {
+        // SAFETY: `input` is valid for `input.len()` bytes.
+        unsafe { bindings::_copy_to_iter(input.as_ptr().cast(), input.len(), self.as_raw()) }
+    }
+
+    /// Utility for implementing `read_iter` given the full contents of the file.
+    ///
+    /// The full contents of the file being read from is represented by `contents`. This call will
+    /// write the appropriate sub-slice of `contents` and update the file position in `ppos` so
+    /// that the file will appear to contain `contents` even if takes multiple reads to read the
+    /// entire file.
+    #[inline]
+    pub fn simple_read_from_buffer(&mut self, ppos: &mut i64, contents: &[u8]) -> Result<usize> {
+        if *ppos < 0 {
+            return Err(EINVAL);
+        }
+        let Ok(pos) = usize::try_from(*ppos) else {
+            return Ok(0);
+        };
+        if pos >= contents.len() {
+            return Ok(0);
+        }
+
+        // BOUNDS: We just checked that `pos < contents.len()` above.
+        let num_written = self.copy_to_iter(&contents[pos..]);
+
+        // OVERFLOW: pos+num_written <= contents.len() <= isize::MAX <= i64::MAX
+        *ppos = (pos + num_written) as i64;
+
+        Ok(num_written)
+    }
+}

-- 
2.49.0.rc0.332.g42c0ae87b1-goog


