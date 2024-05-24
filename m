Return-Path: <linux-kernel+bounces-188249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DA218CDFAD
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 05:18:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24887281CED
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 03:18:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B587512E61;
	Fri, 24 May 2024 03:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UKSg5Htt"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 216BBBA45
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 03:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716520717; cv=none; b=q+jlfK0RojzoxoXgJ3cWvMr7SFHC6S5tvwDQcWw38OB95Tk4OJpno9b2ZJi7DBnnQxjXtx446DAI9ZLYow6Qq0W+svg5fshtzCzMonUWBhRs53QCOxnXmZs6aDqJGwnUKeT3t+8/hbPfbILo9Mc3Hxnq66hfEoZ5vG3O47ErXsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716520717; c=relaxed/simple;
	bh=CmwkT08Wml58wAZ0fufhXC4LR6Vf2WvUoVrYuKBhHUY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KJrZOFGO31upAjDO3VBnFAoyPvtQ6f3Rl3jDjGkh/mLs8Um5ETCJZeJfKYJd1DK/f3HkEn8QH37W/xJ80bz5GEF8bYb9M1z5G1HXd2mNGfn1nd6ROoq0WPgFxnNzNnUHsKswTD6XYgTedpTbLc13SBfAOPwqbstUHJDULWkh89o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UKSg5Htt; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716520717; x=1748056717;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CmwkT08Wml58wAZ0fufhXC4LR6Vf2WvUoVrYuKBhHUY=;
  b=UKSg5HttqLaskS6zSTNn7cQC+Puijbhqg4w+hSybXuubnuv9db0uZzFY
   eEWBgzabZgdoUWTsZlivhx4a75ZMoMnoq9mtwB/w0WJNMQEuuZ8J912Ds
   Km0UN6O7pxR9M3dTOyLWOtAZdeFJYK5eWHyZP3M6YxnA8GIpEA99Hsei1
   Z/Bk20J5iN4CMSpYHnCKqBpQMNTLJR/3xc+cYT/8s90Vyaew7Az6X9lMy
   0MTPHYI0siYfKaPHiZg0HMKpTdkwoyxzQfqqQIlXnRNRLwTWIEnnCsJ4B
   m08XX+xAdE0+cbHxetrNAL3Lvdo68d31E9OuSfkeSjDaHjy8SV0yiWmPk
   A==;
X-CSE-ConnectionGUID: EgoNuA1GR6az9ZF+ksw71A==
X-CSE-MsgGUID: aC3k9JgDTRa5DXuRUUBwGQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11081"; a="12997732"
X-IronPort-AV: E=Sophos;i="6.08,184,1712646000"; 
   d="scan'208";a="12997732"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2024 20:18:14 -0700
X-CSE-ConnectionGUID: 8rBYzwWGRWyGrPd9329P8w==
X-CSE-MsgGUID: dyWvMqt8QVSPk+xJ1pnCjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,184,1712646000"; 
   d="scan'208";a="34487139"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by orviesa007.jf.intel.com with ESMTP; 23 May 2024 20:18:08 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sALRH-0003ml-0P;
	Fri, 24 May 2024 03:17:55 +0000
Date: Fri, 24 May 2024 11:17:08 +0800
From: kernel test robot <lkp@intel.com>
To: Coiby Xu <coxu@redhat.com>, kexec@lists.infradead.org
Cc: oe-kbuild-all@lists.linux.dev, Ondrej Kozina <okozina@redhat.com>,
	Milan Broz <gmazyland@gmail.com>,
	Thomas Staudt <tstaudt@de.ibm.com>,
	Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
	Kairui Song <ryncsn@gmail.com>,
	Jan Pazdziora <jpazdziora@redhat.com>,
	Pingfan Liu <kernelfans@gmail.com>, Baoquan He <bhe@redhat.com>,
	Dave Young <dyoung@redhat.com>, linux-kernel@vger.kernel.org,
	x86@kernel.org, Dave Hansen <dave.hansen@intel.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Vivek Goyal <vgoyal@redhat.com>,
	Eric Biederman <ebiederm@xmission.com>
Subject: Re: [PATCH v4 3/7] crash_dump: store dm keys in kdump reserved memory
Message-ID: <202405241012.KlmCbp77-lkp@intel.com>
References: <20240523050451.788754-4-coxu@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240523050451.788754-4-coxu@redhat.com>

Hi Coiby,

kernel test robot noticed the following build errors:

[auto build test ERROR on de7e71ef8bed222dd144d8878091ecb6d5dfd208]

