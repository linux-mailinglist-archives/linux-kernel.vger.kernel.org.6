Return-Path: <linux-kernel+bounces-569802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03DE6A6A7B8
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 14:57:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A84933B4CF4
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 13:53:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66607224248;
	Thu, 20 Mar 2025 13:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wFEiTarA"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1716D22333B
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 13:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742478809; cv=none; b=AUZ0rD2WhfnynbU4D91KvijxLICh7JE7o6eyuUJ6gBxLn0amvfv/rnZLNtsy8QS0I4AAHQZLFfnd8NWGFA/SOcOKWlpzVT7dkYqQFpXQ0S//P78Aua4B7Q9Bvq6s+f+2XfTxsSwJ2Q07gejeKcyj8FgRMQBz0Dr8ueHIUrzXJyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742478809; c=relaxed/simple;
	bh=jvc5aqPuj6cpy8mAjME7Te6ewZpKMqocp6qr8+dQ3IM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=K1ZZhCtccb5ayIRYIlcm6S9VAbpZCtrSAq70mUcGUaw2g+4dqfIf1GArLBXmLT61i2Tx3iElHhmoIdXqeEwuYfCLGSKEirsH1zFjdC2LxxDdzZCcHnrWk09BixDK09he91Y48fTub7eU+XPpn89MDMOLUiiO0+/aLFgJxNBCz6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wFEiTarA; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-43ceb011ea5so4556105e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 06:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742478806; x=1743083606; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=sN7afcPDPiX+BQZO8olJjhA9mf3Yzn3ZwZ14RycPq9w=;
        b=wFEiTarAjy+GHA4z87EmvNAyjt/ZOeYKGj7WkQZCg1X+FE7NauuC3ACPdAs6iiOugp
         1UapdUqckzDAaiEXQq3pN8/iPaXNLamYBZsMyFAOEkep1MLh5os+y7TiUahVvek/QH+Y
         yHqxKK769Rr5TiORvDy4HTFgTAy7ngqg5xTykBDJFq4s3jvoEL3DpoT0tfq1hqyY7As1
         TOA8+btan5RTzK6OGm5drCHO+yMMdFeHXutPg4f3o4rR+4ITyYpc+V667fSsJ+kuA5uF
         8HmHbqgvGJi7MNsYRGctgPmjy+lcZOSXvL45ZIw+5kyCMRUtnWk13YXRW2WCq/mour31
         Y6pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742478806; x=1743083606;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sN7afcPDPiX+BQZO8olJjhA9mf3Yzn3ZwZ14RycPq9w=;
        b=kJ9z1viDCf53XEs5t0IQ6xxId7RQv0hCD6CgK5jH4sB3EOlva2beKm3RGZ67E877Yx
         t4s6fmKx+ai544zvuFjzxCG2qQMqEYvq6weLdtlGW2MCjOuOaBjlsOMhTGwfieIvzTB8
         PbGRcpRbmoUyvBjtrdyoqexXFKUIvELqMdmRoKjE2XNyZgQ1xDGsGtx3+aJ6tsljmuRV
         rvgPP5qlU2iUGzPrgRrnt7hs/YsLDBGzhr8fiOqC8Y2EmTzYl71aH2uvQMds2epD6vop
         xwr7xkl51RU/uNwTADyykrjtRAye8ogM2FAujOwXejb7Gt2xHZIWVxKmnitHMd6IdPM7
         +h6Q==
X-Forwarded-Encrypted: i=1; AJvYcCWWATZP0mLn4e90a9ntAQX0RYg4wPiLd7ZL0VHoCaw+zXSKoVD0jWB+/tdhDHhgh2TqVJL++bQGucnYDRU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEWWj6z+rssI3kh1967Q4C0aLGZWxR8WpslIeCieiULBgyyKpQ
	q+yeDidEyczPOwCE2MJoNMExypgjqUzoSNR7hfRRVmp5JH1nNwXipl2bolsUNvEaAg2vEM05oSy
	rOGvSj2JBOXoNVA==
X-Google-Smtp-Source: AGHT+IG60HlsW2NRPTHuSpCoWI8rVhaRsVP7DbTo5wOCqM5d6S/JM/4Uh+WJmsy23pV8BsW+b+2fllH6ZBT87Q4=
X-Received: from wmbfj6.prod.google.com ([2002:a05:600c:c86:b0:43c:faa1:bb58])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4fc8:b0:43a:b8eb:9e5f with SMTP id 5b1f17b1804b1-43d43781d7dmr64525285e9.3.1742478806414;
 Thu, 20 Mar 2025 06:53:26 -0700 (PDT)
