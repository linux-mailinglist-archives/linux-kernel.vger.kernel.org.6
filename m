Return-Path: <linux-kernel+bounces-221451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1C9090F3CD
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 18:15:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79E1828164D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 16:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E4E1152787;
	Wed, 19 Jun 2024 16:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eHB/Dz8o"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BF1214373A
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 16:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718813726; cv=none; b=B+gIhIT648td5pO76ZibVf/3PP3QZIKF08vsv1InBUWOc16czCnDLvigkmAfdRd9tLbrcVBt/3kd/ZzV4joDI8+NCUqRdu/VGguFKYqJpHoTjxdTN2MU3AP4uoUbxOAFNGDQqFy0DeuglFKLGnjpaq4AjPGic1bNNiV6hhdnStY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718813726; c=relaxed/simple;
	bh=ss0Uh9EdjlVVVTaBDNia4yMe/Wcg/oAnvkrDgWyx1Pc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PMeudvfgsU7F+aTyEL9Mt2ZEreUTcTjIKeppnytsNSDxBGVzfXHvingcMqRb7g+xePNJvb9wAdOiA/p/CQUFy3BC+wUr9LIarCsX2Kk55v++96z37z7unW47OFhrp+dQ1Ts23Pa8ExytBwuYClQ+PxC087e93ZFYRkoDmdCzzWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eHB/Dz8o; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718813724;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K6uw6c8xTJWi+pvcU2aMToH9/dEBpeu9C2fVbRq6KEk=;
	b=eHB/Dz8o90qiS0VNrOEJRHJQwyzKGWI2Xla4O8kR9jvyx8wEuyNycAbsKt5SewpUj5DYv1
	cv+BbM+/sRMC6RbU/0MqaSd26gHboCsJWb2MKpiHhdzV9UNmDe3ddqjrsdq6VrGd5EElmW
	iRGOuz5uW4yA7cm8YkSao0Xp+Ygv36g=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-518-Ra0Huo0MOxmJgdrPNKLbsA-1; Wed, 19 Jun 2024 12:15:22 -0400
X-MC-Unique: Ra0Huo0MOxmJgdrPNKLbsA-1
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-632b6ff93e4so98318747b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 09:15:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718813722; x=1719418522;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K6uw6c8xTJWi+pvcU2aMToH9/dEBpeu9C2fVbRq6KEk=;
        b=MfeJWVdlYHN56QsGFtxM4qiKXAfrXx/8bb+hVxOFjkDyElGIMTUqTUkBTW2L9d+hpe
         ygRlAAZ/RvwqK7eLFH9o/o39kKPwwlSztzR5fOh8EDotirVsdmw3accse8f7sNyMTpRq
         DRx1AGXWdYtkL+pj3sq492DGeO8ai/K7L0U2GAr7W7ykK5RQjFeAylHh9GDuK0xuwFFS
         OkQkb2OBBs9q9gBOrzxtudBKAogKtidzrRe4zyB5gJ65F7kpP8ksXulsGOEzVoYeFgst
         zoAN2vRv1M5Wi2Tm8HvGLAv9WbEcQHifbjqqNXAN1EKr9aWOrKTpYAgJqbJwXj6+mKCK
         aXNg==
X-Forwarded-Encrypted: i=1; AJvYcCVtLOz7aMpfaWpb8J7mD73T+E92CCYQ1HCfqlcxvGWgEZD68BExRJ52XUAH9cYYfA6ypk92RRcvQ0HAChD99Po03f42cUPXLgu7bgmE
X-Gm-Message-State: AOJu0YwvbGa6n73h2IiaXcoDr9b1fELQj/TzQ4x/zb4AE1wmAT5gVvub
	jZ5aMdVo2PkrORsKghCItznkwefYEI0jsBp3qHLWLr/BP1uhiyvXL6wtj/31fl6ph/jb7X3Bx+U
	3vLqKYvtfwVP792iWas3DNwmh37Nwy2BP3KuOq4x7hhwWjdtwVu+ofNb5zROc5/8bNc9X3Upf1r
	2K3Yebx5+FKejCz4IwJdDeoSGHUIDrs4ZlmnBU
X-Received: by 2002:a81:9e04:0:b0:62f:3278:a635 with SMTP id 00721157ae682-63a8db11467mr30440537b3.20.1718813721756;
        Wed, 19 Jun 2024 09:15:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFYj9yHFJVb+3h0QXR7hz1TBdvtwdMW2hViXwyFTLlI/REfheh7B4/sRoIX5a0uxH+gXSI/PDw6ksDPNWWW1Ps=
