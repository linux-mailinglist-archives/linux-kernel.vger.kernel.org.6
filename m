Return-Path: <linux-kernel+bounces-172528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 77FC68BF320
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 02:06:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17BE51F22ADD
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 00:06:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32F8A12FB38;
	Tue,  7 May 2024 23:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UXDFj5xq"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17E42134404;
	Tue,  7 May 2024 23:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715125323; cv=none; b=uIE9PLUecnjAA8l9WVGXdVegqjE5+74udMcMmWBL4NOrEwjXIl0zd+9Ypdputtk1IsjkD3mwKw6g9xuNBTuvXI9fJWB7TH0a8WvECq+u3qew5Ce+Du4InnaU8VUjFe14l15I+PgIRj+0MzEwZErUGtzej6yclz8fIdVDuw16elA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715125323; c=relaxed/simple;
	bh=DOOMxtEONE1StSq2FtWYdjIVYayHInKfiOQ2VQA8DqI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hhMVAvC6EJupRdCjeKIlKqRAUilu2MrKn19/UrmIVROl546v/phtPjsjwfvTQuZvlYtn5RKDTN4DwK2CQtClBIhQUHe8Cz4KPlGUuTae5ql03rMbP7F+IsLpoSFtVzRZTojNnfNesLutBYvCbxHm9ZdJl3Pgl+vvT+rIimE+I7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UXDFj5xq; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715125321; x=1746661321;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DOOMxtEONE1StSq2FtWYdjIVYayHInKfiOQ2VQA8DqI=;
  b=UXDFj5xqHcn2keI2wIp5o3MoJYHegM+hzdAf5exf7WVZM1FNpyZCoYAV
   Gbyjk9X0bzIKw1y3ILOeARk51M0YsOCob9yMoGZhgk2xJGchsE5JNFFOB
   0OitHE24y6pcsS5jCBhvG63b8+tXhSf6EBjwftvF45eFpp5d0k5RD8gcM
   bq6AYNPck75gZ6q1tl7R/I+GDEptUvzPmBb0RdJe/Y/r85FPB6kC2bM4+
   h29qy977hKNiPoGE4hoynFr1VZv+Ix2Qv/FcTgDdl5rq65Bz2U6HWFHw/
   zSPccqoYo4smu04ZWqfCOH9aLqaxFcDGhreyF3r88CHGozRMJ18F+tmKo
   w==;
X-CSE-ConnectionGUID: kPUi0FPQSluMmcjq/mu8Ug==
X-CSE-MsgGUID: Ai0UVv9OSWiO1ZrbWvoTLQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11066"; a="33468078"
X-IronPort-AV: E=Sophos;i="6.08,143,1712646000"; 
   d="scan'208";a="33468078"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2024 16:42:00 -0700
X-CSE-ConnectionGUID: yPv5lb/DRsK/JtKV/zB6FA==
X-CSE-MsgGUID: bkpKzxQHSzu23mvdV7jzUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,143,1712646000"; 
   d="scan'208";a="28647216"
Received: from lkp-server01.sh.intel.com (HELO f8b243fe6e68) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 07 May 2024 16:41:55 -0700
Received: from kbuild by f8b243fe6e68 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s4URV-0002km-0v;
	Tue, 07 May 2024 23:41:53 +0000
Date: Wed, 8 May 2024 07:40:57 +0800
From: kernel test robot <lkp@intel.com>
To: Vignesh Balasubramanian <vigbalas@amd.com>,
	linux-kernel@vger.kernel.org, linux-toolchains@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, mpe@ellerman.id.au, npiggin@gmail.com,
	christophe.leroy@csgroup.eu, aneesh.kumar@kernel.org,
	naveen.n.rao@linux.ibm.com, ebiederm@xmission.com,
	keescook@chromium.org, x86@kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org, bpetkov@amd.com,
	jinisusan.george@amd.com, matz@suse.de, binutils@sourceware.org,
	jhb@freebsd.org, felix.willgerodt@intel.com,
	Vignesh Balasubramanian <vigbalas@amd.com>
Subject: Re: [PATCH v2 1/1] x86/elf: Add a new .note section containing
 Xfeatures information to x86 core files
Message-ID: <202405080715.hYQ1ae9v-lkp@intel.com>
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
config: i386-buildonly-randconfig-006-20240508 (https://download.01.org/0day-ci/archive/20240508/202405080715.hYQ1ae9v-lkp@intel.com/config)
compiler: gcc-8 (Ubuntu 8.4.0-3ubuntu2) 8.4.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240508/202405080715.hYQ1ae9v-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405080715.hYQ1ae9v-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> arch/x86/kernel/fpu/xstate.c:91:19: warning: 'owner_name' defined but not used [-Wunused-const-variable=]
    static const char owner_name[] = "LINUX";
                      ^~~~~~~~~~
   In file included from include/linux/string.h:369,
                    from arch/x86/include/asm/page_32.h:18,
                    from arch/x86/include/asm/page.h:14,
                    from arch/x86/include/asm/processor.h:20,
                    from arch/x86/include/asm/timex.h:5,
                    from include/linux/timex.h:67,
                    from include/linux/time32.h:13,
                    from include/linux/time.h:60,
                    from include/linux/compat.h:10,
                    from arch/x86/kernel/fpu/xstate.c:8:
   In function 'fortify_memcpy_chk',
       inlined from 'membuf_write.isra.6' at include/linux/regset.h:42:3,
       inlined from '__copy_xstate_to_uabi_buf' at arch/x86/kernel/fpu/xstate.c:1049:2:
   include/linux/fortify-string.h:562:4: warning: call to '__read_overflow2_field' declared with attribute warning: detected read beyond size of field (2nd parameter); maybe use struct_group()?
       __read_overflow2_field(q_size_field, size);
       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/owner_name +91 arch/x86/kernel/fpu/xstate.c

    90	
  > 91	static const char owner_name[] = "LINUX";
    92	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

