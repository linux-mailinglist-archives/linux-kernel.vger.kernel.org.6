Return-Path: <linux-kernel+bounces-242964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EB63928F9E
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 02:03:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A3671F22188
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 00:03:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1961F23BE;
	Sat,  6 Jul 2024 00:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WXZy1dka"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F287211C
	for <linux-kernel@vger.kernel.org>; Sat,  6 Jul 2024 00:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720224202; cv=none; b=csbV41KTZ/8JOBcIXGKh7AFd7cLTJUi8arGdPV6qjpGj6gYl64Fshargar1b92QBVOiCMjSb2yyFSXsOG+L1j9M7EwYAhUKFqJWWgog9SxpTbrhIk/+Tt9BIZCYFZ8sy32NkoSaQZnGMlCZn0d8wCbOF4wqlhxgwPZmcO54R67Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720224202; c=relaxed/simple;
	bh=oKsgv0iFkJHQLCuZK1OneNZikeXXii/caYdBYra4yGQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K+uSnSHkQpEUtP/KlTW4FkMA6tpLtPYh9qsF0dXbBobvrbHu+LMiicbEIvYl2ZHHF8KF72FGwki93ofCJW+NUKR9EPDF4Wixb7su4v8dTw2dRsxHlj249NpM4+vGKAX7k/ej9IqEBDC4NcTaFqOjKI7HlYS5G8ZDQ7sVkwUvaZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WXZy1dka; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720224200; x=1751760200;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=oKsgv0iFkJHQLCuZK1OneNZikeXXii/caYdBYra4yGQ=;
  b=WXZy1dkaedkvJIbTu0xycFJj9q1AroJzM7zyiogS6GEYCeFTAdr84ojn
   euBmNlyH0BT6MLJbgqQFBPv/9x4r13hXKm29OXAvv+HPz5PTRkh8i0t59
   bnXJ3Ww3QirfB8Ok15VJ1T3ZzHRlKGKU25ha3Mkl3T66kSRQoPsSFleKQ
   Rpa0/igeoUUjxHlXvg59uJDi1Yz6qvAUH1wsQ887P0NUogZln1h4cwFp/
   P0qqLmtr3bvMzVbzv7rwX/ZcxlB+tfYSN9+X5DV1BbHuuCQN3Ja/AgVEX
   X1EkYOfGibCkkWPHxC+XHk5GiFQ2tNOzn6SGmAI713v2RPbcGvY+eP9Y4
   g==;
X-CSE-ConnectionGUID: cvaYIxCDRaSGOR4VJ5wGSg==
X-CSE-MsgGUID: i1vMX5IsRo+Pi1aoDO6arQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11123"; a="42935409"
X-IronPort-AV: E=Sophos;i="6.09,186,1716274800"; 
   d="scan'208";a="42935409"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2024 17:03:19 -0700
X-CSE-ConnectionGUID: 0iN5pkOCS6mtVtnllN0ncg==
X-CSE-MsgGUID: teix2iDHSS+V2Sc3sZF8yQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,186,1716274800"; 
   d="scan'208";a="51818468"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 05 Jul 2024 17:03:17 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sPstW-000T6m-1i;
	Sat, 06 Jul 2024 00:03:14 +0000
Date: Sat, 6 Jul 2024 08:02:40 +0800
From: kernel test robot <lkp@intel.com>
To: Jisheng Zhang <jszhang@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>
Cc: oe-kbuild-all@lists.linux.dev, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] riscv: uaccess: use 'asm goto' for put_user()
Message-ID: <202407060732.wjARQ4O7-lkp@intel.com>
References: <20240625040500.1788-4-jszhang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240625040500.1788-4-jszhang@kernel.org>

