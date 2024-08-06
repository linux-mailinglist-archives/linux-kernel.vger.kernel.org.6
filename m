Return-Path: <linux-kernel+bounces-276357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF500949277
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 16:01:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F07B1F221C7
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 14:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA800205E2C;
	Tue,  6 Aug 2024 13:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J1TfrAna"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3ABC20127B
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 13:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722952780; cv=none; b=co7KFq3c49scCuT5L0Dd3Ju7subokLJ5DEOeYfnpj9aolZalLxhEUOZF+KzEMsfBPhnKs/tWNIN3kWgcmHHTpR/y6islwhmm3rkp2nWdx+YYEjZiEE5Gn1erKBKrw23n0su806+OqPPvdyBTethzeQIDogVbZXWzZWiL/w/l/Bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722952780; c=relaxed/simple;
	bh=r7zuSn6T8aiTDmoxN80zggpcp4KnpOuTv4p3Sl1rO74=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=l5OnkbmZLGPsNJjDfOw+mGOposzIS335hXgQNmJXKws7GnfgAMt5Bllm6WeYEpVcwJqPYiY2tggIJOcLdvNKf9w3aCAcpNdj38h0Y87VQqHKuEiv6k1SPi0ST4IVtx1XawID2995RZJqV3VdNO9s6wrdcDm1iC72VT1Mdhdr/uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=J1TfrAna; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-4280a39ecebso32632235e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 06:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722952777; x=1723557577; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ldHWvt49sDIe8d9GqRkvJXWy/GtTjHwVlzeV5qEa4J4=;
        b=J1TfrAnaQiaLvD0+hE70hAB9UDCSCnIE8jFct4RzJbNDUvC0+vqVVQL/JzXBbZ5RqG
         CqCBTi5u0JMd/il9YscYTUk3xaplCwHKtmkBBNvfuGP0a1MHlmaIeQ+oeJufMk7UuxDd
         82StvrRMe9kXgwCyWGrppEWe6zjvAaSRgQlmBDRKa1bpYg27/JxQa8Q2oQAYt6ogK1Me
         MTQ84023VPj4iiJXrjY99Z/RXXweuK57OGuAubZ1BwfD8TH5Gkc5IK91s8hk7pdF5saJ
         aqhOrDulxe2fLf7o9bGsE6aFXne+VcISGLNGKD/QudCizkpVWEtBtaW7b7MYbXNk2hT1
         lXbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722952777; x=1723557577;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ldHWvt49sDIe8d9GqRkvJXWy/GtTjHwVlzeV5qEa4J4=;
        b=KpnLhYvJxgEoBRTxEMi4bwnE4eGweMZr3etYJI8o474zQBXO9n2t0ea9E0X2cAIyzM
         XPNybhwVGLtj8oSS0Uewe/MJugsJLeHcJNhcdbGkUN10VCRGQV6i8HCqlPgCFl2KVAWY
         pG1woCA0myUzfh3WKLCiaBdDqHVDbGDJIAgW36CD/GGPQPptEBdsra/eSM8CmyxokpYC
         yFzt9r6S+Yaen/mc/tGQRckQtpryo1xFu3/ds4ZhdX3oHwJyFMhs0JsIGvg3vhfFqW9e
         4+vGqhuQzCe4WFpJk0ONd3A7YjTrSimVtsmOaMWWf9KNOT/OFUKQdIG4oretB8z2VJ60
         2qYQ==
X-Forwarded-Encrypted: i=1; AJvYcCVznVi2bbTeMgPJ2lJYEYdCf+gkwkLuUBdu1KjnTtRtowEpk7Za+Rh5yKM3nwqF8LQw0E3PVIX4V9wEW53wBhUHcmlesNEVHEh0HyZR
X-Gm-Message-State: AOJu0Ywv14NioRagXIu/YVHgzbgi98EMh81nOFKCRUacki+kBJs6DnIo
	GrYfHanmIhLfUMdllXce0eoHxpX8T4R9jVD+Cn06eJDD4kF/TFPh5z8pV/41+Lqa12aMiKhSdJ9
	H888pHESbaB2FqQ==
X-Google-Smtp-Source: AGHT+IEqaacVkLJfCD8zsGz5kCmDhyXK1FewElTfbchv5QMQEDf0xI/Y7xoF2Umo7xl+OIrm6tI9BSIhh77wwco=
X-Received: from aliceryhl.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:35bd])
 (user=aliceryhl job=sendgmr) by 2002:a05:600c:4928:b0:426:67d8:e09b with SMTP
 id 5b1f17b1804b1-428e47092dcmr406325e9.1.1722952777212; Tue, 06 Aug 2024
 06:59:37 -0700 (PDT)
