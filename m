Return-Path: <linux-kernel+bounces-341303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 168C0987DFA
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 07:51:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F21A1C21EE1
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 05:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D22AE176240;
	Fri, 27 Sep 2024 05:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FqkbN+96"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B384A17107F;
	Fri, 27 Sep 2024 05:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727416263; cv=none; b=hH0KsuAIVXPUkD6kzApNCrSh35Jg182MlXa31IO2BsnbK2ApfCf5qI/O2crenXZRphLlvjOSZahzTmGbAehngWEJj6Opeakxgw1w9hj/EmA9xtU1o2ppMhOf83DLWKvaKzbgUADeF4P+JbIwVwkAir2WlOPy5xQqGfSJBnSPRqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727416263; c=relaxed/simple;
	bh=DPs1bUsyRMjMqYmvWTRMrarOLc/z/+y65fnQk3g/7Do=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uSqPuUd5THEXLRxcYj5nP/ye1QRM/sL3i5NxBgRCnOC3oc3xU4LucyYleUFsN0eJ7Za5xHn2ZamZo/HfRlOSNBAoHonx86goXfsgqpBqFSs92yLt9fEj6NNhjzE1rd9uxyWIv6FcdTPMhNM3083R/O6gDchb9QiFycyvsUPPqhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FqkbN+96; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727416262; x=1758952262;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DPs1bUsyRMjMqYmvWTRMrarOLc/z/+y65fnQk3g/7Do=;
  b=FqkbN+96H2vEM2G93tZ8lLHn+LM0wQYOYT1y1lCwsSz10VywLFKz1+lA
   Ox5VG3POb8Ny3rOPYJVoHWRit7ZO8lHi9Q6ssslAaTdb4PA+We1FTAn9X
   btl2kcYQO9Rs+jWCtcyY9qM2xLw8feSVtB8WKsIt5DeG2EVJp6kRj2ewM
   05M6wdbr6lBaHAx/WT4i/DDcCpbMooEMzasvVuNKg/rDZ5F5YpGb9twQ3
   hQhXf/jwXsWPakA/TlwCxJuGFNbSnxFV9I6XWUkWm3YYlu5GqLlEgbLiq
   INqPjX3Yl11o8HTqidpCB+uNsPXH6fpDyaiF7Ikg8V8btMocQ3nuv2zLZ
   g==;
X-CSE-ConnectionGUID: k32DwA+JRGiE9fPcJnq1QA==
X-CSE-MsgGUID: p6/KrxELQHWyrfKu/D7lUg==
X-IronPort-AV: E=McAfee;i="6700,10204,11207"; a="26418150"
X-IronPort-AV: E=Sophos;i="6.11,157,1725346800"; 
   d="scan'208";a="26418150"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2024 22:51:01 -0700
X-CSE-ConnectionGUID: EAf0mhV7Rwe43f3VBH/pEQ==
X-CSE-MsgGUID: XfvvcDKoRgKLTpQFg/3OCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,157,1725346800"; 
   d="scan'208";a="72012664"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 26 Sep 2024 22:50:57 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1su3sV-000LXH-1B;
	Fri, 27 Sep 2024 05:50:55 +0000
Date: Fri, 27 Sep 2024 13:49:57 +0800
From: kernel test robot <lkp@intel.com>
To: Julian Vetter <jvetter@kalrayinc.com>, Arnd Bergmann <arnd@arndb.de>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-csky@vger.kernel.org, loongarch@lists.linux.dev,
	Yann Sionneau <ysionneau@kalrayinc.com>,
	Julian Vetter <jvetter@kalrayinc.com>
Subject: Re: [PATCH v6 2/5] Replace generic memcpy and memset by IO memcpy
 functions
Message-ID: <202409271356.SXoT779W-lkp@intel.com>
References: <20240925132420.821473-3-jvetter@kalrayinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240925132420.821473-3-jvetter@kalrayinc.com>

Hi Julian,

kernel test robot noticed the following build errors:

[auto build test ERROR on arm64/for-next/core]
[also build test ERROR on arnd-asm-generic/master soc/for-next linus/master v6.11 next-20240926]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Julian-Vetter/Consolidate-__memcpy_-to-from-io-and-__memset_io-into-iomap_copy-c/20240925-225627
base:   https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-next/core
patch link:    https://lore.kernel.org/r/20240925132420.821473-3-jvetter%40kalrayinc.com
patch subject: [PATCH v6 2/5] Replace generic memcpy and memset by IO memcpy functions
config: um-randconfig-r072-20240927 (https://download.01.org/0day-ci/archive/20240927/202409271356.SXoT779W-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240927/202409271356.SXoT779W-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409271356.SXoT779W-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

WARNING: modpost: missing MODULE_DESCRIPTION() in lib/zlib_inflate/zlib_inflate.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/fpga/tests/fpga-mgr-test.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/fpga/tests/fpga-bridge-test.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/fpga/tests/fpga-region-test.o
>> ERROR: modpost: "__memcpy_fromio" [drivers/mtd/chips/cfi_cmdset_0002.ko] undefined!
>> ERROR: modpost: "__memcpy_fromio" [drivers/mtd/chips/map_ram.ko] undefined!
>> ERROR: modpost: "__memcpy_toio" [drivers/mtd/chips/map_ram.ko] undefined!
>> ERROR: modpost: "__memcpy_fromio" [drivers/mtd/chips/map_rom.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

