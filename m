Return-Path: <linux-kernel+bounces-409371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2F1A9C8C29
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 14:52:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6CC5B2B249
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 13:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9700514287;
	Thu, 14 Nov 2024 13:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Stoj/Ene"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3B391172A
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 13:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731591266; cv=none; b=fNbjtTvbqNkzWNMtoaH+Tfwp+ZkKNRUd3+zuxYe16qMRLTUpz3UXodb/zP9PFfCbZWCuxAEVJNhCe868fjBMdXmYOeZuH2U2DqJvLXd1mtC2H+U7fq5zY/rdv2B2ugkz8E8bbzheHnmsJ0dS/uMlX4DX6pE0qHJA1dvdklk1GVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731591266; c=relaxed/simple;
	bh=sMR48JKlGrAmx2olQ17yT0eAJj0RpkknSlND8d7j0Sg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u4QkMB1p+6p9Rer5gIt6sdr/AnmpjEtEBOZCwn4WBzxOkWTVQcfaLvJxX1x3hWtrWtW3D0+02F5i07IXb3cXGCXv9UUKoaITnB0yVScyHwSvWEO6LbhIePT63qtO+yjktoQCevA43CpYnIr8+KuD5YgsF2Y+sxSt/+ekas22kjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Stoj/Ene; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2fb5014e2daso6010701fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 05:34:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731591263; x=1732196063; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1gPQZzQK8GNelw3AYb5yhBmVDG1cjmV9z/F+0TDBmsA=;
        b=Stoj/EnehKKqnQQnziCKeY7IdheQ4N0RzXTRlv+skCKbLo7PJLmxENGzOHa1UQOa4w
         b6ASi9qCnS6Zp3l72Cd8viieVkMgUOSwM6lBPyVTD6gFP2p32eNlkks030Cc6nJjBNVt
         EfzMn9mKjqsPjaoZ5rPeOQMg/o1jZspDWmE88MqUSEphAwg8atCJSAsjygRUdVW7kLg9
         +DihWvtyyeYGVyFpC+h3Q2XKZmRi6e6o5wYIRF0824YNnHAuhYyI9im2n4WZx3TAhN6F
         edzD+GoOqIBosN5k9XJ4Hq/PwGC232/ZHWyxREl7ahENr8PoK1LiNWfR91uA0YTAWeqr
         VXww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731591263; x=1732196063;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1gPQZzQK8GNelw3AYb5yhBmVDG1cjmV9z/F+0TDBmsA=;
        b=Ervgbh0pZvxZ7qyd/G7GYQQqXPvzaGLWHW6CGpN2eKsojnFTLwDC5Ui7sldoPkE1Kp
         M9TJ15nKJmu4UOHgHN0yZF15DcCUKtEMZ3T8Mw++j+4i7NHE7tUGrb7lUS4VY3F4xOar
         of/UrVzNF9vCv9RcEkuaqUisoMw5JI9mF0q6uQ5gLs58c0gr6PXogan/IaDGK0m6svrd
         ua4DLLKjWcKM5aQDbxig1Pb9YW6m6ekKjupgu6+PbfK10lzuPE2Gv+yMbfi1ixKepAjv
         dnkfdVCe3/LQKpq/WtgLnzyi3BEZ4j4UJ0MFZMwy46PNeMJJHtn4qJq7959FAuD5s+UL
         Jt8Q==
X-Forwarded-Encrypted: i=1; AJvYcCVJeHZJbLM29sFWt2lBcbjHnykLSCxlx2UOEAL4VoaebH9bH1W7e1KUgPkjts9ZM7Ly/iBGtaJ7s3Jeav0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyM5WOhG7tp8Cr4Al8wvqqe8OTNrMLb+sJSJbdglYcQ50pmeQTZ
	S71OGKhwH9syCNHU2Hb+49buTsT1R8SdjcFj1QJ24BdffglKAXHWOavES5U4MFOU9CLuC23crcZ
	GIuqbwi0531T0Yq42Ef74H1/YSoo=
