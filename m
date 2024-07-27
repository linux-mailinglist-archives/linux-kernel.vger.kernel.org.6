Return-Path: <linux-kernel+bounces-263964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B4BF993DD3E
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 06:25:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4403A1F23390
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 04:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF7CFBA5E;
	Sat, 27 Jul 2024 04:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="VIxLzRiv";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="NrxW8npn"
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31588469D;
	Sat, 27 Jul 2024 04:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722054304; cv=none; b=EOX+OfBsqdQS9gt2/izUOjtJlAtgqsgjuMl8o1Thg3nl5i15oX+LLdTeRlTSNVFjnpphej9lQkIcaTjLNdxsdWm4aYXK7Z91t+q3cIROISajLfNSn5Ni5Ga8M+lDMestY9rMvquDSfKFdohERlUxxsnaiPcc3OjDQetMeX2/hWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722054304; c=relaxed/simple;
	bh=BLWshaB639I9Y4xfgfqbX+op5Cc0PweVm+o28FZzsjs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=K6Cyk0FUkX21wRFvlBphKr85ab6Au4/O8HIlVCxMUl6DJ2KFmQ0HwPN/nLZrGK073LNTJPIB5Zy/n+0uzYF9pzHHrfDzK+hCB/LsJfqluLIgUaOXNLdF3fZ3G3dUkD/XbSgd3ygsU8u2wyVp7permC2DCIVnDfysbx9ajb2Q4Hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=VIxLzRiv; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=NrxW8npn; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4WWBNq2W2Tz9t4V;
	Sat, 27 Jul 2024 06:24:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1722054299;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=EvFDlAT6bSm4ZK0YHHMjAx+yZbFsKsUM3J2C8BY88GQ=;
	b=VIxLzRiv6nDqZ9+HET6Qb/I6YY5gRgjkF8Uz2kxj6UfKpZj+qtbcGJQhyMqBpO7brpug1q
	Lo1bsAWXe+29OnvnhdUld6ssD9n+kvcLm6MZPUheVN7WNLT/BSRrkbPrELqIA/t/3jmbf8
	S+p+O7hs/DX/rfzlXlUMsZLzgsnBC5rCp8Y3tBL60VUR+vHqbw0fss2rTjS6JbzvmYA77+
	nJL01Yxyu5mSe9PU2sqhZw60Z+VLta768si6DtDEMQOQYfOwpu9S2ZAIDQnW6NQFgWGMmi
	y6N18rmYE8MK9iDOIVEKLbCEWdkOhsEIK55IiunfhiX4lzwGAR5jM06W2ZkRrg==
From: Alex Mantel <alexmantel93@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1722054297;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=EvFDlAT6bSm4ZK0YHHMjAx+yZbFsKsUM3J2C8BY88GQ=;
	b=NrxW8npnUgj8knIJF2G9wB9Y5OmTdjtEDLlhAQ4R2gTY2BuBdKhrPdpImnWopcsXunLfwt
	jHcuzs2KO55t0FXtPhycc5SURb3FxfYK8uiTn+AAztsyUN8uuCHv0RwGJ+l7p97/m+qEYE
	5aubczqstLNqVnCfq8hexOxcyCAZwhmD226IIZotPXvcv60btMaIg6O5+6CYgX2Ow1nuKx
	+Sm617SYVWtXEYICxUwMExvs3k3YQOdI/dTLOM7P5yOFisaG/o3xi2O5rRzTZNSugw2DNM
	ljUGSCCpSb2oe8EKJ3jDN6SbXO8XQJdozQHImAe2q7ppje/ri6VrGv4xPyH7HQ==
To: ojeda@kernel.org,
	alex.gaynor@gmail.com,
	wedsonaf@gmail.com,
	boqun.feng@gmail.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	benno.lossin@proton.me,
	a.hindborg@samsung.com,
	aliceryhl@google.com,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Alex Mantel <alexmantel93@mailbox.org>
