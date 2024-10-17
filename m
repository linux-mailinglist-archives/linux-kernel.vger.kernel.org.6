Return-Path: <linux-kernel+bounces-369200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 76B019A1A3B
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 07:48:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED2751F26D35
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 05:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DBCC178CF6;
	Thu, 17 Oct 2024 05:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VneZFFVR"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B664213633F
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 05:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729144087; cv=none; b=duVRBCceUrWP9CPmTcvHf62QwQl3BecFkPoTpLBY1jFf6MjnwOuEm8Dw5hsRqvBl8jQQoflPY3UUDe3RhqAqTBYzqqoY727NLEM1YaePA2dPGyI/PZdnVJwZPwY+sHO64OIJ3rSm0V2K7xLZZ0TEj3RmSvACJPc/sKB25LOEWs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729144087; c=relaxed/simple;
	bh=I7O2eNRZGkkiLwxy4ytjDtPMAWCrSov9b2lDhnRfiD4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=tvwyl5+Ur1Ra1F2jgC86L4qbDUe5F78V0X/Gr5fXVcrCBda5SikpJMiRXL8zwyafBLPb2GkuHyAdhhb3ca1dKZ252wqU+y7hNssTQWarGbmgVm0Xqzuqa3PAZSKleMibPDbcf2jClMoK5zDA25zOLLhzLerMHK17tDbP300yNNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VneZFFVR; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729144083; x=1760680083;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=I7O2eNRZGkkiLwxy4ytjDtPMAWCrSov9b2lDhnRfiD4=;
  b=VneZFFVRse4hy7I6GwfhqdKc4GHqKfqVB1p19/XhZeCWmGGXqoUu9+Mm
   FsAxemeOD5pi2riKvmdiQ5VJPNUkNTeC1SgDGIUtPUtTS6+zHJgN8MfMz
   kNa/QWq+eBy9JduqJwmg7Z1V7rSSZZoa07DqEtVcJHKqtrX9fje5HzVRO
   E0pWKxbgIVdTYxDvmXasJS9wplhFFYgk2iqX/zByEVztIW94vziPz79JP
   G/bvnBv+5OhyAmiAVhd3v/zPRCHrselsi6yxUwf+/NLAJX/i0oBS5RmNs
   KvXvWCBznHmjYSPZsJQlksYUBVwyoT2uWFkGRDHfYfs7LU9vSIPdO/Eko
   w==;
X-CSE-ConnectionGUID: MfYF1Rr8Ria2ZgsLBE8x9A==
X-CSE-MsgGUID: shG4mooYTZKYcmcxbcikeA==
X-IronPort-AV: E=McAfee;i="6700,10204,11227"; a="40011756"
X-IronPort-AV: E=Sophos;i="6.11,210,1725346800"; 
   d="scan'208";a="40011756"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2024 22:47:59 -0700
X-CSE-ConnectionGUID: JGpB/aceQyOjjOSy4n0F/Q==
X-CSE-MsgGUID: 52UCTdBDROib4nhGt9Yx4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,210,1725346800"; 
   d="scan'208";a="78473234"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 16 Oct 2024 22:47:58 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t1JMa-000LmH-0V;
	Thu, 17 Oct 2024 05:47:56 +0000
Date: Thu, 17 Oct 2024 13:46:58 +0800
From: kernel test robot <lkp@intel.com>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev,
	"Gustavo A. R. Silva" <gustavo@embeddedor.com>,
	LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars:testing/wfamnae-next20241015-2 5/18]
 include/linux/build_bug.h:78:41: error: static assertion failed: "struct
 member likely outside of struct_group_tagged()"
Message-ID: <202410171308.VlSadp8v-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git testing/wfamnae-next20241015-2
head:   41fe8a04339b3781dca5a8ba323ba77022acc441
commit: 0057fa5576ef7f95f1e88ff06bc3445a15ba5338 [5/18] RDMA/uverbs: Use static_assert() to check struct sizes
config: parisc-allmodconfig (https://download.01.org/0day-ci/archive/20241017/202410171308.VlSadp8v-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241017/202410171308.VlSadp8v-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410171308.VlSadp8v-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/linux/container_of.h:5,
                    from include/linux/list.h:5,
                    from include/linux/module.h:12,
                    from drivers/infiniband/core/nldev.c:33:
>> include/linux/build_bug.h:78:41: error: static assertion failed: "struct member likely outside of struct_group_tagged()"
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                         ^~~~~~~~~~~~~~
   include/linux/build_bug.h:77:34: note: in expansion of macro '__static_assert'
      77 | #define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
         |                                  ^~~~~~~~~~~~~~~
   include/rdma/uverbs_ioctl.h:643:1: note: in expansion of macro 'static_assert'
     643 | static_assert(offsetof(struct uverbs_attr_bundle, attrs) == sizeof(struct uverbs_attr_bundle_hdr),
         | ^~~~~~~~~~~~~

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for GET_FREE_REGION
   Depends on [n]: SPARSEMEM [=n]
   Selected by [m]:
   - RESOURCE_KUNIT_TEST [=m] && RUNTIME_TESTING_MENU [=y] && KUNIT [=m]


vim +78 include/linux/build_bug.h

bc6245e5efd70c Ian Abbott       2017-07-10  60  
6bab69c65013be Rasmus Villemoes 2019-03-07  61  /**
6bab69c65013be Rasmus Villemoes 2019-03-07  62   * static_assert - check integer constant expression at build time
6bab69c65013be Rasmus Villemoes 2019-03-07  63   *
6bab69c65013be Rasmus Villemoes 2019-03-07  64   * static_assert() is a wrapper for the C11 _Static_assert, with a
6bab69c65013be Rasmus Villemoes 2019-03-07  65   * little macro magic to make the message optional (defaulting to the
6bab69c65013be Rasmus Villemoes 2019-03-07  66   * stringification of the tested expression).
6bab69c65013be Rasmus Villemoes 2019-03-07  67   *
6bab69c65013be Rasmus Villemoes 2019-03-07  68   * Contrary to BUILD_BUG_ON(), static_assert() can be used at global
6bab69c65013be Rasmus Villemoes 2019-03-07  69   * scope, but requires the expression to be an integer constant
6bab69c65013be Rasmus Villemoes 2019-03-07  70   * expression (i.e., it is not enough that __builtin_constant_p() is
6bab69c65013be Rasmus Villemoes 2019-03-07  71   * true for expr).
6bab69c65013be Rasmus Villemoes 2019-03-07  72   *
6bab69c65013be Rasmus Villemoes 2019-03-07  73   * Also note that BUILD_BUG_ON() fails the build if the condition is
6bab69c65013be Rasmus Villemoes 2019-03-07  74   * true, while static_assert() fails the build if the expression is
6bab69c65013be Rasmus Villemoes 2019-03-07  75   * false.
6bab69c65013be Rasmus Villemoes 2019-03-07  76   */
6bab69c65013be Rasmus Villemoes 2019-03-07  77  #define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
6bab69c65013be Rasmus Villemoes 2019-03-07 @78  #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
6bab69c65013be Rasmus Villemoes 2019-03-07  79  
07a368b3f55a79 Maxim Levitsky   2022-10-25  80  

:::::: The code at line 78 was first introduced by commit
:::::: 6bab69c65013bed5fce9f101a64a84d0385b3946 build_bug.h: add wrapper for _Static_assert

:::::: TO: Rasmus Villemoes <linux@rasmusvillemoes.dk>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

