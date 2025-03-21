Return-Path: <linux-kernel+bounces-571200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B94A9A6BA55
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 13:11:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 024C73B9A2E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 12:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6EBE228C9D;
	Fri, 21 Mar 2025 12:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cPgKZ/yE"
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 547EF226CE4
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 12:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742559030; cv=none; b=f5CPfkBykbcsyq1Zm5WHad1RiWN5e/8r310amXkNfC2HOWiepJgEXKUr+BaKvW3ezf3vIBTMvLkBmXFUEYGZWmfYxuHMYQXRqi9eC77p7K37wx8jDa+HU1ky5EAtTunYtpFtBB+SC0lwhpHOVXjPxC+6hjV0bGctX9C6Hvi9OzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742559030; c=relaxed/simple;
	bh=TulV6My3X/Pv7lQZ0jbzI/s+3T91OC+LBGsc12t3AUM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bdAK7y3KxSi+oNLVrm2N2+C5PmDQG93Drz+7gp3UJm19JPANTv/5xu/5tF8kxCbKkng2pN7IEZF1eGNhuVG7vv0c51s5WAeCQnkZFqFS+QYw3eqlzFT1zuh72f9I1knahFYMs+2OegcIS38TIpHxIVs0EiTLEce4q74fXOh8saE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cPgKZ/yE; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-39141ffa913so976610f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 05:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742559026; x=1743163826; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=mQmdkift3Su0uIdxp4srCVh0Efk/lmcsN2cxpYCwzDI=;
        b=cPgKZ/yEL+fYdDaJgLLFj+a+5exQh2DIrspEzHjQt2tOtE2yRJ0q4bhhwGG/D+jKYE
         uIuRTfB53QIvCvGVlSpxjZ8Aim0UKw7VvWnrPTbSTbbgMBFE4jA8PAiSIpkJNisOKU4D
         Lzj8k6QQbGW8jnQsd7BDE1JT2yXIE/e4E+xOBXrzwl60jNiCnKVMyKAYJWmHxYOJne0m
         QAzzmHeJ9w9KI/YR046QbRV7924A/5Va6Tm0t4y8kZfGZMiHqlE6L4J1r1eXYzlNpLsV
         mdG0eNmkZSX6JFPvtiSnZxICWovKCsjFbOdDdzKs3g0bPPDYth2PFvUS+J0wAABcd6Mb
         XS5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742559026; x=1743163826;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mQmdkift3Su0uIdxp4srCVh0Efk/lmcsN2cxpYCwzDI=;
        b=AN9NYh4rfSF42SHRp+6z/MeDLfShr1ahENpUc0vcfa+IDmwSw7SapRSZcTlhM6Zs1e
         S+nICm2sS6RrqOCu2z3/cvTeqs1MFiO6M0o5fftZXAcYhzT3DZAGl/06VykIgXsA+Cg/
         GlXau59TlOusHLcFo/v0/jb7OHZYbFjhj623jNopUh1Z/HhD5vDcMaTojKceAKg/iylE
         ofcOKGyMLdTtmtmsnCu1Fhdr7g2S6pc1Vs87DNtxDhjD2beaOtuyMkQYVAafuN/7bc7D
         hEiSQ5GTUNPK9/T6GMi/X3G0hAB2BCdKfkwVfcFrfMiDTGq5zKm5S+CPETg2W7xcGIWJ
         cM6A==
X-Forwarded-Encrypted: i=1; AJvYcCUiEyGQTAQLoOGq2qGkgfJO1ERW3wLG6LKLhLlAQFBxu2QkawKzgQpqX+RYA7LQKiZA4Ml2nqtfwYeDITU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0oEYgrprV7lGRofCTjklH6qjDnmL7TKK3X7f/hwr+JzBw3uBc
	//NOTqyuOd7YVKtktG2fYyELcrv7GgmhMHdjGm/QmlwrugiGCV8ng4qWjVKWl5k0vmpPpVYTKWx
	UGiZBArQK0FFPAA==
X-Google-Smtp-Source: AGHT+IH8Dfv+WZcG9sSAF+pG+9WzdD7a2AlCaDbBDGJDmMjPJZo+A4V8E4Z1Q47z5HJ0WzxWWDOCbn14ESFYpmM=
X-Received: from wmbfl10.prod.google.com ([2002:a05:600c:b8a:b0:43c:f122:1874])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:2cd:b0:391:412b:e22b with SMTP id ffacd0b85a97d-3997f903a95mr3381007f8f.18.1742559026780;
 Fri, 21 Mar 2025 05:10:26 -0700 (PDT)
