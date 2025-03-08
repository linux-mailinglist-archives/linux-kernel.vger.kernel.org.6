Return-Path: <linux-kernel+bounces-552443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B27AAA579E5
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 12:06:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1AEE5189A795
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 11:06:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DEF41DE3C1;
	Sat,  8 Mar 2025 11:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="RXK2BIU8"
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D34E1DDA2F
	for <linux-kernel@vger.kernel.org>; Sat,  8 Mar 2025 11:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741431902; cv=none; b=pRHDtbT1CjAeEQ5zrDSZR0qdCqRApoYhr5AlXVuChrK0ms0EXZdAca5mDre0k5sVUtnRn6maAVzdw7T8SlEEISS1X4Z1hUZ1NVPwvbvuyHPR5BzSpcaRBagNHxoTKUZDbpzLO+sOgNkCR1BwK4pz0OqkIUN3yoR50n/RXP6Htew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741431902; c=relaxed/simple;
	bh=8OC8CbFXAYTZnCkf5PkSS/X2TjuDYGxp2OWRT7e6SVA=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aVCFq9aycaWrnIZmO75tr08MDLX3jVZo8yYP3jbReu+G7UhEcNFarpqRje1ag0LSFtPAjIfnhXrDoKYPKwXin6B7PnWeJRzjOP2dKv7NBWq1OOO2wBTpW8wyww61/xCNHBOlqE8TGthNGzCDNTLjLMUAN4zYM08XD+R/iBdlXSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=RXK2BIU8; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=akla2x27azfaxipxlyomj2tzhy.protonmail; t=1741431899; x=1741691099;
	bh=6axCHcAcUqK2bebZurBKW0Xrdj/sG2+f75Bh2KTGI9o=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=RXK2BIU8y19Ojf+RjfitfaGGlImP8zSqgvtUqVn7B7HZNq4EpWfQ6Oi94H/4kyF7i
	 7lP9+GIcNXZ61Nz4VQDwBshU3Blarxs96T6Ap3UC1BuCyQTHf7mSwNRU+MsxGHCMKA
	 XWydYfSI/EwVOpOv1tPUCMP1chGCdsjIEODRGxwQCKzgyzNwMhpUs9j9lJbH5haCRT
	 pyXe7XVPZmIfWuKmSQ78Rw99iKG6tHzPir5+7uBL8y8+jBNz8cy6WFwlKZ8rM1YCES
	 jMIjssE17qrMWP8XZosvzsrHVHYB3FRHBrcPxzSKdhcvXu7IGj6mH01yzGJ1/OSxTh
	 fSyqaWFoS1kdQ==
Date: Sat, 08 Mar 2025 11:04:56 +0000
To: Benno Lossin <benno.lossin@proton.me>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Fiona Behrens <me@kloenk.dev>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 13/22] rust: pin-init: change the way the `paste!` macro is called
Message-ID: <20250308110339.2997091-14-benno.lossin@proton.me>
In-Reply-To: <20250308110339.2997091-1-benno.lossin@proton.me>
References: <20250308110339.2997091-1-benno.lossin@proton.me>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 86bf9a595443852e866260436d5dae4993fd620a
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Change the paste macro path from `::kernel::macros::paste!` to use
`$crate::init::macros::paste!` instead, which links to
`::macros::paste!`. This is because the pin-init crate will be a
dependency of the kernel, so it itself cannot have the kernel as a
dependency.

Signed-off-by: Benno Lossin <benno.lossin@proton.me>
Reviewed-by: Fiona Behrens <me@kloenk.dev>
Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>
Tested-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/pin-init/src/macros.rs | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/rust/pin-init/src/macros.rs b/rust/pin-init/src/macros.rs
index 1fd146a83241..c45ad6af5ca0 100644
--- a/rust/pin-init/src/macros.rs
+++ b/rust/pin-init/src/macros.rs
@@ -498,6 +498,8 @@
 //! };
 //! ```
=20
+pub use ::macros::paste;
+
 /// Creates a `unsafe impl<...> PinnedDrop for $type` block.
 ///
 /// See [`PinnedDrop`] for more information.
@@ -1134,7 +1136,7 @@ macro_rules! __init_internal {
             // information that is associated to already parsed fragments,=
 so a path fragment
             // cannot be used in this position. Doing the retokenization r=
esults in valid rust
             // code.
-            ::kernel::macros::paste!($t::$get_data())
+            $crate::init::macros::paste!($t::$get_data())
         };
         // Ensure that `data` really is of type `$data` and help with type=
 inference:
         let init =3D $crate::init::__internal::$data::make_closure::<_, __=
InitOk, $err>(
@@ -1215,7 +1217,7 @@ fn assert_zeroable<T: $crate::init::Zeroable>(_: *mut=
 T) {}
         //
         // We rely on macro hygiene to make it impossible for users to acc=
ess this local variable.
         // We use `paste!` to create new hygiene for `$field`.
-        ::kernel::macros::paste! {
+        $crate::init::macros::paste! {
             // SAFETY: We forget the guard later when initialization has s=
ucceeded.
             let [< __ $field _guard >] =3D unsafe {
                 $crate::init::__internal::DropGuard::new(::core::ptr::addr=
_of_mut!((*$slot).$field))
@@ -1246,7 +1248,7 @@ fn assert_zeroable<T: $crate::init::Zeroable>(_: *mut=
 T) {}
         //
         // We rely on macro hygiene to make it impossible for users to acc=
ess this local variable.
         // We use `paste!` to create new hygiene for `$field`.
-        ::kernel::macros::paste! {
+        $crate::init::macros::paste! {
             // SAFETY: We forget the guard later when initialization has s=
ucceeded.
             let [< __ $field _guard >] =3D unsafe {
                 $crate::init::__internal::DropGuard::new(::core::ptr::addr=
_of_mut!((*$slot).$field))
@@ -1278,7 +1280,7 @@ fn assert_zeroable<T: $crate::init::Zeroable>(_: *mut=
 T) {}
         //
         // We rely on macro hygiene to make it impossible for users to acc=
ess this local variable.
         // We use `paste!` to create new hygiene for `$field`.
-        ::kernel::macros::paste! {
+        $crate::init::macros::paste! {
             // SAFETY: We forget the guard later when initialization has s=
ucceeded.
             let [< __ $field _guard >] =3D unsafe {
                 $crate::init::__internal::DropGuard::new(::core::ptr::addr=
_of_mut!((*$slot).$field))
@@ -1315,7 +1317,7 @@ fn assert_zeroable<T: $crate::init::Zeroable>(_: *mut=
 T) {}
             // information that is associated to already parsed fragments,=
 so a path fragment
             // cannot be used in this position. Doing the retokenization r=
esults in valid rust
             // code.
-            ::kernel::macros::paste!(
+            $crate::init::macros::paste!(
                 ::core::ptr::write($slot, $t {
                     $($acc)*
                     ..zeroed
@@ -1339,7 +1341,7 @@ fn assert_zeroable<T: $crate::init::Zeroable>(_: *mut=
 T) {}
             // information that is associated to already parsed fragments,=
 so a path fragment
             // cannot be used in this position. Doing the retokenization r=
esults in valid rust
             // code.
-            ::kernel::macros::paste!(
+            $crate::init::macros::paste!(
                 ::core::ptr::write($slot, $t {
                     $($acc)*
                 });
--=20
2.47.2



