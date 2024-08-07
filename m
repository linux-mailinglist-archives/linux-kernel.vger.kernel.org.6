Return-Path: <linux-kernel+bounces-277417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B02F094A119
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 08:53:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 646CC28C075
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 06:53:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 748AB1B86E5;
	Wed,  7 Aug 2024 06:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="X6B4o0wC"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C29191B86DC
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 06:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723013553; cv=none; b=a49+6JOVWQNDSF61xwXTGDxmbA/YX5nZ7P8S6xMvLzS4KmtPbjcvrEjzmVfaUev7UcVmM0B7F9bYax62rlVeS3qwIiD2qrUhm/cwo6/uyff6hWjrtIrMGziDxHiuEAUIqeSeAD3Y4+2qRNYEaSrkAcYrNOqWltKDPmI/THaBxJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723013553; c=relaxed/simple;
	bh=w2k/1GAk/8e3BZcu7LRZq57LRIyFylfLKs6FQXVsiYY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PBv09og+kj1k5X9XUcXg8PwGdhN56e+bXDAYeBcIVPPzV1MLSjMHJRPvbncZ4cPIupnAjKfbD+iHdnETzsawNsx2kIeDYUhh/QOFNbZ/B/risNsb5GdPyVrcHlFZLRjsXEd/PWRO+DxQtImpk/dIPcoBHDRz29dN8sMiKPWLuFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=X6B4o0wC; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-70f5ef740b7so1169403b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 23:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1723013551; x=1723618351; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ojZPHCizjT8+8LuseW1+ElDUzxljEVvHbFiBE43a/C8=;
        b=X6B4o0wCpw8G4JHmq/FLyCoVkTQqFVECcbobmuP7h18MvdaAfNc15OD/4mUZeCK3xk
         bmIWnUG2SgG0LOdmqC3qy2kiX6Vm533Yqg+4+yAZQP2qaDZbxpQQXmnqZ6j9PXovwQZU
         FfXn1YdbK3g2qf8k7lJgV1dkpaa1PqdhrrwXOXK6995VTPDI1Kkvvzgm1MlCmRcvOHk/
         IMuiR2cmWtDe0qxJ0Gv2YKClXgJyilV9zg5Ui8ZDDcay1kC49UWCLCJbi0Vrh0xWPtLS
         bXNdhj7xCawHNwjGfV84M+GjJMwn1W8D7rLQdCGodf6dZjOENOgNY7LGgBR4MxFXEu42
         s7YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723013551; x=1723618351;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ojZPHCizjT8+8LuseW1+ElDUzxljEVvHbFiBE43a/C8=;
        b=uwvYHgw2Y7TZBg1lzZrwiEBjkJhsVS0SsIt/O06itfScU5EkErUF/P9C7YDBeNwU6V
         xXs8LsaEK6hiqhj8FLh31HlldxsA4VYXQaxqPpYzWECeB5TUW5FC24e0sU2HyXsqCVSa
         ScLTxcln1l8KA8EVZtxPTcXpLN11N2a9m0LT5HsgQI9ofbkZGYZBaWvAMzvh/vMXiXpC
         IeiKlsFPSel8ZwgLFtIu6iTeoBo+YQl2Uy/LkHHa4EUM3aTqFEbJ9GC7khmro5PdK6zL
         eoRPjxMBFtUBhqaB0jaQaBid/WhLi6+73yCPBTEtUU9trJSVSTJ22yLbjTk0nNyiwR0P
         ZQtw==
X-Forwarded-Encrypted: i=1; AJvYcCVUbsh0Pc0jzQK7kauqUP+YdMe9e+inG5qcmtR2d4q/xz+LmszEfXy43FNnP0WCL9M3gbNQSVyBiGhvmgi89X70Hn9cSCTBFTAgT2Pi
X-Gm-Message-State: AOJu0YwEPUvXqCycuLVeV02SPLmxbYrZSr9h0sYtNvPf+tsJh9fpXmqt
	tSHptJ11lQ4kYJBdyz/80J6FpqjTUfvV6YPOnGaso/r6RVD2U8Ycj4FfxCAaz6k4l0gZaR7vfhh
	SHGDNMoFCjgsMrYdZioctUB/Ulc2Hkyj5moUn
