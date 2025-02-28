Return-Path: <linux-kernel+bounces-538841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 155C9A49DB1
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 16:41:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14E6516C00F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 15:41:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D998018C02E;
	Fri, 28 Feb 2025 15:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EloH8aRT"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D8291EF399;
	Fri, 28 Feb 2025 15:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740757260; cv=none; b=Hz7LEWN3dMg+0OGu2OHpJ60Z0wJ9YUIcd0mBkiqEkC7VCeyDF2U52VH366eWPDfom5YHHkb3ESe+iMeKBXvJTgujMddGMHvUHIj1w3p8tLeaPUkeRu6EPIOclLKRU13swym6MJIkE3zcGQMwDauMlrP9q02NzQj8h8KOqvnUJHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740757260; c=relaxed/simple;
	bh=PzMZR8ySrEwnl0uhkZbUAuNqNu5MWfhTnY47kvpBWAU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qY9Y6D7mJRrDTR8vhFX0g+UdIomwDabKl+Z7gCIpzZ0fSbjDX5G77X1eogAw+PFMXh6dvXg4FsAiGPUN5l2OreRmgX/ullna2XgBlFRfYvSWPYb8EMMqcNOdMkDceUJoZUP3bXgyxmvCa3DAaYznMqdJPSXW1SRo+mG9HpsS5sY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EloH8aRT; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-54622829175so2051820e87.0;
        Fri, 28 Feb 2025 07:40:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740757256; x=1741362056; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6ljr8xrKyNBrwwV5pBT422OLhNCfKR2buem5K0sHBXw=;
        b=EloH8aRTIWxw17g9DZKWBNzFe5GMMun0thuEv8oTY8M0g8rOW7tehO4dzBnhpi0ZWJ
         VH2a8e0A/IqEwfEz6GyJ8HXhuDml/39FeUUcuh9HergwgmwmALyvVY/1XOz1+01kIYEN
         B7LHZjwan+cWp9fPVlBLN9sbLTktyqJNNd2MRmy4toW6H/b9++8JBfRMNlB9FYYPU+zn
         YLC9pW6lMO1mW0j651DDs0M0Oto3fj16vF6m0put8692DVPDkRD7UJ7aFCovPKn5WsnV
         anOAK8xuHqsmv72t9IPiUUEQXkOnlT5wtRrU8b2qtgy86XZ30luy7zQlVFvCiea+aIL6
         w0mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740757256; x=1741362056;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6ljr8xrKyNBrwwV5pBT422OLhNCfKR2buem5K0sHBXw=;
        b=eIURcE2VWm7bAbprzI8G65jSJPt6r40At++hHsEH1//0LQLrOBPoi0XFAnaelbJaqs
         eR/sIhft12AfTJ2R5g3EElJErqY2T7yYhuu0i+tem23vvVPn6CsPO4FPovKh8pSSlkOA
         d8ZWX92W9enLuBwNNbYGNTnko+HYtat5ndzABzYKZR9/W567zDCuc5jt6vaLlFafLGDG
         VA9jJDlZRKRJewaPyvh6GgJrTgJFGC1EEKwadSxldh7zlqw9UUJJyEQdQRQW9tC+zGT1
         MsRxHvKJYN9rs30mbrjAZXLFXeBEZ78BoPudjHB2hPkFrkEFl8pjT7ZBBBdiV581Krut
         E3Yg==
X-Forwarded-Encrypted: i=1; AJvYcCVqhVi5becYmZK8tkOJCgFqInEHINYiZBC7bYJ71hKzKlMkcnI6CcGYS7CbLl6SCpa0OuSvgWk3b7LzoEc=@vger.kernel.org, AJvYcCWI1VXqHCaLe2vx/GYx2/5WYc5IlbQqqr2qWmleX4HlsuaJGrUAuyhuzeHyFylgDHaqf268Smvb8AEODxK9PY4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyH1GBBEioR5YLpSPjZHdv4Pj7HUdzoxHMdMmtTUSgXDQ6P3rv
	inVE4usFjMkQuEJwKLV2Lnb14Pc8+V18HTFwylzqM4yksU+78eZ/XqK9BvyORZCkhstOLW4d1Pd
	MJb83s90PWJ8YEddOSr1So38TmLo=
X-Gm-Gg: ASbGncuaQbbx5R9iZQsuxE78xhcjtkaGajpSfwv2+HKLbKPzrn0Ub45B0QjVboizKdl
	h0I/da01hSML2tEC+Wq+FT8CNngEKlVDPlAig3lW4oLeou0v31hD7ozi1hDjYQ/1hGvrjPoPo+n
	lSnWrXqgPD84ePivGUSKfB0uWQzKyqCZqIZJybsCQx
