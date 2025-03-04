Return-Path: <linux-kernel+bounces-545754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 036A7A4F10C
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 00:01:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC9C13B08D9
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 23:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19BD627C864;
	Tue,  4 Mar 2025 22:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="TQz2dZyc"
Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C448280CE3;
	Tue,  4 Mar 2025 22:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741129062; cv=none; b=jkMj+fysM8ikyMVRKbpXdva4w9ah40oh5rjGQIYlmqJJ1T7XsulL9XhPzoeEYTXpSUsV/LnbgOkSsQTtOYpIqtdwwAcNKrW1TKR2043PPYj8yE+pM/RBF6EntfdV4P9xy2xFDkBINF7xaJhhhwtcVwLXSQq1xpAIUVmU+FhSgks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741129062; c=relaxed/simple;
	bh=KbjDGtvTijbpKqK/8B4kjKULb1TyKUiwydn+cSkxFOs=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SLouQaMY+Eoz8uXO6mP9LCYsXX+RXo95CG83vJJEgXcnuUAocc2JrR9TLTlRJFI1okBE1oEVNKu2xHKUEUlm9vHPuiYK2CA1PMcu59OBb4ZXu7SR4YoksDKjkiIsyiUuRyo10SmxgM2NIflUwmoCuK3cYjBCeyGVSIu4uCuUq40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=TQz2dZyc; arc=none smtp.client-ip=185.70.40.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1741129057; x=1741388257;
	bh=cLatnXLelTfXuWTiLeC9kgLfAfgHTMr7CnrwiKGHmX0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=TQz2dZycQMkm+wa792Tf7efkBLWyXV0eml3AQ/HmdSRg1eWJeBDv4EQvizKH4/NBU
	 xSKanun7FMa55rIT2dhbId8aiam6ggl+29TX9tJRSYu2yqRRaUqxphjregNR7TdDWe
	 BVSG7vHU7EW2/CCVHCyUc1P4zeC97TDyQISglIUK/uuT0Dv69yftwaaOubY7nFRGlz
	 J7jGLqV7yZ6aDQGrb84KumZy7IAdi5nsEEcVN4jSRqxbLUbFJF+9rcuoF85dfert5Z
	 zimIuPgos6oBpmnp3my5I6CtoT7UKB729K1VNty9FKMguzFgmeGw2mOwy8P8QGRi3m
	 SKmgPfIxkokug==
Date: Tue, 04 Mar 2025 22:57:33 +0000
To: Benno Lossin <benno.lossin@proton.me>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: [RFC PATCH 6/6] rust: pin-init: internal: add syn version of `[try_][pin_]init!` macros
Message-ID: <20250304225536.2033853-7-benno.lossin@proton.me>
In-Reply-To: <20250304225536.2033853-1-benno.lossin@proton.me>
References: <20250304225536.2033853-1-benno.lossin@proton.me>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 95b5f8be2ff954ae446d8260d70deccf648a79a9
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Implement the `[try_][pin_]init!` derive macro using syn to simplify
parsing by not going through an additional declarative macro.
This not only simplifies the code by a lot, increasing maintainability
and making it easier to implement new features. But also improves the
user experience by improving the error messages one gets when giving
incorrect inputs to the macro.
For example, placing a `,` after `..Zeroable::zeroed()` is not allowed:

    use pin_init::*;

    #[derive(Zeroable)]
    struct Foo {
        a: usize,
        b: usize,
    }

    fn main() {
        let _ =3D init!(Foo {
            a: 0,
            ..Zeroable::zeroed(),
        });
    }

