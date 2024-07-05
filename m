Return-Path: <linux-kernel+bounces-241894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20F179280BD
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 05:00:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DEF41C245C4
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 03:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 019685EE95;
	Fri,  5 Jul 2024 02:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gogq4zs2"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F7BD28E8
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 02:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720148232; cv=none; b=nOzM4RZUKALUnbej358EOS70wmg/RKC177Bs4mGrYzRNiSJQ9EwqCDv/q/FQucm4FozvVxf9o/omKcdOoqq0p/ScfaqJK0tD/8e7j9ifjAMFQ95EQUT/qYaZdAQ1QYcpE0i4sLHsXpf7u2V96SNATaWE9x4OeDpFwBeU+9NbcY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720148232; c=relaxed/simple;
	bh=3UZI0sR5AyyDk+4lhiOHvYwd2Wj9tcfb9AD/xql8L18=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=YhywCPwZnjut8DcW+BDZawj5dqjaGrinNTZtONTsg8g+yKZzKbjddxsE7kWbyfLotjNCIBDJFnz07JsOunSFTzJBerogz3gLgJxnt2vLE8+/reiwB3zxlC470XLCWyfq00L2yZeI9Mc+dBl6V2ndJ0Kg9Dy/SiUIqZpc6L2aRxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gogq4zs2; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720148230; x=1751684230;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=3UZI0sR5AyyDk+4lhiOHvYwd2Wj9tcfb9AD/xql8L18=;
  b=gogq4zs2imNc7OFdyBzDNmD0AZDoScv8rClk48lEtbAKV8bjgABm4c32
   wP5jN+0HO9wn30C7nGR5p20xjc2h/vlviND9+NgsQ7Kk7tSaXk+71Mhc/
   +1tUNtUnTwx+HXOzff/e5J6lG/evQJTI1pegasjtD1V2BrkXm+NfSy9Do
   rlkXX1Z5RNB3U8W5HiuNHLlyxtO3f6GtCqix6CwGRDq/XFVWvdFoDUHLE
   fxWwmAdv8Dzi/Yg8O9yWy2QAQIIbj6f89w30aFwYRMqeox/2KjHrhelQ9
   ARQwr8Q/2wKYGpXuuEjClhi1n+hSVAaAkqgjKVY40qN6NEMLD7Ow2Z8FI
   w==;
X-CSE-ConnectionGUID: met89ADPQ2GyaGus8UBPSg==
X-CSE-MsgGUID: cNRwhgIfRQS+NrnaTrKg3w==
X-IronPort-AV: E=McAfee;i="6700,10204,11123"; a="42855709"
X-IronPort-AV: E=Sophos;i="6.09,183,1716274800"; 
   d="scan'208";a="42855709"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2024 19:57:07 -0700
X-CSE-ConnectionGUID: +NfQeeItRlea6M7W2eWsLw==
X-CSE-MsgGUID: C6Mw2XxfQhisAwuADvmEng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,183,1716274800"; 
   d="scan'208";a="46769312"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 04 Jul 2024 19:57:06 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sPZ8B-000RpE-3C;
	Fri, 05 Jul 2024 02:57:03 +0000
Date: Fri, 5 Jul 2024 10:57:00 +0800
From: kernel test robot <lkp@intel.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev.2024.07.04a 51/60] kernel/rcu/tasks.h:2048:13:
 warning: 'test_rcu_tasks_callback' defined but not used
Message-ID: <202407051058.MZAxjsJZ-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2024.07.04a
head:   eb325da54c0ff3147fa6dc7be2a313f45715f904
commit: 9bd3378dd10ba24793a049b5c71f87e01ddb3b51 [51/60] rcu-tasks: Remove RCU Tasks Rude asynchronous APIs
config: i386-buildonly-randconfig-002-20240705 (https://download.01.org/0day-ci/archive/20240705/202407051058.MZAxjsJZ-lkp@intel.com/config)
compiler: gcc-9 (Ubuntu 9.5.0-4ubuntu2) 9.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240705/202407051058.MZAxjsJZ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202407051058.MZAxjsJZ-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from kernel/rcu/update.c:656:
>> kernel/rcu/tasks.h:2048:13: warning: 'test_rcu_tasks_callback' defined but not used [-Wunused-function]
    2048 | static void test_rcu_tasks_callback(struct rcu_head *rhp)
         |             ^~~~~~~~~~~~~~~~~~~~~~~
   In file included from kernel/rcu/update.c:656:
>> kernel/rcu/tasks.h:399:13: warning: 'rcu_barrier_tasks_generic' defined but not used [-Wunused-function]
     399 | static void rcu_barrier_tasks_generic(struct rcu_tasks *rtp)
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~


vim +/test_rcu_tasks_callback +2048 kernel/rcu/tasks.h

bfba7ed084f8ab Uladzislau Rezki (Sony  2020-12-09  2047) 
bfba7ed084f8ab Uladzislau Rezki (Sony  2020-12-09 @2048) static void test_rcu_tasks_callback(struct rcu_head *rhp)
bfba7ed084f8ab Uladzislau Rezki (Sony  2020-12-09  2049) {
bfba7ed084f8ab Uladzislau Rezki (Sony  2020-12-09  2050) 	struct rcu_tasks_test_desc *rttd =
bfba7ed084f8ab Uladzislau Rezki (Sony  2020-12-09  2051) 		container_of(rhp, struct rcu_tasks_test_desc, rh);
bfba7ed084f8ab Uladzislau Rezki (Sony  2020-12-09  2052) 
bfba7ed084f8ab Uladzislau Rezki (Sony  2020-12-09  2053) 	pr_info("Callback from %s invoked.\n", rttd->name);
bfba7ed084f8ab Uladzislau Rezki (Sony  2020-12-09  2054) 
1cf1144e8473e8 Paul E. McKenney        2022-06-07  2055  	rttd->notrun = false;
bfba7ed084f8ab Uladzislau Rezki (Sony  2020-12-09  2056) }
bfba7ed084f8ab Uladzislau Rezki (Sony  2020-12-09  2057) 

:::::: The code at line 2048 was first introduced by commit
:::::: bfba7ed084f8ab0269a5a1d2f51b07865456c334 rcu-tasks: Add RCU-tasks self tests

:::::: TO: Uladzislau Rezki (Sony) <urezki@gmail.com>
:::::: CC: Paul E. McKenney <paulmck@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

