Return-Path: <linux-kernel+bounces-169625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F2288BCB51
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 11:56:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A196B22A66
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 09:56:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E954144D01;
	Mon,  6 May 2024 09:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gqzn0fww"
Received: from mail-lj1-f202.google.com (mail-lj1-f202.google.com [209.85.208.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 965AA1448E2
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 09:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714989247; cv=none; b=qSFzDjGwNOhI2kNIE/KUXR9RFco1NDtfppxS6DJXq/wgU4arbJqzdlNED0qwvKNx7uhZOB41GoALZDp/C6S3Y9FXx7cSG+YSA4r3EDCnk9mnu5lrwj5AINWE6jq0oPJnHVZcQ6cVVFjsHCSIIfR+8bG/xbs3AKFCMKIDtUrVS7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714989247; c=relaxed/simple;
	bh=TputigRZUR00q1xN1sbsYsPUvr9lDRrYeB9O4vnOPD0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=r2s+ss3O6YiQvSrZhfgUNtL5MzZuNTtjud1zYK/dyzRf97jMLmbP3U6PVa/R8A6TIIC4JH/rRw/aT/dnaR7jGxQBl29me2czjvojtKhnIXtFlwSQHDk2Dhu27SzdGKoyQmvkp8j9yKwfg4vhUhtUvyv6s5fcvso+afn65PXXMyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gqzn0fww; arc=none smtp.client-ip=209.85.208.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-lj1-f202.google.com with SMTP id 38308e7fff4ca-2e31652ed62so5509821fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2024 02:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714989244; x=1715594044; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ga8rU6TTAMlW0eYro+OQUU98vsuNjWANwmXQ6mKFv4I=;
        b=gqzn0fwwCVnBIasKIp6/KwRLc9njsxfxmfI7U2ZbFYJ3d4nqRfN9+qIVnwXRZPJV9W
         0Rh9m8Dmac0hUG7leJ0937MIvBVsihNqDaLvHhJdO4HKPuYTRkyG4vlJXAkAnjPtNb/Q
         J3TSm2ShUCEkSkWUoa0TMxYD+4nPxnjozZRBesuy5GdYKLR6NCnjcquyk1VCmqUc6rp5
         +sDn9d4QYaF/tdv+3ToJe1sk+PAhX+dzYKB2C3f2oDsRiTED4LTojgyj+Ex2rYWydyBe
         g/kwWSG7NrPWZIKL5WpIadrMxQWgCcA9ueXUNtA31D0rNphZUYx3jrz3OYI/6stS0763
         6lPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714989244; x=1715594044;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ga8rU6TTAMlW0eYro+OQUU98vsuNjWANwmXQ6mKFv4I=;
        b=DI+L7xQ2VUEF5IkpOLuJkvneMe/Ir/DrrUD75nUhUvL5vIl/4B7dc+osqV39FxHpQ9
         XIxCk4m+OVSJjBYz6oQmyzT6BzhnHMNx766EsY/WbNRPTzKYtlkfqOvGKSq3Ww+IKiDZ
         054ilyezECMK1LyYapr/flELdsMUl94MT9Y4bWQH1l0reVflN9sRMdh012jokBX37Sfr
         f8Hq7C2RRbWGpqokk2sPtQgRX7c1QFLpQqH3XSKvP1jzYp6RAyuFU5eeZRMyf1UWi3z2
         OkeIpzz2uQouzAg6eBA2bPLAkrVTmXZ9sDxg2muf7z2lirqeqa+0NgOMjNHVlyjkarDU
         W0JA==
X-Forwarded-Encrypted: i=1; AJvYcCXKXskV2G1OgFDnijZ86TYd6Otd8WdKixSbOhM85rF7mWA1PrqDZAyNMNgk+e5nQ95lvK1T61RRMX4206EGwjDmRXuSuthAtEK5YiDZ
X-Gm-Message-State: AOJu0YxB2RCwoL5W6hvN6aUYON/TA9AVa3MRBputehajElrivduJGgKz
	0/gNtaOueL1FDveGaG6RbP3l1oL5HXR4TWs6AEynZQbx05NjxGX/k+xRNWJguHAtxsgiPWpp4Kd
	MBZEsMQthTG+gcg==
X-Google-Smtp-Source: AGHT+IHDpeEadcL9TpEMMczWSvQ8JpUf0k+ea4Le7z8CDI+TIQBGNZarotBKM+O9RL+vD+YiNEO4MtxIgHfb1Ak=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a2e:bcc3:0:b0:2e3:6e32:7a31 with SMTP id
 z3-20020a2ebcc3000000b002e36e327a31mr2111ljp.0.1714989243811; Mon, 06 May
 2024 02:54:03 -0700 (PDT)
Date: Mon, 06 May 2024 09:53:27 +0000
In-Reply-To: <20240506-linked-list-v2-0-7b910840c91f@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240506-linked-list-v2-0-7b910840c91f@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=4976; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=TputigRZUR00q1xN1sbsYsPUvr9lDRrYeB9O4vnOPD0=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBmOKilpgrg2auL4BQjpffqhEAv7iAtgfTAjZkfx
 0OxrRlZXACJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZjiopQAKCRAEWL7uWMY5
 Rkr+EACWvky+6jgSOyKwmOCDFtl45pa6K6XUS0Ui/1xL619TmIohZRkC8/Q4pp+For0qr0Czs2i
 H+Gxc+VmLaxNJKqz7bzo8Egd1cLGuxH58jYd5fp7ZVG4lZcDMDiuQgL33U7ntJxEn0iDfyRY5Vd
 r0I647mwFEDv09XJvKR641WdhLMkfU5UpFa65feb2wJQS0J3xCvBWsin7WKUJrhveVazV58fANN
 v+3Ati/rTgrwYM5bKqvRNpLtjG1Z+3v5mtaD7v6dmrF3BUBcsQGQFaXLD2y+b8vQG86Y5ghECYv
 t5J+pJIqCSZfQAXHpnWtJaXWQLYHmr1psZ0+A9G0qAW7Yt84sRG9HuoTFOCeyopkpm9wmpux5Ew
 TNPbbpfba3/6LqnCiyCnsknrY3ZMZ/LHQ3NxtbuB9zmTHTO/eRB7jHX8HiSmWMAZ7AGU3GhRc7e
 t++bhn1UX0DGbB4UzcFrsdL9+DINaSItUCqf7+wytGMXNfY6RtfKqeyYaPA1VG10MCXsX1pIavL
 3QOWaSr7lfOZMSJrIFZ0lhqLK6DE3qL7J4CiG3lF+bNjgt77eIWUGhf4NoD/Xu7t8ya11hYvjD0
 8Pua9x+rhgnTzOqwWkTM40agJ3XEg9M8nAO5UQifCq8yQKAb2ZOsdO9J8+6lehcdZYeglBtcocQ 24d3V3TFgZ021bw==
X-Mailer: b4 0.13-dev-26615
Message-ID: <20240506-linked-list-v2-6-7b910840c91f@google.com>
Subject: [PATCH v2 6/9] rust: list: add iterators
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

Rust Binder has lists containing stuff such as all contexts or all
processes, and sometimes need to iterate over them. This patch enables
Rust Binder to do that using a normal for loop.

The iterator returns the ArcBorrow type, so it is possible to grab a
refcount to values while iterating.

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/kernel/list.rs | 102 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 102 insertions(+)

diff --git a/rust/kernel/list.rs b/rust/kernel/list.rs
index d0ff29a3e5d1..e36afc7ee44a 100644
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
 
@@ -435,6 +437,17 @@ pub fn push_all_back(&mut self, other: &mut List<T, ID>) {
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
@@ -450,3 +463,92 @@ fn drop(&mut self) {
         }
     }
 }
+
+/// An iterator into a [`List`].
+///
+/// # Invariants
+///
+/// * There must be a [`List`] that is immutably borrowed for the duration of `'a`.
+/// * The `current` pointer is null or points at a value in that [`List`].
+/// * The `stop` pointer is equal to the `first` field of the [`List`].
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
2.45.0.rc1.225.g2a3ae87e7f-goog


