Return-Path: <linux-kernel+bounces-576961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F58BA716B2
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 13:30:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 986A77A536D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 12:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CD081E1E0D;
	Wed, 26 Mar 2025 12:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jPQ9Q+yW"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08FF81E1E0B
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 12:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742992242; cv=none; b=uAxXL4A1uO+fgg9a8/4S5bKHTMyzGVdfcKM7vQmyMnfUUBEIC4bAPeKPYh768c0ah34Pga6O3VcPuk74FhT8Sra+29YnKWQ4qmST3GJY4LRWn8xN5YJ9kmpvSDIjrXW1rBzhlY236ZLdQPws3OA1iLUiEJ3irDLMxG70i+uyvTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742992242; c=relaxed/simple;
	bh=LgtmqNrSHlnKtvwzHXwk58TV85eQJsA8R8IafG/GEpY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fujvKyqa5uj9Uu+G3D0aSYgOYDsA3PgHvxK/eZcqrv5MzrdrCNhJoTGMA5kgsCxKLFj+xBHEqokI/vHadtJc6GFc8X/OwFmW0TxFNn92hd2Y8qQz74uZIREPZLGWNwp2vAL9JMhWcYEhae8/CmKDbOFVtrDyLqQ7rAwFfnIEveI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jPQ9Q+yW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742992240;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TG4hOSlV51433RbXLsoSL52zL91v7u43plwp/pvXVeM=;
	b=jPQ9Q+yWML88u70s+cOvviBmuzE5ckzQs5jJlXAjB655Pe0OUo2lPF9J/TlBkYFWtgPKVk
	SSdARt3bkuICZmaT91k+JG6vbvqtmysCj5rXoAF18ywcxPaL4ZzhpR1dQP5Uxj29YJaEj1
	pZ60vpxoHmVddJUt+3Kt9+ZLQbNGBUo=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-361-kCM-BNlkNaar7cvDiHlAfA-1; Wed, 26 Mar 2025 08:30:35 -0400
X-MC-Unique: kCM-BNlkNaar7cvDiHlAfA-1
X-Mimecast-MFC-AGG-ID: kCM-BNlkNaar7cvDiHlAfA_1742992235
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2ff4b130bb2so11708375a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 05:30:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742992234; x=1743597034;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TG4hOSlV51433RbXLsoSL52zL91v7u43plwp/pvXVeM=;
        b=GUTCjqdIH2IAs41DKr+dO0gUvkK9MoAj6naXjiy5YKEHh+qRxJ4wPVwBnF/cMkf6Z3
         I2oP7pRAUJoAGPHzE8N+Hc10lDW0EMzINkO9/kE+Pq3IT5RCaVUjvMbOdSsWNgJ45wX0
         3F62WL3s+DRaS1Giv3Fynaz8iU9jQklc6bJFSqa3/h4ARcfxMSo2HnOt9OzcOLa7XVqf
         g0ujq3xGxmY3iSt/r5L1hVtlzgP9yGinJX8ONRHs4ADgag0ULb9P1A1WNQv9FtWG+oQz
         iWANGrfS0ae3T+Lt0cs707WCqTfGH8MXNGmMcIXHAdFIcMEO1HSoWvB7sZrqskZIaT8g
         J/+A==
X-Forwarded-Encrypted: i=1; AJvYcCVo0BWV8xO0bIka+5kmhwndXGxJXK2Ne/EX77OJ7vkH3XGPDYAnXrEnt2xQAKaJ8b5O+apPG7koiQKkVWM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPs1yrUikTiEnxWOVrnUKWgje3Llem6m26h8YLHa2W+DlzcGnp
	QJQXUr149Gd1MLG0Z0CJxQHD5ZIs0kc5QZhn2EL7HJkCqeRMpuiX0b0/mrHUZ4NTPb0UM+OdIFv
	izpAC7K++67hyWMjMzeQ0xJay0p64tZlm08p0zJn36du6crtgzxq1A6MEuN5QBp6rb93YrMY9m/
	ojvIL1VtMUJCY6x7+CCVXcWVF988rGBSAw94aAQmtJsuMu6Zo=
X-Gm-Gg: ASbGncu/7c9WVllDSLVcjScUd3iy4NzXx3cYh1ufL4iqQSxlWJYlqlT57Yt3XNxs3dk
	gd/XLqEiFRMsl2KBWrYnzF4VzDeanyGmpmNMadk2OYhzZ3L1RvNUERUXJ2wVSDtg3TBmIxI4=
X-Received: by 2002:a17:90a:ec8c:b0:2ff:6e72:b8e9 with SMTP id 98e67ed59e1d1-3030fee7104mr34945068a91.25.1742992233907;
        Wed, 26 Mar 2025 05:30:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IENhAMc3YEZ16YS5Hn9AKnW3lSqkO1WfZupLXyfCcU2r3XX6V/bDRqpagDOibCkDJsx9sj5B4/JsX9eOaiRgPA=
X-Received: by 2002:a17:90a:ec8c:b0:2ff:6e72:b8e9 with SMTP id
 98e67ed59e1d1-3030fee7104mr34944996a91.25.1742992233257; Wed, 26 Mar 2025
 05:30:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250324054333.1954-1-jasowang@redhat.com> <20250324054333.1954-7-jasowang@redhat.com>
