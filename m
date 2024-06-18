Return-Path: <linux-kernel+bounces-219687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE8A690D687
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 17:05:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C54B41C22B4F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 15:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 461D11CD1B;
	Tue, 18 Jun 2024 15:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f+QAV7et"
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 010C117BB5
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 15:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718723149; cv=none; b=HC2SSOuegeJ+ty6EpuSSeNu9EfR8tsSdh8gbVAW1NOnTN4KHApL4ExDa5hx0+AG7FEfalz0D2jH+kn0navHTSFrsWcdUfqbadeyoUbz+EzfukWjzX/+t0Ah0rPvaCendxU50NOhhLsj/eGUQ4aPhjtmdBCpxEx6PbgFXmo+YqPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718723149; c=relaxed/simple;
	bh=kCd4OKDue09xkLeRYSUln1FvuHgENd6Jhn9M/W7Y1FM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hwC07cOZxmUNMdUlWQ6jQqDAruJMQalEeWbdLo1vHYwsK4vkt2xJx9qzrcJheFaVRn0FxkS0ppCkHZPIDjYfWHlWToi3VpqqAGNsAZA2EBvQMnL38Jl7f3xU/+5GojjNCvK3ni+/cUlQM8oxzuv7R53WiYjHhoODP/UP/qOBhrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=f+QAV7et; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6b060f0f48aso25620056d6.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 08:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718723147; x=1719327947; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fy3M/AH6/xybCaot3WBwIJpFavAawHNjcL6fl3GGJgo=;
        b=f+QAV7et32yU/vQfav+iZS1jQ5JCUkFtu8ptt/MVuYBp3aykDNDT0bn3GlRZYJ/2UH
         PLi+SW1pBkeXv8i5Hii0MyEq09zntSATcl4V1Qxrpq01/t8kIZw/Lp3W0r4XBIUyh6iC
         x7udLTaL1kNdzTOBu9H+2gWBUiTwlLL1gHq8skZiHM0znOeddzjFOUP0KP/ueUQV7Hyp
         p0iNwU9HJdo8QTnc5cTbCKSjfgg9Er0q/2SuGYagxqDztG7Z5EAIXEb6Mc5+0smyYNuL
         2osdMrb9F/61vgMG0HraM8v0eFZLwhMPut9wuy0Y3LtcCoI4UbTp0VmnysHo/F/6LdL6
         aKqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718723147; x=1719327947;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fy3M/AH6/xybCaot3WBwIJpFavAawHNjcL6fl3GGJgo=;
        b=tVrHtrfthRs2XdLo6z9goUZZfHVGXEAc+X3J6rzuAVwGwb+mUPmmFiLrPzrZOoMcQz
         vlvWmyCSBKZVJU96XDKCRNsik3EYgw3k5+x9+oF/fZSmg5rFVYUCaGjmhk18D1Z0q1zF
         vincDFTwImT8dj4Hp3I5lnU1lH5CPnWqKXd5cm8KdWH0QalOlpvH67kG2rOcJD0gMr//
         Ro94ZJq4CXze2ANfOks/5De1llgBO0SFR3Cw2kYlC7qS4ALkqCctt8aJgn92DZ9z9KNq
         gWZ3XIuzoGJtV6pSGFgQfU5d1KDXG19pKVSYNEYieeE9VwahP3eVEUV1ACRq+6uAkGsr
         cLZw==
X-Forwarded-Encrypted: i=1; AJvYcCUuTAEQnKoaK1P+sFV7m/E4x76g9ZK3Kn0asnrK3ol8NC+MqPihYY7toBjp+RHwCNdauPnVuBrzS9imtBPtWry/HuQtXGvt4f1fmS7w
X-Gm-Message-State: AOJu0YznqmP362rXn5LLqmaucPx9J28948cf/D763xuiOJHMJxw7AdoE
	pbshxsSJRn6n8EgfDm9cknLEXXzCVy+kO7hDxJ4okIvqPKTA/kZAsOBUFcAIHMdEBQJHCal9K9D
	JnpNcKCGMVYowjy08pdvtKYWS2m/yLQiUvndP
X-Google-Smtp-Source: AGHT+IFa6FCBqd8D9Nj1JaNGKSLtJBvp/bRoyV+oAG2O6vNiHQ1JuiqvjZSAmr21MMQcuWOKxcWHb2lgAwdr0eNcVzw=
X-Received: by 2002:a0c:df02:0:b0:6b5:61:53a9 with SMTP id 6a1803df08f44-6b50061578fmr5936766d6.28.1718723146610;
 Tue, 18 Jun 2024 08:05:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240613233044.117000-1-sj@kernel.org> <5a8a3c85760c19be66965630418e09a820f79277.camel@linux.ibm.com>
