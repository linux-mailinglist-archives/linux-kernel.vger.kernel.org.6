Return-Path: <linux-kernel+bounces-188788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 953938CE6EF
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 16:25:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 18C7AB20C2A
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 14:24:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE11E12C48E;
	Fri, 24 May 2024 14:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="TN8MKuSU"
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A7B12C47A
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 14:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716560691; cv=none; b=bN6Azfc1qL2K80nXgw3XeGvvjKQplr44aAPXOj/ZB7gb/lS7u76CcKUeM5BiM9SE87Jcq0fpX3i7MGfhOkShxcDbYrzjCnEQoiOgsag5G52Lw1PulJUSyWuaAY30B0NiA9SL8mM04enMwLg2RBqlq217ZdtE6cZ/Min8tXPcE10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716560691; c=relaxed/simple;
	bh=GAKoyrn5jaPJBZhMvzIPnR163kOxc9TRWI2BEHr/EOg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n07qfbB2cpU2B/7d2RNeMG1385Bl6zWNoifUtiTDg1YzPfaDjjYcGUPE20I8dMLSCtE5vkEfAJ0phoOEmDeu6TJj/N2mDaKqcsFxHLtDUJ6HvusBWDHaZA2Y0OtkIasx1sBnv7z1muvoN0/j9uKzxlK+J5BM+R7xwT9iRbyNHZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=TN8MKuSU; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-43fb094da40so6195391cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 07:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1716560687; x=1717165487; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8hYkOeLY4QiEED8wXU9jSl5gIYmutzD/WSLBujMKTRo=;
        b=TN8MKuSUv7kOzp1AATaWO5/SNu/JY1be4aCDxAWxoss/L4y88/gjOeNSVthWx9YqA3
         eN7xRHION/ozr9MmZYRZYWLhXQEXg0ubbIQlivPlIv74PvM2Xjmb93JgdxniFF4fff8b
         wQhI6GfGjxCWjHzD+r0hovVvZ2JUrllZC7icoe+5O0SW37PrwnxrcEPYKm73J84ShoS8
         5I6Numt9wCE1ErBHRsMXQB6Ah46uESfJrLrRyKZ7SAkb4cFP9oqEBBTzOStLjMEla5s4
         KR0+Jh5D5vMwgFqLWRenh8X3FokIXkmmOkf5ZYBmcJMgpoztYXSWPQlvDp4E9mLY0Bk7
         QZXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716560687; x=1717165487;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8hYkOeLY4QiEED8wXU9jSl5gIYmutzD/WSLBujMKTRo=;
        b=UDTfbxZwEtOE0KWCtezruEgeVpnenTbwjyia9t6Amx01XgrVBcGX+c/BOpKxXD3bCk
         y8iFMlU0ckAgY+ttkcHBvRM26v3RK/Fd4Ph43CLhJIYamFYEVFG8PUMiJFY0GT/IGwP1
         eBC9OnMHASuB0zjgkJMYFyUCnkwGhjzwqLVINhoM2HLjS1d8J1VCl6wnhYVWM1rqb2cj
         8IPCyFWzp876yoZoVY4Y2xyFEwnvOY/oPfkoNDgMu01H+eHiuUWIG23qeIevquaThxvI
         u87sRRNlcKFXGe+buLbdiAKIkJxq+ntMc7JIrPYbI9U/IyB7oZDyIPmHUwbnwaKjJ3qM
         zHHw==
X-Forwarded-Encrypted: i=1; AJvYcCXVq6dBDc2Qz24WN5t/scXujfpzFFw3PO+JzUKIO9fUHlZFCe5bpNxG3IU4l84U7NlFJUw9l+uygjijFl4M7cvih+QfEI8v3ZF2CLdn
X-Gm-Message-State: AOJu0YyfJjCzzEjc5iFPwIr2So+7IlKZcWzwIRztW9EjohtCjE9FvlnJ
	GCVpStzoDF1EMhgdAEEe+U3Q6XfGaVNQP8Fs3T9qIJZEIjfk/T0RLzw9oHG3sno=
X-Google-Smtp-Source: AGHT+IHQjREFVeKjhgG/zBc9srfJFpq4/cK6ER06u+9Acna36n0WAlHDtLFo5xXKXDhG9YwoKONBbQ==
X-Received: by 2002:ac8:7d81:0:b0:439:d07d:e25f with SMTP id d75a77b69052e-43fafb16fa4mr46187801cf.16.1716560687135;
        Fri, 24 May 2024 07:24:47 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-43fb183507asm8326431cf.56.2024.05.24.07.24.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 May 2024 07:24:46 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sAVqg-001KtA-6F;
	Fri, 24 May 2024 11:24:46 -0300
Date: Fri, 24 May 2024 11:24:46 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: Baolu Lu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Nicolin Chen <nicolinc@nvidia.com>,
	"Liu, Yi L" <yi.l.liu@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	Joel Granados <j.granados@samsung.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 7/9] iommufd: Associate fault object with
 iommufd_hw_pgtable
Message-ID: <20240524142446.GP69273@ziepe.ca>
References: <20240430145710.68112-1-baolu.lu@linux.intel.com>
 <20240430145710.68112-8-baolu.lu@linux.intel.com>
 <BN9PR11MB5276A8E898983310B83C399E8CEC2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <b09f96db-8451-4de9-81c5-312cffdfd4fc@linux.intel.com>
 <BN9PR11MB5276F07A130CD617777A3AAD8CE92@BN9PR11MB5276.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276F07A130CD617777A3AAD8CE92@BN9PR11MB5276.namprd11.prod.outlook.com>

On Mon, May 20, 2024 at 03:39:54AM +0000, Tian, Kevin wrote:
> > From: Baolu Lu <baolu.lu@linux.intel.com>
> > Sent: Monday, May 20, 2024 10:19 AM
> > 
> > On 5/15/24 4:50 PM, Tian, Kevin wrote:
> > >> From: Lu Baolu <baolu.lu@linux.intel.com>
> > >> Sent: Tuesday, April 30, 2024 10:57 PM
> > >>
> > >> @@ -308,6 +314,19 @@ int iommufd_hwpt_alloc(struct iommufd_ucmd
> > >> *ucmd)
> > >>   		goto out_put_pt;
> > >>   	}
> > >>
> > >> +	if (cmd->flags & IOMMU_HWPT_FAULT_ID_VALID) {
> > >> +		struct iommufd_fault *fault;
> > >> +
> > >> +		fault = iommufd_get_fault(ucmd, cmd->fault_id);
> > >> +		if (IS_ERR(fault)) {
> > >> +			rc = PTR_ERR(fault);
> > >> +			goto out_hwpt;
> > >> +		}
> > >> +		hwpt->fault = fault;
> > >> +		hwpt->domain->iopf_handler = iommufd_fault_iopf_handler;
> > >> +		hwpt->domain->fault_data = hwpt;
> > >> +	}
> > >
> > > this is nesting specific. why not moving it to the nested_alloc()?
> > 
> > Nesting is currently a use case for userspace I/O page faults, but this
> > design should be general enough to support other scenarios as well.
> 
> Do we allow user page table w/o nesting?
> 
> What would be a scenario in which the user doesn't manage the
> page table but still want to handle the I/O page fault? The fault
> should always be delivered to the owner managing the page table...

userspace always manages the page table, either it updates the IOPTE
directly in a nest or it calls iommufd map operations.

Ideally the driver will allow PRI on normal cases, although it will
probably never be used.

Jason

