Return-Path: <linux-kernel+bounces-551493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 75F4CA56D24
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 17:07:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E02616DDAF
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 16:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93E1822489F;
	Fri,  7 Mar 2025 16:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W6h/QrYf"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46E54221553
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 16:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741363646; cv=none; b=sG87SeFS1xtIr7Z0XWYi1ttGsRcASGuYXLFSq/9cFQvk3pKg5aix+Vcfa6YDs9Al6D1yGbWjYC3gBO9xxZ6QqugcDGUBohIBHttpN5Vhd4IDN/WfER4SAqcm9l3W22iFzjxZBfj0TBFlzPck4JyU0/tXbmhaRKItO0DbfHCYqpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741363646; c=relaxed/simple;
	bh=pnnr3yVXjXJ58yTtOIaxhRCfVdG1kFVJBYONEQQH3cU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tDy4y6BoE7boeUaeeICjJwFXAI9u4417FYUKn+IC2iGf1EIDnSZ+xq9Rnfrn6eay1uGSr3LMQFkIfSvSsU2GWnmbW2zXaK32LwiADQb4N3LhsRyQMnW7KJL+2u2eoq7yh5tmKiSmkYrVBKCybdwzowfCcIpt7FcncuwjgHytUMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W6h/QrYf; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741363644; x=1772899644;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=pnnr3yVXjXJ58yTtOIaxhRCfVdG1kFVJBYONEQQH3cU=;
  b=W6h/QrYfDPxW/+exce+M+OIUVYUOz/8eJYYW9k/JlTQZRCRIvIyGudsL
   aW6wlg7319YWFeJCfdjDcEm01idVGkVoGA7G2P2JjNiUYpqcQJzndv0os
   nL/WH2U0uJMFgL/R/czOtXjZcRxFKRgwSc0aLli/TApa28F12XGCJdk3n
   UVy829MT9aHXUmJMNhoMGMK51VIBPxxu9ea4lldUFJ2zjrDG9aT9/Jzj5
   asksFaqWozadtxc3TX3UPzcZP2bVG+eWDjAhukaLsL9+b5bUlQqwmSxay
   S/rr+fypD97wkZX/HqpMckBVU1sfttmwwOxUEn3HssWz0WOHF1sVOOzKf
   A==;
X-CSE-ConnectionGUID: AxhCa0+/Ry2TxA2a/bFlbQ==
X-CSE-MsgGUID: nUD1aBo+Qe+GLDW1LUjhkg==
X-IronPort-AV: E=McAfee;i="6700,10204,11365"; a="42616358"
X-IronPort-AV: E=Sophos;i="6.14,229,1736841600"; 
   d="scan'208";a="42616358"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2025 08:07:24 -0800
X-CSE-ConnectionGUID: i9ofbq1LTJuoORwKtHGmqg==
X-CSE-MsgGUID: XLRy0tlCRPOx572f+D2fuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,229,1736841600"; 
   d="scan'208";a="119350170"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2025 08:07:19 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tqaEG-00000000S60-02V0;
	Fri, 07 Mar 2025 18:07:16 +0200
Date: Fri, 7 Mar 2025 18:07:15 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
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
Subject: Re: [PATCH v5 7/7] test_bits: add tests for BIT_U*()
Message-ID: <Z8sZs_Tfl4G8PoAM@smile.fi.intel.com>
References: <20250306-fixed-type-genmasks-v5-0-b443e9dcba63@wanadoo.fr>
 <20250306-fixed-type-genmasks-v5-7-b443e9dcba63@wanadoo.fr>
 <Z8mfAQGUvm3z86kE@smile.fi.intel.com>
 <722e147b-fdd1-4098-8d60-48c83e36a7f7@wanadoo.fr>
 <Z8nhdz5FZIHYb4Yi@smile.fi.intel.com>
 <df371256-d981-433b-bcba-00a445e04c41@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <df371256-d981-433b-bcba-00a445e04c41@wanadoo.fr>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Mar 07, 2025 at 07:11:42PM +0900, Vincent Mailhol wrote:
> On 07/03/2025 at 02:55, Andy Shevchenko wrote:
> > On Fri, Mar 07, 2025 at 01:08:15AM +0900, Vincent Mailhol wrote:
> >> On 06/03/2025 at 22:11, Andy Shevchenko wrote:
> >>> On Thu, Mar 06, 2025 at 08:29:58PM +0900, Vincent Mailhol via B4 Relay wrote:
> >>>> From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> >>>>
> >>>> Add some additional tests in lib/test_bits.c to cover the expected
> >>>> results of the fixed type BIT_U*() macros.
> >>>
> >>> Still would be good to have a small assembly test case for GENMASK*() as they
> >>> went split and it will be a good regression test in case somebody decides to
> >>> unify both without much thinking..
> >>
> >> Let me confirm that I correctly understood your ask. Would something
> >> like this meet your expectations?
> > 
> > I believe it should be written in asm.
> 
> I am not confident enough in my assembly skills to submit asm patches to
> the kernel. So, I would rather take a pass on that one.
> 
> Regardless, if somebody decides to unify both without much thinking as
> you said, I am fully confident that the patch will get Nack-ed right

As I said above "would be good", if you think it's not feasible by you, perhaps
a comment (FIXME: ?) in the Kunit test cases that we lack of / need an asm test
as well.

-- 
With Best Regards,
Andy Shevchenko



