Return-Path: <linux-kernel+bounces-303551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3F7B960DD6
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 16:42:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B113E284FA5
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 14:42:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58E981C57A6;
	Tue, 27 Aug 2024 14:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j0R2E5B9"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E0571C0DE7
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 14:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724769725; cv=none; b=Hy+cI5Tg4kbZOUKMA3ou8v6FQuKJZw4itjqYN6RrYS8iVu+STlFnL5CWCiCL4tt62dql08d8H6QbzCBIWl5yNF9KVv1nA4iTWWk1rTiUO1izIU/j8V9ccNtrjufV/eu6uVrhroMYEJaOe6DQ2LJflKBtdVbg/aAA6++0eKk5xU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724769725; c=relaxed/simple;
	bh=fTLRWBxCzi6tYnTRLTq3xSwtBJMJ9mfKszUdbWqSh4s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OmuCubv2JeqF0OlOC7y1bp7EfNjZ5KBWMZA1e0Li8WNvnO2OLKPrE2F0mzEqLu1jN0nlgr6p/yKvlv3JSYCKwzJVANcwD9OUmgm96h89wrffYWJD0QdlbYsUJJACajBJNVAn1pQ12+1uy72tBgNoIlpIT18yVDgr5YECRJDJoIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j0R2E5B9; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724769724; x=1756305724;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fTLRWBxCzi6tYnTRLTq3xSwtBJMJ9mfKszUdbWqSh4s=;
  b=j0R2E5B9qbyCvubbJRPe1wrXMgkzduilARwUABEXPcHiB/nDJqLUTltF
   5FA2NgcczvEqCSnz9Eg92OKRhM2PMrfIDSgBcAi2HaUlr14HgG88dT0jt
   siQYpyBmRz5RHpxG0YrG3VaeJKtBeAyjk08dcFNZWLoqnpFpcYFP4KrPz
   xXqE6zMuJnatv6BcPdUdoPFCX6lEAJOweQzjdkqdS1mVZT/bzAjlQ+eth
   M3bQpHsCiPKfUCWYJgMFGgHx8Sj41suYuhcOKoJbkqiv5ukHjPb87xh3S
   a9FL6ulOju5+By2RBVVY8bgLlqlIVSCUOh7c6AmF4Tqzmhg/P/ZJXPoMM
   g==;
X-CSE-ConnectionGUID: eTGHAWuYSBuKIR6sZyQfPQ==
X-CSE-MsgGUID: VjZvAelaS6C+sfssM8ZefQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11177"; a="23426039"
X-IronPort-AV: E=Sophos;i="6.10,180,1719903600"; 
   d="scan'208";a="23426039"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2024 07:42:03 -0700
X-CSE-ConnectionGUID: t5of7k9UR5O/D0/9m2eo3A==
X-CSE-MsgGUID: R2eSpCdwS+KyPiZt5YToHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,180,1719903600"; 
   d="scan'208";a="62599370"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2024 07:42:02 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1sixOR-00000002IUf-1lp5;
	Tue, 27 Aug 2024 17:41:59 +0300
Date: Tue, 27 Aug 2024 17:41:59 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 3/8] regulator: core: Fix incorrectly formatted kerneldoc
 "Return" sections
Message-ID: <Zs3lt_0GGXAbsRPn@smile.fi.intel.com>
References: <20240827095550.675018-1-wenst@chromium.org>
 <20240827095550.675018-4-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240827095550.675018-4-wenst@chromium.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Aug 27, 2024 at 05:55:43PM +0800, Chen-Yu Tsai wrote:
> kernel-doc complains about missing "Return" section for many documented
> functions in the regulator core. Many of them actually have descriptions
> about the return values, just not in the format kernel-doc wants.
> 
> Convert these to use the proper "Return:" section header. The existing
> descriptions have been reworded and moved around to fit the grammar and
> formatting.
> 
> In a few cases where the functions don't call even more functions
> and the error numbers are known, those are documented in detail.

...

> + * Return: pointer the &struct device_node corresponding to the regulator if found,

"pointer to the"
Same elsewhere.

> + *	   or %NULL if not found.

...

> + * Return: pointer to a &struct regulator corresponding to the regulator
> + *	   producer, or ERR_PTR() encoded negative error number.

(I'm not sure of definite vs. indefinite article, though. Perhaps you need to
consult with native speaker.)

...

> + *	   producer, or ERR_PTR() encoded negative error number.

Okay, maybe "negative error number" to be used everywhere (see previous email),
the main point is a) to make it clear that it's negative, and b) be consistent
with a term across the subsystem.

-- 
With Best Regards,
Andy Shevchenko



