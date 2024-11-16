Return-Path: <linux-kernel+bounces-411771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73AAF9CFF5B
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 15:49:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 349C1283A52
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 14:49:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CB9A374CB;
	Sat, 16 Nov 2024 14:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hONiac63"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D265B5C96
	for <linux-kernel@vger.kernel.org>; Sat, 16 Nov 2024 14:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731768576; cv=none; b=ogzRzJUMdjek6LBlhPQqhel3n+f8z6EbDVum0HMP8JylaFmYKXQo5Cx/6x02tNQKgZ1W0Gvogjix8un8DXrV7ntwaWfMxtE4P8zlPK3qhb4bJuKRzxSwIrFyP8ig0dlWWf+mP72uKwY36YeYL26GQLavle84R2Z/BCptYCRfbQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731768576; c=relaxed/simple;
	bh=+8qjG6lkKmzdTCWTh1r4yk6B2fJfBryzWI+n+DKtC0I=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=TGtWAcdl6Qis4140XbzdQwZJw8XQZoONJWoh4jcm7XKUHQ0I1/DuEHbsQQ6MjKPscKbeB7o4PCRddUkneN6TCob9SCZ5wsv/BNUma3waQuGlwghq9+CpJuOwLPKm1pgMnxbjHLGdqZyEOYEWFkqHq5Fizx0Mu8/X2lGODBENjq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hONiac63; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731768575; x=1763304575;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=+8qjG6lkKmzdTCWTh1r4yk6B2fJfBryzWI+n+DKtC0I=;
  b=hONiac63jUtjHmFeNxPe/w/mghYp7TIvsugI7wKIuUWjVlsjvQ/7IZVr
   1LaY5kSpbz4SAI7ulNg4QC+9IDzjTwhr+MUYvES47BQSNFjusz0sPhe7V
   oizIECyT48C2FsnZb1YEy5q3okrmRNO3GxKSazUEqeUpqGwzKaEEJPlHz
   sn/jGXW08wRPjKjcjewPxITBtA8MAtMvizRdSGzZk+HEWasoON2OnHUW5
   ElLGEPYkB8Ep1kLD6o5NKNV1D/02VDM1EOArJUvAi8YQmwHDe54i9FwjA
   DqjrOL4aezz4pAj8dMKbPP7BhTXHKT951ro50BhXpfm7OhaC2Uy2w4I5T
   A==;
X-CSE-ConnectionGUID: 4D9cgQQET+aSe/jr93v3FA==
X-CSE-MsgGUID: oSXB+1j/RLivA7Dr4Ug9Jg==
X-IronPort-AV: E=McAfee;i="6700,10204,11258"; a="49197504"
X-IronPort-AV: E=Sophos;i="6.12,160,1728975600"; 
   d="scan'208";a="49197504"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2024 06:49:32 -0800
X-CSE-ConnectionGUID: EHBWx8jxR3q+u9cNnUYDDQ==
X-CSE-MsgGUID: 3s6M9fdvTpieNvJnFrlXFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,160,1728975600"; 
   d="scan'208";a="89589509"
Received: from lkp-server01.sh.intel.com (HELO 1e3cc1889ffb) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 16 Nov 2024 06:49:30 -0800
Received: from kbuild by 1e3cc1889ffb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tCK76-0000hE-1F;
	Sat, 16 Nov 2024 14:49:28 +0000
Date: Sat, 16 Nov 2024 22:49:25 +0800
From: kernel test robot <lkp@intel.com>
To: Ranjan Kumar <ranjan.kumar@broadcom.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Sathya Prakash <sathya.prakash@broadcom.com>
Subject: drivers/scsi/mpi3mr/mpi3mr_fw.c:1531:54: error: variable
 'scratch_pad0' set but not used