In-Reply-To: <5a8a3c85760c19be66965630418e09a820f79277.camel@linux.ibm.com>
From: Alexander Potapenko <glider@google.com>
Date: Tue, 18 Jun 2024 17:05:10 +0200
Message-ID: <CAG_fn=VoCfRAKqesutB6eP2Qi0aG8Tyq4zqoiy0_A3MJDQAEfw@mail.gmail.com>
Subject: Re: [PATCH v4 12/35] kmsan: Support SLAB_POISON
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: SeongJae Park <sj@kernel.org>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Christoph Lameter <cl@linux.com>, 
	David Rientjes <rientjes@google.com>, Heiko Carstens <hca@linux.ibm.com>, 
	Joonsoo Kim <iamjoonsoo.kim@lge.com>, Marco Elver <elver@google.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Pekka Enberg <penberg@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Vasily Gorbik <gor@linux.ibm.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Hyeonggon Yoo <42.hyeyoo@gmail.com>, kasan-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-s390@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Sven Schnelle <svens@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 14, 2024 at 1:44=E2=80=AFAM Ilya Leoshkevich <iii@linux.ibm.com=
> wrote:
>
> On Thu, 2024-06-13 at 16:30 -0700, SeongJae Park wrote:
> > Hi Ilya,
> >
> > On Thu, 13 Jun 2024 17:34:14 +0200 Ilya Leoshkevich
> > <iii@linux.ibm.com> wrote:
> >
> > > Avoid false KMSAN negatives with SLUB_DEBUG by allowing
> > > kmsan_slab_free() to poison the freed memory, and by preventing
> > > init_object() from unpoisoning new allocations by using __memset().
> > >
> > > There are two alternatives to this approach. First, init_object()
> > > can be marked with __no_sanitize_memory. This annotation should be
> > > used
> > > with great care, because it drops all instrumentation from the
> > > function, and any shadow writes will be lost. Even though this is
> > > not a
> > > concern with the current init_object() implementation, this may
> > > change
> > > in the future.
> > >
> > > Second, kmsan_poison_memory() calls may be added after memset()
> > > calls.
> > > The downside is that init_object() is called from
> > > free_debug_processing(), in which case poisoning will erase the
> > > distinction between simply uninitialized memory and UAF.
> > >
> > > Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> > > ---
> > >  mm/kmsan/hooks.c |  2 +-
> > >  mm/slub.c        | 13 +++++++++----
> > >  2 files changed, 10 insertions(+), 5 deletions(-)
> > >
> > [...]
> > > --- a/mm/slub.c
> > > +++ b/mm/slub.c
> > > @@ -1139,7 +1139,12 @@ static void init_object(struct kmem_cache
> > > *s, void *object, u8 val)
> > >     unsigned int poison_size =3D s->object_size;
> > >
> > >     if (s->flags & SLAB_RED_ZONE) {
> > > -           memset(p - s->red_left_pad, val, s->red_left_pad);
> > > +           /*
> > > +            * Use __memset() here and below in order to avoid
> > > overwriting
> > > +            * the KMSAN shadow. Keeping the shadow makes it
> > > possible to
> > > +            * distinguish uninit-value from use-after-free.
> > > +            */
> > > +           __memset(p - s->red_left_pad, val, s-
> > > >red_left_pad);
> >
> > I found my build test[1] fails with below error on latest mm-unstable
> > branch.
> > 'git bisect' points me this patch.
> >
> >       CC      mm/slub.o
> >     /mm/slub.c: In function 'init_object':
> >     /mm/slub.c:1147:17: error: implicit declaration of function
> > '__memset'; did you mean 'memset'? [-Werror=3Dimplicit-function-
> > declaration]
> >      1147 |                 __memset(p - s->red_left_pad, val, s-
> > >red_left_pad);
> >           |                 ^~~~~~~~
> >           |                 memset
> >     cc1: some warnings being treated as errors
> >
> > I haven't looked in deep, but reporting first.  Do you have any idea?
> >
> > [1]
> > https://github.com/awslabs/damon-tests/blob/next/corr/tests/build_m68k.=
sh
> >
> >
> > Thanks,
> > SJ
> >
> > [...]
>
> Thanks for the report.
>
> Apparently not all architectures have __memset(). We should probably go
> back to memset_no_sanitize_memory() [1], but this time mark it with
> noinline __maybe_unused __no_sanitize_memory, like it's done in, e.g.,
> 32/35.
>
> Alexander, what do you think?

We could probably go without __no_sanitize_memory assuming that
platforms supporting KMSAN always have __memset():

  #if defined(CONFIG_KMSAN)
  static inline void *memset_no_sanitize_memory(void *s, int c, size_t n)
  {
          return __memset(s, c, n);
  }
  #else
  static inline void *memset_no_sanitize_memory(void *s, int c, size_t n)
  {
          return memset(s, c, n);
  }
  #endif

