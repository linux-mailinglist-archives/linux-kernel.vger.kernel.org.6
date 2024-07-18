Return-Path: <linux-kernel+bounces-256528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 876D4934FC0
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 17:17:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47FAB282090
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 15:17:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AA0B143C7E;
	Thu, 18 Jul 2024 15:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SED7cxtj"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EE912AF12
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 15:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721315821; cv=none; b=N45KmRURa6GuVb/ogOcA2Yc04rIlYhE4HtoZ3j1IbI5Y2AIneQefQfAPhPoZzE+JZzRKZTZxxoGqnmHYEGCgrlVjVBHbjt5HYoQLnqWux+uQxFNjuFc7F5vxvu4Kece7I79SVohroRBWOJ1RE46BwUNrbpbsmxB/jBDuHrtqasA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721315821; c=relaxed/simple;
	bh=O5x+hCNcORPZbUU0OWY/Y22Vaok0nlcWzJo1PLR9a/g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ItCY2MSP5ZfbVzz4V+c3nOftLZRXrp1w698A619SoWzS4I7FKK99/lxBPaFHzB67k+o7qsxIR+FUc5lYjj2ZWYCZuzj2F5bdzS6N6j4mEEhUiu1iFSgsCNLVxCBzXnNiCqbxE4RbWYddtepvXvGI9hTRzUV1M4ffbkMCG3JQ+OM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SED7cxtj; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721315820; x=1752851820;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=O5x+hCNcORPZbUU0OWY/Y22Vaok0nlcWzJo1PLR9a/g=;
  b=SED7cxtjRxOc1dBlfBxUugOsfmvV5sZO0+QbiV7fqeXUjtd9Ln9PRDma
   vG3QrxkISFMnDVhJ+GFzNHKqmAF7sCPGdkMVjl3Kpkp5xm9/qNV9HOsFl
   h+NdBR0MUj8nZFHK2xBXtlhu9DR4wM7979B4IfVneqA1NxZr9pSa9FdK2
   wXFEFPyAjoCzXT3wSwhV1nQFPtm/KdRRv8ja4vgtLNc5X3Avwwry5ikoY
   8xp5BNFBCqd4QCGWi5UmVtjXN+kWKHf3Ae3vgF1/VpSvtJPByZD7fVCsZ
   lAHf8LhGoDUcdZ/0ymEIw9mflRk0jT4OKfmPGiYGAFB1VSkuw3PtXUxNM
   A==;
X-CSE-ConnectionGUID: Gag5aU+OQGW17u0+nBZHcQ==
X-CSE-MsgGUID: PcYXiLbeTWWk5c8Bg0mnJQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11137"; a="29497366"
X-IronPort-AV: E=Sophos;i="6.09,218,1716274800"; 
   d="scan'208";a="29497366"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2024 08:17:00 -0700
X-CSE-ConnectionGUID: dSAp7XGyQTSjSrwjjKNi3Q==
X-CSE-MsgGUID: +FUsQy+MSWKaPxZ49QPwcg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,218,1716274800"; 
   d="scan'208";a="74021901"
Received: from sbutnari-mobl1.ti.intel.com (HELO [10.245.246.71]) ([10.245.246.71])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2024 08:16:56 -0700
Message-ID: <69dfb1e2-eac6-4cd4-a9d3-caaa7f36f9b9@linux.intel.com>
Date: Thu, 18 Jul 2024 17:16:54 +0200
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
 <9a0eba2e-9933-43bb-ab3b-0480bf1d34a4@linux.intel.com>
 <87frs6vj4m.wl-tiwai@suse.de>
Content-Language: en-US
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <87frs6vj4m.wl-tiwai@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


>>>> diff --git a/sound/soc/intel/common/soc-intel-quirks.h
>>>> b/sound/soc/intel/common/soc-intel-quirks.h
>>>> index de4e550c5b34..ae67853f7e2e 100644
>>>> --- a/sound/soc/intel/common/soc-intel-quirks.h
>>>> +++ b/sound/soc/intel/common/soc-intel-quirks.h
>>>> @@ -11,7 +11,9 @@
>>>>
>>>>  #include <linux/platform_data/x86/soc.h>
>>>>
>>>> -#if IS_ENABLED(CONFIG_X86)
>>>> +#if IS_ENABLED(CONFIG_X86) && \
>>>> +       (IS_ENABLED(CONFIG_SND_SOC_SOF_BAYTRAIL) || \
>>>> +        IS_ENABLED(CONFIG_SND_SST_ATOM_HIFI2_PLATFORM_ACPI))
>>>>
>>>>  #include <linux/dmi.h>
>>>>  #include <asm/iosf_mbi.h>
>>>>
>>>> also at https://github.com/thesofproject/linux/pull/5114
>>>
>>> I'm afraid it's not enough, either.  It's included in
>>> sound/soc/sof/intel/atom.c, and this one can be built-in by selected
>>> from others while CONFIG_SND_SOC_SOF_BAYTRAIL=m.  And, the reverse
>>> selection is done from CONFIG_SND_SOC_SOF_BAYTRAIL -- so
>>> CONFIG_IOSF_MBI can be m as well, and this can lead to the unresolved
>>> symbol from the built-in atom.c.
>>
>> Fair point, I was only looking at the reported failure where Baytrail
>> was completely disabled.
>>
>> I am not sure though if it makes sense to split hair in N dimensions.
>> Building Merrifield as y and Baytrail as m is a corner case that
>> shouldn't exist at all. And it's only an academic compilation issue, in
>> practice using 'y' would fail at run-time due to the usual firmware load
>> dependencies...
> 
> Surely this kind of bug won't hit anyone in practical use, but it's
> only about the randconfig failures.  The original report is in the
> same category, after all.
> 
> Maybe another (rather easier) workaround would be to use
> IS_REACHABLE(), something like below.  This should fix the original
> issue and the potential mess-up of kconfig dependencies.

The simplest solution works for me :-)

Do you want me to send a patch with your Suggested-by: tag or do it
yourself?

> --- a/sound/soc/intel/common/soc-intel-quirks.h
> +++ b/sound/soc/intel/common/soc-intel-quirks.h
> @@ -11,7 +11,7 @@
>  
>  #include <linux/platform_data/x86/soc.h>
>  
> -#if IS_ENABLED(CONFIG_X86)
> +#if IS_REACHABLE(CONFIG_IOSF_MBI)
>  
>  #include <linux/dmi.h>
>  #include <asm/iosf_mbi.h>

