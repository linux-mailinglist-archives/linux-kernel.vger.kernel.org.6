Return-Path: <linux-kernel+bounces-425795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9040D9DEB11
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 17:33:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0D8FB229D1
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 16:33:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAF6D1A0BF8;
	Fri, 29 Nov 2024 16:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wenG2ZNV"
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B84F1A070E
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 16:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732897984; cv=none; b=gl1GQTBbfeA1GAPlduHYltR5bR+7+WOqgQc08HrAWxkxk95k8J+hIJ0vzvXL8Qy0l2ZprtqW2Y6Ucy/qG39rt2sOWkPp7uRGqyNteHbXMgiPYnVf3j+yhp7xWFBHrttOiw04PKaVcs7USasLCuWaB9kP51bhm+sVjdca/VhSSYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732897984; c=relaxed/simple;
	bh=Vj+fM1HEWgk9zeZ3nCQftraSe6z/pjvOnZ1xL1atMIA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=n59IozzAFkFoTOPzJFLu0Vrl2AAFUWcgy8vsr0UA6Eo7CuF/lezP9cGWUSnqeBd6F6MBC7db73XngyzGPgeErp6AHZ7CP5QFktzqIJXy2f9600qh8cLDJnDsb2mI1BTm1X2qMXvQ1wRNGQWI42Lixd/sH00Ik448B9NYtBtiPUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wenG2ZNV; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-385d7611ad3so847436f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 08:33:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732897980; x=1733502780; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=XEZERPJwfgVL12T7CsV2RsjLJQFd2+FhD7A3aSN4nWQ=;
        b=wenG2ZNVg0Umvn6dI7GN1vmcCxnJs5jyB/DMk5/dBqHlO5zp27WwvnWu9n0TjSLB+X
         uPe3VdIzRVtavft/ysPUiWA4IkLKEnd2zbXCECWm545v0tMT4+oSDIeo52FYivq2qi3X
         QtLuv4TwYN5ZLJB/sAjGC1t/sedN8bN+nSmRH7yxaaF4ZxAobBAYjmzNdrnQSKkeRlsS
         1rQOpACmZr+IO7bvFrE+OjuQA0j3dW+5VwzlOIoolmA6hMNXgNLkzJTi36DtOkpIkgGo
         dai/kaEGY3cK2frLV0iQ6c2qIYg6/ZdUdu+8T7izPe9SwOobNhuzYP/XPLpREQDOvHMK
         KDLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732897980; x=1733502780;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XEZERPJwfgVL12T7CsV2RsjLJQFd2+FhD7A3aSN4nWQ=;
        b=ch9cY0XPwLk+54Ypf8XOqStk3A3HVjx1ioLjiE1bYc5+tGBnPj48OFEyhZYaU4J69h
         tdbHPGr14KmZze1ZBKybJYudIpgx8ZlkW6/gnwK2dIXIFEN1uLD2cziXg4NTSLQZ3goP
         GtZ1S69YQC/aR0gWPDVh4Aytw+JULeguBeBt4On8d9bJQmnMDeye02lYc2rQKPDQA2Y/
         p2BXl1Pen2lY8mUW8SrZVjvxy+d/dRp0KRnaJf75AemDFz3XRULkp5NYAA5Y2xD/lQ71
         57wK4ZxxCOEaFCOsbbP7I9qOfhbaumADUp4ch30VMpAfMNScQPyCIZclhpdcdnl7B8bC
         vBPA==
X-Forwarded-Encrypted: i=1; AJvYcCUaxf60P1J+0k057XInO7g+nPVRZJZU6fIYn+Xg/jHHuR447x1LyZLO7iWt8m+VpQOm/KfXZyLUZInr6Uk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeXccsk7bdXMYhmyT+cEHSNcokhK++qHVB3QS08s4Vm/1c6PxB
	UoLC8AOtKZrmUf+OZH76JCd2Gh4YwVMm8XaM/eaXxbyLBdAVW47pE/IuDb4U5wSQ1AAUe6nqvGz
	ogvvZLYjA+SAyNw==
X-Google-Smtp-Source: AGHT+IEtMdEbBKfTi44I0hQxKs9SwxHv8NrQJqJsf3ce8ASa6YkaH62l4mchnBzjtU1EUoOkexS5OiFPJNiqBPU=
X-Received: from wrbeh6.prod.google.com ([2002:a05:6000:4106:b0:382:30eb:98f7])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:491a:b0:385:bc42:52e4 with SMTP id ffacd0b85a97d-385c6eba8bemr11919119f8f.24.1732897980729;
 Fri, 29 Nov 2024 08:33:00 -0800 (PST)
