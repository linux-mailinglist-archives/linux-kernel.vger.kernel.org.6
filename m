Return-Path: <linux-kernel+bounces-386296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 700209B419F
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 05:43:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C4E61C22218
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 04:43:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4C89200CBA;
	Tue, 29 Oct 2024 04:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f05MY81P"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C66C1F4FA8
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 04:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730176975; cv=none; b=F6Fx/VP/aWScOwK3m2lThW4dwYXBX+Fe1PF0qcv1Y3EffVp16FUN8qSQU770VhDx5tkORaJftDzWctqXMwPz/3SQOtAOWF5dal+h88ruX9t6kB2Rop89K59xuiYVHRRGTf8yp/7YrqvXVQKZ7Qva51Xmvl8ZwynpEYNZz4pI/jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730176975; c=relaxed/simple;
	bh=FMv1SMzCCaIcu5A3KfXQYWBrzrewT4qJneSbHJ30744=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=RXSTeRPFeNVzB44GJcm7p9COwDBlu8tsE8xpF9wiDw/ca7A6w3qwyOu7iaNuwQPshwDKWUBmkhWHOp95TzmQ62uBmgSVYGgQBvfgW45AR7pO3rIjUBVkkP2R4/yAvLWrmsEs9SI8w0DEURmx3cE2A6Lk4Sgg25x1zWp4OaDxzXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f05MY81P; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730176974; x=1761712974;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=FMv1SMzCCaIcu5A3KfXQYWBrzrewT4qJneSbHJ30744=;
  b=f05MY81PcnNye8O7xKsg7kUPDhlGPvBroolyZ34z6aTjkURmNavO16bN
   TGF4Vp34evJhQ5VXEB3LVb9d1skquBZzrUxfrb2/4K/gKFuJ5zLi0DXP/
   YKUXFuKi2WXGIrq7WHtgNhPgKl5N+hbFSs9pz6c3hMhAh9ucmFsoKM0x1
   Rq1sUelxL5fQHz7yfT+9YupQ5JSRfSRDYXjtTQzeJsV44DAtZ3zW2eBjl
   MjN/s2OZIiUzvBTQ9SrDOPswtWe0c0rwx0cNuRAyhL6HnwsWLkvC93GLv
   evPvNQJJ5v9pZZjai1qIbsigHwpv+hGwgJJurwiHAVsVkLOidpjPe+wSq
   A==;
X-CSE-ConnectionGUID: y+KAXlRLSNabp+wlDGBIXA==
X-CSE-MsgGUID: aqH85RU1TVOzJ4U947fI3w==
X-IronPort-AV: E=McAfee;i="6700,10204,11239"; a="41193940"
X-IronPort-AV: E=Sophos;i="6.11,241,1725346800"; 
   d="scan'208";a="41193940"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2024 21:42:54 -0700
X-CSE-ConnectionGUID: UbKZlTQPR661bfRfSnQn1A==
X-CSE-MsgGUID: ckFTUfP3SuisHj6b1rhVyg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,241,1725346800"; 
   d="scan'208";a="82161920"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.238.0.51]) ([10.238.0.51])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2024 21:42:51 -0700
Message-ID: <2551f5b6-a1f3-4d4b-a17e-3451bdabfa90@linux.intel.com>
Date: Tue, 29 Oct 2024 12:42:48 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, dwmw2@infradead.org, joro@8bytes.org,
 will@kernel.org, robin.murphy@arm.com, chao.p.peng@intel.com
Subject: Re: [PATCH v3 0/2] vtd: Minor cleanup
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20241024092146.715063-1-zhenzhong.duan@intel.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20241024092146.715063-1-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/10/24 17:21, Zhenzhong Duan wrote:
> Hi,
> 
> This cleanup the vtd dump code to dump lower entry after check current
> level entry's present bit. Also fix the print to avoid confusing.
> 
> See patch log for details.
> 
> Thanks
> Zhenzhong
> 
> Changelog:
> v3:
> - Fix a missed check
> - Refine commit log further
> 
> v2:
> - Add Fixes tag in patch1 (Baolu)
> - Refine commit log in patch2 (Baolu)
> 
> 
> Zhenzhong Duan (2):
>    iommu/vt-d: Fix checks and print in dmar_fault_dump_ptes()
>    iommu/vt-d: Fix checks and print in pgtable_walk()
> 
>   drivers/iommu/intel/iommu.c | 40 ++++++++++++++++++++++++-------------
>   1 file changed, 26 insertions(+), 14 deletions(-)

Queued for v6.13. Thank you!

--
baolu

