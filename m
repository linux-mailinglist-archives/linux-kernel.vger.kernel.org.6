Return-Path: <linux-kernel+bounces-361486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6E6D99A8DF
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 18:27:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A79E41C20D8C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 16:27:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 573EA19922F;
	Fri, 11 Oct 2024 16:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="WZYUDlbP"
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C80D6198E7F
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 16:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728664028; cv=none; b=UTbEYdEpqlF3A4Qim4+g9FnVLCvyaoWwQXXgVTC/v1XRKJXQSCM8CbXFW/HF7WUhy+2hNV/EcloJiFJWciP5XRcB8IYnhQ7EaNm87+FRChtMFE5Qidg3Dx7glzIajh64mCLWIwb3ax1haAmSJt2M/vJyZS/yZ8qdm4nY2PmQ6vY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728664028; c=relaxed/simple;
	bh=j4vbPdAlY9hV+J4KUZ0fvDwUvocm8C+KS46LmplaExk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UU6hRp2TorN6BlxqbKVsqjjs+iWyh17m9QWXGtoDKrQWZgST/SlfwkmOSoKuucn7OEpGJ5OQFHGPmn8e3aYJyyQLRBypUZ2DR5kyjvMrmGBRJBLIOLySBnApTvojr27O3xreGzt6c2YRr/mxiyL72l8mMZ0InXdfp4221F4rlro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=WZYUDlbP; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6cbce16d151so11591046d6.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 09:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1728664025; x=1729268825; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7PekulykcbN+gb8fZx6BBcDe03TnC4iwq2raCf+a2g4=;
        b=WZYUDlbPZjbRwfFIsLwK2tOnXvXo1vTJz1spvgmW9tH/Z0EyQEXBAtoQN7LNxWEwQn
         /XIVtO6Uck0CSntvFv/MzuqDd1POWsjQOfexd6gd7xaLqEZ8DnkWsEvx6XZ74YTeTqX8
         BVrhd9nsVcbzk565NjED0EhYEmNA34hIR4XjdeFzkwFHo91O8yqcRBlbbqlCxDhKVSWk
         v/J/pv/hSbLwjZFe8kj5ZdKNye6B+ITkNUMYIN45bkr4+O1U7kJSDsoS2r1cbIEWr/SW
         u4skzLcyGvhIwyVVALF6mTT3gcbK2lyRJYAx8tix1hu5VDYjZdGFsJhU8Htrvao4iX+f
         JKxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728664025; x=1729268825;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7PekulykcbN+gb8fZx6BBcDe03TnC4iwq2raCf+a2g4=;
        b=MXTstGDxG4W1xT9KHJdTYqk8jH81z5jeNqW/fiU6ZLdh1PAA/qVoofJ2zlqL4Y/R1A
         KHUQXVgoU77BgHRjhdKMVJiTD7rF+R2VyRYbmssbw9OJjWpsseBsa+PBba+2TEEFKVKu
         Rak5TTQG8WjgnX86u6CSu3zUEJDpcwgIEeREeRntxmOaseJY8oOB6HUH8TcnbrF4J0YW
         TR0S8+nZTAvslrscVdCjO8z9j7EVYcI4RQJMo/AwZSpdmtzSbAvT9Mmhblql/KyBL9T/
         9zqOYxyyCKy0ZhMJmAxcUbFp/NrkHzfweM6sROIsX4tpFjBc21q1JcDuWKa0t2JTcNWP
         ysmQ==
X-Forwarded-Encrypted: i=1; AJvYcCXlIHjTLa8YfgZJ5XPQvNiaAqwYgNzZGywUBWq+QVIwtLQlywTTESGaLpWMi/IPqI3w5Dxrn2dSgbmyhKI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+gqSc3FmMLsvRMfLjFIdNF4GB5Mggf2o8AN2yotmZsKSKclYJ
	S5xAQIyxCJ02wlW7do2kdhULxEnjDFzq5+Cmmvanjpqf0ZkKCJmekU1CEGjiAww=
