Return-Path: <linux-kernel+bounces-552449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D2FBA579ED
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 12:08:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22885189BBBF
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 11:08:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FACA1EA7F3;
	Sat,  8 Mar 2025 11:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="NH1M7Qny"
Received: from mail-40133.protonmail.ch (mail-40133.protonmail.ch [185.70.40.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C97191C9DE5;
	Sat,  8 Mar 2025 11:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741431934; cv=none; b=SGwLu+JpKvsVpM+cckoxTa5L6bnRRrfEiZc6sn0KG6mKijRo1rAwdBOc/wAdiT8gRbT78jRFnZCqcV1/F+nEJMzELl5J/iNqU9FuD3gxtiwW3LgxIHeEm4LidTb423KnVIyXBP5azvUbYjJNL8ux319C/xHIv8slGq+2HQG0o/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741431934; c=relaxed/simple;
	bh=aW47bsbPthkXsH3LQZ6JKXD/sDpL4VZ8/FGLOw4CN28=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GScM6ud/F8TGqhYJHXdgbht7IoNZaTFPN1W2NwMPSNTpGSF6atZzwV+O+W1oix0wWhLdHTUJ5trCP2U4O9KRQOBwydk8r2uNZg6KRfo7nstOngngdwknQsdiIj4bDhw7X6MMFX+YPIxBkWe+xawUbGS/+MgbSgTcJy6sgq2Wr98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=NH1M7Qny; arc=none smtp.client-ip=185.70.40.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1741431930; x=1741691130;
	bh=JlAWtP1GKQ84QJcgIvPo+4ZxZOJcPcF4odlipF4shb4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=NH1M7QnyMVUOkJpJzWdFERgxb87SB6sr40EHkdNB5nsDKXEgpuv2wD9ntJtiq/htr
	 nunrDrmV8pCVHRSukxTVPq2GY4cyDPszwQ/bJqwpcaCmeQbl1tk03ciBodBv9eL23W
	 pYkBTTzdbV6UdbVtgaMKcKtz1pvCJqUhzgXsnVunnvjTuGT/t3ahfJRp2+ABwZarSz
	 RM0M7t6uffaIHF5LbsoHYB9oEyApb7exBWZJWoK0ulgbLC8Rt5ERVTIRDJStqfEewR
	 yyl/gh8FtAK4MUJAcX78rOaj7gkqypTSepd/IxXy+weHXO1ZESkhBYj2TeH09aej8I
	 hlTUa7lf57dKQ==
Date: Sat, 08 Mar 2025 11:05:27 +0000
To: Benno Lossin <benno.lossin@proton.me>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>
From: Benno Lossin <benno.lossin@proton.me>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 19/22] rust: pin-init: miscellaneous synchronization with the user-space version
Message-ID: <20250308110339.2997091-20-benno.lossin@proton.me>
In-Reply-To: <20250308110339.2997091-1-benno.lossin@proton.me>
References: <20250308110339.2997091-1-benno.lossin@proton.me>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 7ffced33e2bbb75b51c479786b5af529b10810c9
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Remove the last differences between the kernel version and the
user-space version.

Signed-off-by: Benno Lossin <benno.lossin@proton.me>
Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>
Tested-by: Andreas Hindborg <a.hindborg@kernel.org>
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
index 7f7744d48575..557b5948cddc 100644
--- a/rust/pin-init/src/__internal.rs
+++ b/rust/pin-init/src/__internal.rs
@@ -14,7 +14,7 @@
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
index a00288133ae3..45880ffa81bb 100644
--- a/rust/pin-init/src/lib.rs
+++ b/rust/pin-init/src/lib.rs
@@ -349,8 +349,6 @@
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



