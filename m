Return-Path: <linux-kernel+bounces-576959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DE48A716B7
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 13:31:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F275A172BFD
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 12:29:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C849B1E1DED;
	Wed, 26 Mar 2025 12:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PJu1OqnP"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61FFC19DF7D
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 12:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742992189; cv=none; b=fTn6DLg2UDIJjBHi9rNkArLo4DCfrqn6OouIWnT1OSNER4L9oZZhTJ60XyvHcga3QrdVTO4l6Rjvo/eC1bemPjRVixgDJE77MO7lmfPrkixlPG9E3vYgEVGt7mN5oUuAPmiJTyMrGNpdAeaK8v2sEQYSgbZCgTtcguGMpyQEwrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742992189; c=relaxed/simple;
	bh=ntVumSwhaJ/AJSMq5lpMKpcEKGQpH4Ew1NM6spf4jqw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hEjAfItEAzt2JcOy74DnNf73Q5EbpS8muW007FIW6peCy3MqJZfzbhbTJuwi0R1W1msADKLYzK4fpAq9gYPu6W+eiM/GQCztnPokBUqc4rckZrrarATMVBslPpjbd860Vn/tWe738S10Z45IR37bVJGLq2CCor+Fske2mONhQFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PJu1OqnP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742992186;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rMRlHmUYWwaHNNEginoHKvAMYufYyBuH8PvxpVgns5s=;
	b=PJu1OqnPnbwy+X2ohJjaKXug0xxPa4P4vaktlN1RoNrfD44AApdwAYkI1iBDPnBpeGYiLe
	F7LSRnyfrEj13/bAtY20di04AZTqAqmbnw2cTEzgq8eY+vFQb6hd4edLWSwYS/FWx0e5WW
	pDRYCLiX34UDKvI5+GR2FRX32UJ2uFo=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-113-O33yASo6NnOcs55C-kxK-w-1; Wed, 26 Mar 2025 08:29:45 -0400
X-MC-Unique: O33yASo6NnOcs55C-kxK-w-1
X-Mimecast-MFC-AGG-ID: O33yASo6NnOcs55C-kxK-w_1742992184
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-22412127fd7so87244895ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 05:29:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742992184; x=1743596984;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rMRlHmUYWwaHNNEginoHKvAMYufYyBuH8PvxpVgns5s=;
        b=loq7bAf4TbbeVO+TVmgMeDXcwBV7IDzqIxOd1JNucqDIxKIOcXk6ANnMCB7b1gHuyf
         zJx/n8obHH3MI5I2iN4z4hKGJ2S3IpJnc+wL4RXbpaPkslbsBt8r33beAnWjhbtHHfza
         lBWKa6E8CgpPqkkHathREksbcTDw0E23I4tvojddnF5vXqeE9jWcfe2qzJM/uFx6hz4V
         DfvVkx972/zlELLmYA8Z6dtT2nuQYQv6qzLULgc8UgukxBjQ0TyeRKAI0mfP6wZxpVCV
         x0ND8ZI6FyEXS1iehltJhVtCu4be7M9Gail6v2WEgYKG46etiL8JBeoxGYib060afVra
         lInw==
X-Forwarded-Encrypted: i=1; AJvYcCUG+hzi9uARpU98rAounvKRMcJNIxLh3uPXiaRZjIVy93TQSUNSoCepHCdSKIt+hV5XhO/DpfGw/m0bDT8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXhhR1WhY87MyY9udY17+N7SDlAhD6OKDep0emxCmpjMFVyueb
	G0awDD6yXH2Q5xLf34gL/VLuEJmANyZoyMMPkSqgJpyBm3LhnSm+muUpsjChP1TspX+Q83Y+t2R
	H8KCLODl+kftNLXoFI+gN59KacUsDWn1uXEVZU6XEyB+VvZzNtKv6GcLvT+8rF4vvb8BG7H6usB
	KclDe9n3kCueAU1KRcoVuOeOWCV0VZFSBuCxsmuTL+5xfGi2g=