X-Received: by 2002:a81:9e04:0:b0:62f:3278:a635 with SMTP id
 00721157ae682-63a8db11467mr30440377b3.20.1718813721450; Wed, 19 Jun 2024
 09:15:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240617-stage-vdpa-vq-precreate-v1-0-8c0483f0ca2a@nvidia.com> <20240617-stage-vdpa-vq-precreate-v1-22-8c0483f0ca2a@nvidia.com>
In-Reply-To: <20240617-stage-vdpa-vq-precreate-v1-22-8c0483f0ca2a@nvidia.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 19 Jun 2024 18:14:45 +0200
Message-ID: <CAJaqyWezppMAL85-w7QLmEnKrebjdg9BQORApCj2ZHqWtiDptw@mail.gmail.com>
Subject: Re: [PATCH vhost 22/23] vdpa/mlx5: Don't reset VQs more than necessary
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
> The vdpa device can be reset many times in sequence without any
> significant state changes in between. Previously this was not a problem:
> VQs were torn down only on first reset. But after VQ pre-creation was
> introduced, each reset will delete and re-create the hardware VQs and
> their associated resources.
>
> To solve this problem, avoid resetting hardware VQs if the VQs are still
> in a blank state.
>
> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>

Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

> ---
>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 30 +++++++++++++++++++++++++++---
>  1 file changed, 27 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/ml=
x5_vnet.c
> index d80d6b47da61..1a5ee0d2b47f 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -3134,18 +3134,41 @@ static void init_group_to_asid_map(struct mlx5_vd=
pa_dev *mvdev)
>                 mvdev->group2asid[i] =3D 0;
>  }
>
> +static bool needs_vqs_reset(const struct mlx5_vdpa_dev *mvdev)
> +{
> +       struct mlx5_vdpa_net *ndev =3D to_mlx5_vdpa_ndev(mvdev);
> +       struct mlx5_vdpa_virtqueue *mvq =3D &ndev->vqs[0];
> +
> +       if (mvdev->status & VIRTIO_CONFIG_S_DRIVER_OK)
> +               return true;
> +
> +       if (mvq->fw_state !=3D MLX5_VIRTIO_NET_Q_OBJECT_STATE_INIT)
> +               return true;
> +
> +       return mvq->modified_fields & (
> +               MLX5_VIRTQ_MODIFY_MASK_STATE |
> +               MLX5_VIRTQ_MODIFY_MASK_VIRTIO_Q_ADDRS |
> +               MLX5_VIRTQ_MODIFY_MASK_VIRTIO_Q_AVAIL_IDX |
> +               MLX5_VIRTQ_MODIFY_MASK_VIRTIO_Q_USED_IDX
> +       );
> +}
> +
>  static int mlx5_vdpa_compat_reset(struct vdpa_device *vdev, u32 flags)
>  {
>         struct mlx5_vdpa_dev *mvdev =3D to_mvdev(vdev);
>         struct mlx5_vdpa_net *ndev =3D to_mlx5_vdpa_ndev(mvdev);
> +       bool vq_reset;
>
>         print_status(mvdev, 0, true);
>         mlx5_vdpa_info(mvdev, "performing device reset\n");
>
>         down_write(&ndev->reslock);
>         unregister_link_notifier(ndev);
> -       teardown_vq_resources(ndev);
> -       init_mvqs(ndev);
> +       vq_reset =3D needs_vqs_reset(mvdev);
> +       if (vq_reset) {
> +               teardown_vq_resources(ndev);
> +               init_mvqs(ndev);
> +       }
>
>         if (flags & VDPA_RESET_F_CLEAN_MAP)
>                 mlx5_vdpa_destroy_mr_resources(&ndev->mvdev);
> @@ -3165,7 +3188,8 @@ static int mlx5_vdpa_compat_reset(struct vdpa_devic=
e *vdev, u32 flags)
>                 if (mlx5_vdpa_create_dma_mr(mvdev))
>                         mlx5_vdpa_warn(mvdev, "create MR failed\n");
>         }
> -       setup_vq_resources(ndev, false);
> +       if (vq_reset)
> +               setup_vq_resources(ndev, false);
>         up_write(&ndev->reslock);
>
>         return 0;
>
> --
> 2.45.1
>


