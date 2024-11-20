Return-Path: <linux-kernel+bounces-415961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29CDE9D3F13
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 16:31:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 38371B221E1
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 15:07:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 282E91D79BE;
	Wed, 20 Nov 2024 14:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OHXeT6TJ"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A90041D6DA5
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 14:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732114586; cv=none; b=Jpd1tsaiZHhruftoCL2QWg7TCJQ23Bb/gMj56zLWy5616SfuU4kLWr33qAs3rITFAHH51X8NRrFyUHujX7fCl1cLO10iiUVwndZ6z9GwH/lrfUdG7KaUQ7DaVHX6kg8mBcswQZBBXw6VZD8373ieXJZnTewuMXy6daj4zA4sARI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732114586; c=relaxed/simple;
	bh=gZT3Euh+ZEaMLQWKLqbms6nTrYufOG/3Vrmil72vUnw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UB7+aGTJBgppN7epPiYAwwzcZwlX/51kzM1Bxb4de2lVJ/mHxSwdc+jVO9jL6r283pCn/H+RNVr1IgcZQXzZe0Uk4DwPXHqZ8adIxc2ECwsEooH3oQ9qa7zWWacbvdY0E1Eaq6f1m/655HRcEDlkNHSCwo5KThbBZm0gxfuju9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OHXeT6TJ; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-4316e350d6aso32255325e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 06:56:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732114583; x=1732719383; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/SZjxNKVJkWvdCYwLH30w19SxbpLmf+zpgo7doX1isE=;
        b=OHXeT6TJSiqKNEk320URvAjq7vlSh8fHmUeljlLpecMvEyKiW+HD6cOotxgm3x9pHY
         aXxLc0K+cZjFksykgDZmeb4RuHXKsnAvrVHQGNSgeTmwyTDugldCWL2o2OhzO9sPtaaX
         Gfgt1bZmToyBkNadIdGrSQgoOL2Zbq8kIYFaHIv+ExmoVN5cnr7QhH6QkX5e3QTJKGv3
         mTYCZfFS/y3u1ECh3w0tviHNQbC1l85cuynumPP58qzYfnPcs8wM7IKaCnXIfEUF0VZe
         a3otFNpO3GalxHfQcLl07sWR9fjRcXUutBbE5/a4cjvd5j0N9JBcFBbaCQANxy5qlJF1
         4SPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732114583; x=1732719383;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/SZjxNKVJkWvdCYwLH30w19SxbpLmf+zpgo7doX1isE=;
        b=JmGrvK+9RoseykOeIYuOQFhmZI7wCcrRsLa+5qp2YrODmb36vHPM9xYYdhNwTk7FEt
         RRwCr6zVri42AEaJi1tcejBGYLTWmTNdv++Xx4olK3CZCTCxZl2/Dxaw3oHv7DZG2xIV
         mZs/8DFAHoMg7lBMv+JQbm1xC1sqRot8H1DL1T3FiSpGWI+lwlrburRRWF1MT+t/hPAe
         3xyfzr5FqliXM7q08MPAWenuHb29LfG3cZs2Hw+pHDZilJA9cfo4kRCm5WA025cLLWVV
         HVlsX5mKO2m7xMAbF0SytlYwShWpGHVULmSvaK3sAzfN9y1lMwFV5a+6kTXm7y+4q+tR
         iwDw==
X-Forwarded-Encrypted: i=1; AJvYcCWo3bvTaxahkcr1zxVb/lN8SYiFOnQaBcIdJoLH27fXVQvhdYPFE/KU29vwPqb5G3H53C95SJpsI0FWhXE=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywgw5CXPNLtvpkEKpszjRw1kcuu2m0NcJNGhfx9gDWfcJI5eOYU
	FthvyVBu5s4ra3nxNOdU5uF1e7n70pOzafzhpH28h2tw9kFgWFLVFzbE4bNfi6WgEWtJaResyTA
	5okDxXLzi4AxDzw==
