Return-Path: <linux-kernel+bounces-537991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 68EF7A4934F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 09:21:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2CDE1894809
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 08:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5974A248867;
	Fri, 28 Feb 2025 08:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g0aLyuzF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AE001D61B7;
	Fri, 28 Feb 2025 08:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740730835; cv=none; b=osGvi2v8mGBtrukm1pDfPr5cvCj3Nk8Y0ffKezSwvzBhlH8BwMtin8jpJKE9ZJIGvXLHNv7+f4e/qI69V5ICWQli0HVPMsL/Ych/yn6y9FECR2mqp0mhH11RSaFul4KtOnhC+mQOS7ME/6+OpQi28lJ5AJDb6j4nfRAZ8syYYk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740730835; c=relaxed/simple;
	bh=CagEBvlVT2CKs3j05MhMn7DHiJHMme0HEJxfM1CBDM0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=T3kO+ZnVdZxIKHvoVdg4ELSDjUB9wqtfLSDjKytOpzFB1/KUJRevRANbSTwQjmclm5w6zN1wRlUvAEVxl+p1p/Otm0nbo658FL2rF3OnLFhW6Zqv/7CpYdJ4w3bcEyCjbJlhYB4q66WrLRy4swEv7R+WxTvMUUVTkKLe2Je90ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g0aLyuzF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B60ACC4CED6;
	Fri, 28 Feb 2025 08:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740730835;
	bh=CagEBvlVT2CKs3j05MhMn7DHiJHMme0HEJxfM1CBDM0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=g0aLyuzF5oh1T1zQHxaUFT6JBkcvOUZDQWI/L+0Og77wCJ3NM6umvnxoVOclgm4NI
	 hmewB4ppJy8IBMzyWiKxfswgk6C5jSFPEwJPuX/Qsge17x63uI5zHroYTgQ8yBgV4X
	 hZxbS/G5cyQ7Vowpr/Suiy3aBT0W6yfKK9+7++Y4AqSKHn4xhiI2m7NwelkH5v/ANF
	 dv7n8uWgBDBBW9qZ//g9aKcWpRLGIb2za0pqZyU4Glk+FUUJbU+Xob2s6tFDuXh3zN
	 Kw8jiEJ6+n5KdwrbLdC0I5APt6I7HN67eLO4l9P8PR19iiGMTgoLn31sLRXryEwlGT
	 wywMDYr3YiaPw==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Alice Ryhl" <aliceryhl@google.com>
Cc: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,  "Miguel Ojeda"
 <ojeda@kernel.org>,  "Petr Mladek" <pmladek@suse.com>,  "Steven Rostedt"
 <rostedt@goodmis.org>,  "Andy Shevchenko"
 <andriy.shevchenko@linux.intel.com>,  "Rasmus Villemoes"
 <linux@rasmusvillemoes.dk>,  "Sergey Senozhatsky"
 <senozhatsky@chromium.org>,  "Andrew Morton" <akpm@linux-foundation.org>,
  "Boqun Feng" <boqun.feng@gmail.com>,  "Gary Guo" <gary@garyguo.net>,
  =?utf-8?Q?Bj=C3=B6rn?= Roy Baron <bjorn3_gh@protonmail.com>,  "Benno
 Lossin"
 <benno.lossin@proton.me>,  "Trevor Gross" <tmgross@umich.edu>,  "Maarten
 Lankhorst" <maarten.lankhorst@linux.intel.com>,  "Maxime Ripard"
 <mripard@kernel.org>,  "Thomas Zimmermann" <tzimmermann@suse.de>,  "David
 Airlie" <airlied@gmail.com>,  "Simona Vetter" <simona@ffwll.ch>,
  <linux-kernel@vger.kernel.org>,  <rust-for-linux@vger.kernel.org>,
  <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH 2/4] rust: add #[export] macro
