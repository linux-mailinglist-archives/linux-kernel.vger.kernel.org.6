Return-Path: <linux-kernel+bounces-571202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C5F6A6BA57
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 13:11:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD2134A0755
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 12:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A3CF22A4E2;
	Fri, 21 Mar 2025 12:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="leiY3BpT"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80B1F22A4FA
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 12:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742559034; cv=none; b=nW4fzCTEq3+ZswJjvx45us6ioLdzlUo2C60rm0xOHj4o6allIv1Ud2LOt0NR5z4lnYit4YHwoBpI9tzUwdPmWLdxgtY+EiofbEfMRHiz0VP600wWVQ4XHEA5ahRVzCXd3QHl9dZYhVjc1lpKu5ifdKsEqSFOIC7p0iY7PBODOAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742559034; c=relaxed/simple;
	bh=6lzCJFSUMWX1AlTPPuLqtPzwOcTIE+6x81G2SG9eZx4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=iCb/7rWTwLT6qkFpTpJtXPCkUoqikeBMPFJTp3M4+D/CtnCiO3unrTg+LoUXb8Pfxs9DKp2wCRoOpTHLwf7LgRrE2/Pu3hich0U00oTizD7EgBIQv18WbyK914V6urogHZEfiyKkkChF9aSLpcgtAf3CbwMChv5Pm6cI3yqSb8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=leiY3BpT; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-43935e09897so12755055e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 05:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742559031; x=1743163831; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NBztbKfuuo+ytlc4YEnjoWWJ1PxUABYTHC+WTNo/Y1w=;
        b=leiY3BpTbgul1dW1kKoHMq6HSPwfWd2c8mcVwUCh3iGYyXNKp+FJjwPF8ztN3gZbxU
         YljRAdpRonfPKQkid8/SY7AhgIUhYJWPQZxJFBDrKt1kheNl79pW4aKiGOTtP21PqwXw
         wWNnX4B87nDcWVXO3KXzmh/B7WAnJHGAbFwdVmQl+ONTLJ549Qg3tNdwFDZablpviXYW
         ONgjNZfHQcsgPrzQdPgUz/ZVQG/fIKPiUknvInyW8mgVZTil3I4x9kPqDPjqFbzeigjY
         IzML4MYGm5qIdKUJA55PRPQcNb/KlZeiv9MZ33br4tfFR2HkQ8Wxb/rqVZzRXR7lFc8G
         YJGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742559031; x=1743163831;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NBztbKfuuo+ytlc4YEnjoWWJ1PxUABYTHC+WTNo/Y1w=;
        b=CMvLTMuqk9R0dDVR23fSVD6HP5VTpNtmbb3cAVOpMCBOn0s+bIzn+V8BKmIvNwE0CF
         uqkRE0iiA8ulpD2TDM+nT48/nZ51zyUm/XNR0YCLsKRLl22Vl9BqxCoo7NlKC6p4rOR0
         ekp+c1h3fi3UMqFPdD+rBJD+4RwKk+KQZII0X8g5EqJMBcEelFKW5qBE+f+wbQMlNqoD
         GLQw4sgvE0D6lXBnrMo1AViaRHvWXTs9Eu/ScNg1xKTLqFRj8PTLA8iXe5LYU1TaxAv+
         EHlYzd1SmpDHSOsONGPaQO3xV54SMkNWm+NnJnMiFMB+KKm5zv+EemIdzBzZyp172Cjk
         keSw==
X-Forwarded-Encrypted: i=1; AJvYcCWkb+och4NI//8sHAOvft7784p4Y9kSBcAptOhpU+eY9vk1h3+ENCm0Cj2KpGXMv1GhdRcmVDwnxyeIR4s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGy2tla4Rs2bEoKlIoAuoIHT5PyYke3+7bEljzhlV1q2u2u4m7
	q2RVzf3A60lS7ZU9TiFvQg75IkMcAgiM9opm+sp/Il+frBtPdCK6jvBAo5nC2NFBo0ZObIiTt4A
	1m7SzUf1AsWKNVg==
X-Google-Smtp-Source: AGHT+IF65edUlhZbjCNGt6uO6OKPFramMmkd/YsaLLbYtg4M9yl1T3kNo+qR6bBWCuygeAsNqnIVt9V9KVGreYo=
X-Received: from wmsp31.prod.google.com ([2002:a05:600c:1d9f:b0:43d:4ba5:b5d6])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:5021:b0:43c:ea1a:720c with SMTP id 5b1f17b1804b1-43d509f6307mr30136625e9.18.1742559030874;
 Fri, 21 Mar 2025 05:10:30 -0700 (PDT)
