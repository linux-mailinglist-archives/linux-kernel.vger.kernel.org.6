Return-Path: <linux-kernel+bounces-527491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8769A40BCC
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 22:51:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFA93178F9D
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 21:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30925202C53;
	Sat, 22 Feb 2025 21:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eTPqoxW3"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7812DCA5A
	for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 21:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740261058; cv=none; b=NKu6d4IBnSqu8GOsYfb4qLFgRaEWtv3IwkVZGb6O86E3QTFzMVnFQAoVreRbQUdaoZnS41w7pl2v04ylVCl98wBqyDCmffPGzNKfmkrV4MrXH5m0P8LSr71TRWVz7pc2FnWhl4DfJwrgHdOzzYL2PYldquJEfhptP6DbxFsH8Z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740261058; c=relaxed/simple;
	bh=TsRNaCiBwhb8aWV+R66NFreX8r9V2ZMiX4UrVeScVBI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=G/aAL74yQ3NuNwH4bR3LU8Xwq39ucc3g2p+vi/AbJII/27O8AfPuKJp0k8sTYiLFgPhMTiV56fDM1X0e8AAY4Z4K3qJFjkNcnOu7hXRI5DIuJxXb4YfqxcwDPp1f/s3E5moU8eJPdO1bakJiFeHAn4d6gT6STpyva4YA0K1DYaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eTPqoxW3; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740261056; x=1771797056;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=TsRNaCiBwhb8aWV+R66NFreX8r9V2ZMiX4UrVeScVBI=;
  b=eTPqoxW3iHuaTJ54aJmfwklrhOPDsVaBcoOWobIXmQhz4Wn1sIwZ5C7A
   T+YwFfd4Jrl0yMYIw1VNAoUNIgZkRAvqua5kpEGoAP6lxVrRECGDdA6k4
   JK9LSM7EwyWT7boUqNXwoLIoKOA3mZdjOiyRZ0pwEgpymA/tMtObtXxxo
   YW1LhT3cYCpJMqloYifVR+t55B60xljHbqS9LQoXrmIR46nOLRH/TwqLG
   XlJF0ZAKMnrmwi4q1nATLbBr+qETEWVzxD51a+0vmg3kqX3dvQXMavQJd
   QNVRCLg/52lqEaFH2CT4LpESKBTLxF0HpJfPrQEY5FCobtyupdnmiKPqu
   Q==;
X-CSE-ConnectionGUID: XmuiPkPQQUao4A5UQTgz4A==
X-CSE-MsgGUID: Tpvb16xRRJSNhHBS9IwzLg==
X-IronPort-AV: E=McAfee;i="6700,10204,11353"; a="52457525"
X-IronPort-AV: E=Sophos;i="6.13,308,1732608000"; 
   d="scan'208";a="52457525"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2025 13:50:55 -0800
X-CSE-ConnectionGUID: SFJzLQpFSmWvEDu+E8ugUQ==
X-CSE-MsgGUID: lbGqOC8jR8iNhKlF6l4tEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,308,1732608000"; 
   d="scan'208";a="116206479"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by fmviesa010.fm.intel.com with ESMTP; 22 Feb 2025 13:50:54 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tlxOe-0006vr-1Z;
	Sat, 22 Feb 2025 21:50:52 +0000
Date: Sun, 23 Feb 2025 05:49:54 +0800
From: kernel test robot <lkp@intel.com>
To: Elizabeth Figura <zfigura@codeweavers.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: include/linux/thread_info.h:259:25: error: call to '__bad_copy_to'
 declared with attribute error: copy destination size is too small
Message-ID: <202502230554.IA0tyUeS-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Elizabeth,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   5cf80612d3f72c46ad53ef5042b4c609c393122f
commit: c301e1fefc2d6c83a2beb47e9cdd7b59a90b0067 ntsync: No longer depend on BROKEN.
date:   6 weeks ago
config: i386-buildonly-randconfig-002-20250221 (https://download.01.org/0day-ci/archive/20250223/202502230554.IA0tyUeS-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250223/202502230554.IA0tyUeS-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502230554.IA0tyUeS-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/linux/spinlock.h:60,
                    from include/linux/wait.h:9,
                    from include/linux/wait_bit.h:8,
                    from include/linux/fs.h:6,
                    from drivers/misc/ntsync.c:11:
   In function 'check_copy_size',
       inlined from 'copy_from_user' at include/linux/uaccess.h:207:7,
       inlined from 'setup_wait' at drivers/misc/ntsync.c:888:6:
>> include/linux/thread_info.h:259:25: error: call to '__bad_copy_to' declared with attribute error: copy destination size is too small
     259 |                         __bad_copy_to();
         |                         ^~~~~~~~~~~~~~~


vim +/__bad_copy_to +259 include/linux/thread_info.h

b0377fedb65280 Al Viro   2017-06-29  248  
9dd819a15162f8 Kees Cook 2019-09-25  249  static __always_inline __must_check bool
b0377fedb65280 Al Viro   2017-06-29  250  check_copy_size(const void *addr, size_t bytes, bool is_source)
b0377fedb65280 Al Viro   2017-06-29  251  {
c80d92fbb67b2c Kees Cook 2021-06-17  252  	int sz = __builtin_object_size(addr, 0);
b0377fedb65280 Al Viro   2017-06-29  253  	if (unlikely(sz >= 0 && sz < bytes)) {
b0377fedb65280 Al Viro   2017-06-29  254  		if (!__builtin_constant_p(bytes))
b0377fedb65280 Al Viro   2017-06-29  255  			copy_overflow(sz, bytes);
b0377fedb65280 Al Viro   2017-06-29  256  		else if (is_source)
b0377fedb65280 Al Viro   2017-06-29  257  			__bad_copy_from();
b0377fedb65280 Al Viro   2017-06-29  258  		else
b0377fedb65280 Al Viro   2017-06-29 @259  			__bad_copy_to();
b0377fedb65280 Al Viro   2017-06-29  260  		return false;
b0377fedb65280 Al Viro   2017-06-29  261  	}
6d13de1489b6bf Kees Cook 2019-12-04  262  	if (WARN_ON_ONCE(bytes > INT_MAX))
6d13de1489b6bf Kees Cook 2019-12-04  263  		return false;
b0377fedb65280 Al Viro   2017-06-29  264  	check_object_size(addr, bytes, is_source);
b0377fedb65280 Al Viro   2017-06-29  265  	return true;
b0377fedb65280 Al Viro   2017-06-29  266  }
b0377fedb65280 Al Viro   2017-06-29  267  

:::::: The code at line 259 was first introduced by commit
:::::: b0377fedb6528087ed319b0d054d6ed82240372c copy_{to,from}_user(): consolidate object size checks

:::::: TO: Al Viro <viro@zeniv.linux.org.uk>
:::::: CC: Al Viro <viro@zeniv.linux.org.uk>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

