Return-Path: <linux-kernel+bounces-172541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D96E58BF35F
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 02:13:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77D26B28051
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 00:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B2EB10FF;
	Wed,  8 May 2024 00:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="d8evcJLT"
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E2E633
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 00:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715126697; cv=none; b=LcP/z2l2zyObgVDSld4CZJjK5Q55VIvwGJ+xp0pb6VTmmNZI2YZmsxY4SZOawXb7WL0zNn40ySY1ahSkLZ4fKmrfPDwm5F62wkcs9q1K2vYuI3ZyvUkJHW3rrkpa5zFs4U+ubIheHJzHChhc2eYoNc6QK6Pq+kwIZBFDcMydl9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715126697; c=relaxed/simple;
	bh=EJN6mlEQptyW+8QYnpWcKaJ9kN9jPZky98kePf90PeM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C92rE/rrDptd2ebMFWh9PqIbp3wehUrff9MSWDsDbOkDAXpPKPnTDw8LG5HOdtM1yMPDXP2EfWVDMhJ+wtGuO4xiHy7YMWa2ChLPEztAN4oKFDTQoFUoT9qvk1Ol0AfEzWURpQwSJPAQLieBZ7H+z8fiW8GUArFxIVIk7IShiLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=d8evcJLT; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7928dae7befso328136985a.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2024 17:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1715126695; x=1715731495; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Vwwfu9gXxuRQ/Lnag+3klP7eYPeDRNPyKKE1ARsN48s=;
        b=d8evcJLTJy+8PC0y55ogKbJYsIs07RACpF+JUcjU4FQwxec4Pjhc9SIRrlcsf/gIEF
         JO/rUANvUpt/fuXaGI6CcQ+F/08/HNOsJsKVbh7/k03pQ6LY9VAE2bmpFbSuKidfD2H/
         UhnXbqGFoi7TVrUD25TjwMCEX1kC7VIWAJOucgCNHOrM1U5UDBhb79BpJb0HODBhf75a
         cGTphCQkv31pmV5eOxeeFCtr9LeBBZRMMmSuMTM/SOf0RkWm/z7xwrjYIu9gbbEeG9Yk
         /lJgxIXAQnaaT7BTaoxhNWAU7KKN3r41Z8E2IV8ZULUbT9oPnE72yV0RyoOUu7xCJX+m
         Ofhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715126695; x=1715731495;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vwwfu9gXxuRQ/Lnag+3klP7eYPeDRNPyKKE1ARsN48s=;
        b=VEUonHh2PWSy2KRgXnkurZG6NH7lGXRFQXCH5QiAY/7MqcxlwZ0QYH7n3+6dBKVuI6
         EYe3L2+2nupQj6tOF7uSZX1dN8qAGQHRb/R7LLou65UQXeNFtrnWmmzmOq/4JwnFYXTQ
         pztoggebgq7o5WhN54Kg/1+ct4kRejAcC+lv1caVhevM6jFgR/IFt77519SEQOw8GSUE
         JAQNJBHjD4vckL0IVch5SHnfiU3k+0L6m/rbIewRr3Gf36XKRp9OF3sxIUoftCNLFqnM
         di344WlClsScaVmWQA0Bg3+m3q+mBkWPgkSFUkw4PfiRlVSbZ2DHmjJwUCjeUMRNVq29
         UM4Q==
X-Forwarded-Encrypted: i=1; AJvYcCU0m5dCP3Hwaq0/ZVZVi2m41oBOXkfartMwL/P5FZv4/mh0QvfdximfXe8Oi6zKrTDIHtfxawmTFy1zf80VPGA+5v+B2ftqJ1qPVGV5
X-Gm-Message-State: AOJu0YyACUZTFKOpR4U89GF/6GElcToCmoyCX3isZUhAZjkudaeT/8Q2
	czH8AyRgzEm2JasHhRbo/K65c9QAe50qkg2vROQ7UKr863LfOTMY2hEgTDL9fng=
X-Google-Smtp-Source: AGHT+IHYYyzxl2qn3bcVXy98/9Q/oTYtmKwzIdmiSS76208dyr73dlmOHTUi+Oep8QKsaSqr7cfBKw==
X-Received: by 2002:a05:620a:c07:b0:792:9167:5982 with SMTP id af79cd13be357-792b26ae168mr130112085a.15.1715126695290;
        Tue, 07 May 2024 17:04:55 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id n10-20020a05620a222a00b007929914d7cbsm2454612qkh.81.2024.05.07.17.04.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 17:04:54 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1s4Unm-00040d-AR;
	Tue, 07 May 2024 21:04:54 -0300
Date: Tue, 7 May 2024 21:04:54 -0300
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
Subject: Re: [PATCH v5 3/9] iommu: Add attachment handle to struct iopf_group
Message-ID: <20240508000454.GM4718@ziepe.ca>
References: <20240430145710.68112-1-baolu.lu@linux.intel.com>
 <20240430145710.68112-4-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240430145710.68112-4-baolu.lu@linux.intel.com>

On Tue, Apr 30, 2024 at 10:57:04PM +0800, Lu Baolu wrote:
> @@ -206,8 +197,11 @@ void iommu_report_device_fault(struct device *dev, struct iopf_fault *evt)
>  	if (group == &abort_group)
>  		goto err_abort;
>  
> -	group->domain = get_domain_for_iopf(dev, fault);
> -	if (!group->domain)
> +	if (!(fault->prm.flags & IOMMU_FAULT_PAGE_REQUEST_PASID_VALID) ||
> +	    get_attach_handle_for_iopf(dev, fault->prm.pasid, group))
> +		get_attach_handle_for_iopf(dev, IOMMU_NO_PASID, group);

That seems a bit weird looking?

get_attach_handle_for_iopf(dev, 
   (fault->prm.flags &
   IOMMU_FAULT_PAGE_REQUEST_PASID_VALID) ? fault->prm.pasid : IOMMU_NO_PASID,
   group);

Jason

