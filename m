Return-Path: <linux-kernel+bounces-418734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 180549D64D3
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 21:20:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B29D161818
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 20:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFD171865E7;
	Fri, 22 Nov 2024 20:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fLdSFwLX"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B091176AA1
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 20:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732306818; cv=none; b=Wx0noBvoXdbph8m+M2s35ybbZiJKc+z9T4iE4jiyublST/Gzg1GyrE3UIyAHBQ1BMQZV8D8aXMTYny69dgJVj5vAuql9XfSQ00w461KgbGBa+eIWARNOG7Ncz4hSrCrdX63ag3evwnET/yEvdORtQpRy011hUhltvdAyxuyEAr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732306818; c=relaxed/simple;
	bh=HNDcaOydHm7ucy39Mzb5uU0MWWh26gP81ijOugZ3+Qc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u1LqiZAvmB40Bf4KtlZf8/op7Az3UwdH07NEzto0djYT9ajv31Rxt67zZxaih5zyksXAkRiZnex8ZrKV29+/QG9uuwdEHPu4WQRUrS+H/S97z2WTLtf7CxlkShmwpBEvaPBNykJThq4PqhqMFcJOTuAEJWC8Bd1fsfZPwCNuYwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fLdSFwLX; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732306817; x=1763842817;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HNDcaOydHm7ucy39Mzb5uU0MWWh26gP81ijOugZ3+Qc=;
  b=fLdSFwLX19uJOwRdlxA0DTTAldoafe4q7BNrE5io45QtFVo8SqpDZdNf
   0D1+2aT2CJcBAAxnMhJOFTo6ukzBnCu0uqTJQTkB1x/G2VxkIWPXxdFLb
   t53bQdWH2H9eGElR5asq7r4wKBGNXxmwcj7/26jW8lFe3SC3aDH69BY+j
   fIEE8j5RDC+oAQNwRM1nVjgHS5juXZMXf69ZhQ+IifktPuytKDfeDlD55
   UJOCDVcK7WP+GkmIklOTiSVErSagAL5t9qkTxffDfw2GUzpfSEIuMfu7e
   73TfzFqgfb+5Pszl8j1ENfiWW3Tcb+W0se9X1Z8ORM6TQ/Ve8fb7JKgOu
   g==;
X-CSE-ConnectionGUID: IDdKvHpZSh6U1E/ONUH5qw==
X-CSE-MsgGUID: xrOgI2ORRgK/Rhye/5y1jQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11264"; a="57875263"
X-IronPort-AV: E=Sophos;i="6.12,176,1728975600"; 
   d="scan'208";a="57875263"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2024 12:20:16 -0800
X-CSE-ConnectionGUID: 7igoSp7sSWWh2EGK9MYqjA==
X-CSE-MsgGUID: 2YcHmsClQtSTHrFAFdyOqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,176,1728975600"; 
   d="scan'208";a="113954203"
Received: from lkp-server01.sh.intel.com (HELO 8122d2fc1967) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 22 Nov 2024 12:20:12 -0800
Received: from kbuild by 8122d2fc1967 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tEa8P-0004C7-2s;
	Fri, 22 Nov 2024 20:20:09 +0000
Date: Sat, 23 Nov 2024 04:20:02 +0800
From: kernel test robot <lkp@intel.com>
To: David Laight <David.Laight@aculab.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
Cc: oe-kbuild-all@lists.linux.dev, LKML <linux-kernel@vger.kernel.org>,
	'Arnd Bergmann' <arnd@kernel.org>, 'Jens Axboe' <axboe@kernel.dk>,
	'Matthew Wilcox' <willy@infradead.org>,
	'Christoph Hellwig' <hch@infradead.org>,
	'Andrew Morton' <akpm@linux-foundation.org>,
	Linux Memory Management List <linux-mm@kvack.org>,
	'Andy Shevchenko' <andriy.shevchenko@linux.intel.com>,
	'Dan Carpenter' <dan.carpenter@linaro.org>,
	"'Jason A . Donenfeld'" <Jason@zx2c4.com>,
	"'pedro.falcato@gmail.com'" <pedro.falcato@gmail.com>,
	'Mateusz Guzik' <mjguzik@gmail.com>,
	'Lorenzo Stoakes' <lorenzo.stoakes@oracle.com>
