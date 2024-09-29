Return-Path: <linux-kernel+bounces-342800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F043598931D
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 07:03:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF35C2858E0
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 05:03:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 651D57EEFD;
	Sun, 29 Sep 2024 05:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="d2Bd+dFG"
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C3B225D9
	for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2024 05:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727586195; cv=none; b=UFuO2ChXBxGEhP7S+rVnicqP6H98FOTuFbxPbKGlFdJuAX8Yey6X+wDdQDaDAGv0ERCA9RcN/Mg+a6XtkndMss6YKL1GXaLdNIDeSoZ6HpsMNGmhBiKaNolvjEPfrDI8nG97eXLy+MEn4IkqFWeyBIBtCF7iOz8di0uXmrxwGy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727586195; c=relaxed/simple;
	bh=MBBs2gBB1cs7jAj7EozRTGzyrlscYTocqcXOG2eQawU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZLypcurmqptfNiv9W3JwZQQ/jULVmWXSbJil0OLBhjYwzyWPEyJnvycd7XXMETXvTgdXEhZ07nS5apDyTyVLnvLYdjEsTQZeXjGyno0S1psXr7lv7TnIpW5/x/nwMHHrKHLVAOkDcfLx/YmfnZf/q4cjU2wUAGOLTlnAohLJ9GY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=umich.edu; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=d2Bd+dFG; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=umich.edu
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-6dbc9a60480so27609277b3.0
        for <linux-kernel@vger.kernel.org>; Sat, 28 Sep 2024 22:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1727586193; x=1728190993; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T4fJ3od1/Qv1njknmjb1VUvECYnufqLrw2fjOCobJsA=;
        b=d2Bd+dFGN+yqxUBREV2q8DhakY6tDe1Q8FK46y3VteYr/UzMvaAqyvww2RFNj5smYq
         WGv0WXnZBZu1JVTIKb/fxRKM1J/X4oBLKBrpUOkUQDdJ+s6nxiUG6ieEiYLVh/QTH/gQ
         AmYDdVwz1XcyILvs0IV5GFajDeg31LR1tji9PUtJT/0eqOKUN0FqJ6Mjo2mfvSUsn9I7
         1hZ4n0ZZ2i05AHBaXI7Lk8VpKlCDfiKvUMZsxxvcKDC/H1EiY/ZNj60kUPQBXl1EsnyB
         tjU/iqqxpdoita3Cth8rgWmhtiHeA/jAnq5rqcO07cgCkYlkRq9jWjhSN8hdqNtHsM0E
         C/8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727586193; x=1728190993;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T4fJ3od1/Qv1njknmjb1VUvECYnufqLrw2fjOCobJsA=;
        b=SgAcx9tiElTKUG9WUHxtNerxqIMT9RHAx3DZg0DuwqH6MJNQPJeTuwJpjc4XxArAq2
         tCRVLPtIZX3SjTU6s171xo6SwSDJXqOV31cZE5+Jc4XUeEOjiRWnZJ87FCE9bKih0qiq
         qAs168aJentVUn2ccMt125N9TQD2/q/ye0Ub60BJskKw4QkI6XRDQRGvG+FfjrbYc6ta
         aKRDwKA2NsHGUVhclcn6p4AeLP+2xQL+sKhDF3lV0mc3Kn4CZschGZTS38ncoHSmYTR0
         YXFbqw9wJjNjfXJs88S9T7q8O/y7/4bR3j3BLkuvuxWRi03tTPS86Wq7/VfU92xy6WqP
         1LrQ==
X-Forwarded-Encrypted: i=1; AJvYcCWFnjV0r2Jsrdo9sHzx/MJEkG6YJf+/CEgWEPSJqDvsJGx2yopyBLMymQoGYNW1CWVEmIpZPcMs/r20u0g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx37vZ6INXS20Ph9vOpJIkEHogc27lo0rbgW5rYbvKPTJp1U5+/
	oOBrKSL6rHDHgqLF7RKsLN2yS+Haujjps3A9UqKkQwwNXAl49ojf71LpT+DFN7kPAYJPwSxZdpL
	3qm/em2jJN6hzPJOvuh2z88w5yGqQTf7YbMjccg==
