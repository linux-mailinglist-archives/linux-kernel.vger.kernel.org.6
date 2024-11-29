Return-Path: <linux-kernel+bounces-425794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 724A79DEB10
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 17:33:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31DEB282EE9
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 16:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A90281A08A8;
	Fri, 29 Nov 2024 16:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JWGnJR/2"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC7319F117
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 16:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732897981; cv=none; b=k8h15Ps1nF29oBDQJujag+HjR+UKbS+5I88IoQBR45siTWtB+f62tGgqWL4RFsP7HDVMWGFazr83dfdC7CqG0rjcF+gI+wNUamspK5Ij9nJlzl79lLo8eflEDVfbfert8hf15YZetjkhZVLJBH/hR9vKluRRdycNLCIFEgUfk1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732897981; c=relaxed/simple;
	bh=d5PVsjv5Dk2wDmJvfAYSWwtPELYfnKxOPm05AGfN2t4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LB3ECB2Iv8wbhQRwtnUfLj8ObMJszl8N/4sC2rIjspRNZy4YFg/bzuBqOeU20DFXM9hYDsuKev4fLJJr9soAVbq6V5UkI1vv0hjRNqq46R5s1D7KZMruM1/2g7eXfqIhIbTgZx/ihXHPPec3OoOjbIJbQ2m0RW0iwyvy1aP7BIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JWGnJR/2; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-434a27c9044so12060065e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 08:32:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732897978; x=1733502778; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=94NYmr5c9ppvPDgAeOeEOikiVfAFQj6mOJl+8qXFwoY=;
        b=JWGnJR/2P7cmk0YSYHSXWZzFlGct2/eQ05YrtauHoEkTWV7HmhoOLr8PlyptV+jMBO
         /ykDowJmSlFVaDZl5F8ua0Dcqxx3VYGMArsoLP2efnEjLhb4h9/gXLDuHeGcDk0H99RW
         XUG+acVpx/XfA3gLyZ8klvCIdZrf+eDuSrhuGJ03IRLO2Dq8/UMxIPvVGE34VxQ069ty
         qNEmgn+W80hD0+r/1z5cEgPgcQuKXkuCTA5uxbf5cAYsOO07Eh+ZLpSm2civNckDnTc1
         uxPrC9HNFEdjwLor2AGKheKdXKQjppaOGMuN2Hq/lx2Kv16IgUexzfrMo0gTfmUnoubg
         61FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732897978; x=1733502778;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=94NYmr5c9ppvPDgAeOeEOikiVfAFQj6mOJl+8qXFwoY=;
        b=PoW0jsuZcPk1u4ZH18sDmMhERP/s+eH9QdO9BvQKHkqZnpVJYsQRZGaKOC6BtaMWod
         /2HvGmndaXKsQwXssq1Pi2CqAErzDU7r6J16KCXYGBng+F+w3NmSVuLqPU/qP+00PtJg
         6crRJh85wyqh2Ak7YtG+zjI4WnmzYHWjzXge5JqaQySd9tgb9LnSEeJluugvil8AENWd
         UjjxRsabRLWN61LtkWjsIgVwgswJQ6ceJOebmuxS1c9Fb6DZoFiIt0eDPCRqc8tgI9fx
         LjJlP6GAUsUFkZ9V/LWu7uKS3BSgzFq01nMbkpfZaWRksLniwGDA3RqEQKGrGrinobeF
         Q+IA==
X-Forwarded-Encrypted: i=1; AJvYcCXhi9jLbLBiD8us0g/UToCLvhn8lYc31TxbpD49QiWCBCcu0pJ7bEbV2XOsN6CRlkJwn773vrzPbmBC+n8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbUhOhrlgnlKPess78MFsa0h/9ASEgqOk1EyW1n5Ms9NAb/MFL
	B5YIdvSotE4QHfO/IL9sGXStxhKYME3qNvdQEQph8hfuChV0L+vyxBmvxJy22ZCXWr5tIEAZBFA
	dHUe4oBGAagNo/A==
X-Google-Smtp-Source: AGHT+IGrQvjMp3red6jWsR1GGii7AoihEDmHs9z4agdmTgk8GW6+jX/m+iq6oJEN70Cr+c0nxG1Xp0i1oBsbhdE=
X-Received: from wmpq23.prod.google.com ([2002:a05:600c:3317:b0:42c:b336:8685])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4750:b0:431:5871:6c5d with SMTP id 5b1f17b1804b1-434a9dbbd1amr138602905e9.3.1732897978665;
 Fri, 29 Nov 2024 08:32:58 -0800 (PST)
