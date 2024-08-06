Return-Path: <linux-kernel+bounces-275943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C10C948C45
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 11:42:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C058288877
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 09:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 300A11BDAA4;
	Tue,  6 Aug 2024 09:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N/vSipoG"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C4791BDA84
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 09:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722937353; cv=none; b=sl0YtV2ecrl2zM70jWLPeOQt/Bv/iNJmJwOM/3b3stRDhEBkHvwp5PVTxkvosOGxLTs3igZqFFpzl8tqNnXVWa2wxi1GElRWwWlBQEoHgalRIUWDS0fJFKuj+MOg9+w+PvLiXDrPz5e5PndkZgvswsDXH1ghIp4L+8iUAjpiy+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722937353; c=relaxed/simple;
	bh=IZn7speP+xoerFkC55ZXUSz2mmiZ42yMY/QoBdHoHZ8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=TE1P3BybjxAVJGBejijIGeETE7xwRqav3kTtQRpbsLZWFgShYfY55x7zwZfVmp+KK5WTLmwnGXrM0I6uUQ3ltB6PxSrHwkc7hXhPp/fsLg/G04OyhJ7j2hat8FHPImSr+e+0v002ZLdMxSB/Ivh8TS+hP+4Gfh3KkYlHWvsP+HE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N/vSipoG; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722937351; x=1754473351;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=IZn7speP+xoerFkC55ZXUSz2mmiZ42yMY/QoBdHoHZ8=;
  b=N/vSipoGD6W4P+a4QU86sp5SEcd5Fg/obHwZmiGwwHJDhdMk/S3OgBYx
   D8zxf6LTHOXFyoBUL/hA30qYBB2ciTEa7DZh//Fzy51XfD0q5M8S64OzF
   hHazS6D/HN8dPEkwkYspQJwZR4KAwap4Zu5xAb0feIgidUNpjTQI0MxLA
   gmDcHgyvuVLCtjiDtegiCkSiWY5640yvhhMsZJk0mvxnA2KCGkHNsxFUO
   rCrGZMtoQiHOwjofDP8SFe+txxzlgyGw3PhQNbryJzP4yKDGZk9O2LSet
   8KTRHYvLg85BLhzb5ghHu8ritK0Z5A0Z3mPqb2/3Ag3iJ56g+UbRPUWMX
   g==;
X-CSE-ConnectionGUID: ocXCAyD7TUa8NBVniWASGw==
X-CSE-MsgGUID: quYPJrZIR4yvFIydSeaOSA==
X-IronPort-AV: E=McAfee;i="6700,10204,11155"; a="31604021"
X-IronPort-AV: E=Sophos;i="6.09,267,1716274800"; 
   d="scan'208";a="31604021"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2024 02:42:30 -0700
X-CSE-ConnectionGUID: vpK+OUGMSget8k+YNLBCEA==
X-CSE-MsgGUID: awTUVpA3RmOsjbAtUkRJJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,267,1716274800"; 
   d="scan'208";a="57024709"
Received: from unknown (HELO b6bf6c95bbab) ([10.239.97.151])
  by orviesa007.jf.intel.com with ESMTP; 06 Aug 2024 02:42:29 -0700
Received: from kbuild by b6bf6c95bbab with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sbGi2-0004MZ-20;
	Tue, 06 Aug 2024 09:42:26 +0000
Date: Tue, 6 Aug 2024 17:42:13 +0800
From: kernel test robot <lkp@intel.com>
To: James Smart <jsmart2021@gmail.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Hannes Reinecke <hare@suse.de>, Daniel Wagner <dwagner@suse.de>,
	Ram Vegesna <ram.vegesna@broadcom.com>
Subject: drivers/scsi/elx/efct/efct_hw.c:227:1: warning: the frame size of
 1136 bytes is larger than 1024 bytes
Message-ID: <202408061721.gfnwpv1W-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi James,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   b446a2dae984fa5bd56dd7c3a02a426f87e05813
commit: ebc076b3eddc807729bd81f7bc48e798a3ddc477 scsi: elx: efct: Tie into kernel Kconfig and build process
date:   3 years, 2 months ago
config: arm-allmodconfig (https://download.01.org/0day-ci/archive/20240806/202408061721.gfnwpv1W-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240806/202408061721.gfnwpv1W-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408061721.gfnwpv1W-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/scsi/elx/efct/efct_hw.c: In function 'efct_hw_cb_link':
>> drivers/scsi/elx/efct/efct_hw.c:227:1: warning: the frame size of 1136 bytes is larger than 1024 bytes [-Wframe-larger-than=]
     227 | }
         | ^


vim +227 drivers/scsi/elx/efct/efct_hw.c

