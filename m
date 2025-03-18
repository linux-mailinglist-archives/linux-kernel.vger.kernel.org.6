Return-Path: <linux-kernel+bounces-566726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C074AA67BB6
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 19:12:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E8C0167064
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 18:12:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DAC9212FA2;
	Tue, 18 Mar 2025 18:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZeyrvEkg"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F58C211497
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 18:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742321534; cv=none; b=oD+wcdl1i6PDATn2ZjqbaBQb8Lsz1/080DtUSPH7xcqwFn1riaYWL+OERwpAll9BUHuX0TF//shv0gLWiXEZwyAakvRAUjBYpq7eNOMqw3Sye5hIovLhsG2g0ot61mesPZeDAbU4+Af2YJYzSYT5AJcUF5RPHdJcYOxQeifeAz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742321534; c=relaxed/simple;
	bh=nNuOx0oa3d8FWJfzdjf8A8jsGmhdUvyvymknAhe+uo4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=nB2s3hj4cblW4+tGNosLrs+PcQ/6FiQoBR/HynM2eYDiQXjZWoAx3Plihrn15nT3iI08ltV3aI9fi9+RHeVlzWaGFXAPAoq+mFXhw5aUw/pIwKEgfJRIMMIfZErIZYFedmggrhVX6T3Ca7Vrwk1Y5j6hhm0a4fnRcMUavUw0GJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZeyrvEkg; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742321532; x=1773857532;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=nNuOx0oa3d8FWJfzdjf8A8jsGmhdUvyvymknAhe+uo4=;
  b=ZeyrvEkgT78ZFdSErwub03SjX5yCDNwbARhhMp5/rqtnbCQrLH0O8Z+u
   g16Kl9IZStozkJDtUoKybFxnjYBXyNI3P8Kt7S/saNzh82O3COSgY2T8Q
   GIacYK8DfgygaCY1kN+oGMpug9qDCy87C5sw7FRtAdyY+H0BlzVxvbXEl
   sYTEn0cacBAyB4AJQGE7Hdivd0OPwFjSPzbgXH+lcu5esGeKqTTFbT2Rq
   5tPmxuaKMSUE74RlWhV/QsXzhcUc2raxX7AGOLkTLkv/heOZmlHoSZ3x0
   4vOmJE/xjqm/qlJTWzc46cJJKtn/Yv4nhMfLQzNt6EsgKi3UkowFvQfvm
   A==;
X-CSE-ConnectionGUID: qx5CqNULR+KpF6BzUYBZ/Q==
X-CSE-MsgGUID: hnSTTvCXS0+mbcunT7R9KQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11377"; a="47128012"
X-IronPort-AV: E=Sophos;i="6.14,257,1736841600"; 
   d="scan'208";a="47128012"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2025 11:12:11 -0700
X-CSE-ConnectionGUID: 32mO35lRSeKaPe4JP8BEvg==
X-CSE-MsgGUID: QxCfMGNRTWyx3TTRZGOLEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,257,1736841600"; 
   d="scan'208";a="122519991"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by fmviesa008.fm.intel.com with ESMTP; 18 Mar 2025 11:12:11 -0700
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tubQ8-000E3C-1l;
	Tue, 18 Mar 2025 18:12:08 +0000
Date: Wed, 19 Mar 2025 02:11:56 +0800
From: kernel test robot <lkp@intel.com>
To: Namhyung Kim <namhyung@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>
Subject: mm/slab_common.c:1331:1: warning: 'retain' attribute ignored
Message-ID: <202503190112.kVuDUqV8-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   76b6905c11fd3c6dc4562aefc3e8c4429fefae1e
commit: a992d7a3979120fbd7c13435d27b3da8d9ed095a mm/bpf: Add bpf_get_kmem_cache() kfunc
date:   5 months ago
config: mips-allmodconfig (https://download.01.org/0day-ci/archive/20250319/202503190112.kVuDUqV8-lkp@intel.com/config)
compiler: mips-linux-gcc (GCC) 11.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250319/202503190112.kVuDUqV8-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503190112.kVuDUqV8-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> mm/slab_common.c:1331:1: warning: 'retain' attribute ignored [-Wattributes]
    1331 | {
         | ^

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for GET_FREE_REGION
   Depends on [n]: SPARSEMEM [=n]
   Selected by [m]:
   - RESOURCE_KUNIT_TEST [=m] && RUNTIME_TESTING_MENU [=y] && KUNIT [=m]


vim +/retain +1331 mm/slab_common.c

  1329	
  1330	__bpf_kfunc struct kmem_cache *bpf_get_kmem_cache(u64 addr)
> 1331	{
  1332		struct slab *slab;
  1333	
  1334		if (!virt_addr_valid((void *)(long)addr))
  1335			return NULL;
  1336	
  1337		slab = virt_to_slab((void *)(long)addr);
  1338		return slab ? slab->slab_cache : NULL;
  1339	}
  1340	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

