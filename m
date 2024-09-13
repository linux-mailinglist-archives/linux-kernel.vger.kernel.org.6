Return-Path: <linux-kernel+bounces-328059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2309D977E74
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 13:27:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 531BBB287DA
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 11:27:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6452B1D88C1;
	Fri, 13 Sep 2024 11:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="GfAJqd8V"
Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC1B71D86D9;
	Fri, 13 Sep 2024 11:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726226828; cv=none; b=EgIbll3DmCJCBvWrxQ+z/pQlOftoxNd1skSBib+sRdrela/AxSXimes5kLZbXWbM/C62IFccqNHZZWzHD6SPehbckYY0xkD6kHlomIDmYYTf23DCvECVe7M6o1fgnrnwdkZ3ByJID2dXLa66Mulr6w1Swwzbxx71TaHWmHVtW+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726226828; c=relaxed/simple;
	bh=rEdfMrs1S7lhMN2tPQr84DyozGvdFKVqMen4zKX/92E=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aiHZpG1+s8bbOPZangE5uROkjqchNFtuBdFLIsiO+JncsIU14MULp088tVfLtSCMOIJFjH0tGsR0az4G4Bl8nVQ9r8nKyqIy+HGgzxVHsShYiNGOf6jfX4pzFQPVD3OcHyXD8qAnpp031EXOhkvIwzgK1psTpUDYxJWBYejSACE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=GfAJqd8V; arc=none smtp.client-ip=185.70.40.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1726226824; x=1726486024;
	bh=VXlvsiP9/15yoWne8oVREcHFiFxMqjN6JbRGZinEa08=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=GfAJqd8VQkntF5CnFvTO4ypUqkwrP0u81p4kCRR2BO4XsGWA2NlPMv4vLrAYDOT5/
	 dvTFHlFcTOB4scE34x+bPcR49wRtJDUcg6+p4s77phtGkllGukU9qN5jx8tYfqHwfX
	 WP2KC39CgpMIdijx81tFGQ5VElf56XCwZk84EiC4jBr69sgMy6SbRdTndDuAMI+BqH
	 Qx/zGeB3ShBW3GchlJe16V0s38teMFlsAHwTsdSAqMKor6huPHuTNlRmleZNS9nscS
	 S6wEAD3VlvERLMKsVk6qkD/IaH2+qXNbomZLAAy0JKYh3dGhoQlPWTpeT/Xo2QmQN4
	 6B6kTomPloMnQ==
Date: Fri, 13 Sep 2024 11:27:01 +0000
To: Greg KH <gregkh@linuxfoundation.org>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>
From: Benno Lossin <benno.lossin@proton.me>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 2/3] WIP: rust: fs: mark data returned by inodes untrusted
Message-ID: <20240913112643.542914-3-benno.lossin@proton.me>
In-Reply-To: <20240913112643.542914-1-benno.lossin@proton.me>
References: <20240913112643.542914-1-benno.lossin@proton.me>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 8088ee40b91d921899128e19c1fa02f86a1d05ea
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

This is only meant to show how one would use the untrusted data API, not
to be actually used in production, as I just added `Untrusted` where I
thought it might fit. I have no idea if this is actually the correct
place where the untrusted data path starts.
---
 rust/kernel/fs/inode.rs | 33 +++++++++++++++++++++------------
 1 file changed, 21 insertions(+), 12 deletions(-)

diff --git a/rust/kernel/fs/inode.rs b/rust/kernel/fs/inode.rs
index b2b7d000080e..349f7f1ab420 100644
--- a/rust/kernel/fs/inode.rs
+++ b/rust/kernel/fs/inode.rs
@@ -11,7 +11,9 @@
     PageOffset, UnspecifiedFS,
 };
 use crate::error::{code::*, from_err_ptr, Result};
-use crate::types::{ARef, AlwaysRefCounted, Either, ForeignOwnable, Lockabl=
e, Locked, Opaque};
+use crate::types::{
+    ARef, AlwaysRefCounted, Either, ForeignOwnable, Lockable, Locked, Opaq=
ue, Untrusted,
+};
 use crate::{
     bindings, block, build_error, container_of, folio, folio::Folio, mem_c=
ache::MemCache,
     str::CStr, str::CString, time::Timespec,
@@ -133,21 +135,24 @@ pub unsafe fn mapper(&self) -> Mapper<T> {
     pub unsafe fn mapped_folio(
         &self,
         offset: Offset,
-    ) -> Result<folio::Mapped<'_, folio::PageCache<T>>> {
+    ) -> Result<Untrusted<folio::Mapped<'_, folio::PageCache<T>>>> {
         let page_index =3D offset >> bindings::PAGE_SHIFT;
         let page_offset =3D offset & ((bindings::PAGE_SIZE - 1) as Offset)=
;
         let folio =3D self.read_mapping_folio(page_index.try_into()?)?;
+        let folio =3D folio.into_inner_untrusted();
=20
         // SAFETY: The safety requirements guarantee that there are no con=
current mutable mappings
         // of the folio.
-        unsafe { Folio::map_owned(folio, page_offset.try_into()?) }
+        Ok(Untrusted::new_untrusted(unsafe {
+            Folio::map_owned(folio, page_offset.try_into()?)?
+        }))
     }
