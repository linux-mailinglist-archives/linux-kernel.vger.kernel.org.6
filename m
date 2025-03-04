Return-Path: <linux-kernel+bounces-545729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64EC1A4F0C6
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 23:54:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91F291716F7
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 22:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8156027814C;
	Tue,  4 Mar 2025 22:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="EiAe1ViF"
Received: from mail-40133.protonmail.ch (mail-40133.protonmail.ch [185.70.40.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5782824C06A;
	Tue,  4 Mar 2025 22:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741128850; cv=none; b=IVpsNt/tA8YwT3C/dkOa1ECH+G1EzqgXxjEIfFytvFasNd6Fru5t4JqMj9b8JflgMCZy5UoH6Fx3V+HYGtkQMMg3a+x5VD1+/5VllVhL/3OGNwIYYmRox5o5MMT7dOZshEcuOfjYV5w7qp/Sza39EcmfYtA0yB4uuy2ZzRJyckQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741128850; c=relaxed/simple;
	bh=r7AM5TIzad2OfATgjbzibMwiey/wdkiiDTucINLBoJE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ph/cQKBMWLDKOIkd24Yq0ISKtnFmigJAESbFN07e6jW58xPMetRSymrRPSjXnVY6XnIPMyHF/BCE4sVrQsMFV6e+tyis38nyODJ+bDLk9QsfIJZ8HLjsg/KZjqwOWUNzzt61EmtH3z+QOLr1Gz4lqDBs5FWBsjl+9xe5jT04SSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=EiAe1ViF; arc=none smtp.client-ip=185.70.40.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1741128847; x=1741388047;
	bh=wW49/yJO4VR/pu7lpctPyHIyHEAHS1niWYryybiYs7Y=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=EiAe1ViFXJCWSNwKpH41mVoe2NgujSVf0N9QOfGBJdHxnRAfAgZqe26DAlX2vhZ/p
	 4rgXRK6I1yvRJD62vyxRhMhHz9iF14sfQ0KGOmhZq3V2w5vEu/P5He8y9WImxggyYU
	 QsmHddsaVC8ZCb4whKW3EgsSJZ/FHlfnxUIhv0qJsv4tXDXe2AVgltDDayiR6V6NIG
	 0lgGB8NdSmqKHxwA8TEAeN5eGarcVliy+XdfMKxfSjtgjsSZFkWvTXMUEWl5eoVzKv
	 DyDs1UFb4VV6Z2Ga4y2mhW5Q4b/tB+CFBetFM6EBaHkDJO/ryE0Bd9uBPOg8CCE3gs
	 tz2KkJybHmE6w==
Date: Tue, 04 Mar 2025 22:53:57 +0000
To: Benno Lossin <benno.lossin@proton.me>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 06/22] rust: pin-init: call `try_[pin_]init!` from `[pin_]init!` instead of `__init_internal!`
Message-ID: <20250304225245.2033120-7-benno.lossin@proton.me>
In-Reply-To: <20250304225245.2033120-1-benno.lossin@proton.me>
References: <20250304225245.2033120-1-benno.lossin@proton.me>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 08b75ceaa65ac8464c539e7d94a40c6d1c5fd242
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

The `[pin_]init!` macros have the same behavior as the `try_[pin_]init!`
macros, except that they set the error type to `Infallible`.
Instead of calling the primitive `__init_internal!` with the correct
parameters, the same can thus be achieved by calling `try_[pin_]init!`.
Since this makes it more clear what their behavior is, simplify the
implementations of `[pin_]init!`.

Signed-off-by: Benno Lossin <benno.lossin@proton.me>
---
 rust/pin-init/src/lib.rs | 26 ++++++--------------------
 1 file changed, 6 insertions(+), 20 deletions(-)

diff --git a/rust/pin-init/src/lib.rs b/rust/pin-init/src/lib.rs
index 92027e2f60f5..4c492efeb5cd 100644
--- a/rust/pin-init/src/lib.rs
+++ b/rust/pin-init/src/lib.rs
@@ -676,16 +676,9 @@ macro_rules! pin_init {
     ($(&$this:ident in)? $t:ident $(::<$($generics:ty),* $(,)?>)? {
         $($fields:tt)*
     }) =3D> {
-        $crate::__init_internal!(
-            @this($($this)?),
-            @typ($t $(::<$($generics),*>)?),
-            @fields($($fields)*),
-            @error(::core::convert::Infallible),
-            @data(PinData, use_data),
-            @has_data(HasPinData, __pin_data),
-            @construct_closure(pin_init_from_closure),
-            @munch_fields($($fields)*),
-        )
+        $crate::try_pin_init!($(&$this in)? $t $(::<$($generics),*>)? {
+            $($fields)*
+        }? ::core::convert::Infallible)
     };
 }
=20
@@ -784,16 +777,9 @@ macro_rules! init {
     ($(&$this:ident in)? $t:ident $(::<$($generics:ty),* $(,)?>)? {
         $($fields:tt)*
     }) =3D> {
-        $crate::__init_internal!(
-            @this($($this)?),
-            @typ($t $(::<$($generics),*>)?),
-            @fields($($fields)*),
-            @error(::core::convert::Infallible),
-            @data(InitData, /*no use_data*/),
-            @has_data(HasInitData, __init_data),
-            @construct_closure(init_from_closure),
-            @munch_fields($($fields)*),
-        )
+        $crate::try_init!($(&$this in)? $t $(::<$($generics),*>)? {
+            $($fields)*
+        }? ::core::convert::Infallible)
     }
 }
=20
--=20
2.47.2



