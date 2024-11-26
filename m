Return-Path: <linux-kernel+bounces-422114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EFE99D94D4
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 10:47:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE92BB2FA71
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 09:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61FC61BCA0D;
	Tue, 26 Nov 2024 09:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LVv9XbTo"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 307C21BC069
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 09:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732614078; cv=none; b=eMeAtKENT+Wnkjrb3R4PFRPonNBXPEeoPFPJglnvIHUQD5bHnciCar/EIoW/O3rv+fpjOwhtZaMsHMV7ZQWlN9mWnWwQUaPsvCz7oAyQm3e8vJgltSFkjtHOyMJv8IWqHw3dB0kt9F6lPKusfCAvnCHduBftBnMr89jJ1l9UBpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732614078; c=relaxed/simple;
	bh=r9OdyuisfODo21e6dDcPEBT9eEaMBrGCdnaFDAeXrPI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=GbU0U8Q0pPWnGEud7VtKDUxSRD9GDTtSn+jTfAs6HpaEzFoZQC05SFbv4fd/xrozf6YoNBsT9zqtriDRGTSuQAdTcaNpIsVk8rCHcFDbBIYOj63SVX0e1AqM8z8gNxa/kyzUup64XmlWLcOkwPE+qsc7kA+I8Gk/T2Y8BzFPkgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LVv9XbTo; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732614077; x=1764150077;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=r9OdyuisfODo21e6dDcPEBT9eEaMBrGCdnaFDAeXrPI=;
  b=LVv9XbToOmA9xX4ZXWx3U4ea1VqLi+XyPYkAHFbwC3gzkm7vyTBfIvDm
   nlw8FQzJBZvkhq4UjBntSu5CC86qM6hfY86omJknzYTnHp56USE3UH1je
   W3KmSWqjBcWIwzuuf7LI7nF49vgoNYO8WhNnyTzU5qH6L5FU8m+EU9nUK
   mWbalePMdmvSVEcmlIfGvbHN58y89nOW/qP/zmdmS4Pktv6dVYBcPn+1X
   lpzzkTunYebrk5fsOpiv9YayFnTRhgs1z8sTjJnrgT19cNsQTO846voux
   6bMsmXbPdx4g9Ia0jT8oTBFDiTNYRNn+nBIoR8vYpI/OnhmNJ5fe390aA
   g==;
X-CSE-ConnectionGUID: xPsJx2qKTRaD1WyVWa0A0Q==
X-CSE-MsgGUID: oovI521zSRiqz/347m5/fQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11267"; a="32135557"
X-IronPort-AV: E=Sophos;i="6.12,185,1728975600"; 
   d="scan'208";a="32135557"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2024 01:41:16 -0800
X-CSE-ConnectionGUID: iKyZx3eATMqg6BagnRRgaw==
X-CSE-MsgGUID: Ipu79WXaS5K0MVW2bIA3+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,185,1728975600"; 
   d="scan'208";a="96485714"
Received: from lkp-server01.sh.intel.com (HELO 8122d2fc1967) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 26 Nov 2024 01:41:14 -0800
Received: from kbuild by 8122d2fc1967 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tFs4F-0007Cp-2L;
	Tue, 26 Nov 2024 09:41:11 +0000
Date: Tue, 26 Nov 2024 17:40:16 +0800
From: kernel test robot <lkp@intel.com>
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Paul Moore <paul@paul-moore.com>, Kees Cook <keescook@chromium.org>,
	Serge Hallyn <serge@hallyn.com>,
	John Johansen <john.johansen@canonical.com>
Subject: security/lsm_syscalls.c:31:1: sparse: sparse: Using plain integer as
 NULL pointer
Message-ID: <202411261712.iIifCLEW-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   7eef7e306d3c40a0c5b9ff6adc9b273cc894dbd5
commit: a04a1198088a1378d0389c250cc684f649bcc91e LSM: syscalls for current process attributes
date:   1 year ago
config: s390-randconfig-r132-20241126 (https://download.01.org/0day-ci/archive/20241126/202411261712.iIifCLEW-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 14.2.0
reproduce: (https://download.01.org/0day-ci/archive/20241126/202411261712.iIifCLEW-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411261712.iIifCLEW-lkp@intel.com/

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

