Return-Path: <linux-kernel+bounces-286066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B30D951621
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 10:07:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CA731C21192
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 08:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6E981494C5;
	Wed, 14 Aug 2024 08:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zpfk77cQ"
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F0BB148312
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 08:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723622778; cv=none; b=jbfD6yrZ65zfb6a6QxbyDMl0AvgM0ELzZt8l00nBM5M5rKnvC5A2jung9O1zkPZgnN8RqkqEjP0djpIYMyCNJ/U7faIovXL+oxy/+peOv+sEK4+9hnuTbCyk+ebSIWyKkROZkSjAFzutBP+oLk/jduKG19m6c1HBu05Bzvd/skE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723622778; c=relaxed/simple;
	bh=dGtWLeCSuTNEwUugDyA1XdJqmUZPsl32zsHFqetb4/k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BzEN9TkvwpItaGkRiLEVRyOeX2AsxWDbTZT4PKNQ0j0G1AQXT4fX53d60y/LSeO7tKmz19tILeEq0k80lGB8tq/0mpAx6sEet3xPrpAx2sPMEotUgzIJ4IOqMgHVCS24ZEe8txVPw/kDv1hy6ErCI5uvK9AMK4ggX6Omq8oT3uE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zpfk77cQ; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-36848f30d39so3631106f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 01:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723622774; x=1724227574; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Zzj0Y8qT0OVh2xjwyqiYL1BRt2Dsmc+jX/UXC6YevlE=;
        b=zpfk77cQBe7hAw3WPNQdnv6eiqaaDTRRUP6Y8irQvybs+J4/PvhEDDNrsg0nijaCci
         Yl9Vf6sEOO/XqJUxUtP99gYFalzq1Q339Lq+SkMfJFuH8kCZT9Dl7j/pZPD9Yy/OM9zw
         XdEti1EGa8jN1EOA7VwYmQd632Di8T3Ant0TlDiZo/NiZsnKG5fhpYEqgXzy2YuzrfM7
         DNmzJcfw34/vJNWYQlB7Q2PGfiLt+Neqf8WKgxLgSPoVpPru7+baUwF7a3dw0DqgQIY4
         iRQQPVwyCCHQeuCpOdTuXnuSdgrCfeHTzTcPYsZ6/kmA+iTp1xFty85AqAvHTaKwqWT5
         K50w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723622774; x=1724227574;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Zzj0Y8qT0OVh2xjwyqiYL1BRt2Dsmc+jX/UXC6YevlE=;
        b=rec0bcZiS3PeEsIxWcQsGnRE4Jwi27K1z4UCAk30maX/j4Hf0gVVNEym18b5LwrO69
         25jVwUCymLhzJ8ZmK3bx+78a5umQ5RNbrM9Y7SxoJK2Y0h1rSMM5/4rnllmHa/eB5e1x
         NxbILX1XRlsxhc8/2kDH+HzHi90a9N/CJVXBqn6XXBRoMnek+voCLvicVJXLGuegCtlK
         KPoOb5PmfzdLKLerQfKYiKWpZvUsBgkja9w/EgtGNbAPhTe09I18NZWgGu32sHeJYIOf
         gAB+idlw+tAXwFFL4E7WM2B2CU1+AMzaoddesncliflElEcgFrcNeyjB6SOgebEjo9b6
         VAvw==
X-Forwarded-Encrypted: i=1; AJvYcCW+mZ8Q8aZH7S68SbvAbUuW5S+EQpgJhykLK+JyIrB7rJeRrJpc16td/5sQpOGs0SaWSVwDYDo0QKiZY26NrC1w6y3P16uNLK0wGfin
X-Gm-Message-State: AOJu0YzXYaKAkIwh2HAgBIbHy3FTa9TrS0UxsvmcgBG/MjJLV2ISI4md
	lcPpnbpGkqEx/Vb/1o+bTYJ1lftvzaDFyRTsnPpPymhFzJiIlnV0eiumtoGAYeaE5a/zi0J0phv
	3xlQB8fajwXAcdA==
X-Google-Smtp-Source: AGHT+IEf6YoaCDMsRG7GznUzLKEpOLTGCT7RvZ7lwGKcm+8duQ7/MuPCrVm/1WBElrLQn5b0njZpo7YqRmyRpeU=
X-Received: from aliceryhl.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:35bd])
 (user=aliceryhl job=sendgmr) by 2002:a5d:69d1:0:b0:368:4910:16ed with SMTP id
 ffacd0b85a97d-37177785b92mr3218f8f.5.1723622774225; Wed, 14 Aug 2024 01:06:14
 -0700 (PDT)
Date: Wed, 14 Aug 2024 08:05:26 +0000
In-Reply-To: <20240814-linked-list-v5-0-f5f5e8075da0@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240814-linked-list-v5-0-f5f5e8075da0@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=5025; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=dGtWLeCSuTNEwUugDyA1XdJqmUZPsl32zsHFqetb4/k=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBmvGVfrIu15K142PsJ8dJR1RWGMccf7FITauuV3
 Vl9RoE+XTmJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZrxlXwAKCRAEWL7uWMY5
 RhVtEACGLqSckv4oIE7zO1/sZxd7rQeK2aK1hlpaKAXO8Bw+JXv3aWCbb+yhvbVUBkYwdUyJPYJ
 oGk3TdXMTywqJhEiXBj6KcPVnlCS2KFgsRwFHonPf7SSiQ0RshD4tW85bs2TuXQUg84P3giB0SH
 XOM4Mt/LGwrrmLZBjP9X63kZIeKDb4pZ2UF1VK6Npuoxh8PSjuo03K2NaJZlrjC/W1fuT4t+E2K
 o9SfBSdnyWjEcSt+Mpl8tHd7vjinLDfWJG74bd07S5KniIyNcgJs5VSJljsS4JqG53lOBd9GdSB
 tYromwxGF0ZHCrj4uTQU4V6e+AOZ+uLAE9Gt7WQs8MezM85a+CaVhCcl1cYZxDfjPDlo7tvAGnF
 cestm4A7rsQUeZB9m70zyHxHZIVGuzNpcfsMndQzZxnu6DRgSPnBxgN5PuxnWczKKxawuML+rXR
 qiJVmFYgpYGNswepnc2sr8FzKop7jAAW3yTj74UCyNvV0guiXUvdaXVcn209mx+EwBkvBknxPx3
 lJHHvcEMZSW1QAh26lQ86eSNi10b8QEGDwMXR5Qz150VSuC4UtF3qpvrhTkQOJZFRXEWbsanXD1
 nyEXjnlHUVr6mJECdbi9L2F+pBxxXWUH18KP3Q225jkxOebQhs8vfOOhFEVzxpadyItNiVSwFB2 G1urdF+GicwxfXg==
X-Mailer: b4 0.13.0
Message-ID: <20240814-linked-list-v5-7-f5f5e8075da0@google.com>
Subject: [PATCH v5 07/10] rust: list: add iterators
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
index 551c46a2401b..0d680156b8b1 100644
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
 
@@ -437,6 +439,17 @@ pub fn push_all_back(&mut self, other: &mut List<T, ID>) {
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
@@ -452,3 +465,92 @@ fn drop(&mut self) {
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
2.46.0.76.ge559c4bf1a-goog


