Return-Path: <linux-kernel+bounces-239715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 74E7492645C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 17:09:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98F5F1C234BA
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 15:09:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07F0E17FAAA;
	Wed,  3 Jul 2024 15:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bEdJhdGI"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A82CD17D8A6
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 15:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720019346; cv=none; b=ikkyZ5JVOhjw9Qy6Vr0oX6OhDiw7PQ2gVsHa2tu+OXB+OZ1L0+WGGRMWYLeVdOCWB+BMJe3ityjfQvwPVGVV77ErVIRbFeDjCx2yACEjOlP0HxTLD4s86+cbZvE3z6ynvk01DIW7945ixjMyfJRcGiDiJuf51qkr+G00J7a2X6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720019346; c=relaxed/simple;
	bh=jr1zoQlesMQk4r7o3HlIip0zDDWr+3fEo4jdfJsQNtU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GNVW7I+WIFtXJiBoZJguSJX9XZRagD0cJBR6gLkjySE1mJBInd6gfwyyKRYwfZ5tjl9ru5+drCFz9v1B51SwBrsPViMR46STRl2/Ar7yzrtQA6DaHjw23LG7EyQWablYS39cBkgj3v3cJltIEwZOg9iwRap17OJMwBtuePonWnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bEdJhdGI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720019343;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hJxP5plkEqtGT2+Fyxc7Jfw1c1Ky2bpGqcVIJ84Skao=;
	b=bEdJhdGIBtvLFgSi0C3HiAg3lD8r6PxNFzrQgUcFD7jv+qqy8tT8nQmYM0EiF6y3AGEZZz
	FT3yYOGCQcQ9//imaVBzS/0b7guLnvfnRUVNP136zRNc55dMXnTMiOBp9d+r8TuBUcdbbO
	YOqexfY7vXvcOazTyBdAa1qxsp2d5ig=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-63-zdMd7ErxNTa_ZaZDaN3BiA-1; Wed, 03 Jul 2024 11:09:01 -0400
X-MC-Unique: zdMd7ErxNTa_ZaZDaN3BiA-1
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-701ef03180dso5021080a34.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2024 08:09:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720019341; x=1720624141;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hJxP5plkEqtGT2+Fyxc7Jfw1c1Ky2bpGqcVIJ84Skao=;
        b=MxFR3YZSVrLueuUSojeKGW/SYunar27tsVgQd5fxQAxxI4Ls1bC0eddBQ+nh2Q69QG
         kTAMBUp6qtcCNKYGStJKummp7q+fAfdNWZdGxlboMrvcNQ8g17E/t0Vc2t5fITnWUB64
         GNTL9tvQbSd8YsmhBPPoxFhzYqus+qPsBrPNAx+G4zHmZ4FrvCN2AKbzvaaovlfBNnK6
         j9wqbmGFbRtSvaBgw8Z1SUXkRXW7zHrldxIYpfdirL2NkCq2CjVJNBHEKGz9WrMFVzbS
         3OF6rOKkykLqgZI142zfZMPw5KWHgd/so6Wj9JewrsS6ckVhoNXZL9PkY0GQCwEFDm82
         /Y3g==
X-Forwarded-Encrypted: i=1; AJvYcCX785MP4pic+/xoWONNqE0RUO+SZu9TPIiZXBRBdHkVKfTgMCxFN5Wk0IPOSgMMrnl6e+b0v3Fxx24TJHZrrJDG/dWFUmGHj5cL9/BH
X-Gm-Message-State: AOJu0YyNjD516qLzRyDeP9UHJ6nO08YCfyqsIT3u+ZWk3E15ilY221ef
	5QD6hmgvZBOIj07i3FZ/7xsn4s4/YwogBITRoj12EYsjObv3m4IRGCnHVU5Vc8Qv2qhcl7dMRxb
	n0vRcOTWbgU9dOVrKAVvd5+PESnZOWHe1iFDsZMwpHkJ9ntMfXD1JKpdZWWUkmm79LhPOmSE1AK
	HeTzw7puHSExhpjDxQzpDMzEmiOJfsbQss0orC
