Return-Path: <linux-kernel+bounces-286060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 281C595161B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 10:06:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB54728281E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 08:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD86514036E;
	Wed, 14 Aug 2024 08:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lpbmThUN"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 407FB13D88E
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 08:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723622763; cv=none; b=HnPqnAi/t3jtndH3iXYh9jr2EqKAEnOMOndDYcjrJ/attAqwhWThCufRi/CJMrgWMDrBWqXJGPWUC5RjZ/zKCW/qk1lcM6z2PEpbXU6WgBK7ngn4gg2LQFl+Tq2c2r0rYZygehJywVL3Mjk80oDq4wAagQUlXiBGINbFuMh6HCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723622763; c=relaxed/simple;
	bh=to5V9uzTlPBNFNGla22QaxneooMIy/yOvQICTxnvla8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Zbyh1G97TM9T8ACJBLA98M9Ta8TjAGJ5MGYAFIwlshyuTbUMRtQoV385TPHDKE8bCrVCU/1MhDHJXtDI5KN+p/RqjczJb4fMstfMsVdOAneY9j+36QbRVnSNmDdo6bktnHHxHtyTmfCUWXtTHcXfYpRYx1lJY6rmqfjwS/MJ2UM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lpbmThUN; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-4281b7196bbso48773445e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 01:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723622759; x=1724227559; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=cS8w042FemB04meCg0s9sGOe2wtiJS+z6C7ez/1yX1U=;
        b=lpbmThUNr2SzVU4PbMZuuBMPKytnC33yeu45cJ8atUZyHQPpBslE0CizijHqLgNUtV
         a+BnVKpNUeqZwihCbGXiyIqpGt5pmYt9+CHWOFo7nwUDKvQfxtnJgSXmA//WmQq5G3ZH
         +pL+/7n7TZG8ne3X9WLE4ESTof2Rjmydyb4YUMCQSh61GDVupSWOTy/SdXR4AMrKIpGr
         52xe/uFk7p2rHdZKrlxOpfzVGUAKr0P5KxkmXRfXaLh4AI7VvM5m2PUJqBWuuhYsYuuF
         kZ1+UXol37ezdDEPDA4wfzWUOe3uZ/zJ/0/bLm2W+7r1Jicfkjv9u21RSdSCIAWMQH4m
         f5Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723622759; x=1724227559;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cS8w042FemB04meCg0s9sGOe2wtiJS+z6C7ez/1yX1U=;
        b=xDe/zmgD/k6A8NWHBqvWJ5/3jXhsEt5jbEj32Bw+R9y1uQAuAKZCNgk1QajxT1OApd
         guFfEYOBxHt3j3kUlt35kJepo66jMz8i2hlCTJRvLrmwcHJUvA4COG3INGnPMbkIGr+W
         j10LRWTvtlDO8huh4iRpGP33UsLjupiYnzPIw7ttK3mYqpyxuDKs0LeT1k0OnIlhtAaz
         Cz/ovIPHhKAH4fWQfZuwLfnU5SC/vfnnxzN1NDZTX76VOHWQFdPnhIL4Z6MjisLPTqJS
         MN9ng7+JLzfASiANqA7xWHr9D/xLCccigN4Yr2MToK/JTW1MVqOE4Kd7dpXBpG+fvWvY
         fvhw==
X-Forwarded-Encrypted: i=1; AJvYcCWK0v9OcYXcEVC0f3at4G/BmtQFMLKHytolwnkbnLIB8yLwxNk6ESk2VGGR/yRJ5bXYeNshxPbKyGUPEIrnxwUmb8i/WyjBzLsus5X+
X-Gm-Message-State: AOJu0Ywtxcfs05z2x4yCCauliD5uOyd+Uwiu/zuk4cNOp9qj6pQoZP57
	yK+4yDGDsYgrg7Y/EGz9vFo5N+7JBpavw6oeqK1dI2s/dfA+kJqnK5u5L+Z0S3CKZo8skLPrbsq
	Uk3WXNR9gc0z2Xg==
