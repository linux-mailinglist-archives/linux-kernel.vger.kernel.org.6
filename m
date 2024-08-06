Return-Path: <linux-kernel+bounces-276700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A88A6949734
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 19:58:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C90C6B21ECC
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 17:58:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF3FF75804;
	Tue,  6 Aug 2024 17:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Okfwkyd1"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 602E0381C4
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 17:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722967109; cv=none; b=hbxrFGoKB7HH18oI0Bv36dP3i0AaouR6YBYeNcnuJiOFkGjJ5WVP59epjTTXAserDh6C60j2gxrNJl9XQpO4cMBIbmtZUMjnoROsJiqjdXfDsG0LCshqy4ywekWzORmHirx0pZIPHmS2dr2PnZnh6iAT0KuscBJJeTAEhVYJVN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722967109; c=relaxed/simple;
	bh=qNuxMjpY0wvdmw9acq+viJ9zFuemeU/NFuGE6U6Hs9A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N1FrZiF3NDuAkM5MM8h+jGQZIt68ghSEZOSbW1R5p7xiINTXzSNUrcvJ7Xfs43/wdx0y7VlY/LRO1TED/PztagdFyJixhvKCPz4triCeTn17sWbAmFmJ3NwZxCFOHZ4F2dSP1leneV3QmkQd71Q0g3AKAxe41wK4c8majMS3n2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Okfwkyd1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722967106;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4Gi0LljCZ7f7U2OFha6B11/YBCEDtZQk+22si+AZMeY=;
	b=Okfwkyd1W36mLSX6gISxQwvkxnEevXxktoS2LRo6YxirSi/tL0IAJ7TmcBmbO4ik1g+jlM
	mTsyJIhqoGDtlIp6vR15UTH1PvEjFW4+GD+U6ZK6BfA3GiQHeTiwpgac4DBN0/M5nYkL1b
	FoNgZoWChq0fQDbJhdRXjtp4lZ0/P+U=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-217-4CM7Ub9XN3-CzRiqqULh3g-1; Tue, 06 Aug 2024 13:58:22 -0400
X-MC-Unique: 4CM7Ub9XN3-CzRiqqULh3g-1
Received: by mail-yb1-f198.google.com with SMTP id 3f1490d57ef6-e035949cc4eso1586602276.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 10:58:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722967102; x=1723571902;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4Gi0LljCZ7f7U2OFha6B11/YBCEDtZQk+22si+AZMeY=;
        b=cqWjQC1Mjwgt8t779fyqnXvhOvkRaWvdNgqDLdq92XZonXhDmYj8nBTIQoTGtnl3DI
         0uc0OtcnIKBCMjikWO85iEeoQFolRRBsFagboQoyJDVprHz3U3RwJh6LaXjBrraUPr0R
         5b00I+up6VBV17Zsd3ciXChsFwvB3Ue7ogTGlcrCbJS9iy+fFe/xRTKvH3UPbGFKVFcP
         X0eCex7xUv4nbXep90MrXzfxfVc0+s9d3ZmXQs9FiPRAQHiXYUoUSpGGrNynQGM2DgWH
         GOc73Fkg/jxxiuw0XJVlsMwxDtFweDpZsPbHg+0jhXlf4alTImBhzIfHsR6Sr046P7In
         qQCA==
X-Forwarded-Encrypted: i=1; AJvYcCXpPIZMY2eLzH3k89Vk00vhkVT1wOpV60dQeveNMMS9eo4bOQxGxWkrA03bgWgSMKEvgmFM4+8s6KXnnEk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1xfHanAYiOgr7nkRJDsmsDqof9BUPDRkhUs89EtKRGFiPkrAw
	6Q7v9iHuULplKgruThojbfUcXPgiMToXGpyCa0OOar/k1Y//f7edjESHWJGNABxwqx3wkngZkMB
	RbDxRCvzmX0N9CAkOXsAAQlOVbCQeLBZ5hlMucqAMCNo918NXBDREEPT2TGJBCnodSq7e6xazZ7
	f8o2jaksDgF8cIQCVMgubNItuEF+qYbrCHytLh
X-Received: by 2002:a05:6902:2b92:b0:dff:3058:e30f with SMTP id 3f1490d57ef6-e0bde3ae458mr20463937276.21.1722967102207;
        Tue, 06 Aug 2024 10:58:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGCRzdVY1dNStNjoVWJTvRwfgffcPUw8tKNZba2BQWfVM6yUz0fUVe75m1iRyay70v/MhXYCdUb7+Uy5Pxkt3E=
