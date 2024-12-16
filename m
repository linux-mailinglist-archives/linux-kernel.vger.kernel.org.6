Return-Path: <linux-kernel+bounces-446775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC6AE9F2917
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 05:04:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECC431666E7
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 04:04:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C516915359A;
	Mon, 16 Dec 2024 04:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AqvMoIoh"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 135E92E401
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 04:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734321868; cv=none; b=boDaFUzPDDEa2Ts4Ig2G5mLDzKmnoKQjjpypdmlpawg7EHav5t4Ah2ikMjM0Xt5xAZQIIBxhNuDnP8DIsJIniQAO50Ce0rFqxwmhZR7tqvdOd+1oO+JJSEHYCGSD1ajJdJO9W1aGsBILtJNa9Ziz1l8Zg0R//0LQ7H47EUbeOq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734321868; c=relaxed/simple;
	bh=AUk/DQTmCIpzURbFH8PpGJ5xSZa/W5kaO65osDTlhOQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=okn/ziJcObeSBSZumb1IZSmQBYglatWM+cFL1hbdpt+NErFcXJWaA2racl5C+HVSQFefn2szMjqZd/1ajqK7RC6kP7wKbd0rQKWhLuovYQ1ITYPCb72nvfA0Ckk8baLcjLSx3fznE+caB/9TLcg+/wmZy/6rkWFjetZdLWXwYpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AqvMoIoh; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734321864; x=1765857864;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=AUk/DQTmCIpzURbFH8PpGJ5xSZa/W5kaO65osDTlhOQ=;
  b=AqvMoIohi3RcKsZW8Q0GUp5taTkCXHPOTP/BrkZzN2UbCSU35sdLAffY
   yyc5FaGs8pqpvQ8gOoDQz9eX7YNJrJxCgwgc8Rf413zWLY1zbG6MRWrYb
   FroJUJYTnTDV6AKEoRtM+u2qtzbxr3J9qnpGncGtpYhfLzqN9hVjH4Obn
   /kr79xyFpXWLvK0E5AP0tGNHcWkGGXCbO32p5baSvXgBGTNWIy11975eQ
   1JdfVcAXZxq5hmpjjFGLV00x7AKHnmMA8ELQUR4OLk1oFV5FeqbUMSq0Z
   gQR8zJiXjLW04f0dSJ2BUevlierzf+50RV5MxCh07gBtGbrXnR1z4vHsh
   Q==;
X-CSE-ConnectionGUID: V7A8laaJRwq1zFZgt/U4kQ==
X-CSE-MsgGUID: /TrJDRzbSi6i/3s7awyiVA==
X-IronPort-AV: E=McAfee;i="6700,10204,11282"; a="45179670"
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="45179670"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2024 20:04:23 -0800
X-CSE-ConnectionGUID: g/d/Dm8vTCejdKyhqL8NDw==
X-CSE-MsgGUID: 4OmRXktUSwOZ+YnPSzln+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,237,1728975600"; 
   d="scan'208";a="97130290"
Received: from lkp-server01.sh.intel.com (HELO 82a3f569d0cb) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 15 Dec 2024 20:04:20 -0800
Received: from kbuild by 82a3f569d0cb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tN2LC-000E0L-0h;
	Mon, 16 Dec 2024 04:04:18 +0000
