Return-Path: <linux-kernel+bounces-318936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EA5496F55B
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 15:30:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B81E2282373
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 13:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1978F1CCEDC;
	Fri,  6 Sep 2024 13:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B+MZUrRW"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1104827452
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 13:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725629427; cv=none; b=TqILGU1wsGGWCpAxEhBJdTtaGDaHj3J5xPdNASBERC0/VnHyJ5W5rNTvkO16UZhKgnjsc7yN/OeR6SrmKCaFoC2QZoo5estcWEnG9vQKLDzNxdmZLA7xweukWAIyqku7Zf47pLLqRy1f5A7lGI96yQpWKPbQSkc36Suy2/TSh18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725629427; c=relaxed/simple;
	bh=FedVqIxcJdJe6q0+Ov0foEGRNgWCuLn+aN+bi+wlCfM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RuZDRjh0tNZOWZirpCzACDRF1EYp0hmtk0/JhPD9tCDp+EYMrmvbyI5fLYuEDkb+qjZ2oZUvxUyknWnJW6sc3n1TPn1yy7chroRlT0tKJtvOr/mzJMmdOyDABx6Uo3xdQxnis2earFzkM2/9lNrtp9GMjP47PXwX1FTa3itTFjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B+MZUrRW; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725629424; x=1757165424;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FedVqIxcJdJe6q0+Ov0foEGRNgWCuLn+aN+bi+wlCfM=;
  b=B+MZUrRWKYeZIjVeEWJjgTVCxgcmrFRzhm5tNMqGfuyv01o9fgP7o1XE
   DBQ2nMP0R3p1Hm9Q5SKcSoDFsbV31vCUBsqviboZjHM/ilD6dwgdMrPEY
   47pKkKvzuL8vO0CSRk8MJREWX633pANN5rMlNxT9Fs2snv4WMzVd3/cap
   RVMXtE+DQ1dent7glEu7NwbKse/Hn0tEZfDEtbWbY85BRokWXuM3HVRiq
   02zW54JQNyW6lofZCG3kum7MGLEOVJVyLKejrxbhbq0oedo+jhFk0Xx4F
   bEXDkqZaGSGk9g1eGoHQ2EGFktah9/upMdsR65nf/WaqGkJwW/bLi0x0m
   g==;
X-CSE-ConnectionGUID: iFfRbewdRQmmuS5vDRWfJg==
X-CSE-MsgGUID: 19hj0pSzQnG9FUSjIeF/ng==
X-IronPort-AV: E=McAfee;i="6700,10204,11187"; a="28175521"
X-IronPort-AV: E=Sophos;i="6.10,207,1719903600"; 
   d="scan'208";a="28175521"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2024 06:30:24 -0700
X-CSE-ConnectionGUID: ATQWyoeuQ5qf2SbOG1AoXw==
X-CSE-MsgGUID: FN8pcpVUTcy6oEwz5KYSxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,207,1719903600"; 
   d="scan'208";a="70754969"
Received: from lkp-server01.sh.intel.com (HELO 9c6b1c7d3b50) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 06 Sep 2024 06:30:21 -0700
Received: from kbuild by 9c6b1c7d3b50 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1smZ2Y-000BIN-2x;
	Fri, 06 Sep 2024 13:30:18 +0000
Date: Fri, 6 Sep 2024 21:30:10 +0800
From: kernel test robot <lkp@intel.com>
To: Uros Bizjak <ubizjak@gmail.com>, linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Uros Bizjak <ubizjak@gmail.com>,
	Theodore Ts'o <tytso@mit.edu>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: Re: [PATCH 17/18] random: Do not include <linux/prandom.h>
