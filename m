Return-Path: <linux-kernel+bounces-306213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA9ED963B2E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 08:20:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 156CF1C227C8
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 06:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2700158D91;
	Thu, 29 Aug 2024 06:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RiuaI/6w"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ED06152165
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 06:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724912390; cv=none; b=ETG/XUl2r22/YNXxV35oVsQulS/0Te4AMmNTw5OC6ysiv5zRwbTdXCI0lkkjtUw/IQilmp+Ci7Psv6Iom6y/+cIi4EkYHaxFv82V/ktBDPp3KiJZeRDC1WZFxGn/GhChxk31e/C7U67hPE9BrvN4kQdpcdTiOt+tol+pkVnWvPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724912390; c=relaxed/simple;
	bh=mmmjc/hMQ9ItQRfsRYqLNjVpu1KWrcIjZmNugqjckX0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=j6s+bMLiBU4aCwd8qa2hZJvzWltUqrk6ivZkhj8icJUirwF6umJaS4Sl/U7cJCobubyIwu0mLaAYL+2l54qI+jtzW1i6koYHtisFgUCuDd+ovUOUZ09preS+tKQ5hGDrLx1rz4VxWM+Y5oYHKH8BLVjMfsE3eP2gWzDbrrq1S4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RiuaI/6w; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724912389; x=1756448389;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=mmmjc/hMQ9ItQRfsRYqLNjVpu1KWrcIjZmNugqjckX0=;
  b=RiuaI/6w//J3FvDW6JvrYayhsSGGMWjQ77USwXt2YNBhbOdtV/ryadbC
   ZC4hnI5St3OVR0/dOv85YSTPQOy5bS2YTtdtt7bAweAtlqPUkTLl59TGW
   u9e6R0keMg5HzZg9JJyiWpKEASoNkN9VfUSWR39aiyHTODekHDgmu5tAm
   /lNpf7ryFHitmMj58jW+FyRBNHccYvR0pBW+p/zFBIMZqtB5kgHLo8xeR
   y8NPoEquCHwsmy38H3IVMdkvSsi/XMfjfmyAUXhoNKXDA2FYUPFcxbUCd
   u/INtrS58IlNw/DLfS6HzrCSRFaT4YDBSsQ5NEkk4TGEm5D37tmWLj3px
   g==;
X-CSE-ConnectionGUID: OMYn0wTkT8uUik7gPcgLtw==
X-CSE-MsgGUID: 2UyWCoNDREu822rSpxpSVQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11178"; a="34139092"
X-IronPort-AV: E=Sophos;i="6.10,184,1719903600"; 
   d="scan'208";a="34139092"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2024 23:19:49 -0700
X-CSE-ConnectionGUID: SZ6QgZfASOCALo7kRuaJwQ==
X-CSE-MsgGUID: iDUBGWH6T5moZwfEMiQ1zg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,184,1719903600"; 
   d="scan'208";a="67619595"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 28 Aug 2024 23:19:47 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sjYVV-000LmG-0b;
	Thu, 29 Aug 2024 06:19:45 +0000
Date: Thu, 29 Aug 2024 14:18:56 +0800
From: kernel test robot <lkp@intel.com>
To: "Steven Rostedt (Google)" <rostedt@goodmis.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: kernel/trace/trace.c:2102:19: error: unused function
 'run_tracer_selftest'
