Return-Path: <linux-kernel+bounces-422754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73D1B9D9DB8
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 20:00:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33B8A28633D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 19:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40A901DDC38;
	Tue, 26 Nov 2024 19:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eHwP+1gW"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24E2C16F0E8;
	Tue, 26 Nov 2024 19:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732647644; cv=none; b=tZkXlgP8KlcmOk1nUUg2CYWvzyPw4H+U1JErebilFjcrnYdepVQAO2MnGLl22uYDbUp7KSBsTsi1jztNrKAnVMxBgVLB0QQiZPyqYDNQnHj7JNoM7J/cY5xlwmmaVFEJqznIaxsp2KJOya2UX2sL/waeLz0bvPXRdyzYxaQBJpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732647644; c=relaxed/simple;
	bh=ShGtLWnLNTO8dfsK/CLQkx1/jwvnZA4xXxzrEz2kuc8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RGKTTPR4ut2zf4ng/3oVT8ZcDaVFsx8z6NibXicnDYQQIsGrbjkxJ1jRVk2F0HRnJjcv08jjsfTOcVoWqKisfxawvZOJ7Roz5Pyyhg1gK34l6JHvB022qI0KXQZJZIm8wEgnOEVWtD3AdvkFb74rUWbBfBt13DqUu9n3Ftsw2Ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eHwP+1gW; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2edbe217f00so467263a91.3;
        Tue, 26 Nov 2024 11:00:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732647642; x=1733252442; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/1zcxZNwaduhu/+AJ3yyj47HY6AKBwCWFNYHlvADAGQ=;
        b=eHwP+1gWsiqEozUv/6dIZiD1UUH1OZZaq17fDeJabxa0+trJrvRXZ94UL8nTc6lqER
         i1ivhnUUFAm+VDlOzIKCSolC7vgQEWJNt7Occ2wxuwEY25iow8IiQwTj+1v0hzPGUiyw
         qDzAp5QJXLFfVjzaT0MIDg/gkLa76sL/UobmMmemJtDmLEn0JUGqWp0iNUIQQM6DDDyh
         /Js6WTaFYARkQZ8t9zbYztd7hBBNgyoBM0na+eOrhNsTvXv7tOQF2XLkED2gw4NlYjNn
         gSBTqo3QpAej9OXZKPO2CDOpK+lXfZ2z0HfAgKVYjazsRy2w1jZBk1JmoAW7urKivn3b
         KDsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732647642; x=1733252442;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/1zcxZNwaduhu/+AJ3yyj47HY6AKBwCWFNYHlvADAGQ=;
        b=huc+FVRaOBxQH/BIgRoLEi+3ZPsRDXBIyIf6CBWWJnObwNn45tLFI+aokCV7NETIC8
         7Wms4MqYCqy5HQ2F/mdQ6IQGA42bgFQgGYF5XLmhvYtGlq5IKNnIwzVP+7ylKMaQsvLC
         8opu3RAgLNY55RxlFOBgVDKnIJlwAehg/u0qsbwNP4XhRShD7CgTTtq07Hoe6JuigmX+
         ATI1Zg/VSMSMr2JIgjCnKl6hyjz1bef7Db9axmmIXvFaO2bO5NQADT4dt7iC6FeD6FfY
         t1cxRFWt+5BA7iN7b5ltR//ua4Mr9MHeJdRMhO7oiMLcN5hB+IRN5ni+GKU9ICoDVWwu
         Dx1g==
X-Forwarded-Encrypted: i=1; AJvYcCVHl28/uWrKU6InJzaP1+OWtNX+fL59F1mKcizNuc3kwJxTW8Y64jFzHA3lTkcP1IAgzm0BWYckEN47qFw=@vger.kernel.org, AJvYcCWZmudipcUEx7VEg2oInmRjUj8Nki/zXJZF2yG4acd40awdrBEK9nMpfes/Vlu9+CGvEfALdmxjtO90oAf7vRM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0Nh+yEgwGtSIVeofq9tLTrlX+O0vwRt1k/rQJbxIJvG+PF+Pi
	ltn8pq2tZSrb3CTMRKrFBoxRuwjzowDsb67eH4P3aPuwOrTgjpF6vAiCKB3yhYo9VSRE/jpZuUF
	qdCaNMd6WwxRAYbFqCAuo4eUkZyM=
X-Gm-Gg: ASbGncvg/TqaqbJJL2VBnX/aIOKYfp0twF6roYWYi6/QExLTXcNjyfc+8kBys9Jc0bg
	JqEbnavbfwlZvfFbNJAYR00KuX7Y1xGk=
