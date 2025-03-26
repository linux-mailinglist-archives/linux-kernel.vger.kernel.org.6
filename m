Return-Path: <linux-kernel+bounces-576940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ACDEA7164B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 13:10:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81BD616D0FC
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 12:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA6F71DB933;
	Wed, 26 Mar 2025 12:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MaVBqb5F"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF041A2632
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 12:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742991030; cv=none; b=VI/MmiE3BLaIqUE2xwtIpqLzVOCliEMx/ogzqbW5UcSTOvG6LuC3ZfxkPruN+G+TUbxOLWuiSkDn88z04o433bSi2xGaWLuqlRw65qPk31Vi0d+FkLZiOnZe6shRtE5v0oYxZrUFmgf5vG1Fr7HAa+rVymBHrew3+q3ByUypjH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742991030; c=relaxed/simple;
	bh=F9NkXN3+3mSxqFATL7Ique1FBSyTWtcZ9Qx0/UUpSjA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lFNAniVz6B6z8vY0jbck0RpEkFkqUna4y8dKYQ3D3ee6FQFhsMq/W7scDlkXgky4MBrdj1KcvQEgP8BSfMmon6NTwv4Tm1ymgEF6cdnNvNCBBEtMA+/yes7TEGu0xj69BwHQ7HEmmJL73pxdYsofM7aWXA2eayc8xw3LDhmFecU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MaVBqb5F; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742991027;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zcGJWpgvB7cR9K8awWQvPQUtNpQ+EuhR+/yBYj13d7I=;
	b=MaVBqb5Fee+HnKQnYr1SndW9T+QGf0vUtScyCgPKjEw75d4xVUxvxs7LQFL2BtGYAP/1VW
	41ns0SV5RhobDJMdRVl1kzY4LweH/+vvpE0nQxWirXVMYG9m84yUW3uEvGs9A23S4IAiNX
	HSM4ppYbChUafiCymYxNx2RxBMpTd0g=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-685-1IZRgMlgM7KAaFqVFdgiHg-1; Wed, 26 Mar 2025 08:10:20 -0400
X-MC-Unique: 1IZRgMlgM7KAaFqVFdgiHg-1
X-Mimecast-MFC-AGG-ID: 1IZRgMlgM7KAaFqVFdgiHg_1742991020
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2ff799be8f5so12004934a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 05:10:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742991019; x=1743595819;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zcGJWpgvB7cR9K8awWQvPQUtNpQ+EuhR+/yBYj13d7I=;
        b=Ujrfj0FhwBGAU4grX4By8oKESjGoVulrsHMsDXWOEkCiqMxFpg0hPNypeCZE/OTjJm
         Sz0TF6wkeog+OJVUOeiB0vLYcIBYhUsNshBkHgjs1UH+DXiQrCjoHj3LwGhJQptX3Fvp
         1XNXdsYwMeQat+q37/dO9u9CDH9bQsbf4ggDNF2Z7CsOJLLnwiAHo9zAoPytZcsq8EDq
         /MvbDimo2Cza9JGDf+UE+4bwh9LJEk+7KsgS4Ggb771ksEUc0T5enQSf3D0q3qubdZj6
         /7DxPBiw017K0ijTTYrz2Mbx3ddaXQiYTYtbz41L1+bENjeriEBK0UhGxpuTeztBoOmc
         kopQ==
X-Forwarded-Encrypted: i=1; AJvYcCVotAQtwjchmenMVF0zrmKtm6QPG4Z9fbpysy848ItROLnfYTZ0u5vZzSi+PjbvUMZOvlGQtBaStBi52gI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxN5EYRB4feOROfZYfHYSqHvXnyr19dWuf5g71N0soJVz5YoO5o
	CCVx/C9MvVCb5TAQMBNiV/jMT6o+sIdSmwtDUogAOkb/h7nlXCKnFIQ6aQxAg/3g+BKZ4w2Rw4O
	A44/gY2jOUtbIday+I+9IZBZrg0ob21U9SOxxmx4za8pWkEXTKTEuNeQpQ2Kgs7wcfXS8Af1H5R
	J5PmJceh4Dzk5u842UEx6f0uJxeET1uOsYK9JQZTnZYj7yizU=
