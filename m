Return-Path: <linux-kernel+bounces-430930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 32E1F9E3758
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 11:18:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A226B2C7B6
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 10:17:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AC241ADFF8;
	Wed,  4 Dec 2024 10:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aDujPMTG"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 170D71AF0C0
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 10:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733307457; cv=none; b=EEDT0oY8NR2mDgSc7g4WJl8/LadqCPOMR3951zE2msYCHnXMyGjwjEA5KSyA5wldwzrInWc2YcBnbn/DYMe3tCxdrumwsZHjYKTUqS/Wg8IFfsrtNL3v9zlJ6pNOK1/cNzig7ta/RaXtZLaNUJgZPtPl+L7v5plNSuNWKetsCkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733307457; c=relaxed/simple;
	bh=Xye7f9JONI2GFLTBqhijRnaZvgwGYUk/i7QbSr072Z8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=muItxkcdzj5DZ16eeljhF4oQKpX7qLRt0Qq3aM6BpOVe/v7suO09eL7eTcSBRJxOluebu3HbSQmDsFYV63tmRy6DDrbkmBa3s0e19hly/GJH0K92jNdys/hOFdhT0vS7jO8WFK7v8a9Ze5Q/DO6a9PEWn1bGiwMPsa1vgcsd4d8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aDujPMTG; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733307456; x=1764843456;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Xye7f9JONI2GFLTBqhijRnaZvgwGYUk/i7QbSr072Z8=;
  b=aDujPMTGkqIA8YtIjWImQIk54I4QaNFK0zjj8U1D5JBmtntiov+e8Vgv
   3d6mFmmkswF7JVojqN0qjSemQl8RgWZoaL1fwmc/vS+lhPGgxRNMqPYxR
   B0gWq6zzrYgvBlJFnRZTMgRHmdvlC9jYhsmBLF9zDSrVH78AnpHgzixC/
   u2p+ElWJy+oaO7Chx6OWFPLxjYmg1Cgj79BZzr4LPr2m53FIPI+9PURtE
   7ju6TinqfwMN/EHmkGJ/qOY5z52GcuV8wHOPD+WleOD2zx/kl9FvccxX5
   ZrNFlhxRT0Y2YyfP7KT7lSCFJGa7YbXiaixFgV9POtbvWupQY6AYgYUS7
   Q==;
X-CSE-ConnectionGUID: K3fk1rfkSTm75gg3VNLgLg==
X-CSE-MsgGUID: bToyPUjFSKigQ5eFoMgONA==
X-IronPort-AV: E=McAfee;i="6700,10204,11275"; a="56049876"
X-IronPort-AV: E=Sophos;i="6.12,207,1728975600"; 
   d="scan'208";a="56049876"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2024 02:17:35 -0800
X-CSE-ConnectionGUID: BfTo0SaZTHageSeJ8cYLdw==
X-CSE-MsgGUID: D4ZTgxOwSo27jjiK/5MHAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,207,1728975600"; 
   d="scan'208";a="97784867"
Received: from lkp-server02.sh.intel.com (HELO 1f5a171d57e2) ([10.239.97.151])
  by fmviesa003.fm.intel.com with ESMTP; 04 Dec 2024 02:17:33 -0800
Received: from kbuild by 1f5a171d57e2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tImRe-0002sZ-17;
	Wed, 04 Dec 2024 10:17:25 +0000
Date: Wed, 4 Dec 2024 18:17:05 +0800
From: kernel test robot <lkp@intel.com>
To: Sreekanth Reddy <sreekanth.reddy@broadcom.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Subject: drivers/scsi/mpt3sas/mpt3sas_base.c:3135:63: warning: '-mq-poll'
 directive output may be truncated writing 8 bytes into a region of size
 between 6 and 31