Hi Jisheng,

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on v6.10-rc6 next-20240703]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jisheng-Zhang/riscv-implement-user_access_begin-and-families/20240626-005352
base:   linus/master
patch link:    https://lore.kernel.org/r/20240625040500.1788-4-jszhang%40kernel.org
patch subject: [PATCH 3/4] riscv: uaccess: use 'asm goto' for put_user()
config: riscv-randconfig-r071-20240705 (https://download.01.org/0day-ci/archive/20240706/202407060732.wjARQ4O7-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project a0c6b8aef853eedaa0980f07c0a502a5a8a9740e)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240706/202407060732.wjARQ4O7-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202407060732.wjARQ4O7-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from block/ioctl.c:4:
   In file included from include/linux/blkdev.h:9:
   In file included from include/linux/blk_types.h:10:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:8:
   In file included from include/linux/cacheflush.h:5:
   In file included from arch/riscv/include/asm/cacheflush.h:9:
   In file included from include/linux/mm.h:2253:
   include/linux/vmstat.h:514:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     514 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
>> block/ioctl.c:236:9: error: expected ')'
     236 |         return put_user(val, argp);
         |                ^
   arch/riscv/include/asm/uaccess.h:301:3: note: expanded from macro 'put_user'
     301 |                 __put_user((x), __p) :                          \
         |                 ^
   arch/riscv/include/asm/uaccess.h:274:2: note: expanded from macro '__put_user'
     274 |         __put_user_error(__val, __gu_ptr, __pu_err);            \
         |         ^
   arch/riscv/include/asm/uaccess.h:238:2: note: expanded from macro '__put_user_error'
     238 |         __put_user_nocheck(x, ptr, err_label);                  \
         |         ^
   arch/riscv/include/asm/uaccess.h:228:3: note: expanded from macro '__put_user_nocheck'
     228 |                 __put_user_8((x), __gu_ptr, label);             \
         |                 ^
   arch/riscv/include/asm/uaccess.h:211:25: note: expanded from macro '__put_user_8'
     211 |                         "m" (__ptr[__MSW]) : : label);          \
         |                                              ^
   block/ioctl.c:241:9: error: expected ')'
     241 |         return put_user(val, argp);
         |                ^
   arch/riscv/include/asm/uaccess.h:301:3: note: expanded from macro 'put_user'
     301 |                 __put_user((x), __p) :                          \
         |                 ^
   arch/riscv/include/asm/uaccess.h:274:2: note: expanded from macro '__put_user'
     274 |         __put_user_error(__val, __gu_ptr, __pu_err);            \
         |         ^
   arch/riscv/include/asm/uaccess.h:238:2: note: expanded from macro '__put_user_error'
     238 |         __put_user_nocheck(x, ptr, err_label);                  \
         |         ^
   arch/riscv/include/asm/uaccess.h:228:3: note: expanded from macro '__put_user_nocheck'
     228 |                 __put_user_8((x), __gu_ptr, label);             \
         |                 ^
   arch/riscv/include/asm/uaccess.h:211:25: note: expanded from macro '__put_user_8'
     211 |                         "m" (__ptr[__MSW]) : : label);          \
         |                                              ^
   block/ioctl.c:246:9: error: expected ')'
     246 |         return put_user(val, argp);
         |                ^
   arch/riscv/include/asm/uaccess.h:301:3: note: expanded from macro 'put_user'
     301 |                 __put_user((x), __p) :                          \
         |                 ^
   arch/riscv/include/asm/uaccess.h:274:2: note: expanded from macro '__put_user'
     274 |         __put_user_error(__val, __gu_ptr, __pu_err);            \
         |         ^
   arch/riscv/include/asm/uaccess.h:238:2: note: expanded from macro '__put_user_error'
     238 |         __put_user_nocheck(x, ptr, err_label);                  \
         |         ^
   arch/riscv/include/asm/uaccess.h:228:3: note: expanded from macro '__put_user_nocheck'
     228 |                 __put_user_8((x), __gu_ptr, label);             \
         |                 ^
   arch/riscv/include/asm/uaccess.h:211:25: note: expanded from macro '__put_user_8'
     211 |                         "m" (__ptr[__MSW]) : : label);          \
         |                                              ^
   block/ioctl.c:251:9: error: expected ')'
     251 |         return put_user(val, argp);
         |                ^
   arch/riscv/include/asm/uaccess.h:301:3: note: expanded from macro 'put_user'
     301 |                 __put_user((x), __p) :                          \
         |                 ^
   arch/riscv/include/asm/uaccess.h:274:2: note: expanded from macro '__put_user'
     274 |         __put_user_error(__val, __gu_ptr, __pu_err);            \
         |         ^
   arch/riscv/include/asm/uaccess.h:238:2: note: expanded from macro '__put_user_error'
     238 |         __put_user_nocheck(x, ptr, err_label);                  \
         |         ^
   arch/riscv/include/asm/uaccess.h:228:3: note: expanded from macro '__put_user_nocheck'
     228 |                 __put_user_8((x), __gu_ptr, label);             \
         |                 ^
   arch/riscv/include/asm/uaccess.h:211:25: note: expanded from macro '__put_user_8'
     211 |                         "m" (__ptr[__MSW]) : : label);          \
         |                                              ^
   block/ioctl.c:256:9: error: expected ')'
     256 |         return put_user(val, argp);
         |                ^
   arch/riscv/include/asm/uaccess.h:301:3: note: expanded from macro 'put_user'
     301 |                 __put_user((x), __p) :                          \
         |                 ^
   arch/riscv/include/asm/uaccess.h:274:2: note: expanded from macro '__put_user'
     274 |         __put_user_error(__val, __gu_ptr, __pu_err);            \
         |         ^
   arch/riscv/include/asm/uaccess.h:238:2: note: expanded from macro '__put_user_error'
     238 |         __put_user_nocheck(x, ptr, err_label);                  \
         |         ^
   arch/riscv/include/asm/uaccess.h:228:3: note: expanded from macro '__put_user_nocheck'
     228 |                 __put_user_8((x), __gu_ptr, label);             \
         |                 ^
   arch/riscv/include/asm/uaccess.h:211:25: note: expanded from macro '__put_user_8'
     211 |                         "m" (__ptr[__MSW]) : : label);          \
         |                                              ^
   block/ioctl.c:261:9: error: expected ')'
     261 |         return put_user(val, argp);
         |                ^
   arch/riscv/include/asm/uaccess.h:301:3: note: expanded from macro 'put_user'
     301 |                 __put_user((x), __p) :                          \
         |                 ^
   arch/riscv/include/asm/uaccess.h:274:2: note: expanded from macro '__put_user'
     274 |         __put_user_error(__val, __gu_ptr, __pu_err);            \
         |         ^
   arch/riscv/include/asm/uaccess.h:238:2: note: expanded from macro '__put_user_error'
     238 |         __put_user_nocheck(x, ptr, err_label);                  \
