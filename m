Return-Path: <linux-kernel+bounces-559039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E4ADAA5EEA5
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 09:57:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF6CD7A8DEE
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 08:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EDE8264602;
	Thu, 13 Mar 2025 08:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fXsMI9tk"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C05E5263F21;
	Thu, 13 Mar 2025 08:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741856216; cv=none; b=XT0eMpMWAKzulfCUCHpOUDgXXfXb0zsRGkS3EneBk0jqFnk6RJyWb0o3nKt66lG+5n1xX4Mk+wTFuC1PGLwaWRyOVl+wFciZ5tUsznaUPlYuonAyYboVMioeXEq0KW9VzNMOdhatZi+5KkjpmhWqodVaRgU9yKIZVYWaVD8lDlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741856216; c=relaxed/simple;
	bh=SQM3zpDeZQPCL/TOKD7Cr+jhtK+DlHqqKnNo1aTLtRM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JuYL8TnzO7esdWLnWJkKiX2DTUGkUPk8l4IBpQBI1fMZd4JhD3B4cm8WnkpoTtBjp6WpJlVauontfLaD+EwMwXiVoBtl5SfSLi5keQU7WX0n64qYUS7Ph6rAnIoPE3hfWyIL94Hj+Boggijq288NSwDwxj0NbkaDlPzv4RdwQNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fXsMI9tk; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741856215; x=1773392215;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=SQM3zpDeZQPCL/TOKD7Cr+jhtK+DlHqqKnNo1aTLtRM=;
  b=fXsMI9tklqQ+vEfJ57l9hi59YwTNEB/StP0vWtIvqncRXilW9sdiM+Rt
   2/xyxgY5/mJcHDGJNf8hWEevK7kHDcxw7BiQHVpaQa9gWQp5s3fMfinfi
   PU7tHLDf6p190/n1K4tTNgQfdhVUPnxDLjHwJSJPdttHRGcpW+ICNRKhc
   d0lUAYicAmDlNoOS3PV/4va4dXm+Pm201ub5W0A1plQNEmAHjl/vDWRDL
   1mo9fhgQPpgdYQUZwIgDKZpZnGhDzDPXrj3+CiDLvpPKcUlnB27H1/34r
   s4OppI1p3x3n3Bv2kDI4voST4ukJqlVkuZlngSnOo9vE4ZplE8V6iRiBU
   w==;
X-CSE-ConnectionGUID: 3oOgnovVTGGSJBw8T2QbNg==
X-CSE-MsgGUID: e0aodzN3Qf6nwkG2a405jw==
X-IronPort-AV: E=McAfee;i="6700,10204,11371"; a="60503242"
X-IronPort-AV: E=Sophos;i="6.14,244,1736841600"; 
   d="scan'208";a="60503242"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2025 01:56:54 -0700
X-CSE-ConnectionGUID: Z88IionqRJSJFQ6JE494Og==
X-CSE-MsgGUID: JmCaoyouS5Cep8IvRsdnJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,244,1736841600"; 
   d="scan'208";a="121104151"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2025 01:56:49 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tseMv-000000027hM-29FB;
	Thu, 13 Mar 2025 10:56:45 +0200
Date: Thu, 13 Mar 2025 10:56:45 +0200
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
Message-ID: <Z9KdzZUxs3vlwp0Z@smile.fi.intel.com>
References: <b74df4b5-ecda-45ba-a98a-c84b0a29e380@suse.de>
 <PN3PR01MB9597AC6A02B0BF873920D94CB8D02@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <9092a9ed-aecf-40bd-9d15-b53d60d035b5@suse.de>
 <PN3PR01MB959715C19BCEA54426D24934B8D02@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <ff3a9c58-5c7a-4c48-8a9e-cc828a43baed@app.fastmail.com>
 <PN3PR01MB9597E5C609290DB1A967263CB8D02@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <Z9HgVn-XELC065w0@smile.fi.intel.com>
 <47AE7FCD-0F30-4379-ADE9-090A15ACD58F@live.com>
 <Z9Kb8zMJgmSP-rgD@smile.fi.intel.com>
 <PN3PR01MB959780176C0B16C36FBD59C3B8D32@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <PN3PR01MB959780176C0B16C36FBD59C3B8D32@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Mar 13, 2025 at 08:53:28AM +0000, Aditya Garg wrote:
