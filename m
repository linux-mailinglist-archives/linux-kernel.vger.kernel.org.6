Return-Path: <linux-kernel+bounces-293137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B8D23957B36
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 03:54:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDF3C1C22FD8
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 01:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 364161C28E;
	Tue, 20 Aug 2024 01:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lZZdJEgf"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D51017BD5
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 01:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724118855; cv=none; b=lnL5vxaQDRnQcHQVyR57Hco7+1S85RDyNPSyiIVHrJeVb+qeKj3Rg+1gN1ID7/ADvzMqXEOj4P8YbnTNoNFsV/kNAjPYBYxwz9u/vv0NnL2S/aRlgXpobQm1oVEKgQc/e4BXWwCi8rhz7DzAX4IZ+tBhal2w0agVrqfY55WmAfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724118855; c=relaxed/simple;
	bh=2a8DBZ1NL4nUuB9hzb5dWwMwjpfX9UgxRKFJjQ0Z4NE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=jW0nvggb3mumk2tXShu0EOKzVoWaS34h1Vvy3jHzm5YoURHEddhSB2JDVYZtEnC76TctsohGeBaURoI2bF+xy+aOu36wAROrM1JxNIrkBIG+4fi1V/gaph3LMTrj3zTM6Pg7+w3iPcW6SIx/1ftkx3fuZdFrzujswefgr93kvpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lZZdJEgf; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724118853; x=1755654853;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=2a8DBZ1NL4nUuB9hzb5dWwMwjpfX9UgxRKFJjQ0Z4NE=;
  b=lZZdJEgf3iKSYkdjge8bSPsDqa5Vsx0oBfHpUBvmwM0YiK68m1bVVzQX
   T8QfZSuuyEqrSQvNKDd6Yb78Cs3YO9Ndak9dzsFhLTJjMIFDIkZNLKs7m
   TjqonR02e3g7ScQDA7b+Auv++HYcFzeJmVJqjPtZOUBYiPKSvbtRH1MF7
   8EQWd3diYWdD4x02+XyiQkqHr6YbVGxNVXUTvJT2yI2Soqjr4uu3BCO9I
   mjhFyFaKDlXVMfuEqyubQTYXce5RX6qELbdzwioKtrjN5co2WZf2AVL18
   bCqcUMaCQWt/9Kt9i+iLwzXM01hVVyR8O5NZ2eIJAj9Ckm7s6cFOM6Uog
   Q==;
X-CSE-ConnectionGUID: 1cHmUa5tSeWBHUUiF5kfww==
X-CSE-MsgGUID: zB4nRdgiR/KkJqqUBfShFA==
X-IronPort-AV: E=McAfee;i="6700,10204,11169"; a="22556759"
X-IronPort-AV: E=Sophos;i="6.10,160,1719903600"; 
   d="scan'208";a="22556759"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2024 18:54:13 -0700
X-CSE-ConnectionGUID: 8pWqeHtLRO+fw7fNHgPopg==
X-CSE-MsgGUID: QJHN8CfEShidrbs+lg0XKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,160,1719903600"; 
   d="scan'208";a="60542635"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 19 Aug 2024 18:54:10 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sgE4W-0009c6-1F;
	Tue, 20 Aug 2024 01:54:08 +0000
Date: Tue, 20 Aug 2024 09:53:16 +0800
From: kernel test robot <lkp@intel.com>
To: Kees Cook <kees@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Shuah Khan <skhan@linuxfoundation.org>,
	Vitor Massaru Iha <vitor@massaru.org>,
	David Gow <davidgow@google.com>
