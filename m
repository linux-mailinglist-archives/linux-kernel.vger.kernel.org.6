Return-Path: <linux-kernel+bounces-407138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B48E09C694D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 07:32:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BF651F238AA
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 06:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 140E51779B8;
	Wed, 13 Nov 2024 06:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DAxu25BC"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B83251714BC
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 06:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731479542; cv=none; b=FLhzeqMjI41hZSCZ6iynKMuAtx2mgOrAiTKke0V8noiPHaWD3tI26Cqrw/pzOmwDrtC6lrPKxllYBQRxNEEb031/2H17GtPnja9lcLzM9P84blY/Wi0jDx/jwztQKVCFnV+Kjim0W3ozaGHYDby6v56KKVGAf8D2D5o1fwyOck4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731479542; c=relaxed/simple;
	bh=dfPlndrRvx5LRPZ+CoWGofFBd31blE9k7qzq28w1Fn8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SlDeUBNX4KlkfFCVZwpZTM7JpF18KMwN2/JfozUHfuKGXg6wm8rdJYqYVMaZiwDronUk3WztSRUb/nY8fs14DmwnEgqL72S1XDDL8/UVALS7ycqksJT2dJ1JWY0snw547jx2rCF3KXpTjGsWaF9QYzlyEu0X8ilfrfAWwcX26p4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DAxu25BC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731479539;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0tpZJUhLYkQvz4/1c+WZKWxrz55qwMuTFTv1urMtlfE=;
	b=DAxu25BC2smBJ0bBnLUMMny9hhJ4K6di8LW5FefnEYjLigrOFQ0yyTcM4wc4/JIcdPe3M1
	pHwFD09BDO/fKRzZgbVeHBaLmLGelgDk7dx0CHRfRB7kCPK7l3qwXS2RJ2mayB3u03dVB4
	WWe/ZaGh31+YGHDoGqsC9Q1zipZB/9U=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-316-rWZ1YfhgPeOsz7Y9-aZOow-1; Wed, 13 Nov 2024 01:32:18 -0500
X-MC-Unique: rWZ1YfhgPeOsz7Y9-aZOow-1
X-Mimecast-MFC-AGG-ID: rWZ1YfhgPeOsz7Y9-aZOow
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-37d59ad50f3so3588921f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 22:32:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731479536; x=1732084336;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0tpZJUhLYkQvz4/1c+WZKWxrz55qwMuTFTv1urMtlfE=;
        b=PdK0LJrYRzi+3j76yyCnB91yliL1jgvclpABGiII8bE8L5IhLvV+SOzeVig1twy0HK
         oRocN55q4mlwqlNuK1TKoljCCARXcnaycj1rDQ1lyGeIHXTR1WTjwsO1ToESacf9ZqHi
         B6kihknWQqr4Ek+G61r7qtvOANYCcUDDNmBPBNZfgG4UC5Llofahx9E30Fs6P4BEXpYt
         Ok5Zv86kcV9Nipcxl4h4tdwo+1AUhR/RsSMq3AC7HE07Z+kEmz01BP+4G51pzutFbndl
         IEdhTiupznfqp1T62y7f4EfNkXPa54apdiAD6K+O6i00xoF0x6BNH2X0sbQA4bMlVAZf
         DVMw==
X-Forwarded-Encrypted: i=1; AJvYcCUVmO0Vlr8aKogciQ89KFtqRkoQdik4v9kMuQMvM7aAIcST73wo3697If6c3QrSJU1xjFJNfehdcXKgo30=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWTXA3nWuS5xk0O6g0F81UO8O960JemNFQJIwYR6pskNMzgd/q
	7iJPbXT0d9EkxpvfrTpsBx2cYXQfm6zuYrt49OxKhU3QGXjoPduVdAqigeEwU8JaK9XHt0wVs0h
	ODmbQxU7S+vDOsD4n3Cwrifr4f35Yb4szbT+FiA6Wy2K5ceKFxG75GcUysKpygxEc/FDxLQ==