The declarative macro produces this error:

    error: no rules expected `,`
       |
    11 |       let _ =3D init!(Foo {
       |  _____________^
    12 | |         a: 0,
    13 | |         ..Zeroable::zeroed(),
    14 | |     });
       | |______^ no rules expected this token in macro call
       |
    note: while trying to match `)`
      --> src/macros.rs
       |
       |         @munch_fields($(..Zeroable::zeroed())? $(,)?),
       |                                                     ^
       =3D note: this error originates in the macro `$crate::__init_interna=
l` which comes from the expansion of the macro `init` (in Nightly builds, r=
un with -Z macro-backtrace for more info)

    error: no rules expected `,`
       |
    11 |       let _ =3D init!(Foo {
       |  _____________^
    12 | |         a: 0,
    13 | |         ..Zeroable::zeroed(),
    14 | |     });
       | |______^ no rules expected this token in macro call
       |
    note: while trying to match `)`
      --> src/macros.rs
       |
       |         @munch_fields(..Zeroable::zeroed() $(,)?),
       |                                                 ^
       =3D note: this error originates in the macro `$crate::__init_interna=
l` which comes from the expansion of the macro `init` (in Nightly builds, r=
un with -Z macro-backtrace for more info)

The syn version reduces this error to the much more manageable:

    error: unexpected token, expected `}`
       |
    12 |         ..Zeroable::zeroed(),
       |                             ^

This reimplementation is benefiting the most from syn, as can be seen in
this example. It declares a struct with a single generic, but then
supplies two type arguments in the initializer:

    use pin_init::*;

    struct Foo<T> {
        value: T,
    }
    fn main() {
        let _ =3D init!(Foo::<(), ()> {
            value <- (),
        });
    }

The declarative version emits the following unreadable mess of an error
(shortened for brevity of the commit message):

    error: struct literal body without path
      |
    7 |       let _ =3D init!(Foo::<(), ()> {
      |  _____________^
    8 | |         value <- (),
    9 | |     });
      | |______^
      |
      =3D note: this error originates in the macro `$crate::__init_internal=
` which comes from the expansion of the macro `init` (in Nightly builds, ru=
n with -Z macro-backtrace for more info)
    help: you might have forgotten to add the struct literal inside the blo=
ck
     --> src/macros.rs
      |
      ~                 ::core::ptr::write($slot, $t { SomeStruct {
      |9                    $($acc)*
      ~                 } });
      |

<...40 lines skipped...>

    error[E0061]: this function takes 2 arguments but 3 arguments were supp=
