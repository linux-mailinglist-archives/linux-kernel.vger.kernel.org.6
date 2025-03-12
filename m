Return-Path: <linux-kernel+bounces-558356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC063A5E4C0
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 20:51:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02EAC17AE12
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 19:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41CEC1F0E33;
	Wed, 12 Mar 2025 19:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LBJFa6O0"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CD3E1DE3AF;
	Wed, 12 Mar 2025 19:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741809077; cv=none; b=hRJAsCHtdcf4KJK3C+a1FpdUKui0gf8l5/PbPzd4dbp6DVxSf/cP9+h3IVsqk3vfEMM52zElkpMmmKXWmqLOdEICDFZ7Mg/DDwwUP2I3XfZrK4m+4TTLFVI/SfIOUX7okandZsWfgFnL0q6e3W31akQyDnHMAxuLOf6mjRfA5pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741809077; c=relaxed/simple;
	bh=SRoUV3eMk6edbVaDQv5PueMlnjvLSGvEzLVeIeX4V/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rU9tcE4YyKWHc10AQeItnw1XbDO+PHYXyFCJVDzHv8qM4/oaOcnCGUp2Owfa9721MKCZ/l3Efk5BKw5k2tZKoHbtrW/MtFtFDb5DcsdNa6zBJgT+vKyANAs7fyA62GlHylrnixu0GB6rf0FIYlsbWPQ3t/jfJSXlLZd/13vEiyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LBJFa6O0; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741809076; x=1773345076;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=SRoUV3eMk6edbVaDQv5PueMlnjvLSGvEzLVeIeX4V/Q=;
  b=LBJFa6O0Gq94pnFFdaC6Xx0MPiGbABjmgQQmNlj6THt+bDeRwhFuPojv
   kOIh8bQhsMLACeViSVxHg1urWWbnpsbZlrNu3DIhFzVaF7MrGvMPke6qh
   GWJ88/Q3jgxhpwJU0Sbm9iIZEGsaCG5Ezpsmn3gRvFhCHUWaJeGOKrVXM
   2s6xtoelTunjV3gOfZchm9eAHqjbwMet8suIlvMONyvGRqx0YuDWtj//c
   PRqG4VmQzt/5gbFzHFWl6lBqK4+CvmN4t01D7GSY1seXReFvAkkzBDlMZ
   jEKiJNrLv6S6v3MpQDgu2ZWQB0mLBDsDc5H9juQjYO/5P01s1vNybaPaL
   w==;
X-CSE-ConnectionGUID: Nsyi+gLOSgaJlqXrhDoMNg==
X-CSE-MsgGUID: HfgrZareQsSgJl9E6TXptw==
X-IronPort-AV: E=McAfee;i="6700,10204,11371"; a="42815589"
X-IronPort-AV: E=Sophos;i="6.14,242,1736841600"; 
   d="scan'208";a="42815589"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2025 12:51:15 -0700
X-CSE-ConnectionGUID: mAuhRIanQJCNL6HZOC82OA==
X-CSE-MsgGUID: 6kKyUx38RoKGvr2m8InV2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,242,1736841600"; 
   d="scan'208";a="125804140"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2025 12:51:10 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tsS6d-00000001yNT-0W8I;
	Wed, 12 Mar 2025 21:51:07 +0200
Date: Wed, 12 Mar 2025 21:51:06 +0200
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
Message-ID: <Z9Hlqh7opZHvkSX0@smile.fi.intel.com>
References: <ABAEA9D0-97CB-4ADD-9606-A12D5815335A@live.com>
 <376C9BD3-2F41-4511-BE52-1B8468FE2CB3@live.com>
 <b74df4b5-ecda-45ba-a98a-c84b0a29e380@suse.de>
 <PN3PR01MB9597AC6A02B0BF873920D94CB8D02@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <9092a9ed-aecf-40bd-9d15-b53d60d035b5@suse.de>
 <PN3PR01MB959715C19BCEA54426D24934B8D02@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <ff3a9c58-5c7a-4c48-8a9e-cc828a43baed@app.fastmail.com>
 <PN3PR01MB9597E5C609290DB1A967263CB8D02@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <Z9HgVn-XELC065w0@smile.fi.intel.com>
 <PN3PR01MB959786A68923B2D471C129E6B8D02@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <PN3PR01MB959786A68923B2D471C129E6B8D02@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Mar 12, 2025 at 07:35:54PM +0000, Aditya Garg wrote:
> > On 13 Mar 2025, at 12:58 AM, Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> > On Wed, Mar 12, 2025 at 07:14:36PM +0000, Aditya Garg wrote:
> >>>> On 12 Mar 2025, at 9:05 PM, Sven Peter <sven@svenpeter.dev> wrote:
> >>> On Wed, Mar 12, 2025, at 13:03, Aditya Garg wrote:

...

> >>> I don't have a strong opinion either way: for SMC I just need to print
> >>> FourCC keys for debugging / information in a few places.
> >>> 
> >>> I'm preparing the SMC driver for upstreaming again (after a two year delay :-()
> >>> and was just going to use macros to print the SMC FourCC keys similar to
> >>> DRM_MODE_FMT/DRM_MODE_ARG for now to keep the series smaller and revisit
> >>> the topic later.
> >>> 
> >>> Right now I have these in my local tree (only compile tested so far):
> >>> 
> >>> #define SMC_KEY_FMT "%c%c%c%c (0x%08x)"
> >>> #define SMC_KEY_ARG(k) (k)>>24, (k)>>16, (k)>>8, (k), (k)
> >> 
> >> That seems to be a nice alternative, which I guess Thomas was also suggesting.
> > 
> > I don't think it's "nice". Each of the approaches has pros and cons.
> 
> I would prefer vsprintf, but if it's not there, that remains as nice right?

Nope, it remains us with the only approach (besides copy'n'paste everywhere
which is error prone).

> > You can start from bloat-o-meter here and compare it with your %p extension.
> > 
> > Also, can you show the bloat-o-meter output for the vsprintf.c?
> 
> vsprintf isn't a kernel module, is it? I'll have to compile a new kernel I guess.

You can just compile one file. We need an object out of it, we don't it to be
linked.

> >>> which are then used like this:
> >>> 
> >>>   dev_info(dev,
> >>>       "Initialized (%d keys " SMC_KEY_FMT " .. " SMC_KEY_FMT ")\n",
> >>>        smc->key_count, SMC_KEY_ARG(smc->first_key),
> >>>        SMC_KEY_ARG(smc->last_key));

-- 
With Best Regards,
Andy Shevchenko



