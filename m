Return-Path: <linux-kernel+bounces-435610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92CE89E7A18
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 21:41:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6025A18856A2
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 20:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B39A11F63F0;
	Fri,  6 Dec 2024 20:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DkIpLw5w"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 490871DA31D
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 20:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733517682; cv=none; b=iwFjq+jKrTklxrQet7EZ2FPjmEhshVGbzAznvP1K+srdAvj6ZZODubbHyIPao1D+Cx2KjK7TbF+U1cJqo2jE9Zg1TCGwGjA6MFhJ1Xop8RRYDsACKmK+eI58eIQhyGvNZS4Erjm78NU+Q1Ja6mIUyFd5qzGYTabrW91vy9biUoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733517682; c=relaxed/simple;
	bh=U9NBKH+KxSyrdoQA2yX4lty4YBWea6apoz5dSGWlchc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=LrxivAXjW2AusyFX6apFn9dsYKwVrxZ3rcozzbAn697yzRyzVxYgD7KmUSt5bTIa9vpEird2UBYGMk5yGU38niRL+vQRfokn4Am/KzMmcjLIF0GNOUlidC5pXkota8zx5h6BDydEyInWD5iUCRF5HCsZZ4CV2Po4H6UaKdW5CrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DkIpLw5w; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733517681; x=1765053681;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=U9NBKH+KxSyrdoQA2yX4lty4YBWea6apoz5dSGWlchc=;
  b=DkIpLw5w/yZyGU3h6Lr+VuzxHNdw/T3jG5imydt5JwlnhD9KcoViCIDC
   rXm6G5FGlTzyHozMGXjRUQW9RI5/D/1c1ME6pgTrVDnG7+CftZvPTs5h3
   faPq0PHdI9cjxGTifoSIAunKbxd8J88AH4H6aX1Ys5hG96+jl5LupxfSW
   F1MNvIOqEAxMkbKpFB2+vf457ac1pFu41Zly6NUji/YIbsVVdoUx0C2xB
   uAhq5MS87roERAClOAjWBkWAaB6ZjQM6hXNn0V2LvGwvw1TQndejx79fr
   cWd8IsWqaCz74rHogiPT5B7ByIQIdtRdvpmGs8Q+DpWDxIvuXwklwdiZN
   w==;
X-CSE-ConnectionGUID: mvFHc00KR/uFyuoZWFNFng==
X-CSE-MsgGUID: 0Cg01kBQTq2SzNYHWbsieA==
X-IronPort-AV: E=McAfee;i="6700,10204,11278"; a="37819705"
X-IronPort-AV: E=Sophos;i="6.12,214,1728975600"; 
   d="scan'208";a="37819705"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2024 12:41:21 -0800
X-CSE-ConnectionGUID: oNX2SHkqTh2VVP4nM4ntaw==
X-CSE-MsgGUID: k5iyDtDMQdmNnuI3EMqrUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,214,1728975600"; 
   d="scan'208";a="95300024"
Received: from lkp-server01.sh.intel.com (HELO 82a3f569d0cb) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 06 Dec 2024 12:41:17 -0800
Received: from kbuild by 82a3f569d0cb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tJf8V-0002FJ-1J;
	Fri, 06 Dec 2024 20:41:15 +0000
Date: Sat, 7 Dec 2024 04:41:12 +0800
From: kernel test robot <lkp@intel.com>
To: Yury Norov <yury.norov@gmail.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Brian Norris <briannorris@chromium.org>,
	Kees Cook <kees@kernel.org>, Nathan Chancellor <nathan@kernel.org>
Subject: kernel/sched/build_utility.o: warning: objtool:
 sched_is_eas_possible.isra.0+0x8c: stack state mismatch: reg1[28]=-1+0
 reg2[28]=-2-56
Message-ID: <202412070437.ZjWaJvb1-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Yury,

FYI, the error/warning was bisected to this commit, please ignore it if it's irrelevant.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   b8f52214c61a5b99a54168145378e91b40d10c90
commit: fda1dd3c54ef3c4200c2e77634a91610da973950 find: Switch from inline to __always_inline
date:   4 months ago
config: loongarch-randconfig-001-20241207 (https://download.01.org/0day-ci/archive/20241207/202412070437.ZjWaJvb1-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241207/202412070437.ZjWaJvb1-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412070437.ZjWaJvb1-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> kernel/sched/build_utility.o: warning: objtool: sched_is_eas_possible.isra.0+0x8c: stack state mismatch: reg1[28]=-1+0 reg2[28]=-2-56

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

