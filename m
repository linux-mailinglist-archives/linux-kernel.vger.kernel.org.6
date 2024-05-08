Return-Path: <linux-kernel+bounces-172551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9DB78BF362
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 02:14:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94CD5280C56
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 00:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 949715382;
	Wed,  8 May 2024 00:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h05LgAfM"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63828ECC;
	Wed,  8 May 2024 00:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715127242; cv=none; b=uKLS0vpqobxX/AzPylSNGbd0OIS6Yw5/+RcvClBplVeLjCvhPqV2YA9FXaQ2LzywVQOwbHarCCoFv2OhR6yexOorb9vR3rpBaS//c+8GGoTAqMOAv6aL9A7aNrX/l7Nac+ihAsFiM9nG2v0JWavZrSvV35YNkf+kSl0hA2ErrfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715127242; c=relaxed/simple;
	bh=KlZGcKHOCwyvQnVPkYIgOSg/daK0tJkCNOhIwL1thy8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pYNy7s2GiVfllC5vmx2uonFq7iKHqU4irIADovneo6xOrG5tFMbvJpVuhGUNzWmQ+ECPnPhku5JvRnRolMJBE6YPt9M2yHSrVDqbe0zjYM4b/ygsxy/3LdASZ+KHRptZglo6nAZNY1e78ITiggj4KpnvcOWh6HO7UTe6BIXB9u0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h05LgAfM; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715127241; x=1746663241;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KlZGcKHOCwyvQnVPkYIgOSg/daK0tJkCNOhIwL1thy8=;
  b=h05LgAfMSw7zodFXkD2Tf7DhiUfwg/MoXYTgVu3VBG1PSYszAnoPHVaE
   X2IOZ54X/g2gJp//Va1fed+HjqqPPcV+ydooUxJjgwDO1r4v3i1EWY9R2
   R4AIkqWeAAZ9psSTEehUFSZRd4PTpxP4/dHuCM+41DwmNwwNcqGadG8/n
   Cb5Fu65Jk5OcQPM7N7Rd1u7DJAdRy6aFiz3oK3gsyNBP69SdR48u1o+od
   WzyXUyHSvICWuEswjKCNijjID7RCCQQYZWtMk8tKwRCRJDzmE3xC7MIX8
   U7ZPLnrGqntz3E4GAtUl6fpKhbuvR5kJ40exaPBjD+l8PABv2np0O2LCK
   A==;
X-CSE-ConnectionGUID: S983/FAQTpWdMBIHQTR1xg==
X-CSE-MsgGUID: kflF2nAUR2ywgjy4itWfvA==
X-IronPort-AV: E=McAfee;i="6600,9927,11066"; a="10899162"
X-IronPort-AV: E=Sophos;i="6.08,143,1712646000"; 
   d="scan'208";a="10899162"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2024 17:14:01 -0700
X-CSE-ConnectionGUID: ozBPJ5lsRMK0owkEt7/w6Q==
X-CSE-MsgGUID: LSXQiHGFTA6Byr7pN/S39w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,143,1712646000"; 
   d="scan'208";a="33392994"
Received: from lkp-server01.sh.intel.com (HELO f8b243fe6e68) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 07 May 2024 17:13:57 -0700
Received: from kbuild by f8b243fe6e68 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s4UwT-0002lw-30;
	Wed, 08 May 2024 00:13:53 +0000
Date: Wed, 8 May 2024 08:13:18 +0800
From: kernel test robot <lkp@intel.com>
To: Vignesh Balasubramanian <vigbalas@amd.com>,
	linux-kernel@vger.kernel.org, linux-toolchains@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, mpe@ellerman.id.au,
	npiggin@gmail.com, christophe.leroy@csgroup.eu,
	aneesh.kumar@kernel.org, naveen.n.rao@linux.ibm.com,
	ebiederm@xmission.com, keescook@chromium.org, x86@kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org, bpetkov@amd.com,
	jinisusan.george@amd.com, matz@suse.de, binutils@sourceware.org,
	jhb@freebsd.org, felix.willgerodt@intel.com,
	Vignesh Balasubramanian <vigbalas@amd.com>
Subject: Re: [PATCH v2 1/1] x86/elf: Add a new .note section containing
 Xfeatures information to x86 core files
Message-ID: <202405080809.LGYhRYu3-lkp@intel.com>
References: <20240507095330.2674-2-vigbalas@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240507095330.2674-2-vigbalas@amd.com>

Hi Vignesh,

kernel test robot noticed the following build warnings:

[auto build test WARNING on kees/for-next/execve]
[also build test WARNING on tip/x86/core kees/for-next/pstore kees/for-next/kspp linus/master v6.9-rc7 next-20240507]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Vignesh-Balasubramanian/x86-elf-Add-a-new-note-section-containing-Xfeatures-information-to-x86-core-files/20240507-175615
base:   https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git for-next/execve
patch link:    https://lore.kernel.org/r/20240507095330.2674-2-vigbalas%40amd.com
patch subject: [PATCH v2 1/1] x86/elf: Add a new .note section containing Xfeatures information to x86 core files
config: i386-randconfig-013-20240508 (https://download.01.org/0day-ci/archive/20240508/202405080809.LGYhRYu3-lkp@intel.com/config)
compiler: clang version 18.1.4 (https://github.com/llvm/llvm-project e6c3289804a67ea0bb6a86fadbe454dd93b8d855)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240508/202405080809.LGYhRYu3-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405080809.LGYhRYu3-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> arch/x86/kernel/fpu/xstate.c:91:19: warning: unused variable 'owner_name' [-Wunused-const-variable]
      91 | static const char owner_name[] = "LINUX";
         |                   ^~~~~~~~~~
   1 warning generated.

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for DRM_I915_DEBUG_GEM
   Depends on [n]: HAS_IOMEM [=y] && DRM_I915 [=m] && EXPERT [=y] && DRM_I915_WERROR [=n]
   Selected by [m]:
   - DRM_I915_DEBUG [=y] && HAS_IOMEM [=y] && DRM_I915 [=m] && EXPERT [=y] && !COMPILE_TEST [=n]


vim +/owner_name +91 arch/x86/kernel/fpu/xstate.c

    90	
  > 91	static const char owner_name[] = "LINUX";
    92	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

