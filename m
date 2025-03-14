Return-Path: <linux-kernel+bounces-561998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B7757A61A13
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 20:06:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 017AE3B9C20
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 19:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E89BF2040A4;
	Fri, 14 Mar 2025 19:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hAT37glc"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57DB913A26D
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 19:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741979165; cv=none; b=uOX9zXvr1AMXAaMgE9tkqilDzAHMZrKnl5H5NPVyuzyk2DUart4rNk/R0luNK5pi50vB6KDOpPSdVlVwnukzPJ42N21U0uyPeSC7LgiSBdjXkr3mCo821ANqh7Hl1csq1iE8NxzckOUzpgtuAU9ttIFyplQ2onyTT4palps1K84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741979165; c=relaxed/simple;
	bh=BVTMSVCJEOtbhXDRRYx5p27EBsfYi/ZcaWjbmG5NBoY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ZIbICDGrQiKFEY4QUw0wqHUC1UDbavPyayJSdNnx027J8zHL0spx6IGKj8uRcbY3Kh+kY6qCe3FPXQkws9RBW2GYt+fDjUl54Xeh+JMk1MVe3f2LJ2OV8yX2C7BNwOW1cjRLlaCxeZKE4PxvXT15RYf/R11LgmAYNuaEaAFasUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hAT37glc; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741979164; x=1773515164;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=BVTMSVCJEOtbhXDRRYx5p27EBsfYi/ZcaWjbmG5NBoY=;
  b=hAT37glcRpJMP7bQo4eBmCRwwBihZ7Y1zT8P6kyr3wEjpXgweae0HSyV
   luqknmgcsI1Kyf4zp18YU1bQ0dhmpOAFM3ePJgjGXtldZ77Dv0OekyVLC
   v55wl4drtOATtN9Du2YIjbrZCUdDw26jPsANkualpT9lyiqBlQSY8z8Xu
   tpsIW9I/C9IarKMqDZGiyP6YoUKFrZ4tP/kvYPOVzQDpe3wAOr95kVHn4
   LuaJp0LcpcXr2Q7aSL6CpnsZyCe62WV8RDHWQz8CyecWvw+lx7UFIi5db
   VfurBWnCasqRBnZbBSlZ75fppbM6LFwgLXR8UFLyJOqnUHMg6lh4+aaO6
   Q==;
X-CSE-ConnectionGUID: yiyLoYjdQjmQJynVXM0LTw==
X-CSE-MsgGUID: 2yYbw0AkSre7t7q/AkLG0g==
X-IronPort-AV: E=McAfee;i="6700,10204,11373"; a="46792882"
X-IronPort-AV: E=Sophos;i="6.14,246,1736841600"; 
   d="scan'208";a="46792882"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2025 12:06:03 -0700
X-CSE-ConnectionGUID: xXEeTz3DS4GuYYdQfgK0Sw==
X-CSE-MsgGUID: gjQFeXqrQJakLAUx9rXZ0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,246,1736841600"; 
   d="scan'208";a="126566675"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by orviesa005.jf.intel.com with ESMTP; 14 Mar 2025 12:06:01 -0700
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ttAM2-000Aku-2v;
	Fri, 14 Mar 2025 19:05:58 +0000
Date: Sat, 15 Mar 2025 03:05:03 +0800
From: kernel test robot <lkp@intel.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>
Subject: include/uapi/linux/vbox_vmmdev_types.h:239:4: warning: field u
 within 'struct vmmdev_hgcm_function_parameter32' is less aligned than 'union
 (unnamed union at include/uapi/linux/vbox_vmmdev_types.h:223:2)' and is
 usually due to 'struct vmmdev_hgcm_function...
Message-ID: <202503150545.aH9KdkEE-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   695caca9345a160ecd9645abab8e70cfe849e9ff
commit: c99e1e1d0850ff157f1bc16871acd2dff5a9bcc3 vbox: add HAS_IOPORT dependency
date:   3 weeks ago
config: arm-randconfig-002-20250315 (https://download.01.org/0day-ci/archive/20250315/202503150545.aH9KdkEE-lkp@intel.com/config)
compiler: clang version 21.0.0git (https://github.com/llvm/llvm-project 87916f8c32ebd8e284091db9b70339df57fd1e90)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250315/202503150545.aH9KdkEE-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503150545.aH9KdkEE-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/virt/vboxguest/vboxguest_utils.c:19:
   In file included from include/linux/vbox_utils.h:8:
>> include/uapi/linux/vbox_vmmdev_types.h:239:4: warning: field u within 'struct vmmdev_hgcm_function_parameter32' is less aligned than 'union (unnamed union at include/uapi/linux/vbox_vmmdev_types.h:223:2)' and is usually due to 'struct vmmdev_hgcm_function_parameter32' being packed, which can lead to unaligned accesses [-Wunaligned-access]
     239 |         } u;
         |           ^
>> include/uapi/linux/vbox_vmmdev_types.h:254:6: warning: field u within 'struct vmmdev_hgcm_function_parameter64::(unnamed at include/uapi/linux/vbox_vmmdev_types.h:249:3)' is less aligned than 'union (unnamed union at include/uapi/linux/vbox_vmmdev_types.h:251:4)' and is usually due to 'struct vmmdev_hgcm_function_parameter64::(unnamed at include/uapi/linux/vbox_vmmdev_types.h:249:3)' being packed, which can lead to unaligned accesses [-Wunaligned-access]
     254 |                         } u;
         |                           ^
   2 warnings generated.