X-Received: by 2002:a9d:68d8:0:b0:702:2550:4e2c with SMTP id 46e09a7af769-702255051e8mr4714181a34.14.1720019340957;
        Wed, 03 Jul 2024 08:09:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHZVFTIESQ8I8751zJPQrUjeFOeuFR0etgZWdHlMXhxuGEMPW7TYqK1PmAoORoUI/N+D8s9cfchZbSZ1h971QY=
X-Received: by 2002:a9d:68d8:0:b0:702:2550:4e2c with SMTP id
 46e09a7af769-702255051e8mr4714149a34.14.1720019340676; Wed, 03 Jul 2024
 08:09:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240626-stage-vdpa-vq-precreate-v2-0-560c491078df@nvidia.com> <20240626-stage-vdpa-vq-precreate-v2-9-560c491078df@nvidia.com>
In-Reply-To: <20240626-stage-vdpa-vq-precreate-v2-9-560c491078df@nvidia.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 3 Jul 2024 17:08:24 +0200
Message-ID: <CAJaqyWf-MRS9ahonzAvuHVQ4dfgm6FQPmqk_vKMiRag7XDB8Sw@mail.gmail.com>
Subject: Re: [PATCH vhost v2 09/24] vdpa/mlx5: Rename init_mvqs
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Si-Wei Liu <si-wei.liu@oracle.com>, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 26, 2024 at 12:27=E2=80=AFPM Dragos Tatulea <dtatulea@nvidia.co=
m> wrote:
>
> Function is used to set default values, so name it accordingly.
>
> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>

Reviewed-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

> ---
>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/ml=
x5_vnet.c
> index de013b5a2815..739c2886fc33 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -155,7 +155,7 @@ static bool is_index_valid(struct mlx5_vdpa_dev *mvde=
v, u16 idx)
>  }
>
>  static void free_fixed_resources(struct mlx5_vdpa_net *ndev);
> -static void init_mvqs(struct mlx5_vdpa_net *ndev);
> +static void mvqs_set_defaults(struct mlx5_vdpa_net *ndev);
>  static int setup_vq_resources(struct mlx5_vdpa_net *ndev);
>  static void teardown_vq_resources(struct mlx5_vdpa_net *ndev);
>
> @@ -2810,7 +2810,7 @@ static void restore_channels_info(struct mlx5_vdpa_=
net *ndev)
>         int i;
>
>         mlx5_clear_vqs(ndev);
> -       init_mvqs(ndev);
> +       mvqs_set_defaults(ndev);
>         for (i =3D 0; i < ndev->mvdev.max_vqs; i++) {
>                 mvq =3D &ndev->vqs[i];
>                 ri =3D &mvq->ri;
> @@ -3023,7 +3023,7 @@ static int mlx5_vdpa_compat_reset(struct vdpa_devic=
e *vdev, u32 flags)
>         down_write(&ndev->reslock);
>         unregister_link_notifier(ndev);
>         teardown_vq_resources(ndev);
> -       init_mvqs(ndev);
> +       mvqs_set_defaults(ndev);
>
>         if (flags & VDPA_RESET_F_CLEAN_MAP)
>                 mlx5_vdpa_destroy_mr_resources(&ndev->mvdev);
> @@ -3485,7 +3485,7 @@ static void free_fixed_resources(struct mlx5_vdpa_n=
et *ndev)
>         res->valid =3D false;
>  }
>
> -static void init_mvqs(struct mlx5_vdpa_net *ndev)
> +static void mvqs_set_defaults(struct mlx5_vdpa_net *ndev)
>  {
>         struct mlx5_vdpa_virtqueue *mvq;
>         int i;
> @@ -3635,7 +3635,7 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *=
v_mdev, const char *name,
>         }
>         ndev->cur_num_vqs =3D MLX5V_DEFAULT_VQ_COUNT;
>
> -       init_mvqs(ndev);
> +       mvqs_set_defaults(ndev);
>         allocate_irqs(ndev);
>         init_rwsem(&ndev->reslock);
>         config =3D &ndev->config;
>
> --
> 2.45.1
>


