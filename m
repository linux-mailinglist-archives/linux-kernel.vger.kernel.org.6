Return-Path: <linux-kernel+bounces-352427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0455D991EEF
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2024 16:37:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 217991C21023
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2024 14:37:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 988AB763F8;
	Sun,  6 Oct 2024 14:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YRaSx2br"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B4C75733A
	for <linux-kernel@vger.kernel.org>; Sun,  6 Oct 2024 14:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728225458; cv=none; b=i5gFWz9ijy88uISxauI7YsjbuzcC/V7EVLylHoi9OjKNwz1VYfOgwTqhHbb1oFL5G+zAHzYIjQr3JeZMCTW2pbJWjptSmaApSDAjwmAOCznGLaDyUOYe7Utwfyq3Mrcups+NuKcaFuVWWhoSqXB6Uo2/vM960gyXC5O8dF/ZCHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728225458; c=relaxed/simple;
	bh=BdPxsKQxTnwSTG2BoMp54yXKZgPysJ0Ur7LR3xWZRiI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o5gQ4FHQoK24iSVunBOeF/TvEdyq2s8IoCiE7jhKKuBL5ig/Duvi2z7uF2lyL4ZpaRqW0CpGGo1COm4E4WzYbI7VczWiNyd+pVzjZyNot2wLkZbc5lA4OAKMrDtlSxsmYFnrP/VIT/Ws76bsd9IGjQrtxJEZiJIFGKVltVz7fKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YRaSx2br; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-539908f238fso3906932e87.2
        for <linux-kernel@vger.kernel.org>; Sun, 06 Oct 2024 07:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728225455; x=1728830255; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ND5Svx26eAZVcwpez7MW0bsvA1vYACvoD5M7KxqAkR0=;
        b=YRaSx2brckIJjIDMtK6XkGW4MrMO1wbEzXzoLkTUjNivvOdoWdYg71nwj1jB2fDRPn
         I3Zy+vooFkHyQBldc5m9/tsp3najMAF+FY/dlsSxnBNjN1qjxFjXDsff9SvdnO+3dIls
         cswDFpcFKpBTXTCeZXn7drzn0VKP5D/XGIJHtydJuroDvU3kl3UIfTY3t+pR2yJl/5tC
         RL4TwWOTokI6UoLVrMJ2w1+1aSS88ZrVHILCzp9v1rK8IkQTOXEcyGYIUijjzRCcoaej
         i9ogg0/iy96FB+QfNDYZ6SaTfJFo3zoS3CVR0Ek7pM11qFFojQ3gkP4NLtK3lTnqNaRT
         eNsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728225455; x=1728830255;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ND5Svx26eAZVcwpez7MW0bsvA1vYACvoD5M7KxqAkR0=;
        b=Irr3Oaej7MAo8e0yLmQfNTh812kb65h2FUU7oemfKX/4M6CBBJV1gqApfvdduAPW0s
         003loPHlGORVyUMEO9EZlxhP4Vb3tmsd7Hbu9ZIofxARY22ynAhWWemQIPsCseajFIUG
         op72uAfmnUXIzY2tnQJqjYMn1G09CbpHj6zBoAXr7CLvImlKYFNfo5DAqGVJoJBGdqM2
         WRqoQBZne487EaQQ/R/PN41bVT0Gw65LQehWaJz+Lg7PPU8o3xjKfdQuRZXruRv8gknr
         H3+HrP3Gkvnw89shTkLAIwQFs9KM75nV7D3rTh9+8kz7rwK4AvGsK70wlM3Qkhnbh3X7
         xsSA==
X-Forwarded-Encrypted: i=1; AJvYcCWX6ie90clHlI9w7oMBtR21dykR86Eawy71On1RO2uIrYEy46/QQAsuGoDZ88I9xVp1frupt8bdgqsZfDw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2LRkb/dXYXdevjU5jJSsxX38rVnivl8xYHkvMZI5JMDdgyN9Q
	kMIGkEP7gBmbu4BKAQ5N0ASRNTquVOhYmqrcNf+DgAj1XA+1EOSF2iVge94Ey7Jpf77aFmGhovu
	qfOvt/CbzFOnm1NbK+FlMhOOEVyM=
X-Google-Smtp-Source: AGHT+IHpGKIOejf5iRK2qFu64BjRL/QI8CawWgIdyDY+8/fGVSi35n4BU6U1tnTTr0Qo/rjJiqLbZzf9VgtOLcmclhs=
X-Received: by 2002:a05:6512:3b8e:b0:537:a855:7d6f with SMTP id
 2adb3069b0e04-539ab891f52mr4358542e87.34.1728225454894; Sun, 06 Oct 2024
 07:37:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241001-strict_numa-v3-1-ee31405056ee@gentwo.org>
