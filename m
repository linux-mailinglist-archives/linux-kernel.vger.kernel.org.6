Return-Path: <linux-kernel+bounces-556298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F2C0A5C3C8
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 15:28:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D3747A31D3
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 14:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 311E625D52E;
	Tue, 11 Mar 2025 14:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="weOuFqrT"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE32725D908
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 14:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741703170; cv=none; b=ba858Fx8bmmH05VcwavFGTyaDN6MAj8PDnZ3dcB9LeWjHALRmLILM3ZCz1j3fHJ+Qh2rewtfVAG9TsAWP/7SXAJCJ9qdPDHzoM94gTbLPkWMs8Cn4SOj2liBTsbm28gwWqPMtBq6mDbeIh/cioVrAC+8dkgNPM5gqnWWpvRGlmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741703170; c=relaxed/simple;
	bh=/hojUynEPo4FjkJuts+wIohS5BMSkgWw4Set5Rdyf+E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Gm5OCOtoHi4/uJWkTYAWmp5o5SgN8/ppgeOo0y+sWMQ5+GoPacPbWSUFE27UfCdcNnd+S2ml+/cNNQrD5P7Xf9FIFPQ29SGj1gRgpVIQWrI3RSozAgehDzk+oMU4heFwqS7kaqfagDvQLwscpuc4XGlPzyaz4LEesUrebhw8qm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=weOuFqrT; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-43bc97e6360so27857135e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 07:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741703167; x=1742307967; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=JadJK9y1sKZ4Keav9JLStvrnzzXru9HhnZNlAQYAikA=;
        b=weOuFqrTeC34wXs6oA3qlX7q4qizf7Bx1l4K0bgz/mJJDQyVUEaqD0maRJT31Wq1yS
         YcETGv+3WQgnE00l8wWEfJN5Wwhx8tYilN42d8S5HRyu0gd7rFxFJqLctWglUTSYmoPq
         0i3GkQ6wOGsouF3AMKOY/lJNmlMHBHn67vQmWzxHZnRBvg2W5/o/H7OdUnuvyHZxDESq
         4mbBvHRj9o/EC/nmzeM0DLwQ7JedZeZhCE7fGm/qso++Yi3DbCCeoyfXqUmpMV7qnXq3
         +5tTA7z6oPcSfyjnv0zd7DRDtu9VapdAfejUFNMrjx3nmKxBlun3WnFdeRuDtY0z4ui2
         9jeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741703167; x=1742307967;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JadJK9y1sKZ4Keav9JLStvrnzzXru9HhnZNlAQYAikA=;
        b=DS7BJKFjLrZm8zqTn+Ly9nGjxhNv3hPiPYU3G4hWu8q/h/McsW4nXvldHGHiMlEziq
         QPivYce0b4Q6wiMnTR0C2i2QTdJ/HvPZXJLOLT+85APqI8gp0qwzoSBS7hNS25dJHEi/
         7vXVXbh2TVmQl7BDhI7EXpPOl4YFKGsmtXuQVgQpw+ho/IzM6nBJnUghYaGC189XiWb2
         EiTvm0LjO5kFrVT8/jckYfKOr3I9d93GUMjy1cQzOQH/Py7dDbPdPgmK3dG/SRoeRYNq
         NbKttCXq7Tat1BMvk0WNroc6L6VizJAokDaiyoakolEssgyalgk8sNIMDbBJSAOjZFhM
         iovw==
X-Forwarded-Encrypted: i=1; AJvYcCWZXHZ7qEy0WG/BaqJGM/BiuusVyKMjuxY5qu0WjkYkslu2UJgIxx6gujGegZZpJCzSPk5zmQggExcYlE0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNcnD06MkcTTVUOl3gW9H2frdGpPfeqs9mQaVvtgBjPwcH5yRu
	x/sTZoUy/sSeBXoW5AOmqZFKDUXhpy8zvlAr8vvznpW8R/aJQVHqKaMk/5yMMerA6mR4MkNmmtT
	7sPBLXO0dXOxKwg==
X-Google-Smtp-Source: AGHT+IEFdrFYuu+2Cx2wC79RGudaUW6+8mAmayjW6nCjBT5GMW6ijX527iMMMKlgRA6YRV2vSayTGsD9nLZ7ls8=
X-Received: from wmbg5.prod.google.com ([2002:a05:600c:a405:b0:43b:c967:2f53])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a7b:cc88:0:b0:43c:f75a:eb38 with SMTP id 5b1f17b1804b1-43cf75aed80mr86147505e9.2.1741703167192;
 Tue, 11 Mar 2025 07:26:07 -0700 (PDT)
