Return-Path: <linux-kernel+bounces-541154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 18625A4B959
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 09:31:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9083C3AB295
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 08:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAA231EF099;
	Mon,  3 Mar 2025 08:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JkG+ewZL"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DFA71C8FB5
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 08:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740990497; cv=none; b=FgucKuVRJC+DmPtkg13vIXmUSXfghE38qXol7wW5eATmdb66p28NaxUrGjAxj2FDm2lt2ujwtoLCpxB/8hbfu/E6KXKpKAFi8AluGwJpAeOcp7GZdHopJBxoVXhP+lDdJ+XnppthvCe5e6opr3hBpbMlxi6utEAPqeD36Vh1KYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740990497; c=relaxed/simple;
	bh=lRmX3N1C+LM4n4qOw6aMES+ET/YFvMicl8riRqpvkCI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i/7PaLbBYF3/NAcfyyUNOi4lygyXJZobNDTtpQHIx07go+sPWLAPDV/v0V8JYP+ef426j2TIr6CuYHb9d6Z5FHpAN7WOu+hTSnznyPM2JRepcWvLGUTY+eMyWyflGigNmLJLZ5UmEzJxKeM+JzV30DYigzK+qU3yzaYJ3hq4/vE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JkG+ewZL; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43948f77f1aso26310655e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 00:28:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740990492; x=1741595292; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gLvDvN37rSZdD6m86XjZbKgQ5aDQc83ylMnqHwB2npw=;
        b=JkG+ewZLm7TH+wsAxlsdrCluT51JoNSyv7o59yJshiwmoHzoNxa6Dhq6sTU1BAqQhA
         wZ+xqvp3b/9ZGEBQh3pqjawMAEMZrEGAx/Tdg/7pCczxVFI78MPhO/Qo1URR2dFFrc5H
         nM5wnAzRlaBl+do4yCkJU92vmrHznIUK+u/rM25cs7vabAqFdUEXmY4vt2JY4HxMKUsf
         0dpchgwtDcya8AHMYi97DvCRfq+oAXhgBLXULIVWXv+hBkpVqPJvC5E6r0ZLjQpRAe4z
         JQOGr7qIkyf+XUYcJAHG1TkDMtqpGNwN72fO+80kV/ifH5tyzJ3lp97EebahW3KPMThq
         Zrzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740990492; x=1741595292;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gLvDvN37rSZdD6m86XjZbKgQ5aDQc83ylMnqHwB2npw=;
        b=Gky3FlF53ThaJIt0/qSW/rcPsiu8GR2dhMLQm2g0cxNIb0QZhbr5he5WuX57+zn7Ze
         2iRtOCPYGyqrhneqljrKjaegxwNN/qg8YoClIzSrxNFw1wml1ihcrdTwlehlxeXhsfzm
         0BMw1aCpLWVlext/8u7VeRg05PNv/MInAokM4KZBdJAu28EbMwvYt4RY8rdubwOcS//v
         30EKBl+r6wI80VCbiK9Kpq/rrbFmRKOlGrsZ3d3Sb4ykRhCcJFUFGQEtjPopmHUVhUKB
         8JEZXoz1L/M/S1oaaAX3nlV4kHIeStdunR+UqJqZNcrBPYQYPLpNEAFQrpEDTQ2tDCVo
         XiHw==
X-Forwarded-Encrypted: i=1; AJvYcCUaU7Zwymple/vhoGjYslOEHtnysQaXc8RuZJCjYbkwBljjBFA0U1lySc4/NolCfKCq1UsOtSo6NYylIj8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyk9s+NZJqz0pEPOMq2UiMu3gX/Ua1w3jrlf4Mhz3LISpjIq/RU
	UEUQp9y+MRoHBQ1e3jaP+xXc7F1rMbiRiUXxZ+GsYmwfxiRUyM6f9cRYjVSmCsaxMJqVSv1L7M+
	vSFwD/jgo/8P12Wyg4B/VfLp+c3dW4v2yxiwi
X-Gm-Gg: ASbGncu6oXl2NCYhK4Mvv0ky+KWrfenZEN2uXJvA7fWkHRd0YfPCTN9QnByZo4KMSZq
	OdP4RaMUpbtsochroZwJyMZy37h8kWMtks9Oq20L3/M56wnHV0ebVjGaRXhzWCwCV8qt+GfQ2nY
	Stlt27kJNUKGVff9lmkPrz76MxvihmP+QenQKrJyQgyW8Fimal0FzmbmzJ
