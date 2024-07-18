Return-Path: <linux-kernel+bounces-256206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59888934AB5
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 11:12:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 198FE286746
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 09:12:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FF5381720;
	Thu, 18 Jul 2024 09:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iHvPzGmM"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C72118063C
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 09:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721293963; cv=none; b=GRFE1X8Amzl4JSgdKzNOAcDEzbV/Gh/gyGD96JCwToMk0/9vk7dK59NJJc2PfNzXsanYNQdSm51cHM5fRPCOPZ41RhSPn9h6Wp8TmwdTY8I0S+nygzvqwpPIJ9aj/xuIOcUIT3nODJd4NorGOr2O78khaBsZh09jtUO8ToGEZyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721293963; c=relaxed/simple;
	bh=QYe0N5asl+jIDbTVeVE7d9My/QO1y/ezNH3N+O5/sw4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iRkQM+RU8TfwCRIzPdzu26TurdK48Sns3wDMbXkuG2v7EpY3hAlXfZEr263RveZXOpJySHiJWeXwe+m+90Gc5zR0+g+InjIJDKi92hXLl72bKNoxVjQJTQJjEUI5bIR8/k4G2DGiwvnbcThOD7MnmwWBuuqJcrFRxnvoiFzL9Vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iHvPzGmM; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721293962; x=1752829962;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=QYe0N5asl+jIDbTVeVE7d9My/QO1y/ezNH3N+O5/sw4=;
  b=iHvPzGmMViLZs8UViPT1K3Q6Ej833Nmp0APZynogeb6vq1V04GLC/qTb
   6bzhcbqnM2ADa+XIhHcgTWu+ypERUaqvrByAmjNVAuh03MYyuV5czjuzj
   T6QM1Fa5mvKjuxY6CPMg7nE7z8VB+xFluVQzWeRjlQIpn2ocV9n+Ma9cm
   bGGxK2ONxKlRC9WcKQx5zudaH0DvCi08Z/YKWWWM+hNFAXHunX5IV0RdS
   vJG+7/HamQmQ6flRxRx+Y6NwpGZxGEP/oPZPnaA1gKjRFcqS7PqorLsP2
   5pdSDKgN3PMMAKYBKpLocEHWL1vfK8NEu8WV9K2HJM+KwVC9/x+VK00PV
   Q==;
X-CSE-ConnectionGUID: Yrczej0uQfudwSrc9NKsQQ==
X-CSE-MsgGUID: TN8pJPewRQ+gidtflvsb/w==
X-IronPort-AV: E=McAfee;i="6700,10204,11136"; a="18800803"
X-IronPort-AV: E=Sophos;i="6.09,217,1716274800"; 
   d="scan'208";a="18800803"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2024 02:12:30 -0700
X-CSE-ConnectionGUID: ceCJIchsQI+TWOPMFFF9/g==
X-CSE-MsgGUID: 2Dmhh3EmQWaE2ilNHYqILA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,217,1716274800"; 
   d="scan'208";a="50747716"
Received: from sbutnari-mobl1.ti.intel.com (HELO [10.245.246.71]) ([10.245.246.71])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2024 02:12:27 -0700
Message-ID: <9a0eba2e-9933-43bb-ab3b-0480bf1d34a4@linux.intel.com>
Date: Thu, 18 Jul 2024 11:12:24 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ld.lld: error: undefined symbol: iosf_mbi_available
To: Takashi Iwai <tiwai@suse.de>
Cc: Nathan Chancellor <nathan@kernel.org>, kernel test robot <lkp@intel.com>,
 llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
 linux-kernel@vger.kernel.org, Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
 Bard Liao <bard.liao@intel.com>
References: <202407160704.zpdhJ8da-lkp@intel.com>
 <05954a59-2bef-4262-bd91-cfe21d2381f2@linux.intel.com>
 <20240717202806.GA728411@thelio-3990X> <87wmljw485.wl-tiwai@suse.de>
 <d121ec31-0861-4324-8f53-6e06eaf60233@linux.intel.com>
 <87le1zvzw9.wl-tiwai@suse.de>
Content-Language: en-US
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <87le1zvzw9.wl-tiwai@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



>>> --- a/sound/soc/sof/intel/Kconfig
>>> +++ b/sound/soc/sof/intel/Kconfig
>>> @@ -19,6 +19,7 @@ config SND_SOC_SOF_INTEL_ATOM_HIFI_EP
>>>  	tristate
>>>  	select SND_SOC_SOF_INTEL_COMMON
>>>  	select SND_SOC_SOF_INTEL_HIFI_EP_IPC
>>> +	select IOSF_MBI if X86 && PCI
>>>  	help
>>>  	  This option is not user-selectable but automagically handled by
>>>  	  'select' statements at a higher level.
>>> @@ -44,7 +45,6 @@ config SND_SOC_SOF_BAYTRAIL
>>>  	select SND_SOC_SOF_INTEL_COMMON
>>>  	select SND_SOC_SOF_INTEL_ATOM_HIFI_EP
>>>  	select SND_SOC_SOF_ACPI_DEV
>>> -	select IOSF_MBI if X86 && PCI
>>>  	help
>>>  	  This adds support for Sound Open Firmware for Intel(R) platforms
>>>  	  using the Baytrail, Braswell or Cherrytrail processors.
>>
>> I don't think it's the 'right' fix Takashi.
>>
>> The problem is that we end-up using the iosf_mbi_read() routine by
>> including the soc-intel-quirks.h header file blindly for all X66
>> platforms - even when Baytrail is not used.
>>
>> Adding IOSF support for Tangiger doesn't seem right to me, it's not a
>> real dependency.
>>
>> We can be more restrictive and only use the helper for Baytrail, and use
>> a fallback if Baytrail is not used.
>>
>> diff --git a/sound/soc/intel/common/soc-intel-quirks.h
>> b/sound/soc/intel/common/soc-intel-quirks.h
>> index de4e550c5b34..ae67853f7e2e 100644
>> --- a/sound/soc/intel/common/soc-intel-quirks.h
>> +++ b/sound/soc/intel/common/soc-intel-quirks.h
>> @@ -11,7 +11,9 @@
>>
>>  #include <linux/platform_data/x86/soc.h>
>>
>> -#if IS_ENABLED(CONFIG_X86)
>> +#if IS_ENABLED(CONFIG_X86) && \
>> +       (IS_ENABLED(CONFIG_SND_SOC_SOF_BAYTRAIL) || \
>> +        IS_ENABLED(CONFIG_SND_SST_ATOM_HIFI2_PLATFORM_ACPI))
>>
>>  #include <linux/dmi.h>
>>  #include <asm/iosf_mbi.h>
>>
>> also at https://github.com/thesofproject/linux/pull/5114
> 
> I'm afraid it's not enough, either.  It's included in
> sound/soc/sof/intel/atom.c, and this one can be built-in by selected
> from others while CONFIG_SND_SOC_SOF_BAYTRAIL=m.  And, the reverse
> selection is done from CONFIG_SND_SOC_SOF_BAYTRAIL -- so
> CONFIG_IOSF_MBI can be m as well, and this can lead to the unresolved
> symbol from the built-in atom.c.

Fair point, I was only looking at the reported failure where Baytrail
was completely disabled.

I am not sure though if it makes sense to split hair in N dimensions.
Building Merrifield as y and Baytrail as m is a corner case that
shouldn't exist at all. And it's only an academic compilation issue, in
practice using 'y' would fail at run-time due to the usual firmware load
dependencies...

