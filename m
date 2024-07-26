Return-Path: <linux-kernel+bounces-262749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23B9A93CC2E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 02:44:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 482221C21404
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 00:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD5E3A3D;
	Fri, 26 Jul 2024 00:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FSpcVHkJ"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC71368
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 00:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721954638; cv=none; b=MA74G+3umN/1+48zON0Qp3IOfCpnJqpSKEd9gDlWcRb6SkUDnjYsQcoirwhLf4QnTzV/RU9dX2Mb/FbSlr3CM6u2xeiEdtSuWQUF6qCIgooJAljayAiDOZrj+2WGVlSKQzKWnejpLwJT0JzioiCIUTZ7/Cc8rC/j76nIWPJ503c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721954638; c=relaxed/simple;
	bh=VPdOOuH1CKnSXFfeuJtdz+v+J5s1Shj03usFjFn+7jk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E+heqJiKEBWvvOLD3fFCl26+8Oge5+p1+KPtiLskIr3T9OxWMVRR2qT0MKnZKHw+coTJPUuv3U8xuWQ1NOgEahf7FazFY2z7C2y5o7gZDcEkaNrQYsXJmGZsLyOQiBnVqeB/ofMmzN1BZOLIni+WyzuM3LscpKH8nLbslhruoQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FSpcVHkJ; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3687f8fcab5so698862f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 17:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721954635; x=1722559435; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xYO5SO4GDvuXPDiqp7OtLZoWNem0w1AFsK/JqDBRgRw=;
        b=FSpcVHkJBkUI1NJz+OZuyXSMw5o75dXkWBeDsh0V0NziC4P4pEBCY7IvUuDNPsxkID
         L3BryAlt3pCFdJS9EY82BvDYQu8J00mrFyp5ndl+LXHiddtak8RYbcpCpMggqLzpwn38
         VoBFfRqGI+PvJJttLBBvaUk+991e+NwW3oPkP159IJuXrB8tJn4PWYoMetp90CiaUaJV
         R/OQDKukmSdbzf+61Q2ar+3H8BN8SwUCGsPjsEdx1b9FlE7+5zvGWAr1DOBePJJ8QJp2
         lcEPkiCk3ZuYKZmc+sw6k+bPmMsG08gjlPObhaGd+omJg7glfIwrwiQdlMnTapGolJD+
         i1rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721954635; x=1722559435;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xYO5SO4GDvuXPDiqp7OtLZoWNem0w1AFsK/JqDBRgRw=;
        b=TB8w/cN2A4KUcUQizUxcChkiPuIK12dT5JzWKnoTVwaOSqgTuiFfIGwdwbcq6iC+O/
         RIjBzM2TCgbSiK9vIzZcEErMkahT43X25sPfazd7Ji0/cEQRNbHO9/Ongv43OS3p4ZHf
         9mZgZY49vEDtr2k/as+GUZWxGNiyMDOTb/P38qsmGw+ti23fQJNtHG4zi7CVGyV1fOCr
         bWsrcFwrpTwjpphGLK3WD8rwEZdxsQIMCw7tyXGz5cq7eGWJLD5Pqk3Iog6ApcNgI1Bv
         X+tkUJMXKIcnVMFcGuCR63uAokUc351fcPuNwDfd29bRQlISOCetIinHOPOomIhniOMV
         VQmQ==
X-Forwarded-Encrypted: i=1; AJvYcCXDqQOYh9gSL2JiJPLotTVhZcT8KLogv5OoZZZkcZ5/yBZZyvg6VXx6HPetUrz4xBSy2qbRoi5N8buPfmA2qp9h4yYAXZhpP/Ocvigh
X-Gm-Message-State: AOJu0YzTSvgVO9bot6GxaTrr2WEx8EgePF6FF4MXFSAf+rzdKYa+fJdT
	UDittVWFU/gtmaEQLMl5IjBtx0r/SMhBqOJgjjbmBY7PmwGbBDAcIawxK7NORjlP0THwLce5BWE
	P1WGYB1PXvoPt7Y8tw/Z+vEpU910=
X-Google-Smtp-Source: AGHT+IHXZA7vxZZe9vudcFJu5wQEoaTE/BEGgNP5tTIiap5Lqc5xK2XD+4YyiKwDFyG9zQzigP2NzwAoTFjmLpndzKk=
X-Received: by 2002:a05:6000:112:b0:367:8a72:b8b4 with SMTP id
 ffacd0b85a97d-36b363a30b9mr2518002f8f.33.1721954634536; Thu, 25 Jul 2024
 17:43:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240725-kasan-tsbrcu-v3-0-51c92f8f1101@google.com> <20240725-kasan-tsbrcu-v3-1-51c92f8f1101@google.com>
In-Reply-To: <20240725-kasan-tsbrcu-v3-1-51c92f8f1101@google.com>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Fri, 26 Jul 2024 02:43:43 +0200
Message-ID: <CA+fCnZe-x+JOUN1P-H-i0_3ys+XgpZBKU_zi06XBRfmN+OzO+w@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] kasan: catch invalid free before SLUB
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

On Thu, Jul 25, 2024 at 5:32=E2=80=AFPM Jann Horn <jannh@google.com> wrote:
>
> Currently, when KASAN is combined with init-on-free behavior, the
> initialization happens before KASAN's "invalid free" checks.
>
> More importantly, a subsequent commit will want to use the object metadat=
a
> region to store an rcu_head, and we should let KASAN check that the objec=
t
> pointer is valid before that. (Otherwise that change will make the existi=
ng
> testcase kmem_cache_invalid_free fail.)

This is not the case since v3, right? Do we still need this patch?

If it's still needed, see the comment below.

Thank you!

