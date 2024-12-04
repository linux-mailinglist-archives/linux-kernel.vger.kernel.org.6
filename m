Return-Path: <linux-kernel+bounces-431241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C15BD9E3B6A
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 14:38:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 72B70B28EA0
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 13:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD1DC1BBBEE;
	Wed,  4 Dec 2024 13:15:24 +0000 (UTC)
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1FA61714B3
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 13:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733318124; cv=none; b=DQgAIJIrf3ZNIwQA2EzBznyelFg/FKePncNq/t0vJyIWRJOLOx1jTy+WSI2RbOz9jSHjL8UhNYLMI5eVPFNGt+kNksNsuMyvU+OygKPiQkvONUOjy5J2PL7o/QVvF/DBWoLOdPACE6+PBi75UGnb5pxyWnxcBfwBrvf2GaV6Hlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733318124; c=relaxed/simple;
	bh=9oBDo4zkHiTlZ16eIVrOzrIdyjeP6jNrhBRMl8enpnY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iLG1+0O7gaUAwCtjrsChfNv8sAKUJyLqbeUTiccYpGlMaFOjs/yIxT6p1fbqncL2KOV2pbBPvB9fOSao1J6DHHzzPb4MBZGvsAeBQle65OYB1cg4kTPQhaVqekIolDgbAyfJhzwx+zUyqKMYic65oTxj1OWVBTNolfgavUTzbP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-4afb1961a35so191730137.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 05:15:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733318121; x=1733922921;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=juKoUY/+GHPAhNw5w6qO+bk4TMamhAcWlpPERhaqdrs=;
        b=PfIV3web3P+dTHQ1zZiaQyLWyZOLZRhJW4AYJZ8GzP2gigp/iZwKdVbMcwJWbVb5H0
         YyxgK9glJmiWW+6A/P1nB0C0vk6fDtRUhHFd+jIXINeEsp3i6DlN+2D8V6CiFwDSxckL
         cFaS1MQfdTGtQLJe9O1X0aY5e9xo8XWTHqlJWXNUhAPEVSKvdsFRM17tRYxx1RpwyqcL
         QTmeb0ICU54CA107bgMOIj74ZvtAC5izNmptH1YXkq2g9EIhr8Pb0Mqn5nbpyln6s5U8
         lEaxpSsFJWuM+MBF812SkFxq4u9qtgj0nfKiJLmxKo9t5bAjPcqJxfImlqyh3fKUy0cU
         M3uQ==
X-Forwarded-Encrypted: i=1; AJvYcCUpkzMXExUqD3DcvV60+e9BroNF54tmahqTrZGWK8jXubVJR/pVlWFasxXl9HQHp2FxrH0eQJT8wWaAsQg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCd7AsYJz+2d5mqupib8uqM1/r9uONTjFrV5VCu+FYMAYOC5yd
	hjjeOP1XJBKvLI0ksYx/il2YAEyRmJJ879secm5YWnRGnai7l0IvpGGQGT6i
X-Gm-Gg: ASbGncumIPx1cH4vdsft05OBE9N0aIsg0g+EgQ1WYkocdXMScHw43VT0YY8YS4PJbpR
	MuMOQLmXad8cxDAN8JmPFbLjMAhKtnA3L2PsP55KoGuye6r1WK5E1JLWcWq6vJCwajYX8o+urDo
	hQZPSJ1aH1GB03dhuK6oH8yeJED3lWT+GkwjiooVahWO+Uw1+TMcVxdO/RIPs4LLOLcTJ+3jsxA
	bINqy/y/px3bWwXR8p3GJDsC/vD4XK1dYq+DyUiot5WGWADJmfaozMxmjWNNauEkGXmBnYHQ9yD
	uuB1nz1Vym0d
X-Google-Smtp-Source: AGHT+IEhQVJ2VZglHpmZlFIB7QuUnanMED7V0LBORuijF6qSccN9O6o4hKatLEqsu/fBS1N9uIPJtw==
X-Received: by 2002:a05:6102:dcb:b0:4af:af20:516a with SMTP id ada2fe7eead31-4afaf205498mr1809702137.1.1733318120793;
        Wed, 04 Dec 2024 05:15:20 -0800 (PST)
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com. [209.85.217.42])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4af9d9d123bsm409033137.5.2024.12.04.05.15.19
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Dec 2024 05:15:19 -0800 (PST)
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-4afa53874beso371667137.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 05:15:19 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUk2wtyZTQ1kCT3kqcQpE0muNwxbQ0P7h+roJwcsPJ+gAKYPMU3YwyLOAcqtkDgx9cVU1SkFr0l8dL+xVo=@vger.kernel.org
X-Received: by 2002:a05:6102:34a:b0:4af:a967:65c5 with SMTP id
 ada2fe7eead31-4afa9676822mr3387736137.10.1733318119032; Wed, 04 Dec 2024
 05:15:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <402c3c617c29465c898b1af55e3c6095@AcuMS.aculab.com>
 <5cd3e11780df40b0b771da5548966ebd@AcuMS.aculab.com> <CAHk-=wj=Zv+mMuqJQJptH9zGFhPXqku9YKyR7Vo4f0O0HEcbxw@mail.gmail.com>
 <b47fad1d0cf8449886ad148f8c013dae@AcuMS.aculab.com> <CAHk-=wgH0oETG1eY9WS79aKrPqYZZzfOYxjtgmyr7jH52c8vsg@mail.gmail.com>
 <e718056c1999497ebf8726af49475701@AcuMS.aculab.com> <CAHk-=wj900Q3FtEWJFGADQ0EbmYwBHW8cWzB0p0nvFck=0+y6A@mail.gmail.com>
 <e946e002-8ca8-4a09-a800-d117c89b39d3@app.fastmail.com> <CAHk-=whCvSUpbOawsbj4A6EUT7jO8562FG+vqiLQvW0CBBZZzA@mail.gmail.com>
 <CAHk-=wgRDupSBzUX_N_Qo_eaYyDfOH=VTihhikN36cGxCc+jvg@mail.gmail.com>
 <f88a19d1-c374-43d1-a905-1e973fb6ce5a@app.fastmail.com> <8111159a-c571-4c71-b731-184af56b5cb1@app.fastmail.com>
