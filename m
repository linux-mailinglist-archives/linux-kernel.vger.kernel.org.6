Return-Path: <linux-kernel+bounces-306270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AE69963C4D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 09:13:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D694A283A8D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 07:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59F1C16C873;
	Thu, 29 Aug 2024 07:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gKZgVLoo"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 872E515CD7D
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 07:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724915590; cv=none; b=umAGrBaV2jZq/r1Szz9EVJvXMNff2ey/9BlVuU1prRXU6/WCJvOJhun2rIbDrFKb6aYis1iKW5+hJZ1vFTU5j7DQnHpDKCnxZdTTw3Gr3VahZuwMeDVfWXKaWM37lD9AwvrV630n7lNtEM1ITaa0vJo+ySqLp7hfBEECP4DK0mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724915590; c=relaxed/simple;
	bh=nlIlAL2zaBMHnx800P6wF6aqRBkokcHL0Mf3is8S1CU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hvQQ6M+OKtUx75WJIBQrA2vnl26K8++5KlStDT3qJWYsNwW0+msPMHWT+2CrqYaYmLHxJOzR7ldXxeYxtQDgD6lCfz7L/pxpTnnghvyItocALI6AG4Xrw6kRsB90GRXZJvkw+DIZL/OVG4ivSwDWpPf0EwtdHaChb0ylE2BaRiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gKZgVLoo; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724915587;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hDa/BfPlYfgncY5T1ouEOXs9QAiEyNsHZ78FmWi0H8w=;
	b=gKZgVLoofRNSV0Ia7imXk73X7TOhZgho/PEl8w6cEbBnPuOfiCxs07ExaODpV1nz6S/koD
	Hg9wMMCq51M9+n4mEF+CyoQNXyd5X0Q6EVUWDOvIQeCvoXBz4zWFGJYOOjthKOQZoVzBTe
	mhqTs3fH49ytUoQxJbX/HwSQsyjHLCE=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-467-6Ptce5QAP7qaPRKY6-b6aQ-1; Thu, 29 Aug 2024 03:13:05 -0400
X-MC-Unique: 6Ptce5QAP7qaPRKY6-b6aQ-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a867d92ec4bso13518866b.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 00:13:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724915585; x=1725520385;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hDa/BfPlYfgncY5T1ouEOXs9QAiEyNsHZ78FmWi0H8w=;
        b=Ci2fUA2x3cE4CkzGzOryIl88zLfB1CxVS+2uNXP4aeGAzaTtXah1cxPhK19g9pK2bO
         MebYScU6mM0eyjLawKuPJzqAJ4iVZx1J/wOLtuTAThwb8W6FeYGNIQmUFFYoBQ1BmfUp
         e23JOrwqC46PRYzopq3gJ6BzkvkA6hfAltfzaVI6eG8/Y7ZNp17uim+YwglSE8IHZC23
         4HRkgDKOhcbwYjQvQgCdvD2iUU5khp9OLH33Z5y6s6QY5rk1lykDyboKyfVLb7UIE0lm
         Bo5MZb78zvmYUwqA9ITIHqKQPCJwKQgOjFMJ2p162VXIhJIzfMNZEqeaLQVmrq8OMkWU
         rMHQ==
X-Forwarded-Encrypted: i=1; AJvYcCUWFoZWK7LPg8YNJhLAdSs6ipUp37MgNwH3FQekxe8AuJaHkL/lWArlYZDbCHJRb+AneDNhbGUKR7PmiVE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKFVoO3yRBR1Vwb/F/in56/wLeQ1pUM1JoPIFB3SbtnT/dtuRA
	iXjM2P4PWU0YSZWsZms1zQiuv0iiO4ifeSjEd/8VMtoxAw2e37llH1Zrniruj8AoFyWxYiZSTwP
	W3xpv+BBeR666ATWbMffC5jtdCUkqbyFNtpeLOco/5dstH1vYGg6wFjFNXw2acQ==
X-Received: by 2002:a05:6402:2755:b0:5be:fc2e:b7ce with SMTP id 4fb4d7f45d1cf-5c21ed54a32mr1858404a12.19.1724915584616;
        Thu, 29 Aug 2024 00:13:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGr2Co8m4VGY5qkWIO+/TWxMIHT/EfuU5z5cPxSrB5C2LnjsmaqWkBFFu5KqhIgn7z9eIMK2g==
X-Received: by 2002:a05:6402:2755:b0:5be:fc2e:b7ce with SMTP id 4fb4d7f45d1cf-5c21ed54a32mr1858363a12.19.1724915583662;
        Thu, 29 Aug 2024 00:13:03 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1ed:a269:8195:851e:f4b1:ff5d])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c226ccfeb7sm331942a12.63.2024.08.29.00.13.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 00:13:03 -0700 (PDT)
Date: Thu, 29 Aug 2024 03:12:57 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Carlos Bilbao <carlos.bilbao.osdev@gmail.com>
Cc: dtatulea@nvidia.com, jasowang@redhat.com, bilbao@vt.edu,
	xuanzhuo@linux.alibaba.com, eperezma@redhat.com, cratiu@nvidia.com,
	lingshan.zhu@intel.com, virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Carlos Bilbao <cbilbao@digitalocean.com>