Date: Fri, 21 Mar 2025 12:09:57 +0000
In-Reply-To: <20250321-vec-methods-v2-0-6d9c8a4634cb@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250321-vec-methods-v2-0-6d9c8a4634cb@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=1934; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=TulV6My3X/Pv7lQZ0jbzI/s+3T91OC+LBGsc12t3AUM=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBn3VcmhoW3khohXPFzA6QonRmk0NHq6nP8ON96Q
 kADkcTEEZWJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZ91XJgAKCRAEWL7uWMY5
 RtpSD/9+sKJQlgNeJ9Yp5YwX7uyovPbbm1lkOL8QzsWVlezWA8jAxhtPtrhySh6VSLkTd+4DQbt
 g2NspHynxWyiV+O8KMNRjccfXs/dA3XDIJPQ0cjPjfSM2MfsHi36xiaWXf2uljpaArxkVp44SI6
 eWS2dBoSi9m+P8084KZ+yQQ/HOxa1GpLjM+PiAJttvJXGNSKHDBIn7aRUB6T8mRVpeWo7cu0ZCp
 XQsYIlVks9/IENzEbY4qfxYAXlSudkTZYMt2nc6SS5K+qtTAJFm8F+/iB+KZ2RC26ojhoxP5kqW
 I/dBiWCVIxo6aUlkl4CWjx0ehgu8lWUs/GsXhyMWqcl3sSeImVYowwtVI/t5b/vlSdELcSBb1Ma
 s7UfU0TCy2f2SQk7SJpWTzu9+HzqulXefre8HnaF3EmOlk57Zc2nw0d/UF0AC2F+DDdAAeRnRup
 a5Nxl6VsfU+0jvP2GrSl8yML002eiTssCYEFX5UgTnEh+mAWoUmTTEbvt3UgiMyJXMO3Dx9t9EF
 4FnUWAvMQSXFT5CkJXDOwoxjuEBPsLmZthLtUoh1FTV+5pjlMJ1XeqIyEludXxjEgcnM2GJQtA+
 cTSepSzyyb2EEKmVsraebFeoQhw6hHSiSR4nBPHFo/1poMsa6aIHTMVBjCKA+ZPZhl3l06lTGx1 jupHjO3Ezqb7Hfw==
X-Mailer: b4 0.14.2
Message-ID: <20250321-vec-methods-v2-2-6d9c8a4634cb@google.com>
Subject: [PATCH v2 2/7] rust: alloc: add Vec::pop
From: Alice Ryhl <aliceryhl@google.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Matthew Maurer <mmaurer@google.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="utf-8"

This introduces a basic method that our custom Vec is missing. I expect
that it will be used in many places, but at the time of writing, Rust
Binder has six calls to Vec::pop.

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/kernel/alloc/kvec.rs | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/rust/kernel/alloc/kvec.rs b/rust/kernel/alloc/kvec.rs
index 95e752ed27395fce72d372976b74fb1b0e957194..e42c5c40c992c796409505da70975f970524fc24 100644
--- a/rust/kernel/alloc/kvec.rs
+++ b/rust/kernel/alloc/kvec.rs
@@ -302,6 +302,35 @@ pub fn push(&mut self, v: T, flags: Flags) -> Result<(), AllocError> {
         Ok(())
     }
 
+    /// Removes the last element from a vector and returns it, or `None` if it is empty.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// let mut v = KVec::new();
+    /// v.push(1, GFP_KERNEL)?;
+    /// v.push(2, GFP_KERNEL)?;
+    /// assert_eq!(&v, &[1, 2]);
+    ///
+    /// assert_eq!(v.pop(), Some(2));
+    /// assert_eq!(v.pop(), Some(1));
+    /// assert_eq!(v.pop(), None);
+    /// # Ok::<(), Error>(())
+    /// ```
+    pub fn pop(&mut self) -> Option<T> {
+        let len_sub_1 = self.len.checked_sub(1)?;
+
+        // SAFETY: If the first `len` elements are valid, then the first `len - 1` elements are
+        // valid.
+        self.set_len(len_sub_1);
+
+        // This invalidates a value in this vector's allocation, but the Vec invariants do not
+        // require it to be valid because `self.len <= len_sub_1`.
+        // SAFETY: Since `len_sub_1` is less than the value `self.len` had at the beginning of
+        // `pop`, this index holds a valid value.
+        Some(unsafe { self.as_mut_ptr().add(len_sub_1).read() })
+    }
+
     /// Creates a new [`Vec`] instance with at least the given capacity.
     ///
     /// # Examples

-- 
2.49.0.395.g12beb8f557-goog


