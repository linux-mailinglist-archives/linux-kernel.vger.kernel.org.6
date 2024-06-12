Return-Path: <linux-kernel+bounces-211044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03FCD904C7A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 09:13:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4ACA284B0E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 07:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB8B416C69E;
	Wed, 12 Jun 2024 07:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BLJWDj29"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B5AB168C33
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 07:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718176379; cv=none; b=ZVUMhRr7R+fD/AncOvb7QU2pmckBCVEen5tM/s9xcscFPxfrv0KGXBBdkVgh9mdXfZ0mxf67AoDY4tLFM0sBaTQhHABEuu8bXaSwEpavSOUj/A2vLKlsYdWsNArEFRF4nTfqT7mBPfSTtpXBlx7mrBX1ZUBTe1L5/W5MxqisTbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718176379; c=relaxed/simple;
	bh=FJ9BTeEbejPctTmHZIUK+28zrcodhwdsqUv2ldy1WOg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZF5Pb7YiwlUtIg18E3enncW/6LB35dLWFgYiwB/uyFQxw2kOLuGjCB0F3sS7lLrKU+LHG7LD/D6+R9VvT5S6Tv2xbUy3Uw5ad/MJdZrVhdmam4ExLT0rA4D7TA9BeDsNnTAVFlxB5lzuerX0Tnop65Y/p4otZpnA7VFZUKuZx0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BLJWDj29; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718176376;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0AdGqhESB7FcgdEdVmtQDKt7grmbOEq0F0SyTtNx6No=;
	b=BLJWDj29U37WtcKly6oGuivaT9KD8byIPCl0sqLw8ttFBneyKc2u3iY5D7rnwBWFViMtXs
	NyqlDPvOyi1dD+v2i8J4yzDfGDaWsBn9RdGjFfSL3jdLeHc4Rp8INe9sSMoYF6Sxf7FMFm
	4jV6u9htPi/zzRPLh+Tx6pVEdMltmJE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-tQRDgnF3MymZkIHBgWXyag-1; Wed, 12 Jun 2024 03:12:53 -0400
X-MC-Unique: tQRDgnF3MymZkIHBgWXyag-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4217a6a00d8so31577025e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 00:12:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718176372; x=1718781172;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0AdGqhESB7FcgdEdVmtQDKt7grmbOEq0F0SyTtNx6No=;
        b=E5AzCD1liMlY+s8a8apgFChUgJNlqkIo3fyylPK8z8D5H3KkvXx5NDWoDap/NHD3uK
         gW2IFK5JC/itYLNs9yTlfRFz575FGoTsptRqq18LaaHXEEVI0i6DStZwW26cp5Q5yVR7
         1KUFDgiZ4o6wLhCmn6MM348hdRBmYeqyqWq+Gdpe2nwaSYFJc9yell9s1Czc+p3H2URv
         +ul7MhwJa7MS6SUiM2idYr9lohxL6xJ7+qKOi1tF4zV+sqOaYw89TBwVr/xwX4j3hWaD
         UhXL50fKQ/r9omMa8x0+u5E4Cwcg52dXATXVFQtg4EnBHo5IRZnawrsjzpfkpCUkNxpu
         p1SA==
X-Forwarded-Encrypted: i=1; AJvYcCWICc3aeZe0H5zx+6XD4cjnI0Z7KNqenkdJN2LAT/Nihrt4woQYAUhZBnMybWtVqYg66PHftTad4nZLDvRThwT7+BHPNsU2C8yqp6aR
X-Gm-Message-State: AOJu0YyUXFlNC5DFB569SRod0rAEHlC4tU6d1DrcGLvepJXT5ATmMPvy
	iF3D9HuvFJS3hNwD2+6GgrEluIYJfdz+/9oKBjttBY++k9bxGWlIjBxzxRrWC6vemAHcWOKvXyV
	NoeUFz/hKhdussK+nKUySk2aN/2Q/HHW6bgpRuN6flFEmydfseCCrlHOfllkl6Kj6kPAY4Q==
