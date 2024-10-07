Return-Path: <linux-kernel+bounces-354139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C59899383C
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 22:29:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D6E21C22A28
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 20:29:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06E4F1DED67;
	Mon,  7 Oct 2024 20:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GCkWva8u"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A176E1DE8BD;
	Mon,  7 Oct 2024 20:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728332944; cv=none; b=X/U/tjp6xjLddNsF33Jv7hA6DHtLuAHc8VarP2TAqGvBYhEf4o7WQ84RIt6PxTT8WPeC6A3KJq5rtI9t6IhPGL8ywgzZR9OXPIAUjrBPa5iksQM+cXD66DBP3HS4qHx0BPbN2UUtpXTfcmzsf9Ho1j8NdqTVD1/+17U95RFdk2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728332944; c=relaxed/simple;
	bh=Xa7wl4NsX9MEgEMZaTMVtXEFrE2GZaEBtQ1xLfIvXdk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gozQhcaHJnWfK2zpX5u4Kg+SxAdpMfkMehyXcGqMDAHzhGJpPr3F+xpK5CFf8raE+3YKsWfkXVD1EfGwxBYicIpvmbR99AqpfSiIXW04SkAsaadn/AgHfv5p2J38rtLiTcvASyJhhhqnaW6vaOh3BuLi2fo8+7Gu+wNp8UiLP+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GCkWva8u; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5398e4ae9efso5310039e87.1;
        Mon, 07 Oct 2024 13:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728332941; x=1728937741; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xLBSlqtjkMqVvwxCwoJ2mHaidVZbBBOhd29eZhcK/Dg=;
        b=GCkWva8uNn8GomqRILehjvBdUwcT8GNXOGoy1to2WwiYEwlc+rcqR19QysU/QyAuuK
         w0bA3Qjj64+lbDjatgJ/ijrtRiNPLrXEznSworQws4IcPFiYwvvT5sWfH+UhDTu7imkb
         pqbLIMKdur0lp/mMXfSWWyu8bRVBhxUJ8mMP5rqK3kY+f9wVWny0Cxa/NObZuw1Jm9Eb
         ZsGwD4SjfETrGq7NDZkKgcRgmS5BGZXv2GXRFsFjTVraCEsUT6yKqn7mZRZbREZChFxd
         ptOtZgwdsSgpGO2NildFDV7Xvh1z/S341SA+85ixyfLu/OgOtow6FKC4mxNSjGMrw/T6
         eI1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728332941; x=1728937741;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xLBSlqtjkMqVvwxCwoJ2mHaidVZbBBOhd29eZhcK/Dg=;
        b=P1C5iRr1N/75iEUbEqfB1neBuihtUrVB3nQDoIfKM5IC96soMnIqEagdJUXmGzCUOx
         uKER6qa/P7W0WXdrj/26ojbIdPSLW8sA4rgwEt6fc/azBiWKSUZZt0RojdbwgiVAEkpr
         00QKl+yefKz1Xj5TWVJEtA4tsBHkGYhg+ew2nQb325wRLDerDSArdWHPyf7/U6O8eSgg
         2svL+Jb8xi/xUVYQEqkQpq7cFWWfBMt9DEgAGn3nqfxvwsUPw55tMg0C1j3GhHP/IikG
         y6qROCWqdI7BNLdAhHfMbyd4+Mj1U065GCbbDHbRKn6jhmKFm5poaxv4Y90GGGbaQLvv
         i3UA==
X-Forwarded-Encrypted: i=1; AJvYcCWTRgjltoNixmWQg3bGgQsrGuH90Kn2T7FTNM8KfC2H/r+bv/kPSdvSQ1DoI4QbQ9qv3oK28RmJ5cw2fxI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlTUfbGCqBUVlpCCJo1fKrJGAXlizNcrLgIgqjkTkx+RFcs2bT
	0E+FhSqyVTlx1D987bDmnf5VJCKcBWpBS44FPpzUD+RYzwLwExExEb4djqqv
X-Google-Smtp-Source: AGHT+IEmPNknVfetWBZHpQq/m/4LAIP5u4CBOCK8dpxJcySh/gNHFgbpLd7O/qIqHITdap9kphsu/A==
X-Received: by 2002:a05:6512:124d:b0:539:9ee4:bab3 with SMTP id 2adb3069b0e04-539ab9ed195mr6795281e87.59.1728332940451;
        Mon, 07 Oct 2024 13:29:00 -0700 (PDT)
Received: from abj-NUC9VXQNX.. (87-94-132-183.rev.dnainternet.fi. [87.94.132.183])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-539aff23307sm926237e87.197.2024.10.07.13.28.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 13:28:59 -0700 (PDT)
From: Abdiel Janulgue <abdiel.janulgue@gmail.com>
To: rust-for-linux@vger.kernel.org,
	aliceryhl@google.com
Cc: dakr@redhat.com,
	linux-kernel@vger.kernel.org,
	lyude@redhat.com,
	airlied@redhat.com,
	miguel.ojeda.sandonis@gmail.com,
	boqun.feng@gmail.com
Subject: [PATCH 3/3] rust: page: Add page_slice_to_page
Date: Mon,  7 Oct 2024 23:27:52 +0300
Message-Id: <20241007202752.3096472-4-abdiel.janulgue@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241007202752.3096472-1-abdiel.janulgue@gmail.com>
References: <20241007202752.3096472-1-abdiel.janulgue@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make it convenient to convert buffers into page-sized vmalloc'd chunks which can
then be used in vmalloc_to_page().

Signed-off-by: Abdiel Janulgue <abdiel.janulgue@gmail.com>
---
 rust/kernel/page.rs | 59 ++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 58 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/page.rs b/rust/kernel/page.rs
index a84f382daf5c..490685144694 100644
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
@@ -106,6 +106,27 @@ pub fn vmalloc_to_page<'a>(
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
+    /// let data: [u8; PAGE_SIZE * 2] = [0; PAGE_SIZE * 2];
+    /// let buf: &[u8] = &data;
+    ///
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
@@ -277,6 +298,42 @@ pub unsafe fn copy_from_user_slice_raw(
     }
 }
 
+/// A page-aligned, page-sized object. This is used for convenience to convert a large buffer into
+/// an array of page-sized chunks which can then be used in `Page::page_slice_to_page` wrapper.
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
+            Err(_) => { return Err(AllocError) },
+        };
+        let pages = aligned_len >> PAGE_SHIFT;
+        match k.reserve(pages, GFP_KERNEL) {
+            Ok(_) => {
+                // SAFETY: from above, the length should be equal to the vector's capacity
+                unsafe { k.set_len(pages); }
+                // SAFETY: src buffer sized val.len() does not overlap with dst buffer since
+                // the dst buffer's size is val.len() padded up to a multiple of PAGE_SIZE.
+                unsafe { ptr::copy_nonoverlapping(val.as_ptr(), k.as_mut_ptr() as *mut u8,
+                                                  val.len()) };
+            },
+            Err(_) => { return Err(AllocError) },
+        };
+        Ok(k)
+    }
+}
+
 impl Drop for Page {
     fn drop(&mut self) {
         // SAFETY: By the type invariants, we have ownership of the page and can free it.
-- 
2.34.1


