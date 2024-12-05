Return-Path: <linux-kernel+bounces-433915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C6AA19E5EB4
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 20:21:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DBBA1885363
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 19:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C74BB229B2B;
	Thu,  5 Dec 2024 19:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IwkJkZy3"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEE52229B1F;
	Thu,  5 Dec 2024 19:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733426469; cv=none; b=Ya9vuy62LV7whQk8UQTXD3drScwrZkjTBJ31z3RqXp7qlLHnkPl553feJsl0V/oalyqT7XDjh+oY86UDxmfYDyn39pcSq5fs0JxWMvSODkxrrNc3sW+IJgS54Gpn2m6qEQX3gt49pFfsoFYbqQ1sHHS1xadPSq4g4ENWmYziFCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733426469; c=relaxed/simple;
	bh=X/cKBT1xamce8ZPdE27n3xgo3YoP/gZ1JBfENVQ+vCc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aXJ3oarNY8c+J8ywfhx59ndcdqQXIFTzuz+j1dQLcUFtd0BvcpwZY2q5xu3xIeNcBhv/2s9AXiqmUmH2D5IAp9e7NwSn46wqZOzUrAZAVPJvssaISjAtRLENrVTnE4VpPiIc7/r0WfHFWpPHWCVdEe8ah7rv/0nQTKIKiYh5fzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IwkJkZy3; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733426467; x=1764962467;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=X/cKBT1xamce8ZPdE27n3xgo3YoP/gZ1JBfENVQ+vCc=;
  b=IwkJkZy3o5/t1G6UEGbcIienUYwgaJkDDgpeUEH4JevlBGqyJ0+BBg6n
   3AtFOjHjhcJuTJS4Fn8Wt0z+tTIC/YoXApJidPLqh4IElmKZ/x1RvQs7U
   TUNfCoWLyNJVQPPc48bmzz9escX4JhcX+18mbysXOWO4e6daerXVnik6v
   A1d/C9fcthGliXdmnYU83bAHJSaPGrNvPEuk4pjVjEN05l+AbEy26zR/6
   8RrWZ3bOlaNtxryV1oggFd8yoCHZc+bnhmrJjepj8qeINluvDAUwRgcy2
   mkY0WISTLsxZTEEXoiYXuoGxcOqJ/mg+0fBUDdjx42ScRzSG+2Z8WfAR6
   Q==;
X-CSE-ConnectionGUID: x5MSHbygRkiW85t1tk7Yog==
X-CSE-MsgGUID: Fw8SVSxGS2GBXR/zYGeVbQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11277"; a="33088360"
X-IronPort-AV: E=Sophos;i="6.12,211,1728975600"; 
   d="scan'208";a="33088360"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2024 11:21:06 -0800
X-CSE-ConnectionGUID: wrssc6j+RPCfBOqrD+2JMg==
X-CSE-MsgGUID: +Q3wDQnnRveQCKAj+RgqPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,211,1728975600"; 
   d="scan'208";a="94393982"
Received: from smile.fi.intel.com ([10.237.72.154])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2024 11:21:05 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tJHPK-00000004BTQ-160g;
	Thu, 05 Dec 2024 21:21:02 +0200
Date: Thu, 5 Dec 2024 21:21:02 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
Cc: Matthias Maennich <maennich@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Masahiro Yamada <masahiroy@kernel.org>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] doc: module: DEFAULT_SYMBOL_NAMESPACE must be
 defined before #includes
Message-ID: <Z1H9Hpj-uK6-l9yA@smile.fi.intel.com>
References: <cover.1733305665.git.ukleinek@kernel.org>
 <3dd7ff6fa0a636de86e091286016be8c90e03631.1733305665.git.ukleinek@kernel.org>
 <Z1Fbrbjx-mNTnV0k@smile.fi.intel.com>
 <td6actwt6wzbutyo6ujv5wmpoieyovtbpqqcmq45twfzhwyca3@hpybcti24ndw>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <td6actwt6wzbutyo6ujv5wmpoieyovtbpqqcmq45twfzhwyca3@hpybcti24ndw>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Dec 05, 2024 at 12:21:26PM +0100, Uwe Kleine-König wrote:
> Hello Andy,
> 
> On Thu, Dec 05, 2024 at 09:52:13AM +0200, Andy Shevchenko wrote:
> > On Wed, Dec 04, 2024 at 11:01:11AM +0100, Uwe Kleine-König wrote:
> > > The definition of EXPORT_SYMBOL et al depends on
> > > DEFAULT_SYMBOL_NAMESPACE. So DEFAULT_SYMBOL_NAMESPACE must already be
> > > available when <linux/export.h> is parsed.
> > 
> > > -within the corresponding compilation unit before any EXPORT_SYMBOL macro is
> > > -used.
> > > +within the corresponding compilation unit before the #include for
> > > +<linux/export.h>.
> > 
> > And how do I know where it is included in the current state of affairs with the
> > dependency hell in the kernel?
> > 
> > I suggest to reword it to something like "before any global inclusions", the
> > best probably is to repeat the piece from pr_fmt() / dev_fmt() documentation
> > (if any).
> 
> Well, "before <linux/export.h>" is the accurate thing you have to
> ensure. "before any global inclusion" is the safe and easy thing to do
> to achieve that. Maybe:
> 
> 	...
> 	within the corresponding compilation unit before the #include for
> 	<linux/export.h>. Typically it's placed before the first
> 	#include.

The below is excerpt for pr_fmt():

---8>----
Besides being more concise than the equivalent printk() calls, they can use a
common definition for the format string through the pr_fmt() macro. For
instance, defining this at the top of a source file (before any ``#include``
directive)::

  #define pr_fmt(fmt) "%s:%s: " fmt, KBUILD_MODNAME, __func__

---8>----

> ?


-- 
With Best Regards,
Andy Shevchenko



