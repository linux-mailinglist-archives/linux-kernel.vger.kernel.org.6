Return-Path: <linux-kernel+bounces-339619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C1D89867E0
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 22:53:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 845AF1F257BC
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 20:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 976AD150994;
	Wed, 25 Sep 2024 20:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="FK5+Nhg1"
Received: from mail-40133.protonmail.ch (mail-40133.protonmail.ch [185.70.40.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69413153838
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 20:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727297604; cv=none; b=mZ7TkhuVTLxg3j6ApJzaM/CoZ1X3GV2LjXpnOCm8sQ+9t4Q9iT6x08J4sZh+h6JnU9B52qToQV6HFekTyEJZpIKqNBsQfeW67TzeSSAB3CxL4rDEu2OM06BFp9NuQWiJcHvYIMEN0/zu+97W9/047wjFUpkrIyD+myzpVhfUKw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727297604; c=relaxed/simple;
	bh=IYVmKGR8BTQh+MjR3g//jQuhlY0zjVgj6wdU7ydD0Fc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eopkGWBY24WHp4QDL2+t9D03UlSzx98rzNBBjRGMi4AYy+A/D83/mTYqsMK/zmzG4ax1Bgx8SHD3YrrHwup8ecnTNPRzDDK1uKWZauvmW+JDqYT5WoBXiCmybHYGhbQnMbEd0xTh6O5XF4Nn9HGKEQ7CelYB73zC9pBnbZhegIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=FK5+Nhg1; arc=none smtp.client-ip=185.70.40.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1727297594; x=1727556794;
	bh=ZxKUuYTNuFDMzuoyfDreAfyk2YdwTAdXezye9i3yow4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=FK5+Nhg1gIifAh91THN0ojhFtU4/llF/O9QkT/bLANZrKuqb35cM0bGXBNwwpDUqB
	 btJ1ptXCm3SkISXre+z6QVrgP2G/COGlW0yM2HYXIv8m5TWc/2i9SAxShZEm3jifmd
	 16xvr7sq0auJIhyCodpd4CJjOobut5pLTZ+5YpCG7Ve9AfXqgyeNTINwpAZYIGxtnt
	 fLsKvt2FdGQp2/pFElz94bYNP3pQm/8QS+DDqMqG2HSU11sMqQ4e+8fKj5xbyJEy44
	 17t8rPDC1+yhPGUzLsJRswseVVq6q44QXQcAo4Ei88TSpf9F5MQXoqbIdWFZdPwVgk
	 iV0/otALr/hnQ==
Date: Wed, 25 Sep 2024 20:53:11 +0000
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Greg KH <gregkh@linuxfoundation.org>, Simona Vetter <simona.vetter@ffwll.ch>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] rust: switch uaccess to untrusted data API
Message-ID: <20240925205244.873020-3-benno.lossin@proton.me>
In-Reply-To: <20240925205244.873020-1-benno.lossin@proton.me>
References: <20240925205244.873020-1-benno.lossin@proton.me>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: abe00c8f502b7f6ab6b5ae2814a75fa72a9b0e03
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Userspace is an untrusted data source, so all data that can be read from
there is untrusted. Therefore use the new untrusted API for any data
returned from it.
This makes it significantly harder to write TOCTOU bug, the example bug
in the documentation cannot easily be converted to use the new API. Thus
it is removed.

A possible future improvement is to change how `UserSliceWriter` exposes
writing to userspace: a trait `ToUserspace` TBB (to be bikeshed) could
allow users to write untrusted data to a userpointer without adding more
methods to it.

Signed-off-by: Benno Lossin <benno.lossin@proton.me>
---
 rust/kernel/page.rs    |   8 ++-
 rust/kernel/uaccess.rs | 135 +++++++++++++++++++++--------------------
 2 files changed, 74 insertions(+), 69 deletions(-)

diff --git a/rust/kernel/page.rs b/rust/kernel/page.rs
index 208a006d587c..74ce86326893 100644
--- a/rust/kernel/page.rs
+++ b/rust/kernel/page.rs
@@ -5,9 +5,9 @@
 use crate::{
     alloc::{AllocError, Flags},
     bindings,
-    error::code::*,
-    error::Result,
+    error::{code::*, Result},
     uaccess::UserSliceReader,
+    validate::Untrusted,
 };
 use core::ptr::{self, NonNull};
=20
@@ -237,8 +237,10 @@ pub unsafe fn copy_from_user_slice_raw(
             // SAFETY: If `with_pointer_into_page` calls into this closure=
, then it has performed a
             // bounds check and guarantees that `dst` is valid for `len` b=
ytes. Furthermore, we have
             // exclusive access to the slice since the caller guarantees t=
hat there are no races.
-            reader.read_raw(unsafe { core::slice::from_raw_parts_mut(dst.c=
ast(), len) })
+            let slice =3D unsafe { core::slice::from_raw_parts_mut(dst.cas=
t(), len) };
+            reader.read_raw(Untrusted::new_mut(slice))
         })
