Return-Path: <linux-kernel+bounces-259747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AE621939C8F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 10:25:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C2D8B220C7
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 08:25:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47E7014C5B5;
	Tue, 23 Jul 2024 08:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3h9C3zWK"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E0CE14F12F
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 08:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721722996; cv=none; b=VCbL6o3u8ouMVOUk5JT8cu1L5Odk+DxU0j9JXug1lKw+oXq7Oj0ScaqbDJjStvoRrg5GUEBaiX5QofMlmuHTwOUxRVX7W4bjWoO21+HrPH+eUAWjBGgTx9zhC0j+WBDQ1jI7evtYlSB/iL0X/uW2E1TATbArjKoeYyOnR/OtalM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721722996; c=relaxed/simple;
	bh=yg75c+W1eHmcUh6XQTFsaiSkN/WH/Yg42MPoMls94XQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TUxfFVIIN9mOOTznpgJVpr68acxqkIkX45rZQspx2OyHwmhkAmjne8G8safJOcq3hVOvKGm9f4MxmvoR8Xz3zq3H9uyoDhsKOunLqWLrrusLx7H4q0X6dMBXo6m4ZAp8gGPEv/8FybotZkoWrtHqRA5mE9Y3hXIPu5ww5FPrWdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3h9C3zWK; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e05eae12defso9943043276.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 01:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721722993; x=1722327793; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=tcZ7Zm5VQO7GwdFeiWI47MTbabJd70KzY1xKEHxQP9c=;
        b=3h9C3zWKs+WHtNIkHLGKhx6TZ0sA41x78DdtLhfcum+3HGWq2NumGb0CKBlQm6Zouv
         Uz26hTbSInXWVDKH7Usx6M9nzZDCb8LLIDfQnVp+iMPQNTQ1f/hDbrZ9C6llLaYjcWeX
         KoE4AiJ2CRvq1m1jJXPRSJrpQdbdNd0a6CXBnZy1vEOxNG6wOJaYIZ7xsFQ4msLQ4I/q
         4W42p/Ft3LMggcPk8V56Tymj8dnoNKS4+vP+kuEPm7C5D4FZAtjQpreg+Ra8YVP8OR/y
         q7m2cRrrLUXHAaerYrTrSxPhWTFubePBR7GIoTxTKkZpe9XgY+0Vhp4PbraN7WfEsNaC
         gbxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721722993; x=1722327793;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tcZ7Zm5VQO7GwdFeiWI47MTbabJd70KzY1xKEHxQP9c=;
        b=nk24jvmjjYgqluorTcGsZ0ecMmcSHNwEinm9cPyt1vEAWg/jY+LrtJPfOzrLSrdYXh
         mvoJdNIPsHRJjhK4CusJ86FuSxf3adOAPN2MZ3xfDhBQJdsYS47F6ZkmVyOvhGujylhZ
         L2wTHKL0R0Ow71gInRjwFKxm5bVAIjfUSqScz8zW6h7zg+/aQUw4b/KJ3XC+jNn7uHR1
         jX8iZrimrt0mYkdbFyM98HQ6DU/y964/HNxlkJ0VbxyUyZmdwIL2edtiNc9EynbsDMt1
         lqPu0B9WOSlfjLnX3+Y69CvZ//WnbVQc3xLN9R+68DAdjdjDXJRFV6ROgfCjyDrS67ZA
         1gKQ==
X-Forwarded-Encrypted: i=1; AJvYcCUj2I6/OqHyKZyqP+ynsjIDBEoPabtt+azLZWByjw48wK2jCuKAyRA0CnkjZEOOZiN+JaegHKXqOZvOnxwjC9U6qwsBBIfGjYXhXAuf
X-Gm-Message-State: AOJu0YzptpRKFhr7A/U84C4czywA3iZqOuoPIwTntr7JbJvQoEm45evR
	1upQnRsKo1bRVaShRe8iJlE8nVCq9orrYJj7PgnEfdQ/LDCdMn5dpfujnA28hLyhnO85BKlEJzK
	HJJkehSD2+MqSOA==
