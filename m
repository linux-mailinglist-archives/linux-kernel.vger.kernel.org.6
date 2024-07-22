Return-Path: <linux-kernel+bounces-258983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB955938F76
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 14:56:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8185A280D0D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 12:56:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3E7916D9D4;
	Mon, 22 Jul 2024 12:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mpq1lENV"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59AF116D9C9
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 12:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721652965; cv=none; b=boo3tYprHenJLINhisEizrLCy79/GDKTp9Y6/edciSl2Tus5SewK/OYYPNR+J3N0qhvVschzXATHHoWiors25y+/QXmZ31YU7jFkNgJ134rjGn9HbEyaOcwIVsjwgsBQGhlNNMiQ5EbsMnDtLnxf8AGDajsEE651P2kyt1cgEMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721652965; c=relaxed/simple;
	bh=JZLYf0wsystlScoz0eEY4VxzQQcKUBE/9MHVicMM8II=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e5tOhznpxDg+NVXQscV6S3iZJJvcmuBXksC3gM+BoMXPN3iCDEFbwu5xqLa3YyF0at/Et6CedQ/O78xOd/2+Eccbt8UMenWQvRD2zGKELCeY7l1/A04XjN1a2e0SsxHub0PjI7lROJHnt1XW9GZLkpsTf9iWTqLbpL3YFhlnSD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Mpq1lENV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721652961;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JJVNq97qnVdAr/18tmluAm4AREjAa0bHQTkX1v3BnY0=;
	b=Mpq1lENVO3nSuFBnSGv08t4UCv8nKBxobcHHc2HPMS3yxAg7kmbz0zZvQYbO/OGuYKjpNT
	HY09yf8S09gbhPnZGGSL/fca/IM/Td35r933mNDKXUIA4JtoVQa7xLS6JnImk6jlP1yQbz
	wehVlZKsRsxZKvqKcmwUBi3+66gP4Nc=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-146-If_i04ulMW23Ysuur3OdnA-1; Mon, 22 Jul 2024 08:56:00 -0400
X-MC-Unique: If_i04ulMW23Ysuur3OdnA-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-5a2c84a3bbaso3389138a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 05:56:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721652959; x=1722257759;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JJVNq97qnVdAr/18tmluAm4AREjAa0bHQTkX1v3BnY0=;
        b=ucuF/ggfWrBPsc7Vaq/98CWdaLMLYoCORbUXA5Q3B1vi1/tIoLF83Q7paYxP8LbIoJ
         bHXYpmZXirLRVqkdHexR7F6//kD3myhkE4NhvETlBfFkIa3ws1mNkT9vvQEdfSxU3QkX
         bqys0fdKhbl+TWkaHWj7rduwmIZ/VGVwGPaWw6T/wMGEJKEmYYPb6nfUYR6qX5LQBg54
         0nCxouqHHfYwFzYWXMgS4CVZboL9KiFojaUZ5aMbdKo4/rVfxxoqRl+ZCpoA5ACPVR9v
         ee4UJpwWkZOGiOwZ5t57lU51G9yhZi6n37I9MW+qY7K9o7DlOtfMKxOBLk2MW81kDYcw
         vTbw==
X-Forwarded-Encrypted: i=1; AJvYcCW6Vu4qPTk0r4yZowz6xXQwtnZ/VwaVXJLqV3VaX43JJoIieWt4lmWZG6cA/qTl4B64SUr69ZBqsr9vz26UPz+u9BbexQP1vW1ttdgk
X-Gm-Message-State: AOJu0YwN0vL57eXU3G/7HhgkVTN32+XXDcA2K9rOg8XqlhxSb2Qgy9Ee
	8mExcPTakPsq/CPrd3JdPNBDwqgkN8sMMlXhemn1wP53/kxPOEggrWbM1XRJtp+uPgmiSe3rUuW
	25lyauxGGHQRPhuC54hrYH+JiQbwfYsnwvGzbMkO6YDCoFk1YuMcjMSuVvhL43anu2IhYFCVQ23
	EnM1hgncyR/kyp2l5Q0yU5TY5KW1cgxeLHMcOY
X-Received: by 2002:a05:6402:2710:b0:5a2:69f9:1fe7 with SMTP id 4fb4d7f45d1cf-5a47b5c0b38mr4441760a12.35.1721652959414;
        Mon, 22 Jul 2024 05:55:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHoczppy1uFSf8Ce5bOr4QQLzSZiqqNznaHB9kc0dNoTPng5nEUdTnupdY6jWQpNPwWvx5HiWx06BR6DpqS8NE=
