Return-Path: <linux-kernel+bounces-220903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14E6790E8F1
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 13:05:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BC5C28429A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 11:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58654139583;
	Wed, 19 Jun 2024 11:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HSE2wCkS"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53DA513211E
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 11:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718795120; cv=none; b=bAjI/pP/sAe5PhmeNU2qns5M2z9fPQsCf1Rx6zzh+dr6jErdxf1pjZNYtQHVtKCCvFwVr7HPChjD0qqj30Pxc8xmHw74ze694KXDv6Z1E3k1i4jML+lq8h+hnYEfnmALKgUuwjgy0DvguBOU9u3MwPV9XwTaiFnsxePozugskfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718795120; c=relaxed/simple;
	bh=0dRR5aTDWvDECUZeTACFItq3dlsdteCaVW0/xAz+trc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S0O80wghqR1HgF8Xhrwv9HAYwaJNmkubFBmti4qAldIX5bCEDCqjsGpTFtkUC973DnGxT7saZREQnZ/ks+ei+6pUIrugcb+8HEd9JaoDYF6JjbraPwAax8kuhSqcC6ZRilGAXjnS0N9fWpprg+4DrIbEIPoCsWTHmkNMkwX6tr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HSE2wCkS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718795118;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zDjyaWl/Y5cyCdQUhzIAoRmk8UfpGo+tEe8x0hJrdZo=;
	b=HSE2wCkSHTauQQmV0G8AULnTYtHZVFfrpkL4K/ewTkh7IttxbE8j2zFcM1mMMzOTAJEzE4
	KbAjMyYw2WbJvW05ZtemhBUbCRh8b1QFzIYU/poI9T8WEObXnkMtK9mbJIcUvwOIDOOwSl
	pfOLs+rnyI1uKPyV7TaoYMAGUpQVhA0=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-634-jfnv0QXXMw6uhjS247bGQg-1; Wed, 19 Jun 2024 07:05:15 -0400
X-MC-Unique: jfnv0QXXMw6uhjS247bGQg-1
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-62f4a831dd8so118299617b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 04:05:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718795114; x=1719399914;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zDjyaWl/Y5cyCdQUhzIAoRmk8UfpGo+tEe8x0hJrdZo=;
        b=xRSQxy/Iwl9xp27VFyBJTm/F/AcM91Z+ZBgs/8HFTuZeVaaHOHTy9RcQ7xsj08FKlx
         RuUVQ0q+gqnA27myDvGJVLNtAYWoYdlWfo013jqHWD6LbymzsvpTT0rklTLT38EVqvMD
         MXI61fv1V0Dfb9QiJjGsNNKGSwDvkqkwqPnJOPxMLbl3zSHajDruVStd4VHvo8basclk
         JX0HYikTJjQyCGVNGSuk+yx6jEWqQ0QX0rf8f6Oh/mhpoaIbApqFZMZl8/W771GHT8I4
         BSmIDlaae60ucllsCbtgDepk3WxVS1wsOfILdBw+/jttl4YQTyflfagpHTQLM+E5R2V+
         XW/g==
X-Forwarded-Encrypted: i=1; AJvYcCUNbE74mMEbMzK6b4fMBGFtSPaEvyIoPOYHmugw5jMrtwY575kZQMIPtyk7Ln5iFnVivQZD0qkL5zJ7yK1JSWP3/ZnOygHa/CTFpVhO
X-Gm-Message-State: AOJu0YzAC3SY9TgGVfCfam6RDre0uYF9ATT4feoD8p0q/fc7udUC2wYI
	Dz0ekZKA9C9tNmVULd5BSPelw97e3b0OcOWjzdy3/29dEtujUYAqEc1RtmPJM54BL/BPZqnaBel
	7NCm3YmXNEXO9Lj/FxlCmisI1IlngPn+WTjgW/buYlxO7elTDwGgC8HYkXduEEkohxZajRKLV+z
	l9pj/WNlcaX/d/RFos9K5w5sGwRbNZvPIMEBNL
X-Received: by 2002:a81:c602:0:b0:631:2ebf:b8dc with SMTP id 00721157ae682-63a8dc0792amr23261717b3.4.1718795114364;
        Wed, 19 Jun 2024 04:05:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEJ6Lahkzgb076y8mwVE/rW64T5ZHzTRWqaXRb1RvSZblvaEByNxDwfUmyzdSIeGCQH2jJ+ANLd7BBvZ34oULM=
X-Received: by 2002:a81:c602:0:b0:631:2ebf:b8dc with SMTP id
 00721157ae682-63a8dc0792amr23261497b3.4.1718795114089; Wed, 19 Jun 2024
 04:05:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240617-stage-vdpa-vq-precreate-v1-0-8c0483f0ca2a@nvidia.com> <20240617-stage-vdpa-vq-precreate-v1-5-8c0483f0ca2a@nvidia.com>
In-Reply-To: <20240617-stage-vdpa-vq-precreate-v1-5-8c0483f0ca2a@nvidia.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 19 Jun 2024 13:04:38 +0200
Message-ID: <CAJaqyWfXe9+KTzucF6YsBXOzCkJL0_w-n7PUih_j43hMAgMX4A@mail.gmail.com>
Subject: Re: [PATCH vhost 05/23] vdpa/mlx5: Iterate over active VQs during suspend/resume
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
> No need to iterate over max number of VQs.
>
> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>

Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

> ---
>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/ml=
x5_vnet.c
> index 96782b34e2b2..51630b1935f4 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -1504,7 +1504,7 @@ static void suspend_vqs(struct mlx5_vdpa_net *ndev)
>  {
>         int i;
>
> -       for (i =3D 0; i < ndev->mvdev.max_vqs; i++)
> +       for (i =3D 0; i < ndev->cur_num_vqs; i++)
>                 suspend_vq(ndev, &ndev->vqs[i]);
>  }
>
> @@ -1522,7 +1522,7 @@ static void resume_vq(struct mlx5_vdpa_net *ndev, s=
truct mlx5_vdpa_virtqueue *mv
>
>  static void resume_vqs(struct mlx5_vdpa_net *ndev)
>  {
> -       for (int i =3D 0; i < ndev->mvdev.max_vqs; i++)
> +       for (int i =3D 0; i < ndev->cur_num_vqs; i++)
>                 resume_vq(ndev, &ndev->vqs[i]);
>  }
>
>
> --
> 2.45.1
>


