Return-Path: <linux-kernel+bounces-313575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 88FA496A72C
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 21:14:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07E5A1F2514A
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 19:14:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50DD21D5CD0;
	Tue,  3 Sep 2024 19:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="btG6/m82"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12AA61D5CC3
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 19:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725390871; cv=none; b=Ph+DFDDcDhGwxCozeB9XvUxA/vAZe6frdQwb0ChgkA7HIRmCbQtLrDPq0i78X6fqJDYzlCaLZRt6thFD7rK8Bwr2I1GivdG420EzSFeAoTxoQhQeetJo6odjrypiU2Wbez/Iz3m4C3SWtpIu+2aVO62uKqRU5/dj73pVwc4Way4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725390871; c=relaxed/simple;
	bh=or6X0wP8ozeFggLTdXEFslaB29MDKtBAB44XcYasXF8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rM0nfGV/oNZo0gWMI4X4ZJr7cHnlzuex1jjCYt1YwNw9YcZxFzMhlWAieeHQyH8r5NEkJWWtBCPUEvd5rPveQBWNZR0BtUf06nTFzng8BN7cuKnJ4nQovaAyKJBzGQuBJv7nvfjqLSsetUmGI7lRxwSqStl0UqD5pCUQdGWTREk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=btG6/m82; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725390870; x=1756926870;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=or6X0wP8ozeFggLTdXEFslaB29MDKtBAB44XcYasXF8=;
  b=btG6/m82J/LYRmEm3LRjHp8v5QYMmO2QOCMH/5xxp2NYfkWnTm+DrUGp
   9iDf0mqyjPnZepiqcRgu5SUyZEvD7DNK77uywTIWo9wnSry07RP7pVWeC
   zH0eh8K3lpnGMbzAamy7F3BmR2XmWe++vGZOF7kKc2UbzJSHCCD73UkMA
   dvkBfOeUqJd06xcVqCK1WI+whpMWklzyjWYEezWLyEcqdNme2BhtfGefA
   VZsxqWGfuNZmt5B1BTeMOPGCXp2p4YUou5kDwNL4/8cO+hzY8p7RdIKy1
   EXUrO/e0A+wUgYL0AVN3wIFlO8R/mHhIXqOHrgckzb3WmGOFIhwy3UcTw
   w==;
X-CSE-ConnectionGUID: 2my//sSzQ/mF0ad/hgIPCg==
X-CSE-MsgGUID: 6qhxLm+sTG6o0FSXJDiPpw==
X-IronPort-AV: E=McAfee;i="6700,10204,11184"; a="35404408"
X-IronPort-AV: E=Sophos;i="6.10,199,1719903600"; 
   d="scan'208";a="35404408"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2024 12:14:29 -0700
X-CSE-ConnectionGUID: oS05bFeQT766fMIexoXYvw==
X-CSE-MsgGUID: tDw2CiK5TbWhr9HnYR3D5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,199,1719903600"; 
   d="scan'208";a="95746745"
Received: from lkp-server01.sh.intel.com (HELO 9c6b1c7d3b50) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 03 Sep 2024 12:14:28 -0700
Received: from kbuild by 9c6b1c7d3b50 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1slYyu-00074L-25;
	Tue, 03 Sep 2024 19:14:24 +0000
Date: Wed, 4 Sep 2024 03:13:26 +0800
From: kernel test robot <lkp@intel.com>
To: Uros Bizjak <ubizjak@gmail.com>, loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Uros Bizjak <ubizjak@gmail.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] longsoon/percpu: Simplify _percpu_read() and
 _percpu_write()
Message-ID: <202409040319.2mRdIGd2-lkp@intel.com>
References: <20240903102342.36957-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240903102342.36957-1-ubizjak@gmail.com>

Hi Uros,

kernel test robot noticed the following build errors:

[auto build test ERROR on dennis-percpu/for-next]
[also build test ERROR on linus/master v6.11-rc6 next-20240903]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Uros-Bizjak/longsoon-percpu-Simplify-_percpu_read-and-_percpu_write/20240903-182524
base:   https://git.kernel.org/pub/scm/linux/kernel/git/dennis/percpu.git for-next
patch link:    https://lore.kernel.org/r/20240903102342.36957-1-ubizjak%40gmail.com
patch subject: [PATCH] longsoon/percpu: Simplify _percpu_read() and _percpu_write()
config: loongarch-allmodconfig (https://download.01.org/0day-ci/archive/20240904/202409040319.2mRdIGd2-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240904/202409040319.2mRdIGd2-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409040319.2mRdIGd2-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/linux/irqflags.h:19,
                    from include/linux/spinlock.h:59,
                    from include/linux/sched.h:2134,
                    from arch/loongarch/kernel/asm-offsets.c:8:
   include/linux/sched/mm.h: In function 'set_active_memcg':
>> arch/loongarch/include/asm/percpu.h:85:33: error: initialization of 'long unsigned int' from 'struct mem_cgroup *' makes integer from pointer without a cast [-Wint-conversion]
      85 | #define __pcpu_cast_8(val)      (val)
         |                                 ^
   arch/loongarch/include/asm/percpu.h:89:35: note: in expansion of macro '__pcpu_cast_8'
      89 |         unsigned long __pcp_val = __pcpu_cast_##size(_val);             \
         |                                   ^~~~~~~~~~~~
   arch/loongarch/include/asm/percpu.h:171:36: note: in expansion of macro '_percpu_write'
     171 | #define this_cpu_write_8(pcp, val) _percpu_write(8, pcp, val)
         |                                    ^~~~~~~~~~~~~
   include/linux/percpu-defs.h:368:25: note: in expansion of macro 'this_cpu_write_8'
     368 |                 case 8: stem##8(variable, __VA_ARGS__);break;           \
         |                         ^~~~
   include/linux/percpu-defs.h:490:41: note: in expansion of macro '__pcpu_size_call'
     490 | #define this_cpu_write(pcp, val)        __pcpu_size_call(this_cpu_write_, pcp, val)
         |                                         ^~~~~~~~~~~~~~~~
   include/linux/sched/mm.h:420:17: note: in expansion of macro 'this_cpu_write'
     420 |                 this_cpu_write(int_active_memcg, memcg);
         |                 ^~~~~~~~~~~~~~
   make[3]: *** [scripts/Makefile.build:116: arch/loongarch/kernel/asm-offsets.s] Error 1
   make[3]: Target 'prepare' not remade because of errors.
   make[2]: *** [Makefile:1199: prepare0] Error 2
   make[2]: Target 'prepare' not remade because of errors.
   make[1]: *** [Makefile:240: __sub-make] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:240: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.


vim +85 arch/loongarch/include/asm/percpu.h

    81	
    82	#define __pcpu_cast_1(val)	(((unsigned long) val) & 0xff)
    83	#define __pcpu_cast_2(val)	(((unsigned long) val) & 0xffff)
    84	#define __pcpu_cast_4(val)	(((unsigned long) val) & 0xffffffff)
  > 85	#define __pcpu_cast_8(val)	(val)
    86	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

