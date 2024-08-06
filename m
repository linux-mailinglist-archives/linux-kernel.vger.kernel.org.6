Return-Path: <linux-kernel+bounces-276354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 580FA949274
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 16:00:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD21D1F25CBC
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 14:00:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59CED1D54FB;
	Tue,  6 Aug 2024 13:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="10MjEgrc"
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD4871D54E9
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 13:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722952773; cv=none; b=SrGW/MJ5W09Hn4qLAuMyRoNXDXdSMES09JAZpCI68GjXT6EQgiYhsH4sIVp3zn87sUxqTVPLfBJHgsapOGf/jS5gf1m/WVFIYZtDtBirUoALrpaGQjpuWSjZNaJzAQmBecRNSlq47y/nIhUKyKbLK73NS/h5osvweHhYcB68XKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722952773; c=relaxed/simple;
	bh=jnKF/oyQeugfAQVgW4W1AV60+aM1DDIejGLFKTFwAuQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Hp+W0oiw0y3uNwPZM4RwykhpyXAHqWI33J22V1BIJOQxpZ1U4s0LUHmNOxbrXgCaWpFOEiCaq7HKb43xlr7X58izbHbPFugMwpvBu1lJckDnA4yPheFAwG9nkpdq9SYR4GME83XBOafEgJE3qjglDxvFlEdrukRo3ToTOVC0WGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=10MjEgrc; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-367990b4beeso461801f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 06:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722952770; x=1723557570; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7zBzNoBly2krqneRSwSfI4JKOiFR4iaU7/3GH2+Nyg0=;
        b=10MjEgrcECydPaSJOTViZTV+Zv9yMCcS81nuN87bzGyBOQg4JT7WKJYR+cQqOSx+bH
         /UN4P1nA4FcQXRwJ4/6KlU8fd3yXrhORMmvo5GlLQ4SMsYYU8rJHKvstWnWi/Ib/hLRN
         d1Tl0gFO0djNherVzW4e/Jl58yb03yKSZPZr2k2XvUy7D+XPnkrcFbH2SUhRJ+z+AynY
         Gb/ckWtjTv5LsYHjJea/S/awzaDUpYHXXLWnmq41UqZg9xfllzl99Vuk9182u7D5DBz0
         rQFF3SQqnTyVbJTxtElusBK/c+64C3Sqeu6OvnfJ/4O/YfzPUBEnCl8YMcC9tYsmjoeo
         qi2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722952770; x=1723557570;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7zBzNoBly2krqneRSwSfI4JKOiFR4iaU7/3GH2+Nyg0=;
        b=q0FZmT21/4LLZgB8kZ5OKNih7x/AnepidYWcgw2pyqja7J/qfG4hdBMvo1r6rtrsha
         l2zWbwUOI1w0HS2LzMF3H117OgM4wlJgmJVb7+BnLsGCMdf1Bv+FHihX6u9IqU7AEX91
         J3+vk9xB0fbQ8i8xyvMXfeGj7jntgXnZnWG+yJieXpSsoQ/246oey7ttaTYEUwYAuaY9
         vpfkMqYXnJqdZrla/5lDAomwhnN+QYMHTUHqqXNWhZ7aJPS8d4ad2Kjrnhurhij24rhJ
         qcXQ/BSGBuLGgbvuX21W8JFOXH3fJpZC0/0I3CN5jufj9DPtc7jVK6pXSHO7mUgHKGHo
         Gp6A==
X-Forwarded-Encrypted: i=1; AJvYcCX6KbXRQZ8jo+oHFNg2F3zv8nghCy0DWaBt+SjenjLldauvJl+iyJOKM+j7YHW04k7ArWGosjwizPhX95IjRh3gtLRYR7OuxHrjE+Dt
X-Gm-Message-State: AOJu0Yw6MDcCxT7EVIDI4jGVGWUvNpuHK6HtFT6V5a7g+65WFiUniMFZ
	DsSw2BXQMQOPtU+xMv3tdwsJpUCByzv7LydSvS/R+PpoASLnSCGYDHW7Rtme8XB69CV4TztZ5R/
	c2ULu8GqB71hbtg==
X-Google-Smtp-Source: AGHT+IHfyggQAHCMo1H+VuH8fYUdZIKW7TfKe3NVrHO6BjZxNT1rGo7TVK6+tCqJfI/7xJPbJKrteuHkqeyr4V8=
X-Received: from aliceryhl.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:35bd])
 (user=aliceryhl job=sendgmr) by 2002:a5d:452f:0:b0:36b:bb7b:923a with SMTP id
 ffacd0b85a97d-36bbc1882femr21659f8f.12.1722952770169; Tue, 06 Aug 2024
 06:59:30 -0700 (PDT)
Date: Tue, 06 Aug 2024 13:58:53 +0000
In-Reply-To: <20240806-linked-list-v4-0-23efc510ec92@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240806-linked-list-v4-0-23efc510ec92@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=4065; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=qZ9J/+0vw2xQYmgGbraO8iTE7yockKbb9UgUTf5VFEA=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBmsiw3YHCMsmdQSF7z4EpNqK59qiwpSqxeizLeX
 fV5hcUDSS2JAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZrIsNwAKCRAEWL7uWMY5
 RhG+EAC7hBj+whdtRkvtrucxncYoTz33F9resFfUqJUsEQuOurAvoRVfgeDkNJYbBPbTAMIkMML
 hdkMJ5Sh8ZLlTUEmHErIsUYWKsnZF6qHRjlNNcYNZMcqjW7vZ5vYM1vYkAnz/Ez5O7I88eBOQQW
 JeSLYLa1258RDhqsdVGYSP7tzta1Mljj/e0Twr/wLXYkkFulmqePcP9kg6f6Kxzc1/w8GFzrvlB
 tAkbW9dDl/TvkC1AU9DNEi22iqqIvAQaFWXMMbQ93/i80oGAgBDmG41XR4gzlls6IAOvteQFnDL
 LeKhjvyZLP+SjtG2WhNWDUjySiV3gsIBfQ9Iqpf6s1oo/vmVfys79mmz29v4xIG5xJ6kzVhkY1t
 kAnro5FgZIDzmNdUGc3lL4CwBqfGhc6e5R+x+BWGcIyEVnfppIKqWpRkaVHRk+rs2m2JGR+MLtH
 Y7iOZDZCnqttfLnpWJdWgmypZSpecwan9xlUuEQHiFZ9Me16BfGZN5IVkMJjByQac+Aq9TREVNz
 iZ89p5WUQ7TdZH+D9y0VIS+rA3Kibz9T3nRRB8HDYgSzAuaiJEEdXwuRfaz16dPPgknm+Jw1pMS
 8uof4s7J7aM9GwxiUVIG5Y4Uhyh6+lcqJseanrWSUUeEE/Tg9mLkvDg2nHDfSYPt/E5QnoCjMFj 7ilSFS672vZZ80A==
X-Mailer: b4 0.13.0
Message-ID: <20240806-linked-list-v4-1-23efc510ec92@google.com>
Subject: [PATCH v4 01/10] rust: init: add `assert_pinned` macro
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
2.46.0.rc2.264.g509ed76dc8-goog


