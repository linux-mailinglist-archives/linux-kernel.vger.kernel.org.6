Return-Path: <linux-kernel+bounces-273047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BDCA79463FA
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 21:35:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4AF521F23099
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 19:35:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1877754652;
	Fri,  2 Aug 2024 19:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HGfEyDkX"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95FB51ABEA5
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 19:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722627325; cv=none; b=sUIeIDhoh/QPexpbSr7Ls59zAAvATPP9E10KgJRObSMqYUvSQm3pxXom80ydiDUxyCR+L1j4rmi67LWWx1H2wW2+3UZMhpFqdXQ7yDBWIuxDx5tMjxvIkqEeQJ918q0iXD3iGefWMNYIDuoV8S003fXY/UgFCJsYen6WmWOi+ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722627325; c=relaxed/simple;
	bh=oDY9qeIEsPLiuDP/ZcjTVjCcQ0CzbclKXP2nPYOpEWw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bWZooEdvn20ZucaEhd8vjety1CQi4aDa4TvmKUwZuvQraPgBfyw1gZxdTftoohm54Y6RqA+8UZba3goOujCMefNzSx3YJfibg5UusiswYopkluCv9zoDb+mEOKPtGEIk/PUjeqCUb1gpSt8NR/AGL/dSEhA9o2hSaMI4RB6JJ2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HGfEyDkX; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-368440b073bso2293324f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2024 12:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722627322; x=1723232122; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hYUx5VYfzdcL2cZbcEL5FqwVX5ykzwG2TQHVubtZro0=;
        b=HGfEyDkXT3vj5S8SPVcUz5TEaBPeV0NZECOV6CzWCMqsuc6LiacxksVc6ESI7BOeNz
         eGQIu+NNjxniIVDCZERf/qMIsyTjXPcLDkWgyOG9M0pMsvZONMJ2VW4bxmj3SiowTdkc
         GZCZSy+19Gab11I5luFY/Kk0RZELqZJIOnFF9cJjgEr/QMGceDULsLBj77h/biQ1tnpf
         1bbtQPm+FJt0NSq3DCZ1VTzHR73RdAkap7y6lGARnCleNnsGwQHpuDlBsCUqC0iesStP
         aaPuhdfQwMpraCrFLLlpVsoLi8tEVltaRq2Gd5I8b54oXg1SgKmjVdscGbordAbbeHrM
         QQkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722627322; x=1723232122;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hYUx5VYfzdcL2cZbcEL5FqwVX5ykzwG2TQHVubtZro0=;
        b=aVZQJvr9CK++XLTBrZs5UM3XEYdaSO2+OfV7aaJGZYeRxOfk0bsw2P2JdZn3uVgPFg
         7Ri6TA6XiKGdM3FeBa58XKV9nLHdmBOGIC7p8mFFxua7E1G1Q4w+JzOFgzHGjnJ6XQ9D
         Hf4CjmcwNSUMOVE1zxI9qR/qe7ne0P3N45g5lwrjmfCoi1fgdOVow86kh4jxZo3/VP8S
         sxOEuu5xN1kJXvFetTsaoPZkmQQ5rsXNPHsXpRP4O9tNIh+zZCnayfoA5UEo1zndHVC8
         bwM6GkirjMOIAp0upwuLNFpCsEo5zev50a9gpLansotj6COQ9/VUDtquEfAzr6rFbBBZ
         1X1Q==
X-Forwarded-Encrypted: i=1; AJvYcCWT2vp7/TOpQz0tAZbXmQzh4B887N/qD0wiXZkDOFRzF1WESequocTrK/sSLUkUO9YYoegjtb4MU/wujzPhFPcGGnUnPuoMkhnhlrU7
X-Gm-Message-State: AOJu0YzC9/bw7RHS2UUwE5IrE7xdOwvH6mdFuQbpaEzf4LfqVNKpO0My
	pzpKmoWsdZcanjKwvUs/YF9XD8QbF77JhGej+zw24lK3ctb4TAwNiwAQ1eK3Vgd1XlU6ZoOihcJ
	wuiipS8to0/WuPK0dTn4NzG6qu0g=
X-Google-Smtp-Source: AGHT+IFkYyINSiZFkbDWCMcpm7ALPjDI8in2ngnFEDBwMRL8khCi4/w1CXQrLIWYQQDM9gxGJvydpO5FPCEPQCBmnsA=
X-Received: by 2002:adf:ef4f:0:b0:36b:c65c:661e with SMTP id
 ffacd0b85a97d-36bc65c66b1mr1411494f8f.13.1722627321544; Fri, 02 Aug 2024
 12:35:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240730-kasan-tsbrcu-v5-0-48d3cbdfccc5@google.com>
 <20240730-kasan-tsbrcu-v5-2-48d3cbdfccc5@google.com> <CA+fCnZeq8JGSkFwGitwSc3DbeuoXnoyvC7RgWh6XSG1CoWH=Zg@mail.gmail.com>
 <CAG48ez1guHcQaZtGoap7MG1sac5F3PmMA7XKUH03pEaibvaFJw@mail.gmail.com> <CAG48ez2bqYMPS2D7gFZ-9V3p3-NJUYmYNA113QbMg0JRG+pNEQ@mail.gmail.com>
In-Reply-To: <CAG48ez2bqYMPS2D7gFZ-9V3p3-NJUYmYNA113QbMg0JRG+pNEQ@mail.gmail.com>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Fri, 2 Aug 2024 21:35:10 +0200
Message-ID: <CA+fCnZdNWPnjSvPF5dg0NA+f8y=rtxtbDC13cZJCz+rQVb=ouA@mail.gmail.com>
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