Date: Tue, 11 Mar 2025 14:25:15 +0000
In-Reply-To: <20250311-iov-iter-v1-0-f6c9134ea824@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250311-iov-iter-v1-0-f6c9134ea824@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=1605; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=/hojUynEPo4FjkJuts+wIohS5BMSkgWw4Set5Rdyf+E=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBn0EfzNLsGvU0BxvVQd1R1R0pNczpN3OAh70ew/
 FlfpBkguBiJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZ9BH8wAKCRAEWL7uWMY5
 RhHtEACTIxhdK0JRLjf9ZkXGGZKEQowA1mOYI7Lhx5Nf1GkE0CIsnU13Dif9X1Kt0I91ihBH6rf
 lJYj/QbzWpcH0BTfVxG7bFBAL29tgLS38EjpInkzI9hvHc8+5PyLEpI+DGp6vbKr/sgaDiy5RQ3
 UWJdY9iNAqrFMckgEJHKnyNZ1ZJjuqBoAo0ivgAsmUxpsxwliEd/aUoE9YQjzhBYYYDtUu3cn9N
 AAp2bDka8NuMF0wA8rqrymj3XngX+57jAWkjGPQZk3XHjYIpUWzXxX85nvgAcrXn6+MQKeWffI3
 aa/wKbWYKL+JwSe5rRg97aRE864RXK8H6taL0CjIsjcePVa/fqOxlzFeSrKjfNhtgQSWnL9Kcfw
 fQwdoWdxCXyOqwUWWm5znFkOKTzJmq5i/EkBb7uJrPyiIEH77dGP3YLc6HLQ9EqdHVfjBSc8jkc
 10ctJ5wvbzxs7vhJhOvas0tDcg1wWKZngr2i5kgY/sqag8+1rZSlUD6+RHRyKECqY/SjrAsVbnd
 /5PCH2hdwZDLGNEb5ORgZfoeKrty7xZ6zpBjU5AtNKTxzZML6l3R+pP6G8qoMyXH+eEbEqopb51
 H/VCCqpccNu6eRxvvSC2ESDORMWKAM3QEEQG2/VTjq5Mp9qnbZtwk4HECyN/YiJzbXwQZYYMHlT r3s2J3t4PtKGQ8g==
X-Mailer: b4 0.14.2
Message-ID: <20250311-iov-iter-v1-4-f6c9134ea824@google.com>
Subject: [PATCH 4/5] rust: alloc: add Vec::clear
From: Alice Ryhl <aliceryhl@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Arnd Bergmann <arnd@arndb.de>, Miguel Ojeda <ojeda@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Matthew Maurer <mmaurer@google.com>, Lee Jones <lee@kernel.org>, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="utf-8"

Our custom Vec type is missing the stdlib method `clear`, thus add it.
It will be used in the miscdevice sample.

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/kernel/alloc/kvec.rs | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/rust/kernel/alloc/kvec.rs b/rust/kernel/alloc/kvec.rs
index ae9d072741cedbb34bed0be0c20cc75472aa53be..2d213ede2873cef87116a5527e8e24008c970a58 100644
--- a/rust/kernel/alloc/kvec.rs
+++ b/rust/kernel/alloc/kvec.rs
@@ -395,6 +395,33 @@ pub fn into_raw_parts(self) -> (*mut T, usize, usize) {
         (ptr, len, capacity)
     }
 
+    /// Clears the vector, removing all values.
+    ///
+    /// Note that this method has no effect on the allocated capacity
+    /// of the vector.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// let mut v = kernel::kvec![1, 2, 3]?;
+    ///
+    /// v.clear();
+    ///
+    /// assert!(v.is_empty());
+    /// # Ok::<(), Error>(())
+    /// ```
+    #[inline]
+    pub fn clear(&mut self) {
+        let elems: *mut [T] = self.as_mut_slice();
+
+        // INVARIANT: This call changes the number of elements to zero.
+        self.len = 0;
+
+        // SAFETY: The values being dropped are valid values of type `T` by the type invariants.
+        // It's okay to invalidate them as we just changed the length to zero.
+        unsafe { ptr::drop_in_place(elems) };
+    }
+
     /// Ensures that the capacity exceeds the length by at least `additional` elements.
     ///
     /// # Examples

-- 
2.49.0.rc0.332.g42c0ae87b1-goog


