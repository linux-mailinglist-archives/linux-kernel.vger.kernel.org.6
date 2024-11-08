Return-Path: <linux-kernel+bounces-401576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B66599C1C72
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 12:52:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 492F91F240AE
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 11:52:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B759A1E47A8;
	Fri,  8 Nov 2024 11:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eyBR234B"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7814838DC8
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 11:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731066717; cv=none; b=DqHfVyb8TB9BHFGkOJr4FT0r2j1GV8mvIfNGNJQ/8b3D/IIGlLTtfeE3A/e2gHc0U7qQ57cg/2vsd012w3NQHZgyJBgxc060rV/FmxT7oiBRvAVUHX0aSekoNZOF6+qesgj4De/VEnyn2c9jSX7q7xW/o7tpRSidzQuDDPrBOyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731066717; c=relaxed/simple;
	bh=IdemLiGe2lleN2NhPFCYNBCFN+rRsyiDuFSx/WM/0Lg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UvyPFFGIwC4JJPf3x+IXsWah6R3aHew8BOA0NId7kE/SHyjth+mU9+zLfz+3s+ry8b+2y6EhbRSb3E6dPCroFzEN4ene/Gkz/KJqS5yRo0Zh4tbxNqCu2M4bseIVOcc/gugBM71zkZgIibX1BtLdW48PDTLyq1zDV/kimSL7bx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eyBR234B; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731066714;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RVMdf0uo3gDNaUoTkIjmu00DNjqcMxBxoCSu1o0JEIg=;
	b=eyBR234BPctUOQJZnOmcyW3krh5ATkMGkUgvLb4WB2TjIWWLQBpVkvcdgXZl0AHPurDCp9
	zRv2IMEbY1XhlRB5rHDemQ5gy/P7PABap429mwqQRZWZ83YhbwTwpNebTIzes38NUvrXN5
	k8wSsNkV2AWiHCFbaj99rRiBPIHOTvY=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-118-Zrya7DcGOwWKPUxyPxKzUw-1; Fri, 08 Nov 2024 06:51:53 -0500
X-MC-Unique: Zrya7DcGOwWKPUxyPxKzUw-1
X-Mimecast-MFC-AGG-ID: Zrya7DcGOwWKPUxyPxKzUw
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a9a04210851so138869566b.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2024 03:51:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731066712; x=1731671512;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RVMdf0uo3gDNaUoTkIjmu00DNjqcMxBxoCSu1o0JEIg=;
        b=bwTP9nkHuDSgsCHBdieZAqWNwGykUmvbYKelgdKmV+FsJpeD+bw34WNAxGkzdXr8A6
         OTxR+t0XR6OV5KhLFtBJ1L93KSAmFClWZVDXWagIE5p5RG01OKwiA3wCczcl6PM7K2FB
         V8gyoZuFfIcipwkVjRtomzQypdw1p73WbIiXVdvejlSVT5Tw4N6QwK6nSEy+161Du0/P
         c13R5RS4z6OfoOxZVDh1ULbqA6VJAz+kTwUqzm7LwrT9vodZaFzX+Q3SKcV/Uf0kvDKp
         LIwcVSbO478ovEiz+J5Zh1jMpTlDFFYLGAZj6TMxrsiZXXDOhr1ex+ClbnoPNCilGQU1
         5N6A==
X-Forwarded-Encrypted: i=1; AJvYcCUmCKRppyohCBBq66ekjmLGWYYMQtbl2S5g0KDL1SHXgp9qfm2RR4LSsRikewrNCUKxcaqk6clmMXretaQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxiol8sZZQvAoEIL54W1+xKNCIuetfvPGf8TmuQDpad68oIuZfQ
	7/GbsE2kU/CXv/xXs5fRvJ/tc6Rf5YPIV4qX//cKbv5LrRla+OlaT1LdGKHx/nxM1+Z+JOX0Xwk
	F/27LdRHgsJtSlTT6z9pErr+HVsjRVLHz2/buu8VhSko0l/6gL92o74y+pvt5Dm/QB7CP8A==
X-Received: by 2002:a17:907:8693:b0:a9a:26a1:1963 with SMTP id a640c23a62f3a-a9eefebd0dcmr232324466b.7.1731066711852;
        Fri, 08 Nov 2024 03:51:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFD0qTCLuzzpiQx4UleeDpBK4lEUwR0v0HeuCVIE9uNsxnMpSj0z1K6MCEU5lE8j24eebBDzQ==
X-Received: by 2002:a17:907:8693:b0:a9a:26a1:1963 with SMTP id a640c23a62f3a-a9eefebd0dcmr232321966b.7.1731066711377;
        Fri, 08 Nov 2024 03:51:51 -0800 (PST)
