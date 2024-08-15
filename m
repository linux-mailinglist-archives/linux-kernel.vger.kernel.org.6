Return-Path: <linux-kernel+bounces-287494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 690D0952864
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 05:48:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20812287436
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 03:48:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3F3739AEB;
	Thu, 15 Aug 2024 03:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kAOsmiZ5"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E74638DC7
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 03:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723693681; cv=none; b=IJrLvbhwAFotV75VeEgsCAAqDjJpzGFu/L+cAdP4wVDi8up6bBL9dZJAkhm81QKdBC6sVRccgG3K/itjtdKTGVoZXPGhuQd8iwUtxG1aUF3xHYPtBX4EcY0Fg71UqTPdV5uYHYV2nO7nL5Kgji7nXZ2UtJlRqDdDo7b/4sN/UVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723693681; c=relaxed/simple;
	bh=8jdHYyzrVxI2ZpkL5OVz0sF9lPZiBIy28lyVU46/0os=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sZ+E1GIH/gPE+uFOmTbnxsBJif3lBkWajciUrVxbwdTSr1ASuxp60qROmI5PF74x3ZxbKZQ8suULbxO8hruwjTABwIfoHqAnoouMa5jpQbMEmHgiIrZ2qidQ+3oW0/lYF44unF9R8RbtKXn6tTSBkZyj324mlJISmYtNNpueVdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kAOsmiZ5; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723693679; x=1755229679;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8jdHYyzrVxI2ZpkL5OVz0sF9lPZiBIy28lyVU46/0os=;
  b=kAOsmiZ5bvUI5SSy7DNz642Thqg7INNpnP45jaUnB+0k8jo5XeLSQaC1
   9adx7HRzcA6TCmmYrlrmisgC0cT1HCRFqvx22myRm5O/0CLDWCuEayjdy
   XQ9wPjUgmU0jni5XZwBrJ+MhDiBP/gkNEWeqiCMnlKF9tPTJp3+B5WRrD
   hzCTNjiKAd51HA3Qt/jHgTovSJzrhifStpF8GX4Z1D2DpgyewzH+YTu2P
   dDutKCzvtIO6+CiKnP/lPGuG5zYxWvis1AAzYlrlMaz638ft+6jDM8yCY
   cRKfTOr4mzm47q3ronYtgGfuk6Ab+xNyDEIoyXNswhfgSKj/3joRuzw6A
   A==;
X-CSE-ConnectionGUID: Lat7vHsdTTePP4JurlEaHA==
X-CSE-MsgGUID: nPgGyE21Q0aiqfOwUdv57w==
X-IronPort-AV: E=McAfee;i="6700,10204,11164"; a="33331257"
X-IronPort-AV: E=Sophos;i="6.10,147,1719903600"; 
   d="scan'208";a="33331257"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2024 20:47:56 -0700
X-CSE-ConnectionGUID: Vx3Y+Qj2RR6DU6eAAKk/kA==
X-CSE-MsgGUID: uBrNHq4XTNq2JJg9geNZCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,147,1719903600"; 
   d="scan'208";a="59389058"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 14 Aug 2024 20:47:54 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1seRSp-00039k-2G;
	Thu, 15 Aug 2024 03:47:51 +0000
Date: Thu, 15 Aug 2024 11:47:49 +0800
From: kernel test robot <lkp@intel.com>
To: bajing <bajing@cmss.chinamobile.com>, w.d.hubbs@gmail.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	chris@the-brannons.com, kirk@reisers.ca,
	samuel.thibault@ens-lyon.org, nicolas@fjasle.eu,
	masahiroy@kernel.org, speakup@linux-speakup.org,
	linux-kernel@vger.kernel.org, bajing <bajing@cmss.chinamobile.com>
Subject: Re: [PATCH] speakup: genmap: initialization the variable
Message-ID: <202408151133.RcP4kFGW-lkp@intel.com>
References: <20240814030243.2138-1-bajing@cmss.chinamobile.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240814030243.2138-1-bajing@cmss.chinamobile.com>

