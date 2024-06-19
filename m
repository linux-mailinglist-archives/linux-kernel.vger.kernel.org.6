Return-Path: <linux-kernel+bounces-221796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C5D590F8A8
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 00:00:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A68B91C20ACC
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 22:00:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9FD015AD93;
	Wed, 19 Jun 2024 21:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EvJeMceL"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 767C961FCF
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 21:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718834340; cv=none; b=DK3o0IAIBsQhRwlFZKCrNtqJVCq7mGDqy3sDCVazVgfsoub3Afeisbef1TFWAEG8CPMDKVtClyNLIC4OLZfqTOpMMq+2JUHIUHIhpAn/xvZV8hQkPpZHLKdMj7+/VgGAnUwvAWEnxaVeg/7+y9xSESqL5NIfdSK7j15cwdT7wCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718834340; c=relaxed/simple;
	bh=qiZqO9L1rSIQ0dexkuwPdqbmq3z4EzfCErZNkfPkG6A=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=jMLXaKkkQ/G/TVEJQ0HoLi6aKpPxvEVYm26fD8yVypypVdWJEp1Wb7wPrO5XZS2QCzhOAGJVM022gI9EIUELX+x9jgfrh3ZJPRrhl9aFmggQl+8VuvnAJJ56x5ObUVuDqFG44u2SJ0tvthZzyBngsgCnK853ymSG2TNMo1J00FM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EvJeMceL; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718834339; x=1750370339;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=qiZqO9L1rSIQ0dexkuwPdqbmq3z4EzfCErZNkfPkG6A=;
  b=EvJeMceLL5p3e6UUxdfpV6dIEK6V4JnmiV85+NL+EIXHUnSrdb9qrf4R
   EiXDY1DdCWos1jci8uYJUtktFhtDliYOzyhuPgEOkdaK9btbOIKLgJTap
   YUH9Fbgim/Moh612Z2VonyXXjZHsUbRn1v71UnjZ3E+pv1Q40JjlImOKA
   O+a4pXkmejV+dJnrCIombVIx0Bhv7qsfTNzQajHhvpZ8J7hcl7NlKtAMY
   158IkhakV9qEG6R0ZkKUPCPLhi3/j5p+gYfukuVYMqCP3N/nvZXSvQh9l
   Od38MIptCYuP/Li+AExwIk9n/n4+nWOf2/BnXDLJhpaVihotPPjGo9pIG
   w==;
X-CSE-ConnectionGUID: O0cq2lKfQIa4rmEkEetmMw==
X-CSE-MsgGUID: Yw6zLPgDS8avTEevKYfklA==
X-IronPort-AV: E=McAfee;i="6700,10204,11108"; a="15551540"
X-IronPort-AV: E=Sophos;i="6.08,251,1712646000"; 
   d="scan'208";a="15551540"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2024 14:58:58 -0700
X-CSE-ConnectionGUID: c6FKJ2BYRh+4hdFFfjdOdg==
X-CSE-MsgGUID: 8PXfwZrrROKtjfBDnNOQpw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,251,1712646000"; 
   d="scan'208";a="46408017"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 19 Jun 2024 14:58:56 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sK3KQ-00072I-0e;
	Wed, 19 Jun 2024 21:58:54 +0000
Date: Thu, 20 Jun 2024 05:58:13 +0800
From: kernel test robot <lkp@intel.com>
To: "Borislav Petkov (AMD)" <bp@alien8.de>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	x86@kernel.org
Subject: [tip:x86/alternatives 15/15]
 arch/x86/include/asm/alternative.h:251:25: error: expected string literal
 before ',' token
