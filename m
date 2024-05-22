Return-Path: <linux-kernel+bounces-186184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB0DF8CC0C8
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 14:02:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EED151C21BB3
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 12:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DEBB82494;
	Wed, 22 May 2024 12:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jdYPgH9+"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C0CE7E567
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 12:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716379332; cv=none; b=oasdCmQw5M1PdBL9WvBJJ7da3eqTH2S3QCVuDNYnNuE+XdmH4ZoLNeEJJgvAMS9oSEcsI07ZB33zcyRqTbYuyhevuG0sepTIr+h8pdzgl1PdQngzt1uPevjJOJnR+5XK7zv0P8stMkSbqRsx9SqoUOD0ryhV9txf4DK7MTihQHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716379332; c=relaxed/simple;
	bh=V1W1yhRu3QGRy8i0FYdCDQwXLV2ju0wX/urQiIjlx+A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FyjpDRlDRTVT8Y6hfhM0AC0W8KK1+I/VcBenMGIdRjV8e+NaTuc7cd3PlHqj53xiA1mHgv1OeM0X6BDY65mMXqQ8Hz8yEdYGEXs9eC4IgwDm9Wveqr0rZB62C/hGSQkq3I9ZPY8xBjpDjMlXS2sjIKf6VMAkcxYyneMSN2ikNsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jdYPgH9+; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716379330; x=1747915330;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=V1W1yhRu3QGRy8i0FYdCDQwXLV2ju0wX/urQiIjlx+A=;
  b=jdYPgH9+fypWdM6sAVa9NxgSAtu6Juj/BWXsIkfqetVnYO72rEBtNOCw
   GIZuSOgcaJ3OOh/vFdv5pfdA5Zmz32XA4f3RSVFWEm6anIdguJ1BwSVTE
   uQVodQH+StIXlTMWLk3dTjh3BdkDB75SYPtzZdwopujdTpdo199a5It9R
   JZmEPyxcrVxJP9Mm/DltOzIa06ikMmPeIdUlsjTCEhMboI7PcAy6RnPYR
   1/khSUYDujEXuVLbkfi/oogzpQ0hTOWMp55LHoH6pRhYJJ6KynF3C9wus
   epP2Mpg30H2whNlHf6afIJB8blfSpbcqlJadfTyMWvhH/auVbu71w3CA0
   w==;
X-CSE-ConnectionGUID: W6vvHVvyQoiImkRPVcg8Fg==
X-CSE-MsgGUID: r+gTPmnRRb6Uu+lZhdDYbw==
X-IronPort-AV: E=McAfee;i="6600,9927,11079"; a="38007983"
X-IronPort-AV: E=Sophos;i="6.08,179,1712646000"; 
   d="scan'208";a="38007983"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2024 05:01:57 -0700
X-CSE-ConnectionGUID: qLBuxnBlTUiMeiYoe1OuRg==
X-CSE-MsgGUID: +oAIr/WIRDOT4+f5G2La8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,179,1712646000"; 
   d="scan'208";a="64489562"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2024 05:01:51 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1s9kfE-00000009xkL-0Kd9;
	Wed, 22 May 2024 15:01:48 +0300
Date: Wed, 22 May 2024 15:01:47 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Shenghao Ding <shenghao-ding@ti.com>
Cc: broonie@kernel.org, lgirdwood@gmail.com, perex@perex.cz,
	pierre-louis.bossart@linux.intel.com, 13916275206@139.com,
	judyhsiao@google.com, alsa-devel@alsa-project.org, i-salazar@ti.com,
	linux-kernel@vger.kernel.org, j-chadha@ti.com,
	liam.r.girdwood@intel.com, bard.liao@intel.com,
	yung-chuan.liao@linux.intel.com, dipa@ti.com, kevin-lu@ti.com,
	yuhsuan@google.com, tiwai@suse.de, baojun.xu@ti.com, soyer@irl.hu,
	Baojun.Xu@fpt.com, navada@ti.com, cujomalainey@google.com,
	aanya@ti.com, nayeem.mahmud@ti.com
Subject: Re: [PATCH v1] ASoc: tas2781: Add Calibration Kcontrols and tas2563
 digtial gain for Chromebook
Message-ID: <Zk3eq0k2Eq-gtejq@smile.fi.intel.com>
References: <20240522112942.994-1-shenghao-ding@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240522112942.994-1-shenghao-ding@ti.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, May 22, 2024 at 07:29:41PM +0800, Shenghao Ding wrote:
> Calibrated data will be set to default after loading DSP config params,
> which will cause speaker protection work abnormally. Reload calibrated
> data after loading DSP config params.

..

> -// tas2781-lib.c -- TAS2781 Common functions for HDA and ASoC Audio drivers
> +// tas2781-comlib.c -- TAS2781 Common functions for HDA and ASoC Audio drivers

Please, drop the filename from the file completely, this change is exactly the
answer to "why having filename in the file is a bad idea in a long-term".

..

> +int tasdevice_chn_switch(struct tasdevice_priv *tas_priv,
> +	unsigned short chn)

Pretty much can be on a single line.

