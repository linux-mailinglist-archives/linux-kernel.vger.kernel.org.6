Return-Path: <linux-kernel+bounces-212647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1387990644D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 08:45:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3186284F76
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 06:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C262137C34;
	Thu, 13 Jun 2024 06:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C8SkEai+"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77CE22119
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 06:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718261138; cv=none; b=b0Ej9KxhGkOt+O2j7TmS/ci6jrkKGjwFfylVn3ZNpTLBmXB3pAqlXE6hnw+oQzogN2H5O3pBjFpz3JbLyVU7Bi5lV5EXBMuYkajH8WUfvvP95DfudAnPLdMJ/ZZXqd2oxM4FLTiuXkbrCHm18PoYJZ19J4GTXTSUsRkjJwCax30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718261138; c=relaxed/simple;
	bh=Ys2Cpp4pmssDa7lg5MrWy/T5Ixop45a9ihsxs2rok0M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YxBtK7OCcKKgpwjZFGeyAkMX8ZE0AZQRPQXw2vhDo8TFpj5IQBfJ81K3DtAQitKSIhYfW65lRATPRtWl3NoBQ/uwtrw4znAZB33m+93G6ZKEuuHTgsfpFDelZV2XK+j6zm8PvjEzb65DpmegAnp2aotJF0VwW272hsg9N9TRDeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C8SkEai+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718261134;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EaOBrgbdpnIFPucJH8WH9dmt441HfDwQ5TxqzEJgnt4=;
	b=C8SkEai+jmEmARc186K4/hujQLqnKtILEib29brH393PAvLdfp9bIu47M3DYkPVFEImLjF
	juBz5fkNi7Z4woJewSPKeIMsevlueGBv/RnggLD+2UVsz/tV3QvIcA7uX5iw3nf50+gM7G
	0mc5QMMqVe22mhTWiITPCJFF7BKfwIM=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-179-j_g5o61kMMqiZgV2lHXg-A-1; Thu, 13 Jun 2024 02:45:32 -0400
X-MC-Unique: j_g5o61kMMqiZgV2lHXg-A-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a6ef6ac6e0aso26793866b.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 23:45:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718261131; x=1718865931;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EaOBrgbdpnIFPucJH8WH9dmt441HfDwQ5TxqzEJgnt4=;
        b=VaUmIUuIkQme5YI51WkTLDti7ngxBR4HEiO+oM6bPgJ+TI/b1vppJAHZV3oluRL06Z
         x0CPHBcvfgPjpelB4qid/t0/MIb8b7fpCwcL11LFPKe5EaXW2WrzBIN/4vZwRshNqdV+
         ILvWNnyDh7czLnYxJX6rLEmmUjK7ApMBRJ9E4WNOTbDN/rtmdFSRTveE1A8fpZO7VyTs
         dbIVdxNvYlZIjAk+6tIe8czpsm4ihFevPRdBa+yfHPn40yvU/d9DMzGeUKCcDNuL9JnE
         udezRbiYNH5vGIlGuBrw6/GdOVvO92YgBmML5/2GZg/fi1THi5WCwExKF84AD89GQyPc
         YDJw==
X-Forwarded-Encrypted: i=1; AJvYcCVEt4P0J0N4bBqQRb6TZFdHSygFmx8qNyxwqY0PLWGJx2BCgA3wi8BNy+00y85vN+yKSgWD0MQm5n5AltyKJYpHVTzNik6Y2oKMmlF5
X-Gm-Message-State: AOJu0YwmkBVfJOQgz5sfylsI2ev3qUX036wfbKel6b2QwnB5acVxazJl
	NFPn6vtaM3IOQCUu/YAHrFxNRkiUwcrp8fTeB7YCVbcUOLMsRQDXQlmDFzfen+htzYvnHlkf9JT
	cqVHmpditp2qkR67i96qRrvIVim+JbufYx/WVlx7t+WMFSEXN3GUZJxiTQ8Cqa79EHQmAyBlEY2
	4Tb0ncs8f4DSWjif/QqePXUiYMlvI970JE6g55
X-Received: by 2002:a17:906:7f99:b0:a6f:4a2a:935e with SMTP id a640c23a62f3a-a6f4a2a94c6mr225852166b.18.1718261131434;
        Wed, 12 Jun 2024 23:45:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEYy4AwTtxZrHTSjOgm48lDP81zYFIgfIO/YCdS4gCzAk/Vn8nistPVRk9L5xS0hckO0zz2tvI4n7eld/zASPI=
