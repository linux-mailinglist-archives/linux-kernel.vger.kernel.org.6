Return-Path: <linux-kernel+bounces-258623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D2E6938A9D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 10:01:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 894E7B213F9
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 08:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB0631607BC;
	Mon, 22 Jul 2024 08:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IcAWLjVn"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4338218E1F
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 08:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721635269; cv=none; b=kwOYULkKr+/UeQPwC8YKJq+TgEgh727KHDSHSUpNJuxVCQDkIbWNZKa57D1XlmTlZ9cfc6NxXEk7LLtzFopqD9KjO+RVsumR5Cg+CUgir5DjMZrsW9UtrHNucQl+/LuTj+mpkQ+p3uO+T5fvlNvN+1s+hggMv5zXZI9rjHolkTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721635269; c=relaxed/simple;
	bh=cv/eDdj7rZ/lIOc0x55LCidh/0YmyV8Os80FAWnpRw4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pfzH+4nkyrZiRhvU5voD2IWhanUU8KX4dIWTvkO4BnuMOyC/J4bUjPhEQfF6ariWnnLOokR0BZlDbeBog5W+1W0KznuBE4VXngFCM3K/Xzw5jwrzZz18b69X43CH88YwX0m2kjQOQshswem125RKxsAzUFWagS9ZmfWvjXtTtX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IcAWLjVn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721635267;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5QUfD1YmeCwI0P0HIWL0IY21aE8P6LAnbhy1oMHSUJ0=;
	b=IcAWLjVn95xgrv1GNeuwgfZLdt2hCI8GeN/G1r30geJQMI5nB+4sYIikxzKXGD5gkdVrOj
	q5lkfvJb/AlkBXWiGd3GxgfhiLbFVe+s1lLz7VBQYBFMohVqGFMV2XqM5Swmb2Io2AqIjs
	RkOQn1c00xzaRFl/8wFdsHTj/ZU4S+w=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-447-ur9YtOLHPXiq17HuCFLzEg-1; Mon, 22 Jul 2024 04:01:05 -0400
X-MC-Unique: ur9YtOLHPXiq17HuCFLzEg-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2cb6f2b965dso4670994a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 01:01:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721635264; x=1722240064;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5QUfD1YmeCwI0P0HIWL0IY21aE8P6LAnbhy1oMHSUJ0=;
        b=FYjs+tj0NQdPtMhG7vwECWdUOOslXMTHwBq9Ez9IZm4Myg5um4we2j4qDYuqt1BvoU
         eVMVBk3L1dllGFteVN7vt9CjJdLiEAV3T2wGEcFNR4ygGM+GRg52diiMKHIFDMBsTa0L
         ieFn5CRYwJVoOayQdeYsQ76L5jXlBfaP0u0QcxI3pcgjVg515Ib9+yqyhM7nAbsMvQuc
         X/swi1rp5SJw/m2QrAoa6kBse0m/FThKGVJt6vZjqYkHZOXhJcFvTO5beqYE8GpPSKQb
         DL5VwXKbZkalqudx7f5eAwnxHzziMfp7yISGtB1ma25o8gIXRJ6C66Mi/9wgNwGpVURL
         eOHw==
X-Forwarded-Encrypted: i=1; AJvYcCVo/0lsWK2CKXH5o5j2KDcNVq4IiWxNrMMt0BydSdvA8b7X1ObU7rEi4+WQrraDryrqTnr7caydknLtr/z+tw00SgbzUAFJMHC5TCQ7
X-Gm-Message-State: AOJu0Yz37OyAuleyroD2vG/DE1Dg8GMsOK20FolHe3xhgfbZmYxdznMN
	Jm3c6nqetm9eymPCPjqYiCDPTDbRBJTL+iPlIrYuJIwBLRYbP4gOfzGpYnx9KFBsbYAGh/x+SbY
	SQ8Cwqe4Yk8Lv5AoxBGrhJ8Nzod5ATE3CJWDYWuRgcXCPYfXZyFSgogYuU6fi/iozyCeXL0WSbf
	F+lVjTO9ZWK63+7QOO22sBfw3dmIigTmlayhuF
X-Received: by 2002:a17:90a:7307:b0:2c9:81fd:4c27 with SMTP id 98e67ed59e1d1-2cd27415a88mr4770840a91.14.1721635264305;
        Mon, 22 Jul 2024 01:01:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGnOmbWFvxTc12Z/fU+czmUDIC3h6M95FI8NXEVLeHz/NV5eKtoYowMl6E64RVLXQ+V70jH1p++bYnSZzFW3MI=
