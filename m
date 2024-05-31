Return-Path: <linux-kernel+bounces-197002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E26788D64C7
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 16:49:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EC741C23576
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 14:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEA1557323;
	Fri, 31 May 2024 14:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XG8EPRYs"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81FE87602B
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 14:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717166936; cv=none; b=AK4+OcBqKDMCXZJrAjmRFGkNYudUmKXlBeiNPX+gMKTay2tth+qbOkNJg+ao19yYReErwf5zWh8HpqJH1BOq1q5CXJ3GwIbH7/b7n3ZNs3VsqhtYR92QHQ49FY+Xoc/o+PFyRSOcZgZcGqX2xE8iSet8WH1dlmIn31YrXliNdxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717166936; c=relaxed/simple;
	bh=MG4XTF460ME3QysgJdn6KSQKbYDcjfrewhgJYyzES+8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=st6qATkPHqtc2F8fCEeHwway4fSkYWtesJspYaFI/NHfZLi4m0K6+T0geO0YjcJkpjH9wS6GPV58B6ZYPVgO7n5Oy6E8ifPVDWx49fQyGf0Jr9wy79aEhm23ZZlK1ygh3pnLOcSGvfGlfjblpnWUrRaxVrymzXjeEnawKrEspYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XG8EPRYs; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717166935; x=1748702935;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=MG4XTF460ME3QysgJdn6KSQKbYDcjfrewhgJYyzES+8=;
  b=XG8EPRYsaZoy0KFio2Ju+Rvec97a8r9lEhiHxVmVCiD9ZpJLQznY/1DI
   xTap5rkRGiLVEq7mwngORjlA75IK+rKLWREqirOhNa2Chf5f5LKEa+fMt
   xgVbHZ+u6G7YFWaPGlbZpy4/UN9jQQGEISSjJ6DKNcYpjvoiocLgSECWi
   5XY1YboequMxCp4GwJCCr4ODJzx2M6ou1xVAWn9YmoyPEp+2TDXu7RjG4
   Ewim5EgtTq99avI7fcZKVFpZ2Ux6RnlA3iVgU6R86o+z7jVfqWYbB5BS3
   YG2PQg95F4QmppFJG5imZTI0Xm9nbeYdHGeqHM/DA0SbVZ0fJV3v/dVcB
   Q==;
X-CSE-ConnectionGUID: kaUPsBW7Q3OINUgMZZjlgA==
X-CSE-MsgGUID: fzds1pj1RGWZpcg0MT9i6g==
X-IronPort-AV: E=McAfee;i="6600,9927,11088"; a="24288606"
X-IronPort-AV: E=Sophos;i="6.08,204,1712646000"; 
   d="scan'208";a="24288606"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2024 07:47:59 -0700
X-CSE-ConnectionGUID: eiuozHKnS2iAMwXvlG0LLQ==
X-CSE-MsgGUID: ztnHMCkNRxanqV1Z1AVwhw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,204,1712646000"; 
   d="scan'208";a="59361042"
Received: from ibganev-desk.amr.corp.intel.com (HELO [10.125.108.40]) ([10.125.108.40])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2024 07:47:56 -0700
Message-ID: <f1b6d4d8-1d17-4d1f-ba9d-8b59393a6676@linux.intel.com>
Date: Fri, 31 May 2024 09:46:55 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] ASoc: tas2781: Enable RCA-based playback without DSP
 firmware download
To: Shenghao Ding <shenghao-ding@ti.com>, broonie@kernel.org
Cc: andriy.shevchenko@linux.intel.com, lgirdwood@gmail.com, perex@perex.cz,
 13916275206@139.com, alsa-devel@alsa-project.org, i-salazar@ti.com,
 linux-kernel@vger.kernel.org, j-chadha@ti.com, liam.r.girdwood@intel.com,
 jaden-yue@ti.com, yung-chuan.liao@linux.intel.com, dipa@ti.com,
 yuhsuan@google.com, tiwai@suse.de, baojun.xu@ti.com, soyer@irl.hu,
 Baojun.Xu@fpt.com, judyhsiao@google.com, navada@ti.com,
 cujomalainey@google.com, aanya@ti.com, nayeem.mahmud@ti.com,
 savyasanchi.shukla@netradyne.com, flaviopr@microsoft.com, jesse-ji@ti.com
References: <20240531052636.565-1-shenghao-ding@ti.com>
Content-Language: en-US
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20240531052636.565-1-shenghao-ding@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


> -enum tasdevice_dsp_fw_state {
> -	TASDEVICE_DSP_FW_NONE = 0,
> +enum tasdevice_fw_state {
> +	/* Driver in startup mode, not load any firmware. */
>  	TASDEVICE_DSP_FW_PENDING,
> +	/* DSP firmware in the system, but parsing error. */
>  	TASDEVICE_DSP_FW_FAIL,
> +	/*
> +	 * Only RCA (Reconfigurable Architecture) firmware load
> +	 * successfully.
> +	 */
> +	TASDEVICE_RCA_FW_OK,
> +	/* Both RCA and DSP firmware load successfully. */
>  	TASDEVICE_DSP_FW_ALL_OK,

I appreciate the effort to document the states, but for the RCA cases we
can have two 'success' states?

> -	tas_priv->fw_state = TASDEVICE_DSP_FW_PENDING;
> +	tas_priv->fw_state = TASDEVICE_RCA_FW_OK;
>  	scnprintf(tas_priv->coef_binaryname, 64, "%s_coef.bin",
>  		tas_priv->dev_name);
>  	ret = tasdevice_dsp_parser(tas_priv);
>  	if (ret) {
>  		dev_err(tas_priv->dev, "dspfw load %s error\n",
>  			tas_priv->coef_binaryname);
> -		tas_priv->fw_state = TASDEVICE_DSP_FW_FAIL;
>  		goto out;
>  	}
> -	tasdevice_dsp_create_ctrls(tas_priv);
> +
> +	/*
> +	 * If no dsp-related kcontrol created, the dsp resource will be freed.
> +	 */
> +	ret = tasdevice_dsp_create_ctrls(tas_priv);
> +	if (ret) {
> +		dev_err(tas_priv->dev, "dsp controls error\n");
> +		goto out;
> +	}
>  
>  	tas_priv->fw_state = TASDEVICE_DSP_FW_ALL_OK;

from this code, it seems that the RCA case goes from RCA_FW_OK to
TASDEVICE_DSP_FW_ALL_OK, so there's a difference between the two states, no?


> @@ -466,14 +474,14 @@ static int tasdevice_startup(struct snd_pcm_substream *substream,
>  {
>  	struct snd_soc_component *codec = dai->component;
>  	struct tasdevice_priv *tas_priv = snd_soc_component_get_drvdata(codec);
> -	int ret = 0;
>  
> -	if (tas_priv->fw_state != TASDEVICE_DSP_FW_ALL_OK) {
> -		dev_err(tas_priv->dev, "DSP bin file not loaded\n");
> -		ret = -EINVAL;
> +	switch (tas_priv->fw_state) {
> +	case TASDEVICE_RCA_FW_OK:
> +	case TASDEVICE_DSP_FW_ALL_OK:
> +		return 0;
> +	default:
> +		return -EINVAL;

maybe keep the error logs?


