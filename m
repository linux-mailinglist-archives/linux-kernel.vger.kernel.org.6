Return-Path: <linux-kernel+bounces-563545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 10A8AA643DD
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 08:37:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 635DB1649D8
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 07:37:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8C5D21ADB2;
	Mon, 17 Mar 2025 07:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MdGXkgw5"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95921219A91
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 07:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742197068; cv=none; b=YqDKpArs4nA452zqfPUp0eqLvytG2RYcw0BOHsCnPNCMZamJchFbomCTEJmmiR/xuZ/LMxkONgTvNQYekMkq6HmXJUrOiQoQC1uk4/iYDMGEsoD2pY8WVhjiMy2pKY9RTVx6nhKyrO2in2Dcpqa0FxitjkGKmg1owLzmlhJQ96U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742197068; c=relaxed/simple;
	bh=vJnQ0SQNEnZgP4gfABlV7sCs0cigr7LHhFZnAU6y/90=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=PpLQi4P8TLyzFWUQVCDbx6h28s2wsny3s1YlqS1FjKJDzW7Zi4CZk7ykFLiLeKrYgBI9E0z7/gmcI7md6bX7Mf2tH5tzk/NUVUTNO4yH2ng+J+etktfU4ZjJcOjd4XkxpwjA5HCouCTEwR99fxfPiH9nngKW09wN/SIQJkx63T4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MdGXkgw5; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742197067; x=1773733067;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=vJnQ0SQNEnZgP4gfABlV7sCs0cigr7LHhFZnAU6y/90=;
  b=MdGXkgw5rxoJ9hxZSxs/vhONWw4v8SjjYUe0SSGTXkXWjkL5mHDFzt95
   2EPEAP/g656Q+eHNGkKNBI4Jq/u4Thx3RaWOdKeWHYhglwJRj8qTBWR6g
   In+A8T9m/90+QK3dVtgDIdoqVivFACeKKc4ReovNxRMx3azdJZ+lDEQmp
   4I/Op+/XuRazNJQs2f9t4Rf3wBv96lP5YNrcLphYRKAa76eF0QCCHy4BT
   bVD63ZwnjWAb3uK+f1D3Pyo3CFew0yjTH8+S8/7oakA0tmgRFuMgQxFNj
   iNHtFXVG/tHQGw//u4hIsQoO1N27r6EQ5MZtthVIcBtqSZbBypP2a8RoL
   w==;
X-CSE-ConnectionGUID: n/S6XX/xQUyFbbRkNXFgEg==
X-CSE-MsgGUID: jTD5TDOiT4ylimTjhDGGSg==
X-IronPort-AV: E=McAfee;i="6700,10204,11375"; a="68637753"
X-IronPort-AV: E=Sophos;i="6.14,253,1736841600"; 
   d="scan'208";a="68637753"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2025 00:37:46 -0700
X-CSE-ConnectionGUID: bOJE8TXNQoaRtCtI+xvntQ==
X-CSE-MsgGUID: iCUwQZbVRdySJhn+EfS2hg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,253,1736841600"; 
   d="scan'208";a="122373975"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by fmviesa010.fm.intel.com with ESMTP; 17 Mar 2025 00:37:44 -0700
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tu52c-000CZb-2m;
	Mon, 17 Mar 2025 07:37:42 +0000
Date: Mon, 17 Mar 2025 15:36:46 +0800
From: kernel test robot <lkp@intel.com>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>
Subject: vmlinux.o: warning: objtool: snd_rme96_capture_getrate+0x84: return
 with modified stack frame
Message-ID: <202503171547.LlCTJLQL-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   4701f33a10702d5fc577c32434eb62adde0a1ae1
commit: 3724062ca2b1364f02cf44dbea1a552227844ad1 objtool: Ignore dangling jump table entries
date:   5 weeks ago
config: x86_64-randconfig-r051-20250316 (https://download.01.org/0day-ci/archive/20250317/202503171547.LlCTJLQL-lkp@intel.com/config)
compiler: clang version 20.1.0 (https://github.com/llvm/llvm-project 24a30daaa559829ad079f2ff7f73eb4e18095f88)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250317/202503171547.LlCTJLQL-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503171547.LlCTJLQL-lkp@intel.com/

All warnings (new ones prefixed by >>):

   vmlinux.o: warning: objtool: ___bpf_prog_run+0x1f: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: SiS_GetCRT2Ptr+0x1ad: stack state mismatch: cfa1=4+8 cfa2=5+16
   vmlinux.o: warning: objtool: .text.nvmet_ctrl_state_show: unexpected end of section
   vmlinux.o: warning: objtool: .text.cyapa_update_fw_store: unexpected end of section
>> vmlinux.o: warning: objtool: snd_rme96_capture_getrate+0x84: return with modified stack frame
>> vmlinux.o: warning: objtool: .text.wcd934x_slim_irq_handler: unexpected end of section

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

