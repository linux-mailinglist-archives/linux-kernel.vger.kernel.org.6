Return-Path: <linux-kernel+bounces-535070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 53D93A46E6A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 23:22:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58A1B3ACA39
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 22:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3790225CC77;
	Wed, 26 Feb 2025 22:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="NL8Qlopn"
Received: from mail-ej1-f65.google.com (mail-ej1-f65.google.com [209.85.218.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F59825CC70
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 22:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740608568; cv=none; b=Url0qGd6O5SQEKZIX+tw/Fgx1OiyePPg5zZu2GSxK4o6NUUEl2kxg8qODPQXkS1Bwl8LbH+4xS0OYhNG/71NyugwzrC62zjNLkdxyZudZJpKYw7qFndcUmUWQzBVRq7H8HXCCG2BDqFokY2UYW89eOdz9c2Ghg4L0d6wOswcMFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740608568; c=relaxed/simple;
	bh=X14QyeY7juiG19kFhE8jOTcAC9LX5WqrcvQ1QAzL4R0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ROOnvSSdv3TGhPYrqiEghDjx2oAyrjisgPXEr9NqqYSOZ9uhVQEdoQC+trO+eNxY+djql+c6HrBVd/zzoC2BJEtCOWs8g/bS9w+OhyQ1XhScINe95SI1LgQLLfg0kHLr3oA9t+NnpcFGSoL/nX74fktirsC1zQSm1Lj5FMx5KF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=NL8Qlopn; arc=none smtp.client-ip=209.85.218.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f65.google.com with SMTP id a640c23a62f3a-abee54ae370so37523466b.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 14:22:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1740608564; x=1741213364; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wzpvSa7nrVjiWlv0eKU2ozCFswwUHSEDAs+O1FlWijQ=;
        b=NL8QlopnQuow6Bds0GMCP1vhgsa5fECgvECJA0h9jAb3rPAjaec86tsILTGRSxt8Y2
         cX7m/xALsHrsk0AxqtC39zpnmcMiK6SVnuoK+4ho7aQBgdymHIdMjO9ONu/bHGaPF7ZX
         YUGjZn2wdsfqmHxp6x6fpxi29rJ3ODdOYIO1Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740608564; x=1741213364;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wzpvSa7nrVjiWlv0eKU2ozCFswwUHSEDAs+O1FlWijQ=;
        b=cSvZeXkQcOmzKKZat/v2RZFQ/DlTUIUZkDdH5yf9hzCzQq22ENG4AtE51BPs3tk5kC
         K3kjgBmwjtUetbY1abkeo+Bic3/m73CO51zbsgtUMelQ5l9JXn+UIQyoHw4KEO+Np4N/
         jytT+zLiZ5E4LWwaIADEv1uClpWRcZAOjDbpD5ijsmQgxDpU1yuaGDC9ddwdQmM2guQB
         67VM1t1O4Uo1XsMzWH3VRY9sVzvRnnv5x6+MDrYTopCd449Jhz/v9AgEktKoSTjj6EdK
         RDzhDFLByIRqMakwsCIyZeKOwQX/SM7KyJlEoScFEO0vzcDrBzglQj498GASX263XeH3
         b+cA==
X-Forwarded-Encrypted: i=1; AJvYcCVZEAM0gpndrBy1rRx5OVngdCMPuyL1yHP1FMwmWexHTbkB8uvkDp6VeeIDJysEUBl00l4Foz39V5QAklk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy19cJ+NVVtNx8Vh391rPH/w3AkiNY1Y5fcsyCnOIw0u0KPnIT4
	XSszgHBqoTmiB9q+7s8UTNqIuQuXacFgCx01UhyjBdxY8Xu0EJXSUZP+rfqXj/m2DSfcUhjRvNl
	UwSiA1J1T
X-Gm-Gg: ASbGncsiqw6E6MJN2TQWfdUXRIkyJY7A1WmM+YCinDN8uUrHXzBxRprf+oi+F/veGKO
	C7Sqb8ut30Zb3FWF6utpaxq5qiZQW+5PmoqSEZamjgYrJnoO40JYx6rTko/OUKrKFT934wnNhvW
	Q+e9+S2MTTWEhssI1XCpkU70XpZYvajCke8e23vucbrr+Hcs/7qUZBv9lSg2yaTYrNEP2CwMrVc
	hEzWwu5mpA/Fw8kt8ObWAvqDjQTl70hVH2m4vdsxl8bhLvrnC2SNzQbhGI1oIuflF/Wk701Larc
	ppQamrqY0uJLd/5zA7jKZWWya/WWY3dzoH36T7oLFGa3TD4zeECrlUL0UgcDgd9oV2Lqsvks5Mv
	+
X-Google-Smtp-Source: AGHT+IGW/fGokRkLYKenviat6Wn1/1Sloei0ca9IYb6LF+AZCFF6l612/pt7l6yP+e7xfm8hx9mzGg==
X-Received: by 2002:a17:907:60cc:b0:abe:b99f:8f28 with SMTP id a640c23a62f3a-abeeeea226dmr701400966b.31.1740608563639;
        Wed, 26 Feb 2025 14:22:43 -0800 (PST)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com. [209.85.218.45])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf0c74fb00sm12419866b.130.2025.02.26.14.22.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Feb 2025 14:22:43 -0800 (PST)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-aaee2c5ee6eso40326366b.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 14:22:43 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUc/AP7Yninwy0IbPS1Hnsb51+3/QLoZ6piBrG0dHru5CYQg280IMJ5EkMphv8QyGpBs849NK72klfuqCs=@vger.kernel.org
X-Received: by 2002:a17:906:830c:b0:abe:fffb:f1ef with SMTP id
 a640c23a62f3a-abefffbf91dmr373374066b.20.1740608562825; Wed, 26 Feb 2025
 14:22:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFJgqgRygssuSya_HCdswguuj3nDf_sP9y2zq4GGrN1-d7RMRw@mail.gmail.com>
 <20250222141521.1fe24871@eugeo> <CAFJgqgSG4iZE12Yg6deX3_VYSOLxkm5yr5yu25HxN+y4wPD5bg@mail.gmail.com>
 <6pwjvkejyw2wjxobu6ffeyolkk2fppuuvyrzqpigchqzhclnhm@v5zhfpmirk2c>
 <CAHk-=wgq1DvgNVoodk7JKc6BuU1m9UnoN+k=TLtxCAL7xTP=Dg@mail.gmail.com>
 <CAFJgqgSqMO724SQxinNqVGCGc7=ibUvVq-f7Qk1=S3A47Mr-ZQ@mail.gmail.com>
 <CAH5fLgh7Be0Eg=7UipL7PXqeV1Jq-1rpMJRa_sBkeiOgA7W9Cg@mail.gmail.com>
 <CAHk-=wgJQAPaYubnD3YNu8TYCLmmqs89ET4xE8LAe2AVFc_q9A@mail.gmail.com>
 <5d7363b0-785c-4101-8047-27cb7afb0364@ralfj.de> <CAHk-=wh=8sqvB-_TkwRnvL7jVA_xKbzsy9VH-GR93brSxTp60w@mail.gmail.com>
 <ed7ef66dbde453035117c3f2acb1daefa5bd19eb.camel@tugraz.at>
 <CAHk-=whLSWX=-5-z4Q8x1f_NLrHd0e3afbEwYPkkVSXj=xT-JQ@mail.gmail.com>
 <20250226162655.65ba4b51@gandalf.local.home> <CAHk-=wjAcA4KrZ-47WiPd3haQU7rh+i315ApH82d=oZmgBUT_A@mail.gmail.com>
 <20250226165619.64998576@gandalf.local.home> <20250226171321.714f3b75@gandalf.local.home>
In-Reply-To: <20250226171321.714f3b75@gandalf.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 26 Feb 2025 14:22:26 -0800
X-Gmail-Original-Message-ID: <CAHk-=wj8Btsn0zN5jT1nBsUskF8DJoZbMiK81i_wPBk82Z0MGw@mail.gmail.com>
X-Gm-Features: AQ5f1JoQa0DT2FRkZg7eNVadgxV73SepUYePI-LWmsRCiLb5e60q_ApFv3ZzBm4
Message-ID: <CAHk-=wj8Btsn0zN5jT1nBsUskF8DJoZbMiK81i_wPBk82Z0MGw@mail.gmail.com>
Subject: Re: C aggregate passing (Rust kernel policy)
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Martin Uecker <uecker@tugraz.at>, Ralf Jung <post@ralfj.de>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Ventura Jack <venturajack85@gmail.com>, Kent Overstreet <kent.overstreet@linux.dev>, 
	Gary Guo <gary@garyguo.net>, airlied@gmail.com, boqun.feng@gmail.com, 
	david.laight.linux@gmail.com, ej@inai.de, gregkh@linuxfoundation.org, 
	hch@infradead.org, hpa@zytor.com, ksummit@lists.linux.dev, 
	linux-kernel@vger.kernel.org, miguel.ojeda.sandonis@gmail.com, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 26 Feb 2025 at 14:12, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> I take this is what you meant by following what the code does.
>
>         r = global;
>         if (r > 1000)
>                 goto out;
>         x = r;
>
> Is the code saying to read "global" once. But today the compiler may not do
> that and we have to use READ_ONCE() to prevent it.

Exactly.

And as mentioned, as far as I actually know, neither clang nor gcc
will actually screw it up.

But the C standard *allows* the compiler to basically turn the above into:

> But if I used:
>
>         if (global > 1000)
>                 goto out;
>         x = global;

which can have the TUCTOU issue because 'global' is read twice.

> I guess this is where you say "volatile" is too strong, as this isn't an
> issue and is an optimization the compiler can do.

Yes. 'volatile' is horrendous. It was designed for MMIO, not for
memory, and it shows.

Now, in the kernel we obviously use volatile for MMIO too, and in the
context of that (ie 'readl()' and 'writel()') it's doing pretty much
exactly what it should do.

But in the kernel, when we use 'READ_ONCE()', we basically almost
always actually mean "READ_AT_MOST_ONCE()". It's not that we
necessarily need *exactly* once, but we require that we get one single
stable value).

(And same for WRITE_ONCE()).

We also have worried about access tearing issues, so
READ_ONCE/WRITE_ONCE also check that it's an atomic type etc, so it's
not *purely* about the "no rematerialization" kinds of issues. Again,
those aren't actually necessarily things compilers get wrong, but they
are things that the standard is silent on.

              Linus

