Return-Path: <linux-kernel+bounces-306126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66DBE963982
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 06:49:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CE881C23359
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 04:49:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4049D1465AB;
	Thu, 29 Aug 2024 04:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AfzeS4dp"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE316446DC
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 04:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724906982; cv=none; b=OlZcEvh5Cra4JNdQxPEFujmFUc9HP+FbwWnNInP9Ue7I0CDNt/FeKu3Jd37EAY8f4m7e8WkzxV9V6XpdFgO26oqVTmiTdR8dY836yGVmjQLEm1dQJaUrnu6iBnkTTMx4mm/Ra9Gl1XrqGdBChxjZvSw8OyjLkAHWxI0Q6dQsCTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724906982; c=relaxed/simple;
	bh=DULz1wwF4kdm3KYLQG5LDL/4PQ4uZSYOtMOIgeVVc58=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=agE6gPU7s6SKnY4l5tKccN3JXZ6tG6Lv77pDSwlzXYJYv66TR43UzlN2CpnxSXVsfl5KSlB84lJzxMgr5qQ44gUkHYa78SpwzpctjQqAi+4QrjHrs31U0mrbvLRuXb9HQKHfq2FFfdHhmFs+mbEyX9Wj0DVEyJpL/8l73b0+GVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AfzeS4dp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724906979;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=03Qf/XIbw5qKyffaKvRyGbHN12QPCb2FcgD6gnCFY+0=;
	b=AfzeS4dpbTnzqSrUCoZ5j6kQchdzKNJWHW5fVdJW8stcP3pZ+k2l5y52cGKhGhFk30cFa1
	O8OHoN9Clk+Fpdxv+6/e0qe66ZZDhyWhdPm+9fs6+cO4f+fKyPqdQcl8ve0qtSypGSpd30
	gNPDWAq279dxKP1kO7+TA5GRwdcsC6c=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-219-akF4LiylMsukOLB5QXNBCw-1; Thu, 29 Aug 2024 00:49:37 -0400
X-MC-Unique: akF4LiylMsukOLB5QXNBCw-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2d45800a8f3so254528a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 21:49:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724906976; x=1725511776;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=03Qf/XIbw5qKyffaKvRyGbHN12QPCb2FcgD6gnCFY+0=;
        b=TPd7s6kd2LzK/7g/muYMHmyoF//kmVBnn5MpSvdnnVY5dTDI5WYSF1+URM4uJGW9uP
         hSdnzMpsV48eKRUozLoEUtgVk5YU9WukgoJbF95UeyzNRZnJYKDX8zSdIReHZutd+2Un
         LqQeomI4eQeZHzUPO6HhQjjsgkmOQJJSf5s7DBl0cWbG+K6pLROkurTxavFkoygkk6x6
         7+1z5m8o+ykEVlpG0AqiaGnt1pSHsxDahIoIE5xjc20TmVfZ2wjX5fK5/BqhMTOkzVIF
         GJRFFxHAhBWCim/E0hQewDFDBPp8HT3T4RZcCSG0g2rXUitf9FuGhnnw+ovMHkMvqkjp
         5uyA==
X-Forwarded-Encrypted: i=1; AJvYcCVsU+PlxY96ZtUbak4ZOlx/GUwaNLIVaJss3gti1B8vsyZWL7OEqvr31/WA8KKTRHyypm5/tVAHe/PqX7I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDpF84yZidMMMrXwRAu8Tu52TsnrGJICkedRuyAyPeYE+oF2aZ
	zJZNClml45ruh7fqaEbzwBS1vjvr9Nub7oYVL6CFQwpTX4CD7oLkmJxTvqZgAS39RRqW4eLrwv+
	tFTsXsuwz0asupfY3W90s9Pfx4oaMKJqwGhADZuBxwR188EG3zE/0UsWZrQQPn4Skl2jtP7aO2P
	z1ocVyO1+uf5qTyMAQSUTRx9/p+Hyr8RMb87N/
X-Received: by 2002:a17:90b:3e84:b0:2c1:9892:8fb with SMTP id 98e67ed59e1d1-2d85618881dmr1458616a91.5.1724906976444;
        Wed, 28 Aug 2024 21:49:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGUGAFR6tSH8vk5Ale6DnmiWQGUFCR8vJCc+FkyW8/X5qJjXCZMcxqDXb4gGd/1Grp2C5tsk8mzua6j1X27QYY=
X-Received: by 2002:a17:90b:3e84:b0:2c1:9892:8fb with SMTP id
 98e67ed59e1d1-2d85618881dmr1458599a91.5.1724906975803; Wed, 28 Aug 2024
 21:49:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240828181625.7831-1-carlos.bilbao.osdev@gmail.com>
In-Reply-To: <20240828181625.7831-1-carlos.bilbao.osdev@gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 29 Aug 2024 12:49:24 +0800
Message-ID: <CACGkMEs2wDLBq3_5KDOHou3g8Cxhm9Dx8eXy7JnX0R8ZYqinZA@mail.gmail.com>
Subject: Re: [PATCH] vdpa: Set speed and duplex of mlx5_vnet to UNKNOWN
To: Carlos Bilbao <carlos.bilbao.osdev@gmail.com>
Cc: dtatulea@nvidia.com, mst@redhat.com, bilbao@vt.edu, 
	xuanzhuo@linux.alibaba.com, eperezma@redhat.com, cratiu@nvidia.com, 
	lingshan.zhu@intel.com, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Carlos Bilbao <cbilbao@digitalocean.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 29, 2024 at 2:16=E2=80=AFAM Carlos Bilbao
