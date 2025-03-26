Return-Path: <linux-kernel+bounces-576964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F59FA716C1
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 13:32:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62C92189503C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 12:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B29E1E1E0E;
	Wed, 26 Mar 2025 12:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EWBRoaCX"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27FE6185920
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 12:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742992279; cv=none; b=fGRNyKbz+3BB874P9vFKHSlZMzjO/0a2O1VHupunkBDTDPdTBjGORC4y1E1iVqsJY6TeQnaGb0hVHXDmTAFJS6AUA0q8+cKEGVydFteuFo6PIqMhDmmQxjERUNKSg9n8/68Q9/1LYqVaZBDekUySWkrrdeamofoxHqycUP67ET0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742992279; c=relaxed/simple;
	bh=5XOHgQ9Ffo4lzFeWHbShfU3wyeLpR2N854J29ellPv8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f9jXug2p0CZSCW0IuM0z6wDasm008/awGuYFMbhZ+lbe9VCi8yFt8Wg7dxXrJdRUgiwY90Ih63g+9YcbBigpXW25OgHXZJwFL+HUCdKkIfOavZR18BFEMnyrtnxGmi62nwTt3FdYsxoA54GADev0IVsxAmCKZI3ii+lZyUA1cBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EWBRoaCX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742992276;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DAdSAVacBxue1TmQqDLcTFCwkP1xo1pi83cchMmsOwE=;
	b=EWBRoaCXotmWbb2y2U+zk6rbK9mjM8TpCMyOgiiJMwNOMdDURIIkvorUeMJ0b8F5oowvZt
	Zg4XVsuPXZr0kG7+iLfrbpfc0v79IzSpgyFMUXlD3J1GYjBjzn2lYSUiS2/PnYp/K8ux/e
	H84Jn2Kh2Dfc+J1LYmekrAED83cSE/A=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-90-pyeHWvYiPPKr-6XbLbf1wA-1; Wed, 26 Mar 2025 08:31:15 -0400
X-MC-Unique: pyeHWvYiPPKr-6XbLbf1wA-1
X-Mimecast-MFC-AGG-ID: pyeHWvYiPPKr-6XbLbf1wA_1742992274
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2ff6aaa18e8so10458587a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 05:31:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742992274; x=1743597074;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DAdSAVacBxue1TmQqDLcTFCwkP1xo1pi83cchMmsOwE=;
        b=AVYBu8Dpz49vV+jzE3Ar31ErXVtkCXb+jstS0wzJUurZ6niikfD014CVAmdv3XQSsm
         yoO8wUZqVLl8IohYH8XXQIq114mVXlMOclZyuvZ57R7K9eNy9v1UzUpRLhWXWlZUr/OF
         6CdAfLivCVsSoAq/+rSJ6Tf1dRAu7L6J06TyOFuXlAkGCqKmmtvecOIWZkX+VGhoFZjK
         bpJrwPy9wEy5qy2X1qJK7dJzaLmH3suGExrSKlshyRpTzS/90l8iFYG7RRnaVpgebtEi
         YMA0Hr2UOTqJ48MW2VGRqSYG/dgS5dJMCpmfm5azxlcTmzwPtlRhkQmFfSHjGAmwOZto
         9v3w==
X-Forwarded-Encrypted: i=1; AJvYcCVApEKAPnkasIkmHiME6efnJXniqco7E25MxAooCDD1hAjtTAqNcv8SyT32bksPud6YHIu8AWAkhYZFgNc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxX1HXGMsMXdFdpstR3+1Ghg0sAkNF/MZq0DHRO+4B8WiY3RC2Q
	cfDt42aaBmugJUCOe/fF/VWbRX9MJw7PlvKntI2YSWnlJJkkuY+m/nyBJp6kzchzVMF6BW+h6Pl
	DFmGaj6UfCQ/TaPs9GLSoHKNS2OBJpF08O0ouGzRRGB8Cs82HpiCYL2qUw3a3sRVo603claLZJZ
	T2IkGoCmVHDuZObXeKYm4hkkEt8sGJNzqoEXFl
X-Gm-Gg: ASbGnct89IJhKtgbxUotUYxFoBy6ED1y5aE9Ai26gOm4AHBNiZqVTLMGdhxgAv0EwCB
	PzBeVgMGoJgn15mBBHt7EZK41jkJ+d1V318ls8PA+o0OpxX8QhWshdSdNaHrpP65Z2VQmcrU=
