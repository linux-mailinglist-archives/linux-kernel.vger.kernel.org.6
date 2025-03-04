Return-Path: <linux-kernel+bounces-544071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 335ADA4DD0C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 12:53:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B45BB7AC5F2
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 11:52:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7293204689;
	Tue,  4 Mar 2025 11:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="W5/Qsoj8"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C3B02040B0
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 11:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741089118; cv=none; b=OTe5sXd1xaHWGYyvDhTYfZ9DphpcXSj8ODrMTAN1u4aS51aPyXfB615UmtZ0FmQ1z4w//UGnck1dJ67ipnGOK2jLBGBA0W4G/Wx0rLK3LylKWnTvZIusmDfyLA2cRyntgz6UmTMF5cXaWP6cVNe8W80sn/w7DJtbnp5STP8DTI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741089118; c=relaxed/simple;
	bh=6ix7Yh05nsg0+BRkgBinynB7537OSvluG9ZV2/ywotA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gVUCv51uWTbzjPl/2prJms+iMbKFIxmtXqmOSEgCUGqJwL+u9qmsA2+H/asGuQKWJCBREcY9CP9ZKwfWHssLEMgyFx+xnuYkri30vRj05Lo9uwv1dUgw5gOOKJNZY3JeeInPjzJOJj79BMh3tUd4lbCYGrP42PWQFFd1YuVlstQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=W5/Qsoj8; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-43bc1aa0673so9839765e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 03:51:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741089113; x=1741693913; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=FL6QF1vf/aSpNg0U7JqjgxuXk5Djy4reKV1N7d1McJg=;
        b=W5/Qsoj8Acu0QNuG5LC8o8uu314wtsjXnqJKqgfiGagaBc0dkI8HAQBKuaFY0wdvX3
         XrlrKJInXT5ejGgbJ9sQk5Yk81FHOvFiYCrAiqowiySTqiRrnI4fTUwaw6gasGA/3Nxb
         ic6KS6s7WL7Qp50fbpVnTwpwDw5X0J8zG+4W8z0dVMn6u2PywrfCBFepJmuUTHReL4/D
         MB8qDZONxSGVVGddYT2PiHehaX4KqOlCOP2rN+l0sB96vDNifUt3BZ1bKlPZEsGfZnOk
         RR1zcAdrZHf2gyNfL/YeZ+Meb+b5uAtEt/WyB7Vtdp/E5wlmmqDVRRpdIC7WseejAXVS
         eJbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741089113; x=1741693913;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FL6QF1vf/aSpNg0U7JqjgxuXk5Djy4reKV1N7d1McJg=;
        b=EhO7bwgTD5pgpMhaEV1z1fXTY517hqSaW/AhzN197HjuC08x165s+4WiMHbsNIYTqO
         2LvgGLYOxmF6I/J1+x4A4PKHas0wdA2sS/w7ZKsTtJ2Z/+2FFwMgy/o/4ccuk0AWZtOA
         hblH0Pu2k4zaWCnfbmo7pvwDD0DqbLzFewIX2Gn1Jeq4Dzvo/nleBdk0XyU/kueSA0zN
         eyIGp/ow3O6gc0Pb9zeYh6vEwCLBZBmszw7WZUHHwNVbj18E/RqSpcp4AfXl0gPWOfsx
         sx59U34Gqwo7u0i+rA4sTXqxfO4AlYGBKMbt2etfpuroUklR1JFnPIysll51AU2bgWPZ
         5+rw==
X-Forwarded-Encrypted: i=1; AJvYcCXoQx2qE6J7MQPtUYlbZ9sJWnJzfIYK3Sg1moLjBh3GJ3GHjG1/e2nmasBhFKYuXVwoD55YjwIGyZpx1+k=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywm5DNwDwniEEyBbIDmvm0jvSiGt8gduE7U8DoR1cNeK/vpvrnB
	hcprvTy32lPqdGKFBArry9rVJmM0XphlHX3eXbbopYSVCIFRYW5muGuIGqY4HYwptxaURphU8xv
	d68nDv5cNKQ3emg==
