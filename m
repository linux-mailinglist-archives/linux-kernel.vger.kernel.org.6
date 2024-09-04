Return-Path: <linux-kernel+bounces-315235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7438D96BFA9
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 16:07:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FF9C1F263D1
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 14:07:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 140CF1DA317;
	Wed,  4 Sep 2024 14:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GJbiDpkm"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C15E1D9D6B
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 14:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725458844; cv=none; b=KxcN1MlHwSZQp430UEcc7ri/i1sAwlnHt5YJ18YtTwkSPWdqowdyg798wxMU43vaWGyxa+cQFPNlKIqTElnNDaNMVpIQ8uKCVvR4mTkbKPsKMdoD3RkdCPtF5gSQt7/OMMZ5TT9YuiQtuFoVoln9upRBxYgKUhKA+L56PH413sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725458844; c=relaxed/simple;
	bh=4+jaeKJwNZLJP0GyEY6jDCAlsNMQgBG+kQ5n9d4JmkI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MKSuR6GKvj5fWbRqM2QPgkA/mzjQ0HpvoirZlICy61GQMzI69SlUn90Oq2tYcEZkDE5izZnKGUaZ/SNVdjJseR7RZuQ1jvb0jbJBRpZgzauvAjxU9cnkRkpbYT5usFt+gfwaL0MGDFwm95uQQoweXl/QKRECBq831hBsuqa+hSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GJbiDpkm; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725458843; x=1756994843;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=4+jaeKJwNZLJP0GyEY6jDCAlsNMQgBG+kQ5n9d4JmkI=;
  b=GJbiDpkmvzcvsFquGAKYySgNA5dVEjT2SOGPYZp6NxOcEzpeQt+e0Sca
   dZg6emWg6URsDlKJO1tQiWRxszsEvc7GjDtT2BT3G7s8GRFlPpChrXRgt
   9lBknJqvLyHsRaqHQrrIjZFIMfrbHEeH8pOShAPcATYl3VcorKsPPfCJE
   H4QKF7cUJN7B2J+Kgx82b6xJElFivTxcfYQyTrOSkO4ydpYh4h7wyH1Pj
   5E5efVQlX50Q02F5goyNPrOVomjEQmUUOOQ+lK1MoBCAxhovfzm1JAXWi
   ZFbcqSCzJ6NFcu11F3SLzFEqwsMDcK6ydo4JLIWEbPr346ib7Rv9ADWV6
   A==;
X-CSE-ConnectionGUID: UMrqyADsQYWk7Nagso2u4g==
X-CSE-MsgGUID: GkUqhPBKSw2ONZXcl+GQuA==
X-IronPort-AV: E=McAfee;i="6700,10204,11185"; a="27911566"
X-IronPort-AV: E=Sophos;i="6.10,202,1719903600"; 
   d="scan'208";a="27911566"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2024 07:07:22 -0700
X-CSE-ConnectionGUID: +ZlWUtw0T+CSRpHgSefJzQ==
X-CSE-MsgGUID: w327YfoIRsOR7TrK4wK7BA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,202,1719903600"; 
   d="scan'208";a="65317727"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2024 07:07:20 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1slqfE-000000055Gf-413g;
	Wed, 04 Sep 2024 17:07:16 +0300
Date: Wed, 4 Sep 2024 17:07:02 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Kunwu Chan <kunwu.chan@linux.dev>, krzk@kernel.org,
	andi.shyti@kernel.org, robh@kernel.org, gregkh@linuxfoundation.org,
	suzuki.poulose@arm.com, linux-kernel@vger.kernel.org,
	Kunwu Chan <chentao@kylinos.cn>
Subject: Re: [PATCH] amba: make amba_bustype constant
Message-ID: <ZthphmT8pqV3eFk1@smile.fi.intel.com>
References: <20240823064203.119284-1-kunwu.chan@linux.dev>
 <ZsiTPjtnZZIW-K4k@smile.fi.intel.com>
 <56e29159-3ebb-425a-9bd6-cb66484d7738@linux.dev>
 <ZsxbjnMa8teJ5_Pg@smile.fi.intel.com>
 <5b4987e3-af8a-413f-bbbe-d493d6c371f6@linux.dev>
 <Zs3Wt5xkFOiuH-iP@smile.fi.intel.com>
 <6774cd23-47f9-4d15-8954-a9f749998fe2@linux.dev>
 <Zs8jZiN1TvNfHQ9N@smile.fi.intel.com>
 <65c80deb-21e1-44eb-87c9-c7cdd36d77cd@linux.dev>
 <ZthnjPjPB+6cMf9w@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZthnjPjPB+6cMf9w@shell.armlinux.org.uk>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Sep 04, 2024 at 02:58:36PM +0100, Russell King (Oracle) wrote:
> On Thu, Aug 29, 2024 at 09:31:29AM +0800, Kunwu Chan wrote:
> > Thanks for the reply.
> > On 2024/8/28 21:17, Andy Shevchenko wrote:
> > > On Wed, Aug 28, 2024 at 10:51:54AM +0800, Kunwu Chan wrote:
> > > > On 2024/8/27 21:37, Andy Shevchenko wrote:
> > > > > On Tue, Aug 27, 2024 at 03:45:31PM +0800, Kunwu Chan wrote:
> > > > > > On 2024/8/26 18:40, Andy Shevchenko wrote:
> > > > > > > On Mon, Aug 26, 2024 at 06:08:11PM +0800, Kunwu Chan wrote:

...

> > > > > > > Make it patch series:
> > > > > > > 1) patch that introduces exported function called dev_is_amba() (1 patch)
> > > > Done.
> > > > > > > 2) convert user-by-user (N patches)
> > > > I've no idea about how to modify, such as in iommu.c:
> > > Oh, crap. Yes, this need more thinking.
> > > Anyway, Russell is okay with your initial patch, the rest can be done
> > > separately. For now probably we can leave it exported for this only case.
> > > 
> > Anyway, thanks for the suggestion, i'll   introduce the dev_is_amba function
> > 
> > and  add the Suggested tag for you.
> > 
> > If you have a better idea and need me to do it, you can always contact me.
> 
> General policy is not to add stuff that doesn't have any users. From
> what I can see from briefly reading this discussion, and looking at
> the patches submitted to me, the dev_is_amba() patch adds a helper,
> but as yet there are no users - and not even any patches on a mailing
> list to make use of this helper. Therefore, I won't be applying that
> patch.
> 
> Good idea, but it needs users...

I agree, we need at least a couple of user to convert.

> Please note that I likely won't be reading further discussion (see
> my signature below, and I'm having the same op on the other eye -
> which is the only eye suitable for screen work at the moment -
> this Friday.)

Oh, wish you a successful op and fast recovery!

-- 
With Best Regards,
Andy Shevchenko



