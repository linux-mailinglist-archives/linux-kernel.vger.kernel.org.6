Return-Path: <linux-kernel+bounces-441161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F3B09ECA7A
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 11:38:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 029822886F1
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 10:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6787F211A09;
	Wed, 11 Dec 2024 10:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nuj/+Oee"
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D03A8233691
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 10:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733913467; cv=none; b=RrjixCGpg0tyY5ov7ca668rQOGQ32Nw1wdUNVHPnt7nsaadzL0Ufh7SQs/ChT4mgOMAkaGGOMRX/F0TL2QvFhdbzh+ugADD2fAcMRCHht+cgbPPlf+z6lZHzy4KL+m5Hu17B9xRy33Ny0ji0FgBQNOuBOVcMC/twkn7FxMcEeoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733913467; c=relaxed/simple;
	bh=o52ixmPVakbGqHXkdZGKle8ANx4alFbrYcfoTBoaBeY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=EvMhiU5miRljXo16n+x39aEaBNI+hDEVM74vGuFEba6vsjDxBYmYw1QbxjrM4EEGs/pyiH0U6IUrgpPlNz97RZjDwdIhByQ+RCdGWbAW9RgKRYa4jmRrlRrPXYHVWD9SNUE06grQQ4CltsVR7KYTlrDNAPE70QVCbMyHNXn7RXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nuj/+Oee; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-3862e986d17so1711729f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 02:37:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733913463; x=1734518263; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=N4tIdMdsO0J6lrUvneIwXSrF/KOin5KwKJIBsiYufGA=;
        b=nuj/+OeeVMOiUj+t5OBbkKwDnqVnCgHfp00R3GWlmvtINfVvW7fkLbxPtLSdIi7odm
         A+3e9cYZ5A0RYxxRMF9ohOysJkcV9S4w98+rzVpxF3nR6NE48ZCCQ6Q9waHJos5n0s71
         TvoYLslyYC2HYWBn4GUG+qaQiUUqrwLiBxsvLqLNYEB4q5kfLz/T5WjveFa3wu8CLyEz
         hlaYCOii+ac6v/CPyEha1u8wzKJPOzay3K4BjCihPIAMeBraC41NxyQkDRE6PB5QAhNU
         MGXDR5nXLoiH45j7eUqMUmztWIC9y5ZwzvIi7h7+w+B5rVYwlSZS4gCp8u3ZcGL+z3IM
         0Obw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733913463; x=1734518263;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N4tIdMdsO0J6lrUvneIwXSrF/KOin5KwKJIBsiYufGA=;
        b=fBKGO7fUNQuYgu9r5gp/JtQBwfHNQOAydqC9vevxBfIkWDnVehcZVXKqU8Kyit+vgI
         drKQQ0fxNb3aedUPd3almTOOlnYj/OuTk0Vu05Jh5aQ50K4t4SYXWoHSVu5rJ1p2JplG
         IdThI/hAJhGRQxAlQbHYEGOursZUWErWyiwvDSbreNXSkthGdM7FpdFyCZjP0w7CvjnM
         8UA3+98E9+T4zVmC6a39XIAhOxU8dmiZbB2HwcBgvrsM1CMg2dV+3hQeSMKtIKsqanyd
         J68yLKIVDRQqQVmGDkcWxYr8wJqf/LBogyHTb6eyzAr6u/YZH8cN4HVIAdQzs1UU/pl6
         WTyQ==
X-Forwarded-Encrypted: i=1; AJvYcCWTjM2k8OApvV6Q305fWEIkACBvot/3T5NyqGy5+4U+RF2ANXm6PFNVpETza9h8mmZA5524Np1IIRekrgE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjSTZRS2lp4lxorxkNLCKTSy9qiYji7yhnspY0tR3l5krGPxDQ
	g4tOZEOls5gy4FSsBVxKaaT7l5KewSxq82NNsSZYcajmubtHFkJ48SWpV2gpndTuKJM38CEp83+
	SyPssmV/HrRTiQw==
X-Google-Smtp-Source: AGHT+IGvJYqc2Db+rertFy18yncLZyz9Adh52dHN4rQJSEpkQ1PGruhxbsByd/HWJepWTHQaE7E4uK9LRFm4JnY=
X-Received: from wmpr10.prod.google.com ([2002:a05:600c:320a:b0:435:dde5:2c3b])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:2d84:b0:385:f979:7664 with SMTP id ffacd0b85a97d-3864ced3035mr1190487f8f.58.1733913463310;
 Wed, 11 Dec 2024 02:37:43 -0800 (PST)
