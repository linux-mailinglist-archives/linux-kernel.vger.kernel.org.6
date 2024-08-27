Return-Path: <linux-kernel+bounces-303555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA191960DF0
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 16:43:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 954FB285A4D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 14:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C1471C6882;
	Tue, 27 Aug 2024 14:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HNSlH+Kt"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B981C57BC
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 14:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724769788; cv=none; b=k/Ng1hrFKzlrv+sA7u5B18FO8wFIKrsFpYwOygOZy1/zIrmv9b+xkbRRmfFYJmePSiKljgACakl+yHEzJepdQoBQAP0Mm22uEBPu2P/wDhb5ef76CQ0W7hwS8l+CyySXAO0HyKVgfyB0Hx+zt33kJ0DqPVPTwcQ7S/pmKrtuflw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724769788; c=relaxed/simple;
	bh=qbkNonG0Hlbq/0dme6lulp5ijYLM6Cuh57PNXch0E1g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fiGkGSs20M2pYCx6Ip8tyerPl56Nv/eC1yiqXgGD0vOsWkTNnGsPS35/EoeD6bONngkKit1rqXxFSNktnAWOhLK7Xs6/jmrP7pC/CsTiGcvMEB0PP03QrJiG8Ly+cVeXKlHpWVhbTSQRaPUcmk9ETXg1HsSWeu+WvOvGlfWQbHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HNSlH+Kt; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724769787; x=1756305787;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qbkNonG0Hlbq/0dme6lulp5ijYLM6Cuh57PNXch0E1g=;
  b=HNSlH+Kt/2f7KJeslcwRbda6eg1xF4bq+sbYjoog8rurbqMzlvhqC/NX
   q1ueZWq8EMczEIiuqD8pr9g9GHOZRihzlJMrElInCtZxmvn8DvaVEgUql
   eZqF4OXlE35VUtE7g1V/SMVheG2Aar+HNqyjqFETFL80cdN1wbmedjuIS
   Hnbm35MUl26KwEDRP9y0TkMCMUgUudmzx2zeE62Mg2tAhtLiTAncVkZOT
   OnsQyMCIWUpyJYQj/1tw0vT3HN9JvJ9qG5Oh5+uzvYpHWewYhR5bi0ItC
   sbVBeYGRPDe5fEbeLFu0tosyktmeNnHy1XaCOYHLCRSlOjyVWzuRu9sMc
   g==;
X-CSE-ConnectionGUID: 4g6hiSDwQ7WKiT8CobGkQQ==
X-CSE-MsgGUID: rMeMSjZfReKBux0GtMRMHw==
X-IronPort-AV: E=McAfee;i="6700,10204,11177"; a="13238432"
X-IronPort-AV: E=Sophos;i="6.10,180,1719903600"; 
   d="scan'208";a="13238432"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2024 07:43:07 -0700
X-CSE-ConnectionGUID: bCqfet2BRv6HLa+pEpo+Dg==
X-CSE-MsgGUID: 6nAvkEPvTKW8ubycx8hGOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,180,1719903600"; 
   d="scan'208";a="63599565"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2024 07:43:06 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1sixPS-00000002IW5-2czj;
	Tue, 27 Aug 2024 17:43:02 +0300
Date: Tue, 27 Aug 2024 17:43:02 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 6/8] regulator: fixed: Fix incorrectly formatted
 kerneldoc "Return" section
Message-ID: <Zs3l9lPoDm4E3cEO@smile.fi.intel.com>
References: <20240827095550.675018-1-wenst@chromium.org>
 <20240827095550.675018-7-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240827095550.675018-7-wenst@chromium.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Aug 27, 2024 at 05:55:46PM +0800, Chen-Yu Tsai wrote:
> kernel-doc complains about missing "Return" section for kerneldoc of
> of_get_fixed_voltage_config(). The kerneldoc has a description
> about the return values, just not in the format kernel-doc wants.
> 
> Convert it to use the proper "Return:" section header. The existing
> description have been reworded and moved around to fit the grammar and
> formatting.

...

> + * Return: pointer to populated &struct fixed_voltage_config or %NULL if

Seems to me this should be "pointer to the"

> + *	   memory alloc fails.

-- 
With Best Regards,
Andy Shevchenko



