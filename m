Return-Path: <linux-kernel+bounces-414211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B6EC9D24BF
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 12:25:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E43C5B23F95
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 11:25:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15CBB1C4A08;
	Tue, 19 Nov 2024 11:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BATn507I"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75D0A1C761C;
	Tue, 19 Nov 2024 11:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732015486; cv=none; b=uYm+ZJ3JZh3OTcPs855KJS4gjNw/BcprA1nh1PiDmDmEEgG9uIyxbzkUhtOeDopyEx7AvGjIH8pAMJu5CBSa4DNIdEtjYVai4zYMovrK1ggbyiGLnDEpZuEbHH6qzrYq+wl84NreNfnpf9MF/PV7SKK92UE4wC0hMCuMosN+8u0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732015486; c=relaxed/simple;
	bh=hCtDuutp78iLtmROwjXb1QaB1d1QC/MDZD6AHGd5tjQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=clTlSvJMDxk0ermtmiAnQC5jF6Ih6rZRDRQMyTrRPpn8rX+RgoC0VB4gWnT5Um8rF0kAtyISHn2tHMDof1yQlgUdmodHfHBeGISMd9hyKGJcaMxI35ibAVpzfy7cW2TwhFmhkIm627GCREROsQ5BmOYNkDiL84VbhGlec86wgr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BATn507I; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-53da3b911b9so4752007e87.2;
        Tue, 19 Nov 2024 03:24:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732015483; x=1732620283; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YSlE2AobDBjXj75h9dVNPb0c+CAMh4Q+j+w/qWySOZo=;
        b=BATn507IVRRvKM4vh6SpG9weus2GCaTzmSnX0KyhL51vcrEhQ154QiILBsYeywmJTH
         KwmPCNZxtnwW/4kIXMBy78NAFlh2hsUwaB30cKTPY4ECIDr3x4IACnwjA9BQbwzTmVXK
         CcPDSAY+Gh/YEHeVnK6Z/hPvxTTVDgQSWLW9LvgFMnqXOt9Fdt+Ctk77umjxgqe22P5E
         CYG22Ekuxh9oW/63ZGlyciSG7WNkEzw7ZmZbG1ss47UJDBJuGdZ4ocsD6MxRwVMhQJWP
         v4nWo4lPl0xxJiUq93J1pIsh/Kc4XUH474g+RfwrY2/kpss1WjJz7cgVm2RRBZGsqCat
         yK8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732015483; x=1732620283;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YSlE2AobDBjXj75h9dVNPb0c+CAMh4Q+j+w/qWySOZo=;
        b=l+MmDjvZ2jS3uWCfVEGX6OUtqsRNU/iWBuZyIvQ6Ect04B328R2AMRbb6NbZpTg3Yd
         0wCxrLUOYb0AJCQD1CJ9e+Apjm9P9jt20QZxZ0hYvZ6cQprvW0500eKV7VPGBKMvJCus
         3qDvITSj5Gmh3T31AUtd8n+dlnWtnApZneqoxXh6FzqSZyRVXKfd4CkIrr7NGArh5K0f
         FU42Ulo1Hd+b87a6Yhf4jc7YyhldRsK00ZuuleIHWZHhcwakFrN1Z31ZpuNJ+EW8yOKY
         00T3EZZWCdiaFHGQoFox0MlQi5g/HHGfultwmq/7xJcoWBHdueeKucIDiQeMQ6jL/xlm
         bVGg==
X-Forwarded-Encrypted: i=1; AJvYcCWOqvqVlm4H66qpiJoQn0nl9ZKzr2/buKwSEdt8tS5148JQtga5htoHvYIDd+t52khp3XXmi0+ROBRiAAo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMvskRlZCAS6O++arjjnvtAzFQCKXB4kso5ovVwVhYiJEHr6NZ
	uikhhMWyaCYpdUDCFJts4Q8Mp1mrNoJgJemeupensfeGbSG/xXH21QbEJw==
