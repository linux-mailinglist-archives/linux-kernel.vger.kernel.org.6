Return-Path: <linux-kernel+bounces-173670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F6D18C03BC
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 19:50:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD83A288FD3
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 17:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C95D212AAE8;
	Wed,  8 May 2024 17:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CEJT1VIN"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E1348BEE
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 17:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715190637; cv=none; b=uQuaRGhlj2B2YCNQfdEQ+fTvq3TZ2hehj3pVyz/aK0Hy2JkUEX+pBmLxXzA7xi2fQ7ybiX2haHQPYEuAdeV7b1Mysj98w9NMXpelGnUHUiJ5ttasb5SyZ0Xyk4+eAusWvmTsBo/e8IWabcOisHA/O3vdno0J3lNnyoWTb+TrIdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715190637; c=relaxed/simple;
	bh=/79lVjVOGKjWtEnpx6Su7BVq+J88D4Y6CVYEINBVIBM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qk2pXmIxBAd4vkU+6MTOPemtLP5qTWz2bMuU1a77i6K/AoY54pWmnuL0+feDzEVwdznBidA/+0TGQsWjTg6JUTgk7iM4ZXuJcuTb15nfubrFbCwqjm75MgbkhAwnE6eEeN2maNBG7jk6CdeMMLJK0TboC+Xs3TKfiLOyHLbVTpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CEJT1VIN; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715190635; x=1746726635;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/79lVjVOGKjWtEnpx6Su7BVq+J88D4Y6CVYEINBVIBM=;
  b=CEJT1VINcezzeNR25J2Sl/Xz5TcrHoGqlDO4nzICr2/7XoGIZIgaW5M+
   dgQ/fdQz2Oqfp+PS9wU+ZR+VblsiLgfkf7Y70LnhK6HeB7whlnWqDIuGl
   WVvOnlNc4kbANtAVavY5BRpBEmbkQaKcwmwpq4RdfM1KUctcs6H/K+Txb
   x/ggt9TLV6P93x06fuzdCDb06aF5CDIMSoPhf/jgOt9HZCdRJ/8bH+R+s
   Aictx6asUn2GiDRGynR+WAlHc9h+KhPkhBGvp5WwuNOYznftzQWw+Q9Yy
   M6b2bq+6A8zderPtn0b0Nc/nrG/N/TtrAPF5UvYanS2Hivh6Vs8fohKCp
   g==;
X-CSE-ConnectionGUID: Z0RT8jbiThiMibVvVRZtCw==
X-CSE-MsgGUID: zBLzZt/4SG2UwN9jSQQwmQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11067"; a="21642029"
X-IronPort-AV: E=Sophos;i="6.08,145,1712646000"; 
   d="scan'208";a="21642029"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2024 10:50:33 -0700
X-CSE-ConnectionGUID: uI9ipCNjSUqM28DWf1SIsw==
X-CSE-MsgGUID: Xye86n34QsSgTjh7MdsSUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,145,1712646000"; 
   d="scan'208";a="29339011"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2024 10:50:32 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1s4lQy-00000005Wpr-3ZJ8;
	Wed, 08 May 2024 20:50:28 +0300
Date: Wed, 8 May 2024 20:50:28 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: linux-kernel@vger.kernel.org, Tal Gilboa <talgi@nvidia.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>
Subject: Re: [PATCH v1 1/1] dimlib: Use *-y instead of *-objs in Makefile
Message-ID: <Zju7ZNSMCSzbqCGO@smile.fi.intel.com>
References: <20240508143039.1196671-1-andriy.shevchenko@linux.intel.com>
 <c0ce1a9b-d63d-43e7-96f0-6eeb35051f63@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c0ce1a9b-d63d-43e7-96f0-6eeb35051f63@broadcom.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, May 08, 2024 at 10:39:55AM -0700, Florian Fainelli wrote:
> On 5/8/24 07:29, Andy Shevchenko wrote:
> > *-objs suffix is reserved rather for (user-space) host programs while
> > usually *-y suffix is used for kernel drivers (although *-objs works
> > for that purpose for now).
> > 
> > Let's correct the old usages of *-objs in Makefiles.
> > 
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> Acked-by: Florian Fainelli <florian.fainelli@broadcom.com>
> 
> > ---
> > 
> > Reported by Olek. As I said him this is correct change which is
> > documented in Documentation/kbuild/makefiles.rst "Composite Host
> > Programs" (mind the meaning of the word "host"!).
> 
> Why not credit him with an official Reported-by?

No problem
Reported-by: Alexander Lobakin <aleksander.lobakin@intel.com>

-- 
With Best Regards,
Andy Shevchenko



