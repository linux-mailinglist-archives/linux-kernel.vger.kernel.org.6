Return-Path: <linux-kernel+bounces-176017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 169BF8C28C6
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 18:29:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF291284EF7
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 16:29:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 836AB176FC6;
	Fri, 10 May 2024 16:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="aH1dCE1Y"
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1208174EF3
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 16:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715358539; cv=none; b=CxpE1IJ2tGxm2SGJtfnzKzNxaOOZOrmBK0rC7ikmptZHI3n8uJXwTQCwcvpjMSvv8uaqJrYJkprDzkKocnQ4+DZw2a1sRobe4n5gei3K9o7XsX4pryGHPp0OVFA/zJrIMk/rk3G/AsYHYPETYsiLcPy/LKKo5k8N/EyA06T971E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715358539; c=relaxed/simple;
	bh=qRAfYIuRtk26fUbO0g/YhxEfQgubTQ5I5K3SO5qx7O0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KHD4zQHFdbkklQrN3n6AFNrKS7bHOhVgXgEBzsbOgNmtCRxgvfRuYf19zww7Ngexs3Dbw5IGx/IyMqCsxTocr3La3dGE/x2vJZlCI4XSuBmZPY1isEQZIqatDUUhSVDAVAjBvfGiBRdq7BqvweDvGqelv0j9148qL1KTkcE1Knw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=aH1dCE1Y; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-78f056f928eso137078785a.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 09:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1715358535; x=1715963335; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YgVJGtSdSQoxiH/JwZGPbdmDn+FTEW1VhqEVzZ5vcs0=;
        b=aH1dCE1YJryGJPNrpHNEsjgJhQIkoyfaYaNSYOkFT1y/P6rVXPPx4t8vBdbo7JddPg
         qfkFfu+bXKfLBlGiJqs9O/wBmfn5T218jWvviQI7RqdCRghMcUczbQegkmIIISfm5Z2F
         7X1d+bFAqAl6CJcmHzFELMtb8ngUiYjY0Zg2F3qrSysDGW0qVjnvWfpaMwfAEdbmOwA6
         nBGUo5dwISZQfqq7o9gzQNl6Nel5OnWspFb8y5/BXODFq/xQJ9Bkitt8BuoaWLAUcLJp
         M7qgcuiKVT/z09Urp9ZSk4AsBoBDnbl3lxIhvOiJOhnO6bXGiUNL3KgwTte8/FiFyRYG
         8HcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715358535; x=1715963335;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YgVJGtSdSQoxiH/JwZGPbdmDn+FTEW1VhqEVzZ5vcs0=;
        b=VTJM18s8XxmQey3S8yJABq3B9Gj0QTQHOsfChro4SR9GRWHy9bPJkPiGBFUSUk6kQ3
         5X0p9vwEnR/8K0v95F4uhEmimmrzKRCoEcQBVHHiz6+nhz1MT+35j8qnd/fUaAqA8DkR
         ouNwwQQo6kh4j5giECTw0DxaR0J8ugAxsf7smV7fzrxdULr5fJ4q/RGrOGWNdPToakKI
         JBgGZjtWI1Sz16UdwiUohTHzcF77V093U83BjDYuJaIny08ZDg0+AyvJX3Ji5cgUkO/Q
         2y0QzRLRwebaw6ZlCYyfjyyfLfTKXdOIV8nNn3vT1dZOBsdFux4XNzKnbSQxaHUoKRrP
         qtsw==
X-Forwarded-Encrypted: i=1; AJvYcCVXz+db1v7M2Vk2yUjZIsB/OqHK7K7abZ6Zw9T+r2e3fhYTqm8EujMfCYmKl+RO03qdMdZwRfYhqirS+LMTs/BFkaDRXcI+sHIAncKF
X-Gm-Message-State: AOJu0YxxCemtDDKB5cZ1a+gA6xJ+IA5wX8tFlr+aFw5tgpXGNkm3W8GB
	bNoUIRT72Ub0l1mgpxPJGO6r4GNMC8GPEoUUJJCuXLmhzmjagofzKkR4YbE1OjY=
X-Google-Smtp-Source: AGHT+IEBNBZwJ7UY/w207T6liKWy0qcUwPh16uAcjxrCG90REmApCaJsv6Dn931r+vPN21G8/a76Hw==
X-Received: by 2002:a05:6214:3186:b0:6a0:ae8a:e8ba with SMTP id 6a1803df08f44-6a168141010mr32027096d6.10.1715358535647;
        Fri, 10 May 2024 09:28:55 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6a15f1cd35bsm18630826d6.87.2024.05.10.09.28.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 May 2024 09:28:55 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1s5T78-006c0p-B6;
	Fri, 10 May 2024 13:28:54 -0300
Date: Fri, 10 May 2024 13:28:54 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	Joel Granados <j.granados@samsung.com>, iommu@lists.linux.dev,
	virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/9] iommu: Add attachment handle to struct iopf_group
Message-ID: <20240510162854.GY4718@ziepe.ca>
References: <20240430145710.68112-1-baolu.lu@linux.intel.com>
 <20240430145710.68112-4-baolu.lu@linux.intel.com>
 <20240508000454.GM4718@ziepe.ca>
 <21ffbcc7-1103-4481-af14-5ee8856b9625@linux.intel.com>
 <20240510133824.GW4718@ziepe.ca>
 <0de7c71f-571a-4800-8f2b-9eda0c6b75de@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0de7c71f-571a-4800-8f2b-9eda0c6b75de@linux.intel.com>

On Fri, May 10, 2024 at 10:30:10PM +0800, Baolu Lu wrote:

> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 35ae9a6f73d3..09b4e671dcee 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -173,6 +173,8 @@ struct iommu_domain_geometry {
> 
>  #define __IOMMU_DOMAIN_NESTED  (1U << 6)  /* User-managed address space
> nested
>                                               on a stage-2 translation
> */
> +#define __IOMMU_DOMAIN_PASID   (1U << 7)  /* User-managed domain for a
> +                                             specific PASID*/
> 
>  #define IOMMU_DOMAIN_ALLOC_FLAGS ~__IOMMU_DOMAIN_DMA_FQ
>  /*
> @@ -204,6 +206,9 @@ struct iommu_domain_geometry {
>  #define IOMMU_DOMAIN_SVA       (__IOMMU_DOMAIN_SVA)
>  #define IOMMU_DOMAIN_PLATFORM  (__IOMMU_DOMAIN_PLATFORM)
>  #define IOMMU_DOMAIN_NESTED    (__IOMMU_DOMAIN_NESTED)
> +#define IOMMU_DOMAIN_NESTED_PASID                              \
> +                               (__IOMMU_DOMAIN_NESTED |        \
> +                                __IOMMU_DOMAIN_PASID)

Yeah, something like that, I don't know about naming though..

How about

DOMAIN_NESTED = Attachment to RID or PASID
DOMAIN_NESTED_PASID_TABLE = RID and the entire PASID space

?

Jason

