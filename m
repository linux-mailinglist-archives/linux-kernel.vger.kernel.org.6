Return-Path: <linux-kernel+bounces-426113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 762EC9DEF27
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 07:31:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A7D32818CC
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 06:31:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93C4613E3F5;
	Sat, 30 Nov 2024 06:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Pp78LVYv"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E362D29B0
	for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 06:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732948300; cv=none; b=ZsX9gwSouuzlztGbVpIJ49tTxsRh/K/dHkaMilHE+tw6dMRSLJrWsTtm9aSGQ1mQRRv0IZACt2WLhOiYNMpQnWHfteGnxAgVhhOxZT0Oc8tKXNps9XQj31ZWYIfeRIKOKF34iY6ibau7dh7aWLyCaE2XsbJvQInON7czcOGGr4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732948300; c=relaxed/simple;
	bh=7sV9A8Q4a7fuBUggpipeqhTSHFLT/RBGrZWGScbAJ7M=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=m4z2Apw0pt59o5SJvB1BeA+NVs4FHDiyTBSwJKXRUcC9KC+VhwAiBCj5O+ft5JMywdh+T4zoM017+6WQ/aAIuwCfdMUscf9KyRSHnkVlpjWY39Wqzjw2+sv9k9dtVJvoKTFCBxnNwV7oQqXv0JBa1w3dai7viRWMgJqWvv6HfeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Pp78LVYv; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732948298; x=1764484298;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=7sV9A8Q4a7fuBUggpipeqhTSHFLT/RBGrZWGScbAJ7M=;
  b=Pp78LVYvtxkazQ5/AkjLur/n34nyz2SDGsgjH2TTs7zKvV7N//J1KU6v
   bWnQGK7JLexq89lGhFTLDdgNf4m8gyQSLukrd332SMENocjch1fmAq4xT
   GpnkCHVpgEr6c3rTrdUPzg7Eb6DDT3Zw/q9dSZvigTeMv9UtTCG+HoxqA
   j1Mv9a5M14+IJIxEHlToQmDFJh2JRFVprtvBqtJFmAUQ9+Ix9htd0w4sU
   qLOVp+VE2rFl9OWz4PoEXau60tEVnPO++/fWIhUOiELJzXx6wGsNe/y1R
   VFAWJmP/hPY7P+jvo4D2WTNfFV3Ei3JKGP3Q5mnHGzIRIdvs9sTRsfkYG
   w==;
X-CSE-ConnectionGUID: diybJHLXRc+Q/OtkNygFTg==
X-CSE-MsgGUID: 0t7IwA9EQe6ib2G1o1cHiA==
X-IronPort-AV: E=McAfee;i="6700,10204,11271"; a="44551779"
X-IronPort-AV: E=Sophos;i="6.12,197,1728975600"; 
   d="scan'208";a="44551779"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2024 22:31:37 -0800
X-CSE-ConnectionGUID: sOdusK3ZSIq3O0r4D18Cyw==
X-CSE-MsgGUID: tQHgUqswR9uY4wlN7cMTDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,197,1728975600"; 
   d="scan'208";a="115911818"
Received: from lkp-server02.sh.intel.com (HELO 36a1563c48ff) ([10.239.97.151])
  by fmviesa002.fm.intel.com with ESMTP; 29 Nov 2024 22:31:35 -0800
Received: from kbuild by 36a1563c48ff with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tHH0u-00008l-2w;
	Sat, 30 Nov 2024 06:31:32 +0000
Date: Sat, 30 Nov 2024 14:31:29 +0800
From: kernel test robot <lkp@intel.com>
To: Guixin Liu <kanie@linux.alibaba.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Keith Busch <kbusch@kernel.org>,
	Dmitry Bogdanov <d.bogdanov@yadro.com>,
	Christoph Hellwig <hch@lst.de>, Chaitanya Kulkarni <kch@nvidia.com>
Subject: drivers/nvme/target/pr.c:831:8-15: WARNING: kzalloc should be used
 for data, instead of kmalloc/memset
