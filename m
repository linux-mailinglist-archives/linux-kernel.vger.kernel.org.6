Return-Path: <linux-kernel+bounces-565591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55B05A66B63
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 08:17:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9C75174871
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 07:17:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BB6043151;
	Tue, 18 Mar 2025 07:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PScaWVPs"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF566195808
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 07:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742282266; cv=none; b=kkU9iGCtCtL5uDsEPgwPY56VS1jfHf1F6H7MBgpr2VuTFrN7eiYurO4LGkSCtcD4JO2qfoIC+SVwtufoThWS9Gwx0YCKW3VfEsW2YdzuGhLarAlJk+RmVxIgcFnzDLz0/0f+HWaH9PIMFHXMMT51twstbIeZ/DrCJ+LV4UcfLeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742282266; c=relaxed/simple;
	bh=xGvakVQ4I7CIAbFh6Dj+N2h/vlvQZwPGNMNIWGbMvZg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=H6QfkNzY6GvS7r3vhsbGFKqwpZBLSau7H2M37aBBhLy6nHlUmsq2JHDGpCpLm2qNUyOIH+UKeqD6ghVVUiowfam4c6DinhrM+3qFUvu/AQGgTjSee287q08vB6+KXrcrZbeDrNaMOZ3dE+Qk80WIUyX/SAOucFlP0MomJt2d+RU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PScaWVPs; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742282265; x=1773818265;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=xGvakVQ4I7CIAbFh6Dj+N2h/vlvQZwPGNMNIWGbMvZg=;
  b=PScaWVPsOMqAnteIdm1rRSNCp3kgN0WDF85w9MH54a7bHuEJ9eEyk8km
   HXjewFJ9i0AP6klXrjRpB8zR7Bp/DS5rndmRR+b2NC6FHDxrd+kO1FuOq
   f8208yzzMl31LiOzmtvviPM/BopbaLEkVw+oBZ0hbi9nXf0RoDPd8jZuM
   lqmpejqaITTalcwJ7eDh4YtHpDY5t662bjeV7uwdKlaPDyg3oLbLJEPLC
   Tzs8oGzYZVHy/da0Acy5cKINcTz80a4hU1GmNG62xbSk9W/iAXpk+tnBn
   fGgJFrZs69d7u/YWzvYK7ACKZqY6KIqNEHBljFQ0hO9GHcw3COZNtg5R5
   g==;
X-CSE-ConnectionGUID: YGmvldQ6Qz+5O0+YuimPPQ==
X-CSE-MsgGUID: 1sGjO4b2SlSFyxV1/I80VA==
X-IronPort-AV: E=McAfee;i="6700,10204,11376"; a="47054521"
X-IronPort-AV: E=Sophos;i="6.14,256,1736841600"; 
   d="scan'208";a="47054521"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2025 00:17:44 -0700
X-CSE-ConnectionGUID: e6jCVCkDSyCbPdQ1d6HTmQ==
X-CSE-MsgGUID: i7sqDo8NRMCF/nlO8e4iGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,256,1736841600"; 
   d="scan'208";a="123121590"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by orviesa008.jf.intel.com with ESMTP; 18 Mar 2025 00:17:43 -0700
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tuRCm-000DVk-2m;
	Tue, 18 Mar 2025 07:17:40 +0000
Date: Tue, 18 Mar 2025 15:16:48 +0800
From: kernel test robot <lkp@intel.com>
To: Namhyung Kim <namhyung@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>
Subject: kernel/bpf/kmem_cache_iter.c:25:1: warning: 'retain' attribute
 ignored
Message-ID: <202503181537.syuSFzVo-lkp@intel.com>
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
commit: 2e9a548009c2d804e55cdd5b0e9903756cf7d9b3 bpf: Add open coded version of kmem_cache iterator
date:   5 months ago
config: mips-allmodconfig (https://download.01.org/0day-ci/archive/20250318/202503181537.syuSFzVo-lkp@intel.com/config)
compiler: mips-linux-gcc (GCC) 11.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250318/202503181537.syuSFzVo-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503181537.syuSFzVo-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> kernel/bpf/kmem_cache_iter.c:25:1: warning: 'retain' attribute ignored [-Wattributes]
      25 | {
         | ^
   kernel/bpf/kmem_cache_iter.c:36:1: warning: 'retain' attribute ignored [-Wattributes]
      36 | {
         | ^
   kernel/bpf/kmem_cache_iter.c:81:1: warning: 'retain' attribute ignored [-Wattributes]
      81 | {
         | ^

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for GET_FREE_REGION
   Depends on [n]: SPARSEMEM [=n]
   Selected by [m]:
   - RESOURCE_KUNIT_TEST [=m] && RUNTIME_TESTING_MENU [=y] && KUNIT [=m]


vim +/retain +25 kernel/bpf/kmem_cache_iter.c

    23	
    24	__bpf_kfunc int bpf_iter_kmem_cache_new(struct bpf_iter_kmem_cache *it)
  > 25	{
    26		struct bpf_iter_kmem_cache_kern *kit = (void *)it;
    27	
    28		BUILD_BUG_ON(sizeof(*kit) > sizeof(*it));
    29		BUILD_BUG_ON(__alignof__(*kit) != __alignof__(*it));
    30	
    31		kit->pos = KMEM_CACHE_POS_START;
    32		return 0;
    33	}
    34	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

