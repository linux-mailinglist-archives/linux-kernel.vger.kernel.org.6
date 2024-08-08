Return-Path: <linux-kernel+bounces-278815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 08B1494B542
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 04:58:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B6721C2124C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 02:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A96C2A1D8;
	Thu,  8 Aug 2024 02:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HD8rqLQb"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE07F4C97
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 02:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723085904; cv=none; b=EY/zrFY1kEeI+TlpThqcytYWhiCmQjBYmh/Fs9jbPWKesFuXps8kqSJqb/noc61R/bU0zOcq1aoEqZHL8hQOWkNshau3POzVFwrqEnal7IORvsalgDKOKb2jXBcPGgLKGXnU4c1XGufGE+GDdnlvRTMzfLRN1F+f7RSFllnP0K0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723085904; c=relaxed/simple;
	bh=VNMGCN3K7dYB2D1yFW8pEkV/m/ZDheqzNYCNmyk0nZc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CYi9kYoQus8dmWLQxVwnGMvDUG+XqAQElOSNOobhrEoBryP0eRFKl8O8Je3NqS0R3yAcOjjJyyt43rrLVvzwnzljwWx4VbXi+s519FPkWxhzAVcJsWdT2Ww5RbWVzArxPz/phH3rArh4J8xTqVgqIFjdxhWRsYzOt8PAyibG6PM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HD8rqLQb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723085901;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ms7GM5nBFpICUPNkIa1lvEOGwID30MEVHv5V6CEvL58=;
	b=HD8rqLQbD3D1kt+tpTls4xtQmWjOAWghu4GDQpq9pGO1IrnJHjzvrRrGGt1AR6Nd70RWx/
	Et8oCC/b3UhrOB84DcfRg1CE+SrOwm1mniGpd2h232Kmi17ZwRlIQX8eXR1rrEhYZrL+DV
	2N0rTVWQ8oYbhKulO2T8cYSPciYpzBk=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-475-2kdozWm3NmK3heaWxtATlA-1; Wed, 07 Aug 2024 22:58:20 -0400
X-MC-Unique: 2kdozWm3NmK3heaWxtATlA-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2cb68c23a00so1500466a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2024 19:58:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723085899; x=1723690699;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ms7GM5nBFpICUPNkIa1lvEOGwID30MEVHv5V6CEvL58=;
        b=cUn1bVW1bHQy2NBFJhd9CZVp4X+qgGQqTyZbp3m+4LiLFxHFw2DNVFNyGpimL1Gafp
         zeTMzXEM8TSkGIjauc7bqPOMCt+zX1NruJvMC81ZHZGedJCUhGxbAFiC7QSfUbubgFRv
         hgarFBkip23e4SjE4gOkMuJxQYs5oJEKaXgRTVtRrqW1FCeER+mIvZ3g8GthQu60qFSN
         W/mivYdMvGSMa1wdxGlj5LJ7jgph2SxQptMyPtUlmJLmzVgJRUfPgmmc9Qcs8pshBgGt
         EjBMy8mrS6ivSVkvC4RX++3IqLiu5BJ5qA6JBwZ47+WzXOTn7/d36XLqzVQOrtrZInGj
         MbUA==
X-Forwarded-Encrypted: i=1; AJvYcCXMIwztS+IxOlx23GkLfrZt726enjXO9hzRZkCKu5Vb8X1xLRKMRe815um+4y2Zgiy6eHmiTT7itEntIxCgosnZqoMTTck9giN+yDDa
X-Gm-Message-State: AOJu0Ywvt76mQWJ/kZDNRnaQDxX2Do5wAQWMlHUGAZF65dUUjme+z5M0
	92eZjLzeW090k1LwA6wZsVvPjFEOzev1EEiX3MSKsAVPVtVNCgewL6MHzMLettbxKESBRL/+dGr
	tzF3FOm9orIIOTwvnedpfueXYNinFe9c+j2Egj1zvghb49KjuherPcMncr+YF5n2SXZI2IMeTkL
	ZwPu3e+5eB/XrMO68tZq/2IvG2Q9Vxm4s+lSdu