--
   In file included from block/bsg.c:8:
   In file included from include/linux/blkdev.h:9:
   In file included from include/linux/blk_types.h:10:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:8:
   In file included from include/linux/cacheflush.h:5:
   In file included from arch/riscv/include/asm/cacheflush.h:9:
   In file included from include/linux/mm.h:2253:
   include/linux/vmstat.h:514:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     514 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
>> block/bsg.c:89:9: error: expected ')'
      89 |         return put_user(READ_ONCE(bd->max_queue), uarg);
         |                ^
   arch/riscv/include/asm/uaccess.h:301:3: note: expanded from macro 'put_user'
     301 |                 __put_user((x), __p) :                          \
         |                 ^
   arch/riscv/include/asm/uaccess.h:274:2: note: expanded from macro '__put_user'
     274 |         __put_user_error(__val, __gu_ptr, __pu_err);            \
         |         ^
   arch/riscv/include/asm/uaccess.h:238:2: note: expanded from macro '__put_user_error'
     238 |         __put_user_nocheck(x, ptr, err_label);                  \
         |         ^
   arch/riscv/include/asm/uaccess.h:228:3: note: expanded from macro '__put_user_nocheck'
     228 |                 __put_user_8((x), __gu_ptr, label);             \
         |                 ^
   arch/riscv/include/asm/uaccess.h:211:25: note: expanded from macro '__put_user_8'
     211 |                         "m" (__ptr[__MSW]) : : label);          \
         |                                              ^
   block/bsg.c:125:10: error: expected ')'
     125 |                 return put_user(30527, intp);
         |                        ^
   arch/riscv/include/asm/uaccess.h:301:3: note: expanded from macro 'put_user'
     301 |                 __put_user((x), __p) :                          \
         |                 ^
   arch/riscv/include/asm/uaccess.h:274:2: note: expanded from macro '__put_user'
     274 |         __put_user_error(__val, __gu_ptr, __pu_err);            \
         |         ^
   arch/riscv/include/asm/uaccess.h:238:2: note: expanded from macro '__put_user_error'
     238 |         __put_user_nocheck(x, ptr, err_label);                  \
         |         ^
   arch/riscv/include/asm/uaccess.h:228:3: note: expanded from macro '__put_user_nocheck'
     228 |                 __put_user_8((x), __gu_ptr, label);             \
         |                 ^
   arch/riscv/include/asm/uaccess.h:211:25: note: expanded from macro '__put_user_8'
     211 |                         "m" (__ptr[__MSW]) : : label);          \
         |                                              ^
   block/bsg.c:127:10: error: expected ')'
     127 |                 return put_user(0, intp);
         |                        ^
   arch/riscv/include/asm/uaccess.h:301:3: note: expanded from macro 'put_user'
     301 |                 __put_user((x), __p) :                          \
         |                 ^
   arch/riscv/include/asm/uaccess.h:274:2: note: expanded from macro '__put_user'
     274 |         __put_user_error(__val, __gu_ptr, __pu_err);            \
         |         ^
   arch/riscv/include/asm/uaccess.h:238:2: note: expanded from macro '__put_user_error'
     238 |         __put_user_nocheck(x, ptr, err_label);                  \
         |         ^
   arch/riscv/include/asm/uaccess.h:228:3: note: expanded from macro '__put_user_nocheck'
     228 |                 __put_user_8((x), __gu_ptr, label);             \
         |                 ^
   arch/riscv/include/asm/uaccess.h:211:25: note: expanded from macro '__put_user_8'
     211 |                         "m" (__ptr[__MSW]) : : label);          \
         |                                              ^
   block/bsg.c:129:10: error: expected ')'
     129 |                 return put_user(0, intp);
         |                        ^
   arch/riscv/include/asm/uaccess.h:301:3: note: expanded from macro 'put_user'
     301 |                 __put_user((x), __p) :                          \
         |                 ^
   arch/riscv/include/asm/uaccess.h:274:2: note: expanded from macro '__put_user'
     274 |         __put_user_error(__val, __gu_ptr, __pu_err);            \
         |         ^
   arch/riscv/include/asm/uaccess.h:238:2: note: expanded from macro '__put_user_error'
     238 |         __put_user_nocheck(x, ptr, err_label);                  \
         |         ^
   arch/riscv/include/asm/uaccess.h:228:3: note: expanded from macro '__put_user_nocheck'
     228 |                 __put_user_8((x), __gu_ptr, label);             \
         |                 ^
   arch/riscv/include/asm/uaccess.h:211:25: note: expanded from macro '__put_user_8'
     211 |                         "m" (__ptr[__MSW]) : : label);          \
         |                                              ^
   block/bsg.c:138:10: error: expected ')'
     138 |                 return put_user(min(bd->reserved_size, queue_max_bytes(q)),
         |                        ^
   arch/riscv/include/asm/uaccess.h:301:3: note: expanded from macro 'put_user'
     301 |                 __put_user((x), __p) :                          \
         |                 ^
   arch/riscv/include/asm/uaccess.h:274:2: note: expanded from macro '__put_user'
     274 |         __put_user_error(__val, __gu_ptr, __pu_err);            \
         |         ^
   arch/riscv/include/asm/uaccess.h:238:2: note: expanded from macro '__put_user_error'
     238 |         __put_user_nocheck(x, ptr, err_label);                  \
         |         ^
   arch/riscv/include/asm/uaccess.h:228:3: note: expanded from macro '__put_user_nocheck'
     228 |                 __put_user_8((x), __gu_ptr, label);             \
         |                 ^
   arch/riscv/include/asm/uaccess.h:211:25: note: expanded from macro '__put_user_8'
     211 |                         "m" (__ptr[__MSW]) : : label);          \
         |                                              ^
   block/bsg.c:149:10: error: expected ')'
     149 |                 return put_user(1, intp);
         |                        ^
   arch/riscv/include/asm/uaccess.h:301:3: note: expanded from macro 'put_user'
     301 |                 __put_user((x), __p) :                          \
         |                 ^
   arch/riscv/include/asm/uaccess.h:274:2: note: expanded from macro '__put_user'
     274 |         __put_user_error(__val, __gu_ptr, __pu_err);            \
         |         ^
   arch/riscv/include/asm/uaccess.h:238:2: note: expanded from macro '__put_user_error'
     238 |         __put_user_nocheck(x, ptr, err_label);                  \
