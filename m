Return-Path: <linux-kernel+bounces-307092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A994964828
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 16:24:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4BF94B29858
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 14:19:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A78561AED4D;
	Thu, 29 Aug 2024 14:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SVnnjGCe"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 115F11AE864
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 14:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724941128; cv=none; b=W/fP0QPDwnHJKO2x/JjJJ6cIWjrn6Q7LPIwQBPDoqzz/QKlXl/enohC2zaHsMT0NcSOZ2PAEHZI7Gd9eE2/SwRoZfv2f5sZTkF3+nBjbzejErvSOfNNgBDAFQYepA4oK5sKZRw52pbWa9sL79xMZikkNx5zzppIXSbpaA5FBHJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724941128; c=relaxed/simple;
	bh=xJNP5vrR8GfpfLwJtjfUAKx5jsEgeVULY0gNeKS3n1o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HpNn1u9ZlonBQDNZi9nWAA8U0OFQYoPLUTSmZJoVsN8VEjLJc1VJgOfacCNIAf9sr4/2Q/5ZZQ6DXbP940h+CvShrGxVAVETetdKi8/DWqzq8v0hBPLeh9BkplHxSIRqxauOY/40u3DnRz/10ocRuTGq+eHNEEImrpjLG7u75bE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SVnnjGCe; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724941125;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jYrWURiNhNxaDhZpfvFbKbwERayt+0+/jmKfxf9PB4c=;
	b=SVnnjGCe5W1ly9R6QASJRfe21JCfR65LSfC2Vu36ENBizvJ+L75g7FJzfwx9GkDfa2NJEv
	OIk8jwIXtVWu36ho+APbsWiRKXDgF0t9QN2u2AN490WBfMgsvJeW3BbK46sTE5KxMr+nQJ
	rXMUOm5pZiphx79dU4zZJrP5iJ+Ozts=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-672-s_iWw3naOXW-V7UAIT931Q-1; Thu, 29 Aug 2024 10:18:44 -0400
X-MC-Unique: s_iWw3naOXW-V7UAIT931Q-1
Received: by mail-yb1-f199.google.com with SMTP id 3f1490d57ef6-e02a4de4f4eso1432387276.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 07:18:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724941124; x=1725545924;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jYrWURiNhNxaDhZpfvFbKbwERayt+0+/jmKfxf9PB4c=;
        b=xUJFVI1oivPjsZ/maPrv9rcorXXNVfMN7wZkjTqVfJ7I5c2PSfPu/qHHSk5ooNLLeJ
         9at2O23tQzc/bFC29dTxa4gqyK2BXwCTuuKhGbTS8AkwKarqz41WDSVIsZZCXosKDhNS
         VPyDO4KCtIrODQGm6HhThDT9QaeTMEErplOzPJzSeBO76HnfMYuyouO9l629nMQMxaw5
         8iaNJiRQ9/3AgEa5Sxi0AtHFFUMBrkd72E6oOt30zZ8SRmVzYRy0woSy+kRA+Qc+Gqa8
         SuJhgZcHg1O/BT3kBWXzELDWJ9tvlc8FRYhX9d2qIJ6q/r3dq9DFU2uTBr/GxgOVvyX0
         ImBw==
X-Forwarded-Encrypted: i=1; AJvYcCWf2ysWI6G6nMlptn75IEydQMS8RmQZkQUCBMOAiG8FDAlfSKqHXebl9HwNmnBaRKR5QLchhf0RTpj+aYM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCqmQE5EqZaMaX8Gfk/RdATOCt3Ulpg7xnx91DtJ+osfLWrjxo
	tOa3fqUe/9FuUPDBQdl38BI1sbGncT8OMOYb1FG48bHuv7nHzPubFekeelVAjblh/CpsmaJMJrG
	BFQLBDxpKlEk0X/bMe3AiedUmXZXwdEXgkWDuLlhp5Yx1lZNqFuiqfBmReID62y02CwG/xX94lG
	sc5bFY+VNIYFOY3DD8FoPW6odMhixTBZqqxARA
X-Received: by 2002:a05:6902:260b:b0:e0b:6bb1:fba with SMTP id 3f1490d57ef6-e1a5ac957efmr2795159276.30.1724941124214;
        Thu, 29 Aug 2024 07:18:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEpF1PqlLutsjoAOxniJsGr7lS0v1cnWucZnw8FQwcS+ipQsyyw6OmZ1K70s0kquo8STj73Yc8uL2QRZq4gFvo=
