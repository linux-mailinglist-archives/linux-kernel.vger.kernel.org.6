Return-Path: <linux-kernel+bounces-321096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BB3997146A
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 11:51:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 666A41C2307D
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 09:51:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3741F1B374E;
	Mon,  9 Sep 2024 09:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q5JIgqs8"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC031B2EF7
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 09:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725875458; cv=none; b=mue7ilwurUkwI1zRxhukixBomWunC+fad32IlOFUuNilWIrII+aIhQ+GV+H4kzoPaAQ6HGdarFMKTJyvmJkHC+uywQCca7gyuLOg7t4ZuldwPf5AKfuy0NeIqhK8r3bK0vDlNY8jjx+o45Ns5VZ21jxy6TGwsbKDIJ/8EroaE2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725875458; c=relaxed/simple;
	bh=Q/pk0bz01Cc1a3LW0szlwHGr2S70S9mTAznC9QRAaf8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=PZUhZV3lwMUok/D+NZVXSjOlJ9Y09EbxPe+CTI722wvAu7WjGbYNznIXpl4p+6dGjZ8ulxmanTlJImRovZprqfcbnllYHTm+4Xk8Q4MlVMsQ4uKO4oyZao5gUP4c/sWX0qhKYV7WEoq6zZ1HAMGQ9KjP+h93M/udFZO8ykpNJXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q5JIgqs8; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725875457; x=1757411457;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Q/pk0bz01Cc1a3LW0szlwHGr2S70S9mTAznC9QRAaf8=;
  b=Q5JIgqs8FKTQ6VF5nmSOwiCjafpA/L3uuwenrpkp43szw9oDMuaaLSnX
   YTVr7kLfq34cPzzwRxJWYmPvGaajcWZnagtW8Mjx/6fs/AQF7GZwki2fx
   nTXmHsB9/0bKUaEeM3je2VaAzrwtWita8y0aZcUM9qII/P7BKcMAwpB0J
   3Q4BgCmYl+Hh+dgT/vtpEepQ9wj23VbWkFjsrvTdAcsQwU8snaN2KcY3U
   mQmmortELnlHp2xwU0pNChRl5YqEkkOYeUWwUToHbbgcBc1RTvNc9D2Ta
   mG7RJZxq6nMMYpY3hYVlzbnax1TrDRakGARgR87ix5HO1jPKWormwbr9K
   w==;
X-CSE-ConnectionGUID: IldcxF6zS8+Tn3c5zU3FPA==
X-CSE-MsgGUID: 4b9DR7zxTUyBHLpYOcfnrw==
X-IronPort-AV: E=McAfee;i="6700,10204,11189"; a="24361711"
X-IronPort-AV: E=Sophos;i="6.10,213,1719903600"; 
   d="scan'208";a="24361711"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2024 02:50:56 -0700
X-CSE-ConnectionGUID: 1ygYQyQeQq2vc8lZhzZV5g==
X-CSE-MsgGUID: sXAUfpXvSJi0xrs/YiECKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,213,1719903600"; 
   d="scan'208";a="67357832"
Received: from lkp-server01.sh.intel.com (HELO 9c6b1c7d3b50) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 09 Sep 2024 02:50:56 -0700
Received: from kbuild by 9c6b1c7d3b50 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1snb2r-000EaY-1A;
	Mon, 09 Sep 2024 09:50:53 +0000
Date: Mon, 9 Sep 2024 17:50:27 +0800
From: kernel test robot <lkp@intel.com>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: fs/bcachefs/btree_trans_commit.o: warning: objtool:
 __bch2_trans_commit+0x88: stack state mismatch: reg1[22]=-1+0 reg2[22]=-2-16
Message-ID: <202409091745.jFnZrkPl-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   da3ea35007d0af457a0afc87e84fddaebc4e0b63
commit: 1d16c605cc55ef26f0c65b362665a6c99080ccbc bcachefs: Disk space accounting rewrite
date:   8 weeks ago
config: loongarch-randconfig-001-20240907 (https://download.01.org/0day-ci/archive/20240909/202409091745.jFnZrkPl-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240909/202409091745.jFnZrkPl-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409091745.jFnZrkPl-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> fs/bcachefs/btree_trans_commit.o: warning: objtool: __bch2_trans_commit+0x88: stack state mismatch: reg1[22]=-1+0 reg2[22]=-2-16


objdump-func vmlinux.o __bch2_trans_commit:

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

