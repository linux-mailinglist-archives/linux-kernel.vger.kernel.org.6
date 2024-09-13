Return-Path: <linux-kernel+bounces-328735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A0F9978806
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 20:40:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E20F2867A7
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 18:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D60F12CDA5;
	Fri, 13 Sep 2024 18:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fQmYfh3e"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5591312C474;
	Fri, 13 Sep 2024 18:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726252814; cv=none; b=jY6oM0B56dbUrVAT22ztw6jC+vf9hbUwOZRdlaUniPozQQ7HLbxx+bN+fGg4lnzHo5qjhYK4ZwXY5/C15RDmaU8Tk5sQc60IVStVcdD0nGN5oxnad+f2tkcpIfC5aQkzjUix8BGdNIHpDR5x/QDkfVJKdAJKbAJambLnXZRUe6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726252814; c=relaxed/simple;
	bh=xB36LjuAVwPWwTAdnh0SObbAHxyEukZGyYVEUmacUNs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rwk2OMY0v5UQQ+aMwkRE/VvO9gdwxz9NuFYu2o8fsY4+SFSadDjjdjeDDqtcJczTquwxVbDBITA0PbCjrfxkM8ijdK78tKRedv0EFWj8xQ6ATvu5jEnkvYwc+DO0atrOZXjxM910bHDxP6KsdG84i/zZ6/1C1pyoTWVdEFY4N2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fQmYfh3e; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726252813; x=1757788813;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xB36LjuAVwPWwTAdnh0SObbAHxyEukZGyYVEUmacUNs=;
  b=fQmYfh3e8Lam6PdaIrBMoN0oSFPeu+9x0WCaNNB6jUS8esG3f7HQqbmq
   1s2gMFMNhaOdQ2zGWX8WkK+dWyeyY+618IKG36bxGG0GEzRo1N5Sfj79S
   UoO0xcRBouAbErJ5c+uG0o2sBWY/0OtDpXrzqC8ZfKLyeWmuMO91c+QLj
   0+eWLvun9Rnni7WETB1aq7FBeEI0EOCopdM/PUdbRQfO1TlH88oE3Zsxy
   QUsuXGHo2ROXYEhlhBaoFLF6RJxGavDD+H568CzJs/Tv/G0guxQWrX52U
   zgFQx6o4gnaWhCTxQNp2WH/4ih6CLlrqv1Ouuqy5XeHniVnziia0nkOBE
   g==;
X-CSE-ConnectionGUID: 11sku4LuTmCmy5/4Ax7cHw==
X-CSE-MsgGUID: auoj8PmfRo6cP21+X7861A==
X-IronPort-AV: E=McAfee;i="6700,10204,11194"; a="25101568"
X-IronPort-AV: E=Sophos;i="6.10,226,1719903600"; 
   d="scan'208";a="25101568"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2024 11:40:13 -0700
X-CSE-ConnectionGUID: hqB3z9FrSJS+P9ui0oB4yQ==
X-CSE-MsgGUID: UpgClTK1SAeHrirIOTzOQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,226,1719903600"; 
   d="scan'208";a="68930043"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2024 11:40:11 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1spBDE-00000008OQ9-0lQi;
	Fri, 13 Sep 2024 21:40:08 +0300
Date: Fri, 13 Sep 2024 21:40:07 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Thorsten Blum <thorsten.blum@toblux.com>, kees@kernel.org,
	gustavoars@kernel.org, mcgrof@kernel.org,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH v2] params: Annotate struct module_param_attrs
 with __counted_by()
Message-ID: <ZuSHB2v7OLvagZnn@smile.fi.intel.com>
References: <20240909162725.1805-2-thorsten.blum@toblux.com>
 <20240913164630.GA4091534@thelio-3990X>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240913164630.GA4091534@thelio-3990X>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Sep 13, 2024 at 09:46:30AM -0700, Nathan Chancellor wrote:
> On Mon, Sep 09, 2024 at 06:27:26PM +0200, Thorsten Blum wrote:
> > Add the __counted_by compiler attribute to the flexible array member
> > attrs to improve access bounds-checking via CONFIG_UBSAN_BOUNDS and
> > CONFIG_FORTIFY_SOURCE.
> > 
> > Increment num before adding a new param_attribute to the attrs array and
> > adjust the array index accordingly. Increment num immediately after the
> > first reallocation such that the reallocation for the NULL terminator
> > only needs to add 1 (instead of 2) to mk->mp->num.
> > 
> > Use struct_size() instead of manually calculating the size for the
> > reallocation.
> > 
> > Use krealloc_array() for the additional NULL terminator.

> >  	/* Fix up all the pointers, since krealloc can move us */
> >  	for (i = 0; i < mk->mp->num; i++)

Shouldn't this for loop and followed by assignment also be -1:ed?

-- 
With Best Regards,
Andy Shevchenko



