Return-Path: <linux-kernel+bounces-306916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 79C14964560
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 14:53:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3476B288401
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 12:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C7BB1A76B9;
	Thu, 29 Aug 2024 12:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="catqz8nr"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 766EC1A4F2D
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 12:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724935614; cv=none; b=XSEwBRSZ6YlPUDKYxqlEEUXqAfQhw/bYVfQYT1rTe45vcjS4eq7hwhZb2qUrLtJaAS8+j9R94qkMwE4BYsTcAKQh8eZIX6uZazAtMyFCIyLE2mD1Pj3SlCiosMZICTGj8wvMQur25S+tZvCykNKRMJ//2q+WB+11J8Cl+x5JeVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724935614; c=relaxed/simple;
	bh=yjeKM474OQ8426uuB8l7lodmrn/tuBoYC21N6qPxsbk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XejphF+buAkYKv9H6ptFjs61WEz39Ix/Yh44g3vZYe98zOp0OOMYRtyis563S6sOlUFRf2DK5dH6o8HCqPOfd+GVjz90lCyKwhcgkx0bDcsOaMHF6h7Fx4Jp0lmKR+MAzwUrF7j1b1gschHL2y3EaS4/i6y0IqDNZgX//NmOsfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=catqz8nr; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724935613; x=1756471613;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yjeKM474OQ8426uuB8l7lodmrn/tuBoYC21N6qPxsbk=;
  b=catqz8nrk8UTnr1W79PMeiBxmBTQBjeAeuT6hGOieFBc8iMKOY16o9Kz
   tyv4KaUASaEzOfraLhuwJUMzstWLPIfT2PRQAybsGFMGyt8GNY0aTkgd8
   VHW2MVSiUdUgl/HoyRrQp/uqZCH4cPI2UG59XGNGXtmxUcTdTtDuNtrjO
   AfPhinrPPTApqVdKe5UsBrTOQm5HuAXcHuoMR0pCSmQHM2sLP7jBceHtZ
   xSZURvk3WE4jrXUtI5c0OudNreU3aGwHy2xNblnL2i98fah/QrN1kzeNK
   ZayVMlysnLwAuthNNsFgQHu3RnWWdVF9IvXueR3HsL33wtfLEU5sQpHrR
   Q==;
X-CSE-ConnectionGUID: Yg5IpycJT1OAAuQ+sGjimw==
X-CSE-MsgGUID: 7n7lZge8SSe3kRasOojdeg==
X-IronPort-AV: E=McAfee;i="6700,10204,11179"; a="46039241"
X-IronPort-AV: E=Sophos;i="6.10,185,1719903600"; 
   d="scan'208";a="46039241"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2024 05:46:37 -0700
X-CSE-ConnectionGUID: gS5Ul0NxR/KG1fVei/2EYw==
X-CSE-MsgGUID: c9Kmwa5cQO+Pq3uhNLVRmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,185,1719903600"; 
   d="scan'208";a="63190233"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2024 05:46:35 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1sjeXo-00000002zsd-3fpT;
	Thu, 29 Aug 2024 15:46:32 +0300
Date: Thu, 29 Aug 2024 15:46:32 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 02/10] regulator: core: Fix
 regulator_is_supported_voltage() kerneldoc return value
Message-ID: <ZtBtqPB2MgwUCsM3@smile.fi.intel.com>
References: <20240829085131.1361701-1-wenst@chromium.org>
 <20240829085131.1361701-3-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240829085131.1361701-3-wenst@chromium.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Aug 29, 2024 at 04:51:22PM +0800, Chen-Yu Tsai wrote:
> The kerneldoc for regulator_is_supported_voltage() states that the
> return value is a boolean. That is not correct, as it could return an
> error number if the check failed.
> 
> Fix the description by expanding it to cover the valid return values and
> error conditions. The description is also converted to a proper "Return"
> section.

...

> - * Returns a boolean.
> + * Return: 1 if the voltage range is supported, 0 if not, or a negative error
> + *	   number if @regulator's voltage can't be changed and voltage readback
> + *	   failed.

Not sure why you have TABs in the following lines, but I think you have checked
the rendered files (html, man, pdf) and all look good.

Alternatively it might be written as

 * Return:
 * 1 if the voltage range is supported, 0 if not, or a negative error number
 * if @regulator's voltage can't be changed and voltage readback failed.

which should be the same in the render.

(Also similar applies to the other patch(es))

-- 
With Best Regards,
Andy Shevchenko



