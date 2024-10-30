Return-Path: <linux-kernel+bounces-388903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 855B09B65E8
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 15:32:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44919284515
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 14:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D960F1F4726;
	Wed, 30 Oct 2024 14:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WmxueWrz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE671EABA5;
	Wed, 30 Oct 2024 14:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730298505; cv=none; b=ieeYTd/7EHvXGhPiEY5kmaEHq4Oc6Rq8pQOewcq1y6insy93w4qa80WOnMUrerFKs7mB6ZII9pMx5bDUjiOhcdOnDvwveazlC/mVKvRGr8ZzhgtFdy2Kc4GH9qgpNabGpBm/oc4v7otgg0ILwyyMHpYTvosHGX7YvsGuFED5KUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730298505; c=relaxed/simple;
	bh=cik8CPZIYPW9LoZhpfSKFRXBikFEngZ05BGqUP+wAlM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kYMwPVT1kOeFVn5rxJH4rl8r+TvUcUeJ7iCTMK0ZG8y+nthJhV/r39HyHgtqeIeN2grPEci901FIEU41lgG2hYBzdWRRx81XxXxE9HBhudQaqodjVPoPNggSpbjFKZZPYcCYZyicGiNQJU397UjOk3VJ9nLAhSPu8yIJge4JA0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WmxueWrz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BD2AC4CECE;
	Wed, 30 Oct 2024 14:28:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730298504;
	bh=cik8CPZIYPW9LoZhpfSKFRXBikFEngZ05BGqUP+wAlM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WmxueWrzfCVuFMHErUMRXyrCD1zxmw7JfJnuWjNIvSSVOh+yUpiaA92k8jjvTTxAW
	 ivxwn/8dJA9rPojJhVr2MffiPVolJN1Qd/mbJHDlJyeOnbJo13snzVhd8gAjrD3pOI
	 OYcKP8ecZfWnPHQ1bT5hS2vrAtfRARpHxF2z0a2AakOCOGzQ/fs+X1b3x4zbE7f6UD
	 TVglVBXWecL0nqQvioxg1wfAmq04rw37CJy+uxNucyDd1Bu3X10/HLCrHL2mulqSfE
	 1XhFuJ0K5OGP4170Am2DNoWtRI3K5tXLs3wu4E2Ih7Q1F/YvjgVcRo+Lx/bsdGb7/Y
	 wOCe/k2h0S0DA==
Date: Wed, 30 Oct 2024 15:28:19 +0100
From: Joel Granados <joel.granados@kernel.org>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Yi Liu <yi.l.liu@intel.com>, David Woodhouse <dwmw2@infradead.org>, 
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Kevin Tian <kevin.tian@intel.com>, Klaus Jensen <its@irrelevant.dk>, linux-kernel@vger.kernel.org, 
	iommu@lists.linux.dev, Klaus Jensen <k.jensen@samsung.com>
Subject: Re: Re: [PATCH v4 2/5] iommu/vt-d: Remove the pasid present check in
 prq_event_thread
Message-ID: <pdslu36mhfxbzs254tlte2wavfkmecm53xhdtdelm4nfnemt3f@m5ed4hn6zmbl>
References: <20241015-jag-iopfv8-v4-0-b696ca89ba29@kernel.org>
 <20241015-jag-iopfv8-v4-2-b696ca89ba29@kernel.org>
 <90c772ce-6d2d-4a1d-bfec-5a7813be43e4@intel.com>
 <ujexsgcpvcjux2ugfes6mzjxl53j3icarfbu25imhzliqskyv6@l7f42nv4fhmy>
 <bbd95589-f4c9-4dcf-939b-c3c407eeed21@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bbd95589-f4c9-4dcf-939b-c3c407eeed21@linux.intel.com>

