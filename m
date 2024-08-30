Return-Path: <linux-kernel+bounces-307941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D9F2296553F
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 04:32:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 540721F241DE
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 02:32:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 992FB82D98;
	Fri, 30 Aug 2024 02:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b9CHbrU1"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D26EA2905
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 02:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724985121; cv=none; b=TpqL3B6V6+J7aH106k0aq/xwTRgsLwuc2tcygsiMnTIHQEie5rvNWEytYMahojS/4F/Ct+oyoFhuIpxufIDyk8g8SmuNLVvxmXFCeJSuFKSZU2j7/DmQMczxEXwH6L6yz16lxLDu9cuzzLlXlRGhYBAJA8w9PJYpdt9PET99TsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724985121; c=relaxed/simple;
	bh=JgrCcy4ABRltJafLAgpbwL1QqiNqIHG65m16zukYj8k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=myvnF1CQlS13WqMjCd+FQVQvgD3u5SnOibK/+29hy99PCDYKYJyZ6/jejAxtWt6O1VAiJtErIVsRBcLsdsJoYzZ0liaFzBpaQJ1apia1K1HGbs1XAwLryj/bSpZBxqhZ+fya8Bp3G5t0cNjvszWhZY8K1vbCbEC86kMJTy3+Rz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b9CHbrU1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724985118;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SiHCn+RS2P+GOp87zAp9AO8uaVFW3bWgsV8LIZZeZ04=;
	b=b9CHbrU1CXO+hNQl3fjMwcXNmbXKlCU+WXzTIFtifK7vDzfDFh6NAXKGERtS3zgi9myOs3
	wsDNIzPzl0t9VldscPJItXABnSLTOsvAdy23kEXcOS3h/q52FWrs8cVwI0849/MIBTyjaJ
	RN2z/TUZ2ukP3GzY84TWVMmV6UD69H0=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-412-3OY09uucM1OOKwusdupKGg-1; Thu, 29 Aug 2024 22:31:57 -0400
X-MC-Unique: 3OY09uucM1OOKwusdupKGg-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2d3c0088813so1322439a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 19:31:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724985116; x=1725589916;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SiHCn+RS2P+GOp87zAp9AO8uaVFW3bWgsV8LIZZeZ04=;
        b=i+YmT5Q+YJ+Hk5Y2vFfEq7RhWvLMNsFqegJFOwkuGyetbu9Ee34JHsh1zTMHHfknRR
         3eZ+OSOifAfj8RG2QabJMHR+RPKyNwF4TUnYps0xvuhjl2fUKznco+eyQdnUsywvAKWw
         CtBqaGvhjFPY95gOLboYLrX3pTaqm+NZjwyZ8WkURiy9vOjLN1n+YVE3dCOdfeXFiNnX
         5MMrQLvd3OonlIe+KHPaJ3/KbzAICKSDc0EL6uMbs3FcDl50MqwRnROHWDYc+mDAYMSL
         AmEOD1yKDDkmj16KttUGg6WoR3I/cyQQdWcTDKZRByMF+Dx4drmfc4kX0v7xWknnj9QC
         K8cQ==
X-Forwarded-Encrypted: i=1; AJvYcCUPNRfqHNtwKKEVorrquxgNMut1jlUr5FVwQRTs6O57OdoLfZwl6KO/CcEJOLKZ+G77/QMrHeIT8NC7sB4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtmoJUq6pbCqclofFVv3hNOb6/Pr2nmzjTMrBkhZA6fyyOPoFw
	/rlZ1n7mJDWtxBC3i5Yk31845GKzyjmdNrkyC1aD80A5qE7c9oLF6hiyZJX4sEg7cN6TuQfgldA
	LA91ZBsq1At/oAzt3f4w5j4wG/DZrfhpWmLXBUvgKB+W4baQuqJA/JoRaT6SbRFBinOfvl2naSL
	GRSHsjNljbuh5EpyJCKf5qCigOo+9qaSKIrkB0
X-Received: by 2002:a17:90b:23c9:b0:2d3:c863:cf16 with SMTP id 98e67ed59e1d1-2d856394802mr5161100a91.33.1724985115959;
        Thu, 29 Aug 2024 19:31:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEnsgJ4lUBb3fVdQdm/SYPMNIFmWVuDQ5BaDXg9tFeBxfXR5W8m9NgaFtFBRI6MxpNs+eqO+YoZqa7tXBjhXAU=
