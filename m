Return-Path: <linux-kernel+bounces-571204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B322A6BA5A
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 13:12:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B15323B998A
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 12:11:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A0C022B8D5;
	Fri, 21 Mar 2025 12:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Wm3UCpH+"
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C973022B5A8
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 12:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742559038; cv=none; b=rTvg/st94OZdAgPdEYLglI9AUUsNQgydU1M1u7xooQthZm+yVXcMpPK5451BJiHiliZDFQy8p75JIGIWAfLWu7FnlY9IsMoKC8xuZj4BBQFIz0araKILKBICSBbWc5sB/mfK1ehSNt1NhM3LRMfEtUE0X+jxkiE3CY/zgl7eOzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742559038; c=relaxed/simple;
	bh=3oJRcVdI0f2kepdQ6XQpwMxZNqeOsXeu5B+vRxaad7o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=aqYxJt1qBAVv8vCsmLVZfPnZFEaawRfdM6anpS7fxzbM9oFZYaNJa4/ECZPVlU3WMCT1lYQBJHiAiWgz4bLSMySMrfTUT6sD2eI/yxyk6q7Md2rpAWK+c0CNtk6cp0ijBkPAk27vp1bYO0csjCuSTpqiGAakultIHnVRu9qF9xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Wm3UCpH+; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-391459c0395so941079f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 05:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742559035; x=1743163835; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4ouy1jhMCEvTEa8eqKCvY5GbK3OhWh50uVrS/szpeMA=;
        b=Wm3UCpH+tbnbG28e/SPsRPGOp4pOs0b63MffiXDC83Fjnylco0FMglbXKL/iWXLwiz
         HLgawuEoAI6VpYj2XM2e6J5Jijv6yB7DLOOwkxy+F2wt/mBWvw70IDyRnbaQderuXtrM
         3O1RqMvNAGT/k/QOGfCTsp/krYga1Qfd5vXaaw7nAsCNfoQGSDLSnIfsdivALOTQsMRn
         7yPUE7uOg0DBF4Ao42fXildwTIC0PAa0dmBqbLQhDInhCokXk5BBAoUi5klWRcxU8BI7
         NgLg3Kn0UpSwn1RvSpjlUCA8ghGxSf2MSNU60IcIVhu8nPa6HMUawhO630kH/bnv3UC6
         E+1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742559035; x=1743163835;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4ouy1jhMCEvTEa8eqKCvY5GbK3OhWh50uVrS/szpeMA=;
        b=pyjnZf6I9yj2VR9D3Z2TTXgCImFqFELFY6jsq/qA55vmpV6HbOg8f8qbYg6jXfEutu
         Sflhcnb+eSl1K8YMVpsjkrZJ7OCqHbtJONQHxfgwzrzlcv4SYW0dSRfvIyLOgFk8P/K7
         EPwtr+49xnNkh9HhpBxXvOfaDTU+Y4DLAd23iDOr6/DD7B25mTqoKctiRfBS+RWa0iYB
         025eDsFE1LFFvAhIguGo2VoHMqYLmfyjSkShzlP7gKmhMBK64Wbmcgpas5z/fKRan2oo
         zDnjNEBrBw5kSiwtyLAnhsXyRifQpRlziUcP1NZcCdIWSQz1P9gAcVH4IdOpvPC1jjLz
         4+Fg==
X-Forwarded-Encrypted: i=1; AJvYcCUg9PzBQFHbk7/NPXv22fzX6dHVKybrR+hRrFAi/3KkEi7ODaGJ17zPmjIN5FxOEEZHNbboqqrnf64FHfI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaGEO5KwPtTO/AmMQc0GY9mAqOpxcmJdaoFHHMIexW3eHLBR7b
	t2LY42b1SeMkpNZB36dxytocIWzp3fgv7T7ABX7IxZFD1qihFbkVz33miw387vlF6CgJdAatSsm
	+8qQZXj1xAds2Hw==
X-Google-Smtp-Source: AGHT+IFfkEvFvZCRq2yLE0H25Zi0Vl92qMU4ckTbkdDV45pE7Gz8I7/U9otzQj1IcHMd9eaM7Yw9eh8l9lcm4T4=
X-Received: from wrbeh2.prod.google.com ([2002:a05:6000:4102:b0:399:7520:4538])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:156b:b0:391:3173:4fa2 with SMTP id ffacd0b85a97d-3997f90087emr2770824f8f.5.1742559035065;
 Fri, 21 Mar 2025 05:10:35 -0700 (PDT)