X-Received: by 2002:a05:6000:70d:b0:37d:3e6d:3c2f with SMTP id ffacd0b85a97d-381f1883bc1mr15818764f8f.47.1731479536587;
        Tue, 12 Nov 2024 22:32:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFm7j62RQtg2vMQRf7xE09cRkKXHfFgJ32M3aHTjmYlfby7/gQk3bMsScUdd8LU3HRpv1DW5w==
X-Received: by 2002:a05:6000:70d:b0:37d:3e6d:3c2f with SMTP id ffacd0b85a97d-381f1883bc1mr15818736f8f.47.1731479536229;
        Tue, 12 Nov 2024 22:32:16 -0800 (PST)
Received: from redhat.com ([2a02:14f:17b:c70e:bfc8:d369:451b:c405])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381ed9f8984sm17650303f8f.71.2024.11.12.22.32.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 22:32:15 -0800 (PST)
Date: Wed, 13 Nov 2024 01:32:10 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: virtualization@lists.linux.dev, Si-Wei Liu <si-wei.liu@oracle.com>,
	Jason Wang <jasowang@redhat.com>,
	Eugenio Perez Martin <eperezma@redhat.com>, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org, Gal Pressman <gal@nvidia.com>,
	Parav Pandit <parav@nvidia.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH vhost 2/2] vdpa/mlx5: Fix suboptimal range on iotlb
 iteration
Message-ID: <20241113013149-mutt-send-email-mst@kernel.org>
References: <20241021134040.975221-1-dtatulea@nvidia.com>
 <20241021134040.975221-3-dtatulea@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241021134040.975221-3-dtatulea@nvidia.com>

On Mon, Oct 21, 2024 at 04:40:40PM +0300, Dragos Tatulea wrote:
> From: Si-Wei Liu <si-wei.liu@oracle.com>
> 
> The starting iova address to iterate iotlb map entry within a range
> was set to an irrelevant value when passing to the itree_next()
> iterator, although luckily it doesn't affect the outcome of finding
> out the granule of the smallest iotlb map size. Fix the code to make
> it consistent with the following for-loop.
> 
> Fixes: 94abbccdf291 ("vdpa/mlx5: Add shared memory registration code")


But the cover letter says "that's why it does not have a fixes tag".
Confused.

> Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> ---
>  drivers/vdpa/mlx5/core/mr.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/vdpa/mlx5/core/mr.c b/drivers/vdpa/mlx5/core/mr.c
> index 7d0c83b5b071..8455f08f5d40 100644
> --- a/drivers/vdpa/mlx5/core/mr.c
> +++ b/drivers/vdpa/mlx5/core/mr.c
> @@ -368,7 +368,6 @@ static int map_direct_mr(struct mlx5_vdpa_dev *mvdev, struct mlx5_vdpa_direct_mr
>  	unsigned long lgcd = 0;
>  	int log_entity_size;
>  	unsigned long size;
> -	u64 start = 0;
>  	int err;
>  	struct page *pg;
>  	unsigned int nsg;
> @@ -379,10 +378,9 @@ static int map_direct_mr(struct mlx5_vdpa_dev *mvdev, struct mlx5_vdpa_direct_mr
>  	struct device *dma = mvdev->vdev.dma_dev;
>  
>  	for (map = vhost_iotlb_itree_first(iotlb, mr->start, mr->end - 1);
> -	     map; map = vhost_iotlb_itree_next(map, start, mr->end - 1)) {
> +	     map; map = vhost_iotlb_itree_next(map, mr->start, mr->end - 1)) {
>  		size = maplen(map, mr);
>  		lgcd = gcd(lgcd, size);
> -		start += size;
>  	}
>  	log_entity_size = ilog2(lgcd);
>  
> -- 
> 2.46.1


