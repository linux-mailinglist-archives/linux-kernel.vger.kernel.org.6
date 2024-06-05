Return-Path: <linux-kernel+bounces-203191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A0618FD7A7
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 22:38:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E1752837C3
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 20:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A5C415EFC5;
	Wed,  5 Jun 2024 20:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YHRjOEXG"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EEBF15ECC4
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 20:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717619917; cv=none; b=Yxvh7Pg1ZkJzTWKjzWncSv7UyI88W24k3eMpLSydWU4UMwUCHnnp0elmimZ3BrWnmuZtWAbSKaCu43SmIjF68fpL3W//+hLCcFY3lE9qwpwX8NVwaMo93rrGq+MBb5c8C1poqcMWhkW1eaY8XtzFB/GVZ4Zkxg/aoGq6pAJi76M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717619917; c=relaxed/simple;
	bh=UtFaq9d1kpJ8DQqUoLOFUwRaQIOdIk9HC5ouR+pDKUo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WteOD9FaAP6eMdZ0r9hyqXvY5bdCiwS5Bs1AyJ7DU22W5yOtWg1f5e7iKy90+Bzg7EEfbYgPCBOO2xT+onwi8stwtdMHSNenzafrbWSbIee8VOCBYlSGDDjvhIBio0nGWOe0kpQQuCNBwJEmJzNq7cpKglVJP83OUvd6sSYXA7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YHRjOEXG; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717619917; x=1749155917;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UtFaq9d1kpJ8DQqUoLOFUwRaQIOdIk9HC5ouR+pDKUo=;
  b=YHRjOEXGgRw3aG/15PtgE9VG+MOEHEIb1xqdFOgwpxI2JUK84oLwSkid
   O5Ov5ZmyvO26xbcQb2P2DJtXVf9vCIp2UD5nUh8IUo0fsdjRVUmg7N6X4
   VkIutPab10BGOijl3qNAMMMj8foiCQvYYAU448N+FPadOJiJtiDkDL8qb
   6vVlne6zI/gjZBF+QEwylvb3P1XWwxmiqcG/SvQ4zteceWuT4rtvb7/C1
   xs055LwPl3EBwn1QCUoDrIdiPFbM+XPgiBJF4AydR6aAPWsKBLhZ7EM/a
   lsSzG/ELTC6mFov4rAPg8Go3ZNenZpVs7ZF7tBgdIpgq5wwY9aLxLXR/P
   A==;
X-CSE-ConnectionGUID: u+6TzgHBQtmSFde/FthlTQ==
X-CSE-MsgGUID: FkDVvQtLSomvD61qhVBjSQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11094"; a="17191678"
X-IronPort-AV: E=Sophos;i="6.08,217,1712646000"; 
   d="scan'208";a="17191678"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2024 13:38:36 -0700
X-CSE-ConnectionGUID: SNwQ1MAKQz6KzDWJh5pykg==
X-CSE-MsgGUID: mavzrJMCSJOZJ+DgELSarA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,217,1712646000"; 
   d="scan'208";a="37638936"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2024 13:38:34 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1sExOx-0000000DxfH-0qnG;
	Wed, 05 Jun 2024 23:38:31 +0300
Date: Wed, 5 Jun 2024 23:38:30 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH v1 1/1] drm/mipi-dbi: Add missing MODULE_DESCRIPTION()
Message-ID: <ZmDMxtDz5aq0xom6@smile.fi.intel.com>
References: <20240425125627.2275559-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240425125627.2275559-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Apr 25, 2024 at 03:56:26PM +0300, Andy Shevchenko wrote:
> The modpost script is not happy
> 
>   WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/gpu/drm/drm_mipi_dbi.o
> 
> because there is a missing module description.
> 
> Add it to the module.

Any comments on this?

-- 
With Best Regards,
Andy Shevchenko