Date: Thu, 20 Mar 2025 13:52:57 +0000
In-Reply-To: <20250320-vec-methods-v1-0-7dff5cf25fe8@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250320-vec-methods-v1-0-7dff5cf25fe8@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=2000; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=jvc5aqPuj6cpy8mAjME7Te6ewZpKMqocp6qr8+dQ3IM=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBn3B3MaTdrB2aY4O2BZr16vy1l8wvqBjEVosoD6
 XSrMWV396+JAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZ9wdzAAKCRAEWL7uWMY5
 RqEBD/4opACkgQLqBBXkkpfSTU7IMIpJwgFY49h66limIJrZncvTBbjgwnZ8DXuJSDBsoimaHiF
 SYH7S5RHoI7SRgaD5QgPm/dCTk6EwgrcROuxNcyOEsWMX8exqZnZjuGnzR8HfVprRP4QizJRfdV
 kBuonUUppZypbYegNoDWREcKeCVuCjAChd0DfB+BlT5N8gqgNA7tp4kXwmbzDe9C9ra6tUn2dcJ
 iNlQ1Yq/qWdA+sROfS4c88ONZKpS9p3dH79J4UDJNJbUBOMMrYAL2I+tQpYvSKCE3LV2PK1HUF6
 OXGTwVUY8ivswN1ctrlWqrbJaiu1CoKUUHnn2ONC2H16qg1OVbx2KBD6tZbDnF4Ygcclj8OvOBc
 2oFY3XdMcnrXJD9pnalKSLVNHdljWxMqtUGFdciqwsIddmTkTecbbe7AZgP3IYHzJFj3SNdNwWE
 VU1aGpJNkh6UcIzegrN2p47Hm95x2Uh8o2zvpucbRozPi1GNOi+Jisiv0aZE/llY38+7Db2P+xy
 8VHiKcDUmh2vdXLGks+o+vLi2qHHvMVDIKdhYW9qIUDKa3N+nt78dCnGPDNgluOhN8JRnaDtKhW
 TRnfkHu6ycP+5juuBleeZBOEMBFg7Sj3dsdp/qsUQkvjHJ3Gx8OofL0kiY5Fvr5qdgvw65I4PrL iY8qhO9R8eMysVg==
X-Mailer: b4 0.14.2
Message-ID: <20250320-vec-methods-v1-2-7dff5cf25fe8@google.com>
Subject: [PATCH 2/5] rust: alloc: add Vec::pop
From: Alice Ryhl <aliceryhl@google.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="utf-8"

This introduces a basic method that our custom Vec is missing. I expect
that it will be used in many places, but at the time of writing, Rust
Binder has six calls to Vec::pop.

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/kernel/alloc/kvec.rs | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/rust/kernel/alloc/kvec.rs b/rust/kernel/alloc/kvec.rs
index 95e752ed27395fce72d372976b74fb1b0e957194..9943358c70aa63f5ad7ed9782cb8879d7a80a8fb 100644
--- a/rust/kernel/alloc/kvec.rs
+++ b/rust/kernel/alloc/kvec.rs
@@ -302,6 +302,37 @@ pub fn push(&mut self, v: T, flags: Flags) -> Result<(), AllocError> {
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
+        let Some(len_sub_1) = self.len.checked_sub(1) else {
+            return None;
+        };
+
+        // INVARIANT: If the first `len` elements are valid, then the first `len-1` elements are
+        // valid.
+        self.len = len_sub_1;
+
+        // INVARIANT: This invalidates a value in this vector's allocation, but the Vec invariants
+        // do not require it to be valid because `self.len <= len_sub_1`.
+        // SAFETY: Since `len_sub_1` is less than the value `self.len` had at the beginning of
+        // `pop`, this index holds a valid value.
+        Some(unsafe { self.as_mut_ptr().add(len_sub_1).read() })
+    }
+
     /// Creates a new [`Vec`] instance with at least the given capacity.
     ///
     /// # Examples

-- 
2.49.0.rc1.451.g8f38331e32-goog


