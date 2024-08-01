Return-Path: <linux-kernel+bounces-270183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 42892943D15
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 02:50:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECF24282A79
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 00:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B83F2139D4;
	Thu,  1 Aug 2024 00:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BkwO/yeb"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA92157481
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 00:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722471789; cv=none; b=fcqZxwjDrd4Q/WWQcRdgsoD3qVJpXzfqh9+2DvVeatRdG3hCcXfNN5Vxop5VgaZXu7//468L8RUe90N04Nht7q7pTKXcolkyqwSJVizJDNM5DfuAmRGmPZUaGTDmlvhWlVzmqlO/Gem0gQ7AbYrU/9+qZU+sLot/UYR29TBhoko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722471789; c=relaxed/simple;
	bh=0xY4SrDep9i+3BjTp3D6xB0gxOmqatuOqPUyxSeznxE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PHbXBZ94+Rm9UA1qKBvpF5PFQc68/TbkP3odebRnVhod2DTFyEJvm6vluF1yaBW1XDOC1AhHSC7f7/MvtH590zTluqtNTSIbBXGj0elyBrz8XoiS7EkoE+BLgR3DF5VjjXAsCfsZbikniO6kYZBi+cmJLGHmqRbC6NzsFNZ5mZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BkwO/yeb; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-36868fcb919so3131083f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 17:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722471786; x=1723076586; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vsRe15f8SeekhA1unFJl3x8nWV4+YMvQOTBZActqfL4=;
        b=BkwO/yebkYyBQBVpb1u747ukK5rAVC5oh8h0LORGEkhMewKBBq8/8t1VL44WEAZk9P
         iSIH78IpFsMWkSh+oYXhKl7NFCHvrn0kJF5lBMJoqKLnerncx0Znhaqnv8jqebmLRKWC
         W5pnDoJTZ7Vkn4+4f8Sw7uM1WyabNYoTo0McP3/RiMtMgEveqMcO9SyfGvYF11qIu0Bv
         J1fakweFvcf/G0r6VnW+hrAqbsDGxM6aMCi6zhHnuP3X18n+w0F79d9v7lmx8NiKjxhd
         0grOKZNv2iAOQz7yxZ9lNT6OV1O6Gq+yQeM3WBAA47pXeiWf4gCS+Vaozy+qnteHF1T0
         BNLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722471786; x=1723076586;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vsRe15f8SeekhA1unFJl3x8nWV4+YMvQOTBZActqfL4=;
        b=oyJC1ZHp8u5dflecX2Le+4S+J0kyhaXe2n6v/bOT4M+xABEzsKRfaQLcDmFcipusvC
         M4zf9auuuuL5XAn/5NFJL1W4SyShJtzTqolZr1eARVvOKJ3U4dmy1LE0SQvSGnJId/FV
         dhzQfkBfYXZUTzu/xgYAUXXm375w+uxjXiihKab3jxTf9wfvjNqNv6GekPZ1mqgM3/V3
         lsiyOlkZAHLMb+RStZF5BmK82nNDBvIMfCZHPn4lqH5Fpx5gB7RGN1uWZSgckh7nECg7
         4K6X+6XJFKP5AUoezopY5fPPI2HWxUdRLtVstQJzHaMSH7W8rq+iDCEST3+xJ3iyC+Ub
         kfwQ==
X-Forwarded-Encrypted: i=1; AJvYcCX3pislNaQJicM2m6CjBmoebIPrC/44q/hD3BduO0dmwDzTJqAJS2Q02Ri9j6wYrr5rdYyVGYhS57S0VP3hP/yVU7o7nGlqtOKHZh4E
X-Gm-Message-State: AOJu0YyYq4wHl6eqbblR5JiBdDm7KTWH/ME56kcOhPromld+h8uitTvy
	kLzbMlWdOWjTfBmmbZSm+11bnfhQ0beaUTNzy7FeJ3DcocGTjcpVoQL05VOqhVFro1zDFl4QWbo
	26KBEpaCnof5Mg1+8Wp9dCjp7Npk=
