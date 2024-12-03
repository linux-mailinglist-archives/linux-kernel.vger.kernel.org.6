Return-Path: <linux-kernel+bounces-429007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 535AE9E162B
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 09:48:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AC181638CF
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 08:48:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18C4A1DDA33;
	Tue,  3 Dec 2024 08:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FfbPudO7"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E73B257D;
	Tue,  3 Dec 2024 08:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733215703; cv=none; b=cln1UL7MgUBkir23zGpf17naAfXwe79p8/aAP+V2hCoBSiEzPvRc92JWwHOwUnvC8ux8MC8oOk9QnzWGHGjKDbQCD+Jo9ntSnSpM8HtpFlke5YvVoSF2HQPxLTGrLgZwKSuqqDgVI6YJExB6RThN4CkYLTSMIUyycUbwLj7arjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733215703; c=relaxed/simple;
	bh=WFKzI1fZ+E/odL6blUYCUeXJAWWClEFQFwA8lgkf2Uk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HSWRjAmReFIgTHVWt9wP0Su3lGMwnhXAGGYoCYDLVaPylCMfrh+HOtkjgJCw/+f0wZMFmqEIsQo8ZR6TxZbM+gcqRnmwgcWEy8HBc+Yd5WFq+Sz5ePDfz21iCkZPTGZOpcIv0BqQBrAiB2FH68QcWIkCxAY3uIj4+U4eHTwle+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FfbPudO7; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-7fbbf456a63so311783a12.2;
        Tue, 03 Dec 2024 00:48:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733215700; x=1733820500; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AOSZZo6COvONJZX2dpnbD1MkQEuc1G+gxCG2m+LKD1g=;
        b=FfbPudO72vNA3pi7ij21kbrPl099a2dw8UMqW4cwBU8ktjppkktCP5jQYfNXXN2Cqu
         QXLbijiWFwl3aQiZMylw5o1NuHqooIVxrT4KArg8FXIkvzAR0T+CqoAnjBRt/72lS3oG
         vHzm9W6WHxAQ6p/mnDCXBe3A3zzC226AF7KujNTeTSASgFhDFTRk7jljGs5+WLZUo6mi
         AEnSHk/hucjX/SYaXyi+lGFtfdtQ0Btsm2MtEX+wfifTzVDvsWE6LkwjBNQEjzzRmumi
         pxiUNnuL8xbAbVysJIqCR7n7p5FBYrSzPJ5o1sqVb+oTB8YXNL97BKcjykZHXorie0cD
         usxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733215700; x=1733820500;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AOSZZo6COvONJZX2dpnbD1MkQEuc1G+gxCG2m+LKD1g=;
        b=oze42X6mE/uEPbqaA7NEulFU+bSOC4nvkxVRrBLQDIHhVaMsnRueZdHyUFeYSagdqs
         o+/xMjZAFnc5PNsiNT8ll0oH7XX64ZTHyBK9/+mbFmWlafuLl1gKdPZPIoJk9mB01Igu
         m0UGk/lsM7C3gKu5igfB3lRH3/itK99ebrOr/gbsxosas1jsB97ULOATzfVBkkHkDiAd
         +nw7eDjh+l0XDfMmgYjtOiOR3sky6qkEYgbyJC0ptxWFawTAjlhdUGIdDdahNeNRVDrc
         cO6VLX2NJ8aTtH7DP3+icYmVRGqh2OGGyVegFduPLA58KDt9NSaddnLRhV/WvxBpWMf3
         z/wA==
X-Forwarded-Encrypted: i=1; AJvYcCWPim6CBgzgqybpYnzgJUibg5+jJrqdvQCsqVy8KUy9vejhofgAup4eb2wyd7XO3UinurmdqpLyGzwSi6k=@vger.kernel.org, AJvYcCXjR/KmFTYrqS5UrS0w8KDCvFkX+oVC1lL32ZfIo5ObO7YC0/0zz6HxokVHuWFs6mwNHwxGEpz8tvrQUwu8lHI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMNJ/w1knKOubCA4fnQ1UspTDD5RBLxqJgUnX1+C/l8fcGRp2u
	z/5nHZOUOp3gTzy6C5TtB1c0pjT7G7b/DMqzOeUMmNLmvFpNtd92OvvReFiGXkp5yI8BkOjnMKg
	9N89OoWRafUSVgU52FKVjY1+TxwKXJxCUEaY=
