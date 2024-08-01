Return-Path: <linux-kernel+bounces-270187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39E5C943D1C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 02:51:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3CC91F218B2
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 00:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB897157E61;
	Thu,  1 Aug 2024 00:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dWgj6p8d"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A2EC157A7C
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 00:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722471800; cv=none; b=bm6/ZrdlkDgV5n6Sc1eECV6k0Jm2OcfY4MBNEa990S4gYIivY4+ezQdpPSLjM5pBJ1NfpztbFNS1kwp8/CdD1rNGzJh9reI/sRCYJzfDwpUTH51jaWvL//YnHTd4qmTbwn7on+V9XNtaozEBdvhn7Fo9+umDbZ2gtWzJ4+gkfCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722471800; c=relaxed/simple;
	bh=qXusB0LJpEaRx0q7SGOmH6OZfqW+VUZfCxxC+uuZ/C4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iT/B1MojMd1r3VbU/PVv4XhNo3ZzwlOKyJp+6jmn0bqHd39RpZ7SvncFalWdBpqy/N3Z33Sbp3FUeJe9W2mW8JFCIQAS5wA928BtBUC2W1fhSx7p7Dve6P0rr8eTaeJUGfN9QiNxzcJ488LFaisN/Hgb3X13vso0gvmNmR4S9dE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dWgj6p8d; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-428035c0bb2so8848825e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 17:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722471796; x=1723076596; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+/OWgCrKT8FaN/NojJFZkZVtPfuI+fAkVxQk1yUAr8I=;
        b=dWgj6p8d6H9ML96AdhGcc4lPmVciLz2nd9GCYFAe1q2Yh1SB3HKBgHL+hQJyFccNsQ
         kbBOmPauOakEmROg+Lrs0UabGB2H5VYiW2Sphb6dFBAPS81YbqPvbVdQ6axGgOUpUz+1
         Y1ycdxH3ukFRrfRDW/Z80SuFKD+c7zAbgmfmol4NpK/IM2lUW/A4iAfZ5kRPlXfVo7Fb
         E/IHuPTLthE3jKsBNp54AJMFp13ttRCD/hBAuysI2MWV506uNRWamQT6/YjXODNWVpcK
         MuQ+fecxiWKkUkD1FSZUHFOZkOSE8zKQXT/7Esa4s7svEA102ef7w+cP+Z4YOMBTW4SO
         6CKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722471796; x=1723076596;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+/OWgCrKT8FaN/NojJFZkZVtPfuI+fAkVxQk1yUAr8I=;
        b=gcSK0Sopx30cAv1KsYceukV9FSjvq5r1PUhK76lmM+9ipV9DEzunV4R7OEeroqvC2G
         QAjaC16LGHaYfGzIgoFpZBIjZSJr6rQJ5yUQpZWv/u5h9kg85H7ML3qOHdFjeGTphnb0
         DF9l9SDj2VA9PZGCx6jpNdMqa5I2NzhUB/p4ALtRE8S8d2VQdecnyZwBeuqsbfdKqw4F
         qK22n22V5pmriduwatLCjWhogdu7639uCGW4X/ECQ/VWJgqZlsdrRNaNevaBmcIZxhh4
         Ez1p+UE669B6tMsEv5kkn8SPHR/2cF1teh5FjS01beDkDhzBxlzUW3Chcw5xqbEK8WNs
         G2lA==
X-Forwarded-Encrypted: i=1; AJvYcCWAdw0r3S3RObdvnNDGlqFDRutwO7ct71bJ3aL+oXA+3PBhVf+lHJk1Ech3w9VPHawy5b32YkR1vtcl7V0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfnGkA0pvPLBDQphAtx9SefazyRMut/sbomGO8l26tTS38Ao7U
	BQvn33qjXJd+5I4SzYsscw+5leXrJhwpNvKRuI3k8wqRMShjCuaqGeuzjqN7btEH5NmENAWWEW5
	S3TwtsMHdxI1uZKbnG7vqiYLvnsA=
X-Google-Smtp-Source: AGHT+IHmphYZnFjIEZwAvtSFR7OZBfTm9mzLrM2O4s3KUvA3ATyoECit1idCL/q8p+TyNJKDZukLW0I/lNxbS2u08Zc=
X-Received: by 2002:a05:600c:4688:b0:426:698b:791f with SMTP id
 5b1f17b1804b1-428243e1dcemr46512705e9.3.1722471795367; Wed, 31 Jul 2024
 17:23:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240730-kasan-tsbrcu-v5-0-48d3cbdfccc5@google.com> <20240730-kasan-tsbrcu-v5-2-48d3cbdfccc5@google.com>
