Return-Path: <linux-kernel+bounces-259541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B272E939813
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 03:53:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DBA5281CBB
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 01:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A1DF13A25B;
	Tue, 23 Jul 2024 01:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZPiVGKIg"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A054EC2
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 01:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721699572; cv=none; b=kaFFuXZ8hgrZZ2NU9xm6rjfSZ0BMuSrTSUvzmYcYkKYHkEZt8YLPIxeBcr+ZJu5q6VUl+dxbGOLUzeTYEs7SwnymMF5/mJ02FQ7G6ERQFTweOw5vLgbyqgfWPJRSoyDMjNfeI4MQt3eD0+Jw6cKOny0B+CpF3bCeW5G8FLm/ZpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721699572; c=relaxed/simple;
	bh=0OAP7yrfR/bxTdK47hEUxW4aUnVwJYFdSrSo5vQmC54=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XVoDLRzRouzST382Pd8Z1A2alQMjgikORYAkJyyow4K4EEn16xOZltZC25E+C1UMSXHHGDbOZ2GZRiB1nNxoTCfBTREp4xW0Zyb+A3voawIvWeivTRDXrofp2xXhSyeyOXBadWvhd+Fm4dw15ZSxb6pkxpD88bmJUvD/LV6a+HE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZPiVGKIg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721699569;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pJ7JFLuxpYIYah8YS0qjsxD8eAnofbzaLi2qDbDcUzo=;
	b=ZPiVGKIgzjcI3JdndCipO7lypLt3A2dnO+Mv5iW5JQcVrqzVzGJnaW7SLLVMyp7AeFnFQu
	LUHw2cxmSazw9Neu1eHYYj+5DShLLu1yML1ZIMHwoMqavyEqOiv/+kKYtcvHfzpLWOPmuP
	qFRizV+vbJSHJZkvoU2bTSTeQHvNROA=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-350-E620LHmvOlSMPvXtumIeTQ-1; Mon, 22 Jul 2024 21:52:48 -0400
X-MC-Unique: E620LHmvOlSMPvXtumIeTQ-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-5a8b0832defso1540546a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 18:52:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721699567; x=1722304367;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pJ7JFLuxpYIYah8YS0qjsxD8eAnofbzaLi2qDbDcUzo=;
        b=wybCFRc74g0G1V+HGZPdV7lLrZIjlZDBw7XhumGK66HDEZ+wDtBAJSKDJQOEz5yTSv
         /23gvhfbWUUmpUe1u+TuA+tUK9N+QZw61PfD/wdiF4PWTwnJqnSEPU7Vkkjf0XfHcQs4
         Agari95OW7PGh56KM9H+/KCnrBygB+IIUK+V3RVBtMfoRHHkLWmFaEdr6riaH774aPrv
         hYOA9oXeCc2xsae3U0/NqSu2HkTtgGYxa8uFPssnZ0H2fKypkwtbavbHK/k41O2JIwWq
         P13vkh4AHtut+xvhEi2A/dymuL5K43smbkuNUpI/ox5YjQOX05ym2nIAcRpkHWA478eG
         G0Mw==
X-Forwarded-Encrypted: i=1; AJvYcCXQl5+Y5kd1llLMCbOTx+588yOmk6z02mGL0DHgiadbgDaukbQTxt+5IaSoNN+5snZvBXiky+wCX2skwbhGRIm4NnoyzMB1wAulSwJH
X-Gm-Message-State: AOJu0Yxqt2Ht/IhzYoS834GkdcSsstlbWCTb2+w4Jj5VPcohzaKQ518R
	1dCZzMsuReFQZI5yVddqcoNpW7qQ2cEBURTLy6kbPl9uuG14lo2inpSj1MwCeUwbXy2gbJDJJmz
	dsMACh3dXZh/UFbWD8H2pldQfQ48PGeQWqm2ktj8J7+ZPuKceZMYk1ZVP/LJM7OfNqh0IBwbCp4
	p4t8CuADVOE21fGnn9QSkotwEq8wk3LJ9Vt9m/
X-Received: by 2002:a50:8e46:0:b0:5a1:5c0c:cbd6 with SMTP id 4fb4d7f45d1cf-5a99d304998mr515201a12.8.1721699567156;
        Mon, 22 Jul 2024 18:52:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEpb4QBdHjRYWATG2kay1v6Ynq7TjEslzVYd7B8oglM/3KMtTIx8dJYYYdlwfGufvlJ22Nq4TvO++VYfJ/lO/I=
X-Received: by 2002:a50:8e46:0:b0:5a1:5c0c:cbd6 with SMTP id
 4fb4d7f45d1cf-5a99d304998mr515186a12.8.1721699566814; Mon, 22 Jul 2024
 18:52:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240722010625.1016854-1-lulu@redhat.com> <20240722010625.1016854-4-lulu@redhat.com>
 <CACGkMEvXk8_sXRtugePAMv8PM0qGU-su0eFUsFZ=-=_TjcGZNg@mail.gmail.com>
 <7a4d99e0f16cbe91000c3c780334a4c866904182.camel@nvidia.com>
 <CACLfguUR_hdJGDcjnmYY=qOXFiSnsBsXD5evTDZQi=K0RM4gZQ@mail.gmail.com>
 <CACLfguUWCY6MJkv+GuJ0W0t0Q0iX3fna+EjWxV5E=au9Oa5-aw@mail.gmail.com> <CACGkMEsapSx4Hk+2PcsenGzaBbJ2OKXde_onEb+8gZG9AMAX6A@mail.gmail.com>
