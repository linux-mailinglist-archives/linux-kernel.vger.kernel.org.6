Return-Path: <linux-kernel+bounces-394614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0719D9BB1DF
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 11:57:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2B721F21228
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 10:57:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF7671B6D08;
	Mon,  4 Nov 2024 10:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IIfBPzUl"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD4A318BB84;
	Mon,  4 Nov 2024 10:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730717536; cv=none; b=BRC1MJVhaUPE2N2YVhgg+jgpl/DhV6E8SuCzOLz/8mHnf+gzns5h9jZJh77Ldnucsn+xywSTAkHlMeLWV/uKPH4CkPvvgcCUnvxhMztmp5EDGvgUakqOYx2hIUQRdgWNYCUZx0DMHaIV5BiZXw4XsuaNTR3BrqyCC5b66+vyEQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730717536; c=relaxed/simple;
	bh=Uk1iiLYLyoRnUhMJxOSfgzDMTCawW2FdcelKradx3Mc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UWhxwjWgdL4AfwY9z3Ld9adpGLmPEA6c1vSg/usl+GHfbQRJLgARiXOErt+Ke56SK1vZG5m18E/nEa74eeBOz5jpsLZTz1YBFDFhNWmfZ6K6ehNNr1Cpl4rlxZW+wMpkDysZAYduimw2vo+/HSvkt0WMJE+TvztHaIyj/Mb+c2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IIfBPzUl; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730717534; x=1762253534;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Uk1iiLYLyoRnUhMJxOSfgzDMTCawW2FdcelKradx3Mc=;
  b=IIfBPzUl5phKH+sMSdN8VwBidNxVij+p/IxYsQoRHjWXsyqCvYA29fMk
   xiswZVxm2Sioba05X7RqqfRjpy0nbBDd58rJoMTzJTo675xRCZfMu69Ga
   PPRZ8f/MCWEhy4U/rGExQW08nQXXTXU21pt7eB+YKjs5gtQ/iZxYf05Wm
   7ZBCFl7r0/aafgS49VzvwNjvA+pANSL5PwGv4pxQZc+9d4rrVJZ1hUr3e
   i2WaNJEkv87qDmGlPPUGTpLTEoi8a5heiD2RdpIHLOQe57ab3VEs7mr8S
   hFSrMCnipC/fcFBtr7UZvjLbzsd3yg4Jo7texmCS0A+x4kIsMXwPDdlVC
   w==;
X-CSE-ConnectionGUID: OvYyN1DoQkqkPfynM7ugPQ==
X-CSE-MsgGUID: LKuL/y5JTgO3A6k719zqiQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11245"; a="41799440"
X-IronPort-AV: E=Sophos;i="6.11,256,1725346800"; 
   d="scan'208";a="41799440"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2024 02:52:14 -0800
X-CSE-ConnectionGUID: aIyglxVlRzGO0AWQgMPJfg==
X-CSE-MsgGUID: 0dpG+hToTnyY4zYBJ/Oi3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,256,1725346800"; 
   d="scan'208";a="83549794"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO [10.245.244.217]) ([10.245.244.217])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2024 02:52:12 -0800
Message-ID: <09d8462d-d305-4b83-ade9-747a88aedc38@linux.intel.com>
Date: Mon, 4 Nov 2024 12:52:09 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] sound: fix uninit-value in
 sof_ipc4_pcm_dai_link_fixup_rate
To: Suraj Sonawane <surajsonawane0215@gmail.com>
Cc: broonie@kernel.org, daniel.baluta@nxp.com, kai.vehmanen@linux.intel.com,
 lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
 linux-sound@vger.kernel.org, perex@perex.cz, pierre-louis.bossart@linux.dev,
 ranjani.sridharan@linux.intel.com, sound-open-firmware@alsa-project.org,
 tiwai@suse.com, yung-chuan.liao@linux.intel.com
References: <20241030155705.31327-1-surajsonawane0215@gmail.com>
 <20241103113702.27673-1-surajsonawane0215@gmail.com>
From: =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>
Content-Language: en-US
In-Reply-To: <20241103113702.27673-1-surajsonawane0215@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 03/11/2024 13:37, Suraj Sonawane wrote:
> Fix an issue detected by the Smatch tool:
> 
> sound/soc/sof/ipc4-pcm.c: sof_ipc4_pcm_dai_link_fixup_rate()
> error: uninitialized symbol 'be_rate'.
> 
> This issue occurred because the variable 'be_rate' could remain
> uninitialized if num_input_formats is zero. In such cases, the
> loop that assigns a value to 'be_rate' would not execute,
> potentially leading to undefined behavior when rate->min and
> rate->max are set with an uninitialized 'be_rate'.
> 
> To resolve this, an additional check for num_input_formats > 0
> was added before setting rate->min and rate->max with 'be_rate'.
> This ensures that 'be_rate' is assigned only when there are valid
> input formats, preventing any use of uninitialized data.
> 
> This solution maintains defined behavior for rate->min and rate->max,
> ensuring they are only assigned when valid be_rate data is available.
> 
> Signed-off-by: Suraj Sonawane <surajsonawane0215@gmail.com>
> ---
> V1: Initialize 'be_rate' to 0.
> V2: Add conditional assignment based on num_input_formats to ensure
> be_rate is used only when assigned.
> 
>  sound/soc/sof/ipc4-pcm.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/soc/sof/ipc4-pcm.c b/sound/soc/sof/ipc4-pcm.c
> index 4df2be3d3..d5d7ffc69 100644
> --- a/sound/soc/sof/ipc4-pcm.c
> +++ b/sound/soc/sof/ipc4-pcm.c
> @@ -633,8 +633,11 @@ static int sof_ipc4_pcm_dai_link_fixup_rate(struct snd_sof_dev *sdev,
>  			return -EINVAL;
>  		}
>  
> -		rate->min = be_rate;
> -		rate->max = rate->min;
> +		/* Set rate only if be_rate was assigned */
> +		if (num_input_formats > 0) {

By definition the copier must have at least one input and one output
format, this check is going to be always true.

> +			rate->min = be_rate;
> +			rate->max = rate->min;
> +		}
>  	}
>  
>  	return 0;

-- 
Péter


