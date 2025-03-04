Return-Path: <linux-kernel+bounces-545743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EAFCA4F0DA
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 23:58:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A4043AEF1D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 22:58:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27FF027935C;
	Tue,  4 Mar 2025 22:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="lYk+Wo1J"
Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BDF3278143;
	Tue,  4 Mar 2025 22:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741128977; cv=none; b=GjuwtnQ0rJ75lCR00CTu7D2FJTw1o7RGBsQuu8UVQV4lyxvgn3jjTFxarlTBQa16sCxB0Gll+6ksk+YG+D+5FKK2DRwGoulBidhnTdgyjZZALudTn9Vqc/JKWDKgel2300U2HEYeCwP0v+tqDGvtYVtrplGwMPBe7mh+KBT4rYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741128977; c=relaxed/simple;
	bh=yT3dB0vOv1hIkmDMci3xJqb3BI+6b/lLEQoZY3CHB/0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MIRiNC2m3NkC9zD6zI+UCQO3rWOY07evR/bXw6j8ePcEM1ZF2OrPt4RzTsSUH9r32YtPf484Y44fyEzt0ClZfMT/qHnvaDJTZszKOdxoPHIBoe1Inx4emcYXm1WCl2qNg2H1HMrAwAazBrgOZdW06mosiyIPF/fybjFNWHdEiic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=lYk+Wo1J; arc=none smtp.client-ip=185.70.40.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1741128967; x=1741388167;
	bh=q+cADHWxiQCXDYk3TIb0Y++EiGkXzYSQZyQT6pMBwFA=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=lYk+Wo1JzuzYSFGm/7KlqwLpIcB9Xy0KXliG5skJuy88tujlndn5vQO/F56JiQEjV
	 Zch9sn8K2oXfwRqfOF+6E4B7kkD/gxCpMakLj7iR+Ij36U48bTIiYIC1cv8yJtKR/F
	 UooRU6jfCeUsjniSdHwWUAHoETz/njXNIGDSvi+mWqQKWjexRQCOyES/6c21N4LiNC
	 io2jJgNiiQ4HaOXEaZ5+mlka9Cw1LgoqwxfBa5YWOl/Qvj9OA1t+RBamANsf5viWTY
	 X20Dj1hxVv3KV8hjUZayIzNx2XII2htxOVBOYnNFxzbV8hGB4qM8tUCK3OyFdjP3S2
	 J4L7xSHsQcmfg==
Date: Tue, 04 Mar 2025 22:56:02 +0000
To: Benno Lossin <benno.lossin@proton.me>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 19/22] rust: pin-init: miscellaneous synchronization with the user-space version
Message-ID: <20250304225245.2033120-20-benno.lossin@proton.me>
In-Reply-To: <20250304225245.2033120-1-benno.lossin@proton.me>
References: <20250304225245.2033120-1-benno.lossin@proton.me>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 160fbad2c5b57dbf5df29e17d2da712bca6e965d
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Last differences between the kernel version and the user-space version
are removed here.

Signed-off-by: Benno Lossin <benno.lossin@proton.me>
---
 rust/pin-init/internal/src/lib.rs | 5 ++---
 rust/pin-init/src/__internal.rs   | 2 +-
 rust/pin-init/src/lib.rs          | 2 --
 3 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/rust/pin-init/internal/src/lib.rs b/rust/pin-init/internal/src=
/lib.rs
index 30e145f80bc0..babe5e878550 100644
--- a/rust/pin-init/internal/src/lib.rs
+++ b/rust/pin-init/internal/src/lib.rs
@@ -14,6 +14,8 @@
 //
 // Remove once we have `proc_macro2` in the kernel.
 #![allow(clippy::useless_conversion)]
+// Documentation is done in the pin-init crate instead.
+#![allow(missing_docs)]
=20
 use proc_macro::TokenStream;
=20
@@ -30,19 +32,16 @@
 mod pinned_drop;
 mod zeroable;
=20
-#[allow(missing_docs)]
 #[proc_macro_attribute]
 pub fn pin_data(inner: TokenStream, item: TokenStream) -> TokenStream {
     pin_data::pin_data(inner.into(), item.into()).into()
 }
=20
-#[allow(missing_docs)]
 #[proc_macro_attribute]
 pub fn pinned_drop(args: TokenStream, input: TokenStream) -> TokenStream {
     pinned_drop::pinned_drop(args.into(), input.into()).into()
 }
=20
-#[allow(missing_docs)]
 #[proc_macro_derive(Zeroable)]
 pub fn derive_zeroable(input: TokenStream) -> TokenStream {
     zeroable::derive(input.into()).into()
diff --git a/rust/pin-init/src/__internal.rs b/rust/pin-init/src/__internal=
.rs
index 5336d659685d..6b258502a9d7 100644
--- a/rust/pin-init/src/__internal.rs
+++ b/rust/pin-init/src/__internal.rs
@@ -11,7 +11,7 @@
 ///
 /// [nomicon]: https://doc.rust-lang.org/nomicon/subtyping.html
 /// [this table]: https://doc.rust-lang.org/nomicon/phantom-data.html#tabl=
e-of-phantomdata-patterns
-pub(super) type Invariant<T> =3D PhantomData<fn(*mut T) -> *mut T>;
+pub(crate) type Invariant<T> =3D PhantomData<fn(*mut T) -> *mut T>;
=20
 /// Module-internal type implementing `PinInit` and `Init`.
 ///
diff --git a/rust/pin-init/src/lib.rs b/rust/pin-init/src/lib.rs
index fb64cddd1a72..3d57760a3cee 100644
--- a/rust/pin-init/src/lib.rs
+++ b/rust/pin-init/src/lib.rs
@@ -341,8 +341,6 @@
 ///     }
 /// }
 /// ```
-///
-/// [`pin_init!`]: crate::pin_init
 pub use ::pin_init_internal::pin_data;
=20
 /// Used to implement `PinnedDrop` safely.
--=20
2.47.2



