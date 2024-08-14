Return-Path: <linux-kernel+bounces-286069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A3DE7951625
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 10:08:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3402C1F224F5
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 08:08:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A73714A4C3;
	Wed, 14 Aug 2024 08:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CsEG1bub"
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66528149C6E
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 08:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723622785; cv=none; b=U3hS2xNoCuVo2rg4fkCVHF/i0Qm4DPoOtD4wyq3DeKSjd/03SyeP5UvF1o2SJg5FNkAMxVaqmVwQTKf8a/OzK8dQ+sFFMTwEm3QvEncf7E5OdQp53yaWUdBLrAapDPxvli6gCqg7YjPNsssKlY6Xa5TtazKGdF2XjDkL5CYaL5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723622785; c=relaxed/simple;
	bh=23htzdPkrIBuzSbwmb2DpGXd+teL3V6vJsnxeIFBMn0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GaYZ78WQXX5uTQoI4XId0+Pb5cG16rT83xD+RxSo6b9+KUR/4ktMDIki2SWWY7cEQE21TO9DiGRcGjrmvqcgO4oeiW9IPueAifMcy/GKSZ00KT5TXTW2H2/DyQRLjQKSmBivH+xqPyJlrb76ogV5x83ouWssJ9/tAImWgg4XYOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CsEG1bub; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-3688010b3bfso4255062f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 01:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723622782; x=1724227582; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=G+5F6LU/OcA7Gz9zYCaBXloVPCpdqosC0u282L4bOXQ=;
        b=CsEG1bublEo1bjEs7WT4oK1nYFhwIQaImeoqu6spRZBmiNvENT/NBTCzKXGbGlmlb8
         wUlg3TD+Ss3OEQoM+t2VPmEXD4pTOFxNGiiABZKsyjj0AYBsmnCPDIkiPYEATE1wUWJx
         Qeazveol5v3A8X6zU98lk2ogfckk1ZTVsy33Iu2Q61rjERBYIxC7BErucB9HRC29JvVc
         VKNL2VFJPQxTd0vsYjRdx0N2vjcL+RwKODhakU4iwA92db5Nfx8Lu5hyd63tXgQOWNRG
         D/ur1cE7+syFkvccwQUah8f3VWKTI8RXGOKbJkpPUvE2FNYgZ5MJ/P+FFvv6rXfa5Mr0
         N9uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723622782; x=1724227582;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G+5F6LU/OcA7Gz9zYCaBXloVPCpdqosC0u282L4bOXQ=;
        b=mv1AgeC9EXsRKEsR0TfWO5k8B5vd3aDmEkyRKOV/hWdRl51s7n8ZRMV5bOzK7SEn5Y
         GR8RLvKRuDQLN5/f7LMqRKJAwLB45cG93t0WIvfFxQyl2RlfFaRDVW/G1Q3apcuPDjoW
         rvC9dOos75K/0brFXi8eoyRvEpgHC90E/ChiWc9Jt8QccKB6DfRTAA/+KRea0ejnOM5q
         5a6RjdFr/HJfCu4S5b9eOvZe0zEvM/L6QWN8JLQdMxuwcgoqxa+xoLeIbAIOFrwvjDzS
         84F4CkkQ7CSjYSEOnGKsCFHVmDe9GhSp7NNo0EXPtFsDxaqLmK8M+LOw7Sb10erkJ7Zd
         /pYQ==
X-Forwarded-Encrypted: i=1; AJvYcCWlqicMVDo1o2sk2+Q0d48LRA7gjENR0FSWaUGnfB9jKxIB4gCdAaA7CuSrBunmYORFsfp4K8Ic3NbvUVU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5Lq8T4mZFxEayRrYmQw50Zuy6e4JNNv21huVkTWmXW4s9M+EZ
	o2JZy7Gmc8qBj5mhFlxpqNyOyTUul+NuYkhaZC6yb3xWm91et/s9I0Y/R23JVaTUHCfHr236iDS
	ZEVswd+7SEjE1nA==
X-Google-Smtp-Source: AGHT+IG4+uzs9JFoN8ApOz1EGDBkax7+lwA1i+qa4gBdfEeEUziZccMcI64ZxfWnhlBLnsVsnpcXULhDkh4UkjM=
X-Received: from aliceryhl.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:35bd])
 (user=aliceryhl job=sendgmr) by 2002:adf:eb01:0:b0:367:96b9:d06f with SMTP id
 ffacd0b85a97d-37177828450mr4127f8f.11.1723622781382; Wed, 14 Aug 2024
 01:06:21 -0700 (PDT)
Date: Wed, 14 Aug 2024 08:05:29 +0000
In-Reply-To: <20240814-linked-list-v5-0-f5f5e8075da0@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240814-linked-list-v5-0-f5f5e8075da0@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=5361; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=23htzdPkrIBuzSbwmb2DpGXd+teL3V6vJsnxeIFBMn0=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBmvGVh4B7ecG/0WoAj9SNsZ3AW95MJ+LAZH4Xw+
 vx3fBmV8J+JAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZrxlYQAKCRAEWL7uWMY5
 Rj3uD/46bS2kk5jHziMtHpjUpKC2bjCl21bUHG373S8vxIE7H6O66RoyceGwjifV8eR8UPKyobI
 Jki1fSlFhS8ZTh9AUlVYCgsqJ027XiWqJJJQYwYwa/dS/ocBpqo/AVGxrV/NdhaMaTV+Xa3U2sH
 krtuUk4l0MuCQ2oFeqSjHbc0QiGkaogGeXSC4VluG6ajqqci92McNgVkCsolgpV643VoSFGqS43
 iD5Tqp3l07B8DgS2OVte0Bu1WINvFkoscJKSN/RhEkqqSTCuFGNfQ4whE1BfYvL2sXXtDxyLMrr
 UnW+XWCALEU3uBTqy7CEYXmKUxSUc43I9j999kt/fP5Ed6IzUUAB4e+Tq79gmK8GPQMQE/zKsUT
 3O9K4+8hlR63A0lAptwajlfXOFShK/o1lEKb0sJ3HHOYaTVW6sFVB7gmO2cmTztuZsQ5xYOPsIA
 iKV+jgQD/qBwzhX7q40RYhFHaZUj7zcQflw5aevYB8OVH2CWPD6sL4QClxtlVs1bEypXeDPr4QY
 yifwiu1SvfR3XUX2YjnGQl5vFGDBbXJVuN777gPb8UVFeO3NLu7xyOI71Q/MzMSDC/JKUJMUJqD
 PrnSyIyr4byQ+5w7pVFaXO1cMxfdXAWNh+y2HgPMwzu9chRUibgPXwu+90PUf3YUzOm/SaKYtFQ hFPDjShEvHF9HOA==
X-Mailer: b4 0.13.0
Message-ID: <20240814-linked-list-v5-10-f5f5e8075da0@google.com>
Subject: [PATCH v5 10/10] rust: list: add ListArcField
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
index 8946c6c92521..88fbf70bdf4a 100644
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
2.46.0.76.ge559c4bf1a-goog


