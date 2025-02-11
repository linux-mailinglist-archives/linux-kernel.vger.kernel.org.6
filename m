Return-Path: <linux-kernel+bounces-510229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9112DA31A04
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 00:56:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10D39188A2E5
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Feb 2025 23:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AF35271806;
	Tue, 11 Feb 2025 23:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oJlbljQd"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BE7D271803
	for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2025 23:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739318186; cv=none; b=PJxr/ACGsqqoyR2bB5pBNTAyhal1yoPKj3C3Fkz9y+PZQwwKN6GRWg0jrLtv/5kNyOHTe/rqtZaDy8Mg+gUfCl4QFTu7wuI2RToTO2miE13/yZRgqJ8GXE16jqKIphcu4zyoivcwVG0qFM1DBgu38QkgdiTjXToiUIX7oisFEcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739318186; c=relaxed/simple;
	bh=a06yrhk9MIi3/WomYRZoNyJjyciAqzNE3F6JZIw87hw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=jJve/FUXaYJkiPozbFthbT9OEcpaplulVEOcOvpwPeyIYoRF60ehtEPJMojEBWqq2eIBIKcUJhefePRBblNdTIAuffIYGiyWlEGdlYOeVAA7T+XF5Ec8iBz8Jne2bnnwVzRvD5XQ5datnnysz+IQlgNzf6s41Tvd9cwZgQakzXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oJlbljQd; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739318185; x=1770854185;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=a06yrhk9MIi3/WomYRZoNyJjyciAqzNE3F6JZIw87hw=;
  b=oJlbljQdrGwer+qLKls1i/6QhBDar0Fd89cv5KnODeb5hupCY9ec+/YD
   AaEhgY35i5DQmiom6jq3cqMaoHUC/kX3N0a1EC/ZMNXFDMi0E1DfU8MS7
   6Q7Q8/2PZekq+o+zR82rQuZIAF2PqVNXRWe0Gyf91FwjEyTtMBE6HkVHi
   vdqUiaWP1TOzHTrs2lA93Ut/ULjeaUcFU1Xgh/fJtzR0y53kL6a5hyWNb
   9DMo9gyzMl2bXyOnHjQmENK6P+y6DGV5rlS7wyzWWdofb3VMHciMl2kuS
   SmxZMF0pYiZzmBIRE2vBNIPwD19GkNdjYsb/HoMO3brZHEHQx2QjW46uH
   w==;
X-CSE-ConnectionGUID: 2LbaEFoqSxizD9OkZ0Dpww==
X-CSE-MsgGUID: QYS6PwsZTNm2H1dZ241BHg==
X-IronPort-AV: E=McAfee;i="6700,10204,11342"; a="39876515"
X-IronPort-AV: E=Sophos;i="6.13,278,1732608000"; 
   d="scan'208";a="39876515"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 15:56:24 -0800
X-CSE-ConnectionGUID: 9KaIq0y8SH+zSAFlEaPMlA==
X-CSE-MsgGUID: y7AU7yh3SRCwXCFaCtsD8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="113135482"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 11 Feb 2025 15:56:22 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ti071-0014qx-2D;
	Tue, 11 Feb 2025 23:56:19 +0000
Date: Wed, 12 Feb 2025 07:55:45 +0800
From: kernel test robot <lkp@intel.com>
To: Sami Tolvanen <samitolvanen@google.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>
Subject: error: gendwarfksyms: process_module: dwarf_get_units failed: no
 debugging information?
Message-ID: <202502120752.U3fOKScQ-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   09fbf3d502050282bf47ab3babe1d4ed54dd1fd8
commit: 9c3681f9b9fd12cdbc4a542df599f1837512f3d5 kbuild: Add gendwarfksyms as an alternative to genksyms
date:   5 weeks ago
config: s390-randconfig-002-20250212 (https://download.01.org/0day-ci/archive/20250212/202502120752.U3fOKScQ-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250212/202502120752.U3fOKScQ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502120752.U3fOKScQ-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

>> error: gendwarfksyms: process_module: dwarf_get_units failed: no debugging information?
--
   In file included from <stdin>:3:
   In file included from arch/s390/include/asm/asm-prototypes.h:4:
>> include/linux/kvm_host.h:1908:24: warning: field 'desc' with variable sized type 'struct kvm_stats_desc' not at the end of a struct or class is a GNU extension [-Wgnu-variable-sized-type-not-at-end]
    1908 |         struct kvm_stats_desc desc;
         |                               ^
   1 warning generated.
>> error: gendwarfksyms: process_module: dwarf_get_units failed: no debugging information?

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

