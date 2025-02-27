Return-Path: <linux-kernel+bounces-536556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D11EAA4817D
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 15:36:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9646E168DF3
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 14:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 329E623496B;
	Thu, 27 Feb 2025 14:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IbZznSNC"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0E3822C35C
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 14:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740665964; cv=none; b=AeeB3riYazFo4gXQGU7AsKAwohDh/6hsyIlnwS+zgPB7yNSlM9sDVH3gQa1BN3MOAYx6r4PAyFRJqM6qThaygNtIV870KVdZbkBqryT4dGiDYSzhDRbc2koz1sFIgzYwd18pT5TN1w+dp9KPB0GcVQafctAdog/fS5eU0jG+aOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740665964; c=relaxed/simple;
	bh=TYgMdkpmXdiunpeA5m4Ocp06XU1GCSE6nejOB63Id88=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=DIyGH9WEcm38uM3d3BDpC53hWh47me3DypDflMC+fEpLGtz+UsLdTSYFZ6CvKTL+hoehvVVUAyAQjoE5fs8Kfi0mRgioDCnvQERel7vQUUQAYH+1HBTqSHYkoNu3emTVNOnfpAfJ7dJ/D2qPleosXFy1YTmrcm7vwh59Gr1YJ3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IbZznSNC; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740665963; x=1772201963;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=TYgMdkpmXdiunpeA5m4Ocp06XU1GCSE6nejOB63Id88=;
  b=IbZznSNCFneNHVpmH36DCtLJ+o4U9lXl1tFDBkBCz9pVokygDXR1GnH2
   FcYdsMQ5fN7b05lNgLfY+Issrdb26cZeDaUCwLX7/6d7b0eKM9h+7wbIi
   lDxCl48mHjOhVc+iCTcjrqGkdBChF9BKGHg5VZ2gaqfu5/8ygmyDHudbv
   qPeuy7xMBR2CUfprhTm50aYZCr5nXkQZiYq5rRR4oOp8YRIBqJHsmFTLU
   aExs9f2QY+rk5L93EFGoFfv6XvAhHjN5S5ZovvXRIkGFmvck4+2vP79UB
   g9+vc+sIhSrC9pOYEUf+PAZRNplVLTR9wmcgHMAdEWdR8/uTcY2If4Ax7
   A==;
X-CSE-ConnectionGUID: 2GzRGUwkR+yqx7hjkPDonw==
X-CSE-MsgGUID: Ahyg2GtRTdeKz6zHLbX4vQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11358"; a="52196532"
X-IronPort-AV: E=Sophos;i="6.13,319,1732608000"; 
   d="scan'208";a="52196532"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 06:19:22 -0800
X-CSE-ConnectionGUID: 4vgTw4j/SWaNL+Hl82QupQ==
X-CSE-MsgGUID: p/QvSjdQQnSDENyGf2crAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,319,1732608000"; 
   d="scan'208";a="122158475"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by fmviesa004.fm.intel.com with ESMTP; 27 Feb 2025 06:19:21 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tnejN-000DTg-2f;
	Thu, 27 Feb 2025 14:19:18 +0000
Date: Thu, 27 Feb 2025 22:18:36 +0800
From: kernel test robot <lkp@intel.com>
To: Lukasz Luba <l.luba@partner.samsung.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	MyungJoo Ham <myungjoo.ham@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>
Subject: drivers/devfreq/event/exynos-ppmu.c:529:21: warning: cast to smaller
 integer type 'enum exynos_ppmu_type' from 'const void *'
