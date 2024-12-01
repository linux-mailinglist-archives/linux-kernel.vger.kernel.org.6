Return-Path: <linux-kernel+bounces-426523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D732B9DF463
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Dec 2024 03:12:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A745B20F7F
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Dec 2024 02:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6AB8B641;
	Sun,  1 Dec 2024 02:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="evisfQM+"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 796B7AD24
	for <linux-kernel@vger.kernel.org>; Sun,  1 Dec 2024 02:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733019150; cv=none; b=U0vxVxnrEsZScOruSgOe6Y8coYXsbiWVyz9lH68bBHxKGQ4W/O+auvLN8AINCugY9IdUoieZMwOfnWTTaJgW61+XoSbkPpEG3hdrC8kZihOkqTf34ah3xmm2yY21BFfOdraVGOxknqX7y9eQN4PfoRYqRW3Rr/mYVclKsF3+SN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733019150; c=relaxed/simple;
	bh=J/wUxKYlG07eGTFBQlS196/dCwEk6KnTaQ1aehgqP0g=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Fffe8klvrF2YFVsJdIA6EsLjRhHclJYu/obvb9ORM46EYQmM8tK+GcLKyY9Jd4BYhYZ5ix090vIUwnt0eoKvGPrhaLgQzYa4uC3Eig8XXUH4C6QBuV36aUVimtVW1OoaanCLbIXW3VGzD+GkgAv0/+EdAV7Ug56Agz8Vy5QsObA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=evisfQM+; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733019148; x=1764555148;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=J/wUxKYlG07eGTFBQlS196/dCwEk6KnTaQ1aehgqP0g=;
  b=evisfQM+1NFKehv/35Go+EcYm+meKNqXg0/izE+22p1q06uZEqE4a7sl
   1nHHxwKnrajKXivUo8T81vvCkuk9Xx5w4C27hAQ1OP1MQ5BM+kDboWLPX
   ptYITohShpdA3HhT3YLlG0m9NsaxrPbZ3+lOIS8xeENa3u5l8FokRl9vb
   84FbKgmQiDtIrj4CLaabRXWyy6nlOBgQHDfjg8q340UiriKNr1NslHs0Q
   zvn9R3egPoRhtLbC9ZybzB8pW0pX1yLSttuZ6rEMI3MHp5rHzeIZySupI
   6cn9rPDn035+DuslEZZkH1YwVPdc7xhCH61YLufQSeYGX1iskwBKlE1MK
   g==;
X-CSE-ConnectionGUID: fR8LU4I+QD22B9QYL0g2GA==
X-CSE-MsgGUID: a6A3q0mpR/ybLQ+yza7IQA==
X-IronPort-AV: E=McAfee;i="6700,10204,11272"; a="33449391"
X-IronPort-AV: E=Sophos;i="6.12,199,1728975600"; 
   d="scan'208";a="33449391"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2024 18:12:27 -0800
X-CSE-ConnectionGUID: GK8ZKd5tSsO9v10wVTylXA==
X-CSE-MsgGUID: oZRzBf3cRpaRJVW9T8ZFNQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,199,1728975600"; 
   d="scan'208";a="93246332"
Received: from lkp-server02.sh.intel.com (HELO 36a1563c48ff) ([10.239.97.151])
  by fmviesa009.fm.intel.com with ESMTP; 30 Nov 2024 18:12:25 -0800
Received: from kbuild by 36a1563c48ff with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tHZRf-00018n-21;
	Sun, 01 Dec 2024 02:12:23 +0000
Date: Sun, 1 Dec 2024 10:11:28 +0800
From: kernel test robot <lkp@intel.com>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev,
	"Gustavo A. R. Silva" <gustavo@embeddedor.com>,
	LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars:testing/wfamnae-next20241114 6/22]
 include/linux/compiler_types.h:523:45: error: call to
 '__compiletime_assert_885' declared with attribute error: BUILD_BUG_ON
 failed: conf->keylen < WLAN_KEY_LEN_CCMP
