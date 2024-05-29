Return-Path: <linux-kernel+bounces-194339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B1BD8D3A6F
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 17:15:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BDECAB229D9
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 15:15:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABCF217DE23;
	Wed, 29 May 2024 15:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b81h5WXS"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81FC315A861
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 15:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716995695; cv=none; b=PmtI/i7cNTxgdPIVcv/4MhaykSF5ttsRpeqLmDlbAVVbNuB8+DNdHaNDBLk/JZ30QT3964o25f7XxMRAbb35zC4uSXbGdwB6fGOaeAgIcXfBvO5CP118Dr7pL20g97S1IO4t2L+O8sbxx28qIgLiRTRPk+6KzISxz6vWYEKcrS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716995695; c=relaxed/simple;
	bh=+5PvPZmLOmnshPNPKSLTEOoqrHNii4uujhjt1IhjMqQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fnRBKBdObQj4q+bSRkfTIatRfT+wmEBkHj1I2gUoEnxzIay0B/gEIFFsM0tbIa+x+VLFUiX3y1dPw7PlAIiEX8bCa1WE/S9WaQR0OrNQoYAiMbAsSEb6qtZ4h9FS293eX7lOJI9rLSVEuE/A6t3xgTyf4/SLHgY9piMha3KBKtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b81h5WXS; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716995695; x=1748531695;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=+5PvPZmLOmnshPNPKSLTEOoqrHNii4uujhjt1IhjMqQ=;
  b=b81h5WXSyFUvDj7Jd80kuPIKOF2u1In2ceVWLafuVwtbRvaBk88wvXBC
   x54jvntbRFx2zobxwJRXcQhxj5let3Mx3GEuwLd2rc+19knax8l4lGG3l
   Q8tPit8JeLi0DiHlAFRMMGI0V44QpKFjMIHYAoMQZ4Frj2Vz5kBZ4rOzD
   tcuknPRRstf381Fs4DkpWee0glGrTToEQGaDyA3X40fnQS+Xktr13om8Y
   iVvjKdnRYt2Qx/uogx3DB5Sx92ZgD7sYjZGklq1pKOjcIJ9UGGmgOs+od
   W618hk9s7531lqAzZqX6KI31WIyO3Qdsax6uSJaQzson7NVG4ZVLdCDQg
   g==;
X-CSE-ConnectionGUID: AgEe4vKhRvOVgQn1vsj0kQ==
X-CSE-MsgGUID: nA7IggyjTk6QiEYsG853Tw==
X-IronPort-AV: E=McAfee;i="6600,9927,11087"; a="13356147"
X-IronPort-AV: E=Sophos;i="6.08,198,1712646000"; 
   d="scan'208";a="13356147"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2024 08:14:55 -0700
X-CSE-ConnectionGUID: pVfW9CPiQYG+ybnwT0wnIA==
X-CSE-MsgGUID: J8vlnD7eSByTEwjwOndNIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,198,1712646000"; 
   d="scan'208";a="39892434"
Received: from unknown (HELO [10.125.111.89]) ([10.125.111.89])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2024 08:14:52 -0700
Message-ID: <de2d3908-e424-4449-9ee5-c1b783d73a9d@linux.intel.com>
Date: Wed, 29 May 2024 09:23:26 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] ASoc: tas2781: Enable RCA-based playback without DSP
 firmware download
To: Shenghao Ding <shenghao-ding@ti.com>, broonie@kernel.org
Cc: andriy.shevchenko@linux.intel.com, lgirdwood@gmail.com, perex@perex.cz,
 13916275206@139.com, alsa-devel@alsa-project.org, i-salazar@ti.com,
 linux-kernel@vger.kernel.org, j-chadha@ti.com, liam.r.girdwood@intel.com,
 jaden-yue@ti.com, yung-chuan.liao@linux.intel.com, dipa@ti.com,
 kevin-lu@ti.com, yuhsuan@google.com, tiwai@suse.de, baojun.xu@ti.com,
 soyer@irl.hu, Baojun.Xu@fpt.com, judyhsiao@google.com, navada@ti.com,
 cujomalainey@google.com, aanya@ti.com, nayeem.mahmud@ti.com,
 savyasanchi.shukla@netradyne.com, flaviopr@microsoft.com
References: <20240529103543.2089-1-shenghao-ding@ti.com>
Content-Language: en-US
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20240529103543.2089-1-shenghao-ding@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit




> In only RCA(Reconfigurable Architecture) binary case, no DSP program will
> be working inside tas2563/tas2781, that is dsp-bypass mode, do not support
> speaker protection, and audio acoustic algorithms in this mode.

The commit title and body are much better, thank you!