X-Gm-Gg: ASbGncuR0rDDV1UveWcBjpXgKWwP3/495JKVl+Q3I3NDWS8Lp9W31RFlOLuYdNYSvJU
	7t5CkkFB5JRlU1cvICVzYeQxls715dw4cPo5V+52yY6NuG9TjdA2zZANNFZrGnIrfRbDJWlM=
X-Received: by 2002:a17:90b:51c1:b0:2f7:e201:a8cc with SMTP id 98e67ed59e1d1-3030fe9813fmr36183343a91.18.1742991018901;
        Wed, 26 Mar 2025 05:10:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFtQfTAGm5C6XOVxYYLBpmI7+04qg80NAMnokLPeZTq/I7QFAdx4qLkUYRkyuFtlbrk/t60xlA5loC8rlTSNUI=
X-Received: by 2002:a17:90b:51c1:b0:2f7:e201:a8cc with SMTP id
 98e67ed59e1d1-3030fe9813fmr36183302a91.18.1742991018383; Wed, 26 Mar 2025
 05:10:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250324054333.1954-1-jasowang@redhat.com> <20250324054333.1954-3-jasowang@redhat.com>
In-Reply-To: <20250324054333.1954-3-jasowang@redhat.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 26 Mar 2025 13:09:40 +0100
X-Gm-Features: AQ5f1JqC0hnrWGaA3sp3od-ThhHz9TM4qIjLtia-sBN2x974Y_RgMTmcnH5DHDU
Message-ID: <CAJaqyWe5LxgVGj-g0yeEgQ-_r-+z4OnBaGkdy-VcqTjxV9hRBQ@mail.gmail.com>
Subject: Re: [PATCH 02/19] virtio_ring: switch to use vring_virtqueue in
 virtqueue_poll variants
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, xuanzhuo@linux.alibaba.com, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 24, 2025 at 6:43=E2=80=AFAM Jason Wang <jasowang@redhat.com> wr=
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
> index 1bdfd5d617a7..1c6b63812bf8 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -915,11 +915,10 @@ static unsigned int virtqueue_enable_cb_prepare_spl=
it(struct virtqueue *_vq)
>         return last_used_idx;
>  }
>
> -static bool virtqueue_poll_split(struct virtqueue *_vq, unsigned int las=
t_used_idx)
> +static bool virtqueue_poll_split(struct vring_virtqueue *vq,
> +                                unsigned int last_used_idx)
>  {
> -       struct vring_virtqueue *vq =3D to_vvq(_vq);
> -
> -       return (u16)last_used_idx !=3D virtio16_to_cpu(_vq->vdev,
> +       return (u16)last_used_idx !=3D virtio16_to_cpu(vq->vq.vdev,
>                         vq->split.vring.used->idx);
>  }
>
> @@ -1845,9 +1844,8 @@ static unsigned int virtqueue_enable_cb_prepare_pac=
ked(struct virtqueue *_vq)
>         return vq->last_used_idx;
>  }
>
> -static bool virtqueue_poll_packed(struct virtqueue *_vq, u16 off_wrap)
> +static bool virtqueue_poll_packed(struct vring_virtqueue *vq, u16 off_wr=
ap)
>  {
> -       struct vring_virtqueue *vq =3D to_vvq(_vq);
>         bool wrap_counter;
>         u16 used_idx;
>
> @@ -2608,8 +2606,8 @@ bool virtqueue_poll(struct virtqueue *_vq, unsigned=
 int last_used_idx)
>                 return false;
>
>         virtio_mb(vq->weak_barriers);
> -       return vq->packed_ring ? virtqueue_poll_packed(_vq, last_used_idx=
) :
> -                                virtqueue_poll_split(_vq, last_used_idx)=
;
> +       return vq->packed_ring ? virtqueue_poll_packed(vq, last_used_idx)=
 :
> +                                virtqueue_poll_split(vq, last_used_idx);
>  }
>  EXPORT_SYMBOL_GPL(virtqueue_poll);
>
> --
> 2.42.0
>


