Return-Path: <linux-kernel+bounces-528067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4013DA41324
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 03:04:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2E93188B318
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 02:03:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5164C19C54E;
	Mon, 24 Feb 2025 02:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ERyR1PB7"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BD411E50B
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 02:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740362625; cv=none; b=eXXhTmwubHIvHmNLZ/Qbac0nalucVSdnk0ZjvniYE7Ukfsklo04cAtn8YVtYHjao1vmemmhcHqOJFA6HrfrYwpOiLlxASENYQIZgn9sg07CXz9QND4vqWP5pUu28jA1F0BMLgcRh4jjG8mIQ79sGhvFr2y5ey5BIfCdHkFWS7dE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740362625; c=relaxed/simple;
	bh=w7R9ytRD85MeIXtcZKee/rVGun8dMiy7oOSdiI6M/3Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BgeYA39jY8gBb/OJWoy1GH0k52TsMabAgM7hp5y7+Yo5kx/9p8kUBowJf0v+d2sajomk3qJi+Jwo2LdvEAxSHIFJsCPg+tYwEuvKoaIxodN2C0Ms+SGp5g6OfuTP/1SOey+wOiofwydZH6jfu1h/M+bZ1/7Vd4oD91pxhfyQglI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ERyR1PB7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740362622;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vj/eatzi8/SbTZm4sotqYn1LymWrRr/7l24MdkO3x34=;
	b=ERyR1PB7o0Jo8L4z7RLStRYjYfsGGQ24QFwTevZHwyXSn556Bim8i3nhWtrkX4Aug2kHzk
	7n2oK6WFBbOOPd8H0C6Uz7p3BmZfFtHTZmwtyBkUiLNZrgxLvhvartFyVKiOMWnFiXQqQ9
	X0p3fov4S1uiozu7A6yOBCXbBFV5TcQ=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-689-AGh3PQ0eNpeB4BmHjbG3yg-1; Sun, 23 Feb 2025 21:03:41 -0500
X-MC-Unique: AGh3PQ0eNpeB4BmHjbG3yg-1
X-Mimecast-MFC-AGG-ID: AGh3PQ0eNpeB4BmHjbG3yg_1740362620
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2fc2b258e82so8416642a91.0
        for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2025 18:03:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740362620; x=1740967420;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vj/eatzi8/SbTZm4sotqYn1LymWrRr/7l24MdkO3x34=;
        b=ibfq9afPfxm/ipOG62SwVr+neWql4VgOErsQULjKI+1tmFk0G85ydCMKrUSjO/UsBf
         IeSYIEdO4VztQet7bOVOoE8JHOKBHxZdrL2wrZwIX1YrQpcvLFAMq11Uc1cS7ourU0WN
         lEZli7o+fN6VjKlwNwnM+xYa8PsLZvU4PWfcPDYJAy0dqYHeZic0V8s0e6vnGLNkh4di
         uZW118pcfPnhvAHgalyB9w2b1PCVMU9LD8L1K4mZSzsRkO6V5gF/ldrIjthZ8jK3NF0O
         cHFNUna7ynWs5V7NpxrYSPw3frdRKvDRI2fkViBaeO0I8wKrMQ+ktIn9euZ86Yps8Gkh
         4dKA==
X-Forwarded-Encrypted: i=1; AJvYcCVpbuKFQllgeJwpP60waEymVwGlubsV0XBSWuZQDRwbI3Y8lN2F67zRJB3djlrzoi9a2M2rWqt5N0wiDOE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNSxdkACRqPvlvQFm+g+tL7YDFooNQRjGtbH+xUqchrsvakzcV
	ipiSHSs9PxNSZkv/QrdyHfEXYN/avVI8qIGWCxed7vHxT7aM42MrX3Q3KT++hT9CpUppmsjCC7L
	XQKZ0G3PFsIVdc2HFWAk/81DApY1+n/KDIXIrs4DHTT/A5kAWK439QaCKtEhWxLH7+zlt9yemCg
	6kx8ADsUlSQOkU1qWfI22z/li4MNaD/TfF9a5w
X-Gm-Gg: ASbGnctjnLOhMiQ70sJ1OWC0Q7k+MsWtFXWbXCaMe+SSfjK13ec7Kw49DenWMmQntkA
	VkxPjvlkhdtxnb1pFtXukankl+I/RDsDUONfFIu3vQ4ne2pbYULfd/SKEKgdotp0hskQdWbUYGQ
	==
X-Received: by 2002:a17:90b:2f10:b0:2ee:f076:20f1 with SMTP id 98e67ed59e1d1-2fce75d8389mr23425075a91.0.1740362620366;
        Sun, 23 Feb 2025 18:03:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHqHYDfPs1srCspzCYJowyZpz5am+Rf4d4c61UQnVndBWfcy166ap+BjMNrsJ3c3QtjlAG1XZ63cmpi3gjXfVA=
X-Received: by 2002:a17:90b:2f10:b0:2ee:f076:20f1 with SMTP id
 98e67ed59e1d1-2fce75d8389mr23425019a91.0.1740362619936; Sun, 23 Feb 2025
 18:03:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250221170626.261687-1-eperezma@redhat.com> <20250221170626.261687-5-eperezma@redhat.com>