Subject: lib/usercopy_kunit.c:205:2: error: unexpected token, expected comma
Message-ID: <202408200939.peJOfCTH-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   6e4436539ae182dc86d57d13849862bcafaa4709
commit: cf6219ee889fb304cf8192c707ad280d93baafc7 usercopy: Convert test_user_copy to KUnit test
date:   9 weeks ago
config: mips-randconfig-r111-20240819 (https://download.01.org/0day-ci/archive/20240820/202408200939.peJOfCTH-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 26670e7fa4f032a019d23d56c6a02926e854e8af)
reproduce: (https://download.01.org/0day-ci/archive/20240820/202408200939.peJOfCTH-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408200939.peJOfCTH-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from lib/usercopy_kunit.c:13:
   In file included from include/linux/mman.h:5:
   In file included from include/linux/mm.h:2253:
   include/linux/vmstat.h:514:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     514 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
>> lib/usercopy_kunit.c:205:2: error: unexpected token, expected comma
     205 |         test_legit(u8,  0x5a);
         |         ^
   lib/usercopy_kunit.c:195:4: note: expanded from macro 'test_legit'
     195 |                         put_user(val_##size, (size __user *)usermem),   \
         |                         ^
   arch/mips/include/asm/uaccess.h:71:33: note: expanded from macro 'put_user'
      71 |         access_ok(__p, sizeof(*__p)) ? __put_user((x), __p) : -EFAULT;  \
         |                                        ^
   arch/mips/include/asm/uaccess.h:130:18: note: expanded from macro '__put_user'
     130 |                 __put_data_asm(user_sb, __pu_ptr);                      \
         |                                ^
   <inline asm>:3:10: note: instantiated into assembly here
       3 |         .set    eva
         |                    ^
>> lib/usercopy_kunit.c:205:2: error: invalid operand for instruction
     205 |         test_legit(u8,  0x5a);
         |         ^
   lib/usercopy_kunit.c:195:4: note: expanded from macro 'test_legit'
     195 |                         put_user(val_##size, (size __user *)usermem),   \
         |                         ^
   arch/mips/include/asm/uaccess.h:71:33: note: expanded from macro 'put_user'
      71 |         access_ok(__p, sizeof(*__p)) ? __put_user((x), __p) : -EFAULT;  \
         |                                        ^
   arch/mips/include/asm/uaccess.h:130:18: note: expanded from macro '__put_user'
     130 |                 __put_data_asm(user_sb, __pu_ptr);                      \
         |                                ^
   <inline asm>:4:10: note: instantiated into assembly here
       4 |         sbe $2, 0($17)
         |                 ^
>> lib/usercopy_kunit.c:205:2: error: unexpected token, expected comma
     205 |         test_legit(u8,  0x5a);
         |         ^
   lib/usercopy_kunit.c:199:4: note: expanded from macro 'test_legit'
     199 |                         get_user(val_##size, (size __user *)usermem),   \
         |                         ^
   arch/mips/include/asm/uaccess.h:97:33: note: expanded from macro 'get_user'
      97 |         access_ok(__p, sizeof(*__p)) ? __get_user((x), __p) :           \
         |                                        ^
   arch/mips/include/asm/uaccess.h:177:23: note: expanded from macro '__get_user'
     177 |                 __get_data_asm((x), user_lb, __gu_ptr);                 \
         |                                     ^
   <inline asm>:3:10: note: instantiated into assembly here
       3 |         .set    eva
         |                    ^
>> lib/usercopy_kunit.c:205:2: error: invalid operand for instruction
     205 |         test_legit(u8,  0x5a);
         |         ^
   lib/usercopy_kunit.c:199:4: note: expanded from macro 'test_legit'
     199 |                         get_user(val_##size, (size __user *)usermem),   \
         |                         ^
   arch/mips/include/asm/uaccess.h:97:33: note: expanded from macro 'get_user'
      97 |         access_ok(__p, sizeof(*__p)) ? __get_user((x), __p) :           \
         |                                        ^
   arch/mips/include/asm/uaccess.h:177:23: note: expanded from macro '__get_user'
     177 |                 __get_data_asm((x), user_lb, __gu_ptr);                 \
         |                                     ^
   <inline asm>:4:11: note: instantiated into assembly here
       4 |         lbe $20, 0($17)
         |                  ^
   lib/usercopy_kunit.c:206:2: error: unexpected token, expected comma
     206 |         test_legit(u16, 0x5a5b);
         |         ^
   lib/usercopy_kunit.c:195:4: note: expanded from macro 'test_legit'
     195 |                         put_user(val_##size, (size __user *)usermem),   \
         |                         ^
   arch/mips/include/asm/uaccess.h:71:33: note: expanded from macro 'put_user'
      71 |         access_ok(__p, sizeof(*__p)) ? __put_user((x), __p) : -EFAULT;  \
         |                                        ^
   arch/mips/include/asm/uaccess.h:133:18: note: expanded from macro '__put_user'
     133 |                 __put_data_asm(user_sh, __pu_ptr);                      \
         |                                ^
   <inline asm>:3:10: note: instantiated into assembly here
       3 |         .set    eva
         |                    ^
   lib/usercopy_kunit.c:206:2: error: invalid operand for instruction
     206 |         test_legit(u16, 0x5a5b);
         |         ^
   lib/usercopy_kunit.c:195:4: note: expanded from macro 'test_legit'
     195 |                         put_user(val_##size, (size __user *)usermem),   \
         |                         ^
   arch/mips/include/asm/uaccess.h:71:33: note: expanded from macro 'put_user'
      71 |         access_ok(__p, sizeof(*__p)) ? __put_user((x), __p) : -EFAULT;  \
         |                                        ^
   arch/mips/include/asm/uaccess.h:133:18: note: expanded from macro '__put_user'
     133 |                 __put_data_asm(user_sh, __pu_ptr);                      \
         |                                ^
   <inline asm>:4:10: note: instantiated into assembly here
       4 |         she $2, 0($17)
         |                 ^
   lib/usercopy_kunit.c:206:2: error: unexpected token, expected comma
     206 |         test_legit(u16, 0x5a5b);
         |         ^
   lib/usercopy_kunit.c:199:4: note: expanded from macro 'test_legit'
     199 |                         get_user(val_##size, (size __user *)usermem),   \
         |                         ^
   arch/mips/include/asm/uaccess.h:97:33: note: expanded from macro 'get_user'
      97 |         access_ok(__p, sizeof(*__p)) ? __get_user((x), __p) :           \
         |                                        ^
   arch/mips/include/asm/uaccess.h:180:23: note: expanded from macro '__get_user'
     180 |                 __get_data_asm((x), user_lh, __gu_ptr);                 \
         |                                     ^
   <inline asm>:3:10: note: instantiated into assembly here
       3 |         .set    eva
         |                    ^
   lib/usercopy_kunit.c:206:2: error: invalid operand for instruction
     206 |         test_legit(u16, 0x5a5b);
         |         ^
   lib/usercopy_kunit.c:199:4: note: expanded from macro 'test_legit'
     199 |                         get_user(val_##size, (size __user *)usermem),   \
         |                         ^
   arch/mips/include/asm/uaccess.h:97:33: note: expanded from macro 'get_user'
      97 |         access_ok(__p, sizeof(*__p)) ? __get_user((x), __p) :           \
         |                                        ^
   arch/mips/include/asm/uaccess.h:180:23: note: expanded from macro '__get_user'
     180 |                 __get_data_asm((x), user_lh, __gu_ptr);                 \
         |                                     ^
   <inline asm>:4:11: note: instantiated into assembly here
       4 |         lhe $20, 0($17)
         |                  ^
   lib/usercopy_kunit.c:207:2: error: unexpected token, expected comma
     207 |         test_legit(u32, 0x5a5b5c5d);
         |         ^
   lib/usercopy_kunit.c:195:4: note: expanded from macro 'test_legit'
     195 |                         put_user(val_##size, (size __user *)usermem),   \
         |                         ^
   arch/mips/include/asm/uaccess.h:71:33: note: expanded from macro 'put_user'
      71 |         access_ok(__p, sizeof(*__p)) ? __put_user((x), __p) : -EFAULT;  \
         |                                        ^
   arch/mips/include/asm/uaccess.h:136:18: note: expanded from macro '__put_user'
     136 |                 __put_data_asm(user_sw, __pu_ptr);                      \
         |                                ^
   <inline asm>:3:10: note: instantiated into assembly here
       3 |         .set    eva
         |                    ^
   lib/usercopy_kunit.c:207:2: error: invalid operand for instruction
     207 |         test_legit(u32, 0x5a5b5c5d);
         |         ^
   lib/usercopy_kunit.c:195:4: note: expanded from macro 'test_legit'
     195 |                         put_user(val_##size, (size __user *)usermem),   \
         |                         ^
   arch/mips/include/asm/uaccess.h:71:33: note: expanded from macro 'put_user'
      71 |         access_ok(__p, sizeof(*__p)) ? __put_user((x), __p) : -EFAULT;  \
         |                                        ^
   arch/mips/include/asm/uaccess.h:136:18: note: expanded from macro '__put_user'
     136 |                 __put_data_asm(user_sw, __pu_ptr);                      \


vim +205 lib/usercopy_kunit.c

   172	
   173	/*
   174	 * Legitimate usage: none of these copies should fail.
   175	 */
   176	static void usercopy_test_valid(struct kunit *test)
   177	{
   178		struct usercopy_test_priv *priv = test->priv;
   179		char __user *usermem = priv->umem;
   180		char *kmem = priv->kmem;
   181	
   182		memset(kmem, 0x3a, PAGE_SIZE * 2);
   183		KUNIT_EXPECT_EQ_MSG(test, 0, copy_to_user(usermem, kmem, PAGE_SIZE),
   184		     "legitimate copy_to_user failed");
   185		memset(kmem, 0x0, PAGE_SIZE);
   186		KUNIT_EXPECT_EQ_MSG(test, 0, copy_from_user(kmem, usermem, PAGE_SIZE),
   187		     "legitimate copy_from_user failed");
   188		KUNIT_EXPECT_MEMEQ_MSG(test, kmem, kmem + PAGE_SIZE, PAGE_SIZE,
   189		     "legitimate usercopy failed to copy data");
   190	
   191	#define test_legit(size, check)						\
   192		do {								\
   193			size val_##size = (check);				\
   194			KUNIT_EXPECT_EQ_MSG(test, 0,				\
   195				put_user(val_##size, (size __user *)usermem),	\
   196				"legitimate put_user (" #size ") failed");	\
   197			val_##size = 0;						\
   198			KUNIT_EXPECT_EQ_MSG(test, 0,				\
   199				get_user(val_##size, (size __user *)usermem),	\
   200				"legitimate get_user (" #size ") failed");	\
   201			KUNIT_EXPECT_EQ_MSG(test, val_##size, check,		\
   202				"legitimate get_user (" #size ") failed to do copy"); \
   203		} while (0)
   204	
 > 205		test_legit(u8,  0x5a);
   206		test_legit(u16, 0x5a5b);
   207		test_legit(u32, 0x5a5b5c5d);
   208	#ifdef TEST_U64
   209		test_legit(u64, 0x5a5b5c5d6a6b6c6d);
   210	#endif
   211	#undef test_legit
   212	}
   213	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

