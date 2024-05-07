Return-Path: <linux-kernel+bounces-172539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A87908BF34A
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 02:10:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63C5228A41E
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 00:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E6431A2C2E;
	Tue,  7 May 2024 23:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="TaLFIb8a"
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F7F81A2C1C
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 23:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715126331; cv=none; b=XQ4AXrvR79bPVCOlVohgCUz2FndVZp3beC9zQXZw9uIWJtVHDlbOapZBzh07QG3+C8uUlDegYeCBE/jEG9P0SAYo8X9GdiDSMj0o1jQVKD5Du9v62XKNK+k9SnjoHsw8PvicUJRar0i/PM/VJaV8VNBIzu+atuAzB4bumyANIFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715126331; c=relaxed/simple;
	bh=ylSqnLZbO+zia8UKjkEK25WV8CJGTqFaiaWW/u+DMEo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lNZEa33ysC0/M0mNRQhJ3M6QQJEV6j450ulMoXcVB157GHW275fNsbP/67DgkFXZtXl05YyPr2C3F0NRzS72aXGTeBlKAqbxLGi+dHTvZzbuFbT9sAtWZpD37TO3XKXHPXgbijA1wBR/1vaSFoyYU0nRJCgNR0Ft7blJbhIMTz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=TaLFIb8a; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3c96c096a32so1617014b6e.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2024 16:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1715126328; x=1715731128; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DvtASyflOHvhyFKgb33ra88jVW8QAEN6i7T1g7ME2mI=;
        b=TaLFIb8a5R+329CgRXowOwe0bSLHTUs27HSirM9XKv/Ayi939rcj58FutBQ0sRfkY/
         /RlW0j3jUbsNcOG78g/ltLgCG7YVIf/FnFJG7nWRxOKokR+ixZluMgCscWxOd1ycCGN/
         2CdrtYS3ZhbxCTxb3nnXnngAe9BVt0Z0KG/YzbrFKPzfFLciZowf+8DtzBzJmnUGpkuU
         9M/y/VS8wQ5ldN9gU1DXYN6CaSln9OS5HZLAw7S3K8I0528EfXy3nElY09MafZiXBmZm
         FX1+buqaX9gaekcA53SuswnSH8iRQO27KWbhHDvynOHWTq+dM32EFfjnLIEs7+f15a+G
         dPbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715126328; x=1715731128;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DvtASyflOHvhyFKgb33ra88jVW8QAEN6i7T1g7ME2mI=;
        b=NA5LdEj6cv7K5etjQ+kp5k+2ApTcHMP/vn+/zoOUcsI7/Y5s0fr5EVgt9ALwGgK4UK
         y+jDGRu9wZ63hzIuEBqb3QFSxkGMs/+cenu3qG59EHvH5XgH+lxgLOswi6ezalUfryWo
         MkAIEKTy/RBqhdEQHFN5iwQP5pV55ZB2RITjFloND7HwGJP58GzL6A+p9uXP6pNlPhw2
         xDAujsCaYRTYQGvUVUQAM4ACQEBpEteiu+1zHmmbD+uFadPQWTQBgMNKXidrtCttAEAl
         2pfgq1MWyJyrydU/ioIfJwN2/SGIT1V3fkWegu8KQ8XDUmOJiGhqwStr9SHecJjRxtHS
         Pktg==
X-Forwarded-Encrypted: i=1; AJvYcCXAyL0tdM+9lGJERMpZMNBpLAqcyQy5ISnvLBSzNzC7SBQzL5nIupuEIOzMPGl6//2HOazVIjagEGFy8wF7V7Lygcu0xBThll8No7T8
X-Gm-Message-State: AOJu0YwaVj0yZy3UiwR/Pc/dIzFWdtbvFDJV4BIjqS6rMO4TeC2xHz96
	JVSZ1Hm+TTVt3YLoxeDs1NS8+3U672BV3bPvgPt+LbtshAUCs1/mSpArslfJcH8=
X-Google-Smtp-Source: AGHT+IHu9M7KtAnyALdrftZ/mWuRI60K3nPgZ0sthjqi//C4bjE+htSbFz1y13Y/VO1rSC947qc2mg==
X-Received: by 2002:a05:6808:1393:b0:3c9:66f2:f31a with SMTP id 5614622812f47-3c9852d5e11mr1317313b6e.34.1715126328537;
        Tue, 07 May 2024 16:58:48 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id bi6-20020a05620a318600b00790f74b3814sm5340332qkb.82.2024.05.07.16.58.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 16:58:47 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1s4Uhr-0003Vm-7q;
	Tue, 07 May 2024 20:58:47 -0300
Date: Tue, 7 May 2024 20:58:47 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	Joel Granados <j.granados@samsung.com>, iommu@lists.linux.dev,
	virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/9] iommu: Replace sva_iommu with iommu_attach_handle
Message-ID: <20240507235847.GL4718@ziepe.ca>
References: <20240430145710.68112-1-baolu.lu@linux.intel.com>
 <20240430145710.68112-3-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240430145710.68112-3-baolu.lu@linux.intel.com>

On Tue, Apr 30, 2024 at 10:57:03PM +0800, Lu Baolu wrote:
> diff --git a/drivers/iommu/iommu-priv.h b/drivers/iommu/iommu-priv.h
> index da1addaa1a31..ae65e0b85d69 100644
> --- a/drivers/iommu/iommu-priv.h
> +++ b/drivers/iommu/iommu-priv.h
> @@ -30,6 +30,13 @@ void iommu_device_unregister_bus(struct iommu_device *iommu,
>  
>  struct iommu_attach_handle {
>  	struct iommu_domain		*domain;
> +	union {
> +		/* attach data for SVA domain */
> +		struct {
> +			struct device	*dev;
> +			refcount_t	users;
> +		};
> +	};
>  };

FWIW I was thinking of having the caller allocate the handle and pass it
down, but this seems workable too and is a bit simpler.

> diff --git a/drivers/misc/uacce/uacce.c b/drivers/misc/uacce/uacce.c
> index bdc2e6fda782..b325097421c1 100644
> --- a/drivers/misc/uacce/uacce.c
> +++ b/drivers/misc/uacce/uacce.c
> @@ -106,7 +106,7 @@ static long uacce_fops_compat_ioctl(struct file *filep,
>  static int uacce_bind_queue(struct uacce_device *uacce, struct uacce_queue *q)
>  {
>  	u32 pasid;
> -	struct iommu_sva *handle;
> +	struct iommu_attach_handle *handle;

Though I'm much less keen on this..

Maybe

  struct iommu_attach_handle {
  	struct iommu_domain		*domain;
 	union {
	      struct iommu_sva sva;
 	};
  };

?

Then container_of(sva) to get back to handle and keep the meaningful
type?

Jason

