Return-Path: <linux-kernel+bounces-288762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F25B3953E3B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 02:20:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76A1A1F24C83
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 00:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27FD21C14;
	Fri, 16 Aug 2024 00:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="blEh+i/d"
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98D3C1803A
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 00:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723767449; cv=none; b=g0wtOxvdrJ7XH8UuWpxJEVqVQuAbDAyZ/P3rta+B5StQQ15GhgNDEv617JNx6YfQO+49j6eBPpMSX/Nnjyi+aILFQEa6XB+W6JymC0nWQBPH1PlumHTpTYmbF3KBLYyTgAVKdTpRkqqwiOi07VoCv2TiTtizowgWwqjKbLTIoyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723767449; c=relaxed/simple;
	bh=ZwYyn8JbhkHG8k3gvkoDcn6Gy9hLkeQeH18puVBeNH4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lJo/pWQ9jpIbuOxYj9P9RkFy/SWg9XiISSKfiTjZ11W93KU6TxnTkfxzgT/e3i6l1sjaI23Hfx4D3+R2b2NqDb1UPxklAsKl4Y+y0pmTgTNS4W5yLYHnK7b10VYI4LDonnMugLe3CV+JKaI4cnzQuAbCZcVkgu14dxWEANHpyEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=blEh+i/d; arc=none smtp.client-ip=209.85.217.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-493d7455231so529381137.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 17:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723767446; x=1724372246; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d2YrHTGtF+jpWM5UfiAgi4NfEMMQPWNtG43MOc6x070=;
        b=blEh+i/dsb/C1uJoKnMH9NNquH0w3tEGCsN7d7WsGOF5TEZIluzMMkD+txVCorGRxM
         IqDqmTdkRGG+bYO3MiFnFZb1AkLhFZFlYdQ2QyT82izSDoxcGftagPuosQpeDj/qDeEq
         SoyOyA/Jfx9LQebMGVuyv4i19m0YIa+/KljnrUOnWq1iD72A2qBWBjl6XkxhZhH3RQgI
         p6lAiC09lo1haoieDxFX+XdnGHQ3vqPgkKoWNo6+d7tHbjfiFvOMMu65ctXffc3FHSWi
         qyWWqApTr1po3uYzrT65gR5/GnpIyIGFmmSsr4CgKzDwIYafKlexKvC+VJsbR11iknmQ
         pEEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723767446; x=1724372246;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d2YrHTGtF+jpWM5UfiAgi4NfEMMQPWNtG43MOc6x070=;
        b=NP67qmbboip3o5ttxzo1aGcdMmVgFQeRG8yKIDCjv1WqFVlu3ZvMWIyZ8iXDbKf87p
         L8Ej3GHSAx60CuK3kepxAA1j3wupIdeSXA/UgumVo1MQs0gKer6X/q5Hvpwaqvf9wxXw
         mtvo19NtYhgMArqdYIT/8Fc07JK5uAiLE3fdekrJb4MmXLdG50aVs5ndXE7CVbtkdLDw
         T52RsSv6Y9ycFUtAxWjisznBdqlO7w8bTaYIHZRSQvgzhbSu8A+LORO8XTGpsGcbehYH
         ZEbu3FhR6qcxZQUJbSZS8E+YDJH85sUNgTIC8ADapnrzPg9Gk6uSKYbDXcnxUAxUvUJ7
         19lw==
X-Forwarded-Encrypted: i=1; AJvYcCVpa0L87EWlRMKzdqr27tG7iaOolrRWdX8vfJK5xfUROWE+Tkf+ZoOUhk92Nbee2Bw8dS8yHDUXhVjEH3LBeMxnt3pbA3M2RrPV5Ewm
X-Gm-Message-State: AOJu0Yw668BhAWtDzScUSBMn0maq9E6O3VDxjIIRRNLz+Wrv/YrtQ1lF
	rEZjKP4zhNmKqo0UOHW3hLBEEr9KHV1By7xsQUd8vGybMLstmLwuOzP9BKdYMJJEFa/38OmEkZp
	a9x7LTJrR8UD/0wR+X5JS/DejMz+9Domr
