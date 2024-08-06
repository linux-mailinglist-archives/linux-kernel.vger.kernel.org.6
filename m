Return-Path: <linux-kernel+bounces-276213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 44BBC949030
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 15:08:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBEE81F22592
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 13:08:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 444F81D0DC7;
	Tue,  6 Aug 2024 13:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="al3f5CNy"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE12E1CB333
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 13:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722949718; cv=none; b=s4OqFVLr6teB67QVV2N6Hfb1tQ18R0qg4AjjqZebboVdKCfZfdJ+nl5JxxSqjKN61DROBSFVpX//Q4qtQDc43VvD99PiBb8YnY4UETFX/cL6aXHw9FsjBezgfhG/RoemlQUyDT6UxPHewsrygMjYZz/qoLa3VcwzT+kVbTC62nM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722949718; c=relaxed/simple;
	bh=RNrL9CN+dN6RJP1VI37W81GvijLeQZx/f0QxcrrQ3jM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=bI/Z9O7CxvCdnd3GS7LgcIyc31j424aUztZIjPMAaU+c7dErAqjiL1mvfcw4CAjQPORw4Cs8A70Y6Jd2xpfvd2T1jkPcqjD6L1D7mVDGXW86AgveTCf0sJGYHSrt/b9HocsX211qiQmC9rKZnihA5yPITYhHfUUqLIe5B7bIoL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=al3f5CNy; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722949715; x=1754485715;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=RNrL9CN+dN6RJP1VI37W81GvijLeQZx/f0QxcrrQ3jM=;
  b=al3f5CNyGtOH3gfLR9u5jRD9AT3pSCoeTZkk6218vQSpYpxuUlA/fvAp
   mCvAtduHPWqdCgb91byRQPiqia+1pOpyf0rUquee1LNeXt1DJLSXDBZNv
   P+t/dRJlO1vpvqdKPD7xYop8HC3TpDkg0B1MA20Zp+4n1geK2lW51DF0n
   elEV7/j5gdqqukpitiz95Mrb2ej7sTBB66znwnE7jGiZcS8OK/7ug75Am
   c0iTgtjqPsFn76W23CJgXcKhsy3jdmsAIdizCeWsrINaOK0cV6zQwdysn
   nBvvI7sVaTfxuAqpxgdcwwmRVHBOI7LgGowEvaFsFG4CcGwRKCF88mcDq
   w==;
X-CSE-ConnectionGUID: q6ioebuqRo2zW8eVxIMM8g==
X-CSE-MsgGUID: 3n11WSWvRD+X+N88X7h5wQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11156"; a="20778868"
X-IronPort-AV: E=Sophos;i="6.09,267,1716274800"; 
   d="scan'208";a="20778868"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2024 06:07:57 -0700
X-CSE-ConnectionGUID: I7kZhXtMR8iCSgm6MeE11w==
X-CSE-MsgGUID: lITOk8SxSyePUVOemACZ3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,267,1716274800"; 
   d="scan'208";a="57216435"
Received: from unknown (HELO b6bf6c95bbab) ([10.239.97.151])
  by orviesa008.jf.intel.com with ESMTP; 06 Aug 2024 06:07:55 -0700
Received: from kbuild by b6bf6c95bbab with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sbJup-0004UO-2w;
	Tue, 06 Aug 2024 13:07:51 +0000
Date: Tue, 6 Aug 2024 21:07:33 +0800
From: kernel test robot <lkp@intel.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Ping-Ke Shih <pkshih@realtek.com>
Subject: include/linux/bitfield.h:189:18: warning: 'value32' is used
 uninitialized
Message-ID: <202408062100.DWhN0CYH-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   b446a2dae984fa5bd56dd7c3a02a426f87e05813
commit: 59ea089dcba3b51769280522fd62696d4d436cbc wifi: rtlwifi: Enable the new rtl8192du driver
date:   10 weeks ago
config: mips-randconfig-r061-20240806 (https://download.01.org/0day-ci/archive/20240806/202408062100.DWhN0CYH-lkp@intel.com/config)
compiler: mips64-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240806/202408062100.DWhN0CYH-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408062100.DWhN0CYH-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/linux/ieee80211.h:21,
                    from include/net/mac80211.h:20,
                    from drivers/net/wireless/realtek/rtlwifi/rtl8192du/../wifi.h:14,
                    from drivers/net/wireless/realtek/rtlwifi/rtl8192du/hw.c:4:
   In function 'u32p_replace_bits',
       inlined from '_rtl92du_init_queue_reserved_page.isra' at drivers/net/wireless/realtek/rtlwifi/rtl8192du/hw.c:225:2:
>> include/linux/bitfield.h:189:18: warning: 'value32' is used uninitialized [-Wuninitialized]
     189 |         *p = (*p & ~to(field)) | type##_encode_bits(val, field);        \
         |              ~~~~^~~~~~~~~~~~~
   include/linux/bitfield.h:198:9: note: in expansion of macro '____MAKE_OP'
     198 |         ____MAKE_OP(u##size,u##size,,)
         |         ^~~~~~~~~~~
   include/linux/bitfield.h:201:1: note: in expansion of macro '__MAKE_OP'
     201 | __MAKE_OP(32)
         | ^~~~~~~~~
   drivers/net/wireless/realtek/rtlwifi/rtl8192du/hw.c: In function '_rtl92du_init_queue_reserved_page.isra':
   drivers/net/wireless/realtek/rtlwifi/rtl8192du/hw.c:188:13: note: 'value32' was declared here
     188 |         u32 value32;
         |             ^~~~~~~


vim +/value32 +189 include/linux/bitfield.h

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
00b0c9b82663ac Al Viro         2017-12-14  178  		__field_overflow();					\
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
00b0c9b82663ac Al Viro         2017-12-14 @189  	*p = (*p & ~to(field)) | type##_encode_bits(val, field);	\
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

:::::: The code at line 189 was first introduced by commit
:::::: 00b0c9b82663ac42e5a09f58ce960f81f29d64ee Add primitives for manipulating bitfields both in host- and fixed-endian.

:::::: TO: Al Viro <viro@zeniv.linux.org.uk>
:::::: CC: Al Viro <viro@zeniv.linux.org.uk>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

