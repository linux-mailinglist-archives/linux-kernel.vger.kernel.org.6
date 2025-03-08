Return-Path: <linux-kernel+bounces-552436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E3034A579DE
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 12:05:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12C2A18925C7
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 11:05:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 908F61B78F3;
	Sat,  8 Mar 2025 11:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="SLupBCIE"
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EDB91B4223;
	Sat,  8 Mar 2025 11:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741431874; cv=none; b=uymOgJPI7mV07bSInadGeqsrolzkxiyjLwqMcpxYgRgLyGcAspNTtvQ7b79wDB270DA6zVGGdKXdpxcNbfQGvc4xSK5FjlnA+46W8IiBctXtBOr4jbZOGqJOUiT8lACH0RzksJwJG2iDeeaCKG8FfyexxTuzlDBFhR/cxJTuRkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741431874; c=relaxed/simple;
	bh=GSXAfWxNUwF810zkTd2UScsn8JFXGbweVUw5RwnSfZQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LmkqbVV2CF2Z+7sY+NSTqxBcKJhypTgVvwzf7LaxjHQEYY7EeeTdVB36iGEmfHYXWeu9kRtt6SnA3kfzG2WbS3/Ibi5BL4hNmkVwyry4sSWXH3vZCzcoAR97u0njaY1CmxESpVXTR2gR367WAzH2EW2uXUkwbyqaiv/+ul2t9pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=SLupBCIE; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1741431870; x=1741691070;
	bh=QfsJOgn8Z6t6x8hiNXRFYhyjN1l3K8cHtY4lg+QD0EQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=SLupBCIEaQlfV5RVsiwFaJg0wXZvrY9oLjWMEboNxqF2Pb19Q8E3csA2AT3+Ts/h1
	 nSCspIjI4S0lz74G5Kmm3fsa5n67221f/YBynGKu5QgTFqJ0cEeDod4B/1cJ1IJW1v
	 XA295qY3AukbGAFlePb7CFloPJSAXjHt3nJ9J06aVpLsL4t6dhDawfMdIDo3pR9Cel
	 q+Su4n0PuDyXP8Urvl40OYdnLm6BX6/20y5GiVFrd+QwWgjBKoR6bUE7YZQkH2B/kY
	 J+N+8OsP10hUVCo7Cb3SrUWS2q0+8TA6j5pn20sOglRjTU/R0ZbUQmWiwQOOaH3RNZ
	 xJrh1/XCg36Ww==
Date: Sat, 08 Mar 2025 11:04:25 +0000
To: Benno Lossin <benno.lossin@proton.me>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Fiona Behrens <me@kloenk.dev>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 06/22] rust: pin-init: call `try_[pin_]init!` from `[pin_]init!` instead of `__init_internal!`
Message-ID: <20250308110339.2997091-7-benno.lossin@proton.me>
In-Reply-To: <20250308110339.2997091-1-benno.lossin@proton.me>
References: <20250308110339.2997091-1-benno.lossin@proton.me>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 19e55c255c6088fc3555635f40f0fb31e406dd81
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
Reviewed-by: Fiona Behrens <me@kloenk.dev>
Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>
Tested-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/pin-init/src/lib.rs | 26 ++++++--------------------
 1 file changed, 6 insertions(+), 20 deletions(-)

diff --git a/rust/pin-init/src/lib.rs b/rust/pin-init/src/lib.rs
index fd9e36077e6e..4df5216b80d7 100644
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



