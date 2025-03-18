Return-Path: <linux-kernel+bounces-566244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8D87A6755D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 14:41:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D8953BCA19
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 13:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE71520D502;
	Tue, 18 Mar 2025 13:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KBjvos1m"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F382420CCD7
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 13:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742305261; cv=none; b=uUNvHG+oCwT4ivKzEuf5OeINjZRsT0ZkzIrTrViki+9UuelgI8hNL7C4t8JoXoUpifUldb6TA/0tRwnm4eawncn+v7XaOECGj8hS/wsuTM4ZBtMwsf8oiovaS10EPSEV7EmUXKsBdi9KAjh1s6umIDSN+7DmvWoTnoEqKTkAY2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742305261; c=relaxed/simple;
	bh=lXhVzo4yDgtUowcXdZZW9kbXHp6I9tBz4MzbFXOrOac=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=G3zjO/RXmVddxM/BpKD1udIQYBv5JMQ6PmI0wMGre4sagi0IULwJeC6KqKMJKvWOz/BdwuLZ0nh26zFE4Vfd66s4h1OTQWlKpuKnkudgXPprx2iJSa4jJScA+zApS9p2fi4KlqlKI6HYSpgbdNumVg69mXL9wfkTYhQTPVWoZco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KBjvos1m; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742305259; x=1773841259;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=lXhVzo4yDgtUowcXdZZW9kbXHp6I9tBz4MzbFXOrOac=;
  b=KBjvos1m5WdR2SX82AdDELiMADgEmMGNqkA3xwv8bvfFyLvBpLEF37Mc
   XMFIYN6Ee2q6wLozA27tnf68m+4nOOV4sxq81tBfVYWNWZfjSrR5Y769i
   Ax5WUxW6TyTG/LI+TDmWRFrbPP6lDFtLYTsOpugTpVyojXG2t+z9n9B2E
   nHqiZjYioIG+VYH4xR8s5LrjXTyFLlsZ0jvxlOrj7ycgt7gtXiKUNlWXA
   PAhXA5CnQdeLekiBEIxz38/JQr+1v+yJemykuLKPyOerGk5TOocWOARij
   76U4ClXOFRDzNQw9BKK2JL5RYGyjVtHdh0hGCVVbWmilqjja0kpcyKMJK
   w==;
X-CSE-ConnectionGUID: HrKc9XpaQqCjIp3IWLYxsw==
X-CSE-MsgGUID: mIHA75RJTZ+43Un3uo9NNQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11377"; a="43314330"
X-IronPort-AV: E=Sophos;i="6.14,257,1736841600"; 
   d="scan'208";a="43314330"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2025 06:40:58 -0700
X-CSE-ConnectionGUID: KFb6uDY3T5W8B8T+r5l5Og==
X-CSE-MsgGUID: EUQrMSvPSNa6hUh4Wk9WAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,257,1736841600"; 
   d="scan'208";a="145445398"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by fmviesa002.fm.intel.com with ESMTP; 18 Mar 2025 06:40:57 -0700
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tuXBc-000DpP-05;
	Tue, 18 Mar 2025 13:40:53 +0000
Date: Tue, 18 Mar 2025 21:40:41 +0800
From: kernel test robot <lkp@intel.com>
To: Justin Lai <justinlai0215@realtek.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: include/linux/bitfield.h:178:3: error: call to '__field_overflow'
 declared with attribute error: value doesn't fit into mask
