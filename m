Return-Path: <linux-kernel+bounces-221419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1074890F353
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 17:59:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C0EE1F229D1
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 15:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF50B155756;
	Wed, 19 Jun 2024 15:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LJHNfZ7X"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF82047779
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 15:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718812059; cv=none; b=NSqwiEvA4KFMJXnla2ucDqcm4WJXG2x2f4S3nMMdjpSgkjF/6TWtn2mhmvXAuurnWcPUL04/b3UPdOu1fsJG2vkru/Nndu3HdDU8vxdluSlbx70XRbVHUCDPQoa21pi2GCS/3k+YYV87/TWYc606/+Xoy3gYVB+shDBFOwR8iVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718812059; c=relaxed/simple;
	bh=JYrn5yh+hnO7LhELR0hV0l6YRXobPrRRbY9BLOUoMfk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AQsO0YudMn9qMKF3mYe10zSY8OnVdKQ4Is5f2z7wEAmyn9MkKM+ED9S9VBrEQ7982yuqihRKyaQ3HIlJtu0CPNokvTVS/ZP2NsN+MEy6/26MK8JX+CjNMU8P/ky1352MNxmN8IuUx/SrhJzLghVjjTFSIN/Rezs+0cSzeaVRE5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LJHNfZ7X; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718812056;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bdE1JwX4XUPlHCUNEa7GPYLNmBeA++RuMxTVFfl0GYk=;
	b=LJHNfZ7XMiLqX+JeYyaK7wWlwjiSibPAll5PmkvH+yOBP1YNO0pVF8/59VbVSXJQwN411S
	N41uHXshZj29GMmjIjB61ccU/0AL3ahxNnCEsLLE5StmYYi0kHHANEZ8pwwug7crUUj0fr
	AWJy2nkWIyL4hh1UCwH6GI6063pWshA=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-295-00YaD8LBOOeai_wtbHIl7A-1; Wed, 19 Jun 2024 11:47:35 -0400
X-MC-Unique: 00YaD8LBOOeai_wtbHIl7A-1
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-632cdb75d5aso103827747b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 08:47:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718812055; x=1719416855;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bdE1JwX4XUPlHCUNEa7GPYLNmBeA++RuMxTVFfl0GYk=;
        b=bDzFixx9/Zj+K+GqorwbPlFeYmFWaqk4z5H8O4EEWRMOKdRGKBVXrS7R3myVOvs9P8
         /OILwan5I+Zi2hcIa3K3qVHuOCfjumoLiMSCVF3EtojXnQo9Lfo+94MY7iziP/0c81X1
         wzuUob+fcNvn0h7n/0b2TmvRRsxq4KF092y1CPha99s17ba/PP5bIDJjRDi/+vuLYWBW
         6tMgFfQXhNR+V+KeN0M2qJp78oz7SUQgG1qS6OWTLCjNu5cjOe/Tmzf5+oaiwWxaha5R
         rMRzLx4hMSVMKhTNcSEfZG3eFaxnR9hdtTUECHAlzECvy3mX9jS2N3fzdy4eymQy6XY5
         YQWw==
X-Forwarded-Encrypted: i=1; AJvYcCW7di5W1vgwL97qbfR/wUS9Xs0KLXJ+a/LjC6uPcpJVqnWWhbj9SUa4S7tkBCIP5z049Zr73ytUwE2P5loIesjfoN5+j9ZIuoduY5HN
X-Gm-Message-State: AOJu0Yz6i7ee1YS2hom5f6T/Ai23J/lAX+hKjn9aw0Pt/fMDbpOJdvUn
	k692VD/6AOEyG7u7o+PtTx8kNFtbzf4DtwXcsXWcbyqemBK4sWHZ+k3ZSeoE9TH6hx2AYUZ3qCy
	0RlsGeSYAkqBBYqXNdCBnTihvjccIiQVqDGbbJOLFE2PQz3eTXOToB7+Ts2jub2e/4DXe2NIs+w
	Alf9mQhLuNURymtGruQBaqQN0x6ClG4J1NKfDB
X-Received: by 2002:a81:87c6:0:b0:622:c964:7e24 with SMTP id 00721157ae682-63a8e89bed9mr28085717b3.27.1718812054980;
        Wed, 19 Jun 2024 08:47:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGARc89i/ByokkRmsf8KW6yRGKzxLntpgug1yeSYVGWvi8wS+8L3zugBKbhE/rnCTMx3tu5/cQQG/VU5SbeX3c=
X-Received: by 2002:a81:87c6:0:b0:622:c964:7e24 with SMTP id
 00721157ae682-63a8e89bed9mr28085337b3.27.1718812053908; Wed, 19 Jun 2024
 08:47:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240617-stage-vdpa-vq-precreate-v1-0-8c0483f0ca2a@nvidia.com> <20240617-stage-vdpa-vq-precreate-v1-19-8c0483f0ca2a@nvidia.com>
In-Reply-To: <20240617-stage-vdpa-vq-precreate-v1-19-8c0483f0ca2a@nvidia.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 19 Jun 2024 17:46:57 +0200
Message-ID: <CAJaqyWc5rJT666R672f2RQZvAHxy1QdoUKRfCH_wV1F61pQ2Gg@mail.gmail.com>
Subject: Re: [PATCH vhost 19/23] vdpa/mlx5: Use suspend/resume during VQP change
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Si-Wei Liu <si-wei.liu@oracle.com>, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org, 
	Cosmin Ratiu <cratiu@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 17, 2024 at 5:09=E2=80=AFPM Dragos Tatulea <dtatulea@nvidia.com=
> wrote:
>
> Resume a VQ if it is already created when the number of VQ pairs
> increases. This is done in preparation for VQ pre-creation which is
> coming in a later patch. It is necessary because calling setup_vq() on
> an already created VQ will return early and will not enable the queue.
>
> For symmetry, suspend a VQ instead of tearing it down when the number of
> VQ pairs decreases. But only if the resume operation is supported.
>
> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>

Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

> ---
>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/ml=
x5_vnet.c
> index 0e1c1b7ff297..249b5afbe34a 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -2130,14 +2130,22 @@ static int change_num_qps(struct mlx5_vdpa_dev *m=
vdev, int newqps)
>                 if (err)
>                         return err;
>
> -               for (i =3D ndev->cur_num_vqs - 1; i >=3D 2 * newqps; i--)
> -                       teardown_vq(ndev, &ndev->vqs[i]);
> +               for (i =3D ndev->cur_num_vqs - 1; i >=3D 2 * newqps; i--)=
 {
> +                       struct mlx5_vdpa_virtqueue *mvq =3D &ndev->vqs[i]=
;
> +
> +                       if (is_resumable(ndev))
> +                               suspend_vq(ndev, mvq);
> +                       else
> +                               teardown_vq(ndev, mvq);
> +               }
>
>                 ndev->cur_num_vqs =3D 2 * newqps;
>         } else {
>                 ndev->cur_num_vqs =3D 2 * newqps;
>                 for (i =3D cur_qps * 2; i < 2 * newqps; i++) {
> -                       err =3D setup_vq(ndev, &ndev->vqs[i], true);
> +                       struct mlx5_vdpa_virtqueue *mvq =3D &ndev->vqs[i]=
;
> +
> +                       err =3D mvq->initialized ? resume_vq(ndev, mvq) :=
 setup_vq(ndev, mvq, true);
>                         if (err)
>                                 goto clean_added;
>                 }
>
> --
> 2.45.1
>


