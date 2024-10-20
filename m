Return-Path: <linux-kernel+bounces-373197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C25DB9A53AA
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 13:15:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59B071F218F1
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 11:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 008D31885AD;
	Sun, 20 Oct 2024 11:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VsdEMX2X"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43C1312E1E9
	for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2024 11:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729422944; cv=none; b=anr4OsEUsFiNi9gaEClKf77Q1/B0yHdudHhrRXuZD7CunsepPkcdgpS/yqOaoJX9+qAF1UDCmXz3P4HwZQRqBuKArciWSXaSBiwCcimFjwkjDSD6MZbMaypzHidOXecoH0P6gCIGvHto0B5uSxRbvIaHkp8zlGvC1nUlz0HD0l8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729422944; c=relaxed/simple;
	bh=dNaIP19J6t4liRQU078lv5AlRenmylPH0pYmXw92tqg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=mZWOJtm68tCbIVReBmaclUXlOGJin796CQWo4hhlRMOxDg6/V1CF7Rklq6QOGMrKi4XFau6VaY/4fLCSLTkkFa3rzJup+m0dgbyXhMSCUfEAtEGOLu94JEuyn5Fv2ankn6+guz1q0LWz/gPj/jGIFd45D0ZBWENYQZDHFp5QwUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VsdEMX2X; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729422942; x=1760958942;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=dNaIP19J6t4liRQU078lv5AlRenmylPH0pYmXw92tqg=;
  b=VsdEMX2XwTwcMPhqLOBbO7Xhm6+RtaM+mELXVTAO0u5jQ7iqUISFN8hr
   aXw5dAzFsdGJHbJTxbqekiDJG2njys9N5xxVWqOJtg/AEF+vRqa6QMGpY
   T8ySF4T5J+fLnAWck2fNtD2qz5sOwwnCE2+34riQw3ZcwAJpoLlY7+YYE
   ieqAnLU7VlDCnCIzBW2/Ic/4aoP5MKScMXtC5CkrVTlocjF10m6rMKiCS
   qKZcjrMQ2CsnJ0p7Uo/dvUlazgyFON5UgGaMlzfEozEODXIKiHFdS+bn1
   yu+3Pq+/Q2MoSDDomV+L4yBZuYXXx6kuGuxFMm0mn1217sVHveE5PBRad
   g==;
X-CSE-ConnectionGUID: uE+UKglxTnGfqgV/l6w7pA==
X-CSE-MsgGUID: BbLmYtJdQw+Z7/5ZbFVXwQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11231"; a="32824830"
X-IronPort-AV: E=Sophos;i="6.11,218,1725346800"; 
   d="scan'208";a="32824830"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2024 04:15:42 -0700
X-CSE-ConnectionGUID: A6B/A7DvQ/iP0D80kWE+og==
X-CSE-MsgGUID: 1Vkx7wxuS6qZ7Auow41H/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,218,1725346800"; 
   d="scan'208";a="84061052"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 20 Oct 2024 04:15:40 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t2TuL-000QEB-1B;
	Sun, 20 Oct 2024 11:15:37 +0000
Date: Sun, 20 Oct 2024 19:15:19 +0800
From: kernel test robot <lkp@intel.com>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	"Gustavo A. R. Silva" <gustavo@embeddedor.com>,
	LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars:testing/wfamnae-next20241015-2 1/20]
 kernel/sched/ext.c:3454:10: error: incompatible pointer types returning
 'struct cgroup_hdr *' from a function with result type 'struct cgroup *'
Message-ID: <202410201911.RjSrvRuo-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git testing/wfamnae-next20241015-2
head:   f4f8ca5cd7f039bcab816194342c7b6101e891fe
commit: 7c9abd83f6b3412752cbb1a76954568b5316ad61 [1/20] cgroup: Avoid -Wflex-array-member-not-at-end warnings
config: i386-buildonly-randconfig-003-20241020 (https://download.01.org/0day-ci/archive/20241020/202410201911.RjSrvRuo-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241020/202410201911.RjSrvRuo-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410201911.RjSrvRuo-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from kernel/sched/build_policy.c:63:
>> kernel/sched/ext.c:3454:10: error: incompatible pointer types returning 'struct cgroup_hdr *' from a function with result type 'struct cgroup *' [-Werror,-Wincompatible-pointer-types]
    3454 |                 return &cgrp_dfl_root.cgrp;
         |                        ^~~~~~~~~~~~~~~~~~~
>> kernel/sched/ext.c:7152:17: error: incompatible pointer types initializing 'struct cgroup *' with an expression of type 'struct cgroup_hdr *' [-Werror,-Wincompatible-pointer-types]
    7152 |         struct cgroup *cgrp = &cgrp_dfl_root.cgrp;
         |                        ^      ~~~~~~~~~~~~~~~~~~~
   2 errors generated.


vim +3454 kernel/sched/ext.c

f0e1a0643a59bf Tejun Heo 2024-06-18  3442  
8195136669661f Tejun Heo 2024-09-04  3443  #ifdef CONFIG_EXT_GROUP_SCHED
8195136669661f Tejun Heo 2024-09-04  3444  static struct cgroup *tg_cgrp(struct task_group *tg)
8195136669661f Tejun Heo 2024-09-04  3445  {
8195136669661f Tejun Heo 2024-09-04  3446  	/*
8195136669661f Tejun Heo 2024-09-04  3447  	 * If CGROUP_SCHED is disabled, @tg is NULL. If @tg is an autogroup,
8195136669661f Tejun Heo 2024-09-04  3448  	 * @tg->css.cgroup is NULL. In both cases, @tg can be treated as the
8195136669661f Tejun Heo 2024-09-04  3449  	 * root cgroup.
8195136669661f Tejun Heo 2024-09-04  3450  	 */
8195136669661f Tejun Heo 2024-09-04  3451  	if (tg && tg->css.cgroup)
8195136669661f Tejun Heo 2024-09-04  3452  		return tg->css.cgroup;
8195136669661f Tejun Heo 2024-09-04  3453  	else
8195136669661f Tejun Heo 2024-09-04 @3454  		return &cgrp_dfl_root.cgrp;
8195136669661f Tejun Heo 2024-09-04  3455  }
8195136669661f Tejun Heo 2024-09-04  3456  

:::::: The code at line 3454 was first introduced by commit
:::::: 8195136669661fdfe54e9a8923c33b31c92fc1da sched_ext: Add cgroup support

:::::: TO: Tejun Heo <tj@kernel.org>
:::::: CC: Tejun Heo <tj@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