On Fri, Aug 2, 2024 at 1:23=E2=80=AFPM Jann Horn <jannh@google.com> wrote:
>
> On Fri, Aug 2, 2024 at 11:09=E2=80=AFAM Jann Horn <jannh@google.com> wrot=
e:
> > I guess I could also change the API to pass something different - like
> > a flag meaning "the object is guaranteed to no longer be in use".
> > There is already code in slab_free_hook() that computes this
> > expression, so we could easily pass that to KASAN and then avoid doing
> > the same logic in KASAN again... I think that would be the most
> > elegant approach?
>
> Regarding this, I think I'll add something like this on top of this patch=
 in v6:
>
> diff --git a/include/linux/kasan.h b/include/linux/kasan.h
> index b63f5351c5f3..50bad011352e 100644
> --- a/include/linux/kasan.h
> +++ b/include/linux/kasan.h
> @@ -201,16 +201,17 @@ bool __kasan_slab_free(struct kmem_cache *s,
> void *object, bool init,
>  /**
>   * kasan_slab_free - Possibly handle slab object freeing.
>   * @object: Object to free.
> + * @still_accessible: Whether the object contents are still accessible.
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
>                                                 void *object, bool init,
> -                                               bool after_rcu_delay)
> +                                               bool still_accessible)
>  {
>         if (kasan_enabled())
>                 return __kasan_slab_free(s, object, init, after_rcu_delay=
);
> @@ -410,7 +411,7 @@ static inline bool kasan_slab_pre_free(struct
> kmem_cache *s, void *object)
>  }
>
>  static inline bool kasan_slab_free(struct kmem_cache *s, void *object,
> -                                  bool init, bool after_rcu_delay)
> +                                  bool init, bool still_accessible)
>  {
>         return false;
>  }
> diff --git a/mm/kasan/common.c b/mm/kasan/common.c
> index 71a20818b122..ed4873e18c75 100644
> --- a/mm/kasan/common.c
> +++ b/mm/kasan/common.c
> @@ -230,14 +230,14 @@ static bool check_slab_allocation(struct
> kmem_cache *cache, void *object,
>  }
>
>  static inline void poison_slab_object(struct kmem_cache *cache, void *ob=
ject,
> -                                     bool init, bool after_rcu_delay)
> +                                     bool init, bool still_accessible)
>  {
>         void *tagged_object =3D object;
>
>         object =3D kasan_reset_tag(object);
>
>         /* RCU slabs could be legally used after free within the RCU peri=
od. */
> -       if (unlikely(cache->flags & SLAB_TYPESAFE_BY_RCU) && !after_rcu_d=
elay)
> +       if (unlikely(still_accessible))
>                 return;
>
>         kasan_poison(object, round_up(cache->object_size, KASAN_GRANULE_S=
IZE),
> @@ -256,12 +256,12 @@ bool __kasan_slab_pre_free(struct kmem_cache
> *cache, void *object,
>  }
>
>  bool __kasan_slab_free(struct kmem_cache *cache, void *object, bool init=
,
> -                      bool after_rcu_delay)
> +                      bool still_accessible)
>  {
>         if (!kasan_arch_is_ready() || is_kfence_address(object))
>                 return false;
>
> -       poison_slab_object(cache, object, init, after_rcu_delay);
> +       poison_slab_object(cache, object, init, still_accessible);
>
>         /*
>          * If the object is put into quarantine, do not let slab put the =
object
> diff --git a/mm/slub.c b/mm/slub.c
> index 49571d5ded75..a89f2006d46e 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -2221,31 +2221,34 @@ static __always_inline
>  bool slab_free_hook(struct kmem_cache *s, void *x, bool init,
>                     bool after_rcu_delay)
>  {
> +       /* Are the object contents still accessible? */
> +       bool still_accessible =3D (s->flags & SLAB_TYPESAFE_BY_RCU) &&
> !after_rcu_delay;
> +
>         kmemleak_free_recursive(x, s->flags);
>         kmsan_slab_free(s, x);
>
>         debug_check_no_locks_freed(x, s->object_size);
>
>         if (!(s->flags & SLAB_DEBUG_OBJECTS))
>                 debug_check_no_obj_freed(x, s->object_size);
>
>         /* Use KCSAN to help debug racy use-after-free. */
> -       if (!(s->flags & SLAB_TYPESAFE_BY_RCU) || after_rcu_delay)
> +       if (!still_accessible)
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
>  #ifdef CONFIG_SLUB_RCU_DEBUG
> -       if ((s->flags & SLAB_TYPESAFE_BY_RCU) && !after_rcu_delay) {
> +       if (still_accessible) {
>                 struct rcu_delayed_free *delayed_free;
>
>                 delayed_free =3D kmalloc(sizeof(*delayed_free), GFP_NOWAI=
T);
> @@ -2289,7 +2292,7 @@ bool slab_free_hook(struct kmem_cache *s, void
> *x, bool init,
>                        s->size - inuse - rsize);
>         }
>         /* KASAN might put x into memory quarantine, delaying its reuse. =
*/
> -       return !kasan_slab_free(s, x, init, after_rcu_delay);
> +       return !kasan_slab_free(s, x, init, still_accessible);
>  }
>
>  static __fastpath_inline

Ok, let's do it like this.

Thank you!

