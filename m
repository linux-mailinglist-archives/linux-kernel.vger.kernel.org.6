Return-Path: <linux-kernel+bounces-576963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1BE4A716BE
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 13:32:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A86931894DB1
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 12:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 878821E1E0E;
	Wed, 26 Mar 2025 12:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JYPqQm5y"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A9A1A8407
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 12:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742992268; cv=none; b=NWHRr5awaUT1zYz8wYn8kXtqEiCbzBPwaYg7IkGhJ7TGXMTkl1ttUdaKlRrmogRg32AZ7yY6JmlFzK3M1aDWXrMorW2IzL0Br7F0kY+A+2MJURy8bkwTIPNlq5lZx/pPAp4E7T3SwFM4SlKhvjsfU47PFFEllXBwZ8eDWqiSNNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742992268; c=relaxed/simple;
	bh=wdIRuME0zncj+f5DDnbpfsgAtBRUsGNlNduoYO4D52A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XH9AEYhk0avF7c+D/7Mnt7ocM7s7S9UvVrTLJP67YpWlBEC5NKU0xPOt2f627ex5h9eApNDGE4D1uqZhPLoJPXhf688aB9l0c2ofbHn/XS4hRxeQIsPhyAiAV8nNkJeydS8djUtsRp8NlFBjOkvKHU/akWIuV/GX6HGINpKpQuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JYPqQm5y; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742992266;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w6cKGbPa/biSuO145jPh4hCTdr0hLEmlrBu7Lv96WI4=;
	b=JYPqQm5yJFcyx2NsMQtTH05bsMidcIVDHUaCSetmN5Gqu/kGGnjhtBVC8MlXZljpQuXsJN
	lLHyhtRaGUSCE8kOLAE9T0obKo/gRZkl29/I6TSzVgXn48h+4HjEgfQ9j2wDz4YUl8NhA4
	duTt2Aic/7F4Sbi2PlAY2PTzRrerD7k=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-WgP1Liu_PLCeOLRYQGFbkg-1; Wed, 26 Mar 2025 08:31:04 -0400
X-MC-Unique: WgP1Liu_PLCeOLRYQGFbkg-1
X-Mimecast-MFC-AGG-ID: WgP1Liu_PLCeOLRYQGFbkg_1742992264
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3011bee1751so10810440a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 05:31:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742992264; x=1743597064;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w6cKGbPa/biSuO145jPh4hCTdr0hLEmlrBu7Lv96WI4=;
        b=LO6LZ0CS6e6Y7td8eUKPAwPMtL8CNaFdXP7KHPjZcewHRNtHNwu2S0+2VqVewaSVCn
         BATCpGt3yQbkfRYsAz8GU+IGHvbRro4IY8OTlJ7TfLE/cqN+zOsieJVCk7j90PQKfjA3
         fX1yK1GSSyt+4APVrvvMOPqvSoVNhY9gatLEGWBiMkoIxKnwXc9ABtNLpVLcZ6l5CY3v
         3GFAZaU0wPaVhRgOdKcJ9YoGlNGXcgPXtfQrplMkOo5Gf9LSxhe8N3zPYx+z+tAsT+Ay
         iJPRJPckKo/Ori9HV5imahIbjw/B7DPBzAViX334D4+9UtvUTRoQdaJ9QlnJC2RsyTgv
         fVCw==
X-Forwarded-Encrypted: i=1; AJvYcCVf1I6tgIuOUpm10xXd9Z0JD/EI/+QV4OMrmwPLgB9h01tMjZNQb50N+nFM6MAPKlB/aA8ORIWYmR3VZSk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTYIMJDpAY8DwgzI6tqFzJLhNndiT9K/TpV9eG+L5Z24Z139LC
	+Y8WszarxmjF2SoP9lKj02fkLJK3sN6dL6iZLeJ6Hyf9KxKdFS4gLRczLAk/z+/Drd5KklWvcsd
	KS9sgq0GB+2dlkQ9An/YsWN7zfkgBgYnfQi6IAMLdL7eXno/WRuu+aldwzw5fm2AHGDNvPkp4mU
	pzP7c8MOyF6awFJHftnxIlcIUs3OxNujshiP/G