4df84e8466242d James Smart 2021-06-01  162  
4df84e8466242d James Smart 2021-06-01  163  static int
4df84e8466242d James Smart 2021-06-01  164  efct_hw_cb_link(void *ctx, void *e)
4df84e8466242d James Smart 2021-06-01  165  {
4df84e8466242d James Smart 2021-06-01  166  	struct efct_hw *hw = ctx;
4df84e8466242d James Smart 2021-06-01  167  	struct sli4_link_event *event = e;
4df84e8466242d James Smart 2021-06-01  168  	struct efc_domain *d = NULL;
4df84e8466242d James Smart 2021-06-01  169  	int rc = 0;
4df84e8466242d James Smart 2021-06-01  170  	struct efct *efct = hw->os;
4df84e8466242d James Smart 2021-06-01  171  
4df84e8466242d James Smart 2021-06-01  172  	efct_hw_link_event_init(hw);
4df84e8466242d James Smart 2021-06-01  173  
4df84e8466242d James Smart 2021-06-01  174  	switch (event->status) {
4df84e8466242d James Smart 2021-06-01  175  	case SLI4_LINK_STATUS_UP:
4df84e8466242d James Smart 2021-06-01  176  
4df84e8466242d James Smart 2021-06-01  177  		hw->link = *event;
4df84e8466242d James Smart 2021-06-01  178  		efct->efcport->link_status = EFC_LINK_STATUS_UP;
4df84e8466242d James Smart 2021-06-01  179  
4df84e8466242d James Smart 2021-06-01  180  		if (event->topology == SLI4_LINK_TOPO_NON_FC_AL) {
4df84e8466242d James Smart 2021-06-01  181  			struct efc_domain_record drec = {0};
4df84e8466242d James Smart 2021-06-01  182  
4df84e8466242d James Smart 2021-06-01  183  			efc_log_info(hw->os, "Link Up, NPORT, speed is %d\n",
4df84e8466242d James Smart 2021-06-01  184  				     event->speed);
4df84e8466242d James Smart 2021-06-01  185  			drec.speed = event->speed;
4df84e8466242d James Smart 2021-06-01  186  			drec.fc_id = event->fc_id;
4df84e8466242d James Smart 2021-06-01  187  			drec.is_nport = true;
4df84e8466242d James Smart 2021-06-01  188  			efc_domain_cb(efct->efcport, EFC_HW_DOMAIN_FOUND,
4df84e8466242d James Smart 2021-06-01  189  				      &drec);
4df84e8466242d James Smart 2021-06-01  190  		} else if (event->topology == SLI4_LINK_TOPO_FC_AL) {
4df84e8466242d James Smart 2021-06-01  191  			u8 buf[SLI4_BMBX_SIZE];
4df84e8466242d James Smart 2021-06-01  192  
4df84e8466242d James Smart 2021-06-01  193  			efc_log_info(hw->os, "Link Up, LOOP, speed is %d\n",
4df84e8466242d James Smart 2021-06-01  194  				     event->speed);
4df84e8466242d James Smart 2021-06-01  195  
4df84e8466242d James Smart 2021-06-01  196  			if (!sli_cmd_read_topology(&hw->sli, buf,
4df84e8466242d James Smart 2021-06-01  197  						   &hw->loop_map)) {
4df84e8466242d James Smart 2021-06-01  198  				rc = efct_hw_command(hw, buf, EFCT_CMD_NOWAIT,
4df84e8466242d James Smart 2021-06-01  199  						__efct_read_topology_cb, NULL);
4df84e8466242d James Smart 2021-06-01  200  			}
4df84e8466242d James Smart 2021-06-01  201  
4df84e8466242d James Smart 2021-06-01  202  			if (rc)
4df84e8466242d James Smart 2021-06-01  203  				efc_log_debug(hw->os, "READ_TOPOLOGY failed\n");
4df84e8466242d James Smart 2021-06-01  204  		} else {
4df84e8466242d James Smart 2021-06-01  205  			efc_log_info(hw->os, "%s(%#x), speed is %d\n",
4df84e8466242d James Smart 2021-06-01  206  				     "Link Up, unsupported topology ",
4df84e8466242d James Smart 2021-06-01  207  				     event->topology, event->speed);
4df84e8466242d James Smart 2021-06-01  208  		}
4df84e8466242d James Smart 2021-06-01  209  		break;
4df84e8466242d James Smart 2021-06-01  210  	case SLI4_LINK_STATUS_DOWN:
4df84e8466242d James Smart 2021-06-01  211  		efc_log_info(hw->os, "Link down\n");
4df84e8466242d James Smart 2021-06-01  212  
4df84e8466242d James Smart 2021-06-01  213  		hw->link.status = event->status;
4df84e8466242d James Smart 2021-06-01  214  		efct->efcport->link_status = EFC_LINK_STATUS_DOWN;
4df84e8466242d James Smart 2021-06-01  215  
4df84e8466242d James Smart 2021-06-01  216  		d = efct->efcport->domain;
4df84e8466242d James Smart 2021-06-01  217  		if (d)
4df84e8466242d James Smart 2021-06-01  218  			efc_domain_cb(efct->efcport, EFC_HW_DOMAIN_LOST, d);
4df84e8466242d James Smart 2021-06-01  219  		break;
4df84e8466242d James Smart 2021-06-01  220  	default:
4df84e8466242d James Smart 2021-06-01  221  		efc_log_debug(hw->os, "unhandled link status %#x\n",
4df84e8466242d James Smart 2021-06-01  222  			      event->status);
4df84e8466242d James Smart 2021-06-01  223  		break;
4df84e8466242d James Smart 2021-06-01  224  	}
4df84e8466242d James Smart 2021-06-01  225  
4df84e8466242d James Smart 2021-06-01  226  	return 0;
4df84e8466242d James Smart 2021-06-01 @227  }
4df84e8466242d James Smart 2021-06-01  228  

:::::: The code at line 227 was first introduced by commit
:::::: 4df84e8466242de835416a4ec0c856c0e2ed26eb scsi: elx: efct: Driver initialization routines

:::::: TO: James Smart <jsmart2021@gmail.com>
:::::: CC: Martin K. Petersen <martin.petersen@oracle.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