X-Received: by 2002:a17:90b:23c9:b0:2d3:c863:cf16 with SMTP id
 98e67ed59e1d1-2d856394802mr5161071a91.33.1724985115386; Thu, 29 Aug 2024
 19:31:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240829161620.38679-1-carlos.bilbao.osdev@gmail.com>
 <20240829161620.38679-3-carlos.bilbao.osdev@gmail.com> <c15d3682-05ee-437c-b51c-d6a824252d76@nvidia.com>
In-Reply-To: <c15d3682-05ee-437c-b51c-d6a824252d76@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 30 Aug 2024 10:31:44 +0800
Message-ID: <CACGkMEtDSDTS_SVvsf7nwMdabGCN85P-r5WpjgZdVDV5PMdc0g@mail.gmail.com>
Subject: Re: [PATCH 2/2] vdpa: Add support to update speed/duplex in vDPA/mlx5_vnet
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: Carlos Bilbao <carlos.bilbao.osdev@gmail.com>, mst@redhat.com, bilbao@vt.edu, 
	xuanzhuo@linux.alibaba.com, eperezma@redhat.com, cratiu@nvidia.com, 
	lingshan.zhu@intel.com, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Carlos Bilbao <cbilbao@digitalocean.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 30, 2024 at 5:08=E2=80=AFAM Dragos Tatulea <dtatulea@nvidia.com=
