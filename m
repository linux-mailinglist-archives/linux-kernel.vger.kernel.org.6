Return-Path: <linux-kernel+bounces-571205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 926B7A6BA59
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 13:12:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 062194A06D0
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 12:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86CAF226CF5;
	Fri, 21 Mar 2025 12:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PazOPxuL"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 216B822C35C
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 12:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742559045; cv=none; b=IdRwKglLJDRBxkYoUaMsVeQmn/+9Qo5Y1cVHPUugSS/o03SDTHsT0YT0z10Kq+g4r6F9Fp0LCsjL/CGiNetT31eTjRRouuKW6nEQmbXHR2Lo3hLGuLrDnNgPWa5cGTvmYts7/T4hJzKtvg4KQ8X5d1P/thMCymYDq6iJqINUoGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742559045; c=relaxed/simple;
	bh=op8FOXsG8eKuiuXoYyinweSNuAafqCPjsxLJhA3CuUA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kAYxg52SiwSaSVH6LeSTOBCq1JT9nB0V1Xx4sv1vJMiL4Y0DKzvCXhbsxJcy9rGe8jGYS4S/EANBeFJOG4/VD/pNVMIXjfVnVBoYRsnk+9VKdBUQiV0b5gvTHnnwSfyImmscaittdsGQtKyg60wxsTqUxZJgEvBHdNsz3VYq0w8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PazOPxuL; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-43d51bd9b41so5664145e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 05:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742559042; x=1743163842; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=65EXsBa9VCEM2Xc9qqeAJo/ccGDFW5pMORs8L2NFvxE=;
        b=PazOPxuLh5I4meT1Qb4aUQipXQyjRKmbUUx47on2b3Q2/Pf2j1rUEmmxAX3c6mzd/h
         A7XugF8czcuFzo8hb3sndusEQDBUe18cPBYD/pMdfhvxSPGMdW/DnckDLCGOQhuk03GR
         NTLqpJ31j74hsOqPYMAFRyHMWLQ16AKNhuCGZrL8bo5y6/9hmPHd5Twi8aHYfvNqDyVN
         hk8U0ri1pLmZXoMUBEEXxre4hWHy6JQ9Yf2QCopjpkb6fSLOmp+j7C9DgtV6EAjHyA3l
         FcWl0785LzaRUgkI5z9TpyLW71IvaSv7B3hy+Ca95xVnRfU23xotf3uoCs+gQqZOVLWr
         HAjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742559042; x=1743163842;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=65EXsBa9VCEM2Xc9qqeAJo/ccGDFW5pMORs8L2NFvxE=;
        b=mrLXYQcroXUJCkhkIwniP/eQCFM7iBZuRi+l6f7wTYVqA+x9LAzxBjlJYbQsfDB3MO
         +p1sKnqwGRPRGR3G+sWhNnJxQbhraWuE64V5+EcJ2fo9NpkQYP+trV2RaNmS0scvWnWR
         sHwT97dsmni457jGRzd6ywHmo5XWm8ax7m1ALZZUkdrNAbTwvbv7DP+Hc82WZslT/M5+
         peBsA8EsTMYLT9QxLsOx6lTL0A+EinVAIRtuYvdq9XUVgB3F7iomOzuD6TXS5I95fqIv
         X8OtzTlL+QRTHmQojsSssaicsr/9n72Jmwg/2NQWAKPcLHFvgzoP506Oi79GyVI4AKL2
         mGjQ==
X-Forwarded-Encrypted: i=1; AJvYcCUITTvzIHL9BwlrEGEInABk7sq+Nv7yKxXqsJ0kDlIH3KR6X48qsDL0I1xkPmi7xx9DUkSJ/gfrq5/hO2U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzAwcTA0Bv8pBX++p3tyGQIjPbHNhgGe2ZZt4mwcJOyK+pWu32
	cP6ePy4IAfIml8qLvnq16L/DV2mnOWik+wS+k1/xrOjEIuOuFnBU1CLYSBlVD4mNRTkEc2phIVz
	7J2n1zIf1B1Dlnw==
X-Google-Smtp-Source: AGHT+IFOO2Wy+xG5LzSEhSafYmkXsCDVc1uW2ONz8f494sMu+TmkfaiuuJVB8qhS6G8b2lOHhyxpCsyngE6rBVI=
X-Received: from wmbhc9.prod.google.com ([2002:a05:600c:8709:b0:43d:1ef1:b314])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:468a:b0:43c:ef55:f1e8 with SMTP id 5b1f17b1804b1-43d509f4983mr25528385e9.13.1742559037417;
 Fri, 21 Mar 2025 05:10:37 -0700 (PDT)
