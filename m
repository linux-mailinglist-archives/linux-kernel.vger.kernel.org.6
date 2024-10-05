Return-Path: <linux-kernel+bounces-351750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 985FA99159E
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 12:01:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B20FD1C21404
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 10:01:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC7BE5C613;
	Sat,  5 Oct 2024 10:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kcV2vbCC"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F66A231CA7
	for <linux-kernel@vger.kernel.org>; Sat,  5 Oct 2024 10:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728122469; cv=none; b=REemNNfOq2EbvowCmbQDC8uas6dAVWPCkga0TCqEiN8bxU0CQJ+fDZVxWeKj+GQqkTap8jPFEdpwEKp7GQUBMjZGo+D6Qwd8IK8LBdoxRWrU5TiMgJKaiu0nmkejkushgUzki59m2SYcZutmyHgwwrqyxq8jRb/hNN5Ye6xMOcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728122469; c=relaxed/simple;
	bh=nMf3pELHL1cs+msf2RX5vhmEapBTsV/nTOw2y1HKlzI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m9QtmsguUWhiaVvDTnwnSs0B3xsl4qKraIqsmSSQdo+pU/PX2eUuhk9lZfVfWghV9DtHck490QypdwEN2C8+sNvDisrvZAyBWtEcANGxLY9FFcPucm4xW8z8swcpVWkS1d3tryjO+wdeC+3+HId+Bru77SlA+ISSjqTJOqSHufc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kcV2vbCC; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728122468; x=1759658468;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nMf3pELHL1cs+msf2RX5vhmEapBTsV/nTOw2y1HKlzI=;
  b=kcV2vbCCY9lWhYwGzSNcO8J5FiUDjFXJ6Lcz20E4n4PcRwzo/r4AuyVE
   zDPL98rgVY9POiB1kQJIaw92zfe4ErRBWws5pcpz9zo+hAdzmuSvoOnk1
   iIQUmGDKzDZy30A3cxFVkTmY3HB8I4dMK7LaobKxo+f9z5CL3QbGoS2Yi
   ZBE6BQil74TWZu6A5ue/SokarP2gprZcbfIrCITAhh2gSnv3wnFdazw7x
   zQ3BcxrKYlsGJnApdV48kVKd5lsEb1+SCuFn5H56kq3KIw4KqTbw1XSEz
   dTxnKBoxBKatEEvdEl1GZtGU4p0SvW1YgPTfTUAl1NnE5zZQD3NwJkLYT
   g==;
X-CSE-ConnectionGUID: sMCqFLKxSoK4VqjTeMp8Aw==
X-CSE-MsgGUID: h0eTfywMRl+JZhi+WXYINw==
X-IronPort-AV: E=McAfee;i="6700,10204,11215"; a="27426125"
X-IronPort-AV: E=Sophos;i="6.11,180,1725346800"; 
   d="scan'208";a="27426125"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2024 03:01:07 -0700
X-CSE-ConnectionGUID: JmKzTfbbTi20XzLvp0CRkg==
X-CSE-MsgGUID: D+b79H58QH+6L4SnXtAb/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,180,1725346800"; 
   d="scan'208";a="105707402"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 05 Oct 2024 03:01:05 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sx1ax-0002pq-0C;
	Sat, 05 Oct 2024 10:01:03 +0000
Date: Sat, 5 Oct 2024 18:00:51 +0800
From: kernel test robot <lkp@intel.com>
To: Xiaofeng Lian <1198715581lxf@gmail.com>, stefani@seibold.net,
	linux-kernel@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Xiaofeng Lian <1198715581lxf@gmail.com>
Subject: Re: [PATCH v2] include/linux/kfifo.h: fix some IDEs Intelligence
 errors and the previous patch was misnamed
Message-ID: <202410051712.VDmFpiVZ-lkp@intel.com>
References: <20241002172427.412715-1-1198715581lxf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241002172427.412715-1-1198715581lxf@gmail.com>

