Return-Path: <linux-kernel+bounces-394061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 167A89BAA20
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 02:23:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92C381F21409
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 01:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BFB41531DC;
	Mon,  4 Nov 2024 01:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OGtq9jd0"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E49064A8F
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 01:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730683389; cv=none; b=CnoXg0d3FccqFUOSCn85w/alB9sN3DObfikIpiEVQDAe8+yVPVEpNLKPuubSTud+xlC2ybu6t4XbzrcV+grbC7rhLsIM136KeTusPMF8NbhO6qqjfGlthwTynZUa3fIhV5JsJq+/r9BM1Jp+EHtApv5CsfAoTK2OUwlJRXPzSRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730683389; c=relaxed/simple;
	bh=W7FwEokIFBmLtq8Qi7waT3SiuLX+f7CPSje25bpDp5I=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=r84Ny668otBFsc6g6rqOBjDOkXK2DuujR7pFD5hhlWALAhp+ro0DhZUP3K6dZlqNx8ElgGhqlyccpQsfPuX+BJ3W2YDvW+Q4SggCNT2QmyudLQu2rh9AXQ+ROnuWpa+zkMzvol084SWVkufjN5O+SvUSxUyeJkwIW2QH/46auOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OGtq9jd0; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730683386; x=1762219386;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=W7FwEokIFBmLtq8Qi7waT3SiuLX+f7CPSje25bpDp5I=;
  b=OGtq9jd04bseZ5GtRYW11LOxDPMmlBaDrX+yRKSx5Lmtp7wCd06iFLYH
   gLjD+0/UOPxMxrlRyOTqN7lOXvFKbVpsOx3j8zi2tYapwyU0qx5uiXj71
   R0z/o/UxM/WN/D/iFx5cCEYKrNC7XFD3NGBsvLcFmQKLiK5uBl+cj/+Xk
   vF3jYx6ogGJ9HZZsAJEdu7ypgsPqwMNnUZETeY994wn/GYki3X94UufUQ
   KpbrKYyLYYEuf7Wof/93+0d3NLZwAXsGfdbK3JNdHEsEIWVvJ1Y+/5yUW
   d8+0pgKCEYC6ADo2hivodtlNL1VQih2FfhGaajYtF6LqE40buFTO65SDC
   g==;
X-CSE-ConnectionGUID: aX7ifRcURAOw6NI0GvpIew==
X-CSE-MsgGUID: k5Ybqjg4TUKM+hoibtdK/g==
X-IronPort-AV: E=McAfee;i="6700,10204,11245"; a="33205262"
X-IronPort-AV: E=Sophos;i="6.11,256,1725346800"; 
   d="scan'208";a="33205262"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2024 17:23:05 -0800
X-CSE-ConnectionGUID: HoAvTXAKTImcO9/MIBcKUg==
X-CSE-MsgGUID: /ipwQyw2Qc6p2F9KU1ba3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,256,1725346800"; 
   d="scan'208";a="120971870"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 03 Nov 2024 17:23:04 -0800
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t7lo5-000kLk-2E;
	Mon, 04 Nov 2024 01:23:01 +0000
Date: Mon, 4 Nov 2024 09:22:04 +0800
From: kernel test robot <lkp@intel.com>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev,
	"Gustavo A. R. Silva" <gustavo@embeddedor.com>,
	LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars:testing/wfamnae-next20241028-sa-with-flex 25/26]
 include/linux/compiler.h:189:45: error: '__UNIQUE_ID_y_1140' undeclared; did
 you mean '__UNIQUE_ID_x_1139'?
