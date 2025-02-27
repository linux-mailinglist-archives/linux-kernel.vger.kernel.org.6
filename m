Return-Path: <linux-kernel+bounces-535746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A30EA476AC
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 08:35:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EDA81888590
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 07:35:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27966221F08;
	Thu, 27 Feb 2025 07:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BWeEbevA"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D807121D5A8
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 07:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740641698; cv=none; b=fyXeiWOfMJUOH/iknnxVErC31eSODXI0okvCeNYY9E07n4tEBFXeJJHXAih0CHHD5YPYyH30Q/Dia3uvEzIjEDWn5KRqfCCf/sE8ODgAw9vbdyjGWuyic+KDGH3diomauwNAG0raC6vmrGAfzbIYmAGvmLaAUQfvvI8lwYwEL+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740641698; c=relaxed/simple;
	bh=uC3Dh9dmQKs9E+4iiCtR6XjfqmBPEs526BYOEl0TT5Y=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=iV7w1PMSWh8Z9ubtaf/qqoQLHKzque3n785xQn3CdDbCxVyQ37fYlVcIsAh6nyuYIN5cjCWo+mnZz+sCEAS2naLCd+9aKeKsHeUQuem9hh9Taubjn3uFL/nX7ol21imGWyt39dPkobJT+ffZk2APE5x6wVLUCCbrgarDkWNBe8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BWeEbevA; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740641697; x=1772177697;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=uC3Dh9dmQKs9E+4iiCtR6XjfqmBPEs526BYOEl0TT5Y=;
  b=BWeEbevA+096niXJSN0qGmjYifWVZZbG/RPEyIO0uDi3+EAFu4Rb0QyW
   EfdEdhkQodvyCoFLi5wBw5nx++ddc7oNAP86nEfG/DXLcNlqgjjUSptzx
   vHdJyPa+weqaHSZkrnAvK7EUeFjl7jYPlXdwulQgfgulTYp4QsWwnyrr2
   Yh7s0/huOYUd/ulX2E4pRWfNfazTtvuX7WQlZNJt4s5HJw9tePtqIKZ8Y
   ZFF6xMzFVmRevqt4Tbjg7VFmQ6R9VrnCCI/TwlP5pnirF0dnVOugqDsDL
   glTBMQkTIY3/hLYX5EhOQE1VwUnUZyDMMQuEoUqZpKajyYEivNz1D13td
   g==;
X-CSE-ConnectionGUID: n2XqU87DRnutRa7ddQG0Qw==
X-CSE-MsgGUID: K2hjNpr6Q+iyE9o66JRybg==
X-IronPort-AV: E=McAfee;i="6700,10204,11357"; a="45297408"
X-IronPort-AV: E=Sophos;i="6.13,319,1732608000"; 
   d="scan'208";a="45297408"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 23:34:56 -0800
X-CSE-ConnectionGUID: nTSCnof1Qj+orK4cMzkzTA==
X-CSE-MsgGUID: Yx0WR3poS7OCRYiMgyUXKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="121069787"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by fmviesa003.fm.intel.com with ESMTP; 26 Feb 2025 23:34:54 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tnYPw-000D1g-2V;
	Thu, 27 Feb 2025 07:34:49 +0000
Date: Thu, 27 Feb 2025 15:34:01 +0800
From: kernel test robot <lkp@intel.com>
To: Quinn Tran <qutran@marvell.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Himanshu Madhani <himanshu.madhani@oracle.com>,
	Nilesh Javali <njavali@marvell.com>
Subject: drivers/scsi/qla2xxx/qla_isr.c:3724: warning: Function parameter or
 struct member 'rsp_q_in' not described in 'qla_chk_cont_iocb_avail'
