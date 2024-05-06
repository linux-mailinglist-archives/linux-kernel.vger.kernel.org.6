Return-Path: <linux-kernel+bounces-169538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 97C558BCA15
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 10:55:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 526C928153C
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 08:55:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 124961422C4;
	Mon,  6 May 2024 08:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZTpzYadX"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC071420D1
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 08:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714985698; cv=none; b=dirwfOnR0Ik4R0hu80tO3rudxo0l/12uOpuV6rkXi7DLyFITVWzItWB6A+1F2bav5sbqHP0jS03yPX/fqPrjW+PzO7lDHwI4h+aPRo9GQbDQFIHbyLy1dYIhaGeOKIkvMvjAaoVZ/sn7zJ/LG0OSFXqA8jA3qb+JepX6z3aa+IU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714985698; c=relaxed/simple;
	bh=kLXepkGz2uLMYrQ6dyRebaRkz/kAt5RBr6pMLIinx44=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vDKD3s8sBNnVHjyCWHMfgM4M5x+ptBsNSHfCQpC4caf5WUy8w5x333MnYRYNUCTUjN/6kqUGVdc0Wzk0kbLSxoGYRFDH7MIan2/OtQheOJHwUmXe23nVtnoq1NMQfsvZhZZJFaafWQDfWfKkHLmQmUtYCywTe0tmAQIqVWXr9Ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZTpzYadX; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714985698; x=1746521698;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kLXepkGz2uLMYrQ6dyRebaRkz/kAt5RBr6pMLIinx44=;
  b=ZTpzYadXwP73qL6fkrzEOuUzNPJElpzk9YEl+bbH33UEFh+42vdjn8zx
   lue41GBf+dpxUXAEqQs4tkIea2P4T3FGydIo6Tz6qT46/ZdXj1ZFB/PTD
   tCawd396y3hOeVMRdnaWGttxMqnNIKUchzVi3NBqfS//FM4wAkTZzP7WU
   I7T9YW5XpqovUuG0CG97h241slj8amxKz9TKy+v1yDznD4DlTsVlLTxLk
   MGdjMaZjz51ylc/dkz12bjsbOLJaoNPyumGTapQusBmfD/yLbEwhvYjbH
   upVa80ByTVvMqGfTCfFmj5hVXUzZ+HZJ2lEWlIZOS8ZKjuBJ9JU3FPASl
   w==;
X-CSE-ConnectionGUID: xnw32FaNQVyKcpwplF8IyA==
X-CSE-MsgGUID: qVPXIBHBSFu+XwZZn13GWQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11064"; a="14506468"
X-IronPort-AV: E=Sophos;i="6.07,257,1708416000"; 
   d="scan'208";a="14506468"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2024 01:54:57 -0700
X-CSE-ConnectionGUID: JTNl4onvTMuZBXzq0/gDfg==
X-CSE-MsgGUID: FTDo8FpkTTmAgyhZOEDh0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,257,1708416000"; 
   d="scan'208";a="28055269"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2024 01:54:54 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1s3u7V-00000004cH4-0rqU;
	Mon, 06 May 2024 11:54:49 +0300
Date: Mon, 6 May 2024 11:54:48 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Shenghao Ding <shenghao-ding@ti.com>
Cc: broonie@kernel.org, lgirdwood@gmail.com, perex@perex.cz,
	pierre-louis.bossart@linux.intel.com, 13916275206@139.com,
	alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
	liam.r.girdwood@intel.com, bard.liao@intel.com,
	yung-chuan.liao@linux.intel.com, kevin-lu@ti.com,
	cameron.berkenpas@gmail.com, tiwai@suse.de, baojun.xu@ti.com,
	soyer@irl.hu, Baojun.Xu@fpt.com
Subject: Re: [PATCH v2] ASoC: tas2781: Fix a warning reported by robot kernel
 test
Message-ID: <Zjia2LOnSk1H2zmK@smile.fi.intel.com>
References: <20240505122346.1326-1-shenghao-ding@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240505122346.1326-1-shenghao-ding@ti.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Sun, May 05, 2024 at 08:23:45PM +0800, Shenghao Ding wrote:
> Fix a warning reported by robot kernel test that 'fw_entry' in function
> 'tas2781_load_calibration' is used uninitialized with compiler
> sh4-linux-gcc (GCC) 13.2.0, an update of copyright and a correction of the
> comments.

..

> -// tasdevice-fmw.c -- TASDEVICE firmware support
> +// tas2781-fmwlib.c -- TASDEVICE firmware support

Exactly a good example why the filename shouldn't be in the file.
Please, remove it completely.

-- 
With Best Regards,
Andy Shevchenko



