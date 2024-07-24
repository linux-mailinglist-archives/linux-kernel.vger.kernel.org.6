Return-Path: <linux-kernel+bounces-260564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F144A93AAF1
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 04:13:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 51A46B231F4
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 02:13:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A39E4134B1;
	Wed, 24 Jul 2024 02:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LKFfT3Ui"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2DE717571
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 02:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721787179; cv=none; b=AaI2oRlRY0aV3WMpIMskH8hQYKuQRtYaweFGxc9ytfQeabydGxJd8Gvr5zmSH0QUUesQMcsr7DiNqXrcGtmD8wnT9Ea6g3XMXaI3cG2MnaGL5LTJJ6bjVkYqt16uJz4OtH/QU0Z3nUFdFqXmrOudVd9fglrUx9nbhScRZmypoPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721787179; c=relaxed/simple;
	bh=pvLH4gHm4FBYDuFbbBP4fMwtKLA49f5CaaWi0YuUzAg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bDRAGcaj1YQkdF7fZtYUqE07ORhe7w5AaT4vkG8/iXmFNJ4xr2uW/HNy3Cha95ynr3WvF3dLD11JWvzOCGXnWDoq2PwSgJKxS4kFfxj7ZZ/PnVwcQan1EBGP4QdJb3pxo7VA+CWXuGuSXDsb7CSzNr63/EKxN6aYAHwkPnRy6zM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LKFfT3Ui; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721787176;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ehtuLszjv4cOJgMAfliSF/UD4RjIXwvAD86bpdUkiuk=;
	b=LKFfT3Ui9NieAs3ne/3Dvj8G1lGkZLt/pqt0fnKPIBHoaj+oqwl/3Mo7QKXVg4Lq9uJ66o
	oyDbf1o2sc8cLVWlph0agYAhShkffq9R+gKbAGmBD4rruSkasii5SVZDGJxeJEIrDGQYwC
	PoXqE7BQN0yQXg2hh8B9nJg37CtgPjg=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-411-pyC1iRJIOqmvTZOn8UoFVg-1; Tue, 23 Jul 2024 22:12:53 -0400
X-MC-Unique: pyC1iRJIOqmvTZOn8UoFVg-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2ef2d0509a2so28381611fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 19:12:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721787171; x=1722391971;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ehtuLszjv4cOJgMAfliSF/UD4RjIXwvAD86bpdUkiuk=;
        b=U1XgciIP+q82jxcXt/C0DypNqj1u1agSi9N4cR7ytkU0NbMN4c0SLL9U24xk15mEA8
         GEKtPBVNuKV1t0T2JwRqeQT9xBiCRKneUHnppjJOe5OBkfw/aD5LYIrAHruoNF71Di+P
         OfQtGDA3tYvLsjgFMk83Yj6j/G4tMdhX9G3RfwDjENdbBne2acmv53Xf/U9GcC+Imqz6
         leD2Wk1VYSEvQJSmJjVSmuIGnninthdNLY8aP4+Oa5SjxP6uBiSfFp7BErczn/+kWRnN
         IAAzJec6ZP1dsh6NNqEXEaMWVHWSkAKNhjCFwjBSsKI20nUyxveLJuXo5UOSU7tbOuLV
         KbZA==
X-Forwarded-Encrypted: i=1; AJvYcCU42U4HhchwmGFtNe53JZHI1duMFhtlePkJ7lpMzwf8IYu9xCyiUv5TQC+S5lxCiopeCc/DAtkfB8eksbl0p/s2vJyCiXTem4xzvhHg
X-Gm-Message-State: AOJu0YzqbJlGIDe+MA0NblIEOLI3P7IEd7l0b1kmkf/95OQMC++4O5EN
	d5EmYUntT2BL1N9ZOszsjn+AZifphRi55+CrYzvybQsZo0i/9dMxOxwO7pz2eeV6gTC+cluw4KQ
	CG8LRP/kZ57z21ZGvazlimn/f/dTajfFRLfD5+zgRBwo6APBlK/+F6JV6sPNxCT5Ov90xDQX4F7
	LkA0XOdXn5yk+ma9/uESIIDqjtrHUszP3wEk5T
X-Received: by 2002:a2e:2e09:0:b0:2ef:2b45:b71d with SMTP id 38308e7fff4ca-2f02b741b1cmr9587751fa.24.1721787171643;
        Tue, 23 Jul 2024 19:12:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH2haBDetr3B12GRUddIecLnBaa3DkGcUp0iNR3ZPqOWC2HtbRoOF28NQwySlFGXAweIO8RddD9ZSszJMao+28=
X-Received: by 2002:a2e:2e09:0:b0:2ef:2b45:b71d with SMTP id
 38308e7fff4ca-2f02b741b1cmr9587621fa.24.1721787171177; Tue, 23 Jul 2024
 19:12:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240723054047.1059994-1-lulu@redhat.com> <20240723054047.1059994-2-lulu@redhat.com>
 <8ff8f8d8-1061-42a2-b238-82f685639115@lunn.ch>
In-Reply-To: <8ff8f8d8-1061-42a2-b238-82f685639115@lunn.ch>
From: Cindy Lu <lulu@redhat.com>
Date: Wed, 24 Jul 2024 10:12:14 +0800
Message-ID: <CACLfguUf-HtNqL9ykGGY_XCQadUS7fJR+kn3q7S+cH7aUGmqYg@mail.gmail.com>
Subject: Re: [PATH v5 1/3] vdpa: support set mac address from vdpa tool
To: Andrew Lunn <andrew@lunn.ch>
Cc: dtatulea@nvidia.com, mst@redhat.com, jasowang@redhat.com, parav@nvidia.com, 
	sgarzare@redhat.com, netdev@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 24 Jul 2024 at 02:48, Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Tue, Jul 23, 2024 at 01:39:20PM +0800, Cindy Lu wrote:
