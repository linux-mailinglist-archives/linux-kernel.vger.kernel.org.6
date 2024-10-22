Return-Path: <linux-kernel+bounces-377084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FE189AB9A4
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 00:50:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87BF01C23B43
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 22:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E19B1CF7D7;
	Tue, 22 Oct 2024 22:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DkB0WrkU"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5B7C1CF28E;
	Tue, 22 Oct 2024 22:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729637360; cv=none; b=UdIhvAAujfDqxWln+K0oKrzPcJGL6lp1u5DZXq0qujtPZPmC2tH/nca5XRqjJytvVx/fLOO4rErmGE8WdvumhrZ59i23xNrXnDsOMeGFtlRjb75I7g0sXvi0zMpR6a0e7JO+W/Jn38qfnWtsvFPwZeBxFKk46cHwxmh9WBv4RUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729637360; c=relaxed/simple;
	bh=Rebdq/Bcdys6nlGdGi9ZhFfMw8VO8Z5FWhgnbMngNkk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GcfGOPBEVyoMoeDMtqyuGTmGaTxPtSZ/ykaTl8bk9F0r5xGLaNOR115RewPQqeWA/xJj4ebjK5rzFZktSOEpFDx9ELIdXvxFzXdPWl3Dx4K3Ra5OBPqOB9s6ShyoO0XuZLjErgSY3CC/ci5ErdgU4rsRxiaUP7froXTQ6wXR+r0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DkB0WrkU; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-539e690479cso6570155e87.3;
        Tue, 22 Oct 2024 15:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729637357; x=1730242157; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ftMwKMj+3AfzocPFKICIi9+9U9CUekGXM3KxUPtjkJM=;
        b=DkB0WrkUo9L986vi9bA1U1QV4flOG20uiKsYJWfwqhK1mSFze9HVUMlVZqbdH0pVp1
         /fwx0ZB29HEcY7ncS9FuaBNphiIcHFbB9078Fld4K1ARKb5vBndiVlIoPYqamUQ2AOp6
         kuhtA8o2C7POfUCD3FriUHSuvWmBFiDePxTRNo5QcpzfaOJePKTyxUKwbx+AElZtdGFh
         AFhwFTIzEtrHiZ0RGn5KSZ86NXLbfCjekOwuNQPdsnBUogkPrwc3ou/anZwKwi23YgSY
         j4SroOOH5qh2i919CqGnt5OwK+Zh59j+r0GfH4wBnugv/LjB3aoMnfddoJePYWXzvHou
         SgrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729637357; x=1730242157;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ftMwKMj+3AfzocPFKICIi9+9U9CUekGXM3KxUPtjkJM=;
        b=Pn2exBU/5XHI7PHtFADTUiIlYAqpEOERlGZu/LdwbHuKAziQ3eXP++THkhm4zBfKwj
         JpzJDGgo8YQc89jXirIul66nioEpYYyInlAYtoF0foYwYNtzRjaS6SKIlp1iG8rLkmtb
         c590tvKY6yaW9Vhh+as99/tocooOHSXDgfEUwIY+qiJyECCxM2tQSSlleimDLLbRKrb7
         z8gn4ej1r9VI+N1QdtdUewZQmYGUDon7mty/44tUcK6gCPZe5A8WpcKQ3mrXiEaetfdA
         ctYNy87+rXq7kVtxl7d/vM+GAj+ZLvgNqD7tJRCLOfeH2mqVE1gbvow7aAl6x3FDLII8
         1ufQ==
X-Forwarded-Encrypted: i=1; AJvYcCXDYxPCejDJ0vVsPb9L0+TOHbiFoFpHYyDiF83aC/jp42lm4rZPx9TfO8H1KZRNDXmkrtVVP1ryabBx24Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yye3QtBPkNBhnEkiC8cP1PHehfAiuITJwfWFI+CvcWZlSMIvK80
	th6MGlc1WfboqXNncKLh/nemMXrU83jznb2hhfvxdBmYpGluBWyY6eP+dg==
X-Google-Smtp-Source: AGHT+IEOveVVafqjig6zTJ5sYMApD3cGHz0tfMasspUykwwPfN+R6wOr9UnCKdmoBylEBQ+GxF7kNg==
X-Received: by 2002:a05:6512:31d1:b0:539:8d2c:c01c with SMTP id 2adb3069b0e04-53b1a36b785mr210527e87.41.1729637356523;
        Tue, 22 Oct 2024 15:49:16 -0700 (PDT)
