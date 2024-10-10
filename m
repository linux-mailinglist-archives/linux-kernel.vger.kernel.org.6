Return-Path: <linux-kernel+bounces-359056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7365B9986DE
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 14:58:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 956EA1C2284A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 12:58:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AB441C7B68;
	Thu, 10 Oct 2024 12:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LyIPEPCZ"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16D5B1C9B62
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 12:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728565038; cv=none; b=ZaBD7Sa2gJhlpK1/ia4tbhxMS6q7DByw/Rs619aVlqP31QAfaPln+XrALJOH11kBSgKzurdFhfx5vIDcEGoC3c0HQBuHv56YFslvRaAw/iCH/JZRQI6EQH+nwTgDIXiLIkojWqxYMCT6il4L4258+uKGYMAW/ZJooIAe2Fe0PP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728565038; c=relaxed/simple;
	bh=NyWGuEgAoTCOUDUDd9sQnT8nfx0rvhH11rLVW8whQqU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ihcZDVgvd5HI71ihbfk1DQ7FX4mV+Wrm8nng2PDEPNSDZHxF2iuORVQRn4LiQIGD57GjF/B8amg1k7Q/g3Onqpb/KZbWMvpmO6DTQyfvlyESRjsEe7QbfFeKp85hj1Us3N/1PL2NaR+o8QneDumyqPDCNNiLL1SiZ9TLLuuz5Us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LyIPEPCZ; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e2270a147aso15143937b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 05:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728565035; x=1729169835; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=glV3fv5SFFf1x3gt0c73tA5JY4awjp99N5v6GnmrQXY=;
        b=LyIPEPCZVbJM0qda850rVR357SRpxNCdouwESwtHoRUIldD8RB+JDUr/6+U3Cd6ZuT
         DbSjSfNbLjxetjJc9S5agRYKzMcNe6R43RFTFP8/win/aYo6asCqUbp+OZ76fqufoXc7
         aKMIcHG49PjyofKSStgEzgr6b715OHACFrS9QgAqPFLu1Lmrz++7BcCsAyAbNU3YFWWT
         y89IaBPCdkV3vxlEP8PM3DHexh5nsvjwpd7gTqlQ7CgRFYioZKFC+oQ6QsPc5WZf8mK2
         L5JctfTRbG2xX5ySJsu6sQ1/y7hPR7ijFiNRuDmq6aLD6PyQ2hR3tOv3xpdyBCJ9kGMj
         5Z/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728565035; x=1729169835;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=glV3fv5SFFf1x3gt0c73tA5JY4awjp99N5v6GnmrQXY=;
        b=hzgUhrU3WdVU/qtKSWu4K5CfpYmmBGKkE2ivdSSQqp0lcws9/sSLA9gr3+Cj6dtDyc
         gj+6HOXmDUKaL+OZa3jAkTy0KgrUdfbcEonpARUSsJE2sjfgVK6aKrWh0N0W8X22hAnj
         nU1TJfbVVWq2bDE85BIJFSM5ZGWwXEjwT5F+RVaFn1eSRYk2PRlS8KHkA6EkzcEX5cWB
         lg+C2tpVQPk3U1oDq6FzU0X5P9HvRKHMwow/pgkDPy4jTIsUDkypxnlq2XI4ltJ5kOUI
         9BdC6MWadLfXo114Tu7UMbUP9xKFFpGEo3K0RK0dJXjVq81YpxX2yySe2y0wqDi84/ye
         BMoQ==
X-Forwarded-Encrypted: i=1; AJvYcCWIWWmQwa/kFIfzBBnACl9stXt38p+MQA9leNG70K8UinF1f0f1JevUvLlpjIltR5yN2AFQxdGxFjn5RDU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsA8bzLb71Y9CrV47pg2EdAeJFZ7vVNxlENvKH9669svgBlWZG
	wz3UMPmGIo2sJwob8VWPzq/xuYS1osO5q8OYL58btlO3B6Qxf58OZrbO6Cev9OpvTv0QRRNTgr4
	rC26yfdFYHSlSSg==
X-Google-Smtp-Source: AGHT+IFHaXXnl7DU3u8thuin4117bTfSXLLKlSu8pzsSBybwnadUftHI2kg9Z9q4pkU1hrzfZE6VLP9WSb+EI/o=
X-Received: from aliceryhl.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:35bd])
 (user=aliceryhl job=sendgmr) by 2002:a05:690c:6681:b0:6e2:12e5:356f with SMTP
 id 00721157ae682-6e32215bd01mr1397177b3.3.1728565035062; Thu, 10 Oct 2024
 05:57:15 -0700 (PDT)
