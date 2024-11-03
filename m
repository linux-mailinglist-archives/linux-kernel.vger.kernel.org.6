Return-Path: <linux-kernel+bounces-393697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 744859BA42D
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 06:36:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9ECF41C20ACA
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 05:36:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73E2E140E5F;
	Sun,  3 Nov 2024 05:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I/WvoT5I"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 971C57080C
	for <linux-kernel@vger.kernel.org>; Sun,  3 Nov 2024 05:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730612179; cv=none; b=MgS9PZnRsZqoR8Y6kXzMFtB8f56lIecFBMVNNfneQdoKJ6ZShtYifF5MbQcYxrJWlJciqGpaPcZSH+b4JZO1f3AP+0VIv7C4PuhsK9JSeiNQ24FDN32LBropYgiuF2ii2/zTaB92GesnZ1u1ExuYfqqtID4WtKXgi578kZlqHc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730612179; c=relaxed/simple;
	bh=drngokPcHyJ/DKnypVr5TgvXbuYzJIMa2bww5ktjvoI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=MEBkinlPBexsR+pDJcUAsBIPRcqXLhq1qmJZS/YpEDdALJfEb+h718Q1LHzpYp6Vwuxqbezfm+iG0JAzEg2PaWVF7GmVU8nplr1IrWlVMTPG+VC06yQAGsj9+6/suPOak3Nl/uu4vQj1QAfm50xY7Xn49Ncv8xLRC4LQ/kBEaI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I/WvoT5I; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730612177; x=1762148177;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=drngokPcHyJ/DKnypVr5TgvXbuYzJIMa2bww5ktjvoI=;
  b=I/WvoT5IQw7fKGsqZ+U5lhWukYvC2n9vrAfLLD1e2yW1EHF908MSeYsM
   CSgLuHoXT4Mf61xGTQDYjBnrSAZA8blZ2y/VxNCB+USebUAFDK9EOmhD4
   cNnHO0Slmqp+KmNMMAOLvH9XYM8UB4IPEgH5kkJFrJsZLkZM5ObZZrBYX
   bg8mJaPFBH0RvRo9zBBG6kIHHgG72UJmmPe6+vbskeMZDoQRGOtLYwQeH
   FVFSpkLK8DJcGZ7bjTKkkGufu7Yig6SufpCjpalbU7ydcToJA6sVQCdW7
   x7f1ldfvZ2bUkC1dOvXlBeNnxyKwAiD3eqVw6GviwYnwWE8bL7DwRE2Is
   g==;
X-CSE-ConnectionGUID: P0a7olTLRCegfdv6049UjQ==
X-CSE-MsgGUID: MrkHDZQcSFOe9G4LpKCNqA==
X-IronPort-AV: E=McAfee;i="6700,10204,11244"; a="34116948"
X-IronPort-AV: E=Sophos;i="6.11,254,1725346800"; 
   d="scan'208";a="34116948"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2024 22:36:16 -0700
X-CSE-ConnectionGUID: 4qqVa/XwRHuClCfa1LF1cA==
X-CSE-MsgGUID: IjZdVWprSCyaT7jDRFMLYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,254,1725346800"; 
   d="scan'208";a="106667127"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 02 Nov 2024 22:36:15 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t7THY-000jjF-2N;
	Sun, 03 Nov 2024 05:36:12 +0000
Date: Sun, 3 Nov 2024 13:35:33 +0800
From: kernel test robot <lkp@intel.com>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: fs/bcachefs/journal.c:884:17: sparse: sparse: cast to non-scalar
Message-ID: <202411031315.IurXMwtn-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   11066801dd4b7c4d75fce65c812723a80c1481ae
commit: 1c6fdbd8f2465ddfb73a01ec620cbf3d14044e1a bcachefs: Initial commit
date:   1 year ago
config: arm64-randconfig-r122-20241102 (https://download.01.org/0day-ci/archive/20241103/202411031315.IurXMwtn-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 639a7ac648f1e50ccd2556e17d401c04f9cce625)
reproduce: (https://download.01.org/0day-ci/archive/20241103/202411031315.IurXMwtn-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411031315.IurXMwtn-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   fs/bcachefs/journal.c: note: in included file (through fs/bcachefs/bcachefs.h):
   fs/bcachefs/bcachefs_format.h:1022:42: sparse: sparse: array of flexible structures
>> fs/bcachefs/journal.c:884:17: sparse: sparse: cast to non-scalar
>> fs/bcachefs/journal.c:884:17: sparse: sparse: cast from non-scalar
   fs/bcachefs/journal.c:150:9: sparse: sparse: context imbalance in 'journal_buf_switch' - unexpected unlock
   fs/bcachefs/journal.c:271:13: sparse: sparse: context imbalance in 'journal_flush_write' - wrong count at exit
   fs/bcachefs/journal.c:329:35: sparse: sparse: context imbalance in '__journal_res_get' - different lock contexts for basic block
   fs/bcachefs/journal.c:509:6: sparse: sparse: context imbalance in 'bch2_journal_flush_seq_async' - different lock contexts for basic block
   fs/bcachefs/journal.c:570:12: sparse: sparse: context imbalance in 'journal_seq_flushed' - different lock contexts for basic block
   fs/bcachefs/journal.c: note: in included file (through arch/arm64/include/asm/smp.h, include/linux/smp.h, include/linux/lockdep.h, ...):
   arch/arm64/include/asm/percpu.h:127:1: sparse: sparse: cast truncates bits from constant value (ffffffff becomes ff)
   arch/arm64/include/asm/percpu.h:127:1: sparse: sparse: cast truncates bits from constant value (ffffffff becomes ffff)
   arch/arm64/include/asm/percpu.h:127:1: sparse: sparse: cast truncates bits from constant value (ffffffff becomes ff)
   arch/arm64/include/asm/percpu.h:127:1: sparse: sparse: cast truncates bits from constant value (ffffffff becomes ffff)
   arch/arm64/include/asm/percpu.h:127:1: sparse: sparse: cast truncates bits from constant value (ffffffff becomes ff)
   arch/arm64/include/asm/percpu.h:127:1: sparse: sparse: cast truncates bits from constant value (ffffffff becomes ffff)
   arch/arm64/include/asm/percpu.h:127:1: sparse: sparse: cast truncates bits from constant value (ffffffff becomes ff)
   arch/arm64/include/asm/percpu.h:127:1: sparse: sparse: cast truncates bits from constant value (ffffffff becomes ffff)
   fs/bcachefs/journal.c:797:17: sparse: sparse: context imbalance in '__bch2_set_nr_journal_buckets' - different lock contexts for basic block

vim +884 fs/bcachefs/journal.c

   876	
   877	static bool bch2_journal_writing_to_device(struct journal *j, unsigned dev_idx)
   878	{
   879		union journal_res_state state;
   880		struct journal_buf *w;
   881		bool ret;
   882	
   883		spin_lock(&j->lock);
 > 884		state = READ_ONCE(j->reservations);
   885		w = j->buf + !state.idx;
   886	
   887		ret = state.prev_buf_unwritten &&
   888			bch2_extent_has_device(bkey_i_to_s_c_extent(&w->key), dev_idx);
   889		spin_unlock(&j->lock);
   890	
   891		return ret;
   892	}
   893	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

