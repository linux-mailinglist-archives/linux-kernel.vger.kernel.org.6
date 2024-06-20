Return-Path: <linux-kernel+bounces-222004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9171D90FB99
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 05:17:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D7271F22D30
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 03:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C79C81D540;
	Thu, 20 Jun 2024 03:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZylOazBN"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC84F3C30
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 03:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718853451; cv=none; b=BO2INAdkfs+TCs7U+1rxpx+fVrSj0rxavZdfu7+HrhDcDniziR8XdhbiTpr81vZGLSYELMYntH6FaCnC22Ep0kMQSOxKiNK+cxm5lrtP3tCgm0MJgENoPluVgsFQ/aGt0rklq/u88xuuCjgkK2phd9F/Ks1oonxgfexzthy7/7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718853451; c=relaxed/simple;
	bh=kFrhvDad9vopjUHSTUGe5oK1xfD6Qo46kfJN/Xdwe2o=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=eNXixAEN6HHItQN/oyWFJ2RYIFX0q4rpZVZ7KR3wGR3OXFygx9uipsMz1qr4IKi7P/L+dpNrI8/4yM98QewNCpCPx1vri1EwxMN6MHMU7uBrHAWZ2JdJRGFwivCCw+VlIeLAkaG/FR29TU9DyXELKueRL/WKCxXDPpH1bUHux7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZylOazBN; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718853450; x=1750389450;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=kFrhvDad9vopjUHSTUGe5oK1xfD6Qo46kfJN/Xdwe2o=;
  b=ZylOazBNQF5Bz8MoM+h6auOBCNp1VQUaF8EQopOGor5A5Hpb2WM2QdPN
   piRtxgmKt42NlC/NfofKNHK9/KdvxFMlJWyU/7rPWXD9WfBszqBHYbJWo
   AkybJquVrTS7eU62hiiGrDDjoG5TjkrNA+UKuhC+2pFH/AlEu6I72ZSLX
   EdkVdPtyB51QQ385/U6nHAb+bz7OuFjNK5qgsq+KlwCRBci2J6JWNs1xC
   5dU9zBuz+lwEfnJVb9LeKyUlhRRJrQWK9Q9bCBhJMQzzl4ScIZF+as+AC
   lkjw2inCuzhfXm9bDkSrh79TOPVsfdbKEc4FpQrc6ekYzhCJ5IGtH4FHt
   A==;
X-CSE-ConnectionGUID: 9JqkSp4uTsO8spyddQgH2A==
X-CSE-MsgGUID: B1HJreDnRkKSSdecI422Dg==
X-IronPort-AV: E=McAfee;i="6700,10204,11108"; a="27231598"
X-IronPort-AV: E=Sophos;i="6.08,251,1712646000"; 
   d="scan'208";a="27231598"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2024 20:17:13 -0700
X-CSE-ConnectionGUID: nHjbPQZqR/mfhmE2oKFZEA==
X-CSE-MsgGUID: ivGMZoqYQb2sgWQBofKWWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,251,1712646000"; 
   d="scan'208";a="42766445"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 19 Jun 2024 20:17:10 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sK8IO-0007GK-1v;
	Thu, 20 Jun 2024 03:17:08 +0000
Date: Thu, 20 Jun 2024 11:16:36 +0800
From: kernel test robot <lkp@intel.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev.2024.06.18a 20/34]
 kernel/time/clocksource.c:136:25: error:
 'CONFIG_CLOCKSOURCE_WATCHDOG_MAX_SKEW_US' undeclared