Date: Fri, 21 Mar 2025 12:09:59 +0000
In-Reply-To: <20250321-vec-methods-v2-0-6d9c8a4634cb@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250321-vec-methods-v2-0-6d9c8a4634cb@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=2989; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=6lzCJFSUMWX1AlTPPuLqtPzwOcTIE+6x81G2SG9eZx4=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBn3VcoXPTuvzLjM3mlQwcw5ajNQRpmPUqneFwoJ
 NpzBaM5TAaJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZ91XKAAKCRAEWL7uWMY5
 RiC9D/9zTp2bu0cXiRsjGd0CNOjEPoLfPzpemTPJGzXVqh4p2WRoh0FgrO9TEES+xXODz45qfy8
 VpT7/7mb6ofpz8+dZREU3iUvhs+LCO6n0dWTY9UypmCKxm5h7HKpYyq+dOFKazr+qokDVtE8Syt
 HtInTIlIUQaiyl+lbJRPIQ4VGdQftZRtLPQYAq4zZ4bd/qVa9kh2VeGlOp5fj8iLKfGHDi4+lzg
 Yf00KoUVwJiiwnBW0cO94jfBp6MwOH8Fagr74RhlUBUuQ8VaBwfxd+T5AaYMnHHT+gCVvbi//hu
 Um7D/7h3IRPtZ63TawMCr7ABTqVja5RsmeBPVoW9rU719uwRUdV0H3smrHbyrXYC7PxPSmjdsCk
 7whcVGpF8Er2Lj6UDEQNNp4/iW9tNVQzO+mbJVlAmaQwlMqJVrD9yn/gvPHfpuQw1ue/m3Ku85d
 klWITTz6pvC1DINStsyOoN64yECXLwnGsNjP76rdSoQmT6XQnbe7KE4wJKN4A5e5ea8qaTRIm4d
 0UfFgT/gd1hkyMMwXmoHyALkkf8sE5Z79vmhdBP755hBmo8uB2CsCaO4C9eIQa0nYrxU52V3Vvm
 /z2hGlZijhSQ/Bpagfhc7rk1PdarOhF0sq774ChlYg/RLbgSO0Xbbr4ZjTJE2nl8AV1fv/a2r9v NncP4pCJ9YX4M9A==
X-Mailer: b4 0.14.2
Message-ID: <20250321-vec-methods-v2-4-6d9c8a4634cb@google.com>
Subject: [PATCH v2 4/7] rust: alloc: add Vec::drain_all
From: Alice Ryhl <aliceryhl@google.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Matthew Maurer <mmaurer@google.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Alice Ryhl <aliceryhl@google.com>, 
	Benno Lossin <benno.lossin@proton.me>
Content-Type: text/plain; charset="utf-8"

This is like the stdlib method drain, except that it's hard-coded to use
the entire vector's range. Rust Binder uses it in the range allocator to
take ownership of everything in a vector in a case where reusing the
vector is desirable.

Implementing `DrainAll` in terms of `slice::IterMut` lets us reuse some
nice optimizations in core for the case where T is a ZST.

Reviewed-by: Benno Lossin <benno.lossin@proton.me>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/kernel/alloc/kvec.rs | 57 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/rust/kernel/alloc/kvec.rs b/rust/kernel/alloc/kvec.rs
index c9de619466eed1590fda039a291207100729a96a..d16360c3156b9bb4fc57cddcfd076adb70abd3c9 100644
--- a/rust/kernel/alloc/kvec.rs
+++ b/rust/kernel/alloc/kvec.rs
@@ -562,6 +562,30 @@ pub fn truncate(&mut self, len: usize) {
         //   len, therefore we have exclusive access to [`new_len`, `old_len`)
         unsafe { ptr::drop_in_place(ptr) };
     }
+
+    /// Takes ownership of all items in this vector without consuming the allocation.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// let mut v = kernel::kvec![0, 1, 2, 3]?;
+    ///
+    /// for (i, j) in v.drain_all().enumerate() {
+    ///     assert_eq!(i, j);
+    /// }
+    ///
+    /// assert!(v.capacity() >= 4);
+    /// ```
+    pub fn drain_all(&mut self) -> DrainAll<'_, T> {
+        let len = self.len();
+        // SAFETY: The first 0 elements are valid.
+        self.set_len(0);
+        // INVARIANT: The first `len` elements of the spare capacity are valid values, and as we
+        // just set the length to zero, we may transfer ownership to the `DrainAll` object.
+        DrainAll {
+            elements: self.spare_capacity_mut()[..len].iter_mut(),
+        }
+    }
 }
 
 impl<T: Clone, A: Allocator> Vec<T, A> {
@@ -1047,3 +1071,36 @@ fn into_iter(self) -> Self::IntoIter {
         }
     }
 }
+
+/// An iterator that owns all items in a vector, but does not own its allocation.
+///
+/// # Invariants
+///
+/// Every `&mut MaybeUninit<T>` returned by the iterator contains a valid `T` owned by this
+/// `DrainAll`.
+pub struct DrainAll<'vec, T> {
+    elements: slice::IterMut<'vec, MaybeUninit<T>>,
+}
+
+impl<'vec, T> Iterator for DrainAll<'vec, T> {
+    type Item = T;
+
+    fn next(&mut self) -> Option<T> {
+        let elem = self.elements.next()?;
+        // SAFETY: By the type invariants, we may take ownership of the value in this
+        // `MaybeUninit<T>`.
+        Some(unsafe { elem.assume_init_read() })
+    }
+
+    fn size_hint(&self) -> (usize, Option<usize>) {
+        self.elements.size_hint()
+    }
+}
+
+impl<'vec, T> Drop for DrainAll<'vec, T> {
+    fn drop(&mut self) {
+        if core::mem::needs_drop::<T>() {
+            while self.next().is_some() {}
+        }
+    }
+}

-- 
2.49.0.395.g12beb8f557-goog


