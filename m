Return-Path: <linux-kernel+bounces-262750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 527E293CC30
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 02:44:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D32531F21A73
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 00:44:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2F27EC7;
	Fri, 26 Jul 2024 00:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TlX27JKA"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DAA0442F
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 00:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721954648; cv=none; b=WHv42AKSR2fAlCD5zXlgYXXqgzMiva+1lOe62Yys0QD7G6PhinbdFkOLVJ1jeyA1FtHmSlW3pSzsjMQEYvsSRFXoZaMRrxuN3wPO7vNZC2QWHmWhsDv6uLcT/Cq2PBbkUMQ6ZS7sH6OVl/EiFb/49RSDWMctioRUlx+yr2bNG0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721954648; c=relaxed/simple;
	bh=c0Th0mLV8uUo17LIL/AjYHS2RsTarK1zNMqK+Ajv0W0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TYfJfwkHBoho0A/jCUq47k64NGwbbo5gqkZnnxJr9/bjkxqR1Kjs1lkmsQ3cINcC1R6MvSqmDZsX0MQvGkMWJgr6YmLaVeN0bSkGBYB7TDVjf4uDye/Jquq+C7iduFZ/Hq5jdb3w4C7CKxEOUcK3Apgo5mA6E8qz+Qe7D0GBh7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TlX27JKA; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-42808baddf9so9196525e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 17:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721954645; x=1722559445; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qWLLE86qSUx/Olt4aDlaYWvMRcyjVLxgebJsy4G4sv8=;
        b=TlX27JKAAQWy4PNtBR+C0qQCIWPGYSe/Yibk9Z9r87LOTaLtz+g61J7DZbGtHqNVxC
         AzuvuYdo3oxdTIuuQvVKPyagvtK0KC1AsfeVuq+3SwHBNyDlK9rGzXTvRd3BVvS2riSl
         on1NXq4AZ0G4Qs1NeDg5Ae0XPho6GmPPmi85yoZfloga6gRjq/Bz7xWtzN5ZxQZ4nVky
         8mqGXhDyVTscaWsGLZQC+6cfoMoIdLD8fjMIiFh2+E6PnWo38qWcuAVrNJJ+tgm8LTG1
         3zXeO5RIAk0hg5SYCLspzJQhitCzGnOdIHQt+ISKGWpvef3ETCTktQf10ehkOrlKzZja
         7nwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721954645; x=1722559445;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qWLLE86qSUx/Olt4aDlaYWvMRcyjVLxgebJsy4G4sv8=;
        b=JPJAN+yRfwydPMR8YiHsllHE6CV0KjmERS5of8DGdsYVgks/Iho9We37goxzl90CR0
         pDrre9U1ixThWQ6Jas+nUabUmBg7aSV7Z3uHmmzn67O4cEAT+ucREcw/i5eTDlG+Zpl2
         ejT1PG9AQuEBVC0ZRvLF4d01ZbjMe9I0qbBWwR3T+ZbZoLHV5+6qzcdEd/3Pu/cIHl5h
         9UlSS2RDqW/kem5GJGbpRKVOsS2eiwav6/CQhbTRKQQwL6Wo7XZosUj7Jd0rdwrK3npC
         DfxM7P/aQSy53YXsykVGFbVa/CweWokvHb94YLkc24/FN1GhcjSG5CmbAwGtHRuv+ZOw
         Cdwg==
X-Forwarded-Encrypted: i=1; AJvYcCXzTfjCUX1vE+Xo9ULxdKHzqsqhSnBUZZYpwuIAAdV5KF6Ou2BS0bpuQPGu+aH/xpm/A+vU4YQGhTstHwUY/YPTrlU8gpq4Xeulregv
X-Gm-Message-State: AOJu0YxXmRiqMoTiCmGBIb9jiEcc67W780s+x/ncKH5fUFJUVNkkqzxr
	kdvH5eFWHNmygTJz7/to0fXTIsmvxS2sJWSAHDOb2fSPnqksGT0fpxoc0UK3lCF7gMjZKoEwLMX
	OOxIXh5oXOMug4Mt8G4Du9n60jt4=
