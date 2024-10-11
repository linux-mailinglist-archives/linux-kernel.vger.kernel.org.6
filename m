Return-Path: <linux-kernel+bounces-361017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C59C99A268
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 13:08:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B3E7B252FE
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 11:08:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28622215026;
	Fri, 11 Oct 2024 11:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XNXsQuWi"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF5B2141C7
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 11:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728644866; cv=none; b=cCJafjiniBXJi84fbrFtrxD8DpAxuAqCnYq2S3jR45D/F2zX0TsACs/J1mPRCyK1BSeda8ILc6xXntFtEQopyaPNlA0WiB1uvCMKOK3egmqQM4iphl6sG8+3prCbtLBOALHh9T1LdbG67Ib2aarWFv49KpwrJkEwd8mBpxeRGig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728644866; c=relaxed/simple;
	bh=W2AEd9w6vWrpcUMPLNR+VUSfGNW+x+cz3tudsyam76c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a4YcbC2Y5GcUL1oQwKsGLsJKmREfQw0OaA4S9BDZVEUp6pt5ynqm7AAdrfE6Ro/zuu777scNNi5jiUQaRLR9xlYH9yAhd/w8LSTPi7fMQOBNwr2A71jyvzBbfERnMLVMeSUHOo0yhlUtOf1y5zSzdoMoyCVLP0faIuiXX7qgkCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XNXsQuWi; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728644865; x=1760180865;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=W2AEd9w6vWrpcUMPLNR+VUSfGNW+x+cz3tudsyam76c=;
  b=XNXsQuWif3vvx7FoNWuPylgRtSrI1fs2GRrjOYsqXvEmj9kXlgKZcen8
   8cs90akWjkW78icaGzYl0Rb8Gcahg2nEC6/5ZqhEQzKutGL7MFRlgn0Xl
   PfGWfD7khxwVuayZLZ6eB1xhw2ItBfmIf02LDWhiLgvAyAf+D7JAvSjh7
   SE4QroudZTNf51p6NoRUPbapFG+JLa9uqKXX2jgDINCsGF3R1nYIWYEG9
   rZG/cejkJBElldsWz6paULFnKxL3+951dps7EQod/8/+X8Di1Ua4sYPLO
   30so6unWScxqZZw7zi2woqrR9+5r9Zv6NVDdVvK+IALlK4MswcYn0mvjb
   w==;
X-CSE-ConnectionGUID: EBgqRLplQkeilQqgacYxUg==
X-CSE-MsgGUID: Fn61GwqSQF+/WzsiZI/cxg==
X-IronPort-AV: E=McAfee;i="6700,10204,11221"; a="38610473"
X-IronPort-AV: E=Sophos;i="6.11,195,1725346800"; 
   d="scan'208";a="38610473"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2024 04:07:45 -0700
X-CSE-ConnectionGUID: zKMc30dKQ1ii8EgMRMHeXw==
X-CSE-MsgGUID: z/K0GQ+2Ro+e8sSzq+emuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,195,1725346800"; 
   d="scan'208";a="100207487"
Received: from smile.fi.intel.com ([10.237.72.154])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2024 04:07:39 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1szDUd-00000001ryB-3rKQ;
	Fri, 11 Oct 2024 14:07:35 +0300
Date: Fri, 11 Oct 2024 14:07:35 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Baojun Xu <baojun.xu@ti.com>
Cc: tiwai@suse.de, robh+dt@kernel.org, lgirdwood@gmail.com, perex@perex.cz,
	pierre-louis.bossart@linux.intel.com, kevin-lu@ti.com,
	shenghao-ding@ti.com, navada@ti.com, 13916275206@139.com,
	v-hampiholi@ti.com, v-po@ti.com, niranjan.hy@ti.com,
	alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
	liam.r.girdwood@intel.com, yung-chuan.liao@linux.intel.com,
	broonie@kernel.org, soyer@irl.hu
Subject: Re: [PATCH v1] ALSA: hda/tas2781: Add speaker id check for ASUS
 projects
Message-ID: <ZwkG98S_wxK6xMEq@smile.fi.intel.com>
References: <20241011085303.738-1-baojun.xu@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241011085303.738-1-baojun.xu@ti.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Oct 11, 2024 at 04:53:03PM +0800, Baojun Xu wrote:
> Add speaker id check by gpio in ACPI for ASUS projects.

...

> +		scnprintf(tas_priv->coef_binaryname, 64, "TAS2XXX%04X%01d.bin",

sizeof() ?

> +			codec->core.subsystem_id & 0xffff, spk_id);

lower_16_bits() ?

...

> +		scnprintf(tas_priv->coef_binaryname, 64, "TAS2XXX%04X.bin",

Ditto.

> +			codec->core.subsystem_id & 0xffff);

Ditto.

...

> +	tas_hda->priv->speaker_id = devm_gpiod_get(tas_hda->dev, "speakerid",
> +						   GPIOD_IN);
> +	if (IS_ERR(tas_hda->priv->speaker_id))
> +		dev_info(tas_hda->dev, "Failed to get Speaker id gpio.\n");

This is wrong. If it's okay to ignore, make it optional. Either way you have to
return an error code to the caller as you effectively ignore deferred probe,
for example.

-- 
With Best Regards,
Andy Shevchenko