X-Google-Smtp-Source: AGHT+IHd2IYB1u6mEXO4FqIUkiG5whxsZfQOPChl+QF4ogaZuoZTeMFdegzS150nu6LsBFjcskSikQEFMOXQ/GqiWLc=
X-Received: by 2002:a05:6512:1085:b0:545:1d96:d702 with SMTP id
 2adb3069b0e04-5494c38c05dmr1749128e87.48.1740757256077; Fri, 28 Feb 2025
 07:40:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250228-export-macro-v2-0-569cc7e8926c@google.com> <20250228-export-macro-v2-3-569cc7e8926c@google.com>
In-Reply-To: <20250228-export-macro-v2-3-569cc7e8926c@google.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Fri, 28 Feb 2025 10:40:19 -0500
X-Gm-Features: AQ5f1JrvtXu6E3vZKPCRN_Ad3C8FIGZhvOqUB8FjBPWdG1dpC6lS-lRNgheE0O4
Message-ID: <CAJ-ks9ng6AqmDynFebR+2_ZEpmvxkUNWdTed2vr0kede0dxcxw@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] rust: add #[export] macro
To: Alice Ryhl <aliceryhl@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 28, 2025 at 7:40=E2=80=AFAM Alice Ryhl <aliceryhl@google.com> w=
rote:
>
> Rust has two different tools for generating function declarations to
> call across the FFI boundary:
>
> * bindgen. Generates Rust declarations from a C header.
> * cbindgen. Generates C headers from Rust declarations.
>
> In the kernel, we only use bindgen. This is because cbindgen assumes a
> cargo-based buildsystem, so it is not compatible with the kernel's build
> system. This means that when C code calls a Rust function by name, its
> signature must be duplicated in both Rust code and a C header, and the
> signature needs to be kept in sync manually.

This needs an update given Miguel's comments on the cover letter. I
wonder if the code should also justify the choice (over cbindgen).

