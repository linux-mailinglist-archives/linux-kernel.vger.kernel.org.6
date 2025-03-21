Return-Path: <linux-kernel+bounces-571203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B952A6BA58
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 13:11:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CDEC4A0720
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 12:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2012822B8A5;
	Fri, 21 Mar 2025 12:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wEI9knt6"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A385F22ACFA
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 12:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742559036; cv=none; b=Og4GAG0xy5jnw1xO8wP/YdKosa8sAeOQvVdjJViwmoXlyaFiqwe0XazwCIXh0asRNQJasLMbPCKwkqlhmf1XAQmxhY6QA1FSs5QvrqORora7mrfka67+cLL+/Zq7IZaiOoue074swHfQOGon8iM/iWEzLhQtW/UKf90S/kJfJAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742559036; c=relaxed/simple;
	bh=hADnINVDNiY5Q5VJ37thqPwwLyvHazWkF4CZ6mUuFfI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=oIhAigWy0q4+Oy04eyU+5lG0yDu8qpqTcekv9wvPaiYGonCqodl7Eti9pgjTQCV2pA6JclThk+y62nhDkr5+KjelXySik5uXqNOoHDRzEKAlC5mrhLfOA8nn9RZ7YIkwSUREvqv3LltofvdVIV7ItHe3Qm82GKnafn1xoWrkQ+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wEI9knt6; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-43cec217977so12198585e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 05:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742559033; x=1743163833; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=m/gG0yWCnHb2fPyeO8ul+ISu228ga/KBnWNJmMzlw2k=;
        b=wEI9knt6t5ypzQQIFRLFtbA3GfZMmTIx/Ums9PDa6cbbfAeAvW5vpdwvNKAOffGICs
         3fFXtatf4YHzIOZOMxMWvnpLhHrhRYwrAu+b8IuYJDEpvA91ib5w/DxIBMmSvwfJM9zT
         MkJj7W28XqWY+UXgSAUhEl+TF4ZespVqlDsIeQwAVLPJSFV9akmsAEzv2fqc0Z+FokmL
         tD0Es4UjXu2R0qYPD6G05qpqsJAViMCGdNYKby7o+Uz5pHugUiHWz+mYVTE7DtxdjjA1
         7ZmLsG9+lJ2pxrBn1V+nDZgcPsBvzwWwNbwN7i8e3sc5QwT+51FM2xlwwBFMhRvpmXlR
         xgZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742559033; x=1743163833;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m/gG0yWCnHb2fPyeO8ul+ISu228ga/KBnWNJmMzlw2k=;
        b=anuIMOXIMfAZACNVZO7JDGy19beRD+RVNgWmiPZrFH5mHfuVp89tSiWK71J406FfHf
         QSkgxqy0QenX2hOhlhOyzGn49i+njq+FHvrxZVFhMNg30hAC2lE+Mt/c5Y33yU1LUCkz
         NsFIqjtiRzEbx0zq56E+3UpmMR5DxQz4k3Y3UtSU9KKwkd0R9ON+wCHnpXOhAUB6/eKr
         /McKY+ZOjlYeLubqoLrclGWb5Ybn/HrAk1KQC883wEQKBnigRzSL2pdH3beVEH543XTV
         ZDchsV1+Y6gfUcThHmE3G0j3hUvqp6A5+N85OTu45vhXGV2WCCluLed4serCq26ZfWmK
         HnQQ==
X-Forwarded-Encrypted: i=1; AJvYcCVEQWEjVFEB2eKsVRXqxZayXOQzlvsacpDXCtdk8vMVLwYuTa0IqZfV3CqpT4jcQx88e6Pac2RwL22dLOU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTZvzFNmmpmEjtqWfOO9iaavgmS7nbIz1bz344yrALY/S2JQ1Q
	hlReJ7Z5ocTwRaLiZF/kvEmywXwMjhdBav1RzzdUkU1h1O2yqhCIrk4UD3/OzCpLCZwEbAyJExz
	1vU82anhziUR9uw==
X-Google-Smtp-Source: AGHT+IHASaQPvbkiZRRrsAAJjN6hUNe+sQmf56CNTZ+8mw9tQbEFetUBGO3Z65CQRzZ2NQLtxKQjhg1dhv6RtZg=
X-Received: from wmqa14.prod.google.com ([2002:a05:600c:348e:b0:43c:ebbe:4bce])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1d8f:b0:43d:bb9:ad00 with SMTP id 5b1f17b1804b1-43d509f5650mr28824525e9.15.1742559032986;
 Fri, 21 Mar 2025 05:10:32 -0700 (PDT)
