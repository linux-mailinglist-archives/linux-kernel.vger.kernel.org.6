Return-Path: <linux-kernel+bounces-169622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BCC948BCB4C
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 11:55:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72D60283F58
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 09:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31277143C67;
	Mon,  6 May 2024 09:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UteJOBMW"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2AEA143899
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 09:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714989238; cv=none; b=R+ZCfQO9eQJbr8ah0Eq0YZPU2ulObAa1adVnG8QtIQtQMWgh+QiS+mxeTClIFmWyR5FCSgb8Z61l3E8+aQKCrvRMZSu3X800YowHAgsIUuIcImEnIfND3vhntg9HJc7PqNJ0Jz+Qg9GQwaDaiTesSBAdwz4TfdNcbg8dlRBWIMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714989238; c=relaxed/simple;
	bh=TkDDAEioQS5e03PClrJNkUWgCunwLczUs3+Rw4vQtIE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kBqdIo0UMWRcXLgasYolTq64edawas3DZ3GiS8xYrEN8ZQxmyMekynVpOP0LV3mhJIdBABAWcWyKXBfH7S2YtIwwJhUUOBKQif4pJsaBfpfeVog5xtcU6FPSnHgAbzcYxQCxTKpGAYif1H0nfZ8lu0ZTwbMD+zcp+QkXVNOBwZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UteJOBMW; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-61b1200cc92so33646967b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2024 02:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714989235; x=1715594035; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=lqcGn7n9nLKSxOtaoBrT7a751lVSlam8EM5dcqR6dvA=;
        b=UteJOBMWma9UiHRkM93Z/0/P2llsNgTGaswPhVt7Fqw4qzFtBis4yio7R3tEiR+eXl
         GeecBPnO3ojr+JeNXNqj3wO0Sh1tIHnS/NwaFZy3fK4oIS75MrYQ04LZES+7mgXinQx0
         dJF4D4Yx32LKpT9nIZlcvIsu3bZ8otPm5x9zo9VgmjYelHvpODxaztAzqxu0c0Tc67Ek
         0QHR2DW5AcSfL6S3bn8IzIXPIzjlt4od5TfBe8HNh1ltoPkEm66ndZSsfTX3ZNzir8X4
         WYRCS+FKAraXiMCu0mpXoqf1gnqflyQJrw0BqW65auhiK8/FL6Yg+MXNVtieIemVK6gi
         HyEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714989235; x=1715594035;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lqcGn7n9nLKSxOtaoBrT7a751lVSlam8EM5dcqR6dvA=;
        b=H5Qvk2Vdz3MYMnzc40MweV00qb2ZmaQJvL7DI9brZEnDiRmrV976sVk3tGu+jvaRX9
         VUxo5N5GJD5CM4x5R8G69Fep3gFh2Q3JPd2nrkHS0YPB8Yl8BWRuA8+wwq+0aB4ksGVV
         /gIC2vU6pb0t4tUDMvF3qLCi71wYMMqQdbggMT0H7S3FrN/Y89tUN7P8R7X7N//xYPux
         BCltbjiJI9hldKV/aDqPyswJcBPCxIva1dWdJOEA2uJqeWaiBM0NUavVQ0nRIIHGoMTy
         9pjNozrZGTmuKEAIsBhM04NarkwGVO0h4RJG1KR21nY8o2cgYPJ2NM1DYVw1+TV9wkfv
         IoOQ==
X-Forwarded-Encrypted: i=1; AJvYcCXLalVbqUpi41t6/a0OH1Mwc3BsK2Ywnpw+0ldVb/k9zmkpa3+1ymBLNbu1woYaDfofMpWQIehgX3Fre/RP0d4qb47I85Z1zUPGcJmH
X-Gm-Message-State: AOJu0Yxivvbu9dXNR74DP6fcmczg6MgAGO06fb6cd2PDtvJr7/hvRxXu
	LZ3CujCzxQUOvx7T5Uhs8a8ismXkQYyAJac9DfT4ic6EU1VwktV/ca9ipx+sEFUFRlWWPaJNaGC
	39lgQ+0CbudLCbg==