lied
      |
    7 |       let _ =3D init!(Foo::<(), ()> {
      |  _____________^
    8 | |         value <- (),
    9 | |     });
      | |______^ unexpected argument #3
      |
    note: function defined here
     --> $RUST/core/src/ptr/mod.rs
      |
      | pub const unsafe fn write<T>(dst: *mut T, src: T) {
      |                     ^^^^^
      =3D note: this error originates in the macro `$crate::__init_internal=
` which comes from the expansion of the macro `init` (in Nightly builds, ru=
n with -Z macro-backtrace for more info)

This error delightfully reduces to the simple and clear message:

    error[E0107]: struct takes 1 generic argument but 2 generic arguments w=
ere supplied
      |
    7 |     let _ =3D init!(Foo::<(), ()> {
      |                   ^^^     ---- help: remove the unnecessary generic=
 argument
      |                   |
      |                   expected 1 generic argument
      |
    note: struct defined here, with 1 generic parameter: `T`
     --> tests/ui/compile-fail/init/wrong_generics2.rs:3:8
      |
    3 | struct Foo<T> {
      |        ^^^ -

The syn version is only enabled in the user-space version and disabled
in the kernel until syn becomes available there.

Signed-off-by: Benno Lossin <benno.lossin@proton.me>
---
 rust/pin-init/internal/src/init.rs | 404 +++++++++++++++++++++++++++++
 rust/pin-init/internal/src/lib.rs  |  78 ++++++
 rust/pin-init/src/__internal.rs    |  62 +++++
 rust/pin-init/src/lib.rs           |  66 +----
 4 files changed, 548 insertions(+), 62 deletions(-)
 create mode 100644 rust/pin-init/internal/src/init.rs

diff --git a/rust/pin-init/internal/src/init.rs b/rust/pin-init/internal/sr=
c/init.rs
new file mode 100644
index 000000000000..4d325cd3c006
--- /dev/null
+++ b/rust/pin-init/internal/src/init.rs
@@ -0,0 +1,404 @@
+// SPDX-License-Identifier: Apache-2.0 OR MIT
+
+use proc_macro2::{Ident, Span, TokenStream};
+use quote::{format_ident, quote, quote_spanned};
+use syn::{
+    braced,
+    parse::{Parse, ParseStream},
+    parse_quote,
+    punctuated::Punctuated,
+    spanned::Spanned,
+    token, Error, Expr, ExprCall, ExprPath, Path, Result, Token, Type,
+};
+
+pub(crate) struct InPlaceInitializer {
+    this: Option<This>,
+    path: Path,
+    brace_token: token::Brace,
+    fields: Punctuated<FieldInitializer, Token![,]>,
+    rest: Option<(Token![..], Expr)>,
+    error: Option<(Token![?], Type)>,
+}
+
+struct This {
+    _and_token: Token![&],
+    ident: Ident,
+    _in_token: Token![in],
+}
+
+enum FieldInitializer {
+    Value {
+        ident: Ident,
+        value: Option<(Token![:], Expr)>,
+    },
+    Init {
+        ident: Ident,
+        _larrow: Token![<-],
+        value: Expr,
+    },
+}
+
+impl FieldInitializer {
+    fn ident(&self) -> &Ident {
+        match self {
+            FieldInitializer::Value { ident, .. } | FieldInitializer::Init=
 { ident, .. } =3D> ident,
+        }
+    }
+}
+
+enum InitKind {
+    Normal,
+    Zeroing,
+}
+
+pub(crate) fn init(
+    InPlaceInitializer {
+        this,
+        path,
+        fields,
+        rest,
+        mut error,
+        brace_token,
+        ..
+    }: InPlaceInitializer,
+    default_error: bool,
+    pin: bool,
+) -> Result<TokenStream> {
+    if default_error {
+        error.get_or_insert((
+            Default::default(),
+            parse_quote!(::core::convert::Infallible),
+        ));
+    }
+    let Some((_, error)) =3D error else {
+        return Err(Error::new(
+            brace_token.span.close(),
+            "expected `? <type>` after `}`",
+        ));
+    };
+    let use_data =3D pin;
+    let (has_data_trait, data_trait, get_data, from_closure) =3D match pin=
 {
+        true =3D> (
+            format_ident!("HasPinData"),
+            format_ident!("PinData"),
+            format_ident!("__pin_data"),
+            format_ident!("pin_init_from_closure"),
+        ),
+        false =3D> (
+            format_ident!("HasInitData"),
+            format_ident!("InitData"),
+            format_ident!("__init_data"),
+            format_ident!("init_from_closure"),
+        ),
+    };
+
+    let init_kind =3D get_init_kind(rest)?;
+    let zeroable_check =3D match init_kind {
+        InitKind::Normal =3D> quote! {},
+        InitKind::Zeroing =3D> quote! {
+            // The user specified `..Zeroable::zeroed()` at the end of the=
 list of fields.
+            // Therefore we check if the struct implements `Zeroable` and =
then zero the memory.
+            // This allows us to also remove the check that all fields are=
 present (since we
+            // already set the memory to zero and that is a valid bit patt=
ern).
+            fn assert_zeroable<T: ?::core::marker::Sized>(_: *mut T)
+            where T: ::pin_init::Zeroable
+            {}
+            // Ensure that the struct is indeed `Zeroable`.
+            assert_zeroable(slot);
+            // SAFETY: The type implements `Zeroable` by the check above.
+            unsafe { ::core::ptr::write_bytes(slot, 0, 1) };
+        },
+    };
+
+    let this =3D match this {
+        None =3D> quote!(),
+        Some(This { ident, .. }) =3D> quote! {
+            // Create the `this` so it can be referenced by the user insid=
e of the
+            // expressions creating the individual fields.
+            let #ident =3D unsafe { ::core::ptr::NonNull::new_unchecked(sl=
ot) };
+        },
+    };
+    let data =3D format_ident!("data", span =3D Span::mixed_site());
+    let init_fields =3D init_fields(&fields, use_data, &data);
+    let field_check =3D make_field_check(&fields, init_kind, &path);
+    Ok(quote! {{
+        // We do not want to allow arbitrary returns, so we declare this t=
ype as the `Ok` return
+        // type and shadow it later when we insert the arbitrary user code=
. That way there will be
+        // no possibility of returning without `unsafe`.
+        struct __InitOk;
+        // Get the data about fields from the supplied type.
+        let #data =3D unsafe {
+            use ::pin_init::__internal::#has_data_trait;
+            // Can't use `<#path as #has_data_trait>::#get_data`, since th=
e user is able to omit
+            // generics (which need to be present with that syntax).
+            #path::#get_data()
+        };
+        // Ensure that `#data` really is of type `#data` and help with typ=
e inference:
+        let init =3D ::pin_init::__internal::#data_trait::make_closure::<_=
, __InitOk, #error>(
+            #data,
+            move |slot| {
+                {
+                    // Shadow the structure so it cannot be used to return=
 early.
+                    struct __InitOk;
+
+                    #zeroable_check
+
+                    #this
+
+                    #init_fields
+
+                    #field_check
+                }
+                Ok(__InitOk)
+            }
+        );
+        let init =3D move |slot| -> ::core::result::Result<(), #error> {
+            init(slot).map(|__InitOk| ())
+        };
+        let init =3D unsafe { ::pin_init::#from_closure::<_, #error>(init)=
 };
+        init
+    }})
+}
+
+fn get_init_kind(rest: Option<(Token![..], Expr)>) -> Result<InitKind> {
+    let Some((dotdot, expr)) =3D rest else {
+        return Ok(InitKind::Normal);
+    };
+    let error =3D Error::new_spanned(
+        quote!(#dotdot #expr),
+        "Expected one of the following:\n- Nothing.\n- `..Zeroable::zeroed=
()`.",
+    );
+    let Expr::Call(ExprCall {
+        func, args, attrs, ..
+    }) =3D expr
+    else {
+        return Err(error);
+    };
+    if !args.is_empty() || !attrs.is_empty() {
+        return Err(error);
+    }
+    match *func {
+        Expr::Path(ExprPath {
+            attrs,
+            qself: None,
+            path:
+                Path {
+                    leading_colon: None,
+                    segments,
+                },
+        }) if attrs.is_empty()
+            && segments.len() =3D=3D 2
+            && segments[0].ident =3D=3D "Zeroable"
+            && segments[0].arguments.is_none()
+            && segments[1].ident =3D=3D "zeroed"
+            && segments[1].arguments.is_none() =3D>
+        {
+            Ok(InitKind::Zeroing)
+        }
+        _ =3D> Err(error),
+    }
+}
+
+/// Generate the code that initializes the fields of the struct using the =
initializers in `field`.
+fn init_fields(
+    fields: &Punctuated<FieldInitializer, Token![,]>,
+    use_data: bool,
+    data: &Ident,
+) -> TokenStream {
+    let mut guards =3D vec![];
+    let mut res =3D TokenStream::new();
+    for field in fields {
+        let ident =3D field.ident();
+        let guard =3D format_ident!("__{ident}_guard", span =3D Span::mixe=
d_site());
+        guards.push(guard.clone());
+        let init =3D match field {
+            FieldInitializer::Value { ident, value } =3D> {
+                let mut value_ident =3D ident.clone();
+                let value =3D value.as_ref().map(|value| &value.1).map(|va=
lue| {
+                    // Setting the span of `value_ident` to `value`'s span=
 improves error messages
+                    // when the type of `value` is wrong.
+                    value_ident.set_span(value.span());
+                    quote!(let #value_ident =3D #value;)
+                });
+                // Again span for better diagnostics
+                let write =3D quote_spanned! {ident.span()=3D>
+                    ::core::ptr::write
+                };
+                quote! {
+                    {
+                        #value
+                        // Initialize the field.
+                        //
+                        // SAFETY: The memory at `slot` is uninitialized.
+                        unsafe { #write(::core::ptr::addr_of_mut!((*slot).=
#ident), #value_ident) };
+                    }
+                }
+            }
+            FieldInitializer::Init { ident, value, .. } =3D> {
+                if use_data {
+                    quote! {
+                        let init =3D #value;
+                        // Call the initializer.
+                        //
+                        // SAFETY: `slot` is valid, because we are inside =
of an initializer closure,
+                        // we return when an error/panic occurs.
+                        // We also use the `#data` to require the correct =
trait (`Init` or `PinInit`)
+                        // for `#ident`.
+                        unsafe { #data.#ident(::core::ptr::addr_of_mut!((*=
slot).#ident), init)? };
+                    }
+                } else {
+                    quote! {
+                        let init =3D #value;
+                        // Call the initializer.
+                        //
+                        // SAFETY: `slot` is valid, because we are inside =
of an initializer closure,
+                        // we return when an error/panic occurs.
+                        unsafe {
+                            ::pin_init::Init::__init(
+                                init,
+                                ::core::ptr::addr_of_mut!((*slot).#ident),
+                            )?
+                        };
+                    }
+                }
+            }
+        };
+        res.extend(init);
+        res.extend(quote! {
+            // Create the drop guard:
+            //
+            // We rely on macro hygiene to make it impossible for users to=
 access this local
+            // variable.
+            // SAFETY: We forget the guard later when initialization has s=
ucceeded.
+            let #guard =3D unsafe {
+                ::pin_init::__internal::DropGuard::new(
+                    ::core::ptr::addr_of_mut!((*slot).#ident)
+                )
+            };
+        });
+    }
+    quote! {
+        #res
+        // If execution reaches this point, all fields have been initializ=
ed. Therefore we can now
+        // dismiss the guards by forgetting them.
+        #(::core::mem::forget(#guards);)*
+    }
+}
+
+/// Generate the check for ensuring that every field has been initialized.
+fn make_field_check(
+    fields: &Punctuated<FieldInitializer, Token![,]>,
+    init_kind: InitKind,
+    path: &Path,
+) -> TokenStream {
+    let fields =3D fields.iter().map(|f| f.ident());
+    match init_kind {
+        InitKind::Normal =3D> quote! {
+            // We use unreachable code to ensure that all fields have been=
 mentioned exactly once,
+            // this struct initializer will still be type-checked and comp=
lain with a very natural
+            // error message if a field is forgotten/mentioned more than o=
nce.
+            #[allow(unreachable_code, clippy::diverging_sub_expression)]
+            // SAFETY: this code is never executed.
+            let _ =3D || unsafe {
+                ::core::ptr::write(slot, #path {
+                    #(
+                        #fields: ::core::panic!(),
+                    )*
+                })
+            };
+        },
+        InitKind::Zeroing =3D> quote! {
+            // We use unreachable code to ensure that all fields have been=
 mentioned at most once.
+            // Since the user specified `..Zeroable::zeroed()` at the end,=
 all missing fields will
+            // be zeroed. This struct initializer will still be type-check=
ed and complain with a
+            // very natural error message if a field is mentioned more tha=
n once, or doesn't exist.
+            #[allow(unreachable_code, clippy::diverging_sub_expression, un=
used_assignments)]
+            // SAFETY: this code is never executed.
+            let _ =3D || unsafe {
+                let mut zeroed =3D ::core::mem::zeroed();
+                ::core::ptr::write(slot, zeroed);
+                zeroed =3D ::core::mem::zeroed();
+                ::core::ptr::write(slot, #path {
+                    #(
+                        #fields: ::core::panic!(),
+                    )*
+                    ..zeroed
+                })
+            };
+        },
+    }
+}
+
+impl Parse for InPlaceInitializer {
+    fn parse(input: ParseStream) -> Result<Self> {
+        let content;
+        Ok(Self {
+            this: input.peek(Token![&]).then(|| input.parse()).transpose()=
?,
+            path: input.parse()?,
+            brace_token: braced!(content in input),
+            fields: {
+                let mut fields =3D Punctuated::new();
+                loop {
+                    let lookahead =3D content.lookahead1();
+                    if content.is_empty() || lookahead.peek(Token![..]) {
+                        break;
+                    } else if lookahead.peek(syn::Ident) {
+                        fields.push_value(content.parse()?);
+                        let lookahead =3D content.lookahead1();
+                        if lookahead.peek(Token![,]) {
+                            fields.push_punct(content.parse()?);
+                        } else if content.is_empty() {
+                            break;
+                        } else {
+                            return Err(lookahead.error());
+                        }
+                    } else {
+                        return Err(lookahead.error());
+                    }
+                }
+                fields
+            },
+            rest: content
+                .peek(Token![..])
+                .then(|| -> Result<_> { Ok((content.parse()?, content.pars=
e()?)) })
+                .transpose()?,
+            error: input
+                .peek(Token![?])
+                .then(|| -> Result<_> { Ok((input.parse()?, input.parse()?=
)) })
+                .transpose()?,
+        })
+    }
+}
+
+impl Parse for This {
+    fn parse(input: ParseStream) -> Result<Self> {
+        Ok(Self {
+            _and_token: input.parse()?,
+            ident: input.parse()?,
+            _in_token: input.parse()?,
+        })
+    }
+}
+
+impl Parse for FieldInitializer {
+    fn parse(input: ParseStream) -> Result<Self> {
+        let ident =3D input.parse()?;
+        let lookahead =3D input.lookahead1();
+        Ok(if lookahead.peek(Token![<-]) {
+            Self::Init {
+                ident,
+                _larrow: input.parse()?,
+                value: input.parse()?,
+            }
+        } else if lookahead.peek(Token![:]) {
+            Self::Value {
+                ident,
+                value: Some((input.parse()?, input.parse()?)),
+            }
+        } else if lookahead.peek(Token![,]) || input.is_empty() {
+            Self::Value { ident, value: None }
+        } else {
+            return Err(lookahead.error());
+        })
+    }
+}
diff --git a/rust/pin-init/internal/src/lib.rs b/rust/pin-init/internal/src=
/lib.rs
index 9ef6178e410f..bf524161022a 100644
--- a/rust/pin-init/internal/src/lib.rs
+++ b/rust/pin-init/internal/src/lib.rs
@@ -32,6 +32,8 @@
 #[cfg(kernel)]
 mod zeroable;
