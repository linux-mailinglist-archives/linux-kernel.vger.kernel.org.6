Return-Path: <linux-kernel+bounces-238678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9098E924DBC
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 04:19:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DE3728C748
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 02:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 549176FD0;
	Wed,  3 Jul 2024 02:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UOntJaL1"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49C6E6FB0;
	Wed,  3 Jul 2024 02:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719973048; cv=none; b=jJXBm1NmsWNPU3f5HMH/0/2fcU4+OXeec5NUn10E6k3TGQXbSGSJvkw9V4/PiZRJMWY4aZ+YIRCuQ3IVGuAoO42NCjwUJtUxcHTwD8WufrPA+e2oJscWpEZnGJixVtZuJjjwnL20n1/QS4kKK8Y0fvlHNlploc63MEZLjJwaqjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719973048; c=relaxed/simple;
	bh=DsYS9rsRUUX+3T3zxbkJ8qv0voG/0vvAsvMk7w+ElTk=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=eS3kY1T/ueOEqcyRlIuts55eF/ujZswh0NukCrkg2s5dIvzew8IDqWMSX7ZZFcYxlZhU/eqcoCnQDThsgS9avxCHmN3xIXUNjI/M7DM1FM9Qn0GYWrX9fB0mvBN60HZYW3N1In0o6GdZ7EhIp2Yz5+rJ8cNAh79obeNYzk4o6IQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UOntJaL1; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719973047; x=1751509047;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=DsYS9rsRUUX+3T3zxbkJ8qv0voG/0vvAsvMk7w+ElTk=;
  b=UOntJaL1keIO+rdTHZaioRknSH3sMPEZfUGSTXDUPHT1/5NJa+mYyvQs
   VmtF0AH2b1yJJVs41oph4IX9YrN9oBYvvonpUTFtIQ80jEcNXgsayoU/U
   3WDI2wm2VFbPPmfciUptB1up/7qZFoFdVddFVDR2Z25QsuM6QcHQCfII8
   xPmFwgXvCKGhqn1B4bhMswWUnNpectaUbH+d3xzaBya5SzTM7YJvNnGTu
   UE9bBtaPK2jkOQ/i02+jPrqtoN48N5viRY1IrB9nh9gFPkGRTIszbRKAr
   /niM5MHS48W6ucNJJXUCyiwFWQ/CVAX4dCofFZ7lr175Q6v81G6FEg/PI
   A==;
X-CSE-ConnectionGUID: c9m0a/gnTDOyY0+De/tmSg==
X-CSE-MsgGUID: j8YnVAQUTt657Z7hxpSSEA==
X-IronPort-AV: E=McAfee;i="6700,10204,11121"; a="20082696"
X-IronPort-AV: E=Sophos;i="6.09,180,1716274800"; 
   d="scan'208";a="20082696"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2024 19:17:25 -0700
X-CSE-ConnectionGUID: lkWuV3N8QVqSwH2dwsXMDA==
X-CSE-MsgGUID: K2wl844PT8G+8SL32hyrcQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,180,1716274800"; 
   d="scan'208";a="76834532"
Received: from unknown (HELO [10.239.159.127]) ([10.239.159.127])
  by orviesa002.jf.intel.com with ESMTP; 02 Jul 2024 19:17:23 -0700
Message-ID: <aa64ab1c-70fa-4ab9-afc1-bf76a3d28123@linux.intel.com>
Date: Wed, 3 Jul 2024 10:14:39 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, yj.chiang@mediatek.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] docs: iommu: Remove outdated
 Documentation/userspace-api/iommu.rst
To: Mark-PK Tsai <mark-pk.tsai@mediatek.com>, Jonathan Corbet
 <corbet@lwn.net>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
References: <20240702120617.26882-1-mark-pk.tsai@mediatek.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20240702120617.26882-1-mark-pk.tsai@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/2/24 8:05 PM, Mark-PK Tsai wrote:
> The Documentation/userspace-api/iommu.rst file has become outdated due
> to the removal of associated structures and APIs.
> 
> Specifically, struct such as iommu_cache_invalidate_info and guest
> pasid related uapi were removed in commit 0c9f17877891 ("iommu:
> Remove guest pasid related interfaces and definitions").
> And the corresponding uapi/linux/iommu.h file was removed in
> commit 00a9bc607043 ("iommu: Move iommu fault data to
> linux/iommu.h").
> 
> Signed-off-by: Mark-PK Tsai<mark-pk.tsai@mediatek.com>
> ---
>   Documentation/userspace-api/iommu.rst | 209 --------------------------
>   MAINTAINERS                           |   1 -
>   2 files changed, 210 deletions(-)
>   delete mode 100644 Documentation/userspace-api/iommu.rst

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Thanks,
baolu

