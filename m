Return-Path: <linux-kernel+bounces-428721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F9379E1288
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 05:50:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2A24164DD3
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 04:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45F48165EE8;
	Tue,  3 Dec 2024 04:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Lxdsy/40"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDA29126C16
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 04:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733201442; cv=none; b=QafwG0qfjmqaK6ADia0GcPqNAPUPapm1CXtKVRR9ZhT6MDvXrucdD7zBYNuEZ6rH45xNOFJxaL4C2WDBUN9/gy6/r/GQY+QxWm+ccF0+51c9pPdEDvGanJ9Ay9fpxRnteQJCj4L3WBKR52Jsi0bptsqfs/Dop+t2fph/H0HWRu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733201442; c=relaxed/simple;
	bh=VZObTby+wrUpCZmyv6XIYVl38CzMpOARrRIOlQH/QNw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ChxWsvTzCYwKJqljn8Zy4z9iXU0lKeE7Sm+/PFctUJOZYvSW9mNU0fPD30b1pl63WIEqQSBqn/HCEjE65pEondfrdKZsdI1Vf6ys4ovJioyKe3TZKrMige/dmlgUBHi4WF8Lu1ruo4crD3701pVR0/o+wnGSX9WetYIYTDBNTW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Lxdsy/40; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733201440; x=1764737440;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=VZObTby+wrUpCZmyv6XIYVl38CzMpOARrRIOlQH/QNw=;
  b=Lxdsy/40JKmT7rXciwbIVqhSL/Cv+cBTRKTTvn6/ItsWQoTKtoK7zV1R
   It+06sNRR/p3Ai/R2WdQ1p3iPqeNlDPosHvr7Fq996LlF+hIKkuIGx0yg
   VzbfAozPwvXGuttqrwIirFRmOc9D0mumblDFXXk3kDR5lHBaXolBhs6+4
   mxeyphBn+gNHwpKIJVFjrUPU7aDGRo/tQBgsQnUQZ/PqijdOf+rEAdRpG
   va97ELJUqfi9DhSxL6em4ESicKBVXIwgFXQSH2Srk4ysbH3Od7KEeFMTM
   DaalUjy+M6qAbKgDQ7AcjfP2gLwXGLL0glzv0/2hvPLRgcP3kD+rqYeCC
   g==;
X-CSE-ConnectionGUID: YzpstmWtQRixSEa7O1Tj7Q==
X-CSE-MsgGUID: 3IHvK2EPTQ2P4k9sxMtidg==
X-IronPort-AV: E=McAfee;i="6700,10204,11274"; a="37172929"
X-IronPort-AV: E=Sophos;i="6.12,204,1728975600"; 
   d="scan'208";a="37172929"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2024 20:50:38 -0800
X-CSE-ConnectionGUID: YNyk7VkzRaWK30zUQG49JA==
X-CSE-MsgGUID: oHIhDmU1T9yMLOqs52Nleg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,204,1728975600"; 
   d="scan'208";a="124152610"
Received: from lkp-server01.sh.intel.com (HELO 388c121a226b) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 02 Dec 2024 20:50:35 -0800
Received: from kbuild by 388c121a226b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tIKro-00007p-1r;
	Tue, 03 Dec 2024 04:50:32 +0000
Date: Tue, 3 Dec 2024 12:50:13 +0800
From: kernel test robot <lkp@intel.com>
To: Kashyap Desai <kashyap.desai@broadcom.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Hannes Reinecke <hare@suse.de>, Tomas Henzl <thenzl@redhat.com>,
	Himanshu Madhani <himanshu.madhani@oracle.com>
Subject: drivers/scsi/mpi3mr/mpi3mr_fw.c:360:58: warning: '%d' directive
 output may be truncated writing between 1 and 3 bytes into a region of size
 between 1 and 32
