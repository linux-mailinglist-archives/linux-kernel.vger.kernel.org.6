Return-Path: <linux-kernel+bounces-262241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3C0B93C2E3
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 15:25:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 489151F21F4B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 13:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7FD719ADBF;
	Thu, 25 Jul 2024 13:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KeKiWINR"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D097016DEA8
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 13:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721913913; cv=none; b=CF2lVRsgiyx5UujuuwDNRgZxIHd9Uxo6xxbpWgjNJBE0RAWTr4zX8P8epRonJ/S3cY5b8xZh8+tfTnWtIKpTvGVB76fzI4uapZhzMhiX4hALOcQ9AtE4wGBSPLGdMCM5nrZW56CGcAAU2dI4b9PgteNq0N8zrmxXYQcgBf2EclA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721913913; c=relaxed/simple;
	bh=FquZqCdRSkWOmjxMsAuK0N+4yE04yJ/Bz7POqAHeIdc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ewzIYd+soimBoOtvvcLLueC+U+7KOAInrDahfZ0eqCyTjy9NG8zSxYxUzDBl0Rv1zioNGcWPzjLjgxeWcUgOSwFDenVt30B95/bbVQGk644cPWR+1jgPaEqWW14kMXQ9igSyWm2s7g38zdQ8zI/HIGT4iJS0lgOwyw9KEcB58NU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KeKiWINR; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721913912; x=1753449912;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FquZqCdRSkWOmjxMsAuK0N+4yE04yJ/Bz7POqAHeIdc=;
  b=KeKiWINRhA5Zv12OJ73HvfLR4ubvYAgE3oS75sB+5fWmy6dST8Gem6WZ
   skcszOzMtaNY7+Rdb189NYzbFlxSsrTY4C8+wnqvF/FdeZOYE9biwjHvj
   0gGYQ3vHm1xN2P5LieQueVF+WP4YcwjS3ecUCftNWCuAK6BmJd0fJv+Iz
   jFQyKVVW6Ng2juR3iVs/msi9OjKo//Vm0R5kGt2fbTduhDs0ujxaHKik0
   XocevByl/3TXWNo/lIyOcG2+GYZUk/0u6ivM3KrIXRBfhooBJDggPRCKS
   YGS8wr0wU3E0Gr2dqxnvQ6fVI46HUouOkAwLfJ+91YmuaXeyoxpyXEzc/
   w==;
X-CSE-ConnectionGUID: +SwLOJzTQZOhOVVxCql/lw==
X-CSE-MsgGUID: QHa/MjTuSjmCmgmh5zVnsQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11144"; a="23457016"
X-IronPort-AV: E=Sophos;i="6.09,236,1716274800"; 
   d="scan'208";a="23457016"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2024 06:25:11 -0700
X-CSE-ConnectionGUID: ciqpoQn/Q5qKsjHNf/Em5A==
X-CSE-MsgGUID: PXLIW9fZRlyg1CN4SKi1mQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,236,1716274800"; 
   d="scan'208";a="53692564"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 25 Jul 2024 06:25:07 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sWySu-000o8m-39;
	Thu, 25 Jul 2024 13:25:04 +0000
Date: Thu, 25 Jul 2024 21:24:09 +0800
From: kernel test robot <lkp@intel.com>
To: David Laight <David.Laight@aculab.com>,
	"'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
	'Linus Torvalds' <torvalds@linuxfoundation.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	"'Matthew Wilcox (Oracle)'" <willy@infradead.org>,
	'Christoph Hellwig' <hch@infradead.org>,
	'Andrew Morton' <akpm@linux-foundation.org>,
	Linux Memory Management List <linux-mm@kvack.org>,
	'Andy Shevchenko' <andriy.shevchenko@linux.intel.com>,
	'Dan Carpenter' <dan.carpenter@linaro.org>,
	'Arnd Bergmann' <arnd@kernel.org>,
	"'Jason@zx2c4.com'" <Jason@zx2c4.com>,
	"'pedro.falcato@gmail.com'" <pedro.falcato@gmail.com>,
	'Mateusz Guzik' <mjguzik@gmail.com>
Subject: Re: [PATCH 4/7] minmax: Simplify signedness check
Message-ID: <202407252100.fDFchC5O-lkp@intel.com>
References: <03601661326c4efba4e618ead15fa0e2@AcuMS.aculab.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <03601661326c4efba4e618ead15fa0e2@AcuMS.aculab.com>

Hi David,

kernel test robot noticed the following build errors:

[auto build test ERROR on linux/master]
[also build test ERROR on linus/master v6.10 next-20240725]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/David-Laight/minmax-Put-all-the-clamp-definitions-together/20240724-224832
base:   linux/master
patch link:    https://lore.kernel.org/r/03601661326c4efba4e618ead15fa0e2%40AcuMS.aculab.com
patch subject: [PATCH 4/7] minmax: Simplify signedness check
config: mips-loongson1b_defconfig (https://download.01.org/0day-ci/archive/20240725/202407252100.fDFchC5O-lkp@intel.com/config)
compiler: clang version 15.0.7 (https://github.com/llvm/llvm-project 8dfdcc7b7bf66834a761bd8de445840ef68e4d1a)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240725/202407252100.fDFchC5O-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202407252100.fDFchC5O-lkp@intel.com/

All errors (new ones prefixed by >>):

>> crypto/skcipher.c:83:9: error: static assertion expression is not an integral constant expression
           return max(start, end_page);
                  ^~~~~~~~~~~~~~~~~~~~
   include/linux/minmax.h:70:19: note: expanded from macro 'max'
   #define max(x, y)       __careful_cmp(max, x, y)
                           ^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/minmax.h:56:3: note: expanded from macro '__careful_cmp'
                   __cmp_once(op, x, y, __UNIQUE_ID(__x), __UNIQUE_ID(__y)))
                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/minmax.h:49:17: note: expanded from macro '__cmp_once'
           _Static_assert(__types_ok(x, y),                        \
                          ^~~~~~~~~~~~~~~~
   include/linux/minmax.h:38:2: note: expanded from macro '__types_ok'
           ((__is_ok_signed(x) && __is_ok_signed(y)) ||    \
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   crypto/skcipher.c:83:9: note: cast that performs the conversions of a reinterpret_cast is not allowed in a constant expression
   include/linux/minmax.h:70:19: note: expanded from macro 'max'
   #define max(x, y)       __careful_cmp(max, x, y)
                           ^
   include/linux/minmax.h:56:3: note: expanded from macro '__careful_cmp'
                   __cmp_once(op, x, y, __UNIQUE_ID(__x), __UNIQUE_ID(__y)))
                   ^
   include/linux/minmax.h:49:17: note: expanded from macro '__cmp_once'
           _Static_assert(__types_ok(x, y),                        \
                          ^
   include/linux/minmax.h:38:4: note: expanded from macro '__types_ok'
           ((__is_ok_signed(x) && __is_ok_signed(y)) ||    \
             ^
   include/linux/minmax.h:34:27: note: expanded from macro '__is_ok_signed'
   #define __is_ok_signed(x) is_signed_type(typeof((x) + 0))
                             ^
   include/linux/compiler.h:273:32: note: expanded from macro 'is_signed_type'
   #define is_signed_type(type) (((type)(-1)) < (__force type)1)
                                  ^
   1 error generated.
--
>> lib/lzo/lzo1x_compress.c:53:33: error: static assertion expression is not an integral constant expression
                           const unsigned char *limit = min(ip_end, ip + MAX_ZERO_RUN_LENGTH + 1);
                                                        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/minmax.h:63:19: note: expanded from macro 'min'
   #define min(x, y)       __careful_cmp(min, x, y)
                           ^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/minmax.h:56:3: note: expanded from macro '__careful_cmp'
                   __cmp_once(op, x, y, __UNIQUE_ID(__x), __UNIQUE_ID(__y)))
                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/minmax.h:49:17: note: expanded from macro '__cmp_once'
           _Static_assert(__types_ok(x, y),                        \
                          ^~~~~~~~~~~~~~~~
   include/linux/minmax.h:38:2: note: expanded from macro '__types_ok'
           ((__is_ok_signed(x) && __is_ok_signed(y)) ||    \
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   lib/lzo/lzo1x_compress.c:53:33: note: cast that performs the conversions of a reinterpret_cast is not allowed in a constant expression
   include/linux/minmax.h:63:19: note: expanded from macro 'min'
   #define min(x, y)       __careful_cmp(min, x, y)
                           ^
   include/linux/minmax.h:56:3: note: expanded from macro '__careful_cmp'
                   __cmp_once(op, x, y, __UNIQUE_ID(__x), __UNIQUE_ID(__y)))
                   ^
   include/linux/minmax.h:49:17: note: expanded from macro '__cmp_once'
           _Static_assert(__types_ok(x, y),                        \
                          ^
   include/linux/minmax.h:38:4: note: expanded from macro '__types_ok'
           ((__is_ok_signed(x) && __is_ok_signed(y)) ||    \
             ^
   include/linux/minmax.h:34:27: note: expanded from macro '__is_ok_signed'
   #define __is_ok_signed(x) is_signed_type(typeof((x) + 0))
                             ^
   include/linux/compiler.h:273:32: note: expanded from macro 'is_signed_type'
   #define is_signed_type(type) (((type)(-1)) < (__force type)1)
                                  ^
   1 error generated.


vim +83 crypto/skcipher.c

b286d8b1a690667 Herbert Xu 2016-11-22  75  
b286d8b1a690667 Herbert Xu 2016-11-22  76  /* Get a spot of the specified length that does not straddle a page.
b286d8b1a690667 Herbert Xu 2016-11-22  77   * The caller needs to ensure that there is enough space for this operation.
b286d8b1a690667 Herbert Xu 2016-11-22  78   */
b286d8b1a690667 Herbert Xu 2016-11-22  79  static inline u8 *skcipher_get_spot(u8 *start, unsigned int len)
b286d8b1a690667 Herbert Xu 2016-11-22  80  {
b286d8b1a690667 Herbert Xu 2016-11-22  81  	u8 *end_page = (u8 *)(((unsigned long)(start + len - 1)) & PAGE_MASK);
b286d8b1a690667 Herbert Xu 2016-11-22  82  
b286d8b1a690667 Herbert Xu 2016-11-22 @83  	return max(start, end_page);
b286d8b1a690667 Herbert Xu 2016-11-22  84  }
b286d8b1a690667 Herbert Xu 2016-11-22  85  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

