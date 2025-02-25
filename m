Return-Path: <linux-kernel+bounces-532349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A395CA44BEA
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 21:00:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6F597A3A8C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 19:59:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F5BF204F77;
	Tue, 25 Feb 2025 20:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I/Bm221U"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A7E1A0BD6
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 20:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740513650; cv=none; b=gPnu4YbjWn5X2kL6kUDeFy4hXGFJJTFbkH079PM7C/+h1U+48aVNYSh0BKugM4wERMukZxamieVGiMHsOwEplDbiST5cFygTwK8acgdUTi3Kh9UcjJ632BH4bnrNQu1RcQCYN+5MXYQOQoVK3npcIpDbtKAWaO43o5L4W6QZFZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740513650; c=relaxed/simple;
	bh=oLTkvWNLPVYhtsMmPnDmBjn+UY0z6FDAOmaxpoJigrc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=oMHB1z/JlpyzyC7hOu6ENssL81s9M78qfR3piSFXNDWlSNCcVIk0hzg7v0/PstsHxssoM8y7h14R8KF/rCJcg1Jsh+aNBsxe2A+N+eUj88fViumRbyqN3+KVgJUUAC/AjOnhaLIgw/ajCBMwmZqsRv+H0KNy6AOVlwQrZ6E4jDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I/Bm221U; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740513649; x=1772049649;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=oLTkvWNLPVYhtsMmPnDmBjn+UY0z6FDAOmaxpoJigrc=;
  b=I/Bm221UmZpJq2+ALf79L4fdYegDyB99d28Rrv/Iww0ZUiQgICcs4A7h
   3/7aHdSCrj85DuDlJdTk6B6OBssjLebka8MvpsSiP+V7CmlhYsrCFnCL/
   3Tn3eamMupPW2Q/W/RSuGUCZa7rbkIAUQjy3512bH+weyC2/Ovbb9TfJY
   jvFZGKVkDsCBP2Bt7Jm6+zbG9DECw/vLlttZSFi5BDjH/IFPHF1WcU8pf
   1soMoVVRxfn8LvvLX4tiNU/P/OVIyh6Nq+3oop05GL5sB1z+dzETIy3sd
   9B23zHyQBT2bdTYOKcYIdrwUJVyqaDlmdCbhfFUS02fOJl2hVjOye0JIX
   A==;
X-CSE-ConnectionGUID: aQjZFnTeRlGOd69gXpfOfA==
X-CSE-MsgGUID: XMeNPcxTRui5LTrOhL1kqA==
X-IronPort-AV: E=McAfee;i="6700,10204,11356"; a="51970640"
X-IronPort-AV: E=Sophos;i="6.13,314,1732608000"; 
   d="scan'208";a="51970640"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 12:00:48 -0800
X-CSE-ConnectionGUID: GuX5MFcnSNa27PE9Oirm8A==
X-CSE-MsgGUID: dIJ8GuMdRv2/lw0k41mvvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,314,1732608000"; 
   d="scan'208";a="117099588"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by fmviesa009.fm.intel.com with ESMTP; 25 Feb 2025 12:00:47 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tn16e-000Aig-2d;
	Tue, 25 Feb 2025 20:00:41 +0000
Date: Wed, 26 Feb 2025 04:00:07 +0800
From: kernel test robot <lkp@intel.com>
To: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Andrew Lunn <andrew@lunn.ch>
Subject: undefined reference to `gen_pool_size'
Message-ID: <202502260351.kWkpfnZB-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Grygorii,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   d082ecbc71e9e0bf49883ee4afd435a77a5101b6
commit: 99f629718272974405e8d180d2fa70c03c06d61f net: ethernet: ti: cpsw: drop TI_DAVINCI_CPDMA config option
date:   6 years ago
config: alpha-randconfig-r004-20230123 (https://download.01.org/0day-ci/archive/20250226/202502260351.kWkpfnZB-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 12.4.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250226/202502260351.kWkpfnZB-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502260351.kWkpfnZB-lkp@intel.com/

All errors (new ones prefixed by >>):

   alpha-linux-ld: warning: arch/alpha/lib/styncpy.o: missing .note.GNU-stack section implies executable stack
   alpha-linux-ld: NOTE: This behaviour is deprecated and will be removed in a future version of the linker
   alpha-linux-ld: warning: arch/alpha/lib/styncpy.o: missing .note.GNU-stack section implies executable stack
   alpha-linux-ld: NOTE: This behaviour is deprecated and will be removed in a future version of the linker
   alpha-linux-ld: warning: .tmp_vmlinux1 has a LOAD segment with RWX permissions
   alpha-linux-ld: drivers/net/ethernet/ti/davinci_cpdma.o: in function `cpdma_desc_pool_destroy':
>> (.text+0x34): undefined reference to `gen_pool_size'
>> alpha-linux-ld: (.text+0x38): undefined reference to `gen_pool_size'
>> alpha-linux-ld: (.text+0x48): undefined reference to `gen_pool_avail'
   alpha-linux-ld: (.text+0x50): undefined reference to `gen_pool_avail'
   alpha-linux-ld: (.text+0xb4): undefined reference to `gen_pool_size'
   alpha-linux-ld: (.text+0xb8): undefined reference to `gen_pool_size'
   alpha-linux-ld: (.text+0xc8): undefined reference to `gen_pool_avail'
   alpha-linux-ld: (.text+0xd0): undefined reference to `gen_pool_avail'
   alpha-linux-ld: drivers/net/ethernet/ti/davinci_cpdma.o: in function `cpdma_desc_pool_create.constprop.0':
>> (.text+0x3f4): undefined reference to `devm_gen_pool_create'
>> alpha-linux-ld: (.text+0x428): undefined reference to `devm_gen_pool_create'
   alpha-linux-ld: (.text+0x4a4): undefined reference to `gen_pool_add_virt'
   alpha-linux-ld: (.text+0x4ac): undefined reference to `gen_pool_add_virt'
   alpha-linux-ld: drivers/net/ethernet/ti/davinci_cpdma.o: in function `__cpdma_chan_free':
>> (.text+0x714): undefined reference to `gen_pool_free'
   alpha-linux-ld: (.text+0x71c): undefined reference to `gen_pool_free'
   alpha-linux-ld: drivers/net/ethernet/ti/davinci_cpdma.o: in function `cpdma_chan_submit':
>> (.text+0x1bcc): undefined reference to `gen_pool_alloc'
   alpha-linux-ld: (.text+0x1bd8): undefined reference to `gen_pool_alloc'
   alpha-linux-ld: (.text+0x205c): undefined reference to `gen_pool_free'
   alpha-linux-ld: (.text+0x206c): undefined reference to `gen_pool_free'
   alpha-linux-ld: drivers/net/ethernet/ti/davinci_cpdma.o: in function `cpdma_check_free_tx_desc':
>> (.text+0x20f4): undefined reference to `gen_pool_avail'
   alpha-linux-ld: (.text+0x20f8): undefined reference to `gen_pool_avail'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

