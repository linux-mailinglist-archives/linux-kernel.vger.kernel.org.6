Return-Path: <linux-kernel+bounces-268409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A07A942455
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 03:57:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31631285C3F
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 01:57:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C940DDAB;
	Wed, 31 Jul 2024 01:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y4oA4nMe"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B914D2FF
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 01:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722391034; cv=none; b=HWe1ERxazhFkqHAkIfvMNQUA2pNlui13cevlNu23YlKDvLzt5ZUHM8iJPNQzvkkxhKhyIidPq45xSJ/GoL78ZySZhv5QXM2iuaYDNvwMrgykir8H/wsDFgyqqTIsQ9UMIf0jg49VDM+c+ndxFtpfPNP7FMsdbB7vvfAYMGxjy2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722391034; c=relaxed/simple;
	bh=RCdNowIwLLOvGeo7UOW1THxlROaOWcSUiiLBHtq2S5o=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=kZXkTUJwvxtTaGrYdJ0HJYqy1B4YQwJwo1xuxRYLIASbqlhPY6D0Fh8fCD6fsYHFHQD7h3oR8PjloPZOqO3jfmxqQIzsvE7L+Hnn4qEeG00pcqxyhkU8hdkfSc9sKkYr7f4lDGLuIeZ26YpW9E0yNzWM1rXlp7TDHfVc/bKHzF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y4oA4nMe; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722391031; x=1753927031;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=RCdNowIwLLOvGeo7UOW1THxlROaOWcSUiiLBHtq2S5o=;
  b=Y4oA4nMeWAryon58za1XcvNNgESMYCY2TpunHxxyMmfN6fCOZ7Z+cpw7
   VrhLfmZTrX+POz82GkMar5OPXq2B43NLucDvRQnz1pWpUabWNyUdtvDLw
   XPoA+g6G4/xVmlPw/Mzz+Asv+KgPWKwWWWJy55NjKwE80LBTPaOTzdY+S
   c0QWxcn1BbvGBXdj0MjmQB0kAl+GmvD2PxWjKmmIlvLmhM2vnxgFCCHze
   7H0jXJr5xaptY9590fpgY6mJ6hvFQw4KpET/NIEu0M5tifghPOLJPPb44
   32hTc3I+hXOaIxmnCh1biLYWkr0dz3OZNSkDqRLbQgpaR4WnT/gge0R5b
   g==;
X-CSE-ConnectionGUID: wH3gRIOySzmcDR6N0V/msg==
X-CSE-MsgGUID: FwNVZWhRQgGMI5bROb9qfg==
X-IronPort-AV: E=McAfee;i="6700,10204,11149"; a="20372904"
X-IronPort-AV: E=Sophos;i="6.09,250,1716274800"; 
   d="scan'208";a="20372904"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2024 18:57:11 -0700
X-CSE-ConnectionGUID: c3yEIM8kS+uVhdm8NzgN7w==
X-CSE-MsgGUID: uSAYfPr9TZGm098+B58eNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,250,1716274800"; 
   d="scan'208";a="54779947"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 30 Jul 2024 18:57:08 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sYyaQ-000tcJ-29;
	Wed, 31 Jul 2024 01:57:06 +0000
Date: Wed, 31 Jul 2024 09:56:27 +0800
From: kernel test robot <lkp@intel.com>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	"Gustavo A. R. Silva" <gustavo@embeddedor.com>,
	LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars:testing/wfamnae-next20240729-cbc 8/9]
 include/uapi/scsi/fc/fc_els.h:1131:15: error: expected parameter declarator
