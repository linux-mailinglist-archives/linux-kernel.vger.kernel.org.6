Return-Path: <linux-kernel+bounces-287025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D733D9521C9
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 20:04:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CF8D1F21769
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 18:04:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 615571BD036;
	Wed, 14 Aug 2024 18:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iGN0386R"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 853541BB699
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 18:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723658679; cv=none; b=LUe5IHOqYchL09P1pVzqCTx70R5hlp7Z9RoHoj0XK7RcGIJQ0PpspvPThns+Pj87T6/LmrUsB9aokD2SILPdDfIUhOxvsZuQP69H6LoN+0MihEaObz2U9weRfaLeRMTFbvQLr84b7tDNnrkDAw3kvBGMMD3urt1kJlitQYe5bJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723658679; c=relaxed/simple;
	bh=At677fhWlanLpG6mtxJGtZbeN9D+2cS3dulKaVfdZg4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oMZlYsWd04f3JHYl++2TEZ7hB7a/pkg3HL7W0/HvQwLDAw+XPOeItGl8fmOEoV4JhaVXut7clVKlxC7SdJvScPJiUGQD4hC2h/Ck4HvavTQKZeU3ORzQGLX+U1op5cVfI8bp6jYXSxDIwcQn4QTjWYmIG1xdmO2wHDQrPcMMK9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iGN0386R; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723658677; x=1755194677;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=At677fhWlanLpG6mtxJGtZbeN9D+2cS3dulKaVfdZg4=;
  b=iGN0386R3AYw487NE4UQWvtcQx+DoClkmVu+L0KZGAVkyzoIvxkVMa1b
   ja9biE37Y2304WebLjrhBFhOrMXgaSICYJWShJA8IB9UWzMRVEXQ1ktRU
   UOMFRzEK1A1PNqphLmdkhIlYj574EzZJdN8AP65IB3ugykLXUXevyWeib
   14lCae/OGMnW+qY7wKeFFYAw0hGH9ANM5AsqSdNIy9mu8yKze0uLry2f5
   Wp83frsl0Zd5W8h48oAcDbVAPq1Y4I4k34Xk8ymTSwGcmHDg//2J2CYfy
   d+purKIdKqFjhmqGnJ18l3OT9Z9ICGo+w6KGhUqfdsgOcWS1kx9W15WkV
   A==;
X-CSE-ConnectionGUID: GNeW389dQamSDFb6YRVLQg==
X-CSE-MsgGUID: JXEqT4CNQ8asTHlaeecmCw==
X-IronPort-AV: E=McAfee;i="6700,10204,11164"; a="22051520"
X-IronPort-AV: E=Sophos;i="6.10,146,1719903600"; 
   d="scan'208";a="22051520"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2024 11:04:37 -0700
X-CSE-ConnectionGUID: qtsMKiiRRcK33NckGV4wBQ==
X-CSE-MsgGUID: Ttk86e14Q1qn5H1amE6iQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,146,1719903600"; 
   d="scan'208";a="59063940"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2024 11:04:36 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1seIML-0000000FHLt-0y4K;
	Wed, 14 Aug 2024 21:04:33 +0300
Date: Wed, 14 Aug 2024 21:04:32 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: kernel test robot <lkp@intel.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Herve Codina <herve.codina@bootlin.com>
Subject: Re: WARNING: modpost: vmlinux: section mismatch in reference:
 bitmap_gather+0x6b (section: .text) -> sg_mask (section: .init.rodata)
Message-ID: <ZrzxsORf3QL5FTr6@smile.fi.intel.com>
References: <202407291552.gxr1x7vB-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202407291552.gxr1x7vB-lkp@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Jul 29, 2024 at 03:06:19PM +0800, kernel test robot wrote:
> Hi Andy,
> 
> FYI, the error/warning still remains.
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   dc1c8034e31b14a2e5e212104ec508aec44ce1b9
> commit: de5f84338970815b9fdd3497a975fb572d11e0b5 lib/bitmap: Introduce bitmap_scatter() and bitmap_gather() helpers
> date:   5 months ago
> config: um-randconfig-001-20240729 (https://download.01.org/0day-ci/archive/20240729/202407291552.gxr1x7vB-lkp@intel.com/config)
> compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240729/202407291552.gxr1x7vB-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202407291552.gxr1x7vB-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>, old ones prefixed by <<):

This is dup of https://lore.kernel.org/r/202406200829.IytwLyQJ-lkp@intel.com,
where the main discussion is ongoing.

-- 
With Best Regards,
Andy Shevchenko



