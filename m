Return-Path: <linux-kernel+bounces-383273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 74E889B1951
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 17:42:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93D921C20A76
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 15:42:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA2CA770E2;
	Sat, 26 Oct 2024 15:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AdlWIUdY"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E68352AD0C
	for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 15:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729957334; cv=none; b=tlB/dNeKEXTeRcuQKis5lVCEgG6ZmTuybVWC3Fn4JqXKVXWXsDm/ieJjlXbmFoZ63rfSsPRCKff04aAGTM9xCnxLbJSwwcI7BZZpM60N5zVUl2qUzeV2O7W6Kb6JtH6iHCPj9cioasVCpdFQ6LFAAO5b5ZwRFILGObymKWS1unQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729957334; c=relaxed/simple;
	bh=U3XvoThQntD8wl/3aow8VVyr7FF1JmJG9FGXPTtsiYI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=as54puyU1dPFmffBNaLfExJaHoVowmekHWyuVKZEzCUY3uamlQAf5BLpjBfsRHbrnDXaHRZqjqoyyxmxU+YH/pNDaw72LNPdyBJs3dGWnuX6jcpDZm4NrBuIxUcMo06L4Qgde1dciN4/lzorFc8cnO6Z0yuE3fmGCL7524OfLP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AdlWIUdY; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729957331; x=1761493331;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=U3XvoThQntD8wl/3aow8VVyr7FF1JmJG9FGXPTtsiYI=;
  b=AdlWIUdYjH9uuFZeLF3VTuJIwD+W+pdH1wTEaKBdkQV8HByzNnKme5Dj
   0lOs408GekpYDbowNLUjKO3zMSWaALEIUMIurEVfETQqPSvMEx2j2o4UQ
   pDpXilYoWVbaQcP2NjOYmQIVSVRwBxYEywVV+p+TJTeRFivTSetTmTsJ5
   2Za5hsiY3ku25e1hCap0YJAn21ru8xl2bNHV1TS8KUp3LRxmCWtGlIopG
   kw32uND0kp4wjIQW9U7cUCi/ZyvQ0Q7wv1exCkO5MdfD4oFYcJyMtPHrv
   z6pVd/BmAkDbfLzq4Vs6ttDjrd7yGI2gR6MHSBJBoQRNRj25WA45vnKkW
   Q==;
X-CSE-ConnectionGUID: pWdH0EBRTH+gJVu5xvzlNA==
X-CSE-MsgGUID: YW0expCRTc62RC0EsyQGDw==
X-IronPort-AV: E=McAfee;i="6700,10204,11237"; a="29726848"
X-IronPort-AV: E=Sophos;i="6.11,235,1725346800"; 
   d="scan'208";a="29726848"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2024 08:42:10 -0700
X-CSE-ConnectionGUID: yYJtEhNGQGa8pHfSCboADQ==
X-CSE-MsgGUID: nwkgVL2SQfqThER+IPe/1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,235,1725346800"; 
   d="scan'208";a="85967282"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 26 Oct 2024 08:42:08 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t4ivW-000Zmu-0r;
	Sat, 26 Oct 2024 15:42:06 +0000
Date: Sat, 26 Oct 2024 23:41:19 +0800
From: kernel test robot <lkp@intel.com>
To: Tejun Heo <tj@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	David Vernet <dvernet@meta.com>, Josh Don <joshdon@google.com>
Subject: kernel/sched/ext.c:2399:56: sparse: sparse: incorrect type in
 initializer (different address spaces)
