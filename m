Return-Path: <linux-kernel+bounces-272420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 884DB945BA7
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 11:57:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC22C1C21681
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 09:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1037E1DB456;
	Fri,  2 Aug 2024 09:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="M0luB21l"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 665421DB444
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 09:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722592652; cv=none; b=ikYR1awLlMdnwyn3g5Q+Qy218lq2E9fTG82vJ/KWekg48+vXnjQMVDHbSU5RZzto5bSUBnPVhyRe9PzCfp9FAyrZeRgXCyIrEVgTi+GS5xlwH54OHqMs+ZoBgjiWNcXpFJm6zIVld6VJH3OFhO/pU73Ptg74tS80K5VolGldv+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722592652; c=relaxed/simple;
	bh=jpd2eedHaYtYtufZdqrgfdF0T0QcJmj23Co5xNHf58Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lJzgVEkqBx9pgtulxwb4qIMLw+F/RwNePazs/mLeqkFvpeupQuUwoDpjb++8jpDWOl2XZLyYbUTZRBUF5KqNar4rO4S2yw1JPMeLdvvcqwaeInzYT7Svbp9jMJ1ETBPjSeKTH9ewT6dO2Jj7zyseJKCEpPNawtSKi3jACyhA1mY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=M0luB21l; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1fed726aefcso507085ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2024 02:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722592650; x=1723197450; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X0BnywGd6SV2Ld2s9hvxt+PjYwo9DGOXawX5efNb35U=;
        b=M0luB21lyJA1kXAytXsG8iLWtpZDDU4VRuqL6HEWKnzCRp4Y3OhVd/rEgPmcs6O9Wt
         wRHPTujBaiIceG2JZJ8Jn4O+x78wF5PI7aO8jC1deRHYwsRy0PBF3HCLEWtLVLxHepgm
         3Ob2P0XqwARx8cfS+5IWcMxKfrIz6KHjw6ldrDMIkqEZ+aZ4GhYVQM7fW6p5aLbZCwok
         wZsVqN7cPB5n3oaLYmEdZTnbWXZ3lSOENz7lLQKsSZHXX33Cm3LF9AAvYJ/5kxXjWyzH
         I4fQHv1oOaQmRbpTnjWmexfVTy7WR1+GQfvfoAgO3Pg8xJAujZ20iXtf+suaEkD3qENT
         8DLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722592650; x=1723197450;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X0BnywGd6SV2Ld2s9hvxt+PjYwo9DGOXawX5efNb35U=;
        b=ZDMwSZ9ZI4+dMguSpWPv1ECDRgl5sXA4LlWWg8tiPErsIb+OCrYe1VQmgEjBdDrl1J
         WtgImQc6Cr5n2y6hxx1RfxXnvUCnz2lPrtpvrGmT12RpyyNGLTg4l2xb+U75GEqM4oUu
         rcH/gzmzqw83fJBBU+yhQxuEmivMD5M8MMjDWcyzFLsAyooudfdFk0HzPI+VrGdsjFN1
         AoE4q4tUnNOwU/I3x3YyuFaGNLQzxUS1wNcEHgFI/84HHHlQ+CLmZwHBBMP2mkbItHCQ
         bxJK2WV5ubGGEU470UcaFDHA+qtrAppXs24gFUMoav0fekf74X2/OX5wUnPZt2FEkDmV
         DE5w==
X-Forwarded-Encrypted: i=1; AJvYcCVwllUU3dwTLUgTsv6Gw4RFTv57vwesKEGkFKzpavMoCQcoJfUUNm3a13OVLHLEzGesJlP2LWlCYsYRVh9tNpRGY0iAkdTVtoYRIt1b
X-Gm-Message-State: AOJu0Yw15h0hwk+yrsFOT7kbt/tVoYaF6WYXAbYDOfMxPyn/2eynQ11b
	9IGfssHYqe0/iTf8YzLKDiMF8HxFkrE6KqtdNHDxSUoqagS1yP+LiqyJPQAfEnaTNfohyp6IIaa
	OnwGN8v3AVefd+lzza1ytJ/aBmmqBrjM72r7C
X-Google-Smtp-Source: AGHT+IFlUjJDdyS1eLzxkU2trpY0BKCJLsfCCbCLusbYdoOVCdXuf1gFzo6ObDZkLnHI4AYmtGhzt+maiiNTOQLWG+Q=
X-Received: by 2002:a17:902:ec90:b0:1f7:3764:1e19 with SMTP id
 d9443c01a7336-1ff5cc4a18cmr1463485ad.20.1722592649125; Fri, 02 Aug 2024
 02:57:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240730-kasan-tsbrcu-v5-0-48d3cbdfccc5@google.com>
 <20240730-kasan-tsbrcu-v5-1-48d3cbdfccc5@google.com> <CA+fCnZfURBYNM+o6omuTJyCtL4GpeudpErEd26qde296ciVYuQ@mail.gmail.com>