Message-ID: <202503182158.nkAlbJWX-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   76b6905c11fd3c6dc4562aefc3e8c4429fefae1e
commit: ad61903add56561b72b49d717c01563cf1535781 realtek: Update the Makefile and Kconfig in the realtek folder
date:   6 months ago
config: sparc-allyesconfig (https://download.01.org/0day-ci/archive/20250318/202503182158.nkAlbJWX-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 7.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250318/202503182158.nkAlbJWX-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503182158.nkAlbJWX-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   In file included from include/linux/mdio.h:10:0,
                    from drivers/net/ethernet/realtek/rtase/rtase_main.c:58:
   In function 'u16_encode_bits',
       inlined from 'rtase_calc_time_mitigation.constprop' at drivers/net/ethernet/realtek/rtase/rtase_main.c:1915:13,
       inlined from 'rtase_init_software_variable.isra.41' at drivers/net/ethernet/realtek/rtase/rtase_main.c:1961:13,
       inlined from 'rtase_init_one' at drivers/net/ethernet/realtek/rtase/rtase_main.c:2111:2:
>> include/linux/bitfield.h:178:3: error: call to '__field_overflow' declared with attribute error: value doesn't fit into mask
      __field_overflow();     \
      ^~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:198:2: note: in expansion of macro '____MAKE_OP'
     ____MAKE_OP(u##size,u##size,,)
     ^~~~~~~~~~~
   include/linux/bitfield.h:200:1: note: in expansion of macro '__MAKE_OP'
    __MAKE_OP(16)
    ^~~~~~~~~
   drivers/net/ethernet/realtek/rtase/rtase_main.c: In function 'rtase_open':
>> drivers/net/ethernet/realtek/rtase/rtase_main.c:1117:52: warning: '%i' directive output may be truncated writing between 1 and 10 bytes into a region of size between 7 and 22 [-Wformat-truncation=]
       snprintf(ivec->name, sizeof(ivec->name), "%s_int%i",
                                                       ^~
   drivers/net/ethernet/realtek/rtase/rtase_main.c:1117:45: note: directive argument in the range [0, 2147483647]
       snprintf(ivec->name, sizeof(ivec->name), "%s_int%i",
                                                ^~~~~~~~~~
   drivers/net/ethernet/realtek/rtase/rtase_main.c:1117:4: note: 'snprintf' output between 6 and 30 bytes into a destination of size 26
       snprintf(ivec->name, sizeof(ivec->name), "%s_int%i",
       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         tp->dev->name, i);
         ~~~~~~~~~~~~~~~~~


vim +178 include/linux/bitfield.h

e2192de59e457a Johannes Berg   2023-01-18  120  
e2192de59e457a Johannes Berg   2023-01-18  121  /**
e2192de59e457a Johannes Berg   2023-01-18  122   * FIELD_PREP_CONST() - prepare a constant bitfield element
e2192de59e457a Johannes Berg   2023-01-18  123   * @_mask: shifted mask defining the field's length and position
e2192de59e457a Johannes Berg   2023-01-18  124   * @_val:  value to put in the field
e2192de59e457a Johannes Berg   2023-01-18  125   *
e2192de59e457a Johannes Berg   2023-01-18  126   * FIELD_PREP_CONST() masks and shifts up the value.  The result should
e2192de59e457a Johannes Berg   2023-01-18  127   * be combined with other fields of the bitfield using logical OR.
e2192de59e457a Johannes Berg   2023-01-18  128   *
e2192de59e457a Johannes Berg   2023-01-18  129   * Unlike FIELD_PREP() this is a constant expression and can therefore
e2192de59e457a Johannes Berg   2023-01-18  130   * be used in initializers. Error checking is less comfortable for this
e2192de59e457a Johannes Berg   2023-01-18  131   * version, and non-constant masks cannot be used.
e2192de59e457a Johannes Berg   2023-01-18  132   */
e2192de59e457a Johannes Berg   2023-01-18  133  #define FIELD_PREP_CONST(_mask, _val)					\
e2192de59e457a Johannes Berg   2023-01-18  134  	(								\
e2192de59e457a Johannes Berg   2023-01-18  135  		/* mask must be non-zero */				\
e2192de59e457a Johannes Berg   2023-01-18  136  		BUILD_BUG_ON_ZERO((_mask) == 0) +			\
e2192de59e457a Johannes Berg   2023-01-18  137  		/* check if value fits */				\
e2192de59e457a Johannes Berg   2023-01-18  138  		BUILD_BUG_ON_ZERO(~((_mask) >> __bf_shf(_mask)) & (_val)) + \
e2192de59e457a Johannes Berg   2023-01-18  139  		/* check if mask is contiguous */			\
e2192de59e457a Johannes Berg   2023-01-18  140  		__BF_CHECK_POW2((_mask) + (1ULL << __bf_shf(_mask))) +	\
e2192de59e457a Johannes Berg   2023-01-18  141  		/* and create the value */				\
e2192de59e457a Johannes Berg   2023-01-18  142  		(((typeof(_mask))(_val) << __bf_shf(_mask)) & (_mask))	\
e2192de59e457a Johannes Berg   2023-01-18  143  	)
e2192de59e457a Johannes Berg   2023-01-18  144  
3e9b3112ec74f1 Jakub Kicinski  2016-08-31  145  /**
3e9b3112ec74f1 Jakub Kicinski  2016-08-31  146   * FIELD_GET() - extract a bitfield element
3e9b3112ec74f1 Jakub Kicinski  2016-08-31  147   * @_mask: shifted mask defining the field's length and position
7240767450d6d8 Masahiro Yamada 2017-10-03  148   * @_reg:  value of entire bitfield
3e9b3112ec74f1 Jakub Kicinski  2016-08-31  149   *
3e9b3112ec74f1 Jakub Kicinski  2016-08-31  150   * FIELD_GET() extracts the field specified by @_mask from the
3e9b3112ec74f1 Jakub Kicinski  2016-08-31  151   * bitfield passed in as @_reg by masking and shifting it down.
3e9b3112ec74f1 Jakub Kicinski  2016-08-31  152   */
3e9b3112ec74f1 Jakub Kicinski  2016-08-31  153  #define FIELD_GET(_mask, _reg)						\
3e9b3112ec74f1 Jakub Kicinski  2016-08-31  154  	({								\
3e9b3112ec74f1 Jakub Kicinski  2016-08-31  155  		__BF_FIELD_CHECK(_mask, _reg, 0U, "FIELD_GET: ");	\
3e9b3112ec74f1 Jakub Kicinski  2016-08-31  156  		(typeof(_mask))(((_reg) & (_mask)) >> __bf_shf(_mask));	\
3e9b3112ec74f1 Jakub Kicinski  2016-08-31  157  	})
3e9b3112ec74f1 Jakub Kicinski  2016-08-31  158  
e7d4a95da86e0b Johannes Berg   2018-06-20  159  extern void __compiletime_error("value doesn't fit into mask")
00b0c9b82663ac Al Viro         2017-12-14  160  __field_overflow(void);
00b0c9b82663ac Al Viro         2017-12-14  161  extern void __compiletime_error("bad bitfield mask")
00b0c9b82663ac Al Viro         2017-12-14  162  __bad_mask(void);
00b0c9b82663ac Al Viro         2017-12-14  163  static __always_inline u64 field_multiplier(u64 field)
00b0c9b82663ac Al Viro         2017-12-14  164  {
00b0c9b82663ac Al Viro         2017-12-14  165  	if ((field | (field - 1)) & ((field | (field - 1)) + 1))
00b0c9b82663ac Al Viro         2017-12-14  166  		__bad_mask();
00b0c9b82663ac Al Viro         2017-12-14  167  	return field & -field;
00b0c9b82663ac Al Viro         2017-12-14  168  }
00b0c9b82663ac Al Viro         2017-12-14  169  static __always_inline u64 field_mask(u64 field)
00b0c9b82663ac Al Viro         2017-12-14  170  {
00b0c9b82663ac Al Viro         2017-12-14  171  	return field / field_multiplier(field);
00b0c9b82663ac Al Viro         2017-12-14  172  }
e31a50162feb35 Alex Elder      2020-03-12  173  #define field_max(field)	((typeof(field))field_mask(field))
00b0c9b82663ac Al Viro         2017-12-14  174  #define ____MAKE_OP(type,base,to,from)					\
00b0c9b82663ac Al Viro         2017-12-14  175  static __always_inline __##type type##_encode_bits(base v, base field)	\
00b0c9b82663ac Al Viro         2017-12-14  176  {									\
e7d4a95da86e0b Johannes Berg   2018-06-20  177  	if (__builtin_constant_p(v) && (v & ~field_mask(field)))	\
00b0c9b82663ac Al Viro         2017-12-14 @178  		__field_overflow();					\
00b0c9b82663ac Al Viro         2017-12-14  179  	return to((v & field_mask(field)) * field_multiplier(field));	\
00b0c9b82663ac Al Viro         2017-12-14  180  }									\
00b0c9b82663ac Al Viro         2017-12-14  181  static __always_inline __##type type##_replace_bits(__##type old,	\
00b0c9b82663ac Al Viro         2017-12-14  182  					base val, base field)		\
00b0c9b82663ac Al Viro         2017-12-14  183  {									\
00b0c9b82663ac Al Viro         2017-12-14  184  	return (old & ~to(field)) | type##_encode_bits(val, field);	\
00b0c9b82663ac Al Viro         2017-12-14  185  }									\
00b0c9b82663ac Al Viro         2017-12-14  186  static __always_inline void type##p_replace_bits(__##type *p,		\
00b0c9b82663ac Al Viro         2017-12-14  187  					base val, base field)		\
00b0c9b82663ac Al Viro         2017-12-14  188  {									\
00b0c9b82663ac Al Viro         2017-12-14  189  	*p = (*p & ~to(field)) | type##_encode_bits(val, field);	\
00b0c9b82663ac Al Viro         2017-12-14  190  }									\
00b0c9b82663ac Al Viro         2017-12-14  191  static __always_inline base type##_get_bits(__##type v, base field)	\
00b0c9b82663ac Al Viro         2017-12-14  192  {									\
00b0c9b82663ac Al Viro         2017-12-14  193  	return (from(v) & field)/field_multiplier(field);		\
00b0c9b82663ac Al Viro         2017-12-14  194  }
00b0c9b82663ac Al Viro         2017-12-14  195  #define __MAKE_OP(size)							\
00b0c9b82663ac Al Viro         2017-12-14  196  	____MAKE_OP(le##size,u##size,cpu_to_le##size,le##size##_to_cpu)	\
00b0c9b82663ac Al Viro         2017-12-14  197  	____MAKE_OP(be##size,u##size,cpu_to_be##size,be##size##_to_cpu)	\
00b0c9b82663ac Al Viro         2017-12-14  198  	____MAKE_OP(u##size,u##size,,)
37a3862e123826 Johannes Berg   2018-06-20  199  ____MAKE_OP(u8,u8,,)
00b0c9b82663ac Al Viro         2017-12-14  200  __MAKE_OP(16)
00b0c9b82663ac Al Viro         2017-12-14  201  __MAKE_OP(32)
00b0c9b82663ac Al Viro         2017-12-14  202  __MAKE_OP(64)
00b0c9b82663ac Al Viro         2017-12-14  203  #undef __MAKE_OP
00b0c9b82663ac Al Viro         2017-12-14  204  #undef ____MAKE_OP
00b0c9b82663ac Al Viro         2017-12-14  205  

:::::: The code at line 178 was first introduced by commit
:::::: 00b0c9b82663ac42e5a09f58ce960f81f29d64ee Add primitives for manipulating bitfields both in host- and fixed-endian.

:::::: TO: Al Viro <viro@zeniv.linux.org.uk>
:::::: CC: Al Viro <viro@zeniv.linux.org.uk>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