In-Reply-To: <20250227-export-macro-v1-2-948775fc37aa@google.com> (Alice
	Ryhl's message of "Thu, 27 Feb 2025 17:02:00 +0000")
References: <20250227-export-macro-v1-0-948775fc37aa@google.com>
	<CKneQ3Au7Fx5Uc7AM_RTi5BXRNnOUcrfnqI0fuWO5M7QIosWye4LhdM7bf9zqqzC5dCISrLHE9OgvVeVSla54Q==@protonmail.internalid>
	<20250227-export-macro-v1-2-948775fc37aa@google.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Fri, 28 Feb 2025 09:12:13 +0100
Message-ID: <871pvipjxe.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Alice Ryhl" <aliceryhl@google.com> writes:

> This macro behaves like #[no_mangle], but also performs an assertion
> that the Rust function has the same signature as what is declared in the
> C header.
>
> If the signatures don't match, you will get errors that look like this:
>
> error[E0308]: `if` and `else` have incompatible types
>   --> <linux>/rust/kernel/print.rs:22:22
>    |
> 21 | #[export]
>    | --------- expected because of this
> 22 | unsafe extern "C" fn rust_fmt_argument(
>    |                      ^^^^^^^^^^^^^^^^^ expected `u8`, found `i8`
>    |
>    = note: expected fn item `unsafe extern "C" fn(*mut u8, *mut u8, *mut c_void) -> *mut u8 {bindings::rust_fmt_argument}`
>               found fn item `unsafe extern "C" fn(*mut i8, *mut i8, *const c_void) -> *mut i8 {print::rust_fmt_argument}`
>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
>  rust/kernel/prelude.rs |  2 +-
>  rust/macros/export.rs  | 25 +++++++++++++++++++++++++
>  rust/macros/helpers.rs | 19 ++++++++++++++++++-
>  rust/macros/lib.rs     | 18 ++++++++++++++++++
>  rust/macros/quote.rs   | 21 +++++++++++++++++++--
>  5 files changed, 81 insertions(+), 4 deletions(-)
>
> diff --git a/rust/kernel/prelude.rs b/rust/kernel/prelude.rs
> index dde2e0649790..889102f5a81e 100644
> --- a/rust/kernel/prelude.rs
> +++ b/rust/kernel/prelude.rs
> @@ -17,7 +17,7 @@
>  pub use crate::alloc::{flags::*, Box, KBox, KVBox, KVVec, KVec, VBox, VVec, Vec};
>
>  #[doc(no_inline)]
> -pub use macros::{module, pin_data, pinned_drop, vtable, Zeroable};
> +pub use macros::{export, module, pin_data, pinned_drop, vtable, Zeroable};
>
>  pub use super::{build_assert, build_error};
>
> diff --git a/rust/macros/export.rs b/rust/macros/export.rs
> new file mode 100644
> index 000000000000..3398e1655124
> --- /dev/null
> +++ b/rust/macros/export.rs
> @@ -0,0 +1,25 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +use crate::helpers::function_name;
> +use proc_macro::TokenStream;
> +
> +pub(crate) fn export(_attr: TokenStream, ts: TokenStream) -> TokenStream {

This function is documented in macros/lib.rs. Could you insert a
docstring with a link to the function that carries the docs?

Please describe how the function operates and what mechanics it uses to
achieve its goal in a implementation detail comment.

> +    let Some(name) = function_name(ts.clone()) else {
> +        return "::core::compile_error!(\"The #[export] attribute must be used on a function.\");"
> +            .parse::<TokenStream>()
> +            .unwrap();
> +    };
> +
> +    let signature_check = quote!(
> +        const _: () = {
> +            if true {
> +                ::kernel::bindings::#name
> +            } else {
> +                #name
> +            };
> +        };
> +    );
> +
> +    let no_mangle = "#[no_mangle]".parse::<TokenStream>().unwrap();
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
>  pub(crate) fn try_ident(it: &mut token_stream::IntoIter) -> Option<String> {
>      if let Some(TokenTree::Ident(ident)) = it.next() {
> @@ -215,3 +215,20 @@ pub(crate) fn parse_generics(input: TokenStream) -> (Generics, Vec<TokenTree>) {
>          rest,
>      )
>  }
> +
> +/// Given a function declaration, finds the name of the function.
> +pub(crate) fn function_name(input: TokenStream) -> Option<Ident> {

It would be great with a few tests for this function.

> +    let mut input = input.into_iter();
> +    while let Some(token) = input.next() {
> +        match token {
> +            TokenTree::Ident(i) if i.to_string() == "fn" => {
> +                if let Some(TokenTree::Ident(i)) = input.next() {
> +                    return Some(i);
> +                }
> +                return None;
> +            }
> +            _ => continue,
> +        }
> +    }
> +    None
> +}
> diff --git a/rust/macros/lib.rs b/rust/macros/lib.rs
> index d61bc6a56425..3cbf7705c4c1 100644
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
> @@ -174,6 +175,23 @@ pub fn vtable(attr: TokenStream, ts: TokenStream) -> TokenStream {
>      vtable::vtable(attr, ts)
>  }
>
> +/// Export a function so that C code can call it.
> +///
> +/// This macro has the following effect:
> +///
> +/// * Disables name mangling for this function.
> +/// * Verifies at compile-time that the function signature matches what's in the header file.
> +///
> +/// This macro requires that the function is mentioned in a C header file, and that the header file
> +/// is included in `rust/bindings/bindings_helper.h`.
> +///
> +/// This macro is *not* the same as the C macro `EXPORT_SYMBOL*`, since all Rust symbols are
> +/// currently automatically exported with `EXPORT_SYMBOL_GPL`.

Perhaps add the following:

This macro is useful when rust code is providing a function symbol whose
signature is dictated by a C header file.

> +#[proc_macro_attribute]
> +pub fn export(attr: TokenStream, ts: TokenStream) -> TokenStream {
> +    export::export(attr, ts)
> +}
> +
>  /// Concatenate two identifiers.
>  ///
>  /// This is useful in macros that need to declare or reference items with names
> diff --git a/rust/macros/quote.rs b/rust/macros/quote.rs
> index 33a199e4f176..c18960a91082 100644
> --- a/rust/macros/quote.rs
> +++ b/rust/macros/quote.rs
> @@ -20,6 +20,12 @@ fn to_tokens(&self, tokens: &mut TokenStream) {
>      }
>  }
>
> +impl ToTokens for proc_macro::Ident {
> +    fn to_tokens(&self, tokens: &mut TokenStream) {
> +        tokens.extend([TokenTree::from(self.clone())]);
> +    }
> +}
> +
>  impl ToTokens for TokenTree {
>      fn to_tokens(&self, tokens: &mut TokenStream) {
>          tokens.extend([self.clone()]);
> @@ -40,7 +46,7 @@ fn to_tokens(&self, tokens: &mut TokenStream) {
>  /// `quote` crate but provides only just enough functionality needed by the current `macros` crate.
>  macro_rules! quote_spanned {
>      ($span:expr => $($tt:tt)*) => {{
> -        let mut tokens;
> +        let mut tokens: ::std::vec::Vec<::proc_macro::TokenTree>;
>          #[allow(clippy::vec_init_then_push)]
>          {
>              tokens = ::std::vec::Vec::new();
> @@ -65,7 +71,8 @@ macro_rules! quote_spanned {
>          quote_spanned!(@proc $v $span $($tt)*);
>      };
>      (@proc $v:ident $span:ident ( $($inner:tt)* ) $($tt:tt)*) => {
> -        let mut tokens = ::std::vec::Vec::new();
> +        #[allow(unused_mut)]
> +        let mut tokens = ::std::vec::Vec::<::proc_macro::TokenTree>::new();
>          quote_spanned!(@proc tokens $span $($inner)*);
>          $v.push(::proc_macro::TokenTree::Group(::proc_macro::Group::new(
>              ::proc_macro::Delimiter::Parenthesis,
> @@ -136,6 +143,16 @@ macro_rules! quote_spanned {
>          ));
>          quote_spanned!(@proc $v $span $($tt)*);
>      };
> +    (@proc $v:ident $span:ident = $($tt:tt)*) => {
> +        $v.push(::proc_macro::TokenTree::Punct(
> +                ::proc_macro::Punct::new('=', ::proc_macro::Spacing::Alone)
> +        ));
> +        quote_spanned!(@proc $v $span $($tt)*);
> +    };
> +    (@proc $v:ident $span:ident _ $($tt:tt)*) => {
> +        $v.push(::proc_macro::TokenTree::Ident(::proc_macro::Ident::new("_", $span)));
> +        quote_spanned!(@proc $v $span $($tt)*);
> +    };
>      (@proc $v:ident $span:ident $id:ident $($tt:tt)*) => {
>          $v.push(::proc_macro::TokenTree::Ident(::proc_macro::Ident::new(stringify!($id), $span)));
>          quote_spanned!(@proc $v $span $($tt)*);

The update to `impl ToTokens for TokenTree` should be split out in a
separate patch and should carry some explanation of the change.


Best regards,
Andreas Hindborg



