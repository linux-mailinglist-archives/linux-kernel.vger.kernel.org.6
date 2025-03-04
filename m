Return-Path: <linux-kernel+bounces-545751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0C12A4F0F9
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 00:00:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 818393AFB92
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 22:59:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5E4127C172;
	Tue,  4 Mar 2025 22:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="QdN82TJl"
Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CBA72620EF
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 22:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741129040; cv=none; b=cV5fH0QFuGZG8TpgXfXCstBG3fBnF8RwWxnepAm3ri7PvtUnI+jdq5bfkk4byEzLROT8ReDkTwsqbIRw2vUq5En73l+qcF5n1cAzL4NCNpnsWSeftW3XFAjbg/7Wa1chqWSbvr6r+WJCnnPP2NsXayQH5T+PWpiAStXZcLejCQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741129040; c=relaxed/simple;
	bh=DPDTrjuF7mI7qb5sv+wsWhmWeK982AWmqNancLfopZQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uQDvb6Xr1wQkg3zmsfjxmRPemhVwN/Xb2BNqfmcnaJMCCVySh7Uu0sJZ7kHR3O0sDy7KwK6bE6+mniP0KB6DtH3fKkMVsBzh8oW2pVExy13VtWaqhHYVuLgQ3yMIcsRl6M0EXnZ4IzyuLfvwFgxqOgGz9mlvlJWLA6gv//wF7SM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=QdN82TJl; arc=none smtp.client-ip=185.70.40.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=ozivshyzvvcdjctxbrdowxhfya.protonmail; t=1741129036; x=1741388236;
	bh=qQAVy4uo8qFwAhXOaC3NgVy7vYYVfpy88Dx8uYQlmYs=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=QdN82TJlV/ruz5Xr6DX6yKFNZV5pwtwrSGV9fCknT8o1LMUxLb5oLzlhJQYHxTmrd
	 I6nCMX+yy48y7myt/vAsPZ5Lkt84MYDzK0sYD2ZplusKFXX6LOiSfNmjQiSHtL59o+
	 NpbpiBA9pHWCNXYo2XqrqPvvSvHAxwc/W1mKgYqtMNzXqi8YMx5VGjTkhgRNMP8WVh
	 boV/b9P3VLIPa7kVwx+ixNSJPyKqN0JBGxUPBF3keYWiDrLvVnFmY+acG32KuJl2ov
	 umAJufy5ubtQnRD4dQyUdZZ5V6thjfqYZReJOjMLTEZTp/9J7+c9V17Y7xl+qlzXta
	 olrU/DdeWl6DQ==
Date: Tue, 04 Mar 2025 22:57:10 +0000
To: Benno Lossin <benno.lossin@proton.me>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: [RFC PATCH 3/6] rust: pin-init: internal: add syn version of the `pin_data` proc macro
Message-ID: <20250304225536.2033853-4-benno.lossin@proton.me>
In-Reply-To: <20250304225536.2033853-1-benno.lossin@proton.me>
References: <20250304225536.2033853-1-benno.lossin@proton.me>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 3984665d6322dc4d4ed05dd6a42769496df8d966
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Implement the `pin_data` attribute macro using syn to simplify parsing
by not going through an additional declarative macro.
This not only simplifies the code by a lot, increasing maintainability
and making it easier to implement new features. But also improves the
user experience by improving the error messages one gets when giving
incorrect inputs to the macro.
For example, annotating a function with `pin_data` is not allowed:

    use pin_init::*;

    #[pin_data]
    fn foo() {}

This results in the following rather unwieldy error with the declarative
version:

    error: no rules expected keyword `fn`
      |
    4 | fn foo() {}
      | ^^ no rules expected this token in macro call
      |
    note: while trying to match keyword `struct`
     --> src/macros.rs
      |
      |             $vis:vis struct $name:ident
      |                      ^^^^^^

    error: Could not locate type name.
      |
    3 | #[pin_data]
      | ^^^^^^^^^^^
      |
      =3D note: this error originates in the attribute macro `pin_data` (in=
 Nightly builds, run with -Z macro-backtrace for more info)

The syn version gives this very concise error:

    error: expected `struct`
      |
    4 | fn foo() {}
      | ^^

The syn version is only enabled in the user-space version and disabled
in the kernel until syn becomes available there.

Signed-off-by: Benno Lossin <benno.lossin@proton.me>
---
 rust/pin-init/internal/src/lib.rs          |   9 +-
 rust/pin-init/internal/src/syn_pin_data.rs | 313 +++++++++++++++++++++
 2 files changed, 318 insertions(+), 4 deletions(-)
 create mode 100644 rust/pin-init/internal/src/syn_pin_data.rs