Date: Tue, 06 Aug 2024 13:58:56 +0000
In-Reply-To: <20240806-linked-list-v4-0-23efc510ec92@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240806-linked-list-v4-0-23efc510ec92@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=6227; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=r7zuSn6T8aiTDmoxN80zggpcp4KnpOuTv4p3Sl1rO74=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBmsiw5+GHJ/klVk72FhCBbbiwKSOukj+m07VUKr
 8BBoW+QcgOJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZrIsOQAKCRAEWL7uWMY5
 Rn0MD/9SUxhdpoaP2ThrHhwSTWvEobJYYQ4Wu1Jej80IAWM6W/OcJ8HkoyL5v2MTpnuyTxWm09V
 gvtlUN5g2ytfLn+HkSwqB3Qz2USLEEESEMAwgXKPoWMEP+1gJFjiUOqxBLGUYuE2oOOdEaZDcyE
 Irp4blK1rAq8mIB8OGiYhWD18AXeYys0sZCu/J51JGIZ7jwWdC7h956N3bD0ExOYE3fPTT6/Vsl
 D+TNb9B2ix8YydSC4RFaWYyg6yY4uInP8F4xfuHL1H9ofhUfqzUH4Yv5vN5vV50aPxEF0ywVbGP
 8aaG/+1n6lO8GWCjlJVDp7k31SEOKolH0Uukq0GVB/yA587VtSUQ14E7CK9FJ1M5cB4xplAaZuk
 eHXjuLFWYTLonodni8euSHXd8c2/s0tOt7etGDLjzGmdRJurES0XidFZqkrmyUjuShKxier7Lmh
 XJ07UJCzDqdw6xFgrDb50p0tfU/A+10W0DFjiD2tPL3JdoWpvGE1XmvWeJTzFuZuTPBUW2VgEDs
 3v+YbRwd6ttoYCTU/foce0sExuH/k2NsHm1KPnyr0vjpiPOnUKU6IIpi9EZ5ENNXv4E8nPE7Xm9
 JN2J3n8R3kmpOFfI+Wio0d3YqJWApFcEzH5S+4xKYpGx5dGgZcjsPWMrLWd/ToTJPNMSXyCo+/H am5nPHjNQ1ONVRw==
X-Mailer: b4 0.13.0
Message-ID: <20240806-linked-list-v4-4-23efc510ec92@google.com>
Subject: [PATCH v4 04/10] rust: list: add struct with prev/next pointers
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
 rust/kernel/list.rs | 119 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 119 insertions(+)

diff --git a/rust/kernel/list.rs b/rust/kernel/list.rs
index 8e1533ee987b..074ae863ff5a 100644
--- a/rust/kernel/list.rs
+++ b/rust/kernel/list.rs
@@ -4,5 +4,124 @@
 
 //! A linked list implementation.
 
+use crate::init::PinInit;
+use crate::types::Opaque;
+use core::ptr;
+
 mod arc;
 pub use self::arc::{impl_list_arc_safe, AtomicTracker, ListArc, ListArcSafe, TryNewListArc};
+
+/// Implemented by types where a [`ListArc<Self>`] can be inserted into a `List`.
+///
+/// # Safety
+///
+/// Implementers must ensure that they provide the guarantees documented on methods provided by
+/// this trait.
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
+    /// * Returns the same pointer as the one passed to the most recent call to `prepare_to_insert`.
+    /// * The returned pointer is valid until the next call to `post_remove`.
+    ///
+    /// # Safety
+    ///
+    /// * The provided pointer must originate from the most recent call to `prepare_to_insert`, or
+    ///   from a call to `view_links` that happened after the most recent call to
+    ///   `prepare_to_insert`.
+    /// * Since the most recent call to `prepare_to_insert`, the `post_remove` method must not have
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
+    /// # Safety
+    ///
+    /// The provided pointer must be the pointer returned by the most recent call to
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
+    // This type is `!Unpin` for aliasing reasons as the pointers are part of an intrusive linked
+    // list.
+    #[allow(dead_code)]
+    inner: Opaque<ListLinksFields>,
+}
+
+// SAFETY: The only way to access/modify the pointers inside of `ListLinks<ID>` is via holding the
+// associated `ListArc<T, ID>`. Since that type correctly implements `Send`, it is impossible to
+// move this an instance of this type to a different thread if the pointees are `!Send`.
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
2.46.0.rc2.264.g509ed76dc8-goog