Message-ID: <202412041848.xADfdU8S-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Sreekanth,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   feffde684ac29a3b7aec82d2df850fbdbdee55e4
commit: 432bc7caef4eaacc1101ee2569bb870bdfeed7ce scsi: mpt3sas: Add io_uring iopoll support
date:   3 years, 4 months ago
config: arm64-defconfig (https://download.01.org/0day-ci/archive/20241204/202412041848.xADfdU8S-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241204/202412041848.xADfdU8S-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412041848.xADfdU8S-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/scsi/mpt3sas/mpt3sas_base.c: In function '_base_request_irq':
   drivers/scsi/mpt3sas/mpt3sas_base.c:3144:68: warning: '%d' directive output may be truncated writing between 1 and 3 bytes into a region of size between 1 and 26 [-Wformat-truncation=]
    3144 |                 snprintf(reply_q->name, MPT_NAME_LENGTH, "%s%d-msix%d",
         |                                                                    ^~
   drivers/scsi/mpt3sas/mpt3sas_base.c:3144:58: note: directive argument in the range [0, 254]
    3144 |                 snprintf(reply_q->name, MPT_NAME_LENGTH, "%s%d-msix%d",
         |                                                          ^~~~~~~~~~~~~
   drivers/scsi/mpt3sas/mpt3sas_base.c:3144:17: note: 'snprintf' output between 8 and 35 bytes into a destination of size 32
    3144 |                 snprintf(reply_q->name, MPT_NAME_LENGTH, "%s%d-msix%d",
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    3145 |                     ioc->driver_name, ioc->id, index);
         |                     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/scsi/mpt3sas/mpt3sas_base.c:3135:63: warning: '-mq-poll' directive output may be truncated writing 8 bytes into a region of size between 6 and 31 [-Wformat-truncation=]
    3135 |                 snprintf(reply_q->name, MPT_NAME_LENGTH, "%s%d-mq-poll%d",
         |                                                               ^~~~~~~~
   drivers/scsi/mpt3sas/mpt3sas_base.c:3135:58: note: directive argument in the range [-255, 255]
    3135 |                 snprintf(reply_q->name, MPT_NAME_LENGTH, "%s%d-mq-poll%d",
         |                                                          ^~~~~~~~~~~~~~~~
   drivers/scsi/mpt3sas/mpt3sas_base.c:3135:17: note: 'snprintf' output between 11 and 39 bytes into a destination of size 32
    3135 |                 snprintf(reply_q->name, MPT_NAME_LENGTH, "%s%d-mq-poll%d",
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    3136 |                     ioc->driver_name, ioc->id, qid);
         |                     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/scsi/mpt3sas/mpt3sas_base.c: In function 'mpt3sas_base_start_watchdog':
   drivers/scsi/mpt3sas/mpt3sas_base.c:831:57: warning: '%s' directive output may be truncated writing up to 23 bytes into a region of size 15 [-Wformat-truncation=]
     831 |             sizeof(ioc->fault_reset_work_q_name), "poll_%s%d_status",
         |                                                         ^~
   drivers/scsi/mpt3sas/mpt3sas_base.c:831:51: note: directive argument in the range [0, 255]
     831 |             sizeof(ioc->fault_reset_work_q_name), "poll_%s%d_status",
         |                                                   ^~~~~~~~~~~~~~~~~~
   drivers/scsi/mpt3sas/mpt3sas_base.c:830:9: note: 'snprintf' output between 14 and 39 bytes into a destination of size 20
     830 |         snprintf(ioc->fault_reset_work_q_name,
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     831 |             sizeof(ioc->fault_reset_work_q_name), "poll_%s%d_status",
         |             ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     832 |             ioc->driver_name, ioc->id);
         |             ~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +3135 drivers/scsi/mpt3sas/mpt3sas_base.c

  3107	
  3108	/**
  3109	 * _base_request_irq - request irq
  3110	 * @ioc: per adapter object
  3111	 * @index: msix index into vector table
  3112	 *
  3113	 * Inserting respective reply_queue into the list.
  3114	 */
  3115	static int
  3116	_base_request_irq(struct MPT3SAS_ADAPTER *ioc, u8 index)
  3117	{
  3118		struct pci_dev *pdev = ioc->pdev;
  3119		struct adapter_reply_queue *reply_q;
  3120		int r, qid;
  3121	
  3122		reply_q =  kzalloc(sizeof(struct adapter_reply_queue), GFP_KERNEL);
  3123		if (!reply_q) {
  3124			ioc_err(ioc, "unable to allocate memory %zu!\n",
  3125				sizeof(struct adapter_reply_queue));
  3126			return -ENOMEM;
  3127		}
  3128		reply_q->ioc = ioc;
  3129		reply_q->msix_index = index;
  3130	
  3131		atomic_set(&reply_q->busy, 0);
  3132	
  3133		if (index >= ioc->iopoll_q_start_index) {
  3134			qid = index - ioc->iopoll_q_start_index;
> 3135			snprintf(reply_q->name, MPT_NAME_LENGTH, "%s%d-mq-poll%d",
  3136			    ioc->driver_name, ioc->id, qid);
  3137			reply_q->is_iouring_poll_q = 1;
  3138			ioc->io_uring_poll_queues[qid].reply_q = reply_q;
  3139			goto out;
  3140		}
  3141	
  3142	
  3143		if (ioc->msix_enable)
> 3144			snprintf(reply_q->name, MPT_NAME_LENGTH, "%s%d-msix%d",
  3145			    ioc->driver_name, ioc->id, index);
  3146		else
  3147			snprintf(reply_q->name, MPT_NAME_LENGTH, "%s%d",
  3148			    ioc->driver_name, ioc->id);
  3149		r = request_irq(pci_irq_vector(pdev, index), _base_interrupt,
  3150				IRQF_SHARED, reply_q->name, reply_q);
  3151		if (r) {
  3152			pr_err("%s: unable to allocate interrupt %d!\n",
  3153			       reply_q->name, pci_irq_vector(pdev, index));
  3154			kfree(reply_q);
  3155			return -EBUSY;
  3156		}
  3157	out:
  3158		INIT_LIST_HEAD(&reply_q->list);
  3159		list_add_tail(&reply_q->list, &ioc->reply_queue_list);
  3160		return 0;
  3161	}
  3162	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

