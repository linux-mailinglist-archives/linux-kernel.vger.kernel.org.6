Return-Path: <linux-kernel+bounces-512754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 748C8A33D67
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 12:07:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03A37169E98
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 11:06:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E7B02153FC;
	Thu, 13 Feb 2025 11:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Wa6jmLKm"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B51552153DF
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 11:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739444695; cv=none; b=TDn3GjLHFVol9bMa4blvDGaYP1MqaLJrTLrWA2M3+CI1lO5XVvY92PfRjrFB4QJCO3HrcnAzfetVuANvBvMgqRZjoQo6cVVhrp5OImI+27VjzpWrAUdTsCBVroVvtv9B4eAdmStBsRetSWWoXQz/TKB0SYNNEYNXBQgNxFSPN08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739444695; c=relaxed/simple;
	bh=2M89B3p91FPP25Gw8Y6SiWDXagycK/dpbfENE1t2aLQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pmaYVvcgW/HXWcFAyD7fDm5fr3TZ/qbKdU7rmqmb2YqM/SQgFtUSp71RYRcntIaNz/Qa9bIjw6viPE1P8+shzGdzbgkvmv2Yb0+QeEGAsMZHk73MJYr7SEjmMl1KjMJma/J0PsFS8PoXRIYoThm43t5vWJBPErgd4h1gfq6jE5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Wa6jmLKm; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-4394b2c19ccso5659255e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 03:04:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739444692; x=1740049492; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=m2sxvAYKNr0+htAaMCuMZG0BVvvnjrhzSWzEt2rFCZM=;
        b=Wa6jmLKm9aMrO3rEu72QUgUbIYWOHlJzVY0ND1bFkkiD06lGvxSOWD7uKhsJhjYCKL
         QgB3SlBpm0O3PlZa/jldUvZT9LdKFP9cPVdC8jAOUIWnhx5GNirfs2qO8mcBtLBHuq9V
         vRMlgBVOZCg1PcOA6aR1NfDptK4nOtMb4s3fQpzg7O7DnXpWfV5faPpbGOPH0SinLSTq
         qJRZNRhAfNGJq9s+CPuPALmrjW1Sdw0BSuGoXgVWxUXVQhTzN/ekoS9ryRzEm+NXNUdl
         loexXsGFsByW30Cn+ab3G/uuE7qckoam2yxsLVye6/9n7Q9mYJ04IocMzKC8cxDBY22S
         p15w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739444692; x=1740049492;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m2sxvAYKNr0+htAaMCuMZG0BVvvnjrhzSWzEt2rFCZM=;
        b=Vf9uy1uui4uabtgEfQ28iXKeWSDtUijYHfFeUZECpJBFGixY+cDKdmBt5+ChMVJzZz
         TKn3jNc/QDui7T7s6HauvkLFQICMleGcslhBIg3AaESqByoupW+mwH58Nv4vE2tbYAtE
         QJnd9bi+y63gKBrhrZQf44nCvdPzPK3rh4g1zeZluq3Q7mIwhCfkWsGmRrpFwQWuOOu4
         F+MdFzsQeWJeg9of6oGKdq5jpOFQTiubfsz7MQJ/weAHsVxZvjgd6hTL+nk8yr2Rc8Py
         ry2F1kexlcypVIOT5/DAT+T/++Qj9iM/CDpiNrzY1hsNAtAqglmx9sxjjSnTyxiS1v6m
         7W2Q==
X-Forwarded-Encrypted: i=1; AJvYcCW4buRYZPTxscEbGhNwXE0U+vkdlPo8rC8z2ceuqZDRxAQi2PAlxgVHxl/z1eNG+3eiIDmd+TGasJz0uRA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlyxQjq/ql3gAT44RWYKR0SwyfnT9fivjWOml0JFd0hjh4rxCF
	+2vdxWRXs355WSTVrYC08KXvJ0nWBLjuMkzFmUAXOvbVC3IFBe/MJtqbvAXaFEpijDALYp5Ei7r
	xQxhGtPK67zfEaA==