X-Google-Smtp-Source: AGHT+IG2EoyBilLVQRqv96CAY/4lhYl5dk+AsKpgy8jtfXimSLSsr1+QAjSQU2FxDWwQSJPkVV+riCGX4oxoxLLt55Q=
X-Received: by 2002:a05:6102:6cd:b0:48f:e9d9:3ad4 with SMTP id
 ada2fe7eead31-4977997657fmr1965982137.19.1723767446049; Thu, 15 Aug 2024
 17:17:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240808054320.10017-1-jasowang@redhat.com>
In-Reply-To: <20240808054320.10017-1-jasowang@redhat.com>
From: Barry Song <21cnbao@gmail.com>
Date: Fri, 16 Aug 2024 12:17:14 +1200
Message-ID: <CAGsJ_4ze4YAOSfM5+6Wj1-EcGNaaJQ-S2Ljzm4egjRsXdDp5MA@mail.gmail.com>
Subject: Re: [PATCH v2] vduse: avoid using __GFP_NOFAIL
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com, 
	maxime.coquelin@redhat.com, xieyongji@bytedance.com, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	penguin-kernel@i-love.sakura.ne.jp, linux-mm@kvack.org, 
	akpm@linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 8, 2024 at 5:43=E2=80=AFPM Jason Wang <jasowang@redhat.com> wro=
