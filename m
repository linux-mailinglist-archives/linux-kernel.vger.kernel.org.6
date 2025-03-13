Return-Path: <linux-kernel+bounces-559015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DDD4A5EE5E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 09:49:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 630C97AB002
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 08:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF936262814;
	Thu, 13 Mar 2025 08:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TSFkGBUx"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2499A262D39;
	Thu, 13 Mar 2025 08:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741855744; cv=none; b=XlFexzJ7F+siBiJSg04G2WozbcpcS35PDjQBMGb0X/bEanGn+7AJoUAb5eGhOTajBJK3f9KYUXIyMMjmV/J4uDw86mgdIeAU08EIguJ4jekRwgNN/wo8r6Jeo6fjm59rViNdG1xOxQ/f1j3SsI9vYylOJwAAm4NUarB8dKVT9MA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741855744; c=relaxed/simple;
	bh=DhplvFefgm8QiLiBlqQHTiRakW6BQ00GwBaZ4P4OUbw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SC0rL4CJArGBgJ2VSRh5iQ9RBU1Rh+hCSFaMRixnpX7LqZo/Fbz4Yn2m32/Xk+ku1RpzSllSmugUHd4pYQAi3DehgdvarL0pK1FUpGGx5d7u8gMuiBID+xcJD6yRokn+J9EOCPwDkejyy+/yUYcgqvjPknHs//Q6lLY/RoMFyJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TSFkGBUx; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741855742; x=1773391742;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=DhplvFefgm8QiLiBlqQHTiRakW6BQ00GwBaZ4P4OUbw=;
  b=TSFkGBUxTZD4SaDpb4/7HkXQNFjAItZDX363w+/pfi8OX++NuEdeWWit
   98FDK8nDOpONSABPOjGpg43buKIiU4Q4FtNJ+8F9OiVxti5gWKygrLVM9
   yqD5lfLFTy+IDiZ8vE1Bw15gpj126Vl95CpsEX3s9GuD/WQ6xZ9/KxXZk
   TmnbkB8KO3hz15y+Qt9fM73Ez8fBoN8TuBfo1sb3lyrJ3L9IzNkyMvcXF
   OiiCZdoWJlRzXCEKLT7k5YOcYb8urIoEdfZSUpkk2uOcopp8bI56d4KL4
   OLGVJtgjvTCjFUoGprUJ3sCvaOJbkCjWmmBFqPLzjHZuPss6RGO8PhQko
   A==;
X-CSE-ConnectionGUID: 1c7M7zmdSDy1Wg6fQRjy/Q==
X-CSE-MsgGUID: SSdXtVsoRZ2V9ltYYVErnA==
X-IronPort-AV: E=McAfee;i="6700,10204,11371"; a="68316874"
X-IronPort-AV: E=Sophos;i="6.14,244,1736841600"; 
   d="scan'208";a="68316874"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2025 01:49:00 -0700
X-CSE-ConnectionGUID: tDr4i4hoQqKaZ8OpfjwMhQ==
X-CSE-MsgGUID: qF1/zpwCTDia6ck6gIIWNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,244,1736841600"; 
   d="scan'208";a="121811446"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2025 01:48:56 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tseFI-000000027a9-0r7A;
	Thu, 13 Mar 2025 10:48:52 +0200
Date: Thu, 13 Mar 2025 10:48:51 +0200
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
Message-ID: <Z9Kb8zMJgmSP-rgD@smile.fi.intel.com>
References: <ABAEA9D0-97CB-4ADD-9606-A12D5815335A@live.com>
 <376C9BD3-2F41-4511-BE52-1B8468FE2CB3@live.com>
 <b74df4b5-ecda-45ba-a98a-c84b0a29e380@suse.de>
 <PN3PR01MB9597AC6A02B0BF873920D94CB8D02@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <9092a9ed-aecf-40bd-9d15-b53d60d035b5@suse.de>
 <PN3PR01MB959715C19BCEA54426D24934B8D02@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <ff3a9c58-5c7a-4c48-8a9e-cc828a43baed@app.fastmail.com>
 <PN3PR01MB9597E5C609290DB1A967263CB8D02@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <Z9HgVn-XELC065w0@smile.fi.intel.com>
 <47AE7FCD-0F30-4379-ADE9-090A15ACD58F@live.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <47AE7FCD-0F30-4379-ADE9-090A15ACD58F@live.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Mar 13, 2025 at 07:26:05AM +0000, Aditya Garg wrote:
> > On 13 Mar 2025, at 12:58 AM, Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> > On Wed, Mar 12, 2025 at 07:14:36PM +0000, Aditya Garg wrote:
> >>> On 12 Mar 2025, at 9:05 PM, Sven Peter <sven@svenpeter.dev> wrote:
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
> > You can start from bloat-o-meter here and compare it with your %p extension.
> > 
> > Also, can you show the bloat-o-meter output for the vsprintf.c?
> 
> Here are your outputs:

Thank you!

> ---------------------------------------------------------------------
> For appletbdrm:
> 
> aditya@MacBook:~/linux$ ./scripts/bloat-o-meter $P4 $MACRO
> add/remove: 0/0 grow/shrink: 1/1 up/down: 64/-19 (45)
> Function                                     old     new   delta
> appletbdrm_read_response                     395     459     +64
> appletbdrm_probe                            1786    1767     -19
> Total: Before=13418, After=13463, chg +0.34%

This is enough, no need to repeat this for every parameter.

> ---------------------------------------------------------------------
> For vsprintf:
> 
> aditya@MacBook:~/linux$ ./scripts/bloat-o-meter $OLD $NEW
> add/remove: 0/0 grow/shrink: 1/0 up/down: 220/0 (220)
> Function                                     old     new   delta
> fourcc_string                                479     699    +220
> Total: Before=26454, After=26674, chg +0.83%

So, we get +220 bytes vs +43 bytes. It means if we found 5+ users, it worth
doing.

> >>> which are then used like this:
> >>> 
> >>>  dev_info(dev,
> >>>      "Initialized (%d keys " SMC_KEY_FMT " .. " SMC_KEY_FMT ")\n",
> >>>       smc->key_count, SMC_KEY_ARG(smc->first_key),
> >>>       SMC_KEY_ARG(smc->last_key));

-- 
With Best Regards,
Andy Shevchenko



