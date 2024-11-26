Return-Path: <linux-kernel+bounces-422766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E4CB9D9DDF
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 20:12:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06D64168A9C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 19:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 446C01DE2DB;
	Tue, 26 Nov 2024 19:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kUS0zvIR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A021769D31;
	Tue, 26 Nov 2024 19:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732648350; cv=none; b=S2SuSBRJAF3TTE3ihJFw8xM6OFhuymFYdcDDBZGsp6HMwiH5fTxkuDVJdEHOEVagOTI/D4bBf8GZKUwS6Ft4QMNkbmKYwbAajmK7zVfHXyiEAb6pHREFSkLBGSGdcLyRUtPq8IofsumFNdcGE6MEuUSLglG4NiqTB8BUR6lu6Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732648350; c=relaxed/simple;
	bh=CIDjMGMQZh0qeeQIXLtEavbfZ9HGs/C/E+aH+I02UfU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=G94ggbB0kBi5c8d65UnYjA/F4kgUg0vhbpvsCJS84qjxsPbavuUy6wX+XGfnUCRBy61usRFMWBs7BYIXa3d3ZIsE85Hy7JQw0PMJHG7xReUvEDh63dmChAgyNPWtEuGBTXoJM34uNfE3Mzbta9AYLnu6Oc0JWtADGj5JZ/x2Xdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kUS0zvIR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 035ABC4CECF;
	Tue, 26 Nov 2024 19:12:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732648350;
	bh=CIDjMGMQZh0qeeQIXLtEavbfZ9HGs/C/E+aH+I02UfU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=kUS0zvIRaucXT4nMtI+mChuO25GFSwQXuQfeeky5R/wQ8sd7b8pyWOzhTNG2mgZVr
	 krHLn9orA4VYiUfr2r5Y2ARECtplJ8zwBzOZa6uxTnCpohNTHTY7rY8+lB5cvvGVGp
	 TGmdPqk+EuC6Axy2BEuAqSaZdsddqHsg3sZkgPUQU3P+rcyxRuVXEcK4ddeVFHI6pQ
	 5uGdq4/YcDu3qmhjMpUnSVNmX9JZ6cKOEiMZmn/mMyCG1Frt0x4ALkIzkm4QtBXGuF
	 6B2ZZ0UNv7lTmd3k+ijtJ6E6De6eYbJWs8qD90F7fsSzPLMh+1YQHBKVRBPNfEM7/5
	 wRmejzkWk7EYw==
Date: Tue, 26 Nov 2024 13:12:28 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>
Cc: joro@8bytes.org, suravee.suthikulpanit@amd.com, will@kernel.org,
	robin.murphy@arm.com, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev, vasant.hegde@amd.com
Subject: Re: [PATCH v2 1/8] iommu/amd: Refactor AMD IOMMU debugfs initial
 setup
Message-ID: <20241126191228.GA2650296@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241106074639.2039-2-dheerajkumar.srivastava@amd.com>

On Wed, Nov 06, 2024 at 01:16:32PM +0530, Dheeraj Kumar Srivastava wrote:
> Rearrange initial setup of AMD IOMMU debugfs to segregate per IOMMU
> setup and setup which is common for all IOMMUs. This ensures that common
> debugfs paths (introduced in subsequent patches) are created only once
> instead of being created for each IOMMU.
> ...

> -void amd_iommu_debugfs_setup(struct amd_iommu *iommu)
> +void amd_iommu_debugfs_setup(void)
>  {
> +	struct amd_iommu *iommu;
>  	char name[MAX_NAME_LEN + 1];
>  
> -	mutex_lock(&amd_iommu_debugfs_lock);
> -	if (!amd_iommu_debugfs)
> -		amd_iommu_debugfs = debugfs_create_dir("amd",
> -						       iommu_debugfs_dir);
> -	mutex_unlock(&amd_iommu_debugfs_lock);
> +	amd_iommu_debugfs = debugfs_create_dir("amd", iommu_debugfs_dir);
>  
> -	snprintf(name, MAX_NAME_LEN, "iommu%02d", iommu->index);
> -	iommu->debugfs = debugfs_create_dir(name, amd_iommu_debugfs);
> +	for_each_iommu(iommu) {
> +		snprintf(name, MAX_NAME_LEN, "iommu%02d", iommu->index);
> +		iommu->debugfs = debugfs_create_dir(name, amd_iommu_debugfs);
> +	}

Doing this setup with for_each_iommu() precludes any hot-add of
IOMMUs, but I guess there's no indication of hotplug support anyway
given all the uses of for_each_iommu() in init_iommu_all(),
amd_iommu_init_pci(), amd_iommu_enable_interrupts(), etc.

>  }
> diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
> index 43131c3a2172..d78dc96bbec3 100644
> --- a/drivers/iommu/amd/init.c
> +++ b/drivers/iommu/amd/init.c
> @@ -3377,7 +3377,6 @@ int amd_iommu_enable_faulting(unsigned int cpu)
>   */
>  static int __init amd_iommu_init(void)
>  {
> -	struct amd_iommu *iommu;
>  	int ret;
>  
>  	ret = iommu_go_to_state(IOMMU_INITIALIZED);
> @@ -3391,8 +3390,8 @@ static int __init amd_iommu_init(void)
>  	}
>  #endif
>  
> -	for_each_iommu(iommu)
> -		amd_iommu_debugfs_setup(iommu);
> +	if (!ret)
> +		amd_iommu_debugfs_setup();
>  
>  	return ret;
>  }
> -- 
> 2.25.1
> 

