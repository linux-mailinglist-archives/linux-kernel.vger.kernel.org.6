Return-Path: <linux-kernel+bounces-321763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 05D85971F15
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 18:24:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 240151C233ED
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 16:24:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4625D1474D3;
	Mon,  9 Sep 2024 16:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AZOH57Ms"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF48014D28F
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 16:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725899076; cv=none; b=muIZ0vMG7yLBvAZQMPdg2o9hZ3ilGNTI53fAJDFVwjzV5JrpDybz6q299SC68zJT7PBqgS4qe8D4mVVpwE0zq5WB2YY4t+eMoDiuyOyjUt3t0I2z0ROyOuQcJdAaxwDOn//8N3UqHtH7+W24V0k+y79IZMgtTnvglEDebBatTs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725899076; c=relaxed/simple;
	bh=t2DcPle6NIkerVSPHZZgXTnyq+CSA7/hjTGijoExyBI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RiBO308IpUGWDJ5sYazBN+bYXhqIXbpqrcGQ8bAxjABJ/VYtELTiYO5Igcu+vNqQ9XweZRpRXX+MMffPbNZp8PSmUAKaLI1GJ0YLNsPTS03iI9DF8ZzlsVoMK/LHNvzw/qD1AKKrsLYziU1YfpWo40yyslW5fAu+mvOGLRYZe0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AZOH57Ms; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-42cb57f8b41so17743775e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2024 09:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725899073; x=1726503873; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bTdPIISC7QCFQ1CliKh1ID7iwFPfjIWMG7u/QhygHqE=;
        b=AZOH57MszNCStwDtEJQPzkz1y3IQXoFDiOkFxrPu1wAXH6arnoqPn8No5BL0aj44jN
         P9rDRe9UEDOVVOBHuNSzQFtwygeXbvudxci1S/64H5e7oszcMoHWpkceeNMpmX2VoYoR
         5vTBvBJhLLenprxviFAtnKx2JfEbvM2/+t9JvNgwh9NZCUdRjMGhS9DLS4uoVPGWcICa
         xv/w5QRBAIt/VsJOfughYd68KuzHnvOABmVtTBf31Qj3DxG72V77ODXLc5SwJixNFSyq
         2yQVImJyVyBPyheXpqqDnah9y959nk7jx22djhzPpnnWkVype45HEcDYT/PEtFPoYMDo
         VmvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725899073; x=1726503873;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bTdPIISC7QCFQ1CliKh1ID7iwFPfjIWMG7u/QhygHqE=;
        b=DYRQDHeJa6nPW3zgD81+D1PVKvIYd2626ALGb3tyLSKMZh4m3MaBD2WaNyPj5BVXQ9
         8+/9D5nPJoYFCHJyjxlvkNbwXtsjIH7F8O6zQav1gVnyYNWJoOTS7JM96RQkIINArbPd
         sqcyK37zjQ2qkAp8VKD/PZsWqmaINTrmkwdiBgvTUaiHtwUSdOrHH/MPCnLo4Y6VUaKt
         C8PYLNgbFLkBAFsgPRqhwipmH698exmVm5sXjmUrhXjj0pvr1YCWmaJaA576CbxgDXZw
         BvpxWwmwikRjfUGjAQIBznQQOpUV1z92tXYIMzi+3v2Kb4CjsImy30c+55cVUMW+aNCZ
         UbpA==
X-Forwarded-Encrypted: i=1; AJvYcCU5WHtd4tFGV8dP/MV95qYuEhSaqLKxcnqfE6wGzw6NMkgVrPzNWEW4fpfeSig86mDwpszH2BM9yRbgefs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxi+oNOcSiaN37b4Lad8qXTek9V2ajlSFiN8rbvFPducQaHnfVJ
	NgveionFggmhSjNmKBWHO3yGEAWh36U3yyRYvh7mOdWpQZb2dnY0/IRYE+eFnJPY5XVAqZ81r2x
	40s25BVzcMN5uBg6KP/IK16OZT/I=
X-Google-Smtp-Source: AGHT+IEa9vusa1dYi5rukRbMZKTu7GjjtsVEDL9x/ZsO1PQhj18CTLXrJN6VsmoyvPyaXW5/GIxlVZ/FMC4JBFqmqPA=
X-Received: by 2002:a05:600c:4753:b0:42b:ac3d:3abc with SMTP id
 5b1f17b1804b1-42c9f9e08famr102166945e9.24.1725899072151; Mon, 09 Sep 2024
 09:24:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240909012958.913438-1-feng.tang@intel.com> <20240909012958.913438-2-feng.tang@intel.com>
In-Reply-To: <20240909012958.913438-2-feng.tang@intel.com>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Mon, 9 Sep 2024 18:24:21 +0200
Message-ID: <CA+fCnZcqnsAFEHKcPDag60FR_UbpOQpJidF+wqgZzUZUe6MPVQ@mail.gmail.com>
Subject: Re: [PATCH 1/5] mm/kasan: Don't store metadata inside kmalloc object
 when slub_debug_orig_size is on
