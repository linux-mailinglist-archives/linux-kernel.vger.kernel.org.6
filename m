Return-Path: <linux-kernel+bounces-281112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08CEA94D33A
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 17:18:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B76B12819CD
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 15:18:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66FF5197A76;
	Fri,  9 Aug 2024 15:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AH5H9yyQ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5358812B71
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 15:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723216679; cv=none; b=gR22Gn0NUmlm1Gv7QkU1iWxMFaM1vwGvXU9/gjVmpGd7KshXZ2o9dbw5cZBuklZxbxrYqXU7xO+/tbDngyQOKNlSkoFrgy6u/IxxjjMM+2tbogOLDAZ4kq3Dl0tNxWV9LTF7WcvJJZ7DhFDp1oTizfF9S9udi5UdBXNr9GjxISE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723216679; c=relaxed/simple;
	bh=6AqbC+HU4YQ2LAJOxXnEAW/+2QcWo16Jjv40Zr+G2ic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D/aMdjjlgtymiFybYKzOv/20gdoqEaMXUAbhZqSMYrSl0KMLcNBT8INHITXXd1BUMlGpdvIAAiVYsaNXW2xNKqWlj6oQLWTq3obQ80rGND+QdrR1AQzUz3cfj94ogVwhvkQlDPMcNPfcM7dh6gKg/iUUG0Qo/So+hBRinvkhAXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AH5H9yyQ; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723216678; x=1754752678;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6AqbC+HU4YQ2LAJOxXnEAW/+2QcWo16Jjv40Zr+G2ic=;
  b=AH5H9yyQlv6KeQS1rKNm9sxsP122xPjOH1JMpkqmYyu7MSIZlG5P0KUi
   My+Xn2Q1HBSo4IxMYxrubRNXySQNDHom7AIe7bgpw+jwZS+0JLvWpbJWz
   1fYZJu93zYQaZZE6Icufa+tT86rD0TLy1DTT1idQskzfOPgwxtsLWM2sW
   sexJ+TQbsheMbF24VicLYSaVssM1SbusMLwPWY3oCwahA/ytbQd8d6zfD
   jR59I7gSWULTl2+JiW7QNfD+MSOOWv5zIUXVyLgBxARzT6u77ojd8BoD2
   iEBLSjsCnP7xV8djBlh/vS7e7QCaVqcpDg18BS3mPvA3JjdSze/R6VWEH
   w==;
X-CSE-ConnectionGUID: DYMv+3E+SiqKHUT36FQ5zA==
X-CSE-MsgGUID: hAznOO2lSVWhM7kgZxMrIg==
X-IronPort-AV: E=McAfee;i="6700,10204,11159"; a="38899780"
X-IronPort-AV: E=Sophos;i="6.09,276,1716274800"; 
   d="scan'208";a="38899780"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2024 08:17:57 -0700
X-CSE-ConnectionGUID: 1ZdI463DT5yFGavFpXhXCg==
X-CSE-MsgGUID: VbYX1t7MTqGnHCVcT/gqjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,276,1716274800"; 
   d="scan'208";a="88233745"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2024 08:17:49 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1scRNB-0000000DSBD-3BY5;
	Fri, 09 Aug 2024 18:17:45 +0300
Date: Fri, 9 Aug 2024 18:17:45 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Shenghao Ding <shenghao-ding@ti.com>
Cc: broonie@kernel.org, lgirdwood@gmail.com, perex@perex.cz,
	pierre-louis.bossart@linux.intel.com, 13916275206@139.com,
	zhourui@huaqin.com, alsa-devel@alsa-project.org, i-salazar@ti.com,
	linux-kernel@vger.kernel.org, j-chadha@ti.com,
	liam.r.girdwood@intel.com, jaden-yue@ti.com,
	yung-chuan.liao@linux.intel.com, dipa@ti.com, yuhsuan@google.com,
	henry.lo@ti.com, tiwai@suse.de, baojun.xu@ti.com, soyer@irl.hu,
	Baojun.Xu@fpt.com, judyhsiao@google.com, navada@ti.com,
	cujomalainey@google.com, aanya@ti.com, nayeem.mahmud@ti.com,
	savyasanchi.shukla@netradyne.com, flaviopr@microsoft.com,
	jesse-ji@ti.com, darren.ye@mediatek.com
Subject: Re: [PATCH v1] ASoc: tas2781: Add new Kontrol to set tas2563 digital
 gain
Message-ID: <ZrYzGWQRdsTlYxQg@smile.fi.intel.com>
References: <20240628041844.1776-1-shenghao-ding@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240628041844.1776-1-shenghao-ding@ti.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Jun 28, 2024 at 12:18:43PM +0800, Shenghao Ding wrote:
> Requriment from customer to add new kcontrol to set tas2563 digital gain
> and set "Speaker Force Firmware Load" as the common kcontrol for both
> tas27871 and tas2563.

...

>  #include <sound/tas2781.h>
>  #include <sound/tlv.h>
>  #include <sound/tas2781-tlv.h>

> +#include <asm/unaligned.h>

Before sound would be better, but I'm not insisting.

...

> +	ret =  tasdevice_dev_bulk_read(tas_dev, 0, reg, data, 4);

Too many spaces.

...

> +	/* find out the member same as or closer to the current volume */
> +	ucontrol->value.integer.value[0] =
> +		abs(target - ar_l) <= abs(target - ar_r) ? l : r;

Why do you need to have target to be applied here? IIUC arithmetics correctly
it makes no value to use target in this equation.

...

> +out:
> +	mutex_unlock(&tas_dev->codec_lock);

Why not using cleanup.h?

> +	return 0;

...

This all reminds me that I already gave same/similar comments in the past...


-- 
With Best Regards,
Andy Shevchenko



