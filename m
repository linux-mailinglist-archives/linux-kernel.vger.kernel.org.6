Return-Path: <linux-kernel+bounces-221343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EC45590F238
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 17:34:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E0AF1C214D0
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 15:34:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DE7514F9F9;
	Wed, 19 Jun 2024 15:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Kzi6K1O9"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6644A612EB
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 15:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718811270; cv=none; b=qG77yfYJga+N49J8HgDLKaN8TT01tRmIQX+xknZfriBGyh2MLEjkIlnCVn3mIM8E7evbFIAVNsMHSCMm6CIAM//C5Pu4qjnc7yGZvbpRPVUDKd31PHQ+h6SCtgV9+vKL7AjfhAZmKvKt7NBSgE8jAhFt9ySalnulo1SfhAX6r7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718811270; c=relaxed/simple;
	bh=SyZw5x3PrOSKjnuwYIruwizBz8S5XAWHURMQrf+hBZw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DRRtMtnjLFzLkigRYgjA1ZPUm991OTpjHvFN7mXHB3bp1bDSjPCN2U2Pt9zYuyZlNbyvXMNBbTRE3R/U2hSHOfiW2ISC+m9pPkBF5/b/M35P0jzeVZQsF7YAMKkGtYYTLEFSf4tvkAuJlaeerMbKm1gpBKkqppN/5PbCQbD5Cbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Kzi6K1O9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718811268;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3Z6cd0gXeCDMqMe2Sn9JeYqUvzxkN6ZqxSbh48wbjqY=;
	b=Kzi6K1O9yXJb1m6XtlaMYhs/zM5WPpGhHbbpndbNeLT/lWBuEMB0P1RbJuaBEcLwRZDdHS
	Ax4RKE6fWSFSGxxUNKdHNsgKIlUhQAuy5vdImge7e/2DP6kwu6KkZiW/ppUX7yeVpDcrnP
	vYSVEdlj5ff51h7q+1NKpxg+RIcKBYY=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-65-5ghKo0okMRulV14T5BxnxQ-1; Wed, 19 Jun 2024 11:34:27 -0400
X-MC-Unique: 5ghKo0okMRulV14T5BxnxQ-1
Received: by mail-yb1-f197.google.com with SMTP id 3f1490d57ef6-dfe4f388d33so12579102276.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 08:34:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718811266; x=1719416066;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3Z6cd0gXeCDMqMe2Sn9JeYqUvzxkN6ZqxSbh48wbjqY=;
        b=pq544pTDxhF/14/EcolhjhgHulorJTPplNiVN7dB1aEIpWJacWR0jfQqby522nYEhq
         7HWMVBBRmZa8q8S6S6bADJEGt/JF7+fkfyBvPPFcVso68Hg49cagy/R3aMxWeEGrbGiC
         +MoG98nQnkZEHgGQ9CmexyYvmlVJXpNrU3P0sYR3MWli7b6WMudyN1GRuJQgWl3f8uEB
         TcM59bhKMvv9icjjxg865x36wJ9gdW8fVVFaDyHtxoE2FzAHXh1lppSmlOo4qU/UiORu
         oP5bfy05ZULpglPBqrgWxIRHnpgod0Nx/m1VPC5eu5yoOi9T6wKzlcApjGQ6rkuo0yf9
         f40A==
X-Forwarded-Encrypted: i=1; AJvYcCWz+8TEU0jzxNd30/jnNztEc0C1nnE8KS4vtZsMGvTV0sm5AIah4NlTzJ0SorXug2rgj4A14vJXRw8R0Zjgcp0ji01djaEKSS0raB7j
X-Gm-Message-State: AOJu0YwDdKbfkEwNuGUm+XCnLPkKT6ilE2E8CoAuoPXnjAJW/jYg1Ukz
	Kc7QAkzSRD9xyCDe8nAlPeu/Aujo7oYseADCzeZfWidRBAZpnTu9b39L0KFftnDKp5xz4B7Pti0
	Ag48ha2DypxC8eqCBi7EdbIEnG3CflseJBbgSAzj1uZgBjfE1dGhlFtwm3uYtxo8MCMcpYOTGS9
	CYJtmI75/NI4TaEqlZCvAnTNvqwoziLBbBHU2d
X-Received: by 2002:a25:6ac5:0:b0:dfe:148f:114f with SMTP id 3f1490d57ef6-e02be16c2acmr2786990276.27.1718811266505;
        Wed, 19 Jun 2024 08:34:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFUWTR+p1MQws1i/MEYEjVgKq/tSc0AqXDfYlDvxq3BQdTNeJcL/NDUPxxwDuKICtSuQJkzJRGB/bJCvMMgtB0=
X-Received: by 2002:a25:6ac5:0:b0:dfe:148f:114f with SMTP id
 3f1490d57ef6-e02be16c2acmr2786967276.27.1718811266146; Wed, 19 Jun 2024
 08:34:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240617-stage-vdpa-vq-precreate-v1-0-8c0483f0ca2a@nvidia.com> <20240617-stage-vdpa-vq-precreate-v1-13-8c0483f0ca2a@nvidia.com>
In-Reply-To: <20240617-stage-vdpa-vq-precreate-v1-13-8c0483f0ca2a@nvidia.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 19 Jun 2024 17:33:50 +0200
Message-ID: <CAJaqyWc7B5BA31nMDotNQuWv19CAK2kcDKTZjTy_ODLHP2FMZw@mail.gmail.com>
Subject: Re: [PATCH vhost 13/23] vdpa/mlx5: Set mkey modified flags on all VQs
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
> Otherwise, when virtqueues are moved from INIT to READY the latest mkey
> will not be set appropriately.
>
> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>

Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

> ---
>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/ml=
x5_vnet.c
> index 0201c6fe61e1..0abe01fd20e9 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -2868,7 +2868,7 @@ static int mlx5_vdpa_change_map(struct mlx5_vdpa_de=
v *mvdev,
>
>         mlx5_vdpa_update_mr(mvdev, new_mr, asid);
>
> -       for (int i =3D 0; i < ndev->cur_num_vqs; i++)
> +       for (int i =3D 0; i < mvdev->max_vqs; i++)
>                 ndev->vqs[i].modified_fields |=3D MLX5_VIRTQ_MODIFY_MASK_=
VIRTIO_Q_MKEY |
>                                                 MLX5_VIRTQ_MODIFY_MASK_DE=
SC_GROUP_MKEY;
>
>
> --
> 2.45.1
>