X-Google-Smtp-Source: AGHT+IECAA99O9K/DGavVzcBDiJEt0Sio+U49ZIq/HhKSIk3/fbZT/m740AEMp/LNE2YV+t+Qv9gtg==
X-Received: by 2002:a05:6214:320b:b0:6c5:8a85:19fe with SMTP id 6a1803df08f44-6cbf00ef174mr36358106d6.51.1728664024598;
        Fri, 11 Oct 2024 09:27:04 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cbe85b7597sm16987756d6.42.2024.10.11.09.27.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 09:27:04 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1szITn-007dB9-Kl;
	Fri, 11 Oct 2024 13:27:03 -0300
Date: Fri, 11 Oct 2024 13:27:03 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
	Vasant Hegde <vasant.hegde@amd.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/7] iommu/vt-d: Enhance compatibility check for paging
 domain attach
Message-ID: <20241011162703.GL762027@ziepe.ca>
References: <20241011042722.73930-1-baolu.lu@linux.intel.com>
 <20241011042722.73930-4-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241011042722.73930-4-baolu.lu@linux.intel.com>

On Fri, Oct 11, 2024 at 12:27:18PM +0800, Lu Baolu wrote:

> @@ -1623,27 +1623,15 @@ static int domain_context_mapping_one(struct dmar_domain *domain,
>  
>  	copied_context_tear_down(iommu, context, bus, devfn);
>  	context_clear_entry(context);
> -
>  	context_set_domain_id(context, did);
>  
> -	/*
> -	 * Skip top levels of page tables for iommu which has
> -	 * less agaw than default. Unnecessary for PT mode.
> -	 */
> -	for (agaw = domain->agaw; agaw > iommu->agaw; agaw--) {
> -		ret = -ENOMEM;
> -		pgd = phys_to_virt(dma_pte_addr(pgd));
> -		if (!dma_pte_present(pgd))
> -			goto out_unlock;
> -	}

Yikes, this is nasty racy stuff, glad to see it go

But should the agaw stuff be in its own patch?

> @@ -3506,27 +3483,26 @@ int prepare_domain_attach_device(struct iommu_domain *domain,
>  	if (domain->dirty_ops && !ssads_supported(iommu))
>  		return -EINVAL;
>  
> -	/* check if this iommu agaw is sufficient for max mapped address */
> -	addr_width = agaw_to_width(iommu->agaw);
> -	if (addr_width > cap_mgaw(iommu->cap))
> -		addr_width = cap_mgaw(iommu->cap);
> -
> -	if (dmar_domain->max_addr > (1LL << addr_width))
> +	if (dmar_domain->iommu_coherency !=
> +			iommu_paging_structure_coherency(iommu))
>  		return -EINVAL;
> -	dmar_domain->gaw = addr_width;
> -
> -	/*
> -	 * Knock out extra levels of page tables if necessary
> -	 */
> -	while (iommu->agaw < dmar_domain->agaw) {
> -		struct dma_pte *pte;
> -
> -		pte = dmar_domain->pgd;
> -		if (dma_pte_present(pte)) {
> -			dmar_domain->pgd = phys_to_virt(dma_pte_addr(pte));
> -			iommu_free_page(pte);
> -		}
> -		dmar_domain->agaw--;
> +
> +	if (domain->type & __IOMMU_DOMAIN_PAGING) {

It looks like this entire function is already never called for
anything but paging?

The only three callers are:

	.default_domain_ops = &(const struct iommu_domain_ops) {
		.attach_dev		= intel_iommu_attach_device,
		.set_dev_pasid		= intel_iommu_set_dev_pasid,

and

static const struct iommu_domain_ops intel_nested_domain_ops = {
	.attach_dev		= intel_nested_attach_dev,

And none of those cases can be anything except a paging domain by
definition.

So this if should go away, or be turned into a WARN_ON.

Jason

