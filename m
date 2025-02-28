Return-Path: <linux-kernel+bounces-538819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 916BAA49D69
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 16:27:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3B641652A2
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 15:26:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C395926FD9F;
	Fri, 28 Feb 2025 15:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bNy1MWvO"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BB5B1EF38E;
	Fri, 28 Feb 2025 15:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740756382; cv=none; b=ilcW8T+boBNOdnhFfkl37GsoRmKLYzXML6flibrwrGUytzmSkiVTeFisccSqt8JYhKpO8rUkpSDs/OnVHSzIP6H3bGXIPM7s1Dpd4a55m2NwZnXNpDl0mI+WbQUgZMigdmM4q+2Jo2RGHzNW0bdW5tuNrfRK17vxw9wP6yO+jfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740756382; c=relaxed/simple;
	bh=7yaPiSSI0H2XW8n+W3H4u1sCDyU6Zd1qZoVLZbGxd8I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EenbJqe3zSTCf8/NhLSRDIWSbfVlgRG3RO1iFJ8hwC7dj/BY/Jg+Uub+Nw5SUvaKaBa08eW18bnTNsQKz7cll/uPji9o9H2qyO5q4XkWyh+xQ/tuPZNDsa5ftpQevheL3lUiHoyyUokc5us7dXbb0zc5ZeH1Bi7tqtztyMf2B90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bNy1MWvO; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-3061513d353so23672751fa.2;
        Fri, 28 Feb 2025 07:26:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740756378; x=1741361178; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sQEzC2j8pg6sUrIixsw7/ei5GObidVE1c76DSZgQvMA=;
        b=bNy1MWvOOosK5PtV2E0wGI3NitduxSmuEDUJ1LmbmT80pGXRZX1wQtiYszqYxh/QTG
         IPTAyA63ubaGZCzAvz71obF3WemHJwoUehhxn/n0z1K4M9BcrLwAf2jTTS/4lQYdmEuA
         WGBvPyCoDbPAcOMvAhb+k954G+rG/de/HikDIQTFMEVBbcN9+Jm3nJQRRVyq7e4lUp16
         yc7OgjYDoBkd5WLpjEP5In1zy9RSf58BeEkODm5J/g3yP8gRa4ZTSngo9Mb35xw9lO1C
         M1sMn6g3YpxIzob+wJHgacYpy/QRNsPmkREOiKIvtPgc5icEymUNEGzWl3fS74TaDd/k
         1ZNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740756378; x=1741361178;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sQEzC2j8pg6sUrIixsw7/ei5GObidVE1c76DSZgQvMA=;
        b=wcNfBwOg9UZgv5qlwSBYs5ZDiysdb/Koq6WsYlTbwRlegdZ5rKU2pKym5f5FfkC0YZ
         8f1VslchhXq/UKe5a0EC70YEvDciuZwjmphj9mqQN17XlQlNgpcnrtu4nnPHf+l9/mU5
         10BXwijPG2oVblMla94ZbpqmaUEJeSGi/ZwpReg9tQYa6KmD+bQpjzE9ayiwaxTVGrMG
         Y+ObjlvnPb1+zwxYx2lYpvWc8WKRROAV3vHWbUcYV+2xZqrlaVsB/+n4r2untnBoCxuG
         4sjn23nDur2xvo0N/wWHPTs9itxqbIxfJGNtSZZGucT/7fgLPnnxtmDcXflPTFdlfUFY
         /C7w==
X-Forwarded-Encrypted: i=1; AJvYcCVR2rQ6gVvY86kIGDqzuT+c4T7+YVQu6y3lGE6ln8NozbUeF1AbLaDNAGPGyv1duItXYLV8ARNt3ajwUcT/Zwk=@vger.kernel.org, AJvYcCWWz91iZnF4mx932qsgGI8suo7NLFm0/LIBYR0hIn642OsXV3OAJskPhbPKNE8WGJCgV2o+fOEyc6PH5PM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4zhqlMa91N/CKjRb88JZHQPh1PDxMf6nK/b/m01iGpYpvll+7
	WHzTN+aR19LOFmvtWFv+rwpd/h20Oex/fKX2C9Ag/voEmLzfePAuxkstixyWIaMiYZqFU5wo4jK
	Ax7D/67FKeBW9vGU9qbTRpMCGPpk=
X-Gm-Gg: ASbGnct3a9YB4uO2tEX1F42A1SwOdbLmnV+3rlLa7TJjctE8T11jh/IZNEz9uIwIrSg
	guxgSoelN+PMbXXdVn0vzxy7eNUWrcPNuuuZhFNsEXsyfc3dGgjCFm3P9slBY2NZgey5yRlM0ND
	BSt9ESwn3mdR9bwEfrSZrrCwnBLgmUdJhutUkr+NIY
