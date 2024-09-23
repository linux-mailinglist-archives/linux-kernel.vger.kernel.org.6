Return-Path: <linux-kernel+bounces-336019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B92DC97EE19
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 17:27:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B98F71C21612
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 15:27:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB0D781749;
	Mon, 23 Sep 2024 15:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GGgxQlU0"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4F7119415E
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 15:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727105254; cv=none; b=BbOlFqDu5j76m4WRwZnFsfXOALR0wJ6ZJp9/RuP/shkmOOiU3vyqjamEVj1S/8zmUvIPoMyrLPs+KK/9gTKRXmM39fr89f7sUIY3Xps/ZBJyddkBC0QK2CM5DufvPWz9DH2y+Qrxf+YxkqCUCwd5yagVjLyhdUE+r9Afo1yrwQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727105254; c=relaxed/simple;
	bh=NTF1Ano3mKcGX3BDRGoMK1XxNMP1i/Oa//AJJik8qkQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=MCyUmy7dc9f8D720INh4RABdCEveUSPQnfSGPqZL+6WzDu4GbLuu/pU7xQPmVP3V+c8AsL9dgxzSUJb84NvJcZgFSpuv2LeeJavUUaE0I1L22bdXr0IWi+hfnfWTI4neYcJSmk2NvqV65PHDlugQoeBB+NfZsOl28RGv/DftX6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GGgxQlU0; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727105253; x=1758641253;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=NTF1Ano3mKcGX3BDRGoMK1XxNMP1i/Oa//AJJik8qkQ=;
  b=GGgxQlU0an+AMdd8dVHiSpEkb4OihlJmk569NPIWtfwg5zaxyjkfRWMn
   awpmjx+b6kqvOutlRuLKq/099rjxDlsSkMAe6SXTl9KQ+nukrEAHFdhDL
   Gqo230DejZD/smOcTmalaz9+xacQNcJXaRxyZtDSlIk68nkaAF/yZaNgY
   UlyU76Y+PtoZl+V+dekmz/86vrgOU+yNyrpyLEPme8pw/ABixVcqsOfxn
   NY4+8IJmlYdBq0mmxpO+3Q4yx/T/bKNXMmfbVmmfX6Qdsd05vadCsIfb0
   4TihCGyQ/X8cMJ/JmlqxKtAkKjLe1DoXKdB1OlfAaDuvYYJhYfyjZWC7L
   w==;
X-CSE-ConnectionGUID: Z0h6ctxbQ5uhY/UuHyfn9g==
X-CSE-MsgGUID: e/lK8Y8kQn+DxmSVFrl00g==
X-IronPort-AV: E=McAfee;i="6700,10204,11204"; a="29947009"
X-IronPort-AV: E=Sophos;i="6.10,251,1719903600"; 
   d="scan'208";a="29947009"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2024 08:27:31 -0700
X-CSE-ConnectionGUID: 6q3IyxkXR2mdNYgcK4HsGA==
X-CSE-MsgGUID: zm2MewC+QqG675fZWg2dOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,251,1719903600"; 
   d="scan'208";a="71371794"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 23 Sep 2024 08:27:30 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sskyF-000HJo-1V;
	Mon, 23 Sep 2024 15:27:27 +0000
Date: Mon, 23 Sep 2024 23:27:10 +0800
From: kernel test robot <lkp@intel.com>
To: Alex Deucher <alexander.deucher@amd.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Dave Airlie <airlied@redhat.com>
Subject: include/linux/fortify-string.h:562:25: error: call to
 '__read_overflow2_field' declared with attribute warning: detected read
 beyond size of field (2nd parameter); maybe use struct_group()?