> > Add new UAPI to support the mac address from vdpa tool
> > Function vdpa_nl_cmd_dev_attr_set_doit() will get the
> > new MAC address from the vdpa tool and then set it to the device.
> >
> > The usage is: vdpa dev set name vdpa_name mac **:**:**:**:**:**
> >
> > Here is example:
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
> >  drivers/vdpa/vdpa.c       | 84 +++++++++++++++++++++++++++++++++++++++
> >  include/linux/vdpa.h      |  9 +++++
> >  include/uapi/linux/vdpa.h |  1 +
> >  3 files changed, 94 insertions(+)
> >
> > diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
> > index 8d391947eb8d..07d61ee62839 100644
> > --- a/drivers/vdpa/vdpa.c
> > +++ b/drivers/vdpa/vdpa.c
> > @@ -1361,6 +1361,85 @@ static int vdpa_nl_cmd_dev_config_get_doit(struct sk_buff *skb, struct genl_info
> >       return err;
> >  }
> >
> > +static int vdpa_dev_net_device_attr_set(struct vdpa_device *vdev,
> > +                                     struct genl_info *info)
> > +{
> > +     struct vdpa_dev_set_config set_config = {};
> > +     const u8 *macaddr;
> > +     struct vdpa_mgmt_dev *mdev = vdev->mdev;
> > +     struct nlattr **nl_attrs = info->attrs;
> > +     int err = -EINVAL;
> > +
> > +     if (!vdev->mdev)
> > +             return -EINVAL;
> > +
> > +     down_write(&vdev->cf_lock);
> > +     if ((mdev->supported_features & BIT_ULL(VIRTIO_NET_F_MAC)) &&
> > +         nl_attrs[VDPA_ATTR_DEV_NET_CFG_MACADDR]) {
> > +             set_config.mask |= BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MACADDR);
> > +             macaddr = nla_data(nl_attrs[VDPA_ATTR_DEV_NET_CFG_MACADDR]);
> > +
> > +             if (is_valid_ether_addr(macaddr)) {
> > +                     memcpy(set_config.net.mac, macaddr, ETH_ALEN);
> > +                     if (mdev->ops->dev_set_attr) {
> > +                             err = mdev->ops->dev_set_attr(mdev, vdev,
> > +                                                           &set_config);
> > +                     } else {
> > +                             NL_SET_ERR_MSG_FMT_MOD(info->extack,
> > +                                                    "device not supported");
> > +                     }
> > +             } else {
> > +                     NL_SET_ERR_MSG_FMT_MOD(info->extack,
> > +                                            "Invalid MAC address");
> > +             }
> > +     }
> > +     up_write(&vdev->cf_lock);
> > +     return err;
> > +}
> > +static int vdpa_nl_cmd_dev_attr_set_doit(struct sk_buff *skb,
> > +                                      struct genl_info *info)
> > +{
> > +     const char *name;
> > +     int err = 0;
> > +     struct device *dev;
> > +     struct vdpa_device *vdev;
> > +     u64 classes;
> > +
> > +     if (!info->attrs[VDPA_ATTR_DEV_NAME])
> > +             return -EINVAL;
> > +
> > +     name = nla_data(info->attrs[VDPA_ATTR_DEV_NAME]);
> > +
> > +     down_write(&vdpa_dev_lock);
> > +     dev = bus_find_device(&vdpa_bus, NULL, name, vdpa_name_match);
> > +     if (!dev) {
> > +             NL_SET_ERR_MSG_MOD(info->extack, "device not found");
> > +             err = -ENODEV;
> > +             goto dev_err;
> > +     }
> > +     vdev = container_of(dev, struct vdpa_device, dev);
> > +     if (!vdev->mdev) {
> > +             NL_SET_ERR_MSG_MOD(
> > +                     info->extack,
> > +                     "Fail to find the specified management device");
> > +             err = -EINVAL;
> > +             goto mdev_err;
> > +     }
> > +     classes = vdpa_mgmtdev_get_classes(vdev->mdev, NULL);
> > +     if (classes & BIT_ULL(VIRTIO_ID_NET)) {
> > +             err = vdpa_dev_net_device_attr_set(vdev, info);
> > +     } else {
> > +             NL_SET_ERR_MSG_FMT_MOD(info->extack, "%s device not supported",
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
> >       struct vdpa_device *vdev = container_of(dev, struct vdpa_device, dev);
> > @@ -1497,6 +1576,11 @@ static const struct genl_ops vdpa_nl_ops[] = {
> >               .doit = vdpa_nl_cmd_dev_stats_get_doit,
> >               .flags = GENL_ADMIN_PERM,
> >       },
> > +     {
> > +             .cmd = VDPA_CMD_DEV_ATTR_SET,
> > +             .doit = vdpa_nl_cmd_dev_attr_set_doit,
> > +             .flags = GENL_ADMIN_PERM,
> > +     },
> >  };
> >
> >  static struct genl_family vdpa_nl_family __ro_after_init = {
> > diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
> > index 7977ca03ac7a..3511156c10db 100644
> > --- a/include/linux/vdpa.h
> > +++ b/include/linux/vdpa.h
> > @@ -582,11 +582,20 @@ void vdpa_set_status(struct vdpa_device *vdev, u8 status);
> >   *        @dev: vdpa device to remove
> >   *        Driver need to remove the specified device by calling
> >   *        _vdpa_unregister_device().
> > +  * @dev_set_attr: change a vdpa device's attr after it was create
> > + *        @mdev: parent device to use for device
>
> The indentation looks a bit odd here.
>
>     Andrew
>
sure, Will fix this
thanks
cindy
> ---
> pw-bot: cr
>


