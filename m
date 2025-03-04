Return-Path: <linux-kernel+bounces-544066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ACDEA4DD05
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 12:52:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AB5B176F4A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 11:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 866FF202F88;
	Tue,  4 Mar 2025 11:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="niDhhmuT"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D9E202C22
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 11:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741089110; cv=none; b=RqvUE57oLHkwlLETj7nOOLAvpka9FHrvHbwv2Q+pGmF+f5jJiUe8wlOtpgQcrbaTxLJoMFK4iWLX3Hcsl2vR7lXCET4fYXRzn+XvQNBbHVrfzis0p9RmHK398bm6Im+Lm55SxlE786MDZJjQMi6eH74c8cPUAzXrJmXPLtk+It0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741089110; c=relaxed/simple;
	bh=CJ1T+zPNUeGdU4wvXMNNlDKLq0tzZUD5m4mvMkDIXAA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Lxx0Omljuww6jDXjG2ClQCqw+eoBmjsx701VuES3wCPmgo1h//zuyRndM3iDBCU5E/gfqj4VR8Kdl9kighrwKB3Ic0hQpk38rao3KQD0o85TAa0r8xCQb4pFrmb84Jegljk1750+sodBQwWItFNQqg6/sd3LeUuQkHDXtWjCRVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=niDhhmuT; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-43bca561111so5286125e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 03:51:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741089107; x=1741693907; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0QIrGJtgJ9WrxiYI0Ux/yttKhtDMbTNlh5iJ2ulSDEw=;
        b=niDhhmuT3FI4llPW5gE56rgYMNpVeNm8AH32SpCTQscCl7MkkxMFgApSCVkIDsvcLl
         c/zMo8iDMn0+nbbvi5MjK6RrWuaIVRSTD+q4HlhFyIzdc5uNI82TNzdgqeaeHqdhJvi1
         RgEeWzqxiJ5zq434rlfdFzfHOZ/tSkuT+iCjMTXd4T4tJply7Nd8COjN8EkT+oe0TmQb
         k69a6Af0R3YaI7ignMtrbkthddf0uSND6N2KfeWIGu0mTwkyu8s1WEMJKo5A7MO1iEYv
         wEzCX4DUZT1parNzBdNk+QdWVVd+dMDOV7HmrNrUO4YM32o4PoeUDCB3zM/7bpt3xuFe
         UbhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741089107; x=1741693907;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0QIrGJtgJ9WrxiYI0Ux/yttKhtDMbTNlh5iJ2ulSDEw=;
        b=gmfi4ZEPqvnEHFrET23QEUR1VOD0OvfyvOph+gKXpZMccmZSzM2fp3+McP7aam1s4w
         bdx6Q6DNEiYUJWADlmx2IBkdRlUNUko0a9N7Hbq5erU8SqJQ36rUsl38ovjRfVs0Azr2
         FhjEoVq8PGyrJTqpQP0GLmKhQZimHQEvBkm7eCKG7f0X3BTiDQtZsB+WsAK/hcsFcbmO
         3yH6pA/4ISMBS1wUtZsumET/RsSza1eKvK1dWVPKY0xxf8zGCB5fgI4a8ukdSfm/wfRq
         7roCp7XqM25EpctAxtLbv6v0I1V0wgazzVA0Ab4m+eSpx1c2+X0PJOLzYHTl8+cOMPVL
         s8Ag==
X-Forwarded-Encrypted: i=1; AJvYcCXkw0SyTjpz7U8cfGwHLv1iKiRnx0uY35foxrknhEGP+DHeT6N4Pngtgxun7ex17YPO3tcUE0BCZU8PlHo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+53ZnQnefTd21aY1aEPBfpsX4gOhck+tdIAhCAt7uIgCAtd+7
	NaTNt1NwOQXSvWjXsgMdxQ4FyBijSJXDEfKMq3qpMjV7alNiiQz2ga36CGsU6Joxnvo+/mZcyCn
	GFLOqw6v5IDt5RQ==
X-Google-Smtp-Source: AGHT+IH6uDE7kFpKO1QVfRSRVP5JbMp4n3OVboRInnn7ZaWP8qpMkUMUPL+jOVqAFfAOyRUiCPKTyKLwyY9/ckM=
X-Received: from wmsp28.prod.google.com ([2002:a05:600c:1d9c:b0:439:47d8:90a7])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1d02:b0:43b:bf6f:6eef with SMTP id 5b1f17b1804b1-43bbf6f718emr59000905e9.26.1741089107396;
 Tue, 04 Mar 2025 03:51:47 -0800 (PST)
