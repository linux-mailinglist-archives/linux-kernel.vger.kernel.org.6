Return-Path: <linux-kernel+bounces-349630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6B5498F946
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 23:55:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68EA3282A4A
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 21:55:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 341601C68AA;
	Thu,  3 Oct 2024 21:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eH3KBoH7"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE6A71C2451
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 21:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727992502; cv=none; b=qvOwpyjiA57lweaq2XhcYIGIAxzMAz2a1hAUzxzYI2YggnVhWWNpNB6OE+b6BZCK2M16I0hkMvtYnt9087ICeNBPHAj9X+GxD1yYEk6GYcJpXWW7o7vWPPyVCno8D7ATVk5dTqDoHYsj3ZECc5BBSVmbYcGThJqY7+IKTqBDh0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727992502; c=relaxed/simple;
	bh=1uPcI0h7/zBOkh1rnHMxjRL0nB6YyosX+r9Z3xNqlAw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p1TmhLJyxK0U14v+0dhLX9s4YM4sCyT8xJZWyHJ/eWLa6B+ZhT3MBTbmP84OWf6XZ08lz+zf5mluMb1GpnyGjCc7uckOM47u8t5nEyOLc7BtL9Rhnl2efmt48ZVjI6BcgPIROfWfBB8Nl/iNviu6yoewnhT62ed3KPmxuBd2SfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eH3KBoH7; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727992500; x=1759528500;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1uPcI0h7/zBOkh1rnHMxjRL0nB6YyosX+r9Z3xNqlAw=;
  b=eH3KBoH7atUe4SFMBhSYf33/z0ZOMRmQKUyU8posvbosgkDyvgtDYwWJ
   usT/SuGS/Swjcy9eyQ1kIJJQ0COE1jMgm1U4Cf+5xoauo2GMBl11vgOS3
   spc+jfU84p92zmNCGLwtbUPOjkNkIX0OUOy2KqZ5jZZaQuvhSDqL6tt+6
   46RXUEFy2Gqdnd9egx6fnViHBZYCOMjjKobKWkhnJvDQKoezZ2mTAPQ5m
   IbQogvAMmHUh6dl6Vr/jwE3XL+z7OBNRgcS+fjo35qrsYEDrTKGmt4wjC
   x2XforAFzYun4VX7q17WWHxuSWJ80HiQAyDcPfHB/vub3fagL3XSRNuix
   g==;
X-CSE-ConnectionGUID: lcDM6AJKSQisF6LrkOXp4A==
X-CSE-MsgGUID: Ukul42tsTJWfkSdEOBxguQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11214"; a="37869292"
X-IronPort-AV: E=Sophos;i="6.11,175,1725346800"; 
   d="scan'208";a="37869292"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2024 14:54:55 -0700
X-CSE-ConnectionGUID: qK29dpFzSh69IQG7Gt4Rtg==
X-CSE-MsgGUID: rPDS3m/CQ7yGA7E1BtW+cg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,175,1725346800"; 
   d="scan'208";a="74927109"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 03 Oct 2024 14:54:53 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1swTmd-0000wU-0Q;
	Thu, 03 Oct 2024 21:54:51 +0000
Date: Fri, 4 Oct 2024 05:54:09 +0800
From: kernel test robot <lkp@intel.com>
To: luca.boccassi@gmail.com, linux-kernel@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	christian@brauner.io, paul@paul-moore.com
Subject: Re: [PATCH] pidfd: add ioctl to retrieve pid info
Message-ID: <202410040539.j2SZpABt-lkp@intel.com>
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

kernel test robot noticed the following build errors:

[auto build test ERROR on shuah-kselftest/next]
[also build test ERROR on shuah-kselftest/fixes linus/master v6.12-rc1 next-20241003]
[cannot apply to brauner-vfs/vfs.all]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/luca-boccassi-gmail-com/pidfd-add-ioctl-to-retrieve-pid-info/20241002-223302
base:   https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git next
patch link:    https://lore.kernel.org/r/20241002142516.110567-1-luca.boccassi%40gmail.com
patch subject: [PATCH] pidfd: add ioctl to retrieve pid info
config: x86_64-allnoconfig (https://download.01.org/0day-ci/archive/20241004/202410040539.j2SZpABt-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241004/202410040539.j2SZpABt-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410040539.j2SZpABt-lkp@intel.com/

All errors (new ones prefixed by >>):

>> fs/pidfs.c:146:25: error: call to undeclared function 'task_css_check'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     146 |                 struct cgroup *cgrp = task_css_check(task, pids_cgrp_id, 1)->cgroup;
         |                                       ^
>> fs/pidfs.c:146:46: error: use of undeclared identifier 'pids_cgrp_id'
     146 |                 struct cgroup *cgrp = task_css_check(task, pids_cgrp_id, 1)->cgroup;
         |                                                            ^
   2 errors generated.


vim +/task_css_check +146 fs/pidfs.c

   116	
   117	static long pidfd_info(struct task_struct *task, struct pid *pid, unsigned long arg)
   118	{
   119		struct pidfd_info uinfo = {}, info = {};
   120	
   121		if (copy_from_user(&uinfo, (struct pidfd_info *)arg, sizeof(struct pidfd_info)))
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
 > 146			struct cgroup *cgrp = task_css_check(task, pids_cgrp_id, 1)->cgroup;
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

