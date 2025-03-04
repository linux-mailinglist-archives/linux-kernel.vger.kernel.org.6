Return-Path: <linux-kernel+bounces-545749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B047FA4F0DF
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 23:59:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D2C818972D0
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 22:59:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E0642803E0;
	Tue,  4 Mar 2025 22:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="UNT5dZyA"
Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B55727CCE2
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 22:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741129021; cv=none; b=Bu6RdZPjm/13ela0boXI8umjU/IADhM8FOONV/dnpAISty7WdftVcj4sqzbSM+yveYY/zAwUGJw0PpxZ4ay06cF3W9CUAQg1f0kEiGCuHKGocSGqjm4KU4qsR3CdKseSoKjx1Sk5t4IXkYHOThELPuFtoMwo5AO+m4SEkLkleuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741129021; c=relaxed/simple;
	bh=C6P89FCEKQ7hsnf3HcAy+ET8m/1mUKx+4UNKz3gB5dQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=odSwHBj7ftrcM64eNWYXRgHYwu21z+oQ91FteL9km4VsC4HNaYnwbv/n0QGccp5aIkFi1jJFtHFUwch2QuDpUxf/4AGyuaHMFbKKiI+Kxr4H27pQiP0boXnL1VzcGSvBIvPfGo4CIN34mLLYwGVM7YSmKjkg4bPHPwVHMkLfVro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=UNT5dZyA; arc=none smtp.client-ip=185.70.40.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1741129017; x=1741388217;
	bh=WCPISGW0WxDW396dH2Up0ucrRhbSpXK6XA4DV86Ew0k=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=UNT5dZyAYs3BZ7OxOTKMXQyRAiCl5tZ5xkWRfjzoNGja8F3Kolazy7+kH0wYBWwOB
	 8pcYdnjZJcOtAP4AfZhOfkuNgDXINvLjLQvnCOVjUuqpyJS05XnCLmRgl4sHyPRZ2W
	 uvrdHf/DgkK8K1wU5bHQGksCEpfeB54ovjQ8BlJDjvbcTLPdQpwDJNa2GdQVhaH696
	 1UdkebQypo2tQLVZLzzCtx54ijc8hbp5rnR/YDW1N4kqfmhTowF0fAC3zVEydVrEon
	 PuNrnon2f2w9pSJIJKvNjSiq02op8rFx5SK+biso0Ytzyyl7YpMJufPTWTAvdLNtAw
	 meXp2ABBUrjdw==
Date: Tue, 04 Mar 2025 22:56:51 +0000
To: Benno Lossin <benno.lossin@proton.me>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: [RFC PATCH 1/6] rust: pin-init: internal: add syn version of the `Zeroable` derive macro
Message-ID: <20250304225536.2033853-2-benno.lossin@proton.me>
In-Reply-To: <20250304225536.2033853-1-benno.lossin@proton.me>
References: <20250304225536.2033853-1-benno.lossin@proton.me>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: a6eb2719ee7981c4beaecaa3f25a995a035ea555
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Implement the `Zeroable` derive macro using syn to simplify parsing by
not going through an additional declarative macro.

The syn version is only enabled in the user-space version and disabled
in the kernel until syn becomes available there.

Signed-off-by: Benno Lossin <benno.lossin@proton.me>
---
 rust/pin-init/internal/src/lib.rs          |  5 ++
 rust/pin-init/internal/src/syn_zeroable.rs | 63 ++++++++++++++++++++++
 2 files changed, 68 insertions(+)
 create mode 100644 rust/pin-init/internal/src/syn_zeroable.rs

diff --git a/rust/pin-init/internal/src/lib.rs b/rust/pin-init/internal/src=
/lib.rs
index babe5e878550..5019efe22662 100644
--- a/rust/pin-init/internal/src/lib.rs
+++ b/rust/pin-init/internal/src/lib.rs
@@ -30,6 +30,11 @@
 mod helpers;
 mod pin_data;
 mod pinned_drop;
+#[cfg(kernel)]
+mod zeroable;
+
+#[cfg(not(kernel))]
+#[path =3D "syn_zeroable.rs"]
 mod zeroable;
=20
 #[proc_macro_attribute]
diff --git a/rust/pin-init/internal/src/syn_zeroable.rs b/rust/pin-init/int=
ernal/src/syn_zeroable.rs
new file mode 100644
index 000000000000..90ea8fa63c83
--- /dev/null
+++ b/rust/pin-init/internal/src/syn_zeroable.rs
@@ -0,0 +1,63 @@
+// SPDX-License-Identifier: Apache-2.0 OR MIT
+
+use proc_macro2::TokenStream;
+use quote::quote;
+use syn::{
+    parse_macro_input, parse_quote, Data, DataStruct, DeriveInput, Error, =
GenericParam, Result,
+    TypeParam, WherePredicate,
+};
+
+pub(crate) fn derive(input: proc_macro::TokenStream) -> proc_macro::TokenS=
tream {
+    let raw =3D input.clone().into();
+    do_derive(parse_macro_input!(input as DeriveInput), raw)
+        .unwrap_or_else(|e| e.into_compile_error())
+        .into()
+}
+
+fn do_derive(
+    DeriveInput {
+        ident,
+        mut generics,
+        data,
+        ..
+    }: DeriveInput,
+    raw_input: TokenStream,
+) -> Result<TokenStream> {
+    let Data::Struct(DataStruct { fields, .. }) =3D data else {
+        return Err(Error::new_spanned(
+            raw_input,
+            "`Zeroable` can only be derived for structs.",
+        ));
+    };
+    let field_ty =3D fields.iter().map(|f| &f.ty);
+    let zeroable_bounds =3D generics
+        .params
+        .iter()
+        .filter_map(|p| match p {
+            GenericParam::Type(TypeParam { ident, .. }) =3D> {
+                Some(parse_quote!(#ident: ::pin_init::Zeroable))
+            }
+            _ =3D> None,
+        })
+        .collect::<Vec<WherePredicate>>();
+    generics
+        .make_where_clause()
+        .predicates
+        .extend(zeroable_bounds);
+    let (impl_generics, ty_generics, whr) =3D generics.split_for_impl();
+    Ok(quote! {
+        // SAFETY: Every field type implements `Zeroable` and padding byte=
s may be zero.
+        #[automatically_derived]
+        unsafe impl #impl_generics ::pin_init::Zeroable for #ident #ty_gen=
erics
+            #whr
+        {}
+        const _: () =3D {
+            fn assert_zeroable<T: ?::core::marker::Sized + ::pin_init::Zer=
oable>() {}
+            fn ensure_zeroable #impl_generics ()
+                #whr
+            {
+                #(assert_zeroable::<#field_ty>();)*
+            }
+        };
+    })
+}
--=20
2.48.1



