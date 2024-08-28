Return-Path: <linux-kernel+bounces-305558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5FBC963077
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 20:51:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F153CB2337E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 18:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B64BD1AAE21;
	Wed, 28 Aug 2024 18:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="chgFiVgZ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 889C7187FF1
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 18:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724871087; cv=none; b=YxC0VfvcnfDkAopGlTGY5/fJdr2Etum6lPwVrq1R3smmKiVXXHhTqF1PjFsqrZHxgzk9u6H8YITCJV6EZrJEHSQS47Ou7DvafKmzNzWXPmQLGZyjRW7nyVVbUJZVUCZz7Jutuw4oU6tr2LTP4ZUTZT13JxOmiHFf0u0Ox3jchF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724871087; c=relaxed/simple;
	bh=HwoTSusZXXykZGXZLdDem+Nwo2KaZ6R7+q33InlcrZk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=lpUuHgjiVRBqmOd4T0YImBjB7UaGSc74BtcDEi5F/N7/yl+LRGv3inWaLIZkVPeXI8KsIuup/SSSaTY8nifl+ijaNvBwfSzSH7wCYqNF+Z9ZwxJmny9B0RMF7Rhr0tl16FhLBARow5fYojaE1fiowp365tbOx6L4faOHqTyXew0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=chgFiVgZ; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724871086; x=1756407086;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=HwoTSusZXXykZGXZLdDem+Nwo2KaZ6R7+q33InlcrZk=;
  b=chgFiVgZz3SlLiNpDTClmyS1Du9mH4pd+yGBYAQvmWVsqvh2D+EadrQH
   RCB88qs8m/STV7U917dFA3vU3R0NiWHa5D0ACW1VXqF5lggCIbgwXbSPR
   EkGgm2cdMeyeeYdhgu6dZsk1LA5EtPApsLSzJra8FMIoxwjzRIGobFdfG
   eNzaza6aop0v1pWdSw95se21fribtihURiu+mwEP40YA3chq603Fd/Z6E
   Fv+y9rpgrbnZNepM66psus2ifFi/JTSuCV7bzJHMSoVd/y5IjKyT84Xl1
   Yb8SZuKSsOtEGx6FA5jR2C3prBoPQBOKhhbTHFbmD49b1Fb03C+Kwm8W2
   w==;
X-CSE-ConnectionGUID: vdXC9kv2RRemayELwVWurA==
X-CSE-MsgGUID: +KvPukhkSdKks7merMc1rw==
X-IronPort-AV: E=McAfee;i="6700,10204,11178"; a="23585495"
X-IronPort-AV: E=Sophos;i="6.10,183,1719903600"; 
   d="scan'208";a="23585495"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2024 11:51:25 -0700
X-CSE-ConnectionGUID: +N70tb6HRA2j9yKyLURNJg==
X-CSE-MsgGUID: o/uteC5JSqWPEphBET6etA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,183,1719903600"; 
   d="scan'208";a="67461271"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 28 Aug 2024 11:51:24 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sjNlJ-000LGY-2v;
	Wed, 28 Aug 2024 18:51:21 +0000
Date: Thu, 29 Aug 2024 02:50:52 +0800
From: kernel test robot <lkp@intel.com>
To: Gergo Koteles <soyer@irl.hu>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: drivers/platform/x86/ideapad-laptop.o: warning: objtool:
 .text.fan_mode_show: unexpected end of section
Message-ID: <202408290219.BrPO8twi-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   86987d84b968b69a610fd00ab9006c13db193b4e
commit: 7cc06e729460a209b84d3db4db56c9f85f048cc2 platform/x86: ideapad-laptop: add a mutex to synchronize VPC commands
date:   3 weeks ago
config: x86_64-randconfig-r051-20240828 (https://download.01.org/0day-ci/archive/20240829/202408290219.BrPO8twi-lkp@intel.com/config)
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240829/202408290219.BrPO8twi-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408290219.BrPO8twi-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/platform/x86/ideapad-laptop.o: warning: objtool: .text.fan_mode_show: unexpected end of section

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