X-Received: by 2002:a05:6402:2710:b0:5a2:69f9:1fe7 with SMTP id
 4fb4d7f45d1cf-5a47b5c0b38mr4441749a12.35.1721652959078; Mon, 22 Jul 2024
 05:55:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240722010625.1016854-1-lulu@redhat.com> <20240722010625.1016854-4-lulu@redhat.com>
 <CACGkMEvXk8_sXRtugePAMv8PM0qGU-su0eFUsFZ=-=_TjcGZNg@mail.gmail.com> <7a4d99e0f16cbe91000c3c780334a4c866904182.camel@nvidia.com>
In-Reply-To: <7a4d99e0f16cbe91000c3c780334a4c866904182.camel@nvidia.com>
From: Cindy Lu <lulu@redhat.com>
Date: Mon, 22 Jul 2024 20:55:22 +0800
Message-ID: <CACLfguUR_hdJGDcjnmYY=qOXFiSnsBsXD5evTDZQi=K0RM4gZQ@mail.gmail.com>
Subject: Re: [PATH v4 3/3] vdpa/mlx5: Add the support of set mac address
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: "jasowang@redhat.com" <jasowang@redhat.com>, "sgarzare@redhat.com" <sgarzare@redhat.com>, 
	Parav Pandit <parav@nvidia.com>, "mst@redhat.com" <mst@redhat.com>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 22 Jul 2024 at 17:45, Dragos Tatulea <dtatulea@nvidia.com> wrote:
>
> On Mon, 2024-07-22 at 15:48 +0800, Jason Wang wrote:
> > On Mon, Jul 22, 2024 at 9:06=E2=80=AFAM Cindy Lu <lulu@redhat.com> wrot=
e:
> > >
> > > Add the function to support setting the MAC address.
> > > For vdpa/mlx5, the function will use mlx5_mpfs_add_mac
> > > to set the mac address
> > >
> > > Tested in ConnectX-6 Dx device
> > >
> > > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > > ---
> > >  drivers/vdpa/mlx5/net/mlx5_vnet.c | 25 +++++++++++++++++++++++++
> > >  1 file changed, 25 insertions(+)
> > >
> > > diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/ne=
t/mlx5_vnet.c
> > > index ecfc16151d61..415b527a9c72 100644
> > > --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > @@ -3785,10 +3785,35 @@ static void mlx5_vdpa_dev_del(struct vdpa_mgm=
t_dev *v_mdev, struct vdpa_device *
> > >         destroy_workqueue(wq);
> > >         mgtdev->ndev =3D NULL;
> > >  }
> > > +static int mlx5_vdpa_set_attr(struct vdpa_mgmt_dev *v_mdev,
> > > +                             struct vdpa_device *dev,
> > > +                             const struct vdpa_dev_set_config *add_c=
onfig)
> > > +{
> > > +       struct mlx5_vdpa_dev *mvdev;
> > > +       struct mlx5_vdpa_net *ndev;
> > > +       struct mlx5_core_dev *mdev;
> > > +       struct virtio_net_config *config;
> > > +       struct mlx5_core_dev *pfmdev;
> Reverse xmas tree?
>
will fix this
> > > +       int err =3D -EOPNOTSUPP;
> > > +
> > > +       mvdev =3D to_mvdev(dev);
> > > +       ndev =3D to_mlx5_vdpa_ndev(mvdev);
> > > +       mdev =3D mvdev->mdev;
> > > +       config =3D &ndev->config;
> > > +
> You still need to take the ndev->reslock.
>
sure, will do
> > > +       if (add_config->mask & (1 << VDPA_ATTR_DEV_NET_CFG_MACADDR)) =
{
> > > +               pfmdev =3D pci_get_drvdata(pci_physfn(mdev->pdev));
> > > +               err =3D mlx5_mpfs_add_mac(pfmdev, config->mac);
> > > +               if (!err)
> > > +                       memcpy(config->mac, add_config->net.mac, ETH_=
ALEN);
> What is the expected behaviour when the device is in use?
>
if the err is 0 then copy the Mac address to config
will change this code to make it more clear
Thanks
Cindy
> > > +       }
> > > +       return err;
> >
> > Similar to net simulator, how could be serialize the modification to
> > mac address:
> >
> > 1) from vdpa tool
> > 2) via control virtqueue
> >
> > Thanks
> >
> > > +}
> > >
> > >  static const struct vdpa_mgmtdev_ops mdev_ops =3D {
> > >         .dev_add =3D mlx5_vdpa_dev_add,
> > >         .dev_del =3D mlx5_vdpa_dev_del,
> > > +       .dev_set_attr =3D mlx5_vdpa_set_attr,
> > >  };
> > >
> > >  static struct virtio_device_id id_table[] =3D {
> > > --
> > > 2.45.0
> > >
> >
> Thanks,
> Dragos


