Return-Path: <linux-kernel+bounces-338294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB72B985600
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 11:02:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 189071C20CC2
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 09:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 094DA158DC6;
	Wed, 25 Sep 2024 09:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i5d5PaEb"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07DBE136E01
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 09:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727254956; cv=none; b=gILsQYs2JuBOXMi44t0EhzGepQ2SZZDWnfz0u2sjq9kd5Rk++abDX0GERdY5sYg8VkizgWZA62eW0v9inIzr7g+l4Xvm2O74zXFs8CLvFGmx6gSQNklf723LvbanR/Q1FQMkZZb+4odCCHbA2Ts9LTZs4CEIvNeXQmjmct7G9zA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727254956; c=relaxed/simple;
	bh=yNvGv1QhYEnAeuF9G8eHDX2x7ouTcNwUvGFKsxZ3Oxo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=de1F3kUO5fmF++8qh+qf7LkYcJz9QS3lamA8Af2X0P6KaLt7opAoxx7cdoZR3Z4j1Z1S1MEJoTSE/cOCAKqwuTSvrYflASeFbK/IqbxKwyiCOUIF7xS+nUXvstHUH1nzPQz6zZwilT76BtQxewfa3th89GJ1qjv6poT/JIHF9sA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i5d5PaEb; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727254955; x=1758790955;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yNvGv1QhYEnAeuF9G8eHDX2x7ouTcNwUvGFKsxZ3Oxo=;
  b=i5d5PaEbmr+DuYnHySI8OrGMb3x2caiDdzlR68O89rBAhCw8jP3gW07W
   t4q8t9lMaHV6m9V11ifIY2+QRe+thNH7fPkNiBx7+hyJWJVVCJ1Mh5358
   4kxQwicx0+5ehcrUaQMiEpzt6hzbh6avkvDIqiqDH+XfkveQfonWbmYrg
   Ekt1OaSQ6MGhhEpWBom4RQv8kmvV829XS6y94xeaUDazpN4boE+fVkXhJ
   oMrR9xh5jrAnn8SJtAHz8J+lCJlypIu1HAm9tRXn5SDxPLwJdGmMdNh++
   KhOwKKTeO4TXV8sU6Y3A5C2KH9ltPjOCxFhJifNDUk3upSPR6E6O1v/yH
   Q==;
X-CSE-ConnectionGUID: 7hGUDrSMRx+s4X4J755W+w==
X-CSE-MsgGUID: jYziVCbPQ/OWSFQFUML3cw==
X-IronPort-AV: E=McAfee;i="6700,10204,11205"; a="26159025"
X-IronPort-AV: E=Sophos;i="6.10,256,1719903600"; 
   d="scan'208";a="26159025"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2024 02:02:35 -0700
X-CSE-ConnectionGUID: byWFAAZhQ7i1X3I1OMgIiA==
X-CSE-MsgGUID: ptNiu59rS9WZIrDu2HerIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,256,1719903600"; 
   d="scan'208";a="109166660"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2024 02:02:32 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1stNuo-0000000Ckw8-1TMJ;
	Wed, 25 Sep 2024 12:02:30 +0300
Date: Wed, 25 Sep 2024 12:02:30 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v1 1/1] regmap-irq: Consistently use memset32() in
 regmap_irq_thread()
Message-ID: <ZvPRpmaUuR3JlUYY@smile.fi.intel.com>
References: <20240925082726.620622-1-andriy.shevchenko@linux.intel.com>
 <0b7b6ca3-b05b-40f2-86cf-083beb72727c@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0b7b6ca3-b05b-40f2-86cf-083beb72727c@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Sep 25, 2024 at 11:55:51AM +0300, Matti Vaittinen wrote:
> On 9/25/24 11:27, Andy Shevchenko wrote:

...

> >   		memset32(data->status_buf, GENMASK(31, 0), chip->num_regs);

> > -		memset(data->status_buf, 0, size);
> > +		memset32(data->status_buf, 0, chip->num_regs);

> Can we guarantee the sizeof(unsigned int) == sizeof(uint32_t) on all
> supported architectures? (The status_buf is unsigned int, right?). If yes,
> then this looks nice to me.

Yes as long as we (Linux kernel) support only 32-bit and higher architectures.

-- 
With Best Regards,
Andy Shevchenko



