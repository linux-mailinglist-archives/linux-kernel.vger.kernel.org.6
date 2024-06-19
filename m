Return-Path: <linux-kernel+bounces-220895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B90090E8CB
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 12:57:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABF8F1F21F95
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 10:57:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82C03130E20;
	Wed, 19 Jun 2024 10:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VGmNlQfd"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73A2F132100
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 10:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718794619; cv=none; b=D5jd1afDhFzVRQaCwpzQGAgNgDtGEQIWPBuofwLNyQ4YZi9nEED6m8Y15YmolgBxXx1VsXUWfPxgpRyEYE/oT7Fd5bdRtTn/aQ4Z7cSPwsp62mq750QJl6cPSsOD8Bdoq1JeyNEKkgtyVxe82un+S7H0d/Jp+ED6qI+KVnMxm9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718794619; c=relaxed/simple;
	bh=4smyqk//gciZ2tfr+0FYpp38iYLlwv1szyuA5ggeH4A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kXAmEsrYRlfQv3dLJQSyWfwe3wi748GQBUov8+ze8chbsFErCMxU6VRODfa8p4HKNX3rW2qR4gcMRx5Eh1fs8gtNReLd2Vfcy6ekHvol0RDoKpvG0GE2uYVPE3gzmASsKm98HDgHW+nw9ok44rlpYrePWbvJ94xuEDrgJIUGlFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VGmNlQfd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718794617;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VjZbrAKeWPPaFJmvloNszCVxus289ALpCaWtq/6RLHQ=;
	b=VGmNlQfdae3s1lXGKpNCfo6UR5Nf3II/2ttFvRyQE20xyRK+7tBPPLLF8HPqt+QjoC8OUQ
	wLqAd5s39apk14u81N7bwIFR3IJe1fGDuhGTtVcM5185F4kyI5bWL2Ggu4sJrT6H3OsbuI
	5bF+o3KCSKhkLWaAzANeVR48LQPprfg=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-193-kK5IGzSlOT2ZX34CiDOA4w-1; Wed, 19 Jun 2024 06:56:56 -0400
X-MC-Unique: kK5IGzSlOT2ZX34CiDOA4w-1
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-62f8a1b2969so132105937b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 03:56:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718794616; x=1719399416;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VjZbrAKeWPPaFJmvloNszCVxus289ALpCaWtq/6RLHQ=;
        b=Lxyy3GMOAYNV1oY4+IDf3yidnO4DmTUz8fga3UepqNdU6VMhjruDt080xXA/y4GpY3
         0gvF1YrWwWBpendDvp/GGLKggbCvoqF+6XhtBctc2MNjBGJqKhuzS9nDvvEEV7wTJQdF
         nVmSfV7O7yf4JzeCJeKCSaP1P6eROeJceEvm14EJTfXgn3Vg2B8RdqCHbZeW4w1gRd0c
         6gNzDHk1LRQpOUGMRLQkHQmMmMV0co3yH9hWcSOBdsqzh1yT5qplzbodXA8XeeV/eSl8
         FVE5VzPymrQ2CRC9WEkXGv+sEowRwQ/pi3H2ij2o0GLy5T2+gXDezXSGQfWlpr6nfdUA
         ODuQ==
X-Forwarded-Encrypted: i=1; AJvYcCXI/J2TX0zAVfRS/DztNxxnjwVrlESaaDD5xBngLqFyNwiZp/CWUtRX2qyOtPCHnKh+0MsB4CtBlCFWamFgfMpRopztV7EYL6sxyCi2
X-Gm-Message-State: AOJu0Yz0J7jq/aTf2txCFVnHFv4TscJoyMSYjf24tPuDLLXP/6ZUW3dr
	DfD2euxNGxDEay7iHKnMumn/g8jKZhah0ySOHfMMaZ3bauAbdodY2+H4rspIX1K5XeBgkUFqZGp
	NoK6MTWtB7dv0EWGZqQMndnOZsTv8Ij4IK4VDGCI4oskBlTt5lfUmoJujddjEvd/yuKo950Tb2o
	GQTtX0T6EakjrFNdlXdRVfrWqDk5WpCUsrlDBR
X-Received: by 2002:a05:6902:18c8:b0:dff:2f78:a5e2 with SMTP id 3f1490d57ef6-e02be20b9fbmr3077318276.48.1718794615604;
        Wed, 19 Jun 2024 03:56:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFBUNHSRsqjjtkqh3anCM1rUWgihsBSlpbQwcOBllw4ugAGeY3IlZgXoYdaWC9Vjxq0GasRjZJb7rLeAgR/w+0=
X-Received: by 2002:a05:6902:18c8:b0:dff:2f78:a5e2 with SMTP id
 3f1490d57ef6-e02be20b9fbmr3077292276.48.1718794615243; Wed, 19 Jun 2024
 03:56:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240617-stage-vdpa-vq-precreate-v1-0-8c0483f0ca2a@nvidia.com> <20240617-stage-vdpa-vq-precreate-v1-4-8c0483f0ca2a@nvidia.com>
In-Reply-To: <20240617-stage-vdpa-vq-precreate-v1-4-8c0483f0ca2a@nvidia.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 19 Jun 2024 12:56:19 +0200
Message-ID: <CAJaqyWe_ShF4HkhxsdHjgaBAMwCvw10_t9Wk_-A0QyPT+zFEbQ@mail.gmail.com>
Subject: Re: [PATCH vhost 04/23] vdpa/mlx5: Drop redundant check in teardown_virtqueues()
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
> The check is done inside teardown_vq().
>
> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>

Reviewed-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

> ---
>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/ml=
x5_vnet.c
> index b4d9ef4f66c8..96782b34e2b2 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -2559,16 +2559,10 @@ static int setup_virtqueues(struct mlx5_vdpa_dev =
*mvdev)
>
>  static void teardown_virtqueues(struct mlx5_vdpa_net *ndev)
>  {
> -       struct mlx5_vdpa_virtqueue *mvq;
>         int i;
>
> -       for (i =3D ndev->mvdev.max_vqs - 1; i >=3D 0; i--) {
> -               mvq =3D &ndev->vqs[i];
> -               if (!mvq->initialized)
> -                       continue;
> -
> -               teardown_vq(ndev, mvq);
> -       }
> +       for (i =3D ndev->mvdev.max_vqs - 1; i >=3D 0; i--)
> +               teardown_vq(ndev, &ndev->vqs[i]);
>  }
>
>  static void update_cvq_info(struct mlx5_vdpa_dev *mvdev)
>
> --
> 2.45.1
>