X-Received: by 2002:a17:90b:554e:b0:2fa:228d:5af2 with SMTP id 98e67ed59e1d1-3030fea0d35mr35854788a91.15.1742992274369;
        Wed, 26 Mar 2025 05:31:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHMBiUpX7u1Oi46XXoPSaCW+cpt4tUKFjelSQIwtkx21BmzYxC7k6NWIAAx2C1zOmu3fzfgNqk032hM0TVme1E=
X-Received: by 2002:a17:90b:554e:b0:2fa:228d:5af2 with SMTP id
 98e67ed59e1d1-3030fea0d35mr35854736a91.15.1742992273959; Wed, 26 Mar 2025
 05:31:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250324054333.1954-1-jasowang@redhat.com> <20250324054333.1954-10-jasowang@redhat.com>
In-Reply-To: <20250324054333.1954-10-jasowang@redhat.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 26 Mar 2025 13:30:37 +0100
X-Gm-Features: AQ5f1JoCUWH6yktmmruAjai5d907SFhCX-z2GsZ94SM96jfry_2r0BVObMP-5IU
Message-ID: <CAJaqyWdjgx8d0Si-Qdzv1xKQoQDHBiQ3QBRwYnHmOQO3gf8uEg@mail.gmail.com>
Subject: Re: [PATCH 09/19] virtio_ring: use vring_virtqueue for
 enable_cb_delayed variants
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
>  drivers/virtio/virtio_ring.c | 16 +++++++---------
>  1 file changed, 7 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index a414e66915d9..af8ce6e9d892 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -917,9 +917,8 @@ static unsigned int virtqueue_enable_cb_prepare_split=
(struct vring_virtqueue *vq
>         return last_used_idx;
>  }
>
> -static bool virtqueue_enable_cb_delayed_split(struct virtqueue *_vq)
> +static bool virtqueue_enable_cb_delayed_split(struct vring_virtqueue *vq=
)
>  {
> -       struct vring_virtqueue *vq =3D to_vvq(_vq);
>         u16 bufs;
>
>         START_USE(vq);
> @@ -933,7 +932,7 @@ static bool virtqueue_enable_cb_delayed_split(struct =
virtqueue *_vq)
>                 vq->split.avail_flags_shadow &=3D ~VRING_AVAIL_F_NO_INTER=
RUPT;
>                 if (!vq->event)
>                         vq->split.vring.avail->flags =3D
> -                               cpu_to_virtio16(_vq->vdev,
> +                               cpu_to_virtio16(vq->vq.vdev,
>                                                 vq->split.avail_flags_sha=
dow);
>         }
>         /* TODO: tune this threshold */
> @@ -941,9 +940,9 @@ static bool virtqueue_enable_cb_delayed_split(struct =
virtqueue *_vq)
>
>         virtio_store_mb(vq->weak_barriers,
>                         &vring_used_event(&vq->split.vring),
> -                       cpu_to_virtio16(_vq->vdev, vq->last_used_idx + bu=
fs));
> +                       cpu_to_virtio16(vq->vq.vdev, vq->last_used_idx + =
bufs));
>
> -       if (unlikely((u16)(virtio16_to_cpu(_vq->vdev, vq->split.vring.use=
d->idx)
> +       if (unlikely((u16)(virtio16_to_cpu(vq->vq.vdev, vq->split.vring.u=
sed->idx)
>                                         - vq->last_used_idx) > bufs)) {
>                 END_USE(vq);
>                 return false;
> @@ -1837,9 +1836,8 @@ static unsigned int virtqueue_enable_cb_prepare_pac=
ked(struct vring_virtqueue *v
>         return vq->last_used_idx;
>  }
>
> -static bool virtqueue_enable_cb_delayed_packed(struct virtqueue *_vq)
> +static bool virtqueue_enable_cb_delayed_packed(struct vring_virtqueue *v=
q)
>  {
> -       struct vring_virtqueue *vq =3D to_vvq(_vq);
>         u16 used_idx, wrap_counter, last_used_idx;
>         u16 bufs;
>
> @@ -2631,8 +2629,8 @@ bool virtqueue_enable_cb_delayed(struct virtqueue *=
_vq)
>         if (vq->event_triggered)
>                 vq->event_triggered =3D false;
>
> -       return vq->packed_ring ? virtqueue_enable_cb_delayed_packed(_vq) =
:
> -                                virtqueue_enable_cb_delayed_split(_vq);
> +       return vq->packed_ring ? virtqueue_enable_cb_delayed_packed(vq) :
> +                                virtqueue_enable_cb_delayed_split(vq);
>  }
>  EXPORT_SYMBOL_GPL(virtqueue_enable_cb_delayed);
>
> --
> 2.42.0
>


