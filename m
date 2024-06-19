Return-Path: <linux-kernel+bounces-220538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11CBB90E361
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 08:28:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 083DB1C2123C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 06:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E966A6CDC8;
	Wed, 19 Jun 2024 06:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y/hllxRS"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E6B288DB;
	Wed, 19 Jun 2024 06:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718778497; cv=none; b=MKzjz4OXbNo7SGXPKdRmW92xl4pJT50O+nPZRfbpw+dB1oyB65YerTCoiV06oZqzqr7E3i7SEY0v1TLBjorSp6oy3ayjEiHgYR0Qq/A41KF45aEJuYHqw+uBJYWX9dt6QPg9UffYrqQaXqeMKMWumjgWn3qkVVoq6zZ38KwexP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718778497; c=relaxed/simple;
	bh=5wpLH3UULQ70QIdi562QH80gx5EXjoJrYinxKDWNba8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BJ6LkIBLY6Ba3Sp1n/Zim0LTjxNidJqAu8KgEk8favJJsYCEMR88zrqnXPbwdkmDH8jqkrOm4oUhvpDMCOXzV1aYWC2fbgA/b7qU7to/QqUAeh0IArRwRWTowBSzHWQYjGBHHH45iGWqrrZlZ7WqRqj0mvVcxbTXnzn+nOUBXhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y/hllxRS; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718778495; x=1750314495;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=5wpLH3UULQ70QIdi562QH80gx5EXjoJrYinxKDWNba8=;
  b=Y/hllxRSQY42LIuFKL6XnA722DWrfZ0qAYCoUOpCC4s1aLAV4TH/JXOg
   RtR19aY0s+4KoL837pzlBS6Zy/aTuwksWDEe3DtDuDmCZcVvhhGgvFoBM
   8vzeBNjBLR7m7YykMm/kxB1vJsweBDirtZZikiN8QhwOtMyWt0gK81xa7
   tkKgwphVlbSD7AmCG2ALhPyzjXjsV1K7hG5E5BrnDuabFoVvNI8UkJsX4
   VyV7nl7h3ia/8v4hfeyEWqVsBdzOtK7CID1vCKUtsv10HzNFG6TMYvhz6
   IHmlJYEGv5rjG1+p0puUO4L9td+uOZktjMXp1bLc+vH9bfnKGAOg5cCSG
   w==;
X-CSE-ConnectionGUID: tIT9HADEQDqtztsQeIB2ww==
X-CSE-MsgGUID: NKaGGI4XSr23OOwRd/sa8A==
X-IronPort-AV: E=McAfee;i="6700,10204,11107"; a="15838801"
X-IronPort-AV: E=Sophos;i="6.08,249,1712646000"; 
   d="scan'208";a="15838801"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2024 23:28:15 -0700
X-CSE-ConnectionGUID: LfkoHihfTbOK1J2M4irh6w==
X-CSE-MsgGUID: uYKUTPcRT4OHh5pfJW+Z6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,249,1712646000"; 
   d="scan'208";a="41644749"
Received: from lfiedoro-mobl.ger.corp.intel.com (HELO [10.245.246.239]) ([10.245.246.239])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2024 23:28:13 -0700
Message-ID: <e49db7a2-b77e-4065-9400-84d3386fb169@linux.intel.com>
Date: Wed, 19 Jun 2024 08:28:10 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Regression] Lenovo Thinkpad X1 Carbon Gen 10 first S2idle fails,
 S0ix fails in all further suspends
To: Thorsten Leemhuis <regressions@leemhuis.info>
Cc: Todd Brandt <todd.e.brandt@intel.com>,
 Linux Sound System <linux-sound@vger.kernel.org>,
 Linux kernel regressions list <regressions@lists.linux.dev>,
 LKML <linux-kernel@vger.kernel.org>, sound-open-firmware@alsa-project.org
