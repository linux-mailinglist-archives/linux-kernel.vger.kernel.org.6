Return-Path: <linux-kernel+bounces-301747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D50EB95F501
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 17:27:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 060321C21593
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 15:27:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 938A818D624;
	Mon, 26 Aug 2024 15:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B4DlHXhL"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37636186E48
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 15:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724686054; cv=none; b=QKuSkjFIn2bkzBMP0Y/PwZvQ/AXtn66DQWR5+RO9pQP7E5LmufhcrsdG5bKOrbb5bcBE997aCoQetzoNEauECM0iAE68TKSv7odbuqcdR0pNfuh5IlcRaQyuVxwJST/9bw89nr35YEbEidsOk+LpacnxbxD3jAZZEAIZI+M9H/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724686054; c=relaxed/simple;
	bh=xaE5mWK7wHkrD26xzREpPrSqgq8txeWlxgTXcLQTTwc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=OQ5akuRPa3O4nqZx+yvpTqZehFa8wae1YJhOX+nLLGl8NX3+eLfvntNfSjK2Rw2pH/mvrpn7uO+2D2nZsnbA23ixZzn11JBJ63cFayqHGWSbrdiXmgEWPySW/CYuxScWmi04xDKkTLKVx6EwgiUScpd/e/NQBV9APXuad3CziVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=B4DlHXhL; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e0b3742b309so8202333276.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 08:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724686052; x=1725290852; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=21rARTbEqZ2KZqhME7uhGs5St8UIcszy8yt+7gd23hY=;
        b=B4DlHXhLB8pfNA+HIV8VCq/V0cMC7B3HI/xGXMrUZX85vKQ+9i+uOfGMRTQmYZMQUg
         Z7v8fESA6rJHpMC5P+Uv7mKTxs0LrXcvKYTbYwBOpjyZqQt387esTE0DMeQu+/aj1EP3
         q4T4vjX30Th9rNrPKFj87VRJtiAvrhVGHnJNgPtgkdLXKqTpjZP8l535vsMOQA89K7Ob
         oRIyMygNO3UdGZjJnA7ZsPc0jqw92G6aWVZrkP7KQ2vvssKN/c55RJZjZoPebQUGJcsl
         V2BhXIA2rEoNBl6nQsCNXHr2qoEDMARQAIsHHBvF2UzLekVO/K4+T4Gm/nb2lipL8TbD
         f8LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724686052; x=1725290852;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=21rARTbEqZ2KZqhME7uhGs5St8UIcszy8yt+7gd23hY=;
        b=PNCE2sRH7laiIH4NruDPcTgzcK5tbL10weAwpPxfrPsdvE3tlolWbh1BcWabW9DE9g
         e+J+XxtQDF961gLusMeGabR8O0D2UFDIgB9FTD4i82eMkOm6RUYreS9c5I4G/qlOdqH4
         x/JXmpSug8LPu51QiQsXZ9NaJuH1/Gmx9ua26CBb6yQRR5ccfFWu2wfrpuwUOgvw4YXP
         NHTRHES29W1v3DaYq37a8IZoFAdXOK4AfIzYdZcGZvr1J34TyRBkbzFkLT0AwuGeHtJw
         b73Xi64OdMSqXMPBftI9yBqt7+NnxYfUH7Z2KMfRCryIWeAlWGOKhCa9LjSUNjSLUJkM
         ZvZQ==
X-Forwarded-Encrypted: i=1; AJvYcCVlyHj8t4bMMCtjX2MqmhlwV6R/W3h7eaVbSCQGRtQSHwZnfJVTH+9avmcsPI+m+7iNRu0eRn4m6DHxpU8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwmL/qtXnCi4e2e/+VNz+02U1oOLWkUdB9A9TrqPyuYl8b9KOu
	3uuBZkNSgBG3LyOhkDFufB1yLil1mCzGN9f7ppUo2qQRCLgG5WuN74thXDTZQs6S0QUItPhcf/u
	k0RZTgji/0fbSfg==
X-Google-Smtp-Source: AGHT+IGc2W39ovH2k0SFDR5LLW4PYx5GU70RLPfcV2Uyh97MFGsJbBR3hlHLmdXv1XLsCicaxzYeZpWgWrrDptg=
X-Received: from aliceryhl.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:35bd])
 (user=aliceryhl job=sendgmr) by 2002:a25:a123:0:b0:e11:ade7:ba56 with SMTP id
 3f1490d57ef6-e17a86451a3mr198937276.7.1724686052033; Mon, 26 Aug 2024
 08:27:32 -0700 (PDT)