X-Google-Smtp-Source: AGHT+IH8awhBTUFrN4H3TSWDsh28vbzQETnv5D5N9/KNNhHuxQbom05tM/U4o2rBOxGRjYunVVBn9w7CS0gpl9cN6KM=
X-Received: by 2002:a17:90b:4a06:b0:2eb:12ee:cf0b with SMTP id
 98e67ed59e1d1-2ee08e9fab7mr188876a91.1.1732647642238; Tue, 26 Nov 2024
 11:00:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241126-pr_once_macros-v4-0-410b8ca9643e@tuta.io> <20241126-pr_once_macros-v4-1-410b8ca9643e@tuta.io>
In-Reply-To: <20241126-pr_once_macros-v4-1-410b8ca9643e@tuta.io>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 26 Nov 2024 20:00:29 +0100
Message-ID: <CANiq72kpohLie_23sMQm6h-Cq6wiqqvFfwSsAdi4x760kCisoA@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] rust: Add `OnceLite` for executing code once
To: jens.korinth@tuta.io
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, 
	FUJITA Tomonori <fujita.tomonori@gmail.com>, Dirk Behme <dirk.behme@gmail.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 26, 2024 at 5:41=E2=80=AFPM Jens Korinth via B4 Relay
<devnull+jens.korinth.tuta.io@kernel.org> wrote:
>
> Similar to `Once` in Rust's standard library, but with the same
> non-blocking behavior as the kernel's `DO_ONCE_LITE` macro. Abstraction
> allows easy replacement of the underlying sync mechanisms, see
>
> https://lore.kernel.org/rust-for-linux/20241109-pr_once_macros-v3-0-6beb2=
4e0cac8@tuta.io/.

Nit: you could use a Link tag for this, e.g.

Link: https://lore.kernel.org/rust-for-linux/20241109-pr_once_macros-v3-0-6=
beb24e0cac8@tuta.io/
[1]

And then you can refer to it using [1], like "see [1].".

> +//! This primitive is meant to be used to execute code only once. It is
> +//! similar in design to Rust's
> +//! [`std::sync:Once`](https://doc.rust-lang.org/std/sync/struct.Once.ht=
ml),

In one case you used a shortcut reference link for this -- perhaps you
could do that here and below.

> +//! but borrowing the non-blocking mechanism used in the kernel's
> +//! [`DO_ONCE_LITE`] macro.

I would suggest mentioning C here, e.g. C macro, to reduce ambiguity
(it is true we have just used "kernel's" in some cases).

> +//! An example use case would be to print a message only the first time.

Ideally we would mention one or two concrete use cases here, e.g. you
could grep to see a couple common C use cases.

Also, since we are going to have the `pr_..._once` macros, it may not
be the best example use case, since the developer would use those
instead, right?

The docs look well-formatted etc., so thanks for taking the time writing th=
em :)

> +/// A low-level synchronization primitive for one-time global execution.

I wonder if we should move part of the docs from the module level here
to avoid duplication.

> +/// macro. The Rust macro `do_once_lite` replacing it uses `OnceLite`

Please link these with intra-doc links.

> +/// ```rust

You can remove `rust` from this one, like in the others.

> +/// static START: kernel::once_lite::OnceLite =3D
> +///     kernel::once_lite::OnceLite::new();

I would have a hidden `use` line to simplify the example -- since we
are reading the example about this item, it is OK to shorten it here,
e.g.

    static START: OnceLite =3D OnceLite::new();

> +///   // run initialization here

Please use the usual comment style: "Run initialization here.".

> +/// while !START.is_completed() { /* busy wait */ }

Hmm... without threads this looks a bit strange.

> +    /// Creates a new `OnceLite` value.

Please use intra-doc links wherever possible.

> +    /// This method will _not_ block the calling thread if another

Should we save "does _not_ ... regardless ..."? i.e. it never blocks.

> +    /// [`std::sync::Once`], but identical to the way the implementation=
 of
> +    /// the kernel's [`DO_ONCE_LITE_IF`] macro is behaving at the time o=
f
> +    /// writing.

"at the time of writing" is implicit, so we don't need to say it.

(Of course, it would be nice to have someone making sure we don't get
out of sync!

> +/// Executes code only once.

"an expression" or "a Rust expression" could perhaps be more precise
and hints what the argument is (which may help those not accustomed to
macro signatures).

> +/// kernel::do_once_lite!((||{x =3D 42;})());

Please format the examples if possible. Not a big deal, but it is always ni=
cer.

Can we add an `assert` here too like in the other examples, so that
this doubles as a test?

By the way, does this need to be an immediately called closure? i.e.
the macro takes an expression, can't we do e.g.

    do_once_lite!(x =3D 42);

?

> +        #[link_section =3D ".data.once"]
> +        static ONCE: $crate::once_lite::OnceLite =3D $crate::once_lite::=
OnceLite::new();

I let Boqun et al. review the sync parts, but a few questions: Do we
want/need two `AtomicBool`s? Should the docs for `OnceLite`
mention/suggest `link_section`? Should we have a macro to declare them
instead?

By the way, please test with `CLIPPY=3D1`, I got `new_without_default`.

Cheers,
Miguel

