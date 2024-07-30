Return-Path: <linux-kernel+bounces-267280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F6EE940F87
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 12:35:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DB461F26F6F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 10:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3896019B3CC;
	Tue, 30 Jul 2024 10:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iWVLRewq"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B592B19D8AE
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 10:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722335471; cv=none; b=F4VIbigyGQxxNFbmvOY60DW932JnGHFQ3WAdDGiOBTHFIcs7eubM1upu/3IQw/K/OIMw5aPoMQHaash5ViBU3uixVpaDVZy0G7r/mzCN8muvGsTiUguTZlUocnvkbQPKD93+1dTDVLfp0KTbFoSuDnT3dupALAjgKFAsjZi/5Ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722335471; c=relaxed/simple;
	bh=uuaOP3Q1e7sJOPLNIRWdPJ+N+iBAz5ptB0ZslinQX6E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IIR23yPxoBN6c3h2ZULzaUgoH/C7+gzE0Go8kTY9/Smh4VjSPYSfsC3SrSfK6nD9g9FHiCZH2hRCscHnVimyk2uJiYMQYx5FGjb2+xdx7/yieQ1jCroaUuK+VeQ0su+dLCqEpPhvcLjoqR9LNlIPedy4GGnU58YhqIG7yemoxmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iWVLRewq; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5a18a5dbb23so9063a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 03:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722335468; x=1722940268; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uchJL9SjgJGVthCYhjfEyhLXgYgaYchmaG7P26alVxE=;
        b=iWVLRewqn8drF0OY4zRj0WgXzZBMbk6/Ni+pK9axM0zx2rzngnHZXOy/x9n2XeMXRK
         zG7R1xfdx3vajXHEhnUz6HrQciNaIg0r7sWD7HGhGUfUsd/0KZ0UT3SLG7CTpGYN3rBz
         d01XRPUj+Zyv+eb6/OOSF8ixsQmHuZFT1V0Bab0KN6cWa1p1yxPI6iFu9bu8MlH6AMmN
         c8bFVZVIV40s2FCKxsbMqk9BVez4BQdl4I1O/Ds6Ww+WKma6HEkliFlo73zjS/4yAq7O
         6MxNGGUbOcSmTv4BcEZUpll3CRoMItVLKU0/kneZaVeT0Qii6xo9C0UwAoDF0t9rdiF5
         BTBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722335468; x=1722940268;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uchJL9SjgJGVthCYhjfEyhLXgYgaYchmaG7P26alVxE=;
        b=H3U3OQKuI/GmyphEJaT8k+zVAD6V1hA1OnBOYI0Yt+KihoMueS4+RE1x7J3mT/vqxD
         KqMIJCk59Vf7yUjfybLsvL6diOO8r9GIQfv2epKHmYDNxFFMPVylo12CULI7G3tPUb59
         c2igmvR3Mxztz0h+T5BEz+jEeTiij7/TQzZUPi6Nyw4o8GGRkQzLIjUmfIL05bDV+4IB
         hWy/zA4IiQGo39yMAm1vB4qn7Q3TajukogHXU5bX5YKU5drQo9cl3gKP1Sq4eciVjScG
         7YGTq5kPh03deg5pG3of2NYACfjguXDnugr1RljTKyRSFqDA1OzATAiEnqASMYMJwd3r
         weRg==
X-Forwarded-Encrypted: i=1; AJvYcCWTlo6AWX0VW+ScFWHIIetVTRkA8xQEdxrpEx7WGqIdccaQjACMZnfa5vvweZezKhyIuy/dNG8fkv7ftWY4C6p6iTj+v6mBl1jsswUx
X-Gm-Message-State: AOJu0Yyf1VOPPLdU8265quKgGa/rfK896yHTMXGrltO43bgubGSG399/
	ECrRsgHe1w7DHokPWLReuUu3O4SC9Wa3eFaiayVzcEbyR0etcq+axnYY8CVWz/iYKl7w2oNc79a
	DJNcB9camPr2vcxZltWOSXhgxiej8T6vAsP5c
