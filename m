Return-Path: <linux-kernel+bounces-190747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BDF18D020F
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 15:44:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3388D28D15D
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 13:44:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A409115EFD4;
	Mon, 27 May 2024 13:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KoyqNHpT"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26CD015EFCB
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 13:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716817452; cv=none; b=U4Y487kKJdlJuVatySATaMJuD+9OrXWgBXrRHgenK6dF6/dT+kmrn+w0Gx6ehEeI1X4Wn07kgwMfuWHSLLLHHLP2BCB0PAtze+ByP5GUYjFoihw2mSmVstraHOQ1TMhz2gk4O8Zj/CxRlwa9AYHY1Gqjt046VlDVY47Nxov72gU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716817452; c=relaxed/simple;
	bh=Y4lg1w9PMKXk/DYDc4ftwcvGasjMUD1Xkcb1fEgP/BU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ariai9eRGOentClVqqEzoCvvbMYtE7jA8/ZD1zlHuXkwxQyco1TwqRIQXxmpYYdVjForbQPoOu3ObG1ZqWe+hdd00Rz8hP45Uus1qhXEF5cKonRiq+V6EIm5/etHbu91U/lLX+m1VyMtlq0/mVPITKk38G8oqKvypIMLhsnRB9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KoyqNHpT; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716817452; x=1748353452;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Y4lg1w9PMKXk/DYDc4ftwcvGasjMUD1Xkcb1fEgP/BU=;
  b=KoyqNHpTAniAAb8DVHd3MBZNCUCbaQIazWK85nI2G28jATV2Fd6heo5b
   v1ZM5S2BiQt7OIWcrYfzqXhGsfoeL347+GgiBntsa9DGGpSwuiEcoE+Ma
   pgv8hvO1znZstA2iBvGu+jXt22mUKd6Z9Wb5FMMbzqSKz03B2sbaLQXC1
   wrkH0xMt6SR7Uk32Nj8fWerhdRH6esG1uss5X8wV0ZKskUJryPGB446tC
   G+QGqSthKVBncs5l51EFJwS28rvdidYSTPDUzZd72RdeFgJNpqjHvzHj1
   PLN2kNsokUVqKeKQT77TWnyLB9uFJW0uutkn9wEmHNlVuI6a4RvG//GRS
   w==;
X-CSE-ConnectionGUID: PN9ztC37Qzmn7DTzZkGBsw==
X-CSE-MsgGUID: HbRAAtvwRqyJpYv542inxw==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="24265233"
X-IronPort-AV: E=Sophos;i="6.08,192,1712646000"; 
   d="scan'208";a="24265233"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2024 06:44:10 -0700
X-CSE-ConnectionGUID: +/Yk/RZZSai7ZanjM3CxDg==
X-CSE-MsgGUID: Hdj76MThTLiwanVCmdpq2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,192,1712646000"; 
   d="scan'208";a="39210524"
Received: from kinlongk-mobl1.amr.corp.intel.com (HELO [10.125.110.211]) ([10.125.110.211])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2024 06:44:07 -0700
Message-ID: <6a8ab4f6-63be-4284-814a-d853faf000b5@linux.intel.com>
Date: Mon, 27 May 2024 08:44:06 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ASoc: tas2781: Playback can work when only RCA binary
 loading without dsp firmware loading
To: Shenghao Ding <shenghao-ding@ti.com>, broonie@kernel.org
Cc: andriy.shevchenko@linux.intel.com, lgirdwood@gmail.com, perex@perex.cz,
 13916275206@139.com, alsa-devel@alsa-project.org, i-salazar@ti.com,
 linux-kernel@vger.kernel.org, j-chadha@ti.com, liam.r.girdwood@intel.com,
 jaden-yue@ti.com, yung-chuan.liao@linux.intel.com, dipa@ti.com,
 kevin-lu@ti.com, yuhsuan@google.com, tiwai@suse.de, baojun.xu@ti.com,
 soyer@irl.hu, Baojun.Xu@fpt.com, judyhsiao@google.com, navada@ti.com,
 cujomalainey@google.com, aanya@ti.com, nayeem.mahmud@ti.com
References: <20240525014727.197-1-shenghao-ding@ti.com>
Content-Language: en-US
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20240525014727.197-1-shenghao-ding@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/24/24 20:47, Shenghao Ding wrote:
> In only RCA binary loading case, only default dsp program inside the
> chip will be work.

What does 'RCA' stand for?

Also clarify the commit title without double negatives, e.g.

"Enable RCA-based playback without DSP firmware download"
> -	if (tas_priv->fw_state == TASDEVICE_DSP_FW_FAIL) {
> -		dev_err(tas_priv->dev, "DSP bin file not loaded\n");
> +	/*
> +	 * Only RCA file loaded can still work with default dsp program inside
> +	 * the chip?

reword the commit and remove question mark.

> +	 */
> +	if (!(tas_priv->fw_state == TASDEVICE_RCA_FW_OK ||
> +		tas_priv->fw_state == TASDEVICE_DSP_FW_ALL_OK)) {
> +		dev_err(tas_priv->dev, "No firmware loaded\n");
>  		return;
>  	}
>  
>  	if (state == 0) {
> -		if (tas_priv->cur_prog < tas_fmw->nr_programs) {
> +		if (tas_fmw && tas_priv->cur_prog < tas_fmw->nr_programs) {
>  			/*dsp mode or tuning mode*/

spaces in comments

>  			profile_cfg_id = tas_priv->rcabin.profile_cfg_id;
>  			tasdevice_select_tuningprm_cfg(tas_priv,
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
> index 9350972dfefe..ccb9313ada9b 100644
> --- a/sound/soc/codecs/tas2781-i2c.c
> +++ b/sound/soc/codecs/tas2781-i2c.c
> @@ -380,23 +380,30 @@ static void tasdevice_fw_ready(const struct firmware *fmw,
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
> +	ret = tasdevice_dsp_create_ctrls(tas_priv);
> +	if (ret) {
> +		dev_err(tas_priv->dev, "dsp controls error\n");
> +		goto out;
> +	}

this seems unrelated to the boot process? Move to a different patch?

>  
>  	tas_priv->fw_state = TASDEVICE_DSP_FW_ALL_OK;
>  
> @@ -417,9 +424,8 @@ static void tasdevice_fw_ready(const struct firmware *fmw,
>  	tasdevice_prmg_load(tas_priv, 0);
>  	tas_priv->cur_prog = 0;
>  out:
> -	if (tas_priv->fw_state == TASDEVICE_DSP_FW_FAIL) {
> -		/*If DSP FW fail, kcontrol won't be created */
> -		tasdevice_config_info_remove(tas_priv);
> +	if (tas_priv->fw_state == TASDEVICE_RCA_FW_OK) {
> +		/*If DSP FW fail, DSP kcontrol won't be created */

It looks like you're no longer using PENDING and FAIL states?
The state machine is becoming really hard to follow.

>  		tasdevice_dsp_remove(tas_priv);
>  	}
>  	mutex_unlock(&tas_priv->codec_lock);
> @@ -466,14 +472,14 @@ static int tasdevice_startup(struct snd_pcm_substream *substream,
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