> -enum tasdevice_dsp_fw_state {
> +enum tasdevice_fw_state {
>  	TASDEVICE_DSP_FW_NONE = 0,
>  	TASDEVICE_DSP_FW_PENDING,
>  	TASDEVICE_DSP_FW_FAIL,
> +	TASDEVICE_RCA_FW_OK,
>  	TASDEVICE_DSP_FW_ALL_OK,

You should really add a description of what the state machine looks
like, and why FW_PENDING/FAIL remain but are not used.

>  };
>  
> diff --git a/sound/soc/codecs/tas2781-fmwlib.c b/sound/soc/codecs/tas2781-fmwlib.c
> index 265a8ca25cbb..5db1a0ac6036 100644
> --- a/sound/soc/codecs/tas2781-fmwlib.c
> +++ b/sound/soc/codecs/tas2781-fmwlib.c
> @@ -2324,14 +2324,19 @@ void tasdevice_tuning_switch(void *context, int state)
>  	struct tasdevice_fw *tas_fmw = tas_priv->fmw;
>  	int profile_cfg_id = tas_priv->rcabin.profile_cfg_id;
>  
> -	if (tas_priv->fw_state == TASDEVICE_DSP_FW_FAIL) {
> -		dev_err(tas_priv->dev, "DSP bin file not loaded\n");
> +	/*
> +	 * Only RCA-based Playback can still work with no dsp program running
> +	 * inside the chip?
> +	 */
> +	if (!(tas_priv->fw_state == TASDEVICE_RCA_FW_OK ||
> +		tas_priv->fw_state == TASDEVICE_DSP_FW_ALL_OK)) {
> +		dev_err(tas_priv->dev, "No firmware loaded\n");
>  		return;
>  	}
>  
>  	if (state == 0) {
> -		if (tas_priv->cur_prog < tas_fmw->nr_programs) {
> -			/*dsp mode or tuning mode*/
> +		if (tas_fmw && tas_priv->cur_prog < tas_fmw->nr_programs) {
> +			/* dsp mode or tuning mode */
>  			profile_cfg_id = tas_priv->rcabin.profile_cfg_id;
>  			tasdevice_select_tuningprm_cfg(tas_priv,
>  				tas_priv->cur_prog, tas_priv->cur_conf,
> @@ -2340,9 +2345,10 @@ void tasdevice_tuning_switch(void *context, int state)
>  
>  		tasdevice_select_cfg_blk(tas_priv, profile_cfg_id,
>  			TASDEVICE_BIN_BLK_PRE_POWER_UP);
> -	} else
> +	} else {
>  		tasdevice_select_cfg_blk(tas_priv, profile_cfg_id,
>  			TASDEVICE_BIN_BLK_PRE_SHUTDOWN);
> +	}
>  }
>  EXPORT_SYMBOL_NS_GPL(tasdevice_tuning_switch,
>  	SND_SOC_TAS2781_FMWLIB);
> diff --git a/sound/soc/codecs/tas2781-i2c.c b/sound/soc/codecs/tas2781-i2c.c
> index 9350972dfefe..9b85a44511c2 100644
> --- a/sound/soc/codecs/tas2781-i2c.c
> +++ b/sound/soc/codecs/tas2781-i2c.c
> @@ -380,23 +380,33 @@ static void tasdevice_fw_ready(const struct firmware *fmw,
>  	mutex_lock(&tas_priv->codec_lock);
>  
>  	ret = tasdevice_rca_parser(tas_priv, fmw);
> -	if (ret)
> +	if (ret) {
> +		tasdevice_config_info_remove(tas_priv);
>  		goto out;
> +	}
>  	tasdevice_create_control(tas_priv);
>  
>  	tasdevice_dsp_remove(tas_priv);
>  	tasdevice_calbin_remove(tas_priv);
> -	tas_priv->fw_state = TASDEVICE_DSP_FW_PENDING;
> +	tas_priv->fw_state = TASDEVICE_RCA_FW_OK;
>  	scnprintf(tas_priv->coef_binaryname, 64, "%s_coef.bin",
>  		tas_priv->dev_name);
> +
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
>  
> @@ -417,9 +427,8 @@ static void tasdevice_fw_ready(const struct firmware *fmw,
>  	tasdevice_prmg_load(tas_priv, 0);
>  	tas_priv->cur_prog = 0;
>  out:
> -	if (tas_priv->fw_state == TASDEVICE_DSP_FW_FAIL) {
> -		/*If DSP FW fail, kcontrol won't be created */
> -		tasdevice_config_info_remove(tas_priv);
> +	if (tas_priv->fw_state == TASDEVICE_RCA_FW_OK) {
> +		/*If DSP FW fail, DSP kcontrol won't be created */

please add spaces on each side of a comment.

>  		tasdevice_dsp_remove(tas_priv);

So the state "FW_OK" means a fail now? It's not clear if this branch
will work in all cases, including the original configuration where RCA
was NOT used.

Your previous explanation on the states is very hard to follow

>> It looks like you're no longer using PENDING and FAIL states?
> The state machine is becoming really hard to follow.
PENDING and FAIL states have been used in HDA-based tas2563/tas2781 driver

Not following why the DSP boot state would depend on what interface is
used to load firmware?

If this is because the definition is included in two separate drivers,
is this ok to add an intermediate state on one side but not the other?
Is there any merit to a shared definition if the states are completely
different?


>  	}
>  	mutex_unlock(&tas_priv->codec_lock);
> @@ -466,14 +475,14 @@ static int tasdevice_startup(struct snd_pcm_substream *substream,
>  {
>  	struct snd_soc_component *codec = dai->component;
>  	struct tasdevice_priv *tas_priv = snd_soc_component_get_drvdata(codec);
> -	int ret = 0;
>  
> -	if (tas_priv->fw_state != TASDEVICE_DSP_FW_ALL_OK) {
> -		dev_err(tas_priv->dev, "DSP bin file not loaded\n");
> -		ret = -EINVAL;
> +	if (!(tas_priv->fw_state == TASDEVICE_DSP_FW_ALL_OK ||
> +		tas_priv->fw_state == TASDEVICE_RCA_FW_OK)) {
> +		dev_err(tas_priv->dev, "Bin file not loaded\n");
> +		return -EINVAL;
>  	}
>  
> -	return ret;
> +	return 0;
>  }
>  
>  static int tasdevice_hw_params(struct snd_pcm_substream *substream,