X-Google-Smtp-Source: AGHT+IGmCoJh8WJ6CU35nHCj5+WORiCwN3sPF8aj+A+iomLA9SMFPrHheiwvgUQFi0TxoH+VHwHP38URGnqozCI=
X-Received: from aliceryhl.c.googlers.com ([fda3:e722:ac3:cc00:68:fe9:ac10:f29e])
 (user=aliceryhl job=sendgmr) by 2002:a05:600c:291:b0:430:576d:fa96 with SMTP
 id 5b1f17b1804b1-4334f030b13mr22415e9.8.1732114582861; Wed, 20 Nov 2024
 06:56:22 -0800 (PST)
Date: Wed, 20 Nov 2024 14:49:57 +0000
In-Reply-To: <20241120-vma-v8-0-eb31425da66b@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241120-vma-v8-0-eb31425da66b@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=3530; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=gZT3Euh+ZEaMLQWKLqbms6nTrYufOG/3Vrmil72vUnw=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBnPfiKOwSyo7JZVYh7YZMMMLf6ReyTAFr9kcbzi
 p/IU6JooYKJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZz34igAKCRAEWL7uWMY5
 Rp/hEACkypxgG72GpLru5x4sBEqUUSeMGsryVWgYsYHX2gV20DtgtGdbhI1rzgBZqgt+qeNUxKa
 +ZqyVHTkBTnPYPLFAr9lPYrudJCUj8BDDafGZb+R3ZEAQm3GgJIj3brJJaWnZ2gcpJ1xte+7JW7
 4wXomI/PzSy8EbV4uymi+uJnrbBW4R5lGKnbhLpm+jKGrT+a8UygKm2/leDm6uWVtXcHSnNJGBo
 hrCEeUQDK4mrPR26HDv9wPPyjMyxEx7c+RdZGUgsqoX+hHs70KkQG4gL1AIaFdKtukvC6rGeo1Y
 X+TDHMayeCyz/XicGqQlwtFFirz/q38j3ujbouHa1D8Tsnsjc/7Tb852JpeYOMseuqAu0GWjUjX
 HtnkNoHi27j51fs7YgQ9epYxBO60wsqoM9Expkj8UmYvqm1t0oySIQQd1MU3MkMue17DuL7Jy9b
 NR3zufrHk5jbpQUFeWV1HfVbUMPFGvVtI3/2gqlKHN7fP7l9s6KJqTMpwVcNE8ygUl4lbHX1o5o
 2RnaPaR0WzuP4QRUTJlMWM2Weu0unpvmONfEAW0DwvB1QbnJjalRjlcylwhi6RhZn1ELTX/9/xr
 qpYh6hRmWsct3nWWD9jBaJqiGAZvEWm1rFG5H9qPHIKjYQPogidLCRRS1NKy/Gu/foPpu3RjHhD uzSBNpYqoDIgXVw==
X-Mailer: b4 0.13.0
Message-ID: <20241120-vma-v8-3-eb31425da66b@google.com>
Subject: [PATCH v8 3/7] mm: rust: add vm_insert_page
From: Alice Ryhl <aliceryhl@google.com>
To: Miguel Ojeda <ojeda@kernel.org>, Matthew Wilcox <willy@infradead.org>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	John Hubbard <jhubbard@nvidia.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Arnd Bergmann <arnd@arndb.de>, Christian Brauner <brauner@kernel.org>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	rust-for-linux@vger.kernel.org, Alice Ryhl <aliceryhl@google.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>
Content-Type: text/plain; charset="utf-8"

The vm_insert_page method is only usable on vmas with the VM_MIXEDMAP
flag, so we introduce a new type to keep track of such vmas.

The approach used in this patch assumes that we will not need to encode
many flag combinations in the type. I don't think we need to encode more
than VM_MIXEDMAP and VM_PFNMAP as things are now. However, if that
becomes necessary, using generic parameters in a single type would scale
better as the number of flags increases.

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/kernel/mm/virt.rs | 68 +++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 67 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/mm/virt.rs b/rust/kernel/mm/virt.rs
index 1e755dca46dd..de7f2338810a 100644
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
@@ -80,6 +87,65 @@ pub fn zap_page_range_single(&self, address: usize, size: usize) {
             )
         };
     }
+
+    /// Check whether the `VM_MIXEDMAP` flag is set.
+    #[inline]
+    pub fn check_mixedmap(&self) -> Option<&VmAreaMixedMap> {
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
2.47.0.371.ga323438b13-goog


