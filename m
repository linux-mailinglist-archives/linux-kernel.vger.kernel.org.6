Return-Path: <linux-kernel+bounces-401644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B5839C1D4C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 13:48:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31F3FB24355
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 12:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38E2C1E7C2E;
	Fri,  8 Nov 2024 12:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WhkIDTxa"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B8631E2312
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 12:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731070096; cv=none; b=kSXhUXcjB9OzS5iyJsaVigYtyrchOFDZ9KTA2yeRk3cCfgZM+DogyOxV4SY6BPecjhWo5ZbwUplOOzq3r7F4YLmlfrIBgXNYJYqOtxemPrzSM5nP/YLgOifczi+BhYajCv7SiT1kOteFj6gLV8slBXCklKomucD5coef/jTmtnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731070096; c=relaxed/simple;
	bh=AD8jJcdDP/sbSzXuaWn942hLnQm9QFhXa3EwbSQ26e0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DrD/nH/VrqpscZ08Fc9O6QwqND81b6a6qUldICxUwTGhL9raL4VSo2yuRu9i7T/q+N2rUKwSNJpaNlO5ZRDtshgf/wU6lVJ8ggp1Y8yJRORo9yGTEruLiTvkWh9/DTcY4oRuBbrb4wdUXgfOsI/CUJW/HhzUENWzIaF3S0m2uDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WhkIDTxa; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731070095; x=1762606095;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=AD8jJcdDP/sbSzXuaWn942hLnQm9QFhXa3EwbSQ26e0=;
  b=WhkIDTxaF8LffXCDXbR+dUMxFBM7tn15dkYJboYi6dSTLp1Hb7bVMOpp
   GGPU6u9w3Bkr2ox8EVWbQZB+D/JrF/Ueb4SKhx8psNG1Qo7HTxI2TVES5
   yJw09BvX0mkMB1Hv3sUuEVcUY/XWrNVo3k4FY+hEzJPjBN1Mf2zRZx8xq
   bzwj9KAD+Hsy2kpzn7A+8Ld0rEykFXGwUySdxk6KDZvt/UOcbiX6D42Z7
   lLRP+sbRuaPR1HGM4MC/QLgKBePIFQ4FCqvfFYqW88NaQ2/CwUpX+tcrK
   rOyB6Qd3b+auUL3FW5RZuX2lxczgzBiOkJkxOZ20WYVRpq1HPDs47+q5J
   w==;
X-CSE-ConnectionGUID: mxSEO1LPQU+5c5sHYr1bqQ==
X-CSE-MsgGUID: YpDZBu/2ReWgH51jxzWeww==
X-IronPort-AV: E=McAfee;i="6700,10204,11250"; a="30367770"
X-IronPort-AV: E=Sophos;i="6.12,137,1728975600"; 
   d="scan'208";a="30367770"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2024 04:48:14 -0800
X-CSE-ConnectionGUID: FRYjcacnQ0iFl1HKhPgHXQ==
X-CSE-MsgGUID: 1izRAXw7Sa2ZyNaOnFfqKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,137,1728975600"; 
   d="scan'208";a="90411249"
Received: from smile.fi.intel.com ([10.237.72.154])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2024 04:48:11 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1t9OPH-0000000Cc4T-3siz;
	Fri, 08 Nov 2024 14:48:07 +0200
Date: Fri, 8 Nov 2024 14:48:07 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH v3 1/1] x86/cpu: Make sure flag_is_changeable_p() is
 always being used
Message-ID: <Zy4Ih3rW7eiyFAsJ@smile.fi.intel.com>
References: <20240910084356.1518209-1-andriy.shevchenko@linux.intel.com>
 <Zy3Z3kYOOV3PzG8M@smile.fi.intel.com>
 <52362D81-CE7E-4F06-AA1E-B8C55933B4B4@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52362D81-CE7E-4F06-AA1E-B8C55933B4B4@zytor.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Nov 08, 2024 at 12:50:49PM +0100, H. Peter Anvin wrote:
> On November 8, 2024 10:29:02 AM GMT+01:00, Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> >On Tue, Sep 10, 2024 at 11:42:42AM +0300, Andy Shevchenko wrote:
> >> When flag_is_changeable_p() is unused, it prevents kernel builds
> >> with clang, `make W=1` and CONFIG_WERROR=y:
> >> 
> >> arch/x86/kernel/cpu/common.c:351:19: error: unused function 'flag_is_changeable_p' [-Werror,-Wunused-function]
> >>   351 | static inline int flag_is_changeable_p(u32 flag)
> >>       |                   ^~~~~~~~~~~~~~~~~~~~
> >> 
> >> Fix this by moving core around to make sure flag_is_changeable_p() is
> >> always being used.
> >> 
> >> See also commit 6863f5643dd7 ("kbuild: allow Clang to find unused static
> >> inline functions for W=1 build").
> >
> >Any comments on this? Can it be applied?
> 
> Incidentally, this really should be "unsigned long" rather than u32, although
> I believe it is only used on 32 bits.

I can fix this in v4, does it warrant your Rb / Ack?

-- 
With Best Regards,
Andy Shevchenko



