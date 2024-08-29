Return-Path: <linux-kernel+bounces-306918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BA21964568
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 14:54:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE6EB288C70
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 12:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 942D41AD9D2;
	Thu, 29 Aug 2024 12:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dmp0/0id"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8452B1AD40F
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 12:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724935723; cv=none; b=WptkJDDxlIBmGCk8I38BHG6ZJ/VU2K9jd4Vs+3iuLN5pvl41H0A1EspEgfdsWgf/mOIUTtjtLMSE2DVCsmi53t1WU0r6v/B1njAZqleOHLWLB7JLwkXBjV5vHy33+FqUJZmd5px8Qd1oqlOGcIKh1Vpa49O9z+aFz0qAy8vh8tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724935723; c=relaxed/simple;
	bh=FX92GqaktXomeLGPydc5ejVwsNpDf+T2nmOYU+reubU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MYJ+ysoVPNdZ8pgUIKHd76QgVgvrfDi6N6zt0LVLJXUVkH3WarM9GDfcTVwNXSqmcqsm34IItFpQW58uur5Weiqz08f2FBvssAcAO6l/qAO2yMfag02SrmeGbCOqNGQs1kbIWipOadEapkPJrZZuL48onMUahL5VTt0g7UgNmn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dmp0/0id; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724935722; x=1756471722;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FX92GqaktXomeLGPydc5ejVwsNpDf+T2nmOYU+reubU=;
  b=dmp0/0idGb9ZIs9GWvRjknuW/wrkMLwG7vwhu1bx3miMqs16e8bmRtCs
   IG9eWC5HmWAePrpiU5TKQrct5g0adKPPcfFbYc5AfjU6VnlHG0wHjGYKU
   0pCPUdSnPit01+nQZQHUwaMf0XJRXp9onJer30WZv/WoADfchYfOQelEH
   ltMOsLeMBNlNKV0njYf1F8sIqcxcM2ZrFjsXL+pG9lhhZmzBeFducg/16
   zZLdeZNJSx5nadDFX/sBck+zhx+vhao6AFMsmvyLrkJYmlT0/37qMjlu1
   Teo/IElAXrf2XT3gVw5JvaiBynOhEJAZO37a745trRKm098q7UCcCL/XD
   g==;
X-CSE-ConnectionGUID: JfSgRilETn6RaBEkZv47zQ==
X-CSE-MsgGUID: jirZ/Z8HRw+5arwdImTlaQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11179"; a="34928829"
X-IronPort-AV: E=Sophos;i="6.10,185,1719903600"; 
   d="scan'208";a="34928829"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2024 05:48:41 -0700
X-CSE-ConnectionGUID: qcb6K4f3QnyBs0MZJWehEg==
X-CSE-MsgGUID: aQ1eh1D/Ttq10lKDDqjFXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,185,1719903600"; 
   d="scan'208";a="101077287"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2024 05:48:40 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1sjeZp-00000002zup-3XFd;
	Thu, 29 Aug 2024 15:48:37 +0300
Date: Thu, 29 Aug 2024 15:48:37 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 05/10] regulator: of: Fix incorrectly formatted
 kerneldoc "Return" sections
Message-ID: <ZtBuJbQozUnp6z_0@smile.fi.intel.com>
References: <20240829085131.1361701-1-wenst@chromium.org>
 <20240829085131.1361701-6-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240829085131.1361701-6-wenst@chromium.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Aug 29, 2024 at 04:51:25PM +0800, Chen-Yu Tsai wrote:
> kernel-doc complains about missing "Return" section for many documented
> functions in the regulator OF-specific code. These all have descriptions
> about the return values, just not in the format kernel-doc wants.
> 
> Convert these to use the proper "Return:" section header. The existing
> descriptions have been reworded and moved around to fit the grammar and
> formatting.

...

> - * Returns true if all conditions are met.
> + * Return: True if all conditions are met; false otherwise.

You used %NULL elsewhere, so this also can use references to the boolean
constants.

 * Return: %true if all conditions are met; %false otherwise.

-- 
With Best Regards,
Andy Shevchenko



