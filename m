Return-Path: <linux-kernel+bounces-335776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B89797EA7F
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 13:11:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1963828208A
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 11:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFAF8198832;
	Mon, 23 Sep 2024 11:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="beHosmxA"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC528524D7;
	Mon, 23 Sep 2024 11:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727089906; cv=none; b=NNemy3058I88WwBT0XEfz2d2xTJzMxjCsZB5cea8YSDcKjb39j54gGLXAzEl/Dj3NJV+NRIp6rDHX8K/aPRh90VQRrFHUzODwsU0g4sLxJNNmc1XPOeKhnuVLC/iPGbVy+mPakeAe4ouT+LHnindPRpUdru2nRnFXtHk1A/dgSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727089906; c=relaxed/simple;
	bh=oJ71kPa0w7COfvYdH+l+Agi7RTgRlAUYQAsJKxwaTuk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q/VDdOmcDWMCFkKjOCceivYVgEV6CLdLMvl9MqjnswTVQgBrPKeNeQPMJOhgg44WoAw36hCyVbyhiykuWwNgGHeNRYrCW0q0MtUjjjhcBIsRoh3JZDvO3+1oa36YWiLTEMAQf5f2R9R82dQy7ykvGEX/vTenhWkGxAMwLRv4tlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=beHosmxA; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727089905; x=1758625905;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=oJ71kPa0w7COfvYdH+l+Agi7RTgRlAUYQAsJKxwaTuk=;
  b=beHosmxAqJPBDhdTvS2uUplnjDm2BLts1Z0CQ/nkXZ5fi7NAZbtnCbLl
   RnSFcO1i7VWpjtZWha7PiFuDh1uoNNFow+CoOI6lhntav/3o5SQwUQMYk
   ae27udD0PL/pdJha4MoAB0/4R2+wKUvsWDTQNrxgA60FdmSi4sO1Mvf4b
   DQ29qAQvBQQP9FigM0DDNgiqzuPr6q00Vg/pVGqBmrDezyLm1nVE/tFQj
   oIOVvG5H//4GxiECcuvOvf8H+dhFYtz5OoL611ZBbSfmtlUy6z1hT8tBx
   JUtiLlf/H5Scbc44o6f+gbvcDsJTx2+3K8OA1dXXnqs/ZgDpW7fdcwY/a
   Q==;
X-CSE-ConnectionGUID: rypzY31JSpeiy5rjU8/Uhw==
X-CSE-MsgGUID: fu2pf72HQn23mXp+MC9L8g==
X-IronPort-AV: E=McAfee;i="6700,10204,11202"; a="26126131"
X-IronPort-AV: E=Sophos;i="6.10,251,1719903600"; 
   d="scan'208";a="26126131"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2024 04:11:44 -0700
X-CSE-ConnectionGUID: BYmPudAlReedHEc4L9Lzog==
X-CSE-MsgGUID: cEFssgq6R6au1poM0ms87Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,251,1719903600"; 
   d="scan'208";a="71066628"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2024 04:11:43 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1ssgyi-0000000BxsG-08MT;
	Mon, 23 Sep 2024 14:11:40 +0300
Date: Mon, 23 Sep 2024 14:11:39 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Kunwu Chan <chentao@kylinos.cn>
Cc: linux@armlinux.org.uk, robh@kernel.org, saravanak@google.com,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] amba: Add dev_is_amba() function and export it for
 modules
Message-ID: <ZvFM6yC1EQPS5w_s@smile.fi.intel.com>
References: <20240923094249.80399-1-chentao@kylinos.cn>
 <20240923094249.80399-2-chentao@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240923094249.80399-2-chentao@kylinos.cn>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Sep 23, 2024 at 05:42:47PM +0800, Kunwu Chan wrote:
> Add dev_is_amba() function to determine
> whether the device is a AMBA device.

Thanks, but it needs at least a user to show the conversion.
I think I suggested in the last discussion to convert all
straightforward cases (which are not the direct users of the
given bus type).

-- 
With Best Regards,
Andy Shevchenko



