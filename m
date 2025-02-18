Return-Path: <linux-kernel+bounces-519370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 52BF9A39C27
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 13:30:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC0F01891482
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 12:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F09A3241CA0;
	Tue, 18 Feb 2025 12:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ma4iZaxt"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1FB3241C81
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 12:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739881765; cv=none; b=QyiUhY4km6hNqEody+FDRPUX+Kx+GNZmeWelSVE0Jvm7HyqH3oVdk9JE2RxdLGEVL7K+NYTeanXioPAuRK1s23zMsurQxhP7sZdgG2SKS7ECA8vp4jgFJ32GbqAG9PkbKG7050CW/BFX/JcXmkYZwSZNuuDLpqxUMTT9MZOo/3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739881765; c=relaxed/simple;
	bh=hGsv2vXpRwUZZLZ2yGnB9ShAh5sU8nupXyL8jAVDq94=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=d/BIRA7aR3d5jg9C8tXVG+WB5yyAPpoqAbyJzRyVdv+4C65txG8AC6hcZQvCWFMP69/StWfbT1FUQ/fWNncIhIPdKwVKl7t2UDFrvVUkalZOECK1r4+PeLSZuqG8ERCD96r+R/3mc/Dmfx4EXoLr35jL77ToCgM/4lCi521gaiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ma4iZaxt; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739881763; x=1771417763;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=hGsv2vXpRwUZZLZ2yGnB9ShAh5sU8nupXyL8jAVDq94=;
  b=Ma4iZaxt5MIHI5RDcE7fwOlJib0gKsVDql3YRnJ7yu6JDdXIoTAXHirA
   wPFXkiaPFy42YbITX7shOBPWbszyINAtMEw2xPHz3QeShKrjnNslEE/L2
   ytYPOs34Z90HXIBY6Q7/cqwaxGIlIKp4e6K3S5SI+JCktwF2Tl/4g7pcQ
   hL3pcPy1jMRza0nWhRSCL+ZSBo1L5loKjPJodg1l5/LFHFmyyRBfbRtTy
   4HTpMFaPrMw681QllszxNXu7xaPDl5q/GnJLpxWvwjRIfi2O+8fwIm3U/
   eUCqoJi+fqPh7n+98fY37JHE5RKGtUvN8XWNDMpnAkJEBFu+4U7afufcJ
   Q==;
X-CSE-ConnectionGUID: h8tvshdMQCKDdwuWaVRDPQ==
X-CSE-MsgGUID: tt8en4fZQ1Ke055VYpN8xQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="40278229"
X-IronPort-AV: E=Sophos;i="6.13,296,1732608000"; 
   d="scan'208";a="40278229"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2025 04:29:23 -0800
X-CSE-ConnectionGUID: WGcp88rXTXqAI0O9YPevSw==
X-CSE-MsgGUID: lZDkfhpJR5eBU+5Ls2x/yw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,296,1732608000"; 
   d="scan'208";a="114305486"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by orviesa006.jf.intel.com with ESMTP; 18 Feb 2025 04:29:22 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tkMiw-0000Vh-06;
	Tue, 18 Feb 2025 12:29:15 +0000
Date: Tue, 18 Feb 2025 20:28:37 +0800
From: kernel test robot <lkp@intel.com>
To: James Smart <jsmart2021@gmail.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Hannes Reinecke <hare@suse.de>, Daniel Wagner <dwagner@suse.de>,
	Ram Vegesna <ram.vegesna@broadcom.com>
Subject: drivers/scsi/elx/libefc/efc_node.c:254:70: warning: '%s' directive
 output may be truncated writing up to 15 bytes into a region of size between
 0 and 31
Message-ID: <202502182036.RChzXKS8-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   2408a807bfc3f738850ef5ad5e3fd59d66168996
commit: ebc076b3eddc807729bd81f7bc48e798a3ddc477 scsi: elx: efct: Tie into kernel Kconfig and build process
date:   3 years, 8 months ago
config: x86_64-randconfig-001-20241126 (https://download.01.org/0day-ci/archive/20250218/202502182036.RChzXKS8-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250218/202502182036.RChzXKS8-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502182036.RChzXKS8-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/scsi/elx/libefc/efc_node.c: In function 'efc_node_alloc':
>> drivers/scsi/elx/libefc/efc_node.c:254:70: warning: '%s' directive output may be truncated writing up to 15 bytes into a region of size between 0 and 31 [-Wformat-truncation=]
     254 |         snprintf(node->display_name, sizeof(node->display_name), "%s.%s",
         |                                                                      ^~
     255 |                  nport->display_name, portid_display);
         |                                       ~~~~~~~~~~~~~~                  
   In function 'efc_node_update_display_name',
       inlined from 'efc_node_alloc' at drivers/scsi/elx/libefc/efc_node.c:95:2:
   drivers/scsi/elx/libefc/efc_node.c:254:9: note: 'snprintf' output between 2 and 48 bytes into a destination of size 32
     254 |         snprintf(node->display_name, sizeof(node->display_name), "%s.%s",
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     255 |                  nport->display_name, portid_display);
         |                  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/scsi/elx/libefc/efc_node.c: In function 'efc_node_update_display_name':
>> drivers/scsi/elx/libefc/efc_node.c:254:70: warning: '%s' directive output may be truncated writing up to 15 bytes into a region of size between 0 and 31 [-Wformat-truncation=]
     254 |         snprintf(node->display_name, sizeof(node->display_name), "%s.%s",
         |                                                                      ^~
     255 |                  nport->display_name, portid_display);
         |                                       ~~~~~~~~~~~~~~                  
   drivers/scsi/elx/libefc/efc_node.c:254:9: note: 'snprintf' output between 2 and 48 bytes into a destination of size 32
     254 |         snprintf(node->display_name, sizeof(node->display_name), "%s.%s",
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     255 |                  nport->display_name, portid_display);
         |                  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +254 drivers/scsi/elx/libefc/efc_node.c

6bc6180d7b5c97 James Smart 2021-06-01  244  
6bc6180d7b5c97 James Smart 2021-06-01  245  void
6bc6180d7b5c97 James Smart 2021-06-01  246  efc_node_update_display_name(struct efc_node *node)
6bc6180d7b5c97 James Smart 2021-06-01  247  {
6bc6180d7b5c97 James Smart 2021-06-01  248  	u32 port_id = node->rnode.fc_id;
6bc6180d7b5c97 James Smart 2021-06-01  249  	struct efc_nport *nport = node->nport;
6bc6180d7b5c97 James Smart 2021-06-01  250  	char portid_display[16];
6bc6180d7b5c97 James Smart 2021-06-01  251  
6bc6180d7b5c97 James Smart 2021-06-01  252  	efc_node_fcid_display(port_id, portid_display, sizeof(portid_display));
6bc6180d7b5c97 James Smart 2021-06-01  253  
6bc6180d7b5c97 James Smart 2021-06-01 @254  	snprintf(node->display_name, sizeof(node->display_name), "%s.%s",
6bc6180d7b5c97 James Smart 2021-06-01  255  		 nport->display_name, portid_display);
6bc6180d7b5c97 James Smart 2021-06-01  256  }
6bc6180d7b5c97 James Smart 2021-06-01  257  

:::::: The code at line 254 was first introduced by commit
:::::: 6bc6180d7b5c972c10a2f5392621921de32ce5bc scsi: elx: libefc: Remote node state machine interfaces

:::::: TO: James Smart <jsmart2021@gmail.com>
:::::: CC: Martin K. Petersen <martin.petersen@oracle.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

