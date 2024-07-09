Return-Path: <linux-kernel+bounces-245322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CA2C92B13A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 09:35:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25E032809AB
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 07:35:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26AB6148FFC;
	Tue,  9 Jul 2024 07:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GAF8CV5F"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E787F13FD86
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 07:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720510513; cv=none; b=LftqolBkn/VwNdDAkrVsY1pCuWZFoINnRJPdV5zGdRIXMViBzGOMm5wCpw3DI7w08nTbjJxTD4ENjRPhtY8KWYbcnqbkGMG15WtynixhXwgv4FMQsn5BGFtZYO/DypKsZPb6IDBDNsxuf2j4ggRr3EhsQlhoL3vPVJfCO16eXf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720510513; c=relaxed/simple;
	bh=DdRhbICaef9j8HkGlMP5Bgg0eQtDwpCDC9yQaq+5/6o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mHRHOESlyd5hDATLYEQ5mupw6JxPP1HDJWTFg28jJ32kRa/fOHpJ2zOnnqPbnBc0IIxHCp5Xo4e5PMcryr+oP2jffCp6luWu1z2z5nA+snDICa4aSCE8HenSdC5RtXzspdoK/0RxrRcaq/bKcfVro0z73uSGyvRzH5WwiUGVO34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GAF8CV5F; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720510510;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EIqC2mqFe9C8xKJMg5ba5cK9RsFhYLPxtTQe6Ed06hU=;
	b=GAF8CV5FywvHX7Y9YtNYpnuN/kvRklUKXX1AG4MrUW7Kh4OZ2FakWrr39/d4xknlo4FE8o
	zDXL3wZfFPiLccE1L3tkW5Q2SYUoEjqRcsn+eXrOOBJRn6QWaeB5pj7P0C4vG5ndKGBMug
	xIwD9XeR3VQWUlaP1LajN1v/zPrlS9o=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-654-jUrUdf6KN_G3LtLUxHC24A-1; Tue, 09 Jul 2024 03:35:07 -0400
X-MC-Unique: jUrUdf6KN_G3LtLUxHC24A-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-58c4f94b57cso3543260a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2024 00:35:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720510506; x=1721115306;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EIqC2mqFe9C8xKJMg5ba5cK9RsFhYLPxtTQe6Ed06hU=;
        b=JgHgKvE0JCq3XONN8UNQj6OaVK6P243soAVi32TuZoT6PNWomOkuEsOwXp0yG5byEu
         u94fabjUpcBoPwGI5wk7znmkUWzK23kGk/6FoIvul0tpvXF2OIAbCDMWMf0D93ei5RdU
         vN7FNZyxO02kZE3OqQfeV6w3+3ELqMw7eEizaiptZ5BOKMJjZ8lnUSm1f1F2I8vTZgWK
         xUo2O82RvcFO9bCPLN90dN1n6wln1uE90KXH02HYIfiTynvr18WGPjSKbv5Kl1q2ftdE
         IGuevb730/ZK4BDIVt3mD89Enrd9tUVd3/ScJvQh80iHtNcRZxwRq86UOQ9MkuFCYQfn
         HeVw==
X-Forwarded-Encrypted: i=1; AJvYcCWNIY/U1k3aJRjgDAkz7TbfGT7nyup8UjPUOGWOCweDkvro9XuwZK4XuNNe2TO7TMtVyM57Vc5ZVE1eXVq2xNmv6JofnKdsz0gB/7SU
X-Gm-Message-State: AOJu0YxJeG7hNMw7Yzqnvy7yI/JhEnwfytLEHo43H0x9LZ5z5fuGjgmJ
	RgEQLxMl/Ekf/aXjbSrtA5F1FLZm3RSS/T02whgHMVFeklyAg94y26IJVC9WMWQA5LX/npuOccf
	VuP2G98LWotHxdAYuYgzr2C4/LnGz/XEMyygGP29uxY+LOMxRRHGbn60JnHUuFB/mro1wNMCfY0
	FT4tt5aew/ISoBC1MB0w3wt6Tj6M6kEI+dnKM8
