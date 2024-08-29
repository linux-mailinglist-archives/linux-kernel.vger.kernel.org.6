Return-Path: <linux-kernel+bounces-306919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DF5396456A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 14:54:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F17A6B28DF0
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 12:54:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F48C1AE056;
	Thu, 29 Aug 2024 12:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="caOUhOI3"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8095F1AE033
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 12:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724935760; cv=none; b=riyrXZaW70QMzHFOP6Ln4xnWiBViQY6LA+cvQO4VqYkSQPJpkPCJWjtt6iWJhbLPK5vy/6G0XMl2iN9W0YNUC/UKyMq8/AIv5UGAlOl7t9q+fC62OAXIcRGXblB/Y+4LzbfkeoTi09PEmSYoUvkXYcu0qnePqvUndQAGUke+p38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724935760; c=relaxed/simple;
	bh=sPZsmusIAktLi9bcP0xGfBUVHX02EQ5gXL1gLmac0cA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SxjyQuI0Fq5dyPdD8v6iQ+gBEc9VjSNjL8vl6fT5NzzUUP1akc/oM1xo9en8UEs1xhcoSjIEWbJ+OY8zlinvAxYe/eRxxLOGWQIQnZ/XiG3wtYekLQNQ4O6bKR6vpJfKcvmJlW2xfI0BuM8BSvckADR2969TtimDHn1EfwTNnoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=caOUhOI3; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724935760; x=1756471760;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sPZsmusIAktLi9bcP0xGfBUVHX02EQ5gXL1gLmac0cA=;
  b=caOUhOI3thBfU60GYgNO4s9/FPdH60UfcCE34y+vx1vsFW9KhD3DPWHw
   DLlD7RJAWxjbwJ5/yU8xsBp1Jc7iH1tjmZJJMqec+DZsgC5fm/3wNhAVR
   acGtLev/SHl8Vn16Vr5tMr5NJjZn2XT3Vt+aVfbmHKLAvlbwLEzNfvO0I
   4XHh6ge1FwwGLmY3pAa/BV9t9yCiSUtBmQs37VbzcoPC5WXcFDSsc68iy
   GXmsovjgWnvDhVxbLHcG3FirEC7+Ya7mTOf1QbGs5R6ln1jAOgE5aSrAi
   bICEscvHf+hNYEw1R3F6fM9bE4n/+XvWYUZSdW5Z4lbhvJ+nHdK1Ke+Qt
   Q==;
X-CSE-ConnectionGUID: Dy72VceVRmK3jnXzY10heQ==
X-CSE-MsgGUID: 8D/tzh/oSGOB7l5GQc3h8w==
X-IronPort-AV: E=McAfee;i="6700,10204,11179"; a="41026125"
X-IronPort-AV: E=Sophos;i="6.10,185,1719903600"; 
   d="scan'208";a="41026125"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2024 05:49:19 -0700
X-CSE-ConnectionGUID: D4yuMiytS1uS0u+1oRQG4A==
X-CSE-MsgGUID: LEZsvLTzRBCqhdKCDoN2kw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,185,1719903600"; 
   d="scan'208";a="63766090"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2024 05:49:17 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1sjeaR-00000002zvV-01c2;
	Thu, 29 Aug 2024 15:49:15 +0300
Date: Thu, 29 Aug 2024 15:49:14 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Matti Vaittinen <mazziesaccount@gmail.com>
Subject: Re: [PATCH v2 08/10] regulator: irq_helpers: Fix
 regulator_irq_map_event_simple() kerneldoc
Message-ID: <ZtBuSjH3EfK7QiiC@smile.fi.intel.com>
References: <20240829085131.1361701-1-wenst@chromium.org>
 <20240829085131.1361701-9-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240829085131.1361701-9-wenst@chromium.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Aug 29, 2024 at 04:51:28PM +0800, Chen-Yu Tsai wrote:
> kernel-doc complains about missing "Return" section for the function
> regulator_irq_map_event_simple().
> 
> Add a "Return" section for it based on its behavior. The function
> actually always returns 0, but fills in fields in its @rid parameter as
> needed. Expand the description of the parameter to cover this.
> 
> While at it fix a typo found in the description of the same function.
> 
> Reported-by: Matti Vaittinen <mazziesaccount@gmail.com>
> Closes: https://lore.kernel.org/all/e341240e-1c1f-49a2-91cd-440888fdbda0@gmail.com/

Fixes?

> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>

-- 
With Best Regards,
Andy Shevchenko



