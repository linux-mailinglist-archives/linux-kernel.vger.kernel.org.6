Return-Path: <linux-kernel+bounces-234732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 419D191C9E2
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 03:12:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C59A284707
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 01:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6DAF849C;
	Sat, 29 Jun 2024 01:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="RqSX1oTy"
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABDB41879
	for <linux-kernel@vger.kernel.org>; Sat, 29 Jun 2024 01:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719623509; cv=none; b=HueDC4hWgjfVuqJS/IvqqeQwMVOnV2nznS9blSXKXy2A4eIYXA0UKfRTXakVCLKg8TQZ9ZyCVntvtQV8HCILsf9uBtz+B1Tgc/i+Rk2o6oB8OfHof9ZkL1yTaa2gjSBSAqIXxQP17J5iT8Iql4wR5IzZ9x4ktXou3fJxMHURVoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719623509; c=relaxed/simple;
	bh=NmWmB8xJkdpQ6+qsRZ3yNW+0DCBVDLk7Mf7CANqDZmY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lWv4Pwl3SPo43J3oLDvi2mkmHdckVAdFqVoJvGw3aB4AUEJ3iQOyoeL3NJv0so6MDZSZngEQqT6NNUCaMA6OIuualy/lQDi5GN2SFa2Pu1L3VHesy7k/0z5Rx0eY5eJxqzrB1xWewui4Yi8JPFHRDd6cf7hk0VkFXpXOFzKwMr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=RqSX1oTy; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-3762c172d93so5456055ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 18:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1719623507; x=1720228307; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EBVtd4lNh6ldbTw81Bxi6NFxymecp4v8R1CgV33/re8=;
        b=RqSX1oTy+NnCo89bN4kXTn8OzWyqR/j3I10CZgo3mrpB2ghJ1NWL/T2JMh4MVMM/VG
         eLhl9KnSr/J8EwlB/0qxvSpDj+VK4WBMBNJbm5UmRaZaggPCYEZYNv9LpYdL7F56XJmG
         oLCyz7xVtNpmOKxiRCeYrHlEbBp3L+WMEqc5RRX5iXtmgJ2dG+bcrmuMg0kfwdEAsL7G
         ILHl8pZ+jClGZdwcwZeU40rjHQi51ZuR6eOwf5r0snTOZ/z9keSC0BsNmUsAVRu+w9bB
         1pIUrCixm3jIdBcyKGC2LZko6n38lSUbCE7qaCBSRtnTbmTy16D6i4vvY294lMAKJDdN
         6AIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719623507; x=1720228307;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EBVtd4lNh6ldbTw81Bxi6NFxymecp4v8R1CgV33/re8=;
        b=aklOx5Bg4r15Efzfj7Pep2qh14mc2a7KOVonJ0P0EAfRT5d6LyfV7i/CyzjM+wprrg
         5CIKazJhK+aAxAD41LthGSkmXyCZ1vw9x4hrtSkyptk0Y84kLCs1jBX+c23JBS+ELq08
         KJNF+axHUWhB74BMfhQgmJQ646VLp0zCBCjKyZcK0ymCuWkJcOkDLGUUEOVLJC7BcVTx
         gEytwTrqGfwtPLCBrwrsV9rzi7AOMhsFWk8DCNiuWf/K+FBe/lmMAo9QEXTLQhYfJH5X
         KR4VBOtqR7RmsM4XKfO4+u2k+bnehuIvReRHeh3Ii4NFpuLF8xqFKiAu4512txqc4cRQ
         59sA==
X-Forwarded-Encrypted: i=1; AJvYcCVklu5KooUNAdrPkTY1IVX/JLarTJKclK9mUHwSPxclm61M0OiOWjiITLbNuH39qZBxvuzOm0cL6mXVXKq7vVx799ueYxCezKjIrlYS
X-Gm-Message-State: AOJu0YxPiI1IGnBBZ4bGI+Mbh1WMq76piG4HpD9ybRjSnG4+3rX14GoZ
	zNofwipOIPQvUx2ckLGCGwF17WhYuJxhX0ga1wbaSLGnOpe9sTxQc3TF3fVCCqM=
X-Google-Smtp-Source: AGHT+IE4QgUFrWMp+tH+7fcsNM5wNf5R+mcyUObJCqnJg+lJpDagM/8QA1d89wQbwLfqFUo7RgzINQ==
X-Received: by 2002:a05:6e02:20e2:b0:377:14a7:fc99 with SMTP id e9e14a558f8ab-37714a7ff6bmr145245465ab.24.1719623506847;
        Fri, 28 Jun 2024 18:11:46 -0700 (PDT)
Received: from ziepe.ca ([24.114.37.55])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-72c69b53be5sm1784142a12.16.2024.06.28.18.11.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 18:11:45 -0700 (PDT)
Received: from jgg by jggl with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sNInD-0004RY-K3;
	Fri, 28 Jun 2024 18:06:03 -0300
Date: Fri, 28 Jun 2024 18:06:03 -0300
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
Subject: Re: [PATCH v7 04/10] iommu: Extend domain attach group with handle
 support
Message-ID: <Zn8luxc+RLBOIIX0@ziepe.ca>
References: <20240616061155.169343-1-baolu.lu@linux.intel.com>
 <20240616061155.169343-5-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240616061155.169343-5-baolu.lu@linux.intel.com>

On Sun, Jun 16, 2024 at 02:11:49PM +0800, Lu Baolu wrote:

> +int iommu_replace_group_handle(struct iommu_group *group,
> +			       struct iommu_domain *new_domain,
> +			       struct iommu_attach_handle *handle)
> +{
> +	struct iommu_domain *old_domain = group->domain;
> +	void *curr;
> +	int ret;
> +
> +	if (!new_domain)
> +		return -EINVAL;
> +
> +	mutex_lock(&group->mutex);
> +	ret = __iommu_group_set_domain(group, new_domain);
> +	if (ret)
> +		goto err_unlock;
> +	xa_erase(&group->pasid_array, IOMMU_NO_PASID);
> +	if (handle) {
> +		curr = xa_store(&group->pasid_array, IOMMU_NO_PASID, handle, GFP_KERNEL);
> +		if (xa_err(curr)) {
> +			ret = xa_err(curr);
> +			goto err_restore;

But this error unwind doesn't work because the xa_erase() already
happened and there may have been a handle there that we don't put
back.

Something like this - store to a reserved entry cannot fail:

int iommu_replace_group_handle(struct iommu_group *group,
			       struct iommu_domain *new_domain,
			       struct iommu_attach_handle *handle)
{
	void *curr;
	int ret;

	if (!new_domain)
		return -EINVAL;

	mutex_lock(&group->mutex);
	if (handle) {
		ret = xa_reserve(&group->pasid_array, IOMMU_NO_PASID,
				 GFP_KERNEL);
		if (ret)
			goto err_unlock;
	}

	ret = __iommu_group_set_domain(group, new_domain);
	if (ret)
		goto err_release;

	curr = xa_store(&group->pasid_array, IOMMU_NO_PASID, handle,
			GFP_KERNEL);
	WARN_ON(xa_is_err(curr));

	mutex_unlock(&group->mutex);

	return 0;
err_release:
	xa_release(&group->pasid_array, IOMMU_NO_PASID);
err_unlock:
	mutex_unlock(&group->mutex);
	return ret;
}

Jason

