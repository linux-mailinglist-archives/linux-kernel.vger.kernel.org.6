Return-Path: <linux-kernel+bounces-198330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9102B8D76CE
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2024 17:38:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A77761C20CF5
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2024 15:38:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E6AD47F6A;
	Sun,  2 Jun 2024 15:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ezwjcvfo"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0737641C73
	for <linux-kernel@vger.kernel.org>; Sun,  2 Jun 2024 15:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717342714; cv=none; b=AOJ8z9YO4PP7IWIKnecJs2DDde1x7BiKRQeTVlsVko2N2k7V+2G11Q+nArxj8guh8c2CbOqaBEGYWHpBmG37cFbxP8R/MiAPAc9L142tu94yT+4OAi2j5F6F9cs4eEistS1VLUgKGYYMdBtYNwnZYhtBn6Y/bz38sQnII17kDio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717342714; c=relaxed/simple;
	bh=TIaUFkf0FFnEzNfQE0w20WGmR2pdMyWXT29kVZamx3I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LjfqD8EG5tqCQ3qNJY80LdYQVu86J6JSaeitYyLaVKJ9J5xSxS9dy/yaORELnvMzwm6Sa6mAiozWf5tRiuVYP8NtsxZ07RLj6tkcBoqMmgzb1avjJj6vUjdzsWeODoXTx1ureIngPR//CuoN1fo2YKfdPmVvp8aBiNuMaTTn400=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ezwjcvfo; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717342713; x=1748878713;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TIaUFkf0FFnEzNfQE0w20WGmR2pdMyWXT29kVZamx3I=;
  b=ezwjcvfoeGtxGtCSeTrpCgr81aYB2oByzUQEAip2jVnER+ESuP/oABib
   Yt2f4PS4RRbANC1f04AolYcuVWFkGl/QEH6a/IYN5Fx4EyFkGV8gdzxOT
   vEz/MTpPIftlzXDM9Ubx17fsixFX7rlUt3M5c9sGOGxJhEnuFqaOU+8/E
   c2pJFBOgvUvopXrfhpQyJo5Qz67rM1mCyS6HRIJwb/3XpPxYlORCCcv0b
   FgZyK8645/uAHVXFYbVTl0hiR5kuyXwfWCjep2EqIPao8rr4qHDoeJBo+
   9DcHbLnFBXy4Q4j2auGxIOwfQd8qavHeBcVgtvZPuGGZbiM97dP8jM6q1
   Q==;
X-CSE-ConnectionGUID: b+oSBJt2RIKcIOr3pr2zLQ==
X-CSE-MsgGUID: ByyZYM0ZTreCnjcOPBUfnw==
X-IronPort-AV: E=McAfee;i="6600,9927,11091"; a="24495331"
X-IronPort-AV: E=Sophos;i="6.08,209,1712646000"; 
   d="scan'208";a="24495331"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2024 08:38:32 -0700
X-CSE-ConnectionGUID: tOhcpZ8iQ9KhzLvCFM4ENg==
X-CSE-MsgGUID: gWx3hshVRbeRybVixBv/qA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,209,1712646000"; 
   d="scan'208";a="67482848"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2024 08:38:29 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1sDnHu-0000000D3Hp-2jgD;
	Sun, 02 Jun 2024 18:38:26 +0300
Date: Sun, 2 Jun 2024 18:38:26 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Alex Deucher <alexander.deucher@amd.com>,
	Lewis Huang <lewis.huang@amd.com>, amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
	Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	"Pan, Xinhui" <Xinhui.Pan@amd.com>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH v1 1/1] drm/amd/display: Fix too big frame size
Message-ID: <ZlyR8rohohgp-DD4@smile.fi.intel.com>
References: <20240602142103.3259613-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240602142103.3259613-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Sun, Jun 02, 2024 at 05:21:03PM +0300, Andy Shevchenko wrote:
> Compilation fails on arm with:
> 
>   link_factory.c:743:1: error: the frame size of 1032 bytes is larger than 1024 bytes [-Werror=frame-larger-than=]
> 
> Fix the frame size by allocation one of the big structures.

Fixed even in better way in 0b6dc64b4e22 ("drm/amd/display: Refactor
construct_phy function in dc/link/link_factory.c").

-- 
With Best Regards,
Andy Shevchenko



