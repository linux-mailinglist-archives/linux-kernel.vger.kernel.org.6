Return-Path: <linux-kernel+bounces-532967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E833EA45441
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 05:01:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10744188F811
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 04:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2AB9267393;
	Wed, 26 Feb 2025 04:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NAkRwzmq"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FA5321C9EB
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 04:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740542451; cv=none; b=VuCWR68lQ28mBZGLY1MpeDmraAIj1XfxzZ+OGp1wPo82RnU0OVyh3I1enlNZG614K9qQqPrKaOiZEvpAsG5FBGFMUF/DQ8Q6fsYP/pUI78gUBQOjbH3PHtQBLZ2ISgI3M5QLN1Tgl7f6uN4w/OanNqN2TmDzlTTCO6NdtsHw2cY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740542451; c=relaxed/simple;
	bh=C1veCn/rK3xvTWL13RaHegLP4l8qfJT3vhhx5f3gSS0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dhZdEWeS8KsaCpSoeI8cRBO8KDZpIiVrcfFIp138krXz8qoLcN6f0TX6U1VneQbrnaRgDIQ5BF67wJGPKMA+W1pjEu3Or7VDZBHlbr/hpHC302SfBmcC22w0DhxHsvZKSjek6DeSK9Lj9tG1AZoGGKW7PMurBZLjlPvQjAPz9fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NAkRwzmq; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740542450; x=1772078450;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=C1veCn/rK3xvTWL13RaHegLP4l8qfJT3vhhx5f3gSS0=;
  b=NAkRwzmqhjBmqYKr8FUQKsJkf2g4RKYwiF21TjB4DRNlH9iMXt3g2MPq
   Rh0WppZ0hFvofmNzVZHASxC5qgm+YoZ/K+d0Yx6dL4pGNIy8nZDOpXElD
   F4cIVWk8+rzewqlr3EZpn38iGsVwXRjOuKj1xIqRVO6nVOWO+s2kQ7vMi
   uaBkblINQBMSbHA+/EQRfitLkqDbo4F7rn/8h21Dva9S5s8d/7w1kbS52
   6T0TDAen7EOE3XmuuSGcPJV9vJRnoQhejpsM7GtwMtJBSTWHupdbcV50N
   VKKwwDPC3Eg7CW0XPowyzkjF23HIsltPmMvrm1OD1SOoyLSQHH+KmyftU
   w==;
X-CSE-ConnectionGUID: rHYhn2gsSkSFHvOAiYWrzw==
X-CSE-MsgGUID: Yt6ipYaUR62XG6IYwEQDOQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11356"; a="28966866"
X-IronPort-AV: E=Sophos;i="6.13,316,1732608000"; 
   d="scan'208";a="28966866"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 20:00:49 -0800
X-CSE-ConnectionGUID: oZymBoQpRoW/3AKbpBSfIg==
X-CSE-MsgGUID: dE9++S+AQqOk+1BQ5ohALA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="121833592"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 20:00:46 -0800
Message-ID: <421bb6af-4b7b-4987-8db2-037a39d43078@linux.intel.com>
Date: Wed, 26 Feb 2025 11:57:31 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/12] iommu/vt-d: Cleanup
 intel_context_flush_present()
To: "Tian, Kevin" <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Jason Gunthorpe <jgg@ziepe.ca>
Cc: "Jiang, Dave" <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>,
 Fenghua Yu <fenghuay@nvidia.com>, Zhangfei Gao <zhangfei.gao@linaro.org>,
 Zhou Wang <wangzhou1@hisilicon.com>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20250224051627.2956304-1-baolu.lu@linux.intel.com>
 <20250224051627.2956304-7-baolu.lu@linux.intel.com>
 <BN9PR11MB52763EE4B5976621A7797DBD8CC32@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB52763EE4B5976621A7797DBD8CC32@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/25/25 15:43, Tian, Kevin wrote:
>> From: Lu Baolu<baolu.lu@linux.intel.com>
>> Sent: Monday, February 24, 2025 1:16 PM
>>
>> The intel_context_flush_present() is called in places where either the
>> scalable mode is disabled, or scalable mode is enabled but all PASID
>> entries are known to be non-present. In these cases, the flush_domains
>> path within intel_context_flush_present() will never execute. This dead
>> code is therefore removed.
>>
>> Signed-off-by: Lu Baolu<baolu.lu@linux.intel.com>
> usually a suffix "_present()" indicates that the helper can be called
> on an object which is currently in-use, which is obviously not the
> case here.
> 
> To avoid confusion probably just call it intel_context_flush() or
> intel_context_flush_no_user() is clearer.

How about intel_context_flush_no_pasid()?

