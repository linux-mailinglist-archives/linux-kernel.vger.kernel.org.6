Return-Path: <linux-kernel+bounces-237253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 834B791EDEC
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 06:36:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 883CF1C22992
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 04:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CA2D374FE;
	Tue,  2 Jul 2024 04:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FWqYx7yl"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E965C81F
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 04:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719894978; cv=none; b=KFC44Nsvf5tfy9SO8CxE+xjprLUlTx1zbvqPOESlfZqm/lN+q+gSQM915AOpBEiOGTv0L07b8Vox8nwbuHH22AeQj9UADtH9IyS4qIBCpoK6+xppYp293pX5Xu9tIOrukZRaEsaXicRuJWWYKvyK9OpY6Q8fnRpOLzgY6bTq3LI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719894978; c=relaxed/simple;
	bh=OVwUJBNznARdqYZL7x7aHqg592Wvhe4sk/xyK3nN0tA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RgG3ipRdqq0sJrUSSLO14YbuGLM6E35WAT4GeYWZlDpLty3ekt9akk4pRO6FzbYJ1Wcs7+/sC9JrwLBjdGxGMtq9LQGg7SFAKQdgLCla02XrdgD02kl5MBX7Io/qFi4K+YatKAYj4uIm26fn2JL1ob3q37ojjZCP/NS0uFJwOzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FWqYx7yl; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719894977; x=1751430977;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OVwUJBNznARdqYZL7x7aHqg592Wvhe4sk/xyK3nN0tA=;
  b=FWqYx7yldHC7BtfE4xFZkvngsZVPL/zAnV3DA4chR3+pb3LDMvixbJT9
   LWzed9pZTXsuuMKEKVP4tuC0w9aUcTQL4eU+0cJobEdhCJ17F9SxoT8oV
   47+NKlbfZUiuImwqA5+O8jHaonW4+T9lqjUUX/HXCgxAWbtHZ37PPieN+
   w0/LaUP/CRFX/dq/pkrxLqGyg0+fXBEVcu3z3ssz5Uy16+nLpRUXfi1Kr
   9tQotTvAuFqyvrgmXWFvjDT8kyBeJekhzRSWUtJBeICa2qcjTRHtc4SXw
   ua5OPR9nV+NtnSUMw0dOt8QNakPNtDrgGpJc+sbHxHkynVkvVR1j815rT
   Q==;
X-CSE-ConnectionGUID: 4mKdQgwDQaG6hYnBd4+oJg==
X-CSE-MsgGUID: ZY2E9tfATse5vKGFVEeC3w==
X-IronPort-AV: E=McAfee;i="6700,10204,11120"; a="12351119"
X-IronPort-AV: E=Sophos;i="6.09,178,1716274800"; 
   d="scan'208";a="12351119"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2024 21:36:16 -0700
X-CSE-ConnectionGUID: IELBY2l0T4mJ53Bgx1RUSw==
X-CSE-MsgGUID: BU0DcK1+T3yM0jszmDfnhw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,178,1716274800"; 
   d="scan'208";a="45561528"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.54.39.125])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2024 21:36:16 -0700
Date: Mon, 1 Jul 2024 21:41:28 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin
 Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian
 <kevin.tian@intel.com>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v3 1/2] iommu/vt-d: Add helper to flush caches for
 context change
Message-ID: <20240701214128.5523a1ea@jacob-builder>
In-Reply-To: <20240701112317.94022-2-baolu.lu@linux.intel.com>
References: <20240701112317.94022-1-baolu.lu@linux.intel.com>
	<20240701112317.94022-2-baolu.lu@linux.intel.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


On Mon,  1 Jul 2024 19:23:16 +0800, Lu Baolu <baolu.lu@linux.intel.com>
wrote:

> +	if (flush_domains) {
> +		/*
> +		 * If the IOMMU is running in scalable mode and there
> might
> +		 * be potential PASID translations, the caller should
> hold
> +		 * the lock to ensure that context changes and cache
> flushes
> +		 * are atomic.
> +		 */
> +		assert_spin_locked(&iommu->lock);
> +		for (i = 0; i < info->pasid_table->max_pasid; i++) {
> +			pte = intel_pasid_get_entry(info->dev, i);
> +			if (!pte || !pasid_pte_is_present(pte))
> +				continue;
Is it worth going through 1M PASIDs just to skip the PASID cache
invalidation? Or just do the flush on all used DIDs unconditionally.

> +			did = pasid_get_domain_id(pte);
> +			qi_flush_pasid_cache(iommu, did,
> QI_PC_ALL_PASIDS, 0);
> +			iommu->flush.flush_iotlb(iommu, did, 0, 0,
> DMA_TLB_DSI_FLUSH);
> +		}
> +	}

Thanks,

Jacob