X-Google-Smtp-Source: AGHT+IHClMNtG+d6fxlDY8MwP736UMKm9XCqQoUw9TgnQS0hL5N5cc0pjQHQFoHV43cUof90JEBn9w==
X-Received: by 2002:a05:6512:3b86:b0:53d:a24b:db0f with SMTP id 2adb3069b0e04-53dab3c50b3mr6607291e87.57.1732015482420;
        Tue, 19 Nov 2024 03:24:42 -0800 (PST)
Received: from abj-NUC9VXQNX.. (87-94-132-183.rev.dnainternet.fi. [87.94.132.183])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53dbd478279sm271899e87.232.2024.11.19.03.24.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2024 03:24:41 -0800 (PST)
From: Abdiel Janulgue <abdiel.janulgue@gmail.com>
To: rust-for-linux@vger.kernel.org
Cc: Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Valentin Obst <kernel@valentinobst.de>,
	linux-kernel@vger.kernel.org (open list),
	Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org (open list:MEMORY MANAGEMENT),
	airlied@redhat.com,
	Abdiel Janulgue <abdiel.janulgue@gmail.com>
Subject: [PATCH v3 2/2] rust: page: Extend support to existing struct page mappings
Date: Tue, 19 Nov 2024 13:24:03 +0200
Message-ID: <20241119112408.779243-3-abdiel.janulgue@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241119112408.779243-1-abdiel.janulgue@gmail.com>
References: <20241119112408.779243-1-abdiel.janulgue@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extend Page to support pages that are not allocated by the constructor,
for example, those returned by vmalloc_to_page() or virt_to_page().
Since we don't own those pages we shouldn't Drop them either. Hence we
take advantage of the switch to Opaque so we can cast to a Page pointer
from a struct page pointer and be able to retrieve the reference on an
existing struct page mapping. In this case no destructor will be called
since we are not instantiating a new Page instance.

The new page_slice_to_page wrapper ensures that it explicity accepts
only page-sized chunks.

Signed-off-by: Abdiel Janulgue <abdiel.janulgue@gmail.com>
---
 rust/helpers/page.c | 10 +++++
 rust/kernel/page.rs | 97 ++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 106 insertions(+), 1 deletion(-)

diff --git a/rust/helpers/page.c b/rust/helpers/page.c
index 48d4481c1e33..784563924b83 100644
--- a/rust/helpers/page.c
+++ b/rust/helpers/page.c
@@ -27,3 +27,13 @@ void rust_helper_get_page(struct page *page)
 {
 	get_page(page);
 }
