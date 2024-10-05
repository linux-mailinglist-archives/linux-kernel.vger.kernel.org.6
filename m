Return-Path: <linux-kernel+bounces-352171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFE1D991B38
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2024 00:26:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B9C92834AD
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 22:26:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A8AE16F0EB;
	Sat,  5 Oct 2024 22:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YoGNPnaR"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1877B158A3C
	for <linux-kernel@vger.kernel.org>; Sat,  5 Oct 2024 22:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728167192; cv=none; b=X1TLjbGWLxvEZXsz6IahLJUI7T9CdeCEjMuFGYZFapwJyjBGSnCoViwR1TU95TrpOVJAT5qISHJMQ7mDJzzvldmNuo33laM8tJCx2b5Rvm6TEval43bdwHB+kzZPRuxQZZ5CItgPLnHki4ZU6Twc7reBcS6PhCTY/hVOYHKbaXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728167192; c=relaxed/simple;
	bh=NRN+XmrObaWpC0cMaljPv9wGD6xfsxrY18o++erPKfQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yu3vbxR7Ks7ZRRltYxJDeK6NhoIL+EzKd9rGL9mJEo+5jirQM4dXWMdvRah4tBEz/sppmm+p+PMVvqE5WBz0+dit0ZCgaAEULTPcVXOZeD73Kq2kTGiLto6/yLVFVeRtDl37qME0lmyHxlHounE6F8VDi34loIl1eLbW8ldfVfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YoGNPnaR; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728167191; x=1759703191;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NRN+XmrObaWpC0cMaljPv9wGD6xfsxrY18o++erPKfQ=;
  b=YoGNPnaRsrYxuVeMGu72Vgs2IuMiMq3EV+4Ks6hkOwAy4iOuFLsZbchx
   CooW3vwDSysCD6rTAeJtCiKaVBtF2ACjLx70IjsyI7GjTrgDhsKnyt8tW
   srjwUGcxx3X8erwMovl+BwVvUILlS1KWyPAzTqPRlHTxNCUY7HbLcvTLO
   0j0CnF4MJZDphThH82Jk1ox4SfW0vv2LOHNRirX0v2eKCqQSBNj015+nc
   lD/8S9RN9x98aCSBiEeuC7EiWEaoPEbKJ9iyC8ilb9tou5PrYFp/QZn4e
   gViyT6kIIz5F9fXcNuyF/I71av/e10YUgVjBz9IrTxN8Z5OLxRB2Bx9SW
   w==;
X-CSE-ConnectionGUID: vkepAE3PSQeSBRFvCFfC7A==
X-CSE-MsgGUID: /I/+95+wTZSS1HF6F0DAKw==
X-IronPort-AV: E=McAfee;i="6700,10204,11216"; a="27446863"
X-IronPort-AV: E=Sophos;i="6.11,181,1725346800"; 
   d="scan'208";a="27446863"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2024 15:26:30 -0700
X-CSE-ConnectionGUID: gf9FL0wZTi+Qj3PAyW7pMA==
X-CSE-MsgGUID: 0jpWdUi0TxCA+N/x1G+lFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,181,1725346800"; 
   d="scan'208";a="80025741"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 05 Oct 2024 15:26:29 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sxDEI-0003PX-35;
	Sat, 05 Oct 2024 22:26:26 +0000
Date: Sun, 6 Oct 2024 06:26:24 +0800
From: kernel test robot <lkp@intel.com>
To: luca.boccassi@gmail.com, linux-kernel@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	christian@brauner.io
Subject: Re: [PATCH v4] pidfd: add ioctl to retrieve pid info
Message-ID: <202410060624.Z84m82vK-lkp@intel.com>
References: <20241004194751.215507-1-luca.boccassi@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241004194751.215507-1-luca.boccassi@gmail.com>

Hi,

kernel test robot noticed the following build errors:

[auto build test ERROR on 9852d85ec9d492ebef56dc5f229416c925758edc]

