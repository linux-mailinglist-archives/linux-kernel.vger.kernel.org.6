Return-Path: <linux-kernel+bounces-549521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51E37A5537A
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 18:51:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89FC21780FF
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 17:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0799225B67E;
	Thu,  6 Mar 2025 17:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e6iMhToc"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B52C521480E
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 17:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741283495; cv=none; b=fxFFd6P16C//PUwhXLTNli7LU0jo1zgQyIzwUV70tBeWWP29Z4bxik8MUT7EcxrJfzClrU9nktUqxCwWGquJYyRGHyJy+jqpUvP8EJmWDsHd4XsLLJ+JDdW1SAslo0Ec/MW7MqKmbPxI5XwDpz3PsLV4rwsuBbEvdY+3/Uh5WxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741283495; c=relaxed/simple;
	bh=p2iSreTYKbljOg3NhjKET7agWJ9OBLv8elOeZggvxJo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CSPXtnFWd3/f21/YWl05DwgFXhjWG1sB87iazSN9COJns7D2MrU0B9Z4kjp2eGJlIJEd/PsT+uBc/5e6XgMxZX+NrYbddUa12djBV44qgSgmmKg0FYuQM3O/xFvmc7YfIDLD6XerkOyCws6SGP6XZBq4W3V01QQXAqyGHSI2DM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e6iMhToc; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741283494; x=1772819494;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=p2iSreTYKbljOg3NhjKET7agWJ9OBLv8elOeZggvxJo=;
  b=e6iMhToceL903v0l7pq9TL2PwQFy/wTktn7+YRSgsHTcXP93zwy4XB3V
   h4x19+07AAxUEwdVBdPA3hxVVVchYFMPOo3BnAzPcB212p0TA5iz8saGX
   G/pKwxBbVlNQw2psU/2bDLoqZFxsj02GJS82mf35tXSqYQ6xygOT9kPY6
   NV4igT0jlHoEn3Iszs2fDHgnCPUtn9WDM78f0uiu0XYFOLdrr6VKqjuwm
   S3a1QsRb+FOEd8koj4qnm6RMviqkHDjqTEB6LjegbsrPqJ6fnD2rWnYVD
   TxBaHie94oTY8M3X8pZ3WfDvqPppvI+RzOcgC1lNjksIxCkotWzDmvqai
   w==;
X-CSE-ConnectionGUID: 778v4BT2Sq67sCO515S9DQ==
X-CSE-MsgGUID: OSnlYT+0R4yKdgrwiFvxUg==
X-IronPort-AV: E=McAfee;i="6700,10204,11365"; a="42451564"
X-IronPort-AV: E=Sophos;i="6.14,226,1736841600"; 
   d="scan'208";a="42451564"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 09:51:33 -0800
X-CSE-ConnectionGUID: TCVBOzqsQ/qZJgtD7x6Kew==
X-CSE-MsgGUID: jcaAc1YpR7ezFh9fO3B40g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,226,1736841600"; 
   d="scan'208";a="124187676"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 09:51:29 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tqFNV-00000000B38-3Uf7;
	Thu, 06 Mar 2025 19:51:25 +0200
Date: Thu, 6 Mar 2025 19:51:25 +0200
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
Subject: Re: [PATCH v5 1/7] bits: split the definition of the asm and non-asm
 GENMASK()
Message-ID: <Z8ngnTDqsNAiZDIz@smile.fi.intel.com>
References: <20250306-fixed-type-genmasks-v5-0-b443e9dcba63@wanadoo.fr>
 <20250306-fixed-type-genmasks-v5-1-b443e9dcba63@wanadoo.fr>
 <Z8mdk3z7t42CWfmZ@smile.fi.intel.com>
 <84abfaef-0fb9-4fd4-a657-0cc80eb1de0f@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84abfaef-0fb9-4fd4-a657-0cc80eb1de0f@wanadoo.fr>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Mar 07, 2025 at 12:07:45AM +0900, Vincent Mailhol wrote:
> On 06/03/2025 at 22:05, Andy Shevchenko wrote:
> > On Thu, Mar 06, 2025 at 08:29:52PM +0900, Vincent Mailhol via B4 Relay wrote:
> >> From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>

...

> >> -/*
> >> - * BUILD_BUG_ON_ZERO is not available in h files included from asm files,
> >> - * disable the input check if that is the case.
> >> - */
> > 
> > I believe this comment is still valid...
> > 
> >> +#else /* defined(__ASSEMBLY__) */
> > 
> > 
> > ...here.
> > 
> > Otherwise justify its removal in the commit message.
> 
> OK. I will restore the comment in v6, but will move it to the #else
> branch,

Isn't it what I suggested? :-)

> like this:

>   #else /* defined(__ASSEMBLY__) */
> 
>   /*
>    * BUILD_BUG_ON_ZERO is not available in h files included from asm
>    * files, so no input checks in assembly.
>    */
>   #define GENMASK(h, l)		__GENMASK(h, l)
>   #define GENMASK_ULL(h, l)	__GENMASK_ULL(h, l)
> 
>   #endif /* !defined(__ASSEMBLY__) */
> 
> >> +#define GENMASK(h, l)		__GENMASK(h, l)
> >> +#define GENMASK_ULL(h, l)	__GENMASK_ULL(h, l)
> >> +
> >> +#endif /* !defined(__ASSEMBLY__) */

-- 
With Best Regards,
Andy Shevchenko



