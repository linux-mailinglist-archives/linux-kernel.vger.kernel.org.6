Return-Path: <linux-kernel+bounces-204698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C73F8FF279
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 18:27:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCDA01C241DE
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 16:27:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15ED3197A6A;
	Thu,  6 Jun 2024 16:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HjzAbEJR"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0538D10E9
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 16:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717691261; cv=none; b=kPvMjrSJmGciHMgBFOqXGxsgNcncoZ6JRApfqoUIS2+1HcERn2u+muCSNG9qYkS72Y/cCHwvd+nQOk+fMLbFiurYAVtVid7nldE1lpVEUlHhhLn0SRc1s5GtKmyIdLwlvePx2CGXa4gBgo/d9DZXQb5ShiaiH26tsf336Tw2buI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717691261; c=relaxed/simple;
	bh=awmDsh57h4AtP7unUblPN0J9qBOX9TMrTx1/JBxYOEg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xa2WW3RCS0Ra+knGsFZnp2340nPhC+G4kimwwBs7x8DpV4+E94l5lhXUm4BFfv6oPdl4IopsBdkOcfgvmLa9WMBqlv9zyZHjzbx5Eq6MPKPGsmqVFV+K1JzM4qVHTea96r14gQ36DkW/rn9YvK1B78Ii7bKhgkTikzcMO+V6jzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HjzAbEJR; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717691259; x=1749227259;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=awmDsh57h4AtP7unUblPN0J9qBOX9TMrTx1/JBxYOEg=;
  b=HjzAbEJR5/EAW38nM/tb9RoSDuv7GSxl0lKVyvBqzv3IYP+Nrp02NwNd
   f9isvp/XrkHQcurPBF16/DJvpVZIhIQdRjYQHcxlBcDCuBqPmaQBUlX+Y
   6yl7jmiq9TBfcpUuOY4Kv/62S7vZQmf/ZqfAwTB7MDMnOOiYUvoRok7cN
   6fFH3u2G1yxv/4LtCAspXYNP2KWDxWZl+ZcogwYFjkk3J+LjlCN5KqehO
   JsiapK9ECBTzSjSt62Nx+tbmnUoDQ2N1nIIezvYzh5qPc7XWHAoCoyknm
   CVRN1NOVg4S80dLNwJQMQ4xwbEi3+UpQU4Der1WliXEa/VP93o4VblYU0
   w==;
X-CSE-ConnectionGUID: xdoWqFEGQpak/SCxEyS7uw==
X-CSE-MsgGUID: Uqun5xQxRCSzf4aNvvWuFw==
X-IronPort-AV: E=McAfee;i="6600,9927,11095"; a="14212369"
X-IronPort-AV: E=Sophos;i="6.08,219,1712646000"; 
   d="scan'208";a="14212369"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2024 09:27:05 -0700
X-CSE-ConnectionGUID: HOGixHSaQPSsx4896ZAKCQ==
X-CSE-MsgGUID: D8rI8EucSEKotOCKzzmewQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,219,1712646000"; 
   d="scan'208";a="37886303"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.125.109.168]) ([10.125.109.168])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2024 09:27:04 -0700
Message-ID: <116afccd-c817-4a45-ad77-ccc039339285@intel.com>
Date: Thu, 6 Jun 2024 09:27:03 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvdimm: Fix devs leaks in scan_labels()
To: Li Zhijian <lizhijian@fujitsu.com>, nvdimm@lists.linux.dev
Cc: dan.j.williams@intel.com, vishal.l.verma@intel.com, ira.weiny@intel.com,
 linux-kernel@vger.kernel.org
References: <20240604031658.951493-1-lizhijian@fujitsu.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20240604031658.951493-1-lizhijian@fujitsu.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/3/24 8:16 PM, Li Zhijian wrote:
> Don't allocate devs again when it's valid pointer which has pionted to
> the memory allocated above with size (count + 2 * sizeof(dev)).
> 
> A kmemleak reports:
> unreferenced object 0xffff88800dda1980 (size 16):
>   comm "kworker/u10:5", pid 69, jiffies 4294671781
>   hex dump (first 16 bytes):
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace (crc 0):
>     [<00000000c5dea560>] __kmalloc+0x32c/0x470
>     [<000000009ed43c83>] nd_region_register_namespaces+0x6fb/0x1120 [libnvdimm]
>     [<000000000e07a65c>] nd_region_probe+0xfe/0x210 [libnvdimm]
>     [<000000007b79ce5f>] nvdimm_bus_probe+0x7a/0x1e0 [libnvdimm]
>     [<00000000a5f3da2e>] really_probe+0xc6/0x390
>     [<00000000129e2a69>] __driver_probe_device+0x78/0x150
>     [<000000002dfed28b>] driver_probe_device+0x1e/0x90
>     [<00000000e7048de2>] __device_attach_driver+0x85/0x110
>     [<0000000032dca295>] bus_for_each_drv+0x85/0xe0
>     [<00000000391c5a7d>] __device_attach+0xbe/0x1e0
>     [<0000000026dabec0>] bus_probe_device+0x94/0xb0
>     [<00000000c590d936>] device_add+0x656/0x870
>     [<000000003d69bfaa>] nd_async_device_register+0xe/0x50 [libnvdimm]
>     [<000000003f4c52a4>] async_run_entry_fn+0x2e/0x110
>     [<00000000e201f4b0>] process_one_work+0x1ee/0x600
>     [<000000006d90d5a9>] worker_thread+0x183/0x350
> 
> Fixes: 1b40e09a1232 ("libnvdimm: blk labels and namespace instantiation")
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
> ---
>  drivers/nvdimm/namespace_devs.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvdimm/namespace_devs.c b/drivers/nvdimm/namespace_devs.c
> index d6d558f94d6b..56b016dbe307 100644
> --- a/drivers/nvdimm/namespace_devs.c
> +++ b/drivers/nvdimm/namespace_devs.c
> @@ -1994,7 +1994,9 @@ static struct device **scan_labels(struct nd_region *nd_region)
>  		/* Publish a zero-sized namespace for userspace to configure. */
>  		nd_mapping_free_labels(nd_mapping);
>  
> -		devs = kcalloc(2, sizeof(dev), GFP_KERNEL);
> +		/* devs probably has been allocated */
> +		if (!devs)
> +			devs = kcalloc(2, sizeof(dev), GFP_KERNEL);

This changes the behavior of this code and possibly corrupting the previously allocated memory at times when 'devs' is valid. Was the 'devs' leaked out from the previous loop and should be freed instead?

>  		if (!devs)
>  			goto err;
>  

