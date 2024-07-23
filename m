Return-Path: <linux-kernel+bounces-260452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B165293A972
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 00:47:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69CE4282FE3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 22:47:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60339148FE8;
	Tue, 23 Jul 2024 22:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i4y25xRP"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 465CE25760;
	Tue, 23 Jul 2024 22:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721774822; cv=none; b=BkIvRmo6APhSpih1qa0Yzzxe0ydod6glJlbAXnJpwok2UClnySix1H69RQppjxxEZ1zBVBO74jlHX5qf094RLiJrVBLLx5zuF+e1lnkMQtKk2WhTanFRaC13YXwDbIMdxz+j51bPFBkcAGmdSgn7jFr6Ze6Xu+QR9haQS79W+NU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721774822; c=relaxed/simple;
	bh=dl09buGlXJxjd9vfVzfVMrAdCdvLXfX2AOHwdw+scUQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P5LvrkIO1IVTbwdHdkHI5LYsqSRm1YIU6BYgX5USOXst5BcexshA9xP+Cj5YvpEpksE6ZHObWmrMv6TWhk/+6XchKpIdPHK42msHSQaB/NY+dDIzJmbbY+qZb4izP4qok2dhakpfWCp3p00IEafcSg5RJqFmQ2wh2zJpTw336WQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i4y25xRP; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721774820; x=1753310820;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dl09buGlXJxjd9vfVzfVMrAdCdvLXfX2AOHwdw+scUQ=;
  b=i4y25xRPoTV7tkFELyIrKza9YvzvNph1Pj52gexrdlDz+BSF5xq1CS5l
   VAHN/iKMR17je7RdFt7u+NUsGYgaBvwQewrnhARyCLgdCFiMvV9xAy5UH
   tsqsZoPbmt5P53hCsafHOOuA4Pu+hYhB2SRhhs38HKndOMBgFfeGIcpeb
   u6W2ayRs62XAwZR0cpfPgrePfQd95QBOtxDnDSB322kkUbBhgfqNjtm4Y
   MkWUfh56WLhmCyOKAtcuhFpzHpLWIQY34XuvkhtDoDi3hVe9NIKPxfx9b
   xWbc7wugBUtkFXd+vN4zMzKB+2P7i9pVcxDxZdP38J4swK5WHzZUF7Ysa
   A==;
X-CSE-ConnectionGUID: ZvgipneIRMmdLmDO/xLdBA==
X-CSE-MsgGUID: B66WqGKzStaTdUGIqyyUyg==
X-IronPort-AV: E=McAfee;i="6700,10204,11142"; a="19555282"
X-IronPort-AV: E=Sophos;i="6.09,231,1716274800"; 
   d="scan'208";a="19555282"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2024 15:46:59 -0700
X-CSE-ConnectionGUID: C9dni4CPQI+dq/xQ9efZvw==
X-CSE-MsgGUID: gu2NC/fGTvivYgAzJI8ALg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,231,1716274800"; 
   d="scan'208";a="52613766"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 23 Jul 2024 15:46:55 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sWOHU-000mQS-0g;
	Tue, 23 Jul 2024 22:46:52 +0000
Date: Wed, 24 Jul 2024 06:46:19 +0800
From: kernel test robot <lkp@intel.com>
To: Vignesh Balasubramanian <vigbalas@amd.com>,
	linux-kernel@vger.kernel.org, linux-toolchains@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, mpe@ellerman.id.au,
	npiggin@gmail.com, christophe.leroy@csgroup.eu,
	aneesh.kumar@kernel.org, naveen.n.rao@linux.ibm.com,
	ebiederm@xmission.com, keescook@chromium.org, x86@kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org, bpetkov@amd.com,
	jinisusan.george@amd.com, matz@suse.de, binutils@sourceware.org,
	jhb@freebsd.org, felix.willgerodt@intel.com, tglx@linutronix.de,
	Vignesh Balasubramanian <vigbalas@amd.com>,
	Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v4 1/1] x86/elf: Add a new .note section containing
 xfeatures buffer layout info to x86 core files
Message-ID: <202407240659.eRyEDmG1-lkp@intel.com>
References: <20240723090454.8241-2-vigbalas@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240723090454.8241-2-vigbalas@amd.com>

Hi Vignesh,

kernel test robot noticed the following build errors:

[auto build test ERROR on kees/for-next/execve]
[also build test ERROR on tip/x86/core kees/for-next/pstore kees/for-next/kspp linus/master v6.10 next-20240723]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Vignesh-Balasubramanian/x86-elf-Add-a-new-note-section-containing-xfeatures-buffer-layout-info-to-x86-core-files/20240723-170946
base:   https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git for-next/execve
patch link:    https://lore.kernel.org/r/20240723090454.8241-2-vigbalas%40amd.com
patch subject: [PATCH v4 1/1] x86/elf: Add a new .note section containing xfeatures buffer layout info to x86 core files
config: x86_64-buildonly-randconfig-005-20240724 (https://download.01.org/0day-ci/archive/20240724/202407240659.eRyEDmG1-lkp@intel.com/config)
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240724/202407240659.eRyEDmG1-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202407240659.eRyEDmG1-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from <built-in>:1:
   ./usr/include/asm/elf.h:6:2: error: unknown type name 'u32'
       6 |         u32 type;
         |         ^
   ./usr/include/asm/elf.h:7:2: error: unknown type name 'u32'
       7 |         u32 size;
         |         ^
   ./usr/include/asm/elf.h:8:2: error: unknown type name 'u32'
       8 |         u32 offset;
         |         ^
   ./usr/include/asm/elf.h:9:2: error: unknown type name 'u32'
       9 |         u32 flags;
         |         ^
>> ./usr/include/asm/elf.h:12:16: error: static assertion failed due to requirement 'sizeof(struct x86_xfeat_component) % 4 == 0': x86_xfeat_component is not aligned
      12 | _Static_assert(sizeof(struct x86_xfeat_component)%4 == 0, "x86_xfeat_component is not aligned");
         |                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   ./usr/include/asm/elf.h:12:53: note: expression evaluates to '1 == 0'
      12 | _Static_assert(sizeof(struct x86_xfeat_component)%4 == 0, "x86_xfeat_component is not aligned");
         |                ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~
   5 errors generated.

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