Message-ID: <202412011049.nqm0p1W8-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Gustavo,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git testing/wfamnae-next20241114
head:   ffa0ea7cd2216fa4db0e24844e1675e94b7db1aa
commit: 08dd8b1c450b2e86a7bdaec5e23ff58fcff6ae01 [6/22] wifi: iwlwifi: mvm: Use __counted_by() and avoid -Wfamnae warnings
config: sparc-allmodconfig (https://download.01.org/0day-ci/archive/20241201/202412011049.nqm0p1W8-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241201/202412011049.nqm0p1W8-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412011049.nqm0p1W8-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from <command-line>:
   drivers/net/wireless/intel/iwlwifi/mvm/d3.c: In function 'iwl_mvm_gtk_rekey':
>> include/linux/compiler_types.h:523:45: error: call to '__compiletime_assert_885' declared with attribute error: BUILD_BUG_ON failed: conf->keylen < WLAN_KEY_LEN_CCMP
     523 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |                                             ^
   include/linux/compiler_types.h:504:25: note: in definition of macro '__compiletime_assert'
     504 |                         prefix ## suffix();                             \
         |                         ^~~~~~
   include/linux/compiler_types.h:523:9: note: in expansion of macro '_compiletime_assert'
     523 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:50:9: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      50 |         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
         |         ^~~~~~~~~~~~~~~~
   drivers/net/wireless/intel/iwlwifi/mvm/d3.c:2169:9: note: in expansion of macro 'BUILD_BUG_ON'
    2169 |         BUILD_BUG_ON(conf->keylen < WLAN_KEY_LEN_CCMP);
         |         ^~~~~~~~~~~~
>> include/linux/compiler_types.h:523:45: error: call to '__compiletime_assert_886' declared with attribute error: BUILD_BUG_ON failed: conf->keylen < WLAN_KEY_LEN_GCMP_256
     523 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |                                             ^
   include/linux/compiler_types.h:504:25: note: in definition of macro '__compiletime_assert'
     504 |                         prefix ## suffix();                             \
         |                         ^~~~~~
   include/linux/compiler_types.h:523:9: note: in expansion of macro '_compiletime_assert'
     523 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:50:9: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      50 |         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
         |         ^~~~~~~~~~~~~~~~
   drivers/net/wireless/intel/iwlwifi/mvm/d3.c:2170:9: note: in expansion of macro 'BUILD_BUG_ON'
    2170 |         BUILD_BUG_ON(conf->keylen < WLAN_KEY_LEN_GCMP_256);
         |         ^~~~~~~~~~~~
--
   In file included from <command-line>:
   d3.c: In function 'iwl_mvm_gtk_rekey':
>> include/linux/compiler_types.h:523:45: error: call to '__compiletime_assert_885' declared with attribute error: BUILD_BUG_ON failed: conf->keylen < WLAN_KEY_LEN_CCMP
     523 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |                                             ^
   include/linux/compiler_types.h:504:25: note: in definition of macro '__compiletime_assert'
     504 |                         prefix ## suffix();                             \
         |                         ^~~~~~
   include/linux/compiler_types.h:523:9: note: in expansion of macro '_compiletime_assert'
     523 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:50:9: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      50 |         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
         |         ^~~~~~~~~~~~~~~~
   d3.c:2169:9: note: in expansion of macro 'BUILD_BUG_ON'
    2169 |         BUILD_BUG_ON(conf->keylen < WLAN_KEY_LEN_CCMP);
         |         ^~~~~~~~~~~~
>> include/linux/compiler_types.h:523:45: error: call to '__compiletime_assert_886' declared with attribute error: BUILD_BUG_ON failed: conf->keylen < WLAN_KEY_LEN_GCMP_256
     523 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |                                             ^
   include/linux/compiler_types.h:504:25: note: in definition of macro '__compiletime_assert'
     504 |                         prefix ## suffix();                             \
         |                         ^~~~~~
   include/linux/compiler_types.h:523:9: note: in expansion of macro '_compiletime_assert'
     523 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:50:9: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      50 |         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
         |         ^~~~~~~~~~~~~~~~
   d3.c:2170:9: note: in expansion of macro 'BUILD_BUG_ON'
    2170 |         BUILD_BUG_ON(conf->keylen < WLAN_KEY_LEN_GCMP_256);
         |         ^~~~~~~~~~~~


vim +/__compiletime_assert_885 +523 include/linux/compiler_types.h

eb5c2d4b45e3d2 Will Deacon 2020-07-21  509  
eb5c2d4b45e3d2 Will Deacon 2020-07-21  510  #define _compiletime_assert(condition, msg, prefix, suffix) \
eb5c2d4b45e3d2 Will Deacon 2020-07-21  511  	__compiletime_assert(condition, msg, prefix, suffix)
eb5c2d4b45e3d2 Will Deacon 2020-07-21  512  
eb5c2d4b45e3d2 Will Deacon 2020-07-21  513  /**
eb5c2d4b45e3d2 Will Deacon 2020-07-21  514   * compiletime_assert - break build and emit msg if condition is false
eb5c2d4b45e3d2 Will Deacon 2020-07-21  515   * @condition: a compile-time constant condition to check
eb5c2d4b45e3d2 Will Deacon 2020-07-21  516   * @msg:       a message to emit if condition is false
eb5c2d4b45e3d2 Will Deacon 2020-07-21  517   *
eb5c2d4b45e3d2 Will Deacon 2020-07-21  518   * In tradition of POSIX assert, this macro will break the build if the
eb5c2d4b45e3d2 Will Deacon 2020-07-21  519   * supplied condition is *false*, emitting the supplied error message if the
eb5c2d4b45e3d2 Will Deacon 2020-07-21  520   * compiler has support to do so.
eb5c2d4b45e3d2 Will Deacon 2020-07-21  521   */
eb5c2d4b45e3d2 Will Deacon 2020-07-21  522  #define compiletime_assert(condition, msg) \
eb5c2d4b45e3d2 Will Deacon 2020-07-21 @523  	_compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
eb5c2d4b45e3d2 Will Deacon 2020-07-21  524  

:::::: The code at line 523 was first introduced by commit
:::::: eb5c2d4b45e3d2d5d052ea6b8f1463976b1020d5 compiler.h: Move compiletime_assert() macros into compiler_types.h

:::::: TO: Will Deacon <will@kernel.org>
:::::: CC: Will Deacon <will@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