Date: Fri, 29 Nov 2024 16:32:36 +0000
In-Reply-To: <20241129-vma-v10-0-4dfff05ba927@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241129-vma-v10-0-4dfff05ba927@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=3694; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=d5PVsjv5Dk2wDmJvfAYSWwtPELYfnKxOPm05AGfN2t4=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBnSeyuYNpPwhGV89bUWs5GRH8aX7HH6P4Ztr1U0
 bGuq73pEJ2JAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZ0nsrgAKCRAEWL7uWMY5
 RqU2EACmE2VsGq4kuy2dH1HczWotSUGlrvZA17ocbWpWcLJh0JQ6N+LZjV0Xu6m6TTovT5IofyS
 XcN7yaQjwdI9oGmRkOFB1oRLjjAxEUwr46P/sjxC1UgiuiQaJv0auLW8LP5QiGKA+UaNqGQCcdO
 eGQMKqM4TikGluAykvFlxukfGrYNYTU6sQOVfaZLY2t+/SVMUva/uwFPQh1gpv9vTB9D/Sgi5Wo
 UCvQFh3JwkBvVaijNJoF6ONbRTdCbLiMDc9dVRNzZfDRw0uR4fQDzMEkSRkJ3v5+fScreYBljBK
 k0B1DXlJBNp212kQGxXIA0aC32E2UwuKNb9dHMPpBko8yZwn7Rrf3sbMU1fcfiXhneXaFOUprO9
 H1v5/MRfiqsXXQpFiPQP1+SRjuHSlQ1wJnCOKaViw++5mXvDilf2gbMZO8HhXVGSB55HaS0a3U/
 NjQPkNTFXTBDV8r76dThH5WrcX+Es5A2yJ9gVfTy+Busr0pH9IgPXxO6lorkt4eOoKXvgD1pto7
 kfaSTKS+sHsPqpcgAJeI8RikZWbszcU+qzT2Z0y1akLeFVehqY5O7oMjESLS16mMpy4ui+8Dkc5
 wDnJuzljFqHjFo7j68LGNQ7CVPHglJvW6OslNF4+CePBEE/j1kEWVjZl4+WoxVFvU+zMzj8t4cw YUSBsw9j8CvU+QQ==
X-Mailer: b4 0.13.0
Message-ID: <20241129-vma-v10-3-4dfff05ba927@google.com>
Subject: [PATCH v10 3/8] mm: rust: add vm_insert_page
From: Alice Ryhl <aliceryhl@google.com>
To: Miguel Ojeda <ojeda@kernel.org>, Matthew Wilcox <willy@infradead.org>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	John Hubbard <jhubbard@nvidia.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Arnd Bergmann <arnd@arndb.de>, Christian Brauner <brauner@kernel.org>, Jann Horn <jannh@google.com>, 
	Suren Baghdasaryan <surenb@google.com>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, rust-for-linux@vger.kernel.org, 
	Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="utf-8"

The vm_insert_page method is only usable on vmas with the VM_MIXEDMAP
flag, so we introduce a new type to keep track of such vmas.

The approach used in this patch assumes that we will not need to encode
many flag combinations in the type. I don't think we need to encode more
than VM_MIXEDMAP and VM_PFNMAP as things are now. However, if that
becomes necessary, using generic parameters in a single type would scale
better as the number of flags increases.

Acked-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com> (for mm bits)
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/kernel/mm/virt.rs | 70 +++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 69 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/mm/virt.rs b/rust/kernel/mm/virt.rs
index 032eea4d4690..fa1fd6aa703c 100644
--- a/rust/kernel/mm/virt.rs
+++ b/rust/kernel/mm/virt.rs
@@ -4,7 +4,14 @@
 
 //! Virtual memory.
 
-use crate::{bindings, types::Opaque};
+use crate::{
+    bindings,
+    error::{to_result, Result},
+    page::Page,
+    types::Opaque,
+};
+
+use core::ops::Deref;
 
 /// A wrapper for the kernel's `struct vm_area_struct` with read access.
 ///
@@ -91,6 +98,67 @@ pub fn zap_page_range_single(&self, address: usize, size: usize) {
             )
         };
     }
+
+    /// Check whether the `VM_MIXEDMAP` flag is set.
+    ///
+    /// This can be used to access methods that require `VM_MIXEDMAP` to be set.
+    #[inline]
+    pub fn as_mixedmap_vma(&self) -> Option<&VmAreaMixedMap> {
+        if self.flags() & flags::MIXEDMAP != 0 {
+            // SAFETY: We just checked that `VM_MIXEDMAP` is set. All other requirements are
+            // satisfied by the type invariants of `VmAreaRef`.
+            Some(unsafe { VmAreaMixedMap::from_raw(self.as_ptr()) })
+        } else {
+            None
+        }
+    }
+}
+
+/// A wrapper for the kernel's `struct vm_area_struct` with read access and `VM_MIXEDMAP` set.
+///
+/// It represents an area of virtual memory.
+///
+/// # Invariants
+///
+/// The caller must hold the mmap read lock or the vma read lock. The `VM_MIXEDMAP` flag must be
+/// set.
+#[repr(transparent)]
+pub struct VmAreaMixedMap {
+    vma: VmAreaRef,
+}
+
+// Make all `VmAreaRef` methods available on `VmAreaMixedMap`.
+impl Deref for VmAreaMixedMap {
+    type Target = VmAreaRef;
+
+    #[inline]
+    fn deref(&self) -> &VmAreaRef {
+        &self.vma
+    }
+}
+
+impl VmAreaMixedMap {
+    /// Access a virtual memory area given a raw pointer.
+    ///
+    /// # Safety
+    ///
+    /// Callers must ensure that `vma` is valid for the duration of 'a, and that the mmap read lock
+    /// (or stronger) is held for at least the duration of 'a. The `VM_MIXEDMAP` flag must be set.
+    #[inline]
+    pub unsafe fn from_raw<'a>(vma: *const bindings::vm_area_struct) -> &'a Self {
+        // SAFETY: The caller ensures that the invariants are satisfied for the duration of 'a.
+        unsafe { &*vma.cast() }
+    }
+
+    /// Maps a single page at the given address within the virtual memory area.
+    ///
+    /// This operation does not take ownership of the page.
+    #[inline]
+    pub fn vm_insert_page(&self, address: usize, page: &Page) -> Result {
+        // SAFETY: The caller has read access and has verified that `VM_MIXEDMAP` is set. The page
+        // is order 0. The address is checked on the C side so it can take any value.
+        to_result(unsafe { bindings::vm_insert_page(self.as_ptr(), address as _, page.as_ptr()) })
+    }
 }
 
 /// The integer type used for vma flags.

-- 
2.47.0.338.g60cca15819-goog