Message-ID: <202410262340.HYNIIi1E-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   850925a8133c73c4a2453c360b2c3beb3bab67c9
commit: 7b0888b7cc1924b74ce660e02f6211df8dd46e7b sched_ext: Implement core-sched support
date:   4 months ago
config: s390-randconfig-r112-20241026 (https://download.01.org/0day-ci/archive/20241026/202410262340.HYNIIi1E-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 5886454669c3c9026f7f27eab13509dd0241f2d6)
reproduce: (https://download.01.org/0day-ci/archive/20241026/202410262340.HYNIIi1E-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410262340.HYNIIi1E-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   kernel/sched/build_policy.c: note: in included file:
   kernel/sched/rt.c:916:70: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/rt.c:916:70: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/rt.c:916:70: sparse:    struct task_struct *
   kernel/sched/rt.c:2364:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/rt.c:2364:25: sparse:    struct task_struct *
   kernel/sched/rt.c:2364:25: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/rt.c:1002:38: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct task_struct *curr @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/rt.c:1002:38: sparse:     expected struct task_struct *curr
   kernel/sched/rt.c:1002:38: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/rt.c:1536:31: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct task_struct *p @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/rt.c:1536:31: sparse:     expected struct task_struct *p
   kernel/sched/rt.c:1536:31: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/rt.c:1876:9: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct sched_domain *[assigned] sd @@     got struct sched_domain [noderef] __rcu *parent @@
   kernel/sched/rt.c:1876:9: sparse:     expected struct sched_domain *[assigned] sd
   kernel/sched/rt.c:1876:9: sparse:     got struct sched_domain [noderef] __rcu *parent
   kernel/sched/rt.c:1556:14: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct task_struct *curr @@     got struct task_struct [noderef] __rcu * @@
   kernel/sched/rt.c:1556:14: sparse:     expected struct task_struct *curr
   kernel/sched/rt.c:1556:14: sparse:     got struct task_struct [noderef] __rcu *
   kernel/sched/rt.c:1621:45: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct task_struct *p @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/rt.c:1621:45: sparse:     expected struct task_struct *p
   kernel/sched/rt.c:1621:45: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/rt.c:1682:67: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *tsk @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/rt.c:1682:67: sparse:     expected struct task_struct *tsk
   kernel/sched/rt.c:1682:67: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/rt.c:2044:40: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *task @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/rt.c:2044:40: sparse:     expected struct task_struct *task
   kernel/sched/rt.c:2044:40: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/rt.c:2067:13: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/rt.c:2067:13: sparse:    struct task_struct *
   kernel/sched/rt.c:2067:13: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/rt.c:2417:54: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *tsk @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/rt.c:2417:54: sparse:     expected struct task_struct *tsk
   kernel/sched/rt.c:2417:54: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/rt.c:2419:40: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *p @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/rt.c:2419:40: sparse:     expected struct task_struct *p
   kernel/sched/rt.c:2419:40: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/rt.c:2419:61: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *p @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/rt.c:2419:61: sparse:     expected struct task_struct *p
   kernel/sched/rt.c:2419:61: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/build_policy.c: note: in included file:
   kernel/sched/deadline.c:2401:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *p @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/deadline.c:2401:23: sparse:     expected struct task_struct *p
   kernel/sched/deadline.c:2401:23: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/deadline.c:2411:13: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/deadline.c:2411:13: sparse:    struct task_struct *
   kernel/sched/deadline.c:2411:13: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/deadline.c:2519:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/deadline.c:2519:25: sparse:    struct task_struct *
   kernel/sched/deadline.c:2519:25: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/deadline.c:2026:42: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct sched_dl_entity const *b @@     got struct sched_dl_entity [noderef] __rcu * @@
   kernel/sched/deadline.c:2026:42: sparse:     expected struct sched_dl_entity const *b
   kernel/sched/deadline.c:2026:42: sparse:     got struct sched_dl_entity [noderef] __rcu *
   kernel/sched/deadline.c:2037:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *tsk @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/deadline.c:2037:38: sparse:     expected struct task_struct *tsk
   kernel/sched/deadline.c:2037:38: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/deadline.c:1220:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *p @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/deadline.c:1220:23: sparse:     expected struct task_struct *p
   kernel/sched/deadline.c:1220:23: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/deadline.c:1444:38: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct task_struct *curr @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/deadline.c:1444:38: sparse:     expected struct task_struct *curr
   kernel/sched/deadline.c:1444:38: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/deadline.c:2262:9: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct sched_domain *[assigned] sd @@     got struct sched_domain [noderef] __rcu *parent @@
   kernel/sched/deadline.c:2262:9: sparse:     expected struct sched_domain *[assigned] sd
   kernel/sched/deadline.c:2262:9: sparse:     got struct sched_domain [noderef] __rcu *parent
   kernel/sched/deadline.c:1911:14: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct task_struct *curr @@     got struct task_struct [noderef] __rcu * @@
   kernel/sched/deadline.c:1911:14: sparse:     expected struct task_struct *curr
   kernel/sched/deadline.c:1911:14: sparse:     got struct task_struct [noderef] __rcu *
   kernel/sched/deadline.c:1987:43: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct task_struct *p @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/deadline.c:1987:43: sparse:     expected struct task_struct *p
   kernel/sched/deadline.c:1987:43: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/deadline.c:2566:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *tsk @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/deadline.c:2566:38: sparse:     expected struct task_struct *tsk
   kernel/sched/deadline.c:2566:38: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/deadline.c:2568:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *p @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/deadline.c:2568:23: sparse:     expected struct task_struct *p
   kernel/sched/deadline.c:2568:23: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/deadline.c:2570:44: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct sched_dl_entity const *b @@     got struct sched_dl_entity [noderef] __rcu * @@
   kernel/sched/deadline.c:2570:44: sparse:     expected struct sched_dl_entity const *b
   kernel/sched/deadline.c:2570:44: sparse:     got struct sched_dl_entity [noderef] __rcu *
   kernel/sched/deadline.c:2745:22: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/deadline.c:2745:22: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/deadline.c:2745:22: sparse:    struct task_struct *
   kernel/sched/deadline.c:2794:32: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *p @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/build_policy.c: note: in included file:
   kernel/sched/ext.c:772:25: sparse: sparse: symbol 'scx_has_op' was not declared. Should it be static?
   kernel/sched/ext.c:876:22: sparse: sparse: symbol 'scx_dump_data' was not declared. Should it be static?
   kernel/sched/ext.c:1334:38: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct task_struct *curr @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/ext.c:1406:56: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/ext.c:1406:56: sparse:    struct task_struct *
   kernel/sched/ext.c:1406:56: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/ext.c:1799:35: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct task_struct *p @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/ext.c:1799:35: sparse:     expected struct task_struct *p
   kernel/sched/ext.c:1799:35: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/ext.c:1809:38: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct task_struct *from @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/ext.c:1809:38: sparse:     expected struct task_struct *from
   kernel/sched/ext.c:1809:38: sparse:     got struct task_struct [noderef] __rcu *curr
>> kernel/sched/ext.c:2399:56: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct task_struct *sprev @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/ext.c:2399:56: sparse:     expected struct task_struct *sprev
   kernel/sched/ext.c:2399:56: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/ext.c:4206:52: sparse: sparse: incorrect type in argument 3 (different address spaces) @@     expected struct task_struct *p @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/ext.c:4206:52: sparse:     expected struct task_struct *p
   kernel/sched/ext.c:4206:52: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/ext.c:4914:32: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct const *p @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/ext.c:4914:32: sparse:     expected struct task_struct const *p
   kernel/sched/ext.c:4914:32: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/ext.c:5905:33: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/ext.c:5905:33: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/ext.c:5905:33: sparse:    struct task_struct const *
   kernel/sched/build_policy.c: note: in included file:
   kernel/sched/syscalls.c:206:22: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/syscalls.c:206:22: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/syscalls.c:206:22: sparse:    struct task_struct *
   kernel/sched/build_policy.c: note: in included file (through include/linux/smp.h, include/linux/sched/clock.h):
   include/linux/list.h:83:21: sparse: sparse: self-comparison always evaluates to true
   include/linux/list.h:83:21: sparse: sparse: self-comparison always evaluates to true
   kernel/sched/build_policy.c: note: in included file:
   kernel/sched/sched.h:2234:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2234:25: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2234:25: sparse:    struct task_struct *
   kernel/sched/sched.h:2234:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2234:25: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2234:25: sparse:    struct task_struct *
   kernel/sched/sched.h:2234:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2234:25: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2234:25: sparse:    struct task_struct *
   kernel/sched/sched.h:2234:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2234:25: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2234:25: sparse:    struct task_struct *
   kernel/sched/sched.h:2234:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2234:25: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2234:25: sparse:    struct task_struct *
   kernel/sched/sched.h:2234:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2234:25: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2234:25: sparse:    struct task_struct *
   kernel/sched/sched.h:2234:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2234:25: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2234:25: sparse:    struct task_struct *
   kernel/sched/sched.h:2234:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2234:25: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2234:25: sparse:    struct task_struct *
   kernel/sched/sched.h:2234:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2234:25: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2234:25: sparse:    struct task_struct *
   kernel/sched/sched.h:2234:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2234:25: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2234:25: sparse:    struct task_struct *
   kernel/sched/sched.h:2409:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2409:9: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2409:9: sparse:    struct task_struct *
   kernel/sched/sched.h:2234:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2234:25: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2234:25: sparse:    struct task_struct *
   kernel/sched/sched.h:2409:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2409:9: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2409:9: sparse:    struct task_struct *
   kernel/sched/build_policy.c: note: in included file:
   kernel/sched/syscalls.c:1426:6: sparse: sparse: context imbalance in 'sched_getaffinity' - different lock contexts for basic block
   kernel/sched/build_policy.c: note: in included file:
   kernel/sched/rt.c:1707:15: sparse: sparse: dereference of noderef expression

vim +2399 kernel/sched/ext.c

  2378	
  2379	static int balance_scx(struct rq *rq, struct task_struct *prev,
  2380			       struct rq_flags *rf)
  2381	{
  2382		int ret;
  2383	
  2384		ret = balance_one(rq, prev, rf, true);
  2385	
  2386	#ifdef CONFIG_SCHED_SMT
  2387		/*
  2388		 * When core-sched is enabled, this ops.balance() call will be followed
  2389		 * by put_prev_scx() and pick_task_scx() on this CPU and pick_task_scx()
  2390		 * on the SMT siblings. Balance the siblings too.
  2391		 */
  2392		if (sched_core_enabled(rq)) {
  2393			const struct cpumask *smt_mask = cpu_smt_mask(cpu_of(rq));
  2394			int scpu;
  2395	
  2396			for_each_cpu_andnot(scpu, smt_mask, cpumask_of(cpu_of(rq))) {
  2397				struct rq *srq = cpu_rq(scpu);
  2398				struct rq_flags srf;
> 2399				struct task_struct *sprev = srq->curr;
  2400	
  2401				/*
  2402				 * While core-scheduling, rq lock is shared among
  2403				 * siblings but the debug annotations and rq clock
  2404				 * aren't. Do pinning dance to transfer the ownership.
  2405				 */
  2406				WARN_ON_ONCE(__rq_lockp(rq) != __rq_lockp(srq));
  2407				rq_unpin_lock(rq, rf);
  2408				rq_pin_lock(srq, &srf);
  2409	
  2410				update_rq_clock(srq);
  2411				balance_one(srq, sprev, &srf, false);
  2412	
  2413				rq_unpin_lock(srq, &srf);
  2414				rq_repin_lock(rq, rf);
  2415			}
  2416		}
  2417	#endif
  2418		return ret;
  2419	}
  2420	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