In-Reply-To: <CACGkMEsapSx4Hk+2PcsenGzaBbJ2OKXde_onEb+8gZG9AMAX6A@mail.gmail.com>
From: Cindy Lu <lulu@redhat.com>
Date: Tue, 23 Jul 2024 09:52:09 +0800
Message-ID: <CACLfguXPiqrfpmLjuT20VEqn_Qi1Mg90GB8YDgOanerQy2X-5Q@mail.gmail.com>
Subject: Re: [PATH v4 3/3] vdpa/mlx5: Add the support of set mac address
To: Jason Wang <jasowang@redhat.com>
Cc: Dragos Tatulea <dtatulea@nvidia.com>, "sgarzare@redhat.com" <sgarzare@redhat.com>, 
	Parav Pandit <parav@nvidia.com>, "mst@redhat.com" <mst@redhat.com>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 23 Jul 2024 at 09:28, Jason Wang <jasowang@redhat.com> wrote:
>
> On Mon, Jul 22, 2024 at 10:48=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote=
:
> >
> > On Mon, 22 Jul 2024 at 20:55, Cindy Lu <lulu@redhat.com> wrote:
> > >
> > > On Mon, 22 Jul 2024 at 17:45, Dragos Tatulea <dtatulea@nvidia.com> wr=
ote:
> > > >
> > > > On Mon, 2024-07-22 at 15:48 +0800, Jason Wang wrote:
> > > > > On Mon, Jul 22, 2024 at 9:06=E2=80=AFAM Cindy Lu <lulu@redhat.com=
> wrote:
> > > > > >
> > > > > > Add the function to support setting the MAC address.
> > > > > > For vdpa/mlx5, the function will use mlx5_mpfs_add_mac
> > > > > > to set the mac address
> > > > > >
> > > > > > Tested in ConnectX-6 Dx device
> > > > > >
> > > > > > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > > > > > ---
> > > > > >  drivers/vdpa/mlx5/net/mlx5_vnet.c | 25 +++++++++++++++++++++++=
++
> > > > > >  1 file changed, 25 insertions(+)
> > > > > >
> > > > > > diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/m=
lx5/net/mlx5_vnet.c
> > > > > > index ecfc16151d61..415b527a9c72 100644
> > > > > > --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > > > > +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > > > > @@ -3785,10 +3785,35 @@ static void mlx5_vdpa_dev_del(struct vd=
pa_mgmt_dev *v_mdev, struct vdpa_device *
> > > > > >         destroy_workqueue(wq);
> > > > > >         mgtdev->ndev =3D NULL;
> > > > > >  }
> > > > > > +static int mlx5_vdpa_set_attr(struct vdpa_mgmt_dev *v_mdev,
> > > > > > +                             struct vdpa_device *dev,
> > > > > > +                             const struct vdpa_dev_set_config =
*add_config)
> > > > > > +{
> > > > > > +       struct mlx5_vdpa_dev *mvdev;
> > > > > > +       struct mlx5_vdpa_net *ndev;
> > > > > > +       struct mlx5_core_dev *mdev;
> > > > > > +       struct virtio_net_config *config;
> > > > > > +       struct mlx5_core_dev *pfmdev;
> > > > Reverse xmas tree?
> > > >
> > > will fix this
> > > > > > +       int err =3D -EOPNOTSUPP;
> > > > > > +
> > > > > > +       mvdev =3D to_mvdev(dev);
> > > > > > +       ndev =3D to_mlx5_vdpa_ndev(mvdev);
> > > > > > +       mdev =3D mvdev->mdev;
> > > > > > +       config =3D &ndev->config;
> > > > > > +
> > > > You still need to take the ndev->reslock.
> > > >
> > > sure, will do
> > > > > > +       if (add_config->mask & (1 << VDPA_ATTR_DEV_NET_CFG_MACA=
DDR)) {
> > > > > > +               pfmdev =3D pci_get_drvdata(pci_physfn(mdev->pde=
v));
> > > > > > +               err =3D mlx5_mpfs_add_mac(pfmdev, config->mac);
> > > > > > +               if (!err)
> > > > > > +                       memcpy(config->mac, add_config->net.mac=
, ETH_ALEN);
> > > > What is the expected behaviour when the device is in use?
> > > >
> > > if the err is 0 then copy the Mac address to config
> > > will change this code to make it more clear
> > > Thanks
> > > Cindy
> > sorry for the misunderstanding. The VDPA tool does not support
> > changing the MAC address after the guest is loaded. I think I can add
> > a check for VIRTIO_CONFIG_S_DRIVER_OK here?
>
> Still racy, and I think we probably don't worry about that case. It's
> the fault of the mgmt layer not us.
>
> Thanks
>
Sure, Thanks Jason. will send a new version soon
Thanks
cindy
> > Thanks
> > cindy
> > > > > > +       }
> > > > > > +       return err;
> > > > >
> > > > > Similar to net simulator, how could be serialize the modification=
 to
> > > > > mac address:
> > > > >
> > > > > 1) from vdpa tool
> > > > > 2) via control virtqueue
> > > > >
> > > > > Thanks
> > > > >
> > > > > > +}
> > > > > >
> > > > > >  static const struct vdpa_mgmtdev_ops mdev_ops =3D {
> > > > > >         .dev_add =3D mlx5_vdpa_dev_add,
> > > > > >         .dev_del =3D mlx5_vdpa_dev_del,
> > > > > > +       .dev_set_attr =3D mlx5_vdpa_set_attr,
> > > > > >  };
> > > > > >
> > > > > >  static struct virtio_device_id id_table[] =3D {
> > > > > > --
> > > > > > 2.45.0
> > > > > >
> > > > >
> > > > Thanks,
> > > > Dragos
> >
>


