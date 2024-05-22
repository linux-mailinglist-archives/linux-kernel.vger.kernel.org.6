Return-Path: <linux-kernel+bounces-187536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 804438CD31F
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 15:03:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34EB6283DC5
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 13:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A53E14A4DF;
	Thu, 23 May 2024 13:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W2Z8X5kc"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E8E114A0A7
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 13:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716469415; cv=none; b=AaVPDy2pX8o+6E3NF6+KN4BPcTJ8anrGnwygT6zb/p5ZXYmxvMQzxMhB20XZW4GC4o9prUqpL7nayGU5mgLVQJVAT+ynpvDC/CTU4HAxATQkCzOi10fwRsTGHN/ihV43osbOXgfWxTdFAZPX4YFZsgdUGFmd3DKgk1gNAXtLV/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716469415; c=relaxed/simple;
	bh=YMmJlwEO6z/2N4gfb/N1NI+yIAQXzLQrbPEn8oT4pI4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EDD/gdIw2xBUYTPuB5AbA443+XAwtWfH8XNMMvxl9R1UVBOfqxVsNZc21Ff0C7XYqTrUZBWN2KftFvKubZ4ET+6TY+JkCY5XnhQmv6YXsuy9B/Wkp23c+WTOuXAgXolXuoi2s8VP3lPFJZuK6JF7JWELSF7gx4tqLchxqKgAHyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W2Z8X5kc; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716469415; x=1748005415;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=YMmJlwEO6z/2N4gfb/N1NI+yIAQXzLQrbPEn8oT4pI4=;
  b=W2Z8X5kcrRs5j1NJt1NfP5tZhYvwg21BRTmcuBiwbQHiL0lyBjpDsWSH
   KnBmT7z4SLIy+MTU5dnG5BR+bL9n5iYRAd0vrENhNAszfOMVj6sJcSAEM
   vmYZZsj0puCQFPniqGbimKW8peNCwe9xWlJxs+CZrRwzR0I8APugCdM1D
   7PVY6iYbJ0MsCeuuIumnpVBmxLS8mIqMjmZEJUBH3EbbFjqUeUbaE1y7w
   adTiWY+QD9npzUXNldez2lHbIH8vPfEQnFNvKtkjCeitlPNLIEbhYYH30
   9kyLocqLcQr+k3JFJ3kOtuCsg13gyaKLCHbZUxgd1nsK9XbKwLsXoj/RU
   A==;
X-CSE-ConnectionGUID: OmpZGqZeTCq3pbLFN2a8ig==
X-CSE-MsgGUID: U8EGsNuwQy+D9lmi259Oag==
X-IronPort-AV: E=McAfee;i="6600,9927,11081"; a="12632736"
X-IronPort-AV: E=Sophos;i="6.08,182,1712646000"; 
   d="scan'208";a="12632736"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2024 06:03:34 -0700
X-CSE-ConnectionGUID: 7ZpvCSp4QXCbrj5RfMdAuA==
X-CSE-MsgGUID: mPnkKae6STypwEWjPV8wCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,182,1712646000"; 
   d="scan'208";a="33550442"
Received: from unknown (HELO [10.125.110.41]) ([10.125.110.41])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2024 06:03:32 -0700
Message-ID: <9dd05175-a5a4-409e-88aa-4a3d5800724d@linux.intel.com>
Date: Wed, 22 May 2024 08:40:26 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] ASoc: tas2781: Add Calibration Kcontrols and tas2563
 digtial gain for Chromebook
To: Shenghao Ding <shenghao-ding@ti.com>, broonie@kernel.org
Cc: andriy.shevchenko@linux.intel.com, lgirdwood@gmail.com, perex@perex.cz,
 13916275206@139.com, judyhsiao@google.com, alsa-devel@alsa-project.org,
 i-salazar@ti.com, linux-kernel@vger.kernel.org, j-chadha@ti.com,
 liam.r.girdwood@intel.com, bard.liao@intel.com,
 yung-chuan.liao@linux.intel.com, dipa@ti.com, kevin-lu@ti.com,
 yuhsuan@google.com, tiwai@suse.de, baojun.xu@ti.com, soyer@irl.hu,
 Baojun.Xu@fpt.com, navada@ti.com, cujomalainey@google.com, aanya@ti.com,
 nayeem.mahmud@ti.com
References: <20240522112942.994-1-shenghao-ding@ti.com>
Content-Language: en-US
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20240522112942.994-1-shenghao-ding@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



Could you move this sort of renaming/editing to a first patch?

>  /*Software Reset */
> -#define TAS2781_REG_SWRESET		TASDEVICE_REG(0x0, 0X0, 0x01)
> -#define TAS2781_REG_SWRESET_RESET	BIT(0)
> +#define TASDEVICE_REG_SWRESET		TASDEVICE_REG(0x00, 0X00, 0x01)
> +#define TASDEVICE_REG_SWRESET_RESET	BIT(0)

> -// tas2781-lib.c -- TAS2781 Common functions for HDA and ASoC Audio drivers
> +// tas2781-comlib.c -- TAS2781 Common functions for HDA and ASoC Audio drivers
>  //
> -// Copyright 2023 Texas Instruments, Inc.
> +// Copyright 2023 - 2024 Texas Instruments, Inc.

> @@ -254,8 +281,8 @@ void tas2781_reset(struct tasdevice_priv *tas_dev)
>  	} else {
>  		for (i = 0; i < tas_dev->ndev; i++) {
>  			ret = tasdevice_dev_write(tas_dev, i,
> -				TAS2781_REG_SWRESET,
> -				TAS2781_REG_SWRESET_RESET);
> +				TASDEVICE_REG_SWRESET,
> +				TASDEVICE_REG_SWRESET_RESET);

> @@ -591,8 +1470,8 @@ static const struct snd_soc_component_driver
>  	soc_codec_driver_tasdevice = {
>  	.probe			= tasdevice_codec_probe,
>  	.remove			= tasdevice_codec_remove,
> -	.controls		= tas2781_snd_controls,
> -	.num_controls		= ARRAY_SIZE(tas2781_snd_controls),
> +	.controls		= tasdevice_snd_controls,
> +	.num_controls		= ARRAY_SIZE(tasdevice_snd_controls),
>  	.dapm_widgets		= tasdevice_dapm_widgets,
>  	.num_dapm_widgets	= ARRAY_SIZE(tasdevice_dapm_widgets),
>  	.dapm_routes		= tasdevice_audio_map,

And then add functional changes in a second patch? It'd be simpler to
review really...

