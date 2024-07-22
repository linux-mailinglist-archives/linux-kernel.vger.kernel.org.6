Return-Path: <linux-kernel+bounces-258978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A06DF938F64
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 14:53:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 532321F207BB
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 12:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E6FE16D9A2;
	Mon, 22 Jul 2024 12:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZGfN/Ozp"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8C1E16CD32
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 12:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721652819; cv=none; b=uOBZW2U8Ey+PwVI8jGya4QE6LQDA87cdhEKLpm6NgCJteFhXTU2xsa7fdWMvP69t4QvBQwzAjsg7Y5dr2I6b+T9BnmI/URIlXOD4JD+VpdASNVo2Z9AFr0+9+tF+6V8fHyOY8CQ18vFls6bl8gWpR+UJjSybjTRFC1y5cdGNFxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721652819; c=relaxed/simple;
	bh=Hb2vlo6jvMfawcIP5+hm/LNCX6XVc0VQ/rbcyfyg/Xg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kLHbPtmPCGydjhSJMB5fbknoY2B0pOf+ejqmpBr6lQAWVU+ZLY+lphnYya9qm/AsEnuIXmBVW78uAUFweMVxmVtCIUGdbS1hsENaCi2xjty2xlRBTNDGFbdNyMEjJA8sHoNuXxtxwe5L1vagoIrPMeqXEE3F9oZOP3s/dX3kCFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZGfN/Ozp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721652816;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eU/D7g+qP7HfNmpAQB1UFGkewZKa63OdmYLP+myK2LI=;
	b=ZGfN/Ozp15oLm0er9RTwQA8+i46erzUuxg7TjMU8wqm2lPuMRKqZkW0q351TtlquswGY5u
	G6bM/UCxCGw6TpH/Gf/RnB1l8prmEWLoN2UCHysy4OboVj2QE/IPdCZ5p4psq6qTPK/E4g
	IKDtYJGc4X0vlmjzTRhBzzr0jxp9FUU=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-6V_M6RsyMjyg94E9gMLL8A-1; Mon, 22 Jul 2024 08:53:35 -0400
X-MC-Unique: 6V_M6RsyMjyg94E9gMLL8A-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-52e9557e312so3057591e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 05:53:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721652810; x=1722257610;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eU/D7g+qP7HfNmpAQB1UFGkewZKa63OdmYLP+myK2LI=;
        b=iTL4JsmBE7uFm52zHILA7PTavNH61FTRpYDyE3S2anK3+bVLJOdRsJcTNZ1xi+yTlS
         dD+JE/cveeJWX9rOkBFzi8CuFukBUicAorHWHQFwVWmlUW1gEfRVJ8s7KJ4oPc8LOUz1
         wsL6MOcrULtQoW74Jz1afxPUtZ9O8McwIKcp4uLQCjE5w2SMAAGKmX5dcNlsbhGPmuZo
         0wSMattxa+Wq6x/n0gqHaeucJLrKJW87TzH+JCbcNwdSjBTPpWoSR/P33orKOieAS1Fi
         3KKv+1DipjgDnaUe7ox0Pzsg7OwHzt/Ipvz0Lzmbjfa5j3k7j7ESRbyM6cWpuN4l/1iN
         3eRw==
X-Forwarded-Encrypted: i=1; AJvYcCXdw3QPAPR+eePRFZO2lWPfYWouPsO/lOjGKqE0HxvwnnYpFPtY/JBJqs8M785wkCKRjqM5b9afO2RyRtxPcD39JGVEXGwV94k/eBpC
X-Gm-Message-State: AOJu0Yx/yf3mkUlCN/RcNcrxGl5eQKC9pPLqhWzkr2X6dBJjBRhNIVFw
	dijd2sMFlWAoc5C6VndosKHuWGWH1Gq+/pP5q0Q2U/hzgeCaZrd5K/3fslC7+M+xbRBiEZuxXN1
	vdKh0LhYuyaORrkZ0E04J2A+gW/WoNYYQeo6rHD2GgAr/4DxH+afyiASIXBa54S3KdVCKmmO6u+
	H5jQht+EgQB6pd5s+MbqG9dE+fa/ZiTFkWjIIG
