Return-Path: <linux-kernel+bounces-395653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3DF89BC119
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 23:52:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69EB91F22B95
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 22:52:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4C4F1FDF8E;
	Mon,  4 Nov 2024 22:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TFTqDWAU"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E5301D3195
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 22:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730760770; cv=none; b=NxO/+8cdKYaMSSYadjmitxcjdZKi4fTS/AffGNCwZFNlob+jN2CsmuxoV6+ecgA+3YEMVUlhYuAAYZ39DndG720opJK0Aw+gLJN3rJCwH2Uq7bx9LsXvGq+LSMpo2sZn+7Jvl8GFFmzWSzIvxiN8N/09CkTMU251Zam3Kw67Q/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730760770; c=relaxed/simple;
	bh=4Xxcdy9RsMXY3k6ogxRdk2F4PuNdg0p7ZtEBYXk/L2c=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=N9P7m3k3woVKL78Zki+PAm5oHhazhJMw3ejkjCPKXaKqmf3OCjOPgHe7p4H4psyZUGqQPQT7NdP8OcE5ZwZE3ONdX+ZGwsy6silmDJ1eMAsAXW03gH4ztMcDGY23ax5ogQud+PxeO196/OGdsRGRxGFVSQLHMDxnYR17stpo52k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TFTqDWAU; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730760768; x=1762296768;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=4Xxcdy9RsMXY3k6ogxRdk2F4PuNdg0p7ZtEBYXk/L2c=;
  b=TFTqDWAUpcgy/4llScO/O6YLc1/IAxas8kTN1yUPf8skfdBMfLNNUod7
   ps6PfGueHqwjeVAG9ZYJ27vQC4FXXH9MU2RIYT8L6J9fs/wjmCAR6s5sJ
   qtpwstsM2mKfDL4oQfY40S/wA1zjg71GWSLEDwpgkdLsJs6qkE2fYPa6p
   r7UTl95kR9l0hBaCuPxyp7Hr/vTGycUJZnbqvDb/MHiOxzbrLklS85jLH
   rOub2drQQ89eNwAbXV3sjPshxP6REJwXQ2btwuJYluZOlBQfQHhwwjlsD
   jznPrUDPJP7Jua01m/trQPRzyzcnXxb+Qe5TOpKHGlNLZFjWM5PgLRlZc
   A==;
X-CSE-ConnectionGUID: Yida5bkZTI29ZgkDdw2PbQ==
X-CSE-MsgGUID: ED1zwnBGTgGKcPhvaM+3Pw==
X-IronPort-AV: E=McAfee;i="6700,10204,11246"; a="30592969"
X-IronPort-AV: E=Sophos;i="6.11,258,1725346800"; 
   d="scan'208";a="30592969"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2024 14:52:47 -0800
X-CSE-ConnectionGUID: EY1W2CP9RUaq4vauOyr44A==
X-CSE-MsgGUID: zZLWVCPDQ2SRVeilPTDwGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,258,1725346800"; 
   d="scan'208";a="83912976"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 04 Nov 2024 14:52:45 -0800
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t85wA-000lMj-1W;
	Mon, 04 Nov 2024 22:52:42 +0000
Date: Tue, 5 Nov 2024 06:52:25 +0800
From: kernel test robot <lkp@intel.com>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Hannes Reinecke <hare@suse.de>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Bart Van Assche <bvanassche@acm.org>
Subject: block/blk-zoned.c:579:5-24: WARNING: atomic_dec_and_test variation
 before object free at line 583.
Message-ID: <202411050650.ilIZa8S7-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   557329bcecc2f55e134db8974953b32b69db9d15
commit: dd291d77cc90eb6a86e9860ba8e6e38eebd57d12 block: Introduce zone write plugging
date:   7 months ago
config: alpha-randconfig-r064-20241105 (https://download.01.org/0day-ci/archive/20241105/202411050650.ilIZa8S7-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 13.3.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411050650.ilIZa8S7-lkp@intel.com/

cocci warnings: (new ones prefixed by >>)
>> block/blk-zoned.c:579:5-24: WARNING: atomic_dec_and_test variation before object free at line 583.

vim +579 block/blk-zoned.c

   576	
   577	static inline void disk_put_zone_wplug(struct blk_zone_wplug *zwplug)
   578	{
 > 579		if (atomic_dec_and_test(&zwplug->ref)) {
   580			WARN_ON_ONCE(!bio_list_empty(&zwplug->bio_list));
   581			WARN_ON_ONCE(!list_empty(&zwplug->link));
   582	
 > 583			call_rcu(&zwplug->rcu_head, disk_free_zone_wplug_rcu);
   584		}
   585	}
   586	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

