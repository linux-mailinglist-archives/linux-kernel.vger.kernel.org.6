Return-Path: <linux-kernel+bounces-329110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B91F2978D75
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 07:03:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 23C09B2524A
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 05:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF5EF43AD9;
	Sat, 14 Sep 2024 05:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J3zAeJNK"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C965A18044
	for <linux-kernel@vger.kernel.org>; Sat, 14 Sep 2024 05:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726290164; cv=none; b=NNK0lINHNhzqIPXWG/L0ENhps//VQwHqeRoNPMLOZWUHtuxEcJ+pT5i1RyBteWcUrNvL+cMiSH8o781k++XoKrw8rt7xRanQvGwRWMrv/u+4K7mg32WIdCPxU/E03/0Tr7mqKXphMdFdTT5seNN8Ag7IP6unJPfbxxp3Uo2Kw3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726290164; c=relaxed/simple;
	bh=PRHxpwqBWGpM+2d2QT8lyeuCwQ6nd5/elvNqX+lmXWY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=afHeUaKzggE5xU5vzcDxnsaBRSXf2pI/XE/uz9UsRmOCGPG5QW6bVEiBUNTXq5J2eDL9MQsBXLZJnl1Fqq7xoaNzX5Gz3i29tmvEriA9DnveQNVSxN2MLXKhtDBBvCp/m8xYzOd41JDpX1LZYzctUGLdcL02h2Vcahe3NoJSSCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J3zAeJNK; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726290163; x=1757826163;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=PRHxpwqBWGpM+2d2QT8lyeuCwQ6nd5/elvNqX+lmXWY=;
  b=J3zAeJNK5qO8noTli+hMKJy3AxFFQt/dh9qjM3TBLfL47e1ZGYO/Yo8T
   oDlfNVJLKABy3yPt7cHLPw3VnMe56Qwed6sewffVq2BN5+zqQPMKRx8i2
   4HqN5HNZ+pxzcL6DP5EC8roKHhmHOB1QaEaRtD6j9qeQlXdGQxDCwUst/
   9q0pLdEgKPw4S9KWcVtVYLwhT0eVDnAkyhr17XUvPn/GuRUOj7wzAtSjB
   EvJi12njkw+YbJXLBnVL+Qyq3LYcbujjRU4MR0WlOslQMplXJCSTGSCC/
   tSllADfFA81mLcGcVJNGVRibLwW/ZCuGckfI0477rZUbXxoAbp/u6axRd
   g==;
X-CSE-ConnectionGUID: LKx8guYDQ0urqRmTAdqlcA==
X-CSE-MsgGUID: 8e6JMg5ZQRa+/y3+Ht2V7Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11194"; a="35874105"
X-IronPort-AV: E=Sophos;i="6.10,228,1719903600"; 
   d="scan'208";a="35874105"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2024 22:02:42 -0700
X-CSE-ConnectionGUID: ssI9cVoiSF+soSImCuzkgg==
X-CSE-MsgGUID: F89ZKZi/QGaCBPbBI10qCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,228,1719903600"; 
   d="scan'208";a="73319859"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 13 Sep 2024 22:02:41 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1spKve-0007OK-1j;
	Sat, 14 Sep 2024 05:02:38 +0000
Date: Sat, 14 Sep 2024 13:01:57 +0800
From: kernel test robot <lkp@intel.com>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	"Gustavo A. R. Silva" <gustavo@embeddedor.com>,
	LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars:testing/wfamnae-next20240912 15/15]
 kernel/bpf/core.c:2505:22: warning: comparison of distinct pointer types
 ('struct bpf_prog_array *' and 'struct bpf_prog_array_hdr *')
Message-ID: <202409141212.JISRQdpc-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git testing/wfamnae-next20240912
head:   f2ca068393cf1157c12ab08556b05824eec16511
commit: f2ca068393cf1157c12ab08556b05824eec16511 [15/15] treewide_some: fix multiple -Wfamnae warnings that must be audited separately
config: x86_64-rhel-8.3-rust (https://download.01.org/0day-ci/archive/20240914/202409141212.JISRQdpc-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240914/202409141212.JISRQdpc-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409141212.JISRQdpc-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> kernel/bpf/core.c:2505:22: warning: comparison of distinct pointer types ('struct bpf_prog_array *' and 'struct bpf_prog_array_hdr *') [-Wcompare-distinct-pointer-types]
    2505 |         if (!progs || progs == &bpf_empty_prog_array.hdr)
         |                       ~~~~~ ^  ~~~~~~~~~~~~~~~~~~~~~~~~~
   1 warning generated.


vim +2505 kernel/bpf/core.c

8c7dcb84e3b744 Delyan Kratunov 2022-06-14  2502  
8c7dcb84e3b744 Delyan Kratunov 2022-06-14  2503  void bpf_prog_array_free_sleepable(struct bpf_prog_array *progs)
8c7dcb84e3b744 Delyan Kratunov 2022-06-14  2504  {
8c7dcb84e3b744 Delyan Kratunov 2022-06-14 @2505  	if (!progs || progs == &bpf_empty_prog_array.hdr)
8c7dcb84e3b744 Delyan Kratunov 2022-06-14  2506  		return;
8c7dcb84e3b744 Delyan Kratunov 2022-06-14  2507  	call_rcu_tasks_trace(&progs->rcu, __bpf_prog_array_free_sleepable_cb);
8c7dcb84e3b744 Delyan Kratunov 2022-06-14  2508  }
8c7dcb84e3b744 Delyan Kratunov 2022-06-14  2509  

:::::: The code at line 2505 was first introduced by commit
:::::: 8c7dcb84e3b744b2b70baa7a44a9b1881c33a9c9 bpf: implement sleepable uprobes by chaining gps

:::::: TO: Delyan Kratunov <delyank@fb.com>
:::::: CC: Alexei Starovoitov <ast@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

