Return-Path: <linux-kernel+bounces-323944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 088069745D6
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 00:21:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A79E1C21221
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 22:21:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA3751AB51E;
	Tue, 10 Sep 2024 22:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OMkvxjO5"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 611B91A7AE5
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 22:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726006877; cv=none; b=CA/Kue0UjITZQh67ACpY2TBkyNqIsrLfVwmgjrzhwe/53P9KFfVuExeuBNcrrTMSk+skenVL1yuMH0Fp/U2cWbYdeY4nklS52mp/eaDecznBxO2KKgjk+5KHRRTH0Hs02ZVKZ/KADWBqHtUN92fUfPrcmd8xH7HcwrbrGHtXMVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726006877; c=relaxed/simple;
	bh=/Z18wiXVRmZ/aPtT+yW1l7qM3HA7Wf3Ssasu4f6oXm4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=AtpnawZzs8Ig2keFB8rj0tBl0D4NZotg8o6ZEAY4aSOKYnoulDkVC/FuC5vLInCvucb/DddlwfAsGV/wT+ACcrpRiw/enPaV3vUcBphY8BkHp15oK61Ih/r0BlCmZyY1PpcWKHorlZZXw0Ccf+HKLuTziaEJb2lJcka9aZp0zuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OMkvxjO5; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726006876; x=1757542876;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=/Z18wiXVRmZ/aPtT+yW1l7qM3HA7Wf3Ssasu4f6oXm4=;
  b=OMkvxjO5OqjhuR+JgfA8kWVDp8yb/oLRAfBtCD+i7BqxwCk3XbTHr9YY
   u5MvLNYS2uoquuX5k+l1tupxBkQgShCuK3NjHogf1Gh52E4CfoKznWkwF
   cvH7Ghvth7X/zacZy7/l3FVdyxK39TcV7pyBJaQvSDLNb9Lia4h5yxhtg
   bPdje8DWLDZQB8uhljQnehg0STHelSKE8A1xvO9fmwOYJ4KleET/ZAZ3U
   L7Vku4ZURgSC/mQBU25OkTLP/Marm5t1lIvJjRnDgQm2Hwg7k0qxKvnx8
   28jAJw2pZ3t8KgaAqmNo85bSkHH868YsWHbVe3NHCunXe6dW9SNuepkvr
   w==;
X-CSE-ConnectionGUID: r1qdUSRWQQOJDnYZ9vtMkw==
X-CSE-MsgGUID: fyAYYajGRbaAxQEpG7ia4Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11191"; a="35353222"
X-IronPort-AV: E=Sophos;i="6.10,218,1719903600"; 
   d="scan'208";a="35353222"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2024 15:21:15 -0700
X-CSE-ConnectionGUID: zvs4WUXQRVW72icL34XQ0Q==
X-CSE-MsgGUID: BLdS3QKVSaW62UM1O92okQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,218,1719903600"; 
   d="scan'208";a="104628514"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 10 Sep 2024 15:21:13 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1so9EV-0002mI-1Q;
	Tue, 10 Sep 2024 22:21:11 +0000
Date: Wed, 11 Sep 2024 06:20:36 +0800
From: kernel test robot <lkp@intel.com>
To: Christian Loehle <christian.loehle@arm.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	x86@kernel.org, Peter Zijlstra <peterz@infradead.org>
Subject: [tip:sched/core 69/70] drivers/cpufreq/cppc_cpufreq.c:227:20: error:
 use of undeclared identifier 'NSER_PER_MSEC'
Message-ID: <202409110611.dmyDCkoe-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Christian,

FYI, the error/warning was bisected to this commit, please ignore it if it's irrelevant.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched/core
head:   6cbbb91711c6b17da3802a3cf072d3311828ca33
commit: b3a47ff095544af206b8885391a7bad662d06a57 [69/70] cpufreq/cppc: Use NSEC_PER_MSEC for deadline task
config: riscv-allmodconfig (https://download.01.org/0day-ci/archive/20240911/202409110611.dmyDCkoe-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project bf684034844c660b778f0eba103582f582b710c9)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240911/202409110611.dmyDCkoe-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409110611.dmyDCkoe-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/cpufreq/cppc_cpufreq.c:227:20: error: use of undeclared identifier 'NSER_PER_MSEC'
     227 |                 .sched_runtime  = NSER_PER_MSEC,
         |                                   ^
>> drivers/cpufreq/cppc_cpufreq.c:229:3: error: member reference base type 'long' is not a structure or union
     228 |                 .sched_deadline = 10 * NSEC_PER_MSEC
         |                                        ~~~~~~~~~~~~~
     229 |                 .sched_period   = 10 * NSEC_PER_MSEC,
         |                 ^~~~~~~~~~~~~
   2 errors generated.


vim +/NSER_PER_MSEC +227 drivers/cpufreq/cppc_cpufreq.c

   215	
   216	static void __init cppc_freq_invariance_init(void)
   217	{
   218		struct sched_attr attr = {
   219			.size		= sizeof(struct sched_attr),
   220			.sched_policy	= SCHED_DEADLINE,
   221			.sched_nice	= 0,
   222			.sched_priority	= 0,
   223			/*
   224			 * Fake (unused) bandwidth; workaround to "fix"
   225			 * priority inheritance.
   226			 */
 > 227			.sched_runtime	= NSER_PER_MSEC,
   228			.sched_deadline = 10 * NSEC_PER_MSEC
 > 229			.sched_period	= 10 * NSEC_PER_MSEC,
   230		};
   231		int ret;
   232	
   233		if (fie_disabled != FIE_ENABLED && fie_disabled != FIE_DISABLED) {
   234			fie_disabled = FIE_ENABLED;
   235			if (cppc_perf_ctrs_in_pcc()) {
   236				pr_info("FIE not enabled on systems with registers in PCC\n");
   237				fie_disabled = FIE_DISABLED;
   238			}
   239		}
   240	
   241		if (fie_disabled)
   242			return;
   243	
   244		kworker_fie = kthread_create_worker(0, "cppc_fie");
   245		if (IS_ERR(kworker_fie)) {
   246			pr_warn("%s: failed to create kworker_fie: %ld\n", __func__,
   247				PTR_ERR(kworker_fie));
   248			fie_disabled = FIE_DISABLED;
   249			return;
   250		}
   251	
   252		ret = sched_setattr_nocheck(kworker_fie->task, &attr);
   253		if (ret) {
   254			pr_warn("%s: failed to set SCHED_DEADLINE: %d\n", __func__,
   255				ret);
   256			kthread_destroy_worker(kworker_fie);
   257			fie_disabled = FIE_DISABLED;
   258		}
   259	}
   260	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