Hi Xiaofeng,

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on v6.12-rc1 next-20241004]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Xiaofeng-Lian/include-linux-kfifo-h-fix-some-IDEs-Intelligence-errors-and-the-previous-patch-was-misnamed/20241003-012640
base:   linus/master
patch link:    https://lore.kernel.org/r/20241002172427.412715-1-1198715581lxf%40gmail.com
patch subject: [PATCH v2] include/linux/kfifo.h: fix some IDEs Intelligence errors and the previous patch was misnamed
config: x86_64-kexec (https://download.01.org/0day-ci/archive/20241005/202410051712.VDmFpiVZ-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241005/202410051712.VDmFpiVZ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410051712.VDmFpiVZ-lkp@intel.com/

All errors (new ones prefixed by >>):

>> arch/x86/kvm/hyperv.c:984:3: error: member reference base type 'u64' (aka 'unsigned long long') is not a structure or union
     984 |                 INIT_KFIFO(hv_vcpu->tlb_flush_fifo[i].entries);
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/kfifo.h:151:46: note: expanded from macro 'INIT_KFIFO'
     151 |         __kfifo->mask = __is_kfifo_ptr(__tmp) ? 0 : __KFIFO_SIZE(__tmp->buf) - 1;\
         |                                                     ^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/kfifo.h:138:34: note: expanded from macro '__KFIFO_SIZE'
     138 |                 DECLARE_KFIFO_PTR(__tmp_kfifo, get_kfifo_data_type(fifo));\
         |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/kfifo.h:130:49: note: expanded from macro 'get_kfifo_data_type'
     130 | #define get_kfifo_data_type(fifo) typeof(*(fifo)->type)
         |                                                 ^ ~~~~
   note: (skipping 1 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/kfifo.h:84:28: note: expanded from macro 'STRUCT_KFIFO_PTR'
      84 |         struct __STRUCT_KFIFO_PTR(type, 0, type)
         |                ~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~
   include/linux/kfifo.h:79:24: note: expanded from macro '__STRUCT_KFIFO_PTR'
      79 |         __STRUCT_KFIFO_COMMON(type, recsize, ptrtype); \
         |         ~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/kfifo.h:61:3: note: expanded from macro '__STRUCT_KFIFO_COMMON'
      61 |                 datatype        *type; \
         |                 ^~~~~~~~
>> arch/x86/kvm/hyperv.c:984:3: error: member reference base type 'u64' (aka 'unsigned long long') is not a structure or union
     984 |                 INIT_KFIFO(hv_vcpu->tlb_flush_fifo[i].entries);
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/kfifo.h:151:46: note: expanded from macro 'INIT_KFIFO'
     151 |         __kfifo->mask = __is_kfifo_ptr(__tmp) ? 0 : __KFIFO_SIZE(__tmp->buf) - 1;\
         |                                                     ^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/kfifo.h:138:34: note: expanded from macro '__KFIFO_SIZE'
     138 |                 DECLARE_KFIFO_PTR(__tmp_kfifo, get_kfifo_data_type(fifo));\
         |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/kfifo.h:130:49: note: expanded from macro 'get_kfifo_data_type'
     130 | #define get_kfifo_data_type(fifo) typeof(*(fifo)->type)
         |                                                 ^ ~~~~
   note: (skipping 1 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/kfifo.h:84:28: note: expanded from macro 'STRUCT_KFIFO_PTR'
      84 |         struct __STRUCT_KFIFO_PTR(type, 0, type)
         |                ~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~
   include/linux/kfifo.h:79:24: note: expanded from macro '__STRUCT_KFIFO_PTR'
      79 |         __STRUCT_KFIFO_COMMON(type, recsize, ptrtype); \
         |         ~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/kfifo.h:62:9: note: expanded from macro '__STRUCT_KFIFO_COMMON'
      62 |                 const datatype  *const_type; \
         |                       ^~~~~~~~
>> arch/x86/kvm/hyperv.c:984:3: error: member reference base type 'u64' (aka 'unsigned long long') is not a structure or union
     984 |                 INIT_KFIFO(hv_vcpu->tlb_flush_fifo[i].entries);
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/kfifo.h:151:46: note: expanded from macro 'INIT_KFIFO'
     151 |         __kfifo->mask = __is_kfifo_ptr(__tmp) ? 0 : __KFIFO_SIZE(__tmp->buf) - 1;\
         |                                                     ^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/kfifo.h:138:34: note: expanded from macro '__KFIFO_SIZE'
     138 |                 DECLARE_KFIFO_PTR(__tmp_kfifo, get_kfifo_data_type(fifo));\
         |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/kfifo.h:130:49: note: expanded from macro 'get_kfifo_data_type'
     130 | #define get_kfifo_data_type(fifo) typeof(*(fifo)->type)
         |                                                 ^ ~~~~
   note: (skipping 1 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/kfifo.h:84:37: note: expanded from macro 'STRUCT_KFIFO_PTR'
      84 |         struct __STRUCT_KFIFO_PTR(type, 0, type)
         |                ~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~
   include/linux/kfifo.h:79:39: note: expanded from macro '__STRUCT_KFIFO_PTR'
      79 |         __STRUCT_KFIFO_COMMON(type, recsize, ptrtype); \
         |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~
   include/linux/kfifo.h:64:3: note: expanded from macro '__STRUCT_KFIFO_COMMON'
      64 |                 ptrtype         *ptr; \
         |                 ^~~~~~~
>> arch/x86/kvm/hyperv.c:984:3: error: member reference base type 'u64' (aka 'unsigned long long') is not a structure or union
     984 |                 INIT_KFIFO(hv_vcpu->tlb_flush_fifo[i].entries);
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/kfifo.h:151:46: note: expanded from macro 'INIT_KFIFO'
     151 |         __kfifo->mask = __is_kfifo_ptr(__tmp) ? 0 : __KFIFO_SIZE(__tmp->buf) - 1;\
         |                                                     ^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/kfifo.h:138:34: note: expanded from macro '__KFIFO_SIZE'
     138 |                 DECLARE_KFIFO_PTR(__tmp_kfifo, get_kfifo_data_type(fifo));\
         |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/kfifo.h:130:49: note: expanded from macro 'get_kfifo_data_type'
     130 | #define get_kfifo_data_type(fifo) typeof(*(fifo)->type)
         |                                                 ^ ~~~~
   note: (skipping 1 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/kfifo.h:84:37: note: expanded from macro 'STRUCT_KFIFO_PTR'
      84 |         struct __STRUCT_KFIFO_PTR(type, 0, type)
         |                ~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~
   include/linux/kfifo.h:79:39: note: expanded from macro '__STRUCT_KFIFO_PTR'
      79 |         __STRUCT_KFIFO_COMMON(type, recsize, ptrtype); \
         |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~
   include/linux/kfifo.h:65:3: note: expanded from macro '__STRUCT_KFIFO_COMMON'
      65 |                 ptrtype const   *ptr_const; \
         |                 ^~~~~~~
>> arch/x86/kvm/hyperv.c:984:3: error: member reference base type 'u64' (aka 'unsigned long long') is not a structure or union
     984 |                 INIT_KFIFO(hv_vcpu->tlb_flush_fifo[i].entries);
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/kfifo.h:151:46: note: expanded from macro 'INIT_KFIFO'
     151 |         __kfifo->mask = __is_kfifo_ptr(__tmp) ? 0 : __KFIFO_SIZE(__tmp->buf) - 1;\
         |                                                     ^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/kfifo.h:138:34: note: expanded from macro '__KFIFO_SIZE'
     138 |                 DECLARE_KFIFO_PTR(__tmp_kfifo, get_kfifo_data_type(fifo));\
         |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/kfifo.h:130:49: note: expanded from macro 'get_kfifo_data_type'
     130 | #define get_kfifo_data_type(fifo) typeof(*(fifo)->type)
         |                                                 ^ ~~~~
   include/linux/kfifo.h:116:56: note: expanded from macro 'DECLARE_KFIFO_PTR'
     116 | #define DECLARE_KFIFO_PTR(fifo, type)   STRUCT_KFIFO_PTR(type) fifo
         |                                         ~~~~~~~~~~~~~~~~~^~~~~
   include/linux/kfifo.h:84:28: note: expanded from macro 'STRUCT_KFIFO_PTR'
      84 |         struct __STRUCT_KFIFO_PTR(type, 0, type)
         |                ~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~
   include/linux/kfifo.h:80:2: note: expanded from macro '__STRUCT_KFIFO_PTR'
      80 |         type            buf[0]; \
         |         ^~~~
>> arch/x86/kvm/hyperv.c:984:3: error: member reference base type 'u64' (aka 'unsigned long long') is not a structure or union
     984 |                 INIT_KFIFO(hv_vcpu->tlb_flush_fifo[i].entries);
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/kfifo.h:151:46: note: expanded from macro 'INIT_KFIFO'
     151 |         __kfifo->mask = __is_kfifo_ptr(__tmp) ? 0 : __KFIFO_SIZE(__tmp->buf) - 1;\
         |                                                     ^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/kfifo.h:139:52: note: expanded from macro '__KFIFO_SIZE'
     139 |                 (sizeof(*(fifo)) - sizeof(__tmp_kfifo)) / sizeof(get_kfifo_data_type(fifo));\
         |                                                                  ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/kfifo.h:130:49: note: expanded from macro 'get_kfifo_data_type'
     130 | #define get_kfifo_data_type(fifo) typeof(*(fifo)->type)
         |                                           ~~~~~~^ ~~~~
>> arch/x86/kvm/hyperv.c:984:3: error: invalid operands to binary expression ('void' and 'int')
     984 |                 INIT_KFIFO(hv_vcpu->tlb_flush_fifo[i].entries);
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/kfifo.h:151:71: note: expanded from macro 'INIT_KFIFO'
     151 |         __kfifo->mask = __is_kfifo_ptr(__tmp) ? 0 : __KFIFO_SIZE(__tmp->buf) - 1;\
         |                                                     ~~~~~~~~~~~~~~~~~~~~~~~~ ^ ~
   7 errors generated.


vim +984 arch/x86/kvm/hyperv.c

1f4b34f825e8ce Andrey Smetanin     2015-11-30  959  
3be29eb7b5251a Sean Christopherson 2022-08-30  960  int kvm_hv_vcpu_init(struct kvm_vcpu *vcpu)
5c919412fe61c3 Andrey Smetanin     2015-11-10  961  {
1cac8d9f6bd25d Sean Christopherson 2022-08-30  962  	struct kvm_vcpu_hv *hv_vcpu = to_hv_vcpu(vcpu);
1f4b34f825e8ce Andrey Smetanin     2015-11-30  963  	int i;
1f4b34f825e8ce Andrey Smetanin     2015-11-30  964  
1cac8d9f6bd25d Sean Christopherson 2022-08-30  965  	if (hv_vcpu)
1cac8d9f6bd25d Sean Christopherson 2022-08-30  966  		return 0;
1cac8d9f6bd25d Sean Christopherson 2022-08-30  967  
4592b7eaa87d35 Vitaly Kuznetsov    2021-01-26  968  	hv_vcpu = kzalloc(sizeof(struct kvm_vcpu_hv), GFP_KERNEL_ACCOUNT);
4592b7eaa87d35 Vitaly Kuznetsov    2021-01-26  969  	if (!hv_vcpu)
4592b7eaa87d35 Vitaly Kuznetsov    2021-01-26  970  		return -ENOMEM;
4592b7eaa87d35 Vitaly Kuznetsov    2021-01-26  971  
4592b7eaa87d35 Vitaly Kuznetsov    2021-01-26  972  	vcpu->arch.hyperv = hv_vcpu;
4592b7eaa87d35 Vitaly Kuznetsov    2021-01-26  973  	hv_vcpu->vcpu = vcpu;
4592b7eaa87d35 Vitaly Kuznetsov    2021-01-26  974  
1f4b34f825e8ce Andrey Smetanin     2015-11-30  975  	synic_init(&hv_vcpu->synic);
1f4b34f825e8ce Andrey Smetanin     2015-11-30  976  
1f4b34f825e8ce Andrey Smetanin     2015-11-30  977  	bitmap_zero(hv_vcpu->stimer_pending_bitmap, HV_SYNIC_STIMER_COUNT);
1f4b34f825e8ce Andrey Smetanin     2015-11-30  978  	for (i = 0; i < ARRAY_SIZE(hv_vcpu->stimer); i++)
1f4b34f825e8ce Andrey Smetanin     2015-11-30  979  		stimer_init(&hv_vcpu->stimer[i], i);
4592b7eaa87d35 Vitaly Kuznetsov    2021-01-26  980  
4eeef2424153e7 Sean Christopherson 2021-09-10  981  	hv_vcpu->vp_index = vcpu->vcpu_idx;
fc08b628d7c96d Vitaly Kuznetsov    2021-01-26  982  
53ca765a041d5a Vitaly Kuznetsov    2022-11-01  983  	for (i = 0; i < HV_NR_TLB_FLUSH_FIFOS; i++) {
53ca765a041d5a Vitaly Kuznetsov    2022-11-01 @984  		INIT_KFIFO(hv_vcpu->tlb_flush_fifo[i].entries);
53ca765a041d5a Vitaly Kuznetsov    2022-11-01  985  		spin_lock_init(&hv_vcpu->tlb_flush_fifo[i].write_lock);
53ca765a041d5a Vitaly Kuznetsov    2022-11-01  986  	}
0823570f01989d Vitaly Kuznetsov    2022-11-01  987  
4592b7eaa87d35 Vitaly Kuznetsov    2021-01-26  988  	return 0;
5c919412fe61c3 Andrey Smetanin     2015-11-10  989  }
5c919412fe61c3 Andrey Smetanin     2015-11-10  990  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

