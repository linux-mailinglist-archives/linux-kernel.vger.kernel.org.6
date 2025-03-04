Return-Path: <linux-kernel+bounces-544067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AA7DA4DD06
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 12:53:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6789D3AE432
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 11:52:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FADE202C5D;
	Tue,  4 Mar 2025 11:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iA53fyGz"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E78202F61
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 11:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741089112; cv=none; b=Adof8dbYOE+yELXasV8nirhVDGMT3JAhVdvb5OtEZKFATeUUYkhu388XnQ7MNLBS2HZkMoI01tQeMy6SC7pZmU1ZI5LLuJFPWR5zOAlaLX7E8v4JkDHedj9gUTt8AsIe8UyWOrH9nR6xksKosSgurLZa2e6UMGNCVkeocoD88Sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741089112; c=relaxed/simple;
	bh=xSGLNPDW62yzcckuWTk3uQqTaRzbf58iibOZMdhxq6I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Y4N37gN4B3ExgF2K7JYswo/XtEO3eMmqZGeQysCntV49wYTnaRZn3Egky8sRO5//DCtSEi9RU9rKR0ZiYZJ54CagODtbRvdrhWthNivwUI13e0+4cKEkF3Pkaou/H0kJnNoyPks+s0zo4jRaG+4gtp7hINURWjVC83wTI9cEoew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iA53fyGz; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-438da39bb69so40013725e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 03:51:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741089109; x=1741693909; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=aI2XWfrK8L7dJhBQ99USABCedEMGK80/IAjzCOe7ExI=;
        b=iA53fyGzEwUzG2c5C6TT20S7eMQJchq0a24RTrN7QZIqnl1+FrleLsZrTqkS1E5pA6
         /LW/BzXSPhium4Fi14rsr48MGDfAF5TYofaW0mXr/VVZ/C5BkpVMYfEVKT/mz15HttdY
         yHR8a2v5b1tObAmwn4LNbjbiHYImrLVmMgRP3tsGq8fK87Ltp4z9LDB4jpNjcu3D766K
         x30yyxXE08nSOpKYJjyZYBh/L4J17ohlHz4R1tJvWSi5hFNlbAQOY/1fpZqAw349BG0I
         yY2ZmLW73+DlqkUlnHoOcW5piasKKDiMVBCnSH3/oGFM3TNbeQ+gOvGHuwrsdusMei3S
         8v3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741089109; x=1741693909;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aI2XWfrK8L7dJhBQ99USABCedEMGK80/IAjzCOe7ExI=;
        b=Z3+xHv+z+XaKNTP46O/lmirDxpwEJHJM8FptntEpr8wf8uLAahwngrjbQQ1yO0gyvs
         MULogRcUZ4rYqrSs6uW7ifTODX5PXsQEAzh/iuGAKpysQBo8gkl4PVdvUPhpiusEdxcj
         x48KmarZuOhy5+yJP/pT9b9uxSrtpf4nEys48KftOEtw4YZITH7COjpIAAywWhL5nGkm
         MUxfU7ycqJIZLrqQ1YnxAaXr2v7f2gZz2n3SkUWi83RRtALflilmc4oU0djpOySkdM8V
         9/pgUheOX7DUs5TMfIqR9KqqssURfvSoJxdTl5Fcd5x1iQE/Ih4/KXSHUcqkx1UDmuQ2
         KqAw==
X-Forwarded-Encrypted: i=1; AJvYcCVDODu6BnzpF4tr3MigPMbZgXzA2jwGn62/qXBKH6jV+E0Gcxj0fXbGhjFKrOMcj7kqAb88NbaZhEAybMQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YynTQCOQmg1DXPT4LsIw5xr0J7YCer7Bf1BGcIJmYGwZQ9RQdqj
	fbCdHS0ePQYKGtN93lLuSdHXL9LBsAdNu8+fDYV0h5GevUWH90k9UZ2vT2p5zmrPPYg7f47AWOy
	bl533z94HNULjeg==