Subject: Re: [PATCH] vdpa: Set speed and duplex of mlx5_vnet to UNKNOWN
Message-ID: <20240829031227-mutt-send-email-mst@kernel.org>
References: <20240828181625.7831-1-carlos.bilbao.osdev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240828181625.7831-1-carlos.bilbao.osdev@gmail.com>

On Wed, Aug 28, 2024 at 01:16:25PM -0500, Carlos Bilbao wrote:
> From: Carlos Bilbao <cbilbao@digitalocean.com>
> 
> mlx5_vdpa vDPA devices currently don't support reporting or setting the
> speed and duplex and hence should be UNKNOWN instead of zero.
> 
> Signed-off-by: Carlos Bilbao <cbilbao@digitalocean.com>


As Jason points out, commit log and subject should says what
the patch does.

> ---
>  drivers/vdpa/mlx5/net/mlx5_vnet.c |  7 +++++++
>  drivers/vdpa/vdpa.c               | 23 +++++++++++++++++++++++
>  include/uapi/linux/vdpa.h         |  2 ++
>  3 files changed, 32 insertions(+)
> 
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> index fa78e8288ebb..319f5c6121de 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -3795,6 +3795,13 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
>  	init_rwsem(&ndev->reslock);
>  	config = &ndev->config;
>  
> +	/*
> +	 * mlx5_vdpa vDPA devices currently don't support reporting or
> +	 * setting the speed or duplex.
> +	 */
> +	config->speed  = SPEED_UNKNOWN;
> +	config->duplex = DUPLEX_UNKNOWN;
> +
>  	if (add_config->mask & BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MTU)) {
>  		err = config_func_mtu(mdev, add_config->net.mtu);
>  		if (err)
> diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
> index 4dbd2e55a288..abde23e0041d 100644
> --- a/drivers/vdpa/vdpa.c
> +++ b/drivers/vdpa/vdpa.c
> @@ -15,6 +15,7 @@
>  #include <net/genetlink.h>
>  #include <linux/mod_devicetable.h>
>  #include <linux/virtio_ids.h>
> +#include <uapi/linux/ethtool.h>
>  
>  static LIST_HEAD(mdev_head);
>  /* A global mutex that protects vdpa management device and device level operations. */
> @@ -919,6 +920,22 @@ static int vdpa_dev_net_status_config_fill(struct sk_buff *msg, u64 features,
>  	return nla_put_u16(msg, VDPA_ATTR_DEV_NET_STATUS, val_u16);
>  }
>  
> +static int vdpa_dev_net_speed_config_fill(struct sk_buff *msg, u64 features,
> +					struct virtio_net_config *config)
> +{
> +	__le32 speed = cpu_to_le32(SPEED_UNKNOWN);
> +
> +	return nla_put(msg, VDPA_ATTR_DEV_NET_CFG_SPEED, sizeof(speed), &speed);
> +}
> +
> +static int vdpa_dev_net_duplex_config_fill(struct sk_buff *msg, u64 features,
> +					struct virtio_net_config *config)
> +{
> +	u8 duplex = DUPLEX_UNKNOWN;
> +
> +	return nla_put(msg, VDPA_ATTR_DEV_NET_CFG_DUPLEX, sizeof(duplex), &duplex);
> +}
> +
>  static int vdpa_dev_net_config_fill(struct vdpa_device *vdev, struct sk_buff *msg)
>  {
>  	struct virtio_net_config config = {};
> @@ -941,6 +958,12 @@ static int vdpa_dev_net_config_fill(struct vdpa_device *vdev, struct sk_buff *ms
>  	if (vdpa_dev_net_status_config_fill(msg, features_device, &config))
>  		return -EMSGSIZE;
>  
> +	if (vdpa_dev_net_speed_config_fill(msg, features_device, &config))
> +		return -EMSGSIZE;
> +
> +	if (vdpa_dev_net_duplex_config_fill(msg, features_device, &config))
> +		return -EMSGSIZE;
> +
>  	return vdpa_dev_net_mq_config_fill(msg, features_device, &config);
>  }
>  
> diff --git a/include/uapi/linux/vdpa.h b/include/uapi/linux/vdpa.h
> index 842bf1201ac4..1c64ee0dd7b1 100644
> --- a/include/uapi/linux/vdpa.h
> +++ b/include/uapi/linux/vdpa.h
> @@ -43,6 +43,8 @@ enum vdpa_attr {
>  	VDPA_ATTR_DEV_NET_STATUS,		/* u8 */
>  	VDPA_ATTR_DEV_NET_CFG_MAX_VQP,		/* u16 */
>  	VDPA_ATTR_DEV_NET_CFG_MTU,		/* u16 */
> +	VDPA_ATTR_DEV_NET_CFG_SPEED,		/* u32 */
> +	VDPA_ATTR_DEV_NET_CFG_DUPLEX,		/* u8 */
>  
>  	VDPA_ATTR_DEV_NEGOTIATED_FEATURES,	/* u64 */
>  	VDPA_ATTR_DEV_MGMTDEV_MAX_VQS,		/* u32 */
> -- 
> 2.34.1