X-Received: by 2002:a05:6402:2742:b0:57c:610a:6e7f with SMTP id 4fb4d7f45d1cf-594baf8719fmr1467717a12.11.1720510506319;
        Tue, 09 Jul 2024 00:35:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEprGNtKtwZjWwZDrHR9spCqEFHlNDxGO/hw7rYsSyBxth5QJJ9oylIOl12jUvsQu4A55DuFRtIjAqAaxCAus8=
X-Received: by 2002:a05:6402:2742:b0:57c:610a:6e7f with SMTP id
 4fb4d7f45d1cf-594baf8719fmr1467693a12.11.1720510505896; Tue, 09 Jul 2024
 00:35:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240708065549.89422-1-lulu@redhat.com> <20240708072603-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240708072603-mutt-send-email-mst@kernel.org>
From: Cindy Lu <lulu@redhat.com>
Date: Tue, 9 Jul 2024 15:34:28 +0800
Message-ID: <CACLfguU2OakNJPO6pR6V7D4SV0-VvC=okqDcwutMPztTUweMZA@mail.gmail.com>
Subject: Re: [PATCH] vdpa/mlx5: Add the support of set mac address
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: dtatulea@nvidia.com, jasowang@redhat.com, parav@nvidia.com, 
	sgarzare@redhat.com, netdev@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 8 Jul 2024 at 19:26, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Mon, Jul 08, 2024 at 02:55:49PM +0800, Cindy Lu wrote:
> > Add the function to support setting the MAC address.
> > For vdpa/mlx5, the function will use mlx5_mpfs_add_mac
> > to set the mac address
> >
> > Tested in ConnectX-6 Dx device
> >
> > Signed-off-by: Cindy Lu <lulu@redhat.com>
>
> Is this on top of your other patchset?
>
yes, Will send a new version of these patch
Thanks
cindy
> > ---
> >  drivers/vdpa/mlx5/net/mlx5_vnet.c | 23 +++++++++++++++++++++++
> >  1 file changed, 23 insertions(+)
> >
> > diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > index 26ba7da6b410..f78701386690 100644
> > --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > @@ -3616,10 +3616,33 @@ static void mlx5_vdpa_dev_del(struct vdpa_mgmt_dev *v_mdev, struct vdpa_device *
> >       destroy_workqueue(wq);
> >       mgtdev->ndev = NULL;
> >  }
> > +static int mlx5_vdpa_set_attr_mac(struct vdpa_mgmt_dev *v_mdev,
> > +                               struct vdpa_device *dev,
> > +                               const struct vdpa_dev_set_config *add_config)
> > +{
> > +     struct mlx5_vdpa_dev *mvdev = to_mvdev(dev);
> > +     struct mlx5_vdpa_net *ndev = to_mlx5_vdpa_ndev(mvdev);
> > +     struct mlx5_core_dev *mdev = mvdev->mdev;
> > +     struct virtio_net_config *config = &ndev->config;
> > +     int err;
> > +     struct mlx5_core_dev *pfmdev;
> > +
> > +     if (add_config->mask & (1 << VDPA_ATTR_DEV_NET_CFG_MACADDR)) {
> > +             if (!is_zero_ether_addr(add_config->net.mac)) {
> > +                     memcpy(config->mac, add_config->net.mac, ETH_ALEN);
> > +                     pfmdev = pci_get_drvdata(pci_physfn(mdev->pdev));
> > +                     err = mlx5_mpfs_add_mac(pfmdev, config->mac);
> > +                     if (err)
> > +                             return -1;
> > +             }
> > +     }
> > +     return 0;
> > +}
> >
> >  static const struct vdpa_mgmtdev_ops mdev_ops = {
> >       .dev_add = mlx5_vdpa_dev_add,
> >       .dev_del = mlx5_vdpa_dev_del,
> > +     .dev_set_attr = mlx5_vdpa_set_attr_mac,
> >  };
> >
> >  static struct virtio_device_id id_table[] = {
> > --
> > 2.45.0
>


