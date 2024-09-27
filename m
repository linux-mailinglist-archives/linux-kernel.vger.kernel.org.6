Return-Path: <linux-kernel+bounces-341701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 85FD49883E5
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 14:08:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05C491F218D1
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 12:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F02A18B478;
	Fri, 27 Sep 2024 12:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GcfACVSh"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5978C187547
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 12:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727438907; cv=none; b=N8lQuwRwvLHjj1k0c3j4U4t4+CUrfvDP6pdk3xJNhATVS7K8ppwnNbm1Wfw0dQ7uBIomRkLPcUDfZbit7n9OyEJpXGRUCkMGRpFRtsOfYCffGzTu7PiLhB7oZ68AmdX6HnboNDbWINNkEhom9I1zAaDgPjYP+v+MG/eEQjEYoCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727438907; c=relaxed/simple;
	bh=RLMlw+uJ+M244jPqFaGEuRaYGbfyUC7YS9DMVRwEq1s=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=rM3nuqEtJtsyOIe1Dj11vkzOU7HcUrTwpTa+rzcHvqZ+R+n9Sx2ECYUmlQ4E1SgyTVIPgnvCQ4KASK1x9lqKn7s9semusVkMN46AI+F//YGcr8I/dzxq/KF0QUeMB/xxAU06cuwDXOlQHXW+XTdeqXYOs2wwgmY7hEYu/2Jd8qM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GcfACVSh; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727438906; x=1758974906;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=RLMlw+uJ+M244jPqFaGEuRaYGbfyUC7YS9DMVRwEq1s=;
  b=GcfACVShWkevrBIPRPDfshxHO5Bwb3YX9DDpTU/UCJ0qJH8VTqGL3uLz
   kG7PxmQ5PICBFbcybtcuhNn4n1iTyuQ3ocKqD8Rd10bNqPWJh83m/vV/o
   o0RmIKtrDw+3yayxP6ef1u9F6WAh4jg31Zwmglqc50vk7TeqFwEie+2LV
   8ch30M001LOGo3aPlVU81veu/19apJuPzuIKlC4cGG3LCnR4bmhXhM/Gm
   XrZwd+ACQ7em6IJ1yfVDKdhGDK0ZyUhfhGEEFdIu5qTbem5iNuf1kJ80y
   6ldH8ztsySsaM6451BU2zhhQxUhaJ/xpsc323IcqaPvBQeJIuUBNDNa3o
   w==;
X-CSE-ConnectionGUID: RUeSurwFTqONpu82G7W/jw==
X-CSE-MsgGUID: +IjQESb8QvmhG4sgIFSLsA==
X-IronPort-AV: E=McAfee;i="6700,10204,11207"; a="26745794"
X-IronPort-AV: E=Sophos;i="6.11,158,1725346800"; 
   d="scan'208";a="26745794"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2024 05:08:17 -0700
X-CSE-ConnectionGUID: XcFd3O09QeiVvhAMHh27zQ==
X-CSE-MsgGUID: 0mgo5EXiTp6DBgnbAPzHWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,158,1725346800"; 
   d="scan'208";a="103308572"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 27 Sep 2024 05:08:15 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1su9lc-000Lsf-04;
	Fri, 27 Sep 2024 12:08:12 +0000
Date: Fri, 27 Sep 2024 20:07:44 +0800
From: kernel test robot <lkp@intel.com>
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Paul Moore <paul@paul-moore.com>, Kees Cook <keescook@chromium.org>,
	Serge Hallyn <serge@hallyn.com>,
	John Johansen <john.johansen@canonical.com>
Subject: security/lsm_syscalls.c:31:1: sparse: sparse: Using plain integer as
 NULL pointer
Message-ID: <202409272033.h0DMpeW3-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   075dbe9f6e3c21596c5245826a4ee1f1c1676eb8
commit: a04a1198088a1378d0389c250cc684f649bcc91e LSM: syscalls for current process attributes
date:   11 months ago
config: s390-randconfig-r132-20240927 (https://download.01.org/0day-ci/archive/20240927/202409272033.h0DMpeW3-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 14.1.0
reproduce: (https://download.01.org/0day-ci/archive/20240927/202409272033.h0DMpeW3-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409272033.h0DMpeW3-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> security/lsm_syscalls.c:31:1: sparse: sparse: Using plain integer as NULL pointer
>> security/lsm_syscalls.c:31:1: sparse: sparse: Using plain integer as NULL pointer
   security/lsm_syscalls.c:53:1: sparse: sparse: Using plain integer as NULL pointer
   security/lsm_syscalls.c:53:1: sparse: sparse: Using plain integer as NULL pointer
   security/lsm_syscalls.c:53:1: sparse: sparse: Using plain integer as NULL pointer
   security/lsm_syscalls.c:53:1: sparse: sparse: Using plain integer as NULL pointer

vim +31 security/lsm_syscalls.c

    19	
    20	/**
    21	 * sys_lsm_set_self_attr - Set current task's security module attribute
    22	 * @attr: which attribute to set
    23	 * @ctx: the LSM contexts
    24	 * @size: size of @ctx
    25	 * @flags: reserved for future use
    26	 *
    27	 * Sets the calling task's LSM context. On success this function
    28	 * returns 0. If the attribute specified cannot be set a negative
    29	 * value indicating the reason for the error is returned.
    30	 */
  > 31	SYSCALL_DEFINE4(lsm_set_self_attr, unsigned int, attr, struct lsm_ctx __user *,
    32			ctx, size_t, size, u32, flags)
    33	{
    34		return security_setselfattr(attr, ctx, size, flags);
    35	}
    36	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

