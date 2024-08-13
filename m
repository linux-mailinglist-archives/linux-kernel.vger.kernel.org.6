Return-Path: <linux-kernel+bounces-284314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 32E5594FFC0
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 10:24:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9A4A1F2168A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 08:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D80CE175D3D;
	Tue, 13 Aug 2024 08:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IdH89Cm9"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E389414F9EF
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 08:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723537415; cv=none; b=jc13CM9Of6+Gos1LuMbCmmCFGxSXIq3T5OQ+zP449JO9VpGFCseSNgya298z+4380LtaN599iLTp4snYWNKhw60OSTlzufKYJ7MNdruNvp4TD62DTSpXjkap0evNErmXW4DEJ9xrELfioLrk5JtwgHh7q30/l/wjgE0U4Oje7fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723537415; c=relaxed/simple;
	bh=o6OmeuKsL9pDus+iBeUhP02BPehZcWu18YM9dAEDlVM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A5yoP+rNoJVUjo6UXZrLOjPIymaSCfVNJwJX/4haXpyu1LYrvxl/82FQgfnXoxPj9O8XATon0pi6lnS0cuiwHyheaP3VxX0HlWvNI0gD2PUY4bmn77/omEffISN2kgKwRLVY091O/LRkgyy+VY8maW7wiLkco0y8HSiJoGeD6EQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IdH89Cm9; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723537414; x=1755073414;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=o6OmeuKsL9pDus+iBeUhP02BPehZcWu18YM9dAEDlVM=;
  b=IdH89Cm9TvIX3NSiv+mQjPOXLWSj+LTyBVAtxU9hjAz9Sr1mG8N5fzP2
   3/ztIOrKCC5vnXu7fV4EPF9znpBk+8O7WDwcPDeWhurQ1UvSu3tkPQ6PC
   JeIHbdbU5PfyrQ9vU0WOFPLcG3jg96besP4lfl3sSBTSjOu5AeE2Ba5kg
   kf7wfPAyQox7OXNTSnQzf0S4EVXaDZnA29ElCT8gYWyiv1NgAk7iv/m+9
   yY/SeLOy4ZpdJ4EhGfOW8/rl8TiqDt5Lrogp4hzBFFW1188+6oj/py12T
   xaowlQdpejk9espxHmRf/wTrbeF7wQOSCifDVhpASbtyNnGdJ34XuNyiw
   Q==;
X-CSE-ConnectionGUID: 9Rc5ykkeR7igUxwWDJy90w==
X-CSE-MsgGUID: 9eHlHaANSeaEobIAcHWFfQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11162"; a="21553631"
X-IronPort-AV: E=Sophos;i="6.09,285,1716274800"; 
   d="scan'208";a="21553631"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2024 01:23:33 -0700
X-CSE-ConnectionGUID: k4lzmBiNTcWZlLh4mvx9Rw==
X-CSE-MsgGUID: qnhV2EIeRqCcopm89Krc4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,285,1716274800"; 
   d="scan'208";a="58520574"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2024 01:23:30 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1sdmoQ-0000000EeqR-1GSO;
	Tue, 13 Aug 2024 11:23:26 +0300
Date: Tue, 13 Aug 2024 11:23:26 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Shenghao Ding <shenghao-ding@ti.com>
Cc: broonie@kernel.org, lgirdwood@gmail.com, perex@perex.cz,
	pierre-louis.bossart@linux.intel.com, 13564923607@139.com,
	alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
	liam.r.girdwood@intel.com, cameron.berkenpas@gmail.com,
	tiwai@suse.de, baojun.xu@ti.com, soyer@irl.hu, Baojun.Xu@fpt.com,
	robinchen@ti.com
Subject: Re: [PATCH v2] ALSA: ASoC/tas2781: fix wrong calibrated data order
Message-ID: <ZrsX_ry6bgDZB6bB@smile.fi.intel.com>
References: <20240813043749.108-1-shenghao-ding@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240813043749.108-1-shenghao-ding@ti.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Aug 13, 2024 at 12:37:48PM +0800, Shenghao Ding wrote:
> From: Baojun Xu <baojun.xu@ti.com>
> 
> Wrong calibration data order cause sound too low in some device.
> Fix wrong calibrated data order, add calibration data converssion
> by get_unaligned_be32() after reading from UEFI.

...

>  			rc = tasdevice_dev_bulk_write(tas_priv, i,
>  				TASDEVICE_REG(0, page_array[j], rgno_array[j]),
> -				&(data[4 * j]), 4);
> +				(unsigned char *)&data, 4);

Casting is not needed if the helper is written in a way how regmap IO accessors
done.

In any case, 4 is sizeof(data)

> +			offset += 4;

Ditto.

-- 
With Best Regards,
Andy Shevchenko



