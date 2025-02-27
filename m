Return-Path: <linux-kernel+bounces-537189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 157AFA48903
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 20:29:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2012016C34C
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 19:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C25B26E966;
	Thu, 27 Feb 2025 19:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cj5H6TeP"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4742B26E95E
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 19:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740684573; cv=none; b=bxKxTBgWzXAexsVf94lU/c96X7kBYywnnrkakqd70EMnbH0plcvOF/QWeEiMaV3Xp6QlbsD77QG6jVhjSWsuBWj8JNyCNeM4DxyYN5a3ecHm/cxB2xioAaYhiJpcpRlOxwWcEZ0Lyev29kb7pmSMC+L1UYYzONn21rAuuP10KN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740684573; c=relaxed/simple;
	bh=23SsvAKulhP3ALEN2HoH/NuLHmKdlVV6mEe7MxtqadE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xy4s9noj0grCMD/LixsOq8Lr5I6VZMThKZmY+60VcwC1HF/8dPD2pHO1KDjMxab9k/LZ04pSkqWYPmVPmQ3oGE3ELELw1NxsuEhKjWCVzcn5YKRqvGPZSxsgd+5FGujrT+gAthgTVAqq0vcVm8vYdfFbMy46OFa5M3BMfKs0AQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cj5H6TeP; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740684572; x=1772220572;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=23SsvAKulhP3ALEN2HoH/NuLHmKdlVV6mEe7MxtqadE=;
  b=cj5H6TePeQ2n+hoysDMduZOvSg1zb1+Vo0hpS5P9grs+C/500IScQbgh
   xqtFDmqXzLYr2BX6QdvM7I76C9zhdUtGzGCuyQlcSIm3cndTgUl5hp5FD
   ReeAzbGmDJl2fE9f8iv6O+b9FDUNd7d+vUU3yUT562JsPvn17fNDzL4OB
   8XE33Z1Jhp/kJvM3+uzwLutlxkEtsaWSLfquUyXsfOc6IdxVN76spBWZt
   uoWNAWYd3OreyZOdq8x185ygbq2RFPKzXI54jexv3qoz/PIwT8Um3A299
   qnLY3gmEnaNYLHAUTAtl2AuScpPGVLowyfamWQ7uHwosDCf4J5GpwoRti
   Q==;
X-CSE-ConnectionGUID: ffhhTPuDSRSy/snyEjBMXA==
X-CSE-MsgGUID: /FPUdslmRV6c221PDlrJnA==
X-IronPort-AV: E=McAfee;i="6700,10204,11358"; a="40838923"
X-IronPort-AV: E=Sophos;i="6.13,320,1732608000"; 
   d="scan'208";a="40838923"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 11:29:31 -0800
X-CSE-ConnectionGUID: tLpF088yT0iVP2nsVhccvQ==
X-CSE-MsgGUID: bHzAPuuESwGQqYABbxzfCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,320,1732608000"; 
   d="scan'208";a="117303290"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by fmviesa008.fm.intel.com with ESMTP; 27 Feb 2025 11:29:28 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tnjZW-000DwU-1L;
	Thu, 27 Feb 2025 19:29:26 +0000
Date: Fri, 28 Feb 2025 03:29:19 +0800
From: kernel test robot <lkp@intel.com>
To: Brian Gerst <brgerst@gmail.com>, linux-kernel@vger.kernel.org,
	x86@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Ingo Molnar <mingo@kernel.org>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>, Ard Biesheuvel <ardb@kernel.org>,
	Uros Bizjak <ubizjak@gmail.com>, Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Memory Management List <linux-mm@kvack.org>,
	Brian Gerst <brgerst@gmail.com>
Subject: Re: [PATCH v2 01/11] percpu: Introduce percpu hot section
Message-ID: <202502280328.SFEgOJ50-lkp@intel.com>
References: <20250226180531.1242429-2-brgerst@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250226180531.1242429-2-brgerst@gmail.com>

Hi Brian,

kernel test robot noticed the following build errors:

[auto build test ERROR on 79165720f31868d9a9f7e5a50a09d5fe510d1822]

url:    https://github.com/intel-lab-lkp/linux/commits/Brian-Gerst/percpu-Introduce-percpu-hot-section/20250227-021212
base:   79165720f31868d9a9f7e5a50a09d5fe510d1822
patch link:    https://lore.kernel.org/r/20250226180531.1242429-2-brgerst%40gmail.com
patch subject: [PATCH v2 01/11] percpu: Introduce percpu hot section
config: arm64-allnoconfig (https://download.01.org/0day-ci/archive/20250228/202502280328.SFEgOJ50-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250228/202502280328.SFEgOJ50-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502280328.SFEgOJ50-lkp@intel.com/

All errors (new ones prefixed by >>):

>> aarch64-linux-ld:./arch/arm64/kernel/vmlinux.lds:107: syntax error

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