> +{
> +	struct i2c_client *client = (struct i2c_client *)tas_priv->client;
> +	struct tasdevice *tasdev = &tas_priv->tasdevice[chn];
> +	struct regmap *map = tas_priv->regmap;
> +	int ret;

> +	if (client->addr != tasdev->dev_addr) {

With inverted check this entire function becomes neater.

> +		client->addr = tasdev->dev_addr;
> +		/* All devices share the same regmap, clear the page
> +		 * inside regmap once switching to another device.
> +		 * Register 0 at any pages and any books inside tas2781
> +		 * is the same one for page-switching.
> +		 */
> +		ret = regmap_write(map, TASDEVICE_PAGE_SELECT, 0);
> +		if (ret < 0) {
> +			dev_err(tas_priv->dev, "%s, E=%d\n",
> +				__func__, ret);
> +			return ret;
> +		}
> +		return 1;
> +	}
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(tasdevice_chn_switch);

Is it namespaced? If not would be good to make it so.
Also I see that other file uses namespaced exports.

..

> +	if (!priv->is_user_space_calidata &&
> +		cal_fmw) {

With all possible restrictions this can be on a single line besides the fact
that the second one currently has a broken indentation.

..

> +				&(data[k + 4 * j]), 4);

How parentheses are helpful here?

> +	}

..

> +#include <asm/unaligned.h>

linux/* followed by asm/* as the latter is not so generic as the former.

>  #include <linux/crc8.h>
>  #include <linux/firmware.h>
>  #include <linux/gpio/consumer.h>

..

> +	{
> +		.reg = TAS2781_PRM_TEST_57_REG,
> +		.val = { 0x14 },
> +		.val_len = 1,
> +		.is_locked = true

Here and everywhere else in cases like this (when it's not a termination line)
leave the trailing comma. It will reduce the churn in case this needs to be
expanded in the future.

> +	},

..

> +	int rc;
> +
> +	mutex_lock(&tas_priv->codec_lock);
> +	rc = tasdevice_digital_getvol(tas_priv, ucontrol, mc);
> +	mutex_unlock(&tas_priv->codec_lock);
>  
> -	return tasdevice_digital_getvol(tas_priv, ucontrol, mc);
> +	return rc;

Why not converting to use cleanup.h and this will become a oneliner update.
Same Q to all these mutex additions.

..

> +{
> +	struct i2c_client *clt = (struct i2c_client *)tas_priv->client;

Hmm... Why explicit casting? Is the client not void * or the same type?

> +	struct tasdevice *tasdev = tas_priv->tasdevice;

> +	int rc = -1;

Use proper error codes.

> +	int i;
> +
> +	if (data_len != 4)
> +		return rc;
> +
> +	for (i = 0; i < tas_priv->ndev; i++) {
> +		if (clt->addr == tasdev[i].dev_addr) {
> +			/* First byte is the device index. */
> +			dst[0] = i;
> +			tasdevice_dev_bulk_read(tas_priv, i, reg, &dst[1],
> +				4);

On one line this will be better to read.

> +			rc = 0;
> +			break;

Why not simply

			return 0;

?

> +		}
> +	}
> +
> +	return rc;
> +}

..

> +	if (tas_priv->chip_id != TAS2781 &&
> +		bytes_ext->max != 8 * tas_priv->ndev) {

Here and seems in many places you have broken indentation.

> +		rc = -1;

error code?

> +		goto out;
> +	}

> +		for (j = 0; j < sum; j++) {

With a temporary variable for p[j]...

> +			if (p[j].val_len == 1) {
> +				if (p[j].is_locked)
> +					tasdevice_dev_write(tas_priv, i,
> +						TAS2781_TEST_UNLOCK_REG,
> +						TAS2781_TEST_PAGE_UNLOCK);
> +				tasdevice_dev_read(tas_priv, i, p[j].reg,
> +					(int *)&p[j].val[0]);
> +			} else
> +				tasdevice_dev_bulk_read(tas_priv, i, p[j].reg,
> +					p[j].val, 4);

..all the above can be made more readable.

> +		}
> +
> +		for (j = 0; j < sum - 2; j++) {

Ditto for tas2781_cali_start_reg[j]

> +		}

..

> +	while (r > 1 + l) {
> +		mid = (l + r) / 2;
> +		ar_mid = get_unaligned_be32(tas2563_dvc_table[mid]);
> +		if (target < ar_mid)
> +			r = mid;
> +		else
> +			l = mid;
> +	}

Hmm... I'm wondering if bsearch() can be utilised here.

..

> +	ucontrol->value.integer.value[0] =
> +		abs(target - ar_l) <= abs(target - ar_r) ? l : r;

I don't understand why do you need 'target' to be in this check.

..

> +	uinfo->value.integer.max = (int)tas_priv->ndev - 1;

Why casting?

..

> +	scnprintf(active_dev_name, SNDRV_CTL_ELEM_ID_NAME_MAXLEN,

Why 'c' variant in use? You are ignoring the returned value. Isn't strscpy()
you want or memtostr() (in both cases 2 parameters variant)?

> +		"Activate Tasdevice Id");

Same Q to all scnprintf() calls.

..

> +	cali_data->data = devm_kzalloc(tas_priv->dev, tas_priv->ndev *
> +		(cali_data->reg_array_sz * 4 + 1), GFP_KERNEL);

No way. First of all, we have kcalloc(), second, there is an overflow.h that
has necessary macros to calculate sizes for memory allocations.

> +	if (!cali_data->data)
> +		return -ENOMEM;

..

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

This patch is a mess. Try to split out the different logical changes into
different patches.

-- 
With Best Regards,
Andy Shevchenko