Message-ID: <202406200507.AXxJ6Bmw-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/alternatives
head:   93f78dadee5e56ae48aff567583d503868aa3bf2
commit: 93f78dadee5e56ae48aff567583d503868aa3bf2 [15/15] x86/alternatives, kvm: Fix a couple of CALLs without a frame pointer
config: i386-randconfig-s052-20230614 (https://download.01.org/0day-ci/archive/20240620/202406200507.AXxJ6Bmw-lkp@intel.com/config)
compiler: gcc-13 (Ubuntu 13.2.0-4ubuntu3) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240620/202406200507.AXxJ6Bmw-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406200507.AXxJ6Bmw-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   In file included from arch/x86/include/asm/barrier.h:5,
                    from include/linux/list.h:11,
                    from include/linux/swait.h:5,
                    from include/linux/completion.h:12,
                    from include/linux/crypto.h:15,
                    from arch/x86/kernel/asm-offsets.c:9:
   arch/x86/include/asm/atomic64_32.h: In function 'arch_atomic64_set':
>> arch/x86/include/asm/alternative.h:251:25: error: expected string literal before ',' token
     251 |                 : output, ASM_CALL_CONSTRAINT : [old] "i" (oldfunc), [new] "i" (newfunc), ## input)
         |                         ^
   arch/x86/include/asm/atomic64_32.h:59:9: note: in expansion of macro 'alternative_call'
      59 |         alternative_call(atomic64_##f##_386, atomic64_##g##_cx8, \
         |         ^~~~~~~~~~~~~~~~
   arch/x86/include/asm/atomic64_32.h:72:9: note: in expansion of macro '__alternative_atomic64'
      72 |         __alternative_atomic64(f, f, ASM_OUTPUT2(out), ## in)
         |         ^~~~~~~~~~~~~~~~~~~~~~
   arch/x86/include/asm/atomic64_32.h:118:9: note: in expansion of macro 'alternative_atomic64'
     118 |         alternative_atomic64(set, /* no output */,
         |         ^~~~~~~~~~~~~~~~~~~~
   In file included from arch/x86/include/asm/atomic.h:172,
                    from include/linux/atomic.h:7,
                    from include/linux/jump_label.h:256,
                    from include/linux/static_key.h:1,
                    from arch/x86/include/asm/nospec-branch.h:6,
                    from arch/x86/include/asm/irqflags.h:9,
                    from include/linux/irqflags.h:18,
                    from include/linux/spinlock.h:59,
                    from include/linux/swait.h:7:
>> arch/x86/include/asm/atomic64_32.h:117:18: warning: unused variable 'low' [-Wunused-variable]
     117 |         unsigned low = (unsigned)i;
         |                  ^~~
>> arch/x86/include/asm/atomic64_32.h:116:18: warning: unused variable 'high' [-Wunused-variable]
     116 |         unsigned high = (unsigned)(i >> 32);
         |                  ^~~~
   arch/x86/include/asm/atomic64_32.h: In function 'arch_atomic64_inc':
>> arch/x86/include/asm/alternative.h:251:25: error: expected string literal before ',' token
     251 |                 : output, ASM_CALL_CONSTRAINT : [old] "i" (oldfunc), [new] "i" (newfunc), ## input)
         |                         ^
   arch/x86/include/asm/atomic64_32.h:59:9: note: in expansion of macro 'alternative_call'
      59 |         alternative_call(atomic64_##f##_386, atomic64_##g##_cx8, \
         |         ^~~~~~~~~~~~~~~~
   arch/x86/include/asm/atomic64_32.h:184:9: note: in expansion of macro '__alternative_atomic64'
     184 |         __alternative_atomic64(inc, inc_return, /* no output */,
         |         ^~~~~~~~~~~~~~~~~~~~~~
   arch/x86/include/asm/atomic64_32.h: In function 'arch_atomic64_dec':
>> arch/x86/include/asm/alternative.h:251:25: error: expected string literal before ',' token
     251 |                 : output, ASM_CALL_CONSTRAINT : [old] "i" (oldfunc), [new] "i" (newfunc), ## input)
         |                         ^
   arch/x86/include/asm/atomic64_32.h:59:9: note: in expansion of macro 'alternative_call'
      59 |         alternative_call(atomic64_##f##_386, atomic64_##g##_cx8, \
         |         ^~~~~~~~~~~~~~~~
   arch/x86/include/asm/atomic64_32.h:191:9: note: in expansion of macro '__alternative_atomic64'
     191 |         __alternative_atomic64(dec, dec_return, /* no output */,
         |         ^~~~~~~~~~~~~~~~~~~~~~
   make[3]: *** [scripts/Makefile.build:117: arch/x86/kernel/asm-offsets.s] Error 1
   make[3]: Target 'prepare' not remade because of errors.
   make[2]: *** [Makefile:1208: prepare0] Error 2
   make[2]: Target 'prepare' not remade because of errors.
   make[1]: *** [Makefile:240: __sub-make] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:240: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.


vim +251 arch/x86/include/asm/alternative.h

   162	
   163	#define OLDINSTR(oldinstr)						\
   164		"# ALT: oldinstr\n"						\
   165		"771:\n\t" oldinstr "\n772:\n"					\
   166		"# ALT: padding\n"						\
   167		".skip -(((" alt_rlen ")-(" alt_slen ")) > 0) * "		\
   168			"((" alt_rlen ")-(" alt_slen ")),0x90\n"		\
   169		"773:\n"
   170	
   171	#define ALTINSTR_ENTRY(ft_flags)					      \
   172		".pushsection .altinstructions,\"a\"\n"				      \
   173		" .long 771b - .\n"				/* label           */ \
   174		" .long 774f - .\n"				/* new instruction */ \
   175		" .4byte " __stringify(ft_flags) "\n"		/* feature + flags */ \
   176		" .byte " alt_total_slen "\n"			/* source len      */ \
   177		" .byte " alt_rlen "\n"				/* replacement len */ \
   178		".popsection\n"
   179	
   180	#define ALTINSTR_REPLACEMENT(newinstr)		/* replacement */	\
   181		".pushsection .altinstr_replacement, \"ax\"\n"			\
   182		"# ALT: replacement\n"						\
   183		"774:\n\t" newinstr "\n775:\n"					\
   184		".popsection\n"
   185	
   186	/* alternative assembly primitive: */
   187	#define ALTERNATIVE(oldinstr, newinstr, ft_flags)			\
   188		OLDINSTR(oldinstr)						\
   189		ALTINSTR_ENTRY(ft_flags)					\
   190		ALTINSTR_REPLACEMENT(newinstr)
   191	
   192	#define ALTERNATIVE_2(oldinstr, newinstr1, ft_flags1, newinstr2, ft_flags2) \
   193		ALTERNATIVE(ALTERNATIVE(oldinstr, newinstr1, ft_flags1), newinstr2, ft_flags2)
   194	
   195	/* If @feature is set, patch in @newinstr_yes, otherwise @newinstr_no. */
   196	#define ALTERNATIVE_TERNARY(oldinstr, ft_flags, newinstr_yes, newinstr_no) \
   197		ALTERNATIVE_2(oldinstr, newinstr_no, X86_FEATURE_ALWAYS, newinstr_yes, ft_flags)
   198	
   199	#define ALTERNATIVE_3(oldinstr, newinstr1, ft_flags1, newinstr2, ft_flags2, \
   200				newinstr3, ft_flags3)				\
   201		ALTERNATIVE(ALTERNATIVE_2(oldinstr, newinstr1, ft_flags1, newinstr2, ft_flags2), \
   202			      newinstr3, ft_flags3)
   203	
   204	/*
   205	 * Alternative instructions for different CPU types or capabilities.
   206	 *
   207	 * This allows to use optimized instructions even on generic binary
   208	 * kernels.
   209	 *
   210	 * length of oldinstr must be longer or equal the length of newinstr
   211	 * It can be padded with nops as needed.
   212	 *
   213	 * For non barrier like inlines please define new variants
   214	 * without volatile and memory clobber.
   215	 */
   216	#define alternative(oldinstr, newinstr, ft_flags)			\
   217		asm_inline volatile(ALTERNATIVE(oldinstr, newinstr, ft_flags) : : : "memory")
   218	
   219	#define alternative_2(oldinstr, newinstr1, ft_flags1, newinstr2, ft_flags2) \
   220		asm_inline volatile(ALTERNATIVE_2(oldinstr, newinstr1, ft_flags1, newinstr2, ft_flags2) ::: "memory")
   221	
   222	/*
   223	 * Alternative inline assembly with input.
   224	 *
   225	 * Peculiarities:
   226	 * No memory clobber here.
   227	 * Argument numbers start with 1.
   228	 * Leaving an unused argument 0 to keep API compatibility.
   229	 */
   230	#define alternative_input(oldinstr, newinstr, ft_flags, input...)	\
   231		asm_inline volatile(ALTERNATIVE(oldinstr, newinstr, ft_flags) \
   232			: : "i" (0), ## input)
   233	
   234	/* Like alternative_input, but with a single output argument */
   235	#define alternative_io(oldinstr, newinstr, ft_flags, output, input...)	\
   236		asm_inline volatile(ALTERNATIVE(oldinstr, newinstr, ft_flags)	\
   237			: output : "i" (0), ## input)
   238	
   239	/*
   240	 * Like alternative_io, but for replacing a direct call with another one.
   241	 *
   242	 * Use the %c operand modifier which is the generic way to print a bare
   243	 * constant expression with all syntax-specific punctuation omitted. %P
   244	 * is the x86-specific variant which can handle constants too, for
   245	 * historical reasons, but it should be used primarily for PIC
   246	 * references: i.e., if used for a function, it would add the PLT
   247	 * suffix.
   248	 */
   249	#define alternative_call(oldfunc, newfunc, ft_flags, output, input...)	\
   250		asm_inline volatile(ALTERNATIVE("call %c[old]", "call %c[new]", ft_flags) \
 > 251			: output, ASM_CALL_CONSTRAINT : [old] "i" (oldfunc), [new] "i" (newfunc), ## input)
   252	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

