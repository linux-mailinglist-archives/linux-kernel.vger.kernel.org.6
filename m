Return-Path: <linux-kernel+bounces-529693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98DCFA429F8
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 18:37:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9106D3B5874
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 17:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E119264F81;
	Mon, 24 Feb 2025 17:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b3RJOLez"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C440264A98
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 17:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740418380; cv=none; b=FNWM9Yi+a7f6k7/LrFyE3tbF8YwbRjo4tfBnU6C/us1nnwP3GgH9UxJ7UDniYJFJVHjVV4PB1RpPnN5O+Qap9YenYShhBOqb263bs4Ju9zZ28wp+meyLKTRvMHxVw0nO3568010ioJsVSvufY2eqNTKV/QRtK3DRtNdQG9Mu2M8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740418380; c=relaxed/simple;
	bh=dQHxaqOAMXsXuPcWBI/2KnJbQdTD/Pwe6sXONWPz0ig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xk9toi47mggUDFx189P1+e+QwlBjRK2i1JXxiJ6JVJ6+/OGDegh7mXtqPVEh0kqWSP//GzjOAjgB7CWY3q32I/h15GjBbOo/to1nr13lWZVE3z1xXdF+ExcQS5MoBbpJo+SOZBWlBhGCB+LMiC9/UtYmrRTcGrI3zb9Vy9MoUxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b3RJOLez; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740418380; x=1771954380;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dQHxaqOAMXsXuPcWBI/2KnJbQdTD/Pwe6sXONWPz0ig=;
  b=b3RJOLezqE3RAunYqqSRei3BrpXInYqW0Ol4xZiVuwJZNUWVXhCoKoZp
   ++1sdvGF+EzdI/pVjRB0qWaRjm8pX+U/nCLA+YLyGmvne48yeoIGEwA9E
   ymEdllNEskofKfzAtaYt81/b21SJ7oBjhsEHWDWCq7x3aGrbGFqJSYmVU
   02AoOZOOJDA4smOxOs0izfvPS8PtOzPJmD//Cd8i9RCpTQbkSI7xVZVUs
   q6zJBPzz85tVp228VBEuTD9IX46J8t56x1tbQ9NozcdP4dpwKvD4qo9Ce
   G9UmHmfCS6/MIecoFoRDimaDCCH7rSWGTbysM3NYFG+deofDZJVcYsXFN
   A==;
X-CSE-ConnectionGUID: 16vlhCivQxejyNxj3SA1mg==
X-CSE-MsgGUID: C3au+8W5RdefJ/3yjZDgRA==
X-IronPort-AV: E=McAfee;i="6700,10204,11355"; a="58602514"
X-IronPort-AV: E=Sophos;i="6.13,312,1732608000"; 
   d="scan'208";a="58602514"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2025 09:32:58 -0800
X-CSE-ConnectionGUID: vWV5pYaYSimuV7Gm2c0fqQ==
X-CSE-MsgGUID: qhskSG53T+CLAvTSKVslfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="121375097"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2025 09:32:55 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tmcK4-0000000ElCV-3vwk;
	Mon, 24 Feb 2025 19:32:52 +0200
Date: Mon, 24 Feb 2025 19:32:52 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jianglei Nie <niejianglei2021@163.com>
Cc: ojeda@kernel.org, geert+renesas@glider.be, linux-kernel@vger.kernel.org,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v2] auxdisplay: hd44780: Fix potential memory leak in
 hd44780_remove()
Message-ID: <Z7ytRJMHOqftODD8@smile.fi.intel.com>
References: <20221128084421.8626-1-niejianglei2021@163.com>
 <Y4SRUwKFGJfwNZ2U@smile.fi.intel.com>
 <Y4SUkGYK5Y6Uo3Bv@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y4SUkGYK5Y6Uo3Bv@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Nov 28, 2022 at 12:59:28PM +0200, Andy Shevchenko wrote:
> On Mon, Nov 28, 2022 at 12:45:39PM +0200, Andy Shevchenko wrote:
> > On Mon, Nov 28, 2022 at 04:44:21PM +0800, Jianglei Nie wrote:

...

> > Fixes: 718e05ed92ec ("auxdisplay: Introduce hd44780_common.[ch]")
> > 
> > What you found has nothing to do with the issue. Issue has been introduced
> > later on.
> 
> Side note (mostly for Miguel): That series by Lars was indeed problematic.
> And I see now that he didn't get the parameter to the charlcd_alloc(). Now
> we have problem that your patch solves and dangling parameter in the struct
> charlcd_priv. So, I will restore charlcd_alloc() before his series (after
> this patch has been applied, because of the backport needs) for a new
> kernel development cycle.

FWIW, the
https://lore.kernel.org/r/20250224173010.219024-1-andriy.shevchenko@linux.intel.com
has been just sent.

-- 
With Best Regards,
Andy Shevchenko