X-Google-Smtp-Source: AGHT+IFcZBOUuldUyrZ/nC+GBhKsp/SOAJzssCONhYZVZO8dbhxu3yXfTLnyzNLBTT8kWbI+6xhmwkg9vxIdC1s=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a05:6902:2b8e:b0:dfa:ff27:db9 with SMTP
 id 3f1490d57ef6-e08b989f5fdmr100844276.5.1721722993142; Tue, 23 Jul 2024
 01:23:13 -0700 (PDT)
Date: Tue, 23 Jul 2024 08:22:08 +0000
In-Reply-To: <20240723-linked-list-v3-0-89db92c7dbf4@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240723-linked-list-v3-0-89db92c7dbf4@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=5027; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=yg75c+W1eHmcUh6XQTFsaiSkN/WH/Yg42MPoMls94XQ=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBmn2hVY5aMLZp4Cjqm6xBxmRD+EmxL3JcQWyPuC
 ZstqJMWmQuJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZp9oVQAKCRAEWL7uWMY5
 RvzjD/9maKEceIFrHCcotW18lHOJMHwE5uxCMbRD++60fWoosLMEY27NaPRda+G5QOFJGlaRQAu
 55tFklAIQzLQfnnGAt30e4xagsbvhwV2oTam3zVfV/iylrxIwghHuWE1GzgIiJo4tIHDHCuj9yy
 k3neTOYs6SIzCX6Jfls//scpJzCfmLpku5nnKPMzQKSTDggHL1Ua1+qsfbeH0PhnfC9RvR0Ihip
 lAPOx/Nv1e3/+UT2RJF2H1pZV7GpWYQOK9xXTHPP2iB/T0srqej/mBtdXwD682XDIKPkDYx1QUh
 mc/dJyC0Yj2vSo+lSWoCpEyVQtF+GAZ3haBGbXwQIE+PBprso13FF2WnQU9fGz6BNpZSEz2yxYD
 DIOOLZUVQ8df8exSH38n719SoDK2LL24sR6nKaJzVjER+CvnwVX6eRpS2k3aOFnFXwBqcVdOwE4
 4QTE1p0bd2Hev50lOERKSkI63XLpoNG2NRX7bhfdYiqLt3WGxU8xynuXm/Hw0fKzlQF9uic6eOD
 govnO6fbRKnbgjNBUFS02QHU51HvGHfiJxgkLgtx/2hh6KMNahJMDtnqzHfnhBV5dqqJi7LCywu
 hFfFGLYfyRC7vWUSmNo88v+d1THgQJKXadl1nmSwIEtZ4LqBSpolbj73iOYrlhJTic62faVnJiV arFAqNHIbsyZZwA==
X-Mailer: b4 0.13-dev-26615
Message-ID: <20240723-linked-list-v3-7-89db92c7dbf4@google.com>
Subject: [PATCH v3 07/10] rust: list: add iterators
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

Rust Binder has lists containing stuff such as all contexts or all
processes, and sometimes needs to iterate over them. This patch enables
Rust Binder to do that using a normal for loop.

The iterator returns the ArcBorrow type, so it is possible to grab a
refcount to values while iterating.

Reviewed-by: Benno Lossin <benno.lossin@proton.me>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/kernel/list.rs | 102 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 102 insertions(+)

diff --git a/rust/kernel/list.rs b/rust/kernel/list.rs
index d3f8e38d9ff4..e320da063c07 100644
--- a/rust/kernel/list.rs
+++ b/rust/kernel/list.rs
@@ -5,7 +5,9 @@
 //! A linked list implementation.
 
 use crate::init::PinInit;
+use crate::sync::ArcBorrow;
 use crate::types::Opaque;
+use core::iter::{DoubleEndedIterator, FusedIterator};
 use core::marker::PhantomData;
 use core::ptr;
 
@@ -436,6 +438,17 @@ pub fn push_all_back(&mut self, other: &mut List<T, ID>) {
         // INVARIANT: The other list is now empty, so update its pointer.
         other.first = ptr::null_mut();
     }