X-Google-Smtp-Source: AGHT+IHcafIQ5teDASs1UNLISNfxx6zvEfFKVdysTmE0/SFNJKndkMStbPu7X3ImBd6XnDc0QWAYU5xyuU+ZECnSCfc=
X-Received: by 2002:adf:f18b:0:b0:367:f059:4c55 with SMTP id
 ffacd0b85a97d-36b363d54demr3001273f8f.26.1721954644724; Thu, 25 Jul 2024
 17:44:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240725-kasan-tsbrcu-v3-0-51c92f8f1101@google.com> <20240725-kasan-tsbrcu-v3-2-51c92f8f1101@google.com>
In-Reply-To: <20240725-kasan-tsbrcu-v3-2-51c92f8f1101@google.com>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Fri, 26 Jul 2024 02:43:53 +0200
Message-ID: <CA+fCnZc1ct_Dg7_Zw+2z-EOv_oC4occ-ru-o6-83XYQneBxpwA@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] slub: Introduce CONFIG_SLUB_RCU_DEBUG
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

On Thu, Jul 25, 2024 at 5:32=E2=80=AFPM Jann Horn <jannh@google.com> wrote:
>
> Currently, KASAN is unable to catch use-after-free in SLAB_TYPESAFE_BY_RC=
U
> slabs because use-after-free is allowed within the RCU grace period by
> design.
>
> Add a SLUB debugging feature which RCU-delays every individual
> kmem_cache_free() before either actually freeing the object or handing it
> off to KASAN, and change KASAN to poison freed objects as normal when thi=
s
> option is enabled.
>
> For now I've configured Kconfig.debug to default-enable this feature in t=
he
> KASAN GENERIC and SW_TAGS modes; I'm not enabling it by default in HW_TAG=
S
> mode because I'm not sure if it might have unwanted performance degradati=
on
> effects there.
>
> Note that this is mostly useful with KASAN in the quarantine-based GENERI=
C
> mode; SLAB_TYPESAFE_BY_RCU slabs are basically always also slabs with a
> ->ctor, and KASAN's assign_tag() currently has to assign fixed tags for
> those, reducing the effectiveness of SW_TAGS/HW_TAGS mode.
> (A possible future extension of this work would be to also let SLUB call
> the ->ctor() on every allocation instead of only when the slab page is
> allocated; then tag-based modes would be able to assign new tags on every
> reallocation.)
>
> Signed-off-by: Jann Horn <jannh@google.com>

Acked-by: Andrey Konovalov <andreyknvl@gmail.com>

But see some nits below.

Thank you!

> ---
>  include/linux/kasan.h | 14 ++++++----
>  mm/Kconfig.debug      | 29 ++++++++++++++++++++
>  mm/kasan/common.c     | 13 +++++----
>  mm/kasan/kasan_test.c | 44 +++++++++++++++++++++++++++++
>  mm/slab_common.c      | 12 ++++++++
>  mm/slub.c             | 76 +++++++++++++++++++++++++++++++++++++++++++++=
------
>  6 files changed, 170 insertions(+), 18 deletions(-)
>
> diff --git a/include/linux/kasan.h b/include/linux/kasan.h
> index ebd93c843e78..c64483d3e2bd 100644
> --- a/include/linux/kasan.h
> +++ b/include/linux/kasan.h
> @@ -186,12 +186,15 @@ static __always_inline bool kasan_slab_pre_free(str=
uct kmem_cache *s,
>  }
>
>  bool __kasan_slab_free(struct kmem_cache *s, void *object,
> -                       unsigned long ip, bool init);
> +                       unsigned long ip, bool init, bool after_rcu_delay=
);
>  static __always_inline bool kasan_slab_free(struct kmem_cache *s,
> -                                               void *object, bool init)
> +                                               void *object, bool init,
> +                                               bool after_rcu_delay)
>  {
> -       if (kasan_enabled())
> -               return __kasan_slab_free(s, object, _RET_IP_, init);
> +       if (kasan_enabled()) {
> +               return __kasan_slab_free(s, object, _RET_IP_, init,
> +                               after_rcu_delay);
> +       }
>         return false;
>  }
>
> @@ -387,7 +390,8 @@ static inline bool kasan_slab_pre_free(struct kmem_ca=
che *s, void *object)
>         return false;
>  }
>
> -static inline bool kasan_slab_free(struct kmem_cache *s, void *object, b=
ool init)
> +static inline bool kasan_slab_free(struct kmem_cache *s, void *object,
> +                                  bool init, bool after_rcu_delay)
>  {
>         return false;
>  }
> diff --git a/mm/Kconfig.debug b/mm/Kconfig.debug
> index afc72fde0f03..0c088532f5a7 100644
> --- a/mm/Kconfig.debug
> +++ b/mm/Kconfig.debug
> @@ -70,6 +70,35 @@ config SLUB_DEBUG_ON
>           off in a kernel built with CONFIG_SLUB_DEBUG_ON by specifying
>           "slab_debug=3D-".
>
> +config SLUB_RCU_DEBUG
> +       bool "Make use-after-free detection possible in TYPESAFE_BY_RCU c=
aches"

