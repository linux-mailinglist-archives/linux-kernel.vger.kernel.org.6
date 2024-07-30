Return-Path: <linux-kernel+bounces-268341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D156A942366
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 01:27:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 032F91C23009
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 23:27:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CDB3192B96;
	Tue, 30 Jul 2024 23:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DYZyOEhA"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB971192B64
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 23:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722382028; cv=none; b=dAL+Qapkp8BmX8CTU9wQk+cD7cBhSySchgDngynKXojTQDEvUFsxYSHOfboJHmYoBXsTuJZ+2gbkJLKFd3XYjCo3zXMvrfeR+4ZJ2nJ3xgcrTninPZBq3Sf7fe7xLpQjOGDyIBxiPFrenB2Lgrv34YLbjM2tjCtzi6Ms9lGlt34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722382028; c=relaxed/simple;
	bh=1I2YIz+AZ1WbKIuGnOvY6fR5Y+zIFratpPEerULDaC0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=bUABLgeJV5Tz+72Wq+FhF55tednbf7aRXKUBo1wJoVMwSIt4uUduJDLCCYnLxZV4t34sAFOCPIdm3CKRaOp9j4m4OMyBBbR65bmPoXtMY10xW2VSu58K1/zVFdJLfL6kHDHOPNGu//dYUFQZ+b/YtHyYvyNqXlV6BkXE/KUN9ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DYZyOEhA; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722382026; x=1753918026;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=1I2YIz+AZ1WbKIuGnOvY6fR5Y+zIFratpPEerULDaC0=;
  b=DYZyOEhA7KF1JOix3Ji5tdiJBUPu4VtFo49O82ONV1V09JgbTc2sfJru
   5VS5GRUlmaXECsRLoPA8x+MkiT1H/r2QONmCSh7yabdsemCISrIYwt4Pz
   5ahhk87xpa5tj0bsV4heBJoa8mkh+VcY7bC+zP/IgCD3y2YbZxuO9JTTH
   LpHv+GLvMekOxgXGxQ0HWXN4IkvEvLpQqbQCiBEswAMd18zXtGp593qH0
   V7EiSCKh6JxAHJJtgwEslyUD6mNe29TIiO1BdSmSIfJ2mgMZ9KWNjXSxj
   UXDaihrFSBcLVBmy/Yvp9TP5O994W01oHgsbWceX9FZm9dIwuY9mxJGBl
   g==;
X-CSE-ConnectionGUID: owoSavnnRdaYtBEjp4HfQA==
X-CSE-MsgGUID: HmKk98RTSkeN2MNaE5buPQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11149"; a="20040813"
X-IronPort-AV: E=Sophos;i="6.09,248,1716274800"; 
   d="scan'208";a="20040813"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2024 16:27:05 -0700
X-CSE-ConnectionGUID: FK3TqmT8RF6Y/x6le0r5sw==
X-CSE-MsgGUID: h2LGIfXbSbKM7rFXOVakaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,248,1716274800"; 
   d="scan'208";a="85419053"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 30 Jul 2024 16:27:05 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sYwFC-000tVQ-1v;
	Tue, 30 Jul 2024 23:27:02 +0000
Date: Wed, 31 Jul 2024 07:26:17 +0800
From: kernel test robot <lkp@intel.com>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev,
	"Gustavo A. R. Silva" <gustavo@embeddedor.com>,
	LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars:testing/wfamnae-next20240729-cbc 8/9]
 include/linux/stddef.h:16:33: error: expected declaration specifiers or
 '...' before '__builtin_offsetof'
Message-ID: <202407310719.KIRn0GjQ-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git testing/wfamnae-next20240729-cbc
head:   303f7de5e5f60dfc378b9a32a201110936b43d83
commit: d9b68641e04510cbd540f81b8ef4379e4d26e201 [8/9] scsi: fc: Avoid -Wflex-array-member-not-at-end warnings
config: sh-allmodconfig (https://download.01.org/0day-ci/archive/20240731/202407310719.KIRn0GjQ-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240731/202407310719.KIRn0GjQ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202407310719.KIRn0GjQ-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/uapi/linux/posix_types.h:5,
                    from include/uapi/linux/types.h:14,
                    from include/linux/types.h:6,
                    from include/linux/kasan-checks.h:5,
                    from include/asm-generic/rwonce.h:26,
                    from ./arch/sh/include/generated/asm/rwonce.h:1,
                    from include/linux/compiler.h:305,
                    from include/linux/export.h:5,
                    from drivers/scsi/libfc/fc_elsct.c:12:
>> include/linux/stddef.h:16:33: error: expected declaration specifiers or '...' before '__builtin_offsetof'
      16 | #define offsetof(TYPE, MEMBER)  __builtin_offsetof(TYPE, MEMBER)
         |                                 ^~~~~~~~~~~~~~~~~~
   include/uapi/scsi/fc/fc_els.h:1131:15: note: in expansion of macro 'offsetof'
    1131 | static_assert(offsetof(struct fc_df_desc_fpin_reg, desc_tags) == sizeof(struct fc_df_desc_fpin_reg_hdr),
         |               ^~~~~~~~
   In file included from drivers/scsi/libfc/fc_elsct.c:16:
>> include/uapi/scsi/fc/fc_els.h:1132:15: error: expected declaration specifiers or '...' before string constant
    1132 |               "struct member likely outside of __struct_group()");
         |               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> include/linux/stddef.h:16:33: error: expected declaration specifiers or '...' before '__builtin_offsetof'
      16 | #define offsetof(TYPE, MEMBER)  __builtin_offsetof(TYPE, MEMBER)
         |                                 ^~~~~~~~~~~~~~~~~~
   include/uapi/scsi/fc/fc_els.h:1149:15: note: in expansion of macro 'offsetof'
    1149 | static_assert(offsetof(struct fc_els_rdf, desc) == sizeof(struct fc_els_rdf_hdr),
         |               ^~~~~~~~
   include/uapi/scsi/fc/fc_els.h:1150:15: error: expected declaration specifiers or '...' before string constant
    1150 |               "struct member likely outside of __struct_group()");
         |               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +16 include/linux/stddef.h

6e218287432472 Richard Knutsson 2006-09-30  14  
^1da177e4c3f41 Linus Torvalds   2005-04-16  15  #undef offsetof
14e83077d55ff4 Rasmus Villemoes 2022-03-23 @16  #define offsetof(TYPE, MEMBER)	__builtin_offsetof(TYPE, MEMBER)
3876488444e712 Denys Vlasenko   2015-03-09  17  

:::::: The code at line 16 was first introduced by commit
:::::: 14e83077d55ff4b88fe39f5e98fb8230c2ccb4fb include: drop pointless __compiler_offsetof indirection

:::::: TO: Rasmus Villemoes <linux@rasmusvillemoes.dk>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