X-Received: by 2002:a17:90a:17ec:b0:2c9:36bf:ba6f with SMTP id 98e67ed59e1d1-2d1c4f7ffcemr449634a91.3.1723085899405;
        Wed, 07 Aug 2024 19:58:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEHPsusqODlyN/Y2NKkNEN5MV4OvfYjQpK1hVjQHlsFtCjwUc/HVVj2xAjML9dJtaAFFSkIKjg4vo+eHiHKsy4=
X-Received: by 2002:a17:90a:17ec:b0:2c9:36bf:ba6f with SMTP id
 98e67ed59e1d1-2d1c4f7ffcemr449586a91.3.1723085898669; Wed, 07 Aug 2024
 19:58:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240805082106.65847-1-jasowang@redhat.com> <CACycT3uM1jSdqFT0LGqy1zXZkWF8BNQN=8EMKYMoyP_wjRtsng@mail.gmail.com>
In-Reply-To: <CACycT3uM1jSdqFT0LGqy1zXZkWF8BNQN=8EMKYMoyP_wjRtsng@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 8 Aug 2024 10:58:07 +0800
Message-ID: <CACGkMEtYE1OY+okxHAj=cVfW-Qz45an28oO=Wv15yOtpD6UqdQ@mail.gmail.com>
Subject: Re: [PATCH] vduse: avoid using __GFP_NOFAIL
To: Yongji Xie <xieyongji@bytedance.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Eugenio Perez Martin <eperezma@redhat.com>, Maxime Coquelin <maxime.coquelin@redhat.com>, 
	virtualization@lists.linux.dev, linux-kernel <linux-kernel@vger.kernel.org>, 
	21cnbao@gmail.com, penguin-kernel@i-love.sakura.ne.jp, linux-mm@kvack.org, 
	Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 7, 2024 at 2:52=E2=80=AFPM Yongji Xie <xieyongji@bytedance.com>=
 wrote:
>
> On Mon, Aug 5, 2024 at 4:21=E2=80=AFPM Jason Wang <jasowang@redhat.com> w=
rote:
> >
> > Barry said [1]:
> >
> > """
> > mm doesn't support non-blockable __GFP_NOFAIL allocation. Because
> > __GFP_NOFAIL without direct reclamation may just result in a busy
> > loop within non-sleepable contexts.
> > ""=E2=80=9C
> >
> > Unfortuantely, we do that under read lock. A possible way to fix that
> > is to move the pages allocation out of the lock into the caller, but
> > having to allocate a huge number of pages and auxiliary page array
> > seems to be problematic as well per Tetsuon [2]:
> >
> > """
> > You should implement proper error handling instead of using
> > __GFP_NOFAIL if count can become large.
> > """
> >
> > So I choose another way, which does not release kernel bounce pages
> > when user tries to register usersapce bounce pages. Then we don't need
> > to do allocation in the path which is not expected to be fail (e.g in
> > the release). We pay this for more memory usage but further
> > optimizations could be done on top.
> >
> > [1] https://lore.kernel.org/all/CACGkMEtcOJAA96SF9B8m-nZ1X04-XZr+nq8ZQ2=
saLnUdfOGOLg@mail.gmail.com/T/#m3caef86a66ea6318ef94f9976ddb3a0ccfe6fcf8
> > [2] https://lore.kernel.org/all/CACGkMEtcOJAA96SF9B8m-nZ1X04-XZr+nq8ZQ2=
saLnUdfOGOLg@mail.gmail.com/T/#m7ad10eaba48ade5abf2d572f24e185d9fb146480
> >
> > Fixes: 6c77ed22880d ("vduse: Support using userspace pages as bounce bu=
ffer")
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > ---
>
> Reviewed-by: Xie Yongji <xieyongji@bytedance.com>
> Tested-by: Xie Yongji <xieyongji@bytedance.com>

Thanks.

>
> Have tested it with qemu-storage-daemon [1]:
>
> $ qemu-storage-daemon \
>     --chardev socket,id=3Dcharmonitor,path=3D/tmp/qmp.sock,server=3Don,wa=
it=3Doff \
>     --monitor chardev=3Dcharmonitor \
>     --blockdev driver=3Dhost_device,cache.direct=3Don,aio=3Dnative,filena=
me=3D/dev/nullb0,node-name=3Ddisk0
> \
>     --export type=3Dvduse-blk,id=3Dvduse-test,name=3Dvduse-test,node-name=
=3Ddisk0,writable=3Don
>
> [1] https://github.com/bytedance/qemu/tree/vduse-umem

Great, would you want to post them to the Qemu?

>
> >  drivers/vdpa/vdpa_user/iova_domain.c | 18 ++++++++++--------
> >  drivers/vdpa/vdpa_user/iova_domain.h |  1 +
> >  2 files changed, 11 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/vdpa/vdpa_user/iova_domain.c b/drivers/vdpa/vdpa_u=
ser/iova_domain.c
> > index 791d38d6284c..933d2f7cd49a 100644
> > --- a/drivers/vdpa/vdpa_user/iova_domain.c
> > +++ b/drivers/vdpa/vdpa_user/iova_domain.c
> > @@ -162,6 +162,7 @@ static void vduse_domain_bounce(struct vduse_iova_d=
omain *domain,
> >                                 enum dma_data_direction dir)
> >  {
> >         struct vduse_bounce_map *map;
> > +       struct page *page;
> >         unsigned int offset;
> >         void *addr;
> >         size_t sz;
> > @@ -178,7 +179,10 @@ static void vduse_domain_bounce(struct vduse_iova_=
domain *domain,
> >                             map->orig_phys =3D=3D INVALID_PHYS_ADDR))
> >                         return;
> >
> > -               addr =3D kmap_local_page(map->bounce_page);
> > +               page =3D domain->user_bounce_pages ?
> > +                      map->user_bounce_page : map->bounce_page;
> > +
> > +               addr =3D kmap_local_page(page);
> >                 do_bounce(map->orig_phys + offset, addr + offset, sz, d=
ir);
> >                 kunmap_local(addr);
> >                 size -=3D sz;
> > @@ -270,9 +274,8 @@ int vduse_domain_add_user_bounce_pages(struct vduse=
_iova_domain *domain,
> >                                 memcpy_to_page(pages[i], 0,
> >                                                page_address(map->bounce=
_page),
> >                                                PAGE_SIZE);
> > -                       __free_page(map->bounce_page);
> >                 }
> > -               map->bounce_page =3D pages[i];
> > +               map->user_bounce_page =3D pages[i];
> >                 get_page(pages[i]);
> >         }
> >         domain->user_bounce_pages =3D true;
> > @@ -297,17 +300,16 @@ void vduse_domain_remove_user_bounce_pages(struct=
 vduse_iova_domain *domain)
> >                 struct page *page =3D NULL;
> >
> >                 map =3D &domain->bounce_maps[i];
> > -               if (WARN_ON(!map->bounce_page))
> > +               if (WARN_ON(!map->user_bounce_page))
> >                         continue;
> >
> >                 /* Copy user page to kernel page if it's in use */
> >                 if (map->orig_phys !=3D INVALID_PHYS_ADDR) {
> > -                       page =3D alloc_page(GFP_ATOMIC | __GFP_NOFAIL);
> > +                       page =3D map->bounce_page;
> >                         memcpy_from_page(page_address(page),
> > -                                        map->bounce_page, 0, PAGE_SIZE=
);
> > +                                        map->user_bounce_page, 0, PAGE=
_SIZE);
> >                 }
> > -               put_page(map->bounce_page);
> > -               map->bounce_page =3D page;
> > +               put_page(map->user_bounce_page);
>
> map->user_bounce_page =3D NULL?

For safety, it might be better. Let me add this and post a V2/

Thanks

>
> Thanks,
> Yongji
>


