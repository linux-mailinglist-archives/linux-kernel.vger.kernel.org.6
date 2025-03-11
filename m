Return-Path: <linux-kernel+bounces-556119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 36D1FA5C12B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 13:31:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D248C3A888A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 12:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2B51258CDF;
	Tue, 11 Mar 2025 12:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CwXXiA70"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 587C124168A
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 12:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741696064; cv=none; b=J9Cw+DvvW4r4gobttuEGyHpYYxLOEJNGM/S0mj8+FpuMhYs5STK+aevCvaDr8lUmlK/dtOyWJhFQc4B4dJ8M14YaIoEGrs3t+xCNwikryouzHqBzT32s/jGtKHll+k0TDdKaFHz76xpCTB6o42DqyPAHCOlU3fj4t0JABFo1fQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741696064; c=relaxed/simple;
	bh=yuEZANfTnGK5pY1juUhwdi+Le7nChzttBTelQJpEB/s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VHpUR/j2TgV5iQztpIUoIaJOZ3k5XrqfUHrlFVhfnHyDt4SyV/8QV1zhOauxuORYXJWUWcpnb+cGswoyLOtXr5dl1lyz/deELv0oDnpffPMGUFbEhHTi/RXh8l+RY2ilZjcdmMfxvpKcVGYB0dBvUOVSC4kFbDlbuBPhJsvuQwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CwXXiA70; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741696062; x=1773232062;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yuEZANfTnGK5pY1juUhwdi+Le7nChzttBTelQJpEB/s=;
  b=CwXXiA70wDt+iNI2C5bFaqXwQMqVbztx2fyeDan/8FL2jS/axM/1zxLN
   O7ZaBLAauY83xb6SwoeMX1rYcQpQSRGdyy+9ptcibu+jk0G0SGljDuR5R
   Tli5ubYvg6iBWJv4aWnDqc0oXTPI7nBZFiWn5LqK4AFkNsBVL64z9r0L3
   ZQ0U5vxYwCaeklOVy2mqw8AZZT3ZjIc3Zp16s2nI2FPKr/Dm0djHvLYh5
   QrLsy/7tGY/D2Q3gcUhMEL+g3aPArT9WuLujYcTh0nW7z6VJkB0uQWKTg
   zy3TCuk5vJf7IrfSkj+gCl6AoLmKovgauxy9pnGXDbjLJ8lqtqRK3fgVu
   g==;
X-CSE-ConnectionGUID: fz/J7SQET2GAxfaql214vQ==
X-CSE-MsgGUID: /M51yaZMQ222KncglzngGg==
X-IronPort-AV: E=McAfee;i="6700,10204,11369"; a="53723964"
X-IronPort-AV: E=Sophos;i="6.14,239,1736841600"; 
   d="scan'208";a="53723964"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2025 05:27:41 -0700
X-CSE-ConnectionGUID: fMJhh8eOTEuvXIAfwSyEgg==
X-CSE-MsgGUID: jNHp/5gqRz2QcvkDniWcQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,239,1736841600"; 
   d="scan'208";a="125356807"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by fmviesa004.fm.intel.com with ESMTP; 11 Mar 2025 05:27:37 -0700
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tryh4-0006eG-31;
	Tue, 11 Mar 2025 12:26:56 +0000
Date: Tue, 11 Mar 2025 20:25:59 +0800
From: kernel test robot <lkp@intel.com>
To: Andrey Ryabinin <arbn@yandex-team.com>, linux-kernel@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Alexander Graf <graf@amazon.com>, James Gowans <jgowans@amazon.com>,
	Mike Rapoport <rppt@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Memory Management List <linux-mm@kvack.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>,
	Eric Biederman <ebiederm@xmission.com>, kexec@lists.infradead.org,
	Pratyush Yadav <ptyadav@amazon.de>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	David Rientjes <rientjes@google.com>,
	Andrey Ryabinin <arbn@yandex-team.com>
Subject: Re: [PATCH v2 4/7] kexec, kstate: delay loading of kexec segments
Message-ID: <202503112016.VZt1HD9v-lkp@intel.com>
References: <20250310120318.2124-5-arbn@yandex-team.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250310120318.2124-5-arbn@yandex-team.com>

Hi Andrey,

kernel test robot noticed the following build errors:

[auto build test ERROR on tip/x86/core]
[also build test ERROR on akpm-mm/mm-nonmm-unstable akpm-mm/mm-everything linus/master v6.14-rc6 next-20250307]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Andrey-Ryabinin/kstate-Add-kstate-a-mechanism-to-describe-and-migrate-kernel-state-across-kexec/20250310-200803
base:   tip/x86/core
patch link:    https://lore.kernel.org/r/20250310120318.2124-5-arbn%40yandex-team.com
patch subject: [PATCH v2 4/7] kexec, kstate: delay loading of kexec segments
config: riscv-randconfig-002-20250311 (https://download.01.org/0day-ci/archive/20250311/202503112016.VZt1HD9v-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250311/202503112016.VZt1HD9v-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503112016.VZt1HD9v-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from kernel/vmcore_info.c:24:
   kernel/kexec_internal.h: In function 'kexec_late_load':
>> kernel/kexec_internal.h:39:50: error: invalid use of undefined type 'struct kimage'
      39 |         return IS_ENABLED(CONFIG_KSTATE) && image->file_mode &&
         |                                                  ^~
   kernel/kexec_internal.h:40:23: error: invalid use of undefined type 'struct kimage'
      40 |                 (image->type == KEXEC_TYPE_DEFAULT);
         |                       ^~
>> kernel/kexec_internal.h:40:33: error: 'KEXEC_TYPE_DEFAULT' undeclared (first use in this function); did you mean 'KEXEC_ARCH_DEFAULT'?
      40 |                 (image->type == KEXEC_TYPE_DEFAULT);
         |                                 ^~~~~~~~~~~~~~~~~~
         |                                 KEXEC_ARCH_DEFAULT
   kernel/kexec_internal.h:40:33: note: each undeclared identifier is reported only once for each function it appears in


vim +39 kernel/kexec_internal.h

    36	
    37	static inline bool kexec_late_load(struct kimage *image)
    38	{
  > 39		return IS_ENABLED(CONFIG_KSTATE) && image->file_mode &&
  > 40			(image->type == KEXEC_TYPE_DEFAULT);
    41	}
    42	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