Received: from redhat.com ([2a02:14f:179:39a6:9751:f8aa:307a:2952])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9ee0a4a995sm225542166b.61.2024.11.08.03.51.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 03:51:50 -0800 (PST)
Date: Fri, 8 Nov 2024 06:51:43 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: Carlos Bilbao <carlos.bilbao.osdev@gmail.com>, jasowang@redhat.com,
	shannon.nelson@amd.com, sashal@kernel.org,
	alvaro.karsz@solid-run.com, christophe.jaillet@wanadoo.fr,
	steven.sistare@oracle.com, bilbao@vt.edu,
	xuanzhuo@linux.alibaba.com, johnah.palmer@oracle.com,
	eperezma@redhat.com, cratiu@nvidia.com,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	Carlos Bilbao <cbilbao@digitalocean.com>
Subject: Re: [PATCH v3 1/2] vdpa/mlx5: Set speed and duplex of vDPA devices
 to UNKNOWN
Message-ID: <20241108065046-mutt-send-email-mst@kernel.org>
References: <20240904151115.205622-1-carlos.bilbao.osdev@gmail.com>
 <20240904151115.205622-2-carlos.bilbao.osdev@gmail.com>
 <20241107164932-mutt-send-email-mst@kernel.org>
 <f1d671ff-0429-4cb5-a6e8-309a8567924c@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f1d671ff-0429-4cb5-a6e8-309a8567924c@nvidia.com>

On Fri, Nov 08, 2024 at 10:31:58AM +0100, Dragos Tatulea wrote:
> 
> 
> On 07.11.24 22:50, Michael S. Tsirkin wrote:
> > On Wed, Sep 04, 2024 at 10:11:14AM -0500, Carlos Bilbao wrote:
> >> From: Carlos Bilbao <cbilbao@digitalocean.com>
> >>
> >> Initialize the speed and duplex fields in virtio_net_config to UNKNOWN.
> >> This is needed because mlx5_vdpa vDPA devices currently do not support the
> >> VIRTIO_NET_F_SPEED_DUPLEX feature which reports speed and duplex.
> > 
> > I see no logic here. Without this feature bit, guests will not read
> > this field, why do we suddenly need to initialize it?
> > 
> IIRC, Carlos was reading data via ioctl VHOST_VDPA_GET_CONFIG which calls
> .get_config() directly, always exposing the speed and duplex config fields [0].
> Carlos, was this the case?
> 
> [0] https://lore.kernel.org/lkml/afcbf041-7613-48e6-8088-9d52edd907ff@nvidia.com/T/
> 
> Thanks,
> Dragos

Basically, driver should ignore these if feature is not set.


> >> Add
> >> needed helper cpu_to_mlx5vdpa32() to convert endianness of speed.
> >>
> >> Signed-off-by: Carlos Bilbao <cbilbao@digitalocean.com>
> >> Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
> >> ---
> >>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 12 ++++++++++++
> >>  1 file changed, 12 insertions(+)
> >>
> >> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> >> index b56aae3f7be3..41ca268d43ff 100644
> >> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> >> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> >> @@ -173,6 +173,11 @@ static __virtio16 cpu_to_mlx5vdpa16(struct mlx5_vdpa_dev *mvdev, u16 val)
> >>  	return __cpu_to_virtio16(mlx5_vdpa_is_little_endian(mvdev), val);
> >>  }
> >>  
> >> +static __virtio32 cpu_to_mlx5vdpa32(struct mlx5_vdpa_dev *mvdev, u32 val)
> >> +{
> >> +	return __cpu_to_virtio32(mlx5_vdpa_is_little_endian(mvdev), val);
> >> +}
> >> +
> >>  static u16 ctrl_vq_idx(struct mlx5_vdpa_dev *mvdev)
> >>  {
> >>  	if (!(mvdev->actual_features & BIT_ULL(VIRTIO_NET_F_MQ)))
> >> @@ -3433,6 +3438,13 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
> >>  	init_rwsem(&ndev->reslock);
> >>  	config = &ndev->config;
> >>  
> >> +	/*
> >> +	 * mlx5_vdpa vDPA devices currently don't support reporting or
> >> +	 * setting the speed or duplex.
> >> +	 */
> >> +	config->speed  = cpu_to_mlx5vdpa32(mvdev, SPEED_UNKNOWN);
> >> +	config->duplex = DUPLEX_UNKNOWN;
> >> +
> >>  	if (add_config->mask & BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MTU)) {
> >>  		err = config_func_mtu(mdev, add_config->net.mtu);
> >>  		if (err)
> >> -- 
> >> 2.34.1
> > 


