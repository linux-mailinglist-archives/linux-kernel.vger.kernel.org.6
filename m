Return-Path: <linux-kernel+bounces-239849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 024BA92660C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 18:24:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 778BD1F22955
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 16:24:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48C3F18308D;
	Wed,  3 Jul 2024 16:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WDC+4P6r"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26FB618308B
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 16:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720023704; cv=none; b=T94MTGAlOxnf6rwQa4K568BP+2Hdye25yESGytZr1w5CcUeyqCMOiQDlBeKXMYh/5IkXOp7CEW/lntlSeWcP9RurA6/PfE+GU66UKZ/x8MftHG6KDlKZFZIUCC4n1Otv8RxJpMgaqf7HiOB/b815/ICv8TCJ2XHRZhvn47hZucQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720023704; c=relaxed/simple;
	bh=TcS0Nab4P1uInJHhXVtq4QA+KS6M5rJkuPOwVobX3GA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jdfvIZ/Vyb5c0hC/3FDna0dBtbiEZodKxgej2BbZBVGaX3E776OLANEAi22cfRfjgYZT4JnU8e4vYjP7WXU0lSLEeB3WIiNfDPUdspiFqlFSHchsXv80/t1cg+bmSDvSANLTwaMx63vMAH/OW1KPAhc6bvsJYm8BmVxXS50tvBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WDC+4P6r; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720023702;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RvzgALGPKTw1bigvFfaZyijkP2+PzdDyQ0IADPOqqJg=;
	b=WDC+4P6rwcRBfL8dkIamiRLfjO2nWdq4OQjBJeX1Y2VfgCi91/kM9kXD5zUfpfMVVxONft
	BdSPc5r9wlxWX8giwEVKLckmQTLOm3G/Gl/eiBRpqHZSAMZvJrXJDz1SiSf5Ww5VQR6ytN
	LhsPyllVrI418Gjj8BJKTmD2makerbU=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-32aPcIEaM_2M8DXbCRgGQQ-1; Wed, 03 Jul 2024 12:21:40 -0400
X-MC-Unique: 32aPcIEaM_2M8DXbCRgGQQ-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-58b3fcf235dso1772966a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2024 09:21:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720023699; x=1720628499;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RvzgALGPKTw1bigvFfaZyijkP2+PzdDyQ0IADPOqqJg=;
        b=fJXeNIg8P5BvJifI6WqSKtI6F8maDx19UnnL8Pvre+thBpyjjw0X9raJmf313Z+JEd
         vOxy+qeM8m7qyLu/sDGMxmiSGLIm+fhyG1YFZMm7jz7pHcKqwcPAaLoMd0nWGEacjeAW
         iJpL8dXjCYXaK3HO/e3oHWXZg0TSLE7BjWYJMrbMv49vbCvGQL8c1ucaOFOJzLS7dUfo
         AJWpvreNWDtV0yGWR+Zoy5l5f3qn0jeDYDkNhQ5fWxGam6bASc0Zx+OrjG6rnSK7E0zq
         fsf11my/Zw5A+gYfE8Av245zVKwB4HZbHGOCaKRgPN12lpXa0zRWN+pzkSKk9l6ji6cG
         G6Hg==
X-Forwarded-Encrypted: i=1; AJvYcCVecQFE8L+QJOpzB/zOTbQYcS/2Xil0ABR26U/rGtv/ApBF3kNahsw0bshqFcjo2rjLT55YcyEb+lXKCUDxaKMUjlFpP8BpQB1jaVOR
X-Gm-Message-State: AOJu0YzUwQyhIEZqKWATn8f/DNmIkpZnaZJtHLsg/mGNeU23oT4GRt4U
	Q2xX6DwKC/UyFjIH+obssRiun0m7LyFuwgquU0le1DOSS9HZ8Su9nYDAIasqJc+Jxpq0rSlvubT
	M1MLysf2qGop07Mf+UW7aC891ZGHW9tgvUa+k668ITxQd0ZQXw2iTxCDN9p5CgnkjXogvh/AnA0
	JEnM1BW/RxDmVl2NclaT5rr1pp+hg47tNzkSKZ