Message-ID: <202409062005.ue7L87dN-lkp@intel.com>
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
config: arm-randconfig-002-20240906 (https://download.01.org/0day-ci/archive/20240906/202409062005.ue7L87dN-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240906/202409062005.ue7L87dN-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409062005.ue7L87dN-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

>> crypto/testmgr.c:881:42: warning: 'struct rnd_state' declared inside parameter list will not be visible outside of this definition or declaration
     881 | static inline void init_rnd_state(struct rnd_state *rng)
         |                                          ^~~~~~~~~
   crypto/testmgr.c: In function 'init_rnd_state':
>> crypto/testmgr.c:883:9: error: implicit declaration of function 'prandom_seed_state' [-Wimplicit-function-declaration]
     883 |         prandom_seed_state(rng, get_random_u64());
         |         ^~~~~~~~~~~~~~~~~~
   crypto/testmgr.c: At top level:
   crypto/testmgr.c:886:36: warning: 'struct rnd_state' declared inside parameter list will not be visible outside of this definition or declaration
     886 | static inline u8 prandom_u8(struct rnd_state *rng)
         |                                    ^~~~~~~~~
   crypto/testmgr.c: In function 'prandom_u8':
>> crypto/testmgr.c:888:16: error: implicit declaration of function 'prandom_u32_state' [-Wimplicit-function-declaration]
     888 |         return prandom_u32_state(rng);
         |                ^~~~~~~~~~~~~~~~~
   crypto/testmgr.c: At top level:
   crypto/testmgr.c:891:44: warning: 'struct rnd_state' declared inside parameter list will not be visible outside of this definition or declaration
     891 | static inline u32 prandom_u32_below(struct rnd_state *rng, u32 ceil)
         |                                            ^~~~~~~~~
   crypto/testmgr.c:900:40: warning: 'struct rnd_state' declared inside parameter list will not be visible outside of this definition or declaration
     900 | static inline bool prandom_bool(struct rnd_state *rng)
         |                                        ^~~~~~~~~
   crypto/testmgr.c: In function 'prandom_bool':
>> crypto/testmgr.c:902:34: error: passing argument 1 of 'prandom_u32_below' from incompatible pointer type [-Wincompatible-pointer-types]
     902 |         return prandom_u32_below(rng, 2);
         |                                  ^~~
         |                                  |
         |                                  struct rnd_state *
   crypto/testmgr.c:891:55: note: expected 'struct rnd_state *' but argument is of type 'struct rnd_state *'
     891 | static inline u32 prandom_u32_below(struct rnd_state *rng, u32 ceil)
         |                                     ~~~~~~~~~~~~~~~~~~^~~
   crypto/testmgr.c: At top level:
   crypto/testmgr.c:905:48: warning: 'struct rnd_state' declared inside parameter list will not be visible outside of this definition or declaration
     905 | static inline u32 prandom_u32_inclusive(struct rnd_state *rng,
         |                                                ^~~~~~~~~
   crypto/testmgr.c: In function 'prandom_u32_inclusive':
   crypto/testmgr.c:908:42: error: passing argument 1 of 'prandom_u32_below' from incompatible pointer type [-Wincompatible-pointer-types]
     908 |         return floor + prandom_u32_below(rng, ceil - floor + 1);
         |                                          ^~~
         |                                          |
         |                                          struct rnd_state *
   crypto/testmgr.c:891:55: note: expected 'struct rnd_state *' but argument is of type 'struct rnd_state *'
     891 | static inline u32 prandom_u32_below(struct rnd_state *rng, u32 ceil)
         |                                     ~~~~~~~~~~~~~~~~~~^~~
   crypto/testmgr.c: At top level:
   crypto/testmgr.c:912:51: warning: 'struct rnd_state' declared inside parameter list will not be visible outside of this definition or declaration
     912 | static unsigned int generate_random_length(struct rnd_state *rng,
         |                                                   ^~~~~~~~~
   crypto/testmgr.c: In function 'generate_random_length':
   crypto/testmgr.c:915:46: error: passing argument 1 of 'prandom_u32_below' from incompatible pointer type [-Wincompatible-pointer-types]
     915 |         unsigned int len = prandom_u32_below(rng, max_len + 1);
         |                                              ^~~
         |                                              |
         |                                              struct rnd_state *
   crypto/testmgr.c:891:55: note: expected 'struct rnd_state *' but argument is of type 'struct rnd_state *'
     891 | static inline u32 prandom_u32_below(struct rnd_state *rng, u32 ceil)
         |                                     ~~~~~~~~~~~~~~~~~~^~~
   crypto/testmgr.c:917:35: error: passing argument 1 of 'prandom_u32_below' from incompatible pointer type [-Wincompatible-pointer-types]
     917 |         switch (prandom_u32_below(rng, 4)) {
         |                                   ^~~
         |                                   |
         |                                   struct rnd_state *
   crypto/testmgr.c:891:55: note: expected 'struct rnd_state *' but argument is of type 'struct rnd_state *'
     891 | static inline u32 prandom_u32_below(struct rnd_state *rng, u32 ceil)
         |                                     ~~~~~~~~~~~~~~~~~~^~~
   crypto/testmgr.c:930:38: error: passing argument 1 of 'prandom_u32_below' from incompatible pointer type [-Wincompatible-pointer-types]
     930 |         if (len && prandom_u32_below(rng, 4) == 0)
         |                                      ^~~
         |                                      |
         |                                      struct rnd_state *
   crypto/testmgr.c:891:55: note: expected 'struct rnd_state *' but argument is of type 'struct rnd_state *'
     891 | static inline u32 prandom_u32_below(struct rnd_state *rng, u32 ceil)
         |                                     ~~~~~~~~~~~~~~~~~~^~~
   crypto/testmgr.c: At top level:
   crypto/testmgr.c:936:36: warning: 'struct rnd_state' declared inside parameter list will not be visible outside of this definition or declaration
     936 | static void flip_random_bit(struct rnd_state *rng, u8 *buf, size_t size)
         |                                    ^~~~~~~~~
   crypto/testmgr.c: In function 'flip_random_bit':
   crypto/testmgr.c:940:36: error: passing argument 1 of 'prandom_u32_below' from incompatible pointer type [-Wincompatible-pointer-types]
     940 |         bitpos = prandom_u32_below(rng, size * 8);
         |                                    ^~~
         |                                    |
         |                                    struct rnd_state *
   crypto/testmgr.c:891:55: note: expected 'struct rnd_state *' but argument is of type 'struct rnd_state *'
     891 | static inline u32 prandom_u32_below(struct rnd_state *rng, u32 ceil)
         |                                     ~~~~~~~~~~~~~~~~~~^~~
   crypto/testmgr.c: At top level:
   crypto/testmgr.c:945:37: warning: 'struct rnd_state' declared inside parameter list will not be visible outside of this definition or declaration
     945 | static void flip_random_byte(struct rnd_state *rng, u8 *buf, size_t size)
         |                                     ^~~~~~~~~
   crypto/testmgr.c: In function 'flip_random_byte':
   crypto/testmgr.c:947:31: error: passing argument 1 of 'prandom_u32_below' from incompatible pointer type [-Wincompatible-pointer-types]
     947 |         buf[prandom_u32_below(rng, size)] ^= 0xff;
         |                               ^~~
         |                               |
         |                               struct rnd_state *
   crypto/testmgr.c:891:55: note: expected 'struct rnd_state *' but argument is of type 'struct rnd_state *'
     891 | static inline u32 prandom_u32_below(struct rnd_state *rng, u32 ceil)
         |                                     ~~~~~~~~~~~~~~~~~~^~~
   crypto/testmgr.c: At top level:
   crypto/testmgr.c:951:34: warning: 'struct rnd_state' declared inside parameter list will not be visible outside of this definition or declaration
     951 | static void mutate_buffer(struct rnd_state *rng, u8 *buf, size_t size)
         |                                  ^~~~~~~~~
   crypto/testmgr.c: In function 'mutate_buffer':
   crypto/testmgr.c:957:31: error: passing argument 1 of 'prandom_u32_below' from incompatible pointer type [-Wincompatible-pointer-types]
     957 |         if (prandom_u32_below(rng, 4) == 0) {
         |                               ^~~
         |                               |
         |                               struct rnd_state *
   crypto/testmgr.c:891:55: note: expected 'struct rnd_state *' but argument is of type 'struct rnd_state *'
     891 | static inline u32 prandom_u32_below(struct rnd_state *rng, u32 ceil)
         |                                     ~~~~~~~~~~~~~~~~~~^~~
   In file included from include/linux/kernel.h:28,
                    from include/linux/cpumask.h:11,
                    from include/linux/smp.h:13,
                    from include/linux/lockdep.h:14,
                    from include/linux/spinlock.h:63,
                    from include/linux/swait.h:7,
                    from include/linux/completion.h:12,
                    from include/linux/crypto.h:15,
                    from include/crypto/aead.h:13,
                    from crypto/testmgr.c:19:
   crypto/testmgr.c:958:66: error: passing argument 1 of 'prandom_u32_below' from incompatible pointer type [-Wincompatible-pointer-types]
     958 |                 num_flips = min_t(size_t, 1 << prandom_u32_below(rng, 8),
         |                                                                  ^~~
         |                                                                  |
         |                                                                  struct rnd_state *
   include/linux/minmax.h:93:23: note: in definition of macro '__cmp_once_unique'
      93 |         ({ type ux = (x); type uy = (y); __cmp(op, ux, uy); })
         |                       ^
   include/linux/minmax.h:213:27: note: in expansion of macro '__cmp_once'
     213 | #define min_t(type, x, y) __cmp_once(min, type, x, y)
         |                           ^~~~~~~~~~
   crypto/testmgr.c:958:29: note: in expansion of macro 'min_t'
     958 |                 num_flips = min_t(size_t, 1 << prandom_u32_below(rng, 8),
         |                             ^~~~~
   crypto/testmgr.c:891:55: note: expected 'struct rnd_state *' but argument is of type 'struct rnd_state *'
     891 | static inline u32 prandom_u32_below(struct rnd_state *rng, u32 ceil)
         |                                     ~~~~~~~~~~~~~~~~~~^~~
>> crypto/testmgr.c:961:41: error: passing argument 1 of 'flip_random_bit' from incompatible pointer type [-Wincompatible-pointer-types]
     961 |                         flip_random_bit(rng, buf, size);
         |                                         ^~~
         |                                         |
         |                                         struct rnd_state *
   crypto/testmgr.c:936:47: note: expected 'struct rnd_state *' but argument is of type 'struct rnd_state *'
     936 | static void flip_random_bit(struct rnd_state *rng, u8 *buf, size_t size)
         |                             ~~~~~~~~~~~~~~~~~~^~~
   crypto/testmgr.c:965:31: error: passing argument 1 of 'prandom_u32_below' from incompatible pointer type [-Wincompatible-pointer-types]
     965 |         if (prandom_u32_below(rng, 4) == 0) {
         |                               ^~~
         |                               |
         |                               struct rnd_state *
   crypto/testmgr.c:891:55: note: expected 'struct rnd_state *' but argument is of type 'struct rnd_state *'
     891 | static inline u32 prandom_u32_below(struct rnd_state *rng, u32 ceil)
         |                                     ~~~~~~~~~~~~~~~~~~^~~
   crypto/testmgr.c:966:66: error: passing argument 1 of 'prandom_u32_below' from incompatible pointer type [-Wincompatible-pointer-types]
     966 |                 num_flips = min_t(size_t, 1 << prandom_u32_below(rng, 8), size);
         |                                                                  ^~~
         |                                                                  |
         |                                                                  struct rnd_state *
   include/linux/minmax.h:93:23: note: in definition of macro '__cmp_once_unique'
      93 |         ({ type ux = (x); type uy = (y); __cmp(op, ux, uy); })
         |                       ^
   include/linux/minmax.h:213:27: note: in expansion of macro '__cmp_once'
     213 | #define min_t(type, x, y) __cmp_once(min, type, x, y)
         |                           ^~~~~~~~~~
   crypto/testmgr.c:966:29: note: in expansion of macro 'min_t'
     966 |                 num_flips = min_t(size_t, 1 << prandom_u32_below(rng, 8), size);
         |                             ^~~~~
   crypto/testmgr.c:891:55: note: expected 'struct rnd_state *' but argument is of type 'struct rnd_state *'
     891 | static inline u32 prandom_u32_below(struct rnd_state *rng, u32 ceil)
         |                                     ~~~~~~~~~~~~~~~~~~^~~
>> crypto/testmgr.c:968:42: error: passing argument 1 of 'flip_random_byte' from incompatible pointer type [-Wincompatible-pointer-types]
     968 |                         flip_random_byte(rng, buf, size);
         |                                          ^~~
         |                                          |
         |                                          struct rnd_state *
   crypto/testmgr.c:945:48: note: expected 'struct rnd_state *' but argument is of type 'struct rnd_state *'
     945 | static void flip_random_byte(struct rnd_state *rng, u8 *buf, size_t size)
         |                              ~~~~~~~~~~~~~~~~~~^~~
   crypto/testmgr.c: At top level:
   crypto/testmgr.c:973:42: warning: 'struct rnd_state' declared inside parameter list will not be visible outside of this definition or declaration
     973 | static void generate_random_bytes(struct rnd_state *rng, u8 *buf, size_t count)
         |                                          ^~~~~~~~~
   crypto/testmgr.c: In function 'generate_random_bytes':
   crypto/testmgr.c:982:35: error: passing argument 1 of 'prandom_u32_below' from incompatible pointer type [-Wincompatible-pointer-types]
     982 |         switch (prandom_u32_below(rng, 8)) { /* Choose a generation strategy */
         |                                   ^~~
         |                                   |
         |                                   struct rnd_state *
   crypto/testmgr.c:891:55: note: expected 'struct rnd_state *' but argument is of type 'struct rnd_state *'
     891 | static inline u32 prandom_u32_below(struct rnd_state *rng, u32 ceil)
         |                                     ~~~~~~~~~~~~~~~~~~^~~
   crypto/testmgr.c:986:43: error: passing argument 1 of 'prandom_u32_below' from incompatible pointer type [-Wincompatible-pointer-types]
     986 |                 switch (prandom_u32_below(rng, 4)) {
         |                                           ^~~
         |                                           |
         |                                           struct rnd_state *
   crypto/testmgr.c:891:55: note: expected 'struct rnd_state *' but argument is of type 'struct rnd_state *'
     891 | static inline u32 prandom_u32_below(struct rnd_state *rng, u32 ceil)
         |                                     ~~~~~~~~~~~~~~~~~~^~~
>> crypto/testmgr.c:994:40: error: passing argument 1 of 'prandom_u8' from incompatible pointer type [-Wincompatible-pointer-types]
     994 |                         b = prandom_u8(rng);
         |                                        ^~~
         |                                        |
         |                                        struct rnd_state *
   crypto/testmgr.c:886:47: note: expected 'struct rnd_state *' but argument is of type 'struct rnd_state *'
     886 | static inline u8 prandom_u8(struct rnd_state *rng)
         |                             ~~~~~~~~~~~~~~~~~~^~~
>> crypto/testmgr.c:998:31: error: passing argument 1 of 'mutate_buffer' from incompatible pointer type [-Wincompatible-pointer-types]
     998 |                 mutate_buffer(rng, buf, count);
         |                               ^~~
         |                               |
         |                               struct rnd_state *
   crypto/testmgr.c:951:45: note: expected 'struct rnd_state *' but argument is of type 'struct rnd_state *'
     951 | static void mutate_buffer(struct rnd_state *rng, u8 *buf, size_t size)
         |                           ~~~~~~~~~~~~~~~~~~^~~
   crypto/testmgr.c:1002:40: error: passing argument 1 of 'prandom_u8' from incompatible pointer type [-Wincompatible-pointer-types]
    1002 |                 increment = prandom_u8(rng);
         |                                        ^~~
         |                                        |
         |                                        struct rnd_state *
   crypto/testmgr.c:886:47: note: expected 'struct rnd_state *' but argument is of type 'struct rnd_state *'
     886 | static inline u8 prandom_u8(struct rnd_state *rng)
         |                             ~~~~~~~~~~~~~~~~~~^~~
   crypto/testmgr.c:1003:32: error: passing argument 1 of 'prandom_u8' from incompatible pointer type [-Wincompatible-pointer-types]
    1003 |                 b = prandom_u8(rng);
         |                                ^~~
         |                                |
         |                                struct rnd_state *
   crypto/testmgr.c:886:47: note: expected 'struct rnd_state *' but argument is of type 'struct rnd_state *'
     886 | static inline u8 prandom_u8(struct rnd_state *rng)
         |                             ~~~~~~~~~~~~~~~~~~^~~
   crypto/testmgr.c:1006:31: error: passing argument 1 of 'mutate_buffer' from incompatible pointer type [-Wincompatible-pointer-types]
    1006 |                 mutate_buffer(rng, buf, count);
         |                               ^~~
         |                               |
         |                               struct rnd_state *
   crypto/testmgr.c:951:45: note: expected 'struct rnd_state *' but argument is of type 'struct rnd_state *'
     951 | static void mutate_buffer(struct rnd_state *rng, u8 *buf, size_t size)
         |                           ~~~~~~~~~~~~~~~~~~^~~
>> crypto/testmgr.c:1010:17: error: implicit declaration of function 'prandom_bytes_state' [-Wimplicit-function-declaration]
    1010 |                 prandom_bytes_state(rng, buf, count);
         |                 ^~~~~~~~~~~~~~~~~~~
   crypto/testmgr.c: At top level:
   crypto/testmgr.c:1014:51: warning: 'struct rnd_state' declared inside parameter list will not be visible outside of this definition or declaration
    1014 | static char *generate_random_sgl_divisions(struct rnd_state *rng,
         |                                                   ^~~~~~~~~
   crypto/testmgr.c: In function 'generate_random_sgl_divisions':
>> crypto/testmgr.c:1026:64: error: passing argument 1 of 'prandom_bool' from incompatible pointer type [-Wincompatible-pointer-types]
    1026 |                 if (div == &divs[max_divs - 1] || prandom_bool(rng))
         |                                                                ^~~
         |                                                                |
         |                                                                struct rnd_state *
   crypto/testmgr.c:900:51: note: expected 'struct rnd_state *' but argument is of type 'struct rnd_state *'
     900 | static inline bool prandom_bool(struct rnd_state *rng)
         |                                 ~~~~~~~~~~~~~~~~~~^~~
   crypto/testmgr.c:1028:44: error: passing argument 1 of 'prandom_u32_below' from incompatible pointer type [-Wincompatible-pointer-types]
    1028 |                 else if (prandom_u32_below(rng, 4) == 0)
         |                                            ^~~
         |                                            |
         |                                            struct rnd_state *
   crypto/testmgr.c:891:55: note: expected 'struct rnd_state *' but argument is of type 'struct rnd_state *'
     891 | static inline u32 prandom_u32_below(struct rnd_state *rng, u32 ceil)
         |                                     ~~~~~~~~~~~~~~~~~~^~~
>> crypto/testmgr.c:1031:58: error: passing argument 1 of 'prandom_u32_inclusive' from incompatible pointer type [-Wincompatible-pointer-types]
    1031 |                         this_len = prandom_u32_inclusive(rng, 1, remaining);
         |                                                          ^~~
         |                                                          |
         |                                                          struct rnd_state *
   crypto/testmgr.c:905:59: note: expected 'struct rnd_state *' but argument is of type 'struct rnd_state *'
     905 | static inline u32 prandom_u32_inclusive(struct rnd_state *rng,
         |                                         ~~~~~~~~~~~~~~~~~~^~~
   crypto/testmgr.c:1034:39: error: passing argument 1 of 'prandom_u32_below' from incompatible pointer type [-Wincompatible-pointer-types]
    1034 |                 if (prandom_u32_below(rng, 4) == 0)
         |                                       ^~~
         |                                       |
         |                                       struct rnd_state *
   crypto/testmgr.c:891:55: note: expected 'struct rnd_state *' but argument is of type 'struct rnd_state *'
     891 | static inline u32 prandom_u32_below(struct rnd_state *rng, u32 ceil)
         |                                     ~~~~~~~~~~~~~~~~~~^~~
   crypto/testmgr.c:1035:61: error: passing argument 1 of 'prandom_u32_inclusive' from incompatible pointer type [-Wincompatible-pointer-types]
    1035 |                         div->offset = prandom_u32_inclusive(rng,
         |                                                             ^~~
         |                                                             |
         |                                                             struct rnd_state *
   crypto/testmgr.c:905:59: note: expected 'struct rnd_state *' but argument is of type 'struct rnd_state *'
     905 | static inline u32 prandom_u32_inclusive(struct rnd_state *rng,
         |                                         ~~~~~~~~~~~~~~~~~~^~~
   crypto/testmgr.c:1038:39: error: passing argument 1 of 'prandom_bool' from incompatible pointer type [-Wincompatible-pointer-types]
    1038 |                 else if (prandom_bool(rng))
         |                                       ^~~
         |                                       |
         |                                       struct rnd_state *
   crypto/testmgr.c:900:51: note: expected 'struct rnd_state *' but argument is of type 'struct rnd_state *'
     900 | static inline bool prandom_bool(struct rnd_state *rng)
         |                                 ~~~~~~~~~~~~~~~~~~^~~
   crypto/testmgr.c:1039:57: error: passing argument 1 of 'prandom_u32_below' from incompatible pointer type [-Wincompatible-pointer-types]
    1039 |                         div->offset = prandom_u32_below(rng, 32);
         |                                                         ^~~
         |                                                         |
         |                                                         struct rnd_state *
   crypto/testmgr.c:891:55: note: expected 'struct rnd_state *' but argument is of type 'struct rnd_state *'
     891 | static inline u32 prandom_u32_below(struct rnd_state *rng, u32 ceil)
         |                                     ~~~~~~~~~~~~~~~~~~^~~
   crypto/testmgr.c:1041:57: error: passing argument 1 of 'prandom_u32_below' from incompatible pointer type [-Wincompatible-pointer-types]
    1041 |                         div->offset = prandom_u32_below(rng, PAGE_SIZE);
         |                                                         ^~~
         |                                                         |
         |                                                         struct rnd_state *
   crypto/testmgr.c:891:55: note: expected 'struct rnd_state *' but argument is of type 'struct rnd_state *'
     891 | static inline u32 prandom_u32_below(struct rnd_state *rng, u32 ceil)
         |                                     ~~~~~~~~~~~~~~~~~~^~~
   crypto/testmgr.c:1042:39: error: passing argument 1 of 'prandom_u32_below' from incompatible pointer type [-Wincompatible-pointer-types]
    1042 |                 if (prandom_u32_below(rng, 8) == 0)
         |                                       ^~~
         |                                       |
         |                                       struct rnd_state *
   crypto/testmgr.c:891:55: note: expected 'struct rnd_state *' but argument is of type 'struct rnd_state *'
     891 | static inline u32 prandom_u32_below(struct rnd_state *rng, u32 ceil)
         |                                     ~~~~~~~~~~~~~~~~~~^~~
   crypto/testmgr.c:1047:51: error: passing argument 1 of 'prandom_u32_below' from incompatible pointer type [-Wincompatible-pointer-types]
    1047 |                         switch (prandom_u32_below(rng, 4)) {
         |                                                   ^~~
         |                                                   |
         |                                                   struct rnd_state *
   crypto/testmgr.c:891:55: note: expected 'struct rnd_state *' but argument is of type 'struct rnd_state *'
     891 | static inline u32 prandom_u32_below(struct rnd_state *rng, u32 ceil)
         |                                     ~~~~~~~~~~~~~~~~~~^~~
   crypto/testmgr.c:1059:34: error: passing argument 1 of 'prandom_bool' from incompatible pointer type [-Wincompatible-pointer-types]
    1059 |                     prandom_bool(rng))
         |                                  ^~~
         |                                  |
         |                                  struct rnd_state *
   crypto/testmgr.c:900:51: note: expected 'struct rnd_state *' but argument is of type 'struct rnd_state *'
     900 | static inline bool prandom_bool(struct rnd_state *rng)
         |                                 ~~~~~~~~~~~~~~~~~~^~~
   crypto/testmgr.c: At top level:
   crypto/testmgr.c:1094:51: warning: 'struct rnd_state' declared inside parameter list will not be visible outside of this definition or declaration
    1094 | static void generate_random_testvec_config(struct rnd_state *rng,
         |                                                   ^~~~~~~~~
   crypto/testmgr.c: In function 'generate_random_testvec_config':
   crypto/testmgr.c:1107:35: error: passing argument 1 of 'prandom_u32_below' from incompatible pointer type [-Wincompatible-pointer-types]
    1107 |         switch (prandom_u32_below(rng, 4)) {
         |                                   ^~~
         |                                   |
         |                                   struct rnd_state *
   crypto/testmgr.c:891:55: note: expected 'struct rnd_state *' but argument is of type 'struct rnd_state *'
     891 | static inline u32 prandom_u32_below(struct rnd_state *rng, u32 ceil)
         |                                     ~~~~~~~~~~~~~~~~~~^~~
   crypto/testmgr.c:1122:26: error: passing argument 1 of 'prandom_bool' from incompatible pointer type [-Wincompatible-pointer-types]
    1122 |         if (prandom_bool(rng)) {
         |                          ^~~
         |                          |
         |                          struct rnd_state *
   crypto/testmgr.c:900:51: note: expected 'struct rnd_state *' but argument is of type 'struct rnd_state *'
     900 | static inline bool prandom_bool(struct rnd_state *rng)
         |                                 ~~~~~~~~~~~~~~~~~~^~~
   crypto/testmgr.c:1127:35: error: passing argument 1 of 'prandom_u32_below' from incompatible pointer type [-Wincompatible-pointer-types]
    1127 |         switch (prandom_u32_below(rng, 4)) {
         |                                   ^~~
         |                                   |
         |                                   struct rnd_state *
   crypto/testmgr.c:891:55: note: expected 'struct rnd_state *' but argument is of type 'struct rnd_state *'
     891 | static inline u32 prandom_u32_below(struct rnd_state *rng, u32 ceil)
         |                                     ~~~~~~~~~~~~~~~~~~^~~
   crypto/testmgr.c:1143:34: error: passing argument 1 of 'prandom_bool' from incompatible pointer type [-Wincompatible-pointer-types]
    1143 |                 if (prandom_bool(rng)) {
         |                                  ^~~
         |                                  |
         |                                  struct rnd_state *
   crypto/testmgr.c:900:51: note: expected 'struct rnd_state *' but argument is of type 'struct rnd_state *'
     900 | static inline bool prandom_bool(struct rnd_state *rng)
         |                                 ~~~~~~~~~~~~~~~~~~^~~
   crypto/testmgr.c:1147:34: error: passing argument 1 of 'prandom_bool' from incompatible pointer type [-Wincompatible-pointer-types]
    1147 |                 if (prandom_bool(rng)) {
         |                                  ^~~
         |                                  |
         |                                  struct rnd_state *
   crypto/testmgr.c:900:51: note: expected 'struct rnd_state *' but argument is of type 'struct rnd_state *'
     900 | static inline bool prandom_bool(struct rnd_state *rng)
         |                                 ~~~~~~~~~~~~~~~~~~^~~
>> crypto/testmgr.c:1154:43: error: passing argument 1 of 'generate_random_sgl_divisions' from incompatible pointer type [-Wincompatible-pointer-types]
    1154 |         p = generate_random_sgl_divisions(rng, cfg->src_divs,
         |                                           ^~~
         |                                           |
         |                                           struct rnd_state *
   crypto/testmgr.c:1014:62: note: expected 'struct rnd_state *' but argument is of type 'struct rnd_state *'
    1014 | static char *generate_random_sgl_divisions(struct rnd_state *rng,
         |                                            ~~~~~~~~~~~~~~~~~~^~~
   crypto/testmgr.c:1161:63: error: passing argument 1 of 'prandom_bool' from incompatible pointer type [-Wincompatible-pointer-types]
    1161 |         if (cfg->inplace_mode == OUT_OF_PLACE && prandom_bool(rng)) {
         |                                                               ^~~
         |                                                               |
         |                                                               struct rnd_state *
   crypto/testmgr.c:900:51: note: expected 'struct rnd_state *' but argument is of type 'struct rnd_state *'
     900 | static inline bool prandom_bool(struct rnd_state *rng)
         |                                 ~~~~~~~~~~~~~~~~~~^~~
   crypto/testmgr.c:1163:51: error: passing argument 1 of 'generate_random_sgl_divisions' from incompatible pointer type [-Wincompatible-pointer-types]
    1163 |                 p = generate_random_sgl_divisions(rng, cfg->dst_divs,
         |                                                   ^~~
         |                                                   |
         |                                                   struct rnd_state *
   crypto/testmgr.c:1014:62: note: expected 'struct rnd_state *' but argument is of type 'struct rnd_state *'
    1014 | static char *generate_random_sgl_divisions(struct rnd_state *rng,
         |                                            ~~~~~~~~~~~~~~~~~~^~~
   crypto/testmgr.c:1170:26: error: passing argument 1 of 'prandom_bool' from incompatible pointer type [-Wincompatible-pointer-types]
    1170 |         if (prandom_bool(rng)) {
         |                          ^~~
         |                          |
         |                          struct rnd_state *
   crypto/testmgr.c:900:51: note: expected 'struct rnd_state *' but argument is of type 'struct rnd_state *'
     900 | static inline bool prandom_bool(struct rnd_state *rng)
         |                                 ~~~~~~~~~~~~~~~~~~^~~
   crypto/testmgr.c:1171:56: error: passing argument 1 of 'prandom_u32_inclusive' from incompatible pointer type [-Wincompatible-pointer-types]
    1171 |                 cfg->iv_offset = prandom_u32_inclusive(rng, 1,
         |                                                        ^~~
         |                                                        |
         |                                                        struct rnd_state *
   crypto/testmgr.c:905:59: note: expected 'struct rnd_state *' but argument is of type 'struct rnd_state *'
     905 | static inline u32 prandom_u32_inclusive(struct rnd_state *rng,
         |                                         ~~~~~~~~~~~~~~~~~~^~~
   crypto/testmgr.c:1176:26: error: passing argument 1 of 'prandom_bool' from incompatible pointer type [-Wincompatible-pointer-types]
    1176 |         if (prandom_bool(rng)) {
         |                          ^~~
         |                          |
         |                          struct rnd_state *
   crypto/testmgr.c:900:51: note: expected 'struct rnd_state *' but argument is of type 'struct rnd_state *'
     900 | static inline bool prandom_bool(struct rnd_state *rng)
         |                                 ~~~~~~~~~~~~~~~~~~^~~
   crypto/testmgr.c:1177:57: error: passing argument 1 of 'prandom_u32_inclusive' from incompatible pointer type [-Wincompatible-pointer-types]
    1177 |                 cfg->key_offset = prandom_u32_inclusive(rng, 1,
         |                                                         ^~~
         |                                                         |
         |                                                         struct rnd_state *
   crypto/testmgr.c:905:59: note: expected 'struct rnd_state *' but argument is of type 'struct rnd_state *'
     905 | static inline u32 prandom_u32_inclusive(struct rnd_state *rng,
         |                                         ~~~~~~~~~~~~~~~~~~^~~
   crypto/testmgr.c: In function 'test_hash_vec':
>> crypto/testmgr.c:1689:34: error: storage size of 'rng' isn't known
    1689 |                 struct rnd_state rng;
         |                                  ^~~
>> crypto/testmgr.c:1689:34: warning: unused variable 'rng' [-Wunused-variable]
   crypto/testmgr.c: At top level:
   crypto/testmgr.c:1714:49: warning: 'struct rnd_state' declared inside parameter list will not be visible outside of this definition or declaration
    1714 | static void generate_random_hash_testvec(struct rnd_state *rng,
         |                                                 ^~~~~~~~~
   crypto/testmgr.c: In function 'generate_random_hash_testvec':
>> crypto/testmgr.c:1722:45: error: passing argument 1 of 'generate_random_length' from incompatible pointer type [-Wincompatible-pointer-types]
    1722 |         vec->psize = generate_random_length(rng, maxdatasize);
         |                                             ^~~
         |                                             |
         |                                             struct rnd_state *
   crypto/testmgr.c:912:62: note: expected 'struct rnd_state *' but argument is of type 'struct rnd_state *'
     912 | static unsigned int generate_random_length(struct rnd_state *rng,
         |                                            ~~~~~~~~~~~~~~~~~~^~~
>> crypto/testmgr.c:1723:31: error: passing argument 1 of 'generate_random_bytes' from incompatible pointer type [-Wincompatible-pointer-types]
    1723 |         generate_random_bytes(rng, (u8 *)vec->plaintext, vec->psize);
         |                               ^~~
         |                               |
         |                               struct rnd_state *
   crypto/testmgr.c:973:53: note: expected 'struct rnd_state *' but argument is of type 'struct rnd_state *'
     973 | static void generate_random_bytes(struct rnd_state *rng, u8 *buf, size_t count)
         |                                   ~~~~~~~~~~~~~~~~~~^~~
   crypto/testmgr.c:1733:39: error: passing argument 1 of 'prandom_u32_below' from incompatible pointer type [-Wincompatible-pointer-types]
    1733 |                 if (prandom_u32_below(rng, 4) == 0)
         |                                       ^~~
         |                                       |
         |                                       struct rnd_state *
   crypto/testmgr.c:891:55: note: expected 'struct rnd_state *' but argument is of type 'struct rnd_state *'
     891 | static inline u32 prandom_u32_below(struct rnd_state *rng, u32 ceil)
         |                                     ~~~~~~~~~~~~~~~~~~^~~
   crypto/testmgr.c:1734:60: error: passing argument 1 of 'prandom_u32_inclusive' from incompatible pointer type [-Wincompatible-pointer-types]
    1734 |                         vec->ksize = prandom_u32_inclusive(rng, 1, maxkeysize);
         |                                                            ^~~
         |                                                            |
         |                                                            struct rnd_state *
   crypto/testmgr.c:905:59: note: expected 'struct rnd_state *' but argument is of type 'struct rnd_state *'
     905 | static inline u32 prandom_u32_inclusive(struct rnd_state *rng,
         |                                         ~~~~~~~~~~~~~~~~~~^~~
   crypto/testmgr.c:1735:39: error: passing argument 1 of 'generate_random_bytes' from incompatible pointer type [-Wincompatible-pointer-types]
    1735 |                 generate_random_bytes(rng, (u8 *)vec->key, vec->ksize);
         |                                       ^~~
         |                                       |
         |                                       struct rnd_state *
   crypto/testmgr.c:973:53: note: expected 'struct rnd_state *' but argument is of type 'struct rnd_state *'
     973 | static void generate_random_bytes(struct rnd_state *rng, u8 *buf, size_t count)
         |                                   ~~~~~~~~~~~~~~~~~~^~~
   crypto/testmgr.c: In function 'test_hash_vs_generic_impl':
   crypto/testmgr.c:1769:26: error: storage size of 'rng' isn't known
    1769 |         struct rnd_state rng;
         |                          ^~~
   crypto/testmgr.c:1769:26: warning: unused variable 'rng' [-Wunused-variable]
   crypto/testmgr.c: In function 'test_aead_vec':
   crypto/testmgr.c:2259:34: error: storage size of 'rng' isn't known
    2259 |                 struct rnd_state rng;
         |                                  ^~~
   crypto/testmgr.c:2259:34: warning: unused variable 'rng' [-Wunused-variable]
   crypto/testmgr.c: At top level:
>> crypto/testmgr.c:2282:26: error: field 'rng' has incomplete type
    2282 |         struct rnd_state rng;
         |                          ^~~
   crypto/testmgr.c: In function 'mutate_aead_message':
   crypto/testmgr.c:2308:26: error: passing argument 1 of 'prandom_bool' from incompatible pointer type [-Wincompatible-pointer-types]
    2308 |         if (prandom_bool(rng) && vec->alen > aad_tail_size) {
         |                          ^~~
         |                          |
         |                          struct rnd_state *
   crypto/testmgr.c:900:51: note: expected 'struct rnd_state *' but argument is of type 'struct rnd_state *'
     900 | static inline bool prandom_bool(struct rnd_state *rng)
         |                                 ~~~~~~~~~~~~~~~~~~^~~
   crypto/testmgr.c:2310:33: error: passing argument 1 of 'flip_random_bit' from incompatible pointer type [-Wincompatible-pointer-types]
    2310 |                 flip_random_bit(rng, (u8 *)vec->assoc,
         |                                 ^~~
         |                                 |
         |                                 struct rnd_state *
   crypto/testmgr.c:936:47: note: expected 'struct rnd_state *' but argument is of type 'struct rnd_state *'
     936 | static void flip_random_bit(struct rnd_state *rng, u8 *buf, size_t size)
         |                             ~~~~~~~~~~~~~~~~~~^~~
   crypto/testmgr.c:2312:34: error: passing argument 1 of 'prandom_bool' from incompatible pointer type [-Wincompatible-pointer-types]
    2312 |                 if (prandom_bool(rng))
         |                                  ^~~
         |                                  |
         |                                  struct rnd_state *
   crypto/testmgr.c:900:51: note: expected 'struct rnd_state *' but argument is of type 'struct rnd_state *'
     900 | static inline bool prandom_bool(struct rnd_state *rng)
         |                                 ~~~~~~~~~~~~~~~~~~^~~
   crypto/testmgr.c:2315:26: error: passing argument 1 of 'prandom_bool' from incompatible pointer type [-Wincompatible-pointer-types]
    2315 |         if (prandom_bool(rng)) {
         |                          ^~~
         |                          |
         |                          struct rnd_state *
   crypto/testmgr.c:900:51: note: expected 'struct rnd_state *' but argument is of type 'struct rnd_state *'
     900 | static inline bool prandom_bool(struct rnd_state *rng)
         |                                 ~~~~~~~~~~~~~~~~~~^~~
   crypto/testmgr.c:2317:33: error: passing argument 1 of 'flip_random_bit' from incompatible pointer type [-Wincompatible-pointer-types]
    2317 |                 flip_random_bit(rng, (u8 *)vec->ctext + vec->plen, authsize);
         |                                 ^~~
         |                                 |
         |                                 struct rnd_state *
   crypto/testmgr.c:936:47: note: expected 'struct rnd_state *' but argument is of type 'struct rnd_state *'
     936 | static void flip_random_bit(struct rnd_state *rng, u8 *buf, size_t size)
         |                             ~~~~~~~~~~~~~~~~~~^~~
   crypto/testmgr.c:2320:33: error: passing argument 1 of 'flip_random_bit' from incompatible pointer type [-Wincompatible-pointer-types]
    2320 |                 flip_random_bit(rng, (u8 *)vec->ctext, vec->clen);
         |                                 ^~~
         |                                 |
         |                                 struct rnd_state *
   crypto/testmgr.c:936:47: note: expected 'struct rnd_state *' but argument is of type 'struct rnd_state *'
     936 | static void flip_random_bit(struct rnd_state *rng, u8 *buf, size_t size)
         |                             ~~~~~~~~~~~~~~~~~~^~~
   crypto/testmgr.c: In function 'generate_aead_message':
   crypto/testmgr.c:2342:53: error: passing argument 1 of 'prandom_u32_below' from incompatible pointer type [-Wincompatible-pointer-types]
    2342 |                                   prandom_u32_below(rng, 4) == 0);
         |                                                     ^~~
         |                                                     |
         |                                                     struct rnd_state *
   crypto/testmgr.c:891:55: note: expected 'struct rnd_state *' but argument is of type 'struct rnd_state *'
     891 | static inline u32 prandom_u32_below(struct rnd_state *rng, u32 ceil)
         |                                     ~~~~~~~~~~~~~~~~~~^~~
   crypto/testmgr.c:2345:31: error: passing argument 1 of 'generate_random_bytes' from incompatible pointer type [-Wincompatible-pointer-types]
    2345 |         generate_random_bytes(rng, (u8 *)vec->assoc, vec->alen);
         |                               ^~~
         |                               |
         |                               struct rnd_state *
   crypto/testmgr.c:973:53: note: expected 'struct rnd_state *' but argument is of type 'struct rnd_state *'
     973 | static void generate_random_bytes(struct rnd_state *rng, u8 *buf, size_t count)
         |                                   ~~~~~~~~~~~~~~~~~~^~~
   crypto/testmgr.c:2350:41: error: passing argument 1 of 'prandom_bool' from incompatible pointer type [-Wincompatible-pointer-types]
    2350 |         if (inauthentic && prandom_bool(rng)) {
         |                                         ^~~
         |                                         |
         |                                         struct rnd_state *
   crypto/testmgr.c:900:51: note: expected 'struct rnd_state *' but argument is of type 'struct rnd_state *'
     900 | static inline bool prandom_bool(struct rnd_state *rng)
         |                                 ~~~~~~~~~~~~~~~~~~^~~
   crypto/testmgr.c:2352:39: error: passing argument 1 of 'generate_random_bytes' from incompatible pointer type [-Wincompatible-pointer-types]
    2352 |                 generate_random_bytes(rng, (u8 *)vec->ctext, vec->clen);
         |                                       ^~~
         |                                       |
         |                                       struct rnd_state *
   crypto/testmgr.c:973:53: note: expected 'struct rnd_state *' but argument is of type 'struct rnd_state *'
     973 | static void generate_random_bytes(struct rnd_state *rng, u8 *buf, size_t count)
         |                                   ~~~~~~~~~~~~~~~~~~^~~
   crypto/testmgr.c:2364:47: error: passing argument 1 of 'generate_random_bytes' from incompatible pointer type [-Wincompatible-pointer-types]
    2364 |                         generate_random_bytes(rng, (u8 *)vec->ptext, vec->plen);
         |                                               ^~~
         |                                               |
         |                                               struct rnd_state *
   crypto/testmgr.c:973:53: note: expected 'struct rnd_state *' but argument is of type 'struct rnd_state *'
     973 | static void generate_random_bytes(struct rnd_state *rng, u8 *buf, size_t count)
         |                                   ~~~~~~~~~~~~~~~~~~^~~
   crypto/testmgr.c: In function 'generate_random_aead_testvec':
   crypto/testmgr.c:2415:31: error: passing argument 1 of 'prandom_u32_below' from incompatible pointer type [-Wincompatible-pointer-types]
    2415 |         if (prandom_u32_below(rng, 4) == 0)
         |                               ^~~
         |                               |
         |                               struct rnd_state *
   crypto/testmgr.c:891:55: note: expected 'struct rnd_state *' but argument is of type 'struct rnd_state *'
     891 | static inline u32 prandom_u32_below(struct rnd_state *rng, u32 ceil)


vim +/prandom_seed_state +883 crypto/testmgr.c

f2bb770ae89641 Eric Biggers 2019-04-11   873  
f900fde2888360 Eric Biggers 2023-02-27   874  /*
f900fde2888360 Eric Biggers 2023-02-27   875   * The fuzz tests use prandom instead of the normal Linux RNG since they don't
f900fde2888360 Eric Biggers 2023-02-27   876   * need cryptographically secure random numbers.  This greatly improves the
f900fde2888360 Eric Biggers 2023-02-27   877   * performance of these tests, especially if they are run before the Linux RNG
f900fde2888360 Eric Biggers 2023-02-27   878   * has been initialized or if they are run on a lockdep-enabled kernel.
f900fde2888360 Eric Biggers 2023-02-27   879   */
f900fde2888360 Eric Biggers 2023-02-27   880  
f900fde2888360 Eric Biggers 2023-02-27  @881  static inline void init_rnd_state(struct rnd_state *rng)
f900fde2888360 Eric Biggers 2023-02-27   882  {
f900fde2888360 Eric Biggers 2023-02-27  @883  	prandom_seed_state(rng, get_random_u64());
f900fde2888360 Eric Biggers 2023-02-27   884  }
f900fde2888360 Eric Biggers 2023-02-27   885  
f900fde2888360 Eric Biggers 2023-02-27   886  static inline u8 prandom_u8(struct rnd_state *rng)
f900fde2888360 Eric Biggers 2023-02-27   887  {
f900fde2888360 Eric Biggers 2023-02-27  @888  	return prandom_u32_state(rng);
f900fde2888360 Eric Biggers 2023-02-27   889  }
f900fde2888360 Eric Biggers 2023-02-27   890  
f900fde2888360 Eric Biggers 2023-02-27  @891  static inline u32 prandom_u32_below(struct rnd_state *rng, u32 ceil)
f900fde2888360 Eric Biggers 2023-02-27   892  {
f900fde2888360 Eric Biggers 2023-02-27   893  	/*
f900fde2888360 Eric Biggers 2023-02-27   894  	 * This is slightly biased for non-power-of-2 values of 'ceil', but this
f900fde2888360 Eric Biggers 2023-02-27   895  	 * isn't important here.
f900fde2888360 Eric Biggers 2023-02-27   896  	 */
f900fde2888360 Eric Biggers 2023-02-27   897  	return prandom_u32_state(rng) % ceil;
f900fde2888360 Eric Biggers 2023-02-27   898  }
f900fde2888360 Eric Biggers 2023-02-27   899  
f900fde2888360 Eric Biggers 2023-02-27   900  static inline bool prandom_bool(struct rnd_state *rng)
f900fde2888360 Eric Biggers 2023-02-27   901  {
f900fde2888360 Eric Biggers 2023-02-27  @902  	return prandom_u32_below(rng, 2);
f900fde2888360 Eric Biggers 2023-02-27   903  }
f900fde2888360 Eric Biggers 2023-02-27   904  
f900fde2888360 Eric Biggers 2023-02-27  @905  static inline u32 prandom_u32_inclusive(struct rnd_state *rng,
f900fde2888360 Eric Biggers 2023-02-27   906  					u32 floor, u32 ceil)
f900fde2888360 Eric Biggers 2023-02-27   907  {
f900fde2888360 Eric Biggers 2023-02-27   908  	return floor + prandom_u32_below(rng, ceil - floor + 1);
f900fde2888360 Eric Biggers 2023-02-27   909  }
f900fde2888360 Eric Biggers 2023-02-27   910  
f2bb770ae89641 Eric Biggers 2019-04-11   911  /* Generate a random length in range [0, max_len], but prefer smaller values */
f900fde2888360 Eric Biggers 2023-02-27   912  static unsigned int generate_random_length(struct rnd_state *rng,
f900fde2888360 Eric Biggers 2023-02-27   913  					   unsigned int max_len)
f2bb770ae89641 Eric Biggers 2019-04-11   914  {
f900fde2888360 Eric Biggers 2023-02-27   915  	unsigned int len = prandom_u32_below(rng, max_len + 1);
f2bb770ae89641 Eric Biggers 2019-04-11   916  
f900fde2888360 Eric Biggers 2023-02-27   917  	switch (prandom_u32_below(rng, 4)) {
f2bb770ae89641 Eric Biggers 2019-04-11   918  	case 0:
101e99c23af946 Eric Biggers 2024-07-03   919  		len %= 64;
101e99c23af946 Eric Biggers 2024-07-03   920  		break;
f2bb770ae89641 Eric Biggers 2019-04-11   921  	case 1:
101e99c23af946 Eric Biggers 2024-07-03   922  		len %= 256;
101e99c23af946 Eric Biggers 2024-07-03   923  		break;
f2bb770ae89641 Eric Biggers 2019-04-11   924  	case 2:
101e99c23af946 Eric Biggers 2024-07-03   925  		len %= 1024;
101e99c23af946 Eric Biggers 2024-07-03   926  		break;
f2bb770ae89641 Eric Biggers 2019-04-11   927  	default:
101e99c23af946 Eric Biggers 2024-07-03   928  		break;
f2bb770ae89641 Eric Biggers 2019-04-11   929  	}
101e99c23af946 Eric Biggers 2024-07-03   930  	if (len && prandom_u32_below(rng, 4) == 0)
101e99c23af946 Eric Biggers 2024-07-03   931  		len = rounddown_pow_of_two(len);
101e99c23af946 Eric Biggers 2024-07-03   932  	return len;
f2bb770ae89641 Eric Biggers 2019-04-11   933  }
f2bb770ae89641 Eric Biggers 2019-04-11   934  
49763fc6b1af42 Eric Biggers 2019-12-01   935  /* Flip a random bit in the given nonempty data buffer */
f900fde2888360 Eric Biggers 2023-02-27   936  static void flip_random_bit(struct rnd_state *rng, u8 *buf, size_t size)
49763fc6b1af42 Eric Biggers 2019-12-01   937  {
49763fc6b1af42 Eric Biggers 2019-12-01   938  	size_t bitpos;
49763fc6b1af42 Eric Biggers 2019-12-01   939  
f900fde2888360 Eric Biggers 2023-02-27   940  	bitpos = prandom_u32_below(rng, size * 8);
49763fc6b1af42 Eric Biggers 2019-12-01   941  	buf[bitpos / 8] ^= 1 << (bitpos % 8);
49763fc6b1af42 Eric Biggers 2019-12-01   942  }
49763fc6b1af42 Eric Biggers 2019-12-01   943  
49763fc6b1af42 Eric Biggers 2019-12-01   944  /* Flip a random byte in the given nonempty data buffer */
f900fde2888360 Eric Biggers 2023-02-27   945  static void flip_random_byte(struct rnd_state *rng, u8 *buf, size_t size)
49763fc6b1af42 Eric Biggers 2019-12-01   946  {
f900fde2888360 Eric Biggers 2023-02-27   947  	buf[prandom_u32_below(rng, size)] ^= 0xff;
49763fc6b1af42 Eric Biggers 2019-12-01   948  }
49763fc6b1af42 Eric Biggers 2019-12-01   949  
49763fc6b1af42 Eric Biggers 2019-12-01   950  /* Sometimes make some random changes to the given nonempty data buffer */
f900fde2888360 Eric Biggers 2023-02-27   951  static void mutate_buffer(struct rnd_state *rng, u8 *buf, size_t size)
f2bb770ae89641 Eric Biggers 2019-04-11   952  {
f2bb770ae89641 Eric Biggers 2019-04-11   953  	size_t num_flips;
f2bb770ae89641 Eric Biggers 2019-04-11   954  	size_t i;
f2bb770ae89641 Eric Biggers 2019-04-11   955  
f2bb770ae89641 Eric Biggers 2019-04-11   956  	/* Sometimes flip some bits */
f900fde2888360 Eric Biggers 2023-02-27   957  	if (prandom_u32_below(rng, 4) == 0) {
f900fde2888360 Eric Biggers 2023-02-27  @958  		num_flips = min_t(size_t, 1 << prandom_u32_below(rng, 8),
f900fde2888360 Eric Biggers 2023-02-27   959  				  size * 8);
49763fc6b1af42 Eric Biggers 2019-12-01   960  		for (i = 0; i < num_flips; i++)
f900fde2888360 Eric Biggers 2023-02-27  @961  			flip_random_bit(rng, buf, size);
f2bb770ae89641 Eric Biggers 2019-04-11   962  	}
f2bb770ae89641 Eric Biggers 2019-04-11   963  
f2bb770ae89641 Eric Biggers 2019-04-11   964  	/* Sometimes flip some bytes */
f900fde2888360 Eric Biggers 2023-02-27   965  	if (prandom_u32_below(rng, 4) == 0) {
f900fde2888360 Eric Biggers 2023-02-27  @966  		num_flips = min_t(size_t, 1 << prandom_u32_below(rng, 8), size);
f2bb770ae89641 Eric Biggers 2019-04-11   967  		for (i = 0; i < num_flips; i++)
f900fde2888360 Eric Biggers 2023-02-27  @968  			flip_random_byte(rng, buf, size);
f2bb770ae89641 Eric Biggers 2019-04-11   969  	}
f2bb770ae89641 Eric Biggers 2019-04-11   970  }
f2bb770ae89641 Eric Biggers 2019-04-11   971  
f2bb770ae89641 Eric Biggers 2019-04-11   972  /* Randomly generate 'count' bytes, but sometimes make them "interesting" */
f900fde2888360 Eric Biggers 2023-02-27   973  static void generate_random_bytes(struct rnd_state *rng, u8 *buf, size_t count)
f2bb770ae89641 Eric Biggers 2019-04-11   974  {
f2bb770ae89641 Eric Biggers 2019-04-11   975  	u8 b;
f2bb770ae89641 Eric Biggers 2019-04-11   976  	u8 increment;
f2bb770ae89641 Eric Biggers 2019-04-11   977  	size_t i;
f2bb770ae89641 Eric Biggers 2019-04-11   978  
f2bb770ae89641 Eric Biggers 2019-04-11   979  	if (count == 0)
f2bb770ae89641 Eric Biggers 2019-04-11   980  		return;
f2bb770ae89641 Eric Biggers 2019-04-11   981  
f900fde2888360 Eric Biggers 2023-02-27   982  	switch (prandom_u32_below(rng, 8)) { /* Choose a generation strategy */
f2bb770ae89641 Eric Biggers 2019-04-11   983  	case 0:
f2bb770ae89641 Eric Biggers 2019-04-11   984  	case 1:
f2bb770ae89641 Eric Biggers 2019-04-11   985  		/* All the same byte, plus optional mutations */
f900fde2888360 Eric Biggers 2023-02-27  @986  		switch (prandom_u32_below(rng, 4)) {
f2bb770ae89641 Eric Biggers 2019-04-11   987  		case 0:
f2bb770ae89641 Eric Biggers 2019-04-11   988  			b = 0x00;
f2bb770ae89641 Eric Biggers 2019-04-11   989  			break;
f2bb770ae89641 Eric Biggers 2019-04-11   990  		case 1:
f2bb770ae89641 Eric Biggers 2019-04-11   991  			b = 0xff;
f2bb770ae89641 Eric Biggers 2019-04-11   992  			break;
f2bb770ae89641 Eric Biggers 2019-04-11   993  		default:
f900fde2888360 Eric Biggers 2023-02-27  @994  			b = prandom_u8(rng);
f2bb770ae89641 Eric Biggers 2019-04-11   995  			break;
f2bb770ae89641 Eric Biggers 2019-04-11   996  		}
f2bb770ae89641 Eric Biggers 2019-04-11   997  		memset(buf, b, count);
f900fde2888360 Eric Biggers 2023-02-27  @998  		mutate_buffer(rng, buf, count);
f2bb770ae89641 Eric Biggers 2019-04-11   999  		break;
f2bb770ae89641 Eric Biggers 2019-04-11  1000  	case 2:
f2bb770ae89641 Eric Biggers 2019-04-11  1001  		/* Ascending or descending bytes, plus optional mutations */
f900fde2888360 Eric Biggers 2023-02-27  1002  		increment = prandom_u8(rng);
f900fde2888360 Eric Biggers 2023-02-27  1003  		b = prandom_u8(rng);
f2bb770ae89641 Eric Biggers 2019-04-11  1004  		for (i = 0; i < count; i++, b += increment)
f2bb770ae89641 Eric Biggers 2019-04-11  1005  			buf[i] = b;
f900fde2888360 Eric Biggers 2023-02-27 @1006  		mutate_buffer(rng, buf, count);
f2bb770ae89641 Eric Biggers 2019-04-11  1007  		break;
f2bb770ae89641 Eric Biggers 2019-04-11  1008  	default:
f2bb770ae89641 Eric Biggers 2019-04-11  1009  		/* Fully random bytes */
f900fde2888360 Eric Biggers 2023-02-27 @1010  		prandom_bytes_state(rng, buf, count);
f2bb770ae89641 Eric Biggers 2019-04-11  1011  	}
f2bb770ae89641 Eric Biggers 2019-04-11  1012  }
f2bb770ae89641 Eric Biggers 2019-04-11  1013  
f900fde2888360 Eric Biggers 2023-02-27  1014  static char *generate_random_sgl_divisions(struct rnd_state *rng,
f900fde2888360 Eric Biggers 2023-02-27  1015  					   struct test_sg_division *divs,
25f9dddb928aee Eric Biggers 2019-01-31  1016  					   size_t max_divs, char *p, char *end,
6570737c7fa047 Eric Biggers 2019-03-12  1017  					   bool gen_flushes, u32 req_flags)
25f9dddb928aee Eric Biggers 2019-01-31  1018  {
25f9dddb928aee Eric Biggers 2019-01-31  1019  	struct test_sg_division *div = divs;
25f9dddb928aee Eric Biggers 2019-01-31  1020  	unsigned int remaining = TEST_SG_TOTAL;
25f9dddb928aee Eric Biggers 2019-01-31  1021  
25f9dddb928aee Eric Biggers 2019-01-31  1022  	do {
25f9dddb928aee Eric Biggers 2019-01-31  1023  		unsigned int this_len;
6570737c7fa047 Eric Biggers 2019-03-12  1024  		const char *flushtype_str;
25f9dddb928aee Eric Biggers 2019-01-31  1025  
f900fde2888360 Eric Biggers 2023-02-27 @1026  		if (div == &divs[max_divs - 1] || prandom_bool(rng))
25f9dddb928aee Eric Biggers 2019-01-31  1027  			this_len = remaining;
101e99c23af946 Eric Biggers 2024-07-03 @1028  		else if (prandom_u32_below(rng, 4) == 0)
101e99c23af946 Eric Biggers 2024-07-03  1029  			this_len = (remaining + 1) / 2;
25f9dddb928aee Eric Biggers 2019-01-31  1030  		else
f900fde2888360 Eric Biggers 2023-02-27 @1031  			this_len = prandom_u32_inclusive(rng, 1, remaining);
25f9dddb928aee Eric Biggers 2019-01-31  1032  		div->proportion_of_total = this_len;
25f9dddb928aee Eric Biggers 2019-01-31  1033  
f900fde2888360 Eric Biggers 2023-02-27  1034  		if (prandom_u32_below(rng, 4) == 0)
f900fde2888360 Eric Biggers 2023-02-27  1035  			div->offset = prandom_u32_inclusive(rng,
f900fde2888360 Eric Biggers 2023-02-27  1036  							    PAGE_SIZE - 128,
f900fde2888360 Eric Biggers 2023-02-27  1037  							    PAGE_SIZE - 1);
f900fde2888360 Eric Biggers 2023-02-27  1038  		else if (prandom_bool(rng))
f900fde2888360 Eric Biggers 2023-02-27  1039  			div->offset = prandom_u32_below(rng, 32);
25f9dddb928aee Eric Biggers 2019-01-31  1040  		else
f900fde2888360 Eric Biggers 2023-02-27  1041  			div->offset = prandom_u32_below(rng, PAGE_SIZE);
f900fde2888360 Eric Biggers 2023-02-27  1042  		if (prandom_u32_below(rng, 8) == 0)
25f9dddb928aee Eric Biggers 2019-01-31  1043  			div->offset_relative_to_alignmask = true;
25f9dddb928aee Eric Biggers 2019-01-31  1044  
25f9dddb928aee Eric Biggers 2019-01-31  1045  		div->flush_type = FLUSH_TYPE_NONE;
25f9dddb928aee Eric Biggers 2019-01-31  1046  		if (gen_flushes) {
f900fde2888360 Eric Biggers 2023-02-27  1047  			switch (prandom_u32_below(rng, 4)) {
25f9dddb928aee Eric Biggers 2019-01-31  1048  			case 0:
25f9dddb928aee Eric Biggers 2019-01-31  1049  				div->flush_type = FLUSH_TYPE_REIMPORT;
25f9dddb928aee Eric Biggers 2019-01-31  1050  				break;
25f9dddb928aee Eric Biggers 2019-01-31  1051  			case 1:
25f9dddb928aee Eric Biggers 2019-01-31  1052  				div->flush_type = FLUSH_TYPE_FLUSH;
25f9dddb928aee Eric Biggers 2019-01-31  1053  				break;
25f9dddb928aee Eric Biggers 2019-01-31  1054  			}
25f9dddb928aee Eric Biggers 2019-01-31  1055  		}
25f9dddb928aee Eric Biggers 2019-01-31  1056  
6570737c7fa047 Eric Biggers 2019-03-12  1057  		if (div->flush_type != FLUSH_TYPE_NONE &&
6570737c7fa047 Eric Biggers 2019-03-12  1058  		    !(req_flags & CRYPTO_TFM_REQ_MAY_SLEEP) &&
f900fde2888360 Eric Biggers 2023-02-27  1059  		    prandom_bool(rng))
6570737c7fa047 Eric Biggers 2019-03-12  1060  			div->nosimd = true;
6570737c7fa047 Eric Biggers 2019-03-12  1061  
6570737c7fa047 Eric Biggers 2019-03-12  1062  		switch (div->flush_type) {
6570737c7fa047 Eric Biggers 2019-03-12  1063  		case FLUSH_TYPE_FLUSH:
6570737c7fa047 Eric Biggers 2019-03-12  1064  			if (div->nosimd)
6570737c7fa047 Eric Biggers 2019-03-12  1065  				flushtype_str = "<flush,nosimd>";
6570737c7fa047 Eric Biggers 2019-03-12  1066  			else
6570737c7fa047 Eric Biggers 2019-03-12  1067  				flushtype_str = "<flush>";
6570737c7fa047 Eric Biggers 2019-03-12  1068  			break;
6570737c7fa047 Eric Biggers 2019-03-12  1069  		case FLUSH_TYPE_REIMPORT:
6570737c7fa047 Eric Biggers 2019-03-12  1070  			if (div->nosimd)
6570737c7fa047 Eric Biggers 2019-03-12  1071  				flushtype_str = "<reimport,nosimd>";
6570737c7fa047 Eric Biggers 2019-03-12  1072  			else
6570737c7fa047 Eric Biggers 2019-03-12  1073  				flushtype_str = "<reimport>";
6570737c7fa047 Eric Biggers 2019-03-12  1074  			break;
6570737c7fa047 Eric Biggers 2019-03-12  1075  		default:
6570737c7fa047 Eric Biggers 2019-03-12  1076  			flushtype_str = "";
6570737c7fa047 Eric Biggers 2019-03-12  1077  			break;
6570737c7fa047 Eric Biggers 2019-03-12  1078  		}
6570737c7fa047 Eric Biggers 2019-03-12  1079  
25f9dddb928aee Eric Biggers 2019-01-31  1080  		BUILD_BUG_ON(TEST_SG_TOTAL != 10000); /* for "%u.%u%%" */
6570737c7fa047 Eric Biggers 2019-03-12  1081  		p += scnprintf(p, end - p, "%s%u.%u%%@%s+%u%s", flushtype_str,
25f9dddb928aee Eric Biggers 2019-01-31  1082  			       this_len / 100, this_len % 100,
25f9dddb928aee Eric Biggers 2019-01-31  1083  			       div->offset_relative_to_alignmask ?
25f9dddb928aee Eric Biggers 2019-01-31  1084  					"alignmask" : "",
25f9dddb928aee Eric Biggers 2019-01-31  1085  			       div->offset, this_len == remaining ? "" : ", ");
25f9dddb928aee Eric Biggers 2019-01-31  1086  		remaining -= this_len;
25f9dddb928aee Eric Biggers 2019-01-31  1087  		div++;
25f9dddb928aee Eric Biggers 2019-01-31  1088  	} while (remaining);
25f9dddb928aee Eric Biggers 2019-01-31  1089  
25f9dddb928aee Eric Biggers 2019-01-31  1090  	return p;
25f9dddb928aee Eric Biggers 2019-01-31  1091  }
25f9dddb928aee Eric Biggers 2019-01-31  1092  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