=20
     /// Returns the folio at the given page index.
     pub fn read_mapping_folio(
         &self,
         index: PageOffset,
-    ) -> Result<ARef<Folio<folio::PageCache<T>>>> {
+    ) -> Result<Untrusted<ARef<Folio<folio::PageCache<T>>>>> {
         let folio =3D from_err_ptr(unsafe {
             bindings::read_mapping_folio(
                 (*self.0.get()).i_mapping,
@@ -159,7 +164,7 @@ pub fn read_mapping_folio(
             .ok_or(EIO)?
             .cast::<Folio<folio::PageCache<T>>>();
         // SAFETY: The folio returned by read_mapping_folio has had its re=
fcount incremented.
-        Ok(unsafe { ARef::from_raw(ptr) })
+        Ok(Untrusted::new_untrusted(unsafe { ARef::from_raw(ptr) }))
     }
=20
     /// Iterate over the given range, one folio at a time.
@@ -171,7 +176,7 @@ pub unsafe fn for_each_page<U>(
         &self,
         first: Offset,
         len: Offset,
-        mut cb: impl FnMut(&[u8]) -> Result<Option<U>>,
+        mut cb: impl FnMut(&Untrusted<[u8]>) -> Result<Option<U>>,
     ) -> Result<Option<U>> {
         if first >=3D self.size() {
             return Ok(None);
@@ -183,8 +188,9 @@ pub unsafe fn for_each_page<U>(
         while remain > 0 {
             // SAFETY: The safety requirements of this function satisfy th=
ose of `mapped_folio`.
             let data =3D unsafe { self.mapped_folio(next)? };
+            let data =3D data.into_inner_untrusted();
             let avail =3D cmp::min(data.len(), remain.try_into().unwrap_or=
(usize::MAX));
-            let ret =3D cb(&data[..avail])?;
+            let ret =3D cb(Untrusted::new_untrusted_ref(&data[..avail]))?;
             if ret.is_some() {
                 return Ok(ret);
             }
@@ -297,7 +303,7 @@ impl<T: FileSystem + ?Sized, U: Deref<Target =3D INode<=
T>>> Locked<U, ReadSem> {
     pub fn mapped_folio<'a>(
         &'a self,
         offset: Offset,
-    ) -> Result<folio::Mapped<'a, folio::PageCache<T>>>
+    ) -> Result<Untrusted<folio::Mapped<'a, folio::PageCache<T>>>>
     where
         T: 'a,
     {
@@ -315,7 +321,7 @@ pub fn for_each_page<V>(
         &self,
         first: Offset,
         len: Offset,
-        cb: impl FnMut(&[u8]) -> Result<Option<V>>,
+        cb: impl FnMut(&Untrusted<[u8]>) -> Result<Option<V>>,
     ) -> Result<Option<V>> {
         if T::IS_UNSPECIFIED {
             build_error!("unspecified file systems cannot safely map folio=
s");
@@ -750,14 +756,17 @@ pub fn split_at(mut self, offset: Offset) -> (Self, S=
elf) {
     }
=20
     /// Returns a mapped folio at the given offset.
-    pub fn mapped_folio(&self, offset: Offset) -> Result<folio::Mapped<'_,=
 folio::PageCache<T>>> {
+    pub fn mapped_folio(
+        &self,
+        offset: Offset,
+    ) -> Result<Untrusted<folio::Mapped<'_, folio::PageCache<T>>>> {
         if offset < self.begin || offset >=3D self.end {
             return Err(ERANGE);
         }
=20
         // SAFETY: By the type invariant, there are no other mutable mappi=
ngs of the folio.
         let mut map =3D unsafe { self.inode.mapped_folio(offset) }?;
-        map.cap_len((self.end - offset).try_into()?);
+        map.untrusted_mut().cap_len((self.end - offset).try_into()?);
         Ok(map)
     }
=20
@@ -766,7 +775,7 @@ pub fn for_each_page<U>(
         &self,
         first: Offset,
         len: Offset,
-        cb: impl FnMut(&[u8]) -> Result<Option<U>>,
+        cb: impl FnMut(&Untrusted<[u8]>) -> Result<Option<U>>,
     ) -> Result<Option<U>> {
         if first < self.begin || first >=3D self.end {
             return Err(ERANGE);
--=20
2.46.0



