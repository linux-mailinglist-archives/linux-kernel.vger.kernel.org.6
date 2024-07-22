Return-Path: <linux-kernel+bounces-258605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DDF66938A60
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 09:49:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 674211F218FA
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 07:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3227D1662E4;
	Mon, 22 Jul 2024 07:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gE7qVl0j"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F24121607A0
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 07:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721634541; cv=none; b=MWGf1xNruXl7O9uajItHjAC0KmWM8yPmSwNaz23IlmcFlOEY26cReh/u5KQ3MC+EswEUqFvOJsBrxBPuLyviNfdlMkAgZ7s5Prjl976HLeKE/W6YQ0xhGU6klmm3TY8+YkoCK6EYIkobH3hOi/U/3geUWnfe8a3lXZ8JJ2k3/1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721634541; c=relaxed/simple;
	bh=f+fV8aZHLjNJDmqj0f9UlS/89ETfJ+867t5eBxYZL68=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ae0P9XphWvl2t63BZ9QQwElyt8LIYBugO6RPzwDD5+WvxbezVWFaihP81tQy7ucX5z6kxlacOUZ2UGR6lCrwlYXaMdPLoOHpR+iovVthyZnLdZZrTdKKqeQnCXcpXFZnFC0/FO6PhWxYT6+Y5tlWLnO7ckJJg9ce/BSMJlBMmTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gE7qVl0j; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721634538;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k9Wijau/U3n0K7Jlrn8r30G3DxAJjcM6+ifaqnBRTZQ=;
	b=gE7qVl0j0tirf63JdaCAimgciov1V9jp4LZWXn+IEQO8cttqw4rXvyq7YjG8kuufT59Nvy
	nTbEYaFWt4tydLrR4CvCeqAGVyFGCr3NOSm4rHOSeIFz4L9FnIg02wlIKnCuMAvcE89Xui
	KEeB/IlX3PVAAZTVl8/OEkTj+nmzqTs=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-240-_GgrWJpHMEi0DjQCpUBWEw-1; Mon, 22 Jul 2024 03:48:56 -0400
X-MC-Unique: _GgrWJpHMEi0DjQCpUBWEw-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2cd72aa5328so314456a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 00:48:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721634536; x=1722239336;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k9Wijau/U3n0K7Jlrn8r30G3DxAJjcM6+ifaqnBRTZQ=;
        b=U+dtdu6Up9UTmU7Leox9gWctGZq8pu7kqV+wZvJLQs237jl0m2ZdyivRgNtSx3sY/Z
         6himS7qJvKt069pvgD4dterOjFwYtH5xJx8WOhdPxYUWVzxwPZaPtxYQWt69cpjAGirn
         VgNkEL+Ubjb6ir9yyYqSzUtdDvKZ/e6k8IeMinnZawIPHz3UDa8F3vZeoEU8kfpiJCoW
         Rr4m+92GoB5x0zfbMT2UVvmKZ+NxgVFVhYjMcWFmlUM9vBbloJpI+feVPMrldxZc7I7C
         CdNx6JSpzvAxjzUj5SRrjw5qTTfRtiJsJuaSFPrRIpgf7TxpSqhmw+qGZfcDEGzXoZd+
         oppw==
X-Forwarded-Encrypted: i=1; AJvYcCV+na2dd9+GQgaekJ8w3EKOquvze9Rdr5RewNERCpCYN6yZndsRxraToe2NcqbTb6lVIr+JEhMt545lX2beFQ3VmSdBPtTob9LJwvyy
X-Gm-Message-State: AOJu0YyhS4zPk8HTbAVUpkfZKvaGPMf01GHhTgMlJOAJZ2sU5SEA2gwP
	LUPPRBvk4vrYFxL/Bndt9+3ZtpTLg0j9YeQPcuK3KeJJeYA3Rj9wbSPOE5L13NIb+/ow2daAypL
	Zmn5CRLOK0lFJiGGIVCiSsDUXPsfv0J++dM/ouI/AyHWaiPQr/E7fwmngan1++zSPV9Wyv8Kvec
	oVUulFu8GLgP2bHwKZLdr9q0wWhKh21oPqWewl
