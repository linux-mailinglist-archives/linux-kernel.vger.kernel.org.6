Return-Path: <linux-kernel+bounces-196132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E5DC8D57B7
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 03:22:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1254287459
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 01:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61521C8E9;
	Fri, 31 May 2024 01:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eH0Mptjq"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 419A363C7
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 01:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717118555; cv=none; b=VbcwNm1xz7Xe26YNLH905TtpzBDgBsdRxuUpDOvkQYBpb0D92HnwZ1hhlwukVpsJs4MJYcASYjUC43BOTebX1g2lGWwY0CKN0gZL8W4rkChqseLuhfPFPjNMHvogEoMSGouiq3bwHEsSrWf5kH/h2+xtsqfDf4nOZCmXPUNBpMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717118555; c=relaxed/simple;
	bh=VnNHpRzZrBLyR03ZBBRoUhv2fOQNBpllKF4FtcJ17m0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SHqUwNAWV8RLF2AdthB721/rQk5eu4N3e9PAIpcjbAO5bBSxCCGM/zqtjdJfrOt60OtTP0H+IK9Sn9VdmDrI/c3rPkDueDw57MRiBynf0cDYChSUzKf4/aFDnbXilOW1HuKjpBTWHUSTOoJ/rDb9UGuvJdezDADOshfW6dcnPtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eH0Mptjq; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717118554; x=1748654554;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VnNHpRzZrBLyR03ZBBRoUhv2fOQNBpllKF4FtcJ17m0=;
  b=eH0MptjqdXn8ZJHMZVyrbKwZ6aVwJVh9V9nMFknYMI/tJdH1Ig65o1YR
   qSr5iy22YQNFol6qhVRPK9tT/qhWOHScUqzaxbY9tyzg/OfYfrCZgcw+h
   QjPluGdoIR4NeINnsNRA73dRzA1GXkwRNgUUlK2oe6s+J3HOqV3zoCnNB
   VTCYZuMT1nbiZJ3Eimnntil/2bR1VjiCrboO/Xn8OqQmwgOyEgmfFOw7k
   HWb0KUfWuEukKpvTaeEF0NpxSd43wicR1gRcno5Qx59FLNSIP3pRML6C8
   pnAd7u8Ky94pa+YPgV0MWDjPo7R3JYBix/dcVKcsEH7Pxu5yuq3KGO3d2
   Q==;
X-CSE-ConnectionGUID: KsK2ThsvRYmxzhXi54142A==
X-CSE-MsgGUID: 2qAxUk+qRQ6RuE77pr9K/g==
X-IronPort-AV: E=McAfee;i="6600,9927,11088"; a="13467932"
X-IronPort-AV: E=Sophos;i="6.08,202,1712646000"; 
   d="scan'208";a="13467932"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2024 18:22:20 -0700
X-CSE-ConnectionGUID: j1E0OUfnS06d8RjB+9HywA==
X-CSE-MsgGUID: VNerk86RQuOtSvoxCtS2Cw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,202,1712646000"; 
   d="scan'208";a="40455195"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by fmviesa005.fm.intel.com with ESMTP; 30 May 2024 18:22:18 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sCqyG-000GL3-0P;
	Fri, 31 May 2024 01:22:16 +0000
Date: Fri, 31 May 2024 09:21:39 +0800
From: kernel test robot <lkp@intel.com>
To: Oleg Nesterov <oleg@redhat.com>, Thomas Gleixner <tglx@linutronix.de>
Cc: oe-kbuild-all@lists.linux.dev,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tick: shift tick_nohz_switch_to_nohz() from
 tick_check_oneshot_change() to hrtimer_run_queues()
Message-ID: <202405310959.9U6sUim5-lkp@intel.com>
References: <20240530124203.GA26990@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240530124203.GA26990@redhat.com>

Hi Oleg,

kernel test robot noticed the following build errors:

[auto build test ERROR on tip/timers/core]
[also build test ERROR on linus/master v6.10-rc1 next-20240529]
[cannot apply to tip/timers/nohz]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Oleg-Nesterov/tick-shift-tick_nohz_switch_to_nohz-from-tick_check_oneshot_change-to-hrtimer_run_queues/20240530-204940
base:   tip/timers/core
patch link:    https://lore.kernel.org/r/20240530124203.GA26990%40redhat.com
patch subject: [PATCH] tick: shift tick_nohz_switch_to_nohz() from tick_check_oneshot_change() to hrtimer_run_queues()
config: i386-buildonly-randconfig-005-20240531 (https://download.01.org/0day-ci/archive/20240531/202405310959.9U6sUim5-lkp@intel.com/config)
compiler: gcc-13 (Ubuntu 13.2.0-4ubuntu3) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240531/202405310959.9U6sUim5-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405310959.9U6sUim5-lkp@intel.com/

All errors (new ones prefixed by >>):

   ld: kernel/time/hrtimer.o: in function `hrtimer_run_queues':
>> hrtimer.c:(.text+0x1851): undefined reference to `tick_nohz_switch_to_nohz'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

