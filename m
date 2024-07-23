Return-Path: <linux-kernel+bounces-259739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E563939C85
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 10:23:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C3A7B21CD2
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 08:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3899214D282;
	Tue, 23 Jul 2024 08:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FBSOxPWJ"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE69B14BF90
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 08:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721722977; cv=none; b=MOwShGDD5fN+9dw6McUCSBzuMLMiUcyjPOVWsTajtbOHMUJa/Tu1Y2nV0M51WiX90wuWi0UWaC75MVpsAhdPFmjFJxyt/3OeVzn0dhW9BuBpPVgctd6I49+yMw6EO8PNYIcOGx6HWPLi106i9XcpbplMOdy3ikgxsTLFo9av96Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721722977; c=relaxed/simple;
	bh=B29ZNDqiZR7gkJQ9AeTvzvGahFyz/8UuN8mfE9HDzks=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HbP4vlF60Z0Z70WEWzdtdSw/LL/4yJkbzA3Fe/lNxHsw6JqpPokrELhGP4I7SokLKCVlwozdxrztuGBqN3eQNezjhtGhcvD2enNekY5jCpqNm3486DS/hRBWm+W08VVmzaxeFwMWJ339zRyFlxb8oYlYPDcliq5JP99V8ecoKMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FBSOxPWJ; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e05f08adcacso11918293276.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 01:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721722975; x=1722327775; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=lKAgE1hhMontLqvxWta5AF2oEi2tCqWpiTS25A319OY=;
        b=FBSOxPWJFx5gBq3UgqvBSKR4uJK8stoRKFuWKdIkIhnxdn9Ae5TzidojOuobSF1Jff
         H4cIhjXCp4S0TIpBqVkr9VkqjcH2Kb0QbNmbqEuW/GazIAK59wqf4VpYrbVwqdDhmaxO
         sXIAMKro3St1VgQqYlEZ6LJ6vOIzlAnSitlhrDMysNpI+CL7H1RWhfVcBnftEg3kSOXn
         5+Hqfx7w2frETtaCkGKafOU+amQVE3ateUDNo1uAYmrfqkwhIML91omO+ObnvpO27dVT
         Kr4VJPdeFSKqc9YU2l1kLc6UyTg6b8LBXqLra9cxerMMqkJ0tk9Gz/Qim7eVv+/LJXWq
         HmVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721722975; x=1722327775;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lKAgE1hhMontLqvxWta5AF2oEi2tCqWpiTS25A319OY=;
        b=onEXUa7pd61D4Qo/hgq6pbYLcHCwe/Ra8apWQBg+SkfibytNCtro5tpbbrxHIbjJlK
         3ngyNohQ/bPgy5ldIUD+zv43GpWuDkH4v9z6fkrpuQ4f7YLjCzM1gfhJG4ZOZE9GNi0d
         cZi7Yi1AMDXu2qgGqwBPEE29Mv9s0em8wd3knJ4CThSa2aSkiZ0h0FdoDN9LPb4a+n4k
         3+qnRY5eDGYGgfAYOONrTHBmJgu4Xb4R9VND0lF10z0eUsnAYY9Olc/xIOmJ/vonF5LN
         n8OYBwPqGgk4Rcpc9/kbHSdPxXR9qwSB/C/FDM+Tz5Ud5HuF+NUFQZIRE9QVvYLfEb9y
         Oapg==
X-Forwarded-Encrypted: i=1; AJvYcCUDO3rZULXPa8giHoCvpyz9TdbMbHnJxvAJ0uRH5qb8btGQ85aeBdtudaNzEnn61g9H2Wx8kj2iAgsqCVixlW7Bqq2sxguU4gL3CO8L
X-Gm-Message-State: AOJu0YxUwGnc/Ri9cN15+KZ3OXx6gLbQRiOT5e4bQF9duf7eazJwsaHb
	mOlJ99sMN9Gw296mhg3QiAHX6s6SlxeJcNnRwB+SgXTkEolNnSQxbldCOCG2VnvG4pZoURX9/wL
	zc1g9r+AXFr2c1A==
X-Google-Smtp-Source: AGHT+IEPINv4EyyAutJzjmDpLTXjoGyuMMGsDbpKeKe2iRgOfc3gmLVck9mRZfAe69EaSfXr4Xnx3uFWG2YDSTo=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a05:6902:2b0b:b0:e05:fc91:8935 with SMTP
 id 3f1490d57ef6-e086fe37bf7mr190993276.3.1721722974741; Tue, 23 Jul 2024
 01:22:54 -0700 (PDT)
Date: Tue, 23 Jul 2024 08:22:02 +0000
In-Reply-To: <20240723-linked-list-v3-0-89db92c7dbf4@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240723-linked-list-v3-0-89db92c7dbf4@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=4062; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=uoexIs4rgA1q9vaVNzcAaNZWtRqNFGCqT9huoPU1gnU=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBmn2hSWfpKeIay2gf7V/WLK01LoD4w/NCj2wLF3
 TM4eb/12RaJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZp9oUgAKCRAEWL7uWMY5
 RrNED/9MqXg9v5Q9dDnwmwnmusgWlitLIDaV4mXddxlOJVQCHBAVC8JMkRYQ8+N22Kwiias5s5y
 waRuM8BojBW69i6LYstiTwfj04xykuESpeG4u8+UrVnOWnvkjHlEaQ83DIU7hxn0LaVI09SbRvA
 cCMAL0p6arOlt5Hk5y0vrZx3pFd2CEH1tmPM6naLLEMP0vUBuQ2j+xM8hjLSuiRGzllyPE6uqOm
 Onwz7yMwh96JIZOM3gUTqY0HDbG1x1Xuz5yYbgWIo48lYuQqloPTTdlY0OD2R2WQjf98W8jy3mz
 kVUjuq5BssP9EbwKEHUAXIuLb9Wlf4n81nHLV4pb+jgElDjwJ6MXj43VrY6vOmtp6qZi1wkYoxd
 OeK6boGbN30FTAxCxb2ZqVTb6603RiRgBSRRp0LqAsz0s1sYXbMe7X6VsnBgHEMMAd+FbmPwjuM
 N1WJGt45irvRWR23Vs4hba5uXG8UcCRtxdURQ9/5VIT+MoMhABFDlzKTBggIUr2cgpL8h5Uwy+y
 qXJg6hpT1CYwdlXz6EpokPbXi381LaX1OFv0wptWcCiS/v3xP+nbctzNSJJRxUbuW5kXO0eHB/s
 tcw4ZH4yRVwrr0As/YmdOBOnUnTUpCOQgM0ANgkGVn1Gkc46ZOefbXZ9vmUpoBuWANAlVQn/z/o hUR5RSxzsS9VyYg==
X-Mailer: b4 0.13-dev-26615
Message-ID: <20240723-linked-list-v3-1-89db92c7dbf4@google.com>
Subject: [PATCH v3 01/10] rust: init: add `assert_pinned` macro
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
2.45.2.1089.g2a221341d9-goog


