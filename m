Return-Path: <linux-kernel+bounces-512753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C80FDA33D61
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 12:06:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54F51165658
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 11:05:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 693032153C9;
	Thu, 13 Feb 2025 11:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LR41BsWb"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5F9021422E
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 11:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739444691; cv=none; b=GXOH9stTHXuHdA8PiO9rkStuos0U2nAfsBnuEooypuIiOqop2X4AeO0y63nDNDOXiiN3iTyT37hz+AtW3laJXLYPIZ2wfmgs9AZ9WwAAsusfMKOP6K2MMlmVscyPm3ZajxPGE5tJgXAnusarE0v1G16X/DJ0Lr5uo5nq7G88LdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739444691; c=relaxed/simple;
	bh=Y+J2tVj51QjuipDpR/j89prtBvkMX66gHrDq3YgpYsQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Ws05inAFbeKszpk3SRClcKBCtm6wqzCNtTMn+XCjzCHQsjPgpn6vC7BPd65JeA+zh7Rmv0MyCEH6eH/9FUZitDF9KPg1x1NdR6yOMEsGOw8uczoqqhyC7vxqQ+03Dzzhhy7a6UJVt0N+2OG+xqesj7CFVWH29RTt2XxRXFCQoy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LR41BsWb; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-43945f32e2dso5520025e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 03:04:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739444688; x=1740049488; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=CgLb6B+K0IFKSCneh1iu8CxwdcsXLyqW6hdJtG80sPw=;
        b=LR41BsWb9ipBoHjJV/HB6jwj0jZ4DSOCsJk9hLW9ynxyhTR5JtwwBFH71Ulxv/y4o/
         O0Cz9GW/SeBehw7aXiGX6OAcQPpNV27Lectj/BFm7Y8CHQjKs09nC+m2WfUE5yAqnCVJ
         8NYw9YmVp8utd9u5ZV1oAOfk2H750n9Hg6Hm676MCxIKu62WDrZcGEJrZRRKEhC0USMe
         awrz1FwxYuNyhMxJ02pVehzEMvB9QiuS6S7mjCl8RkhpvPnyRllL1vyslZs2vNZ2uhQn
         o2iHfviXd8iD/YGu+wh8KvQWu/Omrg23CTkCXn41QV+DZMX8J2kozhwaqtJwOTXwO0xM
         6QYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739444688; x=1740049488;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CgLb6B+K0IFKSCneh1iu8CxwdcsXLyqW6hdJtG80sPw=;
        b=RhmsD2kgQ5HLVCigRrCgU8yB/tN61b/Qh325XS+dY1TM+8S9sW0uRQrQJ6LGRZ3u1A
         InX4OnU8jHiRpX/aizhhRQ7yVGaEH8dK3bjjxbyBfeRJIxL68OQ+59KYVlAVycA5DYX6
         LjbxlkdZactPt1pmgo1WlcTLWprIxL40PN8r00Rko08hHMv+xs59/RQEXatJuo0+ZWC/
         lIEtnuPIeulXKC+okqoIW3/EmY4Yoprkd/DETX9P4kuc1BaZ7W4UOeyflVph+RtbjzBC
         WdoWL+jyg90NKHR1H+MfRzKM7TircLYlaVxTTX1um76D+cfaWIwjL+offZDqV7qWDpMt
         Wing==
X-Forwarded-Encrypted: i=1; AJvYcCU9kgsAOg6aDfdwcLEm1bExBB8gX+chkmWVlEQGTAAXzdHjZWYOoiiBUI1HiiNN7jKc4dBcV1puS4ldSLM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxD+iZDOSw1FyIxCPyiESUuwisAsVo+zZin0CurgEbsfBpnBlb1
	q3IN9n54m63VfqDOUUBPeg40f8bb8dUh6VYU9dc7rlva1QIlFC1S75T8El+uJliMLKZktxyLvkR
	olab1GWw5o2UWVw==