Date: Fri, 21 Mar 2025 12:10:00 +0000
In-Reply-To: <20250321-vec-methods-v2-0-6d9c8a4634cb@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250321-vec-methods-v2-0-6d9c8a4634cb@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=3038; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=hADnINVDNiY5Q5VJ37thqPwwLyvHazWkF4CZ6mUuFfI=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBn3VcoFlnD/akIF8WDUZTaYNYUbSOvCYtzimgXI
 4q4bz9fnVGJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZ91XKAAKCRAEWL7uWMY5
 Rg4pD/wO2FhIXrVpiDNLmIt9cPLJvSdHY8rI/2AEeZGrHnxylYPaMQn31Bi/qIrwcgIsSwGTRFn
 okkhkgdd5sBfm+6i/2o8VBI1w8U5xjH7fzhFPyw5EFkjR79fesAxq2Yyhb5e1HUl5LI1Hjwcaxt
 4hdIEpnUlWXP1XWGcEtU4/0uIYIQ7KZqY40t8MtJp0yo1ze7IGZElgufEiNwOT/MR9qtOLzbxYW
 dNjyrdO1AuNDkRCb3LltUOl0vvsFfaI3i4YqYXbIR6JvMBW/pW4m+T9HNsvt6JdDErl9/FUa5B8
 4L0odGz0GKe4WV6zLx4kXBX6ivyoqjyPSYCIZZ/5F/oN+EN8Q/BEgjmYBXM1HmvDC3BgoT6P5T6
 GbvA1MMlQGLw0ERLKqLyroel36uEOZZghlCCzNlIkHxr/skWc6eCcNwbvyAjF5xcCwkNRNNUOl5
 ihWf4VujOcucZSevYFuOvwWiURYHah+SP0ObhKGgL08J9mkYDsm7Fc07rh6E0noE56XYOPiBN3B
 omezUSh4/BVPGK8E4Xld6ZRDwEWizN26X5Yx/rcQ0oXr48y9aSckvN+5LxlyMQB5E64C/PA7KmL
 eEbD18eZqOiQ7Gy1NGn04r4oTwAh/clUZTVlvPvKSHUwYggj/4iEmaEJTjtc0plXAqIyx+ectvb LvTlJiT/vVMMToA==
X-Mailer: b4 0.14.2
Message-ID: <20250321-vec-methods-v2-5-6d9c8a4634cb@google.com>
Subject: [PATCH v2 5/7] rust: alloc: add Vec::retain
From: Alice Ryhl <aliceryhl@google.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Matthew Maurer <mmaurer@google.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="utf-8"

This adds a common Vec method called `retain` that removes all elements
that don't match a certain condition. Rust Binder uses it to find all
processes that match a given pid.

The stdlib retain method takes &T rather than &mut T and has a separate
retain_mut for the &mut T case. However, this is considered an API
mistake that can't be fixed now due to backwards compatibility. There's
no reason for us to repeat that mistake.

To verify the correctness of this implementation, you may run the
following program in userspace:

    fn retain<T>(vec: &mut Vec<T>, f: impl Fn(&T) -> bool) {
        let mut num_kept = 0;
        let mut next_to_check = 0;
        while let Some(to_check) = vec.get_mut(next_to_check) {
            if f(to_check) {
                vec.swap(num_kept, next_to_check);
                num_kept += 1;
            }
            next_to_check += 1;
        }
        vec.truncate(num_kept);
    }

    fn verify(c: &[bool]) {
        let mut vec1: Vec<usize> = (0..c.len()).collect();
        let mut vec2: Vec<usize> = (0..c.len()).collect();

        vec1.retain(|i| c[*i]);
        retain(&mut vec2, |i| c[*i]);

        assert_eq!(vec1, vec2);
    }

    // Used to loop through all 2^n bit vectors.
    fn add(value: &mut [bool]) -> bool {
        let mut carry = true;
        for v in value {
            let new_v = carry != *v;
            carry = carry && *v;
            *v = new_v;
        }
        carry
    }

    fn main() {
        for len in 0..10 {
            let mut retain = vec![false; len];
            while !add(&mut retain) {
                verify(&retain);
            }
        }
        println!("ok!");
    }

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/kernel/alloc/kvec.rs | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/rust/kernel/alloc/kvec.rs b/rust/kernel/alloc/kvec.rs
index d16360c3156b9bb4fc57cddcfd076adb70abd3c9..866369406ea95e68adea366828552e76e451e24f 100644
--- a/rust/kernel/alloc/kvec.rs
+++ b/rust/kernel/alloc/kvec.rs
@@ -586,6 +586,28 @@ pub fn drain_all(&mut self) -> DrainAll<'_, T> {
             elements: self.spare_capacity_mut()[..len].iter_mut(),
         }
     }
+
+    /// Removes all elements that don't match the provided closure.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// let mut v = kernel::kvec![1, 2, 3, 4]?;
+    /// v.retain(|i| i % 2 == 0);
+    /// assert_eq!(v, [2, 4]);
+    /// ```
+    pub fn retain(&mut self, mut f: impl FnMut(&mut T) -> bool) {
+        let mut num_kept = 0;
+        let mut next_to_check = 0;
+        while let Some(to_check) = self.get_mut(next_to_check) {
+            if f(to_check) {
+                self.swap(num_kept, next_to_check);
+                num_kept += 1;
+            }
+            next_to_check += 1;
+        }
+        self.truncate(num_kept);
+    }
 }
 
 impl<T: Clone, A: Allocator> Vec<T, A> {

-- 
2.49.0.395.g12beb8f557-goog


