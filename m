Return-Path: <linux-kernel+bounces-298965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D12B095CE5B
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 15:48:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79B3E1F252E1
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 13:48:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B995A1DFE8;
	Fri, 23 Aug 2024 13:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FUJGztjL"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C12A188586
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 13:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724420935; cv=none; b=qXcCin2BCQPbBEF/9ezmKC7KtBh5iI7YZkwGZKgS6AVJpAbsiIwnPBLw89M1u6TXd5zKlkeAJ9aUWlbGUKuNjVNnCtjAou0Ri4C3mutq2QyOqd7t0DgCuGQvIJWS8qKcdUTfAsm/ZfhkEceGw5JstJBfLAO1Nv3roh/IWtA8fBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724420935; c=relaxed/simple;
	bh=Ym08cutI5xEzCEv/yynu0Y9cHmBRT00cN4KOxX6TVJg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b/2/NaZCgKfksKjxNa5UtrNBt93pAYdafMtAcVj4+CgiUxPXEyy4GWhetA1QdyqmyP3DmQiJk446Sv20Pr39Wtnb01ZzGKXoSEfvrZHNTP1z4Aiyh1XYjKwtTSIx8EN4WszTBpeRx3TJUH8tLlTd6krUjBRc6C9s5bhUwU2g9zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FUJGztjL; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724420933; x=1755956933;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Ym08cutI5xEzCEv/yynu0Y9cHmBRT00cN4KOxX6TVJg=;
  b=FUJGztjLyhGNwFRA7FqCU6v4zdiQ+H5QYzYvusxQzfCagFBL5H7fov2j
   IhjzWD+ZI0gv2wWl0E1xSJJLMfIOsf77wJSrSqnkm7CUuQ41RiXS1xdVs
   KWCgD6duCIf2atMWYrWCDAIKOXHFlr+jKU1QS2XaU02pq6DKTQteqq2fl
   WImq8fQbDNfrwS//eafMutpSvBVS3EC4N9WKdUFnX+H6gaNB0K94RVLAw
   Zfa6OpifopHv/A5neVibRTS11UQwyG3FGwx0z6Hy0HSsG9v/7NwwYc36b
   8n9ZVu3mODDuQVczC6FFfTLHUT5bgYvp3qHzSzxgpB+m2jiwJlvBBGXQo
   A==;
X-CSE-ConnectionGUID: gCZQ3agTSF+iNnBT0ZKvgw==
X-CSE-MsgGUID: c2+SWGdJTEy5GszCN9tolw==
X-IronPort-AV: E=McAfee;i="6700,10204,11172"; a="22752810"
X-IronPort-AV: E=Sophos;i="6.10,170,1719903600"; 
   d="scan'208";a="22752810"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2024 06:48:53 -0700
X-CSE-ConnectionGUID: FxHibKbjT+S4KOjPU6mnIw==
X-CSE-MsgGUID: f+81n/SQQ9WvPNyrFRjjLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,170,1719903600"; 
   d="scan'208";a="61804479"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2024 06:48:50 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1shUel-00000000oGQ-16uV;
	Fri, 23 Aug 2024 16:48:47 +0300
Date: Fri, 23 Aug 2024 16:48:46 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Kunwu Chan <kunwu.chan@linux.dev>
Cc: linux@armlinux.org.uk, krzk@kernel.org, andi.shyti@kernel.org,
	robh@kernel.org, gregkh@linuxfoundation.org, suzuki.poulose@arm.com,
	rmk+kernel@armlinux.org.uk, linux-kernel@vger.kernel.org,
	Kunwu Chan <chentao@kylinos.cn>
Subject: Re: [PATCH] amba: make amba_bustype constant
Message-ID: <ZsiTPjtnZZIW-K4k@smile.fi.intel.com>
References: <20240823064203.119284-1-kunwu.chan@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240823064203.119284-1-kunwu.chan@linux.dev>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Aug 23, 2024 at 02:42:03PM +0800, Kunwu Chan wrote:
> From: Kunwu Chan <chentao@kylinos.cn>
> 
> Since commit d492cc2573a0 ("driver core: device.h: make struct
> bus_type a const *"), the driver core can properly handle constant
> struct bus_type, move the amba_bustype variable to be a constant
> structure as well, placing it into read-only memory which can not be
> modified at runtime.

...

> -extern struct bus_type amba_bustype;
> +extern const struct bus_type amba_bustype;

Can we actually hide this from the outside, i.e. make it static in the C file,
and introduce the dev_is_amba() helper instead?

P.S. You may look at the PNP bus case (some of the latest patches there).

-- 
With Best Regards,
Andy Shevchenko



