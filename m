Return-Path: <linux-kernel+bounces-234738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4120F91C9ED
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 03:13:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E32FF1F22C59
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 01:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AA6D2230F;
	Sat, 29 Jun 2024 01:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="fYM8CNVV"
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66A241C17
	for <linux-kernel@vger.kernel.org>; Sat, 29 Jun 2024 01:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719623516; cv=none; b=TEc4Q4Um6EaSvyj+oOjKMF2XDEZH11uxQC8k+nIXZlo9DJPY/u4DeowK698332bcRjgvQ2Hl52p9Ban4lZVFAAqomkt6twrJ+d83NauHlPBD8Sm20lA0rz6wMiEOs8HOYEORSCp5z3a6Rb4m7LuZpectSvPo82nxQdNE19pAvkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719623516; c=relaxed/simple;
	bh=GNugPRiQq86y98AWq/VYhSjbxZhyTSYTdolFKkCRkP8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q9DS8YuOt8Zu+gI/9aWHC4KQ4FSVo7xFqxM4X/sd6o3C2TfuH/CTpmFVdQUoR56J9xTi/ageS/PM4MTVfOZN7tI2fUk0SdOmo4iuF3h+WfkeLZy1acVvIsnPWu9pdwq7ULh3f8dhtPDXVPJPuSX7J5Vgm1uKSJ30TNQLQ3FBSyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=fYM8CNVV; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-5b97a9a9b4bso469182eaf.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 18:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1719623514; x=1720228314; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=N5mjPkWmG50LdKz2/yPWjPta2U3jK4ZpVUj00ksCRiY=;
        b=fYM8CNVVLP4NKeDsnzw4IZ58oiT0/n+Gzkcp0fJ0DV5I/mk87N5PNc3kW+BMhzptSw
         r/wmL/DiCytM6ztqmryzdW0nAEjeZ3hKW+IdetC/35edfqNMRjeR9gMdL3g27p78HMXH
         iM7FSxCC7ZZAA0bHkNDy6+Nw8zfxWFo9m6Xe0e817TuhTU2+og+FWOMnQJf90cMD8Tny
         mliqrkN52bvb/uYDwbgcpJ9AiM4u2Nh75YLOFO9myovNZm9C2RnKZcf9sPnxH0lUylwd
         aESus5U5za16m/TNWANXn426hDKMKqiv2H5NixovWmx0O7lrJP7oIrD6Dr5AZHWBqSSM
         Odaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719623514; x=1720228314;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N5mjPkWmG50LdKz2/yPWjPta2U3jK4ZpVUj00ksCRiY=;
        b=FrTuYtnoOfmIiHThY9FFjsZF1POS4J+rVQjNUpUtrXX77zehiFcb33lFRqjhls+G6I
         hCSpmOQMdalUUhb2FNX9lfH5472VT5NZBU9lHjqTCqWJIPkJz5bYBOezviGJiE7XXSks
         QfEAEMaFdjAHI3i8JozcuQuhbM9H3UK6PNFmjbcBDB9JoSofiXG+YO7FIZLL7zrU7/Yp
         IB0sm/FIDXBRKwGDligMTWr56uCVPd956zNNJNXuKwXYi2CSPiSj+2kXTSEFhU66Alch
         glM6jjzAMIgO6ehOfoURNAPAGnX67PEXKt+G/+flHW/vfpFh5znOCFh5rA5e9CZT8Zqr
         VMjA==
X-Forwarded-Encrypted: i=1; AJvYcCUwhkMVAdQzbtkDO4bUeHWho2xhqLcKdyUNQuWIoC0UMLjcCLgGKbbP5+g9WCPfhWZIW2kRPWpfkHbXF1e2XOF+gOuFBUszfAFYT9t4
X-Gm-Message-State: AOJu0Ywl87HCLhvFQqBYUvtHxSah4tEfDzib6qPRkcdgDBd6XOl+SieT
	Y1XqAQSWimLwjxxg98IiGZJUmfsbSZGcmVGijYQIqDHMmThzDkrfpUbkq8VIQlc=
X-Google-Smtp-Source: AGHT+IGfnIitLwF85zOIc5aolWihTG9UNRr/tXG1jKGcZH+0/16zVksXuzB7Rp8rLXO3PNhWvv8y8g==
X-Received: by 2002:a05:6359:1a46:b0:1a2:58b6:9728 with SMTP id e5c5f4694b2df-1a258b69a79mr924344355d.18.1719623514328;
        Fri, 28 Jun 2024 18:11:54 -0700 (PDT)
Received: from ziepe.ca ([24.114.37.55])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-72c69b53be5sm1784142a12.16.2024.06.28.18.11.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 18:11:53 -0700 (PDT)
Received: from jgg by jggl with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sNIWS-0004Ai-3J;
	Fri, 28 Jun 2024 17:48:44 -0300
Date: Fri, 28 Jun 2024 17:48:44 -0300
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
Subject: Re: [PATCH v7 03/10] iommu: Add attach handle to struct iopf_group
Message-ID: <Zn8hrOfw65PTvfYv@ziepe.ca>
References: <20240616061155.169343-1-baolu.lu@linux.intel.com>
 <20240616061155.169343-4-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240616061155.169343-4-baolu.lu@linux.intel.com>

On Sun, Jun 16, 2024 at 02:11:48PM +0800, Lu Baolu wrote:
> Previously, the domain that a page fault targets is stored in an
> iopf_group, which represents a minimal set of page faults. With the
> introduction of attach handle, replace the domain with the handle
> so that the fault handler can obtain more information as needed
> when handling the faults.
> 
> iommu_report_device_fault() is currently used for SVA page faults,
> which handles the page fault in an internal cycle. The domain is retrieved
> with iommu_get_domain_for_dev_pasid() if the pasid in the fault message
> is valid. This doesn't work in IOMMUFD case, where if the pasid table of
> a device is wholly managed by user space, there is no domain attached to
> the PASID of the device, and all page faults are forwarded through a
> NESTING domain attaching to RID.
> 
> Add a new IOMMU capability flag, IOMMU_CAP_USER_IOASID_TABLE, which
> indicates if the IOMMU driver supports user-managed PASID tables. In the
> iopf deliver path, if no attach handle found for the iopf PASID, roll
> back to RID domain when the IOMMU driver supports this capability.

This remark is out of date since it is now:

> @@ -547,6 +547,10 @@ static inline int __iommu_copy_struct_from_user_array(
>   * @default_domain: If not NULL this will always be set as the default domain.
>   *                  This should be an IDENTITY/BLOCKED/PLATFORM domain.
>   *                  Do not use in new drivers.
> + * @user_pasid_table: IOMMU driver supports user-managed PASID table. There is
> + *                    no user domain for each PASID and the I/O page faults are
> + *                    forwarded through the user domain attached to the device
> + *                    RID.
>   */
>  struct iommu_ops {
>  	bool (*capable)(struct device *dev, enum iommu_cap);
> @@ -590,6 +594,7 @@ struct iommu_ops {
>  	struct iommu_domain *blocked_domain;
>  	struct iommu_domain *release_domain;
>  	struct iommu_domain *default_domain;
> +	u8 user_pasid_table:1;
>  };

Otherwise looks goot

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