+
+struct page *rust_helper_virt_to_page(const void *kaddr)
+{
+	return virt_to_page(kaddr);
+}
+
+bool rust_helper_virt_addr_valid(const void *kaddr)
+{
+	return virt_addr_valid(kaddr);
+}
diff --git a/rust/kernel/page.rs b/rust/kernel/page.rs
index fdf7ee203597..d0a896f53afb 100644
--- a/rust/kernel/page.rs
+++ b/rust/kernel/page.rs
@@ -3,7 +3,7 @@
 //! Kernel page allocation and management.
 
 use crate::{
-    alloc::{AllocError, Flags},
+    alloc::{AllocError, Allocator, Flags, VVec, KVec, KVVec, Vec, flags::*},
     bindings,
     error::code::*,
     error::Result,
@@ -87,6 +87,49 @@ pub fn alloc_page(flags: Flags) -> Result<ARef<Self>, AllocError> {
         Ok(unsafe { ARef::from_raw(NonNull::new_unchecked(ptr)) })
     }
 
+    /// Create a page object from a buffer which is associated with an existing C `struct page`.
+    ///
+    /// This function ensures it takes a page-sized buffer as represented by `PageSlice`.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// use kernel::page::*;
+    ///
+    /// let somedata: [u8; PAGE_SIZE * 2] = [0; PAGE_SIZE * 2];
+    /// let buf: &[u8] = &somedata;
+    /// let pages: VVec<PageSlice> = buf.try_into()?;
+    /// let page = Page::page_slice_to_page(&pages[0])?;
+    /// # Ok::<(), Error>(())
+    /// ```
+    pub fn page_slice_to_page<'a>(page: &PageSlice) -> Result<&'a Self>
+    {
+        let ptr: *const core::ffi::c_void = page.0.as_ptr() as _;
+        if ptr.is_null() {
+            return Err(EINVAL)
+        }
+        // SAFETY: We've checked that `ptr` is non-null, hence it's safe to call this method.
+        let page = if unsafe { bindings::is_vmalloc_addr(ptr) } {
+            // SAFETY: We've checked that `ptr` is non-null and within the vmalloc range, hence
+            // it's safe to call this method.
+            unsafe { bindings::vmalloc_to_page(ptr) }
+        // SAFETY: We've checked that `ptr` is non-null, hence it's safe to call this method.
+        } else if unsafe { bindings::virt_addr_valid(ptr) } {
+            // SAFETY: We've checked that `ptr` is non-null and a valid virtual address, hence
+            // it's safe to call this method.
+            unsafe { bindings::virt_to_page(ptr) }
+        } else {
+            ptr::null_mut()
+        };
+        if page.is_null() {
+            return Err(EINVAL);
+        }
+        // CAST: `Self` is a `repr(transparent)` wrapper around `bindings::page`.
+        // SAFETY: We just successfully retrieved an existing `bindings::page`, therefore
+        // dereferencing the page pointer is valid.
+        Ok(unsafe { &*page.cast() })
+    }
+
     /// Returns a raw pointer to the page.
     pub fn as_ptr(&self) -> *mut bindings::page {
         self.page.get()
@@ -270,3 +313,55 @@ unsafe fn dec_ref(obj: ptr::NonNull<Self>) {
         unsafe { bindings::put_page(obj.cast().as_ptr()) }
     }
 }
+
+/// A page-aligned, page-sized object.
+///
+/// This is used for convenience to convert a large buffer into an array of page-sized chunks
+/// allocated with the kernel's allocators which can then be used in the
+/// `Page::page_slice_to_page` wrapper.
+///
+// FIXME: This should be `PAGE_SIZE`, but the compiler rejects everything except a literal
+// integer argument for the `repr(align)` attribute.
+#[repr(align(4096))]
+pub struct PageSlice([u8; PAGE_SIZE]);
+
+fn to_vec_with_allocator<A: Allocator>(val: &[u8]) -> Result<Vec<PageSlice, A>, AllocError> {
+    let mut k = Vec::<PageSlice, A>::new();
+    let pages = page_align(val.len()) >> PAGE_SHIFT;
+    match k.reserve(pages, GFP_KERNEL) {
+        Ok(()) => {
+            // SAFETY: from above, the length should be equal to the vector's capacity
+            unsafe { k.set_len(pages); }
+            // SAFETY: src buffer sized val.len() does not overlap with dst buffer since
+            // the dst buffer's size is val.len() padded up to a multiple of PAGE_SIZE.
+            unsafe { ptr::copy_nonoverlapping(val.as_ptr(), k.as_mut_ptr() as *mut u8,
+                                              val.len()) };
+            Ok(k)
+        },
+        Err(_) => Err(AllocError),
+    }
+}
+
+impl TryFrom<&[u8]> for VVec<PageSlice> {
+    type Error = AllocError;
+
+    fn try_from(val: &[u8]) -> Result<Self, AllocError> {
+        to_vec_with_allocator(val)
+    }
+}
+
+impl TryFrom<&[u8]> for KVec<PageSlice> {
+    type Error = AllocError;
+
+    fn try_from(val: &[u8]) -> Result<Self, AllocError> {
+        to_vec_with_allocator(val)
+    }
+}
+
+impl TryFrom<&[u8]> for KVVec<PageSlice> {
+    type Error = AllocError;
+
+    fn try_from(val: &[u8]) -> Result<Self, AllocError> {
+        to_vec_with_allocator(val)
+    }
+}
-- 
2.43.0


