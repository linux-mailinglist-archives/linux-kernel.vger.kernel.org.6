Return-Path: <linux-kernel+bounces-545750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 37275A4F0EE
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 00:00:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9A2718976FA
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 23:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C3FA27816A;
	Tue,  4 Mar 2025 22:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="gzp9nKHn"
Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C7027780E;
	Tue,  4 Mar 2025 22:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741129031; cv=none; b=KVaJN/ZXrIrrOAB4yNn1OtAiqlRIg8xFZYERVGf8AIyW7j2cfPPvuDVluNTL12tS1KGXcyy+7b4CZtv0/1S5rhoeiyYr2D8JLN7xbDAWzdThrK8811cyIFsdY09N770Rfr6hmQZwCtwRfR8jDS4pBBllh59r9XFkd9NsKJg/jLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741129031; c=relaxed/simple;
	bh=/1p1U/3sEDHin25g5MknwxJWkvrn1tU61c0iGrkJ/Nk=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hSysrNKUJuLrMQkkbJSYkL+YMYWQwmd8IY64GyZcFB0V1yZze5XYBaPyGeuxp+li/LntRHdUxAhx1F44TYoph8bWhL/yDzv2ixKCNv2xXxioDhrdfZ86HdwvAa+ry+BFF/oehI46EKUgJfqujPQXCn9n0uaC7Yr37oxvfr2X6Bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=gzp9nKHn; arc=none smtp.client-ip=185.70.40.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1741129027; x=1741388227;
	bh=VjcSRLagK8/viktcl8uaA2EiQIIfWBvwqfrVqBVgAC4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=gzp9nKHnkyXEFap0z6pv5oetXm9kUPSAsKE6TfqpOeBATYYpsN68O25FHAvFiaTrI
	 NL1KctWzKlhNS9zG3gsAWCvKETZC5lHCUzynBu3kzU3Vixmhlzf1qY/TuejupzSUm8
	 gXYpmq4h3kEeemf1vfKYJgv+lS0wCO0xUCaX9EjZ1K6EyIl1zQo4G/3o4MUE8WCIsR
	 ZhCIgfa4GNEQOf7pmzKFM/a9AdtRGYMKLcWJN3ug0sOkyKd2n9cbKsOYDkJfhdKeXY
	 kOmSdmJN6HH0e6htNGJRF88foovSj2A3/LQIwmYcZXMD80zKQ2cF76KU4p4isH4zro
	 C/876FpTYRrhg==
Date: Tue, 04 Mar 2025 22:57:00 +0000
To: Benno Lossin <benno.lossin@proton.me>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: [RFC PATCH 2/6] rust: pin-init: internal: add syn version of `pinned_drop` proc macro
Message-ID: <20250304225536.2033853-3-benno.lossin@proton.me>
In-Reply-To: <20250304225536.2033853-1-benno.lossin@proton.me>
References: <20250304225536.2033853-1-benno.lossin@proton.me>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 92aa7d5325af87fe1da51cad5c381cc41f352d65
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Implement the `pinned_drop` attribute macro using syn to simplify
parsing by not going through an additional declarative macro.
This not only simplifies the code by a lot, increasing maintainability
and making it easier to implement new features. But also improves the
user experience by improving the error messages one gets when giving
incorrect inputs to the macro.
For example in this piece of code, there is a `drop` function missing:

    use pin_init::*;

    #[pin_data(PinnedDrop)]
    struct Foo {}

    #[pinned_drop]
    impl PinnedDrop for Foo {}

But this error is communicated very poorly in the declarative macro
version:

    error: no rules expected `)`
      |
    6 | #[pinned_drop]
      | ^^^^^^^^^^^^^^ no rules expected this token in macro call
      |
    note: while trying to match keyword `fn`
     --> src/macros.rs
      |
      |             fn drop($($sig:tt)*) {
      |             ^^
      =3D note: this error originates in the attribute macro `pinned_drop` =
(in Nightly builds, run with -Z macro-backtrace for more info)

    error[E0277]: the trait bound `Foo: PinnedDrop` is not satisfied
      |
    3 | #[pin_data(PinnedDrop)]
      | ^^^^^^^^^^^^^^^^^^^^^^^
      | |
      | the trait `PinnedDrop` is not implemented for `Foo`
      | required by a bound introduced by this call
      |
      =3D note: this error originates in the macro `$crate::__pin_data` whi=
ch comes from the expansion of the attribute macro `pin_data` (in Nightly b=
uilds, run with -Z macro-backtrace for more info)

The syn version is much more concise and right to the point:

    error[E0046]: not all trait items implemented, missing: `drop`
      |
    7 | impl PinnedDrop for Foo {}
      | ^^^^^^^^^^^^^^^^^^^^^^^ missing `drop` in implementation
      |
      =3D help: implement the missing item: `fn drop(self: Pin<&mut Self>, =
_: OnlyCallFromDrop) { todo!() }`

Another example is the following:

    use pin_init::*;
    use std::pin::Pin;

    #[pin_data(PinnedDrop)]
    struct Foo {}

    #[pinned_drop]
    impl PinnedDrop for Foo {
        fn drop(self: Pin<&mut Self>) {}

        const BAZ: usize =3D 0;
    }

It produces this error in the declarative macro version:

    error: no rules expected keyword `const`
       |
    10 |     const BAZ: usize =3D 0;
       |     ^^^^^ no rules expected this token in macro call
       |
    note: while trying to match `)`
      --> src/macros.rs
       |
       |         ),
       |         ^

    error[E0277]: the trait bound `Foo: PinnedDrop` is not satisfied
      |
    3 | #[pin_data(PinnedDrop)]
      | ^^^^^^^^^^^^^^^^^^^^^^^
      | |
      | the trait `PinnedDrop` is not implemented for `Foo`
      | required by a bound introduced by this call
      |
      =3D note: this error originates in the macro `$crate::__pin_data` whi=
