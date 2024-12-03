Return-Path: <linux-kernel+bounces-428792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B42049E137F
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 07:48:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40E82161159
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 06:48:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5785C188A18;
	Tue,  3 Dec 2024 06:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Uqz05e/J"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4DD518859F
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 06:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733208474; cv=none; b=mAQHTIt7IO/2ZQEqeJze3FhUExa6IpHgLltzZe7BeUEluVnXmHo2T56PU2ricF99x5ix8LonILkH+RyUegaefWLsuvjtCG0YDlikQbgHiyMjAJzwc+kEfvTyqRAqLJJotC89bDrtm7OXRLY8bz3PnoVuXRZtuAKZRZHjF52TgzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733208474; c=relaxed/simple;
	bh=kuugUhtBYnp+bUU+lQ1TzedAgZe5FzJFVQuffo8rzCk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=PC+yD0DL/Z850LKVCMmxgs9rtAu4K7F8RQH4goupbAtaRic1ZTbZlnpISM2meNoiwM8vQIw9evdTB9bQxoDP9Po7Qe+i01XT1emk1K76Y30QaqIGvGSZJRDGa3/DVi8DUMxyAX1I6vVBqPucF1lSCUjPH0PohsLEurvLxzIu1IU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Uqz05e/J; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733208472; x=1764744472;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=kuugUhtBYnp+bUU+lQ1TzedAgZe5FzJFVQuffo8rzCk=;
  b=Uqz05e/JllrnInO7QH7asb4B+5pOqH9p4jThggcHU7qiJZZS9FsZuBoy
   44mTsR7PDqVChlrQyZxKOdzHT3cQ9SUKM/0VcmBDfMBkEbUTf5U+bz4la
   rDKPLYEBtNAkPtcwB5+/U76ktyVunRQsUr1WEI3CV5XQDBlHFaWfp+cib
   mnjLbbMaVFy4pbZxFD7ie5OLzkHJX1Kdgo1qJsxTR9aXz/ekE0rHHbWXM
   FOEViTwNilNQ/pt6ba28jWRwdhb+3x06T6WX7uWiMeQScPiHgwlkZzGfJ
   +VOsrtQi/ZafEYpFgejKBiwLfDJ4FkC2K37/ihHy9PXurdFV2rDg2dTst
   A==;
X-CSE-ConnectionGUID: II25QDttRzqYOlXWyqiqpw==
X-CSE-MsgGUID: WYgSsz6ZSmS9p/h1y2ZwCg==
X-IronPort-AV: E=McAfee;i="6700,10204,11274"; a="44071012"
X-IronPort-AV: E=Sophos;i="6.12,204,1728975600"; 
   d="scan'208";a="44071012"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2024 22:47:52 -0800
X-CSE-ConnectionGUID: xnk2nUiJQPWsUeaW4W5qQQ==
X-CSE-MsgGUID: nwBLQwHBTjmQ29qdtaZauA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,204,1728975600"; 
   d="scan'208";a="97770675"
Received: from lkp-server01.sh.intel.com (HELO 388c121a226b) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 02 Dec 2024 22:47:50 -0800
Received: from kbuild by 388c121a226b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tIMhH-0000Eb-36;
	Tue, 03 Dec 2024 06:47:47 +0000
Date: Tue, 3 Dec 2024 14:47:29 +0800
From: kernel test robot <lkp@intel.com>
To: Kashyap Desai <kashyap.desai@broadcom.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Hannes Reinecke <hare@suse.de>, Tomas Henzl <thenzl@redhat.com>,
	Himanshu Madhani <himanshu.madhani@oracle.com>
Subject: drivers/scsi/mpi3mr/mpi3mr_fw.c:1549:60: warning: '%s' directive
 output may be truncated writing up to 31 bytes into a region of size 11