te:
>
> Barry said [1]:
>
> """
> mm doesn't support non-blockable __GFP_NOFAIL allocation. Because
> __GFP_NOFAIL without direct reclamation may just result in a busy
> loop within non-sleepable contexts.
>
> The current code will result in returning a NULL pointer but
> not a busy-loop.
>
> static inline struct page *
> __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
>                                                 struct alloc_context *ac)
> {
>         ...
>         /*
>          * Make sure that __GFP_NOFAIL request doesn't leak out and make =
sure
>          * we always retry
>          */
>         if (gfp_mask & __GFP_NOFAIL) {
>                 /*
>                  * All existing users of the __GFP_NOFAIL are blockable, =
so warn
>                  * of any new users that actually require GFP_NOWAIT
>                  */
>                 if (WARN_ON_ONCE_GFP(!can_direct_reclaim, gfp_mask))
>                         goto fail;
>                 ...
>         }
>         ...
> fail:
>         warn_alloc(gfp_mask, ac->nodemask,
>                         "page allocation failure: order:%u", order);
> got_pg:
>         return page;
> }
>
> We have two choices to address the issue:
> 1. busy-loop
> 2. BUG_ON
>
> the below patch chose 2:
> https://lore.kernel.org/linux-mm/20240731000155.109583-5-21cnbao@gmail.co=
m/
> ""=E2=80=9C
>
> Unfortuantely, we do that under read lock. A possible way to fix that
> is to move the pages allocation out of the lock into the caller, but
> having to allocate a huge number of pages and auxiliary page array
> seems to be problematic as well per Tetsuon [2]:
>
> """
> You should implement proper error handling instead of using
> __GFP_NOFAIL if count can become large.
> """
>
> So I choose another way, which does not release kernel bounce pages
> when user tries to register usersapce bounce pages. Then we don't need
> to do allocation in the path which is not expected to be fail (e.g in
> the release). We pay this for more memory usage as we don't release
> kernel bounce pages but further optimizations could be done on top.
>
> [1] https://lore.kernel.org/all/CACGkMEtcOJAA96SF9B8m-nZ1X04-XZr+nq8ZQ2sa=
LnUdfOGOLg@mail.gmail.com/T/#m3caef86a66ea6318ef94f9976ddb3a0ccfe6fcf8
> [2] https://lore.kernel.org/all/CACGkMEtcOJAA96SF9B8m-nZ1X04-XZr+nq8ZQ2sa=
LnUdfOGOLg@mail.gmail.com/T/#m7ad10eaba48ade5abf2d572f24e185d9fb146480
>
> Fixes: 6c77ed22880d ("vduse: Support using userspace pages as bounce buff=
er")
> Reviewed-by: Xie Yongji <xieyongji@bytedance.com>
> Tested-by: Xie Yongji <xieyongji@bytedance.com>
> Signed-off-by: Jason Wang <jasowang@redhat.com>

Hi Jason,

Is this the final version to fix __GFP_NOFAIL issue, or will you have a new
version?
Do you prefer it to go through the mm tree or the drivers subsystem tree?
If it's the former, I can send a new version that includes this one in my
series[1].

[1] https://lore.kernel.org/linux-mm/20240731000155.109583-1-21cnbao@gmail.=
com/

> ---
> Changes since V1:
> - Tweak the commit log
> - Assign map->user_bounce_page to NULL for safety
> ---
>  drivers/vdpa/vdpa_user/iova_domain.c | 19 +++++++++++--------
>  drivers/vdpa/vdpa_user/iova_domain.h |  1 +
>  2 files changed, 12 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/vdpa/vdpa_user/iova_domain.c b/drivers/vdpa/vdpa_use=
r/iova_domain.c
> index 791d38d6284c..58116f89d8da 100644
> --- a/drivers/vdpa/vdpa_user/iova_domain.c
> +++ b/drivers/vdpa/vdpa_user/iova_domain.c
> @@ -162,6 +162,7 @@ static void vduse_domain_bounce(struct vduse_iova_dom=
ain *domain,
>                                 enum dma_data_direction dir)
>  {
>         struct vduse_bounce_map *map;
> +       struct page *page;
>         unsigned int offset;
>         void *addr;
>         size_t sz;
> @@ -178,7 +179,10 @@ static void vduse_domain_bounce(struct vduse_iova_do=
main *domain,
>                             map->orig_phys =3D=3D INVALID_PHYS_ADDR))
>                         return;
>
> -               addr =3D kmap_local_page(map->bounce_page);
> +               page =3D domain->user_bounce_pages ?
> +                      map->user_bounce_page : map->bounce_page;
> +
> +               addr =3D kmap_local_page(page);
>                 do_bounce(map->orig_phys + offset, addr + offset, sz, dir=
);
>                 kunmap_local(addr);
>                 size -=3D sz;
> @@ -270,9 +274,8 @@ int vduse_domain_add_user_bounce_pages(struct vduse_i=
ova_domain *domain,
>                                 memcpy_to_page(pages[i], 0,
>                                                page_address(map->bounce_p=
age),
>                                                PAGE_SIZE);
> -                       __free_page(map->bounce_page);
>                 }
> -               map->bounce_page =3D pages[i];
> +               map->user_bounce_page =3D pages[i];
>                 get_page(pages[i]);
>         }
>         domain->user_bounce_pages =3D true;
> @@ -297,17 +300,17 @@ void vduse_domain_remove_user_bounce_pages(struct v=
duse_iova_domain *domain)
>                 struct page *page =3D NULL;
>
>                 map =3D &domain->bounce_maps[i];
> -               if (WARN_ON(!map->bounce_page))
> +               if (WARN_ON(!map->user_bounce_page))
>                         continue;
>
>                 /* Copy user page to kernel page if it's in use */
>                 if (map->orig_phys !=3D INVALID_PHYS_ADDR) {
> -                       page =3D alloc_page(GFP_ATOMIC | __GFP_NOFAIL);
> +                       page =3D map->bounce_page;
>                         memcpy_from_page(page_address(page),
> -                                        map->bounce_page, 0, PAGE_SIZE);
> +                                        map->user_bounce_page, 0, PAGE_S=
IZE);
>                 }
> -               put_page(map->bounce_page);
> -               map->bounce_page =3D page;
> +               put_page(map->user_bounce_page);
> +               map->user_bounce_page =3D NULL;
>         }
>         domain->user_bounce_pages =3D false;
>  out:
> diff --git a/drivers/vdpa/vdpa_user/iova_domain.h b/drivers/vdpa/vdpa_use=
r/iova_domain.h
> index f92f22a7267d..7f3f0928ec78 100644
> --- a/drivers/vdpa/vdpa_user/iova_domain.h
> +++ b/drivers/vdpa/vdpa_user/iova_domain.h
> @@ -21,6 +21,7 @@
>
>  struct vduse_bounce_map {
>         struct page *bounce_page;
> +       struct page *user_bounce_page;
>         u64 orig_phys;
>  };
>
> --
> 2.31.1
>

Thanks
Barry