+        .map(|_| ())
     }
 }
=20
diff --git a/rust/kernel/uaccess.rs b/rust/kernel/uaccess.rs
index e9347cff99ab..3d312f845269 100644
--- a/rust/kernel/uaccess.rs
+++ b/rust/kernel/uaccess.rs
@@ -10,10 +10,12 @@
     error::Result,
     prelude::*,
     types::{AsBytes, FromBytes},
+    validate::Untrusted,
 };
 use alloc::vec::Vec;
 use core::ffi::{c_ulong, c_void};
 use core::mem::{size_of, MaybeUninit};
+use init::init_from_closure;
=20
 /// The type used for userspace addresses.
 pub type UserPtr =3D usize;
@@ -47,59 +49,39 @@
 ///
 /// ```no_run
 /// use alloc::vec::Vec;
-/// use core::ffi::c_void;
-/// use kernel::error::Result;
-/// use kernel::uaccess::{UserPtr, UserSlice};
+/// use core::{convert::Infallible, ffi::c_void};
+/// use kernel::{error::Result, uaccess::{UserPtr, UserSlice}, validate::{=
Unvalidated, Untrusted, Validate}};
 ///
-/// fn bytes_add_one(uptr: UserPtr, len: usize) -> Result<()> {
-///     let (read, mut write) =3D UserSlice::new(uptr, len).reader_writer(=
);
+/// struct AddOne<'a>(&'a mut u8);
 ///
-///     let mut buf =3D Vec::new();
-///     read.read_all(&mut buf, GFP_KERNEL)?;
+/// impl<'a> Validate<&'a mut Unvalidated<u8>> for AddOne<'a> {
+///     type Err =3D Infallible;
 ///
-///     for b in &mut buf {
-///         *b =3D b.wrapping_add(1);
+///     fn validate(unvalidated: &'a mut Unvalidated<u8>) -> Result<Self, =
Self::Err> {
+///         // We are not doing any kind of validation here on purpose. Af=
ter all, we only want to
+///         // increment the value and write it back.
+///         Ok(Self(unvalidated.raw_mut()))
 ///     }
-///
-///     write.write_slice(&buf)?;
-///     Ok(())
 /// }
-/// ```
-///
-/// Example illustrating a TOCTOU (time-of-check to time-of-use) bug.
 ///
-/// ```no_run
-/// use alloc::vec::Vec;
-/// use core::ffi::c_void;
-/// use kernel::error::{code::EINVAL, Result};
-/// use kernel::uaccess::{UserPtr, UserSlice};
+/// impl AddOne<'_> {
+///     fn inc(&mut self) {
+///         *self.0 =3D self.0.wrapping_add(1);
+///     }
+/// }
 ///
-/// /// Returns whether the data in this region is valid.
-/// fn is_valid(uptr: UserPtr, len: usize) -> Result<bool> {
-///     let read =3D UserSlice::new(uptr, len).reader();
+/// fn bytes_add_one(uptr: UserPtr, len: usize) -> Result<()> {
+///     let (read, mut write) =3D UserSlice::new(uptr, len).reader_writer(=
);
 ///
 ///     let mut buf =3D Vec::new();
 ///     read.read_all(&mut buf, GFP_KERNEL)?;
 ///
