Return-Path: <linux-kernel+bounces-552440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 58E33A579E2
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 12:06:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8668D172EF6
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 11:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A8E01D90B1;
	Sat,  8 Mar 2025 11:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="RLgJOSyt"
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE791D5CFF;
	Sat,  8 Mar 2025 11:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741431890; cv=none; b=RUdEwlqY2hqM0BkjVpMy2QLDw/d1/EDc5OucQ5BV5lWB95P6kFOMNh6ZG5Ex1ignRB+GgtjlTAwBP8efy33MGFnKFMSfXjgjOQrKQw8aLC6oi2fX5AhQyXp4eLH6ZN3OVbfJCLCHvAoVfIv+2d9QwMfUcDCY13/XxOQ2ABU3zhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741431890; c=relaxed/simple;
	bh=zX6RaDX6aYrFJpatp4GxJBmg0OX+UqWr6XPys8tGAWE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QExmdbcMe9XSPmGzQCKT7SDAxMWAE77YXuiPTUWLNCIoFhHtQ9zWpLo/0ktdZ6Mkfkie6ab8tUga4dMgtTkCfUBuBm0clDqd+NjIz93bT4pP0k9qoHuzX0fL8CbAdYYiUiN8sp8OLeXbkfZcpZtGbj4qvQx6EtyYAxBg18Cck98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=RLgJOSyt; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1741431886; x=1741691086;
	bh=pZ/T3kTl3o5ylWMp1uYSd2/Fdpx3OzezSj+H6yVGvPg=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=RLgJOSytleMpGgctcAdPcPer79qoXoXYBLl57Z9ptWYx77KKRFhMz63Gl+YJLzg9z
	 e/c0hwQvoFAti4RTnEVOM3EHkQFfJMBtnDAbFZSCR2W9Jg0jrVEbDYJ8RY/NEBGRD1
	 DotA38+MLf6emtknrYX5OdZVL1E6suyLE+kYzUH/49VVQH8wqB8uDdM/UkdOMVVuK9
	 tp9RpOhfeIZV+RnImP5Jf2bPOuYvdvBCde0MAmch8cpA0NQbud1fSiJIidbaGbWKC5
	 LOBsohbCIWNXthwTUMJ2UFsRaun23MV157JXpKxIZcFVJ/tiPX4V2yy49kcsqC7cen
	 kQ4hh5pPHCCSg==
Date: Sat, 08 Mar 2025 11:04:43 +0000
To: Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Fiona Behrens <me@kloenk.dev>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 10/22] rust: add `ZeroableOption` and implement it instead of `Zeroable` for `Option<Box<T, A>>`
Message-ID: <20250308110339.2997091-11-benno.lossin@proton.me>
In-Reply-To: <20250308110339.2997091-1-benno.lossin@proton.me>
References: <20250308110339.2997091-1-benno.lossin@proton.me>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 33f22a4502f52e27329d2a0d02557b2f28fa99d4
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

When making pin-init its own crate, `Zeroable` will no longer be defined
by the kernel crate and thus implementing it for `Option<Box<T, A>>` is
no longer possible due to the orphan rule.
For this reason introduce a new `ZeroableOption` trait that circumvents
this problem.

Signed-off-by: Benno Lossin <benno.lossin@proton.me>
Reviewed-by: Fiona Behrens <me@kloenk.dev>
Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>
Tested-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/alloc/kbox.rs |  4 ++--
 rust/pin-init/src/lib.rs  | 11 +++++++++++
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/alloc/kbox.rs b/rust/kernel/alloc/kbox.rs
index 9861433559dc..07150c038e3f 100644
--- a/rust/kernel/alloc/kbox.rs
+++ b/rust/kernel/alloc/kbox.rs
@@ -15,7 +15,7 @@
 use core::ptr::NonNull;
 use core::result::Result;
=20
-use crate::init::{InPlaceWrite, Init, PinInit, Zeroable};
+use crate::init::{InPlaceWrite, Init, PinInit, ZeroableOption};
 use crate::init_ext::InPlaceInit;
 use crate::types::ForeignOwnable;
=20
@@ -104,7 +104,7 @@
 //
 // In this case we are allowed to use `T: ?Sized`, since all zeros is the =
`None` variant and there
 // is no problem with a VTABLE pointer being null.
-unsafe impl<T: ?Sized, A: Allocator> Zeroable for Option<Box<T, A>> {}
+unsafe impl<T: ?Sized, A: Allocator> ZeroableOption for Box<T, A> {}
=20
 // SAFETY: `Box` is `Send` if `T` is `Send` because the `Box` owns a `T`.
 unsafe impl<T, A> Send for Box<T, A>
diff --git a/rust/pin-init/src/lib.rs b/rust/pin-init/src/lib.rs
index aad6486d33fc..ca6be982b522 100644
--- a/rust/pin-init/src/lib.rs
+++ b/rust/pin-init/src/lib.rs
@@ -1297,6 +1297,17 @@ pub unsafe trait PinnedDrop: __internal::HasPinData =
{
 /// ```
 pub unsafe trait Zeroable {}
=20
+/// Marker trait for types that allow `Option<Self>` to be set to all zero=
es in order to write
+/// `None` to that location.
+///
+/// # Safety
+///
+/// The implementer needs to ensure that `unsafe impl Zeroable for Option<=
Self> {}` is sound.
+pub unsafe trait ZeroableOption {}
+
+// SAFETY: by the safety requirement of `ZeroableOption`, this is valid.
+unsafe impl<T: ZeroableOption> Zeroable for Option<T> {}
+
 /// Create a new zeroed T.
 ///
 /// The returned initializer will write `0x00` to every byte of the given =
`slot`.
--=20
2.47.2



