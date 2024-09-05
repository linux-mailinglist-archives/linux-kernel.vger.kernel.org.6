Return-Path: <linux-kernel+bounces-317584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 538A796E0BA
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 19:02:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 858DC1C23B90
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 17:02:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 059B11A3041;
	Thu,  5 Sep 2024 17:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FgWr2Dkw"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 145691A304D
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 17:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725555708; cv=none; b=s7OOSGTgBfw/wrBT/e3wFnrggY3u86ed0yKVD5Y8cbafmidM03ATax0iNs0LCdtLuI1cecqHrrnNHrvFMIcXjbxUCIHI041zGniRRjwdKJmEs5IQTlKyXjPIrhP5AZrwFRelAbfDFXjZ+HaAj4G20QGT7Ofk8HgwvZEVDD3m2GA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725555708; c=relaxed/simple;
	bh=7aNNO97plgO44jLqRSUeQzdS2MqW2ZCGfSpP/lTtvgg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MzaB0NyzHh7bum0tDiNpWXiRlm6QqVHRcn0bZs91QIinxgxtTDlkXVfr77XWzaxl2ZV8t5lAeRTQcVBXQ2YElpj66RYRJKOsDDAsIUL297MKwXYwyDE1vCzyOJsusAtF6q+Hle97Rb8PXxFYMG9QSEiCN7vo4vSw/KOnaNPLsrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FgWr2Dkw; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725555707; x=1757091707;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7aNNO97plgO44jLqRSUeQzdS2MqW2ZCGfSpP/lTtvgg=;
  b=FgWr2DkwyMSjCmdsC2LQX+VEmdB0JBUOEjWlJiEcJiq8GqOawu4oGAZm
   Ayrq4fEABPyela//tGHU4eZ0nXn2fcu4bdnVhY84h6Jz47YDErunzdZYS
   DLGVN3qwlTuLtIE/QmHMz1hUT3UyZfRt8E0EQho5whfeu9FkLXZ1L2wHt
   qm+XcMYxyCT4c6l3hnHOSljAqRcqDYiCQTpoGDS1zGzUXcfIAXEKF8fbe
   N5Mv/rNKzJuUIoCQ8UXCVdNY6lYh9AC6hL7V5HcnoJNwcKidu5vbKdSfg
   EJ3P9v9avQEwhwix6zQE7FFB4xAWYU3zwO672OQgz1HNXY7dGyGZLhQ2Z
   A==;
X-CSE-ConnectionGUID: HgdXJkxxSz6DGBz9/6Vh8A==
X-CSE-MsgGUID: 3ZjcClPfRGOaTBNNKCqisA==
X-IronPort-AV: E=McAfee;i="6700,10204,11186"; a="24163663"
X-IronPort-AV: E=Sophos;i="6.10,205,1719903600"; 
   d="scan'208";a="24163663"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2024 10:01:30 -0700
X-CSE-ConnectionGUID: 6pFiR2YrQq2riDLwhz3vfg==
X-CSE-MsgGUID: 7xWWu7dATcG2TP9ibgmNPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,205,1719903600"; 
   d="scan'208";a="65337496"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2024 10:01:26 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1smFrH-00000005TiG-32ah;
	Thu, 05 Sep 2024 20:01:23 +0300
Date: Thu, 5 Sep 2024 20:01:23 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Cc: Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>
Subject: Re: [PATCH v1 1/1] x86/cpu: Mark flag_is_changeable_p() with
 __maybe_unused
Message-ID: <Ztnj40_A18uWiwU4@smile.fi.intel.com>
References: <20240905165859.254387-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240905165859.254387-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Sep 05, 2024 at 07:58:58PM +0300, Andy Shevchenko wrote:
> When flag_is_changeable_p() is unused, it prevents kernel builds
> with clang, `make W=1` and CONFIG_WERROR=y:
> 
> arch/x86/kernel/cpu/common.c:351:19: error: unused function 'flag_is_changeable_p' [-Werror,-Wunused-function]
>   351 | static inline int flag_is_changeable_p(u32 flag)
>       |                   ^~~~~~~~~~~~~~~~~~~~
> 
> Fix this by marking it with __maybe_unused.
> 
> See also commit 6863f5643dd7 ("kbuild: allow Clang to find unused static
> inline functions for W=1 build").

...and it should be done for 64-bit case.

-- 
With Best Regards,
Andy Shevchenko