X-Google-Smtp-Source: AGHT+IGwWhG32zlK/wsGtoQT5etLpgbP5OrnXTKZFx5x3tG3CWTCdTVVahU6VEOH6gbd9OrdRmgPBs5lJ71dOcDTP+g=
X-Received: by 2002:a05:6000:188:b0:367:9088:fecc with SMTP id
 ffacd0b85a97d-36baaca26cfmr431122f8f.7.1722471785502; Wed, 31 Jul 2024
 17:23:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240730-kasan-tsbrcu-v5-0-48d3cbdfccc5@google.com> <20240730-kasan-tsbrcu-v5-1-48d3cbdfccc5@google.com>
In-Reply-To: <20240730-kasan-tsbrcu-v5-1-48d3cbdfccc5@google.com>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Thu, 1 Aug 2024 02:22:54 +0200
Message-ID: <CA+fCnZfURBYNM+o6omuTJyCtL4GpeudpErEd26qde296ciVYuQ@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] kasan: catch invalid free before SLUB
 reinitializes the object
To: Jann Horn <jannh@google.com>
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

On Tue, Jul 30, 2024 at 1:06=E2=80=AFPM Jann Horn <jannh@google.com> wrote:
>
> Currently, when KASAN is combined with init-on-free behavior, the
> initialization happens before KASAN's "invalid free" checks.
>
> More importantly, a subsequent commit will want to RCU-delay the actual
> SLUB freeing of an object, and we'd like KASAN to still validate
> synchronously that freeing the object is permitted. (Otherwise this
> change will make the existing testcase kmem_cache_invalid_free fail.)
>
> So add a new KASAN hook that allows KASAN to pre-validate a
> kmem_cache_free() operation before SLUB actually starts modifying the
> object or its metadata.

A few more minor comments below. With that:

Reviewed-by: Andrey Konovalov <andreyknvl@gmail.com>

Thank you!

> Inside KASAN, this:
>
>  - moves checks from poison_slab_object() into check_slab_free()
>  - moves kasan_arch_is_ready() up into callers of poison_slab_object()
>  - removes "ip" argument of poison_slab_object() and __kasan_slab_free()
>    (since those functions no longer do any reporting)

>  - renames check_slab_free() to check_slab_allocation()

check_slab_allocation() is introduced in this patch, so technically
you don't rename anything.

