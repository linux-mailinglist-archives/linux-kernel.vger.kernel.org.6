Return-Path: <linux-kernel+bounces-540082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 185C7A4AD6E
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 19:50:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C16DC3B1004
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 18:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE1881E7C10;
	Sat,  1 Mar 2025 18:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MU37R0vz"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB7D1DED49;
	Sat,  1 Mar 2025 18:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740854996; cv=none; b=mR5aKF98K0Q/gwFVt60C1RZ/H8oaMz04D0ns6eVEdKJ+Ns0bZld/i3IPGeuxvs0OAr3nAMCcTjwO7GKcwMcstmBc0TV3HOTmRkVnlKMplSrjF/+dgAnpwcpV6tOie+im84W7/dSPNfwHBDdV3t0cP4wdGkGDB9dvDHqcpY0Yymk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740854996; c=relaxed/simple;
	bh=IrOfUSH1K4Wm6o+tYeM48yWS/v2GxQKug3+bX3bY5FY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vfd/9FpMM6Bcw4uhofiaVM0dkqNy3p/b3+HkPb/OJyNr7S0s9NJ6HYKbPdvD7raVIwynbyI6lyq4TgMSltocQo1rjvaBbNpXzxEdzCTrZmQv9xrB/ZF2p8tbE+ndTDOxxLUlmil2WUt7t7sTcHfQ2tHve+2VbK+nDGFBimlogk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MU37R0vz; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740854995; x=1772390995;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IrOfUSH1K4Wm6o+tYeM48yWS/v2GxQKug3+bX3bY5FY=;
  b=MU37R0vziI2F0WXwAd0FysrG4Rr6DhWDDatjEatdlEGsVW10w+DTCnog
   T7ycmlkBDFJbFgtRYiODVe80Vj1pCCOeLMm5T2kLCDeWhNy7Rrv+3lP3a
   NHGacTF9SZ7nQdhsqqtSYb6BtM55H6akcNmIgYFzM9Z87nsAlkVhQ+S+h
   ybaEmhoXpxCtUuTGZje3QJOam9CW3GQaVPU8WkwdS6taLp2O7ikh5qVkU
   95CLEcHBb1/G+ycihNTlr7TCHDVbSxU5o7SrfeSmXySrca7q8pd2G8/7Y
   I+rhJ3FOb4RARqWXqZ9qatO4uXLOYXi96TTfzITAe+nKusjTJl8iK5fuY
   Q==;
X-CSE-ConnectionGUID: ZSLOAQSRTV2ySDupv9U61Q==
X-CSE-MsgGUID: la4zOVq9QT+7aYHLcYH4dA==
X-IronPort-AV: E=McAfee;i="6700,10204,11360"; a="45416189"
X-IronPort-AV: E=Sophos;i="6.13,325,1732608000"; 
   d="scan'208";a="45416189"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2025 10:49:54 -0800
X-CSE-ConnectionGUID: wWza1SZPTz+XF7JHCbsrcg==
X-CSE-MsgGUID: iL/GJJIYQ8m57G17eAFtBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,325,1732608000"; 
   d="scan'208";a="122762859"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by fmviesa004.fm.intel.com with ESMTP; 01 Mar 2025 10:49:50 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1toRuG-000GaG-1A;
	Sat, 01 Mar 2025 18:49:48 +0000
Date: Sun, 2 Mar 2025 02:49:36 +0800
From: kernel test robot <lkp@intel.com>
To: Aditya Garg <gargaditya08@live.com>,
	"castet.matthieu@free.fr" <castet.matthieu@free.fr>,
	"stf_xl@wp.pl" <stf_xl@wp.pl>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"b-liu@ti.com" <b-liu@ti.com>,
	"johan@kernel.org" <johan@kernel.org>,
	"heikki.krogerus@linux.intel.com" <heikki.krogerus@linux.intel.com>,
	"valentina.manea.m@gmail.com" <valentina.manea.m@gmail.com>,
	"shuah@kernel.org" <shuah@kernel.org>,
	"i@zenithal.me" <i@zenithal.me>
