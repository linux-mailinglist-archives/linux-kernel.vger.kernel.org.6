Return-Path: <linux-kernel+bounces-286067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 79422951623
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 10:08:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F169C1F22037
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 08:08:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F07D149DE9;
	Wed, 14 Aug 2024 08:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RwzMHaCv"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 954FF14900E
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 08:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723622780; cv=none; b=CEDLyvOO1BLN4uNJTdG3+bZnWUnPHLnYIKk09TFgEMo1YSLRQubWV/yHftMJlbv6n0ZvOo8s+XN9davrUq38UZugXDxNBk28xtvM+WkL68D3WNLxGMstD2gXSEAyuuswf36yAwW2PxwDTplAMuakcL4cpjmEr7CIcpb3dc3vuGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723622780; c=relaxed/simple;
	bh=luJNd/MfagCpX5xgyCXvBHu7a6jvo5DfxROIQE96O0Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=galw3QZ+o5+bNhU0QL/QWuCNJOhOC6M1C2kncgC3rqoQxjZ1m2HzkZPu11wG4IJXqthq1/rAhmgHTViKxN0OWDRYmOR4Xp6egSUzBvp7EllANoJMhwQ+Wzps4znAdISRhRZK4RikHmX4w8LfdHfWRqK+yVGHas3Z7g8jXz3i/7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RwzMHaCv; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-4281310bf7aso45012695e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 01:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723622777; x=1724227577; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=eU2WZjJDSLa2MV/5GK/awSXKL16LXQcf7wHaBKswmn4=;
        b=RwzMHaCvqXlcqn/4h4mFeJtHoioRGpOJcjBwa7lXGL/4lN9aq6XUGb24jxQEH/cqPw
         KpdSWFQVNuc7ZGFjB7i+DSjdRM02/ld13geDXDGf0G4HO9+pSSYLT7zXb45A5ZBMU9UU
         eBt0n72gSkcAbX3WvyVEMHicDHrn8NW6pqjLNd2SlY3zcgmKdjaWo/gcyWZRyzJ5DVDu
         vPrh3rt/zlUN+bsc1LkH/+aG+7VCaKAsh6ec1US1QTOeb1p9F6rctoIeoyeIk4LBtGve
         o+VB9jM0uGLgTw2JFmCrTD2etTWwc2NOX6bF/+8ajcSTH1dBKsZpnW75mCWjL6ifHGFF
         P/6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723622777; x=1724227577;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eU2WZjJDSLa2MV/5GK/awSXKL16LXQcf7wHaBKswmn4=;
        b=OerONsiYj52aTwgRGK60xQVHEOfjh8GsiXwInmlhzNgVl/LjAvtesqRAZWQWKxSymn
         m+8tBIKTGDFPWZEJsM4Z4tDMBBcMD5iUtjqdhKkdLN349ZLd+0edcWff4NNp6N4AGr1+
         lp0zzKE1wY7JPh3/ExY8aA2QsJ96xzkyWsRRQdd3xl8k5wozHdaAueQXZchWMSU8Rqzn
         7OzacOU4NuySEWUOqsdK8oUtPFLEV0XjuLiNiOa7Uy2/sp4/duJDCr4R9gL+RwoAoo33
         Z8LEFCx1y3aRCgyfBjrEZsmsEQ0tRBYrBtFHc7M1SqIOPR0EVPWC/V51nUPrTKsxrvvo
         qdyg==
X-Forwarded-Encrypted: i=1; AJvYcCU7SWE8oaVpsjGWvooWz2oXWckAApBs4pQ7GDVNF3E6Xm7l61sIjzsSQ0nOzq+wNpyHdVerrmmZoCjYP+s=@vger.kernel.org
X-Gm-Message-State: AOJu0YydHYK35aZqlQo/BZf4s3Y/suvyojQQUKYKJN0yU4QGHcpz8tB2
	WF8MshLmolo53szfuaO0BFqFir2Z5jtEDUgcd1hNSzD8Tm5FxsdUmerMeip7Ig0d7m1yeSd5BGY
	9imeo3zlyRKwc0g==