--
   In file included from fs/read_write.c:14:
   In file included from include/linux/fsnotify.h:16:
   In file included from include/linux/audit.h:13:
   In file included from include/linux/ptrace.h:10:
   In file included from include/linux/pid_namespace.h:7:
   In file included from include/linux/mm.h:2253:
   include/linux/vmstat.h:514:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     514 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
>> fs/read_write.c:1340:16: error: expected ')'
    1340 |                 if (unlikely(put_user(pos, offset)))
         |                              ^
   arch/riscv/include/asm/uaccess.h:301:3: note: expanded from macro 'put_user'
     301 |                 __put_user((x), __p) :                          \
         |                 ^
   arch/riscv/include/asm/uaccess.h:274:2: note: expanded from macro '__put_user'
     274 |         __put_user_error(__val, __gu_ptr, __pu_err);            \
         |         ^
   arch/riscv/include/asm/uaccess.h:238:2: note: expanded from macro '__put_user_error'
     238 |         __put_user_nocheck(x, ptr, err_label);                  \
         |         ^
   arch/riscv/include/asm/uaccess.h:228:3: note: expanded from macro '__put_user_nocheck'
     228 |                 __put_user_8((x), __gu_ptr, label);             \
         |                 ^
   arch/riscv/include/asm/uaccess.h:211:25: note: expanded from macro '__put_user_8'
     211 |                         "m" (__ptr[__MSW]) : : label);          \
         |                                              ^
   fs/read_write.c:1357:16: error: expected ')'
    1357 |                 if (unlikely(put_user(pos, offset)))
         |                              ^
   arch/riscv/include/asm/uaccess.h:301:3: note: expanded from macro 'put_user'
     301 |                 __put_user((x), __p) :                          \
         |                 ^
   arch/riscv/include/asm/uaccess.h:274:2: note: expanded from macro '__put_user'
     274 |         __put_user_error(__val, __gu_ptr, __pu_err);            \
         |         ^
   arch/riscv/include/asm/uaccess.h:238:2: note: expanded from macro '__put_user_error'
     238 |         __put_user_nocheck(x, ptr, err_label);                  \
         |         ^
   arch/riscv/include/asm/uaccess.h:228:3: note: expanded from macro '__put_user_nocheck'
     228 |                 __put_user_8((x), __gu_ptr, label);             \
         |                 ^
   arch/riscv/include/asm/uaccess.h:211:25: note: expanded from macro '__put_user_8'
     211 |                         "m" (__ptr[__MSW]) : : label);          \
         |                                              ^
   1 warning and 2 errors generated.
