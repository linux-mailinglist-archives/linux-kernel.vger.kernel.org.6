Return-Path: <linux-kernel+bounces-310000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F2009672EB
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 20:07:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50AD21C210E8
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 18:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 576AC13BAEE;
	Sat, 31 Aug 2024 18:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Nt1h78Bb"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC4F8339A1
	for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2024 18:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725127638; cv=none; b=mxqqSZaxzIdkWg+gwtb+eY01S56XczXfHfqk78lB/H0ZohSq1By/GU8g/tJujqKI/gLucGdjpKcNFq6m2O6hu5vRnUkv2WO4RnF3oUjy3SWYxlqqahhyKFk8O+j3gLsDPULjKhjayI3BG2qMLljpmTcIpphwjmiMFis5aYlow1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725127638; c=relaxed/simple;
	bh=aarbNujcQJQu8cWevGdPTbcJJFKQH7w9HGZjr2sx000=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Yj/KCFAqo0u2eZgVKmZGO+v7gYBvvgc2cS/z3OeHEIXeFhErBJdnopveWBeP7qL5BMeHGT+pEuOa0L2gqqNuTQWi2UrFBBoV4rsU1cUIFuCi5nU8FmQXzJz9B7R6js2lZPGTGgBhQGR9U2vBzRpxRqFIPFthcgVUx8i5Vj6fNG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Nt1h78Bb; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725127637; x=1756663637;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=aarbNujcQJQu8cWevGdPTbcJJFKQH7w9HGZjr2sx000=;
  b=Nt1h78BbXThM4v5gmwsFmncFjmqphdWziACaElAXSVA6Tp16Bpt7XelS
   yX5REe+KAKAuynjR+HwCcbMwSAuEHpB0wJZZPPofb31Uovr5yHe2r2CaB
   h60+30SLDYtOvoSFKFQvzWwQX9J5NsWrWChcg6/r7l6fRbJWcPYOBsbSn
   l/BOsOdtkfxOTSuvJTTgcshAfab3lVF4vDe9ilT/0iuLgADiubJiKIjP1
   VcNnvgQrWeEWa9baRgrVWdOZKfkWX2S4n5To54OFjPN6FzlUlqW3e9btA
   tTHFdU08ZQV73IYKKG66zSXtUdp1wvQBRQ9j+h3nCVLFw3eajvPAPeu2R
   w==;
X-CSE-ConnectionGUID: hI8A+NMsTtKP7/ZLLJ71Zw==
X-CSE-MsgGUID: NhdXM9PNTK+A/hrd5r04ZA==
X-IronPort-AV: E=McAfee;i="6700,10204,11181"; a="35122300"
X-IronPort-AV: E=Sophos;i="6.10,192,1719903600"; 
   d="scan'208";a="35122300"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2024 11:07:16 -0700
X-CSE-ConnectionGUID: ZuQhqq6BRrOc43Oghc6LQg==
X-CSE-MsgGUID: GlbcVdAlRk23nCyW8b0BgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,192,1719903600"; 
   d="scan'208";a="64203827"
Received: from lkp-server01.sh.intel.com (HELO 9c6b1c7d3b50) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 31 Aug 2024 11:07:15 -0700
Received: from kbuild by 9c6b1c7d3b50 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1skSVE-0002zI-2B;
	Sat, 31 Aug 2024 18:07:12 +0000
Date: Sun, 1 Sep 2024 02:06:30 +0800
From: kernel test robot <lkp@intel.com>
To: Sean Christopherson <seanjc@google.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, Kai Huang <kai.huang@intel.com>
Subject: arch/x86/kernel/reboot.c:939:20: error: unused function
 'nmi_shootdown_cpus_on_restart'
Message-ID: <202409010207.jrH6sNV4-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   1934261d897467a924e2afd1181a74c1cbfa2c1d
commit: 261cd5ed934e6923187cf1c9eaa6cb63f2b81212 x86/reboot: Expose VMCS crash hooks if and only if KVM_{INTEL,AMD} is enabled
date:   1 year, 1 month ago
config: x86_64-sof-customedconfig-amd-defconfig (https://download.01.org/0day-ci/archive/20240901/202409010207.jrH6sNV4-lkp@intel.com/config)
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240901/202409010207.jrH6sNV4-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409010207.jrH6sNV4-lkp@intel.com/

All errors (new ones prefixed by >>):

>> arch/x86/kernel/reboot.c:939:20: error: unused function 'nmi_shootdown_cpus_on_restart' [-Werror,-Wunused-function]
     939 | static inline void nmi_shootdown_cpus_on_restart(void)
         |                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   1 error generated.


vim +/nmi_shootdown_cpus_on_restart +939 arch/x86/kernel/reboot.c

26044aff37a5455 Sean Christopherson 2022-11-30  938  
26044aff37a5455 Sean Christopherson 2022-11-30 @939  static inline void nmi_shootdown_cpus_on_restart(void)
26044aff37a5455 Sean Christopherson 2022-11-30  940  {
26044aff37a5455 Sean Christopherson 2022-11-30  941  	if (!crash_ipi_issued)
26044aff37a5455 Sean Christopherson 2022-11-30  942  		nmi_shootdown_cpus(NULL);
2ddded213895e41 Eduardo Habkost     2008-11-12  943  }
58c5661f2144c08 Hidehiro Kawai      2015-12-14  944  

:::::: The code at line 939 was first introduced by commit
:::::: 26044aff37a5455b19a91785086914fd33053ef4 x86/crash: Disable virt in core NMI crash handler to avoid double shootdown

:::::: TO: Sean Christopherson <seanjc@google.com>
:::::: CC: Sean Christopherson <seanjc@google.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