> So add a new KASAN hook that allows KASAN to pre-validate a
> kmem_cache_free() operation before SLUB actually starts modifying the
> object or its metadata.
>
> Acked-by: Vlastimil Babka <vbabka@suse.cz> #slub
> Signed-off-by: Jann Horn <jannh@google.com>
> ---
>  include/linux/kasan.h | 16 ++++++++++++++++
>  mm/kasan/common.c     | 51 +++++++++++++++++++++++++++++++++++++++------=
------
>  mm/slub.c             |  7 +++++++
>  3 files changed, 62 insertions(+), 12 deletions(-)
>
> diff --git a/include/linux/kasan.h b/include/linux/kasan.h
> index 70d6a8f6e25d..ebd93c843e78 100644
> --- a/include/linux/kasan.h
> +++ b/include/linux/kasan.h
> @@ -175,6 +175,16 @@ static __always_inline void * __must_check kasan_ini=
t_slab_obj(
>         return (void *)object;
>  }
>
> +bool __kasan_slab_pre_free(struct kmem_cache *s, void *object,
> +                       unsigned long ip);
> +static __always_inline bool kasan_slab_pre_free(struct kmem_cache *s,
> +                                               void *object)
> +{
> +       if (kasan_enabled())
> +               return __kasan_slab_pre_free(s, object, _RET_IP_);
> +       return false;
> +}

Please add a documentation comment for this new hook; something like
what we have for kasan_mempool_poison_pages() and some of the others.
(I've been meaning to add them for all of them, but still didn't get
around to that.)

> +
>  bool __kasan_slab_free(struct kmem_cache *s, void *object,
>                         unsigned long ip, bool init);
>  static __always_inline bool kasan_slab_free(struct kmem_cache *s,
> @@ -371,6 +381,12 @@ static inline void *kasan_init_slab_obj(struct kmem_=
cache *cache,
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
> diff --git a/mm/kasan/common.c b/mm/kasan/common.c
> index 85e7c6b4575c..7c7fc6ce7eb7 100644
> --- a/mm/kasan/common.c
> +++ b/mm/kasan/common.c
> @@ -208,31 +208,52 @@ void * __must_check __kasan_init_slab_obj(struct km=
em_cache *cache,
>         return (void *)object;
>  }
>
> -static inline bool poison_slab_object(struct kmem_cache *cache, void *ob=
ject,
> -                                     unsigned long ip, bool init)
> +enum free_validation_result {
> +       KASAN_FREE_IS_IGNORED,
> +       KASAN_FREE_IS_VALID,
> +       KASAN_FREE_IS_INVALID
> +};
> +
> +static enum free_validation_result check_slab_free(struct kmem_cache *ca=
che,
> +                                               void *object, unsigned lo=
ng ip)
>  {
> -       void *tagged_object;
> +       void *tagged_object =3D object;
>
> -       if (!kasan_arch_is_ready())
> -               return false;
> +       if (is_kfence_address(object) || !kasan_arch_is_ready())
> +               return KASAN_FREE_IS_IGNORED;
>
> -       tagged_object =3D object;
>         object =3D kasan_reset_tag(object);
>
>         if (unlikely(nearest_obj(cache, virt_to_slab(object), object) !=
=3D object)) {
>                 kasan_report_invalid_free(tagged_object, ip, KASAN_REPORT=
_INVALID_FREE);
> -               return true;
> +               return KASAN_FREE_IS_INVALID;
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
> -               return true;
> +               return KASAN_FREE_IS_INVALID;
>         }
>
> +       return KASAN_FREE_IS_VALID;
> +}
> +
> +static inline bool poison_slab_object(struct kmem_cache *cache, void *ob=
ject,
> +                                     unsigned long ip, bool init)
> +{
> +       void *tagged_object =3D object;
> +       enum free_validation_result valid =3D check_slab_free(cache, obje=
ct, ip);

I believe we don't need check_slab_free() here, as it was already done
in kasan_slab_pre_free()? Checking just kasan_arch_is_ready() and
is_kfence_address() should save a bit on performance impact.

Though if we remove check_slab_free() from here, we do need to add it
to __kasan_mempool_poison_object().

> +
> +       if (valid =3D=3D KASAN_FREE_IS_IGNORED)
> +               return false;
> +       if (valid =3D=3D KASAN_FREE_IS_INVALID)
> +               return true;
> +
> +       object =3D kasan_reset_tag(object);
> +
> +       /* RCU slabs could be legally used after free within the RCU peri=
od. */
> +       if (unlikely(cache->flags & SLAB_TYPESAFE_BY_RCU))
> +               return false;

I vaguely recall there was some reason why this check was done before
the kasan_byte_accessible() check, but I might be wrong. Could you try
booting the kernel with only this patch applied to see if anything
breaks?




> +
>         kasan_poison(object, round_up(cache->object_size, KASAN_GRANULE_S=
IZE),
>                         KASAN_SLAB_FREE, init);
>
> @@ -242,6 +263,12 @@ static inline bool poison_slab_object(struct kmem_ca=
che *cache, void *object,
>         return false;
>  }
>
> +bool __kasan_slab_pre_free(struct kmem_cache *cache, void *object,
> +                               unsigned long ip)
> +{
> +       return check_slab_free(cache, object, ip) =3D=3D KASAN_FREE_IS_IN=
VALID;
> +}
> +
>  bool __kasan_slab_free(struct kmem_cache *cache, void *object,
>                                 unsigned long ip, bool init)
>  {
> diff --git a/mm/slub.c b/mm/slub.c
> index 4927edec6a8c..34724704c52d 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -2170,6 +2170,13 @@ bool slab_free_hook(struct kmem_cache *s, void *x,=
 bool init)
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
>
> --
> 2.45.2.1089.g2a221341d9-goog
>