> To eliminate this manual checking, introduce a new macro that verifies
> at compile time that the two function declarations use the same
> signature. The idea is to run the C declaration through bindgen, and
> then have rustc verify that the function pointers have the same type.
>
> The signature must still be written twice, but at least you can no
> longer get it wrong. If the signatures don't match, you will get errors
> that look like this:
>
> error[E0308]: `if` and `else` have incompatible types
>   --> <linux>/rust/kernel/print.rs:22:22
>    |
> 21 | #[export]
>    | --------- expected because of this
> 22 | unsafe extern "C" fn rust_fmt_argument(
>    |                      ^^^^^^^^^^^^^^^^^ expected `u8`, found `i8`
>    |
>    =3D note: expected fn item `unsafe extern "C" fn(*mut u8, *mut u8, *mu=
t c_void) -> *mut u8 {bindings::rust_fmt_argument}`
>               found fn item `unsafe extern "C" fn(*mut i8, *mut i8, *cons=
t c_void) -> *mut i8 {print::rust_fmt_argument}`
>
> It is unfortunate that the error message starts out by saying "`if` and
> `else` have incompatible types", but I believe the rest of the error
> message is reasonably clear and not too confusing.
>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
>  rust/kernel/prelude.rs |  2 +-
>  rust/macros/export.rs  | 28 ++++++++++++++++++++++++++++
>  rust/macros/helpers.rs | 19 ++++++++++++++++++-
>  rust/macros/lib.rs     | 24 ++++++++++++++++++++++++
>  4 files changed, 71 insertions(+), 2 deletions(-)
>
> diff --git a/rust/kernel/prelude.rs b/rust/kernel/prelude.rs
> index dde2e0649790..889102f5a81e 100644
> --- a/rust/kernel/prelude.rs
> +++ b/rust/kernel/prelude.rs
> @@ -17,7 +17,7 @@
>  pub use crate::alloc::{flags::*, Box, KBox, KVBox, KVVec, KVec, VBox, VV=
ec, Vec};
>
>  #[doc(no_inline)]
> -pub use macros::{module, pin_data, pinned_drop, vtable, Zeroable};
> +pub use macros::{export, module, pin_data, pinned_drop, vtable, Zeroable=
};
>
>  pub use super::{build_assert, build_error};
>
> diff --git a/rust/macros/export.rs b/rust/macros/export.rs
> new file mode 100644
> index 000000000000..c5ec75f2b07f
> --- /dev/null
> +++ b/rust/macros/export.rs
> @@ -0,0 +1,28 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +use crate::helpers::function_name;
> +use proc_macro::TokenStream;
> +
> +/// Please see [`crate::export`] for documentation.
> +pub(crate) fn export(_attr: TokenStream, ts: TokenStream) -> TokenStream=
 {
> +    let Some(name) =3D function_name(ts.clone()) else {
> +        return "::core::compile_error!(\"The #[export] attribute must be=
 used on a function.\");"
> +            .parse::<TokenStream>()
> +            .unwrap();
> +    };

Could you also show in the commit message what this error looks like
when the macro is misused?

> +
> +    // This verifies that the function has the same signature as the dec=
laration generated by
> +    // bindgen. It makes use of the fact that all branches of an if/else=
 must have the same type.
> +    let signature_check =3D quote!(
> +        const _: () =3D {
> +            if true {
> +                ::kernel::bindings::#name
> +            } else {
> +                #name
> +            };
> +        };
> +    );
> +
> +    let no_mangle =3D "#[no_mangle]".parse::<TokenStream>().unwrap();

Would this be simpler as `let no_mangle =3D quote!("#[no_mangle]");`?

> +    TokenStream::from_iter([signature_check, no_mangle, ts])
> +}
> diff --git a/rust/macros/helpers.rs b/rust/macros/helpers.rs
> index 563dcd2b7ace..3e04f8ecfc74 100644
> --- a/rust/macros/helpers.rs
> +++ b/rust/macros/helpers.rs
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0
>
> -use proc_macro::{token_stream, Group, TokenStream, TokenTree};
> +use proc_macro::{token_stream, Group, Ident, TokenStream, TokenTree};
>
>  pub(crate) fn try_ident(it: &mut token_stream::IntoIter) -> Option<Strin=
g> {
>      if let Some(TokenTree::Ident(ident)) =3D it.next() {
> @@ -215,3 +215,20 @@ pub(crate) fn parse_generics(input: TokenStream) -> =
(Generics, Vec<TokenTree>) {
>          rest,
>      )
>  }
> +
> +/// Given a function declaration, finds the name of the function.
> +pub(crate) fn function_name(input: TokenStream) -> Option<Ident> {
> +    let mut input =3D input.into_iter();
> +    while let Some(token) =3D input.next() {
> +        match token {
> +            TokenTree::Ident(i) if i.to_string() =3D=3D "fn" =3D> {
> +                if let Some(TokenTree::Ident(i)) =3D input.next() {
> +                    return Some(i);
> +                }
> +                return None;
> +            }
> +            _ =3D> continue,
> +        }
> +    }
> +    None
> +}
> diff --git a/rust/macros/lib.rs b/rust/macros/lib.rs
> index d61bc6a56425..fbb2860e991f 100644
> --- a/rust/macros/lib.rs
> +++ b/rust/macros/lib.rs
> @@ -9,6 +9,7 @@
>  #[macro_use]
>  mod quote;
>  mod concat_idents;
> +mod export;
>  mod helpers;
>  mod module;
>  mod paste;
> @@ -174,6 +175,29 @@ pub fn vtable(attr: TokenStream, ts: TokenStream) ->=
 TokenStream {
>      vtable::vtable(attr, ts)
>  }
>
> +/// Export a function so that C code can call it via a header file.
> +///
> +/// Functions exported using this macro can be called from C code using =
the declaration in the
> +/// appropriate header file. It should only be used in cases where C cal=
ls the function through a
> +/// header file; cases where C calls into Rust via a function pointer in=
 a vtable (such as
> +/// `file_operations`) should not use this macro.
> +///
> +/// This macro has the following effect:
> +///
> +/// * Disables name mangling for this function.
> +/// * Verifies at compile-time that the function signature matches the d=
eclaration in the header
> +///   file.
> +///
> +/// You must declare the signature of the Rust function in a header file=
 that is included by
> +/// `rust/bindings/bindings_helper.h`.
> +///
> +/// This macro is *not* the same as the C macros `EXPORT_SYMBOL_*`, sinc=
e all Rust symbols are
> +/// currently automatically exported with `EXPORT_SYMBOL_GPL`.

nit: "since" implies causation, which isn't the case, I think.
Consider if ", since" can be replaced with a semicolon.

> +#[proc_macro_attribute]
> +pub fn export(attr: TokenStream, ts: TokenStream) -> TokenStream {
> +    export::export(attr, ts)
> +}
> +
>  /// Concatenate two identifiers.
>  ///
>  /// This is useful in macros that need to declare or reference items wit=
h names
>
> --
> 2.48.1.711.g2feabab25a-goog

Minor comments.

Reviewed-by: Tamir Duberstein <tamird@gmail.com>