Date: Fri, 29 Nov 2024 16:32:37 +0000
In-Reply-To: <20241129-vma-v10-0-4dfff05ba927@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241129-vma-v10-0-4dfff05ba927@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=3946; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=Vj+fM1HEWgk9zeZ3nCQftraSe6z/pjvOnZ1xL1atMIA=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBnSeyve8NrjNvn5/AdaiW267/FN/DvoteK61Oo4
 9jv/idgWVyJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZ0nsrwAKCRAEWL7uWMY5
 RpxAEACz7Q3Z15K9yn6UUnABmC93QguEXyoGn4fILedLcdfZiuIXMtFqpbgt30kuS+yGQJL41+B
 1GNgFO57jYNMEHUZv87T8ItmFDJ2mKpQ7kteUR7+MXAXcpwOYI80gz695ogwkssoeMvfrllsf8c
 N+HTsQlzoRBWcwek+nZnh0RG5ZSR3KEsKtLBZ49/gqJi5p+7SNJnuvR5k6EJC75DGtQw7vYbmxe
 p+5Hqd2L/mzOLVGo3cBp53uEcawKUUU1NBCBlOI3pPhOssdZb2CETukZ5ZUbOQcACHFLeyOyt1Z
 MI/FAqyGKDlSINeXZsUn1izy/oxYKx+6bH/ldZ4G9/2+ffHrhgx0Z4vKQ2MCqrONvgsRM3t5U/h
 13ldm0DP7VL6NEMeZ1EFquTl9VOWVd48ThVZgEOgK+BMN41A0S4mu2SkL+lOu7hnX+WtI8NWEJS
 DQ+5Nr1CLoaGxIEDMWfAs2ojsL6eW5NXDoVpmX+EG3dX69N95evSpj4kGm+Op6PKwMSTD8vbmtf
 5h4v8zcXVcN5EFehLmSy+UqhnFASNEFy6uSDCZiEN2TZ6cgwWdNkhV+bu7OtvnwUViqGSts+rG2
 44LoVmhzRJZhOZbXtPq+CGaRyvxebiBx35ZsGXGC4nQVfZz4wjyrRIfU3H2pHHhAYuG8JkqrETk HrhIta1iCfIzR/Q==
X-Mailer: b4 0.13.0
Message-ID: <20241129-vma-v10-4-4dfff05ba927@google.com>
Subject: [PATCH v10 4/8] mm: rust: add lock_vma_under_rcu
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

Currently, the binder driver always uses the mmap lock to make changes
to its vma. Because the mmap lock is global to the process, this can
involve significant contention. However, the kernel has a feature called
per-vma locks, which can significantly reduce contention. For example,
you can take a vma lock in parallel with an mmap write lock. This is
important because contention on the mmap lock has been a long-term
recurring challenge for the Binder driver.

This patch introduces support for using `lock_vma_under_rcu` from Rust.
The Rust Binder driver will be able to use this to reduce contention on
the mmap lock.

Acked-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com> (for mm bits)
Reviewed-by: Jann Horn <jannh@google.com>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/helpers/mm.c |  5 +++++
 rust/kernel/mm.rs | 56 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 61 insertions(+)

diff --git a/rust/helpers/mm.c b/rust/helpers/mm.c
index 7b72eb065a3e..81b510c96fd2 100644
--- a/rust/helpers/mm.c
+++ b/rust/helpers/mm.c
@@ -43,3 +43,8 @@ struct vm_area_struct *rust_helper_vma_lookup(struct mm_struct *mm,
 {
 	return vma_lookup(mm, addr);
 }
+
+void rust_helper_vma_end_read(struct vm_area_struct *vma)
+{
+	vma_end_read(vma);
+}
diff --git a/rust/kernel/mm.rs b/rust/kernel/mm.rs
index ace8e7d57afe..425b73a9dfe6 100644
--- a/rust/kernel/mm.rs
+++ b/rust/kernel/mm.rs
@@ -13,6 +13,7 @@
 use core::{ops::Deref, ptr::NonNull};
 
 pub mod virt;
+use virt::VmAreaRef;
 
 /// A wrapper for the kernel's `struct mm_struct`.
 ///
@@ -170,6 +171,32 @@ pub unsafe fn from_raw<'a>(ptr: *const bindings::mm_struct) -> &'a MmWithUser {
         unsafe { &*ptr.cast() }
     }
 
+    /// Attempt to access a vma using the vma read lock.
+    ///
+    /// This is an optimistic trylock operation, so it may fail if there is contention. In that
+    /// case, you should fall back to taking the mmap read lock.
+    ///
+    /// When per-vma locks are disabled, this always returns `None`.
+    #[inline]
+    pub fn lock_vma_under_rcu(&self, vma_addr: usize) -> Option<VmaReadGuard<'_>> {
+        #[cfg(CONFIG_PER_VMA_LOCK)]
+        {
+            // SAFETY: Calling `bindings::lock_vma_under_rcu` is always okay given an mm where
+            // `mm_users` is non-zero.
+            let vma = unsafe { bindings::lock_vma_under_rcu(self.as_raw(), vma_addr as _) };
+            if !vma.is_null() {
+                return Some(VmaReadGuard {
+                    // SAFETY: If `lock_vma_under_rcu` returns a non-null ptr, then it points at a
+                    // valid vma. The vma is stable for as long as the vma read lock is held.
+                    vma: unsafe { VmAreaRef::from_raw(vma) },
+                    _nts: NotThreadSafe,
+                });
+            }
+        }
+
+        None
+    }
+
     /// Lock the mmap read lock.
     #[inline]
     pub fn mmap_read_lock(&self) -> MmapReadGuard<'_> {
@@ -238,3 +265,32 @@ fn drop(&mut self) {
         unsafe { bindings::mmap_read_unlock(self.mm.as_raw()) };
     }
 }
+
+/// A guard for the vma read lock.
+///
+/// # Invariants
+///
+/// This `VmaReadGuard` guard owns the vma read lock.
+pub struct VmaReadGuard<'a> {
+    vma: &'a VmAreaRef,
+    // `vma_end_read` must be called on the same thread as where the lock was taken
+    _nts: NotThreadSafe,
+}
+
+// Make all `VmAreaRef` methods available on `VmaReadGuard`.
+impl Deref for VmaReadGuard<'_> {
+    type Target = VmAreaRef;
+
+    #[inline]
+    fn deref(&self) -> &VmAreaRef {
+        self.vma
+    }
+}
+
+impl Drop for VmaReadGuard<'_> {
+    #[inline]
+    fn drop(&mut self) {
+        // SAFETY: We hold the read lock by the type invariants.
+        unsafe { bindings::vma_end_read(self.vma.as_ptr()) };
+    }
+}

-- 
2.47.0.338.g60cca15819-goog