Date: Thu, 10 Oct 2024 12:56:36 +0000
In-Reply-To: <20241010-vma-v6-0-d89039b6f573@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241010-vma-v6-0-d89039b6f573@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=2493; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=NyWGuEgAoTCOUDUDd9sQnT8nfx0rvhH11rLVW8whQqU=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBnB88i1QasOE6/sMcz8AIIZHVv4kJthm+7hFroE
 Cs46FuoTkuJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZwfPIgAKCRAEWL7uWMY5
 RjpgD/0e+GOn8RpHZKr1Y0np5kF/2v08wVH5Zf/VaSpmrg3HwgpMPqxJ3feyy05Z6oBtzK1hkNN
 Wv+G/SpeKhnmzLFgNfbMp5kgoYF1NNoQ7A6bZXnv+MNE24RjvXYhZusm8c4ckJ3Me9xMJBUwO9x
 nK5ClqLjOZajAQiZDQbLfQn58RCc164miHTgRRSSxpBIH0BOszm2qqv9hHhL36aXKd4uh6ldb3q
 hfwUwOuhe8rOCOXFi1Vwrxv9haulc4c47qernQjLpV4WDiscoo0el4OYFCLb+pFx+C9W1GDJzbt
 IrvwUBF+Zau7gsoJlGsLKVKh3Y+N+pJ5/JPHe78rcXLObocbLyDRrTQGuM847vPeazglMm3xSk/
 23EVG4PaTO93mWkCYzxceXM7KEpngQg9/sAkTy3UF3w0oCnxoMkgka1kzwpYFqiet6n/oHnv57k
 q4g1hT0XU9JWAKzWmeonS9vSsB9drqmuMFzPGWt4wbnM8qrI9OFjycdKlvAGzUrBMDitkXW8JEN
 Hx3VDAfZUaB02JEPa36P7/O4T22ElByztu3XaiWl7ngKqFooX7NMUgtH6Ke/RtbCyFIYD3k9SY0
 G/CwzbbswhCVel0TVBbBL4/nzBqcH/FASmIzINtNDhTbaikGPAixxwT1b4Jx0NpNWpSKrrHPuGs OFT+MdwYBY7CHQQ==
X-Mailer: b4 0.13.0
Message-ID: <20241010-vma-v6-2-d89039b6f573@google.com>
Subject: [PATCH v6 2/2] rust: miscdevice: add mmap support
From: Alice Ryhl <aliceryhl@google.com>
To: Miguel Ojeda <ojeda@kernel.org>, Matthew Wilcox <willy@infradead.org>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	John Hubbard <jhubbard@nvidia.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Arnd Bergmann <arnd@arndb.de>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	rust-for-linux@vger.kernel.org, Alice Ryhl <aliceryhl@google.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>
Content-Type: text/plain; charset="utf-8"

Using the vma support introduced by the previous commit, introduce mmap
support for miscdevices. The mmap call is given a vma that is undergoing
initial setup, so the VmAreaNew type is used.

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/kernel/miscdevice.rs | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/rust/kernel/miscdevice.rs b/rust/kernel/miscdevice.rs
index cbd5249b5b45..c9428a6154e3 100644
--- a/rust/kernel/miscdevice.rs
+++ b/rust/kernel/miscdevice.rs
@@ -11,6 +11,7 @@
 use crate::{
     bindings,
     error::{to_result, Error, Result, VTABLE_DEFAULT_ERROR},
+    mm::virt::VmAreaNew,
     prelude::*,
     str::CStr,
     types::{ForeignOwnable, Opaque},
@@ -110,6 +111,11 @@ fn release(device: Self::Ptr) {
         drop(device);
     }
 
+    /// Handle for mmap.
+    fn mmap(_device: <Self::Ptr as ForeignOwnable>::Borrowed<'_>, _vma: &VmAreaNew) -> Result {
+        kernel::build_error(VTABLE_DEFAULT_ERROR)
+    }
+
     /// Handler for ioctls.
     ///
     /// The `cmd` argument is usually manipulated using the utilties in [`kernel::ioctl`].
@@ -156,6 +162,7 @@ impl<T: MiscDevice> VtableHelper<T> {
         const VTABLE: bindings::file_operations = bindings::file_operations {
             open: Some(fops_open::<T>),
             release: Some(fops_release::<T>),
+            mmap: maybe_fn(T::HAS_MMAP, fops_mmap::<T>),
             unlocked_ioctl: maybe_fn(T::HAS_IOCTL, fops_ioctl::<T>),
             #[cfg(CONFIG_COMPAT)]
             compat_ioctl: if T::HAS_COMPAT_IOCTL {
@@ -207,6 +214,23 @@ impl<T: MiscDevice> VtableHelper<T> {
     0
 }
 
+unsafe extern "C" fn fops_mmap<T: MiscDevice>(
+    file: *mut bindings::file,
+    vma: *mut bindings::vm_area_struct,
+) -> c_int {
+    // SAFETY: The mmap call of a file can access the private data.
+    let private = unsafe { (*file).private_data };
+    // SAFETY: Mmap calls can borrow the private data of the file.
+    let device = unsafe { <T::Ptr as ForeignOwnable>::borrow(private) };
+    // SAFETY: The caller provides a vma that is undergoing initial VMA setup.
+    let area = unsafe { kernel::mm::virt::VmAreaNew::from_raw(vma) };
+
+    match T::mmap(device, area) {
+        Ok(()) => 0,
+        Err(err) => err.to_errno() as c_int,
+    }
+}
+
 unsafe extern "C" fn fops_ioctl<T: MiscDevice>(
     file: *mut bindings::file,
     cmd: c_uint,

-- 
2.47.0.rc0.187.ge670bccf7e-goog


