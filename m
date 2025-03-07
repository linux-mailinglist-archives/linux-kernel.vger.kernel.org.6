Return-Path: <linux-kernel+bounces-551696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80BDDA56F9E
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 18:51:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86AA47A914B
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 17:50:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F95F241685;
	Fri,  7 Mar 2025 17:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l9riaeMH"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6900B24060E
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 17:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741369867; cv=none; b=W+04EeyiFnis2eXUW5r8kJaKry603uxddeTbeVkRn3Cnn28shmmJJ5PlV3/olwXfLQiWc45hL3W0jfn9p3DCcT6oExd0aEPVboa9A5cPtJscrQHqwHoqXTZA/k1P7rQ8LNGq6TFENydFIZtyC5nRFDS41BTcPaYL8cdbL9E/pdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741369867; c=relaxed/simple;
	bh=dGD7M+D/Vv3zLXXm89n7VTmmkqauqr/Ru9jLjoB4/aA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oYuBX0yIY0oGNK05DDwqbcaUYOE2c1K9SzrLIXfSgGTSZpsMUInGUls1WBqhL3z4a1RRnoQE9/8xhxJe1nX2O9MQf4Voz/9I8BJSJS2w0/YCoh1FIagKBgQhJFsYOkRTV3uSuLALvACr9o7UzGVemtkDbSrRIjCh5RCXaYPqzAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l9riaeMH; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741369864; x=1772905864;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dGD7M+D/Vv3zLXXm89n7VTmmkqauqr/Ru9jLjoB4/aA=;
  b=l9riaeMHyC9EwLzgh8sVpyoclTCagXBUunpaC+fueX0hg+Yljk6sMRie
   KYYRqArkgShqFbNxHxhBoR9mNwBscJurO0tEWO+GGyI6XRgLeBkLUZKZr
   T4wfM65U1j8lA4m6r5CFhQ6tcbycNc6sSCwb2oxr60haOhfGvZFzUhbF1
   5nP/m/vDUQbLUQ/y3LroSSz6mnfxR0dHv4f8swt4MYHNg6/yDTzD8vG6B
   rEafPE1B0km7Nzyu0qZeOPL3lpmGKUvf/k4KV3NKd9wmZUVRX4sxTBaP8
   kt9ZYDurJ4WoBDs0QffjELAAPwnDyWU3PZ50zq03Glalr4VhukElgu2uk
   g==;
X-CSE-ConnectionGUID: 4fhF1xtRRbyHQhtRJ1ZIdQ==
X-CSE-MsgGUID: roSbwp5YT1iZzqLFQbBV0A==
X-IronPort-AV: E=McAfee;i="6700,10204,11365"; a="53064411"
X-IronPort-AV: E=Sophos;i="6.14,229,1736841600"; 
   d="scan'208";a="53064411"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2025 09:51:04 -0800
X-CSE-ConnectionGUID: qdL4OL/ITzy4ND73d87j2A==
X-CSE-MsgGUID: kLc/vBOjQJODVcV23RQl8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,229,1736841600"; 
   d="scan'208";a="124308185"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2025 09:50:59 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tqbqZ-00000000Tbf-2wYc;
	Fri, 07 Mar 2025 19:50:55 +0200
Date: Fri, 7 Mar 2025 19:50:55 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Yury Norov <yury.norov@gmail.com>
Cc: mailhol.vincent@wanadoo.fr, Lucas De Marchi <lucas.demarchi@intel.com>,
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
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Jani Nikula <jani.nikula@intel.com>
Subject: Re: [PATCH v6 0/7] bits: Fixed-type GENMASK_U*() and BIT_U*()
Message-ID: <Z8sx__SHALZI1NCx@smile.fi.intel.com>
References: <20250308-fixed-type-genmasks-v6-0-f59315e73c29@wanadoo.fr>
 <Z8sqSpKZzfolKm8Q@thinkpad>
 <Z8swXUGf9rtTHw1o@smile.fi.intel.com>
 <Z8sxdOjk3LksG9ky@thinkpad>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8sxdOjk3LksG9ky@thinkpad>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Mar 07, 2025 at 12:48:36PM -0500, Yury Norov wrote:
> On Fri, Mar 07, 2025 at 07:43:57PM +0200, Andy Shevchenko wrote:
> > On Fri, Mar 07, 2025 at 12:18:02PM -0500, Yury Norov wrote:
> > > No rush, please allow your reviewers a week or two before submitting
> > > a new iteration unless you want to disregard the previous version for
> > > some reason, of course. This will not get into the upcoming merge
> > > window, anyways.
> > > 
> > > So, what should I do? Go through the v5 and all discussions in there,
> > > or just jump on this?
> > 
> > There is also question to you. Are we going to leave with U128 variants or is
> > it subject to remove? If the latter, can you issue a formal patch?
> 
> I asked Anshuman about it as he's the only person interested in it. Will wait
> for a _usual_ few weeks for reply before making any conclusions. If you know
> anyone relevant in ARM or everywhere else, feel free to loop them.

I see, yep, we still have time for that, let's wait a bit.

-- 
With Best Regards,
Andy Shevchenko