In-Reply-To: <8111159a-c571-4c71-b731-184af56b5cb1@app.fastmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 4 Dec 2024 14:15:07 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVx0wpKhHKn0NppJRbMA2FwjKntPFX1zaJzKhQANeY6oQ@mail.gmail.com>
Message-ID: <CAMuHMdVx0wpKhHKn0NppJRbMA2FwjKntPFX1zaJzKhQANeY6oQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/8] minmax: Put all the clamp() definitions together
To: Arnd Bergmann <arnd@kernel.org>
Cc: Linus Torvalds <torvalds@linuxfoundation.org>, David Laight <David.Laight@aculab.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	Matthew Wilcox <willy@infradead.org>, Christoph Hellwig <hch@infradead.org>, 
	Andrew Morton <akpm@linux-foundation.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Dan Carpenter <dan.carpenter@linaro.org>, "Jason A . Donenfeld" <Jason@zx2c4.com>, 
	"pedro.falcato@gmail.com" <pedro.falcato@gmail.com>, Mateusz Guzik <mjguzik@gmail.com>, 
	"linux-mm@kvack.org" <linux-mm@kvack.org>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Biju Das <biju.das.jz@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Arnd et al,

People started seeing this in today's linux-next...

On Tue, Jul 30, 2024 at 4:15=E2=80=AFPM Arnd Bergmann <arnd@kernel.org> wro=
te:
> On Tue, Jul 30, 2024, at 12:10, Arnd Bergmann wrote:
> > On Tue, Jul 30, 2024, at 05:59, Linus Torvalds wrote:
> >> On Mon, 29 Jul 2024 at 16:21, Linus Torvalds <torvalds@linuxfoundation=
.org> wrote:
> >
> > I'm giving this a spin on the randconfig test setup now to see
> > if there are some other cases like the bcachefs one. So far I've
> > seen one failure, but I can't make sense of it yet:
> >
> > drivers/gpu/drm/i915/display/intel_backlight.c: In function 'scale':
> > include/linux/compiler_types.h:510:45: error: call to
> > '__compiletime_assert_905' declared with attribute error: clamp() low
> > limit source_min greater than high limit source_max
> > include/linux/minmax.h:107:9: note: in expansion of macro
> > 'BUILD_BUG_ON_MSG'
> >   107 |         BUILD_BUG_ON_MSG(statically_true(ulo > uhi),
> >                 \
> > drivers/gpu/drm/i915/display/intel_backlight.c:47:22: note: in
> > expansion of macro 'clamp'
> >    47 |         source_val =3D clamp(source_val, source_min, source_max=
);
> >
> > See https://pastebin.com/raw/yLJ5ZqVw for the x86-64 .config
> > that triggered this.
>
> The above seems to happen only with gcc-13 and gcc-14, but not gcc-12
> and earlier, and it's the only one I've seen with a bit of randconfig
> testing on that version.
>
> There is another one that I see with gcc-8 randconfigs (arm64):
>
> net/netfilter/ipvs/ip_vs_conn.c: In function 'ip_vs_conn_init':
> include/linux/compiler_types.h:510:38: error: call to '__compiletime_asse=
rt_1040' declared with attribute error: clamp() low limit min greater than =
high limit max_avail
>   510 |  _compiletime_assert(condition, msg, __compiletime_assert_, __COU=
NTER__)
>       |                                      ^
> include/linux/minmax.h:182:28: note: in expansion of macro '__careful_cla=
mp'
>   182 | #define clamp(val, lo, hi) __careful_clamp(val, lo, hi)
>       |                            ^~~~~~~~~~~~~~~
> net/netfilter/ipvs/ip_vs_conn.c:1498:8: note: in expansion of macro 'clam=
p'
>  1498 |  max =3D clamp(max, min, max_avail);
>
> I can reproduce this one with gcc-8/9/10, but not gcc-11
> or higher.
>
> This may be another case of __builtin_constant_p() being
> slightly unreliable when a local variable is constant-folded
> based on a condition, or with partial inlining.

Or perhaps the argument order is wrong, and it should be

    max =3D clamp(max_avail, min, max);

instead?

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

