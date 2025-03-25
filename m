Return-Path: <linux-kernel+bounces-574778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 957B1A6E9C2
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 07:51:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5E5A3AE74C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 06:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76791205E11;
	Tue, 25 Mar 2025 06:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NJyJNMhy"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A9D5234969
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 06:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742885447; cv=none; b=TGx2S6vKZTpCQhryAflX+4ZiQFIhyhQq/g3ly1RbG8qFToFfJapz2GYzPyhuc5MBSyTsO1/EN4twTP4H9O8rb351mV4WWdXIEBLagrcS2DYQxNRLoU9NC1BxrL32t+8jXlKif2CywWsbp3ieSdEusTcbwwu8CjWbSNK2wWWXDXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742885447; c=relaxed/simple;
	bh=pu0zT6gX6x6DsTeciyCK/jb51Z+mrcZK1RmVNEfyxBQ=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=m0BgFo1hoCN796fQGbLV5oG4AN4Eag0Ui6KMVkXfPu/V3VwEiFIkv4UYZT80rGkBMueZbRiSznz0Bx2H61B02IXQr72yRs9iLSrIQY7vOF+zGRfgXQHGai58PfJRpzBni/NEvdpw+Sud1wsa6+cLwjlj/Ub7QV0d15EeE9qEnhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NJyJNMhy; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742885447; x=1774421447;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=pu0zT6gX6x6DsTeciyCK/jb51Z+mrcZK1RmVNEfyxBQ=;
  b=NJyJNMhyiOC7gW5YZ1dmnpg6Z5rIGFVftB9lrql1//xUGh7CgNEB0Bym
   vb0twK084eGimfu8wlLGWpVyO5raAFcbkpYGOdv/MG1vg+LcVIcoANZlm
   NeUJ5bkWhOsLPfjXSwPfNk6wQGOTXFSTDAMWzRm34QDIJmIGFQgjZHb8c
   cyDKdeYdC47MXcu8FD5cb63njQbuqZFrA17wk5q4m3XC7IQenKCkBGlnH
   35gfTF6WtONIYMGQps/d8VYZNJNF2wqCuES5pEXtN65dJlFPxA6Jf/FwN
   PZV8oi2RPqiT06yzPnjKnBhiVcs8uE8rdMXoroG22PooDgkalH83cuJxy
   g==;
X-CSE-ConnectionGUID: ro1MDmOoQVCSVyVzpxkd0A==
X-CSE-MsgGUID: Bn23vwAOTB2fQtOUEanb+A==
X-IronPort-AV: E=McAfee;i="6700,10204,11383"; a="47899962"
X-IronPort-AV: E=Sophos;i="6.14,274,1736841600"; 
   d="scan'208";a="47899962"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2025 23:50:46 -0700
X-CSE-ConnectionGUID: THKVFx1iQrOGN7U1KL3Nnw==
X-CSE-MsgGUID: lgUDVPWuTgSBNIKdbLUZwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,274,1736841600"; 
   d="scan'208";a="129467662"
Received: from ipu5-build.bj.intel.com (HELO [10.238.232.136]) ([10.238.232.136])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2025 23:50:44 -0700
Subject: Re: [PATCH] mm/vmalloc: fix mischeck pfn valid in vmap_pfns
To: "Kasireddy, Vivek" <vivek.kasireddy@intel.com>, Huan Yang
 <link@vivo.com>, Hillf Danton <hdanton@sina.com>,
 Christoph Hellwig <hch@lst.de>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "opensource.kernel@vivo.com" <opensource.kernel@vivo.com>,
 "urezki@gmail.com" <urezki@gmail.com>
References: <20250317055304.GB26662@lst.de>
 <5a12454c-16a1-4400-a764-f49293d8dece@vivo.com>
 <20250318064805.GA16121@lst.de>
 <5229b24f-1984-4225-ae03-8b952de56e3b@vivo.com>
 <20250318083330.GB18902@lst.de>
 <bcbbc2e9-858f-46ed-909e-1d911dd614f0@vivo.com>
 <20250318084453.GB19274@lst.de> <20250319050359.3484-1-hdanton@sina.com>
 <20250319112651.3502-1-hdanton@sina.com>
 <752e606b-640d-46d1-a8e0-fa714b29a7b6@vivo.com>
 <IA0PR11MB71851C5EF8BC5BADFD5A5D79F8A72@IA0PR11MB7185.namprd11.prod.outlook.com>
From: Bingbu Cao <bingbu.cao@linux.intel.com>
Message-ID: <df945f45-c9a4-8332-17e9-1187caedfea1@linux.intel.com>
Date: Tue, 25 Mar 2025 14:46:00 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <IA0PR11MB71851C5EF8BC5BADFD5A5D79F8A72@IA0PR11MB7185.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit

Vivek,

On 3/25/25 2:32 PM, Kasireddy, Vivek wrote:
> Hi Huan,
> 
>> Subject: Re: [PATCH] mm/vmalloc: fix mischeck pfn valid in vmap_pfns
>>
>> HI Hillf,
>>
>> Thanks fo your suggestion.
>>
>> 在 2025/3/19 19:26, Hillf Danton 写道:
>>> On Wed, 19 Mar 2025 09:08:51 +0100 Christoph Hellwig wrote:
>>>> On Wed, Mar 19, 2025 at 01:03:55PM +0800, Hillf Danton wrote:
>>>>> A quick fix is to add a vmap_pfn variant to walk around the pfn
>>>>> check in question, like the following diff (just for idea show).
>>>> No.
>>>>
>>> Patient to see your fix, given no low hanging peach left for Mr Folio
>>> in case of HVO, (feel free to ignore, who is likely about 2.6-mile
>>> less tough than you could be).
>>
>> I now believe there are two way to resolve the HVO folio can't vmap in
>> udmabuf.
>>
>> 1. simple copy vmap_pfn code, don't bother common vmap_pfn, use by itself
>> and remove pfn_valid check.
>>
>> 2. implement folio array based vmap(vmap_folios), which can given a range of
>> each folio(offset, nr_pages), so can suit HVO folio's vmap.
>>
>> 1 is simple and can fast fix this issue, but may not too good. I need discuss with
>> bot Christoph and udmabuf's maintainer.
>>
>> 2 is hard, but may worth to research, which I also will try to do. :)
> Another option is to just limit udmabuf's vmap() to only shmem folios but I guess
> it may not work as expected if THP is also enabled. 
> Bingbu, what exactly is your use-case? Could you please describe the scenario that
> requires you to use udmabuf's vmap()?

I guess my case is a very simple one.

Userspace create the udmabuf and mmap:

dmabuf_fd = ioctl(udma_fd, UDMABUF_CREATE, &create);
userptr = mmap(NULL, len, PROT_READ | PROT_WRITE,
	  MAP_SHARED, dmafd, 0);

And driver side call dma_buf_vmap() on the dmabuf to get a virtual
address.

> 
> Thanks,
> Vivek
> 
>>
> 

-- 
Best regards,
Bingbu Cao

