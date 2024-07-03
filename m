Return-Path: <linux-kernel+bounces-239852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A65DA926616
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 18:25:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 630AC2855F1
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 16:25:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 136DD1862BE;
	Wed,  3 Jul 2024 16:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TsBqYSE/"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7EBC2BD19
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 16:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720023817; cv=none; b=YyIjU8bwvzDH72V//xElrMY55/fZsXG4KEFU+Tk4ZwCo5iEn6rnSww0GfgCP0zc6QdtcKPj4+NHDSfKp7tYhALdJHO9WRTqhZ0cKdwgsGy5FqiTJirwz+OIamW2ZDh3a0nP5nYPp448wpDLyef79Or7Cd6/XHrcbkbW6huoc63s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720023817; c=relaxed/simple;
	bh=yAl9WkIF75Z5792jsKO6kzvCg4MDRUb7mflCnX2qKpE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sqW35UxGZs3hSiFJCo8oPTaJGzf5qhzYwytI0GVR+NZzl0loHTzC4B2FxuXO+04otG/w8tryLrQco1z0R7T3xW2z3Zu51MSiftTdPsUKTGc7Hxsrt+G6p1Ft3TJtd6l0TQPs1xWywUSaJTaiVl1+BK7ms1E2kpRk7d/KuluaMFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TsBqYSE/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720023815;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n91rt4myNGjgsOAzA53ROWPaLTAmQTcNbTctluHszT0=;
	b=TsBqYSE/Ogb+CXsORFRoJ0wRWymSSoZAe46veu2fT/f5QTsMjnEUgiOiAMm+iEAr4+wPfx
	tjoRkoDpJvfVpHItPyaLqgntvC9uKY1RnQrzp8ua1xfNzTCLbjj7kX2odctk11zUgbs+eP
	8oWxICIONoCpyxcUo6LLlsV/vL4/nV4=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-230-X7zafkaAMxOdUYBS3a-1gg-1; Wed, 03 Jul 2024 12:23:29 -0400
X-MC-Unique: X7zafkaAMxOdUYBS3a-1gg-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-58bd8406816so1407539a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2024 09:23:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720023806; x=1720628606;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n91rt4myNGjgsOAzA53ROWPaLTAmQTcNbTctluHszT0=;
        b=cuCBq8TqyaMFcDjodEjYa27VUWlI9/kge0ui/LZ2ET5EJlJhgKh0/E/9FxtvTEBC5W
         6M5rzpotmo2ljEFPCipyHElPcgXScI2jEY5frSV7bqMxfQv6aZky/kITE5yf8JpChAPr
         b/Xf3pJgrpsnievQNbgX8kX6UjA1F7pLV67ObosIFvUaPeDrWMUz9jy/j2Y+uwQnCLby
         L4TstrZc7gkyNMdYgjVAlXFOEp1YllCAEgmbxsptrcY9RhcgI03wliGRaAwVDtZavNX1
         bDcMERvRa6xj2tT5LCEvWCeuIqRMZAVEUIhFrHyD+NeuEhpoI+2aksZGM//1uKnb4Bps
         If/A==
X-Forwarded-Encrypted: i=1; AJvYcCWoyMDugVXEFu93KOzUNqpZo/dhHMwXcSQmKMz2k/YiqHcbGW6ZE5maGPFe2kGUqsZwVOwIYvrjHScEv+aajrM6a7/fpO8PnwXTuFFs
X-Gm-Message-State: AOJu0YwxC+DMJf2QEoDAWS95chuN+lNb+fgbO491r+rDM7v4rCH73/uN
	5XRYCahJ0SCuwV83lpDuEcodCm7i0CaDgY4VP4Ht0/Utb1bxOFnu8ek+JILv6WuRsIxVUE0uU6m
	qDoj/7XXZ5S3cNLup75sr0G3cprlVm+95FJnZ5K0dFCaAuRP4kwFTX8/ml737xpZSxzSxf0mJll
	8f8n7hDV43wssRgQ8pr+h06d0kUA6oPbqCK7v2zWkPU4/5qqA=
X-Received: by 2002:a05:6402:1cc1:b0:57c:6188:875a with SMTP id 4fb4d7f45d1cf-587a0637437mr7847857a12.26.1720023806610;
        Wed, 03 Jul 2024 09:23:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGDKcKhOUx+NmAMpJL8tgtpN3L8p4uaUWiZMnuqg99iVFuWIDVp5qSLrtsQb/GpER4ZLfVxi176Yy0Dko+cScU=
X-Received: by 2002:a05:6402:1cc1:b0:57c:6188:875a with SMTP id
 4fb4d7f45d1cf-587a0637437mr7847840a12.26.1720023806248; Wed, 03 Jul 2024
 09:23:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240626-stage-vdpa-vq-precreate-v2-0-560c491078df@nvidia.com> <20240626-stage-vdpa-vq-precreate-v2-19-560c491078df@nvidia.com>
In-Reply-To: <20240626-stage-vdpa-vq-precreate-v2-19-560c491078df@nvidia.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 3 Jul 2024 18:22:47 +0200
Message-ID: <CAJaqyWccNsTo16CzUmSwNLFw2CTinrQ47YQ2JjRndyHLeRVFNg@mail.gmail.com>
Subject: Re: [PATCH vhost v2 19/24] vdpa/mlx5: Forward error in suspend/resume device
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Si-Wei Liu <si-wei.liu@oracle.com>, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org, 
	Cosmin Ratiu <cratiu@nvidia.com>, Zhu Yanjun <yanjun.zhu@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 26, 2024 at 12:28=E2=80=AFPM Dragos Tatulea <dtatulea@nvidia.co=
m> wrote:
>
> Start using the suspend/resume_vq() error return codes previously added.
>
> Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
> Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev>
> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>

Reviewed-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

> ---
>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/ml=
x5_vnet.c
> index e65d488f7a08..ce1f6a1f36cd 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -3436,22 +3436,25 @@ static int mlx5_vdpa_suspend(struct vdpa_device *=
vdev)
>  {
>         struct mlx5_vdpa_dev *mvdev =3D to_mvdev(vdev);
>         struct mlx5_vdpa_net *ndev =3D to_mlx5_vdpa_ndev(mvdev);
> +       int err;
>
>         mlx5_vdpa_info(mvdev, "suspending device\n");
>
>         down_write(&ndev->reslock);
>         unregister_link_notifier(ndev);
> -       suspend_vqs(ndev);
> +       err =3D suspend_vqs(ndev);
>         mlx5_vdpa_cvq_suspend(mvdev);
>         mvdev->suspended =3D true;
>         up_write(&ndev->reslock);
> -       return 0;
> +
> +       return err;
>  }
>
>  static int mlx5_vdpa_resume(struct vdpa_device *vdev)
>  {
>         struct mlx5_vdpa_dev *mvdev =3D to_mvdev(vdev);
>         struct mlx5_vdpa_net *ndev;
> +       int err;
>
>         ndev =3D to_mlx5_vdpa_ndev(mvdev);
>
> @@ -3459,10 +3462,11 @@ static int mlx5_vdpa_resume(struct vdpa_device *v=
dev)
>
>         down_write(&ndev->reslock);
>         mvdev->suspended =3D false;
> -       resume_vqs(ndev);
> +       err =3D resume_vqs(ndev);
>         register_link_notifier(ndev);
>         up_write(&ndev->reslock);
> -       return 0;
> +
> +       return err;
>  }
>
>  static int mlx5_set_group_asid(struct vdpa_device *vdev, u32 group,
>
> --
> 2.45.1
>