References: <ca2d3d47-0ac0-48a5-910b-e481f2a9870a@leemhuis.info>
Content-Language: en-US
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <ca2d3d47-0ac0-48a5-910b-e481f2a9870a@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/18/24 12:22, Thorsten Leemhuis wrote:
> Hi, Thorsten here, the Linux kernel's regression tracker.
> 
> Pierre-Louis Bossart, I noticed a report about a regression in
> bugzilla.kernel.org that appears to be caused by the following change of
> yours: d5263dbbd8af02 ("ASoC: SOF: Intel: don't ignore IOC interrupts
> for non-audio transfers") [v6.10-rc1]
> 
> As many (most?) kernel developers don't keep an eye on the bug tracker,
> I decided to write this mail. To quote from
> https://bugzilla.kernel.org/show_bug.cgi?id=218961 :


Thanks for the heads-up.
SOF driver bugs are tracked on https://github.com/thesofproject/linux, I
filed an issue https://github.com/thesofproject/linux/issues/5072 with
the information copied.


>> We have a Lenovo Thinkpad X1 Carbon Gen 10 in our lab and ever since
>> 6.10.0-rc1 it has failed its first S2idle suspend, and has stopped
>> getting S0iX on subsequent successful S2idle suspends. The issue in the
>> first suspend fail is here in the audio driver (dmesg section shown):
>>
>> sof-audio-pci-intel-tgl 0000:00:1f.3: Code loader DMA did not complete

The only thing the commit below added is a 500ms timeout, but the log
below shows the DSP boot failed already?

>> sof-audio-pci-intel-tgl 0000:00:1f.3: ------------[ DSP dump start ]------------
>> sof-audio-pci-intel-tgl 0000:00:1f.3: Firmware download failed
>> sof-audio-pci-intel-tgl 0000:00:1f.3: fw_state: SOF_FW_BOOT_READY_OK (6)
>> sof-audio-pci-intel-tgl 0000:00:1f.3: 0x00000005: module: ROM, state: FW_ENTERED, running
>> sof-audio-pci-intel-tgl 0000:00:1f.3: extended rom status:  0x5 0x0 0x4000 0x0 0x0 0x0 0x2560521 0x0
>> sof-audio-pci-intel-tgl 0000:00:1f.3: ------------[ DSP dump end ]------------
>> sof-audio-pci-intel-tgl 0000:00:1f.3: Failed to start DSP
>> sof-audio-pci-intel-tgl 0000:00:1f.3: error: failed to boot DSP firmware after resume -110
>> sof-audio-pci-intel-tgl 0000:00:1f.3: error: hda_dsp_core_reset_enter: timeout on HDA_DSP_REG_ADSPCS read
>> sof-audio-pci-intel-tgl 0000:00:1f.3: error: dsp core reset failed: core_mask 1
>> sof-audio-pci-intel-tgl 0000:00:1f.3: failed to power down DSP during suspend
>> sof-audio-pci-intel-tgl 0000:00:1f.3: error: suspending dsp
>> sof-audio-pci-intel-tgl 0000:00:1f.3: error: failed to power down DSP during suspend -110
>> sof-audio-pci-intel-tgl 0000:00:1f.3: PM: pci_pm_suspend(): snd_sof_suspend [snd_sof] returns -110
>> sof-audio-pci-intel-tgl 0000:00:1f.3: PM: dpm_run_callback(): pci_pm_suspend returns -110
>> sof-audio-pci-intel-tgl 0000:00:1f.3: PM: failed to suspend async: error -110
>>
>> This is the commit:
>>
>> commit d5263dbbd8af026159b16a08a94bedfe51b5f67b
>> Author: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
>> Date:   Thu Apr 4 13:54:47 2024 -0500
>>
>>     ASoC: SOF: Intel: don't ignore IOC interrupts for non-audio transfers
>>
>> Reverting the commit thusly fixes things in everything up to 6.10.0-rc3.
>>
>> %> git diff 6cbf086143cf9674c7f029e1cf435c65a537066a d5263dbbd8af026159b16a08a94bedfe51b5f67b > ../revert.patch
>> %> cat ../revert.patch | patch -1 -R
>>
>> I've attached the sleepgraph timeline of the fail. The dmesg log is
>> accesible by clicking the "dmesg" button in the upper right hand corner.
>> They "log" button shows all the system details.
> 
> See the ticket for more details.
> 
> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
> --
> Everything you wanna know about Linux kernel regression tracking:
> https://linux-regtracking.leemhuis.info/about/#tldr
> If I did something stupid, please tell me, as explained on that page.
> 
> P.S.: let me use this mail to also add the report to the list of tracked
> regressions to ensure it's doesn't fall through the cracks:
> 
> #regzbot introduced: d5263dbbd8af02
> #regzbot title: ASoC: SOF: Intel:
> #regzbot from: Todd Brandt
> #regzbot duplicate: https://bugzilla.kernel.org/show_bug.cgi?id=218961
> #regzbot ignore-activity

