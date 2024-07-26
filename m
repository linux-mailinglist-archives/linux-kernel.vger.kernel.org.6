Return-Path: <linux-kernel+bounces-263300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 079EB93D3FE
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 15:17:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BC651C20944
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 13:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7286F17C200;
	Fri, 26 Jul 2024 13:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AUuAhMEQ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D03817B512
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 13:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721999825; cv=none; b=nw0aDtNZl5gNi3DpaUdU8rn9o9CfctHQD4idA++PXiXmm6xjvFqTsC+aWVg4A6bFZwW5dXfTb5oxfto/IGA7MeEVbvbucyDCkXzkHM7d4wM+VZ1Rir0Jt1MzT+DSRw4mLdiJbcOLEh9dy8IceLbxQx3JJMfi9Ny3isP/1YU0ubU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721999825; c=relaxed/simple;
	bh=E8TJ6MRlezfed8oV6XYbKMbJ33WOOqUbYyIaqIuvt2M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=Bj290W57SxVQrZ6+QwplZsvGRuEt1d7UtTY8qhoAOPdVp5N+E+2q/VhMLSw6NONO4qsKfoqx0QwZkzTGBRs12EW9aIqjbDMZrByRVhCEak13pUpQEjLIcfLm0W9tNrfCZ+zknElcxB8PTioigwVTtoV4YIxG4JDMz4fJkw/ZicI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AUuAhMEQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721999823;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vllFnlg84B30xrdVTJ9/E1KQIK8lYuMk6An3oA0P1n0=;
	b=AUuAhMEQQWajiqO3j39rqac6UvRm+UY6U/OqaLRCMlJPgedFLZu8EzlCCPikg6cP3foINz
	68xtN6jP1fS1CnehTrptOTaOGSujgF0uTvq2chG/rLtdwGrSI4fMOGNmhJKvA/s02SMbdf
	q+RkQaMYO5/JFa9YcF0IaORlnhzvjfQ=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-640-WIpC5ZcoP4W9x2byAkrXRA-1; Fri, 26 Jul 2024 09:17:00 -0400
X-MC-Unique: WIpC5ZcoP4W9x2byAkrXRA-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a7a999275f8so80731166b.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 06:16:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721999819; x=1722604619;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vllFnlg84B30xrdVTJ9/E1KQIK8lYuMk6An3oA0P1n0=;
        b=knCOWJJrFJXRZiu5W1NYznV/szXidF5FrigSIABuHEttBgkk1sZ09vAkCt2Ta5I81m
         OBjEV8iZaN7ItDKu8joVmfGqTwRjG4LJbEwTRUhZBQXVfC1zPb3YrRQE4gqDNdR3+3la
         XXXv1GHtPMOrD7tB/2dJnDD6jh7MulNYgJj9MWYKhNF658x36ks2Yj06ELc/pij8Fp4A
         AwRNJNGGM/5f+lBAVDHqEcDMUMH1sFdezpo3b9zbVfPfGS/ScsIO6EVwvLpamy4AZdma
         sSSHzLvDcInAjuHr2foZL0Gu87Lrt9Ks0uab0RaE6jA2fAK6n7SlRMgsRDHQaEYGPfXy
         mWXQ==
X-Forwarded-Encrypted: i=1; AJvYcCXem/9YJFbPWqWsvTt5x/oN5p24YtxUeLPH++gLeiBxYdun7mV4EO6VAPlXKzJ9zBDA7JoJ/4Zf4rin7D7sSMMrp9rjlJM8mzsHDqbw
X-Gm-Message-State: AOJu0YxAXZk43EoITsbv14VGDZ7KLvNJw2p4dFvl7pD5VGERd4Tn1wsu
	/nKSEtcXUpdowXae9rX/UK+4zeQPpW1kDeDcTqFkgXcjPd+/a/454jfUgZw+mDOEPaGjPp8Fhjo
	l8m2rg7sc7LM0qBNJJNqnAGcBrIo31tZBECi9KYCzzRqU71HtDkvq4E0y0qIQ4+ZqaF6Gc5kKrz
	2TPZkXQuUcWi78At0oEHBg1mZ9yw4gSMLSc5tY
X-Received: by 2002:a50:ab18:0:b0:5a2:6142:24c1 with SMTP id 4fb4d7f45d1cf-5ac6203a20amr5122269a12.5.1721999818737;
        Fri, 26 Jul 2024 06:16:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGNMLKfBY9RgUZNbuxfkLr4bAwXidi3+wYsQGX8RjCIa2lMVc2O1E44vHMrqEn2jQlboMjIf0XHetK/IL3iMXI=
X-Received: by 2002:a50:ab18:0:b0:5a2:6142:24c1 with SMTP id
 4fb4d7f45d1cf-5ac6203a20amr5122229a12.5.1721999818239; Fri, 26 Jul 2024
 06:16:58 -0700 (PDT)
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
Date: Fri, 26 Jul 2024 21:16:20 +0800
Message-ID: <CACLfguUBQ7p8M+aUT5EjKmaBP2tNF6B3_AEhPTqC-66MD0CYcg@mail.gmail.com>
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
Cindy

Cindy
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
>
> > +static int vdpa_nl_cmd_dev_attr_set_doit(struct sk_buff *skb,
> > +                                      struct genl_info *info)
>
> Nit: Does the above pass ./scripts/checkpatch.pl --strict ? I am asking
> because it seems like the alignment might be off?
>
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


