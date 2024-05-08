Return-Path: <linux-kernel+bounces-172549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CC0B68BF373
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 02:17:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8D67B259AF
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 00:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D0E36FD0;
	Wed,  8 May 2024 00:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="XgHrn/0o"
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFAB5AD52
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 00:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715127085; cv=none; b=SsCzx/CWvdNqtqaLgNTrOvR6zReyprrYZxX/TnnoizUg7AmX6NJT0cUFjoJLq7z5QE/Ms5XPIp/KaC2R5fz3t++IaDCGU506Q2I+qUgCN+oei44fUwN2tsKi7EdtZyUfXQgvW2dYI5znqfB0W6u7dovTe/NZTgnPDKy2L/Z3O5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715127085; c=relaxed/simple;
	bh=uBM6JM2ZTgWImlBMh9qZnnFVCD7oJnWjagsz3xFxGHc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lUNo0vAYjuB6VYqeUjQA522ItOCsm+hJip2dtHUa0g8a4/+S4QmFcrbISoMAbxhJNAkvb4AHzQ93UL3+KoI1IV8j5aJ9dlgSyMmbEb76ctZwHqmyXdUvxiQ9VMYmTQkCPL41h7TuI4JsYQENWmJeQAYQypIy1EJ+KrvQDHHNPa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=XgHrn/0o; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3c97dab75bbso689826b6e.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2024 17:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1715127083; x=1715731883; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bjfjkkVg/cpW+PObSNC5kJwblm845FpifEdrDmGUGho=;
        b=XgHrn/0o8CY2T43r+g+K4CXDkKXlLdqVSS0OidxelrnFTpMsFWxH4GGIResJ6gHnzf
         Ow7LehZZ9OyGtJZGw+XrpxzKs1uCTKSRYC2F38wPmDpbCEyrgfXBQePklPkg+BZANrqy
         dD4h8NDvSGu9FCx8lHdla2XPbxo8Z3HOrB/jax1S3wwtBJf6pGFs5jmeoNgn5NjR5fC3
         A6HhSKcmckzaFulBHLg711KsFojDDcyvAR0FKBAkBnWtBJiE5RFVHFj/hhfRHjLDWt/N
         JbeL/8Nw65Dq/5fncsSzCJ4EtBXYgavHuOL6a+Qk9J8ELAS/eoYnBuUoy3Kdy1py5Eq2
         rMqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715127083; x=1715731883;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bjfjkkVg/cpW+PObSNC5kJwblm845FpifEdrDmGUGho=;
        b=EmuVy2fGXWm7pl7a6cExKSxwzK1tFGsRn8M+skUTFsWarxwysnywhP3Hh/SCJ86a8S
         tJXRVYUNKFCVkHk1DoTSOwwto6+H3gyED0fNEv/aRq45oCChZzTsY9made0u1Zu2HnLO
         YfRzw45k+i2s7OMZb6K33nLD4eylJXnRuPvDB31bTGFkDqys+eZ1jmJxLiTqzUpXGxtt
         dHBmXKw60KgV2R52myl0/Dm46UHcuaxfNfC8Vaxmv3pBBaLIr0C/jHs2alkkgU50YUSY
         PtsSVfnbFHobxik6/1EOMyqc+I9arM2FRFSeSYy9ziVcmah2wsNs0CARCGBXOHsgAVpv
         BfQA==
X-Forwarded-Encrypted: i=1; AJvYcCUHHIZkFBxfaa55ih5D2BNwg1RaIdu+/Hqq9uE0E/h33yMAikehHWs/H4Pq0lzbS6fQW8spRrqGc46HuG//I28HlCNPUVUdEDxG9NSe
X-Gm-Message-State: AOJu0Yz+MMi5u7wDQZe3T8cfCEM4uCrzXav+Bj/IQV4sSs1NRo4Ohy6U
	eiGeroqVyM/0gzLdRYmG0pdHFAgdJ6vVi6NXpRksG8pJgBiEZGYE7DO7/iL1cVE=
X-Google-Smtp-Source: AGHT+IG3+7w7f2p3irDmhGGNwkdvL9xcGar5FA005YCMCjPsSm14lX0tCqyBYbPWhopBlbU40pavfg==
X-Received: by 2002:a05:6808:30a6:b0:3c9:7717:713a with SMTP id 5614622812f47-3c9852fa4e6mr1310067b6e.38.1715127082991;
        Tue, 07 May 2024 17:11:22 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id f14-20020a0cf7ce000000b006a0e5626f67sm5081832qvo.50.2024.05.07.17.11.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 17:11:22 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1s4Uu1-0004QL-RV;
	Tue, 07 May 2024 21:11:21 -0300
Date: Tue, 7 May 2024 21:11:21 -0300
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
Subject: Re: [PATCH v5 5/9] iommufd: Add iommufd fault object
Message-ID: <20240508001121.GN4718@ziepe.ca>
References: <20240430145710.68112-1-baolu.lu@linux.intel.com>
 <20240430145710.68112-6-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240430145710.68112-6-baolu.lu@linux.intel.com>

On Tue, Apr 30, 2024 at 10:57:06PM +0800, Lu Baolu wrote:
> diff --git a/drivers/iommu/iommu-priv.h b/drivers/iommu/iommu-priv.h
> index ae65e0b85d69..1a0450a83bd0 100644
> --- a/drivers/iommu/iommu-priv.h
> +++ b/drivers/iommu/iommu-priv.h
> @@ -36,6 +36,10 @@ struct iommu_attach_handle {
>  			struct device	*dev;
>  			refcount_t	users;
>  		};
> +		/* attach data for IOMMUFD */
> +		struct {
> +			void		*idev;
> +		};

We can use a proper type here, just forward declare it.

But this sequence in the other patch:

+       ret = iommu_attach_group(hwpt->domain, idev->igroup->group);
+       if (ret) {
+               iommufd_fault_iopf_disable(idev);
+               return ret;
+       }
+
+       handle = iommu_attach_handle_get(idev->igroup->group, IOMMU_NO_PASID, 0);
+       handle->idev = idev;

Is why I was imagining the caller would allocate, because now we have
the issue that a fault capable domain was installed into the IOMMU
before it's handle could be fully setup, so we have a race where a
fault could come in right between those things. Then what happens?
I suppose we can retry the fault and by the time it comes back the
race should resolve. A bit ugly I suppose.

> diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
> index 83b45dce94a4..1819b28e9e6b 100644
> --- a/include/uapi/linux/iommufd.h
> +++ b/include/uapi/linux/iommufd.h
> @@ -50,6 +50,7 @@ enum {
>  	IOMMUFD_CMD_HWPT_SET_DIRTY_TRACKING,
>  	IOMMUFD_CMD_HWPT_GET_DIRTY_BITMAP,
>  	IOMMUFD_CMD_HWPT_INVALIDATE,
> +	IOMMUFD_CMD_FAULT_ALLOC,
>  };

I think I'd call this a CMD_FAULT_QUEUE_ALLOC - does that make sense?

Jason

