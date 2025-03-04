Return-Path: <linux-kernel+bounces-545737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79C42A4F0D1
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 23:56:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6BF33AE6F0
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 22:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF35A27BF7C;
	Tue,  4 Mar 2025 22:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="UqFVlRBV"
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FBA627BF7F
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 22:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741128909; cv=none; b=uA3kQ9QakUJLvAjtth8hobAa7RpFz0FLWPoRndurVDJkEvDsleXhTsnqTW0OpH8ndT32wbsFjPo7jBBi5NgRi87XpxbjBmixyMmbjw5PKl2lbo7FqsQwu7fdgiydVKrRhOQDwf2lkSp9IUtNJcXZ/r7c6XIG5mYx6PiaujBza9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741128909; c=relaxed/simple;
	bh=BEkVdVIKazKDlupA9mYKA7qa+7YyqFsetLKRiLFMZLE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VHOT3PqpB5HGdeUDQfdcwbQS7rxpcQQOy4rYTI7gvAhzyemIZCtVDhYouQQO0cfS8oc4OKhi98/O5n2C/IBkjes3hiXhq/4Cd8d7GHdHu9K/sAkG+XTzuKnhYkEniBCzO6BCRwgkprzyjhQpnTWKIVZhFmMRV8D+ukWzATglBRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=UqFVlRBV; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1741128905; x=1741388105;
	bh=hhgl6ZZH6zla/PaWftysdys5vKZZeraSAI4fIKzy1rY=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=UqFVlRBV048YKGwFBds17vAgwrgulJIvzWzYuMXzyZiht0O35HUDM6pj+9YaVtRnZ
	 vnoKPRZVUj+E345toOzB+vqUWcrz+2o4ano51Q0SDSUa9rxdKtqJqFIB7CWWVkehsW
	 YwY0uJR96/JoXhURjDfi/P7izEF6Lr9y4k54tkOTzByXm+IGzPVhvd7vttWqz5+F9A
	 oDgsgY8cxCEbADFG0Q+qjr3vnfeIKuYbiofTeRx2W8AGvqWHegk+y69u48BXvPkVz0
	 TO22AwAd9fnc3bKfKMKvo8/ba8UqN0mYeTny9YYRgia1r2ViiCXYvtke9KkLijDRfD
	 0ro+ryLTFuPPg==
Date: Tue, 04 Mar 2025 22:55:00 +0000
To: Benno Lossin <benno.lossin@proton.me>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 13/22] rust: pin-init: change the way the `paste!` macro is called
Message-ID: <20250304225245.2033120-14-benno.lossin@proton.me>
In-Reply-To: <20250304225245.2033120-1-benno.lossin@proton.me>
References: <20250304225245.2033120-1-benno.lossin@proton.me>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 41f68df36c133b58b4926da008fdbfd71f2aa36a
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