X-Google-Smtp-Source: AGHT+IEB3aP700Hf+T0Y9hXFswWx+oBLY+WAVsjCa34dg3231EVe8adDYbhQ2hlUMA3P7Xrq6PWzNabIh7UH2D4=
X-Received: from wmgg21.prod.google.com ([2002:a05:600d:15:b0:439:3c3e:f0e8])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3f12:b0:439:45ce:15da with SMTP id 5b1f17b1804b1-439601c10a2mr29099955e9.25.1739444692374;
 Thu, 13 Feb 2025 03:04:52 -0800 (PST)
Date: Thu, 13 Feb 2025 11:04:06 +0000
In-Reply-To: <20250213-vma-v14-0-b29c47ab21f5@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250213-vma-v14-0-b29c47ab21f5@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=3859; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=2M89B3p91FPP25Gw8Y6SiWDXagycK/dpbfENE1t2aLQ=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBnrdHBNVpj/HCfF1bMPs0sT3j/Jo2hPFWd70C3l
 iOXvQTr0YyJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZ63RwQAKCRAEWL7uWMY5
 RtHcEACcBTXyAj1CXLqb0ECe7oLoK6K8Pl+NeXmHTuMk/Ev7mlbfXpB1nTJjbWRsYCabctv6mkD
 G9xvp3vC3cneN8bB44qp9x+ebNayRdV32qqfyi8cfv/2t5alAL3cKGTErJW6gEeIGyTAi7Mmyem
 stGNNElApGyVgVocm3n6dDGebZ5GQgXMWmtUzojC+mhcF7jIE00ry3mrPAxCQA/Q4SgFWZE2Uhy
 HasbIcqybKe2sgVO1R2tJ2sA2ba6ybalTf2ORz3h4PheSouXcsG51HIepwvqn/mhb9nyocthl88
 bZIptuUR1O79gMUyLSpctcApRDnt8YbFqX/DCLY3mVxCq55sbcHRT3caJ+bCIsGG0a/vsONgeaX
 /jdSt0JbUYbE9+PpBd7IHqjgZxw9z6HRZITmoLhIUaQa00mEbtASKRL0pCOLFK093wxdw2Gy5BO
 V8rsvOruaOrT6AIdS4sDOtMyRXbp6TjKq6EioB92dhZnRPmb1a0Xwv6Td7GifsTVOa6msSoYugx
 DF/+4YZOrTawLkkY/1b4vb/8cgLTehGuS4ASNFFHBbOPFjhWh1PRCvnapev05NtEZ1A+JYbrBSj
 QDyex48V5rO7SbbnmgPgMbO5gTtVde02PpFkw2+qxRX88cQiVaOaFOODzsaMmVS/zYWyz+FXlaz MAB1NXQrXMto4PQ==
X-Mailer: b4 0.13.0
Message-ID: <20250213-vma-v14-7-b29c47ab21f5@google.com>
Subject: [PATCH v14 7/8] rust: miscdevice: add mmap support
From: Alice Ryhl <aliceryhl@google.com>
To: Miguel Ojeda <ojeda@kernel.org>, Matthew Wilcox <willy@infradead.org>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	John Hubbard <jhubbard@nvidia.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>, Suren Baghdasaryan <surenb@google.com>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, rust-for-linux@vger.kernel.org, 
	Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="utf-8"

Add the ability to write a file_operations->mmap hook in Rust when using
the miscdevice abstraction. The `vma` argument to the `mmap` hook uses
the `VmaNew` type from the previous commit; this type provides the
correct set of operations for a file_operations->mmap hook.

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Acked-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/kernel/miscdevice.rs | 44 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/rust/kernel/miscdevice.rs b/rust/kernel/miscdevice.rs
index e14433b2ab9d..e4a2c5996832 100644
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
2.48.1.502.g6dc24dfdaf-goog