diff --git a/rust/pin-init/internal/src/lib.rs b/rust/pin-init/internal/src=
/lib.rs
index 761fbf8b9c68..9ef6178e410f 100644
--- a/rust/pin-init/internal/src/lib.rs
+++ b/rust/pin-init/internal/src/lib.rs
@@ -23,17 +23,18 @@
 #[path =3D "../../../macros/quote.rs"]
 #[macro_use]
 mod quote;
-#[cfg(not(kernel))]
-#[macro_use]
-extern crate quote;
-
+#[cfg(kernel)]
 mod helpers;
+#[cfg(kernel)]
 mod pin_data;
 #[cfg(kernel)]
 mod pinned_drop;
 #[cfg(kernel)]
 mod zeroable;
=20
+#[cfg(not(kernel))]
+#[path =3D "syn_pin_data.rs"]
+mod pin_data;
 #[cfg(not(kernel))]
 #[path =3D "syn_pinned_drop.rs"]
 mod pinned_drop;
diff --git a/rust/pin-init/internal/src/syn_pin_data.rs b/rust/pin-init/int=
ernal/src/syn_pin_data.rs
new file mode 100644
index 000000000000..d95176389e17
--- /dev/null
+++ b/rust/pin-init/internal/src/syn_pin_data.rs
@@ -0,0 +1,313 @@
+// SPDX-License-Identifier: Apache-2.0 OR MIT
+
+use proc_macro2::TokenStream;
+use quote::quote;
+use syn::{
+    parse_macro_input, parse_quote,
+    visit_mut::{visit_path_segment_mut, VisitMut},
+    Error, Field, ItemStruct, PathSegment, Result, Type, TypePath, WhereCl=
ause,
+};
+
+pub(crate) fn pin_data(
+    inner: proc_macro::TokenStream,
+    item: proc_macro::TokenStream,
+) -> proc_macro::TokenStream {
+    do_impl(inner.into(), parse_macro_input!(item as ItemStruct))
+        .unwrap_or_else(|e| e.into_compile_error())
+        .into()
+}
+
+fn do_impl(args: TokenStream, mut struct_: ItemStruct) -> Result<TokenStre=
am> {
+    // The generics might contain the `Self` type. Since this macro will d=
efine a new type with the
+    // same generics and bounds, this poses a problem: `Self` will refer t=
o the new type as opposed
+    // to this struct definition. Therefore we have to replace `Self` with=
 the concrete name.
+    let mut replacer =3D {
+        let name =3D &struct_.ident;
+        let (_, ty_generics, _) =3D struct_.generics.split_for_impl();
+        SelfReplacer(parse_quote!(#name #ty_generics))
+    };
+    replacer.visit_generics_mut(&mut struct_.generics);
+
+    let the_pin_data =3D generate_the_pin_data(&struct_);
+    let unpin_impl =3D unpin_impl(&struct_);
+    let drop_impl =3D drop_impl(&struct_, args)?;
+
+    let mut errors =3D TokenStream::new();
+    for field in &mut struct_.fields {
+        if !is_pinned(field) && is_phantom_pinned(&field.ty) {
+            let message =3D format!("The field `{}` of type `PhantomPinned=
` only has an effect, if it has the `#[pin]` attribute", field.ident.as_ref=
().unwrap() );
+            errors.extend(quote!(::core::compile_error!(#message);));
+        }
+        field.attrs.retain(|a| !a.path().is_ident("pin"));
+    }
+    Ok(quote! {
+        #struct_
+        #errors
+        const _: () =3D {
+            #the_pin_data
+            #unpin_impl
+            #drop_impl
+        };
+    })
+}
+
+struct SelfReplacer(PathSegment);
+
+impl VisitMut for SelfReplacer {
+    fn visit_path_segment_mut(&mut self, seg: &mut PathSegment) {
+        if seg.ident =3D=3D "Self" {
+            *seg =3D self.0.clone();
+        } else {
+            visit_path_segment_mut(self, seg);
+        }
+    }
+
+    fn visit_item_mut(&mut self, _: &mut syn::Item) {
+        // Do not descend into items, since items reset/change what `Self`=
 refers to.
+    }
+}
+
+fn is_pinned(field: &Field) -> bool {
+    field.attrs.iter().any(|a| a.path().is_ident("pin"))
+}
+
+fn is_phantom_pinned(ty: &Type) -> bool {
+    match ty {
+        Type::Path(TypePath { qself: None, path }) =3D> {
+            // Cannot possibly refer to `PhantomPinned`.
+            if path.segments.len() > 3 {
+                return false;
+            }
+            // If there is a `::`, then the path needs to be `::core::mark=
er::PhantomPinned` or
+            // `::std::marker::PhantomPinned`.
+            if path.leading_colon.is_some() && path.segments.len() !=3D 3 =
{
+                return false;
+            }
+            let expected: Vec<&[&str]> =3D vec![&["PhantomPinned"], &["mar=
ker"], &["core", "std"]];
+            for (actual, expected) in path.segments.iter().rev().zip(expec=
ted) {
+                if !actual.arguments.is_empty() || expected.iter().all(|e|=
 actual.ident !=3D e) {
+                    return false;
+                }
+            }
+            true
+        }
+        _ =3D> false,
+    }
+}
+
+fn generate_the_pin_data(
+    ItemStruct {
+        vis,
+        ident,
+        generics,
+        fields,
+        ..
+    }: &ItemStruct,
+) -> TokenStream {
+    let (impl_generics, ty_generics, whr) =3D generics.split_for_impl();
+
+    // For every field, we create a projection function according to its p=
rojection type. If a
+    // field is structurally pinned, then it must be initialized via `PinI=
nit`, if it is not
+    // structurally pinned, then it must be initialized via `Init`.
+    let pinned_field_accessors =3D fields
+        .iter()
+        .filter(|f| is_pinned(f))
+        .map(|Field { vis, ident, ty, .. }| {
+            quote! {
+                #vis unsafe fn #ident<E>(
+                    self,
+                    slot: *mut #ty,
+                    init: impl ::pin_init::PinInit<#ty, E>,
+                ) -> ::core::result::Result<(), E> {
+                    unsafe { ::pin_init::PinInit::__pinned_init(init, slot=
) }
+                }
+            }
+        })
+        .collect::<TokenStream>();
+    let not_pinned_field_accessors =3D fields
+        .iter()
+        .filter(|f| !is_pinned(f))
+        .map(|Field { vis, ident, ty, .. }| {
+            quote! {
+                #vis unsafe fn #ident<E>(
+                    self,
+                    slot: *mut #ty,
+                    init: impl ::pin_init::Init<#ty, E>,
+                ) -> ::core::result::Result<(), E> {
+                    unsafe { ::pin_init::Init::__init(init, slot) }
+                }
+            }
+        })
+        .collect::<TokenStream>();
+    quote! {
+        // We declare this struct which will host all of the projection fu=
nction for our type. It
+        // will be invariant over all generic parameters which are inherit=
ed from the struct.
+        #vis struct __ThePinData #generics
+            #whr
+        {
+            __phantom: ::core::marker::PhantomData<
+                fn(#ident #ty_generics) -> #ident #ty_generics
+            >,
+        }
+
+        impl #impl_generics ::core::clone::Clone for __ThePinData #ty_gene=
rics
+            #whr
+        {
+            fn clone(&self) -> Self { *self }
+        }
+
+        impl #impl_generics ::core::marker::Copy for __ThePinData #ty_gene=
rics
+            #whr
+        {}
+
+        #[allow(dead_code)] // Some functions might never be used and priv=
ate.
+        #[expect(clippy::missing_safety_doc)]
+        impl #impl_generics __ThePinData #ty_generics
+            #whr
+        {
+            #pinned_field_accessors
+            #not_pinned_field_accessors
+        }
+
+        // SAFETY: We have added the correct projection functions above to=
 `__ThePinData` and
+        // we also use the least restrictive generics possible.
+        unsafe impl #impl_generics
+            ::pin_init::__internal::HasPinData for #ident #ty_generics
+            #whr
+        {
+            type PinData =3D __ThePinData #ty_generics;
+
+            unsafe fn __pin_data() -> Self::PinData {
+                __ThePinData { __phantom: ::core::marker::PhantomData }
+            }
+        }
+
+        unsafe impl #impl_generics
+            ::pin_init::__internal::PinData for __ThePinData #ty_generics
+            #whr
+        {
+            type Datee =3D #ident #ty_generics;
+        }
+    }
+}
+
+fn unpin_impl(
+    ItemStruct {
+        ident,
+        generics,
+        fields,
+        ..
+    }: &ItemStruct,
+) -> TokenStream {
+    let generics_with_pinlt =3D {
+        let mut g =3D generics.clone();
+        g.params.insert(0, parse_quote!('__pin));
+        let _ =3D g.make_where_clause();
+        g
+    };
+    let (
+        impl_generics_with_pinlt,
+        ty_generics_with_pinlt,
+        Some(WhereClause {
+            where_token,
+            predicates,
+        }),
+    ) =3D generics_with_pinlt.split_for_impl()
+    else {
+        unreachable!()
+    };
+    let (_, ty_generics, _) =3D generics.split_for_impl();
+    let mut pinned_fields =3D fields
+        .iter()
+        .filter(|f| is_pinned(f))
+        .cloned()
+        .collect::<Vec<_>>();
+    for field in &mut pinned_fields {
+        field.attrs.retain(|a| !a.path().is_ident("pin"));
+    }
+    quote! {
+        // This struct will be used for the unpin analysis. It is needed, =
because only structurally
+        // pinned fields are relevant whether the struct should implement =
`Unpin`.
+        #[allow(dead_code)] // The fields below are never used.
+        struct __Unpin #generics_with_pinlt
+        #where_token
+            #predicates
+        {
+            __phantom_pin: ::core::marker::PhantomData<fn(&'__pin ()) -> &=
'__pin ()>,
+            __phantom: ::core::marker::PhantomData<
+                fn(#ident #ty_generics) -> #ident #ty_generics
+            >,
+            #(#pinned_fields),*
+        }
+
+        #[doc(hidden)]
+        impl #impl_generics_with_pinlt ::core::marker::Unpin for #ident #t=
y_generics
+        #where_token
+            __Unpin #ty_generics_with_pinlt: ::core::marker::Unpin,
+            #predicates
+        {}
+    }
+}
+
+fn drop_impl(
+    ItemStruct {
+        ident, generics, ..
+    }: &ItemStruct,
+    args: TokenStream,
+) -> Result<TokenStream> {
+    let (impl_generics, ty_generics, whr) =3D generics.split_for_impl();
+    let has_pinned_drop =3D match syn::parse2::<Option<syn::Ident>>(args.c=
lone()) {
+        Ok(None) =3D> false,
+        Ok(Some(ident)) if ident =3D=3D "PinnedDrop" =3D> true,
+        _ =3D> {
+            return Err(Error::new_spanned(
+                args,
+                "Expected nothing or `PinnedDrop` as arguments to `#[pin_d=
ata]`.",
+            ))
+        }
+    };
+    // We need to disallow normal `Drop` implementation, the exact behavio=
r depends on whether
+    // `PinnedDrop` was specified in `args`.
+    Ok(if has_pinned_drop {
+        // When `PinnedDrop` was specified we just implement `Drop` and de=
legate.
+        quote! {
+            impl #impl_generics ::core::ops::Drop for #ident #ty_generics
+                #whr
+            {
+                fn drop(&mut self) {
+                    // SAFETY: Since this is a destructor, `self` will not=
 move after this function
+                    // terminates, since it is inaccessible.
+                    let pinned =3D unsafe { ::core::pin::Pin::new_unchecke=
d(self) };
+                    // SAFETY: Since this is a drop function, we can creat=
e this token to call the
+                    // pinned destructor of this type.
+                    let token =3D unsafe { ::pin_init::__internal::OnlyCal=
lFromDrop::new() };
+                    ::pin_init::PinnedDrop::drop(pinned, token);
+                }
+            }
+        }
+    } else {
+        // When no `PinnedDrop` was specified, then we have to prevent imp=
lementing drop.
+        quote! {
+            // We prevent this by creating a trait that will be implemente=
d for all types implementing
+            // `Drop`. Additionally we will implement this trait for the s=
truct leading to a conflict,
+            // if it also implements `Drop`
+            trait MustNotImplDrop {}
+            #[expect(drop_bounds)]
+            impl<T: ::core::ops::Drop> MustNotImplDrop for T {}
+            impl #impl_generics MustNotImplDrop for #ident #ty_generics
+                #whr
+            {}
+            // We also take care to prevent users from writing a useless `=
PinnedDrop` implementation.
+            // They might implement `PinnedDrop` correctly for the struct,=
 but forget to give
+            // `PinnedDrop` as the parameter to `#[pin_data]`.
+            #[expect(non_camel_case_types)]
+            trait UselessPinnedDropImpl_you_need_to_specify_PinnedDrop {}
+            impl<T: ::pin_init::PinnedDrop> UselessPinnedDropImpl_you_need=
_to_specify_PinnedDrop
+                for T {}
+            impl #impl_generics
+                UselessPinnedDropImpl_you_need_to_specify_PinnedDrop for #=
ident #ty_generics
+                #whr
+            {}
+        }
+    })
+}
--=20
2.48.1