Message-ID: <202407310922.Mkw2WfT2-lkp@intel.com>
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
config: s390-allmodconfig (https://download.01.org/0day-ci/archive/20240731/202407310922.Mkw2WfT2-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project ccae7b461be339e717d02f99ac857cf0bc7d17fc)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240731/202407310922.Mkw2WfT2-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202407310922.Mkw2WfT2-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/scsi/libfc/fc_elsct.c:16:
>> include/uapi/scsi/fc/fc_els.h:1131:15: error: expected parameter declarator
    1131 | static_assert(offsetof(struct fc_df_desc_fpin_reg, desc_tags) == sizeof(struct fc_df_desc_fpin_reg_hdr),
         |               ^
   include/linux/stddef.h:16:32: note: expanded from macro 'offsetof'
      16 | #define offsetof(TYPE, MEMBER)  __builtin_offsetof(TYPE, MEMBER)
         |                                 ^
   In file included from drivers/scsi/libfc/fc_elsct.c:16:
>> include/uapi/scsi/fc/fc_els.h:1131:15: error: expected ')'
   include/linux/stddef.h:16:32: note: expanded from macro 'offsetof'
      16 | #define offsetof(TYPE, MEMBER)  __builtin_offsetof(TYPE, MEMBER)
         |                                 ^
   include/uapi/scsi/fc/fc_els.h:1131:14: note: to match this '('
    1131 | static_assert(offsetof(struct fc_df_desc_fpin_reg, desc_tags) == sizeof(struct fc_df_desc_fpin_reg_hdr),
         |              ^
>> include/uapi/scsi/fc/fc_els.h:1131:1: error: type specifier missing, defaults to 'int'; ISO C99 and later do not support implicit int [-Wimplicit-int]
    1131 | static_assert(offsetof(struct fc_df_desc_fpin_reg, desc_tags) == sizeof(struct fc_df_desc_fpin_reg_hdr),
         | ^
         | int
>> include/uapi/scsi/fc/fc_els.h:1131:14: error: a function declaration without a prototype is deprecated in all versions of C [-Werror,-Wstrict-prototypes]
    1131 | static_assert(offsetof(struct fc_df_desc_fpin_reg, desc_tags) == sizeof(struct fc_df_desc_fpin_reg_hdr),
         |              ^
    1132 |               "struct member likely outside of __struct_group()");
         |                                                                 
         |                                                                 void
   include/uapi/scsi/fc/fc_els.h:1149:15: error: expected parameter declarator
    1149 | static_assert(offsetof(struct fc_els_rdf, desc) == sizeof(struct fc_els_rdf_hdr),
         |               ^
   include/linux/stddef.h:16:32: note: expanded from macro 'offsetof'
      16 | #define offsetof(TYPE, MEMBER)  __builtin_offsetof(TYPE, MEMBER)
         |                                 ^
   In file included from drivers/scsi/libfc/fc_elsct.c:16:
   include/uapi/scsi/fc/fc_els.h:1149:15: error: expected ')'
   include/linux/stddef.h:16:32: note: expanded from macro 'offsetof'
      16 | #define offsetof(TYPE, MEMBER)  __builtin_offsetof(TYPE, MEMBER)
         |                                 ^
   include/uapi/scsi/fc/fc_els.h:1149:14: note: to match this '('
    1149 | static_assert(offsetof(struct fc_els_rdf, desc) == sizeof(struct fc_els_rdf_hdr),
         |              ^
   include/uapi/scsi/fc/fc_els.h:1149:1: error: type specifier missing, defaults to 'int'; ISO C99 and later do not support implicit int [-Wimplicit-int]
    1149 | static_assert(offsetof(struct fc_els_rdf, desc) == sizeof(struct fc_els_rdf_hdr),
         | ^
         | int
   include/uapi/scsi/fc/fc_els.h:1149:14: error: a function declaration without a prototype is deprecated in all versions of C [-Werror,-Wstrict-prototypes]
    1149 | static_assert(offsetof(struct fc_els_rdf, desc) == sizeof(struct fc_els_rdf_hdr),
         |              ^
    1150 |               "struct member likely outside of __struct_group()");
         |                                                                 
         |                                                                 void
   In file included from drivers/scsi/libfc/fc_elsct.c:17:
   In file included from include/scsi/libfc.h:16:
   In file included from include/scsi/scsi_transport.h:10:
   In file included from include/linux/transport_class.h:11:
   In file included from include/linux/device.h:32:
   In file included from include/linux/device/driver.h:21:
   In file included from include/linux/module.h:19:
   In file included from include/linux/elf.h:6:
   In file included from arch/s390/include/asm/elf.h:168:
   In file included from include/linux/compat.h:17:
   In file included from include/linux/fs.h:33:
   In file included from include/linux/percpu-rwsem.h:7:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:6:
   include/linux/signal.h:98:11: warning: array index 3 is past the end of the array (that has type 'unsigned long[1]') [-Warray-bounds]
      98 |                 return (set->sig[3] | set->sig[2] |
         |                         ^        ~
   arch/s390/include/asm/signal.h:22:9: note: array 'sig' declared here
      22 |         unsigned long sig[_NSIG_WORDS];
         |         ^
   In file included from drivers/scsi/libfc/fc_elsct.c:17:
   In file included from include/scsi/libfc.h:16:
   In file included from include/scsi/scsi_transport.h:10:
   In file included from include/linux/transport_class.h:11:
   In file included from include/linux/device.h:32:
   In file included from include/linux/device/driver.h:21:
   In file included from include/linux/module.h:19:
   In file included from include/linux/elf.h:6:
   In file included from arch/s390/include/asm/elf.h:168:
   In file included from include/linux/compat.h:17:
   In file included from include/linux/fs.h:33:
   In file included from include/linux/percpu-rwsem.h:7:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:6:
   include/linux/signal.h:98:25: warning: array index 2 is past the end of the array (that has type 'unsigned long[1]') [-Warray-bounds]
      98 |                 return (set->sig[3] | set->sig[2] |
         |                                       ^        ~
   arch/s390/include/asm/signal.h:22:9: note: array 'sig' declared here
      22 |         unsigned long sig[_NSIG_WORDS];
         |         ^
   In file included from drivers/scsi/libfc/fc_elsct.c:17:
   In file included from include/scsi/libfc.h:16:
   In file included from include/scsi/scsi_transport.h:10:
   In file included from include/linux/transport_class.h:11:
   In file included from include/linux/device.h:32:
   In file included from include/linux/device/driver.h:21:
   In file included from include/linux/module.h:19:
   In file included from include/linux/elf.h:6:
   In file included from arch/s390/include/asm/elf.h:168:
   In file included from include/linux/compat.h:17:
   In file included from include/linux/fs.h:33:
   In file included from include/linux/percpu-rwsem.h:7:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:6:
   include/linux/signal.h:99:4: warning: array index 1 is past the end of the array (that has type 'unsigned long[1]') [-Warray-bounds]
      99 |                         set->sig[1] | set->sig[0]) == 0;
         |                         ^        ~
   arch/s390/include/asm/signal.h:22:9: note: array 'sig' declared here
      22 |         unsigned long sig[_NSIG_WORDS];
         |         ^
   In file included from drivers/scsi/libfc/fc_elsct.c:17:
   In file included from include/scsi/libfc.h:16:
   In file included from include/scsi/scsi_transport.h:10:
   In file included from include/linux/transport_class.h:11:
   In file included from include/linux/device.h:32:
   In file included from include/linux/device/driver.h:21:
   In file included from include/linux/module.h:19:
   In file included from include/linux/elf.h:6:
   In file included from arch/s390/include/asm/elf.h:168:
   In file included from include/linux/compat.h:17:
   In file included from include/linux/fs.h:33:


vim +1131 include/uapi/scsi/fc/fc_els.h

  1110	
  1111	/* Diagnostic Function Descriptor - FPIN Registration */
  1112	struct fc_df_desc_fpin_reg {
  1113		/* New members MUST be added within the __struct_group() macro below. */
  1114		__struct_group(fc_df_desc_fpin_reg_hdr, hdr, /* no attrs */,
  1115			__be32		desc_tag; /* FPIN Registration (0x00030001) */
  1116			__be32		desc_len; /* Length of Descriptor (in bytes).
  1117						   * Size of descriptor excluding
  1118						   * desc_tag and desc_len fields.
  1119						   */
  1120			__be32		count;	  /* Number of desc_tags elements */
  1121		);
  1122		__be32		desc_tags[];	/* Array of Descriptor Tags.
  1123						 * Each tag indicates a function
  1124						 * supported by the N_Port (request)
  1125						 * or by the  N_Port and Fabric
  1126						 * Controller (reply; may be a subset
  1127						 * of the request).
  1128						 * See ELS_FN_DTAG_xxx for tag values.
  1129						 */
  1130	};
> 1131	static_assert(offsetof(struct fc_df_desc_fpin_reg, desc_tags) == sizeof(struct fc_df_desc_fpin_reg_hdr),
  1132		      "struct member likely outside of __struct_group()");
  1133	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

