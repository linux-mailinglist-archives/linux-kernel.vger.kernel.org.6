Return-Path: <linux-kernel+bounces-386293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 487909B419C
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 05:40:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F14DE1F23669
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 04:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81864200BAF;
	Tue, 29 Oct 2024 04:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZfvAPlr1"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 467651DD543
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 04:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730176834; cv=none; b=uJeV9eox8aKshbJsYOyTJf1Cv9xwPc/ovhdb0tKS2dr1JpcIhX2VI2CQ106IeOwdV87PwdHeCKlTDUt7VhegmjAnavsv05KpbzcorK9GIYQSa2998jjUVBK3ej3fb7unWcMIGqmIgW6QrOB+/lBWUnkwRaf3FcJelBZzvDCfmas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730176834; c=relaxed/simple;
	bh=9/NgszEXuPhAXbFvQDssVXI33oxGqGlPuCEdTQ1au1U=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=L/cnPJPrd3Am6jDRm/Chnm5+XoNCZOn8pWk6PluSLKHbidXCOj5vUJz7Wj1LOKfKlru8DcEm9nshH6/ChLt+ErLskjZH6VRyVLNR+zBYsdW1aDeH+XKkjPquHCWClLYeZpPvSx3FZ+wNQ6eUV4owBMgUYq5DOMpTsytu8P945pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZfvAPlr1; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730176834; x=1761712834;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=9/NgszEXuPhAXbFvQDssVXI33oxGqGlPuCEdTQ1au1U=;
  b=ZfvAPlr1q9WdGwXHQfeQjVEvteGFDyuHaMfoK6/Mgofxmj9emvY8Q6ZM
   ErOV40nbNaHM4oiWN5OhDPsn+61Fc5pROTeAN5/Q//Z2AmapO9jeTLmbo
   nYAdTVv06XOnmjWdYv8BBVI1PbvEYQPgX7o25/XZjrXX+ETmAmgAMYSLr
   HsWbi5VHnZ2e2JGcKzYpMtAVe81KkJN0jszUnrXfhRXo+FbsLY5SB0/tm
   eMuoi+0rnymkLHVcxbNnBTqwduQn0aafCFi7dTqnzSi78yKZjJLtCvLP1
   SAP6NH5CEIxW399M6Og8gYtwMYHOIYFC6J1PcQzuW8LdkJ8vxw4qCar8y
   A==;
X-CSE-ConnectionGUID: qdq1Ml5gTQigdjctXvC5vA==
X-CSE-MsgGUID: W7Q2LIx2RbG+rs2tOjK2GA==
X-IronPort-AV: E=McAfee;i="6700,10204,11239"; a="41193768"
X-IronPort-AV: E=Sophos;i="6.11,241,1725346800"; 
   d="scan'208";a="41193768"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2024 21:40:33 -0700
X-CSE-ConnectionGUID: mLfhQcVPTiKV17Vx8kFv8g==
X-CSE-MsgGUID: Tih7nE67TNS6jHtbFJjfbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,240,1725346800"; 
   d="scan'208";a="86606981"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.238.0.51]) ([10.238.0.51])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2024 21:40:30 -0700
Message-ID: <a1383f11-dd68-44bc-9ebb-d8d96cb5421a@linux.intel.com>
Date: Tue, 29 Oct 2024 12:40:28 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, David Woodhouse <dwmw2@infradead.org>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v1 1/1] iommu/vt-d: Increase buffer size for device name
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Joerg Roedel <jroedel@suse.de>, Tina Zhang <tina.zhang@intel.com>,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20241014104529.4025937-1-andriy.shevchenko@linux.intel.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20241014104529.4025937-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024/10/14 18:45, Andy Shevchenko wrote:
> GCC is not happy with the current code, e.g.:
> 
> .../iommu/intel/dmar.c:1063:9: note: ‘sprintf’ output between 6 and 15 bytes into a destination of size 13
>   1063 |         sprintf(iommu->name, "dmar%d", iommu->seq_id);
> 
> When `make W=1` is supplied, this prevents kernel building. Fix it by
> increasing the buffer size for device name and use sizeoF() instead of
> hard coded constants.
> 
> Signed-off-by: Andy Shevchenko<andriy.shevchenko@linux.intel.com>
> ---
>   drivers/iommu/intel/dmar.c  | 2 +-
>   drivers/iommu/intel/iommu.h | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)

Queued for v6.13. Thank you!

--
baolu