Subject: [PATCH v3] rust: Implement the smart pointer `InPlaceInit` for `Arc`
Date: Fri, 26 Jul 2024 21:24:42 -0700
Message-Id: <20240727042442.682109-1-alexmantel93@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 87cdbe66921b1de3be3
X-MBO-RS-META: qjf8jnorw5ggqd48bj7idagiqpn3xom8

For pinned and unpinned initialization of structs, a trait named
`InPlaceInit` exists for uniform access. `Arc` did not implement
`InPlaceInit` yet, although the functions already existed. The main
reason for that, was that the trait itself returned a `Pin<Self>`. The
`Arc` implementation of the kernel is already implicitly pinned.

To enable `Arc` to implement `InPlaceInit` and to have uniform access,
for in-place and pinned in-place initialization, an associated type is
introduced for `InPlaceInit`. The new implementation of `InPlaceInit`
for `Arc` sets `Arc` as the associated type. Older implementations use
an explicit `Pin<T>` as the associated type. The implemented methods for
`Arc` are mostly moved from a direct implementation on `Arc`. There
should be no user impact. The implementation for `ListArc` is omitted,
because it is not merged yet.

Link: https://github.com/Rust-for-Linux/linux/issues/1079
Signed-off-by: Alex Mantel <alexmantel93@mailbox.org>
---
Hello again!

This is the 3rd version of my very first patch. I applied the
suggestions on the 2nd submission. Thank you again for your feedback,
looking for more!

v1: 
  * https://lore.kernel.org/rust-for-linux/20240717034801.262343-2-alexmantel93@mailbox.org/

v2: 
  * remove the `From:` from the patch.
  * add the prefix `rust: ` to the subject.
  * Remove the empty line between `Link` and `Signed-off-by`.
  * https://lore.kernel.org/all/20240719192234.330341-1-alexmantel93@mailbox.org/

v3:
  * Rename PinnedResult to PinnedSelf
  * Adjust documentation for PinnedSelf

 rust/kernel/init.rs     | 39 +++++++++++++++++++++++++++++++++++----
 rust/kernel/sync/arc.rs | 25 ++-----------------------
 2 files changed, 37 insertions(+), 27 deletions(-)

diff --git a/rust/kernel/init.rs b/rust/kernel/init.rs
index 68605b633..fa5f182fe 100644
--- a/rust/kernel/init.rs
+++ b/rust/kernel/init.rs
@@ -213,6 +213,7 @@
 use crate::{
     alloc::{box_ext::BoxExt, AllocError, Flags},
     error::{self, Error},
+    sync::Arc,
     sync::UniqueArc,
     types::{Opaque, ScopeGuard},
 };
