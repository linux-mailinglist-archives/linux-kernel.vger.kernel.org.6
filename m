Return-Path: <linux-kernel+bounces-516361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 787BFA37025
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 19:30:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D98C1893226
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 18:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 149551EA7C3;
	Sat, 15 Feb 2025 18:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CSUe4LYm"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE4D1ACECC
	for <linux-kernel@vger.kernel.org>; Sat, 15 Feb 2025 18:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739644221; cv=none; b=Cz/k/wKgwFQDZkdF73roQl+aopCSnt0KfLyexTJPhIGTKV784gu+dZ+x7hX49eAoKolfsLvuN10qHGmSFk/wKejJyDDjzd+Xg24e710axQ7FSPhkBQX8t4JB1G6oDlkN2KWnMEDANqJ2pC3e3ciKWlF6zGcxoeCHauNUhiI2CcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739644221; c=relaxed/simple;
	bh=dMn1Q4aA9MGi5d/1Z9iwwNyIqYg63IgAYhGVKa2FIXU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Y5T/69BfDqeR9Ci9wJSYyCrQmgBvPIdWFaYQ9jvyzVYwu5bDfVqBL4LJxDNanDcohV4NT5DaEWmtacZg8bTT4hPGzfLha16AO4fPpPCxaOrCevyGA8HKiEsgVU9jTXmFrymp3nIrUX7Uzls9awqikBSkMaELjU8uu2ODbOroMMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CSUe4LYm; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739644220; x=1771180220;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=dMn1Q4aA9MGi5d/1Z9iwwNyIqYg63IgAYhGVKa2FIXU=;
  b=CSUe4LYmnaeYj0q6X8s/K9fPM4XhFmgumIqxyHIqaGQA1H1qLW6nC7SM
   yrAVPoeZ6SwJq2jH9WTVBQjVcwoFJRlBjk1jOtOfOM/L8dRVviCbH/BOh
   bfAIGX+3Fw+xAsTuWLC64j9UE+b2Akg3+TCMsVHN2CmrkfEJ5ZDwRvky8
   7eO0icUmO4AwaR/1GkrYAam30yNoxfPBPtXBb0gaTQYlrdku9gqFsfbln
   +BPKSCyIVn9XnQvK0uRclNrB2pnXpmp92/BWRD+rcitG5DVraKCMM3CnJ
   u1nRy01gzF7cbo7K713XQYHRaUxBP1Xkko8I89n+e07DtoixOJgsFpU6w
   Q==;
X-CSE-ConnectionGUID: hijVqHmKQ3CFBeeu4WU4YQ==
X-CSE-MsgGUID: tIkdJHymSa2Tzi2dr7PaXw==
X-IronPort-AV: E=McAfee;i="6700,10204,11346"; a="51355391"
X-IronPort-AV: E=Sophos;i="6.13,289,1732608000"; 
   d="scan'208";a="51355391"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2025 10:30:19 -0800
X-CSE-ConnectionGUID: oh3mlhyLRUOQSRwO++DR0w==
X-CSE-MsgGUID: gT8rgUL9ScmFbmRjcR+rLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,289,1732608000"; 
   d="scan'208";a="113696699"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 15 Feb 2025 10:30:18 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tjMvf-001B4t-06;
	Sat, 15 Feb 2025 18:30:15 +0000
Date: Sun, 16 Feb 2025 02:29:31 +0800
From: kernel test robot <lkp@intel.com>
To: Lizhi Hou <lizhi.hou@amd.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Jeffrey Hugo <quic_jhugo@quicinc.com>,
	George Yang <George.Yang@amd.com>, Min Ma <min.ma@amd.com>
Subject: drivers/accel/amdxdna/amdxdna_mailbox.c:203:9: error: implicit
 declaration of function 'kfree'