> wrote:
>
> (resending as I accidentally replied only to Carlos)
>
> On 29.08.24 18:16, Carlos Bilbao wrote:
> > From: Carlos Bilbao <cbilbao@digitalocean.com>
> >
> > Include support to update the vDPA configuration fields of speed and
> > duplex (as needed by VHOST_VDPA_SET_CONFIG). This includes function
> > mlx5_vdpa_set_config() as well as changes in vdpa.c to fill the initial
> > values to UNKNOWN. Also add a warning message for when
> > mlx5_vdpa_get_config() receives offset and length out of bounds.
> >
> > Signed-off-by: Carlos Bilbao <cbilbao@digitalocean.com>
> > ---
> >  drivers/vdpa/mlx5/net/mlx5_vnet.c | 34 ++++++++++++++++++++++++++++++-
> >  drivers/vdpa/vdpa.c               | 27 ++++++++++++++++++++++++
> >  include/uapi/linux/vdpa.h         |  2 ++
> >  3 files changed, 62 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/=
mlx5_vnet.c
> > index c47009a8b472..a44bb2072eec 100644
> > --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > @@ -3221,12 +3221,44 @@ static void mlx5_vdpa_get_config(struct vdpa_de=
vice *vdev, unsigned int offset,
> >
> >       if (offset + len <=3D sizeof(struct virtio_net_config))
> >               memcpy(buf, (u8 *)&ndev->config + offset, len);
> > +     else
> > +             mlx5_vdpa_warn(mvdev, "Offset and length out of bounds\n"=
);
> >  }
> >
> >  static void mlx5_vdpa_set_config(struct vdpa_device *vdev, unsigned in=
t offset, const void *buf,
> >                                unsigned int len)
> >  {
> > -     /* not supported */
> > +     struct mlx5_vdpa_dev *mvdev =3D to_mvdev(vdev);
> > +     struct mlx5_vdpa_net *ndev =3D to_mlx5_vdpa_ndev(mvdev);
> > +
> > +     if (offset + len > sizeof(struct virtio_net_config)) {
> > +             mlx5_vdpa_warn(mvdev, "Offset and length out of bounds\n"=
);
> > +             return;
> > +     }
> > +
> > +     /*
> > +      * Note that this will update the speed/duplex configuration fiel=
ds
> > +      * but the hardware support to actually perform this change does
> > +      * not exist yet.
> > +      */
> > +     switch (offset) {
> > +     case offsetof(struct virtio_net_config, speed):
> > +             if (len =3D=3D sizeof(((struct virtio_net_config *) 0)->s=
peed))
> > +                     memcpy(&ndev->config.speed, buf, len);
> > +             else
> > +                     mlx5_vdpa_warn(mvdev, "Invalid length for speed.\=
n");
> > +             break;
> > +
> > +     case offsetof(struct virtio_net_config, duplex):
> > +             if (len =3D=3D sizeof(((struct virtio_net_config *)0)->du=
plex))
> > +                     memcpy(&ndev->config.duplex, buf, len);
> > +             else
> > +                     mlx5_vdpa_warn(mvdev, "Invalid length for duplex.=
\n");
> > +             break;
> > +
> > +     default:
> > +             mlx5_vdpa_warn(mvdev, "Configuration field not supported.=
\n");
> This will trigger noise in dmesg because there is a MAC configuration her=
e.
> > +     }
> I would prefer that the .set_config remains a stub TBH. Setting the field=
s here is
> misleading: the user might deduce that the configuration worked when they=
 read the
> values and see that they were updated.

Yes, and actually, those fields are read-only according to the spec:

"""
The network device has the following device configuration layout. All
of the device configuration fields are read-only for the driver.
"""

Thanks

>
> Thanks,
> dragos
> >  }
> >
> >  static u32 mlx5_vdpa_get_generation(struct vdpa_device *vdev)
> > diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
> > index 4dbd2e55a288..b920e4405f6d 100644
> > --- a/drivers/vdpa/vdpa.c
> > +++ b/drivers/vdpa/vdpa.c
> > @@ -15,6 +15,7 @@
> >  #include <net/genetlink.h>
> >  #include <linux/mod_devicetable.h>
> >  #include <linux/virtio_ids.h>
> > +#include <uapi/linux/ethtool.h>
> >
> >  static LIST_HEAD(mdev_head);
> >  /* A global mutex that protects vdpa management device and device leve=
l operations. */
> > @@ -919,6 +920,22 @@ static int vdpa_dev_net_status_config_fill(struct =
sk_buff *msg, u64 features,
> >       return nla_put_u16(msg, VDPA_ATTR_DEV_NET_STATUS, val_u16);
> >  }
> >
> > +static int vdpa_dev_net_speed_config_fill(struct sk_buff *msg, u64 fea=
tures,
> > +                                     struct virtio_net_config *config)
> > +{
> > +     __le32 speed =3D cpu_to_le32(SPEED_UNKNOWN);
> > +
> > +     return nla_put(msg, VDPA_ATTR_DEV_NET_CFG_SPEED, sizeof(speed), &=
speed);
> > +}
> > +
> > +static int vdpa_dev_net_duplex_config_fill(struct sk_buff *msg, u64 fe=
atures,
> > +                                     struct virtio_net_config *config)
> > +{
> > +     u8 duplex =3D DUPLEX_UNKNOWN;
> > +
> > +     return nla_put(msg, VDPA_ATTR_DEV_NET_CFG_DUPLEX, sizeof(duplex),=
 &duplex);
> > +}
> > +
> >  static int vdpa_dev_net_config_fill(struct vdpa_device *vdev, struct s=
k_buff *msg)
> >  {
> >       struct virtio_net_config config =3D {};
> > @@ -940,6 +957,16 @@ static int vdpa_dev_net_config_fill(struct vdpa_de=
vice *vdev, struct sk_buff *ms
> >
> >       if (vdpa_dev_net_status_config_fill(msg, features_device, &config=
))
> >               return -EMSGSIZE;
> > +     /*
> > +      * mlx5_vdpa vDPA devicess currently do not support the
> > +      * VIRTIO_NET_F_SPEED_DUPLEX feature, which reports speed and
> > +      * duplex; hence these are set to UNKNOWN for now.
> > +      */
> > +     if (vdpa_dev_net_speed_config_fill(msg, features_device, &config)=
)
> > +             return -EMSGSIZE;
> > +
> > +     if (vdpa_dev_net_duplex_config_fill(msg, features_device, &config=
))
> > +             return -EMSGSIZE;
> >
> >       return vdpa_dev_net_mq_config_fill(msg, features_device, &config)=
;
> >  }
> > diff --git a/include/uapi/linux/vdpa.h b/include/uapi/linux/vdpa.h
> > index 842bf1201ac4..1c64ee0dd7b1 100644
> > --- a/include/uapi/linux/vdpa.h
> > +++ b/include/uapi/linux/vdpa.h
> > @@ -43,6 +43,8 @@ enum vdpa_attr {
> >       VDPA_ATTR_DEV_NET_STATUS,               /* u8 */
> >       VDPA_ATTR_DEV_NET_CFG_MAX_VQP,          /* u16 */
> >       VDPA_ATTR_DEV_NET_CFG_MTU,              /* u16 */
> > +     VDPA_ATTR_DEV_NET_CFG_SPEED,            /* u32 */
> > +     VDPA_ATTR_DEV_NET_CFG_DUPLEX,           /* u8 */
> >
> >       VDPA_ATTR_DEV_NEGOTIATED_FEATURES,      /* u64 */
> >       VDPA_ATTR_DEV_MGMTDEV_MAX_VQS,          /* u32 */
>


