Return-Path: <linux-kernel+bounces-175933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D9FA8C2776
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 17:13:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3D511F23BBA
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 15:13:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 414C517109F;
	Fri, 10 May 2024 15:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SERZ1VDp"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43F5912C53F
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 15:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715353975; cv=none; b=Awu2Mk7zlZI1r6297QZ7BaZEFRP+CY9HoseQq+I0xrKTUmn1pS7xUFTyKVbQTJQfzdzvKZmza7+2a3dv4Vg9NUfg1h/LvO7XlSSbb9y31JUFatieDdNIQj8saBebWBOAwBXSiAGEXNjqeXdMceK8nZcv+5918bEJLH9GBze9DCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715353975; c=relaxed/simple;
	bh=IRB+pc4QjEmCYoDfPo7B7gkb2wYKCD7OVN0a/6SXhVg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SsM7heT+geiJtc3HIa0FeqcXHSaT6+zjaqn8seIv16Zy9fNgcQYuAITxfHb/lzhtwcTsqiZEnYZV7klvtKJZzOWq5aMnLU75iCPY6wRSaDuMNbpz1Hha/jBobrCULfC5qYuF/SBNTyxXBmaolU7jZf62DDrECdnZKZ4L4pRWSVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SERZ1VDp; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715353974; x=1746889974;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IRB+pc4QjEmCYoDfPo7B7gkb2wYKCD7OVN0a/6SXhVg=;
  b=SERZ1VDpgCN5dda8dCkg4/fsTqFA//Qd2GR0zBEZV5gu86DdZhU23/WV
   zMw70xFbB7kWLFauDHOGbBM33BdW7h/O9ShNwMVXtoAL6Nxtd9d9S1Jbn
   GDHUhLmOsSgme9JrvBT56B2GbCELEbjrcoVTUP7HlgRKLoD3MZfsE3FHM
   b2eX4cT5AqM+1phvT0z5C6s0BAZExjqSDqg3OcjPCH8AYnAeKUpQ5gbL3
   1oBUHUwMibxlmdNWuZVbYSIhb3gkrTGtkbY7YO1pdmzl23m1fQ+x4Psa7
   lm+5hLMpAJRDqozNXStJfftM5DMaIHnlgQ7NQfwcN4Qlt57H6S/QIlWvP
   A==;
X-CSE-ConnectionGUID: wcL2HXPOR6inN+hdUxRAEg==
X-CSE-MsgGUID: JGuwzlToR7G9CBxkzHiWgA==
X-IronPort-AV: E=McAfee;i="6600,9927,11068"; a="11201788"
X-IronPort-AV: E=Sophos;i="6.08,151,1712646000"; 
   d="scan'208";a="11201788"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2024 08:12:53 -0700
X-CSE-ConnectionGUID: ScQD7gxITEGKr8SJL28UfQ==
X-CSE-MsgGUID: 6GMjUwSsRR2qf6kS2BbL+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,151,1712646000"; 
   d="scan'208";a="29492945"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2024 08:12:49 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1s5RvR-000000068kM-3SGV;
	Fri, 10 May 2024 18:12:45 +0300
Date: Fri, 10 May 2024 18:12:45 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Shenghao Ding <shenghao-ding@ti.com>
Cc: broonie@kernel.org, lgirdwood@gmail.com, perex@perex.cz,
	pierre-louis.bossart@linux.intel.com, 13916275206@139.com,
	alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
	liam.r.girdwood@intel.com, bard.liao@intel.com,
	yung-chuan.liao@linux.intel.com, kevin-lu@ti.com,
	cameron.berkenpas@gmail.com, tiwai@suse.de, baojun.xu@ti.com,
	soyer@irl.hu, Baojun.Xu@fpt.com
Subject: Re: [PATCH v4 1/3] ALSA: ASoc/tas2781: Fix wrong loading calibrated
 data sequence
Message-ID: <Zj45bfx4twerXKwc@smile.fi.intel.com>
References: <20240510034123.1181-1-shenghao-ding@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240510034123.1181-1-shenghao-ding@ti.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, May 10, 2024 at 11:41:19AM +0800, Shenghao Ding wrote:
> Calibrated data will be set to default after loading DSP config params,
> which will cause speaker protection work abnormally. Reload calibrated
> data after loading DSP config params.
> 
> Fixes: ef3bcde75d06 ("ASoc: tas2781: Add tas2781 driver")

How on earth this can be a fix?..

> -// Copyright (C) 2022 - 2023 Texas Instruments Incorporated
> +// Copyright (C) 2022 - 2024 Texas Instruments Incorporated

> -#ifndef __TASDEVICE_DSP_H__
> -#define __TASDEVICE_DSP_H__
> +#ifndef __TAS2781_DSP_H__
> +#define __TAS2781_DSP_H__

> -int tasdevice_prmg_calibdata_load(void *context, int prm_no);

-- 
With Best Regards,
Andy Shevchenko



