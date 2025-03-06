Return-Path: <linux-kernel+bounces-548963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05634A54B77
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 14:05:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CFC417451F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 13:05:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F4D020C023;
	Thu,  6 Mar 2025 13:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a3tOFI9a"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69BFC20B7EF
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 13:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741266332; cv=none; b=tjsgl7mfm/v8mcapACL+Ly70ckSHTi1kjMLYBo3kU36G1dhyn+4+bBzvBve9pMYP1sE7p9Ak3Tl4yUcEciJZJwVjJqc9Q6cjIX2rRg3T7T2aefItEWj0liXY42MauYVt6Ufc2AwDSPzFpUyLKxpZsnJOp+ImsrOjyF/nSsaPeY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741266332; c=relaxed/simple;
	bh=vyXzzdl7CTsDjVwKAXKtkmRpCQPPSn+DOaj/Y6vgm5c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mMI1m07fwch5jOutnewMq70MEyLy9TnWrH9ue+4hUnG8xN+CUvNr9DOWd9GUisBX08S3ciR3po1xsgm01Teg60KChA2U61tBVKdw308dwVqf4aIcgeUzIIEQI4759gaq5ClcQe/fZB/oGpuG6m2CXH4HmPBl3U8nCh72e4OrxNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a3tOFI9a; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741266332; x=1772802332;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vyXzzdl7CTsDjVwKAXKtkmRpCQPPSn+DOaj/Y6vgm5c=;
  b=a3tOFI9avEb9IOhLAJkHd3wvPanOqgTZkl91zBKF2VvYITxYW/8bh5um
   2gdY9r8AqlNKYPW8fZxMna1FRrSi/QoobLEvujNUfdS4SNY8BkI8v9tNT
   D5e8dLwflqeM+oCdpSSu2QDl/PuozkBiIwWx8KmL5Yqk1Lfnm3dv8y5Qc
   Rs2cw1L6SZ8L6UaMrAtk11imfrwTvvEXUXamQNTV4QL85QOj8dKS1eGYv
   t0DMA4TvK5CnO7xJi++NH337slp9FgA+idkVCPzwJJyU/t9ulNy8S3fdQ
   7zbtWUXmdcxD7zq7TzMSDi4ghYFrF9Y+63ZKMz8QR9Kod6NYPJqg8Etim
   Q==;
X-CSE-ConnectionGUID: 8efbkgcqSqm+uIjGB3qQjQ==
X-CSE-MsgGUID: 3KY6VE/GQ7aAplUHoXRD3w==
X-IronPort-AV: E=McAfee;i="6700,10204,11365"; a="29854916"
X-IronPort-AV: E=Sophos;i="6.14,226,1736841600"; 
   d="scan'208";a="29854916"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 05:05:31 -0800
X-CSE-ConnectionGUID: tGyxdRHFS1GZCBhj4zJIPw==
X-CSE-MsgGUID: 6lw2cuyCTZGMzTXLnX9+LQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,226,1736841600"; 
   d="scan'208";a="119210793"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 05:05:28 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tqAuh-000000007eh-3UPW;
	Thu, 06 Mar 2025 15:05:23 +0200
Date: Thu, 6 Mar 2025 15:05:23 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: mailhol.vincent@wanadoo.fr
Cc: Yury Norov <yury.norov@gmail.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	Andi Shyti <andi.shyti@linux.intel.com>,
	David Laight <David.Laight@aculab.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: Re: [PATCH v5 1/7] bits: split the definition of the asm and non-asm
 GENMASK()
Message-ID: <Z8mdk3z7t42CWfmZ@smile.fi.intel.com>
References: <20250306-fixed-type-genmasks-v5-0-b443e9dcba63@wanadoo.fr>
 <20250306-fixed-type-genmasks-v5-1-b443e9dcba63@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250306-fixed-type-genmasks-v5-1-b443e9dcba63@wanadoo.fr>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Mar 06, 2025 at 08:29:52PM +0900, Vincent Mailhol via B4 Relay wrote:
> From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> 
> In an upcoming change, GENMASK() and its friends will indirectly
> depend on sizeof() which is not available in asm.
> 
> Instead of adding further complexity to __GENMASK() to make it work
> for both asm and non asm, just split the definition of the two
> variants.

...

> -/*
> - * BUILD_BUG_ON_ZERO is not available in h files included from asm files,
> - * disable the input check if that is the case.
> - */

I believe this comment is still valid...

> +#else /* defined(__ASSEMBLY__) */


...here.

Otherwise justify its removal in the commit message.

> +#define GENMASK(h, l)		__GENMASK(h, l)
> +#define GENMASK_ULL(h, l)	__GENMASK_ULL(h, l)
> +
> +#endif /* !defined(__ASSEMBLY__) */

-- 
With Best Regards,
Andy Shevchenko