To: Feng Tang <feng.tang@intel.com>
Cc: Vlastimil Babka <vbabka@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, 
	Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>, David Rientjes <rientjes@google.com>, 
	Joonsoo Kim <iamjoonsoo.kim@lge.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Hyeonggon Yoo <42.hyeyoo@gmail.com>, Marco Elver <elver@google.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, David Gow <davidgow@google.com>, 
	Danilo Krummrich <dakr@kernel.org>, linux-mm@kvack.org, kasan-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 9, 2024 at 3:30=E2=80=AFAM Feng Tang <feng.tang@intel.com> wrot=
e:
>
> For a kmalloc object, when both kasan and slub redzone sanity check
> are enabled, they could both manipulate its data space like storing
> kasan free meta data and setting up kmalloc redzone, and may affect
> accuracy of that object's 'orig_size'.
>
> As an accurate 'orig_size' will be needed by some function like
> krealloc() soon, save kasan's free meta data in slub's metadata area
> instead of inside object when 'orig_size' is enabled.
>
> This will make it easier to maintain/understand the code. Size wise,
> when these two options are both enabled, the slub meta data space is
> already huge, and this just slightly increase the overall size.
>
> Signed-off-by: Feng Tang <feng.tang@intel.com>
> ---
>  mm/kasan/generic.c |  5 ++++-
>  mm/slab.h          |  6 ++++++
>  mm/slub.c          | 17 -----------------
>  3 files changed, 10 insertions(+), 18 deletions(-)
>
> diff --git a/mm/kasan/generic.c b/mm/kasan/generic.c
> index 6310a180278b..cad376199d47 100644
> --- a/mm/kasan/generic.c
> +++ b/mm/kasan/generic.c
> @@ -393,8 +393,11 @@ void kasan_cache_create(struct kmem_cache *cache, un=
signed int *size,
>          *    be touched after it was freed, or
>          * 2. Object has a constructor, which means it's expected to
>          *    retain its content until the next allocation.

Nit: ", or" above.

> +        * 3. It is from a kmalloc cache which enables the debug option
> +        *    to store original size.
>          */
> -       if ((cache->flags & SLAB_TYPESAFE_BY_RCU) || cache->ctor) {
> +       if ((cache->flags & SLAB_TYPESAFE_BY_RCU) || cache->ctor ||
> +            slub_debug_orig_size(cache)) {
>                 cache->kasan_info.free_meta_offset =3D *size;
>                 *size +=3D sizeof(struct kasan_free_meta);
>                 goto free_meta_added;
> diff --git a/mm/slab.h b/mm/slab.h
> index 90f95bda4571..7a0e9b34ba2a 100644
> --- a/mm/slab.h
> +++ b/mm/slab.h
> @@ -689,6 +689,12 @@ void __kmem_obj_info(struct kmem_obj_info *kpp, void=
 *object, struct slab *slab)
>  void __check_heap_object(const void *ptr, unsigned long n,
>                          const struct slab *slab, bool to_user);
>
> +static inline bool slub_debug_orig_size(struct kmem_cache *s)
> +{
> +       return (kmem_cache_debug_flags(s, SLAB_STORE_USER) &&
> +                       (s->flags & SLAB_KMALLOC));
> +}
> +
>  #ifdef CONFIG_SLUB_DEBUG
>  void skip_orig_size_check(struct kmem_cache *s, const void *object);
>  #endif
> diff --git a/mm/slub.c b/mm/slub.c
> index 23761533329d..996a72fa6f62 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -230,12 +230,6 @@ static inline bool kmem_cache_debug(struct kmem_cach=
e *s)
>         return kmem_cache_debug_flags(s, SLAB_DEBUG_FLAGS);
>  }
>
> -static inline bool slub_debug_orig_size(struct kmem_cache *s)
> -{
> -       return (kmem_cache_debug_flags(s, SLAB_STORE_USER) &&
> -                       (s->flags & SLAB_KMALLOC));
> -}
> -
>  void *fixup_red_left(struct kmem_cache *s, void *p)
>  {
>         if (kmem_cache_debug_flags(s, SLAB_RED_ZONE))
> @@ -760,21 +754,10 @@ static inline void set_orig_size(struct kmem_cache =
*s,
>                                 void *object, unsigned int orig_size)
>  {
>         void *p =3D kasan_reset_tag(object);
> -       unsigned int kasan_meta_size;
>
>         if (!slub_debug_orig_size(s))
>                 return;
>
> -       /*
> -        * KASAN can save its free meta data inside of the object at offs=
et 0.
> -        * If this meta data size is larger than 'orig_size', it will ove=
rlap
> -        * the data redzone in [orig_size+1, object_size]. Thus, we adjus=
t
> -        * 'orig_size' to be as at least as big as KASAN's meta data.
> -        */
> -       kasan_meta_size =3D kasan_metadata_size(s, true);
> -       if (kasan_meta_size > orig_size)
> -               orig_size =3D kasan_meta_size;
> -
>         p +=3D get_info_end(s);
>         p +=3D sizeof(struct track) * 2;
>
> --
> 2.34.1
>

Acked-by: Andrey Konovalov <andreyknvl@gmail.com>