Date: Fri, 21 Mar 2025 12:10:01 +0000
In-Reply-To: <20250321-vec-methods-v2-0-6d9c8a4634cb@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250321-vec-methods-v2-0-6d9c8a4634cb@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=2035; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=3oJRcVdI0f2kepdQ6XQpwMxZNqeOsXeu5B+vRxaad7o=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBn3VcpMwUpKhnEtgIC8iBlUga4gWy7cNLTEDy9Z
 OvolKJUy9WJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZ91XKQAKCRAEWL7uWMY5
 RvLRD/0QxMH8jzWbipTt48i98CYPdCN6V72hLZVOpyXnEb9uPNF7lyyFlGe+DfpAUsZOhNcubbz
 caoeYr+PfBMWib8N8YiM/go8qaJjZbXVg2kQALtfozhjben/46ayX8VjHMQ/UDcnk/CsHfbi0CL
 bBRIO2r8XzUS0DLbCIuxf7TMQ07l1SCJgvboiADcnFGjkWWr+08RaRssIs3QaLx79VVqllmi7IT
 ZsVW24CXjdtpOjZG3T4md3bFi/sTElZELP0ffBHs39GlKeFeGmf54rO9A77Ctnoy6sovSMpR5oQ
 /ulp5Vzy9eUejmNL5ClNLpJIVAaGtKmEfNpRe57rlvA5sOY/6mH+Fe7W34yQN8Qzc17t9cNIk7T
 unPNyaJckgRKfL5P0cVhXFnmW6RyAJZ4GWG3sA9rsRdw0MGdrQ3+cqFpABN2xkW2RB/Z1IjoczO
 1pYdqRxFrZjmMHsDqE08At94PROGbI+6icVpvU2A6EabxmeQsTDCc8BiHJ/DuTFCITs9gxhvZl5
 5udvrDTrdtbfQRg5vXSDJm0Y1zcQOdFrTI2vFy8kHw8gQmVOu/hsvlmG+NK2IBF4v+QPgUXSqAt
 4S+FgBORo2Ael0pw2EeV+KuXO6cTjZvnCW92C0K93JnnbJcJNhFdtmkys4aWu1X1prO0Qa9GkIM lq2yYfLXLf2W45w==
X-Mailer: b4 0.14.2
Message-ID: <20250321-vec-methods-v2-6-6d9c8a4634cb@google.com>
Subject: [PATCH v2 6/7] rust: alloc: add Vec::remove
From: Alice Ryhl <aliceryhl@google.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Matthew Maurer <mmaurer@google.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="utf-8"

This is needed by Rust Binder in the range allocator, and by upcoming
GPU drivers during firmware initialization.

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/kernel/alloc/kvec.rs | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/rust/kernel/alloc/kvec.rs b/rust/kernel/alloc/kvec.rs
index 866369406ea95e68adea366828552e76e451e24f..f7f7f9c650f8167ad6f53b0d83e328203445aa1f 100644
--- a/rust/kernel/alloc/kvec.rs
+++ b/rust/kernel/alloc/kvec.rs
@@ -356,6 +356,34 @@ pub fn pop(&mut self) -> Option<T> {
         Some(unsafe { self.as_mut_ptr().add(len_sub_1).read() })
     }
 
+    /// Removes the element at the given index.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// let mut v = kernel::kvec![1, 2, 3]?;
+    /// assert_eq!(v.remove(1), 2);
+    /// assert_eq!(v, [1, 3]);
+    /// # Ok::<(), Error>(())
+    /// ```
+    pub fn remove(&mut self, i: idx) -> T {
+        // INVARIANT: This breaks the invariants by invalidating the value at index `i`, but we
+        // restore the invariants below.
+        // SAFETY: Since `&self[i]` did not result in a panic, the value at index `i` is valid.
+        let value = unsafe { ptr::read(&self[i]) };
+
+        // SAFETY: We checked that `i` is in-bounds.
+        let p = unsafe { self.as_mut_ptr().add(i) };
+        // INVARIANT: The invariants are still broken, but now the invalid value is the last
+        // element of the vector.
+        // SAFETY: `p.add(1).add(self.len - i - 1)` is `i+1+len-i-1 == len` elements after the
+        // beginning of the vector, so this is in-bounds of the vector.
+        unsafe { ptr::copy(p.add(1), p, self.len - i - 1) };
+        // INVARIANT: This restores the invariants since the invalid element no longer needs to be
+        // valid.
+        self.len = self.len - 1;
+    }
+
     /// Creates a new [`Vec`] instance with at least the given capacity.
     ///
     /// # Examples

-- 
2.49.0.395.g12beb8f557-goog


