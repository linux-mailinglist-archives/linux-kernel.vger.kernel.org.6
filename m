Return-Path: <linux-kernel+bounces-195902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C96CB8D5426
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 23:05:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 698601F24D7D
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 21:05:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F57D84DE7;
	Thu, 30 May 2024 21:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dX6rMLxq"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E80826F30B
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 21:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717103128; cv=none; b=oWxfZD6EPhQidqcX1D5NAOBjOBnSzEDhnwZqj0RayC5Gb4qJsD/k4GUCfEsmvz7GScjjjSTl2GT+lm48pUIWKLkjNaDhudO1zugon9mqhudUUFhD7I/vKWKvDWrRmu2SU+ACP+9XJkfLUhm0md0WJYXr692Ckfk/uQtqxTZp9S0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717103128; c=relaxed/simple;
	bh=Wab1ZpjxSP/0gKB2mRfLQf1QYdy5fhanYyy8leNd0UU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mJirDrN7ySC8WoBOdhfuXurH/1eckJ8X84qEeh6vHNKRQJu3prSNM7376DXnVc1v3n4ESLTwwbxbYuzSAnpkMBu9kkrSB4DRrfS806pf7x3emewkIx0d2asBq3z/+GA8SfamEcORZDPAthJ96OM3YUwvCOyta12nApWFFqxY6S0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dX6rMLxq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717103125;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Q2LCriRFRXLIylgT+gTKyTfxSCc/meDMgzalNC625x8=;
	b=dX6rMLxqMVfZBxCuOwE9f6acJBT91mY3o8mJ8ayDPEjTEN75Y7bxEQJwpXmMlp73miMbL4
	RqpyMaEWesYs+2K1Toy4dE9cQBqMNLKPUAWmQ7ot7jrEnCKbK9JJVlyNdCG4FEt7mrKqCY
	TiyWYEvlVbjJoQSpcANiNpI8UT9l5uU=
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com
 [209.85.160.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-496-ajddaNuyMvqmwbAElWVKCw-1; Thu, 30 May 2024 17:05:24 -0400
X-MC-Unique: ajddaNuyMvqmwbAElWVKCw-1
Received: by mail-oa1-f70.google.com with SMTP id 586e51a60fabf-24ca35572adso1301745fac.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 14:05:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717103123; x=1717707923;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q2LCriRFRXLIylgT+gTKyTfxSCc/meDMgzalNC625x8=;
        b=xNxN9P2+xtf+VAWGiYR11TPMH4br7tIqDxJqKcewpv8E9k3wAhw/xj4Kt2JpxkaddR
         xHTTw/SUuKinV2TrQh5wHYKpfvuvTphZAV5LZzPYDm9Tl2V/CRPhTASiPkCcGND0H3hb
         vzh5G+vEif1G+R2xCobdxHVw9JbGgYMseXprqKC5S0YpvKuZVeH2Chb4NEP+m/iOZq48
         ST9YpylrmE7DDp/6XVHVMGwAmE+qIr5TOCB/qbMDAHpuiyVV3omV5AhXSGhX/qPZPzPK
         CqcqlJy+f2Im6G8AyOa/+Y8RgfQJ4UEo/VhyCMq5CixvohKC1w91vwuByY+VBWwrvpkP
         PkHA==
X-Forwarded-Encrypted: i=1; AJvYcCXdclS5QV/ulBeczUa1V4qyovBvNiafErcXPQL7xNFylRRvlL1gTXst5iAC03229IfyPpSMI9Mi/D9QLS40xfoTcId1Kr+AqyhGGDla
X-Gm-Message-State: AOJu0Yxst4vKVqXbfOZXNfHLfqkp6FBDQNpZ0FrVm96KZ7OmPjUaEikT
	QCf+tgN/8NnVZBwDIf3onHRJvgi2ptsLMH+hKAl4TZMGUqVp98fqdgyWNT879urpDIR0NfjnbFj
	HinuhQUcUw0oJOfT/Hj7lsMoOVcQlJml8tGI3XFbEF0BiEQpTrIFzDccp6/3xIA==
X-Received: by 2002:a05:6871:2898:b0:24f:ee25:3639 with SMTP id 586e51a60fabf-2508bddc002mr62915fac.26.1717103123401;
        Thu, 30 May 2024 14:05:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHS43guAvWnbjReVwItT6ybaTTo9jHFyw4D9vxJUSkaNCNMDnbU6q11n3Nb7CVhlCdYsvZ4sQ==
X-Received: by 2002:a05:6871:2898:b0:24f:ee25:3639 with SMTP id 586e51a60fabf-2508bddc002mr62888fac.26.1717103123035;
        Thu, 30 May 2024 14:05:23 -0700 (PDT)
Received: from localhost (ip98-179-76-110.ph.ph.cox.net. [98.179.76.110])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-43ff23fd366sm1747411cf.56.2024.05.30.14.05.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 14:05:22 -0700 (PDT)
Date: Thu, 30 May 2024 14:05:21 -0700
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: Dimitri Sivanich <sivanich@hpe.com>
Cc: Yi Zhang <yi.zhang@redhat.com>, "Tian, Kevin" <kevin.tian@intel.com>, 
	Vasant Hegde <vasant.hegde@amd.com>, Baolu Lu <baolu.lu@linux.intel.com>, 
	Joerg Roedel <joro@8bytes.org>, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, 
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	David Wang <00107082@163.com>, Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>, 
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org, Steve Wahl <steve.wahl@hpe.com>, 
	Russ Anderson <russ.anderson@hpe.com>
Subject: Re: [PATCH] iommu/amd: Fix panic accessing amd_iommu_enable_faulting
Message-ID: <hxv32qgpb57yxweldav35evt2e3hyt2n2rmbjsl7biaje7s4tp@4nyanvqd6su5>
References: <ZljHE/R4KLzGU6vx@hpe.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZljHE/R4KLzGU6vx@hpe.com>

On Thu, May 30, 2024 at 01:36:03PM GMT, Dimitri Sivanich wrote:
> This fixes a bug introduced by commit d74169ceb0d2 ("iommu/vt-d: Allocate
> DMAR fault interrupts locally").  The panic happens when
> amd_iommu_enable_faulting is called from CPUHP_AP_ONLINE_DYN context.
> 
> Fixes: d74169ceb0d2 ("iommu/vt-d: Allocate DMAR fault interrupts locally")
> Signed-off-by: Dimitri Sivanich <sivanich@hpe.com>
> Tested-by: Yi Zhang <yi.zhang@redhat.com>
> ---

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

>  drivers/iommu/amd/init.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
> index a18e74878f68..b02b959d12af 100644
> --- a/drivers/iommu/amd/init.c
> +++ b/drivers/iommu/amd/init.c
> @@ -3353,7 +3353,7 @@ int amd_iommu_reenable(int mode)
>  	return 0;
>  }
>  
> -int __init amd_iommu_enable_faulting(unsigned int cpu)
> +int amd_iommu_enable_faulting(unsigned int cpu)
>  {
>  	/* We enable MSI later when PCI is initialized */
>  	return 0;
> -- 
> 2.35.3