X-Gm-Gg: ASbGnctqrccQBOR1hLdoA6Z97oNyGH78Jt/co2k7tmqpJQmsy9VEgzqu2y5y7jDyIMN
	UX+T5CbbBBBmtJ/1YXVaGm9xU+q7CVc1c0T6gdWPIpzAsLWLY58cba293slVg5R3+Z6j+TgU=
X-Received: by 2002:a17:90b:35c4:b0:2ee:b6c5:1def with SMTP id 98e67ed59e1d1-3030fe75747mr29582019a91.8.1742992263685;
        Wed, 26 Mar 2025 05:31:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE3CZe85e3cPBUO+wooyUMtF8xON86OsS/QFoXGWXEmTS/eeT7lhZDqKxtKdQFEkvTv0OsgxqaCGbus0LAxjDc=
X-Received: by 2002:a17:90b:35c4:b0:2ee:b6c5:1def with SMTP id
 98e67ed59e1d1-3030fe75747mr29581970a91.8.1742992263103; Wed, 26 Mar 2025
 05:31:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250324054333.1954-1-jasowang@redhat.com> <20250324054333.1954-9-jasowang@redhat.com>
In-Reply-To: <20250324054333.1954-9-jasowang@redhat.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 26 Mar 2025 13:30:26 +0100
X-Gm-Features: AQ5f1JrnjKIStDl8FKrj2WhOboQ6WN9lC9kQj540Si_DlDA1zSNpcLXHxuohnSk
Message-ID: <CAJaqyWfe5HRvCq7-JzprVD=DGef-HM2H0opFx6JWMngYfZUvdg@mail.gmail.com>
Subject: Re: [PATCH 08/19] virtio_ring: switch to use vring_virtqueue for
 enable_cb_prepare variants
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

Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  drivers/virtio/virtio_ring.c | 15 ++++++---------
>  1 file changed, 6 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 3fab40648c75..a414e66915d9 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -893,9 +893,8 @@ static void virtqueue_disable_cb_split(struct virtque=
ue *_vq)
>         }
>  }
>
> -static unsigned int virtqueue_enable_cb_prepare_split(struct virtqueue *=
_vq)
> +static unsigned int virtqueue_enable_cb_prepare_split(struct vring_virtq=
ueue *vq)
>  {
> -       struct vring_virtqueue *vq =3D to_vvq(_vq);
>         u16 last_used_idx;
>
>         START_USE(vq);
> @@ -909,10 +908,10 @@ static unsigned int virtqueue_enable_cb_prepare_spl=
it(struct virtqueue *_vq)
>                 vq->split.avail_flags_shadow &=3D ~VRING_AVAIL_F_NO_INTER=
RUPT;
>                 if (!vq->event)
>                         vq->split.vring.avail->flags =3D
> -                               cpu_to_virtio16(_vq->vdev,
> +                               cpu_to_virtio16(vq->vq.vdev,
>                                                 vq->split.avail_flags_sha=
dow);
>         }
> -       vring_used_event(&vq->split.vring) =3D cpu_to_virtio16(_vq->vdev,
> +       vring_used_event(&vq->split.vring) =3D cpu_to_virtio16(vq->vq.vde=
v,
>                         last_used_idx =3D vq->last_used_idx);
>         END_USE(vq);
>         return last_used_idx;
> @@ -1807,10 +1806,8 @@ static void virtqueue_disable_cb_packed(struct vir=
tqueue *_vq)
>         }
>  }
>
> -static unsigned int virtqueue_enable_cb_prepare_packed(struct virtqueue =
*_vq)
> +static unsigned int virtqueue_enable_cb_prepare_packed(struct vring_virt=
queue *vq)
>  {
> -       struct vring_virtqueue *vq =3D to_vvq(_vq);
> -
>         START_USE(vq);
>
>         /*
> @@ -2568,8 +2565,8 @@ unsigned int virtqueue_enable_cb_prepare(struct vir=
tqueue *_vq)
>         if (vq->event_triggered)
>                 vq->event_triggered =3D false;
>
> -       return vq->packed_ring ? virtqueue_enable_cb_prepare_packed(_vq) =
:
> -                                virtqueue_enable_cb_prepare_split(_vq);
> +       return vq->packed_ring ? virtqueue_enable_cb_prepare_packed(vq) :
> +                                virtqueue_enable_cb_prepare_split(vq);
>  }
>  EXPORT_SYMBOL_GPL(virtqueue_enable_cb_prepare);
>
> --
> 2.42.0
>


