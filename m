Return-Path: <linux-kernel+bounces-244879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 57D8392AAC7
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 22:54:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 84CDCB21B8B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 20:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D61414D439;
	Mon,  8 Jul 2024 20:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="kZKtCCmi"
Received: from mail-40133.protonmail.ch (mail-40133.protonmail.ch [185.70.40.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51711145325
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 20:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720472034; cv=none; b=a22M8W67IDz/5bEql/LLyec4e0C+LjZqMIF3W2CFpZGj3P0n2ZHYkdwQ5CdovZ9KzKUvqR90AM/1DMR19T6KxKUWXgTjaoEqar8RCTZvBmag7yJTLU7eky4WdF4IBggkUISBqQxs+jSE5dDZ4RFeVKAJtyexh5nRkXcwDcrsX6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720472034; c=relaxed/simple;
	bh=WNebBjovG/Y6t0JuS5L8wMjhlvUTtJyVx+KZL4FTy+M=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=GEDasgTcLT4fuxVECURKFNE1dDMp+A35f1xgekGEA3b34tCJUKy4LvXM/E7KdEk4+YV64aC8ys7KhbtfydUDvbKu8RU7x6fyy1DcRm/F/qNIAb/Ztds0pOG2yWr8tQVqcSdgg/jh10bk2JTIvxz+gcqnak1Z+n/HT6FFHnTtvPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=kZKtCCmi; arc=none smtp.client-ip=185.70.40.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1720472025; x=1720731225;
	bh=2gcmWYfWtpmlwzJsSgWAl2wQYGpH1V/X6Lqlx4Fibuw=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=kZKtCCminbqvJ4GdSAbhSBaimBnZXbalgw+oVJc+OswCf2S66h/KwjFvagcyUhRsQ
	 OiTXk/cessoJO9xsIOjuJItQjWO2MY4KYmdVNM7+EuzZ0jk37NHndqsNWWZJtl4tbE
	 DF0lXuLi4A1ZDCo+weiFCaGUsHMcb423yFhKtSCAY4Y7BwE0CxZiUcYuBjl1ocYR6K
	 1A6JVNSoYPZfDM46up4Mq5uVbJFhwkLff57C8ydalxl65CRLNWkl4QqdGr5E6MiYGZ
	 TZMUO82XruUdm07bmaTvvOECgPbeFhDOHT+D5+MKzAmrBDNsCyqmfc/eOjlGNgFhUF
	 EYT8P0KTpX6Kg==
Date: Mon, 08 Jul 2024 20:53:38 +0000
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] rust: kernel: add `drop_contents` to `BoxExt`
Message-ID: <20240708205325.1275473-1-benno.lossin@proton.me>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: ed48222fba2e3e5d6a8f896c32ab85b5f1ca27c3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Sometimes (see [1]) it is necessary to drop the value inside of a
`Box<T>`, but retain the allocation. For example to reuse the allocation
in the future.
Introduce a new function `drop_contents` that turns a `Box<T>` into
`Box<MaybeUninit<T>>` by dropping the value.

Signed-off-by: Benno Lossin <benno.lossin@proton.me>
Link: https://lore.kernel.org/rust-for-linux/20240418-b4-rbtree-v3-5-323e13=
4390ce@google.com/ [1]
---
 rust/kernel/alloc/box_ext.rs | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/rust/kernel/alloc/box_ext.rs b/rust/kernel/alloc/box_ext.rs
index cdbb5ad166d9..6cf79f96d6c7 100644
--- a/rust/kernel/alloc/box_ext.rs
+++ b/rust/kernel/alloc/box_ext.rs
@@ -5,6 +5,7 @@
 use super::{AllocError, Flags};
 use alloc::boxed::Box;
 use core::mem::MaybeUninit;
+use core::ptr;
 use core::result::Result;
=20
 /// Extensions to [`Box`].
@@ -18,6 +19,18 @@ pub trait BoxExt<T>: Sized {
     ///
     /// The allocation may fail, in which case an error is returned.
     fn new_uninit(flags: Flags) -> Result<Box<MaybeUninit<T>>, AllocError>=
;
+
+    /// Drops the contents, but keeps the allocation.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// let value =3D Box::new([0; 32], flags::GFP_KERNEL)
+    /// let value =3D value.drop_contents();
+    /// // Now we can re-use `value`:
+    /// Box::write(value, [1; 32]);
+    /// ```
+    fn drop_contents(self) -> Box<MaybeUninit<T>>;
 }
=20
 impl<T> BoxExt<T> for Box<T> {
@@ -54,4 +67,12 @@ fn new_uninit(flags: Flags) -> Result<Box<MaybeUninit<T>=
>, AllocError> {
         // zero-sized types, we use `NonNull::dangling`.
         Ok(unsafe { Box::from_raw(ptr) })
     }
+
+    fn drop_contents(self) -> Box<MaybeUninit<T>> {
+        let ptr =3D Box::into_raw(self);
+        // SAFETY: `ptr` is valid, because it came from `Box::into_raw`.
+        unsafe { ptr::drop_in_place(ptr) };
+        // SAFETY: `ptr` is valid, because it came from `Box::into_raw`.
+        unsafe { Box::from_raw(ptr.cast()) }
+    }
 }
--=20
2.44.0