X-Google-Smtp-Source: AGHT+IHe21novGmBRhAc1cgxeZ/rnzGM0+Bl4ZHLaMVY4DaNNS190O+pXlPP0izBlxfFWOHjeHfq+Qv3y1Z6Gcw=
X-Received: from aliceryhl.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:35bd])
 (user=aliceryhl job=sendgmr) by 2002:a05:600c:6d48:b0:426:6f38:8990 with SMTP
 id 5b1f17b1804b1-429dd2647eemr40315e9.3.1723622776781; Wed, 14 Aug 2024
 01:06:16 -0700 (PDT)
Date: Wed, 14 Aug 2024 08:05:27 +0000
In-Reply-To: <20240814-linked-list-v5-0-f5f5e8075da0@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240814-linked-list-v5-0-f5f5e8075da0@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=5333; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=luJNd/MfagCpX5xgyCXvBHu7a6jvo5DfxROIQE96O0Y=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBmvGVgRWbQqHhnoystThILzkwOTzoEfhLP4TvEn
 eYN+ni2Hs6JAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZrxlYAAKCRAEWL7uWMY5
 RqvPD/4otcbv3KqvSf+EDcftbS+DTlKRGlweDQfZ8U43+xbUiA3KDeUIYjbqeGHVCnfiJYIVnLZ
 LM5ZtEcWXy82qFs7cEqgTbk0xU+k8w/8ouMAYI87T0w7dlR+5577YbQs7heiKTOuP4FQpEuYk2l
 9svkv0ooW39NFki47X820faJdT/bruKKmymHBm31zhjXuVQ4rKGiGpFNgqhLHUdDoOS4hw4Wwow
 88VrVkMdSevmKHkQFq8FlLXy2TOKAPJwMw7TxqeNyEjix8Ii+y//ZRfpZdCsKNmoLK1id+FeDoy
 Nh1+DQsuIjOt2HljYpfkiOGkgrhbnduyBlKAweL0XGwWHrGzP4UJ//aIyOKaK6opwuR7nv31dwJ
 3r0BaYjfP22xz+WtRbORi6kEBTK2mqvK5K8BhyIVvxFCggS+8Lk6gv6k/3k46hPZfynrh5knrOV
 zGBbXZ7VDfERoYkJo1tfF2auCIk/nNpiOyHaeIkEuMawMzdSDeRDldHlB9QRpAPJ4QnO7m8FR3g
 wC3HUD7nY2ogltx6brpu4OiuXZS7M6VTyh3NEVcTYMcY3mHN0Kh5GaG0idglhcMDXFOwgVbPVIr
 iLlclJAEEEDO97nJIvhP7hBn1pnUB3NrhfxKuTrJfnv51N4zSWg7xle+kB5Tp9kBOaSAtyOuQdg ydxJrHCFQSvXgcQ==
X-Mailer: b4 0.13.0
Message-ID: <20240814-linked-list-v5-8-f5f5e8075da0@google.com>
Subject: [PATCH v5 08/10] rust: list: add cursor
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

The cursor is very similar to the list iterator, but it has one
important feature that the iterator doesn't: it can be used to remove
items from the linked list.

This feature cannot be added to the iterator because the references you
get from the iterator are considered borrows of the original list,
rather than borrows of the iterator. This means that there's no way to
prevent code like this:

let item = iter.next();
iter.remove();
use(item);

If `iter` was a cursor instead of an iterator, then `item` will be
considered a borrow of `iter`. Since `remove` destroys `iter`, this
means that the borrow-checker will prevent uses of `item` after the call
to `remove`.

So there is a trade-off between supporting use in traditional for loops,
and supporting removal of elements as you iterate. Iterators and cursors
represents two different choices on that spectrum.

Rust Binder needs cursors for the list of death notifications that a
process is currently handling. When userspace tells Binder that it has
finished processing the death notification, Binder will iterate the list
to search for the relevant item and remove it.

Reviewed-by: Benno Lossin <benno.lossin@proton.me>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/kernel/list.rs | 82 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 82 insertions(+)

