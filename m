Return-Path: <linux-kernel+bounces-426026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FE9B9DEDE9
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 01:57:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB80728181B
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 00:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63FBC4317E;
	Sat, 30 Nov 2024 00:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HnaxKaoH"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B0432AF06
	for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 00:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732928237; cv=none; b=NJkGj3XdQkNjjGVQcM904iM8gMHnatUErHpXAk0LdKAiW4CJnxItV6G37H6TRRw8QNaDBm0wjQL8OQeB27WzRWkHQrRwhqAjMPwCvkHMvmAgYBPzLWKbm/ZGOKIhNHXKEna/3uGEyVSSxnUDqAtxBb/TZ9Kxn2a8wUvTDytslM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732928237; c=relaxed/simple;
	bh=VicWifUrkNQO95BdTMM+v+ggpR2Nf1fa6ugJaUd0B0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=eYxwzS2KPniOgjK0dfOP7rUxNZw7cbf6u0HeDuvyb+eFNLTBEvfMqI1IOXWu/Nixl8a/QQHqc6Na/gY+Qgy+bm5vUUZ4NeDNGvxjlszH4NvaENpxzecC0hL6Lzc5WVpQA9xQW2YI/v6/a3/sTQblvIVd3kfM43/fiLRADGKy+b0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HnaxKaoH; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732928235; x=1764464235;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=VicWifUrkNQO95BdTMM+v+ggpR2Nf1fa6ugJaUd0B0Q=;
  b=HnaxKaoHTlgplRrs0pLGVX6vsrNy3cWDPKLiWx3pMVOzbP9hmFX6i5eJ
   7ZP1D8pnY1ugcls6lKEPu66t6+YTvG+VJ/04mdjRY8T4IuIm9yeN6P1YX
   5CXBYHyxMAYRXfLXXdW4sLy4fQtyZHUj7OWHvrLmtaEDvkjQ4sVp2ph/6
   zYTnjsNZ96sV4hQ8dJNQHpHV4vq1z+QvBzwkSxLvRRmnumJIboAiYxgHC
   Mf87rcjLKuhirzShVlC3rkZyWRegrXDEAjIHwJrutJgem/3Mf2wPVRtMh
   z+FKWMCRHGuALGzSrLFYUl9HlGdBfYVMlAV+xlKXUHaRS4qD3mwlSYi2C
   w==;
X-CSE-ConnectionGUID: LoodpGvmSB+bXqvfHVnOFg==
X-CSE-MsgGUID: nVFKpowLSBGLjx8MS3OShw==
X-IronPort-AV: E=McAfee;i="6700,10204,11271"; a="33095475"
X-IronPort-AV: E=Sophos;i="6.12,197,1728975600"; 
   d="scan'208";a="33095475"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2024 16:57:15 -0800
X-CSE-ConnectionGUID: 8n5nQJ7QTu6Dk4dOSOS6Rw==
X-CSE-MsgGUID: 47KzjJ7iQzCxXTmQkIv+tg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,197,1728975600"; 
   d="scan'208";a="92920581"
Received: from lkp-server01.sh.intel.com (HELO 5e2646291792) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 29 Nov 2024 16:57:13 -0800
Received: from kbuild by 5e2646291792 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tHBnK-0000ol-24;
	Sat, 30 Nov 2024 00:57:10 +0000
Date: Sat, 30 Nov 2024 08:56:17 +0800
From: kernel test robot <lkp@intel.com>
To: Josef Bacik <josef@toxicpanda.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>
Subject: include/linux/kasan-checks.h:38:27: warning: 'label' may be used
 uninitialized
