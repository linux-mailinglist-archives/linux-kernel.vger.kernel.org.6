Return-Path: <linux-kernel+bounces-547060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6BECA5026F
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 15:43:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90BF47A4DBA
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 14:42:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B321E156669;
	Wed,  5 Mar 2025 14:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NKlZ7S+l"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B207924633D
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 14:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741185794; cv=none; b=gNYcSmxDGGjbKYaNPIcjzkp47f/0ohtL8IDUyrMZtKpSfZ60A2qyJzfXCvN0uBkatgkp/nytCJMpESKIV81k8qfJWg6sVZREuLEResDzJ+z1yCX29akY0qY6WJwjn7kl3NcZawJ2fUnBKeOxe/ZVGumh3fszJ/m2BsPVxvjLXvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741185794; c=relaxed/simple;
	bh=J1i7qe67RESKlvYl+Yda1vlNo50Sk/TQVjKtxyrQbOY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vGtWJ2G6vNOR0XTibNw1uL41TNEs4abhnUOL9oqGn9zc/KAKRiRR3EyfIt7CgukuoTn1PDy9jr9b/xFNO0X9w5uSnnd+NEguupD7sjidtTQM+xa6r8TU8sWlRi1dDDJXWC2XYR03OgP2xMdSnAfinqP/3X8NH565kHGWt0KSHmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NKlZ7S+l; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741185793; x=1772721793;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=J1i7qe67RESKlvYl+Yda1vlNo50Sk/TQVjKtxyrQbOY=;
  b=NKlZ7S+lOVYUX3YWLrhFCqGVLwFrk0jyViuHLymwG1FbXoAZFAfLXrwq
   q4NkKLE7+i+o19bqsPhyR+DTvmcOdxFE0w8oLCK5BGgJGS+qKNwBEYVB/
   HAJxLvkY4S3G2NJPa+NYhyS1MW7bCowjv5u90LSKJdDwDd6SmMkAt3kl+
   9732zUpUtz8GiG+XqWbpJFsUhsQt3vgPQgDoJjaLxETZvA1VwhC974eja
   MZPT9LgDChhDlF9FTooIpdGvJ1gmRd1I9hJMPw5EdjuzhnAOSHIri45jZ
   EjWAweEdDAOvD29xHZleEwEkthjHwqS61RTX2ayi0qlZ8OTKJOmGaSfdQ
   g==;
X-CSE-ConnectionGUID: SGdR4CfXSdOtBbXR7pvLPA==
X-CSE-MsgGUID: 1Ug5W/Q4SUCEBwcFzrOoiA==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="52788181"
X-IronPort-AV: E=Sophos;i="6.14,223,1736841600"; 
   d="scan'208";a="52788181"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2025 06:43:12 -0800
X-CSE-ConnectionGUID: Kzd5AkpjSgWt6Wn/gUhwIw==
X-CSE-MsgGUID: TCsapfVFSsyIUv6V6peZ7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,223,1736841600"; 
   d="scan'208";a="118420148"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2025 06:41:51 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tppwR-0000000HRGP-2JQv;
	Wed, 05 Mar 2025 16:41:47 +0200
Date: Wed, 5 Mar 2025 16:41:47 +0200
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
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Jani Nikula <jani.nikula@intel.com>
Subject: Re: [PATCH v4 3/8] bits: introduce fixed-type genmasks
Message-ID: <Z8hiqzCMoyxHj9rL@smile.fi.intel.com>
References: <20250305-fixed-type-genmasks-v4-0-1873dcdf6723@wanadoo.fr>
 <20250305-fixed-type-genmasks-v4-3-1873dcdf6723@wanadoo.fr>
 <Z8hf7pN84-64LWPv@smile.fi.intel.com>
 <9f0215c4-62e5-4dfa-8dac-732682600c8c@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9f0215c4-62e5-4dfa-8dac-732682600c8c@wanadoo.fr>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Mar 05, 2025 at 11:38:19PM +0900, Vincent Mailhol wrote:
> On 05/03/2025 at 23:30, Andy Shevchenko wrote:
> > On Wed, Mar 05, 2025 at 10:00:15PM +0900, Vincent Mailhol via B4 Relay wrote:

...

> > Perhaps T or TYPE will suffice. Or perhaps we want
> > __GENMASK_Uxx() here?
> 
> If no objection, I have a preference for GENMASK_TYPE().

No objection from me :-)

-- 
With Best Regards,
Andy Shevchenko



