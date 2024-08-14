Return-Path: <linux-kernel+bounces-286890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C890A952008
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 18:32:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 729781F27AAF
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 16:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B80F71B9B26;
	Wed, 14 Aug 2024 16:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N6bjnwvw"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B2EF1B3756
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 16:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723653130; cv=none; b=qLxyzU3+Oc3EGXbU61EPdeWe3jtZzrrPQVWARq+YC3Db6oC7dhxrdqFajUG5nG99WSc5CmEx/NyLCgyt7m9Pa0XF7rXFzNSC1g9o1+XakbPJqGig40NPrRI8sl4Tsz2c2ad6XO5NeMfsDwUEGAo5QrQSr+XNRckyo5dqOqMrwhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723653130; c=relaxed/simple;
	bh=yd5JNvJdC5HkhmulYzfGezhr7UErN+Z7Ol0m2BqggOs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gKGFPymbL0Kl5Dg9Vl7OYxjFK4yvTtWQDa1qNJSopjKEpW9Bs5rnYpLMEqn2aJ/hkiX3PhwMC286AIwo7ftYA2JyvUfIaOzY4E8WZY9r7qOIDlgCFiAe5m58xh+6Jxw8AK9sq0c81XD0FQfY80bq1PZW4knDha/7ooccgPHXrAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N6bjnwvw; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723653128; x=1755189128;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yd5JNvJdC5HkhmulYzfGezhr7UErN+Z7Ol0m2BqggOs=;
  b=N6bjnwvwPdgBq0/6SJICI03/xFyWVR3vtoFGZG9KRFPcpV9Kr45LBJM7
   ckE/IglnCQOSLs8v38RaT4Eb6o24GKoajhG5R60CQfY33IZVNfJ1g4AtS
   yg+u+qt5bMzi0LJ3SX1Eci4X/hkQMpVs9uc1v3HjyLZ7dS7m8qNlf6smb
   GmmRq57fYJT9a3+3YDmxAEyX55zYgpbZVhk/z5AbkD5VjoGy0nVORmpoz
   wBQ/B9zgQGmcmF0N+Fhj0X0oc2M5iVttFobOaB+wcoBpShq7HrlWk5Qtp
   mNMKwe+Txy5S/fVEcrpG24yDCmEQq+dRgzM7LcfT41te6E4mEI1YfuGMs
   Q==;
X-CSE-ConnectionGUID: ojayozjrSROSyBKALBDSIg==
X-CSE-MsgGUID: EepH5fQ4Q1S3stMf5wQPqw==
X-IronPort-AV: E=McAfee;i="6700,10204,11164"; a="24786696"
X-IronPort-AV: E=Sophos;i="6.10,146,1719903600"; 
   d="scan'208";a="24786696"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2024 09:32:08 -0700
X-CSE-ConnectionGUID: ibSyp9AqRUCpmC9ewaZ5UA==
X-CSE-MsgGUID: q+sRb3TDTFSQ4ZP3HcsePg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,146,1719903600"; 
   d="scan'208";a="63489748"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2024 09:32:06 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1seGuo-0000000FFNX-3gmD;
	Wed, 14 Aug 2024 19:32:02 +0300
Date: Wed, 14 Aug 2024 19:32:02 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: kernel test robot <lkp@intel.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Yury Norov <yury.norov@gmail.com>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Herve Codina <herve.codina@bootlin.com>
Subject: Re: WARNING: modpost: vmlinux: section mismatch in reference:
 bitmap_gather+0x68 (section: .text) -> sg_mask (section: .init.rodata)
Message-ID: <ZrzcAnHNXDF2Ck6K@smile.fi.intel.com>
References: <202406200829.IytwLyQJ-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202406200829.IytwLyQJ-lkp@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

+Cc: Clang and bitmap people.

On Thu, Jun 20, 2024 at 08:54:29AM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   e5b3efbe1ab1793bb49ae07d56d0973267e65112
> commit: de5f84338970815b9fdd3497a975fb572d11e0b5 lib/bitmap: Introduce bitmap_scatter() and bitmap_gather() helpers
> date:   3 months ago
> config: um-randconfig-r123-20240620 (https://download.01.org/0day-ci/archive/20240620/202406200829.IytwLyQJ-lkp@intel.com/config)
> compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project 78ee473784e5ef6f0b19ce4cb111fb6e4d23c6b2)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240620/202406200829.IytwLyQJ-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202406200829.IytwLyQJ-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>, old ones prefixed by <<):
> 
> WARNING: modpost: missing MODULE_DESCRIPTION() in vmlinux.o
> >> WARNING: modpost: vmlinux: section mismatch in reference: bitmap_gather+0x68 (section: .text) -> sg_mask (section: .init.rodata)
> WARNING: modpost: vmlinux: section mismatch in reference: bitmap_gather+0x10b (section: .text) -> sg_mask (section: .init.rodata)
> >> WARNING: modpost: vmlinux: section mismatch in reference: bitmap_scatter+0x68 (section: .text) -> sg_mask (section: .init.rodata)
> WARNING: modpost: vmlinux: section mismatch in reference: bitmap_scatter+0x119 (section: .text) -> sg_mask (section: .init.rodata)

I have no other idea that this is a (yet another) clang compiler bug related to
the constant data.

-- 
With Best Regards,
Andy Shevchenko



