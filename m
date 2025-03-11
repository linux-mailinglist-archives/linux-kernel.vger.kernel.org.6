Return-Path: <linux-kernel+bounces-556186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C094A5C23B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 14:18:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A25CD16E4DF
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 13:18:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FF5D189F43;
	Tue, 11 Mar 2025 13:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CLyZDLyO"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E32835979
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 13:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741699077; cv=none; b=q0euwwSEQd4ufCe2169xUqdABww4Qd+wrINSdWrryklBoS7itOgr8n3BQdzheI0/HdmP+jff2l3EPkixyGLKILhqAg/3hzAXoBwfbbZZjuK5EvtyLqzX/36NUMXyAAropsQC5tzCVSgSHOuS3rW6ePzhhh6e7Bl9uiMoI/mOeEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741699077; c=relaxed/simple;
	bh=oWF/zCJYw7SOJxfyEqPYmPrpZVbzoyOjUzQd8BjQX+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=XHVkn+J3GYopdyYX0lLv6Y7IVfE4h1npWg2xnFKFAy7eJ76oULBY9ThB8fvu7KODa5AOIzGPBmGU/0epr2/nPpLOiVm6ieKWDWaOWtGPaRKvspfu/IUBj/xaaRxLOyEX41UWL6J5tSOtCayWdUOG1cIkHtgtfRlG+vLgpZfEoeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CLyZDLyO; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741699075; x=1773235075;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=oWF/zCJYw7SOJxfyEqPYmPrpZVbzoyOjUzQd8BjQX+Y=;
  b=CLyZDLyODxOHZRcCRolbnBBvx0x3XHKqTTcYQFHK4GZpdZEvfSK3F+bC
   Oij8PW+wlblHDnhp/h3dFSjYeuvO/diKRSFUI2NPwM8EwZ1yQzWH6VlV+
   JtqQqx4XjDT/n8Eo7aui7qrmdKy2nV6lM0RAO2VDL4VWFpUGqBzNk2vNp
   84ze/GfNBr0NE9teyBaWugUo5WGnG+32CTW/X5fX71ky6BKNOUXWxAiSj
   GDe6eIzOuN5Oy6zH8xo78VD9xGanz6P1MvnXCjc8oqXemmffK0nI9BdOi
   JHAIBJfuIoSVSp+sJZv9kplOi8OLspjQJ6ODV6VUF85vMNClrmCPYSMNJ
   w==;
X-CSE-ConnectionGUID: TTXRNU+hQpqBRgO1Xg35rg==
X-CSE-MsgGUID: 2tK3WHR0QxyooVABUEQr+w==
X-IronPort-AV: E=McAfee;i="6700,10204,11370"; a="41988780"
X-IronPort-AV: E=Sophos;i="6.14,239,1736841600"; 
   d="scan'208";a="41988780"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2025 06:17:54 -0700
X-CSE-ConnectionGUID: BcIUVsxjRnWDa+PGvIbsmg==
X-CSE-MsgGUID: RROuWSc4QRWQnLeVpBL4BQ==
X-Ironport-Invalid-End-Of-Message: True
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,239,1736841600"; 
   d="scan'208";a="120256698"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by orviesa010.jf.intel.com with ESMTP; 11 Mar 2025 06:17:54 -0700
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1trzUU-0006fo-1t;
	Tue, 11 Mar 2025 13:17:50 +0000
Date: Tue, 11 Mar 2025 21:17:45 +0800
From: kernel test robot <lkp@intel.com>
To: Keith Busch <kbusch@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Paolo Bonzini <pbonzini@redhat.com>,
	Mike Christie <michael.christie@oracle.com>
Subject: kernel/vhost_task.c:148:9-16: WARNING: ERR_CAST can be used with tsk
Message-ID: <202503112124.LprWipYC-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   4d872d51bc9d7b899c1f61534e3dbde72613f627
commit: cb380909ae3b1ebf14d6a455a4f92d7916d790cb vhost: return task creation error instead of NULL
date:   10 days ago
config: parisc-randconfig-r064-20250311 (https://download.01.org/0day-ci/archive/20250311/202503112124.LprWipYC-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 14.2.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503112124.LprWipYC-lkp@intel.com/

cocci warnings: (new ones prefixed by >>)
>> kernel/vhost_task.c:148:9-16: WARNING: ERR_CAST can be used with tsk

vim +148 kernel/vhost_task.c

   106	
   107	/**
   108	 * vhost_task_create - create a copy of a task to be used by the kernel
   109	 * @fn: vhost worker function
   110	 * @handle_sigkill: vhost function to handle when we are killed
   111	 * @arg: data to be passed to fn and handled_kill
   112	 * @name: the thread's name
   113	 *
   114	 * This returns a specialized task for use by the vhost layer or NULL on
   115	 * failure. The returned task is inactive, and the caller must fire it up
   116	 * through vhost_task_start().
   117	 */
   118	struct vhost_task *vhost_task_create(bool (*fn)(void *),
   119					     void (*handle_sigkill)(void *), void *arg,
   120					     const char *name)
   121	{
   122		struct kernel_clone_args args = {
   123			.flags		= CLONE_FS | CLONE_UNTRACED | CLONE_VM |
   124					  CLONE_THREAD | CLONE_SIGHAND,
   125			.exit_signal	= 0,
   126			.fn		= vhost_task_fn,
   127			.name		= name,
   128			.user_worker	= 1,
   129			.no_files	= 1,
   130		};
   131		struct vhost_task *vtsk;
   132		struct task_struct *tsk;
   133	
   134		vtsk = kzalloc(sizeof(*vtsk), GFP_KERNEL);
   135		if (!vtsk)
   136			return ERR_PTR(-ENOMEM);
   137		init_completion(&vtsk->exited);
   138		mutex_init(&vtsk->exit_mutex);
   139		vtsk->data = arg;
   140		vtsk->fn = fn;
   141		vtsk->handle_sigkill = handle_sigkill;
   142	
   143		args.fn_arg = vtsk;
   144	
   145		tsk = copy_process(NULL, 0, NUMA_NO_NODE, &args);
   146		if (IS_ERR(tsk)) {
   147			kfree(vtsk);
 > 148			return ERR_PTR(PTR_ERR(tsk));
   149		}
   150	
   151		vtsk->task = tsk;
   152		return vtsk;
   153	}
   154	EXPORT_SYMBOL_GPL(vhost_task_create);
   155	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