Message-ID: <202502271559.52dHARae-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Quinn,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   dd83757f6e686a2188997cb58b5975f744bb7786
commit: c019cd656e717349ff22d0c41d6fbfc773f48c52 scsi: qla2xxx: edif: Fix dropped IKE message
date:   2 years, 7 months ago
config: i386-randconfig-011-20240921 (https://download.01.org/0day-ci/archive/20250227/202502271559.52dHARae-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250227/202502271559.52dHARae-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502271559.52dHARae-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/scsi/qla2xxx/qla_isr.c:3724: warning: Function parameter or struct member 'rsp_q_in' not described in 'qla_chk_cont_iocb_avail'


vim +3724 drivers/scsi/qla2xxx/qla_isr.c

e84067d7430107 Duane Grigsby 2017-06-21  3713  
fac2807946c10b Quinn Tran    2021-06-23  3714  /**
fac2807946c10b Quinn Tran    2021-06-23  3715   * qla_chk_cont_iocb_avail - check for all continuation iocbs are available
fac2807946c10b Quinn Tran    2021-06-23  3716   *   before iocb processing can start.
fac2807946c10b Quinn Tran    2021-06-23  3717   * @vha: host adapter pointer
fac2807946c10b Quinn Tran    2021-06-23  3718   * @rsp: respond queue
fac2807946c10b Quinn Tran    2021-06-23  3719   * @pkt: head iocb describing how many continuation iocb
fac2807946c10b Quinn Tran    2021-06-23  3720   * Return: 0 all iocbs has arrived, xx- all iocbs have not arrived.
fac2807946c10b Quinn Tran    2021-06-23  3721   */
fac2807946c10b Quinn Tran    2021-06-23  3722  static int qla_chk_cont_iocb_avail(struct scsi_qla_host *vha,
c019cd656e7173 Quinn Tran    2022-07-12  3723  	struct rsp_que *rsp, response_t *pkt, u32 rsp_q_in)
fac2807946c10b Quinn Tran    2021-06-23 @3724  {
c019cd656e7173 Quinn Tran    2022-07-12  3725  	int start_pkt_ring_index;
c019cd656e7173 Quinn Tran    2022-07-12  3726  	u32 iocb_cnt = 0;
fac2807946c10b Quinn Tran    2021-06-23  3727  	int rc = 0;
fac2807946c10b Quinn Tran    2021-06-23  3728  
fac2807946c10b Quinn Tran    2021-06-23  3729  	if (pkt->entry_count == 1)
fac2807946c10b Quinn Tran    2021-06-23  3730  		return rc;
fac2807946c10b Quinn Tran    2021-06-23  3731  
fac2807946c10b Quinn Tran    2021-06-23  3732  	/* ring_index was pre-increment. set it back to current pkt */
fac2807946c10b Quinn Tran    2021-06-23  3733  	if (rsp->ring_index == 0)
fac2807946c10b Quinn Tran    2021-06-23  3734  		start_pkt_ring_index = rsp->length - 1;
fac2807946c10b Quinn Tran    2021-06-23  3735  	else
fac2807946c10b Quinn Tran    2021-06-23  3736  		start_pkt_ring_index = rsp->ring_index - 1;
fac2807946c10b Quinn Tran    2021-06-23  3737  
c019cd656e7173 Quinn Tran    2022-07-12  3738  	if (rsp_q_in < start_pkt_ring_index)
c019cd656e7173 Quinn Tran    2022-07-12  3739  		/* q in ptr is wrapped */
c019cd656e7173 Quinn Tran    2022-07-12  3740  		iocb_cnt = rsp->length - start_pkt_ring_index + rsp_q_in;
fac2807946c10b Quinn Tran    2021-06-23  3741  	else
c019cd656e7173 Quinn Tran    2022-07-12  3742  		iocb_cnt = rsp_q_in - start_pkt_ring_index;
fac2807946c10b Quinn Tran    2021-06-23  3743  
c019cd656e7173 Quinn Tran    2022-07-12  3744  	if (iocb_cnt < pkt->entry_count)
fac2807946c10b Quinn Tran    2021-06-23  3745  		rc = -EIO;
fac2807946c10b Quinn Tran    2021-06-23  3746  
c019cd656e7173 Quinn Tran    2022-07-12  3747  	ql_dbg(ql_dbg_init, vha, 0x5091,
c019cd656e7173 Quinn Tran    2022-07-12  3748  	       "%s - ring %p pkt %p entry count %d iocb_cnt %d rsp_q_in %d rc %d\n",
c019cd656e7173 Quinn Tran    2022-07-12  3749  	       __func__, rsp->ring, pkt, pkt->entry_count, iocb_cnt, rsp_q_in, rc);
fac2807946c10b Quinn Tran    2021-06-23  3750  
fac2807946c10b Quinn Tran    2021-06-23  3751  	return rc;
fac2807946c10b Quinn Tran    2021-06-23  3752  }
fac2807946c10b Quinn Tran    2021-06-23  3753  

:::::: The code at line 3724 was first introduced by commit
:::::: fac2807946c10b9a509b9c348afd442fa823c5f7 scsi: qla2xxx: edif: Add extraction of auth_els from the wire

:::::: TO: Quinn Tran <qutran@marvell.com>
:::::: CC: Martin K. Petersen <martin.petersen@oracle.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