X-Google-Smtp-Source: AGHT+IHQJX6SyApmbGVWCDV7v9PO3CWMVOeGp5KD2gecK+DblPwJWtdlWnpfipQ4oovoR4cHDpo8lbX1wN6Lv3g=
X-Received: from wre25.prod.google.com ([2002:a05:6000:4b19:b0:390:e9b3:446f])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:42c1:b0:390:f552:d295 with SMTP id ffacd0b85a97d-390f552d679mr8502546f8f.53.1741089109445;
 Tue, 04 Mar 2025 03:51:49 -0800 (PST)
Date: Tue, 04 Mar 2025 11:49:56 +0000
In-Reply-To: <20250304-vma-v15-0-5c641b31980a@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250304-vma-v15-0-5c641b31980a@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=3335; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=xSGLNPDW62yzcckuWTk3uQqTaRzbf58iibOZMdhxq6I=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBnxulF6nwf1OhE3YaYgxDSFqu7RzhmizDo18rty
 fsZGoC39uaJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZ8bpRQAKCRAEWL7uWMY5
 RvnqEACtkBMWPxlKw51sOjxu20Xs6uc3j3so2MnrAiG5F8Dq0oQXCv6C2Jm5VA8gD0xzUa7Qcn1
 EprFVaFdIFhxDAs8Cpjsfi1QQgfd+aZDJDrKwt/xeiHu4YKQ+9pGOax+8fDv5ovnkbtrPUqD80X
 TGZJYRHTvmvsxTai5LEk2MERjoDuGuuwra4cUtOLy9QwaUIXEN0HEmCdNR2/A9YZK4qomURJ492
 KJkpg6Hjz4wKDqfAIZSrQh6xCBrUn6sXP08LSi/2/1Nkf/HM6fvoQ50uMHOxHOnkTZgpL9ibMXb
 ki9nFzvsgW8ZCCVxHUAFRWBbsdVs/zgD9AhRfRpPyqE6CniU9gYLRHgDaFt0XRIU8S8+wQihpLq
 qS0HKw//lXRWfjy79LKJkcBq5kkt7CUm1LWaiH974hRZJ33lPv+ShjaWCcySwwWTOV4R+oXh1N2
 sI05EqbAavhyl/HTNzx2eJWXYfUgqGzxEB+JAOkyZ8bCTbsbIbUHuA3DSZJQdaSBTt3EkbBx4k8
 97/BpfghbhBHzw0YUcZjLS77qGRSqpFafXKlef+3s3QHj2SKvUM37syP1C/8XWP7D0lMpPxNuV1
 VQRXEMvU3Li2qX5vz8lgxXzaTOORvZ+LATxG1xp8XHvWru5eC2l5/eZM5wWtq9YpVjSzY+C2UFH Dbaazx7sLY9AHQg==
X-Mailer: b4 0.14.2
Message-ID: <20250304-vma-v15-5-5c641b31980a@google.com>
Subject: [PATCH v15 5/9] mm: rust: add mmput_async support
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

Adds an MmWithUserAsync type that uses mmput_async when dropped but is
otherwise identical to MmWithUser. This has to be done using a separate
type because the thing we are changing is the destructor.

Rust Binder needs this to avoid a certain deadlock. See commit
9a9ab0d96362 ("binder: fix race between mmput() and do_exit()") for
details. It's also needed in the shrinker to avoid cleaning up the mm in
the shrinker's context.

Acked-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Acked-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>
Reviewed-by: Gary Guo <gary@garyguo.net>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/kernel/mm.rs | 51 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/rust/kernel/mm.rs b/rust/kernel/mm.rs
index 618aa48e00a442c7790dc92085932f5aa6693729..c7373d72bce558916f52fd62607b99025da8dbac 100644
--- a/rust/kernel/mm.rs
+++ b/rust/kernel/mm.rs
@@ -110,6 +110,50 @@ fn deref(&self) -> &Mm {
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
+    #[inline]
+    fn inc_ref(&self) {
+        // SAFETY: The pointer is valid since self is a reference.
+        unsafe { bindings::mmget(self.as_raw()) };
+    }
+
+    #[inline]
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
     /// Returns a raw pointer to the inner `mm_struct`.
@@ -161,6 +205,13 @@ pub unsafe fn from_raw<'a>(ptr: *const bindings::mm_struct) -> &'a MmWithUser {
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
2.48.1.711.g2feabab25a-goog