X-Google-Smtp-Source: AGHT+IEeeY1j83AEsNh8WhsygLXPj8O1jjT1aI0TaV+Ap8nu6lHEh2ES40t+f+bMf9+oSYWFTfFGKwhKrpXchbIKRa8=
X-Received: by 2002:a05:651c:2221:b0:30b:8ef2:161d with SMTP id
 38308e7fff4ca-30b9325a121mr16636211fa.18.1740756378205; Fri, 28 Feb 2025
 07:26:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250228-export-macro-v2-0-569cc7e8926c@google.com> <20250228-export-macro-v2-2-569cc7e8926c@google.com>
In-Reply-To: <20250228-export-macro-v2-2-569cc7e8926c@google.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Fri, 28 Feb 2025 10:25:40 -0500
X-Gm-Features: AQ5f1Jq4xHWMjB-Z0ayoaooc4oG9WsypYkgFp2QgRFRS7rFpCWPZvPbMiNGEReE
Message-ID: <CAJ-ks9nn1_gAqz9f3H9O47QA7dwk5MaT5YK3NQtZtUJHyNXbVg@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] rust: macros: support additional tokens in quote!
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

On Fri, Feb 28, 2025 at 7:42=E2=80=AFAM Alice Ryhl <aliceryhl@google.com> w=
rote:
>
> This gives the quote! macro support for the following additional tokens:
>
> * The =3D token.
> * The _ token.
> * Using #my_var with variables of type Ident.
>
> Additionally, some type annotations are added to allow cases where
> groups are empty. For example, quote! does support () in the input, but
> only when it is *not* empty. When it is empty, the compiler cannot infer
> the item type of `tokens`.
>
> These additional quote! features are used by a new proc macro that
> generates code looking like this:
>
>         const _: () =3D {
>             if true {
>                 ::kernel::bindings::#name
>             } else {
>                 #name
>             };
>         };
>
> where #name has type Ident.
>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
>  rust/macros/quote.rs | 21 +++++++++++++++++++--
>  1 file changed, 19 insertions(+), 2 deletions(-)
>
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
>  /// `quote` crate but provides only just enough functionality needed by =
the current `macros` crate.
>  macro_rules! quote_spanned {
>      ($span:expr =3D> $($tt:tt)*) =3D> {{
> -        let mut tokens;
> +        let mut tokens: ::std::vec::Vec<::proc_macro::TokenTree>;
>          #[allow(clippy::vec_init_then_push)]
>          {
>              tokens =3D ::std::vec::Vec::new();
> @@ -65,7 +71,8 @@ macro_rules! quote_spanned {
>          quote_spanned!(@proc $v $span $($tt)*);
>      };
>      (@proc $v:ident $span:ident ( $($inner:tt)* ) $($tt:tt)*) =3D> {
> -        let mut tokens =3D ::std::vec::Vec::new();
> +        #[allow(unused_mut)]

It'd be nice to mention the need for this attribute in the commit
message along with the added type annotations.

> +        let mut tokens =3D ::std::vec::Vec::<::proc_macro::TokenTree>::n=
ew();
>          quote_spanned!(@proc tokens $span $($inner)*);
>          $v.push(::proc_macro::TokenTree::Group(::proc_macro::Group::new(
>              ::proc_macro::Delimiter::Parenthesis,
> @@ -136,6 +143,16 @@ macro_rules! quote_spanned {
>          ));
>          quote_spanned!(@proc $v $span $($tt)*);
>      };
> +    (@proc $v:ident $span:ident =3D $($tt:tt)*) =3D> {
> +        $v.push(::proc_macro::TokenTree::Punct(
> +                ::proc_macro::Punct::new('=3D', ::proc_macro::Spacing::A=
lone)
> +        ));
> +        quote_spanned!(@proc $v $span $($tt)*);
> +    };
> +    (@proc $v:ident $span:ident _ $($tt:tt)*) =3D> {
> +        $v.push(::proc_macro::TokenTree::Ident(::proc_macro::Ident::new(=
"_", $span)));
> +        quote_spanned!(@proc $v $span $($tt)*);
> +    };
>      (@proc $v:ident $span:ident $id:ident $($tt:tt)*) =3D> {
>          $v.push(::proc_macro::TokenTree::Ident(::proc_macro::Ident::new(=
stringify!($id), $span)));
>          quote_spanned!(@proc $v $span $($tt)*);
>
> --
> 2.48.1.711.g2feabab25a-goog

Reviewed-by: Tamir Duberstein <tamird@gmail.com>