X-Google-Smtp-Source: AGHT+IHnj4KwcJwR4hqqqZ0/9sOxcRdaZsnmJP5IDASm2FTMhGCue7uJvacKssbH0SCdqUWPbng41JGRR50dPvmLyKs=
X-Received: by 2002:a05:6000:156d:b0:38f:5057:5810 with SMTP id
 ffacd0b85a97d-390ec7d1e40mr10547737f8f.25.1740990492516; Mon, 03 Mar 2025
 00:28:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250228-export-macro-v2-0-569cc7e8926c@google.com>
 <20250228-export-macro-v2-3-569cc7e8926c@google.com> <CAJ-ks9ng6AqmDynFebR+2_ZEpmvxkUNWdTed2vr0kede0dxcxw@mail.gmail.com>
In-Reply-To: <CAJ-ks9ng6AqmDynFebR+2_ZEpmvxkUNWdTed2vr0kede0dxcxw@mail.gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 3 Mar 2025 09:28:00 +0100
X-Gm-Features: AQ5f1Jp_z3J9oogrNYre-GB0tMVaV9ocvNHvETVAolm9W0Emv57UL3K3-UTPtKA
Message-ID: <CAH5fLgj6jQ9Ga2HMqXF3bypxy4qA-wgrfQx2htq0k=V0jfNMpQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] rust: add #[export] macro
To: Tamir Duberstein <tamird@gmail.com>
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

On Fri, Feb 28, 2025 at 4:40=E2=80=AFPM Tamir Duberstein <tamird@gmail.com>=
 wrote:
>
> On Fri, Feb 28, 2025 at 7:40=E2=80=AFAM Alice Ryhl <aliceryhl@google.com>=
 wrote:
> >
> > Rust has two different tools for generating function declarations to
> > call across the FFI boundary:
> >
> > * bindgen. Generates Rust declarations from a C header.
> > * cbindgen. Generates C headers from Rust declarations.
> >
> > In the kernel, we only use bindgen. This is because cbindgen assumes a
> > cargo-based buildsystem, so it is not compatible with the kernel's buil=
d
> > system. This means that when C code calls a Rust function by name, its
> > signature must be duplicated in both Rust code and a C header, and the
> > signature needs to be kept in sync manually.
>
> This needs an update given Miguel's comments on the cover letter. I
> wonder if the code should also justify the choice (over cbindgen).

Will do.

> > +/// Please see [`crate::export`] for documentation.
> > +pub(crate) fn export(_attr: TokenStream, ts: TokenStream) -> TokenStre=
am {
> > +    let Some(name) =3D function_name(ts.clone()) else {
> > +        return "::core::compile_error!(\"The #[export] attribute must =
be used on a function.\");"
> > +            .parse::<TokenStream>()
> > +            .unwrap();
> > +    };
>
> Could you also show in the commit message what this error looks like
> when the macro is misused?

It looks like this:

error: The #[export] attribute must be used on a function.
   --> <linux>/rust/kernel/lib.rs:241:1
    |
241 | #[export]
    | ^^^^^^^^^
    |
    =3D note: this error originates in the attribute macro `export` (in
Nightly builds, run with -Z macro-backtrace for more info)

But I don't really think it's very useful to include this in the commit mes=
sage.

> > +    let no_mangle =3D "#[no_mangle]".parse::<TokenStream>().unwrap();
>
> Would this be simpler as `let no_mangle =3D quote!("#[no_mangle]");`?

I'll do that. It requires adding the # token to the previous commit.

> > +/// This macro is *not* the same as the C macros `EXPORT_SYMBOL_*`, si=
nce all Rust symbols are
> > +/// currently automatically exported with `EXPORT_SYMBOL_GPL`.
>
> nit: "since" implies causation, which isn't the case, I think.
> Consider if ", since" can be replaced with a semicolon.

Will reword.

> > +#[proc_macro_attribute]
> > +pub fn export(attr: TokenStream, ts: TokenStream) -> TokenStream {
> > +    export::export(attr, ts)
> > +}
> > +
> >  /// Concatenate two identifiers.
> >  ///
> >  /// This is useful in macros that need to declare or reference items w=
ith names
> >
> > --
> > 2.48.1.711.g2feabab25a-goog
>
> Minor comments.
>
> Reviewed-by: Tamir Duberstein <tamird@gmail.com>

Thanks!

Alice