X-Google-Smtp-Source: AGHT+IGTePZTraOgozquZJjsziJbyowCBK/suYNSYNZtINniQU55nZ4K+gPzbIsWMZvQJca4e/9OzrUcfYqthvqOUTo=
X-Received: by 2002:a05:6402:268c:b0:58b:93:b624 with SMTP id
 4fb4d7f45d1cf-5b486ff3d5emr46614a12.1.1722335467220; Tue, 30 Jul 2024
 03:31:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240725-kasan-tsbrcu-v3-0-51c92f8f1101@google.com>
 <20240725-kasan-tsbrcu-v3-1-51c92f8f1101@google.com> <CA+fCnZe-x+JOUN1P-H-i0_3ys+XgpZBKU_zi06XBRfmN+OzO+w@mail.gmail.com>
In-Reply-To: <CA+fCnZe-x+JOUN1P-H-i0_3ys+XgpZBKU_zi06XBRfmN+OzO+w@mail.gmail.com>
From: Jann Horn <jannh@google.com>
Date: Tue, 30 Jul 2024 12:30:30 +0200
Message-ID: <CAG48ez2Ne7ZR1K2959s=wP2-t-V2LxCmg6_OJ+Tu58OvwV42ZA@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] kasan: catch invalid free before SLUB
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

On Fri, Jul 26, 2024 at 2:43=E2=80=AFAM Andrey Konovalov <andreyknvl@gmail.=
com> wrote:
> On Thu, Jul 25, 2024 at 5:32=E2=80=AFPM Jann Horn <jannh@google.com> wrot=
e:
> > Currently, when KASAN is combined with init-on-free behavior, the
> > initialization happens before KASAN's "invalid free" checks.
[...]
> > So add a new KASAN hook that allows KASAN to pre-validate a
> > kmem_cache_free() operation before SLUB actually starts modifying the
> > object or its metadata.
> >
> > Acked-by: Vlastimil Babka <vbabka@suse.cz> #slub
> > Signed-off-by: Jann Horn <jannh@google.com>
> > ---
> >  include/linux/kasan.h | 16 ++++++++++++++++
> >  mm/kasan/common.c     | 51 +++++++++++++++++++++++++++++++++++++++----=
--------
> >  mm/slub.c             |  7 +++++++
> >  3 files changed, 62 insertions(+), 12 deletions(-)
> >
> > diff --git a/include/linux/kasan.h b/include/linux/kasan.h
> > index 70d6a8f6e25d..ebd93c843e78 100644
> > --- a/include/linux/kasan.h
> > +++ b/include/linux/kasan.h
> > @@ -175,6 +175,16 @@ static __always_inline void * __must_check kasan_i=
nit_slab_obj(
> >         return (void *)object;
> >  }
> >
> > +bool __kasan_slab_pre_free(struct kmem_cache *s, void *object,
> > +                       unsigned long ip);
> > +static __always_inline bool kasan_slab_pre_free(struct kmem_cache *s,
> > +                                               void *object)
> > +{
> > +       if (kasan_enabled())
> > +               return __kasan_slab_pre_free(s, object, _RET_IP_);
> > +       return false;
> > +}
>
> Please add a documentation comment for this new hook; something like
> what we have for kasan_mempool_poison_pages() and some of the others.
> (I've been meaning to add them for all of them, but still didn't get
> around to that.)

Ack, done in v4.

> > +static inline bool poison_slab_object(struct kmem_cache *cache, void *=
object,
> > +                                     unsigned long ip, bool init)
> > +{
> > +       void *tagged_object =3D object;
> > +       enum free_validation_result valid =3D check_slab_free(cache, ob=
ject, ip);
>
> I believe we don't need check_slab_free() here, as it was already done
> in kasan_slab_pre_free()? Checking just kasan_arch_is_ready() and
> is_kfence_address() should save a bit on performance impact.
>
> Though if we remove check_slab_free() from here, we do need to add it
> to __kasan_mempool_poison_object().

Ack, changed in v4.

> > +
> > +       if (valid =3D=3D KASAN_FREE_IS_IGNORED)
> > +               return false;
> > +       if (valid =3D=3D KASAN_FREE_IS_INVALID)
> > +               return true;
> > +
> > +       object =3D kasan_reset_tag(object);
> > +
> > +       /* RCU slabs could be legally used after free within the RCU pe=
riod. */
> > +       if (unlikely(cache->flags & SLAB_TYPESAFE_BY_RCU))
> > +               return false;
>
> I vaguely recall there was some reason why this check was done before
> the kasan_byte_accessible() check, but I might be wrong. Could you try
> booting the kernel with only this patch applied to see if anything
> breaks?

I tried booting it to a graphical environment and running the kunit
tests, nothing immediately broke from what I can tell...

