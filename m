Return-Path: <linux-kernel+bounces-287430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15BF09527A7
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 03:52:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48DCF1C21B5A
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 01:52:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A3D94A0F;
	Thu, 15 Aug 2024 01:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JfYCUuVV"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD011847C
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 01:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723686772; cv=none; b=cJ67lbsPQQTooiJ+RHlKoDkDClXfaxcZgUNtmMpnRcJxEXX4f7z6NdB2EplryxpPDxVCM0kxNnmuLYDgbORlCko4kl+6GWhvV4WgrrmuUy47xYiEKsK6eVbh0x/trZAB8JKK+XQjldmKqcEp0ffEFBQ3TRvXkZuVVKGW8RrCMz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723686772; c=relaxed/simple;
	bh=LSWMG4ta64KQ4B7CeQ5sUVVOG2+3UlArCs9/+2vo0fo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eTqJ/ojCPUpQ2ek9pOxDdZg2CQtcSLSF5HRa1DTxaB2ZK17s09XN6+FIqMiUlUXElW/XPEeq4CR80KS/k8zaGSUNGs2TOLCGFytHXQi9BOcLL6ncET8TTSHfX7oJ2h/lnA4mHcZz3ByrMzeirJWwPUwuz/pi5cTL2ikHCTK0d3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JfYCUuVV; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723686771; x=1755222771;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LSWMG4ta64KQ4B7CeQ5sUVVOG2+3UlArCs9/+2vo0fo=;
  b=JfYCUuVV+0otPXy8Z5UUzOAb5XpZzrBE3jhmrIuYx4GcBqj1G56Sd90M
   nhkiUdYhE9Bx+kxQ5RBWxp62TPQMey7vPRk49tIEif25ZBlFb9RXyiXpB
   jJsEWlpvWdS/2YOYCYq3Val2mFtyx+f+J8/APVIZjs1tQ99TT1eNYQNJi
   rRN+oEnPtz+K2vTlPKU5b12lvT3W5YPWNogcDGGB4tLdMRMIQ3A3o69bx
   xNswh62whTJ11ffPrlM2TY6hhhYCS2u5pvPwlWwepfKeHntt1KN47qOnf
   oa7w4jQ83P9bKK8nrJdAV027HAb/Ki//n4odnxAsiukxrK8E12oe7n+E0
   A==;
X-CSE-ConnectionGUID: dYxR7LEsSK+ZHqtaFNU1qA==
X-CSE-MsgGUID: 0bcW1KW4TWeav26gKp44SA==
X-IronPort-AV: E=McAfee;i="6700,10204,11164"; a="21483813"
X-IronPort-AV: E=Sophos;i="6.10,147,1719903600"; 
   d="scan'208";a="21483813"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2024 18:52:50 -0700
X-CSE-ConnectionGUID: gm5BNjOlQgWFwMpnX0lX4w==
X-CSE-MsgGUID: MzlGZMugSvygJbJlnAVC3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,147,1719903600"; 
   d="scan'208";a="59059355"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 14 Aug 2024 18:52:49 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sePfS-00033m-0b;
	Thu, 15 Aug 2024 01:52:46 +0000
Date: Thu, 15 Aug 2024 09:52:16 +0800
From: kernel test robot <lkp@intel.com>
To: Uros Bizjak <ubizjak@gmail.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Uros Bizjak <ubizjak@gmail.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: [PATCH 1/2] err.h: Add ERR_PTR_PCPU(), PTR_ERR_PCPU() and
 IS_ERR_PCPU() functions
Message-ID: <202408150948.jjcISdEv-lkp@intel.com>
References: <20240813172543.38411-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240813172543.38411-1-ubizjak@gmail.com>

Hi Uros,

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on v6.11-rc3 next-20240814]
[cannot apply to akpm-mm/mm-everything]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Uros-Bizjak/mm-kmemleak-Use-IS_ERR_PCPU-for-pointer-in-the-percpu-address-space/20240814-223016
base:   linus/master
patch link:    https://lore.kernel.org/r/20240813172543.38411-1-ubizjak%40gmail.com
patch subject: [PATCH 1/2] err.h: Add ERR_PTR_PCPU(), PTR_ERR_PCPU() and IS_ERR_PCPU() functions
config: powerpc-allnoconfig (https://download.01.org/0day-ci/archive/20240815/202408150948.jjcISdEv-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240815/202408150948.jjcISdEv-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408150948.jjcISdEv-lkp@intel.com/

All errors (new ones prefixed by >>):

   arch/powerpc/include/asm/paca.h: Assembler messages:
>> arch/powerpc/include/asm/paca.h:293: Error: unrecognized opcode: `static'
   arch/powerpc/include/asm/paca.h:294: Error: unrecognized opcode: `static'


vim +293 arch/powerpc/include/asm/paca.h

1426d5a3bd0758 Michael Ellerman 2010-01-28  292  
6c6fdbb2b7002a Chengyang Fan    2021-01-25 @293  static inline void allocate_paca(int cpu) { }
6c6fdbb2b7002a Chengyang Fan    2021-01-25  294  static inline void free_unused_pacas(void) { }
1426d5a3bd0758 Michael Ellerman 2010-01-28  295  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

