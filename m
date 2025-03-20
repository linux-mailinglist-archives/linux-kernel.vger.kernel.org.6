Return-Path: <linux-kernel+bounces-569803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27834A6A7B9
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 14:57:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E7103B6F1B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 13:54:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87621224B07;
	Thu, 20 Mar 2025 13:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KtQg/PjO"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37B8F224231
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 13:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742478811; cv=none; b=I/Fyb1TeWgOdWqpGp4kMKfzsCWka82ZCKztD9GoHl/wWyQg1qfpLtBm8hHwtCVD2WwqLGJdBeHnbahBp8YoZ33ojRyhwsOd91x2ukKV9+ai7rhOI0h++qV4UZP29LjGpxQMG/4GzFGPq8K8O3QL7JPf4jlt351An1ZKsUEmD4QI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742478811; c=relaxed/simple;
	bh=oq9udGuCcSsMEvbqP89aogF1VgUZC37t/ErsD/OVHrw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qJSzKmmwW/QN5OEDz1QLgfyZEDmE7fp0nqtHwgpjNds/P8L4nLWhDZZZuMLrldOdq3ul4ZjYUptMNBN2gs0SugyMDVzzf1TRjGET823rvpB1XwmmNniEz9rM6xzp5EYYdMmE/ZmQP9uFXu95rUJcHqQAriXYaYCDJBmW0N8qZtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KtQg/PjO; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-43cf3168b87so4468435e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 06:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742478808; x=1743083608; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7M2VtU5PPRczkAaCd/oYdvo4gCCR2tO6CUbKZTZQCTA=;
        b=KtQg/PjODm+GRQCjBwAyblXK0jChVnfFTEo1CJE+6lZZDL+HojJGzaQ59d9s9ENrBI
         vh8zgDZJwRDRVZAb5JMnVfruog3k8/k6bGt75MwT7UWpmkXKhth0HPFO8g4BJtpLmQT8
         1NHi1Y00IYHOA2sUU6CuQl2oWTdZ4uBrMJaT3CGzwrSHhVsflPClezI0IwpTaaFATwdv
         eFw77TleLkznXvQ+I2GITSrka3g1+bWNSbNifseUlUkaBAgdmMWokgf0a4MYf2bhrg5U
         pOBNVHFEHpB0fL4ZTqCx/wcuKJoMzzrQh/7WWxzAWz7pmuZGXPVynaqdFlAkDYyXEuIu
         0Q1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742478808; x=1743083608;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7M2VtU5PPRczkAaCd/oYdvo4gCCR2tO6CUbKZTZQCTA=;
        b=oGMfuZo5JWbHSBIBWQ0wi3fxYtepxfIbYMly1ZPhU5l4bcm8DIVPG6yeIQeSOXoTWt
         V4KqErvJj3sc6Wgq/NwFwZ4HgCQubqmXpa+RCOJwh8xXe34C/RfdDTPg1BkxLXALHk0w
         xfL2dAM6ZRRdeXbcbMGbSrlMODTk2/PbOHhCOJ/utqF3AgQ7bj/N+XGniNYabKFffDJx
         1EKDg+7VdSjnr/L8qYLeqh8D6d0E3ey9ngU9lPW5Lb4pVPvq0aKWhDjDVpEjGEdgLPnk
         se+cvG5OpG3gEYcVnw5llTEzAdxHlSEjt2Lpg2KmiTOIFzTlJSiCoAyeaM92rYlxU9ba
         cFCQ==
X-Forwarded-Encrypted: i=1; AJvYcCV4M08yS0lt2gPfS16clj8JufGaVt1iLOrCY+uYDwN1PVtzo8Nnjhn3u3Xv2GEtW99EmZorgyaWZ7sb5gw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5sC7JigKoqZCHidLjTP2SRu2QlE1adncsPuAwftcgLxNpnP3t
	qi2CI1IxrcmAwRRTkJpUIJsN5JzUflj9T2v2BllJLwFKaXVJ1q03LbtMLKqyXg/2Ra2TcbxppWT
	XqpwXwubQ9RjRiQ==
X-Google-Smtp-Source: AGHT+IEHBEzOJAPJ5ezuipJ3siAvbyjFeXNO5sAc0d3iTiI/rmXTEivVMWgnRI+74eXAZJm34UhpBQMONlmhSYY=
X-Received: from wmbep16.prod.google.com ([2002:a05:600c:8410:b0:43c:eaf6:525e])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4e44:b0:43c:f4b3:b094 with SMTP id 5b1f17b1804b1-43d4378041cmr72309735e9.6.1742478808680;
 Thu, 20 Mar 2025 06:53:28 -0700 (PDT)
