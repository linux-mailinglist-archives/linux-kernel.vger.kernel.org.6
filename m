Return-Path: <linux-kernel+bounces-169626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 99EA68BCB52
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 11:56:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC13D1C216AF
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 09:56:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5172C144D29;
	Mon,  6 May 2024 09:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r5s6YMPu"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF5C1448F3
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 09:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714989249; cv=none; b=ulzW28/dpPzcRFp5FNhB7okz61f2IaDe6/w2f9UA1p5qHOf9luqWVOWFsl1D9bShI7k2tnmRCwk23LKqmKpBGejxNZxD0YeJg7PFksWGb4/edyFo6ADGQowhmOZv4B9p2FXkCKWbk8dxS+d6BSI9uKHYTZXCaUaLj8AfncQwXPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714989249; c=relaxed/simple;
	bh=8K9lvD/I7hdBOtJBKpQy5+wPSZSIbLWW5XJdQOsddxI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qsKWIn1bc4e2RlXuKiUE8Jd5bwsPhJXKbCFahIo3oz1Gd34BdZE9YIQp7JVGTYAtIkfNlnOo8jmDye7ejP4XpndjMgGUtAvfH7klVfUgnnNaPu9D03NrndtaA53xSVXEuyFCJM46tTByXXV1mdzbMVhyWE7e7p1hA5+BUs2+uEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=r5s6YMPu; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-de615257412so3740552276.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2024 02:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714989247; x=1715594047; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ezJm3dIadEEPgM9AdRrLvcNCS5JPWxEP25Hxucwcvt8=;
        b=r5s6YMPuJewDzHD1BPG11DPogD22jkgCA2aBwcG623xn9fNvkBMMGbJgw7enuQma6N
         iyluknt/cSX1TnyTDuLmYJQsecKh/pS8K/3p4mT/eE1GrC/SVxRN/AWBnloRdrwC3RTk
         WJg4/pIX3T2qjCPDzUCvzRFSIQd2OdgTEDhNj7bhHA9ntlJFZ4cOdk+AHfvG8pzFlzGg
         ZehbuXSsdni2M3+EsX480f7EJGMRGfWVcmo1cuEWUQ/hY1RZXBF5RkaE2Y7gBLYZ/nRh
         ja/ukwu5N9SRQ90PHPEhmTd88fJWRZ9XGHE8NcrwQE7WCNYfaFX1itwf6A+EBYdKf+2V
         UaFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714989247; x=1715594047;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ezJm3dIadEEPgM9AdRrLvcNCS5JPWxEP25Hxucwcvt8=;
        b=OSJNr+oYZ79eO1WL8t2oK2om4CsDa1Gna3gMUH59aCaHTmr9R/pnme1CT3Zt4UdLiL
         1/PhD4mvXizvQnLPRdr2ZDaprP2XOSXybM9u8cDaZE4ejWDyf9pAanEyiLYOzMaoCIgj
         vWglrD/oOYmTwYd+xxy/2G7Lm9mZeffkyBsIf3mBoRSLzXLiev5Gf/IlUQ20olur2DLA
         CISOrRIpr1lhMOgxAJi+JQP4o3mZnGHuGEiOaWdIjCHgl89NLcTrklZ7IXe61FYwQTd9
         iz5LEgKv4Yfhxl79PZGnP+L/t5g9sGXMzKBeUmHQ9MkD/kXHUurUOJ6PnRhNvL2eam8S
         hcZg==
X-Forwarded-Encrypted: i=1; AJvYcCVJhikArHsxMIVhqwghIOGa7uVWi/iZNmX7TckpWmhk8ILkysqdUQbFucyemPmIRnkBZTjRPu8C5Gv5HR5P9/ZXg0tEjeyLZzF8rZ0w
X-Gm-Message-State: AOJu0YzDUq9Pgo7y/ttxMweFPF2HukSq8ijPq3u+6zaRNBInlSaHEIQ5
	nIg9pGQIU6gBqeQ+kG4mQZ8II9I6P+dOP53HRKl3nvMDDK1O9IVfEKkcEYrGu9IaTd+ZjR/cEoj
	m1vlPAzBbrWFnSw==
X-Google-Smtp-Source: AGHT+IEBI67b/rlR/RdZhzJYKewslwa1JtIus+jos+eEpIsCwHVg5LbTZzENK6W+28QXdTWd3W+eYA2jlbLqs9g=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a05:6902:c01:b0:de5:3003:4b7b with SMTP
 id fs1-20020a0569020c0100b00de530034b7bmr3531670ybb.1.1714989246988; Mon, 06
 May 2024 02:54:06 -0700 (PDT)
Date: Mon, 06 May 2024 09:53:28 +0000
In-Reply-To: <20240506-linked-list-v2-0-7b910840c91f@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240506-linked-list-v2-0-7b910840c91f@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=5286; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=8K9lvD/I7hdBOtJBKpQy5+wPSZSIbLWW5XJdQOsddxI=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBmOKimeotMCAb/jQAq50Zc0JLzfCpOkfdGvoLEt
 plupjKUheyJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZjiopgAKCRAEWL7uWMY5
 RnZgEACvgLng6XYGSmoMrTF4EohLNct1liNo8X0AoAwOxEw+XDWef8P8u5iqebkPBEMRlcJQnwl
 vUSgi9vD9ImBMfgNvXk7x1gzlMxbrivvYY6lbmfVALcji5zSIyIoyFhlLQRcneOcjbGu0xJo9zG
 DY9Jet6bjWLt+17ebpFFO/DR2dF0sPBJceiFIR8DV/WD0HkgLr+A/Ezp3Db++zJullZpXt3pDF1
 QD5X96ylzPodZgt+EaTgY6ssA89o5kFyXTZsv9QYAk+YML9V0ghC9QU/7B0ax2DyGMRYLYZUQhF
 ynE80SaUDEsgIM2C3mBTxo9LO98iL+rhFXXmA8RULghlXhrOSCu/0JqE41utp9cHLxkQihto41M
 o8sINgaqu41MAsdW7JZAAUkHZc3mUnQ0hu5lUot7Fw78N8XR0CImErFJnB2TB+lih6vBJKdd5Ej
 UhhlPoJ4JioMccgnWlnpKFiyhEXsecNK/rwM8ziKinbJmkx+e3IGrTKKRPi6yoiPrYaULlddrj4
 Xe5L03V4gjX2Hs6uftmgPlIk0lcdHouMca6m5gUUOzoAhEOwrrEteLz29wMLuECi/Pghl8c92KU
 +2ldRgyWLB+tzIaFJIYnu5OMYOnvDbr4S7gbd482WsSWsDWNm2RGFPF06ZZp7DzqcJfYhbbkD11 lGSsBZrrc8cMU7Q==
X-Mailer: b4 0.13-dev-26615
Message-ID: <20240506-linked-list-v2-7-7b910840c91f@google.com>
Subject: [PATCH v2 7/9] rust: list: add cursor
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

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/kernel/list.rs | 82 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 82 insertions(+)

diff --git a/rust/kernel/list.rs b/rust/kernel/list.rs
index e36afc7ee44a..641b434e3841 100644
--- a/rust/kernel/list.rs
+++ b/rust/kernel/list.rs
@@ -438,6 +438,20 @@ pub fn push_all_back(&mut self, other: &mut List<T, ID>) {
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
@@ -512,6 +526,74 @@ fn next(&mut self) -> Option<ArcBorrow<'a, T>> {
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
2.45.0.rc1.225.g2a3ae87e7f-goog