X-Google-Smtp-Source: AGHT+IGFGA2ibiacUm5SY6v/Uk0BKQDc1zVikRtFuWauzKWc3ornt2i9Ow+fpFE8fh1RyZtr7swqV66pd31i/h5zmXg=
X-Received: by 2002:a05:690c:3385:b0:6d0:f91e:2ff0 with SMTP id
 00721157ae682-6e24751f3ecmr63818057b3.11.1727586192644; Sat, 28 Sep 2024
 22:03:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240904204347.168520-1-ojeda@kernel.org> <20240904204347.168520-17-ojeda@kernel.org>
In-Reply-To: <20240904204347.168520-17-ojeda@kernel.org>
From: Trevor Gross <tmgross@umich.edu>
Date: Sun, 29 Sep 2024 01:03:01 -0400
Message-ID: <CALNs47s=kCJUJstB4WW1KF_b55-e1kYQ_1rZjPu=LWxv2gmF3w@mail.gmail.com>
Subject: Re: [PATCH 16/19] Documentation: rust: add coding guidelines on lints
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Alice Ryhl <aliceryhl@google.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 4, 2024 at 4:45=E2=80=AFPM Miguel Ojeda <ojeda@kernel.org> wrot=
e:
>
> In the C side, disabling diagnostics locally, i.e. within the source code=
,
> is rare (at least in the kernel). Sometimes warnings are manipulated
> via the flags at the translation unit level, but that is about it.
>
> In Rust, it is easier to change locally the "level" of lints
> (e.g. allowing them locally). In turn, this means it is easier to
> globally enable more lints that may trigger a few false positives here
> and there that need to be allowed ocally, but that generally can spot
> issues or bugs.

s/ocally/locally

> Thus document this.
>
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
> ---
>  Documentation/rust/coding-guidelines.rst | 29 ++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
>
> diff --git a/Documentation/rust/coding-guidelines.rst b/Documentation/rus=
t/coding-guidelines.rst
> index 05542840b16c..185d3b51117d 100644
> --- a/Documentation/rust/coding-guidelines.rst
> +++ b/Documentation/rust/coding-guidelines.rst
> @@ -227,3 +227,32 @@ The equivalent in Rust may look like (ignoring docum=
entation):
>  That is, the equivalent of ``GPIO_LINE_DIRECTION_IN`` would be referred =
to as
>  ``gpio::LineDirection::In``. In particular, it should not be named
>  ``gpio::gpio_line_direction::GPIO_LINE_DIRECTION_IN``.
> +
> +
> +Lints
> +-----
> +
> +In Rust, it is possible to ``allow`` particular warnings (diagnostics, l=
ints)
> +locally, making the compiler ignore instances of a given warning within =
a given
> +function, module, block, etc.
> +
> +It is similar to ``#pragma GCC diagnostic push`` + ``ignored`` + ``pop``=
 in C:
> +
> +.. code-block:: c
> +
> +       #pragma GCC diagnostic push
> +       #pragma GCC diagnostic ignored "-Wunused-function"
> +       static void f(void) {}
> +       #pragma GCC diagnostic pop
> +
> +But way less verbose:
> +
> +.. code-block:: rust
> +
> +       #[allow(dead_code)]
> +       fn f() {}
> +
> +By that virtue, it makes it possible to comfortably enable more diagnost=
ics by
> +default (i.e. outside ``W=3D`` levels). In particular, those that may ha=
ve some
> +false positives but that are otherwise quite useful to keep enabled to c=
atch
> +potential mistakes.

It may be good to link to the docs on this,
https://doc.rust-lang.org/stable/reference/attributes/diagnostics.html.
Either way:

Reviewed-by: Trevor Gross <tmgross@umich.edu>