X-Received: by 2002:a05:6902:2b92:b0:dff:3058:e30f with SMTP id
 3f1490d57ef6-e0bde3ae458mr20463913276.21.1722967101934; Tue, 06 Aug 2024
 10:58:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240802072039.267446-1-dtatulea@nvidia.com> <20240802072039.267446-3-dtatulea@nvidia.com>
In-Reply-To: <20240802072039.267446-3-dtatulea@nvidia.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Tue, 6 Aug 2024 19:57:45 +0200
Message-ID: <CAJaqyWdeNY5guVCo3XyO0H+sN-cr-FUMwALgQJtFT0nmGdRPGw@mail.gmail.com>
Subject: Re: [PATCH vhost 2/7] vdpa/mlx5: Introduce error logging function
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Si-Wei Liu <si-wei.liu@oracle.com>, 
	Tariq Toukan <tariqt@nvidia.com>, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 2, 2024 at 9:24=E2=80=AFAM Dragos Tatulea <dtatulea@nvidia.com>=
 wrote:
>
> mlx5_vdpa_err() was missing. This patch adds it and uses it in the
> necessary places.
>
> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> Reviewed-by: Tariq Toukan <tariqt@nvidia.com>

Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

> ---
>  drivers/vdpa/mlx5/core/mlx5_vdpa.h |  5 +++++
>  drivers/vdpa/mlx5/net/mlx5_vnet.c  | 24 ++++++++++++------------
>  2 files changed, 17 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/vdpa/mlx5/core/mlx5_vdpa.h b/drivers/vdpa/mlx5/core/=
mlx5_vdpa.h
> index 50aac8fe57ef..424d445ebee4 100644
> --- a/drivers/vdpa/mlx5/core/mlx5_vdpa.h
> +++ b/drivers/vdpa/mlx5/core/mlx5_vdpa.h
> @@ -135,6 +135,11 @@ int mlx5_vdpa_update_cvq_iotlb(struct mlx5_vdpa_dev =
*mvdev,
>  int mlx5_vdpa_create_dma_mr(struct mlx5_vdpa_dev *mvdev);
>  int mlx5_vdpa_reset_mr(struct mlx5_vdpa_dev *mvdev, unsigned int asid);
>
> +#define mlx5_vdpa_err(__dev, format, ...)                               =
                           \
> +       dev_err((__dev)->mdev->device, "%s:%d:(pid %d) error: " format, _=
_func__, __LINE__,        \
> +                current->pid, ##__VA_ARGS__)
> +
> +
>  #define mlx5_vdpa_warn(__dev, format, ...)                              =
                           \
>         dev_warn((__dev)->mdev->device, "%s:%d:(pid %d) warning: " format=
, __func__, __LINE__,     \
>                  current->pid, ##__VA_ARGS__)
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/ml=
x5_vnet.c
> index fa78e8288ebb..12133e5d1285 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -1538,13 +1538,13 @@ static int suspend_vq(struct mlx5_vdpa_net *ndev,=
 struct mlx5_vdpa_virtqueue *mv
>
>         err =3D modify_virtqueue_state(ndev, mvq, MLX5_VIRTIO_NET_Q_OBJEC=
T_STATE_SUSPEND);
>         if (err) {
> -               mlx5_vdpa_warn(&ndev->mvdev, "modify to suspend failed, e=
rr: %d\n", err);
> +               mlx5_vdpa_err(&ndev->mvdev, "modify to suspend failed, er=
r: %d\n", err);
>                 return err;
>         }
>
>         err =3D query_virtqueue(ndev, mvq, &attr);
>         if (err) {
> -               mlx5_vdpa_warn(&ndev->mvdev, "failed to query virtqueue, =
err: %d\n", err);
> +               mlx5_vdpa_err(&ndev->mvdev, "failed to query virtqueue, e=
rr: %d\n", err);
>                 return err;
>         }
>
> @@ -1585,7 +1585,7 @@ static int resume_vq(struct mlx5_vdpa_net *ndev, st=
ruct mlx5_vdpa_virtqueue *mvq
>                  */
>                 err =3D modify_virtqueue(ndev, mvq, 0);
>                 if (err) {
> -                       mlx5_vdpa_warn(&ndev->mvdev,
> +                       mlx5_vdpa_err(&ndev->mvdev,
>                                 "modify vq properties failed for vq %u, e=
rr: %d\n",
>                                 mvq->index, err);
>                         return err;
> @@ -1600,15 +1600,15 @@ static int resume_vq(struct mlx5_vdpa_net *ndev, =
struct mlx5_vdpa_virtqueue *mvq
>         case MLX5_VIRTIO_NET_Q_OBJECT_STATE_RDY:
>                 return 0;
>         default:
> -               mlx5_vdpa_warn(&ndev->mvdev, "resume vq %u called from ba=
d state %d\n",
> +               mlx5_vdpa_err(&ndev->mvdev, "resume vq %u called from bad=
 state %d\n",
>                                mvq->index, mvq->fw_state);
>                 return -EINVAL;
>         }
>
>         err =3D modify_virtqueue_state(ndev, mvq, MLX5_VIRTIO_NET_Q_OBJEC=
T_STATE_RDY);
>         if (err)
> -               mlx5_vdpa_warn(&ndev->mvdev, "modify to resume failed for=
 vq %u, err: %d\n",
> -                              mvq->index, err);
> +               mlx5_vdpa_err(&ndev->mvdev, "modify to resume failed for =
vq %u, err: %d\n",
> +                             mvq->index, err);
>
>         return err;
>  }
> @@ -2002,13 +2002,13 @@ static int setup_steering(struct mlx5_vdpa_net *n=
dev)
>
>         ns =3D mlx5_get_flow_namespace(ndev->mvdev.mdev, MLX5_FLOW_NAMESP=
ACE_BYPASS);
>         if (!ns) {
> -               mlx5_vdpa_warn(&ndev->mvdev, "failed to get flow namespac=
e\n");
> +               mlx5_vdpa_err(&ndev->mvdev, "failed to get flow namespace=
\n");
>                 return -EOPNOTSUPP;
>         }
>
>         ndev->rxft =3D mlx5_create_auto_grouped_flow_table(ns, &ft_attr);
>         if (IS_ERR(ndev->rxft)) {
> -               mlx5_vdpa_warn(&ndev->mvdev, "failed to create flow table=
\n");
> +               mlx5_vdpa_err(&ndev->mvdev, "failed to create flow table\=
n");
>                 return PTR_ERR(ndev->rxft);
>         }
>         mlx5_vdpa_add_rx_flow_table(ndev);
> @@ -2530,7 +2530,7 @@ static int mlx5_vdpa_get_vq_state(struct vdpa_devic=
e *vdev, u16 idx, struct vdpa
>
>         err =3D query_virtqueue(ndev, mvq, &attr);
>         if (err) {
> -               mlx5_vdpa_warn(mvdev, "failed to query virtqueue\n");
> +               mlx5_vdpa_err(mvdev, "failed to query virtqueue\n");
>                 return err;
>         }
>         state->split.avail_index =3D attr.used_index;
> @@ -3189,7 +3189,7 @@ static int mlx5_vdpa_compat_reset(struct vdpa_devic=
e *vdev, u32 flags)
>         if ((flags & VDPA_RESET_F_CLEAN_MAP) &&
>             MLX5_CAP_GEN(mvdev->mdev, umem_uid_0)) {
>                 if (mlx5_vdpa_create_dma_mr(mvdev))
> -                       mlx5_vdpa_warn(mvdev, "create MR failed\n");
> +                       mlx5_vdpa_err(mvdev, "create MR failed\n");
>         }
>         if (vq_reset)
>                 setup_vq_resources(ndev, false);
> @@ -3244,7 +3244,7 @@ static int set_map_data(struct mlx5_vdpa_dev *mvdev=
, struct vhost_iotlb *iotlb,
>                 new_mr =3D mlx5_vdpa_create_mr(mvdev, iotlb);
>                 if (IS_ERR(new_mr)) {
>                         err =3D PTR_ERR(new_mr);
> -                       mlx5_vdpa_warn(mvdev, "create map failed(%d)\n", =
err);
> +                       mlx5_vdpa_err(mvdev, "create map failed(%d)\n", e=
rr);
>                         return err;
>                 }
>         } else {
> @@ -3257,7 +3257,7 @@ static int set_map_data(struct mlx5_vdpa_dev *mvdev=
, struct vhost_iotlb *iotlb,
>         } else {
>                 err =3D mlx5_vdpa_change_map(mvdev, new_mr, asid);
>                 if (err) {
> -                       mlx5_vdpa_warn(mvdev, "change map failed(%d)\n", =
err);
> +                       mlx5_vdpa_err(mvdev, "change map failed(%d)\n", e=
rr);
>                         goto out_err;
>                 }
>         }
> --
> 2.45.2
>