X-Gm-Gg: ASbGnctzIsXh2PpVQ8J8BATw4Pzg3oZBo/16MGJ77c0V59BNeb7b2w6xsY8aOSUmt1p
	fxSyUxZyu2hUvkBESc5Ftlr1vMAFPXNI=
X-Google-Smtp-Source: AGHT+IGRdfSSIMxoMmoGcKQ0NDHpV8V+exuQ9YeI+S9wU3oIO/GKPXTP9f4hq+wXOlXUu3x6bprZaQnsqqX6G8k23vI=
X-Received: by 2002:a17:90b:4a8d:b0:2ea:853a:99e0 with SMTP id
 98e67ed59e1d1-2ef0124c9acmr967675a91.5.1733215700158; Tue, 03 Dec 2024
 00:48:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241203051843.291729-1-jtostler1@gmail.com>
In-Reply-To: <20241203051843.291729-1-jtostler1@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 3 Dec 2024 09:48:07 +0100
Message-ID: <CANiq72ksaJcpjHi8=vuWLTLLfik9smaqY9oJXjwtieXgJ6Gy9Q@mail.gmail.com>
Subject: Re: [PATCH] rust: alloc: Add doctest for `ArrayLayout`
To: jtostler1@gmail.com
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 3, 2024 at 6:19=E2=80=AFAM <jtostler1@gmail.com> wrote:
>
> From: Jimmy Ostler <jtostler1@gmail.com>
>
> Added a rustdoc example and Kunit test to the `ArrayLayout` struct's
> `ArrayLayout::new()` function.
>
> Kunit tests ran using `./tools/testing/kunit/kunit.py run \
> --make_options LLVM=3D1 \
> --kconfig_add CONFIG_RUST=3Dy` passed.
>
> Generated documentation looked as expected.
>
> Signed-off-by: Jimmy Ostler <jtostler1@gmail.com>
> Suggested-by: Boqun Feng <boqun.feng@gmail.com>
> Link: https://github.com/Rust-for-Linux/linux/issues/1131

Thanks for the patch!

A few procedural nits: please Cc the maintainers/reviewers, especially
the main one (Danilo) -- for that, please see
`scripts/get_maintainer.pl` as well as e.g.
https://rust-for-linux.com/contributing#submitting-patches for one way
to generate the arguments.

The "Signed-off-by" tag normally would be the last one -- that way
people see that you added the other two rather than the next person in
the chain. It is good to mention the tests etc. that you have done,
although normally for a patch like this it would normally not be
mentioned (since all patches that add an example need to be tested
anyway).

Finally, a nit on the commit message: normally they are written in the
imperative mood.

By the way, the "From:" tag on the top would not need to be there if
your "From:" in the email headers is configured properly.

>  /// Error when constructing an [`ArrayLayout`].
> +#[derive(Debug)]
>  pub struct LayoutError;

Ideally you would mention this change in the commit message too -- it
is the only non-comment/doc change, after all :) It is also important
because, in general, so far, we have not been using `expect`.

> +    ///
> +    ///

Please use a single line.

> +    /// ```rust

You can remove "rust" since it is the default.

> +    /// use kernel::alloc::layout::ArrayLayout;

This line could be hidden -- it is `Self`, after all, so it is not
adding much for the reader. We are not fully consistent on this yet
though.

> +    /// let layout =3D ArrayLayout::<i32>::new(15);
> +    /// assert_eq!(layout.expect("len * size_of::<i32>() does not overfl=
ow").len(), 15);

See above on `expect`.

Moreover, since it is a test, it is fine to panic, but recently we
were discussing that examples should ideally show how "real code"
would be written, thus using `?` etc. instead.

> +    /// let layout =3D ArrayLayout::<i32>::new(isize::MAX as usize);

Perhaps we could consider an example with an smaller argument that
still overflows, to drive home the multiplication involved. It could
perhaps be a third one.

Thanks!

Cheers,
Miguel

