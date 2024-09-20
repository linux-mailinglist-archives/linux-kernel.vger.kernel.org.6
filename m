Return-Path: <linux-kernel+bounces-333901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A018F97CFB3
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 02:45:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C44D11C22489
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 00:45:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E5008F6C;
	Fri, 20 Sep 2024 00:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UJQRC4+B"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2821E1863E
	for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 00:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726793133; cv=none; b=M0UKJ5ZfPWIgaP6C1ytYtyNLjBW3EelDV7lPfC9uaq9GlC/+GpjJaEJQ8Q+DlnHiy6ytXiMqGJ1MByHoZYORae8AJ8T6R/lAGPw9cHKkyLG9By2Tlhynl6z2gxTGhLfWqzI+LqKxgEcnT+ZAWX3dn8b9rQZ11iZqSCacWIOxd+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726793133; c=relaxed/simple;
	bh=z1bcvZvYpgHmxF3F1PTSk7hV7fd7Q28WZoSKTVsXkyk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=uKKK0LO19nr9TAkW4jWaytX6qs8nPhXpfFM5wgOhm1eXIaNUJJLnNugzX0L+fZG960lI6Mjf5kQS9Sy7tkvqYWg3jfgi2UZOcgoqvzAe7eGo5uB1gLNPjVTtPJzTSaNLFY1b+PMQIU36XU3xiiuJzSL0F34V4BMYwlNV3eOm1Nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UJQRC4+B; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726793131; x=1758329131;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=z1bcvZvYpgHmxF3F1PTSk7hV7fd7Q28WZoSKTVsXkyk=;
  b=UJQRC4+BrlgBfu6sjIqvkqZ5CcJgA+/wMcttnYL1RdjEyySsVLHucKIN
   XC4h6TXfc2XYjujt8ZmrGyuDKUZHr4Qd+AsBlACTRMq0KnT0+hcy+MEuJ
   aVUc0/s5q5rB2hOcl8twoSdbwZsrINzDsnku5/a4RvA+mYo2SHXniYibY
   8ABttw1h8jS4xkAqSliAlYDC7z1tqluj1uIkqsEEsG97E2q4aiavRZR7e
   YdLaltdDYfAq78dwmT4ESWiH1bjRaGxWdOBvv+HWZ+9vCTiJxepMEpAbk
   2IXNMLnuHIzZ/f2crYQKS/4s78ArRSTK8INCEGyd7h06kOtpHCGdVRprB
   w==;
X-CSE-ConnectionGUID: /+eGcxFCRBuC00AnRz+IGQ==
X-CSE-MsgGUID: hQr0eIxsQ5qPGK0rvhJkpA==
X-IronPort-AV: E=McAfee;i="6700,10204,11200"; a="25931879"
X-IronPort-AV: E=Sophos;i="6.10,243,1719903600"; 
   d="scan'208";a="25931879"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2024 17:45:31 -0700
X-CSE-ConnectionGUID: 10GkP/K+RpGtTo+xUVeE/w==
X-CSE-MsgGUID: qUbo3fJ4TE2IybJvTMw7iQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,243,1719903600"; 
   d="scan'208";a="74473945"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 19 Sep 2024 17:45:29 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1srRm3-000DpM-0F;
	Fri, 20 Sep 2024 00:45:27 +0000
Date: Fri, 20 Sep 2024 08:45:18 +0800
From: kernel test robot <lkp@intel.com>
To: Andrea Parri <parri.andrea@gmail.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: include/linux/sync_core.h: asm/sync_core.h is included more than
 once.
Message-ID: <202409200859.fKF5Xs8a-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   2004cef11ea072838f99bd95cefa5c8e45df0847
commit: 4ff4c745a16c4c151a71863420811e7f406c3ec2 locking: Introduce prepare_sync_core_cmd()
date:   7 months ago
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409200859.fKF5Xs8a-lkp@intel.com/

includecheck warnings: (new ones prefixed by >>)
>> include/linux/sync_core.h: asm/sync_core.h is included more than once.

vim +6 include/linux/sync_core.h

     4	
     5	#ifdef CONFIG_ARCH_HAS_SYNC_CORE_BEFORE_USERMODE
   > 6	#include <asm/sync_core.h>
     7	#else
     8	/*
     9	 * This is a dummy sync_core_before_usermode() implementation that can be used
    10	 * on all architectures which return to user-space through core serializing
    11	 * instructions.
    12	 * If your architecture returns to user-space through non-core-serializing
    13	 * instructions, you need to write your own functions.
    14	 */
    15	static inline void sync_core_before_usermode(void)
    16	{
    17	}
    18	#endif
    19	
    20	#ifdef CONFIG_ARCH_HAS_PREPARE_SYNC_CORE_CMD
  > 21	#include <asm/sync_core.h>
    22	#else
    23	/*
    24	 * This is a dummy prepare_sync_core_cmd() implementation that can be used on
    25	 * all architectures which provide unconditional core serializing instructions
    26	 * in switch_mm().
    27	 * If your architecture doesn't provide such core serializing instructions in
    28	 * switch_mm(), you may need to write your own functions.
    29	 */
    30	static inline void prepare_sync_core_cmd(struct mm_struct *mm)
    31	{
    32	}
    33	#endif
    34	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