Message-ID: <202502160209.WZSMNh1N-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   6452feaf29a6a1cc1c904520c4b1b4cd90133fac
commit: b87f920b934426a24d54613f12ed67c03ae05024 accel/amdxdna: Support hardware mailbox
date:   3 months ago
config: x86_64-buildonly-randconfig-002-20250216 (https://download.01.org/0day-ci/archive/20250216/202502160209.WZSMNh1N-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250216/202502160209.WZSMNh1N-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502160209.WZSMNh1N-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   drivers/accel/amdxdna/amdxdna_mailbox.c: In function 'mailbox_release_msg':
>> drivers/accel/amdxdna/amdxdna_mailbox.c:203:9: error: implicit declaration of function 'kfree' [-Werror=implicit-function-declaration]
     203 |         kfree(mb_msg);
         |         ^~~~~
   drivers/accel/amdxdna/amdxdna_mailbox.c: At top level:
   drivers/accel/amdxdna/amdxdna_mailbox.c:357:8: error: unknown type name 'irqreturn_t'
     357 | static irqreturn_t mailbox_irq_handler(int irq, void *p)
         |        ^~~~~~~~~~~
   drivers/accel/amdxdna/amdxdna_mailbox.c: In function 'mailbox_irq_handler':
   drivers/accel/amdxdna/amdxdna_mailbox.c:367:16: error: 'IRQ_HANDLED' undeclared (first use in this function)
     367 |         return IRQ_HANDLED;
         |                ^~~~~~~~~~~
   drivers/accel/amdxdna/amdxdna_mailbox.c:367:16: note: each undeclared identifier is reported only once for each function it appears in
   drivers/accel/amdxdna/amdxdna_mailbox.c: In function 'mailbox_rx_worker':
   drivers/accel/amdxdna/amdxdna_mailbox.c:395:25: error: implicit declaration of function 'disable_irq'; did you mean 'disable_work'? [-Werror=implicit-function-declaration]
     395 |                         disable_irq(mb_chann->msix_irq);
         |                         ^~~~~~~~~~~
         |                         disable_work
   drivers/accel/amdxdna/amdxdna_mailbox.c: In function 'xdna_mailbox_send_msg':
>> drivers/accel/amdxdna/amdxdna_mailbox.c:431:18: error: implicit declaration of function 'kzalloc' [-Werror=implicit-function-declaration]
     431 |         mb_msg = kzalloc(sizeof(*mb_msg) + pkg_size, GFP_KERNEL);
         |                  ^~~~~~~
>> drivers/accel/amdxdna/amdxdna_mailbox.c:431:16: warning: assignment to 'struct mailbox_msg *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     431 |         mb_msg = kzalloc(sizeof(*mb_msg) + pkg_size, GFP_KERNEL);
         |                ^
   drivers/accel/amdxdna/amdxdna_mailbox.c: In function 'xdna_mailbox_create_channel':
>> drivers/accel/amdxdna/amdxdna_mailbox.c:490:18: warning: assignment to 'struct mailbox_channel *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     490 |         mb_chann = kzalloc(sizeof(*mb_chann), GFP_KERNEL);
         |                  ^
   drivers/accel/amdxdna/amdxdna_mailbox.c:513:15: error: implicit declaration of function 'request_irq'; did you mean 'request_region'? [-Werror=implicit-function-declaration]
     513 |         ret = request_irq(mb_irq, mailbox_irq_handler, 0, MAILBOX_NAME, mb_chann);
         |               ^~~~~~~~~~~
         |               request_region
   drivers/accel/amdxdna/amdxdna_mailbox.c: In function 'xdna_mailbox_destroy_channel':
   drivers/accel/amdxdna/amdxdna_mailbox.c:537:9: error: implicit declaration of function 'free_irq' [-Werror=implicit-function-declaration]
     537 |         free_irq(mb_chann->msix_irq, mb_chann);
         |         ^~~~~~~~
   drivers/accel/amdxdna/amdxdna_mailbox.c: In function 'mailbox_irq_handler':
   drivers/accel/amdxdna/amdxdna_mailbox.c:368:1: warning: control reaches end of non-void function [-Wreturn-type]
     368 | }
         | ^
   cc1: some warnings being treated as errors


vim +/kfree +203 drivers/accel/amdxdna/amdxdna_mailbox.c

   194	
   195	static int mailbox_release_msg(int id, void *p, void *data)
   196	{
   197		struct mailbox_channel *mb_chann = data;
   198		struct mailbox_msg *mb_msg = p;
   199	
   200		MB_DBG(mb_chann, "msg_id 0x%x msg opcode 0x%x",
   201		       mb_msg->pkg.header.id, mb_msg->pkg.header.opcode);
   202		mb_msg->notify_cb(mb_msg->handle, NULL, 0);
 > 203		kfree(mb_msg);
   204	
   205		return 0;
   206	}
   207	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

