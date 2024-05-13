Return-Path: <linux-kernel+bounces-177430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 870D08C3E7B
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 11:59:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 09BC9B21A38
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 09:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8D70148FEA;
	Mon, 13 May 2024 09:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WVFNpvx4"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E41148833
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 09:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715594344; cv=none; b=HNkpI0+WFKxV5cqh4oUEwcDgM83SxzXMz+5AoPCWfVu3BcIZY/hwIMsDwlxZ0zvkc5QrDnlx+5mINm/g6Ct4IzJ/N7F/DStVrVyV95p2EpZwe7H2O3gdJsjwSJnkaCk1b45l6hFpNyB8iR67FCrsX42JFj6p4+j85/jPFdckB90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715594344; c=relaxed/simple;
	bh=ankU08gSvLs7z5PjJH2l/JvZZTP/EIbvoooq0j5B/0s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r31vGvRKPzTxcRRcRBNrIDGYGZ+IFVxeswdCeG94nvW4afO7lToUFuo22QGLSBWuD0h7VhY7i2zeZL4rEwjQ6YUmHfNpsoh7MyDvMCieEPFAc6U2JRfszSLqLAqvziia4VJcvsaS335/W+JqA0rt/irOyciuA6o9UNjHjfXD1Ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WVFNpvx4; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715594343; x=1747130343;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ankU08gSvLs7z5PjJH2l/JvZZTP/EIbvoooq0j5B/0s=;
  b=WVFNpvx4laP56NePZ9n+InmE5ptujQgs7iO8M8Q8Y1kYsP91j4GPkF2/
   3kRV91EKWm8h3eeF1qcAl/z1AGdz8B7Yn4HrdPcXXq4lOQxOFeDF4Nx2l
   i3QoAcTLMOfuWicFMgB5musQUZglKo09+BpPd0VDfsJbbmEFNLB6KRcVI
   fMZnMYUVtrPqIUmjvNVEDH6B1znAMpe7l1wwE/1NNtljV8hoXudthZ+n9
   BH9NSMxsoBIc1TAEQmKF/cdsguHWRctZj27RGzUhlyljDLDDrL3b7agXl
   HBy5MwBak9uPP2sm/ovGRv6lnJ374nTF3aqQ1qJyLWctO2hKtBD5cAZnU
   A==;
X-CSE-ConnectionGUID: x07EEC4MT/e78J0reyXKWA==
X-CSE-MsgGUID: yZEfYUQyTFm1cqcZ7T8TGw==
X-IronPort-AV: E=McAfee;i="6600,9927,11071"; a="15355327"
X-IronPort-AV: E=Sophos;i="6.08,158,1712646000"; 
   d="scan'208";a="15355327"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2024 02:59:02 -0700
X-CSE-ConnectionGUID: nNf+vrqtRyyToNxv2M9oWA==
X-CSE-MsgGUID: EahDSCLJRKS0nA4a6GTXQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,158,1712646000"; 
   d="scan'208";a="30702672"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2024 02:58:57 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1s6SSM-000000074o7-14V8;
	Mon, 13 May 2024 12:58:54 +0300
Date: Mon, 13 May 2024 12:58:53 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Shenghao Ding <shenghao-ding@ti.com>
Cc: broonie@kernel.org, lgirdwood@gmail.com, perex@perex.cz,
	pierre-louis.bossart@linux.intel.com, 13916275206@139.com,
	alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
	liam.r.girdwood@intel.com, bard.liao@intel.com,
	yung-chuan.liao@linux.intel.com, kevin-lu@ti.com,
	cameron.berkenpas@gmail.com, tiwai@suse.de, baojun.xu@ti.com,
	soyer@irl.hu, Baojun.Xu@fpt.com
Subject: Re: [PATCH v5 1/3] ASoC: tas2781: Fix wrong loading calibrated data
 sequence
Message-ID: <ZkHkXYCpkuWzgZgR@smile.fi.intel.com>
References: <20240512025040.1276-1-shenghao-ding@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240512025040.1276-1-shenghao-ding@ti.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Sun, May 12, 2024 at 10:50:37AM +0800, Shenghao Ding wrote:
> Remove declaration of unused API which load calibrated data in wrong
> sequence, changed the copyright year and correct file name in license
> header.

> -int tasdevice_prmg_calibdata_load(void *context, int prm_no);

This is still being used in two files. How won't this break the build?

-- 
With Best Regards,
Andy Shevchenko



