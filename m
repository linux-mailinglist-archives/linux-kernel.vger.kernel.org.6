Return-Path: <linux-kernel+bounces-307458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA70F964DD0
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 20:38:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E9D51F22E57
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 18:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EF181B9B45;
	Thu, 29 Aug 2024 18:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aHrCZCM/"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F23BB1B8EBD
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 18:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724956675; cv=none; b=X4s7xCmDtp88gUJ1cJQG7AKfScNgaGygaTrkJRj6XZOKJyNlBSo1aN2rrvja9oeFTuq3HzHsFFBNy1FRGsUziHIZYNydz/mDa7+pK/TEUBtyqgC/N7RgI+X3vByjJcFA33DXZSkcrL1KYutxE/79AfBAryApZVruGYzvh+wicBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724956675; c=relaxed/simple;
	bh=clzzPvj3fGxThoMYcayjVCLtB/1hnsi9t1c+TqRgB+g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bSqUBdIWAFAf8tHs9pqqdFYtR8MbBO/r8681NXZi4wPgtWFG9BAirNo3u+yna73OjyIzx2KSDX3CMWqfg6DDGy3NVo/BLOYr3MpEur7lCjGxnXVy09RmwIBIV0C2/t4mgZoNmHBSGNW/ZkLekN+gJjXQFwh+kftNd6S8psZ0S40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aHrCZCM/; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724956673; x=1756492673;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=clzzPvj3fGxThoMYcayjVCLtB/1hnsi9t1c+TqRgB+g=;
  b=aHrCZCM/ASyxj7gih+fJQK7Z+x9qbSXO+RKzIun2QehZx0EixcfAmhsl
   R7q0ChXCSFE4xmOqPrSJqofcxwm9b6Yq7T3THVBrRUEHm4DColYq/KXbX
   da9Dd5VsIN7VAD+AcvI7dEhaSNuWMVcWojaun6LKrbY8Rn7Uov891MIYg
   2CctqkM8+ZNV5fec11uXUx6UzCm5inOUUnLyqeab8CSvoP1dylRGBJZVu
   pJNX7IsRYWThBx2haU0q0oOo51FnSbAAO0ScXk6WzsczZ4sxSsMPCYkAh
   Zds6E8fwqkjYTEgXTuTLp19xV6wGpagMwUgMa5cSjmg81dksYZlBKy7VU
   g==;
X-CSE-ConnectionGUID: jPSCHJaWQF+BdJpy6uaiqQ==
X-CSE-MsgGUID: Wfh0QmXrQyCNRgFqrFaGwg==
X-IronPort-AV: E=McAfee;i="6700,10204,11179"; a="23717544"
X-IronPort-AV: E=Sophos;i="6.10,186,1719903600"; 
   d="scan'208";a="23717544"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2024 11:37:43 -0700
X-CSE-ConnectionGUID: Yji/QOXNS4GM/OSmTxt2Ew==
X-CSE-MsgGUID: z0CDDVojSuWX0uXbvG9YHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,186,1719903600"; 
   d="scan'208";a="68565385"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.246.43])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2024 11:37:39 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Nathan Chancellor <nathan@kernel.org>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>
Cc: Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Joonas Lahtinen
 <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH v1 0/2] drm/i915/fence: A couple of build fixes
In-Reply-To: <20240829182255.GA1468662@thelio-3990X>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20240829155950.1141978-1-andriy.shevchenko@linux.intel.com>
 <87cylrwahb.fsf@intel.com> <ZtCnhXwtO-gd1fMf@smile.fi.intel.com>
 <ZtC5oXSzUuuIgLiQ@smile.fi.intel.com>
 <20240829182255.GA1468662@thelio-3990X>
Date: Thu, 29 Aug 2024 21:37:34 +0300
Message-ID: <87a5gvw4y9.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, 29 Aug 2024, Nathan Chancellor <nathan@kernel.org> wrote:
> On Thu, Aug 29, 2024 at 09:10:41PM +0300, Andy Shevchenko wrote:
>> On Thu, Aug 29, 2024 at 07:53:25PM +0300, Andy Shevchenko wrote:
>> > On Thu, Aug 29, 2024 at 07:38:08PM +0300, Jani Nikula wrote:
>> > > On Thu, 29 Aug 2024, Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
>> > > > With CONFIG_WERROR=y and `make W=1` build fails on my x86_64 machine.
>> > > > This is due to some unused functions. Hence these quick fixes.
>> > > 
>> > > Since when have we been getting the warnings for static inlines?
>
> Since commit 6863f5643dd7 ("kbuild: allow Clang to find unused static
> inline functions for W=1 build"). clang warns about unused static inline
> functions in .c files, unlike GCC (they both do not warn for functions
> coming from .h files). This difference is worked around for the normal
> build by adding '__maybe_unused' to the definition of 'inline' but
> Masahiro wanted to disable it for W=1 to allow this difference to find
> unused/dead code. There have not been too many complaints as far as I am
> aware but I can see how it is surprising.

Heh, I was just going to reply citing the same commit.

I occasionally build with clang myself, and we do enable most W=1 by
default in the drm subsystem, so I was wondering why I hadn't hit
this. The crucial difference is that we lack -DKBUILD_EXTRA_WARN1 which
W=1 adds.

I see there's no subdir-cppflags-y, but I don't see any harm in us
adding -Wundef and -DKBUILD_EXTRA_WARN1 to subdir-ccflags-y. After we
fix the fallout, of course. Do you?

I don't much like the __maybe_unused stuff, but I guess it's fine as a
stopgap measure, and then we can grep for that when running out of
things to do. :p

The TL;DR is,

Reviewed-by: Jani Nikula <jani.nikula@intel.com>

on the series.

BR,
Jani.

-- 
Jani Nikula, Intel

