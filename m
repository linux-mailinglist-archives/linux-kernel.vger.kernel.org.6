Return-Path: <linux-kernel+bounces-264464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DA4693E3A1
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jul 2024 06:49:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A8DCB21519
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jul 2024 04:49:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC9F279C0;
	Sun, 28 Jul 2024 04:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="abA6lAyM"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 359D263D5
	for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2024 04:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722142140; cv=none; b=Yykx0fOmVMKnVF6MAT7ehkboBToqGqsgv69IxEugW5JH/9m9u0E/mO4AFBszA/+6HvyDPGBgq7pH7Mn8MfYrNd/SgFt8UWhv4CfGXuevX2FB2QuHg2DZ3v5tqBLrGJAjy+fwZLDdnZbHdx/ltNdHzEjRfDId8jeFx4A/QC+/Ky8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722142140; c=relaxed/simple;
	bh=vkNaj3JJyNEb2zE0OhedRCB9G8l/gugfivYlfLAJERA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=AeZ2SQ/SO/wwNnsIhWKfBmSDqCxkYnOPy4Ojd85zOyCgVhIatUgZQCprFErkfvAd7q27fFkGhx8PKZgCcvDMb1fFo1n2Ub8uq5x+WPJzm04xl3FwfXbhHlL+pDZWVBbZXEI7dgUF9TxEokMMCvM+vrzo9C9SzCLSqSyS1IlktNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=abA6lAyM; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722142138; x=1753678138;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=vkNaj3JJyNEb2zE0OhedRCB9G8l/gugfivYlfLAJERA=;
  b=abA6lAyMD5BcmFlszrSOQ6X3SVkLr+dIg9D7lOn4t1E35H95i6cbRGIS
   PRrkjq5jVeFqF3YtPl5sLfsf9zsmNmD3NkZXWLiX40jl9t9WMl/YChYc6
   WFK9vWB8Ret4iDGPyUpnFjTw7EJOvUfhzu/8KYOEt7DoJMYrhgwVnB05V
   Xk59m6Zs8IB3l25z4SIlOJcMcrWIEJKz0mAUUEtZeSEyrptTdP1B3tpaa
   hgnQnQD248l60TnwlYG4Txk2fnFoy85JcMft8LFa6ZpqGPUCRmg44xVqb
   sWudieWjgaa5A4SghPdBGzEjlh/UfA9Et9GYmSmN6Q6PU75WEVP8CTOyw
   g==;
X-CSE-ConnectionGUID: RM/hH3RCSXa2Nq6ddefa/Q==
X-CSE-MsgGUID: x1q6Ug3vRb6Q3SiTZbuvWg==
X-IronPort-AV: E=McAfee;i="6700,10204,11146"; a="23751560"
X-IronPort-AV: E=Sophos;i="6.09,243,1716274800"; 
   d="scan'208";a="23751560"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2024 21:48:53 -0700
X-CSE-ConnectionGUID: JCloFiPCSoWgyuo5o5nH0w==
X-CSE-MsgGUID: kikLYrL6RvSgdcXYUSaMBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,243,1716274800"; 
   d="scan'208";a="84597264"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 27 Jul 2024 21:48:52 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sXvpx-000qVy-1z;
	Sun, 28 Jul 2024 04:48:49 +0000
Date: Sun, 28 Jul 2024 12:48:05 +0800
From: kernel test robot <lkp@intel.com>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	"Gustavo A. R. Silva" <gustavo@embeddedor.com>,
	LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars:testing/wfamnae-next20240726-cbc 14/14]
 usr/include/linux/ethtool.h:1645:15: error: expected parameter declarator
Message-ID: <202407281233.Rlzs3LRF-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git testing/wfamnae-next20240726-cbc
head:   bd10b39e2b713a2f9fe8715278e9d4bee9253e24
commit: bd10b39e2b713a2f9fe8715278e9d4bee9253e24 [14/14] ethtool: Avoid -Wflex-array-member-not-at-end warning
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20240728/202407281233.Rlzs3LRF-lkp@intel.com/config)
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240728/202407281233.Rlzs3LRF-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202407281233.Rlzs3LRF-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from <built-in>:1:
   In file included from ./usr/include/linux/mdio.h:15:
   In file included from usr/include/linux/mii.h:13:
>> usr/include/linux/ethtool.h:1645:15: error: expected parameter declarator
    1645 | static_assert(offsetof(struct ethtool_dump, data) == sizeof(struct ethtool_dump_hdr),
         |               ^
   /opt/cross/clang-617a15a9ea/lib/clang/18/include/__stddef_offsetof.h:16:24: note: expanded from macro 'offsetof'
      16 | #define offsetof(t, d) __builtin_offsetof(t, d)
         |                        ^
   In file included from <built-in>:1:
   In file included from ./usr/include/linux/mdio.h:15:
   In file included from usr/include/linux/mii.h:13:
   usr/include/linux/ethtool.h:1645:15: error: expected ')'
   /opt/cross/clang-617a15a9ea/lib/clang/18/include/__stddef_offsetof.h:16:24: note: expanded from macro 'offsetof'
      16 | #define offsetof(t, d) __builtin_offsetof(t, d)
         |                        ^
   usr/include/linux/ethtool.h:1645:14: note: to match this '('
    1645 | static_assert(offsetof(struct ethtool_dump, data) == sizeof(struct ethtool_dump_hdr),
         |              ^
   usr/include/linux/ethtool.h:1645:1: warning: type specifier missing, defaults to 'int' [-Wimplicit-int]
    1645 | static_assert(offsetof(struct ethtool_dump, data) == sizeof(struct ethtool_dump_hdr),
         | ^
         | int
   1 warning and 2 errors generated.
--
   In file included from <built-in>:1:
>> ./usr/include/linux/ethtool.h:1645:15: error: expected parameter declarator
    1645 | static_assert(offsetof(struct ethtool_dump, data) == sizeof(struct ethtool_dump_hdr),
         |               ^
   /opt/cross/clang-617a15a9ea/lib/clang/18/include/__stddef_offsetof.h:16:24: note: expanded from macro 'offsetof'
      16 | #define offsetof(t, d) __builtin_offsetof(t, d)
         |                        ^
   In file included from <built-in>:1:
   ./usr/include/linux/ethtool.h:1645:15: error: expected ')'
   /opt/cross/clang-617a15a9ea/lib/clang/18/include/__stddef_offsetof.h:16:24: note: expanded from macro 'offsetof'
      16 | #define offsetof(t, d) __builtin_offsetof(t, d)
         |                        ^
   ./usr/include/linux/ethtool.h:1645:14: note: to match this '('
    1645 | static_assert(offsetof(struct ethtool_dump, data) == sizeof(struct ethtool_dump_hdr),
         |              ^
   ./usr/include/linux/ethtool.h:1645:1: warning: type specifier missing, defaults to 'int' [-Wimplicit-int]
    1645 | static_assert(offsetof(struct ethtool_dump, data) == sizeof(struct ethtool_dump_hdr),
         | ^
         | int
   1 warning and 2 errors generated.

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