In-Reply-To: <CA+fCnZfURBYNM+o6omuTJyCtL4GpeudpErEd26qde296ciVYuQ@mail.gmail.com>
From: Jann Horn <jannh@google.com>
Date: Fri, 2 Aug 2024 11:56:50 +0200
Message-ID: <CAG48ez0frEi5As0sJdMk1rfpnKRqNo=b7fF77Zf0cBHTFO_bjQ@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] kasan: catch invalid free before SLUB
 reinitializes the object
To: Andrey Konovalov <andreyknvl@gmail.com>
Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>, Alexander Potapenko <glider@google.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Christoph Lameter <cl@linux.com>, 
	Pekka Enberg <penberg@kernel.org>, David Rientjes <rientjes@google.com>, 
	Joonsoo Kim <iamjoonsoo.kim@lge.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Hyeonggon Yoo <42.hyeyoo@gmail.com>, 
	Marco Elver <elver@google.com>, kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 1, 2024 at 2:23=E2=80=AFAM Andrey Konovalov <andreyknvl@gmail.c=
om> wrote:
> On Tue, Jul 30, 2024 at 1:06=E2=80=AFPM Jann Horn <jannh@google.com> wrot=
e:
> >
> > Currently, when KASAN is combined with init-on-free behavior, the
> > initialization happens before KASAN's "invalid free" checks.
> >
> > More importantly, a subsequent commit will want to RCU-delay the actual
> > SLUB freeing of an object, and we'd like KASAN to still validate
> > synchronously that freeing the object is permitted. (Otherwise this
> > change will make the existing testcase kmem_cache_invalid_free fail.)
> >
> > So add a new KASAN hook that allows KASAN to pre-validate a
> > kmem_cache_free() operation before SLUB actually starts modifying the
> > object or its metadata.
>
> A few more minor comments below. With that:
>
> Reviewed-by: Andrey Konovalov <andreyknvl@gmail.com>
>
> Thank you!
>
> > Inside KASAN, this:
> >
> >  - moves checks from poison_slab_object() into check_slab_free()
> >  - moves kasan_arch_is_ready() up into callers of poison_slab_object()
> >  - removes "ip" argument of poison_slab_object() and __kasan_slab_free(=
)
> >    (since those functions no longer do any reporting)
>
> >  - renames check_slab_free() to check_slab_allocation()
>
> check_slab_allocation() is introduced in this patch, so technically
> you don't rename anything.

Right, I'll fix the commit message.