diff --git a/rust/kernel/list.rs b/rust/kernel/list.rs
index 0d680156b8b1..904cfa454dff 100644
--- a/rust/kernel/list.rs
+++ b/rust/kernel/list.rs
@@ -440,6 +440,20 @@ pub fn push_all_back(&mut self, other: &mut List<T, ID>) {
         other.first = ptr::null_mut();
     }
 
+    /// Returns a cursor to the first element of the list.
+    ///
+    /// If the list is empty, this returns `None`.
+    pub fn cursor_front(&mut self) -> Option<Cursor<'_, T, ID>> {
+        if self.first.is_null() {
+            None
+        } else {
+            Some(Cursor {
+                current: self.first,
+                list: self,
+            })
+        }
+    }
+
     /// Creates an iterator over the list.
     pub fn iter(&self) -> Iter<'_, T, ID> {
         // INVARIANT: If the list is empty, both pointers are null. Otherwise, both pointers point
@@ -514,6 +528,74 @@ fn next(&mut self) -> Option<ArcBorrow<'a, T>> {
     }
 }
 
+/// A cursor into a [`List`].
+///
+/// # Invariants
+///
+/// The `current` pointer points a value in `list`.
+pub struct Cursor<'a, T: ?Sized + ListItem<ID>, const ID: u64 = 0> {
+    current: *mut ListLinksFields,
+    list: &'a mut List<T, ID>,
+}
+
+impl<'a, T: ?Sized + ListItem<ID>, const ID: u64> Cursor<'a, T, ID> {
+    /// Access the current element of this cursor.
+    pub fn current(&self) -> ArcBorrow<'_, T> {
+        // SAFETY: The `current` pointer points a value in the list.
+        let me = unsafe { T::view_value(ListLinks::from_fields(self.current)) };
+        // SAFETY:
+        // * All values in a list are stored in an `Arc`.
+        // * The value cannot be removed from the list for the duration of the lifetime annotated
+        //   on the returned `ArcBorrow`, because removing it from the list would require mutable
+        //   access to the cursor or the list. However, the `ArcBorrow` holds an immutable borrow
+        //   on the cursor, which in turn holds a mutable borrow on the list, so any such
+        //   mutable access requires first releasing the immutable borrow on the cursor.
+        // * Values in a list never have a `UniqueArc` reference, because the list has a `ListArc`
+        //   reference, and `UniqueArc` references must be unique.
+        unsafe { ArcBorrow::from_raw(me) }
+    }
+
+    /// Move the cursor to the next element.
+    pub fn next(self) -> Option<Cursor<'a, T, ID>> {
+        // SAFETY: The `current` field is always in a list.
+        let next = unsafe { (*self.current).next };
+
+        if next == self.list.first {
+            None
+        } else {
+            // INVARIANT: Since `self.current` is in the `list`, its `next` pointer is also in the
+            // `list`.
+            Some(Cursor {
+                current: next,
+                list: self.list,
+            })
+        }
+    }
+
+    /// Move the cursor to the previous element.
+    pub fn prev(self) -> Option<Cursor<'a, T, ID>> {
+        // SAFETY: The `current` field is always in a list.
+        let prev = unsafe { (*self.current).prev };
+
+        if self.current == self.list.first {
+            None
+        } else {
+            // INVARIANT: Since `self.current` is in the `list`, its `prev` pointer is also in the
+            // `list`.
+            Some(Cursor {
+                current: prev,
+                list: self.list,
+            })
+        }
+    }
+
+    /// Remove the current element from the list.
+    pub fn remove(self) -> ListArc<T, ID> {
+        // SAFETY: The `current` pointer always points at a member of the list.
+        unsafe { self.list.remove_internal(self.current) }
+    }
+}
+
 impl<'a, T: ?Sized + ListItem<ID>, const ID: u64> FusedIterator for Iter<'a, T, ID> {}
 
 impl<'a, T: ?Sized + ListItem<ID>, const ID: u64> IntoIterator for &'a List<T, ID> {

-- 
2.46.0.76.ge559c4bf1a-goog


