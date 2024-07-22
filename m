Return-Path: <linux-kernel+bounces-258617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8F85938A8C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 09:57:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 23622B216FC
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 07:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED3F2161326;
	Mon, 22 Jul 2024 07:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dC9AT6yD"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6725D16087B
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 07:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721635045; cv=none; b=U5Ujafoi4/MHwS1UOf7LlVwfh4XSxdolBP9wa+DPgXt2IVHlFfimQeQmdJVMAwRHkRx6a3IqgZILHSOhu3ZECNDbE1CAym51YBKc909Ww8ROknZ31sKxZ2u7VPW0v134Z4DH5W7YjrZuLyfA5SmJAH+Rkcc3a32ZCAE4ieEGH2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721635045; c=relaxed/simple;
	bh=HWNPQ/1vUrq7iKlpWAUp1cUMrSt4KvhLV953piOX8g8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dYBSLhPrXlPwNF08nD4tc+Wpl/Tl98dcuKpCbHYdAU2LD0ZltK1ZrQe52PkB4DaGn5+dBS4KaiJad71V+21PgSXQ40ZzT7YIbCU7ZEsW7/uCNReGB8LPC0xj7n3ahQFRiyQnJTxwnIZiKUtFqVgTGVlrSjKUFdQDFjx97iVXKRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dC9AT6yD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721635042;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YQEopZwHga4C7qzVJPruzVlevn1Kn/ATvarPGUPiBhY=;
	b=dC9AT6yDbhN12Q1SkXFoLFJogupoRhqRhKyaJHC1yZ3CwgCkInAA4xi0DFyQ3dY2EB3gFW
	1QQbK1FA6eXg1iaIrbEYFh+MCeKFE/NOIZYLvLLQJwdNbaP2OoRQpRBr0TsqZ97ivjxrs8
	G8bAma1NcAmaFAeGUD/0l5vpZ0+qjHs=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-607-lbnSZAkROOKOQGGVGd7Ecg-1; Mon, 22 Jul 2024 03:57:17 -0400
X-MC-Unique: lbnSZAkROOKOQGGVGd7Ecg-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2ef311ad4bcso4975491fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 00:57:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721635035; x=1722239835;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YQEopZwHga4C7qzVJPruzVlevn1Kn/ATvarPGUPiBhY=;
        b=wN1FaGhBrnJ1LeZwvMqRLvwf2Z204kfglBvDRezSj1psngEvl0w2kvtukVGEPe/GKj
         lQwCFBnPI8gF8iNhoEIEYziX1OBgtxStUlptlIDxzDXayObA2uzKdh8wMNCY85lq2Xth
         o+6ORYFCbb141HwLiZZgqTrq6fMFVMJ08N49vdnVeGLuQpgeHcDxN7Njbmd1envrGTRo
         w31FfORDSGPabQWat2zfZBLWs5MZ6kIZdgI3rICvoSDZLLPZDKM5MGKTj/Z/PdHrHGVl
         LpJkU1dZrTXO5qX0IEnz58YVnjrA+dw3/ucTcgD1PNW2/KUrOv2UO0W40p3DURIGgAax
         dMLg==
X-Forwarded-Encrypted: i=1; AJvYcCUWYiPPpxhg2oaphn9E6wgmBvDlz0m4RGYwMVPOGiUTHtBNy2+teX5yXoqCBlGAPIdsyikCRxONvpGk3xkY97Y9ou4Lp3isFIodxJa0
X-Gm-Message-State: AOJu0Yz9pYwKl77oz87PJf26q+8oBkfDFEcPyuj5qp3ZEdBGurlQkGdu
	3Z8hOFrDuZlbT7k9UMZLmbpp4nMOZoV765maTzR9RI+Z5lt7pGzfa4aDdk8sRl10w7vAssP98Iw
	w9wl+5Wfhj8oNJYRcboBXmco8CNCJcFQUJwmA+qkGYOD+kX+qcZytd3+o/jDXIDSRlLN7+zcCMl
	bsnqoum7Vl3N7y5MG5qT9brQzCxm5h/X/SDpuG0BXIyG0UaWk=
X-Received: by 2002:a05:651c:50d:b0:2ef:17ee:62b0 with SMTP id 38308e7fff4ca-2ef17ee6747mr44078041fa.2.1721635035150;
        Mon, 22 Jul 2024 00:57:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFYfWrHNz6DUflgtw/ZcTjXibd8jwa6+RV9ykMQ9YOOIBFKj5ChXg/RudR/hIBIlgmdHIluX8YxfscwNFeCP2U=