<carlos.bilbao.osdev@gmail.com> wrote:
>
> From: Carlos Bilbao <cbilbao@digitalocean.com>
>
> mlx5_vdpa vDPA devices currently don't support reporting or setting the
> speed and duplex and hence should be UNKNOWN instead of zero.
>
> Signed-off-by: Carlos Bilbao <cbilbao@digitalocean.com>
> ---
>  drivers/vdpa/mlx5/net/mlx5_vnet.c |  7 +++++++
>  drivers/vdpa/vdpa.c               | 23 +++++++++++++++++++++++
>  include/uapi/linux/vdpa.h         |  2 ++
>  3 files changed, 32 insertions(+)
>
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/ml=
x5_vnet.c
> index fa78e8288ebb..319f5c6121de 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -3795,6 +3795,13 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev =
*v_mdev, const char *name,
>         init_rwsem(&ndev->reslock);
>         config =3D &ndev->config;
>
> +       /*
> +        * mlx5_vdpa vDPA devices currently don't support reporting or
> +        * setting the speed or duplex.
> +        */
> +       config->speed  =3D SPEED_UNKNOWN;
> +       config->duplex =3D DUPLEX_UNKNOWN;
> +
>         if (add_config->mask & BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MTU)) {
>                 err =3D config_func_mtu(mdev, add_config->net.mtu);
>                 if (err)
> diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
> index 4dbd2e55a288..abde23e0041d 100644
> --- a/drivers/vdpa/vdpa.c
> +++ b/drivers/vdpa/vdpa.c
> @@ -15,6 +15,7 @@
>  #include <net/genetlink.h>
>  #include <linux/mod_devicetable.h>
>  #include <linux/virtio_ids.h>
> +#include <uapi/linux/ethtool.h>
>
>  static LIST_HEAD(mdev_head);
>  /* A global mutex that protects vdpa management device and device level =
operations. */
> @@ -919,6 +920,22 @@ static int vdpa_dev_net_status_config_fill(struct sk=
_buff *msg, u64 features,
>         return nla_put_u16(msg, VDPA_ATTR_DEV_NET_STATUS, val_u16);
>  }
>
> +static int vdpa_dev_net_speed_config_fill(struct sk_buff *msg, u64 featu=
res,
> +                                       struct virtio_net_config *config)
> +{
> +       __le32 speed =3D cpu_to_le32(SPEED_UNKNOWN);
> +
> +       return nla_put(msg, VDPA_ATTR_DEV_NET_CFG_SPEED, sizeof(speed), &=
speed);
> +}
> +
> +static int vdpa_dev_net_duplex_config_fill(struct sk_buff *msg, u64 feat=
ures,
> +                                       struct virtio_net_config *config)
> +{
> +       u8 duplex =3D DUPLEX_UNKNOWN;
> +
> +       return nla_put(msg, VDPA_ATTR_DEV_NET_CFG_DUPLEX, sizeof(duplex),=
 &duplex);
> +}
> +
>  static int vdpa_dev_net_config_fill(struct vdpa_device *vdev, struct sk_=
buff *msg)
>  {
>         struct virtio_net_config config =3D {};
> @@ -941,6 +958,12 @@ static int vdpa_dev_net_config_fill(struct vdpa_devi=
ce *vdev, struct sk_buff *ms
>         if (vdpa_dev_net_status_config_fill(msg, features_device, &config=
))
>                 return -EMSGSIZE;
>
> +       if (vdpa_dev_net_speed_config_fill(msg, features_device, &config)=
)
> +               return -EMSGSIZE;
> +
> +       if (vdpa_dev_net_duplex_config_fill(msg, features_device, &config=
))
> +               return -EMSGSIZE;
> +
>         return vdpa_dev_net_mq_config_fill(msg, features_device, &config)=
;
>  }
>
> diff --git a/include/uapi/linux/vdpa.h b/include/uapi/linux/vdpa.h
> index 842bf1201ac4..1c64ee0dd7b1 100644
> --- a/include/uapi/linux/vdpa.h
> +++ b/include/uapi/linux/vdpa.h
> @@ -43,6 +43,8 @@ enum vdpa_attr {
>         VDPA_ATTR_DEV_NET_STATUS,               /* u8 */
>         VDPA_ATTR_DEV_NET_CFG_MAX_VQP,          /* u16 */
>         VDPA_ATTR_DEV_NET_CFG_MTU,              /* u16 */
> +       VDPA_ATTR_DEV_NET_CFG_SPEED,            /* u32 */
> +       VDPA_ATTR_DEV_NET_CFG_DUPLEX,           /* u8 */

This should be an independent patch as it allows vdpa tool to
provision speed and duplex.

But a fundamental question is if we need such provisioning?

Thanks

>
>         VDPA_ATTR_DEV_NEGOTIATED_FEATURES,      /* u64 */
>         VDPA_ATTR_DEV_MGMTDEV_MAX_VQS,          /* u32 */
> --
> 2.34.1
>


