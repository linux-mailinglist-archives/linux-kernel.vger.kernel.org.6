Return-Path: <linux-kernel+bounces-576966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7859BA716C4
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 13:33:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26E441895E5B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 12:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0FD41E1E0D;
	Wed, 26 Mar 2025 12:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JDnx6/Tg"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81E5D1C84A3
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 12:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742992309; cv=none; b=scmH4HXZBlJ3sujwuWYCtCXeSKYR4Uto5NLwG/vnpFv5snwXGntNMi/t7gERkt2TjhOm6Be+srMvT4TYRVIXDv2ncMTGK1XoEDey2ZSF8snRkvjTodyCHX14P4kgt54CViHAHEFQdsJwvVVijiAQawwVAglVVt8BEzh6liR74kI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742992309; c=relaxed/simple;
	bh=j1PgJNIW3viI9aUjPkcKwLkz/LrCzWVeZgttB5sdsZQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tBY6EAF9UoraKOxIgFUyGWmBhZlHPVpC0MuAHK9CUC+8JEuzA1bEL1gZFSoDzQKiTYfGFoZXcQ51t9ROWCfQJ+3zJegPkXSYBVwB/fqEzwi3yObe89NWaK5BwHcGr6CyPWQKpvTKZboKSHd/UaKtE5QPYJwO8As2jgs2n+3armw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JDnx6/Tg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742992306;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Iml6swh0i7lBeQVcG26hls4lzAH12sEjWHyxF8tp8XU=;
	b=JDnx6/TgpRh4Db0Y9ZZ4SXtpi8FV1LS0yzmaCd2zdhXVhUIsJxmQhjoDwu/IMW+lZLprKS
	y1ilUOVXnM5qxyDnqccV9HNkDDihGxy9O409lXEJWPOR4ok3NFe8OkYMonEcaLm9xpLkli
	AmCs48zGcJmFuyDV3OO5Ul2hZlLej0s=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-130-Am4K7z9fPOe2qmjO4Uoosg-1; Wed, 26 Mar 2025 08:31:44 -0400
X-MC-Unique: Am4K7z9fPOe2qmjO4Uoosg-1
X-Mimecast-MFC-AGG-ID: Am4K7z9fPOe2qmjO4Uoosg_1742992303
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2ff53a4754aso18431171a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 05:31:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742992303; x=1743597103;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Iml6swh0i7lBeQVcG26hls4lzAH12sEjWHyxF8tp8XU=;
        b=pzyq1a/cfSlZPRrsHVEn6BRfjsG/oQoO31AzK3vYN0IH7OPHyV1KRPIUr+WCpuNLvk
         d+mixAskaHy1iT47F7OHbDvWqEwCW5Mw3jnVW9teXZ47/Soz1oVULNcRSfmEGGqo99KG
         cz7QEVi0puRWDcZS8tJDEkUPp8llHb0HbFrkU2MuuOWWbgPO1Uqw67ZDdYKh5eH/L1Kz
         HgUS28SFu/nLlX5gXlgCBQhTJC8o30iGsJYmVogrtCEbxtBz9XukcjUco0QJejw4FBj6
         mpZTvgSULnl5IfMgYPJSsoGDKWn87n7ZnPiuR0if2BVIUKKMhyw1ps6fMTpYND+KK6Zj
         XKfg==
X-Forwarded-Encrypted: i=1; AJvYcCUW06sUGH4PSjmIh++4Ep6SDS3T+LzTR4V8D6tXX/SSoauPRv0zA4AOqhEvz3Q9TFnzf3XnCSzikkH1TSE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmYAuOjqKxsOqR/I92t53EzQhRdklDoZri4sTMjySS6DSrG2f/
	9kYwbPdL4onsPShIFieT6/gfiDZPdN/eHh9HnbyZyYg9zwr5Piw88OuVvMlwIISEFIqVsyjPbMX
	Z9Bq2VBab1QbiHZjBYXWWGq7FLHblz1mWsnL/YbSt/3f/dvoZDXchsZ4csFMoqJd1uxozw2Ive8
	eUI9GXEb1zQvXOsSrqLXKahIYGCWP1CzWTJkyz