Message-ID: <202411160656.VlupxFbZ-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   cfaaa7d010d1fc58f9717fcc8591201e741d2d49
commit: 0a2714b787b91176e7d4f005dcef8d177efdff8a scsi: mpi3mr: Debug ability improvements
date:   8 months ago
config: x86_64-rhel-9.4-nofixup (https://download.01.org/0day-ci/archive/20241116/202411160656.VlupxFbZ-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241116/202411160656.VlupxFbZ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411160656.VlupxFbZ-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/scsi/mpi3mr/mpi3mr_fw.c: In function 'mpi3mr_issue_reset':
>> drivers/scsi/mpi3mr/mpi3mr_fw.c:1531:54: error: variable 'scratch_pad0' set but not used [-Werror=unused-but-set-variable]
    1531 |         u32 host_diagnostic, ioc_status, ioc_config, scratch_pad0;
         |                                                      ^~~~~~~~~~~~
   drivers/scsi/mpi3mr/mpi3mr_fw.c: In function 'mpi3mr_setup_isr':
   drivers/scsi/mpi3mr/mpi3mr_fw.c:732:58: error: '%d' directive output may be truncated writing between 1 and 3 bytes into a region of size between 1 and 64 [-Werror=format-truncation=]
     732 |         snprintf(intr_info->name, MPI3MR_NAME_LENGTH, "%s%d-msix%d",
         |                                                          ^~
   In function 'mpi3mr_request_irq',
       inlined from 'mpi3mr_setup_isr' at drivers/scsi/mpi3mr/mpi3mr_fw.c:857:12:
   drivers/scsi/mpi3mr/mpi3mr_fw.c:732:55: note: directive argument in the range [0, 255]
     732 |         snprintf(intr_info->name, MPI3MR_NAME_LENGTH, "%s%d-msix%d",
         |                                                       ^~~~~~~~~~~~~
   drivers/scsi/mpi3mr/mpi3mr_fw.c:732:55: note: directive argument in the range [0, 65535]
   drivers/scsi/mpi3mr/mpi3mr_fw.c:732:9: note: 'snprintf' output between 8 and 77 bytes into a destination of size 64
     732 |         snprintf(intr_info->name, MPI3MR_NAME_LENGTH, "%s%d-msix%d",
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     733 |             mrioc->driver_name, mrioc->id, index);
         |             ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from include/asm-generic/bug.h:22,
                    from arch/x86/include/asm/bug.h:87,
                    from include/linux/bug.h:5,
                    from include/linux/thread_info.h:13,
                    from include/linux/spinlock.h:60,
                    from include/linux/wait.h:9,
                    from include/linux/wait_bit.h:8,
                    from include/linux/fs.h:6,
                    from include/linux/highmem.h:5,
                    from include/linux/bvec.h:10,
                    from include/linux/blk_types.h:10,
                    from include/linux/blkdev.h:9,
                    from drivers/scsi/mpi3mr/mpi3mr.h:13,
                    from drivers/scsi/mpi3mr/mpi3mr_fw.c:10:
   drivers/scsi/mpi3mr/mpi3mr_fw.c: In function 'mpi3mr_bring_ioc_ready':
   include/linux/kern_levels.h:5:25: error: '%s' directive argument is null [-Werror=format-overflow=]
       5 | #define KERN_SOH        "\001"          /* ASCII Start Of Header */
         |                         ^~~~~~
   include/linux/printk.h:429:25: note: in definition of macro 'printk_index_wrap'
     429 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
         |                         ^~~~
   include/linux/printk.h:530:9: note: in expansion of macro 'printk'
     530 |         printk(KERN_INFO pr_fmt(fmt), ##__VA_ARGS__)
         |         ^~~~~~
   include/linux/kern_levels.h:14:25: note: in expansion of macro 'KERN_SOH'
      14 | #define KERN_INFO       KERN_SOH "6"    /* informational */
         |                         ^~~~~~~~
   include/linux/printk.h:530:16: note: in expansion of macro 'KERN_INFO'
     530 |         printk(KERN_INFO pr_fmt(fmt), ##__VA_ARGS__)
         |                ^~~~~~~~~
   drivers/scsi/mpi3mr/mpi3mr_debug.h:48:9: note: in expansion of macro 'pr_info'
      48 |         pr_info("%s: " fmt, (ioc)->name, ##__VA_ARGS__)
         |         ^~~~~~~
   drivers/scsi/mpi3mr/mpi3mr_fw.c:1341:9: note: in expansion of macro 'ioc_info'
    1341 |         ioc_info(mrioc, "controller is in %s state during detection\n",
         |         ^~~~~~~~
   include/linux/kern_levels.h:5:25: error: '%s' directive argument is null [-Werror=format-overflow=]
       5 | #define KERN_SOH        "\001"          /* ASCII Start Of Header */
         |                         ^~~~~~
   include/linux/printk.h:429:25: note: in definition of macro 'printk_index_wrap'
     429 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
         |                         ^~~~
   include/linux/printk.h:530:9: note: in expansion of macro 'printk'
     530 |         printk(KERN_INFO pr_fmt(fmt), ##__VA_ARGS__)
         |         ^~~~~~
   include/linux/kern_levels.h:14:25: note: in expansion of macro 'KERN_SOH'
      14 | #define KERN_INFO       KERN_SOH "6"    /* informational */
         |                         ^~~~~~~~
   include/linux/printk.h:530:16: note: in expansion of macro 'KERN_INFO'
     530 |         printk(KERN_INFO pr_fmt(fmt), ##__VA_ARGS__)
         |                ^~~~~~~~~
   drivers/scsi/mpi3mr/mpi3mr_debug.h:48:9: note: in expansion of macro 'pr_info'
      48 |         pr_info("%s: " fmt, (ioc)->name, ##__VA_ARGS__)
         |         ^~~~~~~
   drivers/scsi/mpi3mr/mpi3mr_fw.c:1360:17: note: in expansion of macro 'ioc_info'
    1360 |                 ioc_info(mrioc,
         |                 ^~~~~~~~
   include/linux/kern_levels.h:5:25: error: '%s' directive argument is null [-Werror=format-overflow=]
       5 | #define KERN_SOH        "\001"          /* ASCII Start Of Header */
         |                         ^~~~~~
   include/linux/printk.h:429:25: note: in definition of macro 'printk_index_wrap'
     429 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
         |                         ^~~~
   include/linux/printk.h:500:9: note: in expansion of macro 'printk'
     500 |         printk(KERN_ERR pr_fmt(fmt), ##__VA_ARGS__)
         |         ^~~~~~
   include/linux/kern_levels.h:11:25: note: in expansion of macro 'KERN_SOH'
      11 | #define KERN_ERR        KERN_SOH "3"    /* error conditions */
         |                         ^~~~~~~~
   include/linux/printk.h:500:16: note: in expansion of macro 'KERN_ERR'
     500 |         printk(KERN_ERR pr_fmt(fmt), ##__VA_ARGS__)
         |                ^~~~~~~~
   drivers/scsi/mpi3mr/mpi3mr_debug.h:42:9: note: in expansion of macro 'pr_err'
      42 |         pr_err("%s: " fmt, (ioc)->name, ##__VA_ARGS__)
         |         ^~~~~~
   drivers/scsi/mpi3mr/mpi3mr_fw.c:1371:25: note: in expansion of macro 'ioc_err'
    1371 |                         ioc_err(mrioc,
         |                         ^~~~~~~
   drivers/scsi/mpi3mr/mpi3mr_fw.c: In function 'mpi3mr_start_watchdog':
   drivers/scsi/mpi3mr/mpi3mr_fw.c:2690:60: error: '%s' directive output may be truncated writing up to 63 bytes into a region of size 41 [-Werror=format-truncation=]
    2690 |             sizeof(mrioc->watchdog_work_q_name), "watchdog_%s%d", mrioc->name,
         |                                                            ^~
   drivers/scsi/mpi3mr/mpi3mr_fw.c:2690:50: note: directive argument in the range [0, 255]


vim +/scratch_pad0 +1531 drivers/scsi/mpi3mr/mpi3mr_fw.c

  1512	
  1513	/**
  1514	 * mpi3mr_issue_reset - Issue reset to the controller
  1515	 * @mrioc: Adapter reference
  1516	 * @reset_type: Reset type
  1517	 * @reset_reason: Reset reason code
  1518	 *
  1519	 * Unlock the host diagnostic registers and write the specific
  1520	 * reset type to that, wait for reset acknowledgment from the
  1521	 * controller, if the reset is not successful retry for the
  1522	 * predefined number of times.
  1523	 *
  1524	 * Return: 0 on success, non-zero on failure.
  1525	 */
  1526	static int mpi3mr_issue_reset(struct mpi3mr_ioc *mrioc, u16 reset_type,
  1527		u16 reset_reason)
  1528	{
  1529		int retval = -1;
  1530		u8 unlock_retry_count = 0;
> 1531		u32 host_diagnostic, ioc_status, ioc_config, scratch_pad0;
  1532		u32 timeout = MPI3MR_RESET_ACK_TIMEOUT * 10;
  1533	
  1534		if ((reset_type != MPI3_SYSIF_HOST_DIAG_RESET_ACTION_SOFT_RESET) &&
  1535		    (reset_type != MPI3_SYSIF_HOST_DIAG_RESET_ACTION_DIAG_FAULT))
  1536			return retval;
  1537		if (mrioc->unrecoverable)
  1538			return retval;
  1539		if (reset_reason == MPI3MR_RESET_FROM_FIRMWARE) {
  1540			retval = 0;
  1541			return retval;
  1542		}
  1543	
  1544		ioc_info(mrioc, "%s reset due to %s(0x%x)\n",
  1545		    mpi3mr_reset_type_name(reset_type),
  1546		    mpi3mr_reset_rc_name(reset_reason), reset_reason);
  1547	
  1548		mpi3mr_clear_reset_history(mrioc);
  1549		do {
  1550			ioc_info(mrioc,
  1551			    "Write magic sequence to unlock host diag register (retry=%d)\n",
  1552			    ++unlock_retry_count);
  1553			if (unlock_retry_count >= MPI3MR_HOSTDIAG_UNLOCK_RETRY_COUNT) {
  1554				ioc_err(mrioc,
  1555				    "%s reset failed due to unlock failure, host_diagnostic(0x%08x)\n",
  1556				    mpi3mr_reset_type_name(reset_type),
  1557				    host_diagnostic);
  1558				mrioc->unrecoverable = 1;
  1559				return retval;
  1560			}
  1561	
  1562			writel(MPI3_SYSIF_WRITE_SEQUENCE_KEY_VALUE_FLUSH,
  1563			    &mrioc->sysif_regs->write_sequence);
  1564			writel(MPI3_SYSIF_WRITE_SEQUENCE_KEY_VALUE_1ST,
  1565			    &mrioc->sysif_regs->write_sequence);
  1566			writel(MPI3_SYSIF_WRITE_SEQUENCE_KEY_VALUE_2ND,
  1567			    &mrioc->sysif_regs->write_sequence);
  1568			writel(MPI3_SYSIF_WRITE_SEQUENCE_KEY_VALUE_3RD,
  1569			    &mrioc->sysif_regs->write_sequence);
  1570			writel(MPI3_SYSIF_WRITE_SEQUENCE_KEY_VALUE_4TH,
  1571			    &mrioc->sysif_regs->write_sequence);
  1572			writel(MPI3_SYSIF_WRITE_SEQUENCE_KEY_VALUE_5TH,
  1573			    &mrioc->sysif_regs->write_sequence);
  1574			writel(MPI3_SYSIF_WRITE_SEQUENCE_KEY_VALUE_6TH,
  1575			    &mrioc->sysif_regs->write_sequence);
  1576			usleep_range(1000, 1100);
  1577			host_diagnostic = readl(&mrioc->sysif_regs->host_diagnostic);
  1578			ioc_info(mrioc,
  1579			    "wrote magic sequence: retry_count(%d), host_diagnostic(0x%08x)\n",
  1580			    unlock_retry_count, host_diagnostic);
  1581		} while (!(host_diagnostic & MPI3_SYSIF_HOST_DIAG_DIAG_WRITE_ENABLE));
  1582	
  1583		scratch_pad0 = ((MPI3MR_RESET_REASON_OSTYPE_LINUX <<
  1584		    MPI3MR_RESET_REASON_OSTYPE_SHIFT) | (mrioc->facts.ioc_num <<
  1585		    MPI3MR_RESET_REASON_IOCNUM_SHIFT) | reset_reason);
  1586		writel(reset_reason, &mrioc->sysif_regs->scratchpad[0]);
  1587		writel(host_diagnostic | reset_type,
  1588		    &mrioc->sysif_regs->host_diagnostic);
  1589		switch (reset_type) {
  1590		case MPI3_SYSIF_HOST_DIAG_RESET_ACTION_SOFT_RESET:
  1591			do {
  1592				ioc_status = readl(&mrioc->sysif_regs->ioc_status);
  1593				ioc_config =
  1594				    readl(&mrioc->sysif_regs->ioc_configuration);
  1595				if ((ioc_status & MPI3_SYSIF_IOC_STATUS_RESET_HISTORY)
  1596				    && mpi3mr_soft_reset_success(ioc_status, ioc_config)
  1597				    ) {
  1598					mpi3mr_clear_reset_history(mrioc);
  1599					retval = 0;
  1600					break;
  1601				}
  1602				msleep(100);
  1603			} while (--timeout);
  1604			mpi3mr_print_fault_info(mrioc);
  1605			break;
  1606		case MPI3_SYSIF_HOST_DIAG_RESET_ACTION_DIAG_FAULT:
  1607			do {
  1608				ioc_status = readl(&mrioc->sysif_regs->ioc_status);
  1609				if (mpi3mr_diagfault_success(mrioc, ioc_status)) {
  1610					retval = 0;
  1611					break;
  1612				}
  1613				msleep(100);
  1614			} while (--timeout);
  1615			break;
  1616		default:
  1617			break;
  1618		}
  1619	
  1620		writel(MPI3_SYSIF_WRITE_SEQUENCE_KEY_VALUE_2ND,
  1621		    &mrioc->sysif_regs->write_sequence);
  1622	
  1623		ioc_config = readl(&mrioc->sysif_regs->ioc_configuration);
  1624		ioc_status = readl(&mrioc->sysif_regs->ioc_status);
  1625		ioc_info(mrioc,
  1626		    "ioc_status/ioc_onfig after %s reset is (0x%x)/(0x%x)\n",
  1627		    (!retval)?"successful":"failed", ioc_status,
  1628		    ioc_config);
  1629		if (retval)
  1630			mrioc->unrecoverable = 1;
  1631		return retval;
  1632	}
  1633	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

