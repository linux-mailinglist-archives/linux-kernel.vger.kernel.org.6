Return-Path: <linux-kernel+bounces-371673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E6EA9A3E71
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 14:31:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01142285599
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 12:31:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E849E18028;
	Fri, 18 Oct 2024 12:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z+2nDTxf"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BFF620E323;
	Fri, 18 Oct 2024 12:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729254674; cv=none; b=f9jT+unLfO+gWgMkmcjC6HpGzIUiIGlluThgJo2VwnhSZwX9nw2AzYqOv2no21LlDXoajZgnvnbvTLebTA4rJDr7FLfg9kTIn/15CZCNxN9bN1hkS2BvvxUXotALt+/uC//40f3fLJFNf/lEOmq9h63/YDQiKuSnyVkD+V15a5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729254674; c=relaxed/simple;
	bh=YP4ryAVQ6mxQmShuV+kis5u6NU6ySMg9qusRdIUZQ7M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TgQod0HayCk6PSrbykFGUBHF++7WCfK3oX3htcFvvArrLCPAqfkY4cMbL7X27b0ThTG2PAH5hiuPWOE54dzryxau0xfErVrWYUX8asi8dra8ZelJYfQcec9btzD5jUFvU9e1QRhiU/Q1/IdHAinnkTVXniDyrZehvHtHLFlaRXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z+2nDTxf; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729254673; x=1760790673;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YP4ryAVQ6mxQmShuV+kis5u6NU6ySMg9qusRdIUZQ7M=;
  b=Z+2nDTxf9mRvBCAH+1EdeepbGedXbomKbLM5rhr0wKUBwTwhbdMqugN/
   ghLNyKLmpcVz5cr0zec/y+5TKcZNZZf5eeTtksyeLcTNXjtjOsf144XyM
   esf6n+M0OhbvAqCAZ5oaGB2d/lZGYGdDuvrdksYhRlossy6GINYNCDkrF
   XdK22nQyNLssXkVpq4+j8vzEIDju9X15QI32bjJ8+wFLxSYcOsBior7WF
   AOyJ2CICtnlKBwBHpWc0FwIHc8Wciyt2+i+7zGKIa6sJow8J4Ku2lWGvY
   /S8ggnM9RWu4F2BfSxGHkeMyjIU6i8iyRAPL5+/U4MKTCKymMThbYhWx7
   w==;
X-CSE-ConnectionGUID: 4OgStquhTHGx6+xI9iz+IQ==
X-CSE-MsgGUID: bCHgIM/XTM+LVC6ybjazxQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11229"; a="28875716"
X-IronPort-AV: E=Sophos;i="6.11,213,1725346800"; 
   d="scan'208";a="28875716"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2024 05:31:12 -0700
X-CSE-ConnectionGUID: asULgpfwRPCnZJ0v/ixNkg==
X-CSE-MsgGUID: rXrtIxgBSISh+tpNbvGoFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,213,1725346800"; 
   d="scan'208";a="109591173"
Received: from smile.fi.intel.com ([10.237.72.154])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2024 05:31:09 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1t1m8H-00000004SZ1-34nZ;
	Fri, 18 Oct 2024 15:31:05 +0300
Date: Fri, 18 Oct 2024 15:31:05 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Baojun Xu <baojun.xu@ti.com>
Cc: tiwai@suse.de, robh+dt@kernel.org, lgirdwood@gmail.com, perex@perex.cz,
	pierre-louis.bossart@linux.intel.com, shenghao-ding@ti.com,
	navada@ti.com, 13916275206@139.com, v-hampiholi@ti.com, v-po@ti.com,
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
	liam.r.girdwood@intel.com, yung-chuan.liao@linux.intel.com,
	broonie@kernel.org, antheas.dk@gmail.com
Subject: Re: [PATCH v2] ALSA: hda/tas2781: Add speaker id check for ASUS
 projects
Message-ID: <ZxJVCb13lQ4h2KRD@smile.fi.intel.com>
References: <20241018071118.3298-1-baojun.xu@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241018071118.3298-1-baojun.xu@ti.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Oct 18, 2024 at 03:11:18PM +0800, Baojun Xu wrote:
> Add speaker id check by gpio in ACPI for ASUS projects.
> In other vendors, speaker id was checked by BIOS, and was applied in
> last bit of subsys id, so we can load corresponding firmware binary file
> for its speaker by subsys id.
> But in ASUS project, the firmware binary name will be appended an extra
> number to tell the speakers from different vendors. And this single digit
> come from gpio level of speaker id in BIOS.

...

> +	sub = acpi_get_subsystem_id(ACPI_HANDLE(physdev));
> +	if (IS_ERR(sub)) {
> +		dev_err(p->dev, "Failed to get SUBSYS ID.\n");
> +		goto err;
> +	}
> +	// Speaker id was needed for ASUS projects.
> +	if (strstr(sub, TAS2781_ASUS_ID)) {

strstr() is wrong. You can get 1043 in the middle of the bigger number,
or even text.

> +		ret = devm_acpi_dev_add_driver_gpios(p->dev,
> +			tas2781_speaker_id_gpios);
> +		if (ret) {
> +			dev_err(p->dev, "Unable to add GPIO.\n");

> +			goto err;

No need. If this fails, the below most likely fail as well.

> +		}
> +		p->speaker_id = devm_gpiod_get(p->dev, "speakerid", GPIOD_IN);
> +		if (IS_ERR(p->speaker_id)) {
> +			dev_err(p->dev, "Failed to get Speaker id.\n");
> +			goto err;
> +		}
> +	} else {
> +		p->speaker_id = NULL;
> +	}

...

> +	if (tas_priv->speaker_id != NULL) {
> +		// Speaker id need to be checked for ASUS only.
> +		spk_id = gpiod_get_value(tas_priv->speaker_id);
> +		if (spk_id < 0 || spk_id > 1) {

When "> 1" is possible? Isn't it a dead code?

> +			// Speaker id is not valid, use default.
> +			dev_dbg(tas_priv->dev, "Wrong spk_id = %d\n", spk_id);
> +			spk_id = 0;
> +		}
> +		scnprintf(tas_priv->coef_binaryname,

Why 'c' variant? You do not check the return value anyway. So, what's the point?

> +			  sizeof(tas_priv->coef_binaryname),
> +			  "TAS2XXX%04X%01d.bin",
> +			  lower_16_bits(codec->core.subsystem_id),
> +			  spk_id);
> +	} else {
> +		scnprintf(tas_priv->coef_binaryname,

Ditto.

> +			  sizeof(tas_priv->coef_binaryname),
> +			  "TAS2XXX%04X.bin",
> +			  lower_16_bits(codec->core.subsystem_id));
> +	}

...

> @@ -793,7 +844,6 @@ static int tas2781_hda_i2c_probe(struct i2c_client *clt)
>  	const char *device_name;
>  	int ret;
>  
> -
>  	tas_hda = devm_kzalloc(&clt->dev, sizeof(*tas_hda), GFP_KERNEL);
>  	if (!tas_hda)
>  		return -ENOMEM;

Stray change.

-- 
With Best Regards,
Andy Shevchenko