> Acked-by: Vlastimil Babka <vbabka@suse.cz> #slub
> Signed-off-by: Jann Horn <jannh@google.com>
> ---
>  include/linux/kasan.h | 43 ++++++++++++++++++++++++++++++++++---
>  mm/kasan/common.c     | 59 +++++++++++++++++++++++++++++++--------------=
------
>  mm/slub.c             |  7 ++++++
>  3 files changed, 83 insertions(+), 26 deletions(-)
>
> diff --git a/include/linux/kasan.h b/include/linux/kasan.h
> index 70d6a8f6e25d..34cb7a25aacb 100644
> --- a/include/linux/kasan.h
> +++ b/include/linux/kasan.h
> @@ -172,19 +172,50 @@ static __always_inline void * __must_check kasan_in=
it_slab_obj(
>  {
>         if (kasan_enabled())
>                 return __kasan_init_slab_obj(cache, object);
>         return (void *)object;
>  }
>
> -bool __kasan_slab_free(struct kmem_cache *s, void *object,
> -                       unsigned long ip, bool init);
> +bool __kasan_slab_pre_free(struct kmem_cache *s, void *object,
> +                       unsigned long ip);
> +/**
> + * kasan_slab_pre_free - Validate a slab object freeing request.
> + * @object: Object to free.
> + *
> + * This function checks whether freeing the given object might be permit=
ted; it
> + * checks things like whether the given object is properly aligned and n=
ot
> + * already freed.
> + *
> + * This function is only intended for use by the slab allocator.
> + *
> + * @Return true if freeing the object is known to be invalid; false othe=
rwise.
> + */

Let's reword this to:

kasan_slab_pre_free - Check whether freeing a slab object is safe.
@object: Object to be freed.

This function checks whether freeing the given object is safe. It
performs checks to detect double-free and invalid-free bugs and
reports them.

This function is intended only for use by the slab allocator.

@Return true if freeing the object is not safe; false otherwise.

> +static __always_inline bool kasan_slab_pre_free(struct kmem_cache *s,
> +                                               void *object)
> +{
> +       if (kasan_enabled())
> +               return __kasan_slab_pre_free(s, object, _RET_IP_);
> +       return false;
> +}
> +
> +bool __kasan_slab_free(struct kmem_cache *s, void *object, bool init);
> +/**
> + * kasan_slab_free - Possibly handle slab object freeing.
> + * @object: Object to free.
> + *
> + * This hook is called from the slab allocator to give KASAN a chance to=
 take
> + * ownership of the object and handle its freeing.
> + * kasan_slab_pre_free() must have already been called on the same objec=
t.
> + *
> + * @Return true if KASAN took ownership of the object; false otherwise.
> + */

kasan_slab_free - Poison, initialize, and quarantine a slab object.
@object: Object to be freed.
@init: Whether to initialize the object.

This function poisons a slab object and saves a free stack trace for
it, except for SLAB_TYPESAFE_BY_RCU caches.

For KASAN modes that have integrated memory initialization
(kasan_has_integrated_init() =3D=3D true), this function also initializes
the object's memory. For other modes, the @init argument is ignored.

For the Generic mode, this function might also quarantine the object.
When this happens, KASAN will defer freeing the object to a later
stage and handle it internally then. The return value indicates
whether the object was quarantined.

This function is intended only for use by the slab allocator.

@Return true if KASAN quarantined the object; false otherwise.

>  static __always_inline bool kasan_slab_free(struct kmem_cache *s,
>                                                 void *object, bool init)
>  {
>         if (kasan_enabled())
> -               return __kasan_slab_free(s, object, _RET_IP_, init);
> +               return __kasan_slab_free(s, object, init);
>         return false;
>  }
>
>  void __kasan_kfree_large(void *ptr, unsigned long ip);
>  static __always_inline void kasan_kfree_large(void *ptr)
>  {
> @@ -368,12 +399,18 @@ static inline void kasan_poison_new_object(struct k=
mem_cache *cache,
>                                         void *object) {}
>  static inline void *kasan_init_slab_obj(struct kmem_cache *cache,
>                                 const void *object)
>  {
>         return (void *)object;
>  }
> +
> +static inline bool kasan_slab_pre_free(struct kmem_cache *s, void *objec=
t)
> +{
> +       return false;
> +}
> +
>  static inline bool kasan_slab_free(struct kmem_cache *s, void *object, b=
ool init)
>  {
>         return false;
>  }
>  static inline void kasan_kfree_large(void *ptr) {}
>  static inline void *kasan_slab_alloc(struct kmem_cache *s, void *object,
> diff --git a/mm/kasan/common.c b/mm/kasan/common.c
> index 85e7c6b4575c..8cede1ce00e1 100644
> --- a/mm/kasan/common.c
> +++ b/mm/kasan/common.c
> @@ -205,59 +205,65 @@ void * __must_check __kasan_init_slab_obj(struct km=
em_cache *cache,
>         /* Tag is ignored in set_tag() without CONFIG_KASAN_SW/HW_TAGS */
>         object =3D set_tag(object, assign_tag(cache, object, true));
>
>         return (void *)object;
>  }
>
> -static inline bool poison_slab_object(struct kmem_cache *cache, void *ob=
ject,
> -                                     unsigned long ip, bool init)
> +/* returns true for invalid request */

"Returns true when freeing the object is not safe."

> +static bool check_slab_allocation(struct kmem_cache *cache, void *object=
,
> +                                 unsigned long ip)
>  {
> -       void *tagged_object;
> -
> -       if (!kasan_arch_is_ready())
> -               return false;
> +       void *tagged_object =3D object;
>
> -       tagged_object =3D object;
>         object =3D kasan_reset_tag(object);
>
>         if (unlikely(nearest_obj(cache, virt_to_slab(object), object) !=
=3D object)) {
>                 kasan_report_invalid_free(tagged_object, ip, KASAN_REPORT=
_INVALID_FREE);
>                 return true;
>         }
>
> -       /* RCU slabs could be legally used after free within the RCU peri=
od. */
> -       if (unlikely(cache->flags & SLAB_TYPESAFE_BY_RCU))
> -               return false;
> -
>         if (!kasan_byte_accessible(tagged_object)) {
>                 kasan_report_invalid_free(tagged_object, ip, KASAN_REPORT=
_DOUBLE_FREE);
>                 return true;
>         }
>
> +       return false;
> +}
> +
> +static inline void poison_slab_object(struct kmem_cache *cache, void *ob=
ject,
> +                                     bool init)
> +{
> +       void *tagged_object =3D object;
> +
> +       object =3D kasan_reset_tag(object);
> +
> +       /* RCU slabs could be legally used after free within the RCU peri=
od. */
> +       if (unlikely(cache->flags & SLAB_TYPESAFE_BY_RCU))
> +               return;
> +
>         kasan_poison(object, round_up(cache->object_size, KASAN_GRANULE_S=
IZE),
>                         KASAN_SLAB_FREE, init);
>
>         if (kasan_stack_collection_enabled())
>                 kasan_save_free_info(cache, tagged_object);
> +}
>
> -       return false;
> +bool __kasan_slab_pre_free(struct kmem_cache *cache, void *object,
> +                               unsigned long ip)
> +{
> +       if (!kasan_arch_is_ready() || is_kfence_address(object))
> +               return false;
> +       return check_slab_allocation(cache, object, ip);
>  }
>
> -bool __kasan_slab_free(struct kmem_cache *cache, void *object,
> -                               unsigned long ip, bool init)
> +bool __kasan_slab_free(struct kmem_cache *cache, void *object, bool init=
)
>  {
> -       if (is_kfence_address(object))
> +       if (!kasan_arch_is_ready() || is_kfence_address(object))
>                 return false;
>
> -       /*
> -        * If the object is buggy, do not let slab put the object onto th=
e
> -        * freelist. The object will thus never be allocated again and it=
s
> -        * metadata will never get released.
> -        */
> -       if (poison_slab_object(cache, object, ip, init))
> -               return true;
> +       poison_slab_object(cache, object, init);
>
>         /*
>          * If the object is put into quarantine, do not let slab put the =
object
>          * onto the freelist for now. The object's metadata is kept until=
 the
>          * object gets evicted from quarantine.
>          */
> @@ -503,15 +509,22 @@ bool __kasan_mempool_poison_object(void *ptr, unsig=
ned long ip)
>                 kasan_poison(ptr, folio_size(folio), KASAN_PAGE_FREE, fal=
se);
>                 return true;
>         }
>
>         if (is_kfence_address(ptr))
>                 return false;
> +       if (!kasan_arch_is_ready())
> +               return true;

Hm, I think we had a bug here: the function should return true in both
cases. This seems reasonable: if KASAN is not checking the object, the
caller can do whatever they want with it.





>         slab =3D folio_slab(folio);
> -       return !poison_slab_object(slab->slab_cache, ptr, ip, false);
> +
> +       if (check_slab_allocation(slab->slab_cache, ptr, ip))
> +               return false;
> +
> +       poison_slab_object(slab->slab_cache, ptr, false);
> +       return true;
>  }
>
>  void __kasan_mempool_unpoison_object(void *ptr, size_t size, unsigned lo=
ng ip)
>  {
>         struct slab *slab;
>         gfp_t flags =3D 0; /* Might be executing under a lock. */
> diff --git a/mm/slub.c b/mm/slub.c
> index 3520acaf9afa..0c98b6a2124f 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -2223,12 +2223,19 @@ bool slab_free_hook(struct kmem_cache *s, void *x=
, bool init)
>                 __kcsan_check_access(x, s->object_size,
>                                      KCSAN_ACCESS_WRITE | KCSAN_ACCESS_AS=
SERT);
>
>         if (kfence_free(x))
>                 return false;
>
> +       /*
> +        * Give KASAN a chance to notice an invalid free operation before=
 we
> +        * modify the object.
> +        */
> +       if (kasan_slab_pre_free(s, x))
> +               return false;
> +
>         /*
>          * As memory initialization might be integrated into KASAN,
>          * kasan_slab_free and initialization memset's must be
>          * kept together to avoid discrepancies in behavior.
>          *
>          * The initialization memset's clear the object and the metadata,
>
> --
> 2.46.0.rc1.232.g9752f9e123-goog
>