X-Received: by 2002:a05:600c:3552:b0:421:7be5:f318 with SMTP id 5b1f17b1804b1-422867c0408mr7204625e9.33.1718176371647;
        Wed, 12 Jun 2024 00:12:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGphusi1X4I6zrV9eu6daKqPEPomJK6FFUdfburgBDZrRG2/0lanC4F2ufq6sccZD88eQM6rQ==
X-Received: by 2002:a05:600c:3552:b0:421:7be5:f318 with SMTP id 5b1f17b1804b1-422867c0408mr7204415e9.33.1718176371029;
        Wed, 12 Jun 2024 00:12:51 -0700 (PDT)
Received: from redhat.com ([2a02:14f:178:39eb:4161:d39d:43e6:41f8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-422874de5d5sm13703115e9.33.2024.06.12.00.12.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 00:12:50 -0700 (PDT)
Date: Wed, 12 Jun 2024 03:12:47 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Cindy Lu <lulu@redhat.com>
Cc: dtatulea@nvidia.com, jasowang@redhat.com,
	virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH 1/2] vdpa: support set mac address from vdpa tool
Message-ID: <20240612014143-mutt-send-email-mst@kernel.org>
References: <20240611053239.516996-1-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240611053239.516996-1-lulu@redhat.com>

On Tue, Jun 11, 2024 at 01:32:32PM +0800, Cindy Lu wrote:
> Add new UAPI to support the mac address from vdpa tool

The patch does not do what commit log says.
Instead there's an internal API to set mac and
a UAPI to write into config space.

> Function vdpa_nl_cmd_dev_config_set_doit() will get the
> MAC address from the vdpa tool and then set it to the device.
> 
> The usage is: vdpa dev set name vdpa_name mac **:**:**:**:**:**
> 
> Here is sample:
> root@L1# vdpa -jp dev config show vdpa0
> {
>     "config": {
>         "vdpa0": {
>             "mac": "82:4d:e9:5d:d7:e6",
>             "link ": "up",
>             "link_announce ": false,
>             "mtu": 1500
>         }
>     }
> }
> 
> root@L1# vdpa dev set name vdpa0 mac 00:11:22:33:44:55
> 
> root@L1# vdpa -jp dev config show vdpa0
> {
>     "config": {
>         "vdpa0": {
>             "mac": "00:11:22:33:44:55",
>             "link ": "up",
>             "link_announce ": false,
>             "mtu": 1500
>         }
>     }
> }
> 
> Signed-off-by: Cindy Lu <lulu@redhat.com>
> ---
>  drivers/vdpa/vdpa.c       | 71 +++++++++++++++++++++++++++++++++++++++
>  include/linux/vdpa.h      |  2 ++
>  include/uapi/linux/vdpa.h |  1 +
>  3 files changed, 74 insertions(+)
> 
> diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
> index a7612e0783b3..347ae6e7749d 100644
> --- a/drivers/vdpa/vdpa.c
> +++ b/drivers/vdpa/vdpa.c
> @@ -1149,6 +1149,72 @@ static int vdpa_nl_cmd_dev_config_get_doit(struct sk_buff *skb, struct genl_info
>  	return err;
>  }
>  
> +static int vdpa_nl_cmd_dev_config_set_doit(struct sk_buff *skb,
> +					   struct genl_info *info)
> +{
> +	struct vdpa_dev_set_config set_config = {};
> +	struct nlattr **nl_attrs = info->attrs;
> +	struct vdpa_mgmt_dev *mdev;
> +	const u8 *macaddr;
> +	const char *name;
> +	int err = 0;
> +	struct device *dev;
> +	struct vdpa_device *vdev;
> +
> +	if (!info->attrs[VDPA_ATTR_DEV_NAME])
> +		return -EINVAL;
> +
> +	name = nla_data(info->attrs[VDPA_ATTR_DEV_NAME]);
> +
> +	down_write(&vdpa_dev_lock);
> +	dev = bus_find_device(&vdpa_bus, NULL, name, vdpa_name_match);
> +	if (!dev) {
> +		NL_SET_ERR_MSG_MOD(info->extack, "device not found");
> +		err = -ENODEV;
> +		goto dev_err;
> +	}
> +	vdev = container_of(dev, struct vdpa_device, dev);
> +	if (!vdev->mdev) {
> +		NL_SET_ERR_MSG_MOD(
> +			info->extack,
> +			"Fail to find the specified management device");
> +		err = -EINVAL;
> +		goto mdev_err;
> +	}
> +	mdev = vdev->mdev;
> +	if (nl_attrs[VDPA_ATTR_DEV_NET_CFG_MACADDR]) {
> +		if (!(mdev->supported_features & BIT_ULL(VIRTIO_NET_F_MAC))) {


Seems to poke at a device without even making sure it's a network
device.

> +			NL_SET_ERR_MSG_FMT_MOD(
> +				info->extack,
> +				"Missing features 0x%llx for provided attributes",
> +				BIT_ULL(VIRTIO_NET_F_MAC));
> +			err = -EINVAL;
> +			goto mdev_err;
> +		}
> +		macaddr = nla_data(nl_attrs[VDPA_ATTR_DEV_NET_CFG_MACADDR]);
> +		memcpy(set_config.net.mac, macaddr, ETH_ALEN);
> +		set_config.mask |= BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MACADDR);
> +		if (mdev->ops->set_mac) {
> +			err = mdev->ops->set_mac(mdev, vdev, &set_config);
> +		} else {
> +			NL_SET_ERR_MSG_FMT_MOD(
> +				info->extack,
> +				"%s device not support set mac address ", name);
> +		}
> +
> +	} else {
> +		NL_SET_ERR_MSG_FMT_MOD(info->extack,
> +				       "%s device not support this config ",
> +				       name);
> +	}
> +
> +mdev_err:
> +	put_device(dev);
> +dev_err:
> +	up_write(&vdpa_dev_lock);
> +	return err;
> +}
> +
>  static int vdpa_dev_config_dump(struct device *dev, void *data)
>  {
>  	struct vdpa_device *vdev = container_of(dev, struct vdpa_device, dev);
> @@ -1285,6 +1351,11 @@ static const struct genl_ops vdpa_nl_ops[] = {
>  		.doit = vdpa_nl_cmd_dev_stats_get_doit,
>  		.flags = GENL_ADMIN_PERM,
>  	},
> +	{
> +		.cmd = VDPA_CMD_DEV_CONFIG_SET,
> +		.doit = vdpa_nl_cmd_dev_config_set_doit,
> +		.flags = GENL_ADMIN_PERM,
> +	},
>  };
>  
>  static struct genl_family vdpa_nl_family __ro_after_init = {
> diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
> index db15ac07f8a6..c97f4f1da753 100644
> --- a/include/linux/vdpa.h
> +++ b/include/linux/vdpa.h
> @@ -581,6 +581,8 @@ struct vdpa_mgmtdev_ops {
>  	int (*dev_add)(struct vdpa_mgmt_dev *mdev, const char *name,
>  		       const struct vdpa_dev_set_config *config);
>  	void (*dev_del)(struct vdpa_mgmt_dev *mdev, struct vdpa_device *dev);
> +	int (*set_mac)(struct vdpa_mgmt_dev *mdev, struct vdpa_device *dev,
> +		       const struct vdpa_dev_set_config *config);


Well, now vdpa_mgmtdev_ops which was completely generic is growing
a net specific interface. Which begs a question - how is this
going to work with other device types?

>  };
>  
>  /**
> diff --git a/include/uapi/linux/vdpa.h b/include/uapi/linux/vdpa.h
> index 54b649ab0f22..53f249fb26bc 100644
> --- a/include/uapi/linux/vdpa.h
> +++ b/include/uapi/linux/vdpa.h
> @@ -19,6 +19,7 @@ enum vdpa_command {
>  	VDPA_CMD_DEV_GET,		/* can dump */
>  	VDPA_CMD_DEV_CONFIG_GET,	/* can dump */
>  	VDPA_CMD_DEV_VSTATS_GET,
> +	VDPA_CMD_DEV_CONFIG_SET,
>  };
>  
>  enum vdpa_attr {
> -- 
> 2.45.0