X-Received: by 2002:a05:651c:50d:b0:2ef:17ee:62b0 with SMTP id
 38308e7fff4ca-2ef17ee6747mr44077821fa.2.1721635034786; Mon, 22 Jul 2024
 00:57:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240722010625.1016854-1-lulu@redhat.com> <20240722010625.1016854-3-lulu@redhat.com>
 <CACGkMEtq=2yO=4te+qQxwSzi4G-4E_kdq=tCQq_N94Pk8Ro3Zw@mail.gmail.com>
In-Reply-To: <CACGkMEtq=2yO=4te+qQxwSzi4G-4E_kdq=tCQq_N94Pk8Ro3Zw@mail.gmail.com>
From: Cindy Lu <lulu@redhat.com>
Date: Mon, 22 Jul 2024 15:56:38 +0800
Message-ID: <CACLfguUaDo3seJZT_yQNp_fa4bELHwwAb8OTbXGwBLw2fGdj+w@mail.gmail.com>
Subject: Re: [PATH v4 2/3] vdpa_sim_net: Add the support of set mac address
To: Jason Wang <jasowang@redhat.com>
Cc: dtatulea@nvidia.com, mst@redhat.com, parav@nvidia.com, sgarzare@redhat.com, 
	netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 22 Jul 2024 at 15:48, Jason Wang <jasowang@redhat.com> wrote:
>
> On Mon, Jul 22, 2024 at 9:06=E2=80=AFAM Cindy Lu <lulu@redhat.com> wrote:
> >
> > Add the function to support setting the MAC address.
> > For vdpa_sim_net, the driver will write the MAC address
> > to the config space, and other devices can implement
> > their own functions to support this.
> >
> > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > ---
> >  drivers/vdpa/vdpa_sim/vdpa_sim_net.c | 22 +++++++++++++++++++++-
> >  1 file changed, 21 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c b/drivers/vdpa/vdpa_s=
im/vdpa_sim_net.c
> > index cfe962911804..936e33e5021a 100644
> > --- a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
> > +++ b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
> > @@ -414,6 +414,25 @@ static void vdpasim_net_get_config(struct vdpasim =
*vdpasim, void *config)
> >         net_config->status =3D cpu_to_vdpasim16(vdpasim, VIRTIO_NET_S_L=
INK_UP);
> >  }
> >
> > +static int vdpasim_net_set_attr(struct vdpa_mgmt_dev *mdev,
> > +                               struct vdpa_device *dev,
> > +                               const struct vdpa_dev_set_config *confi=
g)
> > +{
> > +       struct vdpasim *vdpasim =3D container_of(dev, struct vdpasim, v=
dpa);
> > +       struct virtio_net_config *vio_config =3D vdpasim->config;
> > +
> > +       mutex_lock(&vdpasim->mutex);
> > +
> > +       if (config->mask & (1 << VDPA_ATTR_DEV_NET_CFG_MACADDR)) {
> > +               memcpy(vio_config->mac, config->net.mac, ETH_ALEN);
> > +               mutex_unlock(&vdpasim->mutex);
> > +               return 0;
> > +       }
> > +
> > +       mutex_unlock(&vdpasim->mutex);
>
> Do we need to protect:
>
>         case VIRTIO_NET_CTRL_MAC_ADDR_SET:
> read =3D vringh_iov_pull_iotlb(&cvq->vring, &cvq->in_iov,
>                                              vio_config->mac, ETH_ALEN);
>                 if (read =3D=3D ETH_ALEN)
>                         status =3D VIRTIO_NET_OK;
>                 break;
>
> As both are modifying vio_config?
>
> Thanks
>
i have added a lock for this; CVQ also needs to take this lock to
change the MAC address.I thinks maybe this can protect?
Do you mean I need to compare the mac address from the vdpa_tool and
mac address in vio_config?
this vdpa tool should not be used after the guest load, if this is
different this is also acceptable
thanks
Cindy

> > +       return -EINVAL;
> > +}
> > +
> >  static void vdpasim_net_setup_config(struct vdpasim *vdpasim,
> >                                      const struct vdpa_dev_set_config *=
config)
> >  {
> > @@ -510,7 +529,8 @@ static void vdpasim_net_dev_del(struct vdpa_mgmt_de=
v *mdev,
> >
> >  static const struct vdpa_mgmtdev_ops vdpasim_net_mgmtdev_ops =3D {
> >         .dev_add =3D vdpasim_net_dev_add,
> > -       .dev_del =3D vdpasim_net_dev_del
> > +       .dev_del =3D vdpasim_net_dev_del,
> > +       .dev_set_attr =3D vdpasim_net_set_attr
> >  };
> >
> >  static struct virtio_device_id id_table[] =3D {
> > --
> > 2.45.0
> >
>


