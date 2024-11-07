Return-Path: <linux-kernel+bounces-400710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ABDF9C1146
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 22:50:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F39E1F233FA
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 21:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75D0021892F;
	Thu,  7 Nov 2024 21:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KvuT9W+s"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32C57213EC7
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 21:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731016221; cv=none; b=Q4d/H46VfloVGdkB49xHgixfZmYOLRKNObAQgnrHYZBUiujW+uZ9OiMQY6QTPaTWRQTbaTAWQHU8AAEpY/jWrMcCAU8OhuZybJ9WaSNLNYgtq3D+c/kMpsK9QrGukZY7MwqDjqMfR/Y9xStGYcn3F5PX7E3EFVqchWmigXKQBwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731016221; c=relaxed/simple;
	bh=pst33w5MBGaHwFI2CZYkiWO99oANTIkX7lPh4MyoqE4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=unVhbezMpBmvAE3TrA0QeCW12t/bLXQRVzZk3yrzi/rgfHe6D4Zyrrf6wllG637+2r9BvnUP+Na2ZOSIHbK6Ogy1zsaIhWHIXE/PFLI8SiygxbimNtTN9JUgW6h8JFYbvVnInDjsIh2xCW5vFknhklvH3ymoWl9/rjLDtXp2FC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KvuT9W+s; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731016219;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=l18LLKMDfqxNEVCeijQW2WIw0xKoPj/t5wcWlYhyNaQ=;
	b=KvuT9W+sBIQcOv35KNv3pQwfIhKorpiMaNtlZ0XdGIqrHQRdRMBusKJdJKqKoifsySlQAA
	up6ObSlWY21IAXXpomZbzvy8F9GcZzwmpr/C5XfHg4CZpOu0UhOjAPmbQrBFi7bdVDGzRE
	o9MprPjdnHMj3DMawHH+Cr26n/19nig=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-299-T-bzoMXXOmGpLHwZxCUpMA-1; Thu, 07 Nov 2024 16:50:17 -0500
X-MC-Unique: T-bzoMXXOmGpLHwZxCUpMA-1
X-Mimecast-MFC-AGG-ID: T-bzoMXXOmGpLHwZxCUpMA
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-5c934295846so983839a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2024 13:50:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731016217; x=1731621017;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l18LLKMDfqxNEVCeijQW2WIw0xKoPj/t5wcWlYhyNaQ=;
        b=gM+SQx2Mw2kTwzu6gXjlFbtORLE2EbTHD8HeQ6CkFWFLUQtLC2PiayxPHjSWFxtfbH
         lyxr0RScrTdj99TCyQMYzwLolONYyXeLuHH3k0fv+vwbSdtnoJb6d8y93VvDHHa6zsLr
         uhlhKbFsXm2SLGB0mMxhDrfor1EbTf3GLG0QOd3TySx0mu9iFDSO9f/0+O420hGRtzej
         mEiBShm+KpieEPFWQDB5c2AK9HR3xcBCzjewxyhfeHq9kabGBnUwlMtNgZNFIl8zH+8x
         9zFnfwzyRV071jbVzU6Ymy3xioznlxpA6kovCvi1XxrPpayd4un2iUppwtLNJ3WCNI4t
         jmRQ==
X-Forwarded-Encrypted: i=1; AJvYcCWOkBmjZ6lTL1ulE9j7PHCT6fqTaBNzUcUiGxGSuzsCcHNG9XvjiN6wDvvxKBB9xnpfKYAa05RAMoPmhOc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1NdFuoQbRtazliGOPxCacp1QHAvdAT0wwmH3UjW+/MDJIdbau
	qPFf/rMPxFtoSaYZbD6S/vTl1z/WXIHDkDkLwx4zAxjOmaH70tzGxpAFWIdkVlGV4ljUqfByhCQ
	qsysJQ/ZUOrKPrU/hDmHccSonT9MPaglmMXo2NKrV/6Zj4Z0AWLCa34hQwjejJA==