=20
+#[cfg(not(kernel))]
+mod init;
 #[cfg(not(kernel))]
 #[path =3D "syn_pin_data.rs"]
 mod pin_data;
@@ -56,3 +58,79 @@ pub fn pinned_drop(args: TokenStream, input: TokenStream=
) -> TokenStream {
 pub fn derive_zeroable(input: TokenStream) -> TokenStream {
     zeroable::derive(input.into()).into()
 }
+
+#[cfg(kernel)]
+#[proc_macro]
+pub fn pin_init(input: TokenStream) -> TokenStream {
+    quote!(::pin_init::__internal_pin_init!(#input))
+}
+
+#[cfg(not(kernel))]
+#[proc_macro]
+pub fn pin_init(input: TokenStream) -> TokenStream {
+    use syn::parse_macro_input;
+    init::init(
+        parse_macro_input!(input as init::InPlaceInitializer),
+        true,
+        true,
+    )
+    .unwrap_or_else(|e| e.into_compile_error())
+    .into()
+}
+
+#[cfg(kernel)]
+#[proc_macro]
+pub fn init(input: TokenStream) -> TokenStream {
+    quote!(::pin_init::__internal_init!(#input))
+}
+
+#[cfg(not(kernel))]
+#[proc_macro]
+pub fn init(input: TokenStream) -> TokenStream {
+    use syn::parse_macro_input;
+    init::init(
+        parse_macro_input!(input as init::InPlaceInitializer),
+        true,
+        false,
+    )
+    .unwrap_or_else(|e| e.into_compile_error())
+    .into()
+}
+
+#[cfg(kernel)]
+#[proc_macro]
+pub fn try_pin_init(input: TokenStream) -> TokenStream {
+    quote!(::pin_init::__internal_try_pin_init!(#input))
+}
+
+#[cfg(not(kernel))]
+#[proc_macro]
+pub fn try_pin_init(input: TokenStream) -> TokenStream {
+    use syn::parse_macro_input;
+    init::init(
+        parse_macro_input!(input as init::InPlaceInitializer),
+        false,
+        true,
+    )
+    .unwrap_or_else(|e| e.into_compile_error())
+    .into()
+}
+
+#[cfg(kernel)]
+#[proc_macro]
+pub fn try_init(input: TokenStream) -> TokenStream {
+    quote!(::pin_init::__internal_try_init!(#input))
+}
+
+#[cfg(not(kernel))]
+#[proc_macro]
+pub fn try_init(input: TokenStream) -> TokenStream {
+    use syn::parse_macro_input;
+    init::init(
+        parse_macro_input!(input as init::InPlaceInitializer),
+        false,
+        false,
+    )
+    .unwrap_or_else(|e| e.into_compile_error())
+    .into()
+}
diff --git a/rust/pin-init/src/__internal.rs b/rust/pin-init/src/__internal=
.rs
index 6b258502a9d7..741af6f2fdf6 100644
--- a/rust/pin-init/src/__internal.rs
+++ b/rust/pin-init/src/__internal.rs
@@ -287,3 +287,65 @@ unsafe fn __pinned_init(self, _slot: *mut T) -> Result=
<(), ()> {
         Err(())
     }
 }
+
+#[cfg(kernel)]
+#[macro_export]
+macro_rules! __internal_init {
+    ($(&$this:ident in)? $t:ident $(::<$($generics:ty),* $(,)?>)? {
+        $($fields:tt)*
+    }) =3D> {
+        $crate::try_init!($(&$this in)? $t $(::<$($generics),*>)? {
+            $($fields)*
+        }? ::core::convert::Infallible)
+    };
+}
+
+#[cfg(kernel)]
+#[macro_export]
+macro_rules! __internal_pin_init {
+    ($(&$this:ident in)? $t:ident $(::<$($generics:ty),* $(,)?>)? {
+        $($fields:tt)*
+    }) =3D> {
+        $crate::try_pin_init!($(&$this in)? $t $(::<$($generics),*>)? {
+            $($fields)*
+        }? ::core::convert::Infallible)
+    };
+}
+
+#[cfg(kernel)]
+#[macro_export]
+macro_rules! __internal_try_init {
+    ($(&$this:ident in)? $t:ident $(::<$($generics:ty),* $(,)?>)? {
+        $($fields:tt)*
+    }? $err:ty) =3D> {
+        $crate::__init_internal!(
+            @this($($this)?),
+            @typ($t $(::<$($generics),*>)?),
+            @fields($($fields)*),
+            @error($err),
+            @data(InitData, /*no use_data*/),
+            @has_data(HasInitData, __init_data),
+            @construct_closure(init_from_closure),
+            @munch_fields($($fields)*),
+        )
+    };
+}
+
+#[cfg(kernel)]
+#[macro_export]
+macro_rules! __internal_try_pin_init {
+    ($(&$this:ident in)? $t:ident $(::<$($generics:ty),* $(,)?>)? {
+        $($fields:tt)*
+    }? $err:ty) =3D> {
+        $crate::__init_internal!(
+            @this($($this)?),
+            @typ($t $(::<$($generics),*>)? ),
+            @fields($($fields)*),
+            @error($err),
+            @data(PinData, use_data),
+            @has_data(HasPinData, __pin_data),
+            @construct_closure(pin_init_from_closure),
+            @munch_fields($($fields)*),
+        )
+    };
+}
diff --git a/rust/pin-init/src/lib.rs b/rust/pin-init/src/lib.rs
index 356fc959bcb9..a5d86aae2e59 100644
--- a/rust/pin-init/src/lib.rs
+++ b/rust/pin-init/src/lib.rs
@@ -717,18 +717,7 @@ macro_rules! stack_try_pin_init {
 /// ```
 ///
 /// [`NonNull<Self>`]: core::ptr::NonNull
-// For a detailed example of how this macro works, see the module document=
ation of the hidden
-// module `macros` inside of `macros.rs`.
-#[macro_export]
-macro_rules! pin_init {
-    ($(&$this:ident in)? $t:ident $(::<$($generics:ty),* $(,)?>)? {
-        $($fields:tt)*
-    }) =3D> {
-        $crate::try_pin_init!($(&$this in)? $t $(::<$($generics),*>)? {
-            $($fields)*
-        }? ::core::convert::Infallible)
-    };
-}
+pub use pin_init_internal::pin_init;
=20
 /// Construct an in-place, fallible pinned initializer for `struct`s.
 ///
@@ -768,25 +757,7 @@ macro_rules! pin_init {
 /// }
 /// # let _ =3D Box::pin_init(BigBuf::new());
 /// ```
-// For a detailed example of how this macro works, see the module document=
ation of the hidden
-// module `macros` inside of `macros.rs`.
-#[macro_export]
-macro_rules! try_pin_init {
-    ($(&$this:ident in)? $t:ident $(::<$($generics:ty),* $(,)?>)? {
-        $($fields:tt)*
-    }? $err:ty) =3D> {
-        $crate::__init_internal!(
-            @this($($this)?),
-            @typ($t $(::<$($generics),*>)? ),
-            @fields($($fields)*),
-            @error($err),
-            @data(PinData, use_data),
-            @has_data(HasPinData, __pin_data),
-            @construct_closure(pin_init_from_closure),
-            @munch_fields($($fields)*),
-        )
-    }
-}
+pub use pin_init_internal::try_pin_init;
=20
 /// Construct an in-place initializer for `struct`s.
 ///
@@ -824,18 +795,7 @@ macro_rules! try_pin_init {
 /// }
 /// # let _ =3D Box::init(BigBuf::new());
 /// ```
-// For a detailed example of how this macro works, see the module document=
ation of the hidden
-// module `macros` inside of `macros.rs`.
-#[macro_export]
-macro_rules! init {
-    ($(&$this:ident in)? $t:ident $(::<$($generics:ty),* $(,)?>)? {
-        $($fields:tt)*
-    }) =3D> {
-        $crate::try_init!($(&$this in)? $t $(::<$($generics),*>)? {
-            $($fields)*
-        }? ::core::convert::Infallible)
-    }
-}
+pub use pin_init_internal::init;
=20
 /// Construct an in-place fallible initializer for `struct`s.
 ///
@@ -873,25 +833,7 @@ macro_rules! init {
 /// }
 /// # let _ =3D Box::init(BigBuf::new());
 /// ```
-// For a detailed example of how this macro works, see the module document=
ation of the hidden
-// module `macros` inside of `macros.rs`.
-#[macro_export]
-macro_rules! try_init {
-    ($(&$this:ident in)? $t:ident $(::<$($generics:ty),* $(,)?>)? {
-        $($fields:tt)*
-    }? $err:ty) =3D> {
-        $crate::__init_internal!(
-            @this($($this)?),
-            @typ($t $(::<$($generics),*>)?),
-            @fields($($fields)*),
-            @error($err),
-            @data(InitData, /*no use_data*/),
-            @has_data(HasInitData, __init_data),
-            @construct_closure(init_from_closure),
-            @munch_fields($($fields)*),
-        )
-    }
-}
+pub use pin_init_internal::try_init;
=20
 /// Asserts that a field on a struct using `#[pin_data]` is marked with `#=
[pin]` ie. that it is
 /// structurally pinned.
--=20
2.48.1