X-Google-Smtp-Source: AGHT+IH8VHArxLC8vBNsOdEy5JvL2q153l3s3tin9/zAezvqCYlbXmRLADvQwGaR+3klAMQbvFTzSioQ3TQs8Zw=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a0d:e2cb:0:b0:61b:ec66:b8e6 with SMTP id
 l194-20020a0de2cb000000b0061bec66b8e6mr2665283ywe.8.1714989234921; Mon, 06
 May 2024 02:53:54 -0700 (PDT)
Date: Mon, 06 May 2024 09:53:24 +0000
In-Reply-To: <20240506-linked-list-v2-0-7b910840c91f@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240506-linked-list-v2-0-7b910840c91f@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=5975; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=TkDDAEioQS5e03PClrJNkUWgCunwLczUs3+Rw4vQtIE=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBmOKijC6Aiz2Bj0crXUAGLYj/j/lO6i+M8dlMoo
 AKkJhs/eziJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZjioowAKCRAEWL7uWMY5
 RmuVD/0ZKaaI3qmhkVGuDCwOk0UTE7IoWyqZ19QsGRYIZm5kZJCL5CaHA5LOsGLT431L5dCMCJa
 lCchL7/vssNV07q5Lu+NaFTScSLnmORzEwLB2WpE6TVnrVOiiG/+g/tLURyIV1TR8L2KpvjCaJy
 1qtgof3wBfz+h5QAyKgbLjLRCAntmlMEFCGUG+Rw4NG4lMpctJxkGOno2QQ3+ADsWFBX0LEInhe
 Xp6L0hTg2j2wLIYBlRhxb4ObWSnWGTREXTDNVzqJ+SywnQlqfAKEFiRDO8+uSM7Oc/zDAd4kaIu
 sy6ApTEtZhlTF7ZS8SC5tRgpPLzj6zg313b6mmRJX04RlAuiI/InUs+WwKWPVqq3AAwNZDKIIBi
 WXvCnR29c+XmZDb8o5h3eMQx8c/L5hriGibwcnrJ0ot3giYKsQpZpLCpItdRlpJoMUKn9pydTZw
 xEiChaw5Ek9k6/c0dgs+NcxwEooKiKRWqegwvI4znDDhqs47kGGGyesEH52LFoYWabEXgBElkck
 OL3zCqER5qoUDCDiBKoyGfvT2sC6D0uxwa7YPkSXNa2Z6rPdGj/rqDYTnF3H1qnDA4rrDWX9p2d
 0VEudKxejsAH/kgg3fORoUc7CJd9RebNqJmhc8jfsRWR7gH1I1LWkhV3M5esdQ+Js4rcVrskmjG iZw+mvS+4aiEaFQ==
X-Mailer: b4 0.13-dev-26615
Message-ID: <20240506-linked-list-v2-3-7b910840c91f@google.com>
Subject: [PATCH v2 3/9] rust: list: add struct with prev/next pointers
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

Define the ListLinks struct, which wraps the prev/next pointers that
will be used to insert values into a List in a future patch. Also
define the ListItem trait, which is implemented by structs that have a
ListLinks field.

The ListItem trait provides four different methods that are all
essentially container_of or the reverse of container_of. Two of them are
used before inserting/after removing an item from the list, and the two
others are used when looking at a value without changing whether it is
in a list. This distinction is introduced because it is needed for the
patch that adds support for heterogeneous lists, which are implemented
by adding a third pointer field with a fat pointer to the full struct.
When inserting into the heterogeneous list, the pointer-to-self is
updated to have the right vtable, and the container_of operation is
implemented by just returning that pointer instead of using the real
container_of operation.

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/kernel/list.rs | 116 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 116 insertions(+)

diff --git a/rust/kernel/list.rs b/rust/kernel/list.rs
index c5caa0f6105c..b5cfbb96a392 100644
--- a/rust/kernel/list.rs
+++ b/rust/kernel/list.rs
@@ -4,7 +4,123 @@
 
 //! A linked list implementation.
 
+use crate::init::PinInit;
+use crate::types::Opaque;
+use core::ptr;
+
 mod arc;
 pub use self::arc::{
     impl_list_arc_safe, AtomicListArcTracker, ListArc, ListArcSafe, TryNewListArc,
 };