Message-ID: <202412031228.7IB2UW85-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   cdd30ebb1b9f36159d66f088b61aee264e649d7a
commit: 824a156633dfdb0e17979a0d0bb2c757d1bb949c scsi: mpi3mr: Base driver code
date:   3 years, 6 months ago
config: x86_64-randconfig-015-20240106 (https://download.01.org/0day-ci/archive/20241203/202412031228.7IB2UW85-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-12) 11.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241203/202412031228.7IB2UW85-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412031228.7IB2UW85-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/scsi/mpi3mr/mpi3mr_fw.c: In function 'mpi3mr_setup_isr':
>> drivers/scsi/mpi3mr/mpi3mr_fw.c:360:58: warning: '%d' directive output may be truncated writing between 1 and 3 bytes into a region of size between 1 and 32 [-Wformat-truncation=]
     360 |         snprintf(intr_info->name, MPI3MR_NAME_LENGTH, "%s%d-msix%d",
         |                                                          ^~
   drivers/scsi/mpi3mr/mpi3mr_fw.c:360:55: note: directive argument in the range [0, 255]
     360 |         snprintf(intr_info->name, MPI3MR_NAME_LENGTH, "%s%d-msix%d",
         |                                                       ^~~~~~~~~~~~~
   drivers/scsi/mpi3mr/mpi3mr_fw.c:360:55: note: directive argument in the range [0, 65535]
   drivers/scsi/mpi3mr/mpi3mr_fw.c:360:9: note: 'snprintf' output between 8 and 45 bytes into a destination of size 32
     360 |         snprintf(intr_info->name, MPI3MR_NAME_LENGTH, "%s%d-msix%d",
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     361 |             mrioc->driver_name, mrioc->id, index);
         |             ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
--
   drivers/scsi/mpi3mr/mpi3mr_os.c: In function 'mpi3mr_probe':
>> drivers/scsi/mpi3mr/mpi3mr_os.c:210:33: warning: '%d' directive writing between 1 and 3 bytes into a region of size between 1 and 32 [-Wformat-overflow=]
     210 |         sprintf(mrioc->name, "%s%d", mrioc->driver_name, mrioc->id);
         |                                 ^~
   drivers/scsi/mpi3mr/mpi3mr_os.c:210:30: note: directive argument in the range [0, 255]
     210 |         sprintf(mrioc->name, "%s%d", mrioc->driver_name, mrioc->id);
         |                              ^~~~~~
   drivers/scsi/mpi3mr/mpi3mr_os.c:210:9: note: 'sprintf' output between 2 and 35 bytes into a destination of size 32
     210 |         sprintf(mrioc->name, "%s%d", mrioc->driver_name, mrioc->id);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +360 drivers/scsi/mpi3mr/mpi3mr_fw.c

   340	
   341	/**
   342	 * mpi3mr_request_irq - Request IRQ and register ISR
   343	 * @mrioc: Adapter instance reference
   344	 * @index: IRQ vector index
   345	 *
   346	 * Request threaded ISR with primary ISR and secondary
   347	 *
   348	 * Return: 0 on success and non zero on failures.
   349	 */
   350	static inline int mpi3mr_request_irq(struct mpi3mr_ioc *mrioc, u16 index)
   351	{
   352		struct pci_dev *pdev = mrioc->pdev;
   353		struct mpi3mr_intr_info *intr_info = mrioc->intr_info + index;
   354		int retval = 0;
   355	
   356		intr_info->mrioc = mrioc;
   357		intr_info->msix_index = index;
   358		intr_info->op_reply_q = NULL;
   359	
 > 360		snprintf(intr_info->name, MPI3MR_NAME_LENGTH, "%s%d-msix%d",
   361		    mrioc->driver_name, mrioc->id, index);
   362	
   363		retval = request_threaded_irq(pci_irq_vector(pdev, index), mpi3mr_isr,
   364		    mpi3mr_isr_poll, IRQF_SHARED, intr_info->name, intr_info);
   365		if (retval) {
   366			ioc_err(mrioc, "%s: Unable to allocate interrupt %d!\n",
   367			    intr_info->name, pci_irq_vector(pdev, index));
   368			return retval;
   369		}
   370	
   371		return retval;
   372	}
   373	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