X-Received: by 2002:a17:906:7f99:b0:a6f:4a2a:935e with SMTP id
 a640c23a62f3a-a6f4a2a94c6mr225851166b.18.1718261131016; Wed, 12 Jun 2024
 23:45:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240611053239.516996-1-lulu@redhat.com> <20240612014143-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240612014143-mutt-send-email-mst@kernel.org>
From: Cindy Lu <lulu@redhat.com>
Date: Thu, 13 Jun 2024 14:44:52 +0800
Message-ID: <CACLfguU53VpR=nvppx4BwGM=mi7j99Nr7yzEwd8zNY8ps0iBRQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] vdpa: support set mac address from vdpa tool
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: dtatulea@nvidia.com, jasowang@redhat.com, 
	virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 12, 2024 at 3:12=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Tue, Jun 11, 2024 at 01:32:32PM +0800, Cindy Lu wrote:
> > Add new UAPI to support the mac address from vdpa tool
>
> The patch does not do what commit log says.
> Instead there's an internal API to set mac and
> a UAPI to write into config space.
>
thanks, Michael, I will rewrite this part
Thanks
cindy
> > Function vdpa_nl_cmd_dev_config_set_doit() will get the
> > MAC address from the vdpa tool and then set it to the device.
> >
> > The usage is: vdpa dev set name vdpa_name mac **:**:**:**:**:**
> >
> > Here is sample:
> > root@L1# vdpa -jp dev config show vdpa0
> > {
> >     "config": {
> >         "vdpa0": {
> >             "mac": "82:4d:e9:5d:d7:e6",
> >             "link ": "up",
> >             "link_announce ": false,
> >             "mtu": 1500
> >         }
> >     }
> > }
> >
> > root@L1# vdpa dev set name vdpa0 mac 00:11:22:33:44:55
> >
> > root@L1# vdpa -jp dev config show vdpa0
> > {
> >     "config": {
> >         "vdpa0": {
> >             "mac": "00:11:22:33:44:55",
> >             "link ": "up",
> >             "link_announce ": false,
> >             "mtu": 1500
> >         }
> >     }
> > }
> >
> > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > ---
> >  drivers/vdpa/vdpa.c       | 71 +++++++++++++++++++++++++++++++++++++++
> >  include/linux/vdpa.h      |  2 ++
> >  include/uapi/linux/vdpa.h |  1 +
> >  3 files changed, 74 insertions(+)
> >
> > diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
> > index a7612e0783b3..347ae6e7749d 100644
> > --- a/drivers/vdpa/vdpa.c
> > +++ b/drivers/vdpa/vdpa.c
> > @@ -1149,6 +1149,72 @@ static int vdpa_nl_cmd_dev_config_get_doit(struc=
t sk_buff *skb, struct genl_info
> >       return err;
> >  }
> >
> > +static int vdpa_nl_cmd_dev_config_set_doit(struct sk_buff *skb,
> > +                                        struct genl_info *info)
> > +{
> > +     struct vdpa_dev_set_config set_config =3D {};
> > +     struct nlattr **nl_attrs =3D info->attrs;
> > +     struct vdpa_mgmt_dev *mdev;
> > +     const u8 *macaddr;
> > +     const char *name;
> > +     int err =3D 0;
> > +     struct device *dev;
> > +     struct vdpa_device *vdev;
> > +
> > +     if (!info->attrs[VDPA_ATTR_DEV_NAME])
> > +             return -EINVAL;
> > +
> > +     name =3D nla_data(info->attrs[VDPA_ATTR_DEV_NAME]);
> > +
> > +     down_write(&vdpa_dev_lock);
> > +     dev =3D bus_find_device(&vdpa_bus, NULL, name, vdpa_name_match);
> > +     if (!dev) {
> > +             NL_SET_ERR_MSG_MOD(info->extack, "device not found");
> > +             err =3D -ENODEV;
> > +             goto dev_err;
> > +     }
> > +     vdev =3D container_of(dev, struct vdpa_device, dev);
> > +     if (!vdev->mdev) {
> > +             NL_SET_ERR_MSG_MOD(
> > +                     info->extack,
> > +                     "Fail to find the specified management device");
> > +             err =3D -EINVAL;
> > +             goto mdev_err;
> > +     }
> > +     mdev =3D vdev->mdev;
> > +     if (nl_attrs[VDPA_ATTR_DEV_NET_CFG_MACADDR]) {
> > +             if (!(mdev->supported_features & BIT_ULL(VIRTIO_NET_F_MAC=
))) {
>
>
> Seems to poke at a device without even making sure it's a network
> device.
>
sure ,will add the check
Thansk
cindy
> > +                     NL_SET_ERR_MSG_FMT_MOD(
> > +                             info->extack,
> > +                             "Missing features 0x%llx for provided att=
ributes",
> > +                             BIT_ULL(VIRTIO_NET_F_MAC));
> > +                     err =3D -EINVAL;
> > +                     goto mdev_err;
> > +             }
> > +             macaddr =3D nla_data(nl_attrs[VDPA_ATTR_DEV_NET_CFG_MACAD=
DR]);
> > +             memcpy(set_config.net.mac, macaddr, ETH_ALEN);
> > +             set_config.mask |=3D BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MACADD=
R);
> > +             if (mdev->ops->set_mac) {
> > +                     err =3D mdev->ops->set_mac(mdev, vdev, &set_confi=
g);
> > +             } else {
> > +                     NL_SET_ERR_MSG_FMT_MOD(
> > +                             info->extack,
> > +                             "%s device not support set mac address ",=
 name);
> > +             }
> > +
> > +     } else {
> > +             NL_SET_ERR_MSG_FMT_MOD(info->extack,
> > +                                    "%s device not support this config=
 ",
> > +                                    name);
> > +     }
> > +
> > +mdev_err:
> > +     put_device(dev);
> > +dev_err:
> > +     up_write(&vdpa_dev_lock);
> > +     return err;
> > +}
> > +
> >  static int vdpa_dev_config_dump(struct device *dev, void *data)
> >  {
> >       struct vdpa_device *vdev =3D container_of(dev, struct vdpa_device=
, dev);
> > @@ -1285,6 +1351,11 @@ static const struct genl_ops vdpa_nl_ops[] =3D {
> >               .doit =3D vdpa_nl_cmd_dev_stats_get_doit,
> >               .flags =3D GENL_ADMIN_PERM,
> >       },
> > +     {
> > +             .cmd =3D VDPA_CMD_DEV_CONFIG_SET,
> > +             .doit =3D vdpa_nl_cmd_dev_config_set_doit,
> > +             .flags =3D GENL_ADMIN_PERM,
> > +     },
> >  };
> >
> >  static struct genl_family vdpa_nl_family __ro_after_init =3D {
> > diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
> > index db15ac07f8a6..c97f4f1da753 100644
> > --- a/include/linux/vdpa.h
> > +++ b/include/linux/vdpa.h
> > @@ -581,6 +581,8 @@ struct vdpa_mgmtdev_ops {
> >       int (*dev_add)(struct vdpa_mgmt_dev *mdev, const char *name,
> >                      const struct vdpa_dev_set_config *config);
> >       void (*dev_del)(struct vdpa_mgmt_dev *mdev, struct vdpa_device *d=
ev);
> > +     int (*set_mac)(struct vdpa_mgmt_dev *mdev, struct vdpa_device *de=
v,
> > +                    const struct vdpa_dev_set_config *config);
>
>
> Well, now vdpa_mgmtdev_ops which was completely generic is growing
> a net specific interface. Which begs a question - how is this
> going to work with other device types?
>
Thanks Micheal, I will rewrite this part
Thanks
Cindy
> >  };
> >
> >  /**
> > diff --git a/include/uapi/linux/vdpa.h b/include/uapi/linux/vdpa.h
> > index 54b649ab0f22..53f249fb26bc 100644
> > --- a/include/uapi/linux/vdpa.h
> > +++ b/include/uapi/linux/vdpa.h
> > @@ -19,6 +19,7 @@ enum vdpa_command {
> >       VDPA_CMD_DEV_GET,               /* can dump */
> >       VDPA_CMD_DEV_CONFIG_GET,        /* can dump */
> >       VDPA_CMD_DEV_VSTATS_GET,
> > +     VDPA_CMD_DEV_CONFIG_SET,
> >  };
> >
> >  enum vdpa_attr {
> > --
> > 2.45.0
>


