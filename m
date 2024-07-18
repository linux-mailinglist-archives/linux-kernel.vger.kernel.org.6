Return-Path: <linux-kernel+bounces-256146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 50D619349D2
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 10:23:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06A541F21ABA
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 08:23:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8C19770E4;
	Thu, 18 Jul 2024 08:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZmGL3q4V"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 240CC1EA8F
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 08:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721291029; cv=none; b=fMiuZtPn5jfXXrS35PaTtwEkDwXDWDcuRh51hsWy5dEx5iPYB64r5VxON+BJhQLlTAqbMRB0HHAFo1am44aWJ9PSKZ+m3Yt73F9bOd9e780f3nCKQHm1nnZ3UzFAJL1vI4QHdSmY3KyCGwjRClQoOKOZSJ5Xha25dCuwON+H8SE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721291029; c=relaxed/simple;
	bh=64so2fzErg3e9zcwe/1rx4boY6PkVsoWGetw5NVcFp8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BK7DCmftAkoS654T2BmVdTxrpVuTV3IBqTVo5pc2IUF5QXamvpWBKkWa1G4mqMHOPg+2Ym85S9aIbXcpRh4DHclV5ZDg9lp658JgvkrxLnrVn839tvVR/13mtz+Vr9vab2FEJu3NIyMVv8tYwam/5ojV2ew10rkfLkF5wRIjAuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZmGL3q4V; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721291026; x=1752827026;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=64so2fzErg3e9zcwe/1rx4boY6PkVsoWGetw5NVcFp8=;
  b=ZmGL3q4VpMKnyNijkGrm2EDx9AUIQumwvthIHB724GmbBNWDctb4HfAf
   4dYLX5ffOgNwd+UcjKP1YiZQsu1/5KQuiwDD/GMdGMGxWGFjhk5l+Fdjk
   Io28J24Y9uuaMMYViFQz8+boN7RR/lYBSwl8XkjstYw7OVPPgQKHKFHk4
   dBRJ2SlBNx5R9tkDaWP8PpBaZcIQThoWfJRIY8cUWY+y8yjCYQn5R7U8k
   G58FxQYy5nNdh0oojsU1Ddd+eAslSs8T9sIWt6dO4bWcirz+Taho+3yHp
   oo9poBg51Li/riiwftRYh7M1LLhSnd7HWGo3l3IV3sPIv3JBYCD5JbQ7V
   A==;
X-CSE-ConnectionGUID: NABq6MXrSNehUGLZwcxbAg==
X-CSE-MsgGUID: PzPNb7cESCCYJf4HyvT7SA==
X-IronPort-AV: E=McAfee;i="6700,10204,11136"; a="18459507"
X-IronPort-AV: E=Sophos;i="6.09,217,1716274800"; 
   d="scan'208";a="18459507"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2024 01:23:45 -0700
X-CSE-ConnectionGUID: dLyn3vjRQoequ6AAkfq9ug==
X-CSE-MsgGUID: vzCcE248TMSdAfLgjpPrNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,217,1716274800"; 
   d="scan'208";a="81341372"
Received: from sbutnari-mobl1.ti.intel.com (HELO [10.245.246.71]) ([10.245.246.71])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2024 01:23:43 -0700
Message-ID: <d121ec31-0861-4324-8f53-6e06eaf60233@linux.intel.com>
Date: Thu, 18 Jul 2024 10:23:40 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ld.lld: error: undefined symbol: iosf_mbi_available
To: Takashi Iwai <tiwai@suse.de>, Nathan Chancellor <nathan@kernel.org>
Cc: kernel test robot <lkp@intel.com>, llvm@lists.linux.dev,
 oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
 Bard Liao <bard.liao@intel.com>
References: <202407160704.zpdhJ8da-lkp@intel.com>
 <05954a59-2bef-4262-bd91-cfe21d2381f2@linux.intel.com>
 <20240717202806.GA728411@thelio-3990X> <87wmljw485.wl-tiwai@suse.de>
