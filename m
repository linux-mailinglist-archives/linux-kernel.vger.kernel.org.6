Return-Path: <linux-kernel+bounces-441160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E24589ECA79
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 11:38:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84709188379A
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 10:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7740D23369F;
	Wed, 11 Dec 2024 10:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="O/mARUAo"
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C6C230279
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 10:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733913464; cv=none; b=oF6hOv8pGHkRbqJC+M6CWgUpGqCtN7eL+g1GDYjoyy0GLpoxiI5hwyIFCCe7OndOP4RI6YIBW11ieS/hQ1LQf1tR/iuEs/tsI4f+CK+Favpe8IG9WsoJ/6h3v+5eyJcZBdagtRBpE2n0+wVOblJ+wq8tq5bAiSwcd8IYFnHTueo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733913464; c=relaxed/simple;
	bh=PSMNvAHImS1yuLQzsvSoD2e3+5nrD/G5jvs5aJHnybQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YDaojabCAHpxvbe2yNpFeO8NXB+mUXY7fPeYG1xCCCgWEDYf1B4XULa9jXDx07+SMUlPdyuEkk+o1zYV/Wkq6w0vIkop16FVZTRRpQbbj1o6SkVoKJ9vQ1Y/tBhGsjAux6apFex5x/Nsem/0C+qWX2I1bqS5HbJclubSTuzTcok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=O/mARUAo; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-385df115288so2797404f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 02:37:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733913461; x=1734518261; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jtfdo1hWu/gkdW8i64KIMP+Laz0H38tgBK8KPM9++n4=;
        b=O/mARUAo5zcESSbeW2dtzZmGvBLDJbSDzb9uIwlt9AxFVDXPIZY0iobtp3f030Yrbg
         lGZr24wcGWvFWTewd8dJ7at0SRp39oM7SK1/4st9OcbIOGkwyJ77UbIpFWAMQ67CTgtw
         GI55cNSrrAQ+5KHeIoh+YkcyGRWrM/FPr4BcLgfHwLOeD/fpFPX8kdGnuiprbl1ReCMK
         x0k/91c3tImqbmSLJvsUjh4qehUCihwH5vn+aJK/oSvTT9eQkMX1P/JCiRm0FvIfDBOZ
         OCpWMU2hFmxoE26EbeKAt3hpuDPc43YSOha5wDY5RJctspHJoCECUvM94/+qN+OPUPgR
         8V4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733913461; x=1734518261;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jtfdo1hWu/gkdW8i64KIMP+Laz0H38tgBK8KPM9++n4=;
        b=OTHzDufPghiIYRtm1BkZmAMSDPQb7Hpt5Eax0BlOtpqf795i93p2HO393DRAXoI4fV
         ybV4A7LfykzVVpwJzssvs/XWc2bcXfrQ832CVaFgbi8vNtHJ9aganqkfOMchL1G+hzqn
         rodNuLaI5HReoIzbvl0RQ+s1VjWGqXaR8TBFWL3k0hUiO5FeJI5delT9pj6vx554dQa3
         X3PCCI9gA1CmA3viukC5Fxyi5cF5rixguKaVe5bai02nVhxcvfPo7j/KOlJhD5GdcmhK
         5BqCYZWy3M2Xkrf4DdvADL5ovBIbJ0yYh49tmBvjcaJOpPWEN38UQ92bycIyfs94QJHJ
         xYzg==
X-Forwarded-Encrypted: i=1; AJvYcCUCpCXp7zm8CrOCNBUKaoTRX49qnxZzohLMrit9zfXkyt8eWzZ+su0SgTIQwsnjoKDXVpH90D7XHOL7QEk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBqMF1BmIXxVtu+LN+L6TXt4YPymSXz3YNPELIsdSybOdrBxch
	8oMhyHhz8F9AJUOSEV1+STvfLkaWOcZSeeYbz0McKzLfpR0QHZ1FaGlNcmC4vLDUWeAxOy8dIzx
	ys7C0ENoRv0hoyg==
X-Google-Smtp-Source: AGHT+IEPSG2Hqz3P3TcvwAF16etBCufMRdEZ09D0s4Xc1JzGR3A143l7IWc1m3i2YQwgadn0owNcK8U+CXDiey4=
X-Received: from wmok4.prod.google.com ([2002:a05:600c:4784:b0:434:a2c3:d51b])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:4023:b0:385:eb17:cd3d with SMTP id ffacd0b85a97d-3864ce49640mr1860462f8f.8.1733913461236;
 Wed, 11 Dec 2024 02:37:41 -0800 (PST)
Date: Wed, 11 Dec 2024 10:37:08 +0000
In-Reply-To: <20241211-vma-v11-0-466640428fc3@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241211-vma-v11-0-466640428fc3@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=3946; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=PSMNvAHImS1yuLQzsvSoD2e3+5nrD/G5jvs5aJHnybQ=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBnWWtoiZME2oih+BwGJvgLeV9XdV6aNRW+Q12xj
 brbx3/LqYWJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZ1lraAAKCRAEWL7uWMY5
 RhRpEACoHtQCpffN1jELk1C4qWvx35jHIqYWia49W6YKDfgnOKbSh/PaQNsmFLQ5xqVgbm7v/UK
 aBQwg3EiD7cArhLxL66nlarZSNU4xAyIYRagufeEs62wVM8fiHrN0bLBQZaTeVR45ka6Dr/NpjT
 JDvwDHSpm37SvlfAmofc9S+xU4wW8bYutsCq3jCcK0SwgR0BZRcT+q5yYgBnR06vTwCt8Eo32tF
 4eCgLuB09ENw8ozEaZuy3U/nIsKDw/Fs1cyweaV3JFTRhZu08ZCQFCMZIItw+z7S9L6SHZ7QOqo
 2aszTbLLzdzJChsBBjyQ7S46UghGprkQh+8+iJ/+OOOK9T4A71euURV7yzgU5+I7pOVq7uuEUvc
 xMxwyyWyeR/cf/dst1SzUffc7jT2e/Ap4W1LCtdaFkEgNXR6/6vTsJ9ffKl5VQYaw5CW+v+L/NY
 BXwxO+E6cGtAf9afhviyTbXnazRnar/c2501rI4RBu/3zB+0LuIiuSBH4ZyHIkanDFBbekdJzfe
 j2fNRFns1Rv36w8SKGtQokraNhC7EX9sVaWLGkn778X7n00EcmfFH5uMSpERmffICVt/3aJa2rW
 nW09v5vj355pS053y8y4wrt1fWYw/tuQYoBi21rp2L+yWlr+nKcIRcoshluSVLDbH40G2H3jp6u boRup1nXBHzGN5w==
X-Mailer: b4 0.13.0
Message-ID: <20241211-vma-v11-4-466640428fc3@google.com>
Subject: [PATCH v11 4/8] mm: rust: add lock_vma_under_rcu
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
2.47.1.613.gc27f4b7a9f-goog