X-Gm-Gg: ASbGncvj72SbO0AXScC4CVa2XzU2zqh+HtuvjvX1WuzFloSZRYFrGIgwZTvkXJebyZe
	u0zGornRh5NZUFMxw3yO+eg5Fv5+ViPLjR6YbtfMG9qwuyapBCwgNjjDdi3to59RZpdFDqb4=
X-Received: by 2002:a17:903:22c1:b0:224:721:ed9 with SMTP id d9443c01a7336-22780e2446amr321983795ad.44.1742992183759;
        Wed, 26 Mar 2025 05:29:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE/BScA6obxdH+fi5lo6OhP5kjsw9PXw8Acc3gi2RtNXREI+ba2oImLfY8+smoyPTigQHyCWHLgNMaZmFDw/XM=
X-Received: by 2002:a17:903:22c1:b0:224:721:ed9 with SMTP id
 d9443c01a7336-22780e2446amr321983575ad.44.1742992183420; Wed, 26 Mar 2025
 05:29:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250324054333.1954-1-jasowang@redhat.com> <20250324054333.1954-5-jasowang@redhat.com>
In-Reply-To: <20250324054333.1954-5-jasowang@redhat.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 26 Mar 2025 13:29:07 +0100
X-Gm-Features: AQ5f1JrI0fIIFk1dBlcZsQDwykZsIVajlZDNhFlQj02eOsxui9idNYaN5yrAcfc
Message-ID: <CAJaqyWexSxnJXEDWQnYi8mnfyWRbfpnr1UP+HV-Sh4HPshC5_A@mail.gmail.com>
Subject: Re: [PATCH 04/19] virtio_ring: switch to use vring_virtqueue for
 virtqueue resize variants
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
>  drivers/virtio/virtio_ring.c | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 9172f3a089a0..94ce711963e6 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -1216,11 +1216,10 @@ static struct virtqueue *vring_create_virtqueue_s=
plit(
>         return vq;
>  }
>
> -static int virtqueue_resize_split(struct virtqueue *_vq, u32 num)
> +static int virtqueue_resize_split(struct vring_virtqueue *vq, u32 num)
>  {
>         struct vring_virtqueue_split vring_split =3D {};
> -       struct vring_virtqueue *vq =3D to_vvq(_vq);
> -       struct virtio_device *vdev =3D _vq->vdev;
> +       struct virtio_device *vdev =3D vq->vq.vdev;
>         int err;
>
>         err =3D vring_alloc_queue_split(&vring_split, vdev, num,
> @@ -2183,11 +2182,10 @@ static struct virtqueue *vring_create_virtqueue_p=
acked(
>         return vq;
>  }
>
> -static int virtqueue_resize_packed(struct virtqueue *_vq, u32 num)
> +static int virtqueue_resize_packed(struct vring_virtqueue *vq, u32 num)
>  {
>         struct vring_virtqueue_packed vring_packed =3D {};
> -       struct vring_virtqueue *vq =3D to_vvq(_vq);
> -       struct virtio_device *vdev =3D _vq->vdev;
> +       struct virtio_device *vdev =3D vq->vq.vdev;
>         int err;
>
>         if (vring_alloc_queue_packed(&vring_packed, vdev, num, vring_dma_=
dev(vq)))
> @@ -2805,9 +2803,9 @@ int virtqueue_resize(struct virtqueue *_vq, u32 num=
,
>                 recycle_done(_vq);
>
>         if (vq->packed_ring)
> -               err =3D virtqueue_resize_packed(_vq, num);
> +               err =3D virtqueue_resize_packed(vq, num);
>         else
> -               err =3D virtqueue_resize_split(_vq, num);
> +               err =3D virtqueue_resize_split(vq, num);
>
>         return virtqueue_enable_after_reset(_vq);
>  }
> --
> 2.42.0
>


