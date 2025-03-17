Return-Path: <linux-kernel+bounces-563530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 26E87A6438B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 08:27:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D65A1893107
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 07:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A59B21ABA4;
	Mon, 17 Mar 2025 07:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iIOqtbr9"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8458918C337
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 07:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742196424; cv=none; b=izgi30al1rf67RRt4PPyoVVPh/wtFz0pWLI+c3PQGhMjOJCobbRXvHD6ZToy5sgVuKEQq6+sVMHwKM4zqyIvDA6IjSVKJDjrzNlH46IBCGQMHV+ZhS8emQJyWNzhNhWzJYn7PVHE8mVuiAm/8rNL3xVcuMF+HRw7QOZ7pGu61EY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742196424; c=relaxed/simple;
	bh=Dv6IcpigPQK43ljESs7c3/kc6GP7113YFVySNKAJ2iY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tKVfV2rFZ1aj5Y682sGMZdCkmFTfQ4cVO2VeKp+W5HxXgZUCTwh9505mNa3nst/6b6FBkcFHSoXdl5nXrlGRkYD8w9ljK7PUSCkI/rWoTdW6mfjkSHKL62+I2CKfm3TE7Gha8R6yVc5CsRfrpGvBgIsR1gyozjYl5gaslG6I4YU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iIOqtbr9; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742196423; x=1773732423;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Dv6IcpigPQK43ljESs7c3/kc6GP7113YFVySNKAJ2iY=;
  b=iIOqtbr9VTlc06g3kHA4k/Px0ovNFd4b82uCT1wqoTXPFAdZIjjWXVR4
   fXZp1MuVCuPEVE528was4yIhiH92l3OcP0yg5ntpEmSD2uiNBeisXSZjn
   VM6sKrTxuhRYFruJEw/xSUxWY/gMDCfyi6pl9ckFwEQfiZ7R0aQQiY8LU
   4mzdAILCqxdY9NvSlOlL95Mda9nyd1MrOO83afTD5kmGsEVI/HMRq6o6A
   t2ClL0SUrhFavphrXzBTMw+84cXvQ02ogITD5VqFAWgJBK5kkT3ePK7hj
   bqW7to8z5Y8C6qWbQQfyXamyRnDdg4NuDGzG5L5XKPSu215/+mj7xXtsf
   A==;
X-CSE-ConnectionGUID: TEV4uJMOS3eUvhMgF7e4NQ==
X-CSE-MsgGUID: vwvxJVwDTYS6/qmOFv2rnA==
X-IronPort-AV: E=McAfee;i="6700,10204,11375"; a="47056100"
X-IronPort-AV: E=Sophos;i="6.14,253,1736841600"; 
   d="scan'208";a="47056100"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2025 00:27:03 -0700
X-CSE-ConnectionGUID: cPzt/28tSDy6ivAwzpz1FQ==
X-CSE-MsgGUID: MOxBSgvcSWSvXGqQ1xfoXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,253,1736841600"; 
   d="scan'208";a="126492064"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2025 00:27:01 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tu4sF-00000003EnC-1uxh;
	Mon, 17 Mar 2025 09:26:59 +0200
Date: Mon, 17 Mar 2025 09:26:59 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Raag Jadav <raag.jadav@intel.com>
Cc: giometti@enneenne.com, gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] pps: generators: tio: fix platform_set_drvdata()
Message-ID: <Z9fOw6iu37GVxD48@smile.fi.intel.com>
References: <20250315133140.1707949-1-raag.jadav@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250315133140.1707949-1-raag.jadav@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Sat, Mar 15, 2025 at 07:01:40PM +0530, Raag Jadav wrote:
> Set driver_data correctly and fix illegal memory access on driver reload.

Do you have it in practice or you are thinking it will be like this?

-- 
With Best Regards,
Andy Shevchenko



