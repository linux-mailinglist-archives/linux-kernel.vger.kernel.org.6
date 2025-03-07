Return-Path: <linux-kernel+bounces-551147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7510A568A8
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 14:17:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D95C3178C7F
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 13:17:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D9FB21A457;
	Fri,  7 Mar 2025 13:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ad0A0b+R"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09430219E98;
	Fri,  7 Mar 2025 13:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741353412; cv=none; b=BxAvROvY+fCXhzrtWFFon/kRTPGpVoyLKZgTqXHtYa47O2YPCKtgj5iVjc2HbNWoH2Ft7L7e13l2wQ0ONwesH22Fb73EgVURKhCSqBLyV6+Ul8WeTCYvOnSUOKFGTgDZYcU2cw0Rd0BSlPJdelFTz3XqYbiwOtJnYjoGlHPJUB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741353412; c=relaxed/simple;
	bh=KhHFg/yYHEpPx6jwk72aez/mBITw3rcb4aBawBYbT2U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RWsoMDaGESHv8mw1z8Bq9DF5QnygsPwh5EdFOHS8RsUb/dxW8vF/t57I77AGNGlhOo2RFGRKMMSGDlKpAPHhkZNVdWU9BMHGQ5v0cHSkAULoFWhWr3fo7Ax65wO8AOg94R5x+GVvfdNrdTYrj7/fmOJYWGGIFC5vdHHG0PqXzo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ad0A0b+R; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-30bf9edec80so196211fa.2;
        Fri, 07 Mar 2025 05:16:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741353409; x=1741958209; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y3VQ9ytoeNOJ8T6SK+bKHMm3Z64Rc/dAgHBqXQ0/v/s=;
        b=ad0A0b+RPRR5nrM7hGg9FTerwzYpXBaBoTMRTGWpf+PIJFJ7v2tB+IBJPVSMq7UcOt
         IqmApdTmCPxEMxiGxWZkWSGdwld31+ZpNE8MHy1vNtgmv2ScYXwP+LgAsV4uDWN1+H62
         iBDCp+ju8DNZ0mvlsed5lOqdBb+VJXPHl1l4llqS2L08pLrERgXfjUZat6lZ3nxAEQru
         F95BNlosNhkUMQdC/QsugNLA6geruzerodatAuk86G+82s8XnU93oP8RURo4VOlYyDcx
         NqdE6xOjPa/x9oH6AfO6ASIkHkkke2bVvot8CdXQfdQce1oM/n0TvVJfC6j93ezBbiji
         2zGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741353409; x=1741958209;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y3VQ9ytoeNOJ8T6SK+bKHMm3Z64Rc/dAgHBqXQ0/v/s=;
        b=XzmbPEqS7vHnVXiL8FeSvyuAET6heSqlb5dy4SNt5WpPn5UZIGCyG4TKgfHeY6EAbV
         tzIWf3TZgD1tKBvJsQwutAtVKBMnXSAdHr4wB8rZf7+d1zGi3ZeEbHodNVFaoiBpsL1l
         BB5bfOMzN6tTUR24zYXM7Ybn9l2qgAmK7TYmRq8gSJ/kkE1InLFFqDoj0YzTvAax6GIf
         Z2vX/41nCtGV0E7WuM9VXTCl5KHcxJcGkxUA0vM4I4rfwnAQ2s6H0KnsuKuLoqmqetBU
         erB6TwbKdAExQ9ZTmcJFE5IsETEh0znRORx/5H3oUgvTXg2V5zfn1J8ReBpioOBp/Nzg
         vg6A==
X-Forwarded-Encrypted: i=1; AJvYcCV7Wv62YlvSUQQKlU0zHhi5+vzAjcm6oJwCA2gkTwu/u7ZlCZTGqJogtfAivzzUbQi5Jqdeg2+b2xkDug8=@vger.kernel.org, AJvYcCW3eSD18Pku6kJMj2tif3MvTgs5dtuDIxhwQeJdESEc3llRx1T7q8eJu9ADhCCjFFtYLJuipaQZYYD2z9mXgVI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjtHEtWhJgBlmdmERQBu0Pi8dxpgB2KtLLISkPdyClFkFCZ15T
	dS8nt/wijyLags5JiHHH4DefSm1AzuZFUOgAhh2creh5VdjlqQrBVrh1ghpopga1xjZnnxstV9P
	xrW/9FOASU+jvYAhEZXBUBeUQEvk=