Date: Mon, 16 Dec 2024 12:03:45 +0800
From: kernel test robot <lkp@intel.com>
To: David Laight <David.Laight@aculab.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: oe-kbuild-all@lists.linux.dev,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Memory Management List <linux-mm@kvack.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	'Vincent Mailhol' <mailhol.vincent@wanadoo.fr>
Subject: Re: [PATCH next] linux/bits.h: Simplify GENMASK()
Message-ID: <202412161103.LytYDSSl-lkp@intel.com>
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
[also build test ERROR on linus/master v6.13-rc3]
[cannot apply to next-20241213 next-20241213]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/David-Laight/linux-bits-h-Simplify-GENMASK/20241216-040445
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/8423d75207f64e4081f0019601b4a016%40AcuMS.aculab.com
patch subject: [PATCH next] linux/bits.h: Simplify GENMASK()
config: loongarch-randconfig-001-20241216 (https://download.01.org/0day-ci/archive/20241216/202412161103.LytYDSSl-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241216/202412161103.LytYDSSl-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412161103.LytYDSSl-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from lib/test_bits.c:6:
   lib/test_bits.c: In function 'genmask_u128_test':
>> include/uapi/linux/bits.h:15:44: error: '__uint128' undeclared (first use in this function); did you mean '__int128'?
      15 | #define __GENMASK_U128(hi, lo) ___GENMASK((__uint128)1, hi, lo)
         |                                            ^~~~~~~~~
   include/kunit/test.h:774:22: note: in definition of macro 'KUNIT_BASE_BINARY_ASSERTION'
     774 |         const typeof(right) __right = (right);                                 \
         |                      ^~~~~
   include/kunit/test.h:969:9: note: in expansion of macro 'KUNIT_BINARY_INT_ASSERTION'
     969 |         KUNIT_BINARY_INT_ASSERTION(test,                                       \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
   include/kunit/test.h:966:9: note: in expansion of macro 'KUNIT_EXPECT_EQ_MSG'
     966 |         KUNIT_EXPECT_EQ_MSG(test, left, right, NULL)
         |         ^~~~~~~~~~~~~~~~~~~
   lib/test_bits.c:46:9: note: in expansion of macro 'KUNIT_EXPECT_EQ'
      46 |         KUNIT_EXPECT_EQ(test, 0x0000000000000001ull, GENMASK_U128(0, 0));
         |         ^~~~~~~~~~~~~~~
   include/uapi/linux/bits.h:15:32: note: in expansion of macro '___GENMASK'
      15 | #define __GENMASK_U128(hi, lo) ___GENMASK((__uint128)1, hi, lo)
         |                                ^~~~~~~~~~
   include/linux/bits.h:33:40: note: in expansion of macro '__GENMASK_U128'
      33 |         (GENMASK_INPUT_CHECK(hi, lo) + __GENMASK_U128(hi, lo))
         |                                        ^~~~~~~~~~~~~~
   lib/test_bits.c:46:54: note: in expansion of macro 'GENMASK_U128'
      46 |         KUNIT_EXPECT_EQ(test, 0x0000000000000001ull, GENMASK_U128(0, 0));
         |                                                      ^~~~~~~~~~~~
   include/uapi/linux/bits.h:15:44: note: each undeclared identifier is reported only once for each function it appears in
      15 | #define __GENMASK_U128(hi, lo) ___GENMASK((__uint128)1, hi, lo)
         |                                            ^~~~~~~~~
   include/kunit/test.h:774:22: note: in definition of macro 'KUNIT_BASE_BINARY_ASSERTION'
     774 |         const typeof(right) __right = (right);                                 \
         |                      ^~~~~
   include/kunit/test.h:969:9: note: in expansion of macro 'KUNIT_BINARY_INT_ASSERTION'
     969 |         KUNIT_BINARY_INT_ASSERTION(test,                                       \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
   include/kunit/test.h:966:9: note: in expansion of macro 'KUNIT_EXPECT_EQ_MSG'
     966 |         KUNIT_EXPECT_EQ_MSG(test, left, right, NULL)
         |         ^~~~~~~~~~~~~~~~~~~
   lib/test_bits.c:46:9: note: in expansion of macro 'KUNIT_EXPECT_EQ'
      46 |         KUNIT_EXPECT_EQ(test, 0x0000000000000001ull, GENMASK_U128(0, 0));
         |         ^~~~~~~~~~~~~~~
   include/uapi/linux/bits.h:15:32: note: in expansion of macro '___GENMASK'
      15 | #define __GENMASK_U128(hi, lo) ___GENMASK((__uint128)1, hi, lo)
         |                                ^~~~~~~~~~
   include/linux/bits.h:33:40: note: in expansion of macro '__GENMASK_U128'
      33 |         (GENMASK_INPUT_CHECK(hi, lo) + __GENMASK_U128(hi, lo))
         |                                        ^~~~~~~~~~~~~~
   lib/test_bits.c:46:54: note: in expansion of macro 'GENMASK_U128'
      46 |         KUNIT_EXPECT_EQ(test, 0x0000000000000001ull, GENMASK_U128(0, 0));
         |                                                      ^~~~~~~~~~~~
>> include/uapi/linux/bits.h:15:54: error: expected ')' before numeric constant
      15 | #define __GENMASK_U128(hi, lo) ___GENMASK((__uint128)1, hi, lo)
         |                                                      ^
   include/kunit/test.h:774:22: note: in definition of macro 'KUNIT_BASE_BINARY_ASSERTION'
     774 |         const typeof(right) __right = (right);                                 \
         |                      ^~~~~
   include/kunit/test.h:969:9: note: in expansion of macro 'KUNIT_BINARY_INT_ASSERTION'
     969 |         KUNIT_BINARY_INT_ASSERTION(test,                                       \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
   include/kunit/test.h:966:9: note: in expansion of macro 'KUNIT_EXPECT_EQ_MSG'
     966 |         KUNIT_EXPECT_EQ_MSG(test, left, right, NULL)
         |         ^~~~~~~~~~~~~~~~~~~
   lib/test_bits.c:46:9: note: in expansion of macro 'KUNIT_EXPECT_EQ'
      46 |         KUNIT_EXPECT_EQ(test, 0x0000000000000001ull, GENMASK_U128(0, 0));
         |         ^~~~~~~~~~~~~~~
   include/uapi/linux/bits.h:15:32: note: in expansion of macro '___GENMASK'
      15 | #define __GENMASK_U128(hi, lo) ___GENMASK((__uint128)1, hi, lo)
         |                                ^~~~~~~~~~
   include/linux/bits.h:33:40: note: in expansion of macro '__GENMASK_U128'
      33 |         (GENMASK_INPUT_CHECK(hi, lo) + __GENMASK_U128(hi, lo))
         |                                        ^~~~~~~~~~~~~~
   lib/test_bits.c:46:54: note: in expansion of macro 'GENMASK_U128'
      46 |         KUNIT_EXPECT_EQ(test, 0x0000000000000001ull, GENMASK_U128(0, 0));
         |                                                      ^~~~~~~~~~~~
   include/uapi/linux/bits.h:9:12: note: to match this '('
       9 |         ((((one) << (hi)) - 1) * 2 + 1 - (((one) << (lo)) - 1))
         |            ^
   include/kunit/test.h:774:22: note: in definition of macro 'KUNIT_BASE_BINARY_ASSERTION'
     774 |         const typeof(right) __right = (right);                                 \
         |                      ^~~~~
   include/kunit/test.h:969:9: note: in expansion of macro 'KUNIT_BINARY_INT_ASSERTION'
     969 |         KUNIT_BINARY_INT_ASSERTION(test,                                       \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
   include/kunit/test.h:966:9: note: in expansion of macro 'KUNIT_EXPECT_EQ_MSG'
     966 |         KUNIT_EXPECT_EQ_MSG(test, left, right, NULL)
         |         ^~~~~~~~~~~~~~~~~~~
   lib/test_bits.c:46:9: note: in expansion of macro 'KUNIT_EXPECT_EQ'
      46 |         KUNIT_EXPECT_EQ(test, 0x0000000000000001ull, GENMASK_U128(0, 0));
         |         ^~~~~~~~~~~~~~~
   include/uapi/linux/bits.h:15:32: note: in expansion of macro '___GENMASK'
      15 | #define __GENMASK_U128(hi, lo) ___GENMASK((__uint128)1, hi, lo)
         |                                ^~~~~~~~~~
   include/linux/bits.h:33:40: note: in expansion of macro '__GENMASK_U128'
      33 |         (GENMASK_INPUT_CHECK(hi, lo) + __GENMASK_U128(hi, lo))
         |                                        ^~~~~~~~~~~~~~
   lib/test_bits.c:46:54: note: in expansion of macro 'GENMASK_U128'
      46 |         KUNIT_EXPECT_EQ(test, 0x0000000000000001ull, GENMASK_U128(0, 0));
         |                                                      ^~~~~~~~~~~~
>> include/uapi/linux/bits.h:15:54: error: expected ')' before numeric constant
      15 | #define __GENMASK_U128(hi, lo) ___GENMASK((__uint128)1, hi, lo)
         |                                                      ^
   include/kunit/test.h:774:22: note: in definition of macro 'KUNIT_BASE_BINARY_ASSERTION'
     774 |         const typeof(right) __right = (right);                                 \
         |                      ^~~~~
   include/kunit/test.h:969:9: note: in expansion of macro 'KUNIT_BINARY_INT_ASSERTION'
     969 |         KUNIT_BINARY_INT_ASSERTION(test,                                       \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
   include/kunit/test.h:966:9: note: in expansion of macro 'KUNIT_EXPECT_EQ_MSG'
     966 |         KUNIT_EXPECT_EQ_MSG(test, left, right, NULL)
         |         ^~~~~~~~~~~~~~~~~~~
   lib/test_bits.c:46:9: note: in expansion of macro 'KUNIT_EXPECT_EQ'
      46 |         KUNIT_EXPECT_EQ(test, 0x0000000000000001ull, GENMASK_U128(0, 0));
         |         ^~~~~~~~~~~~~~~
   include/uapi/linux/bits.h:15:32: note: in expansion of macro '___GENMASK'
      15 | #define __GENMASK_U128(hi, lo) ___GENMASK((__uint128)1, hi, lo)
         |                                ^~~~~~~~~~
   include/linux/bits.h:33:40: note: in expansion of macro '__GENMASK_U128'
      33 |         (GENMASK_INPUT_CHECK(hi, lo) + __GENMASK_U128(hi, lo))
         |                                        ^~~~~~~~~~~~~~
   lib/test_bits.c:46:54: note: in expansion of macro 'GENMASK_U128'
      46 |         KUNIT_EXPECT_EQ(test, 0x0000000000000001ull, GENMASK_U128(0, 0));
         |                                                      ^~~~~~~~~~~~
   include/uapi/linux/bits.h:9:44: note: to match this '('
       9 |         ((((one) << (hi)) - 1) * 2 + 1 - (((one) << (lo)) - 1))
         |                                            ^
   include/kunit/test.h:774:22: note: in definition of macro 'KUNIT_BASE_BINARY_ASSERTION'
     774 |         const typeof(right) __right = (right);                                 \
         |                      ^~~~~
   include/kunit/test.h:969:9: note: in expansion of macro 'KUNIT_BINARY_INT_ASSERTION'
     969 |         KUNIT_BINARY_INT_ASSERTION(test,                                       \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
   include/kunit/test.h:966:9: note: in expansion of macro 'KUNIT_EXPECT_EQ_MSG'
     966 |         KUNIT_EXPECT_EQ_MSG(test, left, right, NULL)
         |         ^~~~~~~~~~~~~~~~~~~
   lib/test_bits.c:46:9: note: in expansion of macro 'KUNIT_EXPECT_EQ'
      46 |         KUNIT_EXPECT_EQ(test, 0x0000000000000001ull, GENMASK_U128(0, 0));
         |         ^~~~~~~~~~~~~~~
   include/uapi/linux/bits.h:15:32: note: in expansion of macro '___GENMASK'
      15 | #define __GENMASK_U128(hi, lo) ___GENMASK((__uint128)1, hi, lo)
         |                                ^~~~~~~~~~
   include/linux/bits.h:33:40: note: in expansion of macro '__GENMASK_U128'
      33 |         (GENMASK_INPUT_CHECK(hi, lo) + __GENMASK_U128(hi, lo))
         |                                        ^~~~~~~~~~~~~~
   lib/test_bits.c:46:54: note: in expansion of macro 'GENMASK_U128'
      46 |         KUNIT_EXPECT_EQ(test, 0x0000000000000001ull, GENMASK_U128(0, 0));
         |                                                      ^~~~~~~~~~~~
>> include/uapi/linux/bits.h:15:54: error: expected ')' before numeric constant
      15 | #define __GENMASK_U128(hi, lo) ___GENMASK((__uint128)1, hi, lo)
         |                                                      ^
   include/kunit/test.h:774:40: note: in definition of macro 'KUNIT_BASE_BINARY_ASSERTION'
     774 |         const typeof(right) __right = (right);                                 \
         |                                        ^~~~~
   include/kunit/test.h:969:9: note: in expansion of macro 'KUNIT_BINARY_INT_ASSERTION'
     969 |         KUNIT_BINARY_INT_ASSERTION(test,                                       \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
   include/kunit/test.h:966:9: note: in expansion of macro 'KUNIT_EXPECT_EQ_MSG'
     966 |         KUNIT_EXPECT_EQ_MSG(test, left, right, NULL)
         |         ^~~~~~~~~~~~~~~~~~~
   lib/test_bits.c:46:9: note: in expansion of macro 'KUNIT_EXPECT_EQ'
      46 |         KUNIT_EXPECT_EQ(test, 0x0000000000000001ull, GENMASK_U128(0, 0));
         |         ^~~~~~~~~~~~~~~
   include/uapi/linux/bits.h:15:32: note: in expansion of macro '___GENMASK'
      15 | #define __GENMASK_U128(hi, lo) ___GENMASK((__uint128)1, hi, lo)
         |                                ^~~~~~~~~~
   include/linux/bits.h:33:40: note: in expansion of macro '__GENMASK_U128'
      33 |         (GENMASK_INPUT_CHECK(hi, lo) + __GENMASK_U128(hi, lo))
         |                                        ^~~~~~~~~~~~~~
   lib/test_bits.c:46:54: note: in expansion of macro 'GENMASK_U128'
      46 |         KUNIT_EXPECT_EQ(test, 0x0000000000000001ull, GENMASK_U128(0, 0));
         |                                                      ^~~~~~~~~~~~
   include/uapi/linux/bits.h:9:12: note: to match this '('
       9 |         ((((one) << (hi)) - 1) * 2 + 1 - (((one) << (lo)) - 1))
         |            ^
   include/kunit/test.h:774:40: note: in definition of macro 'KUNIT_BASE_BINARY_ASSERTION'
     774 |         const typeof(right) __right = (right);                                 \
         |                                        ^~~~~
   include/kunit/test.h:969:9: note: in expansion of macro 'KUNIT_BINARY_INT_ASSERTION'
     969 |         KUNIT_BINARY_INT_ASSERTION(test,                                       \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
   include/kunit/test.h:966:9: note: in expansion of macro 'KUNIT_EXPECT_EQ_MSG'
     966 |         KUNIT_EXPECT_EQ_MSG(test, left, right, NULL)
         |         ^~~~~~~~~~~~~~~~~~~
   lib/test_bits.c:46:9: note: in expansion of macro 'KUNIT_EXPECT_EQ'
      46 |         KUNIT_EXPECT_EQ(test, 0x0000000000000001ull, GENMASK_U128(0, 0));
         |         ^~~~~~~~~~~~~~~
   include/uapi/linux/bits.h:15:32: note: in expansion of macro '___GENMASK'
      15 | #define __GENMASK_U128(hi, lo) ___GENMASK((__uint128)1, hi, lo)
         |                                ^~~~~~~~~~
   include/linux/bits.h:33:40: note: in expansion of macro '__GENMASK_U128'
      33 |         (GENMASK_INPUT_CHECK(hi, lo) + __GENMASK_U128(hi, lo))
         |                                        ^~~~~~~~~~~~~~
   lib/test_bits.c:46:54: note: in expansion of macro 'GENMASK_U128'
      46 |         KUNIT_EXPECT_EQ(test, 0x0000000000000001ull, GENMASK_U128(0, 0));
         |                                                      ^~~~~~~~~~~~
>> include/uapi/linux/bits.h:15:54: error: expected ')' before numeric constant
      15 | #define __GENMASK_U128(hi, lo) ___GENMASK((__uint128)1, hi, lo)
         |                                                      ^
   include/kunit/test.h:774:40: note: in definition of macro 'KUNIT_BASE_BINARY_ASSERTION'
     774 |         const typeof(right) __right = (right);                                 \
         |                                        ^~~~~
   include/kunit/test.h:969:9: note: in expansion of macro 'KUNIT_BINARY_INT_ASSERTION'
     969 |         KUNIT_BINARY_INT_ASSERTION(test,                                       \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
   include/kunit/test.h:966:9: note: in expansion of macro 'KUNIT_EXPECT_EQ_MSG'
     966 |         KUNIT_EXPECT_EQ_MSG(test, left, right, NULL)
         |         ^~~~~~~~~~~~~~~~~~~
   lib/test_bits.c:46:9: note: in expansion of macro 'KUNIT_EXPECT_EQ'
      46 |         KUNIT_EXPECT_EQ(test, 0x0000000000000001ull, GENMASK_U128(0, 0));
         |         ^~~~~~~~~~~~~~~
   include/uapi/linux/bits.h:15:32: note: in expansion of macro '___GENMASK'
      15 | #define __GENMASK_U128(hi, lo) ___GENMASK((__uint128)1, hi, lo)
         |                                ^~~~~~~~~~
   include/linux/bits.h:33:40: note: in expansion of macro '__GENMASK_U128'
      33 |         (GENMASK_INPUT_CHECK(hi, lo) + __GENMASK_U128(hi, lo))
         |                                        ^~~~~~~~~~~~~~
   lib/test_bits.c:46:54: note: in expansion of macro 'GENMASK_U128'
      46 |         KUNIT_EXPECT_EQ(test, 0x0000000000000001ull, GENMASK_U128(0, 0));
         |                                                      ^~~~~~~~~~~~
   include/uapi/linux/bits.h:9:44: note: to match this '('
       9 |         ((((one) << (hi)) - 1) * 2 + 1 - (((one) << (lo)) - 1))
         |                                            ^
   include/kunit/test.h:774:40: note: in definition of macro 'KUNIT_BASE_BINARY_ASSERTION'
     774 |         const typeof(right) __right = (right);                                 \
         |                                        ^~~~~
   include/kunit/test.h:969:9: note: in expansion of macro 'KUNIT_BINARY_INT_ASSERTION'
     969 |         KUNIT_BINARY_INT_ASSERTION(test,                                       \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
   include/kunit/test.h:966:9: note: in expansion of macro 'KUNIT_EXPECT_EQ_MSG'
     966 |         KUNIT_EXPECT_EQ_MSG(test, left, right, NULL)
         |         ^~~~~~~~~~~~~~~~~~~
   lib/test_bits.c:46:9: note: in expansion of macro 'KUNIT_EXPECT_EQ'
      46 |         KUNIT_EXPECT_EQ(test, 0x0000000000000001ull, GENMASK_U128(0, 0));
         |         ^~~~~~~~~~~~~~~
   include/uapi/linux/bits.h:15:32: note: in expansion of macro '___GENMASK'
      15 | #define __GENMASK_U128(hi, lo) ___GENMASK((__uint128)1, hi, lo)
         |                                ^~~~~~~~~~
   include/linux/bits.h:33:40: note: in expansion of macro '__GENMASK_U128'
      33 |         (GENMASK_INPUT_CHECK(hi, lo) + __GENMASK_U128(hi, lo))
         |                                        ^~~~~~~~~~~~~~
   lib/test_bits.c:46:54: note: in expansion of macro 'GENMASK_U128'
      46 |         KUNIT_EXPECT_EQ(test, 0x0000000000000001ull, GENMASK_U128(0, 0));
         |                                                      ^~~~~~~~~~~~
>> include/uapi/linux/bits.h:15:54: error: expected ')' before numeric constant
      15 | #define __GENMASK_U128(hi, lo) ___GENMASK((__uint128)1, hi, lo)
         |                                                      ^
   include/kunit/test.h:774:22: note: in definition of macro 'KUNIT_BASE_BINARY_ASSERTION'
     774 |         const typeof(right) __right = (right);                                 \
         |                      ^~~~~
   include/kunit/test.h:969:9: note: in expansion of macro 'KUNIT_BINARY_INT_ASSERTION'
     969 |         KUNIT_BINARY_INT_ASSERTION(test,                                       \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
   include/kunit/test.h:966:9: note: in expansion of macro 'KUNIT_EXPECT_EQ_MSG'
     966 |         KUNIT_EXPECT_EQ_MSG(test, left, right, NULL)
         |         ^~~~~~~~~~~~~~~~~~~
   lib/test_bits.c:47:9: note: in expansion of macro 'KUNIT_EXPECT_EQ'
      47 |         KUNIT_EXPECT_EQ(test, 0x0000000000000003ull, GENMASK_U128(1, 0));
         |         ^~~~~~~~~~~~~~~
   include/uapi/linux/bits.h:15:32: note: in expansion of macro '___GENMASK'
      15 | #define __GENMASK_U128(hi, lo) ___GENMASK((__uint128)1, hi, lo)
         |                                ^~~~~~~~~~
   include/linux/bits.h:33:40: note: in expansion of macro '__GENMASK_U128'
      33 |         (GENMASK_INPUT_CHECK(hi, lo) + __GENMASK_U128(hi, lo))
         |                                        ^~~~~~~~~~~~~~
   lib/test_bits.c:47:54: note: in expansion of macro 'GENMASK_U128'
      47 |         KUNIT_EXPECT_EQ(test, 0x0000000000000003ull, GENMASK_U128(1, 0));
         |                                                      ^~~~~~~~~~~~
   include/uapi/linux/bits.h:9:12: note: to match this '('
       9 |         ((((one) << (hi)) - 1) * 2 + 1 - (((one) << (lo)) - 1))
         |            ^
   include/kunit/test.h:774:22: note: in definition of macro 'KUNIT_BASE_BINARY_ASSERTION'
     774 |         const typeof(right) __right = (right);                                 \
         |                      ^~~~~
   include/kunit/test.h:969:9: note: in expansion of macro 'KUNIT_BINARY_INT_ASSERTION'
     969 |         KUNIT_BINARY_INT_ASSERTION(test,                                       \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
   include/kunit/test.h:966:9: note: in expansion of macro 'KUNIT_EXPECT_EQ_MSG'
     966 |         KUNIT_EXPECT_EQ_MSG(test, left, right, NULL)
         |         ^~~~~~~~~~~~~~~~~~~
   lib/test_bits.c:47:9: note: in expansion of macro 'KUNIT_EXPECT_EQ'
      47 |         KUNIT_EXPECT_EQ(test, 0x0000000000000003ull, GENMASK_U128(1, 0));
         |         ^~~~~~~~~~~~~~~
   include/uapi/linux/bits.h:15:32: note: in expansion of macro '___GENMASK'
      15 | #define __GENMASK_U128(hi, lo) ___GENMASK((__uint128)1, hi, lo)
         |                                ^~~~~~~~~~
   include/linux/bits.h:33:40: note: in expansion of macro '__GENMASK_U128'
      33 |         (GENMASK_INPUT_CHECK(hi, lo) + __GENMASK_U128(hi, lo))
         |                                        ^~~~~~~~~~~~~~
   lib/test_bits.c:47:54: note: in expansion of macro 'GENMASK_U128'
      47 |         KUNIT_EXPECT_EQ(test, 0x0000000000000003ull, GENMASK_U128(1, 0));
         |                                                      ^~~~~~~~~~~~
>> include/uapi/linux/bits.h:15:54: error: expected ')' before numeric constant
      15 | #define __GENMASK_U128(hi, lo) ___GENMASK((__uint128)1, hi, lo)
         |                                                      ^
   include/kunit/test.h:774:22: note: in definition of macro 'KUNIT_BASE_BINARY_ASSERTION'
     774 |         const typeof(right) __right = (right);                                 \
         |                      ^~~~~
   include/kunit/test.h:969:9: note: in expansion of macro 'KUNIT_BINARY_INT_ASSERTION'
     969 |         KUNIT_BINARY_INT_ASSERTION(test,                                       \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
   include/kunit/test.h:966:9: note: in expansion of macro 'KUNIT_EXPECT_EQ_MSG'
     966 |         KUNIT_EXPECT_EQ_MSG(test, left, right, NULL)
         |         ^~~~~~~~~~~~~~~~~~~
   lib/test_bits.c:47:9: note: in expansion of macro 'KUNIT_EXPECT_EQ'
      47 |         KUNIT_EXPECT_EQ(test, 0x0000000000000003ull, GENMASK_U128(1, 0));
         |         ^~~~~~~~~~~~~~~
   include/uapi/linux/bits.h:15:32: note: in expansion of macro '___GENMASK'
      15 | #define __GENMASK_U128(hi, lo) ___GENMASK((__uint128)1, hi, lo)
         |                                ^~~~~~~~~~
   include/linux/bits.h:33:40: note: in expansion of macro '__GENMASK_U128'
      33 |         (GENMASK_INPUT_CHECK(hi, lo) + __GENMASK_U128(hi, lo))
         |                                        ^~~~~~~~~~~~~~
   lib/test_bits.c:47:54: note: in expansion of macro 'GENMASK_U128'
      47 |         KUNIT_EXPECT_EQ(test, 0x0000000000000003ull, GENMASK_U128(1, 0));
         |                                                      ^~~~~~~~~~~~
   include/uapi/linux/bits.h:9:44: note: to match this '('
       9 |         ((((one) << (hi)) - 1) * 2 + 1 - (((one) << (lo)) - 1))
         |                                            ^
   include/kunit/test.h:774:22: note: in definition of macro 'KUNIT_BASE_BINARY_ASSERTION'
     774 |         const typeof(right) __right = (right);                                 \
         |                      ^~~~~
   include/kunit/test.h:969:9: note: in expansion of macro 'KUNIT_BINARY_INT_ASSERTION'
     969 |         KUNIT_BINARY_INT_ASSERTION(test,                                       \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
   include/kunit/test.h:966:9: note: in expansion of macro 'KUNIT_EXPECT_EQ_MSG'
     966 |         KUNIT_EXPECT_EQ_MSG(test, left, right, NULL)
         |         ^~~~~~~~~~~~~~~~~~~
   lib/test_bits.c:47:9: note: in expansion of macro 'KUNIT_EXPECT_EQ'
      47 |         KUNIT_EXPECT_EQ(test, 0x0000000000000003ull, GENMASK_U128(1, 0));
         |         ^~~~~~~~~~~~~~~
   include/uapi/linux/bits.h:15:32: note: in expansion of macro '___GENMASK'
      15 | #define __GENMASK_U128(hi, lo) ___GENMASK((__uint128)1, hi, lo)
         |                                ^~~~~~~~~~
   include/linux/bits.h:33:40: note: in expansion of macro '__GENMASK_U128'
      33 |         (GENMASK_INPUT_CHECK(hi, lo) + __GENMASK_U128(hi, lo))
         |                                        ^~~~~~~~~~~~~~
   lib/test_bits.c:47:54: note: in expansion of macro 'GENMASK_U128'
      47 |         KUNIT_EXPECT_EQ(test, 0x0000000000000003ull, GENMASK_U128(1, 0));
         |                                                      ^~~~~~~~~~~~
>> include/uapi/linux/bits.h:15:54: error: expected ')' before numeric constant
      15 | #define __GENMASK_U128(hi, lo) ___GENMASK((__uint128)1, hi, lo)
         |                                                      ^
   include/kunit/test.h:774:40: note: in definition of macro 'KUNIT_BASE_BINARY_ASSERTION'
     774 |         const typeof(right) __right = (right);                                 \
         |                                        ^~~~~
   include/kunit/test.h:969:9: note: in expansion of macro 'KUNIT_BINARY_INT_ASSERTION'
     969 |         KUNIT_BINARY_INT_ASSERTION(test,                                       \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
   include/kunit/test.h:966:9: note: in expansion of macro 'KUNIT_EXPECT_EQ_MSG'
     966 |         KUNIT_EXPECT_EQ_MSG(test, left, right, NULL)
         |         ^~~~~~~~~~~~~~~~~~~
   lib/test_bits.c:47:9: note: in expansion of macro 'KUNIT_EXPECT_EQ'
      47 |         KUNIT_EXPECT_EQ(test, 0x0000000000000003ull, GENMASK_U128(1, 0));
         |         ^~~~~~~~~~~~~~~
   include/uapi/linux/bits.h:15:32: note: in expansion of macro '___GENMASK'
      15 | #define __GENMASK_U128(hi, lo) ___GENMASK((__uint128)1, hi, lo)
         |                                ^~~~~~~~~~
   include/linux/bits.h:33:40: note: in expansion of macro '__GENMASK_U128'
      33 |         (GENMASK_INPUT_CHECK(hi, lo) + __GENMASK_U128(hi, lo))
         |                                        ^~~~~~~~~~~~~~
   lib/test_bits.c:47:54: note: in expansion of macro 'GENMASK_U128'
      47 |         KUNIT_EXPECT_EQ(test, 0x0000000000000003ull, GENMASK_U128(1, 0));
         |                                                      ^~~~~~~~~~~~
   include/uapi/linux/bits.h:9:12: note: to match this '('
       9 |         ((((one) << (hi)) - 1) * 2 + 1 - (((one) << (lo)) - 1))
         |            ^
   include/kunit/test.h:774:40: note: in definition of macro 'KUNIT_BASE_BINARY_ASSERTION'
     774 |         const typeof(right) __right = (right);                                 \
         |                                        ^~~~~
   include/kunit/test.h:969:9: note: in expansion of macro 'KUNIT_BINARY_INT_ASSERTION'
     969 |         KUNIT_BINARY_INT_ASSERTION(test,                                       \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
   include/kunit/test.h:966:9: note: in expansion of macro 'KUNIT_EXPECT_EQ_MSG'
     966 |         KUNIT_EXPECT_EQ_MSG(test, left, right, NULL)
         |         ^~~~~~~~~~~~~~~~~~~
   lib/test_bits.c:47:9: note: in expansion of macro 'KUNIT_EXPECT_EQ'
      47 |         KUNIT_EXPECT_EQ(test, 0x0000000000000003ull, GENMASK_U128(1, 0));
         |         ^~~~~~~~~~~~~~~
   include/uapi/linux/bits.h:15:32: note: in expansion of macro '___GENMASK'
      15 | #define __GENMASK_U128(hi, lo) ___GENMASK((__uint128)1, hi, lo)
         |                                ^~~~~~~~~~
   include/linux/bits.h:33:40: note: in expansion of macro '__GENMASK_U128'
      33 |         (GENMASK_INPUT_CHECK(hi, lo) + __GENMASK_U128(hi, lo))
         |                                        ^~~~~~~~~~~~~~
   lib/test_bits.c:47:54: note: in expansion of macro 'GENMASK_U128'
      47 |         KUNIT_EXPECT_EQ(test, 0x0000000000000003ull, GENMASK_U128(1, 0));
         |                                                      ^~~~~~~~~~~~
>> include/uapi/linux/bits.h:15:54: error: expected ')' before numeric constant
      15 | #define __GENMASK_U128(hi, lo) ___GENMASK((__uint128)1, hi, lo)
         |                                                      ^
   include/kunit/test.h:774:40: note: in definition of macro 'KUNIT_BASE_BINARY_ASSERTION'
     774 |         const typeof(right) __right = (right);                                 \
         |                                        ^~~~~
   include/kunit/test.h:969:9: note: in expansion of macro 'KUNIT_BINARY_INT_ASSERTION'
     969 |         KUNIT_BINARY_INT_ASSERTION(test,                                       \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
   include/kunit/test.h:966:9: note: in expansion of macro 'KUNIT_EXPECT_EQ_MSG'
     966 |         KUNIT_EXPECT_EQ_MSG(test, left, right, NULL)
         |         ^~~~~~~~~~~~~~~~~~~
   lib/test_bits.c:47:9: note: in expansion of macro 'KUNIT_EXPECT_EQ'
      47 |         KUNIT_EXPECT_EQ(test, 0x0000000000000003ull, GENMASK_U128(1, 0));
         |         ^~~~~~~~~~~~~~~
   include/uapi/linux/bits.h:15:32: note: in expansion of macro '___GENMASK'
      15 | #define __GENMASK_U128(hi, lo) ___GENMASK((__uint128)1, hi, lo)
         |                                ^~~~~~~~~~
   include/linux/bits.h:33:40: note: in expansion of macro '__GENMASK_U128'
      33 |         (GENMASK_INPUT_CHECK(hi, lo) + __GENMASK_U128(hi, lo))
         |                                        ^~~~~~~~~~~~~~
   lib/test_bits.c:47:54: note: in expansion of macro 'GENMASK_U128'
      47 |         KUNIT_EXPECT_EQ(test, 0x0000000000000003ull, GENMASK_U128(1, 0));
         |                                                      ^~~~~~~~~~~~
   include/uapi/linux/bits.h:9:44: note: to match this '('
       9 |         ((((one) << (hi)) - 1) * 2 + 1 - (((one) << (lo)) - 1))
         |                                            ^
   include/kunit/test.h:774:40: note: in definition of macro 'KUNIT_BASE_BINARY_ASSERTION'
     774 |         const typeof(right) __right = (right);                                 \
         |                                        ^~~~~
   include/kunit/test.h:969:9: note: in expansion of macro 'KUNIT_BINARY_INT_ASSERTION'
     969 |         KUNIT_BINARY_INT_ASSERTION(test,                                       \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
   include/kunit/test.h:966:9: note: in expansion of macro 'KUNIT_EXPECT_EQ_MSG'
     966 |         KUNIT_EXPECT_EQ_MSG(test, left, right, NULL)
         |         ^~~~~~~~~~~~~~~~~~~
   lib/test_bits.c:47:9: note: in expansion of macro 'KUNIT_EXPECT_EQ'
      47 |         KUNIT_EXPECT_EQ(test, 0x0000000000000003ull, GENMASK_U128(1, 0));
         |         ^~~~~~~~~~~~~~~
   include/uapi/linux/bits.h:15:32: note: in expansion of macro '___GENMASK'
      15 | #define __GENMASK_U128(hi, lo) ___GENMASK((__uint128)1, hi, lo)
         |                                ^~~~~~~~~~
   include/linux/bits.h:33:40: note: in expansion of macro '__GENMASK_U128'
      33 |         (GENMASK_INPUT_CHECK(hi, lo) + __GENMASK_U128(hi, lo))
         |                                        ^~~~~~~~~~~~~~
   lib/test_bits.c:47:54: note: in expansion of macro 'GENMASK_U128'
      47 |         KUNIT_EXPECT_EQ(test, 0x0000000000000003ull, GENMASK_U128(1, 0));
         |                                                      ^~~~~~~~~~~~
>> include/uapi/linux/bits.h:15:54: error: expected ')' before numeric constant
      15 | #define __GENMASK_U128(hi, lo) ___GENMASK((__uint128)1, hi, lo)
         |                                                      ^
   include/kunit/test.h:774:22: note: in definition of macro 'KUNIT_BASE_BINARY_ASSERTION'
     774 |         const typeof(right) __right = (right);                                 \
         |                      ^~~~~
   include/kunit/test.h:969:9: note: in expansion of macro 'KUNIT_BINARY_INT_ASSERTION'
     969 |         KUNIT_BINARY_INT_ASSERTION(test,                                       \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
   include/kunit/test.h:966:9: note: in expansion of macro 'KUNIT_EXPECT_EQ_MSG'
     966 |         KUNIT_EXPECT_EQ_MSG(test, left, right, NULL)
         |         ^~~~~~~~~~~~~~~~~~~
   lib/test_bits.c:48:9: note: in expansion of macro 'KUNIT_EXPECT_EQ'
      48 |         KUNIT_EXPECT_EQ(test, 0x0000000000000006ull, GENMASK_U128(2, 1));
         |         ^~~~~~~~~~~~~~~
   include/uapi/linux/bits.h:15:32: note: in expansion of macro '___GENMASK'
      15 | #define __GENMASK_U128(hi, lo) ___GENMASK((__uint128)1, hi, lo)
         |                                ^~~~~~~~~~
   include/linux/bits.h:33:40: note: in expansion of macro '__GENMASK_U128'
      33 |         (GENMASK_INPUT_CHECK(hi, lo) + __GENMASK_U128(hi, lo))
         |                                        ^~~~~~~~~~~~~~
   lib/test_bits.c:48:54: note: in expansion of macro 'GENMASK_U128'
      48 |         KUNIT_EXPECT_EQ(test, 0x0000000000000006ull, GENMASK_U128(2, 1));
         |                                                      ^~~~~~~~~~~~
   include/uapi/linux/bits.h:9:12: note: to match this '('
       9 |         ((((one) << (hi)) - 1) * 2 + 1 - (((one) << (lo)) - 1))
         |            ^
   include/kunit/test.h:774:22: note: in definition of macro 'KUNIT_BASE_BINARY_ASSERTION'
     774 |         const typeof(right) __right = (right);                                 \
         |                      ^~~~~
   include/kunit/test.h:969:9: note: in expansion of macro 'KUNIT_BINARY_INT_ASSERTION'
     969 |         KUNIT_BINARY_INT_ASSERTION(test,                                       \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
   include/kunit/test.h:966:9: note: in expansion of macro 'KUNIT_EXPECT_EQ_MSG'
     966 |         KUNIT_EXPECT_EQ_MSG(test, left, right, NULL)
         |         ^~~~~~~~~~~~~~~~~~~
   lib/test_bits.c:48:9: note: in expansion of macro 'KUNIT_EXPECT_EQ'
      48 |         KUNIT_EXPECT_EQ(test, 0x0000000000000006ull, GENMASK_U128(2, 1));
         |         ^~~~~~~~~~~~~~~
   include/uapi/linux/bits.h:15:32: note: in expansion of macro '___GENMASK'
      15 | #define __GENMASK_U128(hi, lo) ___GENMASK((__uint128)1, hi, lo)
         |                                ^~~~~~~~~~
   include/linux/bits.h:33:40: note: in expansion of macro '__GENMASK_U128'
      33 |         (GENMASK_INPUT_CHECK(hi, lo) + __GENMASK_U128(hi, lo))
         |                                        ^~~~~~~~~~~~~~
   lib/test_bits.c:48:54: note: in expansion of macro 'GENMASK_U128'
      48 |         KUNIT_EXPECT_EQ(test, 0x0000000000000006ull, GENMASK_U128(2, 1));
         |                                                      ^~~~~~~~~~~~
>> include/uapi/linux/bits.h:15:54: error: expected ')' before numeric constant
      15 | #define __GENMASK_U128(hi, lo) ___GENMASK((__uint128)1, hi, lo)
         |                                                      ^
   include/kunit/test.h:774:22: note: in definition of macro 'KUNIT_BASE_BINARY_ASSERTION'
     774 |         const typeof(right) __right = (right);                                 \
         |                      ^~~~~
   include/kunit/test.h:969:9: note: in expansion of macro 'KUNIT_BINARY_INT_ASSERTION'
     969 |         KUNIT_BINARY_INT_ASSERTION(test,                                       \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
   include/kunit/test.h:966:9: note: in expansion of macro 'KUNIT_EXPECT_EQ_MSG'
     966 |         KUNIT_EXPECT_EQ_MSG(test, left, right, NULL)
         |         ^~~~~~~~~~~~~~~~~~~
   lib/test_bits.c:48:9: note: in expansion of macro 'KUNIT_EXPECT_EQ'
      48 |         KUNIT_EXPECT_EQ(test, 0x0000000000000006ull, GENMASK_U128(2, 1));
         |         ^~~~~~~~~~~~~~~
   include/uapi/linux/bits.h:15:32: note: in expansion of macro '___GENMASK'
      15 | #define __GENMASK_U128(hi, lo) ___GENMASK((__uint128)1, hi, lo)
         |                                ^~~~~~~~~~
   include/linux/bits.h:33:40: note: in expansion of macro '__GENMASK_U128'
      33 |         (GENMASK_INPUT_CHECK(hi, lo) + __GENMASK_U128(hi, lo))
         |                                        ^~~~~~~~~~~~~~
   lib/test_bits.c:48:54: note: in expansion of macro 'GENMASK_U128'
      48 |         KUNIT_EXPECT_EQ(test, 0x0000000000000006ull, GENMASK_U128(2, 1));
         |                                                      ^~~~~~~~~~~~
   include/uapi/linux/bits.h:9:44: note: to match this '('
       9 |         ((((one) << (hi)) - 1) * 2 + 1 - (((one) << (lo)) - 1))
         |                                            ^
   include/kunit/test.h:774:22: note: in definition of macro 'KUNIT_BASE_BINARY_ASSERTION'
     774 |         const typeof(right) __right = (right);                                 \
         |                      ^~~~~
   include/kunit/test.h:969:9: note: in expansion of macro 'KUNIT_BINARY_INT_ASSERTION'
     969 |         KUNIT_BINARY_INT_ASSERTION(test,                                       \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
   include/kunit/test.h:966:9: note: in expansion of macro 'KUNIT_EXPECT_EQ_MSG'
     966 |         KUNIT_EXPECT_EQ_MSG(test, left, right, NULL)
         |         ^~~~~~~~~~~~~~~~~~~
   lib/test_bits.c:48:9: note: in expansion of macro 'KUNIT_EXPECT_EQ'
      48 |         KUNIT_EXPECT_EQ(test, 0x0000000000000006ull, GENMASK_U128(2, 1));
         |         ^~~~~~~~~~~~~~~
   include/uapi/linux/bits.h:15:32: note: in expansion of macro '___GENMASK'
      15 | #define __GENMASK_U128(hi, lo) ___GENMASK((__uint128)1, hi, lo)
         |                                ^~~~~~~~~~
   include/linux/bits.h:33:40: note: in expansion of macro '__GENMASK_U128'
      33 |         (GENMASK_INPUT_CHECK(hi, lo) + __GENMASK_U128(hi, lo))
         |                                        ^~~~~~~~~~~~~~
   lib/test_bits.c:48:54: note: in expansion of macro 'GENMASK_U128'
      48 |         KUNIT_EXPECT_EQ(test, 0x0000000000000006ull, GENMASK_U128(2, 1));
         |                                                      ^~~~~~~~~~~~
>> include/uapi/linux/bits.h:15:54: error: expected ')' before numeric constant
      15 | #define __GENMASK_U128(hi, lo) ___GENMASK((__uint128)1, hi, lo)
         |                                                      ^
   include/kunit/test.h:774:40: note: in definition of macro 'KUNIT_BASE_BINARY_ASSERTION'
     774 |         const typeof(right) __right = (right);                                 \
         |                                        ^~~~~
   include/kunit/test.h:969:9: note: in expansion of macro 'KUNIT_BINARY_INT_ASSERTION'
     969 |         KUNIT_BINARY_INT_ASSERTION(test,                                       \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
   include/kunit/test.h:966:9: note: in expansion of macro 'KUNIT_EXPECT_EQ_MSG'
     966 |         KUNIT_EXPECT_EQ_MSG(test, left, right, NULL)
         |         ^~~~~~~~~~~~~~~~~~~
   lib/test_bits.c:48:9: note: in expansion of macro 'KUNIT_EXPECT_EQ'
      48 |         KUNIT_EXPECT_EQ(test, 0x0000000000000006ull, GENMASK_U128(2, 1));
         |         ^~~~~~~~~~~~~~~
   include/uapi/linux/bits.h:15:32: note: in expansion of macro '___GENMASK'
      15 | #define __GENMASK_U128(hi, lo) ___GENMASK((__uint128)1, hi, lo)
         |                                ^~~~~~~~~~
   include/linux/bits.h:33:40: note: in expansion of macro '__GENMASK_U128'
      33 |         (GENMASK_INPUT_CHECK(hi, lo) + __GENMASK_U128(hi, lo))
         |                                        ^~~~~~~~~~~~~~
   lib/test_bits.c:48:54: note: in expansion of macro 'GENMASK_U128'
      48 |         KUNIT_EXPECT_EQ(test, 0x0000000000000006ull, GENMASK_U128(2, 1));
         |                                                      ^~~~~~~~~~~~
   include/uapi/linux/bits.h:9:12: note: to match this '('
       9 |         ((((one) << (hi)) - 1) * 2 + 1 - (((one) << (lo)) - 1))
         |            ^
   include/kunit/test.h:774:40: note: in definition of macro 'KUNIT_BASE_BINARY_ASSERTION'
     774 |         const typeof(right) __right = (right);                                 \
         |                                        ^~~~~
   include/kunit/test.h:969:9: note: in expansion of macro 'KUNIT_BINARY_INT_ASSERTION'
     969 |         KUNIT_BINARY_INT_ASSERTION(test,                                       \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
   include/kunit/test.h:966:9: note: in expansion of macro 'KUNIT_EXPECT_EQ_MSG'
     966 |         KUNIT_EXPECT_EQ_MSG(test, left, right, NULL)
         |         ^~~~~~~~~~~~~~~~~~~
   lib/test_bits.c:48:9: note: in expansion of macro 'KUNIT_EXPECT_EQ'
      48 |         KUNIT_EXPECT_EQ(test, 0x0000000000000006ull, GENMASK_U128(2, 1));
         |         ^~~~~~~~~~~~~~~
   include/uapi/linux/bits.h:15:32: note: in expansion of macro '___GENMASK'
      15 | #define __GENMASK_U128(hi, lo) ___GENMASK((__uint128)1, hi, lo)
         |                                ^~~~~~~~~~
   include/linux/bits.h:33:40: note: in expansion of macro '__GENMASK_U128'
      33 |         (GENMASK_INPUT_CHECK(hi, lo) + __GENMASK_U128(hi, lo))
         |                                        ^~~~~~~~~~~~~~
   lib/test_bits.c:48:54: note: in expansion of macro 'GENMASK_U128'
      48 |         KUNIT_EXPECT_EQ(test, 0x0000000000000006ull, GENMASK_U128(2, 1));
         |                                                      ^~~~~~~~~~~~
>> include/uapi/linux/bits.h:15:54: error: expected ')' before numeric constant
      15 | #define __GENMASK_U128(hi, lo) ___GENMASK((__uint128)1, hi, lo)
         |                                                      ^
   include/kunit/test.h:774:40: note: in definition of macro 'KUNIT_BASE_BINARY_ASSERTION'
     774 |         const typeof(right) __right = (right);                                 \
         |                                        ^~~~~
   include/kunit/test.h:969:9: note: in expansion of macro 'KUNIT_BINARY_INT_ASSERTION'
     969 |         KUNIT_BINARY_INT_ASSERTION(test,                                       \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
   include/kunit/test.h:966:9: note: in expansion of macro 'KUNIT_EXPECT_EQ_MSG'
     966 |         KUNIT_EXPECT_EQ_MSG(test, left, right, NULL)
         |         ^~~~~~~~~~~~~~~~~~~
   lib/test_bits.c:48:9: note: in expansion of macro 'KUNIT_EXPECT_EQ'
      48 |         KUNIT_EXPECT_EQ(test, 0x0000000000000006ull, GENMASK_U128(2, 1));
         |         ^~~~~~~~~~~~~~~
   include/uapi/linux/bits.h:15:32: note: in expansion of macro '___GENMASK'
      15 | #define __GENMASK_U128(hi, lo) ___GENMASK((__uint128)1, hi, lo)
         |                                ^~~~~~~~~~
   include/linux/bits.h:33:40: note: in expansion of macro '__GENMASK_U128'
      33 |         (GENMASK_INPUT_CHECK(hi, lo) + __GENMASK_U128(hi, lo))
         |                                        ^~~~~~~~~~~~~~
   lib/test_bits.c:48:54: note: in expansion of macro 'GENMASK_U128'
      48 |         KUNIT_EXPECT_EQ(test, 0x0000000000000006ull, GENMASK_U128(2, 1));
         |                                                      ^~~~~~~~~~~~
   include/uapi/linux/bits.h:9:44: note: to match this '('
       9 |         ((((one) << (hi)) - 1) * 2 + 1 - (((one) << (lo)) - 1))
         |                                            ^
   include/kunit/test.h:774:40: note: in definition of macro 'KUNIT_BASE_BINARY_ASSERTION'
     774 |         const typeof(right) __right = (right);                                 \
         |                                        ^~~~~
   include/kunit/test.h:969:9: note: in expansion of macro 'KUNIT_BINARY_INT_ASSERTION'
     969 |         KUNIT_BINARY_INT_ASSERTION(test,                                       \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
   include/kunit/test.h:966:9: note: in expansion of macro 'KUNIT_EXPECT_EQ_MSG'
     966 |         KUNIT_EXPECT_EQ_MSG(test, left, right, NULL)
         |         ^~~~~~~~~~~~~~~~~~~
   lib/test_bits.c:48:9: note: in expansion of macro 'KUNIT_EXPECT_EQ'
      48 |         KUNIT_EXPECT_EQ(test, 0x0000000000000006ull, GENMASK_U128(2, 1));
         |         ^~~~~~~~~~~~~~~
   include/uapi/linux/bits.h:15:32: note: in expansion of macro '___GENMASK'
      15 | #define __GENMASK_U128(hi, lo) ___GENMASK((__uint128)1, hi, lo)
         |                                ^~~~~~~~~~
   include/linux/bits.h:33:40: note: in expansion of macro '__GENMASK_U128'
      33 |         (GENMASK_INPUT_CHECK(hi, lo) + __GENMASK_U128(hi, lo))
         |                                        ^~~~~~~~~~~~~~
   lib/test_bits.c:48:54: note: in expansion of macro 'GENMASK_U128'
      48 |         KUNIT_EXPECT_EQ(test, 0x0000000000000006ull, GENMASK_U128(2, 1));
         |                                                      ^~~~~~~~~~~~
>> include/uapi/linux/bits.h:15:54: error: expected ')' before numeric constant
      15 | #define __GENMASK_U128(hi, lo) ___GENMASK((__uint128)1, hi, lo)
         |                                                      ^
   include/kunit/test.h:774:22: note: in definition of macro 'KUNIT_BASE_BINARY_ASSERTION'
     774 |         const typeof(right) __right = (right);                                 \
         |                      ^~~~~
   include/kunit/test.h:969:9: note: in expansion of macro 'KUNIT_BINARY_INT_ASSERTION'
     969 |         KUNIT_BINARY_INT_ASSERTION(test,                                       \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
   include/kunit/test.h:966:9: note: in expansion of macro 'KUNIT_EXPECT_EQ_MSG'
     966 |         KUNIT_EXPECT_EQ_MSG(test, left, right, NULL)
         |         ^~~~~~~~~~~~~~~~~~~
   lib/test_bits.c:49:9: note: in expansion of macro 'KUNIT_EXPECT_EQ'
      49 |         KUNIT_EXPECT_EQ(test, 0x00000000ffffffffull, GENMASK_U128(31, 0));
         |         ^~~~~~~~~~~~~~~
   include/uapi/linux/bits.h:15:32: note: in expansion of macro '___GENMASK'
      15 | #define __GENMASK_U128(hi, lo) ___GENMASK((__uint128)1, hi, lo)
         |                                ^~~~~~~~~~
   include/linux/bits.h:33:40: note: in expansion of macro '__GENMASK_U128'
      33 |         (GENMASK_INPUT_CHECK(hi, lo) + __GENMASK_U128(hi, lo))
         |                                        ^~~~~~~~~~~~~~
   lib/test_bits.c:49:54: note: in expansion of macro 'GENMASK_U128'
      49 |         KUNIT_EXPECT_EQ(test, 0x00000000ffffffffull, GENMASK_U128(31, 0));
         |                                                      ^~~~~~~~~~~~
   include/uapi/linux/bits.h:9:12: note: to match this '('
       9 |         ((((one) << (hi)) - 1) * 2 + 1 - (((one) << (lo)) - 1))
         |            ^
   include/kunit/test.h:774:22: note: in definition of macro 'KUNIT_BASE_BINARY_ASSERTION'
     774 |         const typeof(right) __right = (right);                                 \
         |                      ^~~~~
   include/kunit/test.h:969:9: note: in expansion of macro 'KUNIT_BINARY_INT_ASSERTION'
     969 |         KUNIT_BINARY_INT_ASSERTION(test,                                       \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
   include/kunit/test.h:966:9: note: in expansion of macro 'KUNIT_EXPECT_EQ_MSG'
     966 |         KUNIT_EXPECT_EQ_MSG(test, left, right, NULL)
         |         ^~~~~~~~~~~~~~~~~~~
   lib/test_bits.c:49:9: note: in expansion of macro 'KUNIT_EXPECT_EQ'
      49 |         KUNIT_EXPECT_EQ(test, 0x00000000ffffffffull, GENMASK_U128(31, 0));
         |         ^~~~~~~~~~~~~~~
   include/uapi/linux/bits.h:15:32: note: in expansion of macro '___GENMASK'
      15 | #define __GENMASK_U128(hi, lo) ___GENMASK((__uint128)1, hi, lo)
         |                                ^~~~~~~~~~
   include/linux/bits.h:33:40: note: in expansion of macro '__GENMASK_U128'
      33 |         (GENMASK_INPUT_CHECK(hi, lo) + __GENMASK_U128(hi, lo))
         |                                        ^~~~~~~~~~~~~~
   lib/test_bits.c:49:54: note: in expansion of macro 'GENMASK_U128'
      49 |         KUNIT_EXPECT_EQ(test, 0x00000000ffffffffull, GENMASK_U128(31, 0));
         |                                                      ^~~~~~~~~~~~
>> include/uapi/linux/bits.h:15:54: error: expected ')' before numeric constant
      15 | #define __GENMASK_U128(hi, lo) ___GENMASK((__uint128)1, hi, lo)
         |                                                      ^
   include/kunit/test.h:774:22: note: in definition of macro 'KUNIT_BASE_BINARY_ASSERTION'
     774 |         const typeof(right) __right = (right);                                 \
         |                      ^~~~~
   include/kunit/test.h:969:9: note: in expansion of macro 'KUNIT_BINARY_INT_ASSERTION'
     969 |         KUNIT_BINARY_INT_ASSERTION(test,                                       \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
   include/kunit/test.h:966:9: note: in expansion of macro 'KUNIT_EXPECT_EQ_MSG'
     966 |         KUNIT_EXPECT_EQ_MSG(test, left, right, NULL)
         |         ^~~~~~~~~~~~~~~~~~~
   lib/test_bits.c:49:9: note: in expansion of macro 'KUNIT_EXPECT_EQ'
      49 |         KUNIT_EXPECT_EQ(test, 0x00000000ffffffffull, GENMASK_U128(31, 0));
         |         ^~~~~~~~~~~~~~~
   include/uapi/linux/bits.h:15:32: note: in expansion of macro '___GENMASK'
      15 | #define __GENMASK_U128(hi, lo) ___GENMASK((__uint128)1, hi, lo)
         |                                ^~~~~~~~~~
   include/linux/bits.h:33:40: note: in expansion of macro '__GENMASK_U128'
      33 |         (GENMASK_INPUT_CHECK(hi, lo) + __GENMASK_U128(hi, lo))
         |                                        ^~~~~~~~~~~~~~
   lib/test_bits.c:49:54: note: in expansion of macro 'GENMASK_U128'
      49 |         KUNIT_EXPECT_EQ(test, 0x00000000ffffffffull, GENMASK_U128(31, 0));
         |                                                      ^~~~~~~~~~~~
   include/uapi/linux/bits.h:9:44: note: to match this '('
       9 |         ((((one) << (hi)) - 1) * 2 + 1 - (((one) << (lo)) - 1))
         |                                            ^
   include/kunit/test.h:774:22: note: in definition of macro 'KUNIT_BASE_BINARY_ASSERTION'
     774 |         const typeof(right) __right = (right);                                 \
         |                      ^~~~~
   include/kunit/test.h:969:9: note: in expansion of macro 'KUNIT_BINARY_INT_ASSERTION'
     969 |         KUNIT_BINARY_INT_ASSERTION(test,                                       \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
   include/kunit/test.h:966:9: note: in expansion of macro 'KUNIT_EXPECT_EQ_MSG'
     966 |         KUNIT_EXPECT_EQ_MSG(test, left, right, NULL)
         |         ^~~~~~~~~~~~~~~~~~~
   lib/test_bits.c:49:9: note: in expansion of macro 'KUNIT_EXPECT_EQ'
      49 |         KUNIT_EXPECT_EQ(test, 0x00000000ffffffffull, GENMASK_U128(31, 0));
         |         ^~~~~~~~~~~~~~~
   include/uapi/linux/bits.h:15:32: note: in expansion of macro '___GENMASK'
      15 | #define __GENMASK_U128(hi, lo) ___GENMASK((__uint128)1, hi, lo)
         |                                ^~~~~~~~~~
   include/linux/bits.h:33:40: note: in expansion of macro '__GENMASK_U128'
      33 |         (GENMASK_INPUT_CHECK(hi, lo) + __GENMASK_U128(hi, lo))
         |                                        ^~~~~~~~~~~~~~
   lib/test_bits.c:49:54: note: in expansion of macro 'GENMASK_U128'
      49 |         KUNIT_EXPECT_EQ(test, 0x00000000ffffffffull, GENMASK_U128(31, 0));
         |                                                      ^~~~~~~~~~~~
>> include/uapi/linux/bits.h:15:54: error: expected ')' before numeric constant
      15 | #define __GENMASK_U128(hi, lo) ___GENMASK((__uint128)1, hi, lo)
         |                                                      ^
   include/kunit/test.h:774:40: note: in definition of macro 'KUNIT_BASE_BINARY_ASSERTION'
     774 |         const typeof(right) __right = (right);                                 \
         |                                        ^~~~~
   include/kunit/test.h:969:9: note: in expansion of macro 'KUNIT_BINARY_INT_ASSERTION'
     969 |         KUNIT_BINARY_INT_ASSERTION(test,                                       \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
   include/kunit/test.h:966:9: note: in expansion of macro 'KUNIT_EXPECT_EQ_MSG'
     966 |         KUNIT_EXPECT_EQ_MSG(test, left, right, NULL)
         |         ^~~~~~~~~~~~~~~~~~~
   lib/test_bits.c:49:9: note: in expansion of macro 'KUNIT_EXPECT_EQ'
      49 |         KUNIT_EXPECT_EQ(test, 0x00000000ffffffffull, GENMASK_U128(31, 0));
         |         ^~~~~~~~~~~~~~~
   include/uapi/linux/bits.h:15:32: note: in expansion of macro '___GENMASK'
      15 | #define __GENMASK_U128(hi, lo) ___GENMASK((__uint128)1, hi, lo)
         |                                ^~~~~~~~~~
   include/linux/bits.h:33:40: note: in expansion of macro '__GENMASK_U128'
      33 |         (GENMASK_INPUT_CHECK(hi, lo) + __GENMASK_U128(hi, lo))
         |                                        ^~~~~~~~~~~~~~
   lib/test_bits.c:49:54: note: in expansion of macro 'GENMASK_U128'
      49 |         KUNIT_EXPECT_EQ(test, 0x00000000ffffffffull, GENMASK_U128(31, 0));
         |                                                      ^~~~~~~~~~~~
   include/uapi/linux/bits.h:9:12: note: to match this '('
       9 |         ((((one) << (hi)) - 1) * 2 + 1 - (((one) << (lo)) - 1))
         |            ^
   include/kunit/test.h:774:40: note: in definition of macro 'KUNIT_BASE_BINARY_ASSERTION'
     774 |         const typeof(right) __right = (right);                                 \
         |                                        ^~~~~
   include/kunit/test.h:969:9: note: in expansion of macro 'KUNIT_BINARY_INT_ASSERTION'
     969 |         KUNIT_BINARY_INT_ASSERTION(test,                                       \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
   include/kunit/test.h:966:9: note: in expansion of macro 'KUNIT_EXPECT_EQ_MSG'
     966 |         KUNIT_EXPECT_EQ_MSG(test, left, right, NULL)
         |         ^~~~~~~~~~~~~~~~~~~
   lib/test_bits.c:49:9: note: in expansion of macro 'KUNIT_EXPECT_EQ'
      49 |         KUNIT_EXPECT_EQ(test, 0x00000000ffffffffull, GENMASK_U128(31, 0));
         |         ^~~~~~~~~~~~~~~
   include/uapi/linux/bits.h:15:32: note: in expansion of macro '___GENMASK'
      15 | #define __GENMASK_U128(hi, lo) ___GENMASK((__uint128)1, hi, lo)
         |                                ^~~~~~~~~~
   include/linux/bits.h:33:40: note: in expansion of macro '__GENMASK_U128'
      33 |         (GENMASK_INPUT_CHECK(hi, lo) + __GENMASK_U128(hi, lo))
         |                                        ^~~~~~~~~~~~~~
   lib/test_bits.c:49:54: note: in expansion of macro 'GENMASK_U128'
      49 |         KUNIT_EXPECT_EQ(test, 0x00000000ffffffffull, GENMASK_U128(31, 0));
         |                                                      ^~~~~~~~~~~~
>> include/uapi/linux/bits.h:15:54: error: expected ')' before numeric constant
      15 | #define __GENMASK_U128(hi, lo) ___GENMASK((__uint128)1, hi, lo)
         |                                                      ^
   include/kunit/test.h:774:40: note: in definition of macro 'KUNIT_BASE_BINARY_ASSERTION'
     774 |         const typeof(right) __right = (right);                                 \
         |                                        ^~~~~
   include/kunit/test.h:969:9: note: in expansion of macro 'KUNIT_BINARY_INT_ASSERTION'
     969 |         KUNIT_BINARY_INT_ASSERTION(test,                                       \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
   include/kunit/test.h:966:9: note: in expansion of macro 'KUNIT_EXPECT_EQ_MSG'
     966 |         KUNIT_EXPECT_EQ_MSG(test, left, right, NULL)
         |         ^~~~~~~~~~~~~~~~~~~
   lib/test_bits.c:49:9: note: in expansion of macro 'KUNIT_EXPECT_EQ'
      49 |         KUNIT_EXPECT_EQ(test, 0x00000000ffffffffull, GENMASK_U128(31, 0));
         |         ^~~~~~~~~~~~~~~
   include/uapi/linux/bits.h:15:32: note: in expansion of macro '___GENMASK'
      15 | #define __GENMASK_U128(hi, lo) ___GENMASK((__uint128)1, hi, lo)
         |                                ^~~~~~~~~~
   include/linux/bits.h:33:40: note: in expansion of macro '__GENMASK_U128'
      33 |         (GENMASK_INPUT_CHECK(hi, lo) + __GENMASK_U128(hi, lo))
         |                                        ^~~~~~~~~~~~~~
   lib/test_bits.c:49:54: note: in expansion of macro 'GENMASK_U128'
      49 |         KUNIT_EXPECT_EQ(test, 0x00000000ffffffffull, GENMASK_U128(31, 0));
         |                                                      ^~~~~~~~~~~~
   include/uapi/linux/bits.h:9:44: note: to match this '('
       9 |         ((((one) << (hi)) - 1) * 2 + 1 - (((one) << (lo)) - 1))
         |                                            ^
   include/kunit/test.h:774:40: note: in definition of macro 'KUNIT_BASE_BINARY_ASSERTION'
     774 |         const typeof(right) __right = (right);                                 \
         |                                        ^~~~~
   include/kunit/test.h:969:9: note: in expansion of macro 'KUNIT_BINARY_INT_ASSERTION'
     969 |         KUNIT_BINARY_INT_ASSERTION(test,                                       \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
   include/kunit/test.h:966:9: note: in expansion of macro 'KUNIT_EXPECT_EQ_MSG'
     966 |         KUNIT_EXPECT_EQ_MSG(test, left, right, NULL)
         |         ^~~~~~~~~~~~~~~~~~~
   lib/test_bits.c:49:9: note: in expansion of macro 'KUNIT_EXPECT_EQ'
      49 |         KUNIT_EXPECT_EQ(test, 0x00000000ffffffffull, GENMASK_U128(31, 0));
         |         ^~~~~~~~~~~~~~~
   include/uapi/linux/bits.h:15:32: note: in expansion of macro '___GENMASK'
      15 | #define __GENMASK_U128(hi, lo) ___GENMASK((__uint128)1, hi, lo)
         |                                ^~~~~~~~~~
   include/linux/bits.h:33:40: note: in expansion of macro '__GENMASK_U128'
      33 |         (GENMASK_INPUT_CHECK(hi, lo) + __GENMASK_U128(hi, lo))
         |                                        ^~~~~~~~~~~~~~
   lib/test_bits.c:49:54: note: in expansion of macro 'GENMASK_U128'
      49 |         KUNIT_EXPECT_EQ(test, 0x00000000ffffffffull, GENMASK_U128(31, 0));
         |                                                      ^~~~~~~~~~~~
>> include/uapi/linux/bits.h:15:54: error: expected ')' before numeric constant
      15 | #define __GENMASK_U128(hi, lo) ___GENMASK((__uint128)1, hi, lo)
         |                                                      ^
   include/kunit/test.h:774:22: note: in definition of macro 'KUNIT_BASE_BINARY_ASSERTION'
     774 |         const typeof(right) __right = (right);                                 \
         |                      ^~~~~
   include/kunit/test.h:969:9: note: in expansion of macro 'KUNIT_BINARY_INT_ASSERTION'
     969 |         KUNIT_BINARY_INT_ASSERTION(test,                                       \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
   include/kunit/test.h:966:9: note: in expansion of macro 'KUNIT_EXPECT_EQ_MSG'
     966 |         KUNIT_EXPECT_EQ_MSG(test, left, right, NULL)
         |         ^~~~~~~~~~~~~~~~~~~
   lib/test_bits.c:50:9: note: in expansion of macro 'KUNIT_EXPECT_EQ'
      50 |         KUNIT_EXPECT_EQ(test, 0x000000ffffe00000ull, GENMASK_U128(39, 21));
         |         ^~~~~~~~~~~~~~~
   include/uapi/linux/bits.h:15:32: note: in expansion of macro '___GENMASK'
      15 | #define __GENMASK_U128(hi, lo) ___GENMASK((__uint128)1, hi, lo)
         |                                ^~~~~~~~~~
   include/linux/bits.h:33:40: note: in expansion of macro '__GENMASK_U128'
      33 |         (GENMASK_INPUT_CHECK(hi, lo) + __GENMASK_U128(hi, lo))
         |                                        ^~~~~~~~~~~~~~
   lib/test_bits.c:50:54: note: in expansion of macro 'GENMASK_U128'
      50 |         KUNIT_EXPECT_EQ(test, 0x000000ffffe00000ull, GENMASK_U128(39, 21));
         |                                                      ^~~~~~~~~~~~
   include/uapi/linux/bits.h:9:12: note: to match this '('
       9 |         ((((one) << (hi)) - 1) * 2 + 1 - (((one) << (lo)) - 1))
         |            ^
   include/kunit/test.h:774:22: note: in definition of macro 'KUNIT_BASE_BINARY_ASSERTION'
     774 |         const typeof(right) __right = (right);                                 \
         |                      ^~~~~
   include/kunit/test.h:969:9: note: in expansion of macro 'KUNIT_BINARY_INT_ASSERTION'
     969 |         KUNIT_BINARY_INT_ASSERTION(test,                                       \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
   include/kunit/test.h:966:9: note: in expansion of macro 'KUNIT_EXPECT_EQ_MSG'
     966 |         KUNIT_EXPECT_EQ_MSG(test, left, right, NULL)
         |         ^~~~~~~~~~~~~~~~~~~
   lib/test_bits.c:50:9: note: in expansion of macro 'KUNIT_EXPECT_EQ'
      50 |         KUNIT_EXPECT_EQ(test, 0x000000ffffe00000ull, GENMASK_U128(39, 21));
         |         ^~~~~~~~~~~~~~~
   include/uapi/linux/bits.h:15:32: note: in expansion of macro '___GENMASK'
      15 | #define __GENMASK_U128(hi, lo) ___GENMASK((__uint128)1, hi, lo)
         |                                ^~~~~~~~~~
   include/linux/bits.h:33:40: note: in expansion of macro '__GENMASK_U128'
      33 |         (GENMASK_INPUT_CHECK(hi, lo) + __GENMASK_U128(hi, lo))
         |                                        ^~~~~~~~~~~~~~
   lib/test_bits.c:50:54: note: in expansion of macro 'GENMASK_U128'
      50 |         KUNIT_EXPECT_EQ(test, 0x000000ffffe00000ull, GENMASK_U128(39, 21));
         |                                                      ^~~~~~~~~~~~
>> include/uapi/linux/bits.h:15:54: error: expected ')' before numeric constant
      15 | #define __GENMASK_U128(hi, lo) ___GENMASK((__uint128)1, hi, lo)
         |                                                      ^
   include/kunit/test.h:774:22: note: in definition of macro 'KUNIT_BASE_BINARY_ASSERTION'
     774 |         const typeof(right) __right = (right);                                 \
         |                      ^~~~~
   include/kunit/test.h:969:9: note: in expansion of macro 'KUNIT_BINARY_INT_ASSERTION'
     969 |         KUNIT_BINARY_INT_ASSERTION(test,                                       \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
   include/kunit/test.h:966:9: note: in expansion of macro 'KUNIT_EXPECT_EQ_MSG'
     966 |         KUNIT_EXPECT_EQ_MSG(test, left, right, NULL)
         |         ^~~~~~~~~~~~~~~~~~~
   lib/test_bits.c:50:9: note: in expansion of macro 'KUNIT_EXPECT_EQ'
      50 |         KUNIT_EXPECT_EQ(test, 0x000000ffffe00000ull, GENMASK_U128(39, 21));
         |         ^~~~~~~~~~~~~~~
   include/uapi/linux/bits.h:15:32: note: in expansion of macro '___GENMASK'
      15 | #define __GENMASK_U128(hi, lo) ___GENMASK((__uint128)1, hi, lo)
         |                                ^~~~~~~~~~
   include/linux/bits.h:33:40: note: in expansion of macro '__GENMASK_U128'
      33 |         (GENMASK_INPUT_CHECK(hi, lo) + __GENMASK_U128(hi, lo))
         |                                        ^~~~~~~~~~~~~~
   lib/test_bits.c:50:54: note: in expansion of macro 'GENMASK_U128'
      50 |         KUNIT_EXPECT_EQ(test, 0x000000ffffe00000ull, GENMASK_U128(39, 21));
         |                                                      ^~~~~~~~~~~~
   include/uapi/linux/bits.h:9:44: note: to match this '('
       9 |         ((((one) << (hi)) - 1) * 2 + 1 - (((one) << (lo)) - 1))
         |                                            ^
   include/kunit/test.h:774:22: note: in definition of macro 'KUNIT_BASE_BINARY_ASSERTION'
     774 |         const typeof(right) __right = (right);                                 \
         |                      ^~~~~
   include/kunit/test.h:969:9: note: in expansion of macro 'KUNIT_BINARY_INT_ASSERTION'
     969 |         KUNIT_BINARY_INT_ASSERTION(test,                                       \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
   include/kunit/test.h:966:9: note: in expansion of macro 'KUNIT_EXPECT_EQ_MSG'
     966 |         KUNIT_EXPECT_EQ_MSG(test, left, right, NULL)
         |         ^~~~~~~~~~~~~~~~~~~
   lib/test_bits.c:50:9: note: in expansion of macro 'KUNIT_EXPECT_EQ'
      50 |         KUNIT_EXPECT_EQ(test, 0x000000ffffe00000ull, GENMASK_U128(39, 21));
         |         ^~~~~~~~~~~~~~~
   include/uapi/linux/bits.h:15:32: note: in expansion of macro '___GENMASK'
      15 | #define __GENMASK_U128(hi, lo) ___GENMASK((__uint128)1, hi, lo)
         |                                ^~~~~~~~~~
   include/linux/bits.h:33:40: note: in expansion of macro '__GENMASK_U128'
      33 |         (GENMASK_INPUT_CHECK(hi, lo) + __GENMASK_U128(hi, lo))
         |                                        ^~~~~~~~~~~~~~
   lib/test_bits.c:50:54: note: in expansion of macro 'GENMASK_U128'
      50 |         KUNIT_EXPECT_EQ(test, 0x000000ffffe00000ull, GENMASK_U128(39, 21));
         |                                                      ^~~~~~~~~~~~
>> include/uapi/linux/bits.h:15:54: error: expected ')' before numeric constant
      15 | #define __GENMASK_U128(hi, lo) ___GENMASK((__uint128)1, hi, lo)
         |                                                      ^
   include/kunit/test.h:774:40: note: in definition of macro 'KUNIT_BASE_BINARY_ASSERTION'
     774 |         const typeof(right) __right = (right);                                 \
         |                                        ^~~~~
   include/kunit/test.h:969:9: note: in expansion of macro 'KUNIT_BINARY_INT_ASSERTION'
     969 |         KUNIT_BINARY_INT_ASSERTION(test,                                       \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
   include/kunit/test.h:966:9: note: in expansion of macro 'KUNIT_EXPECT_EQ_MSG'
     966 |         KUNIT_EXPECT_EQ_MSG(test, left, right, NULL)
         |         ^~~~~~~~~~~~~~~~~~~
   lib/test_bits.c:50:9: note: in expansion of macro 'KUNIT_EXPECT_EQ'
      50 |         KUNIT_EXPECT_EQ(test, 0x000000ffffe00000ull, GENMASK_U128(39, 21));
         |         ^~~~~~~~~~~~~~~
   include/uapi/linux/bits.h:15:32: note: in expansion of macro '___GENMASK'
      15 | #define __GENMASK_U128(hi, lo) ___GENMASK((__uint128)1, hi, lo)
         |                                ^~~~~~~~~~
   include/linux/bits.h:33:40: note: in expansion of macro '__GENMASK_U128'
      33 |         (GENMASK_INPUT_CHECK(hi, lo) + __GENMASK_U128(hi, lo))
         |                                        ^~~~~~~~~~~~~~
   lib/test_bits.c:50:54: note: in expansion of macro 'GENMASK_U128'
      50 |         KUNIT_EXPECT_EQ(test, 0x000000ffffe00000ull, GENMASK_U128(39, 21));
         |                                                      ^~~~~~~~~~~~
   include/uapi/linux/bits.h:9:12: note: to match this '('
       9 |         ((((one) << (hi)) - 1) * 2 + 1 - (((one) << (lo)) - 1))
         |            ^
   include/kunit/test.h:774:40: note: in definition of macro 'KUNIT_BASE_BINARY_ASSERTION'
     774 |         const typeof(right) __right = (right);                                 \
         |                                        ^~~~~
   include/kunit/test.h:969:9: note: in expansion of macro 'KUNIT_BINARY_INT_ASSERTION'
     969 |         KUNIT_BINARY_INT_ASSERTION(test,                                       \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
   include/kunit/test.h:966:9: note: in expansion of macro 'KUNIT_EXPECT_EQ_MSG'
     966 |         KUNIT_EXPECT_EQ_MSG(test, left, right, NULL)
         |         ^~~~~~~~~~~~~~~~~~~
   lib/test_bits.c:50:9: note: in expansion of macro 'KUNIT_EXPECT_EQ'
      50 |         KUNIT_EXPECT_EQ(test, 0x000000ffffe00000ull, GENMASK_U128(39, 21));
         |         ^~~~~~~~~~~~~~~
   include/uapi/linux/bits.h:15:32: note: in expansion of macro '___GENMASK'
      15 | #define __GENMASK_U128(hi, lo) ___GENMASK((__uint128)1, hi, lo)
         |                                ^~~~~~~~~~
   include/linux/bits.h:33:40: note: in expansion of macro '__GENMASK_U128'
      33 |         (GENMASK_INPUT_CHECK(hi, lo) + __GENMASK_U128(hi, lo))
         |                                        ^~~~~~~~~~~~~~
   lib/test_bits.c:50:54: note: in expansion of macro 'GENMASK_U128'
      50 |         KUNIT_EXPECT_EQ(test, 0x000000ffffe00000ull, GENMASK_U128(39, 21));
         |                                                      ^~~~~~~~~~~~
   include/uapi/linux/bits.h:15:54: error: expected ')' before numeric constant
      15 | #define __GENMASK_U128(hi, lo) ___GENMASK((__uint128)1, hi, lo)
         |                                                      ^
   include/kunit/test.h:774:40: note: in definition of macro 'KUNIT_BASE_BINARY_ASSERTION'
     774 |         const typeof(right) __right = (right);                                 \
         |                                        ^~~~~
   include/kunit/test.h:969:9: note: in expansion of macro 'KUNIT_BINARY_INT_ASSERTION'
     969 |         KUNIT_BINARY_INT_ASSERTION(test,                                       \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
   include/kunit/test.h:966:9: note: in expansion of macro 'KUNIT_EXPECT_EQ_MSG'
     966 |         KUNIT_EXPECT_EQ_MSG(test, left, right, NULL)
         |         ^~~~~~~~~~~~~~~~~~~
   lib/test_bits.c:50:9: note: in expansion of macro 'KUNIT_EXPECT_EQ'
      50 |         KUNIT_EXPECT_EQ(test, 0x000000ffffe00000ull, GENMASK_U128(39, 21));
         |         ^~~~~~~~~~~~~~~
   include/uapi/linux/bits.h:15:32: note: in expansion of macro '___GENMASK'
      15 | #define __GENMASK_U128(hi, lo) ___GENMASK((__uint128)1, hi, lo)
         |                                ^~~~~~~~~~
   include/linux/bits.h:33:40: note: in expansion of macro '__GENMASK_U128'
      33 |         (GENMASK_INPUT_CHECK(hi, lo) + __GENMASK_U128(hi, lo))
         |                                        ^~~~~~~~~~~~~~
   lib/test_bits.c:50:54: note: in expansion of macro 'GENMASK_U128'
      50 |         KUNIT_EXPECT_EQ(test, 0x000000ffffe00000ull, GENMASK_U128(39, 21));
         |                                                      ^~~~~~~~~~~~
   include/uapi/linux/bits.h:9:44: note: to match this '('
       9 |         ((((one) << (hi)) - 1) * 2 + 1 - (((one) << (lo)) - 1))
         |                                            ^
   include/kunit/test.h:774:40: note: in definition of macro 'KUNIT_BASE_BINARY_ASSERTION'
     774 |         const typeof(right) __right = (right);                                 \
         |                                        ^~~~~
   include/kunit/test.h:969:9: note: in expansion of macro 'KUNIT_BINARY_INT_ASSERTION'
     969 |         KUNIT_BINARY_INT_ASSERTION(test,                                       \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
   include/kunit/test.h:966:9: note: in expansion of macro 'KUNIT_EXPECT_EQ_MSG'
     966 |         KUNIT_EXPECT_EQ_MSG(test, left, right, NULL)
         |         ^~~~~~~~~~~~~~~~~~~
   lib/test_bits.c:50:9: note: in expansion of macro 'KUNIT_EXPECT_EQ'
      50 |         KUNIT_EXPECT_EQ(test, 0x000000ffffe00000ull, GENMASK_U128(39, 21));
         |         ^~~~~~~~~~~~~~~
   include/uapi/linux/bits.h:15:32: note: in expansion of macro '___GENMASK'
      15 | #define __GENMASK_U128(hi, lo) ___GENMASK((__uint128)1, hi, lo)
         |                                ^~~~~~~~~~
   include/linux/bits.h:33:40: note: in expansion of macro '__GENMASK_U128'
      33 |         (GENMASK_INPUT_CHECK(hi, lo) + __GENMASK_U128(hi, lo))
         |                                        ^~~~~~~~~~~~~~
   lib/test_bits.c:50:54: note: in expansion of macro 'GENMASK_U128'
      50 |         KUNIT_EXPECT_EQ(test, 0x000000ffffe00000ull, GENMASK_U128(39, 21));
         |                                                      ^~~~~~~~~~~~
   include/uapi/linux/bits.h:15:54: error: expected ')' before numeric constant
      15 | #define __GENMASK_U128(hi, lo) ___GENMASK((__uint128)1, hi, lo)
         |                                                      ^
   include/kunit/test.h:774:22: note: in definition of macro 'KUNIT_BASE_BINARY_ASSERTION'
     774 |         const typeof(right) __right = (right);                                 \


vim +15 include/uapi/linux/bits.h

    14	
  > 15	#define __GENMASK_U128(hi, lo) ___GENMASK((__uint128)1, hi, lo)
    16	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