Date: Fri, 21 Mar 2025 12:10:02 +0000
In-Reply-To: <20250321-vec-methods-v2-0-6d9c8a4634cb@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250321-vec-methods-v2-0-6d9c8a4634cb@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=1923; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=op8FOXsG8eKuiuXoYyinweSNuAafqCPjsxLJhA3CuUA=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBn3VcqVJ3vDPsIBvOO+bI8RrCdXtJ8eKSCKt2ZG
 1FdyCgakL6JAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZ91XKgAKCRAEWL7uWMY5
 RqJYD/9Ofti/igTSpvAQmd2uQ3JHgyZhw12A/8M4zfIZKjmDKBjUMIYVWQ2+Ag6hY3qeuupROoW
 ki/qGeewtku66mr5Jt3Juka3HlZTOKw1fgf0i5XdHJNZDhYa2JcoCNYarO2XM1vJi9z3HwyzO2U
 JzF0ocNfDS0WdxoP2/VUBGY1qd4M43cVmiZ51ikYZte2NAKw671Nlz/dNJ34moDuSKkMdfjRevy
 SEfQdhYPHV0GxGoLudURQ90+S8Dx1cQzflup66zMatT+eKEd5gDNWdbMjqhgf+46Ex7DtQfKLyF
 BGxSYSy9rUhYejv4FZh9Nt2cV1S1jjcnMFCZT27JlcGY2t1lPDr+uuRGh0Wv4X1TIpUUQ6q30U0
 TKjkWNHsF5TFF16j8QqS6bcSLMN8teBXTkrn9/oW+1mrP9Sl6MRf+2Mcl4Rq0cBX64qB66L3hWi
 bh1ko1YxypBenbPu5CQ/K3FITQrF8v1MKff2hv5zrQEcuf4cb6QQtkb3FRIgKmOFSQHRtx20Rqo
 bnPfY1/3y66MGULXuOA/00/oQpMjlZWMu8kSQ7kROa5ueQ+L0UWKXU9QlRhqXZaRP/1nobASv+0
 PQ9k74QrNLAKtNJ/G0wFJgHqAcvuNTuqg872hXCKibOpTOQtGlDwbQ5ou/oSaj1YPWk2d9v8Ez3 2W+zQLS11op734g==
X-Mailer: b4 0.14.2
Message-ID: <20250321-vec-methods-v2-7-6d9c8a4634cb@google.com>
Subject: [PATCH v2 7/7] rust: alloc: add Vec::insert_within_capacity
From: Alice Ryhl <aliceryhl@google.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Matthew Maurer <mmaurer@google.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="utf-8"

This adds a variant of Vec::insert that does not allocate memory. This
makes it safe to use this function while holding a spinlock. Rust Binder
uses it for the range allocator fast path.

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/kernel/alloc/kvec.rs | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/rust/kernel/alloc/kvec.rs b/rust/kernel/alloc/kvec.rs
index f7f7f9c650f8167ad6f53b0d83e328203445aa1f..38ffd0cf2af6e375f8d4fc2f9afe9295b29e7db0 100644
--- a/rust/kernel/alloc/kvec.rs
+++ b/rust/kernel/alloc/kvec.rs
@@ -327,6 +327,27 @@ pub fn push_within_capacity(&mut self, v: T) -> Result<(), T> {
         Ok(())
     }
 
+    pub fn insert_within_capacity(&mut self, index: usize, element: T) -> Result<(), T> {
+        assert!(index <= self.len());
+
+        if self.len() >= self.capacity() {
+            return Err(element);
+        }
+
+        // SAFETY: This is in bounds since `index <= len < capacity`.
+        let p = unsafe { vec.as_mut_ptr().add(index) };
+        // INVARIANT: This breaks the Vec invariants by making `index` contain an invalid element,
+        // but we restore the invariants below.
+        // SAFETY: Both the src and dst ranges end no later than one element after the length.
+        // Since the length is less than the capacity, both ranges are in bounds of the allocation.
+        unsafe { ptr::copy(p, p.add(1), len - index) };
+        // INVARIANT: This restores the Vec invariants.
+        // SAFETY: The pointer is in-bounds of the allocation.
+        unsafe { ptr::write(p, element) };
+        // SAFETY: Index `len` contains a valid element due to the above copy and write.
+        unsafe { vec.set_len(len + 1) };
+    }
+
     /// Removes the last element from a vector and returns it, or `None` if it is empty.
     ///
     /// # Examples

-- 
2.49.0.395.g12beb8f557-goog


