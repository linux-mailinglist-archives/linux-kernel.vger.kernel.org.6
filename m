Return-Path: <linux-kernel+bounces-558326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5651CA5E461
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 20:28:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1DAA07AB76F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 19:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9EA8258CE9;
	Wed, 12 Mar 2025 19:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OnZZMd3W"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC77F1E5B9B;
	Wed, 12 Mar 2025 19:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741807714; cv=none; b=pMH4x55OSDA51iYUUrLL/sANjs0vpLgiTSd39arJDWuFqyKTQ1+DHORlcL4mVOl97VSF0lq6DdWsVOt+phAULGcPzbf6+9fO6hM27pBAnCrXSyHY71Z9YgX8DXocCcqbuTm0CPHE2PLSWBEf2Q8I4kZDt1EVNv/M9Nxv5tzdTtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741807714; c=relaxed/simple;
	bh=Ml55QutQYDuNAblqTcMykzzhvcpoajqHCuwTLeq8ZBE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fx3qnIbx3wTY3Hx2uUNIpS/csLg31YKReyB+EErjvJmOGFKD8brIlW2Q11FXdZXG+eMhM+6FPg8Dxb2lyC6Y294I6LOf/tl7zUH4O8YvZ50n6crveIJkkEmY0Pg2EcN+VCNvdbErZvX9hRt3UgAKmoOr5Mktzo18YngWNGrjDDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OnZZMd3W; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741807713; x=1773343713;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=Ml55QutQYDuNAblqTcMykzzhvcpoajqHCuwTLeq8ZBE=;
  b=OnZZMd3W/6PU0zfK0DxnbXYhWuzHUTnbOt6/v72TKVKEyRRozDm3tczG
   8EnYHRQHbE+lQ5L5VJFivZjjEpwYZ9NqjFppzm3ZCOr160QYD54AbH8jE
   B05dnpagNaUkKS37aUgNyS/zHw6wiLKB+7qKzKgixdb71IknTRAEgxecD
   OoV7Gqox/3P0Wva0AuHL+s8/QI70laeLtRGDvkByG1YYP1UaRK7f/BNHP
   2TFDsjE/cvN7GC1oEq6LkcerNxoxBNO2PI1i7rDaF1dhTBRHrLjGEV2Wa
   c455Ckwd3eKEWZhN3UOG+mCBNo8ecdfjQ5uUZtA54uZJYHGZ3jilONoXg
   Q==;
X-CSE-ConnectionGUID: uqKdhHNsSCyuigODnO+lzw==
X-CSE-MsgGUID: x3u7NpWESIyGPn5wIWgACQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11371"; a="45679548"
X-IronPort-AV: E=Sophos;i="6.14,242,1736841600"; 
   d="scan'208";a="45679548"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2025 12:28:32 -0700
X-CSE-ConnectionGUID: csoMPoPiQ+6YRYdT+vqq7Q==
X-CSE-MsgGUID: e2AEQ3zRSTCqEVh6w2B10w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,242,1736841600"; 
   d="scan'208";a="125614288"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2025 12:28:27 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tsRkc-00000001xr9-20mF;
	Wed, 12 Mar 2025 21:28:22 +0200
Date: Wed, 12 Mar 2025 21:28:22 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Aditya Garg <gargaditya08@live.com>
Cc: Sven Peter <sven@svenpeter.dev>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Aun-Ali Zaidi <admin@kodeit.net>,
	Maxime Ripard <mripard@kernel.org>,
	"airlied@redhat.com" <airlied@redhat.com>,
	Simona Vetter <simona@ffwll.ch>, Petr Mladek <pmladek@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Jonathan Corbet <corbet@lwn.net>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"apw@canonical.com" <apw@canonical.com>,
	"joe@perches.com" <joe@perches.com>,
	"dwaipayanray1@gmail.com" <dwaipayanray1@gmail.com>,
	"lukas.bulwahn@gmail.com" <lukas.bulwahn@gmail.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	Hector Martin <marcan@marcan.st>,
	"asahi@lists.linux.dev" <asahi@lists.linux.dev>
Subject: Re: [PATCH 1/2] lib/vsprintf: Add support for generic FourCCs by
 extending %p4cc
Message-ID: <Z9HgVn-XELC065w0@smile.fi.intel.com>
References: <ABAEA9D0-97CB-4ADD-9606-A12D5815335A@live.com>
 <376C9BD3-2F41-4511-BE52-1B8468FE2CB3@live.com>
 <b74df4b5-ecda-45ba-a98a-c84b0a29e380@suse.de>
 <PN3PR01MB9597AC6A02B0BF873920D94CB8D02@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <9092a9ed-aecf-40bd-9d15-b53d60d035b5@suse.de>
 <PN3PR01MB959715C19BCEA54426D24934B8D02@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <ff3a9c58-5c7a-4c48-8a9e-cc828a43baed@app.fastmail.com>
 <PN3PR01MB9597E5C609290DB1A967263CB8D02@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <PN3PR01MB9597E5C609290DB1A967263CB8D02@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Mar 12, 2025 at 07:14:36PM +0000, Aditya Garg wrote:
> > On 12 Mar 2025, at 9:05 PM, Sven Peter <sven@svenpeter.dev> wrote:
> > On Wed, Mar 12, 2025, at 13:03, Aditya Garg wrote:

...

> > I don't have a strong opinion either way: for SMC I just need to print
> > FourCC keys for debugging / information in a few places.
> > 
> > I'm preparing the SMC driver for upstreaming again (after a two year delay :-()
> > and was just going to use macros to print the SMC FourCC keys similar to
> > DRM_MODE_FMT/DRM_MODE_ARG for now to keep the series smaller and revisit
> > the topic later.
> > 
> > Right now I have these in my local tree (only compile tested so far):
> > 
> > #define SMC_KEY_FMT "%c%c%c%c (0x%08x)"
> > #define SMC_KEY_ARG(k) (k)>>24, (k)>>16, (k)>>8, (k), (k)
> 
> That seems to be a nice alternative, which I guess Thomas was also suggesting.

I don't think it's "nice". Each of the approaches has pros and cons.
You can start from bloat-o-meter here and compare it with your %p extension.

Also, can you show the bloat-o-meter output for the vsprintf.c?

> > which are then used like this:
> > 
> >    dev_info(dev,
> >        "Initialized (%d keys " SMC_KEY_FMT " .. " SMC_KEY_FMT ")\n",
> >         smc->key_count, SMC_KEY_ARG(smc->first_key),
> >         SMC_KEY_ARG(smc->last_key));

-- 
With Best Regards,
Andy Shevchenko



