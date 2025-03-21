Return-Path: <linux-kernel+bounces-571201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 05FAFA6BA56
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 13:11:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 362027A6AD6
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 12:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBDF222A7EC;
	Fri, 21 Mar 2025 12:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gfJAZYv+"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DED4227EBD
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 12:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742559032; cv=none; b=l4RwTVALQ8bb4urFBg58fIO+m3eRZF5hXvwT7NzZ5uLTh6P2qCj5dswellB7maAqmXBRpP80fWGoGImPHKWPWPi+3PYynhABAmCjA1X+8v8i1GwOlZmuXgHJgRkGCDbP1gtErmetknlklDzhyEes69U88HzTQwE6EWketWo9tRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742559032; c=relaxed/simple;
	bh=CenZwVOD+GrhyGqXr7eT4mqrBBg+m3/fOxMffAwc6YE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cm5VZrW+dqb0OluQ2WXIwWWksAkjBxUiLVNh3X5WZ/OMU8MhDOmr6p0nJry28xipP5mjURM+6qHbhwP8YCM04PQMMMVffjLGz54xIhwf/wokcrKIaCb01eAW2iatbMrTJcDmXw6nRvafBkDyeOu1UubVQuSVd6ZNI1qdix14ylU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gfJAZYv+; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-4394c489babso8504605e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 05:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742559028; x=1743163828; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8p9XCS80u4SekshtxVRT2AVnFTXfb9fXAjsyjCLRaEc=;
        b=gfJAZYv+MnsfkYXV1rggzulbF8oUiZ6A4iZ3BJr2qz/+2Td5UveGOe7PqeUI3DtYZw
         dfkn8zPXrDds/W/UDD2NS6kmUQY0xP8E1orrn9vsGemqA0eMY+RXdB0QibVM0z5HE3/H
         GiyDC1MR+O4KNoXahz0MMVTIQdYSjmzPq0V8Lz0kwslmJAdiwuY32qJ/5LqeMposcl/e
         6dlj8X/pNVTFXMH/rgVpYLViH8/G8m0TCxgahq2eKf+UbGMvyDEOzdHzxzLRkUtLf+a5
         SYpC7jwASOkdb3ShAityRq4Y6gOgDx6gmw3pYpwDU+PfA20DPMjrtbHMc/AFSh74VhEa
         Ctww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742559028; x=1743163828;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8p9XCS80u4SekshtxVRT2AVnFTXfb9fXAjsyjCLRaEc=;
        b=L8cfI+wfj3uxZozW4i7mji9OdVu3hSjXlLwTvt5zOVIHKg0pB8qG+/tQ9N1Xe2lmYM
         ezYKj2IVI8UI9Hfcm/2UKO70RRGQ8HZ3lifktPD3HmUrsmvshf4JYVlgtoyQ8WxPKzAs
         FO38PT0cpYvyV95jfr3MQxJ8k4cH1pyvr+iKaXFVJkS1VNbcxX9s4lGTazqOL7RB0I6A
         E6lkSCO2VXOB7e9rHeDmgCq4OxiBpd0mY8cqP0jMPMCu7eOYis0QmFJvMt8+AhQdG2GS
         NIpL++kmDMPHslpTmVXinBWGqXLD9+GJ7K074SEi/u4qPrXW/xpEPE+ohHQuQ7hEckvI
         Mn4Q==
X-Forwarded-Encrypted: i=1; AJvYcCXLaWVFXlEV3V305HMjj82HoappOcJxtI0gECN5x2uKuCFekV68OrbuUC8TKdv/Z55iyvPI0oR9CCZMmq0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYQbDNBJbS9CpQu0/n6FycQDNyXk36tIjAWHjjXTdxTVx+MBms
	g35hgsAnpPokOYXQPpZ1J25YKuYDyrI6PykfIvVwR6BtPQrHXgBBAooHosI7gU6nCFLZM6t87aa
	03zBaEttHctkzLA==
