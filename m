Return-Path: <linux-kernel+bounces-428533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 12BFA9E0FC3
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 01:33:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8391B23058
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 00:33:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF34E288DA;
	Tue,  3 Dec 2024 00:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HPBHM/Tc"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E4196AAD
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 00:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733185994; cv=none; b=iPnmzHQBlI5qiDdWXRm40UqDhAH9g5h+SK8U8ZxPlABYI7qJLZYxTwPOg5Ai77MFG33kl13RHWftPooL23Rv24YGDXIHmV8EJzrmDuC+aAxHhzRX3Mj1AUhGO+LGMvL96Mf9HyEBuPCX39PeZdncUDl8BnAUg/gorlCKi/vuunQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733185994; c=relaxed/simple;
	bh=GX9Qy5BGeWyg6vob/RxOIajuIQafKFCDfCZsVSFEJ4E=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Sa1SJuHnfhqbYo4Kw/DLNmBszJTX1sIiDaAa4j8bgaNVBPuqTFEy0jwSFeG0iHJ42KhsuOI5VxRmyL8ntiZOF86xGEOFarciGQSpz7Z1m8BwzjbYCQMXTzUH8wICPvJkiax5pZ9dzNeiZrEiD0NzAOapvvYGnSQ+bakOoeLLP2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HPBHM/Tc; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733185992; x=1764721992;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=GX9Qy5BGeWyg6vob/RxOIajuIQafKFCDfCZsVSFEJ4E=;
  b=HPBHM/TctvbmYtePxg+ROnBGCyPQegxc+uYlAV9BJOgoM50FIZ0cTdG9
   Y6KnDISs0mqLvQQuquk3JWa+XC8syrAEPabwOoUdk+yz/eiPGq5fFYWHL
   +GeL/flaEjK7WsFzUOBqNcY2+ST18x8rj+iJJdHvKtXjLOt0fYQulYet2
   jcAyqVUSQ0/NsPCGtSHQFwje6fMjEHoGNtBpbwumcjc7jvH+2izO7SLMC
   r0m2btGlU3y13E7RwkqnJEz10+Jn8rnHsTPDBib9JB7u80fLVyFLzQVDZ
   XWQYuvAZa79DyFlSDwOxNgIiU7gGyquddqXFp9QwG3OmEuSnnJvskgB1Z
   Q==;
X-CSE-ConnectionGUID: aOb3Fc5JSf+MQvv9JP4GoA==
X-CSE-MsgGUID: JtT8srbcT3uReNUr3PhBLA==
X-IronPort-AV: E=McAfee;i="6700,10204,11274"; a="44765856"
X-IronPort-AV: E=Sophos;i="6.12,203,1728975600"; 
   d="scan'208";a="44765856"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2024 16:33:12 -0800
X-CSE-ConnectionGUID: RvaT9BKjR0WufqMAds7lTw==
X-CSE-MsgGUID: WnjEUOpUQaiHM0hpiX9NZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,203,1728975600"; 
   d="scan'208";a="93731475"
Received: from lkp-server02.sh.intel.com (HELO 36a1563c48ff) ([10.239.97.151])
  by fmviesa009.fm.intel.com with ESMTP; 02 Dec 2024 16:33:09 -0800
Received: from kbuild by 36a1563c48ff with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tIGqb-000350-00;
	Tue, 03 Dec 2024 00:33:03 +0000
Date: Tue, 3 Dec 2024 08:31:35 +0800
From: kernel test robot <lkp@intel.com>
To: Quinn Tran <qutran@marvell.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Himanshu Madhani <himanshu.madhani@oracle.com>,
	Nilesh Javali <njavali@marvell.com>
Subject: drivers/scsi/qla2xxx/qla_isr.c:3724: warning: Function parameter or
 member 'rsp_q_in' not described in 'qla_chk_cont_iocb_avail'
Message-ID: <202412030821.oJA3KV4d-lkp@intel.com>
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
head:   cdd30ebb1b9f36159d66f088b61aee264e649d7a
commit: c019cd656e717349ff22d0c41d6fbfc773f48c52 scsi: qla2xxx: edif: Fix dropped IKE message
date:   2 years, 5 months ago
config: i386-buildonly-randconfig-001-20240107 (https://download.01.org/0day-ci/archive/20241203/202412030821.oJA3KV4d-lkp@intel.com/config)
compiler: ClangBuiltLinux clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241203/202412030821.oJA3KV4d-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412030821.oJA3KV4d-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/scsi/qla2xxx/qla_isr.c:3724: warning: Function parameter or member 'rsp_q_in' not described in 'qla_chk_cont_iocb_avail'


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