@@ -1112,11 +1113,17 @@ unsafe fn __pinned_init(self, slot: *mut T) -> Result<(), E> {
 
 /// Smart pointer that can initialize memory in-place.
 pub trait InPlaceInit<T>: Sized {
+    /// Pinned version of Rusts `Self`.
+    ///
+    /// If a type already implicitly pins its pointee, `Pin<Self>` is unnecessary. In this case use
+    /// `Self`, otherwise just use `Pin<Self>`.
+    type PinnedSelf;
+
     /// Use the given pin-initializer to pin-initialize a `T` inside of a new smart pointer of this
     /// type.
     ///
     /// If `T: !Unpin` it will not be able to move afterwards.
-    fn try_pin_init<E>(init: impl PinInit<T, E>, flags: Flags) -> Result<Pin<Self>, E>
+    fn try_pin_init<E>(init: impl PinInit<T, E>, flags: Flags) -> Result<Self::PinnedSelf, E>
     where
         E: From<AllocError>;
 
@@ -1124,7 +1131,7 @@ fn try_pin_init<E>(init: impl PinInit<T, E>, flags: Flags) -> Result<Pin<Self>,
     /// type.
     ///
     /// If `T: !Unpin` it will not be able to move afterwards.
-    fn pin_init<E>(init: impl PinInit<T, E>, flags: Flags) -> error::Result<Pin<Self>>
+    fn pin_init<E>(init: impl PinInit<T, E>, flags: Flags) -> error::Result<Self::PinnedSelf>
     where
         Error: From<E>,
     {
@@ -1153,9 +1160,31 @@ fn init<E>(init: impl Init<T, E>, flags: Flags) -> error::Result<Self>
     }
 }
 
+impl<T> InPlaceInit<T> for Arc<T> {
+    type PinnedSelf = Self;
+
+    #[inline]
+    fn try_pin_init<E>(init: impl PinInit<T, E>, flags: Flags) -> Result<Self::PinnedSelf, E>
+    where
+        E: From<AllocError>,
+    {
+        UniqueArc::try_pin_init(init, flags).map(|u| u.into())
+    }
+
+    #[inline]
+    fn try_init<E>(init: impl Init<T, E>, flags: Flags) -> Result<Self, E>
+    where
+        E: From<AllocError>,
+    {
+        UniqueArc::try_init(init, flags).map(|u| u.into())
+    }
+}
+
 impl<T> InPlaceInit<T> for Box<T> {
+    type PinnedSelf = Pin<Self>;
+
     #[inline]
-    fn try_pin_init<E>(init: impl PinInit<T, E>, flags: Flags) -> Result<Pin<Self>, E>
+    fn try_pin_init<E>(init: impl PinInit<T, E>, flags: Flags) -> Result<Self::PinnedSelf, E>
     where
         E: From<AllocError>,
     {
@@ -1184,8 +1213,10 @@ fn try_init<E>(init: impl Init<T, E>, flags: Flags) -> Result<Self, E>
 }
 
 impl<T> InPlaceInit<T> for UniqueArc<T> {
+    type PinnedSelf = Pin<Self>;
+
     #[inline]
-    fn try_pin_init<E>(init: impl PinInit<T, E>, flags: Flags) -> Result<Pin<Self>, E>
+    fn try_pin_init<E>(init: impl PinInit<T, E>, flags: Flags) -> Result<Self::PinnedSelf, E>
     where
         E: From<AllocError>,
     {
diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
index 3673496c2..3021f30fd 100644
--- a/rust/kernel/sync/arc.rs
+++ b/rust/kernel/sync/arc.rs
@@ -12,12 +12,13 @@
 //! 2. It does not support weak references, which allows it to be half the size.
 //! 3. It saturates the reference count instead of aborting when it goes over a threshold.
 //! 4. It does not provide a `get_mut` method, so the ref counted object is pinned.
+//! 5. The object in [`Arc`] is pinned implicitly.
 //!
 //! [`Arc`]: https://doc.rust-lang.org/std/sync/struct.Arc.html
 
 use crate::{
     alloc::{box_ext::BoxExt, AllocError, Flags},
-    error::{self, Error},
+    bindings,
     init::{self, InPlaceInit, Init, PinInit},
     try_init,
     types::{ForeignOwnable, Opaque},
@@ -209,28 +210,6 @@ pub fn new(contents: T, flags: Flags) -> Result<Self, AllocError> {
         // `Arc` object.
         Ok(unsafe { Self::from_inner(Box::leak(inner).into()) })
     }
-
-    /// Use the given initializer to in-place initialize a `T`.
-    ///
-    /// If `T: !Unpin` it will not be able to move afterwards.
-    #[inline]
-    pub fn pin_init<E>(init: impl PinInit<T, E>, flags: Flags) -> error::Result<Self>
-    where
-        Error: From<E>,
-    {
-        UniqueArc::pin_init(init, flags).map(|u| u.into())
-    }
-
-    /// Use the given initializer to in-place initialize a `T`.
-    ///
-    /// This is equivalent to [`Arc<T>::pin_init`], since an [`Arc`] is always pinned.
-    #[inline]
-    pub fn init<E>(init: impl Init<T, E>, flags: Flags) -> error::Result<Self>
-    where
-        Error: From<E>,
-    {
-        UniqueArc::init(init, flags).map(|u| u.into())
-    }
 }
 
 impl<T: ?Sized> Arc<T> {
-- 
2.39.2