ch comes from the expansion of the attribute macro `pin_data` (in Nightly b=
uilds, run with -Z macro-backtrace for more info)

In the syn version, we get instead:

    error[E0438]: const `BAZ` is not a member of trait `pinned_init::Pinned=
Drop`
       |
    11 |     const BAZ: usize =3D 0;
       |     ^^^^^^^^^^^^^^^^^^^^^ not a member of trait `pinned_init::Pinn=
edDrop`

The syn version is only enabled in the user-space version and disabled
in the kernel until syn becomes available there.

Signed-off-by: Benno Lossin <benno.lossin@proton.me>
---
 rust/pin-init/internal/src/lib.rs             |  4 +
 rust/pin-init/internal/src/syn_pinned_drop.rs | 77 +++++++++++++++++++
 2 files changed, 81 insertions(+)
 create mode 100644 rust/pin-init/internal/src/syn_pinned_drop.rs

diff --git a/rust/pin-init/internal/src/lib.rs b/rust/pin-init/internal/src=
/lib.rs
index 5019efe22662..761fbf8b9c68 100644
--- a/rust/pin-init/internal/src/lib.rs
+++ b/rust/pin-init/internal/src/lib.rs
@@ -29,10 +29,14 @@
=20
 mod helpers;
 mod pin_data;
+#[cfg(kernel)]
 mod pinned_drop;
 #[cfg(kernel)]
 mod zeroable;
=20
+#[cfg(not(kernel))]
+#[path =3D "syn_pinned_drop.rs"]
+mod pinned_drop;
 #[cfg(not(kernel))]
 #[path =3D "syn_zeroable.rs"]
 mod zeroable;
diff --git a/rust/pin-init/internal/src/syn_pinned_drop.rs b/rust/pin-init/=
internal/src/syn_pinned_drop.rs
new file mode 100644
index 000000000000..1e70ee29adba
--- /dev/null
+++ b/rust/pin-init/internal/src/syn_pinned_drop.rs
@@ -0,0 +1,77 @@
+// SPDX-License-Identifier: Apache-2.0 OR MIT
+
+use proc_macro2::TokenStream;
+use quote::quote;
+use syn::{
+    parse_macro_input, parse_quote, spanned::Spanned, Error, ImplItem, Imp=
lItemFn, ItemImpl,
+    Result, Token,
+};
+
+pub(crate) fn pinned_drop(
+    args: proc_macro::TokenStream,
+    input: proc_macro::TokenStream,
+) -> proc_macro::TokenStream {
+    parse_macro_input!(args as syn::parse::Nothing);
+    do_impl(parse_macro_input!(input as ItemImpl))
+        .unwrap_or_else(|e| e.into_compile_error())
+        .into()
+}
+
+fn do_impl(mut input: ItemImpl) -> Result<TokenStream> {
+    let Some((_, path, _)) =3D &mut input.trait_ else {
+        return Err(Error::new_spanned(
+            input,
+            "expected an `impl` block implementing `PinnedDrop`",
+        ));
+    };
+    if !is_pinned_drop(path) {
+        return Err(Error::new_spanned(
+            input,
+            "expected an `impl` block implementing `PinnedDrop`",
+        ));
+    }
+    let mut error =3D None;
+    if let Some(unsafety) =3D input.unsafety.take() {
+        error =3D Some(
+            Error::new_spanned(
+                unsafety,
+                "implementing the trait `PinnedDrop` via `#[pinned_drop]` =
is not unsafe",
+            )
+            .into_compile_error(),
+        );
+    }
+    input.unsafety =3D Some(Token![unsafe](input.impl_token.span()));
+    if path.segments.len() !=3D 2 {
+        path.segments.insert(0, parse_quote!(pin_init));
+    }
+    path.leading_colon.get_or_insert(Token![::](path.span()));
+    for item in &mut input.items {
+        match item {
+            ImplItem::Fn(ImplItemFn { sig, .. }) if sig.ident =3D=3D "drop=
" =3D> {
+                sig.inputs
+                    .push(parse_quote!(_: ::pin_init::__internal::OnlyCall=
FromDrop));
+            }
+            _ =3D> {}
+        }
+    }
+    Ok(quote! {
+        #error
+        #input
+    })
+}
+
+fn is_pinned_drop(path: &syn::Path) -> bool {
+    if path.segments.len() > 2 {
+        return false;
+    }
+    // If there is a `::`, then the path needs to be `::pin_init::PinnedDr=
op`.
+    if path.leading_colon.is_some() && path.segments.len() !=3D 2 {
+        return false;
+    }
+    for (actual, expected) in path.segments.iter().rev().zip(["PinnedDrop"=
, "pin_init"]) {
+        if actual.ident !=3D expected {
+            return false;
+        }
+    }
+    true
+}
--=20
2.48.1



