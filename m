Return-Path: <linux-kernel+bounces-280441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A7D494CAB4
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 08:37:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F11D01F23307
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 06:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 685F716C684;
	Fri,  9 Aug 2024 06:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kEDbXzb/"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23B9112FF72
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 06:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723185466; cv=none; b=hrLDhaBY7IP9QM/QJBn9ERGyNyi+/atqngekiDln93Lo5FGUHyDB02rlA7TtsO6yD6h4jgt34b673QEJlh/mlK8zbug5EV0gZj3D8RwbgRXhySKjK7+utlUiwHwfwvv2ey3BShnNtK5UbzJoPrXJHa7yjfQpmjQawF1RTeOM330=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723185466; c=relaxed/simple;
	bh=AKgm5hGI3U5WW/tDOgil8Ci0U1WSd3Q9p0NpadTmkEE=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Ewsh+IP3smPLeSyYyJsHQOjBVWLeqmKaySFMI4BbC6OlMdtZVXRwYUj5kh5EPfKtYAGLFXzQxBDtU8zgPRNyo+XD1vdqXWhr/v10HQFIZcwNoHiusrh5m7emuOym8JPy6lyK8T0UFv2UfpGFYXWRLKX/Iu0xIxqm41vKO9Kbohg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kEDbXzb/; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723185465; x=1754721465;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=AKgm5hGI3U5WW/tDOgil8Ci0U1WSd3Q9p0NpadTmkEE=;
  b=kEDbXzb/CMHQ3XNTBksTnusuCQk34Ip/wEeBuTFT+HjAkJj1yq5Swe8h
   2l5/u/CpTIlVDu3/QY3eALGZ8BELjBMBbsO2XHScAcyP9M1ZtbybK7ec0
   Roz4gx+tZSU6VhbjoK9/ptOP0H+t8ERL7A/50dO5VeauHHmpMXA8MtsGc
   uuYfhfzs+3wU0oDHqYROaTL3H9YHH+xErtPeaU2IXGIV0oGRpOYj7f5OM
   iE5Tlg/GXbrQLCY+ZtFCqAqLc8mMwM/g50xnsfPVBfgiNk8pRAxRqal54
   eKdzODS5myKtC6lJW1u0fku+lFKwuhpYUimGBNSZKtHQXHiwnSlCcaTii
   A==;
X-CSE-ConnectionGUID: qihpEeWcQaiZ9yXn/A18jw==
X-CSE-MsgGUID: YpTqea0PRNudR/gSdqHzDw==
X-IronPort-AV: E=McAfee;i="6700,10204,11158"; a="21157646"
X-IronPort-AV: E=Sophos;i="6.09,275,1716274800"; 
   d="scan'208";a="21157646"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2024 23:37:44 -0700
X-CSE-ConnectionGUID: HOCdLXN8TSC6V22qh5iCoA==
X-CSE-MsgGUID: 5SdCDGM3S3SsmSKSvAZKrQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,275,1716274800"; 
   d="scan'208";a="57443066"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.124.229.145]) ([10.124.229.145])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2024 23:37:42 -0700
Message-ID: <8b4fca1e-72a9-4c57-9ad8-5602def71560@linux.intel.com>
Date: Fri, 9 Aug 2024 14:37:39 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] iommu: Remove unused declaration
 iommu_sva_unbind_gpasid()
To: Yue Haibing <yuehaibing@huawei.com>, joro@8bytes.org, will@kernel.org,
 robin.murphy@arm.com, jgg@ziepe.ca
References: <20240808140619.2498535-1-yuehaibing@huawei.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20240808140619.2498535-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/8/8 22:06, Yue Haibing wrote:
> Commit 0c9f17877891 ("iommu: Remove guest pasid related interfaces and definitions")
> removed the implementation but leave declaration.
> 
> Signed-off-by: Yue Haibing<yuehaibing@huawei.com>

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Thanks,
baolu