Content-Language: en-US
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <87wmljw485.wl-tiwai@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/18/24 09:26, Takashi Iwai wrote:
> On Wed, 17 Jul 2024 22:28:06 +0200,
> Nathan Chancellor wrote:
>>
>> On Wed, Jul 17, 2024 at 01:43:35PM +0200, Pierre-Louis Bossart wrote:
>>>
>>>
>>> On 7/16/24 01:07, kernel test robot wrote:
>>>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
>>>> head:   3e7819886281e077e82006fe4804b0d6b0f5643b
>>>> commit: 8d4ba1be3d2257606e04aff412829d8972670750 ASoC: SOF: pci: split PCI into different drivers
>>>> date:   3 years, 4 months ago
>>>
>>> This doesn't seem to be a problem on the latest code? was it intentional
>>> to report a problem on such an old commit?
>>
>> It's still reproducible at commit 8b0f0bb27c32 ("Merge tag
>> 'fs_for_v6.11-rc1' of
>> git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs") for me,
>> using either LLVM or GCC with the configuration linked below:

I can't compile this branch - errors in unrelated parts of the code, but
indeed there's a problem when IOSF_MBI=y and Baytrail is not selected.

>>   ld.lld: error: undefined symbol: iosf_mbi_available
>>   >>> referenced by atom.c
>>   >>>               sound/soc/sof/intel/atom.o:(atom_machine_select) in archive vmlinux.a
>>
>>   ld.lld: error: undefined symbol: iosf_mbi_read
>>   >>> referenced by atom.c
>>   >>>               sound/soc/sof/intel/atom.o:(atom_machine_select) in archive vmlinux.a
>>
>>   .../gcc/14.1.0/bin/i386-linux-ld: sound/soc/sof/intel/atom.o: in function `atom_machine_select':
>>   atom.c:(.text+0x1b9): undefined reference to `iosf_mbi_available'
>>   .../gcc/14.1.0/bin/i386-linux-ld: atom.c:(.text+0x1e3): undefined reference to `iosf_mbi_read'
> 
> Yours looks different from the original report, and indeed this must
> be a missing fix.
> 
> Does the following change cover it?
> 
> 
> thanks,
> 
> Takashi
> 
> --- a/sound/soc/sof/intel/Kconfig
> +++ b/sound/soc/sof/intel/Kconfig
> @@ -19,6 +19,7 @@ config SND_SOC_SOF_INTEL_ATOM_HIFI_EP
>  	tristate
>  	select SND_SOC_SOF_INTEL_COMMON
>  	select SND_SOC_SOF_INTEL_HIFI_EP_IPC
> +	select IOSF_MBI if X86 && PCI
>  	help
>  	  This option is not user-selectable but automagically handled by
>  	  'select' statements at a higher level.
> @@ -44,7 +45,6 @@ config SND_SOC_SOF_BAYTRAIL
>  	select SND_SOC_SOF_INTEL_COMMON
>  	select SND_SOC_SOF_INTEL_ATOM_HIFI_EP
>  	select SND_SOC_SOF_ACPI_DEV
> -	select IOSF_MBI if X86 && PCI
>  	help
>  	  This adds support for Sound Open Firmware for Intel(R) platforms
>  	  using the Baytrail, Braswell or Cherrytrail processors.

I don't think it's the 'right' fix Takashi.

The problem is that we end-up using the iosf_mbi_read() routine by
including the soc-intel-quirks.h header file blindly for all X66
platforms - even when Baytrail is not used.

Adding IOSF support for Tangiger doesn't seem right to me, it's not a
real dependency.

We can be more restrictive and only use the helper for Baytrail, and use
a fallback if Baytrail is not used.

diff --git a/sound/soc/intel/common/soc-intel-quirks.h
b/sound/soc/intel/common/soc-intel-quirks.h
index de4e550c5b34..ae67853f7e2e 100644
--- a/sound/soc/intel/common/soc-intel-quirks.h
+++ b/sound/soc/intel/common/soc-intel-quirks.h
@@ -11,7 +11,9 @@

 #include <linux/platform_data/x86/soc.h>

-#if IS_ENABLED(CONFIG_X86)
+#if IS_ENABLED(CONFIG_X86) && \
+       (IS_ENABLED(CONFIG_SND_SOC_SOF_BAYTRAIL) || \
+        IS_ENABLED(CONFIG_SND_SST_ATOM_HIFI2_PLATFORM_ACPI))

 #include <linux/dmi.h>
 #include <asm/iosf_mbi.h>

also at https://github.com/thesofproject/linux/pull/5114