Date: Mon, 26 Aug 2024 15:27:17 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIANSezGYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDCyMz3eKSxJLMZN3c0pLUCt1EkyQjI4tUg1SzxEQloJaCotS0zAqwcdG xtbUAqAODgV4AAAA=
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=3344; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=xaE5mWK7wHkrD26xzREpPrSqgq8txeWlxgTXcLQTTwc=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBmzJ7e1wyvVdjxf5Ue323CU135hgPQlEmTNdVVU
 +3/TxYwT52JAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZsye3gAKCRAEWL7uWMY5
 RoBED/4wDkveoJXLs5D8oE5A48NJyluDTMwsJDG84US0BXja6AoC4de4m7u+n81DiMF3xccXVXX
 qnEgn8NYqUMTHmNsXNoeNSvJpFb1TDCjCn0ebtUGaBTXnUsgi8Itav1SztPseqszX+MAO2HLMU6
 XnQOs8bCb2MOqxdX2InJaK2Q6iihb+iw7R/t4WJY2O3x0cZTZXMb/QQAlhwgKuHKqTKpAf5rPcU
 t0GJftiK8xoZafaEMOQLt1H6RqnDR329A6KJmIdx+757L6QTnZ6+HqywtExpdtzNfIY57HzKgh1
 XVoneOZ1wOAfINGzfL3aub13mhkpU65B2igdS3LPLuUjH4vi7hhq34C2hrUKjT8ou5uiDzssz/x
 +fAZ3vU8G1B4p55TEjAbwQkAz81/Q/I0rgCBq6HqVX+EySAV5bCtK9FVJxVlW9/ufghiR7wHTIu
 PCAGFGkKqyUKg1g4CnEw/QEVqBPBfbRWYV1lFornqjoU1QNJAuA2lw33DDY5NO1lMUeVuiMSkf7
 MluBpCipUz3O2h1ysXvh3ufzNqtfrEM0YLZsIfhJDNywn0o62Dkk+u1rSJBB7m/qmtGXxXHO0Ft
 YE+uRUy5L8XlSlVHs53NHqGUNOHoiAMCgn4kXN3AD/4RFd8ArZxCuyASbQB5+OzdDTK3rLu2Thw mBxJGiDE0Uv83+Q==
X-Mailer: b4 0.13.0
Message-ID: <20240826-static-mutex-v1-1-a14ee71561f3@google.com>
Subject: [PATCH] rust: add global lock support
From: Alice Ryhl <aliceryhl@google.com>
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@samsung.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="utf-8"

We don't currently have any support for global locks in Rust, however
they are very useful and I have needed to work around this limitation
several times. My workarounds generally involve initializing the mutex
in the module's init function, and this workaround is reflected here.

Due to the initialization requirement, constructing a global mutex is
unsafe with the current approach. In the future, it would be really nice
to support global mutexes that don't need to be initialized, which would
make them safe. Unfortunately, this is not possible today because
bindgen refuses to expose __ARCH_SPIN_LOCK_UNLOCKED to Rust as a
compile-time constant. It just generates an `extern "C"` global
reference instead.

On most architectures, we could initialize the lock to just contain all
zeros. A possible improvement would be to create a Kconfig constant
that is set whenever the current architecture uses all zeros for the
initializer and have `unsafe_const_init` be a no-op on those
architectures. We could also provide a safe const initializer that is
only available when that Kconfig option is set.

For architectures that don't use all-zeros for the unlocked case, we
will most likely have to hard-code the correct representation on the
Rust side.

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/kernel/sync/lock.rs | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/rust/kernel/sync/lock.rs b/rust/kernel/sync/lock.rs
index f6c34ca4d819..19e8ecd8d194 100644
--- a/rust/kernel/sync/lock.rs
+++ b/rust/kernel/sync/lock.rs
@@ -117,6 +117,40 @@ pub fn new(t: T, name: &'static CStr, key: &'static LockClassKey) -> impl PinIni
             }),
         })
     }
+
+    /// Create a global lock that has not yet been initialized.
+    ///
+    /// Since global locks is not yet fully supported, this method implements global locks by
+    /// requiring you to initialize them before you start using it. Usually this is best done in
+    /// the module's init function.
+    ///
+    /// # Safety
+    ///
+    /// You must call [`unsafe_const_init`] before calling any other method on this lock.
+    ///
+    /// [`unsafe_const_init`]: Self::unsafe_const_init
+    pub const unsafe fn unsafe_const_new(t: T) -> Self {
+        Self {
+            data: UnsafeCell::new(t),
+            state: Opaque::uninit(),
+            _pin: PhantomPinned,
+        }
+    }
+
+    /// Initialize a global lock.
+    ///
+    /// # Safety
+    ///
+    /// * This lock must have been created with [`unsafe_const_new`].
+    /// * This lock must be pinned.
+    /// * This method must not be called more than once on a given lock.
+    ///
+    /// [`unsafe_const_new`]: Self::unsafe_const_new
+    pub unsafe fn unsafe_const_init(&self, name: &'static CStr, key: &'static LockClassKey) {
+        // SAFETY: The pointer to `state` is valid for the duration of this call, and both `name`
+        // and `key` are valid indefinitely.
+        unsafe { B::init(self.state.get(), name.as_char_ptr(), key.as_ptr()) }
+    }
 }
 
 impl<T: ?Sized, B: Backend> Lock<T, B> {

---
base-commit: b204bbc53f958fc3119d63bf2cda5a526e7267a4
change-id: 20240826-static-mutex-a4b228e0e6aa

Best regards,
-- 
Alice Ryhl <aliceryhl@google.com>