X-Gm-Gg: ASbGnctikwocyOEXznfCOdBgEXfG8HbNSkBqMKcIY9Tje4s2oww75bBdcFJ+cFhiYq9
	9tsdJR/qwUtau1NJZZYIhfTmMXWh8ey7Tq32sGoH3TBeqi6g6BpyFLsm9ts1b+YoGBY8za2E=
X-Received: by 2002:a17:90b:2647:b0:2ff:592d:23bc with SMTP id 98e67ed59e1d1-3030fe58cc6mr32759834a91.4.1742992303331;
        Wed, 26 Mar 2025 05:31:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEGVFQzn+Y0z6JNs/or65j22c6R82kHGtishESvAExGqtxlwrwA8tRNSq9MhfHCoOvDPTzRqP6kI11gRu69gT8=
X-Received: by 2002:a17:90b:2647:b0:2ff:592d:23bc with SMTP id
 98e67ed59e1d1-3030fe58cc6mr32759796a91.4.1742992302862; Wed, 26 Mar 2025
 05:31:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250324054333.1954-1-jasowang@redhat.com> <20250324054333.1954-12-jasowang@redhat.com>
In-Reply-To: <20250324054333.1954-12-jasowang@redhat.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 26 Mar 2025 13:31:06 +0100
X-Gm-Features: AQ5f1JpmUSjk9F5tsDREnBeJZ7NTPykh0XX2gC-sNmEouR7JUIoBSu8q5nZyCJs
Message-ID: <CAJaqyWf-=xnNvO3SjCEH1wBd+es3GJEOEdGsi=sndPkGwtcQpQ@mail.gmail.com>
Subject: Re: [PATCH 11/19] virtio_ring: switch to use vring_virtqueue for
 detach_unused_buf variants
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
>  drivers/virtio/virtio_ring.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index f754da8c2ac6..19aa24d62d20 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -950,9 +950,8 @@ static bool virtqueue_enable_cb_delayed_split(struct =
vring_virtqueue *vq)
>         return true;
>  }
>
> -static void *virtqueue_detach_unused_buf_split(struct virtqueue *_vq)
> +static void *virtqueue_detach_unused_buf_split(struct vring_virtqueue *v=
q)
>  {
> -       struct vring_virtqueue *vq =3D to_vvq(_vq);
>         unsigned int i;
>         void *buf;
>
> @@ -965,7 +964,7 @@ static void *virtqueue_detach_unused_buf_split(struct=
 virtqueue *_vq)
>                 buf =3D vq->split.desc_state[i].data;
>                 detach_buf_split(vq, i, NULL);
>                 vq->split.avail_idx_shadow--;
> -               vq->split.vring.avail->idx =3D cpu_to_virtio16(_vq->vdev,
> +               vq->split.vring.avail->idx =3D cpu_to_virtio16(vq->vq.vde=
v,
>                                 vq->split.avail_idx_shadow);
>                 END_USE(vq);
>                 return buf;
> @@ -1892,9 +1891,8 @@ static bool virtqueue_enable_cb_delayed_packed(stru=
ct vring_virtqueue *vq)
>         return true;
>  }
>
> -static void *virtqueue_detach_unused_buf_packed(struct virtqueue *_vq)
> +static void *virtqueue_detach_unused_buf_packed(struct vring_virtqueue *=
vq)
>  {
> -       struct vring_virtqueue *vq =3D to_vvq(_vq);
>         unsigned int i;
>         void *buf;
>
> @@ -2642,8 +2640,8 @@ void *virtqueue_detach_unused_buf(struct virtqueue =
*_vq)
>  {
>         struct vring_virtqueue *vq =3D to_vvq(_vq);
>
> -       return vq->packed_ring ? virtqueue_detach_unused_buf_packed(_vq) =
:
> -                                virtqueue_detach_unused_buf_split(_vq);
> +       return vq->packed_ring ? virtqueue_detach_unused_buf_packed(vq) :
> +                                virtqueue_detach_unused_buf_split(vq);
>  }
>  EXPORT_SYMBOL_GPL(virtqueue_detach_unused_buf);
>
> --
> 2.42.0
>


