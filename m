Return-Path: <linux-kernel+bounces-544065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1080A4DD04
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 12:52:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44EE43ABAB3
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 11:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F69F202C2F;
	Tue,  4 Mar 2025 11:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t8bFgWac"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE97202977
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 11:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741089108; cv=none; b=Ffp+C6NCe150tC70ciPv2C8jpeW8uClJjy9O+neyya12z7tmRt3766EvXFQFs7M3TvFLcxnYZCvqkggEtODj0CPJqEPw3SeCtbxDu/jL+j27G+dzz2uoUjaxj4y4NqUZyj1h+px9sCRQPt+fe/MPIazBeYhzZl/uM46/7q1G89c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741089108; c=relaxed/simple;
	bh=fcHX/4wtIhBLmwTssDocfCMWr9cgOfwvmfwPjcbUNdc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=oJo591bpTvWrGwkdF1Cou08B7UdP4KxCwohlp9flMmmAzgPaOvSWnSmsGv7t+jeRZvP+dJVMoRE9acnCq4tdWASqQBPVEn8FtTP7h0kgBBHfpruP6pqcJOojL1JHp4CV14WS1+47t8nMLHpsmJzp5B+6KNaJtmbwRkYBnT1Rggc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=t8bFgWac; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-43bcd9a46feso2365505e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 03:51:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741089105; x=1741693905; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8bXoUXmVT8dxGizwxKV/ovMv4cD7PL8uGOjI5BrX468=;
        b=t8bFgWacBQUXgdJAG/7u4mVV1pUX0tSEbuiiSGBd6afxVIeG4HIPDR7NK0li8Aw6og
         0e/D2RAhaOq7kPCfFfpoPn1gFiDbays5R89Km/+lgc4hyZuIUQZoOulm7vVrX5XM0/Sd
         NGyIY5vmMiD5DGSILNl9nOGG0XrS//HWNRsxHaSuoyXpeNFqZzXegLnOlgbHnWUxxS/B
         jxqmKkExQAACIsvmOP0qjYknVPYvPLZMWLmB0dSFnX9koilnWeKdMRLCMkNmLIBQ7iuY
         zM83srGaOHmpeHNY+Chg73BftATtmE9emAPTSZrq191f7M6P3PrJxA1oTqdFd0th/jSB
         RG5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741089105; x=1741693905;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8bXoUXmVT8dxGizwxKV/ovMv4cD7PL8uGOjI5BrX468=;
        b=j3MXPe/V1LbrSXjYWgDMkUkulGCMt37X8H+94YH1s/dfUUFOdlPYVVRsjmFHEzhEsN
         VN1GwlILz80yoR38Q0onUsNvPPaEvB5hudNoc9jpLTgncC+anuzLJ/mkn8OuX5uptnsa
         uqYf4UUgHwaBLqrLTVFd2t5mXpo2VXStDE1/FdnI9dNMgeauEHvki6Z8F/E3DUxbQoo2
         SaiklsFsQbdUw1jCFVfewfL9dYxpCzk3xUFylkuSlVcGlCI17BEf7ysU0HgtwRT6M3lw
         15IN7uIQhcsScNFjimqHxgLgMvwZGYgVdlpZjktMDJpuPR36NSGXZrKt8geMLxsvoksN
         6dUQ==
X-Forwarded-Encrypted: i=1; AJvYcCUJKx6elONmTojgXOg/Oz8mspU2FDeFj/fXOfAKWO9RDIXywktmbJWf/Rqcl2nwmoEDR8leMveQDA+p4Fs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKwHtOwVMya9E4vytumucGyLIAdPfSxDPtuDYjUx2BhJ2+qF1O
	Eo1a4Ac6W9LMnsY9BG4d77VRQxOeobtmnTGecTHlTJf33IBdQAh/BwZOpZk6DL4gDKGZWHGwj1k
	r70vpPbrkV5Hk3g==
X-Google-Smtp-Source: AGHT+IEtgljy5PaQ2bfEAQGJv1s6zOf0IF77l1v38ZmX0KNmJzpW9ZYIhIEy1GbxHihOJdIZbz1Qpz8vNS7Cjhw=
X-Received: from wmdd25.prod.google.com ([2002:a05:600c:a219:b0:43b:c0cf:b8e2])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3513:b0:439:9f42:c137 with SMTP id 5b1f17b1804b1-43ba66e218emr160072865e9.11.1741089105287;
 Tue, 04 Mar 2025 03:51:45 -0800 (PST)