In-Reply-To: <20241001-strict_numa-v3-1-ee31405056ee@gentwo.org>
From: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Date: Sun, 6 Oct 2024 23:37:22 +0900
Message-ID: <CAB=+i9T8cOLQt4YprvUghwWZx1nOaiQ-0vV1N1zOOHWAFXza0Q@mail.gmail.com>
Subject: Re: [PATCH v3] SLUB: Add support for per object memory policies
To: cl@gentwo.org
Cc: Vlastimil Babka <vbabka@suse.cz>, Pekka Enberg <penberg@kernel.org>, 
	David Rientjes <rientjes@google.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Yang Shi <shy828301@gmail.com>, Christoph Lameter <cl@linux.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	Huang Shijie <shijie@os.amperecomputing.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 2, 2024 at 4:08=E2=80=AFAM Christoph Lameter via B4 Relay
<devnull+cl.gentwo.org@kernel.org> wrote:
>
> From: Christoph Lameter <cl@gentwo.org>
>
>     The old SLAB allocator used to support memory policies on a per
>     allocation bases. In SLUB the memory policies are applied on a
>     per page frame / folio bases. Doing so avoids having to check memory
>     policies in critical code paths for kmalloc and friends.
>
>     This worked on general well on Intel/AMD/PowerPC because the
>     interconnect technology is mature and can minimize the latencies
>     through intelligent caching even if a small object is not
>     placed optimally.
>
>     However, on ARM we have an emergence of new NUMA interconnect
>     technology based more on embedded devices. Caching of remote content
>     can currently be ineffective using the standard building blocks / mes=
h
>     available on that platform. Such architectures benefit if each slab
>     object is individually placed according to memory policies
>     and other restrictions.
>
>     This patch adds another kernel parameter
>
>             slab_strict_numa
>
>     If that is set then a static branch is activated that will cause
>     the hotpaths of the allocator to evaluate the current memory
>     allocation policy. Each object will be properly placed by
>     paying the price of extra processing and SLUB will no longer
>     defer to the page allocator to apply memory policies at the
>     folio level.
>
>     This patch improves performance of memcached running
>     on Ampere Altra 2P system (ARM Neoverse N1 processor)
>     by 3.6% due to accurate placement of small kernel objects.
>
> Tested-by: Huang Shijie <shijie@os.amperecomputing.com>
> Signed-off-by: Christoph Lameter (Ampere) <cl@gentwo.org>
> ---
> Changes in v3:
> - Make the static key a static in slub.c
> - Use pr_warn / pr_info instead of printk
> - Link to v2: https://lore.kernel.org/r/20240906-strict_numa-v2-1-f104e6d=
e6d1e@gentwo.org
>
> Changes in v2:
> - Fix various issues
> - Testing
> ---
>  mm/slub.c | 42 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 42 insertions(+)
>
> diff --git a/mm/slub.c b/mm/slub.c
> index 21f71cb6cc06..7ae94f79740d 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -218,6 +218,10 @@ DEFINE_STATIC_KEY_FALSE(slub_debug_enabled);
>  #endif
>  #endif         /* CONFIG_SLUB_DEBUG */
>
> +#ifdef CONFIG_NUMA
> +static DEFINE_STATIC_KEY_FALSE(strict_numa);
> +#endif
> +
>  /* Structure holding parameters for get_partial() call chain */
>  struct partial_context {
>         gfp_t flags;
> @@ -3957,6 +3961,28 @@ static __always_inline void *__slab_alloc_node(str=
uct kmem_cache *s,
>         object =3D c->freelist;
>         slab =3D c->slab;
>
> +#ifdef CONFIG_NUMA
> +       if (static_branch_unlikely(&strict_numa) &&
> +                       node =3D=3D NUMA_NO_NODE) {
> +
> +               struct mempolicy *mpol =3D current->mempolicy;
> +
> +               if (mpol) {
> +                       /*
> +                        * Special BIND rule support. If existing slab
> +                        * is in permitted set then do not redirect
> +                        * to a particular node.
> +                        * Otherwise we apply the memory policy to get
> +                        * the node we need to allocate on.
> +                        */
> +                       if (mpol->mode !=3D MPOL_BIND || !slab ||
> +                                       !node_isset(slab_nid(slab), mpol-=
>nodes))
> +
> +                               node =3D mempolicy_slab_node();
> +               }

Is it intentional to allow the local node only (via
mempolicy_slab_node()) in interrupt contexts?

> +       }
> +#endif
> +
>         if (!USE_LOCKLESS_FAST_PATH() ||
>             unlikely(!object || !slab || !node_match(slab, node))) {
>                 object =3D __slab_alloc(s, gfpflags, node, addr, c, orig_=
size);
> @@ -5601,6 +5627,22 @@ static int __init setup_slub_min_objects(char *str=
)
>  __setup("slab_min_objects=3D", setup_slub_min_objects);
>  __setup_param("slub_min_objects=3D", slub_min_objects, setup_slub_min_ob=
jects, 0);
>
> +#ifdef CONFIG_NUMA
> +static int __init setup_slab_strict_numa(char *str)
> +{
> +       if (nr_node_ids > 1) {
> +               static_branch_enable(&strict_numa);
> +               pr_info("SLUB: Strict NUMA enabled.\n");
> +       } else
> +               pr_warn("slab_strict_numa parameter set on non NUMA syste=
m.\n");

nit: this statement should be enclosed within braces per coding style guide=
line.
Otherwise everything looks good to me (including the document amended).

Best,
Hyeonggon