X-Received: by 2002:a05:6902:260b:b0:e0b:6bb1:fba with SMTP id
 3f1490d57ef6-e1a5ac957efmr2795125276.30.1724941123845; Thu, 29 Aug 2024
 07:18:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240821114100.2261167-2-dtatulea@nvidia.com> <20240821114100.2261167-7-dtatulea@nvidia.com>
In-Reply-To: <20240821114100.2261167-7-dtatulea@nvidia.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Thu, 29 Aug 2024 16:18:08 +0200
Message-ID: <CAJaqyWfCeAmx7cZ49PCxwRmCFnS7cXigO294rLG7OtJNaaGqnQ@mail.gmail.com>
Subject: Re: [PATCH vhost 5/7] vdpa/mlx5: Rename mr_mtx -> lock
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Si-Wei Liu <si-wei.liu@oracle.com>, virtualization@lists.linux-foundation.org, 
	Gal Pressman <gal@nvidia.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Parav Pandit <parav@nvidia.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Cosmin Ratiu <cratiu@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 21, 2024 at 1:42=E2=80=AFPM Dragos Tatulea <dtatulea@nvidia.com=
> wrote:
>
> Now that the mr resources have their own namespace in the
> struct, give the lock a clearer name.
>
> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>

Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

> ---
>  drivers/vdpa/mlx5/core/mlx5_vdpa.h |  2 +-
>  drivers/vdpa/mlx5/core/mr.c        | 20 ++++++++++----------
>  drivers/vdpa/mlx5/core/resources.c |  6 +++---
>  drivers/vdpa/mlx5/net/mlx5_vnet.c  |  4 ++--
>  4 files changed, 16 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/vdpa/mlx5/core/mlx5_vdpa.h b/drivers/vdpa/mlx5/core/=
mlx5_vdpa.h
> index 5ae6deea2a8a..89b564cecddf 100644
> --- a/drivers/vdpa/mlx5/core/mlx5_vdpa.h
> +++ b/drivers/vdpa/mlx5/core/mlx5_vdpa.h
> @@ -87,7 +87,7 @@ struct mlx5_vdpa_mr_resources {
>         struct mlx5_vdpa_mr *mr[MLX5_VDPA_NUM_AS];
>         unsigned int group2asid[MLX5_VDPA_NUMVQ_GROUPS];
>         struct list_head mr_list_head;
> -       struct mutex mr_mtx;
> +       struct mutex lock;
>  };
>
>  struct mlx5_vdpa_dev {
> diff --git a/drivers/vdpa/mlx5/core/mr.c b/drivers/vdpa/mlx5/core/mr.c
> index 2c8660e5c0de..f20f2a8a701d 100644
> --- a/drivers/vdpa/mlx5/core/mr.c
> +++ b/drivers/vdpa/mlx5/core/mr.c
> @@ -666,9 +666,9 @@ static void _mlx5_vdpa_put_mr(struct mlx5_vdpa_dev *m=
vdev,
>  void mlx5_vdpa_put_mr(struct mlx5_vdpa_dev *mvdev,
>                       struct mlx5_vdpa_mr *mr)
>  {
> -       mutex_lock(&mvdev->mres.mr_mtx);
> +       mutex_lock(&mvdev->mres.lock);
>         _mlx5_vdpa_put_mr(mvdev, mr);
> -       mutex_unlock(&mvdev->mres.mr_mtx);
> +       mutex_unlock(&mvdev->mres.lock);
>  }
>
>  static void _mlx5_vdpa_get_mr(struct mlx5_vdpa_dev *mvdev,
> @@ -683,9 +683,9 @@ static void _mlx5_vdpa_get_mr(struct mlx5_vdpa_dev *m=
vdev,
>  void mlx5_vdpa_get_mr(struct mlx5_vdpa_dev *mvdev,
>                       struct mlx5_vdpa_mr *mr)
>  {
> -       mutex_lock(&mvdev->mres.mr_mtx);
> +       mutex_lock(&mvdev->mres.lock);
>         _mlx5_vdpa_get_mr(mvdev, mr);
> -       mutex_unlock(&mvdev->mres.mr_mtx);
> +       mutex_unlock(&mvdev->mres.lock);
>  }
>
>  void mlx5_vdpa_update_mr(struct mlx5_vdpa_dev *mvdev,
> @@ -694,19 +694,19 @@ void mlx5_vdpa_update_mr(struct mlx5_vdpa_dev *mvde=
v,
>  {
>         struct mlx5_vdpa_mr *old_mr =3D mvdev->mres.mr[asid];
>
> -       mutex_lock(&mvdev->mres.mr_mtx);
> +       mutex_lock(&mvdev->mres.lock);
>
>         _mlx5_vdpa_put_mr(mvdev, old_mr);
>         mvdev->mres.mr[asid] =3D new_mr;
>
> -       mutex_unlock(&mvdev->mres.mr_mtx);
> +       mutex_unlock(&mvdev->mres.lock);
>  }
>
>  static void mlx5_vdpa_show_mr_leaks(struct mlx5_vdpa_dev *mvdev)
>  {
>         struct mlx5_vdpa_mr *mr;
>
> -       mutex_lock(&mvdev->mres.mr_mtx);
> +       mutex_lock(&mvdev->mres.lock);
>
>         list_for_each_entry(mr, &mvdev->mres.mr_list_head, mr_list) {
>
> @@ -715,7 +715,7 @@ static void mlx5_vdpa_show_mr_leaks(struct mlx5_vdpa_=
dev *mvdev)
>                                        mr, mr->mkey, refcount_read(&mr->r=
efcount));
>         }
>
> -       mutex_unlock(&mvdev->mres.mr_mtx);
> +       mutex_unlock(&mvdev->mres.lock);
>
>  }
>
> @@ -779,9 +779,9 @@ struct mlx5_vdpa_mr *mlx5_vdpa_create_mr(struct mlx5_=
vdpa_dev *mvdev,
>         if (!mr)
>                 return ERR_PTR(-ENOMEM);
>
> -       mutex_lock(&mvdev->mres.mr_mtx);
> +       mutex_lock(&mvdev->mres.lock);
>         err =3D _mlx5_vdpa_create_mr(mvdev, mr, iotlb);
> -       mutex_unlock(&mvdev->mres.mr_mtx);
> +       mutex_unlock(&mvdev->mres.lock);
>
>         if (err)
>                 goto out_err;
> diff --git a/drivers/vdpa/mlx5/core/resources.c b/drivers/vdpa/mlx5/core/=
resources.c
> index 3e3b3049cb08..fe2ca3458f6c 100644
> --- a/drivers/vdpa/mlx5/core/resources.c
> +++ b/drivers/vdpa/mlx5/core/resources.c
> @@ -256,7 +256,7 @@ int mlx5_vdpa_alloc_resources(struct mlx5_vdpa_dev *m=
vdev)
>                 mlx5_vdpa_warn(mvdev, "resources already allocated\n");
>                 return -EINVAL;
>         }
> -       mutex_init(&mvdev->mres.mr_mtx);
> +       mutex_init(&mvdev->mres.lock);
>         res->uar =3D mlx5_get_uars_page(mdev);
>         if (IS_ERR(res->uar)) {
>                 err =3D PTR_ERR(res->uar);
> @@ -301,7 +301,7 @@ int mlx5_vdpa_alloc_resources(struct mlx5_vdpa_dev *m=
vdev)
>  err_uctx:
>         mlx5_put_uars_page(mdev, res->uar);
>  err_uars:
> -       mutex_destroy(&mvdev->mres.mr_mtx);
> +       mutex_destroy(&mvdev->mres.lock);
>         return err;
>  }
>
> @@ -318,7 +318,7 @@ void mlx5_vdpa_free_resources(struct mlx5_vdpa_dev *m=
vdev)
>         dealloc_pd(mvdev, res->pdn, res->uid);
>         destroy_uctx(mvdev, res->uid);
>         mlx5_put_uars_page(mvdev->mdev, res->uar);
> -       mutex_destroy(&mvdev->mres.mr_mtx);
> +       mutex_destroy(&mvdev->mres.lock);
>         res->valid =3D false;
>  }
>
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/ml=
x5_vnet.c
> index 3e55a7f1afcd..8a51c492a62a 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -3639,10 +3639,10 @@ static int mlx5_set_group_asid(struct vdpa_device=
 *vdev, u32 group,
>
>         mvdev->mres.group2asid[group] =3D asid;
>
> -       mutex_lock(&mvdev->mres.mr_mtx);
> +       mutex_lock(&mvdev->mres.lock);
>         if (group =3D=3D MLX5_VDPA_CVQ_GROUP && mvdev->mres.mr[asid])
>                 err =3D mlx5_vdpa_update_cvq_iotlb(mvdev, mvdev->mres.mr[=
asid]->iotlb, asid);
> -       mutex_unlock(&mvdev->mres.mr_mtx);
> +       mutex_unlock(&mvdev->mres.lock);
>
>         return err;
>  }
> --
> 2.45.1
>


