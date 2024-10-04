Return-Path: <linux-kernel+bounces-349879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92EBB98FC95
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 05:56:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7D541C221B5
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 03:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1DF1481CE;
	Fri,  4 Oct 2024 03:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="es8xXIDu"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F4B13D982
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 03:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728014167; cv=none; b=mZZbAbmgLkddBD4LpO90oxF7vps//xYgJlx1RdAWYRtKb8zef+n0aeDCY91tK3yIItJ5COMOetCJz30VjW4BqofG+VBGh+HUnKgimXtKjWgo68b76UaESQ6SfoIIPZ8qaeCU1CMRwW3U+3rpswiYC1fmJKowaOYIGSMHiQa8MIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728014167; c=relaxed/simple;
	bh=f60efwpdEBV93DkMJWkEPoTaEsnIHKFyT4bxtSaqAvw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P3YfRZxhdT4duMUzFwFEPtuE8LJ1Ot4P/FrIod7M/vKHzINoqWMWT9JMOQuP4ILo1ZE9R/1pG8dmaBFIFOzgKfmSG2Fyqb1O29uzR9Xw0nj/S+yWKVJxOJSWmG8Z4WQ3809kd1g1GE1kxW8AGddkTyPAP8+QA80wbgfvHROPkjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=es8xXIDu; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728014164; x=1759550164;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=f60efwpdEBV93DkMJWkEPoTaEsnIHKFyT4bxtSaqAvw=;
  b=es8xXIDuevMZ/Oc7fURlsQYadqExtGkFTR6sZIuk3AxCR+JB1WWuOi++
   pfLZfvAb41AC+rwP16E/dGNGmwhVMDSv31qu6MKY17yk8v9QREwoj3R0u
   GVXGoor5CAQUSkzlTSjQdSMW6g44vlWeZcNy4+LH2IfgXuILxQCvMdNg1
   oCLjZdwYcM+8s+2Pw0A8uvw1nAnSjgqgjwve83q8M9zPYhsQJYaUziOPE
   GR7qPWNI2Q0CDx+DwneSnwoYtt6dFayNAi9S8dmGEO2o/NRNqlSjnqmUp
   EMw2I1fG4F+wYiCwQRO869e22gMn+5y5tNkfwlqAeTzPIbJ8ya8aiAnRq
   Q==;
X-CSE-ConnectionGUID: I/N0U2oeSZq2e6woX/8UTQ==
X-CSE-MsgGUID: I0DCjrtGRgK2k+53QmmV+g==
X-IronPort-AV: E=McAfee;i="6700,10204,11214"; a="30106525"
X-IronPort-AV: E=Sophos;i="6.11,176,1725346800"; 
   d="scan'208";a="30106525"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2024 20:56:04 -0700
X-CSE-ConnectionGUID: sE+3s6lUSYevPkDpdN0sgA==
X-CSE-MsgGUID: OKm3xyatREWI5eCILuxpAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,176,1725346800"; 
   d="scan'208";a="74409699"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 03 Oct 2024 20:56:02 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1swZQ7-0001Bq-2s;
	Fri, 04 Oct 2024 03:55:59 +0000
Date: Fri, 4 Oct 2024 11:55:07 +0800
From: kernel test robot <lkp@intel.com>
To: luca.boccassi@gmail.com, linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, christian@brauner.io,
	paul@paul-moore.com
Subject: Re: [PATCH] pidfd: add ioctl to retrieve pid info
Message-ID: <202410041128.tLVDbeJB-lkp@intel.com>
References: <20241002142516.110567-1-luca.boccassi@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241002142516.110567-1-luca.boccassi@gmail.com>

Hi,

kernel test robot noticed the following build warnings:

[auto build test WARNING on shuah-kselftest/next]
[also build test WARNING on shuah-kselftest/fixes linus/master v6.12-rc1 next-20241003]
[cannot apply to brauner-vfs/vfs.all]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/luca-boccassi-gmail-com/pidfd-add-ioctl-to-retrieve-pid-info/20241002-223302
base:   https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git next
patch link:    https://lore.kernel.org/r/20241002142516.110567-1-luca.boccassi%40gmail.com
patch subject: [PATCH] pidfd: add ioctl to retrieve pid info
config: x86_64-randconfig-123-20241004 (https://download.01.org/0day-ci/archive/20241004/202410041128.tLVDbeJB-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241004/202410041128.tLVDbeJB-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410041128.tLVDbeJB-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> fs/pidfs.c:121:37: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got struct pidfd_info * @@
   fs/pidfs.c:121:37: sparse:     expected void const [noderef] __user *from
   fs/pidfs.c:121:37: sparse:     got struct pidfd_info *

vim +121 fs/pidfs.c

   116	
   117	static long pidfd_info(struct task_struct *task, struct pid *pid, unsigned long arg)
   118	{
   119		struct pidfd_info uinfo = {}, info = {};
   120	
 > 121		if (copy_from_user(&uinfo, (struct pidfd_info *)arg, sizeof(struct pidfd_info)))
   122			return -EFAULT;
   123		if (uinfo.size > sizeof(struct pidfd_info))
   124			return -E2BIG;
   125		if (uinfo.size < sizeof(struct pidfd_info))
   126			return -EINVAL; /* First version, no smaller struct possible */
   127	
   128		if (uinfo.request_mask & ~(PIDFD_INFO_PID | PIDFD_INFO_CREDS | PIDFD_INFO_CGROUPID | PIDFD_INFO_SECURITY_CONTEXT))
   129			return -EINVAL;
   130	
   131		memcpy(&info, &uinfo, uinfo.size);
   132	
   133		if (uinfo.request_mask & PIDFD_INFO_PID)
   134			info.pid = pid_nr_ns(pid, task_active_pid_ns(task));
   135	
   136		if (uinfo.request_mask & PIDFD_INFO_CREDS) {
   137			const struct cred *c = get_task_cred(task);
   138			if (!c)
   139				return -ESRCH;
   140	
   141			info.uid = from_kuid_munged(current_user_ns(), c->uid);
   142			info.gid = from_kgid_munged(current_user_ns(), c->gid);
   143		}
   144	
   145		if (uinfo.request_mask & PIDFD_INFO_CGROUPID) {
   146			struct cgroup *cgrp = task_css_check(task, pids_cgrp_id, 1)->cgroup;
   147			if (!cgrp)
   148				return -ENODEV;
   149	
   150			info.cgroupid = cgroup_id(cgrp);
   151		}
   152	
   153		if (uinfo.request_mask & PIDFD_INFO_SECURITY_CONTEXT) {
   154			char *secctx;
   155			u32 secid, secctx_len;
   156			const struct cred *c = get_task_cred(task);
   157			if (!c)
   158				return -ESRCH;
   159	
   160			security_cred_getsecid(c, &secid);
   161			if (security_secid_to_secctx(secid, &secctx, &secctx_len))
   162				return -EFAULT;
   163	
   164			memcpy(info.security_context, secctx, min_t(u32, secctx_len, NAME_MAX-1));
   165		}
   166	
   167		if (copy_to_user((void __user *)arg, &info, uinfo.size))
   168			return -EFAULT;
   169	
   170		return 0;
   171	}
   172	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

