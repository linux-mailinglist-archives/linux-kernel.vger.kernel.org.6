Return-Path: <linux-kernel+bounces-226442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7538B913E65
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 23:07:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F2BB9B20DE8
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 21:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE77F1849CB;
	Sun, 23 Jun 2024 21:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ABfvm7S7"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEB3618307B
	for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 21:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719176811; cv=none; b=ePnsMOlUBmcDx6U+T5PQ7URXolCYZPYe5wzdk232ngVH1kr/Lbg4ibaVVZyNDPjvS2e140spSYHRx3raLqi6DN18iL4DDmYyweGuilUNfJjhF2kdX6zlJzrIcaW6JmV0sPf19oTtOK/7bRNeAQP4KoWAoXgMMJOcXXANcpDR+0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719176811; c=relaxed/simple;
	bh=zkWfU5ShTF7TTS1/GdxKjQaMhJInTaMm8BoK2bAwSac=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=K0cZ8cBO6GoPOnEIdWo7+64yGXK+PBvaY7/N7VMzQb4G3eRr4woftFuJpsX8aBnK+q8qxPghggFtCHM9r+TBMp70HVUvB2mJR1PKccA2Ki5NtlooDFNuPN8AbWU2hghy4EOGKKCFTUZhxpaD6asf4dwq9ZNhLxNswpvHheQpCIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ABfvm7S7; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719176809; x=1750712809;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=zkWfU5ShTF7TTS1/GdxKjQaMhJInTaMm8BoK2bAwSac=;
  b=ABfvm7S7UE5i9HXrzEf6y/zcYxCqTs0fLU4RO4EenmvtW7ECSGSx3t1D
   bJjf6jm85dANyWa0NB01PdXeI6p5rxDW097zjP67FMHvQ08bYIWv64/Ue
   ES+52JkwBnyrTMaWbnXFS9Ya/QabPICUWQ9BKebeDIDXWDE9888XdugEl
   BGKsI9ZmGeJabz+CjoZBO6qb4Zdl9yL43hWWIZbhr0+LYWmy0WH706g10
   VX937yiZbmTVFnwUiR3aeL6BlOqOXNwUPHCDWqiOZ9ePO7L6599fYIpWC
   IP/tNsVEMeZy/dOZ9f9FR6C18zadoxxjlmdYlIkwtmbSdRRtwHq03WPxe
   w==;
X-CSE-ConnectionGUID: cG77OdBuSQOkgpJHUscJzw==
X-CSE-MsgGUID: d6J2yeihRhKaAGtuiHvNgg==
X-IronPort-AV: E=McAfee;i="6700,10204,11112"; a="16283424"
X-IronPort-AV: E=Sophos;i="6.08,260,1712646000"; 
   d="scan'208";a="16283424"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2024 14:06:49 -0700
X-CSE-ConnectionGUID: J1Zj2R8DS4qj4qwvm2M8zw==
X-CSE-MsgGUID: JnoaMiTiRuS3w6jpJ7Jmxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,260,1712646000"; 
   d="scan'208";a="48030100"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 23 Jun 2024 14:06:47 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sLUQ8-000BRs-2X;
	Sun, 23 Jun 2024 21:06:44 +0000
Date: Mon, 24 Jun 2024 05:06:09 +0800
From: kernel test robot <lkp@intel.com>
To: Tianyang Zhang <zhangtianyang@loongson.cn>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Jianmin Lv <lvjianmin@loongson.cn>,
	Liupu Wang <wangliupu@loongson.cn>
Subject: [tip:irq/core 39/46] drivers/irqchip/irq-loongarch-avec.c:82:17:
 error: implicit declaration of function 'loongson_send_ipi_single'
Message-ID: <202406240451.ygBFNyJ3-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq/core
head:   c9d269469d2b9a06559cdc84d12dd3fb4d552581
commit: 760d7e719499d64beea62bfcf53938fb233bb6e7 [39/46] Loongarch: Support loongarch avec
config: loongarch-allnoconfig (https://download.01.org/0day-ci/archive/20240624/202406240451.ygBFNyJ3-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240624/202406240451.ygBFNyJ3-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406240451.ygBFNyJ3-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/irqchip/irq-loongarch-avec.c: In function 'loongarch_avec_sync':
>> drivers/irqchip/irq-loongarch-avec.c:82:17: error: implicit declaration of function 'loongson_send_ipi_single' [-Werror=implicit-function-declaration]
      82 |                 loongson_send_ipi_single(adata->prev_cpu, SMP_CLEAR_VECT);
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/irqchip/irq-loongarch-avec.c:82:59: error: 'SMP_CLEAR_VECT' undeclared (first use in this function)
      82 |                 loongson_send_ipi_single(adata->prev_cpu, SMP_CLEAR_VECT);
         |                                                           ^~~~~~~~~~~~~~
   drivers/irqchip/irq-loongarch-avec.c:82:59: note: each undeclared identifier is reported only once for each function it appears in
   drivers/irqchip/irq-loongarch-avec.c: In function 'complete_irq_moving':
   drivers/irqchip/irq-loongarch-avec.c:173:55: error: 'SMP_CLEAR_VECT' undeclared (first use in this function)
     173 |                         loongson_send_ipi_single(cpu, SMP_CLEAR_VECT);
         |                                                       ^~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/loongson_send_ipi_single +82 drivers/irqchip/irq-loongarch-avec.c

    73	
    74	static void loongarch_avec_sync(struct loongarch_avec_data *adata)
    75	{
    76		struct pending_list *plist;
    77	
    78		if (cpu_online(adata->prev_cpu)) {
    79			plist = per_cpu_ptr(&pending_list, adata->prev_cpu);
    80			list_add_tail(&adata->entry, &plist->head);
    81			adata->moving = true;
  > 82			loongson_send_ipi_single(adata->prev_cpu, SMP_CLEAR_VECT);
    83		}
    84		adata->prev_cpu = adata->cpu;
    85		adata->prev_vec = adata->vec;
    86	}
    87	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

