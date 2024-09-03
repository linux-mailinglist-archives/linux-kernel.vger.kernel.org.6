Return-Path: <linux-kernel+bounces-313398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24BA096A4F8
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 19:03:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1418281824
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 17:03:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8E8318BC29;
	Tue,  3 Sep 2024 17:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kH+2xJb8"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FAB61C14
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 17:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725382999; cv=none; b=KEF8t68IDxhdq/85PWjANQf8yb8e5ZMG9/dMI8U6oEnCXpfiS9FO/B7p4bbNALpiki4PyyMs6bS5+tLjJaehHYNtTlDKMWEv35aiAZkotyuGDANG79nEhBuH/klbofjB0z6cPra2/vZE2h1HF1g3iRfOtHhrfosYP0KzmUvSLdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725382999; c=relaxed/simple;
	bh=dfa7SZEevL8QR8WbUVs6ccHdwTtMMo+OlkwjuxtjWtc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sqN9tAyEDspQyX5CPbt4Pa07u+ixNMmPjOpTcbQqPr2cA3I5hvlvrey3yEB80Et0F82Te/EQ4g/bbi5PTtq/r++s2xH/QAiXh6HYLofnPClLqefadn9+NoBtnC3btHnTodzWFLpsx3xanJae0ysgXuieNQtsGF0v4MY7jyVe7EY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kH+2xJb8; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725382998; x=1756918998;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dfa7SZEevL8QR8WbUVs6ccHdwTtMMo+OlkwjuxtjWtc=;
  b=kH+2xJb8QJFRzaoiPxqa9QK6Z8h5LzZTRuj1rUyRwlTLhwQZNkoJx8Ki
   I+aewcj0zs7YHCgD0HMURekMEm+LzCUzagS3PXL0sKjPixu/wBYoaR/xD
   BBZrfbZbytwkVoC/VWx0mYMlFSCC4ml9f7w/k4DjU1/A1gQ2uqGn3JQpS
   uPDDnRItd7nGhLfZa9mZKTp+gS/CLxE+SxzurLau/XEBNzrj6rHeHnZYz
   IwVYFnkOEyfZrWmzVTCM8wczV1pqEtKo/6zu3PsaYCsbFbDh5kSz4VB8F
   lcCDtiNj18rT+KRXH6PW9js1VCeeZV4Viy95CI+3g7dFQUO+2MMjVE9AN
   g==;
X-CSE-ConnectionGUID: ZsH9Il7sSy+iF9R0l10uGg==
X-CSE-MsgGUID: v9Q48Z8cQWSmvTQr2LUM/Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11184"; a="23953350"
X-IronPort-AV: E=Sophos;i="6.10,199,1719903600"; 
   d="scan'208";a="23953350"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2024 10:03:17 -0700
X-CSE-ConnectionGUID: v2AEKlJ2SFqIBcpvH2L5vA==
X-CSE-MsgGUID: jNWaO8xmTaqb+Ah2MPIUkQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,199,1719903600"; 
   d="scan'208";a="64655627"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2024 10:03:12 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1slWvt-00000004mRB-0xyg;
	Tue, 03 Sep 2024 20:03:09 +0300
Date: Tue, 3 Sep 2024 20:03:08 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: D Scott Phillips <scott@os.amperecomputing.com>
Cc: Catalin M arinas <catalin.marinas@arm.com>,
	Mark Rutland <mark.rutland@arm.com>, Will Deacon <will@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	AKASHI Takahiro <takahiro.akashi@linaro.org>,
	Alison Schofield <alison.schofield@intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Ankit Agrawal <ankita@nvidia.com>, Baoquan He <bhe@redhat.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Wang Jinchao <wangjinchao@xfusion.com>,
	linux-kernel@vger.kernel.org, patches@amperecomputing.com
Subject: Re: [PATCH v3] arm64: Expose the end of the linear map in PHYSMEM_END
Message-ID: <ZtdBTHzaeK4JNxvz@smile.fi.intel.com>
References: <20240903164532.3874988-1-scott@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240903164532.3874988-1-scott@os.amperecomputing.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Sep 03, 2024 at 09:45:32AM -0700, D Scott Phillips wrote:
> The memory hot-plug and resource management code needs to know the
> largest address which can fit in the linear map, so set
> PHYSMEM_END for that purpose.
> 
> This fixes a crash[1] at boot when amdgpu tries to create
> DEVICE_PRIVATE_MEMORY and is given a physical address by the
> resource management code which is outside the range which can have
> a `struct page`
> 
> The Fixes: commit listed below isn't actually broken, but the
> reorganization of vmemmap causes the improper DEVICE_PRIVATE_MEMORY address
> to go from a warning to a crash.
> 
> [1]: Unable to handle kernel paging request at virtual address

No need to have [1]: prefix here and also read this
https://www.kernel.org/doc/html/latest/process/submitting-patches.html#backtraces-in-commit-messages
and amend commit message accordingly.

>      000001ffa6000034
>      Mem abort info:
>        ESR = 0x0000000096000044
>        EC = 0x25: DABT (current EL), IL = 32 bits
>        SET = 0, FnV = 0
>        EA = 0, S1PTW = 0
>        FSC = 0x04: level 0 translation fault
>      Data abort info:
>        ISV = 0, ISS = 0x00000044, ISS2 = 0x00000000
>        CM = 0, WnR = 1, TnD = 0, TagAccess = 0
>        GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
>      user pgtable: 4k pages, 48-bit VAs, pgdp=000008000287c000
>      [000001ffa6000034] pgd=0000000000000000, p4d=0000000000000000
>      Call trace:
>       __init_zone_device_page.constprop.0+0x2c/0xa8
>       memmap_init_zone_device+0xf0/0x210
>       pagemap_range+0x1e0/0x410
>       memremap_pages+0x18c/0x2e0
>       devm_memremap_pages+0x30/0x90
>       kgd2kfd_init_zone_device+0xf0/0x200 [amdgpu]
>       amdgpu_device_ip_init+0x674/0x888 [amdgpu]
>       amdgpu_device_init+0x7a4/0xea0 [amdgpu]
>       amdgpu_driver_load_kms+0x28/0x1c0 [amdgpu]
>       amdgpu_pci_probe+0x1a0/0x560 [amdgpu]
>       local_pci_probe+0x48/0xb8
>       work_for_cpu_fn+0x24/0x40
>       process_one_work+0x170/0x3e0
>       worker_thread+0x2ac/0x3e0
>       kthread+0xf4/0x108
>       ret_from_fork+0x10/0x20

-- 
With Best Regards,
Andy Shevchenko



