Return-Path: <linux-kernel+bounces-426461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A9969DF34A
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 22:21:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C01A428126D
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 21:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0506B1AA783;
	Sat, 30 Nov 2024 21:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PwZbIrSQ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4F56146A63
	for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 21:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733001702; cv=none; b=WbDo5+xJqnCrFhWdOl0yxNTPwjlHBuav+/PGFatnNbdtohcOvnSHNqLX2rYHjY2Ln4YQPW6N+xv3cf7fa0OLsZ8EwepRamCLpRXF32wIWKgk0uVFgcA9cfTNV24ZmPIbUtL65KNEAOAU64Lb44BfsTf4+K+u1xp2UqIaIcu2eaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733001702; c=relaxed/simple;
	bh=vhDHRZ4YvqJEMsaNwywMcd5E7eZGg0VUJ+IFCSiNVqM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=vE9nduEVkLYLkzcaKoT71SPG0XhxC+4c406e93w/RqiYtbeBiKUCjF/GvT7EQXnysHLMMRmIOZrk5Rd/gjUaIU7Ss2dRIPFkvDKB2PvJFygprswIOWbLWzWMLEdzOpOLBGbM6C93IkTXNg9wTeJYXZpsEC0I9eYpIx7F5lRIMsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PwZbIrSQ; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733001699; x=1764537699;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=vhDHRZ4YvqJEMsaNwywMcd5E7eZGg0VUJ+IFCSiNVqM=;
  b=PwZbIrSQIQfRjOd+Pv6z2rqo2wfLtgzcK6Mg951Ij3iXCiawT90FUUM0
   Z++ZnX+4mxwm4+hr21K25suj+x5REp1pzLldhVWE5i82jHahvk8xIX97X
   DyErXI3K4sEYf0SjtfboChQgQvsPnmvx/0KCLdNoai6Q4be03E1NgSV7M
   m730j8qWnXi4bWQad8Vr+pMqqNT05ktxEkvYgkxAMrP9uermkuN02WrHq
   lWaK8Uts9RfhFaSNhAV7ug88Vd7F6lwXtKLi83olP/hHPXbf9alAutsri
   MNBM4jCHD3no7U7qUOmM86EsFztuO4eZNy0Kdzn5vOH2/clj02tSniPo2
   Q==;
X-CSE-ConnectionGUID: jE9vA4nlSaeekHKKuXgruw==
X-CSE-MsgGUID: 3EYXJcksRXSmNINJLV+Jmw==
X-IronPort-AV: E=McAfee;i="6700,10204,11272"; a="33340972"
X-IronPort-AV: E=Sophos;i="6.12,199,1728975600"; 
   d="scan'208";a="33340972"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2024 13:21:39 -0800
X-CSE-ConnectionGUID: 6f+krGuhSbef0R5emJRIXg==
X-CSE-MsgGUID: 9z+u9zzmSfa6+O9hjb85Sg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,199,1728975600"; 
   d="scan'208";a="97709704"
Received: from lkp-server02.sh.intel.com (HELO 36a1563c48ff) ([10.239.97.151])
  by orviesa005.jf.intel.com with ESMTP; 30 Nov 2024 13:21:38 -0800
Received: from kbuild by 36a1563c48ff with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tHUuF-0000z5-1O;
	Sat, 30 Nov 2024 21:21:35 +0000
Date: Sun, 1 Dec 2024 05:21:01 +0800
From: kernel test robot <lkp@intel.com>
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Huacai Chen <chenhuacai@kernel.org>,
	Jinyang He <hejinyang@loongson.cn>,
	Youling Tang <tangyouling@loongson.cn>
Subject: arch/loongarch/kernel/machine_kexec.o: warning: objtool: .text:
 unexpected end of section
Message-ID: <202412010508.PLHqFGSx-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Tiezhu,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   0e287d31b62bb53ad81d5e59778384a40f8b6f56
commit: cb8a2ef0848ca80d67d6d56e2df757cfdf6b3355 LoongArch: Add ORC stack unwinder support
date:   9 months ago
config: loongarch-randconfig-r053-20241201 (https://download.01.org/0day-ci/archive/20241201/202412010508.PLHqFGSx-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241201/202412010508.PLHqFGSx-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412010508.PLHqFGSx-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> arch/loongarch/kernel/machine_kexec.o: warning: objtool: .text: unexpected end of section

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