Message-ID: <202411040919.Jqv24HmW-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git testing/wfamnae-next20241028-sa-with-flex
head:   0e7c24c783de39e1f965e8c23e96a7de29dfbfca
commit: c8ed0e38de664a505d69f49e390abad734e8fd8a [25/26] Revert "net: dev: Convert sa_data to flexible array in struct sockaddr"
config: x86_64-rhel-8.3-func (https://download.01.org/0day-ci/archive/20241104/202411040919.Jqv24HmW-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241104/202411040919.Jqv24HmW-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411040919.Jqv24HmW-lkp@intel.com/

Note: the gustavoars/testing/wfamnae-next20241028-sa-with-flex HEAD 0e7c24c783de39e1f965e8c23e96a7de29dfbfca builds fine.
      It only hurts bisectability.

All errors (new ones prefixed by >>):

   In file included from include/linux/string.h:390,
                    from include/linux/bitmap.h:13,
                    from include/linux/cpumask.h:12,
                    from arch/x86/include/asm/cpumask.h:5,
                    from arch/x86/include/asm/msr.h:11,
                    from arch/x86/include/asm/tsc.h:10,
                    from arch/x86/include/asm/timex.h:6,
                    from include/linux/timex.h:67,
                    from include/linux/time32.h:13,
                    from include/linux/time.h:60,
                    from include/linux/stat.h:19,
                    from include/linux/module.h:13,
                    from net/ipv4/arp.c:74:
   net/ipv4/arp.c: In function 'arp_req_get':
   net/ipv4/arp.c:1188:52: error: 'struct sockaddr' has no member named 'sa_data_min'; did you mean 'sa_data'?
    1188 |                min(dev->addr_len, sizeof(r->arp_ha.sa_data_min)));
         |                                                    ^~~~~~~~~~~
   include/linux/fortify-string.h:621:48: note: in definition of macro '__fortify_memcpy_chk'
     621 |         const size_t __fortify_size = (size_t)(size);                   \
         |                                                ^~~~
   net/ipv4/arp.c:1187:9: note: in expansion of macro 'memcpy'
    1187 |         memcpy(r->arp_ha.sa_data, neigh->ha,
         |         ^~~~~~
   include/linux/minmax.h:105:9: note: in expansion of macro '__careful_cmp_once'
     105 |         __careful_cmp_once(op, x, y, __UNIQUE_ID(x_), __UNIQUE_ID(y_))
         |         ^~~~~~~~~~~~~~~~~~
   include/linux/minmax.h:129:25: note: in expansion of macro '__careful_cmp'
     129 | #define min(x, y)       __careful_cmp(min, x, y)
         |                         ^~~~~~~~~~~~~
   net/ipv4/arp.c:1188:16: note: in expansion of macro 'min'
    1188 |                min(dev->addr_len, sizeof(r->arp_ha.sa_data_min)));
         |                ^~~