+
+    /// Creates an iterator over the list.
+    pub fn iter(&self) -> Iter<'_, T, ID> {
+        // INVARIANT: If the list is empty, both pointers are null. Otherwise, both pointers point
+        // at the first element of the same list.
+        Iter {
+            current: self.first,
+            stop: self.first,
+            _ty: PhantomData,
+        }
+    }
 }
 
 impl<T: ?Sized + ListItem<ID>, const ID: u64> Default for List<T, ID> {
@@ -451,3 +464,92 @@ fn drop(&mut self) {
         }
     }
 }
+
+/// An iterator over a [`List`].
+///
+/// # Invariants
+///
+/// * There must be a [`List`] that is immutably borrowed for the duration of `'a`.
+/// * The `current` pointer is null or points at a value in that [`List`].
+/// * The `stop` pointer is equal to the `first` field of that [`List`].
+#[derive(Clone)]
+pub struct Iter<'a, T: ?Sized + ListItem<ID>, const ID: u64 = 0> {
+    current: *mut ListLinksFields,
+    stop: *mut ListLinksFields,
+    _ty: PhantomData<&'a ListArc<T, ID>>,
+}
+
+impl<'a, T: ?Sized + ListItem<ID>, const ID: u64> Iterator for Iter<'a, T, ID> {
+    type Item = ArcBorrow<'a, T>;
+
+    fn next(&mut self) -> Option<ArcBorrow<'a, T>> {
+        if self.current.is_null() {
+            return None;
+        }
+
+        let current = self.current;
+
+        // SAFETY: We just checked that `current` is not null, so it is in a list, and hence not
+        // dangling. There's no race because the iterator holds an immutable borrow to the list.
+        let next = unsafe { (*current).next };
+        // INVARIANT: If `current` was the last element of the list, then this updates it to null.
+        // Otherwise, we update it to the next element.
+        self.current = if next != self.stop {
+            next
+        } else {
+            ptr::null_mut()
+        };
+
+        // SAFETY: The `current` pointer points at a value in the list.
+        let item = unsafe { T::view_value(ListLinks::from_fields(current)) };
+        // SAFETY:
+        // * All values in a list are stored in an `Arc`.
+        // * The value cannot be removed from the list for the duration of the lifetime annotated
+        //   on the returned `ArcBorrow`, because removing it from the list would require mutable
+        //   access to the list. However, the `ArcBorrow` is annotated with the iterator's
+        //   lifetime, and the list is immutably borrowed for that lifetime.
+        // * Values in a list never have a `UniqueArc` reference.
+        Some(unsafe { ArcBorrow::from_raw(item) })
+    }
+}
+
+impl<'a, T: ?Sized + ListItem<ID>, const ID: u64> FusedIterator for Iter<'a, T, ID> {}
+
+impl<'a, T: ?Sized + ListItem<ID>, const ID: u64> IntoIterator for &'a List<T, ID> {
+    type IntoIter = Iter<'a, T, ID>;
+    type Item = ArcBorrow<'a, T>;
+
+    fn into_iter(self) -> Iter<'a, T, ID> {
+        self.iter()
+    }
+}
+
+/// An owning iterator into a [`List`].
+pub struct IntoIter<T: ?Sized + ListItem<ID>, const ID: u64 = 0> {
+    list: List<T, ID>,
+}
+
+impl<T: ?Sized + ListItem<ID>, const ID: u64> Iterator for IntoIter<T, ID> {
+    type Item = ListArc<T, ID>;
+
+    fn next(&mut self) -> Option<ListArc<T, ID>> {
+        self.list.pop_front()
+    }
+}
+
+impl<T: ?Sized + ListItem<ID>, const ID: u64> FusedIterator for IntoIter<T, ID> {}
+
+impl<T: ?Sized + ListItem<ID>, const ID: u64> DoubleEndedIterator for IntoIter<T, ID> {
+    fn next_back(&mut self) -> Option<ListArc<T, ID>> {
+        self.list.pop_back()
+    }
+}
+
+impl<T: ?Sized + ListItem<ID>, const ID: u64> IntoIterator for List<T, ID> {
+    type IntoIter = IntoIter<T, ID>;
+    type Item = ListArc<T, ID>;
+
+    fn into_iter(self) -> IntoIter<T, ID> {
+        IntoIter { list: self }
+    }
+}

-- 
2.45.2.1089.g2a221341d9-goog