X-Google-Smtp-Source: AGHT+IExd+t5gHa6krdkvl+K9+xIeC51eSc3WJqkqn7ZvqNSWqTYs++D8sfLUW6mJXqW18/N5gvbCnhKAiBeVZkM68Y=
X-Received: by 2002:a2e:bd0f:0:b0:2ff:552c:290b with SMTP id
 38308e7fff4ca-2ff5901af4cmr10159161fa.10.1731591262685; Thu, 14 Nov 2024
 05:34:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241016154152.1376492-1-feng.tang@intel.com> <20241016154152.1376492-3-feng.tang@intel.com>
In-Reply-To: <20241016154152.1376492-3-feng.tang@intel.com>
From: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Date: Thu, 14 Nov 2024 22:34:10 +0900
Message-ID: <CAB=+i9QUC+zscxC6AuK9qUaD-Y9VmAv2-Ovqt8JRJJARWxZ-EQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] mm/slub: Improve redzone check and zeroing for krealloc()
To: Feng Tang <feng.tang@intel.com>
Cc: Vlastimil Babka <vbabka@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, 
	Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>, David Rientjes <rientjes@google.com>, 
	Joonsoo Kim <iamjoonsoo.kim@lge.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Andrey Konovalov <andreyknvl@gmail.com>, Marco Elver <elver@google.com>, 
	Alexander Potapenko <glider@google.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Danilo Krummrich <dakr@kernel.org>, Narasimhan.V@amd.com, linux-mm@kvack.org, 
	kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 17, 2024 at 12:42=E2=80=AFAM Feng Tang <feng.tang@intel.com> wr=
