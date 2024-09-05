Return-Path: <linux-kernel+bounces-316212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C194996CCA1
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 04:26:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 770DE1F26A11
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 02:26:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A564B1386C6;
	Thu,  5 Sep 2024 02:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FPzECW/6"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A3E3136E21
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 02:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725503200; cv=none; b=d0VVv8DBVFMS4x0poeSbkQkgzKnM8rJ9S3G32+yvUSSb3Az1wrqrq37wh0OgKZmIDjMYxDgpbbuDLCzqOJNlEGelgGL3RKPaecmg6jREFMyHBWkk4v7zKGRSj8Ss0iSKLlYLA1h/hBTkIawaFJ0XKn9ylEvMN5kJTg6crGIB0ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725503200; c=relaxed/simple;
	bh=0fSXcX9f2cuGkwjtwMSB0e3XbaJEAH6jrJj+iH7u9GA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VCP44bPuLh2qtQj/qwZMw2hkBasvu+w0Rps7Lyd+xvZOftn16/ajG00rHuD8XoJ5tsVWwhgmqU7rQjlleUG3YfgDS9qPJy/6dSxZ99N1v/OfXz18GxYaqliEjHVJ1CYjUKY3OrYBQdm42EJi2WpazEvTPLtu0pT4DDIBg79I0cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FPzECW/6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725503197;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0AcrrDwG+gt5HtN9utGk0xrv2KVXxivTuUcudC8C5KA=;
	b=FPzECW/6u2jDvMa1FlJWJVcGjd38gxgplihOF3vg+qxZPxJ5Hsp8ULgR0xKTuujk7s6egj
	rFjwgKpg52tojGtkJwIg3578KjfeCERcIvG8ghzOkNOPk1kHGV+3G6dbVlOcQdZr4f/QzN
	24LpTjyZc0GVm5smBV2GHGNZkkR4z0c=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-605-3rJFqE9QOtmuMbWm6jF_ng-1; Wed, 04 Sep 2024 22:26:35 -0400
X-MC-Unique: 3rJFqE9QOtmuMbWm6jF_ng-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2d8a1e91afaso264445a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 19:26:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725503194; x=1726107994;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0AcrrDwG+gt5HtN9utGk0xrv2KVXxivTuUcudC8C5KA=;
        b=qxxjnpPzgzGpAE3ji6ilzuvjj7L4pJ0NO5Ojw8x3KNGaaCTr3tIqo5+xm+zKT+ggrd
         XjFLl9JWLfRdJDIanHGaSW3q4ly97penxCCpNsSmupPmnddx79yyhVIW0JGbcPcfx5m7
         pLrve+pt8gt5i8XpJ0uQiQhKL1Ap4Q4k8iQUAl4/wrCPBxJ+Oje3UtlK3J/qYY1r2NGO
         xK6nXJ7VJ9RjaDI3jOBftPocvrB1a25+03eEzFnys1E2PEsNEdtlppxgwdZhZbzlopGi
         FWDB60mxlNf1YjF5nitqoE0Ctb0022d7uV3CFE1MYhAFw7cfpmUS6CDKlsB62vpvNap+
         BOkA==
X-Forwarded-Encrypted: i=1; AJvYcCVLXodeD3I8m9O2Hegb8tOi/GiRdOPCR+uL9SYQrlm5/A4PTGiBZadfr3aVprj9R0QVVbtvnLseYpwm+6M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/fqztTT9lASsG16Ppw3WqhjPnKMWzMIiLhYBGrCU+sSC7W/YX
	1A5gUGwcoLUrVsk+gGko4oRouiO9xkgI2WB4TzHXVcsQnFxWgYz3j6ohtY9QkXmbkfLgpyzmHkQ
	6fmmArfDPXUK3OFjxo4GD5biQanyGcHz5QjEhOaJqzNlIoCSqsdKtJb4uq5CZN6p3+gsoo0gjlO
	N5ZJ497sbYDdpiF5roq5vUJ0rh6gN6kzDome/Y
