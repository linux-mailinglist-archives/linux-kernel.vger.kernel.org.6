Return-Path: <linux-kernel+bounces-529776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC34EA42AC7
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 19:13:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 071581763F3
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 18:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE61B264A89;
	Mon, 24 Feb 2025 18:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RlUwYmd5"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99FF433F3
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 18:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740420707; cv=none; b=pMkOF0hI0kJ+1lF600lzbZL0qrnSeGAKJHe64mcaQhRsHJ59UGxNWeogi7I4XmNR3QHp/q96oyH2nrxKo9AksABl4VrnFBjZDyjlBBM+jWIphmwFIvv4F5q5+bm1JUpLysGvHncE+DNuhdoHGrj0qGEwHa5HWQ4Ko4ab3Yg6wKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740420707; c=relaxed/simple;
	bh=6vwIJq36TFsrmFzwCOIaxGEWsTnkWmsv7+48wxqvu7o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kS34Jf1MmKNi8HsF76683kCBfuw31cbvGk5sX64GMIRN6U0Bohemrw0fgs0vkGASeBmyo6PpdwGSspPNhQNWUbgKhNV42P0zKp/AM5FfH9TDdeAn1GeiFDz0zr+ig9+HJdoZJvPKd/cdwa07lu5hGjrhp2Gt734sUg6vqYcAzo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RlUwYmd5; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740420706; x=1771956706;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6vwIJq36TFsrmFzwCOIaxGEWsTnkWmsv7+48wxqvu7o=;
  b=RlUwYmd5R/5y3aOXTkGiD60r5EKcj+Gkf/xHad/72/asxvminP66u6kD
   z6Rsl59h43X6I4/HW4qHFA+JOWQI52SZv/FSiIHd57y1JC2x71GerkYwq
   62JYaHRzQxorKUuFVNBUIQAIG7788P7Krm+1Q1fkDZKGdMhEW/7CHqVe4
   L1Lbv9OOXt81Gap+wKIBv1PnUFGlCI5F2F1+LX3gUzqNTv+t56Le+wSfL
   xTo+gfVgGGeVFSM/PvtavNqNyfmlFJ5vA3mCnOePye74ZQ5I+fIltqCO7
   gad4Y6brFUhsCGx/kf7qzMehquUaIeo3IFzENK+pH2NlOAEh4HYKsFnJO
   g==;
X-CSE-ConnectionGUID: BmaPwE6zTlSnFAInq43cTA==
X-CSE-MsgGUID: 2UICPywoTPeeQili3eVzWg==
X-IronPort-AV: E=McAfee;i="6700,10204,11355"; a="28784332"
X-IronPort-AV: E=Sophos;i="6.13,312,1732608000"; 
   d="scan'208";a="28784332"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2025 10:11:45 -0800
X-CSE-ConnectionGUID: Pa2ixOGuSm2Otk6dgMUccg==
X-CSE-MsgGUID: IW03Ccg7StaIxvSF69ZYxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,312,1732608000"; 
   d="scan'208";a="120755065"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2025 10:11:43 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tmcvb-0000000ElxV-3c5G;
	Mon, 24 Feb 2025 20:11:39 +0200
Date: Mon, 24 Feb 2025 20:11:39 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v1 1/1] x86/mm: Check if PTRS_PER_PMD is defined before
 use
Message-ID: <Z7y2W8tsAOPhqNfn@smile.fi.intel.com>
References: <20250224173940.219820-1-andriy.shevchenko@linux.intel.com>
 <76b8174e-3c4c-4db4-83d0-aa8d241c7afe@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <76b8174e-3c4c-4db4-83d0-aa8d241c7afe@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Feb 24, 2025 at 09:59:23AM -0800, Dave Hansen wrote:
> On 2/24/25 09:39, Andy Shevchenko wrote:
> > Compiler is not happy about PTRS_PER_PMD being undefined
> > 
> > In file included from arch/x86/kernel/head_32.S:29:
> > arch/x86/include/asm/pgtable_32.h:59:5: error: "PTRS_PER_PMD" is not defined, evaluates to 0 [-Werror=undef]
> >    59 | #if PTRS_PER_PMD > 1
> > 
> > Add a check to make sure PTRS_PER_PMD is defined before use.
> 
> Hi Andy,
> 
> From reading the "Closes:" link, it appears this is a new issue that
> originates from a new compile flag. So it doesn't seem like it's worth
> backporting.

FWIW, I haven't put any Fixes tag nor Cc: stable@ :-)
Also note this looks like both compilers complain about the same.

> Also, the _behavior_ of "#if PTRS_PER_PMD > 1" was fine, right? It
> didn't cause the logic to go backwards from what was intended, does it?
> 
> This:
> 
> 	https://gcc.gnu.org/onlinedocs/gcc-3.0.2/cpp_4.html
> 
> says: "Identifiers that are not macros, which are all considered to be
> the number zero."
> 
> Which would yield the correct behavior.
> 
> So I think this is purely a fix for new warning in new kernels. We
> shouldn't need to backport this anywhere at all.

-- 
With Best Regards,
Andy Shevchenko



