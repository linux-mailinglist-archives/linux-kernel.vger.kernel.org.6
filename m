Return-Path: <linux-kernel+bounces-271032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EBB6E9448A8
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 11:43:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FA0F1F22904
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 09:43:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82FE2170A02;
	Thu,  1 Aug 2024 09:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="otWyfblC"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44819EEB3
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 09:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722505383; cv=none; b=LXvzmjipQwvNgArPdsvTW7FYI03NtEvsrejC00fZbKiAg6q+jcnsN8e8F35mXGlbvncEXVJiwhRkp70CvGV5dh7sY5zyEHFLF0YSRV3zu2IV/WqfQfl/xVg2fH4ZA9GgDLMMvHN4Z+KebJJ7UYRdBhfDEGpXOHGgaeLFWTV7A0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722505383; c=relaxed/simple;
	bh=/fZmHLIz4tMUPuqgb1xpJQYqGHHk61hfOq+SQhBPq18=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=baxe7HEa9h4grAI/TtuYoTQIhwrPKEqrQM7CfTgomEobI+gJZnnVfmJQY/9ygfUCjRpz2N5AoZXC+M27yYD9MfiMzQfhOgCDdPmJpqIorckJ665Ww0pjBfISvAkqqYMwLn2F3FLPw9I0MUcYhElTFs/ClSCCSuft1Sw/G1VIPKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=otWyfblC; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-428243f928cso22571975e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2024 02:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722505380; x=1723110180; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xH+fBgRnwsthPgYi/oe0eH8RjLbFhVP+C/hiF5wcIOg=;
        b=otWyfblC6ZuR8tCt72hCEvM66lSu5qS2HPbSI0Lzp6M/yZnqGQa4SSKP/YJOzG+PLt
         v3NJ/qiIlM8lMo87PEx1Q07pRUGjHUUq3UOFPte9IXDIsppQpN/d7mjnlg94yq9DdKQv
         3T4X0SOdllZ2l86igLzArPmMenAAVPPHZDS6uddPepjIMB9hvOx6H5hxuTlhWw7oe0+6
         FNhh07X9pxBw2QVAo73VErDvVIW9TdoNiaFR1ROkOljPo2feOZnql8/rTqLlIH6lDOiF
         zR7dja0IkSvC5giJBmpMTCLVBz3HXLxNehfZ1LAoi8NvkjijpdE44Eql7lSii94sGlqo
         /3bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722505380; x=1723110180;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xH+fBgRnwsthPgYi/oe0eH8RjLbFhVP+C/hiF5wcIOg=;
        b=gGhkLr72VGmygugmclgseaCgvRZwZsLnhDjDNkrznzxvcJp5Jc647fx6nsgHLnyHZJ
         8oHJNLQ0bib4JYmF4a8jRpknECwUE8hOpW1PmreWrU+0sWH+5tMTaVfPxTqcDSopgpwU
         wMbQ97DxiFC/+YFFAZjXCTWZbQJClR2cCabd7ucjYfyBOmSnLGxA4bMC95OHlk11KTGY
         hXQAbhaeTPnyLPcXf+9XzEJdAO/lpf93DnMfCNdEZXR97ewkp9W9f+4yEYW4Mc4E36qb
         5sIVKfqq2NUSEYGY4NpdnEStCwV040FDfYp1QZcYMePkxSinsMXR4qr+ks/G7nzIV+/Y
         gBMA==
X-Forwarded-Encrypted: i=1; AJvYcCXtswX8SDi5/zcuAZ640pkgRwqsb/11iUXiUPMxwrr9w0dEQwyWQaI9zvlxWG2ISwoXeKQbUvaw7mlShj105Nyi6EkOqrVQZjr4dWcN
X-Gm-Message-State: AOJu0YyxNqMSiFWmRXscn2DplN+dTpB6rCrDTSIhmzc3LZMuoSpoDNO6
	H/oB62bY6NA6oYYPdLr2bLts6/McFBY8H+XMF0WzfbZOHSGN9+DHEKMFTwuUXcftzP8XRodAauH
	Uw8DlB/sMsh/AOP07lFYqTA7SBgeEnbZbVQN2
X-Google-Smtp-Source: AGHT+IGNxLdpK9yDQuPbeyIoE//94sKUHY6JfjA9T49ykZfGDutE/O2sKVvnl7fm5s8QibFPdq2rJbE+Sj07FBblOmU=
X-Received: by 2002:a5d:67cc:0:b0:368:3789:1a2 with SMTP id
 ffacd0b85a97d-36baacc9cd9mr1270766f8f.21.1722505380296; Thu, 01 Aug 2024
 02:43:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240723-linked-list-v3-0-89db92c7dbf4@google.com>
 <20240723-linked-list-v3-4-89db92c7dbf4@google.com> <1b2078d8-d93b-4626-a73f-edc5616a2357@proton.me>
In-Reply-To: <1b2078d8-d93b-4626-a73f-edc5616a2357@proton.me>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 1 Aug 2024 11:42:48 +0200
Message-ID: <CAH5fLggKphE3f=Jv+pfXc+_qjsGBVpXw_F4fOJiAi6vNtJ5x+Q@mail.gmail.com>
Subject: Re: [PATCH v3 04/10] rust: list: add struct with prev/next pointers
To: Benno Lossin <benno.lossin@proton.me>
Cc: Miguel Ojeda <ojeda@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@samsung.com>, Marco Elver <elver@google.com>, Coly Li <colyli@suse.de>, 
	Paolo Abeni <pabeni@redhat.com>, Pierre Gondois <pierre.gondois@arm.com>, 
	Ingo Molnar <mingo@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Wei Yang <richard.weiyang@gmail.com>, 
	Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, Kees Cook <kees@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 31, 2024 at 8:41=E2=80=AFPM Benno Lossin <benno.lossin@proton.m=
e> wrote:
>
> On 23.07.24 10:22, Alice Ryhl wrote:
> > +/// The prev/next pointers for an item in a linked list.
> > +///
> > +/// # Invariants
> > +///
> > +/// The fields are null if and only if this item is not in a list.
> > +#[repr(transparent)]
> > +pub struct ListLinks<const ID: u64 =3D 0> {
> > +    #[allow(dead_code)]
> > +    inner: Opaque<ListLinksFields>,
>
> Do you really need `Opaque`? Or would `UnsafeCell` be enough? (If it is
> enough and you change this, be aware that `Opaque` is `!Unpin`, so if
> you intend for `ListLinks` to also be `!Unpin`, then you need a
> `PhantomPinned`)

I need the `!Unpin` part for aliasing.

> > +}
> > +
> > +// SAFETY: The next/prev fields of a ListLinks can be moved across thr=
ead boundaries.
>
> Why? This is not a justification.

What would you say?

> > +unsafe impl<const ID: u64> Send for ListLinks<ID> {}
> > +// SAFETY: The type is opaque so immutable references to a ListLinks a=
re useless. Therefore, it's
> > +// okay to have immutable access to a ListLinks from several threads a=
t once.
>
> You don't need to argue via `Opaque`, the type doesn't expose any
> `&self` functions, so there are no functions to consider.

I'm not arguing via the `Opaque` type. I'm just using "opaque" as a
normal english word with its normal meaning.

Alice