X-Google-Smtp-Source: AGHT+IE0JzqCo4hT9QhFZy6HGmQmE5baL1LKwOCenfRXCBC0aZnS95NxOjoqopt/ytWRBePpcJcn2995SwMi5dQ=
X-Received: from wmbbe9.prod.google.com ([2002:a05:600c:1e89:b0:43d:1c63:a630])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:ac7:b0:43d:abd:ad0e with SMTP id 5b1f17b1804b1-43d52a8fa06mr14331465e9.18.1742559028756;
 Fri, 21 Mar 2025 05:10:28 -0700 (PDT)
Date: Fri, 21 Mar 2025 12:09:58 +0000
In-Reply-To: <20250321-vec-methods-v2-0-6d9c8a4634cb@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250321-vec-methods-v2-0-6d9c8a4634cb@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=1965; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=CenZwVOD+GrhyGqXr7eT4mqrBBg+m3/fOxMffAwc6YE=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBn3VcnRUiLDyS+/y9aPym1UGxnWYuFowsPTBhvo
 eunLeIjeqCJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZ91XJwAKCRAEWL7uWMY5
 RuMrD/48ZEWJt7SecaUIQ6dxxdUbGuIINRB33Cj7n9VFJ0LeTrdZwvaKHenGsqt0DUe0ISCphQ9
 NxRzT3Og/mJkCXL+V76PUg7g82LwLG4HqI+KcyS47ytPTozohC/jnT0k0aNzpyEDVV9G+MzOE2q
 woYoD8+NGDVlbb/BqP1jSGT+vMoCXCkaWRJn2yCbKd49GEqpYpI/1hRpRwhvC6PcaeS5+7IpcZ8
 yG036eNtsM72oJTCUAo28fEffERRcXp5yqwq/zn/XSsUPXETtRFsJgIMwDFEQBF2xT9qHzN2sAM
 oJit/chN4q19jYRBylKecR79zYABtDFZO/qCzrbYM0c+5U4bll9TIFbQ8zut9jQMiNxEMYEgNgG
 7r808ZAetZ/6jrRqqGq6iUeXlv9a/Mzzrvnj1nzgAReWK//J7RQxKsyJRxlIIj7hFXy5cGm1aa+
 rP0qJoIqM9EF+fB7lBbJ6UiQLA/JVzZV2Xpp/XYtOvz/AfiTYIUWLEsI53Ozgoo6lhMlidDf9/V
 E7rsKXbeC8SAOcLF6KoFqqsg0/itVkNT1i976l0Kc+rUTPvNz13QuenjDK42MAl/8oLIbNb0NQV
 +mKm9+IuO3kaBGmmezdYbaAIg91j9QP2Y2U5GOPOcdeCZ2FJFN/g3pzDMX6fDZPyLCOQu1whnaM r384qMqhlA7u49A==
X-Mailer: b4 0.14.2
Message-ID: <20250321-vec-methods-v2-3-6d9c8a4634cb@google.com>
Subject: [PATCH v2 3/7] rust: alloc: add Vec::push_within_capacity
From: Alice Ryhl <aliceryhl@google.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Matthew Maurer <mmaurer@google.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Alice Ryhl <aliceryhl@google.com>, 
	Benno Lossin <benno.lossin@proton.me>
Content-Type: text/plain; charset="utf-8"

This introduces a new method called `push_within_capacity` for appending
to a vector without attempting to allocate if the capacity is full. Rust
Binder will use this in various places to safely push to a vector while
holding a spinlock.

The existing Vec::push method is reimplemented in terms of the new
method.

Reviewed-by: Benno Lossin <benno.lossin@proton.me>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/kernel/alloc/kvec.rs | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/rust/kernel/alloc/kvec.rs b/rust/kernel/alloc/kvec.rs
index e42c5c40c992c796409505da70975f970524fc24..c9de619466eed1590fda039a291207100729a96a 100644
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
+    /// assert!(v.push_within_capacity(10).is_err());
+    /// # Ok::<(), Error>(())
+    /// ```
+    pub fn push_within_capacity(&mut self, v: T) -> Result<(), T> {
+        if self.len() >= self.capacity() {
+            return Err(v);
+        }
 
         // SAFETY:
         // - `self.len` is smaller than `self.capacity` and hence, the resulting pointer is

-- 
2.49.0.395.g12beb8f557-goog


