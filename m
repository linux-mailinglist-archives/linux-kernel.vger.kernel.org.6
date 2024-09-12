Return-Path: <linux-kernel+bounces-325890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0B62975F7D
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 05:01:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA8F51C23508
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 03:01:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31DD1126C18;
	Thu, 12 Sep 2024 02:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="URGAVd33"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9E3C126C0D
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 02:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726109910; cv=none; b=Hu85GkGJzCjs3iuYV7Dttv9iLAXC7OHwlvGPQHSJLIexNjNwDy6fhhLnuUj9Vy5f002VyfDDDC6jFWke+4/AvUJjVF3oO5dEzKjjCJj/2p6o+zQHnggurEif0pWo4XTkyjzGVTtqUMoDLenGab+r4EhSKMdhqNvF46jVwnukDY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726109910; c=relaxed/simple;
	bh=QDvRae7jTgRB1mOTi6oQbEufkcwvpAQD4eAFPMHBhc0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=O7yxJ9thEq5l178QeneQ56aNPiuRdQNHmBV3rhGFaLsj2cc+tolnU5c9+IRvgI2/rzZEg78BPB/z2vgLASnfQnOuJuo46geRxKJRmWMU3Bas5aobQcRGKxEqcQifZiSlKGXFylygUySA/XnH3YJfftU05ceaOwXpj0SAVl10P4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=URGAVd33; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726109908; x=1757645908;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=QDvRae7jTgRB1mOTi6oQbEufkcwvpAQD4eAFPMHBhc0=;
  b=URGAVd33LbHRECu9NkkBAVcTiMtvRFkuWzZz63qzd/qp6Ok+sq/Vi+um
   1Z2Pm4ELr97j8+uwXXVHxt53JUkbA2awuKSx1m28E0+sszNmt7qVThdE9
   SuehvnS7YE4HlRZvC+/+/CHZG5OcWBcYv5QXfwEPr+j0hss4DKVObxRtl
   QY3C7PkfRIlc9jhUFrdytUT2qbErdZYqVOAhiPEnDbS6FEYZsnwkZYp17
   MDFZhaRBgrn02jDFgI5Jl88nOLEknY/OtzjEgNFz/7++BHgGmFs6OvOfC
   XKmnh6kiwPAPE3GuHw6PRRfrsLXGoWGoBB7mNSQIn5Dxd9ppNoDZjv7NB
   w==;
X-CSE-ConnectionGUID: 211KAUTZTLeJ1syPr40bww==
X-CSE-MsgGUID: i50gz9DsSB2WG0a2t90Axw==
X-IronPort-AV: E=McAfee;i="6700,10204,11192"; a="27860132"
X-IronPort-AV: E=Sophos;i="6.10,221,1719903600"; 
   d="scan'208";a="27860132"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2024 19:58:28 -0700
X-CSE-ConnectionGUID: IjRQ/KnPT/+7aKvvfvya3Q==
X-CSE-MsgGUID: AyjAcX7CS16sKjrzsGdQcg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,221,1719903600"; 
   d="scan'208";a="67554008"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 11 Sep 2024 19:58:27 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1soa2L-0004QC-0r;
	Thu, 12 Sep 2024 02:58:25 +0000
Date: Thu, 12 Sep 2024 10:58:18 +0800
From: kernel test robot <lkp@intel.com>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: fs/bcachefs/btree_trans_commit.o: warning: objtool:
 __bch2_trans_commit+0x4e8: return with modified stack frame
Message-ID: <202409121036.cdVPP0Xh-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   77f587896757708780a7e8792efe62939f25a5ab
commit: 2744e5c9eb1a1090b5f61c955e934c70bfe6b04c bcachefs: KEY_TYPE_accounting
date:   8 weeks ago
config: loongarch-randconfig-001-20240912 (https://download.01.org/0day-ci/archive/20240912/202409121036.cdVPP0Xh-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240912/202409121036.cdVPP0Xh-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409121036.cdVPP0Xh-lkp@intel.com/

All warnings (new ones prefixed by >>):

   fs/bcachefs/btree_trans_commit.o: warning: objtool: bch2_trans_commit_write_locked.isra.0() falls through to next function do_bch2_trans_commit.constprop.0.isra.0()
>> fs/bcachefs/btree_trans_commit.o: warning: objtool: __bch2_trans_commit+0x4e8: return with modified stack frame


objdump-func vmlinux.o __bch2_trans_commit:

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

