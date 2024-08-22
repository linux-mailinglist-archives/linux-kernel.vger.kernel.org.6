Return-Path: <linux-kernel+bounces-297607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18A7095BB61
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 18:08:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C41181F2210C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 16:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2E411CCEC7;
	Thu, 22 Aug 2024 16:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cC1b2jdq"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6800D1CCB35
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 16:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724342902; cv=none; b=oU9B9pPMvSJBd0+7Q3n7dFwidHVh39gNDfUv3J97l2dfMtFe+m+lbNgK2WFhnDpniAbK15LlEFxE9TiqCl2Q9M9hV6asRYYsWMLn/WmT0zLkS/KLYcKvX5VOI5aWwzVnYXPOrKUleFNSoFyuaeSmqsnJARVKsBUOpiJ7bWxWfoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724342902; c=relaxed/simple;
	bh=ZeQ8WJaJGro3mYVLvWjPMld9csOVqbAnz0RETX66F/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nLJStmxsi9gzKu8q/urrQPi3DKxuvQXtI9actI+ga3Ev+MQS7cPTw2oFP9uuCCruxNZEhBLMP7xAdP83LL3UqxC/ZxiaLdcT/HIfUfOtuj+O0QNFR5UQtIoRIqQBb1x5CNxIEMTkNluH5mbjar095DNyKJLERh8FPmLqQu+jqwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cC1b2jdq; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724342902; x=1755878902;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZeQ8WJaJGro3mYVLvWjPMld9csOVqbAnz0RETX66F/Y=;
  b=cC1b2jdqCYT5tZ6/34rYcL9qEtrFCC1MMdAt+y5SnWC8fibQcEVIYTFa
   Cnjdkg5zky43JQtoJeAfU0r3PVF9RjfHdqUjNEQsD8gKv6OufJeqDN+mQ
   Xpp/BOMmowSW36NbkIXudFtZX9DrR8JuS4pQ00uyTwh15esJFONeZ/IzM
   T21OJnp9EXFf/RzpEuWtPbCflKlU1/gkpmGwbOG1JPaCGTqwgBG8zai2M
   QiRwkaqaH8L9+krYKJAvx4/8HhEK7LC+cnDMQ1Nm3NHdPCGVjtDy8s1Vp
   B2SaAN4o0oSCM2JI2JpHfAheOQUhwfwvoo/9rskmTaIjB4Ww8NfgWR+kV
   A==;
X-CSE-ConnectionGUID: NQ7jy+4HRgW4RZyI/PVvkw==
X-CSE-MsgGUID: ELh40G58RyW4e+vomBgYQg==
X-IronPort-AV: E=McAfee;i="6700,10204,11172"; a="40235493"
X-IronPort-AV: E=Sophos;i="6.10,167,1719903600"; 
   d="scan'208";a="40235493"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2024 09:08:21 -0700
X-CSE-ConnectionGUID: BylcR1dsTbiEc3H4XMh66w==
X-CSE-MsgGUID: al5XR5QCQW+AXx4CZ/8UqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,167,1719903600"; 
   d="scan'208";a="61169781"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 22 Aug 2024 09:08:18 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1shAMB-000Cxo-32;
	Thu, 22 Aug 2024 16:08:15 +0000
Date: Fri, 23 Aug 2024 00:07:58 +0800
From: kernel test robot <lkp@intel.com>
To: Chen Yufan <chenyufan@vivo.com>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, opensource.kernel@vivo.com
Subject: Re: [PATCH v1] X86 architecture (32-bit and 64-bit): Convert to use
 jiffies macro
Message-ID: <202408222338.iKsWRLjQ-lkp@intel.com>
References: <20240822034721.9561-1-chenyufan@vivo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240822034721.9561-1-chenyufan@vivo.com>

Hi Chen,

kernel test robot noticed the following build errors:

[auto build test ERROR on tip/x86/core]
[also build test ERROR on linus/master v6.11-rc4 next-20240822]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Chen-Yufan/X86-architecture-32-bit-and-64-bit-Convert-to-use-jiffies-macro/20240822-114925
base:   tip/x86/core
patch link:    https://lore.kernel.org/r/20240822034721.9561-1-chenyufan%40vivo.com
patch subject: [PATCH v1] X86 architecture (32-bit and 64-bit): Convert to use jiffies macro
config: x86_64-randconfig-161-20240822 (https://download.01.org/0day-ci/archive/20240822/202408222338.iKsWRLjQ-lkp@intel.com/config)
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240822/202408222338.iKsWRLjQ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408222338.iKsWRLjQ-lkp@intel.com/

All errors (new ones prefixed by >>):

>> arch/x86/kernel/cpu/aperfmperf.c:19:1: error: expected external declaration
      19 | +#include <linux/jiffies.h>
         | ^
>> arch/x86/kernel/cpu/aperfmperf.c:19:2: error: expected identifier or '('
      19 | +#include <linux/jiffies.h>
         |  ^
   2 errors generated.


vim +19 arch/x86/kernel/cpu/aperfmperf.c

  > 19	+#include <linux/jiffies.h>
    20	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

