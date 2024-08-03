Return-Path: <linux-kernel+bounces-273504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C4CF946A09
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Aug 2024 16:17:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE0E21C20B70
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Aug 2024 14:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E95714EC4D;
	Sat,  3 Aug 2024 14:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="MR9HsNh6"
Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1DC3B641;
	Sat,  3 Aug 2024 14:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722694620; cv=none; b=WV5/ha4ALUZyK6e/X8jP7GuYc5h1Y5/PlSP6Bta9EtiGW4gxCyqhoK6csT8FhdI4//X769WQ94C/Uzdz6nLt9NTqbo9B4N7F4BoDqcsicBs+yxc6NaHVJbQjJE06GvSGkIGTxt4WIkAlE8MmyzEEzoxwk0KzeXeNNcDWFaVKMOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722694620; c=relaxed/simple;
	bh=3+Ynq/blDlS/A1xWsiCrCm+4IrtRXyRbpnMqLqXw6ik=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=PyxN7X8mUCTBL9RDyFkw2qUXmliMyRl4N2MDZfpotbvATLb2kKo6R0bFR0LSzyBUvheex+jDWo0HVR42Qny12lzWtYs8gZn3S3UYLWiKyexStJnKEai8AzWFLMLo0e4A8FLDPH+/jCImy2lurVwJEOgCCi8WQxqO3oFwaEQXnaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=MR9HsNh6; arc=none smtp.client-ip=185.70.40.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1722694615; x=1722953815;
	bh=hAQ6hy44bp3XygD6ePThhXDsm8YAT2lNRtRycLfd8Lw=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=MR9HsNh6cH4NxDg9pvs+a6Y25nCmGwIsmfffMGI4DVBVkh0iFbSHEV4Krauz4jMtk
	 XvdOcXzSHTGigQi2WcDr7R3s1In3uAEEdWandgBXci7UCueXzar1NgJ8irvejeAOR6
	 ADhDOL2VzZvlPvQP+UG3CHjnZLmPIaAwdDXxEldgwVyxMZ17qrHvVmrdOple4MntXB
	 5VNtmFb96kAj++DNkQtTBhFUrsQ4cRAdW4g2/8O54LmxZgVMeev++6R25XcgbT8PfN
	 X/T1zDYwE80+f+QF1ZAKVFMK0daZ6eiRrJHSd5mE9RqPn5zuEaZ+kUi6jY3Fp5nGOF
	 0rQ176yn77I9w==
Date: Sat, 03 Aug 2024 14:16:49 +0000
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] rust: kernel: add `drop_contents` to `BoxExt`
Message-ID: <20240803141639.3237686-1-benno.lossin@proton.me>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: cbd9a19a765b4f558cda95955f0c0f8c875b915a
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
 rust/kernel/alloc/box_ext.rs | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/alloc/box_ext.rs b/rust/kernel/alloc/box_ext.rs
index 829cb1c1cf9e..076d5de5f47d 100644
--- a/rust/kernel/alloc/box_ext.rs
+++ b/rust/kernel/alloc/box_ext.rs
@@ -4,7 +4,7 @@
=20
 use super::{AllocError, Flags};
 use alloc::boxed::Box;
-use core::mem::MaybeUninit;
+use core::{mem::MaybeUninit, ptr, result::Result};
=20
 /// Extensions to [`Box`].
 pub trait BoxExt<T>: Sized {
@@ -17,6 +17,22 @@ pub trait BoxExt<T>: Sized {
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
+    /// use kernel::alloc::{flags, box_ext::BoxExt};
+    /// let value =3D Box::new([0; 32], flags::GFP_KERNEL)?;
+    /// assert_eq!(*value, [0; 32]);
+    /// let value =3D Box::drop_contents(value);
+    /// // Now we can re-use `value`:
+    /// let value =3D Box::write(value, [1; 32]);
+    /// assert_eq!(*value, [1; 32]);
+    /// # Ok::<(), Error>(())
+    /// ```
+    fn drop_contents(this: Self) -> Box<MaybeUninit<T>>;
 }
=20
 impl<T> BoxExt<T> for Box<T> {
@@ -53,4 +69,12 @@ fn new_uninit(flags: Flags) -> Result<Box<MaybeUninit<T>=
>, AllocError> {
         // zero-sized types, we use `NonNull::dangling`.
         Ok(unsafe { Box::from_raw(ptr) })
     }
+
+    fn drop_contents(this: Self) -> Box<MaybeUninit<T>> {
+        let ptr =3D Box::into_raw(this);
+        // SAFETY: `ptr` is valid, because it came from `Box::into_raw`.
+        unsafe { ptr::drop_in_place(ptr) };
+        // SAFETY: `ptr` is valid, because it came from `Box::into_raw`.
+        unsafe { Box::from_raw(ptr.cast()) }
+    }
 }
--=20
2.45.2