vim +239 include/uapi/linux/vbox_vmmdev_types.h

f6ddd094f579344 Hans de Goede 2017-11-30  219  
f6ddd094f579344 Hans de Goede 2017-11-30  220  /** HGCM function parameter, 32-bit client. */
f6ddd094f579344 Hans de Goede 2017-11-30  221  struct vmmdev_hgcm_function_parameter32 {
f6ddd094f579344 Hans de Goede 2017-11-30  222  	enum vmmdev_hgcm_function_parameter_type type;
f6ddd094f579344 Hans de Goede 2017-11-30  223  	union {
f6ddd094f579344 Hans de Goede 2017-11-30  224  		__u32 value32;
f6ddd094f579344 Hans de Goede 2017-11-30  225  		__u64 value64;
f6ddd094f579344 Hans de Goede 2017-11-30  226  		struct {
f6ddd094f579344 Hans de Goede 2017-11-30  227  			__u32 size;
f6ddd094f579344 Hans de Goede 2017-11-30  228  			union {
f6ddd094f579344 Hans de Goede 2017-11-30  229  				__u32 phys_addr;
f6ddd094f579344 Hans de Goede 2017-11-30  230  				__u32 linear_addr;
f6ddd094f579344 Hans de Goede 2017-11-30  231  			} u;
f6ddd094f579344 Hans de Goede 2017-11-30  232  		} pointer;
f6ddd094f579344 Hans de Goede 2017-11-30  233  		struct {
f6ddd094f579344 Hans de Goede 2017-11-30  234  			/** Size of the buffer described by the page list. */
f6ddd094f579344 Hans de Goede 2017-11-30  235  			__u32 size;
f6ddd094f579344 Hans de Goede 2017-11-30  236  			/** Relative to the request header. */
f6ddd094f579344 Hans de Goede 2017-11-30  237  			__u32 offset;
f6ddd094f579344 Hans de Goede 2017-11-30  238  		} page_list;
f6ddd094f579344 Hans de Goede 2017-11-30 @239  	} u;
f6ddd094f579344 Hans de Goede 2017-11-30  240  } __packed;
f6ddd094f579344 Hans de Goede 2017-11-30  241  VMMDEV_ASSERT_SIZE(vmmdev_hgcm_function_parameter32, 4 + 8);
f6ddd094f579344 Hans de Goede 2017-11-30  242  
f6ddd094f579344 Hans de Goede 2017-11-30  243  /** HGCM function parameter, 64-bit client. */
f6ddd094f579344 Hans de Goede 2017-11-30  244  struct vmmdev_hgcm_function_parameter64 {
f6ddd094f579344 Hans de Goede 2017-11-30  245  	enum vmmdev_hgcm_function_parameter_type type;
f6ddd094f579344 Hans de Goede 2017-11-30  246  	union {
f6ddd094f579344 Hans de Goede 2017-11-30  247  		__u32 value32;
f6ddd094f579344 Hans de Goede 2017-11-30  248  		__u64 value64;
f6ddd094f579344 Hans de Goede 2017-11-30  249  		struct {
f6ddd094f579344 Hans de Goede 2017-11-30  250  			__u32 size;
f6ddd094f579344 Hans de Goede 2017-11-30  251  			union {
f6ddd094f579344 Hans de Goede 2017-11-30  252  				__u64 phys_addr;
f6ddd094f579344 Hans de Goede 2017-11-30  253  				__u64 linear_addr;
f6ddd094f579344 Hans de Goede 2017-11-30 @254  			} u;
f6ddd094f579344 Hans de Goede 2017-11-30  255  		} __packed pointer;
f6ddd094f579344 Hans de Goede 2017-11-30  256  		struct {
f6ddd094f579344 Hans de Goede 2017-11-30  257  			/** Size of the buffer described by the page list. */
f6ddd094f579344 Hans de Goede 2017-11-30  258  			__u32 size;
f6ddd094f579344 Hans de Goede 2017-11-30  259  			/** Relative to the request header. */
f6ddd094f579344 Hans de Goede 2017-11-30  260  			__u32 offset;
f6ddd094f579344 Hans de Goede 2017-11-30  261  		} page_list;
f6ddd094f579344 Hans de Goede 2017-11-30  262  	} __packed u;
f6ddd094f579344 Hans de Goede 2017-11-30  263  } __packed;
f6ddd094f579344 Hans de Goede 2017-11-30  264  VMMDEV_ASSERT_SIZE(vmmdev_hgcm_function_parameter64, 4 + 12);
f6ddd094f579344 Hans de Goede 2017-11-30  265  

:::::: The code at line 239 was first introduced by commit
:::::: f6ddd094f5793447d594aa9f42032a7aba12b4d2 virt: Add vboxguest driver for Virtual Box Guest integration UAPI

:::::: TO: Hans de Goede <hdegoede@redhat.com>
:::::: CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

