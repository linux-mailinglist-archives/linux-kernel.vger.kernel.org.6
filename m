Return-Path: <linux-kernel+bounces-351709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1D1D991516
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 09:37:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E923A1C21C73
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 07:37:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2AEE130A73;
	Sat,  5 Oct 2024 07:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FDVKVwKN"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49F6922EF4
	for <linux-kernel@vger.kernel.org>; Sat,  5 Oct 2024 07:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728113825; cv=none; b=dtd6dt3dAMHgGpTkBokfmP+4lsU11S+SgF9fSxjpcNG0OoGa7eMh7UArQA3SZlv7iF81wi5NEiWodKpp6PPGsiopgoUWnXoiWmd6F4gWBHHT5ZczbCxLpQt/RXYDNRSdteTewKBpVOrRZvJd5r4swQIQUEktnxOKjh+wxU+fGw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728113825; c=relaxed/simple;
	bh=7QsfAUesIwsyo251sdvhJLi5vbdFFwiEhqwdpjClz0k=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=UcpOqb1YFPU72yjwg6Xk6ouLOKI+Ucz5AaBwlU36c/sEYZJmjQJqAWD9AIjCeYaCcXmwp8eOEQ74Ct0iuD2Aon2LRqsLKpF4vK0oH0cHfVawfDd39AIXPY0zVTx5rBTIuiLTr75O/triiBC6X+FQuZKfc70B7aB4bz6TsyACFYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FDVKVwKN; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728113823; x=1759649823;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=7QsfAUesIwsyo251sdvhJLi5vbdFFwiEhqwdpjClz0k=;
  b=FDVKVwKNwG90zO8Km1W+zwvisalq2o5xVvYR1H8DBqEWYsRPhzP971fI
   B7hylxAbD9Hd0hhFhLnJpPsMniOL3PUYWVoXz+qldr4WNrhCRDkczZ8Ce
   CxAc4QQoTRvcgOaosQYNJJ5LHimZ3gypsP4bQ1W4Qxn0LW5Gd4N8PHq5U
   bKpD4ZWrpZDmP+gmJw4ASw0hWDJc5eDYTBQHWCzu98ifFIlkJJkGmLUhy
   NKkw7bBWdLO+ZHq0UQMbG+aaLttGf5lJ586hH7ermgp5PBt9JHqOcN0Ud
   e9eYS2f9eJ6b1BXX0+sBYNQsx7MvBikD3IsRqDUzQ+P+cvhDRjPW3BK4h
   g==;
X-CSE-ConnectionGUID: zjzSkKZNQPiL92ingVfdnQ==
X-CSE-MsgGUID: BDG7Dm/mRZqgLq2DerqrSQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11215"; a="44860262"
X-IronPort-AV: E=Sophos;i="6.11,179,1725346800"; 
   d="scan'208";a="44860262"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2024 00:37:03 -0700
X-CSE-ConnectionGUID: mBJ0b46fS8iROa26GYn+Vg==
X-CSE-MsgGUID: 7iohqpDxQByH1F87n0RKhg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,179,1725346800"; 
   d="scan'208";a="74511508"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 05 Oct 2024 00:37:02 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1swzLX-0002k6-2D;
	Sat, 05 Oct 2024 07:36:59 +0000
Date: Sat, 5 Oct 2024 15:36:15 +0800
From: kernel test robot <lkp@intel.com>
To: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: drivers/gpu/drm/sti/sti_mixer.c:145:47: sparse: sparse: incorrect
 type in argument 1 (different address spaces)
Message-ID: <202410051504.tmcbQl23-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Ville,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   27cc6fdf720183dce1dbd293483ec5a9cb6b595e
commit: 74bde7581df3e18061119e1b27b63d0a9ea57b7a drm/sti: Allow build with COMPILE_TEST=y
date:   4 months ago
config: sh-randconfig-r111-20241004 (https://download.01.org/0day-ci/archive/20241005/202410051504.tmcbQl23-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 14.1.0
reproduce: (https://download.01.org/0day-ci/archive/20241005/202410051504.tmcbQl23-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410051504.tmcbQl23-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/gpu/drm/sti/sti_mixer.c:145:47: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got void * @@
   drivers/gpu/drm/sti/sti_mixer.c:145:47: sparse:     expected void const volatile [noderef] __iomem *ptr
   drivers/gpu/drm/sti/sti_mixer.c:145:47: sparse:     got void *
   drivers/gpu/drm/sti/sti_mixer.c:168:38: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void *addr @@     got void [noderef] __iomem * @@
   drivers/gpu/drm/sti/sti_mixer.c:168:38: sparse:     expected void *addr
   drivers/gpu/drm/sti/sti_mixer.c:168:38: sparse:     got void [noderef] __iomem *

vim +145 drivers/gpu/drm/sti/sti_mixer.c

a5f81078a56c6a Vincent Abriou 2016-02-04  139  
a5f81078a56c6a Vincent Abriou 2016-02-04  140  static void mixer_dbg_mxn(struct seq_file *s, void *addr)
a5f81078a56c6a Vincent Abriou 2016-02-04  141  {
a5f81078a56c6a Vincent Abriou 2016-02-04  142  	int i;
a5f81078a56c6a Vincent Abriou 2016-02-04  143  
a5f81078a56c6a Vincent Abriou 2016-02-04  144  	for (i = 1; i < 8; i++)
a5f81078a56c6a Vincent Abriou 2016-02-04 @145  		seq_printf(s, "-0x%08X", (int)readl(addr + i * 4));
a5f81078a56c6a Vincent Abriou 2016-02-04  146  }
a5f81078a56c6a Vincent Abriou 2016-02-04  147  

:::::: The code at line 145 was first introduced by commit
:::::: a5f81078a56c6ab57b7db2402ac64c34338004c5 drm/sti: add debugfs entries for MIXER crtc

:::::: TO: Vincent Abriou <vincent.abriou@st.com>
:::::: CC: Vincent Abriou <vincent.abriou@st.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