Message-ID: <202411300855.sRB49hum-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Josef,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   2ba9f676d0a2e408aef14d679984c26373bf37b7
commit: 1ec49744ba83f0429c5c706708610f7821a7b6f4 btrfs: turn on -Wmaybe-uninitialized
date:   1 year, 10 months ago
config: arm64-randconfig-001-20241120 (https://download.01.org/0day-ci/archive/20241130/202411300855.sRB49hum-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241130/202411300855.sRB49hum-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411300855.sRB49hum-lkp@intel.com/

Note: it may well be a FALSE warning. FWIW you are at least aware of it now.
http://gcc.gnu.org/wiki/Better_Uninitialized_Warnings

All warnings (new ones prefixed by >>):

   In file included from include/asm-generic/rwonce.h:26,
                    from arch/arm64/include/asm/rwonce.h:71,
                    from include/linux/compiler.h:247,
                    from include/linux/export.h:33,
                    from include/linux/linkage.h:7,
                    from include/linux/kernel.h:17,
                    from fs/btrfs/ioctl.c:6:
   In function 'instrument_copy_from_user_before',
       inlined from '_copy_from_user' at include/linux/uaccess.h:126:3,
       inlined from 'copy_from_user' at include/linux/uaccess.h:161:7,
       inlined from 'btrfs_ioctl_set_fslabel' at fs/btrfs/ioctl.c:4112:6:
>> include/linux/kasan-checks.h:38:27: warning: 'label' may be used uninitialized [-Wmaybe-uninitialized]
      38 | #define kasan_check_write __kasan_check_write
   include/linux/instrumented.h:137:9: note: in expansion of macro 'kasan_check_write'
     137 |         kasan_check_write(to, n);
         |         ^~~~~~~~~~~~~~~~~
   include/linux/kasan-checks.h: In function 'btrfs_ioctl_set_fslabel':
   include/linux/kasan-checks.h:20:6: note: by argument 1 of type 'const volatile void *' to '__kasan_check_write' declared here
      20 | bool __kasan_check_write(const volatile void *p, unsigned int size);
         |      ^~~~~~~~~~~~~~~~~~~
   fs/btrfs/ioctl.c:4106:14: note: 'label' declared here
    4106 |         char label[BTRFS_LABEL_SIZE];
         |              ^~~~~
   In function 'instrument_copy_from_user_before',
       inlined from '_copy_from_user' at include/linux/uaccess.h:126:3,
       inlined from 'copy_from_user' at include/linux/uaccess.h:161:7,
       inlined from 'btrfs_ioctl_wait_sync' at fs/btrfs/ioctl.c:3137:7:
   include/linux/kasan-checks.h:38:27: warning: 'transid' may be used uninitialized [-Wmaybe-uninitialized]
      38 | #define kasan_check_write __kasan_check_write
   include/linux/instrumented.h:137:9: note: in expansion of macro 'kasan_check_write'
     137 |         kasan_check_write(to, n);
         |         ^~~~~~~~~~~~~~~~~
   include/linux/kasan-checks.h: In function 'btrfs_ioctl_wait_sync':
   include/linux/kasan-checks.h:20:6: note: by argument 1 of type 'const volatile void *' to '__kasan_check_write' declared here
      20 | bool __kasan_check_write(const volatile void *p, unsigned int size);
         |      ^~~~~~~~~~~~~~~~~~~
   fs/btrfs/ioctl.c:3134:13: note: 'transid' declared here
    3134 |         u64 transid;
         |             ^~~~~~~
   In function 'instrument_copy_from_user_before',
       inlined from '_copy_from_user' at include/linux/uaccess.h:126:3,
       inlined from 'copy_from_user' at include/linux/uaccess.h:161:7,
       inlined from 'btrfs_ioctl_tree_search' at fs/btrfs/ioctl.c:1740:6:
   include/linux/kasan-checks.h:38:27: warning: 'sk' may be used uninitialized [-Wmaybe-uninitialized]
      38 | #define kasan_check_write __kasan_check_write
   include/linux/instrumented.h:137:9: note: in expansion of macro 'kasan_check_write'
     137 |         kasan_check_write(to, n);
         |         ^~~~~~~~~~~~~~~~~
   include/linux/kasan-checks.h: In function 'btrfs_ioctl_tree_search':
   include/linux/kasan-checks.h:20:6: note: by argument 1 of type 'const volatile void *' to '__kasan_check_write' declared here
      20 | bool __kasan_check_write(const volatile void *p, unsigned int size);
         |      ^~~~~~~~~~~~~~~~~~~
   fs/btrfs/ioctl.c:1733:39: note: 'sk' declared here
    1733 |         struct btrfs_ioctl_search_key sk;
         |                                       ^~
   In function 'instrument_copy_from_user_before',
       inlined from '_copy_from_user' at include/linux/uaccess.h:126:3,
       inlined from 'copy_from_user' at include/linux/uaccess.h:161:7,
       inlined from 'btrfs_ioctl_set_features' at fs/btrfs/ioctl.c:4256:6:
>> include/linux/kasan-checks.h:38:27: warning: 'flags' may be used uninitialized [-Wmaybe-uninitialized]
      38 | #define kasan_check_write __kasan_check_write
   include/linux/instrumented.h:137:9: note: in expansion of macro 'kasan_check_write'
     137 |         kasan_check_write(to, n);
         |         ^~~~~~~~~~~~~~~~~
   include/linux/kasan-checks.h: In function 'btrfs_ioctl_set_features':
   include/linux/kasan-checks.h:20:6: note: by argument 1 of type 'const volatile void *' to '__kasan_check_write' declared here
      20 | bool __kasan_check_write(const volatile void *p, unsigned int size);
         |      ^~~~~~~~~~~~~~~~~~~
   fs/btrfs/ioctl.c:4248:42: note: 'flags' declared here
    4248 |         struct btrfs_ioctl_feature_flags flags[2];
         |                                          ^~~~~
   In function 'instrument_copy_from_user_before',
       inlined from '_copy_from_user' at include/linux/uaccess.h:126:3,
       inlined from 'copy_from_user' at include/linux/uaccess.h:161:7,
       inlined from 'btrfs_ioctl_tree_search_v2' at fs/btrfs/ioctl.c:1772:6:
   include/linux/kasan-checks.h:38:27: warning: 'args' may be used uninitialized [-Wmaybe-uninitialized]
      38 | #define kasan_check_write __kasan_check_write
   include/linux/instrumented.h:137:9: note: in expansion of macro 'kasan_check_write'
     137 |         kasan_check_write(to, n);
         |         ^~~~~~~~~~~~~~~~~
   include/linux/kasan-checks.h: In function 'btrfs_ioctl_tree_search_v2':
   include/linux/kasan-checks.h:20:6: note: by argument 1 of type 'const volatile void *' to '__kasan_check_write' declared here
      20 | bool __kasan_check_write(const volatile void *p, unsigned int size);
         |      ^~~~~~~~~~~~~~~~~~~
   fs/btrfs/ioctl.c:1763:43: note: 'args' declared here
    1763 |         struct btrfs_ioctl_search_args_v2 args;
         |                                           ^~~~
   In function 'instrument_copy_from_user_before',
       inlined from '_copy_from_user' at include/linux/uaccess.h:126:3,
       inlined from 'copy_from_user' at include/linux/uaccess.h:161:7,
       inlined from 'btrfs_ioctl_space_info' at fs/btrfs/ioctl.c:2991:6:
   include/linux/kasan-checks.h:38:27: warning: 'space_args' may be used uninitialized [-Wmaybe-uninitialized]
      38 | #define kasan_check_write __kasan_check_write
   include/linux/instrumented.h:137:9: note: in expansion of macro 'kasan_check_write'
     137 |         kasan_check_write(to, n);
         |         ^~~~~~~~~~~~~~~~~
   include/linux/kasan-checks.h: In function 'btrfs_ioctl_space_info':
   include/linux/kasan-checks.h:20:6: note: by argument 1 of type 'const volatile void *' to '__kasan_check_write' declared here
      20 | bool __kasan_check_write(const volatile void *p, unsigned int size);
         |      ^~~~~~~~~~~~~~~~~~~
   fs/btrfs/ioctl.c:2973:39: note: 'space_args' declared here
    2973 |         struct btrfs_ioctl_space_args space_args;
         |                                       ^~~~~~~~~~
   In function 'instrument_copy_from_user_before',
       inlined from '_copy_from_user' at include/linux/uaccess.h:126:3,
       inlined from 'copy_from_user' at include/linux/uaccess.h:161:7,
       inlined from 'btrfs_ioctl_encoded_write.constprop' at fs/btrfs/ioctl.c:4473:7:
   include/linux/kasan-checks.h:38:27: warning: 'args' may be used uninitialized [-Wmaybe-uninitialized]
      38 | #define kasan_check_write __kasan_check_write
   include/linux/instrumented.h:137:9: note: in expansion of macro 'kasan_check_write'
     137 |         kasan_check_write(to, n);
         |         ^~~~~~~~~~~~~~~~~
   include/linux/kasan-checks.h: In function 'btrfs_ioctl_encoded_write.constprop':
   include/linux/kasan-checks.h:20:6: note: by argument 1 of type 'const volatile void *' to '__kasan_check_write' declared here
      20 | bool __kasan_check_write(const volatile void *p, unsigned int size);
         |      ^~~~~~~~~~~~~~~~~~~
   fs/btrfs/ioctl.c:4433:44: note: 'args' declared here
    4433 |         struct btrfs_ioctl_encoded_io_args args;
         |                                            ^~~~


vim +/label +38 include/linux/kasan-checks.h

7d8ad890dad00f Marco Elver     2019-07-11  31  
7d8ad890dad00f Marco Elver     2019-07-11  32  /*
7d8ad890dad00f Marco Elver     2019-07-11  33   * kasan_check_*: Only available when the particular compilation unit has KASAN
7d8ad890dad00f Marco Elver     2019-07-11  34   * instrumentation enabled. May be used in header files.
7d8ad890dad00f Marco Elver     2019-07-11  35   */
7d8ad890dad00f Marco Elver     2019-07-11  36  #ifdef __SANITIZE_ADDRESS__
7d8ad890dad00f Marco Elver     2019-07-11  37  #define kasan_check_read __kasan_check_read
7d8ad890dad00f Marco Elver     2019-07-11 @38  #define kasan_check_write __kasan_check_write
64f8ebaf115bcd Andrey Ryabinin 2016-05-20  39  #else
b5f6e0fc7d60e0 Marco Elver     2019-07-11  40  static inline bool kasan_check_read(const volatile void *p, unsigned int size)
b5f6e0fc7d60e0 Marco Elver     2019-07-11  41  {
b5f6e0fc7d60e0 Marco Elver     2019-07-11  42  	return true;
b5f6e0fc7d60e0 Marco Elver     2019-07-11  43  }
b5f6e0fc7d60e0 Marco Elver     2019-07-11  44  static inline bool kasan_check_write(const volatile void *p, unsigned int size)
b5f6e0fc7d60e0 Marco Elver     2019-07-11  45  {
b5f6e0fc7d60e0 Marco Elver     2019-07-11  46  	return true;
b5f6e0fc7d60e0 Marco Elver     2019-07-11  47  }
64f8ebaf115bcd Andrey Ryabinin 2016-05-20  48  #endif
64f8ebaf115bcd Andrey Ryabinin 2016-05-20  49  

:::::: The code at line 38 was first introduced by commit
:::::: 7d8ad890dad00f6cd64bfb44d9be4fceb10cf819 mm/kasan: introduce __kasan_check_{read,write}

:::::: TO: Marco Elver <elver@google.com>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

