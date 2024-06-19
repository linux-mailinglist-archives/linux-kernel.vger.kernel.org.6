Return-Path: <linux-kernel+bounces-220940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D18D90E969
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 13:28:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C89FF1F24573
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 11:28:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A54F13C8F0;
	Wed, 19 Jun 2024 11:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MDvDepqK"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D763813AA4D
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 11:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718796526; cv=none; b=lttXGxICwsPrwzYj724i4/6tmHK36CGwx9lyxm8XNkvc2f7wO3c/iWr0LOP3YiCGKykmgCATe0DIq1ihrPJcyHex77vZd2xp3oPlPZfLOFfjJpSqUYSYiO8Q1BWj0xjgwM7ytuijWhIWnLt8D5iDxDpFaKBPJP7e6sZS1NQ+2vM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718796526; c=relaxed/simple;
	bh=UebvP+HuSTSd4+xs5uWLtAZajwRAnKbKtoQ1F5LF4fE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ht1A7/1qtbTYT3HHa709aBBk73P7PxEq6OafTeVZrEO75SePTkWIA1yWMTkjJf88c0UPSlrqD3xAOcC+RkQ0uFmJe63REHK2VKOTff+EqwKAXmB1+0SwAFv0CZxlM0fDnuS13rdyYSJb8x6uubESnHDuptSGNzGrtkARLWGJBV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MDvDepqK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718796524;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8nu4T3Lf7xrksBQPYeiJSwp8o6qGfAc6ny6mt2UlNiA=;
	b=MDvDepqKqOPCoX6eBKw4ON4BSCgwl4HtdEPsIE3I81pGjMyO3qoS/jIwQJqCOj1fr9q8Pc
	Wc9qjnKQsNbjyzSlI5rSWHJGN+iQ58aq7nJKvSnpCpoekcEDFohyxu026KpEqxnkUczwmq
	8qucHqxuGdvR6BwOQRaleWgtQj4VkGw=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-536-xvzF0N_DM3m1OPg3EFrtkA-1; Wed, 19 Jun 2024 07:28:42 -0400
X-MC-Unique: xvzF0N_DM3m1OPg3EFrtkA-1
Received: by mail-yb1-f200.google.com with SMTP id 3f1490d57ef6-e02726920d8so3000013276.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 04:28:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718796522; x=1719401322;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8nu4T3Lf7xrksBQPYeiJSwp8o6qGfAc6ny6mt2UlNiA=;
        b=TKbnJKNXB6LAUxEj8s6gS9vT91rhsVS2qxJwgP/x+QXDcEhrbBsX2HMh8ypTzagWF0
         yZajzmgbl4wWtYxvRTQ71Kx/fN5xgrC97bAy56cM/oHOPR+MLi8ZZ+iskl/2/3QZ1bIb
         ItAreHI4b4EGMbzLUYewFLVS4zjlhkzPWwmQB5AnP5YVmb5T1CU9ujptq39YJs5NBCQV
         VXRWNZgsMffwOyeYZQv06cZbV24HO4jxIuXdhdwtzjSbHvlrwRnXLtO3X7AwamLyQ872
         HVoT8h/zPz+iByF3wf1geB6RaCmBhQg91eGolmlSV4aCztL3wbZRaIx1sngi6hKD4P1P
         uSCQ==
X-Forwarded-Encrypted: i=1; AJvYcCV1/TFdBxctONeJq4S33v35STO4KauVdCC+anfeZ8Rthoq0agpgOlq9teLLd0KK1nd0+21hP0Bo7tpVkOMv5W1tIx20ToqUJ3IBAT2D
X-Gm-Message-State: AOJu0YwjQvsgAfOnj0LuLLum273vlZ95ggBb18n5TlLj34GEpOfeGz4r
	6yxi4yaSxxNmMkRPj/M0LqSgu+aufRRZLSXuQ8l/RHxm/dW3C+L6QSJ9s68KkKRamX3YToGX6Pm
	jEexD9i3NzqlIGd6kZkOJAadxWEjmhurb5wr/vqRNSi5XME5nMJ/z8vfNMA0Tdnvl/KQp8omtnc
	XkdwnOYyZcGO/IG/YYvZVKGNC9MHopZH+MPn1E
