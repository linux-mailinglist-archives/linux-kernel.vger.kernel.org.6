Return-Path: <linux-kernel+bounces-311229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 717BD968659
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 13:38:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E85ED1F238B6
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 11:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D6981D175E;
	Mon,  2 Sep 2024 11:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IoN4UyUg"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D57A818455B;
	Mon,  2 Sep 2024 11:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725277105; cv=none; b=QGrNMYkeZMkpkCZDPHiYUretCqjxYrL30ERgYxJutD2TdAe1eCJo40fyW5y6C05cZ2J4w8FwcUcgOtKxmF9+T/dv/yaACb48KoPsugs2Qt/1NwY02B1E0ZEjxydyuWShYb3BlJA9wik67I68lpZmqPo2fUJXvlCZu2UonAWTJg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725277105; c=relaxed/simple;
	bh=4pnFvsWfkpHTyg9bH+andsa9SLKI4qCs7vP3a+fOQNM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uXU72omlfo2K5jhGNVCgKhW7xSI2GUxqe8lPZgJuwfwVzTPzaKVsy0VyN1aHRSF1IjAkhJj8XAgkpiUGHEwmiqx0Ow0CPt+szhF9lndAVk3JQC9iXAHCzwp9tDWZpOxv9lBYvKH7s8kkOjWpoz0hy4mKbPGEJNE8uu5WQ3eHRWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IoN4UyUg; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725277104; x=1756813104;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=4pnFvsWfkpHTyg9bH+andsa9SLKI4qCs7vP3a+fOQNM=;
  b=IoN4UyUgW07QNtZ2MkWxcVPNp+1kfBfpDDsC+MsMVLGul9CPJ2wG/s9e
   xPsr7vwvPW4fjMWg5excEeKK+szJ60saU0N27lkOsdyKYfcO/iDpRnC+w
   NCyU81vIrl2HthHme0DL/g5RGIuYNzpXdl8VnvGRiiKrUrMKofTriT3oA
   3IXdAbBrRaKLdF8I9R1Gw1S01prH/K+hgPcmFXCV7eDfiEgLg8RWxLm+I
   1J3f81T2g/I3lE5DTyeJLC4q3nDKV2M8hurd18K8jx1PsuE/SDhlPXoQH
   SMk3ubbbVgHL5MFyTEZrlCq+3563h1wWcCp0Zr8vKBlEYZGIwR00QdWJL
   A==;
X-CSE-ConnectionGUID: AGCk4bYwTIKZL5LQ2WhWbQ==
X-CSE-MsgGUID: NPuUUgpxTmKwkpqfnpCUqQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11182"; a="41329986"
X-IronPort-AV: E=Sophos;i="6.10,195,1719903600"; 
   d="scan'208";a="41329986"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2024 04:38:23 -0700
X-CSE-ConnectionGUID: FxSTbZA2RqO6adpzBr9uLg==
X-CSE-MsgGUID: +aqW+f0uRaSw+4JQKcgwdg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,195,1719903600"; 
   d="scan'208";a="64264954"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2024 04:38:21 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1sl5Ny-00000004LP4-23Gy;
	Mon, 02 Sep 2024 14:38:18 +0300
Date: Mon, 2 Sep 2024 14:38:18 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Hans de Goede <hdegoede@redhat.com>, linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Scally <djrscally@gmail.com>
Subject: Re: [PATCH v2 1/4] driver core: Ignore 0 in dev_err_probe()
Message-ID: <ZtWjqkQUi74JFN1s@smile.fi.intel.com>
References: <20240822130722.1261891-1-andriy.shevchenko@linux.intel.com>
 <20240822130722.1261891-2-andriy.shevchenko@linux.intel.com>
 <ce59c3c6-8729-469f-a0df-b6844792e324@stanley.mountain>
 <96a19237-9380-4173-9e52-e8295a0f4883@stanley.mountain>
 <ZtWQcXerriSnWgf1@smile.fi.intel.com>
 <4e8fa6fa-89aa-422f-b603-e2a3e1a2c704@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4e8fa6fa-89aa-422f-b603-e2a3e1a2c704@stanley.mountain>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Sep 02, 2024 at 02:10:41PM +0300, Dan Carpenter wrote:
> On Mon, Sep 02, 2024 at 01:16:17PM +0300, Andy Shevchenko wrote:
> > On Sat, Aug 31, 2024 at 11:53:51AM +0300, Dan Carpenter wrote:
> > > On Sat, Aug 31, 2024 at 11:25:54AM +0300, Dan Carpenter wrote:
> > > > On Thu, Aug 22, 2024 at 04:05:38PM +0300, Andy Shevchenko wrote:
> > > > > In the similar way, ignore 0 error code (AKA "success") in
> > > > > dev_err_probe(). This helps to simplify a code such as
> > > > > 
> > > > >   if (ret < 0)
> > > > >     return dev_err_probe(int3472->dev, ret, err_msg);
> > > > > 
> > > > >   return ret;
> > > > > 
> > > > > to
> > > > > 
> > > > >   return dev_err_probe(int3472->dev, ret, err_msg);
> > > > > 
> > > > > Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> > > > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > > 
> > > > This is a terrible idea because currently Smatch is able to detect about one
> > > > bug per month where someone unintentionally passes the wrong error variable
> > > > to dev_err_probe().
> > 
> > How many cases you know where smatch is false positive about this?
> 
> This check has a very low false positive rate.

Yes, that's my expectation as well.

> There is only one potential
> false positive in the current linux-next.  Let me add Baolin Wang to get his
> take on this.  I never mentioned reported this warning because the code was old
> when I wrote the check.
> 
> drivers/spi/spi-sprd-adi.c
>    550          ret = of_hwspin_lock_get_id(np, 0);
>    551          if (ret > 0 || (IS_ENABLED(CONFIG_HWSPINLOCK) && ret == 0)) {
> 
> Is it possible for the CONFIG_ to not be enabled but ret is zero?
> 
>    552                  sadi->hwlock =
>    553                          devm_hwspin_lock_request_specific(&pdev->dev, ret);
>    554                  if (!sadi->hwlock) {
>    555                          ret = -ENXIO;
>    556                          goto put_ctlr;
>    557                  }
>    558          } else {
>    559                  switch (ret) {
>    560                  case -ENOENT:
>    561                          dev_info(&pdev->dev, "no hardware spinlock supplied\n");
>    562                          break;
>    563                  default:
>    564                          dev_err_probe(&pdev->dev, ret, "failed to find hwlock id\n");
>                                                           ^^^
> 
>    565                          goto put_ctlr;
>    566                  }
>    567          }
> 
> 
> > I believe the number is only a few at most, which means that you may easily
> > detect this still with this change being applied, i.e. "anything that
> > terminates function flow with code 0, passed to dev_err_probe(), is
> > suspicious".
> 
> I think you mean the opposite of what you wrote?  That if we're passing zero to
> dev_err_probe() and it's the last line in a function it's *NOT* suspicious?

Yes, sorry, I meant "...terminates function flow _in the middle_...".

> Otherwise, I don't really understand the heuristic you're proposing.

-- 
With Best Regards,
Andy Shevchenko