X-Google-Smtp-Source: AGHT+IHG6pEJIWLU9mt7Zghg8hgN3WIt5DM3XzHjfDM6pd1KFbLaVZ0ECjHsRl8XIe2Pxvf09MAEI820HChGkGA=
X-Received: from aliceryhl.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:35bd])
 (user=aliceryhl job=sendgmr) by 2002:a05:600c:4c99:b0:424:a5b0:9a9 with SMTP
 id 5b1f17b1804b1-429dd273b35mr63605e9.7.1723622759320; Wed, 14 Aug 2024
 01:05:59 -0700 (PDT)
Date: Wed, 14 Aug 2024 08:05:20 +0000
In-Reply-To: <20240814-linked-list-v5-0-f5f5e8075da0@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240814-linked-list-v5-0-f5f5e8075da0@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=4060; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=swQo6k413j3se9yButdYhvfnah6TceJmmk7q/aYZXEE=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBmvGVcIR+udRWbqZ+Yn2f+g1A12sPAkWbH7C8Lt
 TFC+mN8PByJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZrxlXAAKCRAEWL7uWMY5
 Rpe9D/98+0m6jaOygMTBRlIaPJVGy79dX4G13YldUIQyhqT+nmbqTsyaAeXDL/9v+PocYr7pZ2w
 T3A/JNRKH5sjidtbckjVluCqZGDubN5U+02jQxZzh7pWcI/0ZRWQCkNC/MqDYeVO+mrCcwxzZAI
 OlZC9038K+BrOyoo/hPwHtf15X09bxuUR4SoeiCouyGnHopOjyvmVSPwX5vL0IfMqbwApj5+sl6
 S7s3jElQyfttf/WFT3iNjWqY3oJGRtbjCDz1m/NHO701vgJCbgaATOxw1lCMeT02a6CpM33dWeH
 rlAdJ62Fr9qNRgq5LzgkVBEE7II33V8JmQ/pggn5VsZXrw2X2WKExvmPdP6bKcHWUYL6urRNfpu
 NfPhTDTUeusOayY416A4MPj60cuEyqlIH+X/+UF4cJKPHKXvZqgGGD4442pXGcHRgU76nbh+WEl
 J0wNfbZTWI8QPXL8I1t0exVfWRGwfdWVMUagd2r5PMqVO73wIZuDwg9+XVNWzmbuyvViGBqUaMc
 dt8aIkzbXEp7DCtX99+PbZu2Zz/rUpZ+KAjcmo0mEnMk/FtVKyXjt/TKAptorwYI+hDIzDv21iC
 /8g4vMuqyXYf3uGn7tPZkHX6SjRLxELMKWZfGGRO6h8QKL00pKunR6ioP8OqCm4YtlRo9jz8m2F 7wQAwF/1dcRvu0g==
X-Mailer: b4 0.13.0
Message-ID: <20240814-linked-list-v5-1-f5f5e8075da0@google.com>
Subject: [PATCH v5 01/10] rust: init: add `assert_pinned` macro
From: Alice Ryhl <aliceryhl@google.com>
To: Miguel Ojeda <ojeda@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@samsung.com>, Marco Elver <elver@google.com>, Coly Li <colyli@suse.de>, 
	Paolo Abeni <pabeni@redhat.com>, Pierre Gondois <pierre.gondois@arm.com>, 
	Ingo Molnar <mingo@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Wei Yang <richard.weiyang@gmail.com>, 
	Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, Alice Ryhl <aliceryhl@google.com>, 
	Kees Cook <kees@kernel.org>
Content-Type: text/plain; charset="utf-8"

From: Benno Lossin <benno.lossin@proton.me>

Add a macro to statically check if a field of a struct is marked with
`#[pin]` ie that it is structurally pinned. This can be used when
`unsafe` code needs to rely on fields being structurally pinned.

The macro has a special "inline" mode for the case where the type
depends on generic parameters from the surrounding scope.

Signed-off-by: Benno Lossin <benno.lossin@proton.me>
Co-developed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/kernel/init.rs            | 67 ++++++++++++++++++++++++++++++++++++++++++
 rust/kernel/init/__internal.rs | 29 ++++++++++++++++++
 2 files changed, 96 insertions(+)