X-Gm-Gg: ASbGncuhqxY+/Otum0jOQ+NKGyyM48Yhqpvwb584ElYDptRiIoJp0qZbclkgc/VZXlV
	C6SW5RxGulaosHDLahKhYPD4Frtvcu4OXMzzDJw0+qFjSq9p7i8Y7eI9t0VGUt7gWCKB2GffCRr
	b5LK2l0zTPoWpxmi4IfHRugIIRSw==
X-Google-Smtp-Source: AGHT+IGUmbNI3uNkbBokJ0+DgOYZHVrMA0KljTUSpPD1yMDF4SeZI0QrTt7A0UVzR7ue36spq/j+MH2SODW29tRzY6M=
X-Received: by 2002:a2e:a54e:0:b0:30b:b204:6b8c with SMTP id
 38308e7fff4ca-30bf46cc12bmr4549561fa.10.1741353408784; Fri, 07 Mar 2025
 05:16:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250307-unique-ref-v5-0-bffeb633277e@pm.me> <20250307-unique-ref-v5-4-bffeb633277e@pm.me>
In-Reply-To: <20250307-unique-ref-v5-4-bffeb633277e@pm.me>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 7 Mar 2025 14:16:32 +0100
X-Gm-Features: AQ5f1JqNs14SPErLkrKBYYdeb5lkcZJUFUpN9DwjGRBjLmBuTwRm0PlYJR22B9c
Message-ID: <CANiq72mYfhuRWkjomb1vOMMPOaxvdS6qjfVLAwxUw6ecdqyh2A@mail.gmail.com>
Subject: Re: [PATCH v5 4/4] rust: adding OwnableRefCounted and SimpleOwnableRefCounted
To: Oliver Mangold <oliver.mangold@pm.me>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Asahi Lina <lina@asahilina.net>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Oliver,

Some general style nits for this and other series you may send in the
future (not a review). Please note that most may apply several times.

On Fri, Mar 7, 2025 at 11:04=E2=80=AFAM Oliver Mangold <oliver.mangold@pm.m=
e> wrote:
>
> Types implementing one of these traits
> can safely convert between an ARef<T> and an Owned<T>.

The wrapping is strange here, and it also happens in your code
comments. Please use the same width as the rest of the code in a file
etc.

> +/// - The same safety requirements as for [`Ownable`] and [`RefCounted`]=
 apply.

"same" sounds like no extra requirements -- what about something like:

    The safety requirements from both [.....

I wonder if we should expand/inline them, even if they come from the
supertraits.

> +/// - the uniqueness invariant of [`Owned`] is upheld until dropped.

Please use uppercase to start sentences.

> +///         // Use a KBox to handle the actual allocation

Please use Markdown for comments too, and period at the end (also for
"SAFETY: ..." comments).

> +/// // SAFETY: we implement the trait correctly by ensuring

There is no need to say "we implement the trait correctly", i.e. the
`SAFETY` tag is enough to introduce the comment; the same way we don't
say "SAFETY: the following unsafe block is correct because ..." etc.

> +///     }
> +///     fn is_unique(&self) -> bool {

Newline between items.

> +/// let foo =3D Foo::new().unwrap();

In general, we try to avoid showing patterns that people should avoid
when writing actual code (at least in non-hidden code) -- could we
avoid the `unwrap()`?

> +// TODO: enable this when compiler supports it (>=3D1.85)
> +// #[diagnostic::do_not_recommend]

I think (untested) we could conditionally enable this already and
remove the `TODO` with something like:

    config RUSTC_HAS_DO_NOT_RECOMMEND
        def_bool RUSTC_VERSION >=3D 108500

    #[cfg_attr(CONFIG_RUSTC_HAS_DO_NOT_RECOMMEND, diagnostic::do_not_recomm=
end)]

Thanks!

Cheers,
Miguel