Received: from abj-NUC9VXQNX.. (87-94-132-183.rev.dnainternet.fi. [87.94.132.183])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53a223e595csm894881e87.14.2024.10.22.15.49.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 15:49:15 -0700 (PDT)
From: Abdiel Janulgue <abdiel.janulgue@gmail.com>
To: rust-for-linux@vger.kernel.org,
	aliceryhl@google.com
Cc: dakr@redhat.com,
	linux-kernel@vger.kernel.org,
	airlied@redhat.com,
	miguel.ojeda.sandonis@gmail.com,
	boqun.feng@gmail.com,
	Abdiel Janulgue <abdiel.janulgue@gmail.com>
Subject: [PATCH v2 4/5] rust: page: Add page_slice_to_page
Date: Wed, 23 Oct 2024 01:44:48 +0300
Message-ID: <20241022224832.1505432-5-abdiel.janulgue@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241022224832.1505432-1-abdiel.janulgue@gmail.com>
References: <20241022224832.1505432-1-abdiel.janulgue@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make it convenient to convert buffers into page-sized vmalloc'd chunks which
can then be used in vmalloc_to_page().

Signed-off-by: Abdiel Janulgue <abdiel.janulgue@gmail.com>
---
 rust/kernel/page.rs | 59 ++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 58 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/page.rs b/rust/kernel/page.rs
index 465928986f4b..2f0507fac9f0 100644
--- a/rust/kernel/page.rs
+++ b/rust/kernel/page.rs
@@ -3,7 +3,7 @@
 //! Kernel page allocation and management.
 
 use crate::{
-    alloc::{AllocError, Flags},
+    alloc::{AllocError, Flags, VVec, flags::*},
     bindings,
     error::code::*,
     error::Result,
@@ -116,6 +116,26 @@ pub fn vmalloc_to_page<'a>(
         Ok(unsafe { &*page.cast() })
     }
 
+    /// A convenience wrapper to vmalloc_to_page which ensures it takes a page-sized buffer
+    /// represented by `PageSlice`.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// use kernel::page::*;
+    ///
+    /// # fn dox() -> Result<(), kernel::alloc::AllocError> {
+    /// let somedata: [u8; PAGE_SIZE * 2] = [0; PAGE_SIZE * 2];
+    /// let buf: &[u8] = &somedata;
+    /// let pages: VVec<PageSlice> = buf.try_into()?;
+    /// let page = Page::page_slice_to_page(&pages[0])?;
+    /// # Ok(()) }
+    /// ```
+    pub fn page_slice_to_page<'a>(page: &PageSlice) -> Result<&'a Self, AllocError>
+    {
+        Self::vmalloc_to_page(page.0.as_ptr() as _)
+    }
+
     /// Returns a raw pointer to the page.
     pub fn as_ptr(&self) -> *mut bindings::page {
         self.page.get()
@@ -287,6 +307,43 @@ pub unsafe fn copy_from_user_slice_raw(
     }
 }
 
+/// A page-aligned, page-sized object. This is used for convenience to convert a large
+/// buffer into an array of page-sized vmalloc'd chunks which can then be used in
+/// `Page::page_slice_to_page` wrapper.
+///
+// FIXME: This should be `PAGE_SIZE`, but the compiler rejects everything except a literal
+// integer argument for the `repr(align)` attribute.
+#[repr(align(4096))]
+pub struct PageSlice([u8; PAGE_SIZE]);
+
+impl TryFrom<&[u8]> for VVec<PageSlice> {
+    type Error = AllocError;
+
+    fn try_from(val: &[u8]) -> Result<Self, AllocError> {
+        let mut k = VVec::new();
+        let aligned_len: usize;
+
+        // Ensure the size is page-aligned.
+        match core::alloc::Layout::from_size_align(val.len(), PAGE_SIZE) {
+            Ok(align) => { aligned_len = align.pad_to_align().size() },
+            Err(_) => return Err(AllocError),
+        };
+        let pages = aligned_len >> PAGE_SHIFT;
+        match k.reserve(pages, GFP_KERNEL) {
+            Ok(()) => {
+                // SAFETY: from above, the length should be equal to the vector's capacity
+                unsafe { k.set_len(pages); }
+                // SAFETY: src buffer sized val.len() does not overlap with dst buffer since
+                // the dst buffer's size is val.len() padded up to a multiple of PAGE_SIZE.
+                unsafe { ptr::copy_nonoverlapping(val.as_ptr(), k.as_mut_ptr() as *mut u8,
+                                                  val.len()) };
+                Ok(k)
+            },
+            Err(_) => Err(AllocError),
+        }
+    }
+}
+
 unsafe impl Ownable for Page {
     unsafe fn ptr_drop(ptr: *mut Self) {
         // SAFETY: By the type invariants, we have ownership of the page and can free it.
-- 
2.43.0


