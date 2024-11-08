Return-Path: <linux-kernel+bounces-401349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C1109C1921
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 10:32:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 003191C20A2D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 09:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 275C41E1029;
	Fri,  8 Nov 2024 09:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jf/xsqBu"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33C051E0E05
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 09:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731058326; cv=none; b=V+LanQ71CMmmuB3Yoit1UcwYJ+Q3x9nFCgAgA9BInDTjR7Mzq5JXwsIRXac6TBCyGYPmaKmKi38wbUTHT20q7+IzI68e2Qn9OXY7NRBpyqV/xR/Svocx1FYP/FHeSNlLaPq8sk35gqUsxnMc+2kL6nfgfG72Z54Wd7L++Ds85AM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731058326; c=relaxed/simple;
	bh=Je9ZZ9CFGMZQKQGj3EiPzKjUT5V1O4+C4dgnzRBMpEY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fNJjWJm83n4IZT9VgUvlWU+yVjl+mt+f/Fnx9DUJ6FEUJo38lzfN81q+EElULypEXkboVUtgXu8ZaEwMr9D75L+GqeZhi7ko8wBUhl4u7jAspaCt50VpkA6NpN62EJsyjchSF1RYFMECOSn7i3S+CjEbwm0tnAB9yvYHoZkXau0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jf/xsqBu; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731058325; x=1762594325;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Je9ZZ9CFGMZQKQGj3EiPzKjUT5V1O4+C4dgnzRBMpEY=;
  b=jf/xsqBuNpJcc97faQLY/GEPtvOTVsjxNnjLgjVb9FfeOYpcy3sf17FR
   sde40fQK7NIAsP/A6Qwf3x8Dm40Yquw03QRzN7npceyOpneFgn4u6kkAB
   kKTfyk78P04fAROAMPvqtif+CvYOXl4kGKMua2SRYpjwk1hV3CpLg/UIK
   8F3pYuCV/9lbQ5S5WG1txnz1qfCiGP5uBfo8AvURwhzuTdR2jHjGV1l6Z
   LYDyuYbKc5g3DiwaY9JaHJu7l8uhu7Td3KIZQWXDjNCaoNCNFK3E2f0rf
   ssKpoovmZf+s886/FJtFgf9KScuL+evr1Gfiaf6O35IU6/eAlgkmfbjO5
   g==;
X-CSE-ConnectionGUID: qHKIqooCTkC+4g9TlZfg0A==
X-CSE-MsgGUID: dXFc+qLJQ2OKxN2sWDWK6w==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="31102915"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="31102915"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2024 01:31:07 -0800
X-CSE-ConnectionGUID: e2FT6bEBSXq8BSTQ93CwFw==
X-CSE-MsgGUID: yQeAcDm9TM+f67Wm6Rn+aQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,137,1728975600"; 
   d="scan'208";a="90348414"
Received: from smile.fi.intel.com ([10.237.72.154])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2024 01:31:03 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1t9LKV-0000000CYUU-3Jdq;
	Fri, 08 Nov 2024 11:30:59 +0200
Date: Fri, 8 Nov 2024 11:30:59 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>
Subject: Re: [PATCH v1 1/1] sched/fair: Mark cfs_bandwidth_used() and
 m*_vruntime() with __maybe_unused
Message-ID: <Zy3aU4g-lBim39CS@smile.fi.intel.com>
References: <20240905171210.267626-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240905171210.267626-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Sep 05, 2024 at 08:12:10PM +0300, Andy Shevchenko wrote:
> When cfs_bandwidth_used() is unused, it prevents kernel builds
> with clang, `make W=1` and CONFIG_WERROR=y:
> 
> kernel/sched/fair.c:526:19: error: unused function 'max_vruntime' [-Werror,-Wunused-function]
>   526 | static inline u64 max_vruntime(u64 max_vruntime, u64 vruntime)
>       |                   ^~~~~~~~~~~~
> kernel/sched/fair.c:6580:20: error: unused function 'cfs_bandwidth_used' [-Werror,-Wunused-function]
>  6580 | static inline bool cfs_bandwidth_used(void)
>       |                    ^~~~~~~~~~~~~~~~~~
> 
> Fix this by marking them with __maybe_unused (all cases for the sake of
> symmetry).
> 
> See also commit 6863f5643dd7 ("kbuild: allow Clang to find unused static
> inline functions for W=1 build").

Any comments on this? Can it be eventually applied, please?

-- 
With Best Regards,
Andy Shevchenko