Hi bajing,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.11-rc3 next-20240814]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/bajing/speakup-genmap-initialization-the-variable/20240815-000631
base:   linus/master
patch link:    https://lore.kernel.org/r/20240814030243.2138-1-bajing%40cmss.chinamobile.com
patch subject: [PATCH] speakup: genmap: initialization the variable
config: x86_64-randconfig-005-20240815 (https://download.01.org/0day-ci/archive/20240815/202408151133.RcP4kFGW-lkp@intel.com/config)
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240815/202408151133.RcP4kFGW-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408151133.RcP4kFGW-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/accessibility/speakup/genmap.c:75:3: warning: variable 'lc' is uninitialized when used here [-Wuninitialized]
      75 |                 lc++;
         |                 ^~
   drivers/accessibility/speakup/genmap.c:52:31: note: initialize the variable 'lc' to silence this warning
      52 |         int value, shift_state, i, lc, spk_val = 0, lock_val = 0;
         |                                      ^
         |                                       = 0
   1 warning generated.


vim +/lc +75 drivers/accessibility/speakup/genmap.c

6a5c94d92699b7 Samuel Thibault 2022-06-12  48  
6a5c94d92699b7 Samuel Thibault 2022-06-12  49  int
6a5c94d92699b7 Samuel Thibault 2022-06-12  50  main(int argc, char *argv[])
6a5c94d92699b7 Samuel Thibault 2022-06-12  51  {
1cb16586b0aba7 bajing          2024-08-14  52  	int value, shift_state, i, lc, spk_val = 0, lock_val = 0;
6a5c94d92699b7 Samuel Thibault 2022-06-12  53  	int max_key_used = 0, num_keys_used = 0;
6a5c94d92699b7 Samuel Thibault 2022-06-12  54  	struct st_key *this;
6a5c94d92699b7 Samuel Thibault 2022-06-12  55  	struct st_key_init *p_init;
6a5c94d92699b7 Samuel Thibault 2022-06-12  56  	char buffer[256];
6a5c94d92699b7 Samuel Thibault 2022-06-12  57  
6a5c94d92699b7 Samuel Thibault 2022-06-12  58  	bzero(key_table, sizeof(key_table));
6a5c94d92699b7 Samuel Thibault 2022-06-12  59  	bzero(key_data, sizeof(key_data));
6a5c94d92699b7 Samuel Thibault 2022-06-12  60  
6a5c94d92699b7 Samuel Thibault 2022-06-12  61  	shift_table[0] = 0;
6a5c94d92699b7 Samuel Thibault 2022-06-12  62  	for (i = 1; i <= 16; i++)
6a5c94d92699b7 Samuel Thibault 2022-06-12  63  		shift_table[i] = -1;
6a5c94d92699b7 Samuel Thibault 2022-06-12  64  
6a5c94d92699b7 Samuel Thibault 2022-06-12  65  	if (argc < 2) {
6a5c94d92699b7 Samuel Thibault 2022-06-12  66  		fputs("usage: genmap filename\n", stderr);
6a5c94d92699b7 Samuel Thibault 2022-06-12  67  		exit(1);
6a5c94d92699b7 Samuel Thibault 2022-06-12  68  	}
6a5c94d92699b7 Samuel Thibault 2022-06-12  69  
6a5c94d92699b7 Samuel Thibault 2022-06-12  70  	for (p_init = init_key_data; p_init->name[0] != '.'; p_init++)
6a5c94d92699b7 Samuel Thibault 2022-06-12  71  		add_key(p_init->name, p_init->value, p_init->shift);
6a5c94d92699b7 Samuel Thibault 2022-06-12  72  
6a5c94d92699b7 Samuel Thibault 2022-06-12  73  	open_input(NULL, argv[1]);
6a5c94d92699b7 Samuel Thibault 2022-06-12  74  	while (fgets(buffer, sizeof(buffer), infile)) {
6a5c94d92699b7 Samuel Thibault 2022-06-12 @75  		lc++;

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

