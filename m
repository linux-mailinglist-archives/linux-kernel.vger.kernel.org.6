Return-Path: <linux-kernel+bounces-263302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D705393D40E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 15:20:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E82A1F24103
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 13:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 364B317C201;
	Fri, 26 Jul 2024 13:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KgSND7wn"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E388D17A5AB
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 13:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722000020; cv=none; b=Y3h51wgPVFRF3y6331ni6Tg/Nyoazerv49BdoVGaPq5hjdyrfGrfHX7Ss7ACph5ig22PYAWgrqSPcSN591Elh1r2gVf5STo5I9p4bjaX8VY0mC1qnBFM++bjddvNZ1SKCojifgmQYgO0QNcisALs6zStelbiE8NKKNM+uz9v2hM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722000020; c=relaxed/simple;
	bh=okBVGW+4Ldc/gYbopPMTEK9G1vsz0TiBtRfOBBB3ybs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=OZwd0fe7H3mkI7435XjjRjQ2HsoOgAjLtzmtR/scVvZLn6NYIJD5RMSmUBdF33NIxpDX9/vjipJAmK+PNxII2Ds6S2kquP9w3pkvYyErGvGyxhUet1hT+W8/hgIXSU54ERtmlAr+gFmyr0SZMlrshuHX7+TYw3iDq1cOrgH3vYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KgSND7wn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722000017;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AhcUQuVGN/p5AORVU51L+UH99nfvjtvJ6aAvMYY+bH4=;
	b=KgSND7wnvrJXZThhOJcqsJIbzjZUGySQsrYjHrk+h8EDa/dGV41n+qlNAKbC+yjx42Iml1
	U1pibKvi45GjFt/bZ3tw8Zvbh6RPrFCyi9A1N+nP3YaAFKtrDkfyQEehxWOurep5t1+OU6
	SrF8SaesGQsSFeSICVq8QzrXOty9FRA=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-235-Xpq61tC9PA-jYgth69pKPA-1; Fri, 26 Jul 2024 09:20:14 -0400
X-MC-Unique: Xpq61tC9PA-jYgth69pKPA-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-5a8b0832d9cso1566981a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 06:20:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722000013; x=1722604813;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AhcUQuVGN/p5AORVU51L+UH99nfvjtvJ6aAvMYY+bH4=;
        b=nDc9ItShd43YcNPwsAkjr8Jlxr63RHB5jZ9fUPDkuBvDmL+9oT2fNyY1Cvsd1HXMzE
         fYgL3qiOc8t8cUZPO1djXMBWJ9KTQ/zQ8mloPSHcz1O4bqVb646/S00M3L7oBUKiIoWu
         X8aB7OVcjC0hQXzO2WHIwE8NXMANhgMpqNjGU8A//caufuVdU/T6xfsM40cBkGkVAcCb
         v2r5KCGXwlqSHj7KbC9B1w804/h+DCIcq8ZpZ/gwzzwk+LPVQB+7bW2QcXqXm4e6Hu69
         zrthW7+Si2MC6qPnWENaLzTCcrwUg8YWnhZ9dnbYegUWo9h1m9u+bhudxxX/cw16EF5j
         SRrQ==
X-Forwarded-Encrypted: i=1; AJvYcCVYGe6fDP4+ekRAX+rM0PwRwsCyAuKgRhaOfukIifl8l3K9HguKjAe7/K50Tffdh/qZv1EHCeqxiK+E5dh4I6kYizLpVjAzXrZQEkPV
X-Gm-Message-State: AOJu0YwvcndjVRyriSIsWujhN/rbyr9cBdeei5mGat8DCecF6GDKpQrL
	FV/q4Q/kN4chC8jxU1Ga54j0q26fZJOufVRRebzvTGbTJwppkjrFGGSd7TiKNIQfwrrHkvsGZtV
	KaXqZWKObJ4I3ukRJLSNiI/Gr8FeF1+EdsYzDSzAy/k5w0ydjEjgMEL64MhFJguO3Iztm6htZCF
	HM8E12kh1u1sNJpCHzmGcOVp/kmmVL1XVqnimd
