Return-Path: <linux-kernel+bounces-545734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 83518A4F0CD
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 23:55:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8888A1892AC6
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 22:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C074F279334;
	Tue,  4 Mar 2025 22:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="lK4t+Gwx"
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 658781F4611
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 22:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741128882; cv=none; b=OKQOtW2Ke8nlMdl72vkKeBxKBqx65VQsqLC8QEehYUTPjezswYwWHlzDvYvuncMU89ldtVZ636mNUnQGgyZiuon6Es/MnLObckSKrpOSHGjpROuWn+CamVrxPn2K6h+pX6aajSRtrUKmmFan19+6typsjRhLEQc8ZGOgQRE+4nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741128882; c=relaxed/simple;
	bh=F1sw/m5LT824WJfevABb6Iyc57TNxO6rjpGdIpNrqtc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=StVK6HGLRBV5Av2EWQOCvBaBGJHcCza1pAxBktfCDaTBaCffEDivvV+nOTU1QVL3STQcVbfQ7iya3xxPyaffM6VkmDLx6mhCYJsn20tluG0aP4/rv+ah9zPQYUA5CJvcrVhBW2ojuOXMsUkiiUqO43CKlMq7YAmc3C+PXynx3W8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=lK4t+Gwx; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1741128878; x=1741388078;
	bh=Iwbgpizi1KRgYui6yUrhf96nnNJZKE4KcqTIH7y5ch4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=lK4t+GwxB3GZymmPkX74LgayUstCLHfVzDkAe33NLDHFGISkqzGTKJHwGLpXeDK0m
	 rj4zhV119U6k5K7C5254DkoWsXvzJmofWVd1rZ2mz5VwFHS8PzAHh6ylcqkYjcn27P
	 XFwSQsFGgxpzip/50/z8eD9BaHq5CziTu1iX2/z7yyHlC3XlRESC83tKD1T/yzgZ4J
	 6Mr+bPiMZSaQBPiFfING2xQtH4E0Qb17Q33HHw//cHv7rNSNUc0Ue47Prna+nXtklO
	 6WFxYek9/aSncKYP3iUA0IJi49rCw+ghAAkgWk87eOqLwS1IULC5QxB4XdPHSerq8t
	 wxYowgS2z+PnA==
Date: Tue, 04 Mar 2025 22:54:31 +0000
To: Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>
From: Benno Lossin <benno.lossin@proton.me>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 10/22] rust: add `ZeroableOption` and implement it instead of `Zeroable` for `Option<Box<T, A>>`
Message-ID: <20250304225245.2033120-11-benno.lossin@proton.me>
In-Reply-To: <20250304225245.2033120-1-benno.lossin@proton.me>
References: <20250304225245.2033120-1-benno.lossin@proton.me>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: a909774627b5d788712124e8d67630e795664355
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
index 5fd8fa7c2ce9..fd2c4fdd0ca4 100644
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



