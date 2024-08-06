Return-Path: <linux-kernel+bounces-276363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90B8F94927D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 16:03:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43F8D281F30
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 14:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3960F17ADF1;
	Tue,  6 Aug 2024 13:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="T4E2xdi6"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62D3B3DABF6
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 13:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722952795; cv=none; b=b6BCfg44059dmVhAX4NNvASNP8d0Hny+ByNDUvJsyXaEa3+Fz1QYlLHFST7gbCnMIOF/YAthVbdxIQIjBYqbSp5toqp+WgtvqvKamSLNMEz8Ne06+oKumRd8BRuJ8vs7ijXO50eIH1CfJ7WYLdrdLjdZFSJB70oLSo8d7PqVuyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722952795; c=relaxed/simple;
	bh=sjs5+cx5RsK4I10owZyIhjJWj92izcNKjyfWK0eU9GU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YfePQom6W9zD9Qe6IjHk+RbD6Jny6d7PDlMSzCp6WvlM3PkXDutwjl9uw8cvNTp4DWk3NT3NHEyvRu+c66ddBt1XFjLfmVriw7S0HZayEUGG9psgiS2Zdfz9y4rXYCcjqsd7yVCkhqshzrFIi8vW6xf21CYAjmz86RCLabl3rFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=T4E2xdi6; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e03b3f48c65so1096605276.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 06:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722952792; x=1723557592; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=RSHT3FWCrBiqXPsNuRM6ONtDFcAm4Iow/SptrIyizP4=;
        b=T4E2xdi6Q5R+BtLok+JhEqhGqm0MmbvQWxG7K2qdHrndumOwWJylWqkaayQOUUf3uG
         31Bzf2g/RU4RbPaAKdKWcJhTodj2TmWSqyw4QjqC1yN2yQPk/eT+hN7fmxJHgqBoRFe4
         HweWxt9xb9PTV61M0ammgNXiGlkL2gUFJ7r1PNo0M/SDRdYmmfKC9Ai1+lgLirBNAZ9L
         W2DiSuam4qrv91E4aCAIOCLEge0nzQTRr59vT1GZyUn7UOC1+YZweQSfY3r7el++wLxx
         cDtdaLe4pw+YeeE4eBL1ti6abucdDa4Ferv1oq9O4SXGRAZO6AxzQUDKUGzYQnNcosYl
         nhUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722952792; x=1723557592;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RSHT3FWCrBiqXPsNuRM6ONtDFcAm4Iow/SptrIyizP4=;
        b=vvbbQOpLmnfXvsLHpGiNNh1JXX/I95Q4hKRHyAL39YArachUZAMHFigNb0iVCoGVhL
         gbuFDY+xi6SQCHsfTPjjjvuZNNwHIrtxwidAxfOhVo1rfmLmhh6gDBHm6hS8ftFEgpCZ
         NHAEd2H+H4V3pZ0wg1VtbKGI2jYWwid0R1i+YFLQecWT3Mm5gMf/SzA/2xV14tizLla4
         LX+3z7uH8pqXsj0fg69P7V6MwP0UDhl0N7ryGsbGqJNodn6yUTsUMmg1zcHuUQs6w4kK
         FSvjSc6kNTuy8RjsxPGifXoMkk4OSLERtA/SWrGEbB91uwtgjSnNhin9L36uDVa0tK1o
         IDCA==
X-Forwarded-Encrypted: i=1; AJvYcCWTHSsr5p2/3E5Zic2xFcWR1BE5GSR77iWNz1PEHf/7n6YICaCd1clRsD4/c0A3EemYB0oRYOrXMsRaTYNzt2/l1JbrzQBhwmuf+BQe
X-Gm-Message-State: AOJu0Yz1Q33TRCMCTRyOPXVpePUTrxjuXHAsUfXO1YjEKnPSZSVuwvr8
	/+yE+r+IkT33eNEtOGC/zq986FpREbZe7ARSffQSdwzpMQolBv7MAiFoCnWzRVwH/caM7cfLTDo
	v6qiBjICBwhx1vg==
X-Google-Smtp-Source: AGHT+IGK3CoPkJd39xnjiPgyg29UTNJbe2DuQKHixP3ZF4Qqay5YuUYU3D+U0KziAQa4gcAj3c6RtdIOIt3h0tw=
X-Received: from aliceryhl.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:35bd])
 (user=aliceryhl job=sendgmr) by 2002:a05:6902:2483:b0:e03:a0b2:f73 with SMTP
 id 3f1490d57ef6-e0bde2f3cdbmr112477276.6.1722952792116; Tue, 06 Aug 2024
 06:59:52 -0700 (PDT)
Date: Tue, 06 Aug 2024 13:59:02 +0000
In-Reply-To: <20240806-linked-list-v4-0-23efc510ec92@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240806-linked-list-v4-0-23efc510ec92@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=5366; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=sjs5+cx5RsK4I10owZyIhjJWj92izcNKjyfWK0eU9GU=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBmsiw95qN0U65sxn3WNBTslbzyWYYlxLIS2QYlL
 KrVxm0wgvWJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZrIsPQAKCRAEWL7uWMY5
 RknPD/95GFWviEvAvGiqrlvWy9Dct+g9YPZ7uZx4exk0nGLduAyqEWEKPkGX01jgDxTSRxAV5eV
 Ed7LOHsvGXL7tBqehry6mzHyqwNRjdAjZwJvsfFTPZXU6nRaarN5bnlMo7YP5p91QlorWU5b2VX
 8OK6kqM7qGoni+IOoYoPmbJ9Qk9FhdZxjSoj7c/wlAmf4D42z0zd7u+JFkqOL9K+TOpdqfGkze0
 SvmmB6RV0HdNYOTGLWMzGz76SQMb+xjkwEK4JefF2sEXyvAAPPbKfPvpWqnc6U+7spKSTKRoKig
 F1wi9ZRNt51Jkwd+DMQPaDXZcBgl3DonqbQbhiqB+IcfdvSYunqPRCcjaK46nco9oxrfeqBbmHI
 nQMKoKLBSFZBiM4EX+HRkySBEXTObAVDkd7cOv/2ukt8vHLoSCSnTPeFmChapaeNNLIJBzH4auL
 xg1OYcslvWZ97ah+kTsbCR0ZaFgVuI5AU7soFuQIsd4tJ3T3GUHi1MCEiNQrHckMqO8u5BNLgcO
 rOfd8II2QxJPFjgE4VJyMtOKF9URrnXSf0zaeLe9NrR9uZgFjcHQHHCGQwsiwHE8DPJGFAY+i9x
 r+c/lXGWLYvr/EEYT2Xxt1oP6CID4hxaG2X6P3NTJ8hl3ka5rXDih6wyskm9vVpidJKNBCXzAEw FYMJPL6lhGT6IsA==
X-Mailer: b4 0.13.0
Message-ID: <20240806-linked-list-v4-10-23efc510ec92@google.com>
Subject: [PATCH v4 10/10] rust: list: add ListArcField
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
index cf26fec37c1e..e4cefac0f390 100644
--- a/rust/kernel/list.rs
+++ b/rust/kernel/list.rs
@@ -19,6 +19,9 @@
 mod arc;
 pub use self::arc::{impl_list_arc_safe, AtomicTracker, ListArc, ListArcSafe, TryNewListArc};
 
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
2.46.0.rc2.264.g509ed76dc8-goog


