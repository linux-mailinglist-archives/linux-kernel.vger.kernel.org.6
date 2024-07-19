Return-Path: <linux-kernel+bounces-257641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E533937CEE
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 21:23:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE72E282890
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 19:23:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CC4514831C;
	Fri, 19 Jul 2024 19:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="i8vsH30t";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="evmpP3uX"
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0187C147C8B;
	Fri, 19 Jul 2024 19:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721416984; cv=none; b=tTaGl8yEMjWq0R454Chej3aJMUVhA1nHV4lKZM+AGyIHOm4o2486WT969+jFOwvbJ+Xkfmfcr5RLDwDVSYRxUqUHBqRIHv46AgkglgtB0LXT9JorLAdlZzboxNz2DS8w1vHPEyrAcmF+5s4q2CPRbX2SWGBxl0faX1QjU94mE/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721416984; c=relaxed/simple;
	bh=FiB1k7ZW2L9qvrbLzTajYumpfEgNj1qVPCi/WpVMsWA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SgifNhl5tv9u8ZYrgaGAurPw9lax5lFRCrEWEiO6DqwlrO5t9csjz2mnFLq1+vQSKMqukgFp5gwYNT4mv+XV9FhFXDtH2SaPB+YCR+r0AE6UymScFuduuT04pmZ870FZ4inP6fiInUsK9ZR/64C+ijB3UiA2HWYDlibgw2Q3iwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=i8vsH30t; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=evmpP3uX; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4WQfhW6Stwz9sQr;
	Fri, 19 Jul 2024 21:22:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1721416971;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=3ZBvqEenjInpmNIAA4ZKnr+Ec9cxwQRrsbC7X+M+5qI=;
	b=i8vsH30t6DkZEvleP99CmjQVlNZmGUZGnH+C0xxD5LFR70fsoYFFkX3J2p+cNpA3M7gaTL
	R4xiM2uvUj02Q6bHhj0eYFAPncPIUklZ5A6Lc8V7z/OVnn4fjgZ+PZsUReib0RnalQEkM9
	uf+PcdlVpcwg8f5jfmptTI9IFARv0UtMJfFCIJwA5GTMtHmg22jKqO6dxgcVSZXi9ZZ5A/
	Opj71W+noBjq0t6ymvNA18YiZqPLJa4kkEn8+TyLLsXA8J6YrUV1UviqtMt/9gB0X/lyjl
	4iSXlc63zWTOyemv+ls/y9VGsWmQwDIFf0aw5atNVp6GOxTssAPyRwDBH1/rsA==
From: Alex Mantel <alexmantel93@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1721416969;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=3ZBvqEenjInpmNIAA4ZKnr+Ec9cxwQRrsbC7X+M+5qI=;
	b=evmpP3uXBOsM6t88c8+aLBSLPO+BW4YJGC3NcOa+scgXsKibMs14SZxBYGN25oYHKcXWif
	Db504sZFobJn33B8Rcb6nXVfUFlW9fH6v/G7V2Bl6XEbGfAuLXyFpgHAGbtv8+SmfCktxm
	Moon17GAI89meOPkV+Y0+jwZ/KMaYFwltnnvaSMcmWAkn1Vt2E5YsqCtxZiBZkfFUlEmpE
	J/VRJB796Rbb56Z4k+Vi8TPgfrgND+eCQl2yU1dZeo1qzZTKNT11b6sbQBwmXI1n4llPpQ
	y+ghuZtpWxXSEPCnYK5Jar/drQUFj9CiWvzGvEHXtToMIGfF1WoUkfCtPTf5Tw==
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
Subject: [PATCH v2] rust: Implement the smart pointer `InPlaceInit` for `Arc`
Date: Fri, 19 Jul 2024 12:22:34 -0700
Message-Id: <20240719192234.330341-1-alexmantel93@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 939419403be119f10dd
X-MBO-RS-META: 4u8x7ejxx5skkou8wmhfr9d4uugg59zi
X-Rspamd-Queue-Id: 4WQfhW6Stwz9sQr

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

This is the 2nd version of my very first patch. In comparison to the
first version, this version changes the format of the commit
message only, as suggested by Miguel Ojeda. Thank you for taking the
time. Any further feedback is more than welcome!

v1: 
  * https://lore.kernel.org/rust-for-linux/20240717034801.262343-2-alexmantel93@mailbox.org/

v2: 
  * remove the `From:` from the patch.
  * add the prefix `rust: ` to the subject.
  * Remove the empty line between `Link` and `Signed-off-by`.


 rust/kernel/init.rs     | 37 +++++++++++++++++++++++++++++++++----
 rust/kernel/sync/arc.rs | 25 ++-----------------------
 2 files changed, 35 insertions(+), 27 deletions(-)

diff --git a/rust/kernel/init.rs b/rust/kernel/init.rs
index 68605b633..46f50cf12 100644
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
@@ -1112,11 +1113,15 @@ unsafe fn __pinned_init(self, slot: *mut T) -> Result<(), E> {
 
 /// Smart pointer that can initialize memory in-place.
 pub trait InPlaceInit<T>: Sized {
+    /// A type might be pinned implicitly. An addtional `Pin<ImplicitlyPinned>` is useless. In
+    /// doubt, the type can just be set to `Pin<Self>`.
+    type PinnedResult;
+
     /// Use the given pin-initializer to pin-initialize a `T` inside of a new smart pointer of this
     /// type.
     ///
     /// If `T: !Unpin` it will not be able to move afterwards.
-    fn try_pin_init<E>(init: impl PinInit<T, E>, flags: Flags) -> Result<Pin<Self>, E>
+    fn try_pin_init<E>(init: impl PinInit<T, E>, flags: Flags) -> Result<Self::PinnedResult, E>
     where
         E: From<AllocError>;
 
@@ -1124,7 +1129,7 @@ fn try_pin_init<E>(init: impl PinInit<T, E>, flags: Flags) -> Result<Pin<Self>,
     /// type.
     ///
     /// If `T: !Unpin` it will not be able to move afterwards.
-    fn pin_init<E>(init: impl PinInit<T, E>, flags: Flags) -> error::Result<Pin<Self>>
+    fn pin_init<E>(init: impl PinInit<T, E>, flags: Flags) -> error::Result<Self::PinnedResult>
     where
         Error: From<E>,
     {
@@ -1153,9 +1158,31 @@ fn init<E>(init: impl Init<T, E>, flags: Flags) -> error::Result<Self>
     }
 }
 
+impl<T> InPlaceInit<T> for Arc<T> {
+    type PinnedResult = Self;
+
+    #[inline]
+    fn try_pin_init<E>(init: impl PinInit<T, E>, flags: Flags) -> Result<Self::PinnedResult, E>
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
+    type PinnedResult = Pin<Self>;
+
     #[inline]
-    fn try_pin_init<E>(init: impl PinInit<T, E>, flags: Flags) -> Result<Pin<Self>, E>
+    fn try_pin_init<E>(init: impl PinInit<T, E>, flags: Flags) -> Result<Self::PinnedResult, E>
     where
         E: From<AllocError>,
     {
@@ -1184,8 +1211,10 @@ fn try_init<E>(init: impl Init<T, E>, flags: Flags) -> Result<Self, E>
 }
 
 impl<T> InPlaceInit<T> for UniqueArc<T> {
+    type PinnedResult = Pin<Self>;
+
     #[inline]
-    fn try_pin_init<E>(init: impl PinInit<T, E>, flags: Flags) -> Result<Pin<Self>, E>
+    fn try_pin_init<E>(init: impl PinInit<T, E>, flags: Flags) -> Result<Self::PinnedResult, E>
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