X-Received: by 2002:a05:6402:2113:b0:57a:2ccb:b3f2 with SMTP id 4fb4d7f45d1cf-5879f59bc0dmr8314472a12.16.1720023699465;
        Wed, 03 Jul 2024 09:21:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFLrQmfzqoCkSKEjGQCytFKKt1qFveCCZLiKDvdyFB5I6punigduS2DoMmXGBJNBjrgv6P7Ec5gPWUP4aOKX74=
X-Received: by 2002:a05:6402:2113:b0:57a:2ccb:b3f2 with SMTP id
 4fb4d7f45d1cf-5879f59bc0dmr8314456a12.16.1720023699020; Wed, 03 Jul 2024
 09:21:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240626-stage-vdpa-vq-precreate-v2-0-560c491078df@nvidia.com> <20240626-stage-vdpa-vq-precreate-v2-16-560c491078df@nvidia.com>
In-Reply-To: <20240626-stage-vdpa-vq-precreate-v2-16-560c491078df@nvidia.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 3 Jul 2024 18:21:01 +0200
Message-ID: <CAJaqyWdK4u0Y2EbgyWsYupLvybuBK=waf_qhUqne2q9wHvuEqA@mail.gmail.com>
Subject: Re: [PATCH vhost v2 16/24] vdpa/mlx5: Accept Init -> Ready VQ
 transition in resume_vq()
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Si-Wei Liu <si-wei.liu@oracle.com>, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org, 
	Cosmin Ratiu <cratiu@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 26, 2024 at 12:28=E2=80=AFPM Dragos Tatulea <dtatulea@nvidia.co=
m> wrote:
>
> Until now resume_vq() was used only for the suspend/resume scenario.
> This change also allows calling resume_vq() to bring it from Init to
> Ready state (VQ initialization).
>
> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>

Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

> ---
>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 24 ++++++++++++++++++++++--
>  1 file changed, 22 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/ml=
x5_vnet.c
> index 0a62ce0b4af8..adcc4d63cf83 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -1557,11 +1557,31 @@ static void suspend_vqs(struct mlx5_vdpa_net *nde=
v)
>
>  static void resume_vq(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtq=
ueue *mvq)
>  {
> -       if (!mvq->initialized || !is_resumable(ndev))
> +       if (!mvq->initialized)
>                 return;
>
> -       if (mvq->fw_state !=3D MLX5_VIRTIO_NET_Q_OBJECT_STATE_SUSPEND)
> +       switch (mvq->fw_state) {
> +       case MLX5_VIRTIO_NET_Q_OBJECT_STATE_INIT:
> +               /* Due to a FW quirk we need to modify the VQ fields firs=
t then change state.
> +                * This should be fixed soon. After that, a single comman=
d can be used.
> +                */
> +               if (modify_virtqueue(ndev, mvq, 0))
> +                       mlx5_vdpa_warn(&ndev->mvdev,
> +                               "modify vq properties failed for vq %u\n"=
, mvq->index);
> +               break;
> +       case MLX5_VIRTIO_NET_Q_OBJECT_STATE_SUSPEND:
> +               if (!is_resumable(ndev)) {
> +                       mlx5_vdpa_warn(&ndev->mvdev, "vq %d is not resuma=
ble\n", mvq->index);
> +                       return;
> +               }
> +               break;
> +       case MLX5_VIRTIO_NET_Q_OBJECT_STATE_RDY:
>                 return;
> +       default:
> +               mlx5_vdpa_warn(&ndev->mvdev, "resume vq %u called from ba=
d state %d\n",
> +                              mvq->index, mvq->fw_state);
> +               return;
> +       }
>
>         if (modify_virtqueue_state(ndev, mvq, MLX5_VIRTIO_NET_Q_OBJECT_ST=
ATE_RDY))
>                 mlx5_vdpa_warn(&ndev->mvdev, "modify to resume failed for=
 vq %u\n", mvq->index);
>
> --
> 2.45.1
>