In-Reply-To: <20250324054333.1954-7-jasowang@redhat.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 26 Mar 2025 13:29:57 +0100
X-Gm-Features: AQ5f1JpJ342Eh2KHZtcoMs5FNlOUTtFbR-VB9AcdClCRputrNawo7spgsqwBruw
Message-ID: <CAJaqyWeE2FnhF5kMV2NneWa4Fp6NK03NO=h_BcB1=3JUDpjUiA@mail.gmail.com>
Subject: Re: [PATCH 06/19] virtio_ring: switch to use vring_virtqueue for
 virtqueue_add variants
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, xuanzhuo@linux.alibaba.com, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 24, 2025 at 6:44=E2=80=AFAM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> Those variants are used internally so let's switch to use
> vring_virtqueue as parameter to be consistent with other internal
> virtqueue helpers.
>
> Signed-off-by: Jason Wang <jasowang@redhat.com>

Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

> ---
>  drivers/virtio/virtio_ring.c | 40 +++++++++++++++++-------------------
>  1 file changed, 19 insertions(+), 21 deletions(-)
>
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index cf3ab6404698..619869e80309 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -472,7 +472,7 @@ static unsigned int vring_unmap_one_split(const struc=
t vring_virtqueue *vq,
>         return extra->next;
>  }
>
> -static struct vring_desc *alloc_indirect_split(struct virtqueue *_vq,
> +static struct vring_desc *alloc_indirect_split(struct vring_virtqueue *v=
q,
>                                                unsigned int total_sg,
>                                                gfp_t gfp)
>  {
> @@ -501,7 +501,7 @@ static struct vring_desc *alloc_indirect_split(struct=
 virtqueue *_vq,
>         return desc;
>  }
>
> -static inline unsigned int virtqueue_add_desc_split(struct virtqueue *vq=
,
> +static inline unsigned int virtqueue_add_desc_split(struct vring_virtque=
ue *vq,
>                                                     struct vring_desc *de=
sc,
>                                                     struct vring_desc_ext=
ra *extra,
>                                                     unsigned int i,
> @@ -509,11 +509,12 @@ static inline unsigned int virtqueue_add_desc_split=
(struct virtqueue *vq,
>                                                     unsigned int len,
>                                                     u16 flags, bool prema=
pped)
>  {
> +       struct virtio_device *vdev =3D vq->vq.vdev;
>         u16 next;
>
> -       desc[i].flags =3D cpu_to_virtio16(vq->vdev, flags);
> -       desc[i].addr =3D cpu_to_virtio64(vq->vdev, addr);
> -       desc[i].len =3D cpu_to_virtio32(vq->vdev, len);
> +       desc[i].flags =3D cpu_to_virtio16(vdev, flags);
> +       desc[i].addr =3D cpu_to_virtio64(vdev, addr);
> +       desc[i].len =3D cpu_to_virtio32(vdev, len);
>
>         extra[i].addr =3D premapped ? DMA_MAPPING_ERROR : addr;
>         extra[i].len =3D len;
> @@ -521,12 +522,12 @@ static inline unsigned int virtqueue_add_desc_split=
(struct virtqueue *vq,
>
>         next =3D extra[i].next;
>
> -       desc[i].next =3D cpu_to_virtio16(vq->vdev, next);
> +       desc[i].next =3D cpu_to_virtio16(vdev, next);
>
>         return next;
>  }
>
> -static inline int virtqueue_add_split(struct virtqueue *_vq,
> +static inline int virtqueue_add_split(struct vring_virtqueue *vq,
>                                       struct scatterlist *sgs[],
>                                       unsigned int total_sg,
>                                       unsigned int out_sgs,
> @@ -536,7 +537,6 @@ static inline int virtqueue_add_split(struct virtqueu=
e *_vq,
>                                       bool premapped,
>                                       gfp_t gfp)
>  {
> -       struct vring_virtqueue *vq =3D to_vvq(_vq);
>         struct vring_desc_extra *extra;
>         struct scatterlist *sg;
>         struct vring_desc *desc;
> @@ -561,7 +561,7 @@ static inline int virtqueue_add_split(struct virtqueu=
e *_vq,
>         head =3D vq->free_head;
>
>         if (virtqueue_use_indirect(vq, total_sg))
> -               desc =3D alloc_indirect_split(_vq, total_sg, gfp);
> +               desc =3D alloc_indirect_split(vq, total_sg, gfp);
>         else {
>                 desc =3D NULL;
>                 WARN_ON_ONCE(total_sg > vq->split.vring.num && !vq->indir=
ect);
> @@ -608,7 +608,7 @@ static inline int virtqueue_add_split(struct virtqueu=
e *_vq,
>                         /* Note that we trust indirect descriptor
>                          * table since it use stream DMA mapping.
>                          */
> -                       i =3D virtqueue_add_desc_split(_vq, desc, extra, =
i, addr, len,
> +                       i =3D virtqueue_add_desc_split(vq, desc, extra, i=
, addr, len,
>                                                      VRING_DESC_F_NEXT,
>                                                      premapped);
>                 }
> @@ -625,14 +625,14 @@ static inline int virtqueue_add_split(struct virtqu=
eue *_vq,
>                         /* Note that we trust indirect descriptor
>                          * table since it use stream DMA mapping.
>                          */
> -                       i =3D virtqueue_add_desc_split(_vq, desc, extra, =
i, addr, len,
> +                       i =3D virtqueue_add_desc_split(vq, desc, extra, i=
, addr, len,
>                                                      VRING_DESC_F_NEXT |
>                                                      VRING_DESC_F_WRITE,
>                                                      premapped);
>                 }
>         }
>         /* Last one doesn't continue. */
> -       desc[prev].flags &=3D cpu_to_virtio16(_vq->vdev, ~VRING_DESC_F_NE=
XT);
> +       desc[prev].flags &=3D cpu_to_virtio16(vq->vq.vdev, ~VRING_DESC_F_=
NEXT);
>         if (!indirect && vring_need_unmap_buffer(vq, &extra[prev]))
>                 vq->split.desc_extra[prev & (vq->split.vring.num - 1)].fl=
ags &=3D
>                         ~VRING_DESC_F_NEXT;
> @@ -645,7 +645,7 @@ static inline int virtqueue_add_split(struct virtqueu=
e *_vq,
>                 if (vring_mapping_error(vq, addr))
>                         goto unmap_release;
>
> -               virtqueue_add_desc_split(_vq, vq->split.vring.desc,
> +               virtqueue_add_desc_split(vq, vq->split.vring.desc,
>                                          vq->split.desc_extra,
>                                          head, addr,
>                                          total_sg * sizeof(struct vring_d=
esc),
> @@ -671,13 +671,13 @@ static inline int virtqueue_add_split(struct virtqu=
eue *_vq,
>         /* Put entry in available array (but don't update avail->idx unti=
l they
>          * do sync). */
>         avail =3D vq->split.avail_idx_shadow & (vq->split.vring.num - 1);
> -       vq->split.vring.avail->ring[avail] =3D cpu_to_virtio16(_vq->vdev,=
 head);
> +       vq->split.vring.avail->ring[avail] =3D cpu_to_virtio16(vq->vq.vde=
v, head);
>
>         /* Descriptors and available array need to be set before we expos=
e the
>          * new available array entries. */
>         virtio_wmb(vq->weak_barriers);
>         vq->split.avail_idx_shadow++;
> -       vq->split.vring.avail->idx =3D cpu_to_virtio16(_vq->vdev,
> +       vq->split.vring.avail->idx =3D cpu_to_virtio16(vq->vq.vdev,
>                                                 vq->split.avail_idx_shado=
w);
>         vq->num_added++;
>
> @@ -687,7 +687,7 @@ static inline int virtqueue_add_split(struct virtqueu=
e *_vq,
>         /* This is very unlikely, but theoretically possible.  Kick
>          * just in case. */
>         if (unlikely(vq->num_added =3D=3D (1 << 16) - 1))
> -               virtqueue_kick(_vq);
> +               virtqueue_kick(&vq->vq);
>
>         return 0;
>
> @@ -702,7 +702,6 @@ static inline int virtqueue_add_split(struct virtqueu=
e *_vq,
>         for (n =3D 0; n < total_sg; n++) {
>                 if (i =3D=3D err_idx)
>                         break;
> -
>                 i =3D vring_unmap_one_split(vq, &extra[i]);
>         }
>
> @@ -1441,7 +1440,7 @@ static int virtqueue_add_indirect_packed(struct vri=
ng_virtqueue *vq,
>         return -ENOMEM;
>  }
>
> -static inline int virtqueue_add_packed(struct virtqueue *_vq,
> +static inline int virtqueue_add_packed(struct vring_virtqueue *vq,
>                                        struct scatterlist *sgs[],
>                                        unsigned int total_sg,
>                                        unsigned int out_sgs,
> @@ -1451,7 +1450,6 @@ static inline int virtqueue_add_packed(struct virtq=
ueue *_vq,
>                                        bool premapped,
>                                        gfp_t gfp)
>  {
> -       struct vring_virtqueue *vq =3D to_vvq(_vq);
>         struct vring_packed_desc *desc;
>         struct scatterlist *sg;
>         unsigned int i, n, c, descs_used, err_idx, len;
> @@ -2263,9 +2261,9 @@ static inline int virtqueue_add(struct virtqueue *_=
vq,
>  {
>         struct vring_virtqueue *vq =3D to_vvq(_vq);
>
> -       return vq->packed_ring ? virtqueue_add_packed(_vq, sgs, total_sg,
> +       return vq->packed_ring ? virtqueue_add_packed(vq, sgs, total_sg,
>                                         out_sgs, in_sgs, data, ctx, prema=
pped, gfp) :
> -                                virtqueue_add_split(_vq, sgs, total_sg,
> +                                virtqueue_add_split(vq, sgs, total_sg,
>                                         out_sgs, in_sgs, data, ctx, prema=
pped, gfp);
>  }
>
> --
> 2.42.0
>


