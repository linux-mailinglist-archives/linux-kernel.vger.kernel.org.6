Return-Path: <linux-kernel+bounces-563771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D9F28A6481E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 10:50:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D787A3B22DD
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 09:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B0FD222594;
	Mon, 17 Mar 2025 09:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="clPIzzE1"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1514082D98
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 09:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742205048; cv=none; b=gEYnpQecDaDhM0RHB3VOUMfrULTtSFk4p5sC1GomMuMOp8CSHZnXLUpSkVdZPZH/GP7tPbkHahXsyk0E0tWIAwbnOYcEvdt+1rhIcS1SU/8pIUrd1WBpSfiDHD1WsTZt17nst2k6+Q2b1xvHQu3mTgfSrEiBjY8DKDnO9Z0LsxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742205048; c=relaxed/simple;
	bh=xc2EKTgDFsTwXV1rAzwD3odDvNheT6OB0Ss/UFGv/p8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YghlOAbPq8EOhsPqWng22IoqLTvN8HE5RMrLODi84eGjiPA+W5EtSCjJDuoOVSju9ykd5/D3zpBmNCmX4oq9zMtTk5hSWFDeu6jCM9YS+mHrSpzrCWsrZJ/QSUgwb32Lun3KjOfMj8umP2qMq6Qo20uxeZXIjU/fD6Ho1n29sMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=clPIzzE1; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742205047; x=1773741047;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xc2EKTgDFsTwXV1rAzwD3odDvNheT6OB0Ss/UFGv/p8=;
  b=clPIzzE1z92EjhgxsLUCsDm0Yd/ip7EgzqFmF6S/lcs5LCaee8RMWkUE
   x/6lErA8vK3mMQTN4CCj6UCoX8hlwsQN0yaZZzFXfKIVEGIKbkHDyM73O
   SQUxpH0V8h+f2YcxGMS6I9pFTIDd8eY8LUvrIO0aPhVAkniBE0iSDlJSy
   WydYtKsZ78NgmFewMPV8668GmTYbbGxp3Ucg0VyDC/KVUGau45w8eQkAv
   1g3sY4qaap44tg6j7422QnCPe9rHgxM3Ioyral3aykFTm9f/+mPgKHSob
   +l8+EV7MWIYwDNksPlQ+bhvARWmP++pv2hBhghT1YlOB2k/h/emQvyfdM
   g==;
X-CSE-ConnectionGUID: ECGLm1t5Tn2hsQ1qvK2YGg==
X-CSE-MsgGUID: 8zsOvMVkSeKhyx05SGsY3Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11375"; a="47187033"
X-IronPort-AV: E=Sophos;i="6.14,253,1736841600"; 
   d="scan'208";a="47187033"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2025 02:50:47 -0700
X-CSE-ConnectionGUID: Qi01J1/6SMC41SoM56fgMg==
X-CSE-MsgGUID: R6d5HApERyqDZ/uNkHIwXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,253,1736841600"; 
   d="scan'208";a="126553607"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2025 02:50:45 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tu77L-00000003GtB-0cgG;
	Mon, 17 Mar 2025 11:50:43 +0200
Date: Mon, 17 Mar 2025 11:50:42 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v1 1/1] resource: Split DEFINE_RES_NAMED_DESC() out of
 DEFINE_RES_NAMED()
Message-ID: <Z9fwciozfh7JK4BC@smile.fi.intel.com>
References: <20250313160940.414931-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250313160940.414931-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

+Cc: Andrew.

Andrew, olease, tell me if you want a resend as I just noticed that the header
is orphaned.

Arnd, do we have any plans to have a record in MAINTAINERS for the (currently
orphaned) headers?

On Thu, Mar 13, 2025 at 06:09:40PM +0200, Andy Shevchenko wrote:
> In some cases it would be useful to supply predefined descriptor
> of the resource. For this, introduce DEFINE_RES_NAMED_DESC() macro.
> 
> While at it, provide DEFINE_RES() that takes only start, size,
> and flags.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  include/linux/ioport.h | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/ioport.h b/include/linux/ioport.h
> index f437502224cd..a740aebc372d 100644
> --- a/include/linux/ioport.h
> +++ b/include/linux/ioport.h
> @@ -157,15 +157,20 @@ enum {
>  };
>  
>  /* helpers to define resources */
> -#define DEFINE_RES_NAMED(_start, _size, _name, _flags)			\
> +#define DEFINE_RES_NAMED_DESC(_start, _size, _name, _flags, _desc)	\
>  (struct resource) {							\
>  		.start = (_start),					\
>  		.end = (_start) + (_size) - 1,				\
>  		.name = (_name),					\
>  		.flags = (_flags),					\
> -		.desc = IORES_DESC_NONE,				\
> +		.desc = (_desc),					\
>  	}
>  
> +#define DEFINE_RES_NAMED(_start, _size, _name, _flags)			\
> +	DEFINE_RES_NAMED_DESC(_start, _size, _name, _flags, IORES_DESC_NONE)
> +#define DEFINE_RES(_start, _size, _flags)				\
> +	DEFINE_RES_NAMED(_start, _size, NULL, _flags)
> +
>  #define DEFINE_RES_IO_NAMED(_start, _size, _name)			\
>  	DEFINE_RES_NAMED((_start), (_size), (_name), IORESOURCE_IO)
>  #define DEFINE_RES_IO(_start, _size)					\

-- 
With Best Regards,
Andy Shevchenko



