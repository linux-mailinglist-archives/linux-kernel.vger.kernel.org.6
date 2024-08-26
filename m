Return-Path: <linux-kernel+bounces-301283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D342D95EEA2
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 12:40:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 128101C213D8
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 10:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E357514A09F;
	Mon, 26 Aug 2024 10:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZRIRiwdk"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5986143C6F
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 10:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724668826; cv=none; b=h4FolDBhIYIUeZIpoTNCZfuUekKTf0jhC9Ir7D66VixKoZeGNloHFWkAMc5VT7LTQJdlExi0Eo3QqhSxPlWXWiEGZ2Vrimdx7iWIAG5ySqmlV1JAmQ3O9AMzpBOB7PON9oxTtwqvp1AD2V/0rSn2VYdF0VbZhVhXPSCD0+we+D8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724668826; c=relaxed/simple;
	bh=Tq0YpF+9mcf9IJ4TcgL3GRruFSziStrHB8UXzUSeiY4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g7wSevukbFOcfGX7hTyMEG67DrgKdKlkA7GlwtppNMVaP5xmOXVVfON9NSb9nVPhtvmZYgJcqqeKzf8MAwybaEQ6QS7HLKp59iRvIG8I12OkXyvi2Js7o4kcAi+CR+4HeENH1gxbUmETCrUKGRe2xnuVJdRsmUS6NZWZMB0CiPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZRIRiwdk; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724668825; x=1756204825;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Tq0YpF+9mcf9IJ4TcgL3GRruFSziStrHB8UXzUSeiY4=;
  b=ZRIRiwdkLTI/zEj+D+YZ0JwPDM16NB8OAcXVa4p/ONR+pewNFphD6s+e
   wpO27cAwtyjIZozB5haJ4/3rZVg2QvKTnXSdJHBosGN/EpEU4goeV+D5n
   mS3W3W/zf+fPRcA2Z1j2z3vbLnodzwR2HkNzdTfckugEQXGBVCyupgt6c
   XG3xh2Wupac6ZQjnbRuB7WCXLLasr0GxXxCK+/JIfm0B3LwvDQ8XgD5yX
   /LnaixAKxDAn8V+MJ8V7snRRn+zIs5jmIZalpxL/gLwF2BzmIKVM2uGSx
   gi8Cpfm7OEL1i/ieSFBLcKtVdurhfR/7B7F9K2v3JY3k8dtpsX6P/RR3E
   A==;
X-CSE-ConnectionGUID: woPzeRXWT0K+DiqwS3cV+w==
X-CSE-MsgGUID: BDLdE6wlSTykTNeoOz2+pA==
X-IronPort-AV: E=McAfee;i="6700,10204,11175"; a="48472899"
X-IronPort-AV: E=Sophos;i="6.10,177,1719903600"; 
   d="scan'208";a="48472899"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2024 03:40:20 -0700
X-CSE-ConnectionGUID: oDx6sgS7RxOVxv4tZyzNyQ==
X-CSE-MsgGUID: gGMmXnxjSJaXwfGRk2aBnw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,177,1719903600"; 
   d="scan'208";a="62153363"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2024 03:40:17 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1siX8x-00000001pqc-0pTn;
	Mon, 26 Aug 2024 13:40:15 +0300
Date: Mon, 26 Aug 2024 13:40:14 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Kunwu Chan <kunwu.chan@linux.dev>
Cc: linux@armlinux.org.uk, krzk@kernel.org, andi.shyti@kernel.org,
	robh@kernel.org, gregkh@linuxfoundation.org, suzuki.poulose@arm.com,
	rmk+kernel@armlinux.org.uk, linux-kernel@vger.kernel.org,
	Kunwu Chan <chentao@kylinos.cn>
Subject: Re: [PATCH] amba: make amba_bustype constant
Message-ID: <ZsxbjnMa8teJ5_Pg@smile.fi.intel.com>
References: <20240823064203.119284-1-kunwu.chan@linux.dev>
 <ZsiTPjtnZZIW-K4k@smile.fi.intel.com>
 <56e29159-3ebb-425a-9bd6-cb66484d7738@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <56e29159-3ebb-425a-9bd6-cb66484d7738@linux.dev>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Aug 26, 2024 at 06:08:11PM +0800, Kunwu Chan wrote:
> On 2024/8/23 21:48, Andy Shevchenko wrote:
> > On Fri, Aug 23, 2024 at 02:42:03PM +0800, Kunwu Chan wrote:

...

> > > -extern struct bus_type amba_bustype;
> > > +extern const struct bus_type amba_bustype;
> > Can we actually hide this from the outside, i.e. make it static in the C file,
> > and introduce the dev_is_amba() helper instead?
> > 
> > P.S. You may look at the PNP bus case (some of the latest patches there)
> 
> I found it problematic in the process of making changes.
> 
> There have some usage of amba_bustype outside the AMBA code ,i.e:
> https://elixir.bootlin.com/linux/v6.10.4/source/drivers/iommu/iommu.c#L155
> 
> So, If we make the amba_bustype inside the AMBA code, the outside cannot
> access.

Yes, that's the idea.

> If only internal access is allowed, it will compile and report an error, how
> should I modify it next, and any suggestions?

Make it patch series:
1) patch that introduces exported function called dev_is_amba() (1 patch);
2) convert user-by-user (N patches);
3) hide the bus type and make it constant.

-- 
With Best Regards,
Andy Shevchenko