+
+/// Implemented by types where a [`ListArc<Self>`] can be inserted into a `List`.
+///
+/// # Safety
+///
+/// Implementers must ensure that they provide the guarantees documented on the three methods
+/// below.
+///
+/// [`ListArc<Self>`]: ListArc
+pub unsafe trait ListItem<const ID: u64 = 0>: ListArcSafe<ID> {
+    /// Views the [`ListLinks`] for this value.
+    ///
+    /// # Guarantees
+    ///
+    /// If there is a previous call to `prepare_to_insert` and there is no call to `post_remove`
+    /// since the most recent such call, then this returns the same pointer as the one returned by
+    /// the most recent call to `prepare_to_insert`.
+    ///
+    /// Otherwise, the returned pointer points at a read-only [`ListLinks`] with two null pointers.
+    ///
+    /// # Safety
+    ///
+    /// The provided pointer must point at a valid value. (It need not be in an `Arc`.)
+    unsafe fn view_links(me: *const Self) -> *mut ListLinks<ID>;
+
+    /// View the full value given its [`ListLinks`] field.
+    ///
+    /// Can only be used when the value is in a list.
+    ///
+    /// # Guarantees
+    ///
+    /// * Returns the same pointer as the one passed to the previous call to `prepare_to_insert`.
+    /// * The returned pointer is valid until the next call to `post_remove`.
+    ///
+    /// # Safety
+    ///
+    /// * The provided pointer must originate from the previous call to `prepare_to_insert`, or
+    ///   from a call to `view_links` that happened after the previous call to `prepare_to_insert`.
+    /// * Since the previous call to `prepare_to_insert`, the `post_remove` method must not have
+    ///   been called.
+    unsafe fn view_value(me: *mut ListLinks<ID>) -> *const Self;
+
+    /// This is called when an item is inserted into a `List`.
+    ///
+    /// # Guarantees
+    ///
+    /// The caller is granted exclusive access to the returned [`ListLinks`] until `post_remove` is
+    /// called.
+    ///
+    /// # Safety
+    ///
+    /// * The provided pointer must point at a valid value in an [`Arc`].
+    /// * Calls to `prepare_to_insert` and `post_remove` on the same value must alternate.
+    /// * The caller must own the [`ListArc`] for this value.
+    /// * The caller must not give up ownership of the [`ListArc`] unless `post_remove` has been
+    ///   called after this call to `prepare_to_insert`.
+    ///
+    /// [`Arc`]: crate::sync::Arc
+    unsafe fn prepare_to_insert(me: *const Self) -> *mut ListLinks<ID>;
+
+    /// This undoes a previous call to `prepare_to_insert`.
+    ///
+    /// # Guarantees
+    ///
+    /// The returned pointer is the pointer that was originally passed to `prepare_to_insert`.
+    ///
+    /// The caller is free to recreate the `ListArc` after this call.
+    ///
+    /// # Safety
+    ///
+    /// The provided pointer must be the pointer returned by the previous call to
+    /// `prepare_to_insert`.
+    unsafe fn post_remove(me: *mut ListLinks<ID>) -> *const Self;
+}
+
+#[repr(C)]
+#[derive(Copy, Clone)]
+struct ListLinksFields {
+    next: *mut ListLinksFields,
+    prev: *mut ListLinksFields,
+}
+
+/// The prev/next pointers for an item in a linked list.
+///
+/// # Invariants
+///
+/// The fields are null if and only if this item is not in a list.
+#[repr(transparent)]
+pub struct ListLinks<const ID: u64 = 0> {
+    #[allow(dead_code)]
+    inner: Opaque<ListLinksFields>,
+}
+
+// SAFETY: The next/prev fields of a ListLinks can be moved across thread boundaries.
+unsafe impl<const ID: u64> Send for ListLinks<ID> {}
+// SAFETY: The type is opaque so immutable references to a ListLinks are useless. Therefore, it's
+// okay to have immutable access to a ListLinks from several threads at once.
+unsafe impl<const ID: u64> Sync for ListLinks<ID> {}
+
+impl<const ID: u64> ListLinks<ID> {
+    /// Creates a new initializer for this type.
+    pub fn new() -> impl PinInit<Self> {
+        // INVARIANT: Pin-init initializers can't be used on an existing `Arc`, so this value will
+        // not be constructed in an `Arc` that already has a `ListArc`.
+        ListLinks {
+            inner: Opaque::new(ListLinksFields {
+                prev: ptr::null_mut(),
+                next: ptr::null_mut(),
+            }),
+        }
+    }
+}

-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