ote:
>
> For current krealloc(), one problem is its caller doesn't pass the old
> request size, say the object is 64 bytes kmalloc one, but caller may
> only requested 48 bytes. Then when krealloc() shrinks or grows in the
> same object, or allocate a new bigger object, it lacks this 'original
> size' information to do accurate data preserving or zeroing (when
> __GFP_ZERO is set).
>
> Thus with slub debug redzone and object tracking enabled, parts of the
> object after krealloc() might contain redzone data instead of zeroes,
> which is violating the __GFP_ZERO guarantees. Good thing is in this
> case, kmalloc caches do have this 'orig_size' feature. So solve the
> problem by utilize 'org_size' to do accurate data zeroing and preserving.
>
> [Thanks to syzbot and V, Narasimhan for discovering kfence and big
>  kmalloc related issues in early patch version]
>
> Suggested-by: Vlastimil Babka <vbabka@suse.cz>
> Signed-off-by: Feng Tang <feng.tang@intel.com>
> ---
>  mm/slub.c | 84 +++++++++++++++++++++++++++++++++++++++----------------
>  1 file changed, 60 insertions(+), 24 deletions(-)
>
> diff --git a/mm/slub.c b/mm/slub.c
> index 1d348899f7a3..958f7af79fad 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -4718,34 +4718,66 @@ static __always_inline __realloc_size(2) void *
>  __do_krealloc(const void *p, size_t new_size, gfp_t flags)
>  {
>         void *ret;
> -       size_t ks;
> -
> -       /* Check for double-free before calling ksize. */
> -       if (likely(!ZERO_OR_NULL_PTR(p))) {
> -               if (!kasan_check_byte(p))
> -                       return NULL;
> -               ks =3D ksize(p);
> -       } else
> -               ks =3D 0;
> -
> -       /* If the object still fits, repoison it precisely. */
> -       if (ks >=3D new_size) {
> -               /* Zero out spare memory. */
> -               if (want_init_on_alloc(flags)) {
> -                       kasan_disable_current();
> +       size_t ks =3D 0;
> +       int orig_size =3D 0;
> +       struct kmem_cache *s =3D NULL;
> +
> +       /* Check for double-free. */
> +       if (unlikely(ZERO_OR_NULL_PTR(p)))
> +               goto alloc_new;

nit: I think kasan_check_bytes() is the function that checks for double-fre=
e?

Otherwise looks good to me,
Reviewed-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>

> +       if (!kasan_check_byte(p))
> +               return NULL;
> +
> +       if (is_kfence_address(p)) {
> +               ks =3D orig_size =3D kfence_ksize(p);
> +       } else {
> +               struct folio *folio;
> +
> +               folio =3D virt_to_folio(p);
> +               if (unlikely(!folio_test_slab(folio))) {
> +                       /* Big kmalloc object */
> +                       WARN_ON(folio_size(folio) <=3D KMALLOC_MAX_CACHE_=
SIZE);
> +                       WARN_ON(p !=3D folio_address(folio));
> +                       ks =3D folio_size(folio);
> +               } else {
> +                       s =3D folio_slab(folio)->slab_cache;
> +                       orig_size =3D get_orig_size(s, (void *)p);
> +                       ks =3D s->object_size;
> +               }
> +       }
> +
> +       /* If the old object doesn't fit, allocate a bigger one */
> +       if (new_size > ks)
> +               goto alloc_new;
> +
> +       /* Zero out spare memory. */
> +       if (want_init_on_alloc(flags)) {
> +               kasan_disable_current();
> +               if (orig_size && orig_size < new_size)
> +                       memset((void *)p + orig_size, 0, new_size - orig_=
size);
> +               else
>                         memset((void *)p + new_size, 0, ks - new_size);
> -                       kasan_enable_current();
> -               }
> +               kasan_enable_current();
> +       }
>
> -               p =3D kasan_krealloc((void *)p, new_size, flags);
> -               return (void *)p;
> +       /* Setup kmalloc redzone when needed */
> +       if (s && slub_debug_orig_size(s)) {
> +               set_orig_size(s, (void *)p, new_size);
> +               if (s->flags & SLAB_RED_ZONE && new_size < ks)
> +                       memset_no_sanitize_memory((void *)p + new_size,
> +                                               SLUB_RED_ACTIVE, ks - new=
_size);
>         }
> +       p =3D kasan_krealloc((void *)p, new_size, flags);
> +       return (void *)p;
> +
> +alloc_new:
>         ret =3D kmalloc_node_track_caller_noprof(new_size, flags, NUMA_NO=
_NODE, _RET_IP_);
>         if (ret && p) {
>                 /* Disable KASAN checks as the object's redzone is access=
ed. */
>                 kasan_disable_current();
> -               memcpy(ret, kasan_reset_tag(p), ks);
> +               memcpy(ret, kasan_reset_tag(p), orig_size ?: ks);
>                 kasan_enable_current();
>         }
>
> @@ -4766,16 +4798,20 @@ __do_krealloc(const void *p, size_t new_size, gfp=
_t flags)
>   * memory allocation is flagged with __GFP_ZERO. Otherwise, it is possib=
le that
>   * __GFP_ZERO is not fully honored by this API.
>   *
> - * This is the case, since krealloc() only knows about the bucket size o=
f an
> - * allocation (but not the exact size it was allocated with) and hence
> - * implements the following semantics for shrinking and growing buffers =
with
> - * __GFP_ZERO.
> + * When slub_debug_orig_size() is off, krealloc() only knows about the b=
ucket
> + * size of an allocation (but not the exact size it was allocated with) =
and
> + * hence implements the following semantics for shrinking and growing bu=
ffers
> + * with __GFP_ZERO.
>   *
>   *         new             bucket
>   * 0       size             size
>   * |--------|----------------|
>   * |  keep  |      zero      |
>   *
> + * Otherwise, the original allocation size 'orig_size' could be used to
> + * precisely clear the requested size, and the new size will also be sto=
red
> + * as the new 'orig_size'.
> + *
>   * In any case, the contents of the object pointed to are preserved up t=
o the
>   * lesser of the new and old sizes.
>   *
> --
> 2.27.0
>

