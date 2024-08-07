Return-Path: <linux-kernel+bounces-277359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B543A949FAF
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 08:14:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A5F81F246E0
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 06:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 306A21A01DB;
	Wed,  7 Aug 2024 06:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z5KxDYju"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E59A816CD11
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 06:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723011257; cv=none; b=T+rVf8VzlfxqYdsfve1gAa5orotfwkfgQoF2miRZbQKQhPxQ5ZRRT1kFVrQrjsgfwmlX0pxBpU8twdkG4SK2DXHYafbxTe5m932J+K/GUkWGZybxVRaMLCR+lrP7m9dNFxSCE+Ss92mM8c3+56IyzGkNj/nSCwWmrc3G911teZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723011257; c=relaxed/simple;
	bh=kzB24mEuUPTDSRo+OopxR81otdeY8W2AbnIwcZW9Mqc=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=cOOrSp2635q3dz+fjUzEC5xbj/jx5McuaCeHrm882KCMPEvydV6yx798cwm5At18kJRAh9ZAyyJRvX3HKWE4+yDu/YIcE0PbfPM5TntrI8qRvhsz2jqnr8evfIwpbgEK2NXW5Y/DtsDlVPWKynw4td0XATkPuPCmQiA3bsBzTd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z5KxDYju; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723011256; x=1754547256;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=kzB24mEuUPTDSRo+OopxR81otdeY8W2AbnIwcZW9Mqc=;
  b=Z5KxDYjuudQ3kCYCpMl4N4I8gVvIG4nXX0dmh8PCiuNIkgQk6Fe14D7i
   UmINCAogYeJygONPph0IrOG7AIHNgM8gKFiWlMypKmT1iHZObDVX8/nVQ
   EL13pFYhHP1xYPGfcgrfoLVywKeWojgKDK0dX93OUA6bfYU+A63dxzpVg
   HgJY+ia4d/Wf6YRdgWdvW3aHYpY2R+qr1EaIiNt6/l9vDurhdqK3gXvbE
   PBFFmhEwT22cgBRnX08eW0A3xAdZa87j33EBGBpLSQ6P6kfvuRPyDzvSy
   soJGUyMzw8WjfJyCdeSR8T3cJDOSLJsOguwmXTTeodR4MvE5ThYR3+lw0
   g==;
X-CSE-ConnectionGUID: PSUYq9/2QJeGQ6JRlL9wFg==
X-CSE-MsgGUID: 3Q0EGU6GRaGC0Q587Hoqmg==
X-IronPort-AV: E=McAfee;i="6700,10204,11156"; a="32466269"
X-IronPort-AV: E=Sophos;i="6.09,269,1716274800"; 
   d="scan'208";a="32466269"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2024 23:14:15 -0700
X-CSE-ConnectionGUID: sNYYDmbIT0qVr8bRycs+/w==
X-CSE-MsgGUID: 4EMsCG5lTXaS7EWz/bb0Mw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,269,1716274800"; 
   d="scan'208";a="56409205"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.125.248.220]) ([10.125.248.220])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2024 23:14:14 -0700
Message-ID: <3af0ac5a-ec1b-464b-bacc-29d2aa491a79@linux.intel.com>
Date: Wed, 7 Aug 2024 14:14:11 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Kevin Tian <kevin.tian@intel.com>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/7] iommu/vt-d: Remove identity mappings from
 si_domain
To: Jason Gunthorpe <jgg@ziepe.ca>
References: <20240806023941.93454-1-baolu.lu@linux.intel.com>
 <20240806023941.93454-3-baolu.lu@linux.intel.com>
 <20240806170529.GK676757@ziepe.ca>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20240806170529.GK676757@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/8/7 1:05, Jason Gunthorpe wrote:
> On Tue, Aug 06, 2024 at 10:39:36AM +0800, Lu Baolu wrote:
>> As the driver has enforced DMA domains for devices managed by an IOMMU
>> hardware that doesn't support passthrough translation mode, there is no
>> need for static identity mappings in the si_domain. Remove the identity
>> mapping code to avoid dead code.
>>
>> Signed-off-by: Lu Baolu<baolu.lu@linux.intel.com>
>> ---
>>   drivers/iommu/intel/iommu.c | 122 ++----------------------------------
>>   1 file changed, 4 insertions(+), 118 deletions(-)
> Reviewed-by: Jason Gunthorpe<jgg@nvidia.com>
> 
> I always wondered why this was so fine grained, I would have expected
> it to work on blocks of 512 x 1G, once you allocate a memory for the
> 1G table level you may as well fill it with identity IOPTEs. The only
> optimization point is how many blocks of 512x1G are needed..

I am not sure whether or not those early hardware support super pages.
  :-).

Thanks,
baolu