>> include/linux/compiler.h:189:45: error: '__UNIQUE_ID_y_1140' undeclared (first use in this function); did you mean '__UNIQUE_ID_x_1139'?
     189 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
         |                                             ^~~~~~~~~~~~
   include/linux/fortify-string.h:621:48: note: in definition of macro '__fortify_memcpy_chk'
     621 |         const size_t __fortify_size = (size_t)(size);                   \
         |                                                ^~~~
   net/ipv4/arp.c:1187:9: note: in expansion of macro 'memcpy'
    1187 |         memcpy(r->arp_ha.sa_data, neigh->ha,
         |         ^~~~~~
   include/linux/compiler_types.h:505:9: note: in expansion of macro '__compiletime_assert'
     505 |         __compiletime_assert(condition, msg, prefix, suffix)
         |         ^~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:517:9: note: in expansion of macro '_compiletime_assert'
     517 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/minmax.h:100:9: note: in expansion of macro 'BUILD_BUG_ON_MSG'
     100 |         BUILD_BUG_ON_MSG(!__types_ok(x,y,ux,uy),        \
         |         ^~~~~~~~~~~~~~~~
   include/linux/minmax.h:56:27: note: in expansion of macro 'is_signed_type'
      56 | #define __sign_use(x,ux) (is_signed_type(typeof(ux))? \
         |                           ^~~~~~~~~~~~~~
   include/linux/minmax.h:82:29: note: in expansion of macro '__sign_use'
      82 |         (__sign_use(x,ux) & __sign_use(y,uy))
         |                             ^~~~~~~~~~
   include/linux/minmax.h:100:27: note: in expansion of macro '__types_ok'
     100 |         BUILD_BUG_ON_MSG(!__types_ok(x,y,ux,uy),        \
         |                           ^~~~~~~~~~
   include/linux/minmax.h:105:9: note: in expansion of macro '__careful_cmp_once'
     105 |         __careful_cmp_once(op, x, y, __UNIQUE_ID(x_), __UNIQUE_ID(y_))
         |         ^~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:84:22: note: in expansion of macro '___PASTE'
      84 | #define __PASTE(a,b) ___PASTE(a,b)
         |                      ^~~~~~~~
   include/linux/compiler.h:189:29: note: in expansion of macro '__PASTE'
     189 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
         |                             ^~~~~~~
   include/linux/compiler_types.h:84:22: note: in expansion of macro '___PASTE'
      84 | #define __PASTE(a,b) ___PASTE(a,b)
         |                      ^~~~~~~~
   include/linux/compiler.h:189:37: note: in expansion of macro '__PASTE'
     189 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
         |                                     ^~~~~~~
   include/linux/minmax.h:105:55: note: in expansion of macro '__UNIQUE_ID'
     105 |         __careful_cmp_once(op, x, y, __UNIQUE_ID(x_), __UNIQUE_ID(y_))
         |                                                       ^~~~~~~~~~~
   include/linux/minmax.h:129:25: note: in expansion of macro '__careful_cmp'
     129 | #define min(x, y)       __careful_cmp(min, x, y)
         |                         ^~~~~~~~~~~~~
   net/ipv4/arp.c:1188:16: note: in expansion of macro 'min'
    1188 |                min(dev->addr_len, sizeof(r->arp_ha.sa_data_min)));
         |                ^~~
   include/linux/compiler.h:189:45: note: each undeclared identifier is reported only once for each function it appears in
     189 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
         |                                             ^~~~~~~~~~~~
   include/linux/fortify-string.h:621:48: note: in definition of macro '__fortify_memcpy_chk'
     621 |         const size_t __fortify_size = (size_t)(size);                   \
         |                                                ^~~~
   net/ipv4/arp.c:1187:9: note: in expansion of macro 'memcpy'
    1187 |         memcpy(r->arp_ha.sa_data, neigh->ha,
         |         ^~~~~~
   include/linux/compiler_types.h:505:9: note: in expansion of macro '__compiletime_assert'
     505 |         __compiletime_assert(condition, msg, prefix, suffix)
         |         ^~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:517:9: note: in expansion of macro '_compiletime_assert'
     517 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/minmax.h:100:9: note: in expansion of macro 'BUILD_BUG_ON_MSG'
     100 |         BUILD_BUG_ON_MSG(!__types_ok(x,y,ux,uy),        \
         |         ^~~~~~~~~~~~~~~~
   include/linux/minmax.h:56:27: note: in expansion of macro 'is_signed_type'
      56 | #define __sign_use(x,ux) (is_signed_type(typeof(ux))? \
         |                           ^~~~~~~~~~~~~~
   include/linux/minmax.h:82:29: note: in expansion of macro '__sign_use'
      82 |         (__sign_use(x,ux) & __sign_use(y,uy))
         |                             ^~~~~~~~~~
   include/linux/minmax.h:100:27: note: in expansion of macro '__types_ok'
     100 |         BUILD_BUG_ON_MSG(!__types_ok(x,y,ux,uy),        \
         |                           ^~~~~~~~~~
   include/linux/minmax.h:105:9: note: in expansion of macro '__careful_cmp_once'
     105 |         __careful_cmp_once(op, x, y, __UNIQUE_ID(x_), __UNIQUE_ID(y_))
         |         ^~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:84:22: note: in expansion of macro '___PASTE'
      84 | #define __PASTE(a,b) ___PASTE(a,b)
         |                      ^~~~~~~~
   include/linux/compiler.h:189:29: note: in expansion of macro '__PASTE'
     189 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
         |                             ^~~~~~~
   include/linux/compiler_types.h:84:22: note: in expansion of macro '___PASTE'
      84 | #define __PASTE(a,b) ___PASTE(a,b)
         |                      ^~~~~~~~
   include/linux/compiler.h:189:37: note: in expansion of macro '__PASTE'
     189 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
         |                                     ^~~~~~~
   include/linux/minmax.h:105:55: note: in expansion of macro '__UNIQUE_ID'
     105 |         __careful_cmp_once(op, x, y, __UNIQUE_ID(x_), __UNIQUE_ID(y_))


vim +189 include/linux/compiler.h

fe8c8a126806fe Cesar Eduardo Barros 2013-11-25  188  
a8306f2d4dcea0 Nick Desaulniers     2023-08-31 @189  #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
6f33d58794ef4c Rusty Russell        2012-11-22  190  

:::::: The code at line 189 was first introduced by commit
:::::: a8306f2d4dcea03538c70c26d2948483f70254ff compiler.h: unify __UNIQUE_ID

:::::: TO: Nick Desaulniers <ndesaulniers@google.com>
:::::: CC: Andrew Morton <akpm@linux-foundation.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

