Return-Path: <linux-kernel+bounces-545752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E7C99A4F104
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 00:01:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B3983AFD40
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 23:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2690B28041D;
	Tue,  4 Mar 2025 22:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="cHZZNF/l"
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2DE027C179;
	Tue,  4 Mar 2025 22:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741129045; cv=none; b=XsTWixCxQk6uB+qdlC+ILS6JhsJmHazybYmX3l56kuwvVC7cHj3+pFmkbgHy5yROfQ8Ol+A7Y2MaZWHExaBrcD4rqiIUl+ybZFcormLyLyVdoa4/hAQjrI7cRkOeSmPMuWB9sF3v4O9yAdY0gJgygQYeHZw112ZeQCR+3SVg6S4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741129045; c=relaxed/simple;
	bh=/NgfdyGrvrrJRgd78DH4d8RXs9+z9377eNpQzrEPQHs=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eyvv/yZXEqYHuHhf9RhMSGCrDM3P9OFPzfSieQCTjyKOaRgHgRTwa2zXKlPxlPiJYOoFCd4gb5GJQ5zSr2YYntaNXEH/uYy0b2Bss7gH8/kaa+5nfRFeeYHg2PPLUaWq9IZisqY56XdbhwhVPN0cqAez95/NU/9ij2MFRcfYEeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=cHZZNF/l; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=irsuoly6ynda5hokp2px2mbkpi.protonmail; t=1741129041; x=1741388241;
	bh=msWAcT+/QJwPKs67gv1ysXe/xXa5w32shczegMlO+6Y=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=cHZZNF/lygI7cMFdm9Lt/wiox4BSaT+P4szvvQU8nUr7Y1u0+AFWuE+eVwAjjYedk
	 8tM7WcPWZVRL/PHivLq+66RrEQsNd8qR1K8cffW0GetCZl1uKaGLoGj+4vdCGm0Anm
	 JoUe8kllR7sydgaNdXZhLQIERXzRP2Z2SySnMNm3RGdfxf8HaSRIKPU6MQEPj5xKMD
	 0h8+PyvdF6SWmJx4bSlHtanWO8c76xunXcQcfBn2lI7z9C3vFn53kjyXPD0huQ6veL
	 IUrJc6BrW5xGE2Kp4nkAHNqwgT1jkTUmR9n0W8RT4vHKnOjT3VsZ+hn+SmbpZMeA0Y
	 BKv8IVqkNbT8g==
Date: Tue, 04 Mar 2025 22:57:18 +0000
To: Benno Lossin <benno.lossin@proton.me>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 4/6] rust: pin-init: add `?Sized` bounds to traits in `#[pin_data]` macro
Message-ID: <20250304225536.2033853-5-benno.lossin@proton.me>
In-Reply-To: <20250304225536.2033853-1-benno.lossin@proton.me>
References: <20250304225536.2033853-1-benno.lossin@proton.me>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: b6c3bb1f9af22086c07614dc2183d851ba8d9c52
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

`#[pin_data]` uses some auxiliary traits to ensure that a user does not
implement `Drop` for the annotated struct, as that is unsound and can
lead to UB. However, if the struct that is annotated is `!Sized`, the
current bounds do not work, because `Sized` is an implicit bound for
generics.

This is *not* a soundness hole of pin-init, as it currently is
impossible to construct an unsized value using pin-init.

Signed-off-by: Benno Lossin <benno.lossin@proton.me>
---
 rust/pin-init/internal/src/syn_pin_data.rs | 6 +++---
 rust/pin-init/src/macros.rs                | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/rust/pin-init/internal/src/syn_pin_data.rs b/rust/pin-init/int=
ernal/src/syn_pin_data.rs
index d95176389e17..30cd4bc35fd0 100644
--- a/rust/pin-init/internal/src/syn_pin_data.rs
+++ b/rust/pin-init/internal/src/syn_pin_data.rs
@@ -293,7 +293,7 @@ fn drop(&mut self) {
             // if it also implements `Drop`
             trait MustNotImplDrop {}
             #[expect(drop_bounds)]
-            impl<T: ::core::ops::Drop> MustNotImplDrop for T {}
+            impl<T: ::core::ops::Drop + ?::core::marker::Sized> MustNotImp=
lDrop for T {}
             impl #impl_generics MustNotImplDrop for #ident #ty_generics
                 #whr
             {}
@@ -302,8 +302,8 @@ impl #impl_generics MustNotImplDrop for #ident #ty_gene=
rics
             // `PinnedDrop` as the parameter to `#[pin_data]`.
             #[expect(non_camel_case_types)]
             trait UselessPinnedDropImpl_you_need_to_specify_PinnedDrop {}
-            impl<T: ::pin_init::PinnedDrop> UselessPinnedDropImpl_you_need=
_to_specify_PinnedDrop
-                for T {}
+            impl<T: ::pin_init::PinnedDrop + ?::core::marker::Sized>
+                UselessPinnedDropImpl_you_need_to_specify_PinnedDrop for T=
 {}
             impl #impl_generics
                 UselessPinnedDropImpl_you_need_to_specify_PinnedDrop for #=
ident #ty_generics
                 #whr
diff --git a/rust/pin-init/src/macros.rs b/rust/pin-init/src/macros.rs
index 361623324d5c..03e2588423cc 100644
--- a/rust/pin-init/src/macros.rs
+++ b/rust/pin-init/src/macros.rs
@@ -931,7 +931,7 @@ impl<'__pin, $($impl_generics)*> ::core::marker::Unpin =
for $name<$($ty_generics)
         // if it also implements `Drop`
         trait MustNotImplDrop {}
         #[expect(drop_bounds)]
-        impl<T: ::core::ops::Drop> MustNotImplDrop for T {}
+        impl<T: ::core::ops::Drop + ?::core::marker::Sized> MustNotImplDro=
p for T {}
         impl<$($impl_generics)*> MustNotImplDrop for $name<$($ty_generics)=
*>
         where $($whr)* {}
         // We also take care to prevent users from writing a useless `Pinn=
edDrop` implementation.
@@ -939,7 +939,7 @@ impl<$($impl_generics)*> MustNotImplDrop for $name<$($t=
y_generics)*>
         // `PinnedDrop` as the parameter to `#[pin_data]`.
         #[expect(non_camel_case_types)]
         trait UselessPinnedDropImpl_you_need_to_specify_PinnedDrop {}
-        impl<T: $crate::PinnedDrop>
+        impl<T: $crate::PinnedDrop + ?::core::marker::Sized>
             UselessPinnedDropImpl_you_need_to_specify_PinnedDrop for T {}
         impl<$($impl_generics)*>
             UselessPinnedDropImpl_you_need_to_specify_PinnedDrop for $name=
<$($ty_generics)*>
--=20
2.48.1