Message-ID: <202409232316.5U75bLW8-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   de5cb0dcb74c294ec527eddfe5094acfdb21ff21
commit: 377b5b397d073c0aae36b833a5bcac0e6f349243 Merge tag 'amd-drm-next-6.10-2024-04-19' of https://gitlab.freedesktop.org/agd5f/linux into drm-next
date:   5 months ago
config: riscv-randconfig-r062-20240830 (https://download.01.org/0day-ci/archive/20240923/202409232316.5U75bLW8-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 13.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240923/202409232316.5U75bLW8-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409232316.5U75bLW8-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/linux/string.h:369,
                    from include/linux/bitmap.h:13,
                    from include/linux/cpumask.h:13,
                    from include/linux/smp.h:13,
                    from include/linux/lockdep.h:14,
                    from include/linux/spinlock.h:63,
                    from include/linux/mmzone.h:8,
                    from include/linux/gfp.h:7,
                    from include/linux/slab.h:16,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/os_types.h:30,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/dm_services_types.h:29,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/dm_services.h:35,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_stream.c:26:
   In function 'fortify_memcpy_chk',
       inlined from 'dc_stream_remove_writeback' at drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_stream.c:523:5:
>> include/linux/fortify-string.h:562:25: error: call to '__read_overflow2_field' declared with attribute warning: detected read beyond size of field (2nd parameter); maybe use struct_group()? [-Werror=attribute-warning]
     562 |                         __read_overflow2_field(q_size_field, size);
         |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   cc1: all warnings being treated as errors


vim +/__read_overflow2_field +562 include/linux/fortify-string.h

a28a6e860c6cf2 Francis Laniel 2021-02-25  497  
f68f2ff91512c1 Kees Cook      2021-04-20  498  /*
f68f2ff91512c1 Kees Cook      2021-04-20  499   * To make sure the compiler can enforce protection against buffer overflows,
f68f2ff91512c1 Kees Cook      2021-04-20  500   * memcpy(), memmove(), and memset() must not be used beyond individual
f68f2ff91512c1 Kees Cook      2021-04-20  501   * struct members. If you need to copy across multiple members, please use
f68f2ff91512c1 Kees Cook      2021-04-20  502   * struct_group() to create a named mirror of an anonymous struct union.
f68f2ff91512c1 Kees Cook      2021-04-20  503   * (e.g. see struct sk_buff.) Read overflow checking is currently only
f68f2ff91512c1 Kees Cook      2021-04-20  504   * done when a write overflow is also present, or when building with W=1.
f68f2ff91512c1 Kees Cook      2021-04-20  505   *
f68f2ff91512c1 Kees Cook      2021-04-20  506   * Mitigation coverage matrix
f68f2ff91512c1 Kees Cook      2021-04-20  507   *					Bounds checking at:
f68f2ff91512c1 Kees Cook      2021-04-20  508   *					+-------+-------+-------+-------+
f68f2ff91512c1 Kees Cook      2021-04-20  509   *					| Compile time  |   Run time    |
f68f2ff91512c1 Kees Cook      2021-04-20  510   * memcpy() argument sizes:		| write | read  | write | read  |
f68f2ff91512c1 Kees Cook      2021-04-20  511   *        dest     source   length      +-------+-------+-------+-------+
f68f2ff91512c1 Kees Cook      2021-04-20  512   * memcpy(known,   known,   constant)	|   y   |   y   |  n/a  |  n/a  |
f68f2ff91512c1 Kees Cook      2021-04-20  513   * memcpy(known,   unknown, constant)	|   y   |   n   |  n/a  |   V   |
f68f2ff91512c1 Kees Cook      2021-04-20  514   * memcpy(known,   known,   dynamic)	|   n   |   n   |   B   |   B   |
f68f2ff91512c1 Kees Cook      2021-04-20  515   * memcpy(known,   unknown, dynamic)	|   n   |   n   |   B   |   V   |
f68f2ff91512c1 Kees Cook      2021-04-20  516   * memcpy(unknown, known,   constant)	|   n   |   y   |   V   |  n/a  |
f68f2ff91512c1 Kees Cook      2021-04-20  517   * memcpy(unknown, unknown, constant)	|   n   |   n   |   V   |   V   |
f68f2ff91512c1 Kees Cook      2021-04-20  518   * memcpy(unknown, known,   dynamic)	|   n   |   n   |   V   |   B   |
f68f2ff91512c1 Kees Cook      2021-04-20  519   * memcpy(unknown, unknown, dynamic)	|   n   |   n   |   V   |   V   |
f68f2ff91512c1 Kees Cook      2021-04-20  520   *					+-------+-------+-------+-------+
f68f2ff91512c1 Kees Cook      2021-04-20  521   *
f68f2ff91512c1 Kees Cook      2021-04-20  522   * y = perform deterministic compile-time bounds checking
f68f2ff91512c1 Kees Cook      2021-04-20  523   * n = cannot perform deterministic compile-time bounds checking
f68f2ff91512c1 Kees Cook      2021-04-20  524   * n/a = no run-time bounds checking needed since compile-time deterministic
f68f2ff91512c1 Kees Cook      2021-04-20  525   * B = can perform run-time bounds checking (currently unimplemented)
f68f2ff91512c1 Kees Cook      2021-04-20  526   * V = vulnerable to run-time overflow (will need refactoring to solve)
f68f2ff91512c1 Kees Cook      2021-04-20  527   *
f68f2ff91512c1 Kees Cook      2021-04-20  528   */
54d9469bc515dc Kees Cook      2021-06-24  529  __FORTIFY_INLINE bool fortify_memcpy_chk(__kernel_size_t size,
f68f2ff91512c1 Kees Cook      2021-04-20  530  					 const size_t p_size,
f68f2ff91512c1 Kees Cook      2021-04-20  531  					 const size_t q_size,
f68f2ff91512c1 Kees Cook      2021-04-20  532  					 const size_t p_size_field,
f68f2ff91512c1 Kees Cook      2021-04-20  533  					 const size_t q_size_field,
475ddf1fce1ec4 Kees Cook      2023-04-07  534  					 const u8 func)
a28a6e860c6cf2 Francis Laniel 2021-02-25  535  {
a28a6e860c6cf2 Francis Laniel 2021-02-25  536  	if (__builtin_constant_p(size)) {
f68f2ff91512c1 Kees Cook      2021-04-20  537  		/*
f68f2ff91512c1 Kees Cook      2021-04-20  538  		 * Length argument is a constant expression, so we
f68f2ff91512c1 Kees Cook      2021-04-20  539  		 * can perform compile-time bounds checking where
fa35198f39571b Kees Cook      2022-09-19  540  		 * buffer sizes are also known at compile time.
f68f2ff91512c1 Kees Cook      2021-04-20  541  		 */
f68f2ff91512c1 Kees Cook      2021-04-20  542  
f68f2ff91512c1 Kees Cook      2021-04-20  543  		/* Error when size is larger than enclosing struct. */
fa35198f39571b Kees Cook      2022-09-19  544  		if (__compiletime_lessthan(p_size_field, p_size) &&
fa35198f39571b Kees Cook      2022-09-19  545  		    __compiletime_lessthan(p_size, size))
a28a6e860c6cf2 Francis Laniel 2021-02-25  546  			__write_overflow();
fa35198f39571b Kees Cook      2022-09-19  547  		if (__compiletime_lessthan(q_size_field, q_size) &&
fa35198f39571b Kees Cook      2022-09-19  548  		    __compiletime_lessthan(q_size, size))
a28a6e860c6cf2 Francis Laniel 2021-02-25  549  			__read_overflow2();
f68f2ff91512c1 Kees Cook      2021-04-20  550  
f68f2ff91512c1 Kees Cook      2021-04-20  551  		/* Warn when write size argument larger than dest field. */
fa35198f39571b Kees Cook      2022-09-19  552  		if (__compiletime_lessthan(p_size_field, size))
f68f2ff91512c1 Kees Cook      2021-04-20  553  			__write_overflow_field(p_size_field, size);
f68f2ff91512c1 Kees Cook      2021-04-20  554  		/*
f68f2ff91512c1 Kees Cook      2021-04-20  555  		 * Warn for source field over-read when building with W=1
f68f2ff91512c1 Kees Cook      2021-04-20  556  		 * or when an over-write happened, so both can be fixed at
f68f2ff91512c1 Kees Cook      2021-04-20  557  		 * the same time.
f68f2ff91512c1 Kees Cook      2021-04-20  558  		 */
fa35198f39571b Kees Cook      2022-09-19  559  		if ((IS_ENABLED(KBUILD_EXTRA_WARN1) ||
fa35198f39571b Kees Cook      2022-09-19  560  		     __compiletime_lessthan(p_size_field, size)) &&
fa35198f39571b Kees Cook      2022-09-19  561  		    __compiletime_lessthan(q_size_field, size))
f68f2ff91512c1 Kees Cook      2021-04-20 @562  			__read_overflow2_field(q_size_field, size);
a28a6e860c6cf2 Francis Laniel 2021-02-25  563  	}
f68f2ff91512c1 Kees Cook      2021-04-20  564  	/*
f68f2ff91512c1 Kees Cook      2021-04-20  565  	 * At this point, length argument may not be a constant expression,
f68f2ff91512c1 Kees Cook      2021-04-20  566  	 * so run-time bounds checking can be done where buffer sizes are
f68f2ff91512c1 Kees Cook      2021-04-20  567  	 * known. (This is not an "else" because the above checks may only
f68f2ff91512c1 Kees Cook      2021-04-20  568  	 * be compile-time warnings, and we want to still warn for run-time
f68f2ff91512c1 Kees Cook      2021-04-20  569  	 * overflows.)
f68f2ff91512c1 Kees Cook      2021-04-20  570  	 */
f68f2ff91512c1 Kees Cook      2021-04-20  571  
f68f2ff91512c1 Kees Cook      2021-04-20  572  	/*
f68f2ff91512c1 Kees Cook      2021-04-20  573  	 * Always stop accesses beyond the struct that contains the
f68f2ff91512c1 Kees Cook      2021-04-20  574  	 * field, when the buffer's remaining size is known.
311fb40aa0569a Kees Cook      2022-09-02  575  	 * (The SIZE_MAX test is to optimize away checks where the buffer
f68f2ff91512c1 Kees Cook      2021-04-20  576  	 * lengths are unknown.)
f68f2ff91512c1 Kees Cook      2021-04-20  577  	 */
475ddf1fce1ec4 Kees Cook      2023-04-07  578  	if (p_size != SIZE_MAX && p_size < size)
3d965b33e40d97 Kees Cook      2023-04-07  579  		fortify_panic(func, FORTIFY_WRITE, p_size, size, true);
475ddf1fce1ec4 Kees Cook      2023-04-07  580  	else if (q_size != SIZE_MAX && q_size < size)
3d965b33e40d97 Kees Cook      2023-04-07  581  		fortify_panic(func, FORTIFY_READ, p_size, size, true);
54d9469bc515dc Kees Cook      2021-06-24  582  
54d9469bc515dc Kees Cook      2021-06-24  583  	/*
54d9469bc515dc Kees Cook      2021-06-24  584  	 * Warn when writing beyond destination field size.
54d9469bc515dc Kees Cook      2021-06-24  585  	 *
54d9469bc515dc Kees Cook      2021-06-24  586  	 * We must ignore p_size_field == 0 for existing 0-element
54d9469bc515dc Kees Cook      2021-06-24  587  	 * fake flexible arrays, until they are all converted to
54d9469bc515dc Kees Cook      2021-06-24  588  	 * proper flexible arrays.
54d9469bc515dc Kees Cook      2021-06-24  589  	 *
9f7d69c5cd2390 Kees Cook      2022-09-19  590  	 * The implementation of __builtin_*object_size() behaves
54d9469bc515dc Kees Cook      2021-06-24  591  	 * like sizeof() when not directly referencing a flexible
54d9469bc515dc Kees Cook      2021-06-24  592  	 * array member, which means there will be many bounds checks
54d9469bc515dc Kees Cook      2021-06-24  593  	 * that will appear at run-time, without a way for them to be
54d9469bc515dc Kees Cook      2021-06-24  594  	 * detected at compile-time (as can be done when the destination
54d9469bc515dc Kees Cook      2021-06-24  595  	 * is specifically the flexible array member).
54d9469bc515dc Kees Cook      2021-06-24  596  	 * https://gcc.gnu.org/bugzilla/show_bug.cgi?id=101832
54d9469bc515dc Kees Cook      2021-06-24  597  	 */
54d9469bc515dc Kees Cook      2021-06-24  598  	if (p_size_field != 0 && p_size_field != SIZE_MAX &&
54d9469bc515dc Kees Cook      2021-06-24  599  	    p_size != p_size_field && p_size_field < size)
54d9469bc515dc Kees Cook      2021-06-24  600  		return true;
54d9469bc515dc Kees Cook      2021-06-24  601  
54d9469bc515dc Kees Cook      2021-06-24  602  	return false;
a28a6e860c6cf2 Francis Laniel 2021-02-25  603  }
a28a6e860c6cf2 Francis Laniel 2021-02-25  604  

:::::: The code at line 562 was first introduced by commit
:::::: f68f2ff91512c199ec24883001245912afc17873 fortify: Detect struct member overflows in memcpy() at compile-time

:::::: TO: Kees Cook <keescook@chromium.org>
:::::: CC: Kees Cook <keescook@chromium.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