Date: Thu, 20 Mar 2025 13:52:58 +0000
In-Reply-To: <20250320-vec-methods-v1-0-7dff5cf25fe8@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250320-vec-methods-v1-0-7dff5cf25fe8@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=1917; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=oq9udGuCcSsMEvbqP89aogF1VgUZC37t/ErsD/OVHrw=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBn3B3NFeE1Ogr3RQZHN9/v7DaROFK5k4mpOMKCD
 1Bd7vq5b1SJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZ9wdzQAKCRAEWL7uWMY5
 RgB6D/0WkW5RJz0jjMuXX3XTipgrz//n0nnWXy+rkrG5AGwSDuVf3M4Pio0sjmwpUUIw1uWFewq
 FCeIWWqhvI1k8xFxhXzkGXobRcV2V7agTcSuheKZwR5cIHu4zTBdu4ixma4xl+PrH9PpNptnnbx
 cjKzDQeS4Tuc6Cp2tdcsz9DG+Gpy38V0184/y2k3RFf8RCvWaFUN1FVNeSN53SI9QOVImcyL8CD
 5P6MuQkgyaVRCDU3F9gQzJ79VDNbxCRPdKTHzoAGoW+9I4LQX0Up+qUORWONQNaZ4nT0nAKnY6B
 z5JcOXwELHaNMqCoiy7xPr85LYgJ4DHuqXp+WOJP4aBgwoUlVA4bkSx9TpMf3BJmaYfrRTPpnpu
 Ji7jw+sjx+UddZ7X7J6lCfrJTYEm2QHQvAtvFh7bBTjI+aeMV9syMuii0aUXkgsxPCSP91Nh4xI
 uokdy/KAnkk1Shz4V6+Gr+870N9TQx414tLvmduVix5D9q2xYEvyxEaOgZduvIvhHBiW+8mYJ9W
 YbiX+p4ZII5fHHxZErqUrje8kXdgDeRRFIkuN8FJHWfsrRF3kCUwQphuQpbRlBCLm0MrrYD4bur
 bj7mHFHm1rNBaqvWJIwMV62lrKw4z/bsJlH1gpHzsl6uFalCYCpMKc4saFWoFaep/YQenO8dZmx v6y+Oy7M5/gyWVw==
X-Mailer: b4 0.14.2
Message-ID: <20250320-vec-methods-v1-3-7dff5cf25fe8@google.com>
Subject: [PATCH 3/5] rust: alloc: add Vec::push_within_capacity
From: Alice Ryhl <aliceryhl@google.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="utf-8"

This introduces a new method called `push_within_capacity` for appending
to a vector without attempting to allocate if the capacity is full. Rust
Binder will use this in various places to safely push to a vector while
holding a spinlock.

The existing Vec::push method is reimplemented in terms of the new
method.

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/kernel/alloc/kvec.rs | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/rust/kernel/alloc/kvec.rs b/rust/kernel/alloc/kvec.rs
index 9943358c70aa63f5ad7ed9782cb8879d7a80a8fb..df930ff0d0b85b8b03c9b7932a2b31dfb62612ed 100644
--- a/rust/kernel/alloc/kvec.rs
+++ b/rust/kernel/alloc/kvec.rs
@@ -284,6 +284,31 @@ pub fn spare_capacity_mut(&mut self) -> &mut [MaybeUninit<T>] {
     /// ```
     pub fn push(&mut self, v: T, flags: Flags) -> Result<(), AllocError> {
         self.reserve(1, flags)?;
+        let err = self.push_within_capacity(v);
+        // SAFETY: The call to `reserve` was successful, so `push_within_capacity` cannot fail.
+        unsafe { err.unwrap_unchecked() };
+        Ok(())
+    }
+
+    /// Appends an element to the back of the [`Vec`] instance.
+    ///
+    /// Fails if the vector does not have capacity for the new element.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// let mut v = KVec::with_capacity(10, GFP_KERNEL);
+    /// for i in 0..10 {
+    ///     v.push_within_capacity(i).unwrap();
+    /// }
+    ///
+    /// assert!(v.push_within_capacity(11).is_err());
+    /// # Ok::<(), Error>(())
+    /// ```
+    pub fn push_within_capacity(&mut self, v: T) -> Result<(), T> {
+        if self.len() >= self.capacity() {
+            return Err(v);
+        }
 
         // SAFETY:
         // - `self.len` is smaller than `self.capacity` and hence, the resulting pointer is

-- 
2.49.0.rc1.451.g8f38331e32-goog