Date: Wed, 11 Dec 2024 10:37:09 +0000
In-Reply-To: <20241211-vma-v11-0-466640428fc3@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241211-vma-v11-0-466640428fc3@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=3090; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=o52ixmPVakbGqHXkdZGKle8ANx4alFbrYcfoTBoaBeY=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBnWWtoRxaCSkuHkzNXUxE2qqNVnv4EQP+W4uD5c
 UetmRby79SJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZ1lraAAKCRAEWL7uWMY5
 RmGCD/9Xgd51fs3bqaJoNH1j26BxFH1sX0Yp3b23v/LQVFSNhncGa6OGK550wg7ov0OeRIedPKw
 vfoO7FS+v9j13zOMi4A9nogfpPp0lYkqOTWrjQl4lIX68/kck8B5nybxGBMNAvS2CWxD8J0Oomq
 6SQ+cb/xgGWhD7xV2WvIifQANQyuin8/tmalAHCl1YX+yIhv+kuE9c0KrvQTAZoWjdTvymoHJIf
 1HJepqC3TOgcM0g6dYzn1eNvyFJ9ohJMe9U/AuPZyQf7j0uZPdI87WRmSPQo4Nz3eWY1OLsDC3O
 UXjBgTWPCBw2u6qNS1ZBOlc/qK8zjohbdQlEjtXZmBJySD+w3BE4xtEeY3yFUM4dz74jwcOQlWK
 WDLxpWyPhDtHAwUZApsiExI7rM4qZ5YDprePBLCPvtvFW0iPN05pOnPqHip3EZB571ZotEyrQqH
 M6TPjtBZ0so7nD5X7bMEUx1AWeXuWpfqU9K+OuvbpcPa1bSLiKddGL3/aXfKcp89ZoPPHKRWgE4
 qQKlEHkqh+G265jkYzw0ENNNu9TBPO/eqNsH9Vz4XpCRGS3WC0l5ZbXStkimQTxSBRvxIimx72u
 12CtVhWEgk2lytcOj92QGdVSVd3m1qTGXFcJ2PHYgnugqt12OMZ/3fsD9gyqGz17LTTFnjZ+Rls mQogTRrM6ybWoCA==
X-Mailer: b4 0.13.0
Message-ID: <20241211-vma-v11-5-466640428fc3@google.com>
Subject: [PATCH v11 5/8] mm: rust: add mmput_async support
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

Adds an MmWithUserAsync type that uses mmput_async when dropped but is
otherwise identical to MmWithUser. This has to be done using a separate
type because the thing we are changing is the destructor.

Rust Binder needs this to avoid a certain deadlock. See commit
9a9ab0d96362 ("binder: fix race between mmput() and do_exit()") for
details. It's also needed in the shrinker to avoid cleaning up the mm in
the shrinker's context.

Acked-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com> (for mm bits)
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/kernel/mm.rs | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/rust/kernel/mm.rs b/rust/kernel/mm.rs
index 425b73a9dfe6..50f4861ae4b9 100644
--- a/rust/kernel/mm.rs
+++ b/rust/kernel/mm.rs
@@ -98,6 +98,48 @@ fn deref(&self) -> &Mm {
     }
 }
 
+/// A wrapper for the kernel's `struct mm_struct`.
+///
+/// This type is identical to `MmWithUser` except that it uses `mmput_async` when dropping a
+/// refcount. This means that the destructor of `ARef<MmWithUserAsync>` is safe to call in atomic
+/// context.
+///
+/// # Invariants
+///
+/// Values of this type are always refcounted using `mmget`. The value of `mm_users` is non-zero.
+#[repr(transparent)]
+pub struct MmWithUserAsync {
+    mm: MmWithUser,
+}
+
+// SAFETY: It is safe to call `mmput_async` on another thread than where `mmget` was called.
+unsafe impl Send for MmWithUserAsync {}
+// SAFETY: All methods on `MmWithUserAsync` can be called in parallel from several threads.
+unsafe impl Sync for MmWithUserAsync {}
+
+// SAFETY: By the type invariants, this type is always refcounted.
+unsafe impl AlwaysRefCounted for MmWithUserAsync {
+    fn inc_ref(&self) {
+        // SAFETY: The pointer is valid since self is a reference.
+        unsafe { bindings::mmget(self.as_raw()) };
+    }
+
+    unsafe fn dec_ref(obj: NonNull<Self>) {
+        // SAFETY: The caller is giving up their refcount.
+        unsafe { bindings::mmput_async(obj.cast().as_ptr()) };
+    }
+}
+
+// Make all `MmWithUser` methods available on `MmWithUserAsync`.
+impl Deref for MmWithUserAsync {
+    type Target = MmWithUser;
+
+    #[inline]
+    fn deref(&self) -> &MmWithUser {
+        &self.mm
+    }
+}
+
 // These methods are safe to call even if `mm_users` is zero.
 impl Mm {
     /// Call `mmgrab` on `current.mm`.
@@ -171,6 +213,13 @@ pub unsafe fn from_raw<'a>(ptr: *const bindings::mm_struct) -> &'a MmWithUser {
         unsafe { &*ptr.cast() }
     }
 
+    /// Use `mmput_async` when dropping this refcount.
+    #[inline]
+    pub fn into_mmput_async(me: ARef<MmWithUser>) -> ARef<MmWithUserAsync> {
+        // SAFETY: The layouts and invariants are compatible.
+        unsafe { ARef::from_raw(ARef::into_raw(me).cast()) }
+    }
+
     /// Attempt to access a vma using the vma read lock.
     ///
     /// This is an optimistic trylock operation, so it may fail if there is contention. In that

-- 
2.47.1.613.gc27f4b7a9f-goog


