Return-Path: <linux-kernel+bounces-196904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 49FC98D634B
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 15:43:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7297E1C268BB
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 13:43:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DDEC158DC5;
	Fri, 31 May 2024 13:43:33 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4370415887E
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 13:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717163012; cv=none; b=lBRqfucjqvrM+z7Cms/mYQyyptlXkBRH9Xe5aJHPljQiGEjLKTTnu0xWjVEDO5ed5/z7PyDCNyjLRwO+cGH5iTvJNmqexk59Njp6JBjb7TmyMWHRL2uUg25vWB/pXuN6+HDeyznNZe/ndgi2aaGQHsm/7EVCFCE4T+qaWhGVLdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717163012; c=relaxed/simple;
	bh=al9Ha/OrDfBziIwM4XhvpMCjLLsWKg3ELWnz6t66700=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OrRXG4fmwf4kUzMmbF99IJRydxYrQ/+vAJeoKkgN7d1wCsfrMoQ0ZIHFjVoBuT0BNdfHBtHd0MflexzUqhOyBkaSIOp2l7segv0JG+iBrPp/vXFeD+NgKZyHnikz6lsFsMUYc9EdFQ4GVmT+cZsDxbW4Pwz1pvKsniuOto3TR9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
X-CSE-ConnectionGUID: hGF9cshyST2YN+ZLXP5G6g==
X-CSE-MsgGUID: O0JE6j2TQJ2oSVvJgDxXIw==
X-IronPort-AV: E=McAfee;i="6600,9927,11088"; a="13657272"
X-IronPort-AV: E=Sophos;i="6.08,204,1712646000"; 
   d="scan'208";a="13657272"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2024 06:43:31 -0700
X-CSE-ConnectionGUID: soasy7mOQKuHne6hRgFRmQ==
X-CSE-MsgGUID: iFOsiirCRLCdwuykA4WJSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,204,1712646000"; 
   d="scan'208";a="40601440"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2024 06:43:29 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andy.shevchenko@gmail.com>)
	id 1sD2XW-0000000CTf4-3DpK;
	Fri, 31 May 2024 16:43:26 +0300
Date: Fri, 31 May 2024 16:43:26 +0300
From: Andy Shevchenko <andy.shevchenko@gmail.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Chris Packham <chris.packham@alliedtelesis.co.nz>, tzimmermann@suse.de,
	ojeda@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] auxdisplay: linedisp: Support configuring the boot
 message
Message-ID: <ZlnT_imCNdts8EOd@smile.fi.intel.com>
References: <20240530232054.3559043-1-chris.packham@alliedtelesis.co.nz>
 <CAMuHMdXGJxwRDRjKQT5aa6off9nQ5WqreK9K-QhJwhUXngYA=Q@mail.gmail.com>
 <CAHp75Ve3-JkNUuF_LT=E53WfEfxt5yizSvoD22a3OvHiPXSRJQ@mail.gmail.com>
 <CAMuHMdXg1GCAqYPy++4UjFN6QsCnfikZdvsz5=2G4j13E3DUjQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMuHMdXg1GCAqYPy++4UjFN6QsCnfikZdvsz5=2G4j13E3DUjQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, May 31, 2024 at 10:22:02AM +0200, Geert Uytterhoeven wrote:
> On Fri, May 31, 2024 at 10:16 AM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> > On Fri, May 31, 2024 at 10:45 AM Geert Uytterhoeven
> > <geert@linux-m68k.org> wrote:
> > > On Fri, May 31, 2024 at 7:28 AM Chris Packham
> > > <chris.packham@alliedtelesis.co.nz> wrote:
> > > > Like we do for charlcd, allow the configuration of the initial message
> > > > on line-display devices.

..

> > > > +#ifndef CONFIG_PANEL_BOOT_MESSAGE
> > > >  #include <generated/utsrelease.h>
> > > > +#endif
> > >
> > > The #ifndef/#endif is not really needed.
> >
> > It's needed to avoid unnecessary build of the module (in case of m).
> 
> OK.
> 
> > > As I see no real deficiencies:
> > > Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
> >
> > I believe you agree with leaving ifdeffery above.
> 
> Thanks, I agree to agree ;-)

Btw, I will take a long lasting vacations (ten weeks in a row) and most likely
won't be able to actively participate for this subsystem. Thinking about how
to proceed if something critical appears... Maybe you want a push access to the
same Git repo and in (rare) cases can handle fixes? We may ask Konstantin to
configure that on git.kernel.org.

P.S. This change doesn't seem to me as critical and there is still a chance
that I will have time to proceed, but the situation just motivated me to discuss
the possibilities.

-- 
With Best Regards,
Andy Shevchenko