Message-ID: <202408291419.auyiQ03C-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   d5d547aa7b51467b15d9caa86b116f8c2507c72a
commit: e8352cf5778c53b80fdcee086278b2048ddb8f98 tracing: Move setting of tracing_selftest_running out of register_tracer()
date:   1 year, 3 months ago
config: x86_64-sof-customedconfig-amd-defconfig (https://download.01.org/0day-ci/archive/20240829/202408291419.auyiQ03C-lkp@intel.com/config)
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240829/202408291419.auyiQ03C-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408291419.auyiQ03C-lkp@intel.com/

All errors (new ones prefixed by >>):

>> kernel/trace/trace.c:2102:19: error: unused function 'run_tracer_selftest' [-Werror,-Wunused-function]
    2102 | static inline int run_tracer_selftest(struct tracer *type)
         |                   ^~~~~~~~~~~~~~~~~~~
   1 error generated.


vim +/run_tracer_selftest +2102 kernel/trace/trace.c

e8352cf5778c53 Steven Rostedt (Google   2023-05-28  2054) 
9afecfbb95198e Steven Rostedt (VMware   2017-03-24  2055) static __init int init_trace_selftests(void)
9afecfbb95198e Steven Rostedt (VMware   2017-03-24  2056) {
9afecfbb95198e Steven Rostedt (VMware   2017-03-24  2057) 	struct trace_selftests *p, *n;
9afecfbb95198e Steven Rostedt (VMware   2017-03-24  2058) 	struct tracer *t, **last;
9afecfbb95198e Steven Rostedt (VMware   2017-03-24  2059) 	int ret;
9afecfbb95198e Steven Rostedt (VMware   2017-03-24  2060) 
9afecfbb95198e Steven Rostedt (VMware   2017-03-24  2061) 	selftests_can_run = true;
9afecfbb95198e Steven Rostedt (VMware   2017-03-24  2062) 
9afecfbb95198e Steven Rostedt (VMware   2017-03-24  2063) 	mutex_lock(&trace_types_lock);
9afecfbb95198e Steven Rostedt (VMware   2017-03-24  2064) 
9afecfbb95198e Steven Rostedt (VMware   2017-03-24  2065) 	if (list_empty(&postponed_selftests))
9afecfbb95198e Steven Rostedt (VMware   2017-03-24  2066) 		goto out;
9afecfbb95198e Steven Rostedt (VMware   2017-03-24  2067) 
9afecfbb95198e Steven Rostedt (VMware   2017-03-24  2068) 	pr_info("Running postponed tracer tests:\n");
9afecfbb95198e Steven Rostedt (VMware   2017-03-24  2069) 
78041c0c9e935d Steven Rostedt (VMware   2020-02-20  2070) 	tracing_selftest_running = true;
9afecfbb95198e Steven Rostedt (VMware   2017-03-24  2071) 	list_for_each_entry_safe(p, n, &postponed_selftests, list) {
6fc2171c5c0367 Anders Roxell            2018-11-30  2072  		/* This loop can take minutes when sanitizers are enabled, so
6fc2171c5c0367 Anders Roxell            2018-11-30  2073  		 * lets make sure we allow RCU processing.
6fc2171c5c0367 Anders Roxell            2018-11-30  2074  		 */
6fc2171c5c0367 Anders Roxell            2018-11-30  2075  		cond_resched();
9afecfbb95198e Steven Rostedt (VMware   2017-03-24  2076) 		ret = run_tracer_selftest(p->type);
9afecfbb95198e Steven Rostedt (VMware   2017-03-24  2077) 		/* If the test fails, then warn and remove from available_tracers */
9afecfbb95198e Steven Rostedt (VMware   2017-03-24  2078) 		if (ret < 0) {
9afecfbb95198e Steven Rostedt (VMware   2017-03-24  2079) 			WARN(1, "tracer: %s failed selftest, disabling\n",
9afecfbb95198e Steven Rostedt (VMware   2017-03-24  2080) 			     p->type->name);
9afecfbb95198e Steven Rostedt (VMware   2017-03-24  2081) 			last = &trace_types;
9afecfbb95198e Steven Rostedt (VMware   2017-03-24  2082) 			for (t = trace_types; t; t = t->next) {
9afecfbb95198e Steven Rostedt (VMware   2017-03-24  2083) 				if (t == p->type) {
9afecfbb95198e Steven Rostedt (VMware   2017-03-24  2084) 					*last = t->next;
9afecfbb95198e Steven Rostedt (VMware   2017-03-24  2085) 					break;
9afecfbb95198e Steven Rostedt (VMware   2017-03-24  2086) 				}
9afecfbb95198e Steven Rostedt (VMware   2017-03-24  2087) 				last = &t->next;
9afecfbb95198e Steven Rostedt (VMware   2017-03-24  2088) 			}
9afecfbb95198e Steven Rostedt (VMware   2017-03-24  2089) 		}
9afecfbb95198e Steven Rostedt (VMware   2017-03-24  2090) 		list_del(&p->list);
9afecfbb95198e Steven Rostedt (VMware   2017-03-24  2091) 		kfree(p);
9afecfbb95198e Steven Rostedt (VMware   2017-03-24  2092) 	}
78041c0c9e935d Steven Rostedt (VMware   2020-02-20  2093) 	tracing_selftest_running = false;
9afecfbb95198e Steven Rostedt (VMware   2017-03-24  2094) 
9afecfbb95198e Steven Rostedt (VMware   2017-03-24  2095)  out:
9afecfbb95198e Steven Rostedt (VMware   2017-03-24  2096) 	mutex_unlock(&trace_types_lock);
9afecfbb95198e Steven Rostedt (VMware   2017-03-24  2097) 
9afecfbb95198e Steven Rostedt (VMware   2017-03-24  2098) 	return 0;
9afecfbb95198e Steven Rostedt (VMware   2017-03-24  2099) }
b9ef0326c05a00 Steven Rostedt           2017-05-17  2100  core_initcall(init_trace_selftests);
f4e781c0a89d58 Steven Rostedt (Red Hat  2013-03-07  2101) #else
f4e781c0a89d58 Steven Rostedt (Red Hat  2013-03-07 @2102) static inline int run_tracer_selftest(struct tracer *type)
f4e781c0a89d58 Steven Rostedt (Red Hat  2013-03-07  2103) {
f4e781c0a89d58 Steven Rostedt (Red Hat  2013-03-07  2104) 	return 0;
0d5c6e1c19bab8 Steven Rostedt           2012-11-01  2105  }
e8352cf5778c53 Steven Rostedt (Google   2023-05-28  2106) static inline int do_run_tracer_selftest(struct tracer *type)
e8352cf5778c53 Steven Rostedt (Google   2023-05-28  2107) {
e8352cf5778c53 Steven Rostedt (Google   2023-05-28  2108) 	return 0;
e8352cf5778c53 Steven Rostedt (Google   2023-05-28  2109) }
f4e781c0a89d58 Steven Rostedt (Red Hat  2013-03-07  2110) #endif /* CONFIG_FTRACE_STARTUP_TEST */
0d5c6e1c19bab8 Steven Rostedt           2012-11-01  2111  

:::::: The code at line 2102 was first introduced by commit
:::::: f4e781c0a89d5810729772290441ac7d61f321ec tracing: Move the tracing selftest code into its own function

:::::: TO: Steven Rostedt (Red Hat) <srostedt@redhat.com>
:::::: CC: Steven Rostedt <rostedt@goodmis.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

