Return-Path: <linux-kernel+bounces-342085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2018988A6C
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 20:53:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CF761C21492
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 18:53:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5F0C1C2317;
	Fri, 27 Sep 2024 18:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JwvKKf75"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A521C230A
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 18:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727463162; cv=none; b=pbqgLjvapoOahKRMtNiELjKvNe32xoNpJ54puPcsLEUf3KWmKxG1v9aaWB/u5SOaUB8srw+fcmSgAGkKXYzYhKSpkHecN9J+IvTolV3+I3GgJTGhGTC0aVsxz10O5l83ZqOiA2vkPwAFkkqngEvzo2AwRjzWXDbXpWJQIZUr1Ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727463162; c=relaxed/simple;
	bh=iVxgqZXjMej+I7kXAg4rzaQYHzcYNrV42cvylIYqPBw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=TIxCcj8j5XdtCFosoJA3IqzZfmni+BGjQC9td88nJIJ8Ox8YPru2oQlmhnWUYNuZIhxOkFyJdSDlAjaCW/TnkY+lSXuyflnvgw5U46VTQwLO+BoFo9xK4oNCrW4VL+LY6SYCc19t1WXz/mcsKj52qX83/GdR/pRzbxARm5a8/t4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JwvKKf75; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727463161; x=1758999161;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=iVxgqZXjMej+I7kXAg4rzaQYHzcYNrV42cvylIYqPBw=;
  b=JwvKKf75oioUUTte4qm5MkDa9LVuu+L5JqsQntmcDHcWMVoKaUwQ12a7
   zwyy8/4AHTnPD06jqUNrDKfZtQ2bsiSCWQeE6lMRn2mLko9TrkN4Z0RRi
   SYbdjfh/Q+ojLfJpTHN5rMNvpklNE5egSNsCOaJRlYOyaJvg+gztD9wnt
   IzO7fnbcJpFIweDYooWa9ydYJANJ3YHT03QPn7PLCqIJ5Om+hoaRfm+oc
   CiVzrDDgRRS3oSSJy9s3l4o3yypsSU8rStG0m6kDQ+JVkqGRsDvUFWNjD
   7vi93SuCezC3yZwhSqj7LbfS0tGBJjKybNFYE1+N2Wpqmd+9vD4ayEnbi
   Q==;
X-CSE-ConnectionGUID: H3JcCYncQCC4/uDYHfuB9Q==
X-CSE-MsgGUID: BZdBfHGURxSVMVXgmK2J+Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11208"; a="49144938"
X-IronPort-AV: E=Sophos;i="6.11,159,1725346800"; 
   d="scan'208";a="49144938"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2024 11:52:40 -0700
X-CSE-ConnectionGUID: xuZQu/GgTcyojCcguQaKEw==
X-CSE-MsgGUID: cQgdAU97TjKW5RHG67Hijw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,159,1725346800"; 
   d="scan'208";a="103428423"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 27 Sep 2024 11:52:39 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1suG4y-000MVf-1S;
	Fri, 27 Sep 2024 18:52:36 +0000
Date: Sat, 28 Sep 2024 02:52:13 +0800
From: kernel test robot <lkp@intel.com>
To: Arnaud Vrac <avrac@freebox.fr>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Marc Gonzalez <mgonzalez@freebox.fr>
Subject: drivers/gpu/drm/msm/hdmi/hdmi_phy_8998.c:156:19: error: unused
 function 'pll_cmp_to_fdata'
Message-ID: <202409280227.wxyNR8Ju-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Arnaud,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   eee280841e1c8188fe9af5536c193d07d184e874
commit: caedbf17c48dcd9f076aa7157c1bb8ab8082c418 drm/msm: add msm8998 hdmi phy/pll support
date:   4 weeks ago
config: i386-buildonly-randconfig-003-20240928 (https://download.01.org/0day-ci/archive/20240928/202409280227.wxyNR8Ju-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240928/202409280227.wxyNR8Ju-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409280227.wxyNR8Ju-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/gpu/drm/msm/hdmi/hdmi_phy_8998.c:156:19: error: unused function 'pll_cmp_to_fdata' [-Werror,-Wunused-function]
     156 | static inline u64 pll_cmp_to_fdata(u32 pll_cmp, unsigned long ref_clk)
         |                   ^~~~~~~~~~~~~~~~
   1 error generated.


vim +/pll_cmp_to_fdata +156 drivers/gpu/drm/msm/hdmi/hdmi_phy_8998.c

   155	
 > 156	static inline u64 pll_cmp_to_fdata(u32 pll_cmp, unsigned long ref_clk)
   157	{
   158		u64 fdata = ((u64)pll_cmp) * ref_clk * 10;
   159	
   160		do_div(fdata, HDMI_PLL_CMP_CNT);
   161	
   162		return fdata;
   163	}
   164	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

