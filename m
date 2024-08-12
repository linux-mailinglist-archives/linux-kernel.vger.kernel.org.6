Return-Path: <linux-kernel+bounces-282858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0700694E98B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 11:17:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACBB71F23419
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 09:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2315B16D4DC;
	Mon, 12 Aug 2024 09:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f6moDP/K"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9448816D4D4
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 09:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723454248; cv=none; b=aTh2OEvIuvtjikcoNpvrKMFSYcpwHuWHdZXeNGlA95E9ThxQfPGBRTHFW2PxLoceJP1xm+P/cJEBCJ6t99FXRs+hMjLhBpydWg/DF8QUugRx4Ez1XkwByKLOMIxNBayKsedZg9A3SmDrocPoHhyv8SzOTvx0OcP+Pfrb+5RHs04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723454248; c=relaxed/simple;
	bh=Lz63Dfwp5XIblLwOcTkihhV7G1CgponampdWZ030ARQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JZAnur+Zg83EIjWgrXuaxcH5LlAuZ4sucnsQ1hYseb04Sl8NmAMRcUYN1578fa8c61AigIcqDBvnORJr0FVhQnebxjbW29wg9FcqTve1VKYzceHECTn8o1QFibNoBlbEjWj11mzEZKZehMUGP6qMZY0769LO56yRaCqHStwjwE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f6moDP/K; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723454247; x=1754990247;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Lz63Dfwp5XIblLwOcTkihhV7G1CgponampdWZ030ARQ=;
  b=f6moDP/KTIj5CXkeqej7I6L1Z7bgqmL1acxBaXrLu7EGlcz41MFhlFlW
   z4EPtPIHceCpY/HzC6SGvx6UaogpCuLfK7khbm1zubvV967CSeWPcJd6P
   vnWkhqcxtAYxdp2UxkFfumVWKjLteq8ERXtnCfJQC+BTpWfWuhWUMCBLi
   tfww2GoUbG/YLkG9VRfdy5veoRTZb43nKEAdb+cgePF6/cANjKuU1ihWQ
   lRhaSibjOvTDcQb2ZRjvgyIUPA6osKBANMlyJliCtXeqFQFF2OkMh2vAS
   JDEaIKP0VMFo7g6qPHVD+LuKNa2VJFLH2/yXf4XUup5/2YF+zSo0QuWnp
   Q==;
X-CSE-ConnectionGUID: 81OOSkC0Qk+jUV77wBFkqg==
X-CSE-MsgGUID: H8/ebQZaTQCU/kXsGXUTWw==
X-IronPort-AV: E=McAfee;i="6700,10204,11161"; a="21682923"
X-IronPort-AV: E=Sophos;i="6.09,282,1716274800"; 
   d="scan'208";a="21682923"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2024 02:17:26 -0700
X-CSE-ConnectionGUID: h4aY31XiTmqfG1wEPsXCVQ==
X-CSE-MsgGUID: 5fcwkgH5R0uOLnCedJumeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,282,1716274800"; 
   d="scan'208";a="95712182"
Received: from mylly.fi.intel.com (HELO [10.237.72.57]) ([10.237.72.57])
  by orviesa001.jf.intel.com with ESMTP; 12 Aug 2024 02:17:23 -0700
Message-ID: <0ae18e57-ef79-4fd8-9e9a-4c57b480b267@linux.intel.com>
Date: Mon, 12 Aug 2024 12:17:22 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v3 3/6] i3c: mipi-i3c-hci: Add a quirk to set PIO
 mode
To: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Guruvendra Punugupati <Guruvendra.Punugupati@amd.com>,
 Krishnamoorthi M <krishnamoorthi.m@amd.com>, linux-i3c@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20240807052359.290046-1-Shyam-sundar.S-k@amd.com>
 <20240807052359.290046-4-Shyam-sundar.S-k@amd.com>
 <2a9f6c23-9c7b-496b-9998-ea0afe526b46@linux.intel.com>
 <94e789ab-2e64-4a6e-804f-b5e7b2a952cb@amd.com>
Content-Language: en-US
From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
In-Reply-To: <94e789ab-2e64-4a6e-804f-b5e7b2a952cb@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi

On 8/9/24 6:44 PM, Shyam Sundar S K wrote:
>> I was thinking these quirks can be passed as driver_data more cleanly
>> and be specific only to affected HW if AMD HW would have an unique
>> ACPI ID for each HW version.
>>
>> Above X86_VENDOR_AMD might be too generic if and when quirks are fixed
>> in the future HW :-)
>>
>> So something like:
>>
>> static const struct acpi_device_id i3c_hci_acpi_match[] = {
>>      {"AMDI1234", HCI_QUIRK_PIO_MODE | HCI_QUIRK_OD_PP_TIMING |
>> HCI_QUIRK_RESP_BUF_THLD},
>>      {}
>> };
>>
>> and set them in the i3c_hci_probe() as:
>>
>> hci->quirks = (unsigned long)device_get_match_data(&pdev->dev);
> 
> Nice idea. But only problem is that MSFT wants to have the same ACPI
> ID present in the specification.
> 
> I have replied to Andy on patch 1/6. Can you please put your remarks
> there?
> 
Well this is implementation detail later in the series and I found it 
better to focus ACPI ID discussion in 1/6.

> Yeah, agreed that having X86_VENDOR_AMD is too generic, but felt its
> good to have additional checks only after the HW is fixed, rather than
> being speculative now.. :-)
> 
> What would you advise?
> Most probably there will be future HW with either exactly same set of 
quirks, reduced quirks or new quirks and X86_VENDOR_AMD test will work 
only with the first case :-)