Subject: Re: [PATCH next 6/7] minmax.h: Simplify the variants of clamp()
Message-ID: <202411230458.dhZwh3TT-lkp@intel.com>
References: <8f69f4deac014f558bab186444bac2e8@AcuMS.aculab.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8f69f4deac014f558bab186444bac2e8@AcuMS.aculab.com>

Hi David,

kernel test robot noticed the following build warnings:

[auto build test WARNING on next-20241121]

url:    https://github.com/intel-lab-lkp/linux/commits/David-Laight/minmax-h-Add-whitespace-around-operators-and-after-commas/20241121-152617
base:   next-20241121
patch link:    https://lore.kernel.org/r/8f69f4deac014f558bab186444bac2e8%40AcuMS.aculab.com
patch subject: [PATCH next 6/7] minmax.h: Simplify the variants of clamp()
config: loongarch-allyesconfig (https://download.01.org/0day-ci/archive/20241123/202411230458.dhZwh3TT-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241123/202411230458.dhZwh3TT-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411230458.dhZwh3TT-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/linux/kernel.h:28,
                    from include/linux/cpumask.h:11,
                    from arch/loongarch/include/asm/processor.h:9,
                    from arch/loongarch/include/asm/thread_info.h:15,
                    from include/linux/thread_info.h:60,
                    from include/asm-generic/current.h:6,
                    from ./arch/loongarch/include/generated/asm/current.h:1,
                    from include/linux/sched.h:12,
                    from include/linux/delay.h:13,
                    from drivers/iio/magnetometer/yamaha-yas530.c:27:
   drivers/iio/magnetometer/yamaha-yas530.c: In function 'yas537_measure':
>> include/linux/minmax.h:188:20: warning: overflow in conversion from 'long unsigned int' to 's32' {aka 'int'} changes value from '18446744073709543424' to '-8192' [-Woverflow]
     188 |         type ulo = (lo);                                                        \
         |                    ^
   include/linux/minmax.h:197:9: note: in expansion of macro '__clamp_once'
     197 |         __clamp_once(type, val, lo, hi, __UNIQUE_ID(v_), __UNIQUE_ID(l_), __UNIQUE_ID(h_))
         |         ^~~~~~~~~~~~
   include/linux/minmax.h:233:32: note: in expansion of macro '__careful_clamp'
     233 | #define clamp_val(val, lo, hi) __careful_clamp(typeof(val), val, lo, hi)
         |                                ^~~~~~~~~~~~~~~
   drivers/iio/magnetometer/yamaha-yas530.c:414:25: note: in expansion of macro 'clamp_val'
     414 |                         clamp_val(h[i], -BIT(13), BIT(13) - 1);
         |                         ^~~~~~~~~


vim +188 include/linux/minmax.h

   172	
   173	/**
   174	 * min_not_zero - return the minimum that is _not_ zero, unless both are zero
   175	 * @x: value1
   176	 * @y: value2
   177	 */
   178	#define min_not_zero(x, y) ({			\
   179		typeof(x) __x = (x);			\
   180		typeof(y) __y = (y);			\
   181		__x == 0 ? __y : ((__y == 0) ? __x : min(__x, __y)); })
   182	
   183	#define __clamp(val, lo, hi)	\
   184		((val) >= (hi) ? (hi) : ((val) <= (lo) ? (lo) : (val)))
   185	
   186	#define __clamp_once(type, val, lo, hi, uval, ulo, uhi) ({			\
   187		type uval = (val);							\
 > 188		type ulo = (lo);							\
   189		type uhi = (hi);							\
   190		BUILD_BUG_ON_MSG(statically_true(ulo > uhi),				\
   191			"clamp() low limit " #lo " greater than high limit " #hi);	\
   192		BUILD_BUG_ON_MSG(!__types_ok3(uval, ulo, uhi),				\
   193			"clamp("#val", "#lo", "#hi") signedness error");		\
   194		__clamp(uval, ulo, uhi); })
   195	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

