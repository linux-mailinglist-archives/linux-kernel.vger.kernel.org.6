Return-Path: <linux-kernel+bounces-274377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01D39947781
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 10:43:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B47DA28111E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 08:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2471314EC7E;
	Mon,  5 Aug 2024 08:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PMGYM3m8"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C343D3FB3B;
	Mon,  5 Aug 2024 08:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722847402; cv=none; b=f5bQUyhicaAZl2QS0qEOrObNZN0vrDjtkOH5lA6iWTR9TYqyr/LUEVknWqf17wTJqa3zKpeOajdwzjYyT3zAdGPjrNDnTsxkUgHtnfBSyoHs9rvyoMS2vvhg/PWh1oq+C4FGkc/klEww79HWiH3Y2CPIwV7EsQVg3emIvry65Rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722847402; c=relaxed/simple;
	bh=6V+NUWtERM0UhpzcaLVsRmqe5qPsjA6dhvW+4SWx5Pg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jusoMxeaJQf9v1+ditsCvSx4QnSWIcITYWynY6Nj6nfWqKeulrMyJ8L17lSOiQaAk4CeIrJ7wln6tfL8ofH5/tXojyaFP0V9M8ISnj1pdeVrz1qO4FxepwVLqFJoKoYYD1rCz7z4qgVr+78/97i5MGnT4fps74FafiYqINIXT/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PMGYM3m8; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722847401; x=1754383401;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=6V+NUWtERM0UhpzcaLVsRmqe5qPsjA6dhvW+4SWx5Pg=;
  b=PMGYM3m88lUF+IfWjSRIkFVjP8MGJUOo1vLn18RNHefv0G3x/CsyWQL7
   jA80Bl5tBbt+NJ0DqwJYwcDV/ZzVXHJtcF8ec7td8Z8j7ZChMFMIGyFsa
   XD8l5JOg5WDcMni4Iu4kT2KMBmTpaUuK8cnN8mq6lx0aRu8LnpuMDPE4y
   MwK2rBwsebdK+sBrhPBGPeuEVEwcIRbS4SpNic00ZG6TsfPdmWAdFS/Eo
   0TOdEu3O5Zo1Vaq86N9/Z0VYoM6s3ozKTTuv4cLVUwNOzmiiMcfWikxpN
   emeI3J6xA0tH+M6X4MCk0bSHP07rncRic/0R0ea6luVONS2b9x4m51pan
   w==;
X-CSE-ConnectionGUID: E5/4+mZIQlub8z1qJLf57A==
X-CSE-MsgGUID: ozf7ShDvTRewoGWh7+jovQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11154"; a="24664413"
X-IronPort-AV: E=Sophos;i="6.09,264,1716274800"; 
   d="scan'208";a="24664413"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2024 01:43:20 -0700
X-CSE-ConnectionGUID: 9Ma2Wu6YQjO+e8vJqN52fA==
X-CSE-MsgGUID: mOqaFRYgTW+ZAhNCcWlnUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,264,1716274800"; 
   d="scan'208";a="60226007"
Received: from aslawinx-mobl.ger.corp.intel.com (HELO [10.94.0.53]) ([10.94.0.53])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2024 01:43:18 -0700
Message-ID: <83d0a673-007e-4e0e-8db3-856ae02cd67c@linux.intel.com>
Date: Mon, 5 Aug 2024 10:43:15 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ALSA: hda: Manally set pins to correct HP firmware
 settings
Content-Language: en-US
To: Steven 'Steve' Kendall <skend@chromium.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240802-hdmi-audio-hp-wrongpins-v1-1-8d8ba10d77f8@chromium.org>
From: =?UTF-8?Q?Amadeusz_S=C5=82awi=C5=84ski?=
 <amadeuszx.slawinski@linux.intel.com>
In-Reply-To: <20240802-hdmi-audio-hp-wrongpins-v1-1-8d8ba10d77f8@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/3/2024 1:50 AM, Steven 'Steve' Kendall wrote:
> In recent HP UEFI firmware (likely v2.15 and above, tested on 2.27),
> these pins are incorrectly set for HDMI/DP audio. Tested on
> HP MP9 G4 Retail System AMS. Pins for the ports set to escalating values
> (0x70, 80, 90) to have differing default associations, though in my
> testing setting all pins to 0x70 also worked as suggested by the first
> link below. Tested audio with two monitors connected via DisplayPort.
> 
> Link: https://forum.manjaro.org/t/intel-cannon-lake-pch-cavs-conexant-cx20632-no-sound-at-hdmi-or-displayport/133494
> Link: https://bbs.archlinux.org/viewtopic.php?id=270523
> Signed-off-by: Steven 'Steve' Kendall <skend@chromium.org>
> ---
>   sound/pci/hda/patch_hdmi.c | 21 ++++++++++++++++++++-
>   1 file changed, 20 insertions(+), 1 deletion(-)
> 
> diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
> index 707d203ba652..dfcbd41097f8 100644
> --- a/sound/pci/hda/patch_hdmi.c
> +++ b/sound/pci/hda/patch_hdmi.c
> @@ -3115,6 +3115,25 @@ static int patch_i915_hsw_hdmi(struct hda_codec *codec)
>   				     enable_silent_stream);
>   }
>   
> +static const struct snd_pci_quirk kaby_hdmi_list[] = {

I see that Takashi gave some other suggestion, but in case there is 
decision to proceed with this patch, change kaby_hdmi_list to kbl_hdmi_list.

> +	SND_PCI_QUIRK(0x103c, 0x83ef, "HP MP9 G4 Retail System AMS", 1),
> +	{}
> +};
> +
> +static int patch_i915_kaby_hdmi(struct hda_codec *codec)

and same here, kaby -> kbl

or maybe even consider cnl, as both linked issues seem to be reported on 
devices with Cannon Lake audio controller?

