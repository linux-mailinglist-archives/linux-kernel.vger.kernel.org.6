Return-Path: <linux-kernel+bounces-262340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12B6993C447
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 16:35:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC08028787B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 14:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C7A219B5BE;
	Thu, 25 Jul 2024 14:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Syga3nUl"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE58419AD94
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 14:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721918125; cv=none; b=Eu93wxQ7iEOgeoih36wbviRaZeEZticlaBRGsnCD5nm8tnRd9A8q8bPkW7eosdXcNi6JsuDwvYzkPsm8999U7SRaQYoCVlYpIarFEIlu+YuBgTdu8dbjy6dxN2i+qPxlSyP8n/lkHA4e4txEE2mjZjyhHGSfYpwdgOmI1+rvbYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721918125; c=relaxed/simple;
	bh=3MCHIhC45M0nUeFybC0lXbQPGObmnQAsY9s3FbrYUDU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CWnNUXKrzjibcLvdP3hwlmUJsjtMuLhN6xkKojl4ygoASNYo2kN4iCxnEvGTPI/ZbEe0gKaZoGswgEYCC56ntqyu7u9aG03q0++gRFVfpIHPDsp46aIzJbsdnoKRI5hi7eQoKOg44tkUWhWTlTGHV/y6l9kyG4yWL0qmZy8BStM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Syga3nUl; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5a28b61b880so13197a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 07:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721918122; x=1722522922; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D+McA66aY10VJ6ghs/3u7Af6ixrbJytWpoKwjU1ZAzo=;
        b=Syga3nUld9ahKe2WaODFTJN1M7cqfZ3ndyafO2A3e/rhKCwbIicBGeOrf4vnomWERC
         fCHPk2gQ2Odh3N7Ghl0KGut/fxqvmD9hDbWlJamwxBAafhxRpx6lvWSsSJwNf5PtN3ms
         PKkwwn+wWgmEtqyu/aXraSD4i6UoXrJ+3vxL7oMzX6eBRgsYttwn4kpfq7rkOGTMFaEB
         5R5SqZd/Kw//u6ircKIOsx9tKbG39l1CK7/VfGkPJjr7BFpkUV+oSlKxRUvRiH/npODR
         pTwO4jlTWP7UNCo3VLRwKoZI/hrOnCK20A5J2J2yeqa4+iHTNr82BNKHIYmu664vykhV
         4cAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721918122; x=1722522922;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D+McA66aY10VJ6ghs/3u7Af6ixrbJytWpoKwjU1ZAzo=;
        b=Srg/U8MmYgjz/r62IT54wnmdanf0l4FY1aDA17e7nbp8ndl87jXU64tV+usIC9tYRC
         sSyLCVfptUQLjXvIgs8ThYQyZglOmuY3jHoNWYaEa1wn9mrBMZFbZsPUJcdWvjGxhP+k
         7gjqyWUBJ85oz1y1nf4ZpBEW79jmeBuQvOWRkPzbD62H33f1GFikVmrxPmYdykmyfyQK
         +Di+3rEAI7ekbjtuIZryZRdZjC1lMcR/eko4VV3HUGcFDwtRgT7Hg+jUOD0YwPx3uo1c
         mmf6WL2Sl19izU7k6yPd7MACzrq6tz9Sg2Zi8JMIcEGFq7DhA4E++xQAlb9G+NwIeqfj
         a2gA==
X-Forwarded-Encrypted: i=1; AJvYcCWSTJI/Wv1LyMHMMgvabLgtfht07DpEKaA2et/HhmwV5231dlMsLQ9W4lK2btmoBz1PCBWe9LEXnXDPpcLhe23E2+aVr9nnyaOReVuX
X-Gm-Message-State: AOJu0YxhZ1kKzk4L+vGhvX9a0VgZvl4fRFuxzrcHVWVTsT8z3Uq7ED29
	d+WBOpu3wFc/hWbBUySTvn3vjUqIsKqT2r0gb3aufbExh76Ai6IblWY9FwWeNI7pA6q1nK4CDwo
	uq9UKy6d3gArcwrlHgdbQZpDhL0k8NK+c24L0
X-Google-Smtp-Source: AGHT+IFsQcKHyP28uWVcrlW4h2tyYXKvjJGcqJ9fm224GrZ5xXpHACWdB9BeRTGwkeXGJ2yqTYjtxASYez2n61NSBbE=
X-Received: by 2002:a05:6402:50d4:b0:58b:93:b623 with SMTP id
 4fb4d7f45d1cf-5ac2ca7f225mr247791a12.5.1721918121258; Thu, 25 Jul 2024
 07:35:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240724-kasan-tsbrcu-v2-0-45f898064468@google.com>
 <20240724-kasan-tsbrcu-v2-2-45f898064468@google.com> <9e05f9be-9e75-4b4d-84a4-1da52591574b@suse.cz>
In-Reply-To: <9e05f9be-9e75-4b4d-84a4-1da52591574b@suse.cz>
From: Jann Horn <jannh@google.com>
Date: Thu, 25 Jul 2024 16:34:44 +0200
Message-ID: <CAG48ez0wJ51FnSRGtcjJrBB5iuEh4LS+1v7MNnSxS5JFeVy5-w@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] slub: Introduce CONFIG_SLUB_RCU_DEBUG
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>, Alexander Potapenko <glider@google.com>, 
	Andrey Konovalov <andreyknvl@gmail.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Vincenzo Frascino <vincenzo.frascino@arm.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>, David Rientjes <rientjes@google.com>, 
	Joonsoo Kim <iamjoonsoo.kim@lge.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Hyeonggon Yoo <42.hyeyoo@gmail.com>, Marco Elver <elver@google.com>, kasan-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 25, 2024 at 3:28=E2=80=AFPM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