X-Received: by 2002:a17:90b:3006:b0:2d3:ba42:775c with SMTP id 98e67ed59e1d1-2d8904c6ea8mr14915073a91.1.1725503194559;
        Wed, 04 Sep 2024 19:26:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEWuQKLDoZMrRIdao7KmQN4ts3CZKQHTuY+s+a//aNWe36FRXtO0yYzwLAFD4CEo6un3aPXRTMoy8n5g9CHlN4=
X-Received: by 2002:a17:90b:3006:b0:2d3:ba42:775c with SMTP id
 98e67ed59e1d1-2d8904c6ea8mr14915055a91.1.1725503194136; Wed, 04 Sep 2024
 19:26:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240904151115.205622-1-carlos.bilbao.osdev@gmail.com> <20240904151115.205622-2-carlos.bilbao.osdev@gmail.com>
In-Reply-To: <20240904151115.205622-2-carlos.bilbao.osdev@gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 5 Sep 2024 10:26:22 +0800
Message-ID: <CACGkMEvj0yWoGP6LvdNL5rkE59DsdpGwwaZNGVVHYO+zgjTudg@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] vdpa/mlx5: Set speed and duplex of vDPA devices to UNKNOWN
To: Carlos Bilbao <carlos.bilbao.osdev@gmail.com>
Cc: dtatulea@nvidia.com, mst@redhat.com, shannon.nelson@amd.com, 
	sashal@kernel.org, alvaro.karsz@solid-run.com, christophe.jaillet@wanadoo.fr, 
	steven.sistare@oracle.com, bilbao@vt.edu, xuanzhuo@linux.alibaba.com, 
	johnah.palmer@oracle.com, eperezma@redhat.com, cratiu@nvidia.com, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Carlos Bilbao <cbilbao@digitalocean.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 4, 2024 at 11:18=E2=80=AFPM Carlos Bilbao
<carlos.bilbao.osdev@gmail.com> wrote:
>
> From: Carlos Bilbao <cbilbao@digitalocean.com>
>
> Initialize the speed and duplex fields in virtio_net_config to UNKNOWN.
> This is needed because mlx5_vdpa vDPA devices currently do not support th=
e
> VIRTIO_NET_F_SPEED_DUPLEX feature which reports speed and duplex. Add
> needed helper cpu_to_mlx5vdpa32() to convert endianness of speed.
>
> Signed-off-by: Carlos Bilbao <cbilbao@digitalocean.com>
> Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

> ---
>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/ml=
x5_vnet.c
> index b56aae3f7be3..41ca268d43ff 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -173,6 +173,11 @@ static __virtio16 cpu_to_mlx5vdpa16(struct mlx5_vdpa=
_dev *mvdev, u16 val)
>         return __cpu_to_virtio16(mlx5_vdpa_is_little_endian(mvdev), val);
>  }
>
> +static __virtio32 cpu_to_mlx5vdpa32(struct mlx5_vdpa_dev *mvdev, u32 val=
)
> +{
> +       return __cpu_to_virtio32(mlx5_vdpa_is_little_endian(mvdev), val);
> +}
> +
>  static u16 ctrl_vq_idx(struct mlx5_vdpa_dev *mvdev)
>  {
>         if (!(mvdev->actual_features & BIT_ULL(VIRTIO_NET_F_MQ)))
> @@ -3433,6 +3438,13 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev =
*v_mdev, const char *name,
>         init_rwsem(&ndev->reslock);
>         config =3D &ndev->config;
>
> +       /*
> +        * mlx5_vdpa vDPA devices currently don't support reporting or
> +        * setting the speed or duplex.
> +        */
> +       config->speed  =3D cpu_to_mlx5vdpa32(mvdev, SPEED_UNKNOWN);
> +       config->duplex =3D DUPLEX_UNKNOWN;
> +
>         if (add_config->mask & BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MTU)) {
>                 err =3D config_func_mtu(mdev, add_config->net.mtu);
>                 if (err)
> --
> 2.34.1
>


