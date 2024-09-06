Return-Path: <linux-kernel+bounces-319022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9056B96F695
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 16:22:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2D86B20BBF
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 14:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53AEF156880;
	Fri,  6 Sep 2024 14:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IZQI2tg0"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B81901DFEF
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 14:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725632552; cv=none; b=tar06yxA2eU6+AOqv1hC9Arh1TFFkgiAymCo3NpquuK2NhKovjzLIn6LTmJpiHV8B9tqyft0YxfMHlZI4HbsSCxfqerkZZzGRrqbSbaMHlZDJZs5GcynJOFUxnoEB4KOqJK0D3hdbb3eMmcM1q1r9mAzZUWW1j5po5WYFffWWjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725632552; c=relaxed/simple;
	bh=sRgeBNcKFgMqqkW9Yo1Gps/THyaCysW2AxD8cIFBghU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VDwC3nc6srJCLkK46q+ZY+IbPI8ZkKpFoEmWYcKKK0jGcQ+ytz7C7/k5Kei2ECSJjqJl+P6D0HmYlXpMFH4iqyAUnjM46heTdv4l9fnBMS9Zy8lEcRMpgNREycEzGZz2nXFWqcZ5crssGtObJ07LPwBCjSNRn6+PeVdoXNs+Ky0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IZQI2tg0; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725632549; x=1757168549;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sRgeBNcKFgMqqkW9Yo1Gps/THyaCysW2AxD8cIFBghU=;
  b=IZQI2tg0ohIBC9seq9Y6v/+bcm6Nafwll6XMaQD+dUn3vaXnrDMfas7u
   yzZtlYYYuZG7RaIXKldknu8KkE6rsUWsHVPbxw1dhAH0cnTMh0XJ9B8mW
   Fofr5hXBYUjhwDxYSE20wyLWSsf00+OAnAO6B4jmvfmvMT02MWDaXuT1d
   2lE2rNvusEWkjqmI+K4h1wxlKMeZrOXUSfjyJfeTuL3mLCg0+mg6QZjYz
   9jtWIclE60P9IbVYCCfeRW/VETqI3o1umk4ualBsX3BR5GxDBlMzM5Miw
   oWeap7kFuOHWcLi7JLwElEzSTSC4y98r5M+aVmf1ldCfIMVkDsDhkBRnD
   Q==;
X-CSE-ConnectionGUID: urn9V607RAyD09r6S8NE3Q==
X-CSE-MsgGUID: Da8MOBxgREOvIrEE+qFIpA==
X-IronPort-AV: E=McAfee;i="6700,10204,11187"; a="41901900"
X-IronPort-AV: E=Sophos;i="6.10,208,1719903600"; 
   d="scan'208";a="41901900"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2024 07:22:28 -0700
X-CSE-ConnectionGUID: CdYiCZJrQL2Jf21xiloMmg==
X-CSE-MsgGUID: vpXNwx25Rbeuq4YAUidMsw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,208,1719903600"; 
   d="scan'208";a="66717890"
Received: from lkp-server01.sh.intel.com (HELO 9c6b1c7d3b50) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 06 Sep 2024 07:22:25 -0700
Received: from kbuild by 9c6b1c7d3b50 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1smZqx-000BLX-28;
	Fri, 06 Sep 2024 14:22:23 +0000
Date: Fri, 6 Sep 2024 22:21:24 +0800
From: kernel test robot <lkp@intel.com>
To: Uros Bizjak <ubizjak@gmail.com>, linux-kernel@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Uros Bizjak <ubizjak@gmail.com>, Theodore Ts'o <tytso@mit.edu>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: Re: [PATCH 17/18] random: Do not include <linux/prandom.h>
Message-ID: <202409062123.F3r9hB9z-lkp@intel.com>
References: <20240905122020.872466-18-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240905122020.872466-18-ubizjak@gmail.com>

Hi Uros,

kernel test robot noticed the following build errors:

[auto build test ERROR on akpm-mm/mm-nonmm-unstable]
[also build test ERROR on mtd/mtd/next mtd/mtd/fixes linus/master v6.11-rc6 next-20240906]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Uros-Bizjak/x86-kaslr-Include-linux-prandom-h-instead-of-linux-random-h/20240905-202710
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-nonmm-unstable
patch link:    https://lore.kernel.org/r/20240905122020.872466-18-ubizjak%40gmail.com
patch subject: [PATCH 17/18] random: Do not include <linux/prandom.h>
config: um-randconfig-002-20240906 (https://download.01.org/0day-ci/archive/20240906/202409062123.F3r9hB9z-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 05f5a91d00b02f4369f46d076411c700755ae041)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240906/202409062123.F3r9hB9z-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409062123.F3r9hB9z-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   In file included from crypto/testmgr.c:27:
   In file included from include/linux/scatterlist.h:8:
   In file included from include/linux/mm.h:2228:
   include/linux/vmstat.h:517:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     517 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   In file included from crypto/testmgr.c:27:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/um/include/asm/io.h:24:
   include/asm-generic/io.h:548:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     548 |         val = __raw_readb(PCI_IOBASE + addr);
         |                           ~~~~~~~~~~ ^
   include/asm-generic/io.h:561:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     561 |         val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:37:51: note: expanded from macro '__le16_to_cpu'
      37 | #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
         |                                                   ^
   In file included from crypto/testmgr.c:27:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/um/include/asm/io.h:24:
   include/asm-generic/io.h:574:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     574 |         val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
      35 | #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
         |                                                   ^
   In file included from crypto/testmgr.c:27:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/um/include/asm/io.h:24:
   include/asm-generic/io.h:585:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     585 |         __raw_writeb(value, PCI_IOBASE + addr);
         |                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:595:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     595 |         __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:605:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     605 |         __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:693:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     693 |         readsb(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:701:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     701 |         readsw(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:709:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     709 |         readsl(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:718:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     718 |         writesb(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
   include/asm-generic/io.h:727:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     727 |         writesw(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
   include/asm-generic/io.h:736:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     736 |         writesl(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
>> crypto/testmgr.c:881:42: warning: declaration of 'struct rnd_state' will not be visible outside of this function [-Wvisibility]
     881 | static inline void init_rnd_state(struct rnd_state *rng)
         |                                          ^
>> crypto/testmgr.c:883:2: error: call to undeclared function 'prandom_seed_state'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     883 |         prandom_seed_state(rng, get_random_u64());
         |         ^
   crypto/testmgr.c:886:36: warning: declaration of 'struct rnd_state' will not be visible outside of this function [-Wvisibility]
     886 | static inline u8 prandom_u8(struct rnd_state *rng)
         |                                    ^
>> crypto/testmgr.c:888:9: error: call to undeclared function 'prandom_u32_state'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     888 |         return prandom_u32_state(rng);
         |                ^
   crypto/testmgr.c:891:44: warning: declaration of 'struct rnd_state' will not be visible outside of this function [-Wvisibility]
     891 | static inline u32 prandom_u32_below(struct rnd_state *rng, u32 ceil)
         |                                            ^
   crypto/testmgr.c:897:9: error: call to undeclared function 'prandom_u32_state'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     897 |         return prandom_u32_state(rng) % ceil;
         |                ^
   crypto/testmgr.c:900:40: warning: declaration of 'struct rnd_state' will not be visible outside of this function [-Wvisibility]
     900 | static inline bool prandom_bool(struct rnd_state *rng)
         |                                        ^
>> crypto/testmgr.c:902:27: error: incompatible pointer types passing 'struct rnd_state *' to parameter of type 'struct rnd_state *' [-Werror,-Wincompatible-pointer-types]
     902 |         return prandom_u32_below(rng, 2);
         |                                  ^~~
   crypto/testmgr.c:891:55: note: passing argument to parameter 'rng' here
     891 | static inline u32 prandom_u32_below(struct rnd_state *rng, u32 ceil)
         |                                                       ^
   crypto/testmgr.c:905:48: warning: declaration of 'struct rnd_state' will not be visible outside of this function [-Wvisibility]
     905 | static inline u32 prandom_u32_inclusive(struct rnd_state *rng,
         |                                                ^
   crypto/testmgr.c:908:35: error: incompatible pointer types passing 'struct rnd_state *' to parameter of type 'struct rnd_state *' [-Werror,-Wincompatible-pointer-types]
     908 |         return floor + prandom_u32_below(rng, ceil - floor + 1);
         |                                          ^~~
   crypto/testmgr.c:891:55: note: passing argument to parameter 'rng' here
     891 | static inline u32 prandom_u32_below(struct rnd_state *rng, u32 ceil)
         |                                                       ^
   crypto/testmgr.c:912:51: warning: declaration of 'struct rnd_state' will not be visible outside of this function [-Wvisibility]
     912 | static unsigned int generate_random_length(struct rnd_state *rng,
         |                                                   ^
   crypto/testmgr.c:915:39: error: incompatible pointer types passing 'struct rnd_state *' to parameter of type 'struct rnd_state *' [-Werror,-Wincompatible-pointer-types]
     915 |         unsigned int len = prandom_u32_below(rng, max_len + 1);
         |                                              ^~~
   crypto/testmgr.c:891:55: note: passing argument to parameter 'rng' here
     891 | static inline u32 prandom_u32_below(struct rnd_state *rng, u32 ceil)
         |                                                       ^
   crypto/testmgr.c:917:28: error: incompatible pointer types passing 'struct rnd_state *' to parameter of type 'struct rnd_state *' [-Werror,-Wincompatible-pointer-types]
     917 |         switch (prandom_u32_below(rng, 4)) {
         |                                   ^~~
   crypto/testmgr.c:891:55: note: passing argument to parameter 'rng' here
     891 | static inline u32 prandom_u32_below(struct rnd_state *rng, u32 ceil)
         |                                                       ^
   crypto/testmgr.c:930:31: error: incompatible pointer types passing 'struct rnd_state *' to parameter of type 'struct rnd_state *' [-Werror,-Wincompatible-pointer-types]
     930 |         if (len && prandom_u32_below(rng, 4) == 0)
         |                                      ^~~
   crypto/testmgr.c:891:55: note: passing argument to parameter 'rng' here
     891 | static inline u32 prandom_u32_below(struct rnd_state *rng, u32 ceil)
         |                                                       ^
   crypto/testmgr.c:936:36: warning: declaration of 'struct rnd_state' will not be visible outside of this function [-Wvisibility]
     936 | static void flip_random_bit(struct rnd_state *rng, u8 *buf, size_t size)
         |                                    ^
   crypto/testmgr.c:940:29: error: incompatible pointer types passing 'struct rnd_state *' to parameter of type 'struct rnd_state *' [-Werror,-Wincompatible-pointer-types]
     940 |         bitpos = prandom_u32_below(rng, size * 8);
         |                                    ^~~
   crypto/testmgr.c:891:55: note: passing argument to parameter 'rng' here
     891 | static inline u32 prandom_u32_below(struct rnd_state *rng, u32 ceil)
         |                                                       ^
   crypto/testmgr.c:945:37: warning: declaration of 'struct rnd_state' will not be visible outside of this function [-Wvisibility]
     945 | static void flip_random_byte(struct rnd_state *rng, u8 *buf, size_t size)
         |                                     ^
   crypto/testmgr.c:947:24: error: incompatible pointer types passing 'struct rnd_state *' to parameter of type 'struct rnd_state *' [-Werror,-Wincompatible-pointer-types]
     947 |         buf[prandom_u32_below(rng, size)] ^= 0xff;
         |                               ^~~
   crypto/testmgr.c:891:55: note: passing argument to parameter 'rng' here
     891 | static inline u32 prandom_u32_below(struct rnd_state *rng, u32 ceil)
         |                                                       ^
   crypto/testmgr.c:951:34: warning: declaration of 'struct rnd_state' will not be visible outside of this function [-Wvisibility]
     951 | static void mutate_buffer(struct rnd_state *rng, u8 *buf, size_t size)
         |                                  ^
   crypto/testmgr.c:957:24: error: incompatible pointer types passing 'struct rnd_state *' to parameter of type 'struct rnd_state *' [-Werror,-Wincompatible-pointer-types]
     957 |         if (prandom_u32_below(rng, 4) == 0) {
         |                               ^~~
   crypto/testmgr.c:891:55: note: passing argument to parameter 'rng' here
     891 | static inline u32 prandom_u32_below(struct rnd_state *rng, u32 ceil)
         |                                                       ^
   crypto/testmgr.c:958:52: error: incompatible pointer types passing 'struct rnd_state *' to parameter of type 'struct rnd_state *' [-Werror,-Wincompatible-pointer-types]
     958 |                 num_flips = min_t(size_t, 1 << prandom_u32_below(rng, 8),
         |                                                                  ^~~
   include/linux/minmax.h:213:49: note: expanded from macro 'min_t'
     213 | #define min_t(type, x, y) __cmp_once(min, type, x, y)
         |                                                 ^
   include/linux/minmax.h:96:30: note: expanded from macro '__cmp_once'
      96 |         __cmp_once_unique(op, type, x, y, __UNIQUE_ID(x_), __UNIQUE_ID(y_))
         |                                     ^
   include/linux/minmax.h:93:16: note: expanded from macro '__cmp_once_unique'
      93 |         ({ type ux = (x); type uy = (y); __cmp(op, ux, uy); })
         |                       ^
   crypto/testmgr.c:891:55: note: passing argument to parameter 'rng' here
     891 | static inline u32 prandom_u32_below(struct rnd_state *rng, u32 ceil)
         |                                                       ^
   crypto/testmgr.c:961:20: error: incompatible pointer types passing 'struct rnd_state *' to parameter of type 'struct rnd_state *' [-Werror,-Wincompatible-pointer-types]
     961 |                         flip_random_bit(rng, buf, size);
         |                                         ^~~
   crypto/testmgr.c:936:47: note: passing argument to parameter 'rng' here
     936 | static void flip_random_bit(struct rnd_state *rng, u8 *buf, size_t size)
         |                                               ^
   crypto/testmgr.c:965:24: error: incompatible pointer types passing 'struct rnd_state *' to parameter of type 'struct rnd_state *' [-Werror,-Wincompatible-pointer-types]
     965 |         if (prandom_u32_below(rng, 4) == 0) {
         |                               ^~~
   crypto/testmgr.c:891:55: note: passing argument to parameter 'rng' here
     891 | static inline u32 prandom_u32_below(struct rnd_state *rng, u32 ceil)
         |                                                       ^
   crypto/testmgr.c:966:52: error: incompatible pointer types passing 'struct rnd_state *' to parameter of type 'struct rnd_state *' [-Werror,-Wincompatible-pointer-types]
     966 |                 num_flips = min_t(size_t, 1 << prandom_u32_below(rng, 8), size);
         |                                                                  ^~~
   include/linux/minmax.h:213:49: note: expanded from macro 'min_t'
     213 | #define min_t(type, x, y) __cmp_once(min, type, x, y)
         |                                                 ^
   include/linux/minmax.h:96:30: note: expanded from macro '__cmp_once'
      96 |         __cmp_once_unique(op, type, x, y, __UNIQUE_ID(x_), __UNIQUE_ID(y_))
         |                                     ^
   include/linux/minmax.h:93:16: note: expanded from macro '__cmp_once_unique'
      93 |         ({ type ux = (x); type uy = (y); __cmp(op, ux, uy); })


vim +/prandom_seed_state +883 crypto/testmgr.c

f2bb770ae89641 Eric Biggers 2019-04-11  873  
f900fde2888360 Eric Biggers 2023-02-27  874  /*
f900fde2888360 Eric Biggers 2023-02-27  875   * The fuzz tests use prandom instead of the normal Linux RNG since they don't
f900fde2888360 Eric Biggers 2023-02-27  876   * need cryptographically secure random numbers.  This greatly improves the
f900fde2888360 Eric Biggers 2023-02-27  877   * performance of these tests, especially if they are run before the Linux RNG
f900fde2888360 Eric Biggers 2023-02-27  878   * has been initialized or if they are run on a lockdep-enabled kernel.
f900fde2888360 Eric Biggers 2023-02-27  879   */
f900fde2888360 Eric Biggers 2023-02-27  880  
f900fde2888360 Eric Biggers 2023-02-27 @881  static inline void init_rnd_state(struct rnd_state *rng)
f900fde2888360 Eric Biggers 2023-02-27  882  {
f900fde2888360 Eric Biggers 2023-02-27 @883  	prandom_seed_state(rng, get_random_u64());
f900fde2888360 Eric Biggers 2023-02-27  884  }
f900fde2888360 Eric Biggers 2023-02-27  885  
f900fde2888360 Eric Biggers 2023-02-27  886  static inline u8 prandom_u8(struct rnd_state *rng)
f900fde2888360 Eric Biggers 2023-02-27  887  {
f900fde2888360 Eric Biggers 2023-02-27 @888  	return prandom_u32_state(rng);
f900fde2888360 Eric Biggers 2023-02-27  889  }
f900fde2888360 Eric Biggers 2023-02-27  890  
f900fde2888360 Eric Biggers 2023-02-27 @891  static inline u32 prandom_u32_below(struct rnd_state *rng, u32 ceil)
f900fde2888360 Eric Biggers 2023-02-27  892  {
f900fde2888360 Eric Biggers 2023-02-27  893  	/*
f900fde2888360 Eric Biggers 2023-02-27  894  	 * This is slightly biased for non-power-of-2 values of 'ceil', but this
f900fde2888360 Eric Biggers 2023-02-27  895  	 * isn't important here.
f900fde2888360 Eric Biggers 2023-02-27  896  	 */
f900fde2888360 Eric Biggers 2023-02-27  897  	return prandom_u32_state(rng) % ceil;
f900fde2888360 Eric Biggers 2023-02-27  898  }
f900fde2888360 Eric Biggers 2023-02-27  899  
f900fde2888360 Eric Biggers 2023-02-27  900  static inline bool prandom_bool(struct rnd_state *rng)
f900fde2888360 Eric Biggers 2023-02-27  901  {
f900fde2888360 Eric Biggers 2023-02-27 @902  	return prandom_u32_below(rng, 2);
f900fde2888360 Eric Biggers 2023-02-27  903  }
f900fde2888360 Eric Biggers 2023-02-27  904  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