Date: Tue, 04 Mar 2025 11:49:55 +0000
In-Reply-To: <20250304-vma-v15-0-5c641b31980a@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250304-vma-v15-0-5c641b31980a@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=4299; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=CJ1T+zPNUeGdU4wvXMNNlDKLq0tzZUD5m4mvMkDIXAA=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBnxulEaSGw/31FVCS5/5VSXxZoaOUjXDpT1LrRR
 tDfSE0L5QqJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZ8bpRAAKCRAEWL7uWMY5
 RsEuD/4o/rKRXqBbfkuRQLFPGDy/juNfWz4I75JbEw2BitMOV9q6peNiHW/KVI0pzGPicY3eBFz
 zFOlfAZVOz9Y8l/OVFYrhFBYxNweJRZ4iP6tjagJGeEmnw3bNPINVGHYCviyuLhkN/f/Rf6PCLH
 WTZ+Qp225X5ZWQbT3lnG6OpqgCmVY4sGVkcyEhQy+MYMuCvGdSorUPTKDegf0lsWHnugChI933w
 ZQDhHKTlTVFn2qDoN+6A331S+guYm3vpVzcKQwEmNttw/j+EAWy65W9bJ9ohghPmwRtEXOsCN7w
 JWwaxbH8G2s0fdMV3k7PtY7X6pCsbgBWiZpTpzOn1dz5mX1QI9rNIq7SP8XS2jqlMIGZeOu+Ijh
 H7WpdZLUSHVXkFsk2ASi3a0DySn2MVw6U1W8yznu+0nukUfrZCzIFcyJOv77VGIrzaUg3CN6j/4
 bT16j/9m3o0cuhLU7f6QhFRn3B0GeWBWtXn2y6627GG0V2xUTj/7Aomb7k2kKHlnbbuU7JfM4lD
 fDSeCVVdkUjfJF9PTT3ZAag2v8yD7/+AoTRyHVUg/JfCtq4eQB5VJ9jU966fx2AbSFcCNxPN15G
 EeNWMWKEXC8vRNy+nEw6XEMrOUknXmBnhDXEZi13FCs4NkyMMB8F4RsSaYKsPMbl2nHgDSMWNDe JxsF/6psbJFeXrg==
X-Mailer: b4 0.14.2
Message-ID: <20250304-vma-v15-4-5c641b31980a@google.com>
Subject: [PATCH v15 4/9] mm: rust: add lock_vma_under_rcu
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

Acked-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Acked-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Reviewed-by: Jann Horn <jannh@google.com>
Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>
Reviewed-by: Gary Guo <gary@garyguo.net>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/helpers/mm.c |  5 +++++
 rust/kernel/mm.rs | 60 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 65 insertions(+)

diff --git a/rust/helpers/mm.c b/rust/helpers/mm.c
index 7b72eb065a3e1173c920f02a440053cf6e93814e..81b510c96fd2692dcb7ab4705f790bd3a41a630e 100644
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
index 8b19dde249789b65d7b92159d131cbf38ba08149..618aa48e00a442c7790dc92085932f5aa6693729 100644
--- a/rust/kernel/mm.rs
+++ b/rust/kernel/mm.rs
@@ -18,6 +18,7 @@
 use core::{ops::Deref, ptr::NonNull};
 
 pub mod virt;
+use virt::VmaRef;
 
 /// A wrapper for the kernel's `struct mm_struct`.
 ///
@@ -160,6 +161,36 @@ pub unsafe fn from_raw<'a>(ptr: *const bindings::mm_struct) -> &'a MmWithUser {
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
+            let vma = unsafe { bindings::lock_vma_under_rcu(self.as_raw(), vma_addr) };
+            if !vma.is_null() {
+                return Some(VmaReadGuard {
+                    // SAFETY: If `lock_vma_under_rcu` returns a non-null ptr, then it points at a
+                    // valid vma. The vma is stable for as long as the vma read lock is held.
+                    vma: unsafe { VmaRef::from_raw(vma) },
+                    _nts: NotThreadSafe,
+                });
+            }
+        }
+
+        // Silence warnings about unused variables.
+        #[cfg(not(CONFIG_PER_VMA_LOCK))]
+        let _ = vma_addr;
+
+        None
+    }
+
     /// Lock the mmap read lock.
     #[inline]
     pub fn mmap_read_lock(&self) -> MmapReadGuard<'_> {
@@ -230,3 +261,32 @@ fn drop(&mut self) {
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
+    vma: &'a VmaRef,
+    // `vma_end_read` must be called on the same thread as where the lock was taken
+    _nts: NotThreadSafe,
+}
+
+// Make all `VmaRef` methods available on `VmaReadGuard`.
+impl Deref for VmaReadGuard<'_> {
+    type Target = VmaRef;
+
+    #[inline]
+    fn deref(&self) -> &VmaRef {
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
2.48.1.711.g2feabab25a-goog


