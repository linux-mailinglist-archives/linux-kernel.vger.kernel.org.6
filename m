Return-Path: <linux-kernel+bounces-576962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C29BDA716BF
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 13:32:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 156D61782A8
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 12:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C56831E1DFE;
	Wed, 26 Mar 2025 12:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fnvAiiI/"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9249F1C84A3
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 12:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742992253; cv=none; b=fIendeNbofvocBrWbzX65cx2RNqGAq06Rudpuiq6oWHG4XJIWCKY+WdSIdYzDAvc0hgVCFxwoZzPDU56FC6lIfATjKioB8hVows+Ujdnn1f65A9ttaKXfqdd8Cqpw6OoEorbg7PiLUMBqFI43eEYu6pcsZlMM4SeH2yteBmwaoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742992253; c=relaxed/simple;
	bh=t1jAaeK2ABeSg5LQWx2wud9VnSm5B8lPYZn3evgb48A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=icfaQNwDZ5FYHI1nQWUetYdplq3crvE5Go4EVijeZAmoDa7g+eqzkljYSVWCqa/2QiIH51UPDKNm2bV3Rozq2rFMCSmRipUuDjAphE25pTvRdfC584xPdtlP9izup1pUD/oRkJiqxzSQQzaktyP0S7V/QB2ql8mSy4t4CaLYdOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fnvAiiI/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742992250;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BofOIcmGmmEYNcMOZrv+oDBXVdFbZpweL97kRPLwA+0=;
	b=fnvAiiI/SXM3R1dMJf1iAOrT9jh85ifvM7PkQprypxHqokZSZp/EUc+Uc33je2HylgPBKB
	smMWdwRdMyiLUCXOCJ6iyzJGInHMyMSUaGnm1vt/HZITOGkv4WKNQ0hBbpMrDmuy9FBOHb
	SIkYJtj/zRovbRgt+zBloZ1UD4CmTp8=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-85-3bF8-L8hPxOmbdzP08SgJA-1; Wed, 26 Mar 2025 08:30:49 -0400
X-MC-Unique: 3bF8-L8hPxOmbdzP08SgJA-1
X-Mimecast-MFC-AGG-ID: 3bF8-L8hPxOmbdzP08SgJA_1742992248
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2ff58318acaso18951132a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 05:30:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742992248; x=1743597048;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BofOIcmGmmEYNcMOZrv+oDBXVdFbZpweL97kRPLwA+0=;
        b=BIiqEiKBKi0AIIHetP/Ro5owqEQVN0Qxyeua4FZoITQrKGnwaxH9rv0pFCOd68qZWE
         xzatfyFgG9ZP58II2rjGcjnNYJmj8YlZv52/MjG9KZBMa/QISF7GlYbm4HnQREYBlaDr
         BXfoZIDpJ5Y+8pPGlzltS8TF0p32hi/fatTNRS7Cxis2tAyPlW4eOgDBB3e8zV7w9n9p
         Smqc4SMyJq3WItN8EGPbwykh0oHIjYfxdgcykXdQ9Tlsa1i5TPQTnjAaoJD3R2WeYlR4
         DSVmGXfVubygWquDftSXe9SYoM5d7ZqUk9kjkoWBd/CgoHl8ChIh6OUe+NhY3452E/B7
         713Q==
X-Forwarded-Encrypted: i=1; AJvYcCUseZWHgfAhgdNtb2ZXR3ThSgsVgEhKdIYGpypkOk48iT98Q+vrtu1QfOKWxNR5tdnGDjjziGRIv4Hseb4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlRa2A43LDecvTWu4DmGELRIXpYb+4tddzu3Rr3G9G0rTPbHNc
	Ys2GeVx2jOvAA/a9lReW6OiFKt0Fj4g4tmvS0CbKXMGuLDkaBMw7Nn8O7awjMsy9gOD+DSSziJt
	FX0I7jZ+QLv4Kw1SYoOAMwlX8mepO4nLZ3QIv7z6tCpBo5QWuZQEdOmdHDx0wY14j4PWIIZGpF9
	BiJXsi225iGE4iwciMUJuNZn+IHAR1uRJOcuya
X-Gm-Gg: ASbGncvqiTbT0B9X2H8AGmezRUvAe4q3kjsXFL8RjOBOmxZqjQ9PeOPWQk/sqrU7Hyw
	pdot3iXjc+M6C787msRK34X7gfESkfQPRF9gaoJwI2D7qlXDbxtaYcdI5FGQf02Pku8pjRXc=