Date: Tue, 04 Mar 2025 11:49:54 +0000
In-Reply-To: <20250304-vma-v15-0-5c641b31980a@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250304-vma-v15-0-5c641b31980a@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=4393; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=fcHX/4wtIhBLmwTssDocfCMWr9cgOfwvmfwPjcbUNdc=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBnxulE35gpHk35cH1NYdSr/OIMNoS3/kPrxsAOt
 5v94b4dxyiJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZ8bpRAAKCRAEWL7uWMY5
 RuktD/9ogqVaTeCoVL3KzY80MQtLBy/Z+3W1tM6BEtXiz3MizrheNzByHgnxnePNvdeY407Tjuj
 mJPzDY51bu1bxF0jiaIcsJ0zHjQNhFS8VAYFnmwuJHRQ+/nPShcZYoMxhohKM+WGdIz/ywMy6ti
 9eAr2gxkCY4G/TPog7tCQDey6pfcauCKu3SWByVgrUZ6GIWHksX0yA2jWEwd3JT5/exOAEi+w52
 gGRHtAJMPSbg0Pw+AVhSOU4KRRh8tGqYVEEIe4DY+Znvi7EMwB8hez7r4Owp1qhk/dDLNcI22zZ
 MjO92KWkicPIQD49vIgtCMjHkZkNsgvB6BT5pxaJdE75AS1Y4nmTItPvv3qzU9U43McA4jc3P7W
 01b9zAn/RiS1Ch5ROmXJQOA+9Xk0H6g+TDJl2mloIZvLaHQ8i5yufKs+jc9uhSQZDpErHyYj9hn
 rQ6vvQMMxRP/7f4d1fVSL7xt4gZoM7D2lifTHjkGiYLKwqfdM9ZEiC7EkleOzqfZtHj5M3SJ41E
 hg6QS/iKr1CF9P5fh8J3AL6cHkZptcYztYpxE1i6ou9uKqFVF/1lg8eyggKvRo5Uj928H5Nd458
 QP2BEuHhm7lis6zO+5fFZDS96yVPGya2yz73PeKzsqfLlbRdm4f7MqfmhZRAnIJtgcFyV1ETUrP Zs84KcLaY/1mHoA==
X-Mailer: b4 0.14.2
Message-ID: <20250304-vma-v15-3-5c641b31980a@google.com>
Subject: [PATCH v15 3/9] mm: rust: add vm_insert_page
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

The vm_insert_page method is only usable on vmas with the VM_MIXEDMAP
flag, so we introduce a new type to keep track of such vmas.

The approach used in this patch assumes that we will not need to encode
many flag combinations in the type. I don't think we need to encode more
than VM_MIXEDMAP and VM_PFNMAP as things are now. However, if that
becomes necessary, using generic parameters in a single type would scale
better as the number of flags increases.

Acked-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Acked-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>
Reviewed-by: Gary Guo <gary@garyguo.net>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/kernel/mm/virt.rs | 79 +++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 78 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/mm/virt.rs b/rust/kernel/mm/virt.rs
index a66be649f0b8d3dfae8ce2d18b70cb2b283fb7fe..3e2eabcc21450497a02ffa1ed1f31f3e7e7e1b6b 100644
--- a/rust/kernel/mm/virt.rs
+++ b/rust/kernel/mm/virt.rs
@@ -14,7 +14,15 @@
 //! ensures that you can't, for example, accidentally call a function that requires holding the
 //! write lock when you only hold the read lock.
 
-use crate::{bindings, mm::MmWithUser, types::Opaque};
+use crate::{
+    bindings,
+    error::{to_result, Result},
+    mm::MmWithUser,
+    page::Page,
+    types::Opaque,
+};
+
+use core::ops::Deref;
 
 /// A wrapper for the kernel's `struct vm_area_struct` with read access.
 ///
@@ -119,6 +127,75 @@ pub fn zap_page_range_single(&self, address: usize, size: usize) {
             bindings::zap_page_range_single(self.as_ptr(), address, size, core::ptr::null_mut())
         };
     }
+
+    /// If the [`VM_MIXEDMAP`] flag is set, returns a [`VmaMixedMap`] to this VMA, otherwise
+    /// returns `None`.
+    ///
+    /// This can be used to access methods that require [`VM_MIXEDMAP`] to be set.
+    ///
+    /// [`VM_MIXEDMAP`]: flags::MIXEDMAP
+    #[inline]
+    pub fn as_mixedmap_vma(&self) -> Option<&VmaMixedMap> {
+        if self.flags() & flags::MIXEDMAP != 0 {
+            // SAFETY: We just checked that `VM_MIXEDMAP` is set. All other requirements are
+            // satisfied by the type invariants of `VmaRef`.
+            Some(unsafe { VmaMixedMap::from_raw(self.as_ptr()) })
+        } else {
+            None
+        }
+    }
+}
+
+/// A wrapper for the kernel's `struct vm_area_struct` with read access and [`VM_MIXEDMAP`] set.
+///
+/// It represents an area of virtual memory.
+///
+/// This struct is identical to [`VmaRef`] except that it must only be used when the
+/// [`VM_MIXEDMAP`] flag is set on the vma.
+///
+/// # Invariants
+///
+/// The caller must hold the mmap read lock or the vma read lock. The `VM_MIXEDMAP` flag must be
+/// set.
+///
+/// [`VM_MIXEDMAP`]: flags::MIXEDMAP
+#[repr(transparent)]
+pub struct VmaMixedMap {
+    vma: VmaRef,
+}
+
+// Make all `VmaRef` methods available on `VmaMixedMap`.
+impl Deref for VmaMixedMap {
+    type Target = VmaRef;
+
+    #[inline]
+    fn deref(&self) -> &VmaRef {
+        &self.vma
+    }
+}
+
+impl VmaMixedMap {
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
+        // SAFETY: By the type invariant of `Self` caller has read access and has verified that
+        // `VM_MIXEDMAP` is set. By invariant on `Page` the page has order 0.
+        to_result(unsafe { bindings::vm_insert_page(self.as_ptr(), address, page.as_ptr()) })
+    }
 }
 
 /// The integer type used for vma flags.

-- 
2.48.1.711.g2feabab25a-goog