X-Received: by 2002:a25:9e92:0:b0:dfe:f4e3:72cb with SMTP id 3f1490d57ef6-e02be16636amr2405832276.27.1718796522160;
        Wed, 19 Jun 2024 04:28:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG2//M0xJEG1ac3l2EWYJOki/9vn16+rkHiPKi6eqTjS6c2HpE220pBNTiYol4LEfF4a8/TbCQvq5VtNyY6U/4=
X-Received: by 2002:a25:9e92:0:b0:dfe:f4e3:72cb with SMTP id
 3f1490d57ef6-e02be16636amr2405820276.27.1718796521806; Wed, 19 Jun 2024
 04:28:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240617-stage-vdpa-vq-precreate-v1-0-8c0483f0ca2a@nvidia.com> <20240617-stage-vdpa-vq-precreate-v1-8-8c0483f0ca2a@nvidia.com>
In-Reply-To: <20240617-stage-vdpa-vq-precreate-v1-8-8c0483f0ca2a@nvidia.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 19 Jun 2024 13:28:05 +0200
Message-ID: <CAJaqyWd5HRa2JVXVgPxYZn05drN8UyUHu=7jyxtON1d-XHneNg@mail.gmail.com>
Subject: Re: [PATCH vhost 08/23] vdpa/mlx5: Clear and reinitialize software VQ
 data on reset
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Si-Wei Liu <si-wei.liu@oracle.com>, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org, 
	Cosmin Ratiu <cratiu@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 17, 2024 at 5:08=E2=80=AFPM Dragos Tatulea <dtatulea@nvidia.com=
> wrote:
>
> The hardware VQ configuration is mirrored by data in struct
> mlx5_vdpa_virtqueue . Instead of clearing just a few fields at reset,
> fully clear the struct and initialize with the appropriate default
> values.
>
> As clear_vqs_ready() is used only during reset, get rid of it.
>
> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>

Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

> ---
>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 16 +++-------------
>  1 file changed, 3 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/ml=
x5_vnet.c
> index c8b5c87f001d..de013b5a2815 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -2941,18 +2941,6 @@ static void teardown_vq_resources(struct mlx5_vdpa=
_net *ndev)
>         ndev->setup =3D false;
>  }
>
> -static void clear_vqs_ready(struct mlx5_vdpa_net *ndev)
> -{
> -       int i;
> -
> -       for (i =3D 0; i < ndev->mvdev.max_vqs; i++) {
> -               ndev->vqs[i].ready =3D false;
> -               ndev->vqs[i].modified_fields =3D 0;
> -       }
> -
> -       ndev->mvdev.cvq.ready =3D false;
> -}
> -
>  static int setup_cvq_vring(struct mlx5_vdpa_dev *mvdev)
>  {
>         struct mlx5_control_vq *cvq =3D &mvdev->cvq;
> @@ -3035,12 +3023,14 @@ static int mlx5_vdpa_compat_reset(struct vdpa_dev=
ice *vdev, u32 flags)
>         down_write(&ndev->reslock);
>         unregister_link_notifier(ndev);
>         teardown_vq_resources(ndev);
> -       clear_vqs_ready(ndev);
> +       init_mvqs(ndev);

Nitpick / suggestion if you have to send a v2. The init_mvqs function
name sounds like it can allocate stuff that needs to be released to
me. But I'm very bad at naming :). Maybe something like
"mvqs_set_defaults" or similar?

> +
>         if (flags & VDPA_RESET_F_CLEAN_MAP)
>                 mlx5_vdpa_destroy_mr_resources(&ndev->mvdev);
>         ndev->mvdev.status =3D 0;
>         ndev->mvdev.suspended =3D false;
>         ndev->cur_num_vqs =3D MLX5V_DEFAULT_VQ_COUNT;
> +       ndev->mvdev.cvq.ready =3D false;
>         ndev->mvdev.cvq.received_desc =3D 0;
>         ndev->mvdev.cvq.completed_desc =3D 0;
>         memset(ndev->event_cbs, 0, sizeof(*ndev->event_cbs) * (mvdev->max=
_vqs + 1));
>
> --
> 2.45.1
>


