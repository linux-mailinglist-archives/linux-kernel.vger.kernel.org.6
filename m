Return-Path: <linux-kernel+bounces-303564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA199960E3D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 16:46:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 190E31C22FC1
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 14:46:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03BA01C57BD;
	Tue, 27 Aug 2024 14:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EmIBigeC"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC2851C6F5B
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 14:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724769979; cv=none; b=NfIHfeImr6FZvrPKIl18r79Nef1K0SFZFMOyKijCkWN19tOFVCBPFakSch1ZPhIO/cHEGVfmf9pIcpYETevPv2kjhg7/8C9j5t1loqVnYnkoQxVKm+IHZC8+CFPv+fCg2X9Qj+0p+5TvYcIx/aITXA2uPSlEc2SumZozdVrPHh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724769979; c=relaxed/simple;
	bh=Ut6wtB3afFPfnM8/3InMmzC+pymVz6Qun6OR7O+FXO4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LIwKEmtv0Tg26vHjWF09UIcEIXmqCq8VHPt7psDjXa+oenw/cbUISBpxNshHWzisnumhlLlBjLJAMpvKRv4hL6NZv92FRK9Gj0t+JdZE2KCobDzByAELcFHLuwcDnshBesLNEj2R5zsGFIize53c4LGbGPMzbn1fOYdL7xA7pqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EmIBigeC; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724769978; x=1756305978;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Ut6wtB3afFPfnM8/3InMmzC+pymVz6Qun6OR7O+FXO4=;
  b=EmIBigeCccu6wt1wwA4ElvYesjD1jxDlLbXd6NyH/NSv0pdb6bvNHMDl
   hlveaXlZLCtMCywOfHyc7bABRUWpaWG2h/Bgy06Grt8Rix9MQK5jLSlEk
   8sGzzzkY29qQsFOZ6VTmmYgutYV+3b0LAMwQ83PYPP82Ao6AEh9kCzTXF
   FOA/Qluo39BFC+Jr9SRPeKO4IJ0w1mZjXZFFMPT6eHchmeu0ekduw55Az
   54AbZy6rkdFdnMHwiGQ+bf43g70hp6YKVxKUOmtvjU1fe6pARGYnOb8H5
   ouoGItrAKS0B55SGnLl+dJvQCYNl0mNX12FR4PTo2glX+/eH3amZDlz4I
   g==;
X-CSE-ConnectionGUID: nmcs8aD/Q/qMLrU63pB4vg==
X-CSE-MsgGUID: KiYLATPxTEmk+3M5krVUnw==
X-IronPort-AV: E=McAfee;i="6700,10204,11177"; a="23426834"
X-IronPort-AV: E=Sophos;i="6.10,180,1719903600"; 
   d="scan'208";a="23426834"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2024 07:46:17 -0700
X-CSE-ConnectionGUID: xjyD17UBTlSLvMVxkClH5A==
X-CSE-MsgGUID: Rk50y7ELQsmPzeLNWR4PcQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,180,1719903600"; 
   d="scan'208";a="62601951"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2024 07:46:15 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1sixSW-00000002IYu-1g1K;
	Tue, 27 Aug 2024 17:46:12 +0300
Date: Tue, 27 Aug 2024 17:46:12 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 0/8] regulator: kerneldoc section fixes
Message-ID: <Zs3mtN-vPnVtppY-@smile.fi.intel.com>
References: <20240827095550.675018-1-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240827095550.675018-1-wenst@chromium.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Aug 27, 2024 at 05:55:40PM +0800, Chen-Yu Tsai wrote:
> Hi,
> 
> Here are a bunch of kerneldoc fixes for the regulator core. This sort of
> came as a request from Andy to not move code that already had warnings

You can add Reported-by: or Suggested-by to the cover letter.

> without fixing said warnings. So here I'm fixing them first.
> 
> The bulk of the fixes are in the regulator core and OF code, but I also
> fixed up a few bits in common code that were missing "Return" sections.
> These are purely kerneldoc fixes and don't touch any actual code. I left
> the devres code and helpers alone for now.

Thanks for doing this!

I briefly looked at them, the main two remarks are:
1) definite vs. indefinite article;
2) same and consistent term for negative error codes (or numbers if you
prefer).

Otherwise LGTM!

-- 
With Best Regards,
Andy Shevchenko