X-Received: by 2002:a17:90a:7307:b0:2c9:81fd:4c27 with SMTP id
 98e67ed59e1d1-2cd27415a88mr4770811a91.14.1721635263773; Mon, 22 Jul 2024
 01:01:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240722010625.1016854-1-lulu@redhat.com> <20240722010625.1016854-3-lulu@redhat.com>
 <CACGkMEtq=2yO=4te+qQxwSzi4G-4E_kdq=tCQq_N94Pk8Ro3Zw@mail.gmail.com> <CACLfguUaDo3seJZT_yQNp_fa4bELHwwAb8OTbXGwBLw2fGdj+w@mail.gmail.com>
In-Reply-To: <CACLfguUaDo3seJZT_yQNp_fa4bELHwwAb8OTbXGwBLw2fGdj+w@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 22 Jul 2024 16:00:52 +0800
Message-ID: <CACGkMEvT-j3GNq0C8nx_oy0KoqgAGhMwJwXbAXPjomkouNxEgg@mail.gmail.com>
Subject: Re: [PATH v4 2/3] vdpa_sim_net: Add the support of set mac address
To: Cindy Lu <lulu@redhat.com>
Cc: dtatulea@nvidia.com, mst@redhat.com, parav@nvidia.com, sgarzare@redhat.com, 
	netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 22, 2024 at 3:57=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
>
> On Mon, 22 Jul 2024 at 15:48, Jason Wang <jasowang@redhat.com> wrote:
> >
> > On Mon, Jul 22, 2024 at 9:06=E2=80=AFAM Cindy Lu <lulu@redhat.com> wrot=
e:
> > >
> > > Add the function to support setting the MAC address.
> > > For vdpa_sim_net, the driver will write the MAC address
> > > to the config space, and other devices can implement
> > > their own functions to support this.
> > >
> > > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > > ---
> > >  drivers/vdpa/vdpa_sim/vdpa_sim_net.c | 22 +++++++++++++++++++++-
> > >  1 file changed, 21 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c b/drivers/vdpa/vdpa=
_sim/vdpa_sim_net.c
> > > index cfe962911804..936e33e5021a 100644
> > > --- a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
> > > +++ b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
> > > @@ -414,6 +414,25 @@ static void vdpasim_net_get_config(struct vdpasi=
m *vdpasim, void *config)
> > >         net_config->status =3D cpu_to_vdpasim16(vdpasim, VIRTIO_NET_S=
_LINK_UP);
> > >  }
> > >
> > > +static int vdpasim_net_set_attr(struct vdpa_mgmt_dev *mdev,
> > > +                               struct vdpa_device *dev,
> > > +                               const struct vdpa_dev_set_config *con=
fig)
> > > +{
> > > +       struct vdpasim *vdpasim =3D container_of(dev, struct vdpasim,=
 vdpa);
> > > +       struct virtio_net_config *vio_config =3D vdpasim->config;
> > > +
> > > +       mutex_lock(&vdpasim->mutex);
> > > +
> > > +       if (config->mask & (1 << VDPA_ATTR_DEV_NET_CFG_MACADDR)) {
> > > +               memcpy(vio_config->mac, config->net.mac, ETH_ALEN);
> > > +               mutex_unlock(&vdpasim->mutex);
> > > +               return 0;
> > > +       }
> > > +
> > > +       mutex_unlock(&vdpasim->mutex);
> >
> > Do we need to protect:
> >
> >         case VIRTIO_NET_CTRL_MAC_ADDR_SET:
> > read =3D vringh_iov_pull_iotlb(&cvq->vring, &cvq->in_iov,
> >                                              vio_config->mac, ETH_ALEN)=
;
> >                 if (read =3D=3D ETH_ALEN)
> >                         status =3D VIRTIO_NET_OK;
> >                 break;
> >
> > As both are modifying vio_config?
> >
> > Thanks
> >
> i have added a lock for this; CVQ also needs to take this lock to
> change the MAC address.I thinks maybe this can protect?

Right, I miss that it is done in the vdpasim_net_work().

> Do you mean I need to compare the mac address from the vdpa_tool and
> mac address in vio_config?
> this vdpa tool should not be used after the guest load, if this is
> different this is also acceptable
> thanks

The patch looks good then.

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

> Cindy
>
> > > +       return -EINVAL;
> > > +}
> > > +
> > >  static void vdpasim_net_setup_config(struct vdpasim *vdpasim,
> > >                                      const struct vdpa_dev_set_config=
 *config)
> > >  {
> > > @@ -510,7 +529,8 @@ static void vdpasim_net_dev_del(struct vdpa_mgmt_=
dev *mdev,
> > >
> > >  static const struct vdpa_mgmtdev_ops vdpasim_net_mgmtdev_ops =3D {
> > >         .dev_add =3D vdpasim_net_dev_add,
> > > -       .dev_del =3D vdpasim_net_dev_del
> > > +       .dev_del =3D vdpasim_net_dev_del,
> > > +       .dev_set_attr =3D vdpasim_net_set_attr
> > >  };
> > >
> > >  static struct virtio_device_id id_table[] =3D {
> > > --
> > > 2.45.0
> > >
> >
>