X-Received: by 2002:a17:90b:1997:b0:2c9:8020:1b51 with SMTP id 98e67ed59e1d1-2cd273f776dmr2791083a91.3.1721634535903;
        Mon, 22 Jul 2024 00:48:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEXRzsCMJv/6tknO7a6u+ZBcL+U7UQuyw2cdT0yYEkm2DsQ1rWAMN0KuDM6A4GO1xcfnMyjBEi8/MfpUnx4Ou0=
X-Received: by 2002:a17:90b:1997:b0:2c9:8020:1b51 with SMTP id
 98e67ed59e1d1-2cd273f776dmr2791063a91.3.1721634535409; Mon, 22 Jul 2024
 00:48:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240722010625.1016854-1-lulu@redhat.com> <20240722010625.1016854-4-lulu@redhat.com>
In-Reply-To: <20240722010625.1016854-4-lulu@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 22 Jul 2024 15:48:44 +0800
Message-ID: <CACGkMEvXk8_sXRtugePAMv8PM0qGU-su0eFUsFZ=-=_TjcGZNg@mail.gmail.com>
Subject: Re: [PATH v4 3/3] vdpa/mlx5: Add the support of set mac address
To: Cindy Lu <lulu@redhat.com>
Cc: dtatulea@nvidia.com, mst@redhat.com, parav@nvidia.com, sgarzare@redhat.com, 
	netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 22, 2024 at 9:06=E2=80=AFAM Cindy Lu <lulu@redhat.com> wrote:
>
> Add the function to support setting the MAC address.
> For vdpa/mlx5, the function will use mlx5_mpfs_add_mac
> to set the mac address
>
> Tested in ConnectX-6 Dx device
>
> Signed-off-by: Cindy Lu <lulu@redhat.com>
> ---
>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
>
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/ml=
x5_vnet.c
> index ecfc16151d61..415b527a9c72 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -3785,10 +3785,35 @@ static void mlx5_vdpa_dev_del(struct vdpa_mgmt_de=
v *v_mdev, struct vdpa_device *
>         destroy_workqueue(wq);
>         mgtdev->ndev =3D NULL;
>  }
> +static int mlx5_vdpa_set_attr(struct vdpa_mgmt_dev *v_mdev,
> +                             struct vdpa_device *dev,
> +                             const struct vdpa_dev_set_config *add_confi=
g)
> +{
> +       struct mlx5_vdpa_dev *mvdev;
> +       struct mlx5_vdpa_net *ndev;
> +       struct mlx5_core_dev *mdev;
> +       struct virtio_net_config *config;
> +       struct mlx5_core_dev *pfmdev;
> +       int err =3D -EOPNOTSUPP;
> +
> +       mvdev =3D to_mvdev(dev);
> +       ndev =3D to_mlx5_vdpa_ndev(mvdev);
> +       mdev =3D mvdev->mdev;
> +       config =3D &ndev->config;
> +
> +       if (add_config->mask & (1 << VDPA_ATTR_DEV_NET_CFG_MACADDR)) {
> +               pfmdev =3D pci_get_drvdata(pci_physfn(mdev->pdev));
> +               err =3D mlx5_mpfs_add_mac(pfmdev, config->mac);
> +               if (!err)
> +                       memcpy(config->mac, add_config->net.mac, ETH_ALEN=
);
> +       }
> +       return err;

Similar to net simulator, how could be serialize the modification to
mac address:

1) from vdpa tool
2) via control virtqueue

Thanks

> +}
>
>  static const struct vdpa_mgmtdev_ops mdev_ops =3D {
>         .dev_add =3D mlx5_vdpa_dev_add,
>         .dev_del =3D mlx5_vdpa_dev_del,
> +       .dev_set_attr =3D mlx5_vdpa_set_attr,
>  };
>
>  static struct virtio_device_id id_table[] =3D {
> --
> 2.45.0
>