X-Received: by 2002:a50:c04d:0:b0:5a3:b45:3970 with SMTP id 4fb4d7f45d1cf-5ac27750881mr3153326a12.0.1722000013062;
        Fri, 26 Jul 2024 06:20:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFtB78u5qVHemteUb/n5/CBlV2qDcx0mVsZ+2chC9WujC4lrXXqlD2osHIxxTvD60+aLUAhJOP6uvrm/JcF0xc=
X-Received: by 2002:a50:c04d:0:b0:5a3:b45:3970 with SMTP id
 4fb4d7f45d1cf-5ac27750881mr3153306a12.0.1722000012559; Fri, 26 Jul 2024
 06:20:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240725013217.1124704-1-lulu@redhat.com> <20240725013217.1124704-2-lulu@redhat.com>
 <ZqKLd9ZIJ4l5tAL8@LQ3V64L9R2>
In-Reply-To: <ZqKLd9ZIJ4l5tAL8@LQ3V64L9R2>
From: Cindy Lu <lulu@redhat.com>
Date: Fri, 26 Jul 2024 21:19:34 +0800
Message-ID: <CACLfguU1pBgRLQwUXXX70ROhy41KvFuHd_08_t-YXS75hsafzg@mail.gmail.com>
Subject: Re: [PATH v6 1/3] vdpa: support set mac address from vdpa tool
To: Joe Damato <jdamato@fastly.com>, Cindy Lu <lulu@redhat.com>, dtatulea@nvidia.com, 
	mst@redhat.com, jasowang@redhat.com, parav@nvidia.com, sgarzare@redhat.com, 
	netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 26 Jul 2024 at 01:29, Joe Damato <jdamato@fastly.com> wrote:
>
> On Thu, Jul 25, 2024 at 09:31:02AM +0800, Cindy Lu wrote:
> [...]
> > diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
> > index 8d391947eb8d..532cf3b52b26 100644
> > --- a/drivers/vdpa/vdpa.c
> > +++ b/drivers/vdpa/vdpa.c
> > @@ -1361,6 +1361,81 @@ static int vdpa_nl_cmd_dev_config_get_doit(struct sk_buff *skb, struct genl_info
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
>
> Nit: IIRC networking code prefers reverse-xmas tree style and
> macaddr above needs to be moved.
>
will fix  this
thanks
cindy
> > +     down_write(&vdev->cf_lock);
> > +     if (nl_attrs[VDPA_ATTR_DEV_NET_CFG_MACADDR]) {
> > +             set_config.mask |= BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MACADDR);
> > +             macaddr = nla_data(nl_attrs[VDPA_ATTR_DEV_NET_CFG_MACADDR]);
> > +
> > +             if (is_valid_ether_addr(macaddr)) {
> > +                     ether_addr_copy(set_config.net.mac, macaddr);
> > +                     memcpy(set_config.net.mac, macaddr, ETH_ALEN);
> > +                     if (mdev->ops->dev_set_attr) {
> > +                             err = mdev->ops->dev_set_attr(mdev, vdev,
> > +                                                           &set_config);
> > +                     } else {
> > +                             NL_SET_ERR_MSG_FMT_MOD(
> > +                                     info->extack,
> > +                                     "device does not support changing the MAC address");
> > +                     }
> > +             } else {
> > +                     NL_SET_ERR_MSG_FMT_MOD(info->extack,
> > +                                            "Invalid MAC address");
> > +             }
> > +     }
> > +     up_write(&vdev->cf_lock);
> > +     return err;
> > +}
>
> Nit: other code in this file has line breaks separating functions.
> Probably good to add one here?
>
sure will change this
thanks
Cindy
>
> > +static int vdpa_nl_cmd_dev_attr_set_doit(struct sk_buff *skb,
> > +                                      struct genl_info *info)
>
> Nit: Does the above pass ./scripts/checkpatch.pl --strict ? I am asking
> because it seems like the alignment might be off?
>
I tried this, but there doesn't seem to have warning. I'll double-check this.
Thanks
cindy
> > +{
> > +     const char *name;
> > +     int err = 0;
> > +     struct device *dev;
> > +     struct vdpa_device *vdev;
> > +     u64 classes;
>
> Nit: Same as above; I believe networking code is supposed to follow
> reverse xmas tree order so these variables should be rearranged.
>
will fix  this

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
> > +             NL_SET_ERR_MSG_MOD(info->extack, "unmanaged vdpa device");
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
>
> [...]
>