X-Received: by 2002:a05:6512:b93:b0:52c:da18:618c with SMTP id 2adb3069b0e04-52efb7c81e5mr4946311e87.45.1721652810676;
        Mon, 22 Jul 2024 05:53:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF1mNcBQlFjEipVBmIhBwOyNuYK7PE8pk7ocN9FHW1CRN8mmKIK/bPZP3oGT+TMvN+d/t1tuhOEjNRdYMGH2b0=
X-Received: by 2002:a05:6512:b93:b0:52c:da18:618c with SMTP id
 2adb3069b0e04-52efb7c81e5mr4946290e87.45.1721652810311; Mon, 22 Jul 2024
 05:53:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240722010625.1016854-1-lulu@redhat.com> <20240722010625.1016854-4-lulu@redhat.com>
 <CACGkMEvXk8_sXRtugePAMv8PM0qGU-su0eFUsFZ=-=_TjcGZNg@mail.gmail.com>
In-Reply-To: <CACGkMEvXk8_sXRtugePAMv8PM0qGU-su0eFUsFZ=-=_TjcGZNg@mail.gmail.com>
From: Cindy Lu <lulu@redhat.com>
Date: Mon, 22 Jul 2024 20:52:51 +0800
Message-ID: <CACLfguV27KGZE9z5OKuse44tpsF2u8DALhGNxu+g8==qV50CYQ@mail.gmail.com>
Subject: Re: [PATH v4 3/3] vdpa/mlx5: Add the support of set mac address
To: Jason Wang <jasowang@redhat.com>
Cc: dtatulea@nvidia.com, mst@redhat.com, parav@nvidia.com, sgarzare@redhat.com, 
	netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 22 Jul 2024 at 15:49, Jason Wang <jasowang@redhat.com> wrote:
>
> On Mon, Jul 22, 2024 at 9:06=E2=80=AFAM Cindy Lu <lulu@redhat.com> wrote:
> >
> > Add the function to support setting the MAC address.
> > For vdpa/mlx5, the function will use mlx5_mpfs_add_mac
> > to set the mac address
> >
> > Tested in ConnectX-6 Dx device
> >
> > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > ---
> >  drivers/vdpa/mlx5/net/mlx5_vnet.c | 25 +++++++++++++++++++++++++
> >  1 file changed, 25 insertions(+)
> >
> > diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/=
mlx5_vnet.c
> > index ecfc16151d61..415b527a9c72 100644
> > --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > @@ -3785,10 +3785,35 @@ static void mlx5_vdpa_dev_del(struct vdpa_mgmt_=
dev *v_mdev, struct vdpa_device *
> >         destroy_workqueue(wq);
> >         mgtdev->ndev =3D NULL;
> >  }
> > +static int mlx5_vdpa_set_attr(struct vdpa_mgmt_dev *v_mdev,
> > +                             struct vdpa_device *dev,
> > +                             const struct vdpa_dev_set_config *add_con=
fig)
> > +{
> > +       struct mlx5_vdpa_dev *mvdev;
> > +       struct mlx5_vdpa_net *ndev;
> > +       struct mlx5_core_dev *mdev;
> > +       struct virtio_net_config *config;
> > +       struct mlx5_core_dev *pfmdev;
> > +       int err =3D -EOPNOTSUPP;
> > +
> > +       mvdev =3D to_mvdev(dev);
> > +       ndev =3D to_mlx5_vdpa_ndev(mvdev);
> > +       mdev =3D mvdev->mdev;
> > +       config =3D &ndev->config;
> > +
> > +       if (add_config->mask & (1 << VDPA_ATTR_DEV_NET_CFG_MACADDR)) {
> > +               pfmdev =3D pci_get_drvdata(pci_physfn(mdev->pdev));
> > +               err =3D mlx5_mpfs_add_mac(pfmdev, config->mac);
> > +               if (!err)
> > +                       memcpy(config->mac, add_config->net.mac, ETH_AL=
EN);
> > +       }
> > +       return err;
>
> Similar to net simulator, how could be serialize the modification to
> mac address:
>
> 1) from vdpa tool
> 2) via control virtqueue
>
> Thanks
>
sure. Wiil do
thanks
cindy
> > +}
> >
> >  static const struct vdpa_mgmtdev_ops mdev_ops =3D {
> >         .dev_add =3D mlx5_vdpa_dev_add,
> >         .dev_del =3D mlx5_vdpa_dev_del,
> > +       .dev_set_attr =3D mlx5_vdpa_set_attr,
> >  };
> >
> >  static struct virtio_device_id id_table[] =3D {
> > --
> > 2.45.0
> >
>