Perhaps, it makes sense to point out that is related to KASAN's
use-after-free detection in the option description.

> +       depends on SLUB_DEBUG

Do we need depends on KASAN?

> +       default KASAN_GENERIC || KASAN_SW_TAGS
> +       help
> +         Make SLAB_TYPESAFE_BY_RCU caches behave approximately as if the=
 cache
> +         was not marked as SLAB_TYPESAFE_BY_RCU and every caller used
> +         kfree_rcu() instead.
> +
> +         This is intended for use in combination with KASAN, to enable K=
ASAN to
> +         detect use-after-free accesses in such caches.
> +         (KFENCE is able to do that independent of this flag.)
> +
> +         This might degrade performance.
> +         Unfortunately this also prevents a very specific bug pattern fr=
om
> +         triggering (insufficient checks against an object being recycle=
d
> +         within the RCU grace period); so this option can be turned off =
even on
> +         KASAN builds, in case you want to test for such a bug.
> +
> +         If you're using this for testing bugs / fuzzing and care about
> +         catching all the bugs WAY more than performance, you might want=
 to
> +         also turn on CONFIG_RCU_STRICT_GRACE_PERIOD.
> +
> +         WARNING:
> +         This is designed as a debugging feature, not a security feature=
.
> +         Objects are sometimes recycled without RCU delay under memory p=
ressure.
> +
> +         If unsure, say N.
> +
>  config PAGE_OWNER
>         bool "Track page owner"
>         depends on DEBUG_KERNEL && STACKTRACE_SUPPORT
> diff --git a/mm/kasan/common.c b/mm/kasan/common.c
> index 7c7fc6ce7eb7..d92cb2e9189d 100644
> --- a/mm/kasan/common.c
> +++ b/mm/kasan/common.c
> @@ -238,7 +238,8 @@ static enum free_validation_result check_slab_free(st=
ruct kmem_cache *cache,
>  }
>
>  static inline bool poison_slab_object(struct kmem_cache *cache, void *ob=
ject,
> -                                     unsigned long ip, bool init)
> +                                     unsigned long ip, bool init,
> +                                     bool after_rcu_delay)
>  {
>         void *tagged_object =3D object;
>         enum free_validation_result valid =3D check_slab_free(cache, obje=
ct, ip);
> @@ -251,7 +252,8 @@ static inline bool poison_slab_object(struct kmem_cac=
he *cache, void *object,
>         object =3D kasan_reset_tag(object);
>
>         /* RCU slabs could be legally used after free within the RCU peri=
od. */
> -       if (unlikely(cache->flags & SLAB_TYPESAFE_BY_RCU))
> +       if (unlikely(cache->flags & SLAB_TYPESAFE_BY_RCU) &&
> +           !after_rcu_delay)

This can be kept on the same line.

>                 return false;
>
>         kasan_poison(object, round_up(cache->object_size, KASAN_GRANULE_S=
IZE),
> @@ -270,7 +272,8 @@ bool __kasan_slab_pre_free(struct kmem_cache *cache, =
void *object,
>  }
>
>  bool __kasan_slab_free(struct kmem_cache *cache, void *object,
> -                               unsigned long ip, bool init)
> +                               unsigned long ip, bool init,
> +                               bool after_rcu_delay)
>  {
>         if (is_kfence_address(object))
>                 return false;
> @@ -280,7 +283,7 @@ bool __kasan_slab_free(struct kmem_cache *cache, void=
 *object,
>          * freelist. The object will thus never be allocated again and it=
s
>          * metadata will never get released.
>          */
> -       if (poison_slab_object(cache, object, ip, init))
> +       if (poison_slab_object(cache, object, ip, init, after_rcu_delay))
>                 return true;
>
>         /*
> @@ -535,7 +538,7 @@ bool __kasan_mempool_poison_object(void *ptr, unsigne=
d long ip)
>                 return false;
>
>         slab =3D folio_slab(folio);
> -       return !poison_slab_object(slab->slab_cache, ptr, ip, false);
> +       return !poison_slab_object(slab->slab_cache, ptr, ip, false, fals=
e);
>  }
>
>  void __kasan_mempool_unpoison_object(void *ptr, size_t size, unsigned lo=
ng ip)
> diff --git a/mm/kasan/kasan_test.c b/mm/kasan/kasan_test.c
> index 7b32be2a3cf0..cba782a4b072 100644
> --- a/mm/kasan/kasan_test.c
> +++ b/mm/kasan/kasan_test.c
> @@ -996,6 +996,49 @@ static void kmem_cache_invalid_free(struct kunit *te=
st)
>         kmem_cache_destroy(cache);
>  }
>
> +static void kmem_cache_rcu_uaf(struct kunit *test)
> +{
> +       char *p;
> +       size_t size =3D 200;
> +       struct kmem_cache *cache;
> +
> +       KASAN_TEST_NEEDS_CONFIG_ON(test, CONFIG_SLUB_RCU_DEBUG);
> +
> +       cache =3D kmem_cache_create("test_cache", size, 0, SLAB_TYPESAFE_=
BY_RCU,
> +                                 NULL);
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, cache);
> +
> +       p =3D kmem_cache_alloc(cache, GFP_KERNEL);
> +       if (!p) {
> +               kunit_err(test, "Allocation failed: %s\n", __func__);
> +               kmem_cache_destroy(cache);
> +               return;
> +       }
> +       *p =3D 1;
> +
> +       rcu_read_lock();
> +
> +       /* Free the object - this will internally schedule an RCU callbac=
k. */
> +       kmem_cache_free(cache, p);
> +
> +       /* We should still be allowed to access the object at this point =
because

Empty line after /* here and below.



> +        * the cache is SLAB_TYPESAFE_BY_RCU and we've been in an RCU rea=
d-side
> +        * critical section since before the kmem_cache_free().
> +        */
> +       READ_ONCE(*p);
> +
> +       rcu_read_unlock();
> +
> +       /* Wait for the RCU callback to execute; after this, the object s=
hould
> +        * have actually been freed from KASAN's perspective.
> +        */
> +       rcu_barrier();
> +
> +       KUNIT_EXPECT_KASAN_FAIL(test, READ_ONCE(*p));
> +
> +       kmem_cache_destroy(cache);
> +}
> +
>  static void empty_cache_ctor(void *object) { }
>
>  static void kmem_cache_double_destroy(struct kunit *test)
> @@ -1937,6 +1980,7 @@ static struct kunit_case kasan_kunit_test_cases[] =
=3D {
>         KUNIT_CASE(kmem_cache_oob),
>         KUNIT_CASE(kmem_cache_double_free),
>         KUNIT_CASE(kmem_cache_invalid_free),
> +       KUNIT_CASE(kmem_cache_rcu_uaf),
>         KUNIT_CASE(kmem_cache_double_destroy),
>         KUNIT_CASE(kmem_cache_accounted),
>         KUNIT_CASE(kmem_cache_bulk),
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index 1560a1546bb1..19511e34017b 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -450,6 +450,18 @@ static void slab_caches_to_rcu_destroy_workfn(struct=
 work_struct *work)
>
>  static int shutdown_cache(struct kmem_cache *s)
>  {
> +       if (IS_ENABLED(CONFIG_SLUB_RCU_DEBUG) &&
> +           (s->flags & SLAB_TYPESAFE_BY_RCU)) {
> +               /*
> +                * Under CONFIG_SLUB_RCU_DEBUG, when objects in a
> +                * SLAB_TYPESAFE_BY_RCU slab are freed, SLUB will interna=
lly
> +                * defer their freeing with call_rcu().
> +                * Wait for such call_rcu() invocations here before actua=
lly
> +                * destroying the cache.
> +                */
> +               rcu_barrier();
> +       }
> +
>         /* free asan quarantined objects */
>         kasan_cache_shutdown(s);
>
> diff --git a/mm/slub.c b/mm/slub.c
> index 34724704c52d..f44eec209e3e 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -2144,15 +2144,26 @@ static inline void memcg_slab_free_hook(struct km=
em_cache *s, struct slab *slab,
>  }
>  #endif /* CONFIG_MEMCG_KMEM */
>
> +#ifdef CONFIG_SLUB_RCU_DEBUG
> +static void slab_free_after_rcu_debug(struct rcu_head *rcu_head);
> +
> +struct rcu_delayed_free {
> +       struct rcu_head head;
> +       void *object;
> +};
> +#endif
> +
>  /*
>   * Hooks for other subsystems that check memory allocations. In a typica=
l
>   * production configuration these hooks all should produce no code at al=
l.
>   *
>   * Returns true if freeing of the object can proceed, false if its reuse
> - * was delayed by KASAN quarantine, or it was returned to KFENCE.
> + * was delayed by CONFIG_SLUB_RCU_DEBUG or KASAN quarantine, or it was r=
eturned
> + * to KFENCE.
>   */
>  static __always_inline
> -bool slab_free_hook(struct kmem_cache *s, void *x, bool init)
> +bool slab_free_hook(struct kmem_cache *s, void *x, bool init,
> +                   bool after_rcu_delay)
>  {
>         kmemleak_free_recursive(x, s->flags);
>         kmsan_slab_free(s, x);
> @@ -2163,7 +2174,7 @@ bool slab_free_hook(struct kmem_cache *s, void *x, =
bool init)
>                 debug_check_no_obj_freed(x, s->object_size);
>
>         /* Use KCSAN to help debug racy use-after-free. */
> -       if (!(s->flags & SLAB_TYPESAFE_BY_RCU))
> +       if (!(s->flags & SLAB_TYPESAFE_BY_RCU) || after_rcu_delay)
>                 __kcsan_check_access(x, s->object_size,
>                                      KCSAN_ACCESS_WRITE | KCSAN_ACCESS_AS=
SERT);
>
> @@ -2177,6 +2188,28 @@ bool slab_free_hook(struct kmem_cache *s, void *x,=
 bool init)
>         if (kasan_slab_pre_free(s, x))
>                 return false;
>
> +#ifdef CONFIG_SLUB_RCU_DEBUG
> +       if ((s->flags & SLAB_TYPESAFE_BY_RCU) && !after_rcu_delay) {
> +               struct rcu_delayed_free *delayed_free;
> +
> +               delayed_free =3D kmalloc(sizeof(*delayed_free), GFP_NOWAI=
T);
> +               if (delayed_free) {
> +                       /*
> +                        * Let KASAN track our call stack as a "related w=
ork
> +                        * creation", just like if the object had been fr=
eed
> +                        * normally via kfree_rcu().
> +                        * We have to do this manually because the rcu_he=
ad is
> +                        * not located inside the object.
> +                        */
> +                       kasan_record_aux_stack_noalloc(x);
> +
> +                       delayed_free->object =3D x;
> +                       call_rcu(&delayed_free->head, slab_free_after_rcu=
_debug);
> +                       return false;
> +               }
> +       }
> +#endif /* CONFIG_SLUB_RCU_DEBUG */
> +
>         /*
>          * As memory initialization might be integrated into KASAN,
>          * kasan_slab_free and initialization memset's must be
> @@ -2200,7 +2233,7 @@ bool slab_free_hook(struct kmem_cache *s, void *x, =
bool init)
>                        s->size - inuse - rsize);
>         }
>         /* KASAN might put x into memory quarantine, delaying its reuse. =
*/
> -       return !kasan_slab_free(s, x, init);
> +       return !kasan_slab_free(s, x, init, after_rcu_delay);
>  }
>
>  static __fastpath_inline
> @@ -2214,7 +2247,7 @@ bool slab_free_freelist_hook(struct kmem_cache *s, =
void **head, void **tail,
>         bool init;
>
>         if (is_kfence_address(next)) {
> -               slab_free_hook(s, next, false);
> +               slab_free_hook(s, next, false, false);
>                 return false;
>         }
>
> @@ -2229,7 +2262,7 @@ bool slab_free_freelist_hook(struct kmem_cache *s, =
void **head, void **tail,
>                 next =3D get_freepointer(s, object);
>
>                 /* If object's reuse doesn't have to be delayed */
> -               if (likely(slab_free_hook(s, object, init))) {
> +               if (likely(slab_free_hook(s, object, init, false))) {
>                         /* Move object to the new freelist */
>                         set_freepointer(s, object, *head);
>                         *head =3D object;
> @@ -4442,7 +4475,7 @@ void slab_free(struct kmem_cache *s, struct slab *s=
lab, void *object,
>         memcg_slab_free_hook(s, slab, &object, 1);
>         alloc_tagging_slab_free_hook(s, slab, &object, 1);
>
> -       if (likely(slab_free_hook(s, object, slab_want_init_on_free(s))))
> +       if (likely(slab_free_hook(s, object, slab_want_init_on_free(s), f=
alse)))
>                 do_slab_free(s, slab, object, object, 1, addr);
>  }
>
> @@ -4451,7 +4484,7 @@ void slab_free(struct kmem_cache *s, struct slab *s=
lab, void *object,
>  static noinline
>  void memcg_alloc_abort_single(struct kmem_cache *s, void *object)
>  {
> -       if (likely(slab_free_hook(s, object, slab_want_init_on_free(s))))
> +       if (likely(slab_free_hook(s, object, slab_want_init_on_free(s), f=
alse)))
>                 do_slab_free(s, virt_to_slab(object), object, object, 1, =
_RET_IP_);
>  }
>  #endif
> @@ -4470,6 +4503,33 @@ void slab_free_bulk(struct kmem_cache *s, struct s=
lab *slab, void *head,
>                 do_slab_free(s, slab, head, tail, cnt, addr);
>  }
>
> +#ifdef CONFIG_SLUB_RCU_DEBUG
> +static void slab_free_after_rcu_debug(struct rcu_head *rcu_head)
> +{
> +       struct rcu_delayed_free *delayed_free =3D
> +                       container_of(rcu_head, struct rcu_delayed_free, h=
ead);
> +       void *object =3D delayed_free->object;
> +       struct slab *slab =3D virt_to_slab(object);
> +       struct kmem_cache *s;
> +
> +       if (WARN_ON(is_kfence_address(rcu_head)))
> +               return;
> +
> +       /* find the object and the cache again */
> +       if (WARN_ON(!slab))
> +               return;
> +       s =3D slab->slab_cache;
> +       if (WARN_ON(!(s->flags & SLAB_TYPESAFE_BY_RCU)))
> +               return;
> +
> +       /* resume freeing */
> +       if (!slab_free_hook(s, object, slab_want_init_on_free(s), true))
> +               return;
> +       do_slab_free(s, slab, object, NULL, 1, _THIS_IP_);
> +       kfree(delayed_free);
> +}
> +#endif /* CONFIG_SLUB_RCU_DEBUG */
> +
>  #ifdef CONFIG_KASAN_GENERIC
>  void ___cache_free(struct kmem_cache *cache, void *x, unsigned long addr=
)
>  {
>
> --
> 2.45.2.1089.g2a221341d9-goog
>

