Return-Path: <linux-kernel+bounces-220893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D76D90E8C2
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 12:56:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9686CB23547
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 10:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9030F13213C;
	Wed, 19 Jun 2024 10:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Kyq3RRzv"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72B784D8B2
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 10:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718794558; cv=none; b=PuppAvMNDvzbj5nqtCOZ3qGZHFJ6PirWrjPwnUSM6kylrQljI0Gn+xn75U5ayn48WNb4WKduGO8Rv0l//+R6JsCp808/nZhRMOSB4RcW8A54o7SQaka9X4jA7+bzvU7rbeb0HQH+6HkStAbgyU29L8Wf1NrOFSJ0xXkja8fuJhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718794558; c=relaxed/simple;
	bh=kGxMAaJvLmfXkBIK3NGXhSRM0AwoYHtsGbNLEE0bnpY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bcvmBUrMkpbg+sSdWLxwgBBHXxSpPkqy/o2JN8nWp+8yhqsgjdEQ1Ewt07A1GthW3nNalvXVYUCAxjacMyC9SyKuCvXnF9MxJ1BrKUHgS0QWOnCyfsqmN8CIEHGMkjM/Tg2Ah+k7MDii/RBYpklQdtNvSaq+QUZClBiq1gyCR0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Kyq3RRzv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718794555;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mOO5ZSP3WLU9Q7oAH7CvSIrRzVR6QPgru4zl8xC0EsM=;
	b=Kyq3RRzvAQoiGk8i8GKOhLyFdurooJHfq+ALjKJSHAnTHSOccX/pWPVV3Mzw4hAfl4ylEL
	TbKnnerlslU1kLmW7WIkv8Iwda0WP2+vGjc5sV9mk5HIPcYX8ddAEHDqlzXPtuaZG4Od0/
	kNIr27EFQJvgT/ddhsdMMeeF50TCnvA=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-605-cWvsySWYNNK0uNbZ9ZstNA-1; Wed, 19 Jun 2024 06:55:54 -0400
X-MC-Unique: cWvsySWYNNK0uNbZ9ZstNA-1
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-62fb4a1f7bfso145651907b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 03:55:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718794553; x=1719399353;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mOO5ZSP3WLU9Q7oAH7CvSIrRzVR6QPgru4zl8xC0EsM=;
        b=u/K3pxReJ+l0SNy4+gov5I68HQyX6UYIbHWW/d9LPMFXZg9a1t75F7eONuK0k1DNrn
         i/CPvtuSgvfviYaTuCjNQY/DbYty6onZfSyZtVxnhp+ncoTQRG4Jh4LVDKzNYLEN0PCU
         mrjTbCSW1PkKCMzjILYXjDRXSLc19/RbCVGqH+kKGp5f9gPvbGDhKFfaF5f9bHWNsums
         eoJlFrLYO/rgfIM263/OLlyKHbNWm5J7SnYcWPsbY3uiPJJ5/2feV0m3sKRJUm2cbAll
         oPLindPG7pRc45A3FfWIpk642nqvkiEMObFZ3k8z/Tw+DppEdas0Fqhw/60mrRm1nR5C
         OsiQ==
X-Forwarded-Encrypted: i=1; AJvYcCW6WoxSDC9DVYONvnYtC7hWhDkhbjCtIw42hs3+Whick3vKhtNgLmEp2ONlot2OLs96DIRatMyfa+Ak9MyNIL8uIGPhUyWShXBn0V4F
X-Gm-Message-State: AOJu0Yzr+8giMEu797p7ljOuNfaTc2o6ccoqBVWar1YCKb1rbIMkZpHa
	7ZWDw8OoYOIHuH/AxAxVjgq/42kkeq4/O7fTK7rPZRkOekiDNaG7bH9SLWkBC2kseCjWl3DrU40
	T9YC+xlpI1alJu+YQRmJ/l5wzQShINkhsuZnc2qhYe82yeiDo+49s/rnXUTOGXUQul7wQ1COfV/
	mH8k8SKmAd5blIDiCKbi0Qoj9hPvi26DsvlmYm
X-Received: by 2002:a81:9144:0:b0:627:a7d7:6d76 with SMTP id 00721157ae682-63a8f6196cfmr23423237b3.39.1718794553599;
        Wed, 19 Jun 2024 03:55:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFvxPUUYPpg9QjOGGTil9Q0vxhLdibJM9rIX47lCpLHxV4IIFiJXXL5B/tBGDpyegeZIjHDn8kj0g1taUiWYss=
X-Received: by 2002:a81:9144:0:b0:627:a7d7:6d76 with SMTP id
 00721157ae682-63a8f6196cfmr23423047b3.39.1718794553297; Wed, 19 Jun 2024
 03:55:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240617-stage-vdpa-vq-precreate-v1-0-8c0483f0ca2a@nvidia.com> <20240617-stage-vdpa-vq-precreate-v1-3-8c0483f0ca2a@nvidia.com>
In-Reply-To: <20240617-stage-vdpa-vq-precreate-v1-3-8c0483f0ca2a@nvidia.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 19 Jun 2024 12:55:17 +0200
Message-ID: <CAJaqyWdWSbua3HJaAHP0vetugyy5-ryAD8d-z-Xi26VQXiRSiA@mail.gmail.com>
Subject: Re: [PATCH vhost 03/23] vdpa/mlx5: Drop redundant code
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

Patch message suggestion:
Originally, the second loop initialized the CVQ. But (acde3929492b
("vdpa/mlx5: Use consistent RQT size") initialized all the queues in
the first loop, so the second iteration in ...

>
> The second iteration in init_mvqs() is never called because the first
> one will iterate up to max_vqs.
>

Either way,

Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
> ---
>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 6 ------
>  1 file changed, 6 deletions(-)
>
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/ml=
x5_vnet.c
> index 1ad281cbc541..b4d9ef4f66c8 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -3519,12 +3519,6 @@ static void init_mvqs(struct mlx5_vdpa_net *ndev)
>                 mvq->fwqp.fw =3D true;
>                 mvq->fw_state =3D MLX5_VIRTIO_NET_Q_OBJECT_NONE;
>         }
> -       for (; i < ndev->mvdev.max_vqs; i++) {
> -               mvq =3D &ndev->vqs[i];
> -               memset(mvq, 0, offsetof(struct mlx5_vdpa_virtqueue, ri));
> -               mvq->index =3D i;
> -               mvq->ndev =3D ndev;
> -       }
>  }
>
>  struct mlx5_vdpa_mgmtdev {
>
> --
> 2.45.1
>