> > Acked-by: Vlastimil Babka <vbabka@suse.cz> #slub
> > Signed-off-by: Jann Horn <jannh@google.com>
> > ---
> >  include/linux/kasan.h | 43 ++++++++++++++++++++++++++++++++++---
> >  mm/kasan/common.c     | 59 +++++++++++++++++++++++++++++++------------=
--------
> >  mm/slub.c             |  7 ++++++
> >  3 files changed, 83 insertions(+), 26 deletions(-)
> >
> > diff --git a/include/linux/kasan.h b/include/linux/kasan.h
> > index 70d6a8f6e25d..34cb7a25aacb 100644
> > --- a/include/linux/kasan.h
> > +++ b/include/linux/kasan.h
> > @@ -172,19 +172,50 @@ static __always_inline void * __must_check kasan_=
init_slab_obj(
> >  {
> >         if (kasan_enabled())
> >                 return __kasan_init_slab_obj(cache, object);
> >         return (void *)object;
> >  }
> >
> > -bool __kasan_slab_free(struct kmem_cache *s, void *object,
> > -                       unsigned long ip, bool init);
> > +bool __kasan_slab_pre_free(struct kmem_cache *s, void *object,
> > +                       unsigned long ip);
> > +/**
> > + * kasan_slab_pre_free - Validate a slab object freeing request.
> > + * @object: Object to free.
> > + *
> > + * This function checks whether freeing the given object might be perm=
itted; it
> > + * checks things like whether the given object is properly aligned and=
 not
> > + * already freed.
> > + *
> > + * This function is only intended for use by the slab allocator.
> > + *
> > + * @Return true if freeing the object is known to be invalid; false ot=
herwise.
> > + */
>
> Let's reword this to:
>
> kasan_slab_pre_free - Check whether freeing a slab object is safe.
> @object: Object to be freed.
>
> This function checks whether freeing the given object is safe. It
> performs checks to detect double-free and invalid-free bugs and
> reports them.
>
> This function is intended only for use by the slab allocator.
>
> @Return true if freeing the object is not safe; false otherwise.

Ack, will apply this for v6. But I'll replace "not safe" with
"unsafe", and change "It performs checks to detect double-free and
invalid-free bugs and reports them" to "It may check for double-free
and invalid-free bugs and report them.", since KASAN only sometimes
performs such checks (depending on CONFIG_KASAN, kasan_enabled(),
kasan_arch_is_ready(), and so on).

> > +static __always_inline bool kasan_slab_pre_free(struct kmem_cache *s,
> > +                                               void *object)
> > +{
> > +       if (kasan_enabled())
> > +               return __kasan_slab_pre_free(s, object, _RET_IP_);
> > +       return false;
> > +}
> > +
> > +bool __kasan_slab_free(struct kmem_cache *s, void *object, bool init);
> > +/**
> > + * kasan_slab_free - Possibly handle slab object freeing.
> > + * @object: Object to free.
> > + *
> > + * This hook is called from the slab allocator to give KASAN a chance =
to take
> > + * ownership of the object and handle its freeing.
> > + * kasan_slab_pre_free() must have already been called on the same obj=
ect.
> > + *
> > + * @Return true if KASAN took ownership of the object; false otherwise=
.
> > + */
>
> kasan_slab_free - Poison, initialize, and quarantine a slab object.
> @object: Object to be freed.
> @init: Whether to initialize the object.
>
> This function poisons a slab object and saves a free stack trace for
> it, except for SLAB_TYPESAFE_BY_RCU caches.
>
> For KASAN modes that have integrated memory initialization
> (kasan_has_integrated_init() =3D=3D true), this function also initializes
> the object's memory. For other modes, the @init argument is ignored.

As an aside: Is this actually reliably true? It would be false for
kfence objects, but luckily we can't actually get kfence objects
passed to this function (which I guess maybe we should maybe document
here as part of the API). It would also be wrong if
__kasan_slab_free() can be reached while kasan_arch_is_ready() is
false, which I guess would happen if you ran a CONFIG_KASAN=3Dy kernel
on a powerpc machine without radix or something like that?

(And similarly I wonder if the check of kasan_has_integrated_init() in
slab_post_alloc_hook() is racy, but I haven't checked in which phase
of boot KASAN is enabled for HWASAN.)

But I guess that's out of scope for this series.

> For the Generic mode, this function might also quarantine the object.
> When this happens, KASAN will defer freeing the object to a later
> stage and handle it internally then. The return value indicates
> whether the object was quarantined.
>
> This function is intended only for use by the slab allocator.
>
> @Return true if KASAN quarantined the object; false otherwise.

Same thing as I wrote on patch 2/2: To me this seems like too much
implementation detail for the documentation of an API between
components of the kernel? I agree that the meaning of the "init"
argument is important to document here, and it should be documented
that the hook can take ownership of the object (and I guess it's fine
to mention that this is for quarantine purposes), but I would leave
out details about differences in behavior between KASAN modes.
Basically my heuristic here is that in my opinion, this header comment
should mostly describe as much of the function as SLUB has to know to
properly use it.

So I'd do something like:

<<<
kasan_slab_free - Poison, initialize, and quarantine a slab object.
@object: Object to be freed.
@init: Whether to initialize the object.

This function informs that a slab object has been freed and is not
supposed to be accessed anymore, except for objects in
SLAB_TYPESAFE_BY_RCU caches.

For KASAN modes that have integrated memory initialization
(kasan_has_integrated_init() =3D=3D true), this function also initializes
the object's memory. For other modes, the @init argument is ignored.

This function might also take ownership of the object to quarantine it.
When this happens, KASAN will defer freeing the object to a later
stage and handle it internally until then. The return value indicates
whether KASAN took ownership of the object.

This function is intended only for use by the slab allocator.

@Return true if KASAN took ownership of the object; false otherwise.
>>>

But if you disagree, I'll add your full comment as you suggested.

[...]
> > diff --git a/mm/kasan/common.c b/mm/kasan/common.c
> > index 85e7c6b4575c..8cede1ce00e1 100644
> > --- a/mm/kasan/common.c
> > +++ b/mm/kasan/common.c
> > @@ -205,59 +205,65 @@ void * __must_check __kasan_init_slab_obj(struct =
kmem_cache *cache,
> >         /* Tag is ignored in set_tag() without CONFIG_KASAN_SW/HW_TAGS =
*/
> >         object =3D set_tag(object, assign_tag(cache, object, true));
> >
> >         return (void *)object;
> >  }
> >
> > -static inline bool poison_slab_object(struct kmem_cache *cache, void *=
object,
> > -                                     unsigned long ip, bool init)
> > +/* returns true for invalid request */
>
> "Returns true when freeing the object is not safe."

ack, applied

