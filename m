Return-Path: <linux-kernel+bounces-358713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 043899982BE
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 11:48:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAE0D1F21B13
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 09:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A5D71BD4FD;
	Thu, 10 Oct 2024 09:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cQGqnxjt"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEFC01BCA1E;
	Thu, 10 Oct 2024 09:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728553676; cv=none; b=rwULUbKk7ZetZpua0BQlSKIrwaROyJUUAu0yJdKLwY7Yk+wniI4zE//iKO97cBUJqO4dn4ca9lIpUPIe0qrL8HPjSDnqs3mySo/i4MGfSTnIiMWk2lOsIgCKc7goHYx45GujGwjXE6qKHErSCxpMjJRodaPFZOqxhclGCcFCaX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728553676; c=relaxed/simple;
	bh=xDQtvIGrdPFT3ACTdJNy+zVmYU8ERIFuzjpHzDtQxCg=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=nkjvOlr8Lfmmr9O2xBAX8TmSB4FYkaZ2t8s6fHAjL3JWjZjZTtJl9tcwaiuR+2du5XVFYbpWjfCcrXlKmPz5QM2XABntaKb+wQBAmLI9v12+hzgNjqItAfk1+SawKbe/Dx+mQzcQzWiZP6rpdpTVL9/PcqOt4VNGcWcApB+gM84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cQGqnxjt; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728553675; x=1760089675;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=xDQtvIGrdPFT3ACTdJNy+zVmYU8ERIFuzjpHzDtQxCg=;
  b=cQGqnxjtwN4dm/W5Ox+em0TGqQLtjK9ZefZNRcAO0Ugb/kfv/4EZU34x
   bLI2TGTbEUg/Y9Xbtd9kZevNdKDNFGueNUM6OR83quUB3dBTLkg9qgrBG
   IDTs51TvDk7Os/c2h+uJNSb52CNDkFMNBVEwdBLNQqV0bPdgMDs4jBQe+
   M+qWRWt8FrFret2WXeHrw3+7qNF7HqoZPYUkSW6DYbTrj9sECvLMwKBi6
   5TWwJYTmiKlU5ldrumi8jFdXV5wIHkBDtt9mEYPPU09mvGsOgfF8D0iYl
   +zkdIpV49WUIOwLvNhvrQYc0jXArYydIvXHRtWLfW564vfHBmCdGqWaJn
   g==;
X-CSE-ConnectionGUID: iv/IMbR/S/OaEOIr3qkeug==
X-CSE-MsgGUID: eKCYXIWARk2z6GpGC3FZnQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11220"; a="27846450"
X-IronPort-AV: E=Sophos;i="6.11,192,1725346800"; 
   d="scan'208";a="27846450"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2024 02:46:41 -0700
X-CSE-ConnectionGUID: YwNrpjwmTs2+3fXEZBXuFQ==
X-CSE-MsgGUID: f+uVe++RRy+N0rFCGExTWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,192,1725346800"; 
   d="scan'208";a="77365422"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.237])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2024 02:46:38 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 10 Oct 2024 12:46:35 +0300 (EEST)
To: Kurt Borja <kuurtb@gmail.com>
cc: oe-kbuild-all@lists.linux.dev, kernel test robot <lkp@intel.com>, 
    Hans de Goede <hdegoede@redhat.com>, LKML <linux-kernel@vger.kernel.org>, 
    platform-driver-x86@vger.kernel.org, Dell.Client.Kernel@dell.com
Subject: Re: [PATCH v3] alienware-wmi: Dell AWCC platform_profile support
In-Reply-To: <202410101120.w4OLAnaI-lkp@intel.com>
Message-ID: <b4746132-2282-3cb4-64f5-bc83afbcafae@linux.intel.com>
References: <20241008195642.36677-2-kuurtb@gmail.com> <202410101120.w4OLAnaI-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 10 Oct 2024, kernel test robot wrote:

> Hi Kurt,
> 
> kernel test robot noticed the following build errors:
> 
> [auto build test ERROR on linus/master]
> [also build test ERROR on v6.12-rc2 next-20241009]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Kurt-Borja/alienware-wmi-Dell-AWCC-platform_profile-support/20241009-040025
> base:   linus/master
> patch link:    https://lore.kernel.org/r/20241008195642.36677-2-kuurtb%40gmail.com
> patch subject: [PATCH v3] alienware-wmi: Dell AWCC platform_profile support
> config: i386-randconfig-r051-20241010 (https://download.01.org/0day-ci/archive/20241010/202410101120.w4OLAnaI-lkp@intel.com/config)
> compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241010/202410101120.w4OLAnaI-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202410101120.w4OLAnaI-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
> >> drivers/platform/x86/dell/alienware-wmi.c:822:9: error: call to undeclared function 'FIELD_PREP'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
>      822 |         return FIELD_PREP(PROFILE_MASK, prof) | PROFILE_ACTIVATE;
>          |                ^
>    1 error generated.
> 
> 
> vim +/FIELD_PREP +822 drivers/platform/x86/dell/alienware-wmi.c
> 
>    819	
>    820	static u32 profile_to_wmax_arg(enum WMAX_THERMAL_PROFILE prof)
>    821	{
>  > 822		return FIELD_PREP(PROFILE_MASK, prof) | PROFILE_ACTIVATE;
>    823	}
>    824	

For the one time I forget to mention that please add the necessary 
headers, it immediately bites (that was in my mind at one point but in 
the end I forgot to add it).

So please, add the headers both for FIELD_PREP() and GENMASK().

-- 
 i.


