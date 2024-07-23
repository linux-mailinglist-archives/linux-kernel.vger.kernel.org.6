Return-Path: <linux-kernel+bounces-259750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07CC8939C92
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 10:25:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B79472833EE
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 08:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45D8E1514CC;
	Tue, 23 Jul 2024 08:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2rDqSbyY"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B700E1509BC
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 08:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721723005; cv=none; b=J9OfAmzC1zMNycwZ972sjOpJK/bN3RtMVaiVbWGI8naTUVavV5DBoQPbRwyI75vp6Me+jDs+Ejf6uSgsSI1RwZt1+mQWjMIKEeazRI9zfz1/YjoI07HkfcI6NPQULf10NW34CHARqqTwP+3SXwZkh8KKdgMKbNG99T1fAImuhxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721723005; c=relaxed/simple;
	bh=P4GJjcMR46AtcXwSMbkn2ALRqne3SCIpIm1LC96k388=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Ppb0MlIG9UrBkNvA5STPi/IvcADrABBh8t5chUvPFRS6x79YxHaeZSPAwz4SIzh5yr1mZsXHzB5L8Bt9eM2II+RCat7Lc5gTloLhK0AEL+Ff1SUle3hDvBxJbAX8/d45kjur/teT4XCfUpjNMO6/o3xBXzfIWOff7UbX2OVzKbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2rDqSbyY; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e03623b24ddso11274148276.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 01:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721723003; x=1722327803; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=AhyYYDQfkjp32gHrK6fI251ZMph8ENPohnNmRiSfKnI=;
        b=2rDqSbyYf5AVuu/NZSLEKXJsHg1yfuaVPhQ0/TgjjygW5SeTStxntpdiAq/aBV2p0d
         PRORgu4/v3KAQwHt3U4N3c22EC0mlQuLSUA1XD+3voAJO1LgYyNH3PvIBp4jyDqQL1Ab
         38FkUm5GlQCwvGdSWVhdiTObFTuYksSDgTYEWxTBFWLA6xtuJW3DTdInqDyxWug0B3hT
         csjx9JL0xHVydNzs5xHhIlJPuF/5wsLSTVgKybll2BorffsNHFUU4TLwVYydZXrdUm4T
         KfsmOJvAwp0ZjougSIuQeaZOGOIE0f0st7kmEGaB9F1XcwHBOLL+ZJPxd2k8QEAOrqqX
         Tztg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721723003; x=1722327803;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AhyYYDQfkjp32gHrK6fI251ZMph8ENPohnNmRiSfKnI=;
        b=VXUQRmkQ0FvIiOOpleMMXVrgVxZ9+bL1caJ3F9Rjp4iAfe9R4R9HARenwAxq7+9tfn
         HtDtWeF/DxEPwnIS4McuO1qiNYle3CCLsDgRWKAMzvVSC1Tq3YKN1GxYYqQi2b3lKReo
         nkmxot2lToIAHxuBmuyecsVx+yj1BXHpWmElzJgFutq1HRV8a5EAplN2WllgQlgzDiw0
         udYOezJ/NBz/xcSfDgPtiPevSKGBzWhw4ZPDPpdWVGOu6JsXd70p54b3vdQees9kWR5q
         51komPAQI76anPrqH1tHaNS/r4v8WK9TyqusN8jiFXvBT6o8c3/hfp+pblz+s2WFYUzu
         phOA==
X-Forwarded-Encrypted: i=1; AJvYcCVV6ZmecXQDcvVG4OwWDG1PjhJBsnKbMQQHm5czjhUEa2S6Bv0OleaKAGDbIFX5QnXdSvWadumUQbZi7fpGDG2JFLrc9hqbSiRffMtV
X-Gm-Message-State: AOJu0YzttRjaYeD/AQqT3DYTmbeNU7PEs0HRJFM/N7GzZ/Yp9RV6kZur
	0HNE0J2PQpxHSh5sDT9v5aY0hLsZ0x+quaQIjKZ0SWlDG8niy7EyEYNhw06Pe59RKGZ/l8xyZ3x
	jN3TaK8U+RDd2pQ==
X-Google-Smtp-Source: AGHT+IG6G5H67c/ash+4uWHilLseAkYsYekJmisvjTIJQ8aoyq3aBo73QFuP5o3PZ0zTuW7kBoiyNL11XTmW814=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a05:6902:c06:b0:e08:6e2c:69da with SMTP
 id 3f1490d57ef6-e086fe5929amr33578276.1.1721723002720; Tue, 23 Jul 2024
 01:23:22 -0700 (PDT)
Date: Tue, 23 Jul 2024 08:22:11 +0000
In-Reply-To: <20240723-linked-list-v3-0-89db92c7dbf4@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240723-linked-list-v3-0-89db92c7dbf4@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=5347; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=P4GJjcMR46AtcXwSMbkn2ALRqne3SCIpIm1LC96k388=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBmn2hXo1PmAC+q0DYNGOd2yWV7fxwZJyktK3qhC
 coxfhbBK4eJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZp9oVwAKCRAEWL7uWMY5
 RkTeEACq8mdJD5GbaeydqlsUqAWawFtAlK6l7GVNEoK8QnEmTFNaMmdXYa5vYTu8xyesOXilNjk
 WwgVa8HBdg5j6hx9dJLEeIpmzh3Q97hy9CQQqQyRRQRJ9Z4VpEGRJRTycjfaKzJ56HRGcWNT2rL
 wMUHFwTdEpeYq/GlzdWe6SL+3HpqeP0O3JODB4+e0PaB1oHcCBA10CHOvYCaI8EwJVy6ogXGMvM
 dsjlztvnUU4txnkXZuioHELL/b076czFo5sZdJR+Sd2G9Prn7gi0fh0YD1VIq/gHaz0PyFM9MpD
 sicSM6S1AKbf89y7iZuLLcp1Bgv4i1fJUmHcy3CDhnfNdDt/1Sb9N7zydNfpBLx6mZReP8zh0Xs
 Ocm5L8olFGQusZVhDGAEMydJxNmqFyDGpl1+zKNU1A5XsIyN0ANHdjIJjX7gYGTz/xcAYURhimf
 GA9kWJjBvL4/A5n8doAGG/eXyiUZI4ukSJteBEqOISMt3GIF7iQv4J58wRZOZqzQ+oo/Av66NHE
 4Xl1yCYl4C2OqVLETWm71aIJTfWLuGCbEhH6UMdMMrImU6AMdvn5F7f5CzvTqVfL82XZvVvQxu/
 sP7LyVpLs8+m71NyvXtnv9SNbi5U4iAu32Ka5zinQ8Z9ncC4naU6DqTx3WkjLibRy29IzovVt6q bIe6EbWfbFI6bWQ==
X-Mailer: b4 0.13-dev-26615
Message-ID: <20240723-linked-list-v3-10-89db92c7dbf4@google.com>
Subject: [PATCH v3 10/10] rust: list: add ListArcField
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

Reviewed-by: Benno Lossin <benno.lossin@proton.me>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/kernel/list.rs           |  3 ++
 rust/kernel/list/arc_field.rs | 96 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 99 insertions(+)

diff --git a/rust/kernel/list.rs b/rust/kernel/list.rs
index f61b19c145db..e8031bb3a94a 100644
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
2.45.2.1089.g2a221341d9-goog


