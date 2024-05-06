Return-Path: <linux-kernel+bounces-169628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BE1A8BCB54
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 11:56:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CE0C1C20DD1
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 09:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FF2E145342;
	Mon,  6 May 2024 09:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yhsmoglW"
Received: from mail-lf1-f73.google.com (mail-lf1-f73.google.com [209.85.167.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1D03145340
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 09:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714989256; cv=none; b=KY3oSFW7IM+ZxDxWlgJj7K1QYIlWYkBB5BDRJ1Jy4nWfH+pqOkI56D80QOEIYftx7WG7f95f8Uh5i2p0qmhzagEAN3yVfZzgt6gvhIiQbjZOVGKCLvMedWt1e/eJ6hfIOF13qUkFcshNikutn8CZdd1pVZrIBaOIJHUCdskm/JQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714989256; c=relaxed/simple;
	bh=W+uP1Xzo0QGwIGIjvgjEQaM3hRC9GEBc2dTf6jeCEAQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GlE/HUwJSnogdMwnjy120//PdIonSyVF431EUTWh2aSn0ifddES/6oY9NBic4wqaFuyParkrCx477bN6lYTDZD2JWwRPbj6bKqjALLWxjiYgxR77U1E+ODnArn5dA5C55Z5720T2ms0/zPaihB+owZDGaRP7ZEzcVChmoWQwhH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yhsmoglW; arc=none smtp.client-ip=209.85.167.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-lf1-f73.google.com with SMTP id 2adb3069b0e04-52025c91485so1089468e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2024 02:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714989253; x=1715594053; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=EFhgl6guD2GoA3y7AQJ34n3OZOg5tBWu3g1w/ea5Ugc=;
        b=yhsmoglWa9q17WtS+AYhoBJlnhnMi4QliF5yuowiSK1UqDs2Pf9dyJscjelGG339vd
         8XKuGroW56oLYystTSgqAN4hDunYHNO/fFwlDzjbQT2dPHuaZkuhNZS7fJwlucTdq7t3
         TW2r19KMOonE9DSE+3W3vviJHD24BlUhq0scMDpLK5G2sku8+XfZASOpPrRT+T4zR6MW
         6iCSQ5gUdUO9B7K8adWrUtv/ka+DOA5Wwq+IkDovl/66WbW7wpo4ele/eRbTo8xLZPdD
         zeqHy+OxhqLAJFPWIpQKEJT5HroO/o9Axs5uFXOTmULwRPXvu47pUR2GHKGoPr9x2UIV
         AcxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714989253; x=1715594053;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EFhgl6guD2GoA3y7AQJ34n3OZOg5tBWu3g1w/ea5Ugc=;
        b=BtMluvJERK9dCjYfsF3+phZZwI/H4kzev3O9FWWXQChRZ3tmPwJNyLuNxvF0c+mcEI
         q/4tQT5wUpq861py6wx39qWfKcQCaHzN+Djdqe+5UquJwSJ2JcGi0MdPmuAdhaP6pnZB
         OMPdapFNvqQ1tjRoR3iM5F2/VtAdC4uXnsle1kIQ76KrzYhhHOG3P6PlU4wkr5yBRwk4
         wmXIfnlZgigZ7lT/eC669NNRBpGDboycXsAhxYJu0DL9wuDoSuCINCZBuLakzfFXnZT9
         bGs2OlzzDrvT7hr4/zW2WBqCZBNaVjMN8fsjMySDmeF8SuNhmXcoYv0CjgU/zihfsE9b
         KUNA==
X-Forwarded-Encrypted: i=1; AJvYcCXNd9ycyLXgbFoBZO6lWfWGN9GkJC3wEWRQqZGZ3W6utIKlyj6EZH3m1PyiCvyFCRRX+/75YIpVQslv9XWALjga/WH4b6Vr81Wc9XdF
X-Gm-Message-State: AOJu0YzC27wuk9x8T60spUccdiarDZtDf8PGORkzfrP4h4A8dOHB/XrO
	UFR1CIUiX+aBxKe9838oauzfF5UoIJO7HoiMp5YaFrsP7JMRAcrJ1/cZtHyhnbuLtpcmRO64gjP
	Qh5A3W4efKxOJBA==
X-Google-Smtp-Source: AGHT+IFxQtIkICEgPtZHYPEZWh098J61GE/MO3Oo4IR5rCHuzox04WC7mgPH8Mbq6LEd/92R9vCy0D7WDptcaes=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a05:6512:481d:b0:51e:2f65:6343 with SMTP
 id eo29-20020a056512481d00b0051e2f656343mr9707lfb.1.1714989252940; Mon, 06
 May 2024 02:54:12 -0700 (PDT)
Date: Mon, 06 May 2024 09:53:30 +0000
In-Reply-To: <20240506-linked-list-v2-0-7b910840c91f@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240506-linked-list-v2-0-7b910840c91f@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=5298; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=W+uP1Xzo0QGwIGIjvgjEQaM3hRC9GEBc2dTf6jeCEAQ=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBmOKinNQFA7Dt4Jiu7iDKcG5Nh1AAMez0H+o1lT
 97GWD9bPgOJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZjiopwAKCRAEWL7uWMY5
 Rrs/D/9LmjqabenKG3DQxazA8r5i8/Q6QDUsEsQreqaefgXZmOy82aw0Mm5kjM0qKE7KEozdvna
 7TmcuMq3p7FkN27/RBZFFVZhlAC28DbrowKAOhKltU5U+DHdsWhWBQu7iMf5EBY7/tO+99JsVIh
 dHXbWnP0m+clnh2dVFsjxHfGvsg1HsUtiNl/8e6LOYO8cSdvN68aiLbvlpRXshA2VOruETq5DKD
 4mo6P3f7VXTXn2GKuMLS/4ccQ2B+JtB1Ek9lNH1T13y19hlfiXY2sA0/AQnmywQst9Wq3T30w6z
 hJ2PTrvq6fSxstTjSERdKZzltPylLb6dlbdSrAxg32fS0PKehnHEO9ijSvTtC1Gvo6VLGWGlgd1
 ZeEmK5O2zGXOOxRghCs2qMLCUIDutdHiptG4vuI90sqOby2y+jmtwn8Tm3odmb5OdGvFg0WfyAS
 6Vo8EjW5uuqyN+hvf7bsfDgegDScTjyN27WimpBVqCLfDnnGLpYAddj9/CzNukVoNSHXRMeaJvP
 ZhHz9QsIPzyfY3QYczA6XEIDFRilurvWB1iMzzJoLmiuKNo7mlcbzU5/dIA0MfI9HCNL0NuTJe8
 dGUwcFxeYAFPmC1FRfug9M3a6pjVRmvnv+cdXXhBm0dSdTGDNPY+MOCIl3PMwm6tQ84wJufaViU YhF9Jz3YQI8y6Pw==
X-Mailer: b4 0.13-dev-26615
Message-ID: <20240506-linked-list-v2-9-7b910840c91f@google.com>
Subject: [PATCH v2 9/9] rust: list: add ListArcField
From: Alice Ryhl <aliceryhl@google.com>
To: Miguel Ojeda <ojeda@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@samsung.com>, Marco Elver <elver@google.com>, 
	Kees Cook <keescook@chromium.org>, Coly Li <colyli@suse.de>, Paolo Abeni <pabeni@redhat.com>, 
	Pierre Gondois <pierre.gondois@arm.com>, Ingo Molnar <mingo@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Wei Yang <richard.weiyang@gmail.com>, 
	Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="utf-8"

One way to explain what `ListArc` does is that it controls exclusive
access to the prev/next pointer field in a refcounted object. The
feature of having a special reference to a refcounted object with
exclusive access to specific fields is useful for other things, so
provide a general utility for that.

This is used by Rust Binder to keep track of which processes have a
reference to a given node. This involves an object for each process/node
pair, that is referenced by both the process and the node. For some
fields in this object, only the process's reference needs to access
them (and it needs mutable access), so Binder uses a ListArc to give the
process's reference exclusive access.

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/kernel/list.rs           |  3 ++
 rust/kernel/list/arc_field.rs | 96 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 99 insertions(+)

diff --git a/rust/kernel/list.rs b/rust/kernel/list.rs
index 3e687401c6d3..d88a4c0f5c31 100644
--- a/rust/kernel/list.rs
+++ b/rust/kernel/list.rs
@@ -23,6 +23,9 @@
     impl_list_arc_safe, AtomicListArcTracker, ListArc, ListArcSafe, TryNewListArc,
 };
 
+mod arc_field;
+pub use self::arc_field::{define_list_arc_field_getter, ListArcField};
+
 /// A linked list.
 ///
 /// All elements in this linked list will be [`ListArc`] references to the value. Since a value can
diff --git a/rust/kernel/list/arc_field.rs b/rust/kernel/list/arc_field.rs
new file mode 100644
index 000000000000..2330f673427a
--- /dev/null
+++ b/rust/kernel/list/arc_field.rs
@@ -0,0 +1,96 @@
+// SPDX-License-Identifier: GPL-2.0
+
+// Copyright (C) 2024 Google LLC.
+
+//! A field that is exclusively owned by a [`ListArc`].
+//!
+//! This can be used to have reference counted struct where one of the reference counted pointers
+//! has exclusive access to a field of the struct.
+//!
+//! [`ListArc`]: crate::list::ListArc
+
+use core::cell::UnsafeCell;
+
+/// A field owned by a specific [`ListArc`].
+///
+/// [`ListArc`]: crate::list::ListArc
+pub struct ListArcField<T, const ID: u64 = 0> {
+    value: UnsafeCell<T>,
+}
+
+// SAFETY: If the inner type is thread-safe, then it's also okay for `ListArc` to be thread-safe.
+unsafe impl<T: Send + Sync, const ID: u64> Send for ListArcField<T, ID> {}
+// SAFETY: If the inner type is thread-safe, then it's also okay for `ListArc` to be thread-safe.
+unsafe impl<T: Send + Sync, const ID: u64> Sync for ListArcField<T, ID> {}
+
+impl<T, const ID: u64> ListArcField<T, ID> {
+    /// Creates a new `ListArcField`.
+    pub fn new(value: T) -> Self {
+        Self {
+            value: UnsafeCell::new(value),
+        }
+    }
+
+    /// Access the value when we have exclusive access to the `ListArcField`.
+    ///
+    /// This allows access to the field using an `UniqueArc` instead of a `ListArc`.
+    pub fn get_mut(&mut self) -> &mut T {
+        self.value.get_mut()
+    }
+
+    /// Unsafely assert that you have shared access to the `ListArc` for this field.
+    ///
+    /// # Safety
+    ///
+    /// The caller must have shared access to the `ListArc<ID>` containing the struct with this
+    /// field for the duration of the returned reference.
+    pub unsafe fn assert_ref(&self) -> &T {
+        // SAFETY: The caller has shared access to the `ListArc`, so they also have shared access
+        // to this field.
+        unsafe { &*self.value.get() }
+    }
+
+    /// Unsafely assert that you have mutable access to the `ListArc` for this field.
+    ///
+    /// # Safety
+    ///
+    /// The caller must have mutable access to the `ListArc<ID>` containing the struct with this
+    /// field for the duration of the returned reference.
+    #[allow(clippy::mut_from_ref)]
+    pub unsafe fn assert_mut(&self) -> &mut T {
+        // SAFETY: The caller has exclusive access to the `ListArc`, so they also have exclusive
+        // access to this field.
+        unsafe { &mut *self.value.get() }
+    }
+}
+
+/// Defines getters for a [`ListArcField`].
+#[macro_export]
+macro_rules! define_list_arc_field_getter {
+    ($pub:vis fn $name:ident(&self $(<$id:tt>)?) -> &$typ:ty { $field:ident }
+     $($rest:tt)*
+    ) => {
+        $pub fn $name<'a>(self: &'a $crate::list::ListArc<Self $(, $id)?>) -> &'a $typ {
+            let field = &(&**self).$field;
+            // SAFETY: We have a shared reference to the `ListArc`.
+            unsafe { $crate::list::ListArcField::<$typ $(, $id)?>::assert_ref(field) }
+        }
+
+        $crate::list::define_list_arc_field_getter!($($rest)*);
+    };
+
+    ($pub:vis fn $name:ident(&mut self $(<$id:tt>)?) -> &mut $typ:ty { $field:ident }
+     $($rest:tt)*
+    ) => {
+        $pub fn $name<'a>(self: &'a mut $crate::list::ListArc<Self $(, $id)?>) -> &'a mut $typ {
+            let field = &(&**self).$field;
+            // SAFETY: We have a mutable reference to the `ListArc`.
+            unsafe { $crate::list::ListArcField::<$typ $(, $id)?>::assert_mut(field) }
+        }
+
+        $crate::list::define_list_arc_field_getter!($($rest)*);
+    };
+
+    () => {};
+}
+pub use define_list_arc_field_getter;

-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