X-Received: by 2002:a05:6402:2744:b0:5cf:c5d:3821 with SMTP id 4fb4d7f45d1cf-5cf0c5d389fmr236606a12.32.1731016216617;
        Thu, 07 Nov 2024 13:50:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH6nDc50TzAQL4eJHDTWajE9g/rEFVvsViceWaZynJTGUxmlB32dBLzNO6F7e97OIiqtIhyXg==
X-Received: by 2002:a05:6402:2744:b0:5cf:c5d:3821 with SMTP id 4fb4d7f45d1cf-5cf0c5d389fmr236573a12.32.1731016216212;
        Thu, 07 Nov 2024 13:50:16 -0800 (PST)
Received: from redhat.com ([2a02:14f:179:39a6:9751:f8aa:307a:2952])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cf08ca5bdesm439054a12.11.2024.11.07.13.50.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 13:50:14 -0800 (PST)
Date: Thu, 7 Nov 2024 16:50:06 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Carlos Bilbao <carlos.bilbao.osdev@gmail.com>
Cc: dtatulea@nvidia.com, jasowang@redhat.com, shannon.nelson@amd.com,
	sashal@kernel.org, alvaro.karsz@solid-run.com,
	christophe.jaillet@wanadoo.fr, steven.sistare@oracle.com,
	bilbao@vt.edu, xuanzhuo@linux.alibaba.com, johnah.palmer@oracle.com,
	eperezma@redhat.com, cratiu@nvidia.com,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	Carlos Bilbao <cbilbao@digitalocean.com>
Subject: Re: [PATCH v3 1/2] vdpa/mlx5: Set speed and duplex of vDPA devices
 to UNKNOWN
Message-ID: <20241107164932-mutt-send-email-mst@kernel.org>
References: <20240904151115.205622-1-carlos.bilbao.osdev@gmail.com>
 <20240904151115.205622-2-carlos.bilbao.osdev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240904151115.205622-2-carlos.bilbao.osdev@gmail.com>

On Wed, Sep 04, 2024 at 10:11:14AM -0500, Carlos Bilbao wrote:
> From: Carlos Bilbao <cbilbao@digitalocean.com>
> 
> Initialize the speed and duplex fields in virtio_net_config to UNKNOWN.
> This is needed because mlx5_vdpa vDPA devices currently do not support the
> VIRTIO_NET_F_SPEED_DUPLEX feature which reports speed and duplex.

I see no logic here. Without this feature bit, guests will not read
this field, why do we suddenly need to initialize it?

> Add
> needed helper cpu_to_mlx5vdpa32() to convert endianness of speed.
> 
> Signed-off-by: Carlos Bilbao <cbilbao@digitalocean.com>
> Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
> ---
>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> index b56aae3f7be3..41ca268d43ff 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -173,6 +173,11 @@ static __virtio16 cpu_to_mlx5vdpa16(struct mlx5_vdpa_dev *mvdev, u16 val)
>  	return __cpu_to_virtio16(mlx5_vdpa_is_little_endian(mvdev), val);
>  }
>  
> +static __virtio32 cpu_to_mlx5vdpa32(struct mlx5_vdpa_dev *mvdev, u32 val)
> +{
> +	return __cpu_to_virtio32(mlx5_vdpa_is_little_endian(mvdev), val);
> +}
> +
>  static u16 ctrl_vq_idx(struct mlx5_vdpa_dev *mvdev)
>  {
>  	if (!(mvdev->actual_features & BIT_ULL(VIRTIO_NET_F_MQ)))
> @@ -3433,6 +3438,13 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
>  	init_rwsem(&ndev->reslock);
>  	config = &ndev->config;
>  
> +	/*
> +	 * mlx5_vdpa vDPA devices currently don't support reporting or
> +	 * setting the speed or duplex.
> +	 */
> +	config->speed  = cpu_to_mlx5vdpa32(mvdev, SPEED_UNKNOWN);
> +	config->duplex = DUPLEX_UNKNOWN;
> +
>  	if (add_config->mask & BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MTU)) {
>  		err = config_func_mtu(mdev, add_config->net.mtu);
>  		if (err)
> -- 
> 2.34.1