> > On 13 Mar 2025, at 2:19 PM, Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> > On Thu, Mar 13, 2025 at 07:26:05AM +0000, Aditya Garg wrote:
> >>>> On 13 Mar 2025, at 12:58 AM, Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> >>> On Wed, Mar 12, 2025 at 07:14:36PM +0000, Aditya Garg wrote:
> >>>>> On 12 Mar 2025, at 9:05 PM, Sven Peter <sven@svenpeter.dev> wrote:
> >>>>> On Wed, Mar 12, 2025, at 13:03, Aditya Garg wrote:

...

> >>>>> I don't have a strong opinion either way: for SMC I just need to print
> >>>>> FourCC keys for debugging / information in a few places.
> >>>>> 
> >>>>> I'm preparing the SMC driver for upstreaming again (after a two year delay :-()
> >>>>> and was just going to use macros to print the SMC FourCC keys similar to
> >>>>> DRM_MODE_FMT/DRM_MODE_ARG for now to keep the series smaller and revisit
> >>>>> the topic later.
> >>>>> 
> >>>>> Right now I have these in my local tree (only compile tested so far):
> >>>>> 
> >>>>> #define SMC_KEY_FMT "%c%c%c%c (0x%08x)"
> >>>>> #define SMC_KEY_ARG(k) (k)>>24, (k)>>16, (k)>>8, (k), (k)
> >>>> 
> >>>> That seems to be a nice alternative, which I guess Thomas was also suggesting.
> >>> 
> >>> I don't think it's "nice". Each of the approaches has pros and cons.
> >>> You can start from bloat-o-meter here and compare it with your %p extension.
> >>> 
> >>> Also, can you show the bloat-o-meter output for the vsprintf.c?
> >> 
> >> Here are your outputs:
> > 
> > Thank you!
> > 
> >> ---------------------------------------------------------------------
> >> For appletbdrm:
> >> 
> >> aditya@MacBook:~/linux$ ./scripts/bloat-o-meter $P4 $MACRO
> >> add/remove: 0/0 grow/shrink: 1/1 up/down: 64/-19 (45)
> >> Function                                     old     new   delta
> >> appletbdrm_read_response                     395     459     +64
> >> appletbdrm_probe                            1786    1767     -19
> >> Total: Before=13418, After=13463, chg +0.34%
> > 
> > This is enough, no need to repeat this for every parameter.
> > 
> >> ---------------------------------------------------------------------
> >> For vsprintf:
> >> 
> >> aditya@MacBook:~/linux$ ./scripts/bloat-o-meter $OLD $NEW
> >> add/remove: 0/0 grow/shrink: 1/0 up/down: 220/0 (220)
> >> Function                                     old     new   delta
> >> fourcc_string                                479     699    +220
> >> Total: Before=26454, After=26674, chg +0.83%
> > 
> > So, we get +220 bytes vs +43 bytes. It means if we found 5+ users, it worth
> > doing.
> 
> Will it also depend upon the number of times it's being used? In appletbdrm,
> it is being used 3 times. Probably more in Asahi SMC.

Right, it depends on the usage count. Also on different architectures it may
give different results. On 32-bit it probably gives better statistics.

> >>>>> which are then used like this:
> >>>>> 
> >>>>> dev_info(dev,
> >>>>>     "Initialized (%d keys " SMC_KEY_FMT " .. " SMC_KEY_FMT ")\n",
> >>>>>      smc->key_count, SMC_KEY_ARG(smc->first_key),
> >>>>>      SMC_KEY_ARG(smc->last_key));

-- 
With Best Regards,
Andy Shevchenko



