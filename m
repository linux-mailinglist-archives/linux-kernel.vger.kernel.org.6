Return-Path: <linux-kernel+bounces-190040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8216B8CF8B9
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 07:27:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FA2F1F216B0
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 05:27:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09B8BD26D;
	Mon, 27 May 2024 05:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IB9RUwp5"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DC2779F0
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 05:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716787627; cv=none; b=Hzm1jtaE/10MOMxoNSukLirfqqF7l7BwaD7cxgtxwMxjsVkNUyWtJbKZb46FPHjOdfUWnO6MMJ/g3vYlFttmK1yBK6KvElQ7WhgdprzHJhQgbBdVCwSio8bwYW8ssVqvaGnkqkVCgh19Y755k3G+Ke2lgBl5g7G7t19U2UfvL1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716787627; c=relaxed/simple;
	bh=Yd7VMAUoH0eRSX0H3bwa1PpMsjWV9tOya8nHLWCczDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=u1Gyy2pohTuG+6lzWMurGCeNRapUElWvcFbciuSgeGAV2sTgNwETcMKZAzzNU8g63XCS1ygkpGxZV68IiJiU46bLk3FBkfB79UvMCRGm6Qt8YTBfGAz3pUrb/mZ+YlK3mzHheZomM6UP3SoPQK/qF+tnQOmWFbgUfjt9AGnz+QA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IB9RUwp5; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716787625; x=1748323625;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Yd7VMAUoH0eRSX0H3bwa1PpMsjWV9tOya8nHLWCczDQ=;
  b=IB9RUwp5TZkm+6gLvnZwAyfIkK1WX2Iip+wQcL07a9vEMGPPGzMOnMxR
   VXgc6qZGRODCufU2Bhd2p6aQy44I5FZ+mG4TXh0k9zdRB3wtXBb/OFWGu
   alRVSBbVOATxZY42PT4emYUy9MpG+BLFHlxAfwKm8NCWfJNogdeU7Emer
   7yzdJwFrfLDe8IENMp9o9MYLEeMEL20Chrk3XRVN82lCF3jRQOZPSptzE
   RbvPr4qdwvkZEoncEfHq4WAWOx6qZ3lMFfkvpZYj6axhB5AlT0QzRhX7c
   fvPIZ7QQmVLd5Pf/SWs0gXHvem45p7AaxqCRRIWMAdEuJDezFCmFW0LBD
   A==;
X-CSE-ConnectionGUID: PC6JvUqfSeamet5wEpKYuw==
X-CSE-MsgGUID: BT+W4U9BQI2i6vkfOo3r/Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11084"; a="12927802"
X-IronPort-AV: E=Sophos;i="6.08,191,1712646000"; 
   d="scan'208";a="12927802"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2024 22:27:04 -0700
X-CSE-ConnectionGUID: Y3kfcI39RPC2Ev7kZbK7KQ==
X-CSE-MsgGUID: pGzBmz/nRaK9i5iNrVj4qg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,191,1712646000"; 
   d="scan'208";a="39414158"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by orviesa003.jf.intel.com with ESMTP; 26 May 2024 22:27:03 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sBSsr-0009Sb-0r;
	Mon, 27 May 2024 05:26:58 +0000
Date: Mon, 27 May 2024 13:25:58 +0800
From: kernel test robot <lkp@intel.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev.2024.05.18a 44/51] update.c:undefined reference to
 `cmpxchg_emu_u8'
Message-ID: <202405271352.XYjxKyUi-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2024.05.18a
head:   0e3eb8082184e066eb389f5e6f9c7b8c2d452d66
commit: c48887df74a95090e633a29ffbcef00b71cdab66 [44/51] rcu-tasks: Remove open-coded one-byte cmpxchg() emulation
config: um-allyesconfig (https://download.01.org/0day-ci/archive/20240527/202405271352.XYjxKyUi-lkp@intel.com/config)
compiler: gcc-13 (Ubuntu 13.2.0-4ubuntu3) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240527/202405271352.XYjxKyUi-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405271352.XYjxKyUi-lkp@intel.com/

All errors (new ones prefixed by >>):

   /usr/bin/ld: kernel/rcu/update.o: in function `rcu_trc_cmpxchg_need_qs':
>> update.c:(.text+0x27d5): undefined reference to `cmpxchg_emu_u8'
   /usr/bin/ld: kernel/rcu/update.o: in function `trc_read_check_handler':
   update.c:(.text+0x2839): undefined reference to `cmpxchg_emu_u8'
>> /usr/bin/ld: update.c:(.text+0x2882): undefined reference to `cmpxchg_emu_u8'
   /usr/bin/ld: kernel/rcu/update.o: in function `trc_inspect_reader':
   update.c:(.text+0x52ce): undefined reference to `cmpxchg_emu_u8'
   /usr/bin/ld: update.c:(.text+0x5330): undefined reference to `cmpxchg_emu_u8'
   /usr/bin/ld: kernel/rcu/update.o:update.c:(.text+0x5933): more undefined references to `cmpxchg_emu_u8' follow
>> collect2: error: ld returned 1 exit status

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