--
   In file included from fs/file_table.c:17:
   In file included from include/linux/security.h:33:
   In file included from include/linux/mm.h:2253:
   include/linux/vmstat.h:514:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     514 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   In file included from fs/file_table.c:19:
>> include/linux/eventpoll.h:81:6: error: expected ')'
      81 |         if (__put_user(revents, &uevent->events) ||
         |             ^
   arch/riscv/include/asm/uaccess.h:274:2: note: expanded from macro '__put_user'
     274 |         __put_user_error(__val, __gu_ptr, __pu_err);            \
         |         ^
   arch/riscv/include/asm/uaccess.h:238:2: note: expanded from macro '__put_user_error'
     238 |         __put_user_nocheck(x, ptr, err_label);                  \
         |         ^
   arch/riscv/include/asm/uaccess.h:228:3: note: expanded from macro '__put_user_nocheck'
     228 |                 __put_user_8((x), __gu_ptr, label);             \
         |                 ^
   arch/riscv/include/asm/uaccess.h:211:25: note: expanded from macro '__put_user_8'
     211 |                         "m" (__ptr[__MSW]) : : label);          \
         |                                              ^
   In file included from fs/file_table.c:19:
   include/linux/eventpoll.h:82:6: error: expected ')'
      82 |             __put_user(data, &uevent->data))
         |             ^
   arch/riscv/include/asm/uaccess.h:274:2: note: expanded from macro '__put_user'
     274 |         __put_user_error(__val, __gu_ptr, __pu_err);            \
         |         ^
   arch/riscv/include/asm/uaccess.h:238:2: note: expanded from macro '__put_user_error'
     238 |         __put_user_nocheck(x, ptr, err_label);                  \
         |         ^
   arch/riscv/include/asm/uaccess.h:228:3: note: expanded from macro '__put_user_nocheck'
     228 |                 __put_user_8((x), __gu_ptr, label);             \
         |                 ^
   arch/riscv/include/asm/uaccess.h:211:25: note: expanded from macro '__put_user_8'
     211 |                         "m" (__ptr[__MSW]) : : label);          \
         |                                              ^
   1 warning and 2 errors generated.
..


vim +236 block/ioctl.c

66ba32dc167202c block/ioctl.c         Martin K. Petersen 2012-09-18  233  
9b81648cb5e3ae7 block/ioctl.c         Arnd Bergmann      2019-11-29  234  static int put_ushort(unsigned short __user *argp, unsigned short val)
^1da177e4c3f415 drivers/block/ioctl.c Linus Torvalds     2005-04-16  235  {
9b81648cb5e3ae7 block/ioctl.c         Arnd Bergmann      2019-11-29 @236  	return put_user(val, argp);
^1da177e4c3f415 drivers/block/ioctl.c Linus Torvalds     2005-04-16  237  }
^1da177e4c3f415 drivers/block/ioctl.c Linus Torvalds     2005-04-16  238  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