Message-ID: <202502272210.guXvXlHo-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   dd83757f6e686a2188997cb58b5975f744bb7786
commit: 0ae9c3213c2ca34f7e7ebad1436267778d37ba9f PM / devfreq: exynos-events: change matching code during probe
date:   6 years ago
config: x86_64-buildonly-randconfig-006-20250127 (https://download.01.org/0day-ci/archive/20250227/202502272210.guXvXlHo-lkp@intel.com/config)
compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51eccf88f5321e7c60591c5546b254b6afab99)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250227/202502272210.guXvXlHo-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502272210.guXvXlHo-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/devfreq/event/exynos-ppmu.c:19:
   In file included from include/linux/suspend.h:5:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:20:
   include/linux/mm.h:162:2: warning: unannotated fall-through between switch labels [-Wimplicit-fallthrough]
     162 |         case 72:
         |         ^
   include/linux/mm.h:162:2: note: insert '__attribute__((fallthrough));' to silence this warning
     162 |         case 72:
         |         ^
         |         __attribute__((fallthrough)); 
   include/linux/mm.h:162:2: note: insert 'break;' to avoid fall-through
     162 |         case 72:
         |         ^
         |         break; 
   include/linux/mm.h:164:2: warning: unannotated fall-through between switch labels [-Wimplicit-fallthrough]
     164 |         case 64:
         |         ^
   include/linux/mm.h:164:2: note: insert '__attribute__((fallthrough));' to silence this warning
     164 |         case 64:
         |         ^
         |         __attribute__((fallthrough)); 
   include/linux/mm.h:164:2: note: insert 'break;' to avoid fall-through
     164 |         case 64:
         |         ^
         |         break; 
   include/linux/mm.h:166:2: warning: unannotated fall-through between switch labels [-Wimplicit-fallthrough]
     166 |         case 56:
         |         ^
   include/linux/mm.h:166:2: note: insert '__attribute__((fallthrough));' to silence this warning
     166 |         case 56:
         |         ^
         |         __attribute__((fallthrough)); 
   include/linux/mm.h:166:2: note: insert 'break;' to avoid fall-through
     166 |         case 56:
         |         ^
         |         break; 
>> drivers/devfreq/event/exynos-ppmu.c:529:21: warning: cast to smaller integer type 'enum exynos_ppmu_type' from 'const void *' [-Wvoid-pointer-to-enum-cast]
     529 |                 info->ppmu_type = (enum exynos_ppmu_type)of_id->data;
         |                                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   4 warnings generated.


vim +529 drivers/devfreq/event/exynos-ppmu.c

   504	
   505	static int of_get_devfreq_events(struct device_node *np,
   506					 struct exynos_ppmu *info)
   507	{
   508		struct devfreq_event_desc *desc;
   509		struct device *dev = info->dev;
   510		struct device_node *events_np, *node;
   511		int i, j, count;
   512		const struct of_device_id *of_id;
   513	
   514		events_np = of_get_child_by_name(np, "events");
   515		if (!events_np) {
   516			dev_err(dev,
   517				"failed to get child node of devfreq-event devices\n");
   518			return -EINVAL;
   519		}
   520	
   521		count = of_get_child_count(events_np);
   522		desc = devm_kcalloc(dev, count, sizeof(*desc), GFP_KERNEL);
   523		if (!desc)
   524			return -ENOMEM;
   525		info->num_events = count;
   526	
   527		of_id = of_match_device(exynos_ppmu_id_match, dev);
   528		if (of_id)
 > 529			info->ppmu_type = (enum exynos_ppmu_type)of_id->data;
   530		else
   531			return -EINVAL;
   532	
   533		j = 0;
   534		for_each_child_of_node(events_np, node) {
   535			for (i = 0; i < ARRAY_SIZE(ppmu_events); i++) {
   536				if (!ppmu_events[i].name)
   537					continue;
   538	
   539				if (of_node_name_eq(node, ppmu_events[i].name))
   540					break;
   541			}
   542	
   543			if (i == ARRAY_SIZE(ppmu_events)) {
   544				dev_warn(dev,
   545					"don't know how to configure events : %pOFn\n",
   546					node);
   547				continue;
   548			}
   549	
   550			switch (info->ppmu_type) {
   551			case EXYNOS_TYPE_PPMU:
   552				desc[j].ops = &exynos_ppmu_ops;
   553				break;
   554			case EXYNOS_TYPE_PPMU_V2:
   555				desc[j].ops = &exynos_ppmu_v2_ops;
   556				break;
   557			}
   558	
   559			desc[j].driver_data = info;
   560	
   561			of_property_read_string(node, "event-name", &desc[j].name);
   562	
   563			j++;
   564		}
   565		info->desc = desc;
   566	
   567		of_node_put(events_np);
   568	
   569		return 0;
   570	}
   571	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

