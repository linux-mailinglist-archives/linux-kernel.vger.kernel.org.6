Return-Path: <linux-kernel+bounces-384562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0814E9B2BB8
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 10:42:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3D971F22E25
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 09:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C590E1B6D10;
	Mon, 28 Oct 2024 09:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Zq5ZaQbc"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 171E7186E59;
	Mon, 28 Oct 2024 09:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730108534; cv=none; b=a7dsArpd9t2zvIXdM60eJpy/c7xnk45j14wyZAzJCBr6flMRDpQit43A44lB+Z9GrQ6h4WaSqQEFqksPtmA4u5LZsLcVG/+YZDSulnXnAlJoIYh27p7u58UjzD/C4BRwr7ThkVAhs9JnIiUWqCW8N7YhlnWJ+/xkiKyLGLE9usM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730108534; c=relaxed/simple;
	bh=u3CcYZPAhCHto7li0VH0IFXnXUVWJuwP8SZ7uyxGndc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iaqZVsBdYeRhAcEuh82IKOtmIEr2UrmbHZo8rUgWTa35zChTlHcO42QQwVECj2T3p4AaqRViJbaJwsDp8nWGQ1X3D+08fwSGs+FBKKrWwwrwtSETrR0HB0LIi+31hSyjSqDIY7kS58J172Kxg4Q1SknacP8Df+XSQhKxsYdUE2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Zq5ZaQbc; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730108532; x=1761644532;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=u3CcYZPAhCHto7li0VH0IFXnXUVWJuwP8SZ7uyxGndc=;
  b=Zq5ZaQbcWoEMQt3Q1sV3SeyXr3dTH/aa0L57XHp12Z/rWB3StbwdaMPi
   uXblRNqmXxnucwjA/RvjB4QloIp0TuahHRIUrZdELdiZ3GDGEI1NrVs+k
   XzVUhOx2Q6g1P0dyTKYtby1IcJq9pY1B6heELYgStEQBmdWQPlwHZb8TZ
   nvdCNq9dP+3lCkDABsoqBSL2RkTyS5A22QMsY1vb4mVdKz/D1SrlZWbOB
   pCawXIRbQ/U5XTaaxpYXY+TUainf5730tndxc17/GofYC4t8uXyqpfNUb
   C8nhz/urVLVO0IEkByYo+u57odBWazf48PsjLHhUnAguP8jwBhfILQKih
   w==;
X-CSE-ConnectionGUID: 5mlvsVDpQWasqs/IxISbzA==
X-CSE-MsgGUID: In1KRxI3SL+CSEpAH+eKcQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11238"; a="33493347"
X-IronPort-AV: E=Sophos;i="6.11,238,1725346800"; 
   d="scan'208";a="33493347"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2024 02:42:12 -0700
X-CSE-ConnectionGUID: V1p5E/jKQkCXUO1JA9ii9Q==
X-CSE-MsgGUID: JN9SWGHhSfKSLF9tTWxD3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,238,1725346800"; 
   d="scan'208";a="81470816"
Received: from smile.fi.intel.com ([10.237.72.154])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2024 02:42:07 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1t5MGC-00000007tdH-1h6o;
	Mon, 28 Oct 2024 11:42:04 +0200
Date: Mon, 28 Oct 2024 11:42:04 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Baojun Xu <baojun.xu@ti.com>
Cc: tiwai@suse.de, robh+dt@kernel.org, lgirdwood@gmail.com, perex@perex.cz,
	pierre-louis.bossart@linux.intel.com, shenghao-ding@ti.com,
	navada@ti.com, 13916275206@139.com, v-hampiholi@ti.com, v-po@ti.com,
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
	liam.r.girdwood@intel.com, yung-chuan.liao@linux.intel.com,
	broonie@kernel.org, antheas.dk@gmail.com
Subject: Re: [PATCH v3] ALSA: hda/tas2781: Add speaker id check for ASUS
 projects
Message-ID: <Zx9cbCq5jl3tOJAk@smile.fi.intel.com>
References: <20241027143935.1340-1-baojun.xu@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241027143935.1340-1-baojun.xu@ti.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Sun, Oct 27, 2024 at 10:39:35PM +0800, Baojun Xu wrote:
> Add speaker id check by gpio in ACPI for ASUS projects.
> In other vendors, speaker id was checked by BIOS, and was applied in
> last bit of subsys id, so we can load corresponding firmware binary file
> for its speaker by subsys id.
> But in ASUS project, the firmware binary name will be appended an extra
> number to tell the speakers from different vendors. And this single digit
> come from gpio level of speaker id in BIOS.

...

> +	// Speaker id was needed for ASUS projects.
> +	if (!strncasecmp(sub, TAS2781_ASUS_ID, sizeof(TAS2781_ASUS_ID))) {

Why "case"? Just use strcmp() since the second one is constant and you use it's
length.

> +		devm_acpi_dev_add_driver_gpios(p->dev,
> +			tas2781_speaker_id_gpios);

I don't know why you completely removed the check, I would leave a debug
message on the error path to give a clue to the user if it fails here.
See how other driver do with this.

Something like

		ret = devm_acpi_dev_add_driver_gpios(p->dev, tas2781_speaker_id_gpios);
		if (ret)
			dev_dbg(...);

> +		p->speaker_id = devm_gpiod_get(p->dev, "speakerid", GPIOD_IN);
> +		if (IS_ERR(p->speaker_id)) {
> +			dev_err(p->dev, "Failed to get Speaker id.\n");

Wrong value in ret, right?

> +			goto err;
> +		}
> +	} else {
> +		p->speaker_id = NULL;
> +	}
>  
>  	acpi_dev_free_resource_list(&resources);
>  	strscpy(p->dev_name, hid, sizeof(p->dev_name));
> +	put_device(physdev);
>  	acpi_dev_put(adev);
>  
>  	return 0;
>  
>  err:
>  	dev_err(p->dev, "read acpi error, ret: %d\n", ret);
> +	put_device(physdev);
>  	acpi_dev_put(adev);
>  
>  	return ret;

...

> +	if (tas_priv->speaker_id != NULL) {
> +		// Speaker id need to be checked for ASUS only.
> +		spk_id = gpiod_get_value(tas_priv->speaker_id);
> +		if (spk_id < 0) {
> +			// Speaker id is not valid, use default.
> +			dev_dbg(tas_priv->dev, "Wrong spk_id = %d\n", spk_id);
> +			spk_id = 0;
> +		}
> +		snprintf(tas_priv->coef_binaryname,
> +			  sizeof(tas_priv->coef_binaryname),
> +			  "TAS2XXX%04X%01d.bin",

%01d makes a little sense. Just use %d.

> +			  lower_16_bits(codec->core.subsystem_id),
> +			  spk_id);
> +	} else {
> +		snprintf(tas_priv->coef_binaryname,
> +			  sizeof(tas_priv->coef_binaryname),
> +			  "TAS2XXX%04X.bin",
> +			  lower_16_bits(codec->core.subsystem_id));
> +	}

-- 
With Best Regards,
Andy Shevchenko