diff --git a/rust/kernel/init.rs b/rust/kernel/init.rs
index 495c09ebe3a3..1263f486abc4 100644
--- a/rust/kernel/init.rs
+++ b/rust/kernel/init.rs
@@ -742,6 +742,73 @@ macro_rules! try_init {
     };
 }
 
+/// Asserts that a field on a struct using `#[pin_data]` is marked with `#[pin]` ie. that it is
+/// structurally pinned.
+///
+/// # Example
+///
+/// This will succeed:
+/// ```
+/// use kernel::assert_pinned;
+/// #[pin_data]
+/// struct MyStruct {
+///     #[pin]
+///     some_field: u64,
+/// }
+///
+/// assert_pinned!(MyStruct, some_field, u64);
+/// ```
+///
+/// This will fail:
+/// ```compile_fail
+/// use kernel::assert_pinned;
+/// #[pin_data]
+/// struct MyStruct {
+///     some_field: u64,
+/// }
+///
+/// assert_pinned!(MyStruct, some_field, u64);
+/// ```
+///
+/// Some uses of the macro may trigger the `can't use generic parameters from outer item` error. To
+/// work around this, you may pass the `inline` parameter to the macro. The `inline` parameter can
+/// only be used when the macro is invoked from a function body.
+/// ```
+/// use kernel::assert_pinned;
+/// #[pin_data]
+/// struct Foo<T> {
+///     #[pin]
+///     elem: T,
+/// }
+///
+/// impl<T> Foo<T> {
+///     pub fn project(self: Pin<&mut Self>) -> Pin<&mut T> {
+///         assert_pinned!(Foo<T>, elem, T, inline);
+///
+///         // SAFETY: The field is structurally pinned.
+///         unsafe { self.map_unchecked_mut(|me| &mut me.elem) }
+///     }
+/// }
+/// ```
+#[macro_export]
+macro_rules! assert_pinned {
+    ($ty:ty, $field:ident, $field_ty:ty, inline) => {
+        let _ = move |ptr: *mut $field_ty| {
+            // SAFETY: This code is unreachable.
+            let data = unsafe { <$ty as $crate::init::__internal::HasPinData>::__pin_data() };
+            let init = $crate::init::__internal::AlwaysFail::<$field_ty>::new();
+            // SAFETY: This code is unreachable.
+            unsafe { data.$field(ptr, init) }.ok();
+        };
+    };
+
+    ($ty:ty, $field:ident, $field_ty:ty) => {
+        const _: () = {
+            $crate::assert_pinned!($ty, $field, $field_ty, inline);
+        };
+    };
+}
+
 /// A pin-initializer for the type `T`.
 ///
 /// To use this initializer, you will need a suitable memory location that can hold a `T`. This can
diff --git a/rust/kernel/init/__internal.rs b/rust/kernel/init/__internal.rs
index db3372619ecd..13cefd37512f 100644
--- a/rust/kernel/init/__internal.rs
+++ b/rust/kernel/init/__internal.rs
@@ -228,3 +228,32 @@ pub unsafe fn new() -> Self {
         Self(())
     }
 }
+
+/// Initializer that always fails.
+///
+/// Used by [`assert_pinned!`].
+///
+/// [`assert_pinned!`]: crate::assert_pinned
+pub struct AlwaysFail<T: ?Sized> {
+    _t: PhantomData<T>,
+}
+
+impl<T: ?Sized> AlwaysFail<T> {
+    /// Creates a new initializer that always fails.
+    pub fn new() -> Self {
+        Self { _t: PhantomData }
+    }
+}
+
+impl<T: ?Sized> Default for AlwaysFail<T> {
+    fn default() -> Self {
+        Self::new()
+    }
+}
+
+// SAFETY: `__pinned_init` always fails, which is always okay.
+unsafe impl<T: ?Sized> PinInit<T, ()> for AlwaysFail<T> {
+    unsafe fn __pinned_init(self, _slot: *mut T) -> Result<(), ()> {
+        Err(())
+    }
+}

-- 
2.46.0.76.ge559c4bf1a-goog