> On 7/24/24 6:34 PM, Jann Horn wrote:
> > Currently, KASAN is unable to catch use-after-free in SLAB_TYPESAFE_BY_=
RCU
> > slabs because use-after-free is allowed within the RCU grace period by
> > design.
> >
> > Add a SLUB debugging feature which RCU-delays every individual
> > kmem_cache_free() before either actually freeing the object or handing =
it
> > off to KASAN, and change KASAN to poison freed objects as normal when t=
his
> > option is enabled.
> >
> > Note that this creates an aligned 16-byte area in the middle of the sla=
b
> > metadata area, which kinda sucks but seems to be necessary in order to =
be
> > able to store an rcu_head in there that can be unpoisoned while the RCU
> > callback is pending.
>
> An alternative could be a head-less variant of kfree_rcu_mightsleep() tha=
t
> would fail instead of go to reclaim if it can't allocate, and upon failur=
e
> we would fall back ot the old behavior and give up on checking that objec=
t?

Yes, true, that would be an option... behaving differently under
memory pressure seems a little weird to me, but it would probably do
the job...

I've now tried implementing it roughly as you suggested; the diffstat
for that (on top of the existing series) looks like this:

 include/linux/kasan.h | 24 +++++++++---------------
 mm/kasan/common.c     | 23 +++++++----------------
 mm/slab.h             |  3 ---
 mm/slub.c             | 46 +++++++++++++++++++---------------------------
 4 files changed, 35 insertions(+), 61 deletions(-)

Basically it gets rid of all the plumbing I added to stuff more things
into the metadata area, but it has to add a flag to kasan_slab_free()
to tell it whether the call is happening after RCU delay or not.

I'm changing slab_free_hook() to allocate an instance of the struct

struct rcu_delayed_free {
  struct rcu_head head;
  void *object;
};

with kmalloc(sizeof(*delayed_free), GFP_NOWAIT), and then if that
works, I use that to RCU-delay the freeing.


I think this looks a bit nicer than my original version; I'll go run
the test suite and then send it out as v3.


> But maybe it's just too complicated and we just pay the overhead. At leas=
t
> this doesn't concern kmalloc caches with their power-of-two alignment
> guarantees where extra metadata blows things up more.

If we wanted to compress the slab metadata for this down a bit, we
could probably also overlap the out-of-line freepointer with the
rcu_head, since the freepointer can't be in use while the rcu_head is
active... but I figured that since this is a debug feature mainly
intended for ASAN builds, keeping things simple is more important.

> > (metadata_access_enable/disable doesn't work here because while the RCU
> > callback is pending, it will be accessed by asynchronous RCU processing=
.)
> > To be able to re-poison the area after the RCU callback is done executi=
ng,
> > a new helper kasan_poison_range_as_redzone() is necessary.
> >
> > For now I've configured Kconfig.debug to default-enable this feature in=
 the
> > KASAN GENERIC and SW_TAGS modes; I'm not enabling it by default in HW_T=
AGS
> > mode because I'm not sure if it might have unwanted performance degrada=
tion
> > effects there.
> >
> > Note that this is mostly useful with KASAN in the quarantine-based GENE=
RIC
> > mode; SLAB_TYPESAFE_BY_RCU slabs are basically always also slabs with a
> > ->ctor, and KASAN's assign_tag() currently has to assign fixed tags for
> > those, reducing the effectiveness of SW_TAGS/HW_TAGS mode.
> > (A possible future extension of this work would be to also let SLUB cal=
l
> > the ->ctor() on every allocation instead of only when the slab page is
> > allocated; then tag-based modes would be able to assign new tags on eve=
ry
> > reallocation.)
> >
> > Signed-off-by: Jann Horn <jannh@google.com>
>
> Acked-by: Vlastimil Babka <vbabka@suse.cz> #slab
>
> ...
>
> > --- a/mm/slab_common.c
> > +++ b/mm/slab_common.c
> > @@ -450,6 +450,18 @@ static void slab_caches_to_rcu_destroy_workfn(stru=
ct work_struct *work)
> >
> >  static int shutdown_cache(struct kmem_cache *s)
> >  {
> > +     if (IS_ENABLED(CONFIG_SLUB_RCU_DEBUG) &&
> > +         (s->flags & SLAB_TYPESAFE_BY_RCU)) {
> > +             /*
> > +              * Under CONFIG_SLUB_RCU_DEBUG, when objects in a
> > +              * SLAB_TYPESAFE_BY_RCU slab are freed, SLUB will interna=
lly
> > +              * defer their freeing with call_rcu().
> > +              * Wait for such call_rcu() invocations here before actua=
lly
> > +              * destroying the cache.
> > +              */
> > +             rcu_barrier();
> > +     }
>
> I think once we have the series [1] settled (patch 5/6 specifically), the
> delayed destruction could handle this case too?
>
> [1]
> https://lore.kernel.org/linux-mm/20240715-b4-slab-kfree_rcu-destroy-v1-0-=
46b2984c2205@suse.cz/

Ah, thanks for the pointer, I hadn't seen that one.


> > +
> >       /* free asan quarantined objects */
> >       kasan_cache_shutdown(s);
> >
> > diff --git a/mm/slub.c b/mm/slub.c
> > index 34724704c52d..999afdc1cffb 100644
>
>