Cc: oe-kbuild-all@lists.linux.dev,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH] usb: replace strcpy() with strscpy()
Message-ID: <202503020226.3yStuXZ8-lkp@intel.com>
References: <DEF7EF73-12C4-4F30-BC14-DD829F0C6884@live.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DEF7EF73-12C4-4F30-BC14-DD829F0C6884@live.com>

Hi Aditya,

kernel test robot noticed the following build errors:

[auto build test ERROR on usb/usb-testing]
[also build test ERROR on usb/usb-next usb/usb-linus johan-usb-serial/usb-next johan-usb-serial/usb-linus linus/master v6.14-rc4 next-20250228]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Aditya-Garg/usb-replace-strcpy-with-strscpy/20250228-230839
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
patch link:    https://lore.kernel.org/r/DEF7EF73-12C4-4F30-BC14-DD829F0C6884%40live.com
patch subject: [PATCH] usb: replace strcpy() with strscpy()
config: csky-randconfig-002-20250302 (https://download.01.org/0day-ci/archive/20250302/202503020226.3yStuXZ8-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250302/202503020226.3yStuXZ8-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503020226.3yStuXZ8-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/linux/build_bug.h:5,
                    from include/linux/container_of.h:5,
                    from include/linux/list.h:5,
                    from include/linux/module.h:12,
                    from drivers/usb/atm/ueagle-atm.c:15:
   drivers/usb/atm/ueagle-atm.c: In function 'cmvs_file_name':
>> include/linux/compiler.h:197:62: error: static assertion failed: "must be array"
     197 | #define __BUILD_BUG_ON_ZERO_MSG(e, msg) ((int)sizeof(struct {_Static_assert(!(e), msg);}))
         |                                                              ^~~~~~~~~~~~~~
   include/linux/compiler.h:202:33: note: in expansion of macro '__BUILD_BUG_ON_ZERO_MSG'
     202 | #define __must_be_array(a)      __BUILD_BUG_ON_ZERO_MSG(!__is_array(a), \
         |                                 ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/string.h:80:47: note: in expansion of macro '__must_be_array'
      80 |         sized_strscpy(dst, src, sizeof(dst) + __must_be_array(dst) +    \
         |                                               ^~~~~~~~~~~~~~~
   include/linux/args.h:25:24: note: in expansion of macro '__strscpy0'
      25 | #define __CONCAT(a, b) a ## b
         |                        ^
   include/linux/args.h:26:27: note: in expansion of macro '__CONCAT'
      26 | #define CONCATENATE(a, b) __CONCAT(a, b)
         |                           ^~~~~~~~
   include/linux/string.h:114:9: note: in expansion of macro 'CONCATENATE'
     114 |         CONCATENATE(__strscpy, COUNT_ARGS(__VA_ARGS__))(dst, src, __VA_ARGS__)
         |         ^~~~~~~~~~~
   drivers/usb/atm/ueagle-atm.c:1574:9: note: in expansion of macro 'strscpy'
    1574 |         strscpy(cmv_name, FW_DIR);
         |         ^~~~~~~


vim +197 include/linux/compiler.h

230fa253df6352 Christian Borntraeger 2014-11-25  193  
cb7380de9e4cbc Kees Cook             2025-02-05  194  #ifdef __CHECKER__
cb7380de9e4cbc Kees Cook             2025-02-05  195  #define __BUILD_BUG_ON_ZERO_MSG(e, msg) (0)
cb7380de9e4cbc Kees Cook             2025-02-05  196  #else /* __CHECKER__ */
cb7380de9e4cbc Kees Cook             2025-02-05 @197  #define __BUILD_BUG_ON_ZERO_MSG(e, msg) ((int)sizeof(struct {_Static_assert(!(e), msg);}))
cb7380de9e4cbc Kees Cook             2025-02-05  198  #endif /* __CHECKER__ */
cb7380de9e4cbc Kees Cook             2025-02-05  199  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