url:    https://github.com/intel-lab-lkp/linux/commits/Coiby-Xu/kexec_file-allow-to-place-kexec_buf-randomly/20240523-130727
base:   de7e71ef8bed222dd144d8878091ecb6d5dfd208
patch link:    https://lore.kernel.org/r/20240523050451.788754-4-coxu%40redhat.com
patch subject: [PATCH v4 3/7] crash_dump: store dm keys in kdump reserved memory
config: arm-allmodconfig (https://download.01.org/0day-ci/archive/20240524/202405241012.KlmCbp77-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240524/202405241012.KlmCbp77-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405241012.KlmCbp77-lkp@intel.com/

All errors (new ones prefixed by >>):

   kernel/crash_dump_dm_crypt.c: In function 'crash_load_dm_crypt_keys':
>> kernel/crash_dump_dm_crypt.c:158:16: error: variable 'kbuf' has initializer but incomplete type
     158 |         struct kexec_buf kbuf = {
         |                ^~~~~~~~~
>> kernel/crash_dump_dm_crypt.c:159:18: error: 'struct kexec_buf' has no member named 'image'
     159 |                 .image = image,
         |                  ^~~~~
   kernel/crash_dump_dm_crypt.c:159:26: warning: excess elements in struct initializer
     159 |                 .image = image,
         |                          ^~~~~
   kernel/crash_dump_dm_crypt.c:159:26: note: (near initialization for 'kbuf')
>> kernel/crash_dump_dm_crypt.c:160:18: error: 'struct kexec_buf' has no member named 'buf_min'
     160 |                 .buf_min = 0,
         |                  ^~~~~~~
   kernel/crash_dump_dm_crypt.c:160:28: warning: excess elements in struct initializer
     160 |                 .buf_min = 0,
         |                            ^
   kernel/crash_dump_dm_crypt.c:160:28: note: (near initialization for 'kbuf')
>> kernel/crash_dump_dm_crypt.c:161:18: error: 'struct kexec_buf' has no member named 'buf_max'
     161 |                 .buf_max = ULONG_MAX,
         |                  ^~~~~~~
   In file included from include/linux/limits.h:7,
                    from include/linux/thread_info.h:12,
                    from include/asm-generic/preempt.h:5,
                    from ./arch/arm/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:79,
                    from include/linux/rcupdate.h:27,
                    from include/linux/rbtree.h:24,
                    from include/linux/key.h:15,
                    from kernel/crash_dump_dm_crypt.c:2:
   include/vdso/limits.h:13:25: warning: excess elements in struct initializer
      13 | #define ULONG_MAX       (~0UL)
         |                         ^
   kernel/crash_dump_dm_crypt.c:161:28: note: in expansion of macro 'ULONG_MAX'
     161 |                 .buf_max = ULONG_MAX,
         |                            ^~~~~~~~~
   include/vdso/limits.h:13:25: note: (near initialization for 'kbuf')
      13 | #define ULONG_MAX       (~0UL)
         |                         ^
   kernel/crash_dump_dm_crypt.c:161:28: note: in expansion of macro 'ULONG_MAX'
     161 |                 .buf_max = ULONG_MAX,
         |                            ^~~~~~~~~
>> kernel/crash_dump_dm_crypt.c:162:18: error: 'struct kexec_buf' has no member named 'top_down'
     162 |                 .top_down = false,
         |                  ^~~~~~~~
   kernel/crash_dump_dm_crypt.c:162:29: warning: excess elements in struct initializer
     162 |                 .top_down = false,
         |                             ^~~~~
   kernel/crash_dump_dm_crypt.c:162:29: note: (near initialization for 'kbuf')
>> kernel/crash_dump_dm_crypt.c:163:18: error: 'struct kexec_buf' has no member named 'random'
     163 |                 .random = true,
         |                  ^~~~~~
   kernel/crash_dump_dm_crypt.c:163:27: warning: excess elements in struct initializer
     163 |                 .random = true,
         |                           ^~~~
   kernel/crash_dump_dm_crypt.c:163:27: note: (near initialization for 'kbuf')
>> kernel/crash_dump_dm_crypt.c:158:26: error: storage size of 'kbuf' isn't known
     158 |         struct kexec_buf kbuf = {
         |                          ^~~~
>> kernel/crash_dump_dm_crypt.c:187:20: error: 'KEXEC_BUF_MEM_UNKNOWN' undeclared (first use in this function)
     187 |         kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
         |                    ^~~~~~~~~~~~~~~~~~~~~
   kernel/crash_dump_dm_crypt.c:187:20: note: each undeclared identifier is reported only once for each function it appears in
>> kernel/crash_dump_dm_crypt.c:188:13: error: implicit declaration of function 'kexec_add_buffer' [-Werror=implicit-function-declaration]
     188 |         r = kexec_add_buffer(&kbuf);
         |             ^~~~~~~~~~~~~~~~
   kernel/crash_dump_dm_crypt.c:158:26: warning: unused variable 'kbuf' [-Wunused-variable]
     158 |         struct kexec_buf kbuf = {
         |                          ^~~~
   cc1: some warnings being treated as errors


vim +/kbuf +158 kernel/crash_dump_dm_crypt.c

   155	
   156	int crash_load_dm_crypt_keys(struct kimage *image)
   157	{
 > 158		struct kexec_buf kbuf = {
 > 159			.image = image,
 > 160			.buf_min = 0,
 > 161			.buf_max = ULONG_MAX,
 > 162			.top_down = false,
 > 163			.random = true,
   164		};
   165	
   166		int r;
   167	
   168		if (state == FRESH)
   169			return 0;
   170	
   171		if (key_count != keys_header->key_count) {
   172			pr_err("Only record %u keys (%u in total)\n", key_count,
   173			       keys_header->key_count);
   174			return -EINVAL;
   175		}
   176	
   177		image->dm_crypt_keys_addr = 0;
   178		r = build_keys_header();
   179		if (r)
   180			return r;
   181	
   182		kbuf.buffer = keys_header;
   183		kbuf.bufsz = keys_header_size;
   184	
   185		kbuf.memsz = kbuf.bufsz;
   186		kbuf.buf_align = ELF_CORE_HEADER_ALIGN;
 > 187		kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
 > 188		r = kexec_add_buffer(&kbuf);

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