Message-ID: <202412031406.ymLEG23a-lkp@intel.com>
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
commit: 672ae26c82166d63e0352403b7ea16ab4705edc1 scsi: mpi3mr: Add support for internal watchdog thread
date:   3 years, 6 months ago
config: x86_64-randconfig-015-20240106 (https://download.01.org/0day-ci/archive/20241203/202412031406.ymLEG23a-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-12) 11.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241203/202412031406.ymLEG23a-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412031406.ymLEG23a-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/scsi/mpi3mr/mpi3mr_fw.c: In function 'mpi3mr_setup_isr':
   drivers/scsi/mpi3mr/mpi3mr_fw.c:453:58: warning: '%d' directive output may be truncated writing between 1 and 3 bytes into a region of size between 1 and 32 [-Wformat-truncation=]
     453 |         snprintf(intr_info->name, MPI3MR_NAME_LENGTH, "%s%d-msix%d",
         |                                                          ^~
   drivers/scsi/mpi3mr/mpi3mr_fw.c:453:55: note: directive argument in the range [0, 255]
     453 |         snprintf(intr_info->name, MPI3MR_NAME_LENGTH, "%s%d-msix%d",
         |                                                       ^~~~~~~~~~~~~
   drivers/scsi/mpi3mr/mpi3mr_fw.c:453:55: note: directive argument in the range [0, 65535]
   drivers/scsi/mpi3mr/mpi3mr_fw.c:453:9: note: 'snprintf' output between 8 and 45 bytes into a destination of size 32
     453 |         snprintf(intr_info->name, MPI3MR_NAME_LENGTH, "%s%d-msix%d",
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     454 |             mrioc->driver_name, mrioc->id, index);
         |             ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/scsi/mpi3mr/mpi3mr_fw.c: In function 'mpi3mr_start_watchdog':
>> drivers/scsi/mpi3mr/mpi3mr_fw.c:1549:60: warning: '%s' directive output may be truncated writing up to 31 bytes into a region of size 11 [-Wformat-truncation=]
    1549 |             sizeof(mrioc->watchdog_work_q_name), "watchdog_%s%d", mrioc->name,
         |                                                            ^~
   drivers/scsi/mpi3mr/mpi3mr_fw.c:1549:50: note: directive argument in the range [0, 255]
    1549 |             sizeof(mrioc->watchdog_work_q_name), "watchdog_%s%d", mrioc->name,
         |                                                  ^~~~~~~~~~~~~~~
   drivers/scsi/mpi3mr/mpi3mr_fw.c:1548:9: note: 'snprintf' output between 11 and 44 bytes into a destination of size 20
    1548 |         snprintf(mrioc->watchdog_work_q_name,
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    1549 |             sizeof(mrioc->watchdog_work_q_name), "watchdog_%s%d", mrioc->name,
         |             ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    1550 |             mrioc->id);
         |             ~~~~~~~~~~


vim +1549 drivers/scsi/mpi3mr/mpi3mr_fw.c

  1532	
  1533	/**
  1534	 * mpi3mr_start_watchdog - Start watchdog
  1535	 * @mrioc: Adapter instance reference
  1536	 *
  1537	 * Create and start the watchdog thread to monitor controller
  1538	 * faults.
  1539	 *
  1540	 * Return: Nothing.
  1541	 */
  1542	void mpi3mr_start_watchdog(struct mpi3mr_ioc *mrioc)
  1543	{
  1544		if (mrioc->watchdog_work_q)
  1545			return;
  1546	
  1547		INIT_DELAYED_WORK(&mrioc->watchdog_work, mpi3mr_watchdog_work);
  1548		snprintf(mrioc->watchdog_work_q_name,
> 1549		    sizeof(mrioc->watchdog_work_q_name), "watchdog_%s%d", mrioc->name,
  1550		    mrioc->id);
  1551		mrioc->watchdog_work_q =
  1552		    create_singlethread_workqueue(mrioc->watchdog_work_q_name);
  1553		if (!mrioc->watchdog_work_q) {
  1554			ioc_err(mrioc, "%s: failed (line=%d)\n", __func__, __LINE__);
  1555			return;
  1556		}
  1557	
  1558		if (mrioc->watchdog_work_q)
  1559			queue_delayed_work(mrioc->watchdog_work_q,
  1560			    &mrioc->watchdog_work,
  1561			    msecs_to_jiffies(MPI3MR_WATCHDOG_INTERVAL));
  1562	}
  1563	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

