Return-Path: <linux-kernel+bounces-570635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E201AA6B2E0
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 03:18:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 365FA3B15E5
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 02:17:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A2441E0DEA;
	Fri, 21 Mar 2025 02:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GsnWUcHY"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F41C217C210
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 02:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742523484; cv=none; b=KUPy6yAdSwiYZq+A02tjujNmRxWkPoqaKacqDgabAOACyP0kU9QL8AZRp4E3MymOZpICtWXVXt2KYCw/XRDowQKbna2cd+Zw9Trb9YGiIcC4Hsk2Qf88/dbSm5ZaMQl90nKrCYmv0mCs+cHG2/Es/658XHaeWIFcNoochsSA6Fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742523484; c=relaxed/simple;
	bh=yiT0IByiw6hfNbsZ2ycmFtsULRBmPbyQPGomX3XADbA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ldygia2eft0MM9atC6E5SV0LkMTDBQLoZn8oPFadwLnHmsRaE+iORelqzRHk4ZOX2SvBZFMWVbVDK5Av9M/HoNSI4kPaXYWmyYqHPqAs6bvbUQWjwWr83uw/hwtUp0No04e6QVBFeXIB9BgkLzePJrCwVH1pYwP7RTd6bpFgeLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GsnWUcHY; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742523482; x=1774059482;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=yiT0IByiw6hfNbsZ2ycmFtsULRBmPbyQPGomX3XADbA=;
  b=GsnWUcHYMys2oqgyk406KrKgXnNRn2EfnO97JmtojPTTEmMCkizQPJcf
   uDcaHgnl7eKCz/x7NPizbCNXBm1YYjhJ5dp2BpbFdxqMEDLjtmoDAvY3H
   np0ZNe8o6C+cbdxeHGT8THDSQNdq5R/nj9ioE2ScVggjoC28CZnoDrH+w
   MRAawalZP6G6EjEcRpuWmS2XAMAGYT/z0nI+oYfcCMFrclgZjzVLQq3O4
   7wO73RPQ8xkm78kagDnUH9pX5T4iMf9guVDnOJ4QbkCVYS+dkIQgaA8Mg
   wyjQAodh1UkYMP9fgEMkpOxu/2SGZKEtF/Ei10AkX5zmG/k13eBEvCu+u
   A==;
X-CSE-ConnectionGUID: nh/tafTeSTChj+6imSLtQA==
X-CSE-MsgGUID: 3HBuhXgXS1Cxa9IKm5DBIQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11379"; a="66247433"
X-IronPort-AV: E=Sophos;i="6.14,263,1736841600"; 
   d="scan'208";a="66247433"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2025 19:18:01 -0700
X-CSE-ConnectionGUID: l0xm/TmsR1icDX7kc4ic6A==
X-CSE-MsgGUID: HN5ZugeWT5GnzJJUsrOWlQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,263,1736841600"; 
   d="scan'208";a="127425864"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2025 19:17:59 -0700
Message-ID: <0527bf74-f272-47e1-8cf7-1e66167fb560@linux.intel.com>
Date: Fri, 21 Mar 2025 10:14:28 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] iommu: make inclusion of iommufd directory
 conditional
To: Rolf Eike Beer <eb@emlix.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Kevin Tian <kevin.tian@intel.com>
References: <12652899.O9o76ZdvQC@devpool47.emlix.com>
 <2243601.irdbgypaU6@devpool47.emlix.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <2243601.irdbgypaU6@devpool47.emlix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/20/25 17:22, Rolf Eike Beer wrote:
> Nothing in there is active if CONFIG_IOMMUFD is not enabled, so the whole
> directory can depend on that switch as well.
> 
> Fixes: 2ff4bed7fee7 ("iommufd: File descriptor, context, kconfig and makefiles")
> Signed-off-by: Rolf Eike Beer<eb@emlix.com>

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