url:    https://github.com/intel-lab-lkp/linux/commits/luca-boccassi-gmail-com/pidfd-add-ioctl-to-retrieve-pid-info/20241005-041639
base:   9852d85ec9d492ebef56dc5f229416c925758edc
patch link:    https://lore.kernel.org/r/20241004194751.215507-1-luca.boccassi%40gmail.com
patch subject: [PATCH v4] pidfd: add ioctl to retrieve pid info
config: arm-randconfig-002-20241006 (https://download.01.org/0day-ci/archive/20241006/202410060624.Z84m82vK-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241006/202410060624.Z84m82vK-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410060624.Z84m82vK-lkp@intel.com/

All errors (new ones prefixed by >>):

>> fs/pidfs.c:156:25: error: implicit declaration of function 'task_css_check' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
                   struct cgroup *cgrp = task_css_check(task, pids_cgrp_id, 1)->cgroup;
                                         ^
   fs/pidfs.c:156:64: error: member reference type 'int' is not a pointer
                   struct cgroup *cgrp = task_css_check(task, pids_cgrp_id, 1)->cgroup;
                                         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~  ^
   fs/pidfs.c:156:46: error: use of undeclared identifier 'pids_cgrp_id'
                   struct cgroup *cgrp = task_css_check(task, pids_cgrp_id, 1)->cgroup;
                                                              ^
   3 errors generated.

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for GET_FREE_REGION
   Depends on [n]: SPARSEMEM [=n]
   Selected by [m]:
   - RESOURCE_KUNIT_TEST [=m] && RUNTIME_TESTING_MENU [=y] && KUNIT [=m]


vim +/task_css_check +156 fs/pidfs.c

   117	
   118	static long pidfd_info(struct task_struct *task, unsigned int cmd, unsigned long arg)
   119	{
   120		struct pidfd_info __user *uinfo = (struct pidfd_info __user *)arg;
   121		size_t usize = _IOC_SIZE(cmd);
   122		struct pidfd_info kinfo = {};
   123		struct user_namespace *user_ns;
   124		const struct cred *c;
   125		__u64 request_mask;
   126	
   127		if (!uinfo)
   128			return -EINVAL;
   129		if (usize < sizeof(struct pidfd_info))
   130			return -EINVAL; /* First version, no smaller struct possible */
   131	
   132		if (copy_from_user(&request_mask, &uinfo->request_mask, sizeof(request_mask)))
   133			return -EFAULT;
   134	
   135		c = get_task_cred(task);
   136		if (!c)
   137			return -ESRCH;
   138	
   139		/* Unconditionally return identifiers and credentials, the rest only on request */
   140	
   141		kinfo.pid = task_pid_vnr(task);
   142		kinfo.tgid = task_tgid_vnr(task);
   143		kinfo.ppid = task_ppid_nr_ns(task, task_active_pid_ns(task));
   144	
   145		user_ns = current_user_ns();
   146		kinfo.ruid = from_kuid_munged(user_ns, c->uid);
   147		kinfo.rgid = from_kgid_munged(user_ns, c->gid);
   148		kinfo.euid = from_kuid_munged(user_ns, c->euid);
   149		kinfo.egid = from_kgid_munged(user_ns, c->egid);
   150		kinfo.suid = from_kuid_munged(user_ns, c->suid);
   151		kinfo.sgid = from_kgid_munged(user_ns, c->sgid);
   152		kinfo.fsuid = from_kuid_munged(user_ns, c->fsuid);
   153		kinfo.fsgid = from_kgid_munged(user_ns, c->fsgid);
   154	
   155		if (request_mask & PIDFD_INFO_CGROUPID) {
 > 156			struct cgroup *cgrp = task_css_check(task, pids_cgrp_id, 1)->cgroup;
   157			if (!cgrp)
   158				return -ENODEV;
   159	
   160			kinfo.cgroupid = cgroup_id(cgrp);
   161			kinfo.result_mask |= PIDFD_INFO_CGROUPID;
   162		}
   163	
   164		/*
   165		 * If userspace and the kernel have the same struct size it can just
   166		 * be copied. If userspace provides an older struct, only the bits that
   167		 * userspace knows about will be copied. If userspace provides a new
   168		 * struct, only the bits that the kernel knows about will be copied and
   169		 * the size value will be set to the size the kernel knows about.
   170		 */
   171		if (copy_to_user(uinfo, &kinfo, min(usize, sizeof(kinfo))))
   172			return -EFAULT;
   173	
   174		return 0;
   175	}
   176	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