X-Google-Smtp-Source: AGHT+IETt1KM8mTnwNBX/+Qs7S9wNiln513XQSwOOCU5mmeBIz6oHmWu32ViLfcmLt4UwTl+aQsEffppahddkuy8SIg=
X-Received: by 2002:a05:6a21:38b:b0:1c0:f77e:2521 with SMTP id
 adf61e73a8af0-1c69958230emr22419273637.19.1723013550618; Tue, 06 Aug 2024
 23:52:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240805082106.65847-1-jasowang@redhat.com>
In-Reply-To: <20240805082106.65847-1-jasowang@redhat.com>
From: Yongji Xie <xieyongji@bytedance.com>
Date: Wed, 7 Aug 2024 14:52:19 +0800
Message-ID: <CACycT3uM1jSdqFT0LGqy1zXZkWF8BNQN=8EMKYMoyP_wjRtsng@mail.gmail.com>
Subject: Re: [PATCH] vduse: avoid using __GFP_NOFAIL
To: Jason Wang <jasowang@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Eugenio Perez Martin <eperezma@redhat.com>, Maxime Coquelin <maxime.coquelin@redhat.com>, 
	virtualization@lists.linux.dev, linux-kernel <linux-kernel@vger.kernel.org>, 
	21cnbao@gmail.com, penguin-kernel@i-love.sakura.ne.jp, linux-mm@kvack.org, 
	Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 5, 2024 at 4:21=E2=80=AFPM Jason Wang <jasowang@redhat.com> wro=
te:
>
> Barry said [1]:
>
> """
> mm doesn't support non-blockable __GFP_NOFAIL allocation. Because
> __GFP_NOFAIL without direct reclamation may just result in a busy
> loop within non-sleepable contexts.
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
> the release). We pay this for more memory usage but further
> optimizations could be done on top.
>
> [1] https://lore.kernel.org/all/CACGkMEtcOJAA96SF9B8m-nZ1X04-XZr+nq8ZQ2sa=
LnUdfOGOLg@mail.gmail.com/T/#m3caef86a66ea6318ef94f9976ddb3a0ccfe6fcf8
> [2] https://lore.kernel.org/all/CACGkMEtcOJAA96SF9B8m-nZ1X04-XZr+nq8ZQ2sa=
LnUdfOGOLg@mail.gmail.com/T/#m7ad10eaba48ade5abf2d572f24e185d9fb146480
>
> Fixes: 6c77ed22880d ("vduse: Support using userspace pages as bounce buff=
er")
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---

Reviewed-by: Xie Yongji <xieyongji@bytedance.com>
Tested-by: Xie Yongji <xieyongji@bytedance.com>

Have tested it with qemu-storage-daemon [1]:

$ qemu-storage-daemon \
    --chardev socket,id=3Dcharmonitor,path=3D/tmp/qmp.sock,server=3Don,wait=
=3Doff \
    --monitor chardev=3Dcharmonitor \
    --blockdev driver=3Dhost_device,cache.direct=3Don,aio=3Dnative,filename=
=3D/dev/nullb0,node-name=3Ddisk0
\
    --export type=3Dvduse-blk,id=3Dvduse-test,name=3Dvduse-test,node-name=
=3Ddisk0,writable=3Don

[1] https://github.com/bytedance/qemu/tree/vduse-umem

>  drivers/vdpa/vdpa_user/iova_domain.c | 18 ++++++++++--------
>  drivers/vdpa/vdpa_user/iova_domain.h |  1 +
>  2 files changed, 11 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/vdpa/vdpa_user/iova_domain.c b/drivers/vdpa/vdpa_use=
r/iova_domain.c
> index 791d38d6284c..933d2f7cd49a 100644
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
> @@ -297,17 +300,16 @@ void vduse_domain_remove_user_bounce_pages(struct v=
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

map->user_bounce_page =3D NULL?

Thanks,
Yongji

