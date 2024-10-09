Return-Path: <linux-kernel+bounces-357419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34A1F99710F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 18:20:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E279A285956
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 16:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94E0F1DEFF0;
	Wed,  9 Oct 2024 16:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Dt6SZ5mQ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 842971D07A3
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 16:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728489908; cv=none; b=MXxuN1MyMFsyNp9EDPhUJYOYDjr5WEiSjx+zYOoCvY+jhakSdDZagx4JXak5o2uR/UZHJQVkqpzicifmFwhvAkP4QYQasIm+K60gcibpF3bR5acNGDZrPOPp1yulHq2UIvUT5l9Dhqr3nPmYFrscHkb5E8PpM303m5pVOVIqdEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728489908; c=relaxed/simple;
	bh=Aa/YkaSPkAQ9LmxK/psfEBmzO+jOivxxfO7edhW0+Ds=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=hM3LpAJq79CYJOyTkQSxPteBSJ8MGr4HyR1fKA3goByupvBKhX3Txq3Rw9u2TBBqplAsJErkHl7ElbK4WVVEjhaPCK0BzLBgaRuvNBHbu9rzpLIM3uegGCDAM5hEVlu4cDm0vCQAqB185/vunnv9g5dV9o78+nGCoS10O0UWtc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Dt6SZ5mQ; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728489906; x=1760025906;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Aa/YkaSPkAQ9LmxK/psfEBmzO+jOivxxfO7edhW0+Ds=;
  b=Dt6SZ5mQ+rPZOZJ9sr1Jsm0ojpLYgBFO/1c09Y8wVuKWZ2ruNMdeYmse
   Oep570Dcojl03kT22mtr3uTZ3hHTZMJ56HPmfocsOffmbNkemwKTPbxhp
   dz2mmRYMyCQ1VaOUuzhCb0A+RWxMckDHed91LFVUKaZTlcfn362ZAhcXo
   WBggNCDrcoPyp/TOoDHzDOrUnaQC1z5aDe2oJPiWvD/aJXISxNtGN6X4R
   mYYPyBvpZnTc0eK+RTC6hllGVR4kFaQwRgUvFVb5pt9wevsirNHtb87JW
   k6WXyIdIWDszGxva8LMqor5GLR6tTGAjale2p5JBpYqy0aiTo/jBlM28x
   A==;
X-CSE-ConnectionGUID: 7iVj/ssiTGSVvUw+Rmoy8Q==
X-CSE-MsgGUID: ESkMYqFIS06MQAqtRPT4rw==
X-IronPort-AV: E=McAfee;i="6700,10204,11220"; a="38388470"
X-IronPort-AV: E=Sophos;i="6.11,190,1725346800"; 
   d="scan'208";a="38388470"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2024 09:05:05 -0700
X-CSE-ConnectionGUID: mwAphqa+TEST01XD5+cjVw==
X-CSE-MsgGUID: cNZRg4HSQ8iVjY4Mf/CpHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,190,1725346800"; 
   d="scan'208";a="76612716"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 09 Oct 2024 09:05:04 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1syZBN-0009SD-2R;
	Wed, 09 Oct 2024 16:05:01 +0000
Date: Thu, 10 Oct 2024 00:04:53 +0800
From: kernel test robot <lkp@intel.com>
To: Boris Burkov <boris@bur.io>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	David Sterba <dsterba@suse.com>
Subject: fs/btrfs/send.c:6877:5-8: Unneeded variable: "ret". Return "0" on
 line 6883
Message-ID: <202410092305.WbyqspH8-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   75b607fab38d149f232f01eae5e6392b394dd659
commit: 38622010a6de3a62cc72688348548854ed82dcf5 btrfs: send: add support for fs-verity
date:   2 years ago
config: i386-randconfig-052-20241009 (https://download.01.org/0day-ci/archive/20241009/202410092305.WbyqspH8-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410092305.WbyqspH8-lkp@intel.com/

cocci warnings: (new ones prefixed by >>)
>> fs/btrfs/send.c:6877:5-8: Unneeded variable: "ret". Return "0" on line 6883

vim +6877 fs/btrfs/send.c

  6874	
  6875	static int changed_verity(struct send_ctx *sctx, enum btrfs_compare_tree_result result)
  6876	{
> 6877		int ret = 0;
  6878	
  6879		if (!sctx->cur_inode_new_gen && !sctx->cur_inode_deleted) {
  6880			if (result == BTRFS_COMPARE_TREE_NEW)
  6881				sctx->cur_inode_needs_verity = true;
  6882		}
> 6883		return ret;
  6884	}
  6885	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

