Return-Path: <linux-kernel+bounces-305033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B33996286F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 15:17:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5CCC1F22322
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 13:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F450188002;
	Wed, 28 Aug 2024 13:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ezyGrRgb"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19B62187850
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 13:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724851054; cv=none; b=h3uV6T1KLLu7nReqdEr8McBuKIXbA5GNguVx/F5ha9Zjhszhx91Al0X+yfTyWj7UB0pOfsEW15roQcXRDVRQZhbV8LfDxxbcB5QVtk26JKixMTm7IgzYtJAJaBJ9nDClQU0MbBMKgTwjRDQQesbLfn+61thsi7M6n6naHs38Q0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724851054; c=relaxed/simple;
	bh=2KXho2KHiEFqSM3aafpK+vtoDdE3KxDx4vcnAGhNM+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q+zNwnhIBUnwBsoC40YhT8Yy6ZnV4924l+klrZOXX3Y/1ohLAHsMFzY6579fV197scH93qdeN551B+AhsSNGF6LsG2TSZpljv9aIHR4QbYdJNLeWbbbk4xjfj7l6zl+GpspQ3JRzefhJoE2qcbFVfJx0qbXTGXgA0mFp8xMr2uY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ezyGrRgb; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724851053; x=1756387053;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2KXho2KHiEFqSM3aafpK+vtoDdE3KxDx4vcnAGhNM+Q=;
  b=ezyGrRgb2pILBtuOk8GCjW1wUQC/BM7t+wJdKuB01aKkEr4vmbqbHonM
   VRVBzURQCKkssd4jmaivyZLE69+FoQOyA8DSTqrUk5D15BJ/PYLyfBOML
   /bkqI9gqKMq2rxDZ5oZN7DXH/4TwQygnH0Qw3K6uJJiiDZf2qf9SK2Hz0
   6bPladdSe425ORVHSVN6UHgDjCb97HGsrbOBYtQC0spO1AE480o3nn5Y3
   v5MW2aKAYIlcf2S5cyLN7l8xmTD8afUEViPj3wfurw6jE25WCz2f5M/7m
   c0CmGmiUdHVP0jh3oriWVq0M52dJ+uVB02XK8TMdQqFpr94yVmERa4dQC
   w==;
X-CSE-ConnectionGUID: pIAytznAQiW0h2aCwZHQ5g==
X-CSE-MsgGUID: 9OgY/Rj1TPq0Y9QDZ9jzfA==
X-IronPort-AV: E=McAfee;i="6700,10204,11178"; a="34757163"
X-IronPort-AV: E=Sophos;i="6.10,182,1719903600"; 
   d="scan'208";a="34757163"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2024 06:17:33 -0700
X-CSE-ConnectionGUID: tKiEGV87RNarBF7gdAuviQ==
X-CSE-MsgGUID: yh53E/fjRyyf7E4dESXYZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,182,1719903600"; 
   d="scan'208";a="68041159"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2024 06:17:30 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1sjIYB-00000002ecQ-1RGY;
	Wed, 28 Aug 2024 16:17:27 +0300
Date: Wed, 28 Aug 2024 16:17:27 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Kunwu Chan <kunwu.chan@linux.dev>
Cc: linux@armlinux.org.uk, krzk@kernel.org, andi.shyti@kernel.org,
	robh@kernel.org, gregkh@linuxfoundation.org, suzuki.poulose@arm.com,
	rmk+kernel@armlinux.org.uk, linux-kernel@vger.kernel.org,
	Kunwu Chan <chentao@kylinos.cn>
Subject: Re: [PATCH] amba: make amba_bustype constant
Message-ID: <Zs8jZiN1TvNfHQ9N@smile.fi.intel.com>
References: <20240823064203.119284-1-kunwu.chan@linux.dev>
 <ZsiTPjtnZZIW-K4k@smile.fi.intel.com>
 <56e29159-3ebb-425a-9bd6-cb66484d7738@linux.dev>
 <ZsxbjnMa8teJ5_Pg@smile.fi.intel.com>
 <5b4987e3-af8a-413f-bbbe-d493d6c371f6@linux.dev>
 <Zs3Wt5xkFOiuH-iP@smile.fi.intel.com>
 <6774cd23-47f9-4d15-8954-a9f749998fe2@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6774cd23-47f9-4d15-8954-a9f749998fe2@linux.dev>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Aug 28, 2024 at 10:51:54AM +0800, Kunwu Chan wrote:
> On 2024/8/27 21:37, Andy Shevchenko wrote:
> > On Tue, Aug 27, 2024 at 03:45:31PM +0800, Kunwu Chan wrote:
> > > On 2024/8/26 18:40, Andy Shevchenko wrote:
> > > > On Mon, Aug 26, 2024 at 06:08:11PM +0800, Kunwu Chan wrote:

...

> > > > Make it patch series:
> > > > 1) patch that introduces exported function called dev_is_amba() (1 patch)
> Done.
> > > > 2) convert user-by-user (N patches)
> 
> I've no idea about how to modify, such as in iommu.c:

Oh, crap. Yes, this need more thinking.
Anyway, Russell is okay with your initial patch, the rest can be done
separately. For now probably we can leave it exported for this only case.


-- 
With Best Regards,
Andy Shevchenko



