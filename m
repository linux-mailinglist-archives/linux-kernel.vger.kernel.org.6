Return-Path: <linux-kernel+bounces-446640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A26D9F276B
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 00:29:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D2001885247
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 23:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FCFB1C3F00;
	Sun, 15 Dec 2024 23:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fAryS06c"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 030F31BE854
	for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2024 23:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734305383; cv=none; b=qsSIJp2wlqO/zxfD9cDs5VVI45YzaMbMUVzoqpf164gU4Hi6eoxtPxLJmNEALBt5LiQTkMsSCnu2VmtitQyw9xXSj46QNmxmOET4WGQPfvg+sNPISoWCSJtzR9dpHrCwnyA1i52UE9dWCmsscHiH6Eqn1WxT4iTW6nY4F50cQis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734305383; c=relaxed/simple;
	bh=BeXOtucXB0xQEHBYLPVciozRUo6qviAv4IvlJIbZLb0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mHB6WvEqDzDmhVsq2r1ILwOqQbwI7rIIpKDwiskfbyROzCsue3hGK4JN2m2CQsaB7xAZd+0sJlVLgfKBx/JMUiUyQej108R+jwLejqBL5kBW0rmYmpWOCQ/0QuC1MSZWFuQG/K97w5DBtR00hl0lxGbQQVm2JctGX7QD4bcwbPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fAryS06c; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734305381; x=1765841381;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BeXOtucXB0xQEHBYLPVciozRUo6qviAv4IvlJIbZLb0=;
  b=fAryS06cp4kz8JnSV9PtvXepfCJWxRJLbe2jNeoORvCrKf1l1ju94U2Q
   vrsN1PgR3OVjYk2nrDezIe5vjhgr87RldG/zKoMHnXhEvlQ63+gnY1VO0
   CoP+E3nPksQTu3GfP4M4Al7QLPLnxF5vn18LRuloky20ICBELqNZt8FmF
   Ua9ns1pjbPLyfyZO6VoCTP8VHosVqNfX0SyE3uHgEDVoJEGLrn2dogzgH
   aZEURRHCJd7XJLRmMDAWDmWAIGkNN4CJznhP2lJO3KgGqBgeqJh4XlrKo
   hKXWp2gGTUm1V4IJP/pifaF6fO4CEts9DAWFD8VmEKGGrHh+pxsGCf3wl
   A==;
X-CSE-ConnectionGUID: egJlR7cQSFyXzzQnTyv62Q==
X-CSE-MsgGUID: Q4TG+QUBTgmq8RguoFC5hw==
X-IronPort-AV: E=McAfee;i="6700,10204,11282"; a="45687012"
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="45687012"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2024 15:29:40 -0800
X-CSE-ConnectionGUID: Dq8NeIx2TJWEBZePK/qxPQ==
X-CSE-MsgGUID: QJNDDPs0SY2zopPzz7r2Ow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,237,1728975600"; 
   d="scan'208";a="96938814"
Received: from lkp-server01.sh.intel.com (HELO 82a3f569d0cb) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 15 Dec 2024 15:29:38 -0800
Received: from kbuild by 82a3f569d0cb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tMy3L-000DuA-1O;
	Sun, 15 Dec 2024 23:29:35 +0000
Date: Mon, 16 Dec 2024 07:28:52 +0800
From: kernel test robot <lkp@intel.com>
To: David Laight <David.Laight@aculab.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Memory Management List <linux-mm@kvack.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	'Vincent Mailhol' <mailhol.vincent@wanadoo.fr>
Subject: Re: [PATCH next] linux/bits.h: Simplify GENMASK()
Message-ID: <202412160756.7tFtCu4g-lkp@intel.com>
References: <8423d75207f64e4081f0019601b4a016@AcuMS.aculab.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8423d75207f64e4081f0019601b4a016@AcuMS.aculab.com>

Hi David,

kernel test robot noticed the following build errors:

[auto build test ERROR on akpm-mm/mm-everything]
[also build test ERROR on linus/master v6.13-rc2]
[cannot apply to next-20241213 next-20241213]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/David-Laight/linux-bits-h-Simplify-GENMASK/20241216-040445
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/8423d75207f64e4081f0019601b4a016%40AcuMS.aculab.com
patch subject: [PATCH next] linux/bits.h: Simplify GENMASK()
config: arm64-randconfig-004-20241216 (https://download.01.org/0day-ci/archive/20241216/202412160756.7tFtCu4g-lkp@intel.com/config)
compiler: clang version 15.0.7 (https://github.com/llvm/llvm-project 8dfdcc7b7bf66834a761bd8de445840ef68e4d1a)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241216/202412160756.7tFtCu4g-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412160756.7tFtCu4g-lkp@intel.com/

All errors (new ones prefixed by >>):

>> lib/test_bits.c:46:47: error: use of undeclared identifier '__uint128'
           KUNIT_EXPECT_EQ(test, 0x0000000000000001ull, GENMASK_U128(0, 0));
                                                        ^
   include/linux/bits.h:33:33: note: expanded from macro 'GENMASK_U128'
           (GENMASK_INPUT_CHECK(hi, lo) + __GENMASK_U128(hi, lo))
                                          ^
   include/uapi/linux/bits.h:15:44: note: expanded from macro '__GENMASK_U128'
   #define __GENMASK_U128(hi, lo) ___GENMASK((__uint128)1, hi, lo)
                                              ^
>> lib/test_bits.c:46:47: error: use of undeclared identifier '__uint128'
   include/linux/bits.h:33:33: note: expanded from macro 'GENMASK_U128'
           (GENMASK_INPUT_CHECK(hi, lo) + __GENMASK_U128(hi, lo))
                                          ^
   include/uapi/linux/bits.h:15:44: note: expanded from macro '__GENMASK_U128'
   #define __GENMASK_U128(hi, lo) ___GENMASK((__uint128)1, hi, lo)
                                              ^
>> lib/test_bits.c:46:47: error: use of undeclared identifier '__uint128'
   include/linux/bits.h:33:33: note: expanded from macro 'GENMASK_U128'
           (GENMASK_INPUT_CHECK(hi, lo) + __GENMASK_U128(hi, lo))
                                          ^
   include/uapi/linux/bits.h:15:44: note: expanded from macro '__GENMASK_U128'
   #define __GENMASK_U128(hi, lo) ___GENMASK((__uint128)1, hi, lo)
                                              ^
>> lib/test_bits.c:46:47: error: use of undeclared identifier '__uint128'
   include/linux/bits.h:33:33: note: expanded from macro 'GENMASK_U128'
           (GENMASK_INPUT_CHECK(hi, lo) + __GENMASK_U128(hi, lo))
                                          ^
   include/uapi/linux/bits.h:15:44: note: expanded from macro '__GENMASK_U128'
   #define __GENMASK_U128(hi, lo) ___GENMASK((__uint128)1, hi, lo)
                                              ^
   lib/test_bits.c:47:47: error: use of undeclared identifier '__uint128'
           KUNIT_EXPECT_EQ(test, 0x0000000000000003ull, GENMASK_U128(1, 0));
                                                        ^
   include/linux/bits.h:33:33: note: expanded from macro 'GENMASK_U128'
           (GENMASK_INPUT_CHECK(hi, lo) + __GENMASK_U128(hi, lo))
                                          ^
   include/uapi/linux/bits.h:15:44: note: expanded from macro '__GENMASK_U128'
   #define __GENMASK_U128(hi, lo) ___GENMASK((__uint128)1, hi, lo)
                                              ^
   lib/test_bits.c:47:47: error: use of undeclared identifier '__uint128'
   include/linux/bits.h:33:33: note: expanded from macro 'GENMASK_U128'
           (GENMASK_INPUT_CHECK(hi, lo) + __GENMASK_U128(hi, lo))
                                          ^
   include/uapi/linux/bits.h:15:44: note: expanded from macro '__GENMASK_U128'
   #define __GENMASK_U128(hi, lo) ___GENMASK((__uint128)1, hi, lo)
                                              ^
   lib/test_bits.c:47:47: error: use of undeclared identifier '__uint128'
   include/linux/bits.h:33:33: note: expanded from macro 'GENMASK_U128'
           (GENMASK_INPUT_CHECK(hi, lo) + __GENMASK_U128(hi, lo))
                                          ^
   include/uapi/linux/bits.h:15:44: note: expanded from macro '__GENMASK_U128'
   #define __GENMASK_U128(hi, lo) ___GENMASK((__uint128)1, hi, lo)
                                              ^
   lib/test_bits.c:47:47: error: use of undeclared identifier '__uint128'
   include/linux/bits.h:33:33: note: expanded from macro 'GENMASK_U128'
           (GENMASK_INPUT_CHECK(hi, lo) + __GENMASK_U128(hi, lo))
                                          ^
   include/uapi/linux/bits.h:15:44: note: expanded from macro '__GENMASK_U128'
   #define __GENMASK_U128(hi, lo) ___GENMASK((__uint128)1, hi, lo)
                                              ^
   lib/test_bits.c:48:47: error: use of undeclared identifier '__uint128'
           KUNIT_EXPECT_EQ(test, 0x0000000000000006ull, GENMASK_U128(2, 1));
                                                        ^
   include/linux/bits.h:33:33: note: expanded from macro 'GENMASK_U128'
           (GENMASK_INPUT_CHECK(hi, lo) + __GENMASK_U128(hi, lo))
                                          ^
   include/uapi/linux/bits.h:15:44: note: expanded from macro '__GENMASK_U128'
   #define __GENMASK_U128(hi, lo) ___GENMASK((__uint128)1, hi, lo)
                                              ^
   lib/test_bits.c:48:47: error: use of undeclared identifier '__uint128'
   include/linux/bits.h:33:33: note: expanded from macro 'GENMASK_U128'
           (GENMASK_INPUT_CHECK(hi, lo) + __GENMASK_U128(hi, lo))
                                          ^
   include/uapi/linux/bits.h:15:44: note: expanded from macro '__GENMASK_U128'
   #define __GENMASK_U128(hi, lo) ___GENMASK((__uint128)1, hi, lo)
                                              ^
   lib/test_bits.c:48:47: error: use of undeclared identifier '__uint128'
   include/linux/bits.h:33:33: note: expanded from macro 'GENMASK_U128'
           (GENMASK_INPUT_CHECK(hi, lo) + __GENMASK_U128(hi, lo))
                                          ^
   include/uapi/linux/bits.h:15:44: note: expanded from macro '__GENMASK_U128'
   #define __GENMASK_U128(hi, lo) ___GENMASK((__uint128)1, hi, lo)
                                              ^
   lib/test_bits.c:48:47: error: use of undeclared identifier '__uint128'
   include/linux/bits.h:33:33: note: expanded from macro 'GENMASK_U128'
           (GENMASK_INPUT_CHECK(hi, lo) + __GENMASK_U128(hi, lo))
                                          ^
   include/uapi/linux/bits.h:15:44: note: expanded from macro '__GENMASK_U128'
   #define __GENMASK_U128(hi, lo) ___GENMASK((__uint128)1, hi, lo)
                                              ^
   lib/test_bits.c:49:47: error: use of undeclared identifier '__uint128'
           KUNIT_EXPECT_EQ(test, 0x00000000ffffffffull, GENMASK_U128(31, 0));
                                                        ^
   include/linux/bits.h:33:33: note: expanded from macro 'GENMASK_U128'
           (GENMASK_INPUT_CHECK(hi, lo) + __GENMASK_U128(hi, lo))
                                          ^
   include/uapi/linux/bits.h:15:44: note: expanded from macro '__GENMASK_U128'
   #define __GENMASK_U128(hi, lo) ___GENMASK((__uint128)1, hi, lo)
                                              ^
   lib/test_bits.c:49:47: error: use of undeclared identifier '__uint128'
   include/linux/bits.h:33:33: note: expanded from macro 'GENMASK_U128'
           (GENMASK_INPUT_CHECK(hi, lo) + __GENMASK_U128(hi, lo))
                                          ^
   include/uapi/linux/bits.h:15:44: note: expanded from macro '__GENMASK_U128'
   #define __GENMASK_U128(hi, lo) ___GENMASK((__uint128)1, hi, lo)
                                              ^
   lib/test_bits.c:49:47: error: use of undeclared identifier '__uint128'
   include/linux/bits.h:33:33: note: expanded from macro 'GENMASK_U128'
           (GENMASK_INPUT_CHECK(hi, lo) + __GENMASK_U128(hi, lo))
                                          ^
   include/uapi/linux/bits.h:15:44: note: expanded from macro '__GENMASK_U128'
   #define __GENMASK_U128(hi, lo) ___GENMASK((__uint128)1, hi, lo)
                                              ^
   lib/test_bits.c:49:47: error: use of undeclared identifier '__uint128'
   include/linux/bits.h:33:33: note: expanded from macro 'GENMASK_U128'
           (GENMASK_INPUT_CHECK(hi, lo) + __GENMASK_U128(hi, lo))
                                          ^
   include/uapi/linux/bits.h:15:44: note: expanded from macro '__GENMASK_U128'
   #define __GENMASK_U128(hi, lo) ___GENMASK((__uint128)1, hi, lo)
                                              ^
   lib/test_bits.c:50:47: error: use of undeclared identifier '__uint128'
           KUNIT_EXPECT_EQ(test, 0x000000ffffe00000ull, GENMASK_U128(39, 21));
                                                        ^
   include/linux/bits.h:33:33: note: expanded from macro 'GENMASK_U128'


vim +/__uint128 +46 lib/test_bits.c

6d511020e13d5d6 Rikard Falkeborn  2020-08-11  41  
d7bcc37436c7d37 Anshuman Khandual 2024-08-22  42  static void genmask_u128_test(struct kunit *test)
d7bcc37436c7d37 Anshuman Khandual 2024-08-22  43  {
d7bcc37436c7d37 Anshuman Khandual 2024-08-22  44  #ifdef CONFIG_ARCH_SUPPORTS_INT128
d7bcc37436c7d37 Anshuman Khandual 2024-08-22  45  	/* Below 64 bit masks */
d7bcc37436c7d37 Anshuman Khandual 2024-08-22 @46  	KUNIT_EXPECT_EQ(test, 0x0000000000000001ull, GENMASK_U128(0, 0));
d7bcc37436c7d37 Anshuman Khandual 2024-08-22  47  	KUNIT_EXPECT_EQ(test, 0x0000000000000003ull, GENMASK_U128(1, 0));
d7bcc37436c7d37 Anshuman Khandual 2024-08-22  48  	KUNIT_EXPECT_EQ(test, 0x0000000000000006ull, GENMASK_U128(2, 1));
d7bcc37436c7d37 Anshuman Khandual 2024-08-22  49  	KUNIT_EXPECT_EQ(test, 0x00000000ffffffffull, GENMASK_U128(31, 0));
d7bcc37436c7d37 Anshuman Khandual 2024-08-22  50  	KUNIT_EXPECT_EQ(test, 0x000000ffffe00000ull, GENMASK_U128(39, 21));
d7bcc37436c7d37 Anshuman Khandual 2024-08-22  51  	KUNIT_EXPECT_EQ(test, 0xffffffffffffffffull, GENMASK_U128(63, 0));
d7bcc37436c7d37 Anshuman Khandual 2024-08-22  52  
d7bcc37436c7d37 Anshuman Khandual 2024-08-22  53  	/* Above 64 bit masks - only 64 bit portion can be validated once */
d7bcc37436c7d37 Anshuman Khandual 2024-08-22  54  	KUNIT_EXPECT_EQ(test, 0xffffffffffffffffull, GENMASK_U128(64, 0) >> 1);
d7bcc37436c7d37 Anshuman Khandual 2024-08-22  55  	KUNIT_EXPECT_EQ(test, 0x00000000ffffffffull, GENMASK_U128(81, 50) >> 50);
d7bcc37436c7d37 Anshuman Khandual 2024-08-22  56  	KUNIT_EXPECT_EQ(test, 0x0000000000ffffffull, GENMASK_U128(87, 64) >> 64);
d7bcc37436c7d37 Anshuman Khandual 2024-08-22  57  	KUNIT_EXPECT_EQ(test, 0x0000000000ff0000ull, GENMASK_U128(87, 80) >> 64);
d7bcc37436c7d37 Anshuman Khandual 2024-08-22  58  
d7bcc37436c7d37 Anshuman Khandual 2024-08-22  59  	KUNIT_EXPECT_EQ(test, 0xffffffffffffffffull, GENMASK_U128(127, 0) >> 64);
d7bcc37436c7d37 Anshuman Khandual 2024-08-22  60  	KUNIT_EXPECT_EQ(test, 0xffffffffffffffffull, (u64)GENMASK_U128(127, 0));
d7bcc37436c7d37 Anshuman Khandual 2024-08-22  61  	KUNIT_EXPECT_EQ(test, 0x0000000000000003ull, GENMASK_U128(127, 126) >> 126);
d7bcc37436c7d37 Anshuman Khandual 2024-08-22  62  	KUNIT_EXPECT_EQ(test, 0x0000000000000001ull, GENMASK_U128(127, 127) >> 127);
d7bcc37436c7d37 Anshuman Khandual 2024-08-22  63  #ifdef TEST_GENMASK_FAILURES
d7bcc37436c7d37 Anshuman Khandual 2024-08-22  64  	/* these should fail compilation */
d7bcc37436c7d37 Anshuman Khandual 2024-08-22  65  	GENMASK_U128(0, 1);
d7bcc37436c7d37 Anshuman Khandual 2024-08-22  66  	GENMASK_U128(0, 10);
d7bcc37436c7d37 Anshuman Khandual 2024-08-22  67  	GENMASK_U128(9, 10);
d7bcc37436c7d37 Anshuman Khandual 2024-08-22  68  #endif /* TEST_GENMASK_FAILURES */
d7bcc37436c7d37 Anshuman Khandual 2024-08-22  69  #endif /* CONFIG_ARCH_SUPPORTS_INT128 */
d7bcc37436c7d37 Anshuman Khandual 2024-08-22  70  }
d7bcc37436c7d37 Anshuman Khandual 2024-08-22  71  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