X-Google-Smtp-Source: AGHT+IEE4mERgLHcPxh4Z0XFIOmAvsYP5lm1mfa5000wNXTddJEmQQVgk4sP9gXH2gaDBiy234o63CvPhb4kDSo=
X-Received: from wmrn40.prod.google.com ([2002:a05:600c:5028:b0:439:5d9c:5d7e])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:46cc:b0:436:18d0:aa6e with SMTP id 5b1f17b1804b1-43960185e92mr36208335e9.5.1739444688303;
 Thu, 13 Feb 2025 03:04:48 -0800 (PST)
Date: Thu, 13 Feb 2025 11:04:04 +0000
In-Reply-To: <20250213-vma-v14-0-b29c47ab21f5@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250213-vma-v14-0-b29c47ab21f5@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=3164; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=Y+J2tVj51QjuipDpR/j89prtBvkMX66gHrDq3YgpYsQ=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBnrdHABUIA7xn4otWDfLthBx/LSs7Na9aVE8qME
 MbIMzywdJOJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZ63RwAAKCRAEWL7uWMY5
 RjJsD/9N/t+Xpj0ZBHju/OxddzbE+XEa6J7uMG5lNLfo03HNmsU7+6msxBvBQJ5vmKKjXjm3x9c
 oQ6hTWK6bPKhSrlen4dQyjRbw9cwqTxkxsgiLMGpqYZsYazH+ZkFqGJ/jfsq4gKS8grIm0Rj2G+
 D10/6vhw9ak557lgN3VdinlGRP3uz2TAMd3uiMGmlNInXAPtA58zBnPDFgrNmvoFWahp559WW6I
 20YGQWCPZKHjnbkMUCKsvkUbV18BxMTsLDTA0RIic2VyHQPOn2hB7hkCZOmdSzYtn0wBwZaCwjD
 ceaujq4uwhd+WV5miM++gFGrD9oJCHg8/ZOkc4ktS3GEoYRLvOVVzfFgCbNuP9YAnCercllEqfY
 GpfkQhzlFm+//Jxpm4fvqK7SVcfK/wbHpnXqx24ZgF2e+rJRoCrORcAttWL1atKC4oLtF96Q4GY
 /eZdG2B1Lep6R4PMqWwNOJ0oA7sOd1VvPSpKMs9k8B7dPLICaYDyu/9LWb6Gy47AyIlT2q5i4XD
 31iiqx+C7U8sGa0Z9N3uV28UyrkCD9qSFEJZc/0iTVZwnPn9tjuRtmOu5y5iaItpLQn+Wnxv7UL
 svXiQQz4GpRz1fQx3xZJrfYl8541aByQWVHo//K0h2RGgCSJV55vtoHEr5dKkxDfGptyf/REv5J Q+YfAvaP2OZ/9Vg==
X-Mailer: b4 0.13.0
Message-ID: <20250213-vma-v14-5-b29c47ab21f5@google.com>
Subject: [PATCH v14 5/8] mm: rust: add mmput_async support
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

Adds an MmWithUserAsync type that uses mmput_async when dropped but is
otherwise identical to MmWithUser. This has to be done using a separate
type because the thing we are changing is the destructor.

Rust Binder needs this to avoid a certain deadlock. See commit
9a9ab0d96362 ("binder: fix race between mmput() and do_exit()") for
details. It's also needed in the shrinker to avoid cleaning up the mm in
the shrinker's context.

Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>
Acked-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com> (for mm bits)
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/kernel/mm.rs | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/rust/kernel/mm.rs b/rust/kernel/mm.rs
index 618aa48e00a4..42decd311740 100644
--- a/rust/kernel/mm.rs
+++ b/rust/kernel/mm.rs
@@ -110,6 +110,48 @@ fn deref(&self) -> &Mm {
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
     /// Returns a raw pointer to the inner `mm_struct`.
@@ -161,6 +203,13 @@ pub unsafe fn from_raw<'a>(ptr: *const bindings::mm_struct) -> &'a MmWithUser {
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
2.48.1.502.g6dc24dfdaf-goog