Message-ID: <202406201116.d69O9imA-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2024.06.18a
head:   f29bcafffef0ecc8a5d2cdc1bbef9a6889225263
commit: 5800c05045dbfeb8c9e571c6b47e8d7dd0d0691d [20/34] clocksource: Take advantage of always-defined CLOCKSOURCE_WATCHDOG_MAX_SKEW_US
config: arc-randconfig-002-20240620 (https://download.01.org/0day-ci/archive/20240620/202406201116.d69O9imA-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240620/202406201116.d69O9imA-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406201116.d69O9imA-lkp@intel.com/

All errors (new ones prefixed by >>):

   kernel/time/clocksource.c: In function '__clocksource_update_freq_scale':
>> kernel/time/clocksource.c:136:25: error: 'CONFIG_CLOCKSOURCE_WATCHDOG_MAX_SKEW_US' undeclared (first use in this function)
     136 | #define MAX_SKEW_USEC   CONFIG_CLOCKSOURCE_WATCHDOG_MAX_SKEW_US
         |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   kernel/time/clocksource.c:137:28: note: in expansion of macro 'MAX_SKEW_USEC'
     137 | #define WATCHDOG_MAX_SKEW (MAX_SKEW_USEC * NSEC_PER_USEC)
         |                            ^~~~~~~~~~~~~
   kernel/time/clocksource.c:1167:50: note: in expansion of macro 'WATCHDOG_MAX_SKEW'
    1167 |                 if (cs->uncertainty_margin < 2 * WATCHDOG_MAX_SKEW)
         |                                                  ^~~~~~~~~~~~~~~~~
   kernel/time/clocksource.c:136:25: note: each undeclared identifier is reported only once for each function it appears in
     136 | #define MAX_SKEW_USEC   CONFIG_CLOCKSOURCE_WATCHDOG_MAX_SKEW_US
         |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   kernel/time/clocksource.c:137:28: note: in expansion of macro 'MAX_SKEW_USEC'
     137 | #define WATCHDOG_MAX_SKEW (MAX_SKEW_USEC * NSEC_PER_USEC)
         |                            ^~~~~~~~~~~~~
   kernel/time/clocksource.c:1167:50: note: in expansion of macro 'WATCHDOG_MAX_SKEW'
    1167 |                 if (cs->uncertainty_margin < 2 * WATCHDOG_MAX_SKEW)
         |                                                  ^~~~~~~~~~~~~~~~~


vim +/CONFIG_CLOCKSOURCE_WATCHDOG_MAX_SKEW_US +136 kernel/time/clocksource.c

2e27e793e280ff1 Paul E. McKenney 2021-05-27  119  
2e27e793e280ff1 Paul E. McKenney 2021-05-27  120  /*
2e27e793e280ff1 Paul E. McKenney 2021-05-27  121   * Maximum permissible delay between two readouts of the watchdog
2e27e793e280ff1 Paul E. McKenney 2021-05-27  122   * clocksource surrounding a read of the clocksource being validated.
2e27e793e280ff1 Paul E. McKenney 2021-05-27  123   * This delay could be due to SMIs, NMIs, or to VCPU preemptions.  Used as
2e27e793e280ff1 Paul E. McKenney 2021-05-27  124   * a lower bound for cs->uncertainty_margin values when registering clocks.
c37e85c135cead4 Paul E. McKenney 2022-12-06  125   *
c37e85c135cead4 Paul E. McKenney 2022-12-06  126   * The default of 500 parts per million is based on NTP's limits.
c37e85c135cead4 Paul E. McKenney 2022-12-06  127   * If a clocksource is good enough for NTP, it is good enough for us!
ababe5f6bfbf3eb Borislav Petkov  2024-06-12  128   *
ababe5f6bfbf3eb Borislav Petkov  2024-06-12  129   * In other words, by default, even if a clocksource is extremely
ababe5f6bfbf3eb Borislav Petkov  2024-06-12  130   * precise (for example, with a sub-nanosecond period), the maximum
ababe5f6bfbf3eb Borislav Petkov  2024-06-12  131   * permissible skew between the clocksource watchdog and the clocksource
ababe5f6bfbf3eb Borislav Petkov  2024-06-12  132   * under test is not permitted to go below the 500ppm minimum defined
ababe5f6bfbf3eb Borislav Petkov  2024-06-12  133   * by MAX_SKEW_USEC.  This 500ppm minimum may be overridden using the
ababe5f6bfbf3eb Borislav Petkov  2024-06-12  134   * CLOCKSOURCE_WATCHDOG_MAX_SKEW_US Kconfig option.
2e27e793e280ff1 Paul E. McKenney 2021-05-27  135   */
fc153c1c58cb8c3 Waiman Long      2021-12-05 @136  #define MAX_SKEW_USEC	CONFIG_CLOCKSOURCE_WATCHDOG_MAX_SKEW_US
fc153c1c58cb8c3 Waiman Long      2021-12-05  137  #define WATCHDOG_MAX_SKEW (MAX_SKEW_USEC * NSEC_PER_USEC)
2e27e793e280ff1 Paul E. McKenney 2021-05-27  138  

:::::: The code at line 136 was first introduced by commit
:::::: fc153c1c58cb8c3bb3b443b4d7dc3211ff5f65fc clocksource: Add a Kconfig option for WATCHDOG_MAX_SKEW

:::::: TO: Waiman Long <longman@redhat.com>
:::::: CC: Paul E. McKenney <paulmck@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

