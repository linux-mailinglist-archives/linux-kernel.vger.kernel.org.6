Return-Path: <linux-kernel+bounces-177431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A2D0E8C3E7D
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 12:00:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D35F11C2147B
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 09:59:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 619BF148FE9;
	Mon, 13 May 2024 09:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DbhCT4xF"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5258C147C8F
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 09:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715594392; cv=none; b=QuTNUmWdNbymI/d+vxHE5q71EpCMTV4Jw0qNhtNBaixQb8R39hACeq9Ep98iGiBNtdUGfVcY0IOMscG+c438nopAWEju4UZcbIA2U/BECOd4jzH2dXzksyPzydiow5ZwBKWQK7x5EbJfOJABO0RE+SC7kMPMBLKdyynejY8P/WA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715594392; c=relaxed/simple;
	bh=eC5slO7yGLc+RIm/m+uLfz8QHF9LGtyOPUjwCiEnrHc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s94Stdlv7vAVM9nG3qYncc/J8kibg4KpxBeH9VdO6lYnJMLQKlmUr4RLTmcykK0B0zqgi7m58eOoaBAxlp6dYBdyXw6TarlSYLcDkaDa/HujARvtj0UED8PnYzPDHEW5lUv6Nvjl2hnvGWi09JEECGlDDAIk8EAlazV+lsEqizM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DbhCT4xF; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715594392; x=1747130392;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=eC5slO7yGLc+RIm/m+uLfz8QHF9LGtyOPUjwCiEnrHc=;
  b=DbhCT4xF9Sye16BWXy+vOvK851h+pVrGr9RQSx6QJpKuWIbWauwPnmFe
   57i1RZBPUMwjIaR3AqmOxYk2Tj5/4yTc/fLGhE8J5IeVh46W9eGHdCAFJ
   EWLV68zTGeKEdXAQdSlicXtOpv8yfikauh+LAXrPRuSo/xDOdGCULK92k
   KHqx/jGLGCaNg5H1JUgqXSoA1G5t+DI/DuKKbhVlUADurgNv0axd/xSzS
   5aLiTa/NUzxUDsZ/VM7hmzOMr9vJ6l5tdqxA8WcjJAZVMDsbkWLglIvfJ
   W2LTaV4kjtAA0lRtqR5GWyNNe22h9gsMcIYs2TQMnl8kW00eLomzshTwL
   g==;
X-CSE-ConnectionGUID: npjHwor1T7aMRZs94BYLOA==
X-CSE-MsgGUID: k6LEpGoTSkeD19ugVj/N2Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11071"; a="15313864"
X-IronPort-AV: E=Sophos;i="6.08,158,1712646000"; 
   d="scan'208";a="15313864"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2024 02:59:51 -0700
X-CSE-ConnectionGUID: s6BMTyaxQNaKJhqhJLqVuQ==
X-CSE-MsgGUID: B2wmIDwJS6GyTEVTXWp/tA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,158,1712646000"; 
   d="scan'208";a="35158811"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2024 02:59:46 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1s6ST9-000000074pD-0Ajy;
	Mon, 13 May 2024 12:59:43 +0300
Date: Mon, 13 May 2024 12:59:42 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Shenghao Ding <shenghao-ding@ti.com>
Cc: broonie@kernel.org, lgirdwood@gmail.com, perex@perex.cz,
	pierre-louis.bossart@linux.intel.com, 13916275206@139.com,
	alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
	liam.r.girdwood@intel.com, bard.liao@intel.com,
	yung-chuan.liao@linux.intel.com, kevin-lu@ti.com,
	cameron.berkenpas@gmail.com, tiwai@suse.de, baojun.xu@ti.com,
	soyer@irl.hu, Baojun.Xu@fpt.com
Subject: Re: [PATCH v5 2/3] ASoC: tas2781: Fix wrong loading calibrated data
 sequence
Message-ID: <ZkHkjhxIZ8I0s3-D@smile.fi.intel.com>
References: <20240512025040.1276-1-shenghao-ding@ti.com>
 <20240512025040.1276-2-shenghao-ding@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240512025040.1276-2-shenghao-ding@ti.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Sun, May 12, 2024 at 10:50:38AM +0800, Shenghao Ding wrote:
> Calibrated data will be set to default after loading DSP config params,
> which will cause speaker protection work abnormally. Reload calibrated
> data after loading DSP config params.

..

> -int tasdevice_prmg_calibdata_load(void *context, int prm_no)

> -EXPORT_SYMBOL_NS_GPL(tasdevice_prmg_calibdata_load,
> -	SND_SOC_TAS2781_FMWLIB);

AFAICS the i2c glue driver still uses this, how can't this break the build?

-- 
With Best Regards,
Andy Shevchenko