X-Google-Smtp-Source: AGHT+IGmelcITCLSxHDM+ol2aAuW+SX1n24peFVEH2jDRbxRitIa4L9bodIVhVTmWM6MYSThFc/JIyzqdk61KPY=
X-Received: from wmsp23.prod.google.com ([2002:a05:600c:1d97:b0:43b:c59f:5eb4])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:511e:b0:439:6017:6689 with SMTP id 5b1f17b1804b1-43ba66e0bf5mr134523075e9.9.1741089113515;
 Tue, 04 Mar 2025 03:51:53 -0800 (PST)
Date: Tue, 04 Mar 2025 11:49:58 +0000
In-Reply-To: <20250304-vma-v15-0-5c641b31980a@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250304-vma-v15-0-5c641b31980a@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=4010; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=6ix7Yh05nsg0+BRkgBinynB7537OSvluG9ZV2/ywotA=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBnxulG4bX1vws8nKbvRQGg/HqDRGItXCMIy067J
 UtrjP8bcg2JAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZ8bpRgAKCRAEWL7uWMY5
 Ri5ND/4qzKj39WFiIJmDQtStg/DTeOLhovy/f+nq4dxxKjIfPkCXN7mCBwdVuyaZ9IzpZiig/Pr
 JjlUejmUYiv7GpXNwQ5fevvLnl2gcsS1Ww7K77rmGyLn0NSzhVvcqZcao+XO/4XJt6+XVtvMz1V
 WBioMluf2e0EYFq9tTgyMbxs30d2OPKQTdMBKNpgYFXQT8S/Ce2+TokcsxSrswN6WzxBaSXwFs4
 vRooNosfXpQ9rl/CMycHIVLQyQ5+Jt7zL6o/RMAu+HbDp97x7c3D0vNJ8COJNYSNkfQyjRZOH+u
 F8SnH4QGOnzt/WmfwjdLOWZZAMqop2kISubcoSUSqZjRykmfS/498SXFXeXyeaUaVWHDH4qcZX9
 A+xW9AB1b1Pwo1yR2dF1KkC668o9aBCnVWc+OC68hEn7PoO3wGTMwMjr/Dy48ASSh5hmdk0yVJU
 R2KomJV44m9VI3/5Xh8pJWvqS3z0BqUe4Kav9e4WepTAk4ez1a7Kr/jk9guvCkT/EuW9+kf3vqO
 lEMYpTjt8VuhMEqFGnTSDh3AiPQCgKVDPpLIaRdvE+uPl9AvDfpkrtdwg14IX3dnHQYUDC1L20f
 74KnV/YeVER1hTZMagxWLY/LsEtTbKcOy/w81SF+BaH/9ihcVLAzKHC+ETYboYoKrzb64CNSBdM TUDoUxIAgm/EwsA==
X-Mailer: b4 0.14.2
Message-ID: <20250304-vma-v15-7-5c641b31980a@google.com>
Subject: [PATCH v15 7/9] rust: miscdevice: add mmap support
From: Alice Ryhl <aliceryhl@google.com>
To: Miguel Ojeda <ojeda@kernel.org>, Matthew Wilcox <willy@infradead.org>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	John Hubbard <jhubbard@nvidia.com>, "Liam R. Howlett" <Liam.Howlett@Oracle.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>, Suren Baghdasaryan <surenb@google.com>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, rust-for-linux@vger.kernel.org, 
	Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="utf-8"