X-Received: by 2002:a17:90b:2647:b0:2ff:592d:23bc with SMTP id 98e67ed59e1d1-3030fe58cc6mr32754803a91.4.1742992248108;
        Wed, 26 Mar 2025 05:30:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGHZspv04CXcu+ey4YOBhN+VJKI5mU2+Jtl12WquvdbY1oIVinT6nMNfzFCcHEY+oJ4kBspf1BZQ2XjZ5Pwcs4=
X-Received: by 2002:a17:90b:2647:b0:2ff:592d:23bc with SMTP id
 98e67ed59e1d1-3030fe58cc6mr32754746a91.4.1742992247541; Wed, 26 Mar 2025
 05:30:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250324054333.1954-1-jasowang@redhat.com> <20250324054333.1954-8-jasowang@redhat.com>
In-Reply-To: <20250324054333.1954-8-jasowang@redhat.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 26 Mar 2025 13:30:11 +0100
X-Gm-Features: AQ5f1JpRUV94ZzxyW-F1h7s9QroQ6M5Rkq4ahPxn9uzQpE7HmuL0CSIEhSc_E5I
Message-ID: <CAJaqyWdVXNH-W4hbgiLS+8O--atXQDE8bqN23Z5M9rnOFx4g4A@mail.gmail.com>
Subject: Re: [PATCH 07/19] virtio: switch to use vring_virtqueue for
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
>  drivers/virtio/virtio_ring.c | 16 +++++++---------
>  1 file changed, 7 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 619869e80309..3fab40648c75 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -812,11 +812,10 @@ static bool more_used_split(const struct vring_virt=
queue *vq)
>         return virtqueue_poll_split(vq, vq->last_used_idx);
>  }
>
> -static void *virtqueue_get_buf_ctx_split(struct virtqueue *_vq,
> +static void *virtqueue_get_buf_ctx_split(struct vring_virtqueue *vq,
>                                          unsigned int *len,
>                                          void **ctx)
>  {
> -       struct vring_virtqueue *vq =3D to_vvq(_vq);
>         void *ret;
>         unsigned int i;
>         u16 last_used;
> @@ -838,9 +837,9 @@ static void *virtqueue_get_buf_ctx_split(struct virtq=
ueue *_vq,
>         virtio_rmb(vq->weak_barriers);
>
>         last_used =3D (vq->last_used_idx & (vq->split.vring.num - 1));
> -       i =3D virtio32_to_cpu(_vq->vdev,
> +       i =3D virtio32_to_cpu(vq->vq.vdev,
>                         vq->split.vring.used->ring[last_used].id);
> -       *len =3D virtio32_to_cpu(_vq->vdev,
> +       *len =3D virtio32_to_cpu(vq->vq.vdev,
>                         vq->split.vring.used->ring[last_used].len);
>
>         if (unlikely(i >=3D vq->split.vring.num)) {
> @@ -862,7 +861,7 @@ static void *virtqueue_get_buf_ctx_split(struct virtq=
ueue *_vq,
>         if (!(vq->split.avail_flags_shadow & VRING_AVAIL_F_NO_INTERRUPT))
>                 virtio_store_mb(vq->weak_barriers,
>                                 &vring_used_event(&vq->split.vring),
> -                               cpu_to_virtio16(_vq->vdev, vq->last_used_=
idx));
> +                               cpu_to_virtio16(vq->vq.vdev, vq->last_use=
d_idx));
>
>         LAST_ADD_TIME_INVALID(vq);
>
> @@ -1721,11 +1720,10 @@ static bool more_used_packed(const struct vring_v=
irtqueue *vq)
>         return virtqueue_poll_packed(vq, READ_ONCE(vq->last_used_idx));
>  }
>
> -static void *virtqueue_get_buf_ctx_packed(struct virtqueue *_vq,
> +static void *virtqueue_get_buf_ctx_packed(struct vring_virtqueue *vq,
>                                           unsigned int *len,
>                                           void **ctx)
>  {
> -       struct vring_virtqueue *vq =3D to_vvq(_vq);
>         u16 last_used, id, last_used_idx;
>         bool used_wrap_counter;
>         void *ret;
> @@ -2521,8 +2519,8 @@ void *virtqueue_get_buf_ctx(struct virtqueue *_vq, =
unsigned int *len,
>  {
>         struct vring_virtqueue *vq =3D to_vvq(_vq);
>
> -       return vq->packed_ring ? virtqueue_get_buf_ctx_packed(_vq, len, c=
tx) :
> -                                virtqueue_get_buf_ctx_split(_vq, len, ct=
x);
> +       return vq->packed_ring ? virtqueue_get_buf_ctx_packed(vq, len, ct=
x) :
> +                                virtqueue_get_buf_ctx_split(vq, len, ctx=
);
>  }
>  EXPORT_SYMBOL_GPL(virtqueue_get_buf_ctx);
>
> --
> 2.42.0
>


