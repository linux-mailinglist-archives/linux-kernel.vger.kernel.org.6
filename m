Return-Path: <linux-kernel+bounces-220901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DB2190E8E7
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 13:03:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B1B91C212E7
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 11:03:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1EE11369AC;
	Wed, 19 Jun 2024 11:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iEb/nmFb"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF93D12F5BF
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 11:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718794996; cv=none; b=X4AHIEOvR48KSeNigFq/TptBOsItKOT/nAcAHjomS14SZ4TKWNaF6ondKvQm77qpbGRTf/zUqxDqE/dnLj5/Mo+BHuLTPafp+odM+GUe+AggeHTRcSTwXh8amsjXvk1uqdTtKfn3/Dukdku3AoPoNO3vgqu/q2+08YwJpdF8FbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718794996; c=relaxed/simple;
	bh=1bdmFYChepEqjby6FGx8U06BldFaO0w3AEyYFVmPYEo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LCZ+4+YsX69CgsAlaEOx3xaA/+hvZscpehweYxkfgC8UkABh9eKe4nhDwX/5xy0uWBNeaGY2z7I1bAZh9ajWJlzOGPtjmxsBu0rvNWSX7ozd1OytTeSZfeTPR0KKu/eWpGOO9wrgVEfjXSbaiBVoN84ADNEoWH9x58eScTQ2Cj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iEb/nmFb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718794993;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V/M7MnGXwS8uLXvNZgVDSoX5YtxoFcpHgW7L/ahwWrY=;
	b=iEb/nmFbPREPlkwT2L1YiNacxIcuVFm8JaxaktXdjiCTQQJH2SFy1kY1lPoktCunhdUvTK
	huasTdPLxkGvrKKpTG6wHji93K6Veusix0Sp/xgL1vEX/f2zdCjOiA6LRl2oGym2UlG4eE
	ArWHbLMaAKINd+WznubSN88eZ6CqwnM=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-111-JekWv1S-NWykEvvmhX0Ffw-1; Wed, 19 Jun 2024 07:03:11 -0400
X-MC-Unique: JekWv1S-NWykEvvmhX0Ffw-1
Received: by mail-yb1-f199.google.com with SMTP id 3f1490d57ef6-dfdfe3d9fc8so13031964276.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 04:03:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718794991; x=1719399791;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V/M7MnGXwS8uLXvNZgVDSoX5YtxoFcpHgW7L/ahwWrY=;
        b=DKqhMx225nCtj6gRWA+V+HiwDzLHGzRqR4xBnLSoz7atdgO33YpPDNOi4K7ZhTRFaw
         0eFJfk8cI3JjwFdVkaDOHPPnNU86WY9X+cifiyIa+pLlYD9ML0QxxAVyPMiw8U6ojJMO
         BjgtuBppyIlqPkptYqFBdns1qB+DrHpQPmPonRtatUceMM4rl7rw4iDVXqw3Zvcp8f0/
         u4QKQ/sVlvdbnzUWrJ+eLe83M+mr9DypPxK2LESnkXKL3NYo67q7XkxfInqBp5Ma+H65
         3h81dxzH787v8OFaLv4CWe6/9zvFdNhXS3WMkaIlOh0PvbEmyVdER5WVFE5cHxMHzNe7
         y5IA==
X-Forwarded-Encrypted: i=1; AJvYcCXe5ID/bXhTdyW8e0I2xhAMFSaq3u3+9YjhiAv7zlAzPNPqKzVSnlwCKMFnJaotAOnKvr1+8y39o5GbrrNSSq4SvkScrAB/JMlfeidp
X-Gm-Message-State: AOJu0Yz8nz5w1JPBJQ3lH0azp/qYMInNkLzGMOhkjjiCYMIkKYl0ua5z
	5f/VS4P7IsK2+fFqZ/teP9kfdB/MPMrRB4nO9nJhhPSZzmUFS1k5ucB7zqLwPZDmOqeQPZkRh+U
	Hznnn2NRv1WWndf10B8CX7RReEdOPFjCY6rXHHcQjZ/sdcKPCkkXOUlzNE4CeNbra/vC4uIeCpZ
	fGS/0/2pHw8a669qq55h0QGjQEIMYLUsDQa6TI
X-Received: by 2002:a25:24b:0:b0:e02:c29d:7dc6 with SMTP id 3f1490d57ef6-e02c29d8011mr1449188276.43.1718794991115;
        Wed, 19 Jun 2024 04:03:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHMuYoMspdK9W3dvJFbwMXu6A1vxVHrL7pJhY3Nas3Emxi4QlBjq10Z0XGEVO+7m9QoYNiiYNpMnoT3yoCdFRY=
X-Received: by 2002:a25:24b:0:b0:e02:c29d:7dc6 with SMTP id
 3f1490d57ef6-e02c29d8011mr1449158276.43.1718794990800; Wed, 19 Jun 2024
 04:03:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240617-stage-vdpa-vq-precreate-v1-0-8c0483f0ca2a@nvidia.com> <20240617-stage-vdpa-vq-precreate-v1-6-8c0483f0ca2a@nvidia.com>
In-Reply-To: <20240617-stage-vdpa-vq-precreate-v1-6-8c0483f0ca2a@nvidia.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 19 Jun 2024 13:02:34 +0200
Message-ID: <CAJaqyWdHgpbmjtEP-tGgCiMGwrvkicjxXV8NLRZyDpRk97nkJA@mail.gmail.com>
Subject: Re: [PATCH vhost 06/23] vdpa/mlx5: Remove duplicate suspend code
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
> Use the dedicated suspend_vqs() function instead.
>
> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>

Reviewed-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

> ---
>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
>
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/ml=
x5_vnet.c
> index 51630b1935f4..eca6f68c2eda 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -3355,17 +3355,12 @@ static int mlx5_vdpa_suspend(struct vdpa_device *=
vdev)
>  {
>         struct mlx5_vdpa_dev *mvdev =3D to_mvdev(vdev);
>         struct mlx5_vdpa_net *ndev =3D to_mlx5_vdpa_ndev(mvdev);
> -       struct mlx5_vdpa_virtqueue *mvq;
> -       int i;
>
>         mlx5_vdpa_info(mvdev, "suspending device\n");
>
>         down_write(&ndev->reslock);
>         unregister_link_notifier(ndev);
> -       for (i =3D 0; i < ndev->cur_num_vqs; i++) {
> -               mvq =3D &ndev->vqs[i];
> -               suspend_vq(ndev, mvq);
> -       }
> +       suspend_vqs(ndev);
>         mlx5_vdpa_cvq_suspend(mvdev);
>         mvdev->suspended =3D true;
>         up_write(&ndev->reslock);
>
> --
> 2.45.1
>