In-Reply-To: <20250221170626.261687-5-eperezma@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 24 Feb 2025 10:03:27 +0800
X-Gm-Features: AWEUYZmFvdghBWbj7dfL1lk5t5jzlCOVdRYAsevanX_ZGMVfIVhiNzRnHAcWiJI
Message-ID: <CACGkMEuGSGcmMtAwGwBWfHai=yUGGcD__kjCh-z3NbK8q6oGSw@mail.gmail.com>
Subject: Re: [RFC v2 4/5] virtiofs: perform DMA operations out of the spinlock
To: =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	Hanna Reitz <hreitz@redhat.com>, linux-kernel@vger.kernel.org, 
	German Maglione <gmaglione@redhat.com>, virtualization@lists.linux.dev, 
	Stefano Garzarella <sgarzare@redhat.com>, yama@redhat.com, Vivek Goyal <vgoyal@redhat.com>, 
	Miklos Szeredi <miklos@szeredi.hu>, mst@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 22, 2025 at 1:07=E2=80=AFAM Eugenio P=C3=A9rez <eperezma@redhat=
.com> wrote:
>
> This is useful for some setups like swiotlb or VDUSE where the DMA
> operations are expensive and/or need to be performed with a write lock.
>
> After applying this patch, fio read test goes from 1124MiB/s to 1191MiB/s=
.

What FIO parameter have you used? It might be worth trying different
sizes. It seems to be more obvious when using larger requests when I'm
testing similar optimization for virtio-blk.

And we also need to test without VDUSE, to make sure no regression in
classical setups.

Thanks

>
> Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> ---
>  fs/fuse/virtio_fs.c | 40 ++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 38 insertions(+), 2 deletions(-)
>
> diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
> index 1344c5782a7c..e19c78f2480e 100644
> --- a/fs/fuse/virtio_fs.c
> +++ b/fs/fuse/virtio_fs.c
> @@ -836,8 +836,19 @@ static void virtio_fs_requests_done_work(struct work=
_struct *work)
>
>         /* End requests */
>         list_for_each_entry_safe(req, next, &reqs, list) {
> +               unsigned int total_sgs =3D req->out_sgs + req->in_sgs;
> +
>                 list_del_init(&req->list);
>
> +               for (unsigned int i =3D 0; i < total_sgs; ++i) {
> +                       enum dma_data_direction dir =3D (i < req->out_sgs=
) ?
> +                               DMA_TO_DEVICE : DMA_FROM_DEVICE;
> +                       dma_unmap_page(vq->vdev->dev.parent,
> +                                      sg_dma_address(&req->sg[i]),
> +                                      sg_dma_len(&req->sg[i]), dir);
> +
> +               }
> +
>                 /* blocking async request completes in a worker context *=
/
>                 if (req->args->may_block) {
>                         struct virtio_fs_req_work *w;
> @@ -1426,6 +1437,24 @@ static int virtio_fs_enqueue_req(struct virtio_fs_=
vq *fsvq,
>                 sgs[i] =3D &req->sg[i];
>         WARN_ON(req->out_sgs + req->in_sgs !=3D total_sgs);
>
> +       // TODO can we change this ptr out of the lock?
> +       vq =3D fsvq->vq;
> +       // TODO handle this and following errors
> +       for (i =3D 0; i < total_sgs; i++) {
> +               struct page *page =3D sg_page(&req->sg[i]);
> +               enum dma_data_direction dir =3D (i < req->out_sgs) ?
> +                       DMA_TO_DEVICE : DMA_FROM_DEVICE;
> +               dma_addr_t dma_addr =3D dma_map_page(vq->vdev->dev.parent=
, page,
> +                                                  req->sg[i].offset, req=
->sg[i].length, dir);
> +
> +               if (dma_mapping_error(vq->vdev->dev.parent, dma_addr)) {
> +                       ret =3D -ENOMEM;
> +                       goto out;
> +               }
> +               sg_dma_address(&req->sg[i]) =3D dma_addr;
> +               sg_dma_len(&req->sg[i]) =3D req->sg[i].length;
> +       }
> +
>         spin_lock(&fsvq->lock);
>
>         if (!fsvq->connected) {
> @@ -1434,8 +1463,8 @@ static int virtio_fs_enqueue_req(struct virtio_fs_v=
q *fsvq,
>                 goto out;
>         }
>
> -       vq =3D fsvq->vq;
> -       ret =3D virtqueue_add_sgs(vq, sgs, req->out_sgs, req->in_sgs, req=
, GFP_ATOMIC);
> +       ret =3D virtqueue_add_sgs_premapped(vq, sgs, req->out_sgs,
> +                                         req->in_sgs, req, GFP_ATOMIC);
>         if (ret < 0) {
>                 spin_unlock(&fsvq->lock);
>                 goto out;
> @@ -1460,6 +1489,13 @@ static int virtio_fs_enqueue_req(struct virtio_fs_=
vq *fsvq,
>                 virtqueue_notify(vq);
>
>  out:
> +       for (unsigned int j =3D 0; ret && j < total_sgs; ++j) {
> +               enum dma_data_direction dir =3D (j < req->out_sgs) ?
> +                       DMA_TO_DEVICE : DMA_FROM_DEVICE;
> +               dma_unmap_page(vq->vdev->dev.parent,
> +                              sg_dma_address(&req->sg[j]),
> +                              sg_dma_len(&req->sg[j]), dir);
> +       }
>         if (ret < 0 && req->argbuf) {
>                 kfree(req->argbuf);
>                 req->argbuf =3D NULL;
> --
> 2.48.1
>