Add the ability to write a file_operations->mmap hook in Rust when using
the miscdevice abstraction. The `vma` argument to the `mmap` hook uses
the `VmaNew` type from the previous commit; this type provides the
correct set of operations for a file_operations->mmap hook.

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Acked-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Acked-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>
Reviewed-by: Gary Guo <gary@garyguo.net>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/kernel/miscdevice.rs | 44 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/rust/kernel/miscdevice.rs b/rust/kernel/miscdevice.rs
index e14433b2ab9d8fa391474b2ad7e3ed55c64b4d91..e4a2c599683243ac955b7c95e0645b8c1010b25f 100644
--- a/rust/kernel/miscdevice.rs
+++ b/rust/kernel/miscdevice.rs
@@ -14,6 +14,7 @@
     error::{to_result, Error, Result, VTABLE_DEFAULT_ERROR},
     ffi::{c_int, c_long, c_uint, c_ulong},
     fs::File,
+    mm::virt::VmaNew,
     prelude::*,
     seq_file::SeqFile,
     str::CStr,
@@ -119,6 +120,22 @@ fn release(device: Self::Ptr, _file: &File) {
         drop(device);
     }
 
+    /// Handle for mmap.
+    ///
+    /// This function is invoked when a user space process invokes the `mmap` system call on
+    /// `file`. The function is a callback that is part of the VMA initializer. The kernel will do
+    /// initial setup of the VMA before calling this function. The function can then interact with
+    /// the VMA initialization by calling methods of `vma`. If the function does not return an
+    /// error, the kernel will complete initialization of the VMA according to the properties of
+    /// `vma`.
+    fn mmap(
+        _device: <Self::Ptr as ForeignOwnable>::Borrowed<'_>,
+        _file: &File,
+        _vma: &VmaNew,
+    ) -> Result {
+        kernel::build_error!(VTABLE_DEFAULT_ERROR)
+    }
+
     /// Handler for ioctls.
     ///
     /// The `cmd` argument is usually manipulated using the utilties in [`kernel::ioctl`].
@@ -176,6 +193,7 @@ impl<T: MiscDevice> VtableHelper<T> {
         const VTABLE: bindings::file_operations = bindings::file_operations {
             open: Some(fops_open::<T>),
             release: Some(fops_release::<T>),
+            mmap: maybe_fn(T::HAS_MMAP, fops_mmap::<T>),
             unlocked_ioctl: maybe_fn(T::HAS_IOCTL, fops_ioctl::<T>),
             #[cfg(CONFIG_COMPAT)]
             compat_ioctl: if T::HAS_COMPAT_IOCTL {
@@ -257,6 +275,32 @@ impl<T: MiscDevice> VtableHelper<T> {
     0
 }
 
+/// # Safety
+///
+/// `file` must be a valid file that is associated with a `MiscDeviceRegistration<T>`.
+/// `vma` must be a vma that is currently being mmap'ed with this file.
+unsafe extern "C" fn fops_mmap<T: MiscDevice>(
+    file: *mut bindings::file,
+    vma: *mut bindings::vm_area_struct,
+) -> c_int {
+    // SAFETY: The mmap call of a file can access the private data.
+    let private = unsafe { (*file).private_data };
+    // SAFETY: This is a Rust Miscdevice, so we call `into_foreign` in `open` and `from_foreign` in
+    // `release`, and `fops_mmap` is guaranteed to be called between those two operations.
+    let device = unsafe { <T::Ptr as ForeignOwnable>::borrow(private) };
+    // SAFETY: The caller provides a vma that is undergoing initial VMA setup.
+    let area = unsafe { VmaNew::from_raw(vma) };
+    // SAFETY:
+    // * The file is valid for the duration of this call.
+    // * There is no active fdget_pos region on the file on this thread.
+    let file = unsafe { File::from_raw_file(file) };
+
+    match T::mmap(device, file, area) {
+        Ok(()) => 0,
+        Err(err) => err.to_errno(),
+    }
+}
+
 /// # Safety
 ///
 /// `file` must be a valid file that is associated with a `MiscDeviceRegistration<T>`.

-- 
2.48.1.711.g2feabab25a-goog


