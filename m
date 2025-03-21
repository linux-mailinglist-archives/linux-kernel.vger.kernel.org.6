Return-Path: <linux-kernel+bounces-570769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7680EA6B44E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 07:15:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 051303ABFD3
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 06:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00D701EA7C1;
	Fri, 21 Mar 2025 06:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W5vMrqOK"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEA8F1E0E0D
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 06:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742537727; cv=none; b=qgYL+KEByOoz7WB8kk6xVonxn+gLWoLhR1JtJr/ElR40Xx2VQhI0T4RGTyz0xAbePRD9YGT219AeoyTluPfMFIonleffGxSasPHI/kk2LLKgj+0EEbXCUooWgnbWHlSUVvs7s8NQFfsguUEBVMk8bj/dPhIhHVsx38QAwirgP00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742537727; c=relaxed/simple;
	bh=izCCY+JUOv8XIPhPZ529CQx8d2SH7XHgsWIx8qUdB4s=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Yxzlj4Va+synxfoBPivah6HH931QkeTgA/mqvdT4GhrFsbLuToMQUG1pGzH1MARt5cMxh79RHGW+TjFGDbT5TnY4AYqS5DgDShUZ7s6pyYM/8NbCRZdwLUSpfqcbrxWhyr28EWp7u6BHfgyKHr2LAeDR1eX+pOJfe0FJ0GCt89s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W5vMrqOK; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742537726; x=1774073726;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=izCCY+JUOv8XIPhPZ529CQx8d2SH7XHgsWIx8qUdB4s=;
  b=W5vMrqOKlKt8Uq9mS0yTAkhVjzMQE3ZnITPWhClKMzEjOPg73dSjQkV0
   wyiuHRMGtjs1cfBD8cmU9Pgv7rEBr4Ht+Zu56Y+iJpG51kwshIhAuM75G
   Wu/Cr4pF6UAJ100qluNVRWjpFjlpozsTgvPNhfCgyvzb/jAIli31KWbdR
   QRjcTQH/0UB4LFG1IqTEi2ZIJj7CwNENJj0h5fwdpwIh4M5/6slq37lj5
   zOI0x3xJspxHxwJ/OhjDBECT8oBy07BrA/Y4Q8EKxidf8NopLWwoNqKCl
   si3UkETExYt1Cf0dH+NILk1aO+hcrjKUl+D4SarxjG5sEe9jDLnKJ1bEG
   A==;
X-CSE-ConnectionGUID: x+Htvj9wTjC5sQOmLbZ+DA==
X-CSE-MsgGUID: mhrzA0jCRBGkTyMQD3yuTw==
X-IronPort-AV: E=McAfee;i="6700,10204,11379"; a="43983563"
X-IronPort-AV: E=Sophos;i="6.14,263,1736841600"; 
   d="scan'208";a="43983563"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2025 23:15:25 -0700
X-CSE-ConnectionGUID: ljjPuSgVSD2XdB/i7OYOzw==
X-CSE-MsgGUID: 7PJOydRKRFSy0djP18Uewg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,263,1736841600"; 
   d="scan'208";a="123824441"
Received: from lkp-server02.sh.intel.com (HELO e98e3655d6d2) ([10.239.97.151])
  by orviesa007.jf.intel.com with ESMTP; 20 Mar 2025 23:15:23 -0700
Received: from kbuild by e98e3655d6d2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tvVf7-00015f-2L;
	Fri, 21 Mar 2025 06:15:21 +0000
Date: Fri, 21 Mar 2025 14:12:53 +0800
From: kernel test robot <lkp@intel.com>
To: Nirmoy Das <nirmoy.das@intel.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Matthew Auld <matthew.auld@intel.com>
Subject: drivers/gpu/drm/xe/xe_gt.h:27:undefined reference to
 `gt_reset_failure'
Message-ID: <202503211455.NEkMGJB4-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   a1cffe8cc8aef85f1b07c4464f0998b9785b795a
commit: 649f533b7aa2bda13d9ef0a6ef4b0a622b226d2b drm/xe: Add caller info to xe_gt_reset_async
date:   5 months ago
config: sparc64-randconfig-r053-20250319 (https://download.01.org/0day-ci/archive/20250321/202503211455.NEkMGJB4-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 11.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250321/202503211455.NEkMGJB4-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503211455.NEkMGJB4-lkp@intel.com/

All errors (new ones prefixed by >>):

   sparc64-linux-ld: drivers/gpu/drm/xe/xe_gt.o: in function `xe_gt_reset_async':
>> drivers/gpu/drm/xe/xe_gt.h:27:(.text+0x24f0): undefined reference to `gt_reset_failure'
>> sparc64-linux-ld: drivers/gpu/drm/xe/xe_gt.h:27:(.text+0x24fc): undefined reference to `gt_reset_failure'
   sparc64-linux-ld: drivers/gpu/drm/xe/xe_gt.o: in function `gt_reset.isra.0':
   drivers/gpu/drm/xe/xe_gt.h:27:(.text+0x2e10): undefined reference to `gt_reset_failure'
   sparc64-linux-ld: drivers/gpu/drm/xe/xe_gt.h:27:(.text+0x2e1c): undefined reference to `gt_reset_failure'


vim +27 drivers/gpu/drm/xe/xe_gt.h

0d97ecce16bd26 Niranjana Vishwanathapura 2023-10-09  23  
8f3013e0b22206 Himal Prasad Ghimiray     2023-07-27  24  extern struct fault_attr gt_reset_failure;
8f3013e0b22206 Himal Prasad Ghimiray     2023-07-27  25  static inline bool xe_fault_inject_gt_reset(void)
8f3013e0b22206 Himal Prasad Ghimiray     2023-07-27  26  {
8f3013e0b22206 Himal Prasad Ghimiray     2023-07-27 @27  	return should_fail(&gt_reset_failure, 1);
8f3013e0b22206 Himal Prasad Ghimiray     2023-07-27  28  }
8f3013e0b22206 Himal Prasad Ghimiray     2023-07-27  29  

:::::: The code at line 27 was first introduced by commit
:::::: 8f3013e0b22206b27f37dcf1b96ce68df3393040 drm/xe: Introduce fault injection for gt reset

:::::: TO: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
:::::: CC: Rodrigo Vivi <rodrigo.vivi@intel.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