Message-ID: <202411301434.LEckbcWx-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   2ba9f676d0a2e408aef14d679984c26373bf37b7
commit: 5a47c2080a7316f184107464e4f76737c0c05186 nvmet: support reservation feature
date:   3 weeks ago
config: hexagon-randconfig-r051-20241130 (https://download.01.org/0day-ci/archive/20241130/202411301434.LEckbcWx-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 592c0fe55f6d9a811028b5f3507be91458ab2713)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411301434.LEckbcWx-lkp@intel.com/

cocci warnings: (new ones prefixed by >>)
>> drivers/nvme/target/pr.c:831:8-15: WARNING: kzalloc should be used for data, instead of kmalloc/memset

vim +831 drivers/nvme/target/pr.c

   802	
   803	static void nvmet_execute_pr_report(struct nvmet_req *req)
   804	{
   805		u32 cdw11 = le32_to_cpu(req->cmd->common.cdw11);
   806		u32 cdw10 = le32_to_cpu(req->cmd->common.cdw10);
   807		u32 num_bytes = 4 * (cdw10 + 1); /* cdw10 is number of dwords */
   808		u8 eds = cdw11 & 1; /* Extended data structure, bit 00 */
   809		struct nvme_registered_ctrl_ext *ctrl_eds;
   810		struct nvme_reservation_status_ext *data;
   811		struct nvmet_pr *pr = &req->ns->pr;
   812		struct nvmet_pr_registrant *holder;
   813		struct nvmet_pr_registrant *reg;
   814		u16 num_ctrls = 0;
   815		u16 status;
   816		u8 rtype;
   817	
   818		/* nvmet hostid(uuid_t) is 128 bit. */
   819		if (!eds) {
   820			req->error_loc = offsetof(struct nvme_common_command, cdw11);
   821			status = NVME_SC_HOST_ID_INCONSIST | NVME_STATUS_DNR;
   822			goto out;
   823		}
   824	
   825		if (num_bytes < sizeof(struct nvme_reservation_status_ext)) {
   826			req->error_loc = offsetof(struct nvme_common_command, cdw10);
   827			status = NVME_SC_INVALID_FIELD | NVME_STATUS_DNR;
   828			goto out;
   829		}
   830	
 > 831		data = kmalloc(num_bytes, GFP_KERNEL);
   832		if (!data) {
   833			status = NVME_SC_INTERNAL;
   834			goto out;
   835		}
   836		memset(data, 0, num_bytes);
   837		data->gen = cpu_to_le32(atomic_read(&pr->generation));
   838		data->ptpls = 0;
   839		ctrl_eds = data->regctl_eds;
   840	
   841		rcu_read_lock();
   842		holder = rcu_dereference(pr->holder);
   843		rtype = holder ? holder->rtype : 0;
   844		data->rtype = rtype;
   845	
   846		list_for_each_entry_rcu(reg, &pr->registrant_list, entry) {
   847			num_ctrls++;
   848			/*
   849			 * continue to get the number of all registrans.
   850			 */
   851			if (((void *)ctrl_eds + sizeof(*ctrl_eds)) >
   852			    ((void *)data + num_bytes))
   853				continue;
   854			/*
   855			 * Dynamic controller, set cntlid to 0xffff.
   856			 */
   857			ctrl_eds->cntlid = cpu_to_le16(NVME_CNTLID_DYNAMIC);
   858			if (rtype == NVME_PR_WRITE_EXCLUSIVE_ALL_REGS ||
   859			    rtype == NVME_PR_EXCLUSIVE_ACCESS_ALL_REGS)
   860				ctrl_eds->rcsts = 1;
   861			if (reg == holder)
   862				ctrl_eds->rcsts = 1;
   863			uuid_copy((uuid_t *)&ctrl_eds->hostid, &reg->hostid);
   864			ctrl_eds->rkey = cpu_to_le64(reg->rkey);
   865			ctrl_eds++;
   866		}
   867		rcu_read_unlock();
   868	
   869		put_unaligned_le16(num_ctrls, data->regctl);
   870		status = nvmet_copy_to_sgl(req, 0, data, num_bytes);
   871		kfree(data);
   872	out:
   873		nvmet_req_complete(req, status);
   874	}
   875	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

