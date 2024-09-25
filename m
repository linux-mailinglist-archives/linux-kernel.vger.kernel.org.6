Return-Path: <linux-kernel+bounces-338277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2D389855CE
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 10:46:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 933B4284287
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 08:46:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72BE0157A46;
	Wed, 25 Sep 2024 08:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Oez+TumF"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F912AE6C;
	Wed, 25 Sep 2024 08:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727253976; cv=none; b=CSARL0ygg/1C3YUJbNdZR0K7xZIG1afhXymwUWmK5WQxboBvkhlmnlxdVDT2XvAT7EGtFpgNRA5RyEfDfdu2tPE+c+cF02dCek5U0rVyRgmakFHKFCsUQJ1y+4ZRijSn/66vBMPLjIB+/n5GBTDozzzSEjRC4MzVXJ5tcFhk+94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727253976; c=relaxed/simple;
	bh=xKL4aaFY4RmnNb3f+W1zkmXNIxHXpZYbk2lZXvhOuPs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fKfcOkFiUOaTDLyzC3+Wl5ANQFEYHeuuQp7L2zUQUb/R4vEiXxpvg7Nn1W8HlR3RTEaZKUrf1KtGY6d2qo4/V/gQ2/IE4zpqO2J1fFfSDPpNeFceExFy42GrrA6RBPVfDnIKTdTndNBLjJARitYCeR6T5K1HHDbNXuiwIbJaEmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Oez+TumF; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727253975; x=1758789975;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=xKL4aaFY4RmnNb3f+W1zkmXNIxHXpZYbk2lZXvhOuPs=;
  b=Oez+TumFIbJH0UMUtTJwO5hCUFIAg6DKKDsFm4eGog7LTHUi9kBG0TZw
   ZO2yqha/KYtK7sfxAXIJGNpaA1iN04dhw5oFfgxIlKddH8zayvfH/z8Ls
   afYbRuuDXFNEek3J0WhwhjDa+emFED2rHKJBzN1QGEgDFy4yXlz3RQWQM
   nhY/3qO6SlOrAbGTr6cXor2VxlJZIx5gM6r0FgxMlLfEgi9uJn7faYYzp
   QR1998OdI/19x6QFm70Gk//AJ4aM/2d+/USTy6Jl2ZynFhMnwpxcRlQGP
   PxNr5AxMKxWSbjDkq1ef2xyv4iuAJ3Hp+T96+FxPVbkncOrcjet4T7ldJ
   Q==;
X-CSE-ConnectionGUID: X+kDoALuTrqThnJfbMmIvA==
X-CSE-MsgGUID: Jh1DeZ07Q0WqgX7lEpnzfg==
X-IronPort-AV: E=McAfee;i="6700,10204,11205"; a="30079166"
X-IronPort-AV: E=Sophos;i="6.10,256,1719903600"; 
   d="scan'208";a="30079166"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2024 01:46:15 -0700
X-CSE-ConnectionGUID: 2JP7K0g9RHWi3KLwhIZrOA==
X-CSE-MsgGUID: BQZ2JySuSzWRKK8r8IpEwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,256,1719903600"; 
   d="scan'208";a="71787690"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO [10.245.246.30]) ([10.245.246.30])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2024 01:46:11 -0700
Message-ID: <814913ab-903a-4395-bfb9-5fcbb9d3a5f2@linux.intel.com>
Date: Wed, 25 Sep 2024 10:46:08 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ASoC: intel: sof_sdw: Add check devm_kasprintf() returned
 value
To: Charles Han <hanchunchao@inspur.com>, yung-chuan.liao@linux.intel.com,
 ckeepax@opensource.cirrus.com
Cc: alsa-devel@alsa-project.org, liam.r.girdwood@linux.intel.com,
 peter.ujfalusi@linux.intel.com, broonie@kernel.org, tiwai@suse.com,
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240925080030.11262-1-hanchunchao@inspur.com>
Content-Language: en-US
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20240925080030.11262-1-hanchunchao@inspur.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/25/24 10:00, Charles Han wrote:
> devm_kasprintf() can return a NULL pointer on failure but this
> returned value is not checked.
> 
> Fixes: b359760d95ee ("ASoC: intel: sof_sdw: Add simple DAI link creation helper")
> Signed-off-by: Charles Han <hanchunchao@inspur.com>
> ---
>  sound/soc/intel/boards/sof_sdw.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/sound/soc/intel/boards/sof_sdw.c b/sound/soc/intel/boards/sof_sdw.c
> index d258728d64cf..26917f6f15cf 100644
> --- a/sound/soc/intel/boards/sof_sdw.c
> +++ b/sound/soc/intel/boards/sof_sdw.c
> @@ -919,6 +919,9 @@ static int create_ssp_dailinks(struct snd_soc_card *card,
>  		char *cpu_dai_name = devm_kasprintf(dev, GFP_KERNEL, "SSP%d Pin", i);
>  		char *codec_name = devm_kasprintf(dev, GFP_KERNEL, "i2c-%s:0%d",
>  						  ssp_info->acpi_id, j++);
> +		if (!name || !cpu_dai_name || !codec_name)
> +			return -ENOMEM;
> +

all 3 changes are correct, thanks for the patch. The only nit-pick is
that I would have moved the devm_ allocation + test lower to be
consistent with the coding style which avoids mixing code and declarations.

>  		int playback = ssp_info->dais[0].direction[SNDRV_PCM_STREAM_PLAYBACK];
>  		int capture = ssp_info->dais[0].direction[SNDRV_PCM_STREAM_CAPTURE];
>  
> @@ -985,6 +988,9 @@ static int create_hdmi_dailinks(struct snd_soc_card *card,
>  	for (i = 0; i < hdmi_num; i++) {
>  		char *name = devm_kasprintf(dev, GFP_KERNEL, "iDisp%d", i + 1);
>  		char *cpu_dai_name = devm_kasprintf(dev, GFP_KERNEL, "iDisp%d Pin", i + 1);
> +		if (!name || !cpu_dai_name)
> +			return -ENOMEM;
> +
>  		char *codec_name, *codec_dai_name;
>  
>  		if (intel_ctx->hdmi.idisp_codec) {
> @@ -996,6 +1002,9 @@ static int create_hdmi_dailinks(struct snd_soc_card *card,
>  			codec_dai_name = "snd-soc-dummy-dai";
>  		}
>  
> +		if (!codec_dai_name)
> +			return -ENOMEM;
> +
>  		ret = asoc_sdw_init_simple_dai_link(dev, *dai_links, be_id, name,
>  						    1, 0, // HDMI only supports playback
>  						    cpu_dai_name, platform_component->name,
> @@ -1019,6 +1028,9 @@ static int create_bt_dailinks(struct snd_soc_card *card,
>  			SOF_BT_OFFLOAD_SSP_SHIFT;
>  	char *name = devm_kasprintf(dev, GFP_KERNEL, "SSP%d-BT", port);
>  	char *cpu_dai_name = devm_kasprintf(dev, GFP_KERNEL, "SSP%d Pin", port);
> +	if (!name || !cpu_dai_name)
> +		return -ENOMEM;
> +
>  	int ret;
>  
>  	ret = asoc_sdw_init_simple_dai_link(dev, *dai_links, be_id, name,


