Return-Path: <linux-kernel+bounces-512752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 796D7A33D5F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 12:06:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CE853A9BBF
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 11:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75DCE21516F;
	Thu, 13 Feb 2025 11:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iH27nHe6"
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B20B421481D
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 11:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739444689; cv=none; b=CU84D4p5i+By5E2z3BtGsAcESKZxryXOiJh3+QnD0xi6bib7SgEHEx+uwl9mED3GaThIWZSoPDcsU9FqsJwRh51PABAd20rlxzBo77mbZWYb7ZzvvTv0LZCv5/T4IWr6l8N8/TWtDafkzK3Wfum5FsjH+1Jog+Qf1IaJLVtH5zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739444689; c=relaxed/simple;
	bh=7YH1vGH4J5NrwgKxb07UMrGiCmpjxEls6xw94mytwWs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hCqbXDKnGAEXIQhx22QCVYmQcqlTmHz4nFkXWF5dSq7NixzqKHasm+bdHP0X3Y82algWVW+l8m0hipc7YC5IT4YqJHxq1Z1/1Nd3P+JbY90t5Q3lMrDbcd11Mzr6WZczELzshj66OLe6EarA8XjeN9w8MlUuuoSOf3JZCqT5hd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iH27nHe6; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-38f28a4647eso145971f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 03:04:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739444686; x=1740049486; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/uyBvvUIBqhEGg3k1MSKl3P/NCSf2A+x8xfYmCFIPos=;
        b=iH27nHe6lHnqVr1/loBq8AkqzfZVPaBixskq5+kuxyCzuh9GBI5dzOJl14bxHBnGbJ
         3bqOAUYKVlUC99gLQgQAf3l4cWApVxx0i7aOH4AVjJSeczjxqNOcOliWuI3/WIecQvBJ
         OhpOOAwZnB85SAbv4n/pEYhsotibWVNwOeYsssxhNXcD0wngydGW8dyoarG6BE9VzHFT
         XUxCcr8mKBtQWfYANCCfbO/jkpttRMVLq59thlKllBaOUs83Wag1Ix6OJULV6sll1eL2
         HTqA073+fGjvQ4yzuiYdXtekNPY2EsZauGMqa+RU05oZ5QjfSp/qb40vRE9odm+R9zUh
         AJYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739444686; x=1740049486;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/uyBvvUIBqhEGg3k1MSKl3P/NCSf2A+x8xfYmCFIPos=;
        b=ObFktPQfA8PBDZDdQArB3XcIfTRlg+mlEpSxmpFrVe7PWtURbzEYsQpBKqt/vBETMt
         zFq4GArIFc4+M2EWL22c/tozrf2Vx3HKhs9RpgDJf5KEFN98PR6Te3GKOkuf0P8cmxGQ
         NO+T7jsG4UD6GDuNMwSVsVntfh/Wsfoe/Y+kCOJ4v+tAQ1tmlWdgpcvU0PT7lCIaMMPU
         DY5eVfwfVH3jH7K+diUnYM4Fx/PCK9X/BAlPQdTIG3b7CL+jf0jBelVbKn6jmrvG10oE
         JrCl2uzCHxirpqzKm8oEr/VkM2Q7lRRsBetF32rv/fZpPKTR83h32O+6N3HLIbnUSOUo
         ENrQ==
X-Forwarded-Encrypted: i=1; AJvYcCVoUiZcE0dozzrqtHMQHfXNAbYjTc7AcHJt27g9aUicrdu7k/KNQuMs5b0uZh9sUKXoyqEdrcKvEu0SufE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIyiGlQi/lMpgGKzR//Ff8N8bMIEWUqHacyklhLxQJfDOEQn7c
	+b0wm4CMlaq46flQ2yxd/wNXmITM6/2DRZTET9ZgKi5H9G51oxSW4pXBUjU26oESIRuzlPyaps6
	unGL3YdmUOkuvXw==
X-Google-Smtp-Source: AGHT+IHfpu4LwUir1xs0IVZCM1IC0uXcvmusDtyLHlflipwlekCf6G6k2n3LWvqP3SiylhkkpqKNBH+Ir9bJCqU=
X-Received: from wmbay19.prod.google.com ([2002:a05:600c:1e13:b0:439:5636:735f])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3b9e:b0:439:3dc0:29b6 with SMTP id 5b1f17b1804b1-43960169525mr31940045e9.2.1739444686140;
 Thu, 13 Feb 2025 03:04:46 -0800 (PST)
Date: Thu, 13 Feb 2025 11:04:03 +0000
In-Reply-To: <20250213-vma-v14-0-b29c47ab21f5@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250213-vma-v14-0-b29c47ab21f5@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=4092; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=7YH1vGH4J5NrwgKxb07UMrGiCmpjxEls6xw94mytwWs=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBnrdHAisosHMy/OP18+ZFSNrfkNK5udMfSbyYBd
 /UYV8VUP0+JAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZ63RwAAKCRAEWL7uWMY5
 Rto2D/9a3RX0gRbzHxMqA63smy2e5oFZ4X2tYbSXIkyIwN6VWd8YZtH1PcFwUa5wK0pU8XdojFd
 AYyeERKnFDljzjTqnvwqBfphg0liowGbNq23niy2uCffaJxJo4UFB/Drit3FPKggtxzHYqlSPSs
 7luyMeiT/YiEiq1s08asYDvnPjbigsK7Vl5UaX+i6F1pHlNeaJ750Ohu+Z8Ts3OEu/MyCC69Oso
 9buHg7+vnmGaOGJHFS4eDB16eYOTTcvgOIZ2ChRuao5jPRoBo2GjNWXxjy4vV7QfGrE4Ji5AqUn
 IyBvpRKcct/CWYF5YcWkNEDGIvx5sqofRxhE3uhD2+JdwrCefrkQYizdTzFxvFfh7VAAue0FLUa
 GNmYd2K0SvmP1Oikt07eoNMllm+se3DMiQdMea/I/HQYLf4vH/zEd09fKFYz8O4vsAl/nsIGGyw
 ulMOzd64acCq2XDNQH9O4ocWZM0V905RHEID9LA86bKDSVZiyp+fgDpbmDkwTMfYhKgTi3hUlVM
 O+oKYcf9ikY3RTB2rW+zZRdXGN+6G39veH40gcvbcFon8yw4J7Q/gd61g5QGdnKCz+a4skqrcrQ
 rW24zBO2XYUM9mStTg2QYQbtyTURioRrsA18aFyqz3iWziTvzshu0DHWgtkaeah3hggl6BIqBfb DtcnZcK0amgnBGA==
X-Mailer: b4 0.13.0
Message-ID: <20250213-vma-v14-4-b29c47ab21f5@google.com>
Subject: [PATCH v14 4/8] mm: rust: add lock_vma_under_rcu
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
Reviewed-by: Jann Horn <jannh@google.com>
Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/helpers/mm.c |  5 +++++
 rust/kernel/mm.rs | 60 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 65 insertions(+)

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
index 8b19dde24978..618aa48e00a4 100644
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
2.48.1.502.g6dc24dfdaf-goog