In-Reply-To: <20240730-kasan-tsbrcu-v5-2-48d3cbdfccc5@google.com>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Thu, 1 Aug 2024 02:23:04 +0200
Message-ID: <CA+fCnZeq8JGSkFwGitwSc3DbeuoXnoyvC7RgWh6XSG1CoWH=Zg@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] slub: Introduce CONFIG_SLUB_RCU_DEBUG
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

But see a comment below.

> ---
>  include/linux/kasan.h | 11 +++++---
>  mm/Kconfig.debug      | 30 ++++++++++++++++++++
>  mm/kasan/common.c     | 11 ++++----
>  mm/kasan/kasan_test.c | 46 +++++++++++++++++++++++++++++++
>  mm/slab_common.c      | 12 ++++++++
>  mm/slub.c             | 76 +++++++++++++++++++++++++++++++++++++++++++++=
------
>  6 files changed, 169 insertions(+), 17 deletions(-)
>
> diff --git a/include/linux/kasan.h b/include/linux/kasan.h
> index 34cb7a25aacb..0b952e11c7a0 100644
> --- a/include/linux/kasan.h
> +++ b/include/linux/kasan.h
> @@ -194,28 +194,30 @@ static __always_inline bool kasan_slab_pre_free(str=
uct kmem_cache *s,
>  {
>         if (kasan_enabled())
>                 return __kasan_slab_pre_free(s, object, _RET_IP_);
>         return false;
>  }
>
> -bool __kasan_slab_free(struct kmem_cache *s, void *object, bool init);
> +bool __kasan_slab_free(struct kmem_cache *s, void *object, bool init,
> +                      bool after_rcu_delay);

What do you think about renaming this argument to poison_rcu? I think
it makes the intention more clear from the KASAN's point of view.

>  /**
>   * kasan_slab_free - Possibly handle slab object freeing.
>   * @object: Object to free.

@poison_rcu - Whether to skip poisoning for SLAB_TYPESAFE_BY_RCU caches.

And also update the reworded comment from the previous patch:

This function poisons a slab object and saves a free stack trace for
it, except for SLAB_TYPESAFE_BY_RCU caches when @poison_rcu is false.



>   *
>   * This hook is called from the slab allocator to give KASAN a chance to=
 take
>   * ownership of the object and handle its freeing.
>   * kasan_slab_pre_free() must have already been called on the same objec=
t.
>   *
>   * @Return true if KASAN took ownership of the object; false otherwise.
>   */
>  static __always_inline bool kasan_slab_free(struct kmem_cache *s,
> -                                               void *object, bool init)
> +                                               void *object, bool init,
> +                                               bool after_rcu_delay)
>  {
>         if (kasan_enabled())
> -               return __kasan_slab_free(s, object, init);
> +               return __kasan_slab_free(s, object, init, after_rcu_delay=
);
>         return false;
>  }
>
>  void __kasan_kfree_large(void *ptr, unsigned long ip);
>  static __always_inline void kasan_kfree_large(void *ptr)
>  {
> @@ -405,13 +407,14 @@ static inline void *kasan_init_slab_obj(struct kmem=
_cache *cache,
>
>  static inline bool kasan_slab_pre_free(struct kmem_cache *s, void *objec=
t)
>  {
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
>  static inline void kasan_kfree_large(void *ptr) {}
>  static inline void *kasan_slab_alloc(struct kmem_cache *s, void *object,
>                                    gfp_t flags, bool init)
> diff --git a/mm/Kconfig.debug b/mm/Kconfig.debug
> index afc72fde0f03..8e440214aac8 100644
> --- a/mm/Kconfig.debug
> +++ b/mm/Kconfig.debug
> @@ -67,12 +67,42 @@ config SLUB_DEBUG_ON
>           equivalent to specifying the "slab_debug" parameter on boot.
>           There is no support for more fine grained debug control like
>           possible with slab_debug=3Dxxx. SLUB debugging may be switched
>           off in a kernel built with CONFIG_SLUB_DEBUG_ON by specifying
>           "slab_debug=3D-".
>
> +config SLUB_RCU_DEBUG
> +       bool "Enable UAF detection in TYPESAFE_BY_RCU caches (for KASAN)"
> +       depends on SLUB_DEBUG
> +       depends on KASAN # not a real dependency; currently useless witho=
ut KASAN
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
>         select DEBUG_FS
>         select STACKTRACE
>         select STACKDEPOT
> diff --git a/mm/kasan/common.c b/mm/kasan/common.c
> index 8cede1ce00e1..0769b23a9d5f 100644
> --- a/mm/kasan/common.c
> +++ b/mm/kasan/common.c
> @@ -227,43 +227,44 @@ static bool check_slab_allocation(struct kmem_cache=
 *cache, void *object,
>         }
>
>         return false;
>  }
>
>  static inline void poison_slab_object(struct kmem_cache *cache, void *ob=
ject,
> -                                     bool init)
> +                                     bool init, bool after_rcu_delay)
>  {
>         void *tagged_object =3D object;
>
>         object =3D kasan_reset_tag(object);
>
>         /* RCU slabs could be legally used after free within the RCU peri=
od. */
> -       if (unlikely(cache->flags & SLAB_TYPESAFE_BY_RCU))
> +       if (unlikely(cache->flags & SLAB_TYPESAFE_BY_RCU) && !after_rcu_d=
elay)
>                 return;
>
>         kasan_poison(object, round_up(cache->object_size, KASAN_GRANULE_S=
IZE),
>                         KASAN_SLAB_FREE, init);
>
>         if (kasan_stack_collection_enabled())
>                 kasan_save_free_info(cache, tagged_object);
>  }
>
>  bool __kasan_slab_pre_free(struct kmem_cache *cache, void *object,
>                                 unsigned long ip)
>  {
>         if (!kasan_arch_is_ready() || is_kfence_address(object))
>                 return false;
>         return check_slab_allocation(cache, object, ip);
>  }
>
> -bool __kasan_slab_free(struct kmem_cache *cache, void *object, bool init=
)
> +bool __kasan_slab_free(struct kmem_cache *cache, void *object, bool init=
,
> +                      bool after_rcu_delay)
>  {
>         if (!kasan_arch_is_ready() || is_kfence_address(object))
>                 return false;
>
> -       poison_slab_object(cache, object, init);
> +       poison_slab_object(cache, object, init, after_rcu_delay);
>
>         /*
>          * If the object is put into quarantine, do not let slab put the =
object
>          * onto the freelist for now. The object's metadata is kept until=
 the
>          * object gets evicted from quarantine.
>          */
> @@ -517,13 +518,13 @@ bool __kasan_mempool_poison_object(void *ptr, unsig=
ned long ip)
>
>         slab =3D folio_slab(folio);
>
>         if (check_slab_allocation(slab->slab_cache, ptr, ip))
>                 return false;
>
> -       poison_slab_object(slab->slab_cache, ptr, false);
> +       poison_slab_object(slab->slab_cache, ptr, false, false);
>         return true;
>  }
>
>  void __kasan_mempool_unpoison_object(void *ptr, size_t size, unsigned lo=
ng ip)
>  {
>         struct slab *slab;
> diff --git a/mm/kasan/kasan_test.c b/mm/kasan/kasan_test.c
> index 7b32be2a3cf0..567d33b493e2 100644
> --- a/mm/kasan/kasan_test.c
> +++ b/mm/kasan/kasan_test.c
> @@ -993,12 +993,57 @@ static void kmem_cache_invalid_free(struct kunit *t=
est)
>          */
>         kmem_cache_free(cache, p);
>
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
> +       /*
> +        * We should still be allowed to access the object at this point =
because
> +        * the cache is SLAB_TYPESAFE_BY_RCU and we've been in an RCU rea=
d-side
> +        * critical section since before the kmem_cache_free().
> +        */
> +       READ_ONCE(*p);
> +
> +       rcu_read_unlock();
> +
> +       /*
> +        * Wait for the RCU callback to execute; after this, the object s=
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
>  {
>         struct kmem_cache *cache;
>
> @@ -1934,12 +1979,13 @@ static struct kunit_case kasan_kunit_test_cases[]=
 =3D {
>         KUNIT_CASE(workqueue_uaf),
>         KUNIT_CASE(kfree_via_page),
>         KUNIT_CASE(kfree_via_phys),
>         KUNIT_CASE(kmem_cache_oob),
>         KUNIT_CASE(kmem_cache_double_free),
>         KUNIT_CASE(kmem_cache_invalid_free),
> +       KUNIT_CASE(kmem_cache_rcu_uaf),
>         KUNIT_CASE(kmem_cache_double_destroy),
>         KUNIT_CASE(kmem_cache_accounted),
>         KUNIT_CASE(kmem_cache_bulk),
>         KUNIT_CASE(mempool_kmalloc_oob_right),
>         KUNIT_CASE(mempool_kmalloc_large_oob_right),
>         KUNIT_CASE(mempool_slab_oob_right),
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index 40b582a014b8..df09066d56fe 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -539,12 +539,24 @@ static void slab_caches_to_rcu_destroy_workfn(struc=
t work_struct *work)
>                 kmem_cache_release(s);
>         }
>  }
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
>         if (__kmem_cache_shutdown(s) !=3D 0)
>                 return -EBUSY;
>
> diff --git a/mm/slub.c b/mm/slub.c
> index 0c98b6a2124f..f0d0e3c30837 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -2197,45 +2197,78 @@ static inline bool memcg_slab_post_alloc_hook(str=
uct kmem_cache *s,
>  static inline void memcg_slab_free_hook(struct kmem_cache *s, struct sla=
b *slab,
>                                         void **p, int objects)
>  {
>  }
>  #endif /* CONFIG_MEMCG */
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
>
>         debug_check_no_locks_freed(x, s->object_size);
>
>         if (!(s->flags & SLAB_DEBUG_OBJECTS))
>                 debug_check_no_obj_freed(x, s->object_size);
>
>         /* Use KCSAN to help debug racy use-after-free. */
> -       if (!(s->flags & SLAB_TYPESAFE_BY_RCU))
> +       if (!(s->flags & SLAB_TYPESAFE_BY_RCU) || after_rcu_delay)
>                 __kcsan_check_access(x, s->object_size,
>                                      KCSAN_ACCESS_WRITE | KCSAN_ACCESS_AS=
SERT);
>
>         if (kfence_free(x))
>                 return false;
>
>         /*
>          * Give KASAN a chance to notice an invalid free operation before=
 we
>          * modify the object.
>          */
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
>          * kept together to avoid discrepancies in behavior.
>          *
>          * The initialization memset's clear the object and the metadata,
> @@ -2253,42 +2286,42 @@ bool slab_free_hook(struct kmem_cache *s, void *x=
, bool init)
>                         memset(kasan_reset_tag(x), 0, s->object_size);
>                 rsize =3D (s->flags & SLAB_RED_ZONE) ? s->red_left_pad : =
0;
>                 memset((char *)kasan_reset_tag(x) + inuse, 0,
>                        s->size - inuse - rsize);
>         }
>         /* KASAN might put x into memory quarantine, delaying its reuse. =
*/
> -       return !kasan_slab_free(s, x, init);
> +       return !kasan_slab_free(s, x, init, after_rcu_delay);
>  }
>
>  static __fastpath_inline
>  bool slab_free_freelist_hook(struct kmem_cache *s, void **head, void **t=
ail,
>                              int *cnt)
>  {
>
>         void *object;
>         void *next =3D *head;
>         void *old_tail =3D *tail;
>         bool init;
>
>         if (is_kfence_address(next)) {
> -               slab_free_hook(s, next, false);
> +               slab_free_hook(s, next, false, false);
>                 return false;
>         }
>
>         /* Head and tail of the reconstructed freelist */
>         *head =3D NULL;
>         *tail =3D NULL;
>
>         init =3D slab_want_init_on_free(s);
>
>         do {
>                 object =3D next;
>                 next =3D get_freepointer(s, object);
>
>                 /* If object's reuse doesn't have to be delayed */
> -               if (likely(slab_free_hook(s, object, init))) {
> +               if (likely(slab_free_hook(s, object, init, false))) {
>                         /* Move object to the new freelist */
>                         set_freepointer(s, object, *head);
>                         *head =3D object;
>                         if (!*tail)
>                                 *tail =3D object;
>                 } else {
> @@ -4474,40 +4507,67 @@ static __fastpath_inline
>  void slab_free(struct kmem_cache *s, struct slab *slab, void *object,
>                unsigned long addr)
>  {
>         memcg_slab_free_hook(s, slab, &object, 1);
>         alloc_tagging_slab_free_hook(s, slab, &object, 1);
>
> -       if (likely(slab_free_hook(s, object, slab_want_init_on_free(s))))
> +       if (likely(slab_free_hook(s, object, slab_want_init_on_free(s), f=
alse)))
>                 do_slab_free(s, slab, object, object, 1, addr);
>  }
>
>  #ifdef CONFIG_MEMCG
>  /* Do not inline the rare memcg charging failed path into the allocation=
 path */
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
>
>  static __fastpath_inline
>  void slab_free_bulk(struct kmem_cache *s, struct slab *slab, void *head,
>                     void *tail, void **p, int cnt, unsigned long addr)
>  {
>         memcg_slab_free_hook(s, slab, p, cnt);
>         alloc_tagging_slab_free_hook(s, slab, p, cnt);
>         /*
>          * With KASAN enabled slab_free_freelist_hook modifies the freeli=
st
>          * to remove objects, whose reuse must be delayed.
>          */
>         if (likely(slab_free_freelist_hook(s, &head, &tail, &cnt)))
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
> +       do_slab_free(s, slab, object, object, 1, _THIS_IP_);
> +       kfree(delayed_free);
> +}
> +#endif /* CONFIG_SLUB_RCU_DEBUG */
> +
>  #ifdef CONFIG_KASAN_GENERIC
>  void ___cache_free(struct kmem_cache *cache, void *x, unsigned long addr=
)
>  {
>         do_slab_free(cache, virt_to_slab(x), x, x, 1, addr);
>  }
>  #endif
>
> --
> 2.46.0.rc1.232.g9752f9e123-goog
>