On Tue, Oct 29, 2024 at 11:12:49AM +0800, Baolu Lu wrote:
> On 2024/10/28 18:24, Joel Granados wrote:
> > On Mon, Oct 28, 2024 at 03:50:46PM +0800, Yi Liu wrote:
> >> On 2024/10/16 05:08, Joel Granados wrote:
> >>> From: Klaus Jensen<k.jensen@samsung.com>
> >>>
> >>> PASID is not strictly needed when handling a PRQ event; remove the check
> >>> for the pasid present bit in the request. This change was not included
> >>> in the creation of prq.c to emphasize the change in capability checks
> >>> when handing PRQ events.
> >>>
> >>> Signed-off-by: Klaus Jensen<k.jensen@samsung.com>
> >>> Reviewed-by: Kevin Tian<kevin.tian@intel.com>
> >>> Signed-off-by: Joel Granados<joel.granados@kernel.org>
> >> looks like the PRQ draining is missed for the PRI usage. When a pasid
> >> entry is destroyed, it might need to add helper similar to the
> >> intel_drain_pasid_prq() to drain PRQ for the non-pasid usage.
> > These types of user space PRIs (non-pasid, non-svm) are created by
> > making use of iommufd_hwpt_replace_device. Which adds an entry to the
> > pasid_array indexed on IOMMU_NO_PASID (0U) via the following path:
> > 
> > iommufd_hwpt_replace_device
> >    -> iommufd_fault_domain_repalce_dev
> >      -> __fault_domain_replace_dev
> >        -> iommu_replace_group_handle
>             -> __iommu_group_set_domain
>               -> intel_iommu_attach_device
>                  -> device_block_translation
>                    -> intel_pasid_tear_down_entry(IOMMU_NO_PASID)
> 
> Here a domain is removed from the pasid entry, hence we need to flush
> all page requests that are pending in the IOMMU page request queue or
> the PCI fabric.
This make a lot of sense: To use iommufd_hwpt_replace_device to replace
the existing hwpt with a iopf enabled one, the soon to be irrelevant
page requests from the existing hwpt need to be flushed. And we were not
doing that here.

> 
> >          -> xa_reserve(&group->pasid_array, IOMMU_NO_PASID, GFP_KERNEL);
> > 
> > It is my understanding that this will provide the needed relation
> > between the device and the prq in such a way that when  remove_dev_pasid
> > is called, intel_iommu_drain_pasid_prq will be called with the
> > appropriate pasid value set to IOMMU_NO_PASID. Please correct me if I'm
> > mistaken.
> 
> Removing a domain from a RID and a PASID are different paths.
> Previously, this IOMMU driver only supported page requests on PASID
> (non-IOMMU_NO_PASID). It is acceptable that it does not flush the PRQ in
> the domain-removing RID path.
> 
> With the changes made in this series, the driver now supports page
> requests for RID. It should also flush the PRQ when removing a domain
> from a PASID entry for IOMMU_NO_PASID.

Thank you for your explanation. Clarifies where I lacked understanding.

> 
> > 
> > Does this answer your question? Do you have a specific path that you are
> > looking at where a specific non-pasid drain is needed?
> 
> Perhaps we can simply add below change.
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index e860bc9439a2..a24a42649621 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -4283,7 +4283,6 @@ static void intel_iommu_remove_dev_pasid(struct 
> device *dev, ioasid_t pasid,
>          intel_iommu_debugfs_remove_dev_pasid(dev_pasid);
>          kfree(dev_pasid);
>          intel_pasid_tear_down_entry(iommu, dev, pasid, false);
> -       intel_drain_pasid_prq(dev, pasid);
>   }
> 
>   static int intel_iommu_set_dev_pasid(struct iommu_domain *domain,
> diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
> index 2e5fa0a23299..8639f3eb4264 100644
> --- a/drivers/iommu/intel/pasid.c
> +++ b/drivers/iommu/intel/pasid.c
> @@ -265,6 +265,7 @@ void intel_pasid_tear_down_entry(struct intel_iommu 
> *iommu, struct device *dev,
>                  iommu->flush.flush_iotlb(iommu, did, 0, 0, 
> DMA_TLB_DSI_FLUSH);
> 
>          devtlb_invalidation_with_pasid(iommu, dev, pasid);
> +       intel_drain_pasid_prq(dev, pasid);
>   }
This make sense logically as the intel_drain_pasid_prq keeps being
called at the end of intel_iommu_remove_dev_pasid, but it is now also
included in the intel_pasid_tear_down_entry call which adds it to the
case discussed.

> 
>   /*
> diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
> index 078d1e32a24e..ff88f31053d1 100644
> --- a/drivers/iommu/intel/svm.c
> +++ b/drivers/iommu/intel/svm.c
> @@ -304,9 +304,6 @@ void intel_drain_pasid_prq(struct device *dev, u32 
> pasid)
>          int qdep;
> 
>          info = dev_iommu_priv_get(dev);
> -       if (WARN_ON(!info || !dev_is_pci(dev)))
> -               return;
Did you mean to take out both checks?:
  1. The info pointer check
  2. the dev_is_pci check

I can understand the dev_is_pci check, but we should definitely take
action if info is NULL. Right?

> -
>          if (!info->pri_enabled)
>                  return;
> 
> Generally, intel_drain_pasid_prq() should be called if
> 
> - a translation is removed from a pasid entry; and
This is the path that is already mentiond

> - PRI on this device is enabled.
And this path is:
  -> intel_iommu_enable_iopf
    -> context_flip_pri
      -> intel_context_flush_present
        -> qi_flush_pasid_cache

Right?

I'll put this in my next version if I see that there is a consensus in
the current discussion.

thx again for the feedback.

Best
-- 

Joel Granados