-///     todo!()
-/// }
-///
-/// /// Returns the bytes behind this user pointer if they are valid.
-/// fn get_bytes_if_valid(uptr: UserPtr, len: usize) -> Result<Vec<u8>> {
-///     if !is_valid(uptr, len)? {
-///         return Err(EINVAL);
+///     for b in &mut buf {
+///         b.validate_mut::<AddOne<'_>>()?.inc();
 ///     }
 ///
-///     let read =3D UserSlice::new(uptr, len).reader();
-///
-///     let mut buf =3D Vec::new();
-///     read.read_all(&mut buf, GFP_KERNEL)?;
-///
-///     // THIS IS A BUG! The bytes could have changed since we checked th=
em.
-///     //
-///     // To avoid this kind of bug, don't call `UserSlice::new` multiple
-///     // times with the same address.
-///     Ok(buf)
+///     write.write_untrusted_slice(Untrusted::transpose_slice(&buf))?;
+///     Ok(())
 /// }
 /// ```
 ///
@@ -130,7 +112,7 @@ pub fn new(ptr: UserPtr, length: usize) -> Self {
     /// Reads the entirety of the user slice, appending it to the end of t=
he provided buffer.
     ///
     /// Fails with [`EFAULT`] if the read happens on a bad address.
-    pub fn read_all(self, buf: &mut Vec<u8>, flags: Flags) -> Result {
+    pub fn read_all(self, buf: &mut Vec<Untrusted<u8>>, flags: Flags) -> R=
esult {
         self.reader().read_all(buf, flags)
     }
=20
@@ -218,38 +200,47 @@ pub fn is_empty(&self) -> bool {
     /// Fails with [`EFAULT`] if the read happens on a bad address, or if =
the read goes out of
     /// bounds of this [`UserSliceReader`]. This call may modify `out` eve=
n if it returns an error.
     ///
+    /// Returns a reference to the initialized bytes in `out`.
+    ///
     /// # Guarantees
     ///
     /// After a successful call to this method, all bytes in `out` are ini=
tialized.
-    pub fn read_raw(&mut self, out: &mut [MaybeUninit<u8>]) -> Result {
-        let len =3D out.len();
-        let out_ptr =3D out.as_mut_ptr().cast::<c_void>();
-        if len > self.length {
-            return Err(EFAULT);
-        }
-        let Ok(len_ulong) =3D c_ulong::try_from(len) else {
-            return Err(EFAULT);
+    pub fn read_raw<'a>(
+        &'a mut self,
+        out: &'a mut Untrusted<[MaybeUninit<u8>]>,
+    ) -> Result<&'a mut Untrusted<[u8]>> {
+        let init =3D |ptr: *mut [u8]| {
+            let out_ptr =3D ptr.cast::<c_void>();
+            let len =3D ptr.len();
+            if len > self.length {
+                return Err(EFAULT);
+            }
+            let Ok(len_ulong) =3D c_ulong::try_from(len) else {
+                return Err(EFAULT);
+            };
+            // SAFETY: `out_ptr` points into a mutable slice of length `le=
n_ulong`, so we may write
+            // that many bytes to it.
+            let res =3D
+                unsafe { bindings::copy_from_user(out_ptr, self.ptr as *co=
nst c_void, len_ulong) };
+            if res !=3D 0 {
+                return Err(EFAULT);
+            }
+            self.ptr =3D self.ptr.wrapping_add(len);
+            self.length -=3D len;
+            Ok(())
         };
-        // SAFETY: `out_ptr` points into a mutable slice of length `len_ul=
ong`, so we may write
-        // that many bytes to it.
-        let res =3D
-            unsafe { bindings::copy_from_user(out_ptr, self.ptr as *const =
c_void, len_ulong) };
-        if res !=3D 0 {
-            return Err(EFAULT);
-        }
-        self.ptr =3D self.ptr.wrapping_add(len);
-        self.length -=3D len;
-        Ok(())
+        out.write_uninit_slice(unsafe { init_from_closure(init) })
     }
=20
     /// Reads raw data from the user slice into a kernel buffer.
     ///
     /// Fails with [`EFAULT`] if the read happens on a bad address, or if =
the read goes out of
     /// bounds of this [`UserSliceReader`]. This call may modify `out` eve=
n if it returns an error.
-    pub fn read_slice(&mut self, out: &mut [u8]) -> Result {
+    pub fn read_slice(&mut self, out: &mut Untrusted<[u8]>) -> Result<&mut=
 Untrusted<[u8]>> {
         // SAFETY: The types are compatible and `read_raw` doesn't write u=
ninitialized bytes to
         // `out`.
-        let out =3D unsafe { &mut *(out as *mut [u8] as *mut [MaybeUninit<=
u8>]) };
+        let out =3D
+            unsafe { &mut *(out as *mut Untrusted<[u8]> as *mut Untrusted<=
[MaybeUninit<u8>]>) };
         self.read_raw(out)
     }
=20
@@ -291,13 +282,15 @@ pub fn read<T: FromBytes>(&mut self) -> Result<T> {
     /// Reads the entirety of the user slice, appending it to the end of t=
he provided buffer.
     ///
     /// Fails with [`EFAULT`] if the read happens on a bad address.
-    pub fn read_all(mut self, buf: &mut Vec<u8>, flags: Flags) -> Result {
+    pub fn read_all(mut self, buf: &mut Vec<Untrusted<u8>>, flags: Flags) =
-> Result {
         let len =3D self.length;
-        VecExt::<u8>::reserve(buf, len, flags)?;
+        VecExt::<_>::reserve(buf, len, flags)?;
=20
         // The call to `try_reserve` was successful, so the spare capacity=
 is at least `len` bytes
         // long.
-        self.read_raw(&mut buf.spare_capacity_mut()[..len])?;
+        self.read_raw(Untrusted::transpose_slice_uninit_mut(
+            &mut buf.spare_capacity_mut()[..len],
+        ))?;
=20
         // SAFETY: Since the call to `read_raw` was successful, so the nex=
t `len` bytes of the
         // vector have been initialized.
@@ -333,8 +326,18 @@ pub fn is_empty(&self) -> bool {
     /// bounds of this [`UserSliceWriter`]. This call may modify the assoc=
iated userspace slice even
     /// if it returns an error.
     pub fn write_slice(&mut self, data: &[u8]) -> Result {
-        let len =3D data.len();
-        let data_ptr =3D data.as_ptr().cast::<c_void>();
+        self.write_untrusted_slice(Untrusted::new_ref(data))
+    }
+
+    /// Writes raw data to this user pointer from a kernel buffer.
+    ///
+    /// Fails with [`EFAULT`] if the write happens on a bad address, or if=
 the write goes out of
+    /// bounds of this [`UserSliceWriter`]. This call may modify the assoc=
iated userspace slice even
+    /// if it returns an error.
+    pub fn write_untrusted_slice(&mut self, data: &Untrusted<[u8]>) -> Res=
ult {
+        let data_ptr =3D (data as *const _) as *const [u8];
+        let len =3D data_ptr.len();
+        let data_ptr =3D data_ptr.cast::<c_void>();
         if len > self.length {
             return Err(EFAULT);
         }
--=20
2.46.0



