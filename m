Return-Path: <linux-kernel+bounces-189584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD6578CF26D
	for <lists+linux-kernel@lfdr.de>; Sun, 26 May 2024 04:00:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E87C11C20D1F
	for <lists+linux-kernel@lfdr.de>; Sun, 26 May 2024 02:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFD9417FD;
	Sun, 26 May 2024 02:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VxdMoxRz"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C59F622;
	Sun, 26 May 2024 02:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716688840; cv=none; b=hQ87BruC+KlCI8gpuBkTtkwtsJqvIOxkAr6QBWRH00kYCF2RasFAQPGjOmpalSD+e1kIcmYIPDulcCrBDLXwi6Mljwvisc5WFCXHpB7U1SSwc/cT7H8qnj0JAtlU8zfOLh54s+5OHCIQer5kFKjpFP/kitCcAhUtxJ7DR/4R4TQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716688840; c=relaxed/simple;
	bh=CzcVNZjWSshoEFL81VKFzrkOMmouWtgwix9NhZydeTI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L+xFf0AutU35ruOTSYrExXJCb9IMO/AIbzD3WK2YnBggeZmhG1K2xa3/XRFwOpi2D5F0+kQPrpFI5DgMf7XUrxdkwH4CH9s3vlXYE7x8hxnRdAP65x0pjjULAjnEf2A03iMOrx0jwABxE1hqavXzbX1Fi+pa8Hb2jt4DxtiNFKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VxdMoxRz; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716688838; x=1748224838;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CzcVNZjWSshoEFL81VKFzrkOMmouWtgwix9NhZydeTI=;
  b=VxdMoxRz92gshTyPJq1I4JjAYf5ezusgQWSy2PB5cFf4Wuq5Qe4ySG8R
   b06yFUm88BKzxT4xCFIXD/9ByfhAjXOxggTa7+0loXiGWRAMLL2JFTC02
   phmBPDGzcM/BvZ9e2gULNQ1r5vtqtPVVIDiSPbV03iDdI0j+BQKiSTQF+
   hlukmo4evdHcpXTbkm96xp9LTuumO44/+4m3aTyK6pnfQwT5DwijECGcj
   IUQ3a0avL4cdSPK0t4nKgpWVHurAhu/rx+GKM3DyWa5ABIxV/7X02IrtG
   vDA3f8ljX/NppGuuJD5oPNP4tc6BF24ImfIEQ4jg6oPWkMkx/IUzga6b1
   g==;
X-CSE-ConnectionGUID: lxaRk+Q2QvKxq0zoGNsnaw==
X-CSE-MsgGUID: 35Pe1xyMQ0mMB1174gT7Vw==
X-IronPort-AV: E=McAfee;i="6600,9927,11083"; a="23633382"
X-IronPort-AV: E=Sophos;i="6.08,189,1712646000"; 
   d="scan'208";a="23633382"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2024 19:00:37 -0700
X-CSE-ConnectionGUID: 8bgepjOfSp2uABOKzPJRSg==
X-CSE-MsgGUID: qqwx/AslRHOoP6sn78rbyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,189,1712646000"; 
   d="scan'208";a="39375336"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by orviesa004.jf.intel.com with ESMTP; 25 May 2024 19:00:33 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sB3BW-0007df-0g;
	Sun, 26 May 2024 02:00:30 +0000
Date: Sun, 26 May 2024 09:59:51 +0800
From: kernel test robot <lkp@intel.com>
To: "Jason-JH.Lin" <jason-jh.lin@mediatek.com>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Chun-Kuang Hu <chunkuang.hu@kernel.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: oe-kbuild-all@lists.linux.dev, Conor Dooley <conor+dt@kernel.org>,
	Jason-ch Chen <jason-ch.chen@mediatek.com>,
	"Jason-JH . Lin" <jason-jh.lin@mediatek.com>,
	Singo Chang <singo.chang@mediatek.com>,
	Nancy Lin <nancy.lin@mediatek.com>,
	Shawn Sung <shawn.sung@mediatek.com>, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, dri-devel@lists.freedesktop.org,
	Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [PATCH v6 6/8] mailbox: mediatek: Add CMDQ secure mailbox driver
Message-ID: <202405260953.uzQ4Rwg2-lkp@intel.com>
References: <20240525230810.24623-7-jason-jh.lin@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240525230810.24623-7-jason-jh.lin@mediatek.com>

Hi Jason-JH.Lin,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on next-20240523]
[cannot apply to robh/for-next krzk-dt/for-next fujitsu-integration/mailbox-for-next v6.9]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jason-JH-Lin/dt-bindings-gce-mt8195-Add-CMDQ_SYNC_TOKEN_SECURE_THR_EOF-event-id/20240526-071102
base:   linus/master
patch link:    https://lore.kernel.org/r/20240525230810.24623-7-jason-jh.lin%40mediatek.com
patch subject: [PATCH v6 6/8] mailbox: mediatek: Add CMDQ secure mailbox driver
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20240526/202405260953.uzQ4Rwg2-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240526/202405260953.uzQ4Rwg2-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405260953.uzQ4Rwg2-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/mailbox/mtk-cmdq-sec-mailbox.c: In function 'cmdq_sec_task_exec_work':
>> drivers/mailbox/mtk-cmdq-sec-mailbox.c:619:31: warning: variable 'data' set but not used [-Wunused-but-set-variable]
     619 |         struct cmdq_sec_data *data;
         |                               ^~~~


vim +/data +619 drivers/mailbox/mtk-cmdq-sec-mailbox.c

   611	
   612	static void cmdq_sec_task_exec_work(struct work_struct *work_item)
   613	{
   614		struct cmdq_sec_task *sec_task = container_of(work_item,
   615							      struct cmdq_sec_task, exec_work);
   616		struct cmdq_sec_thread *sec_thread = container_of(sec_task->task.thread,
   617								 struct cmdq_sec_thread, thread);
   618		struct cmdq_sec *cmdq = container_of(sec_thread->dev, struct cmdq_sec, dev);
 > 619		struct cmdq_sec_data *data;
   620		unsigned long flags;
   621		int err;
   622	
   623		dev_dbg(&cmdq->dev, "%s gce:%#lx sec_task:%p pkt:%p thread:%u",
   624			__func__, (unsigned long)cmdq->base_pa,
   625			sec_task, sec_task->task.pkt, sec_thread->idx);
   626	
   627		if (!sec_task->task.pkt->sec_data) {
   628			dev_err(&cmdq->dev, "pkt:%p without sec_data", sec_task->task.pkt);
   629			return;
   630		}
   631		data = (struct cmdq_sec_data *)sec_task->task.pkt->sec_data;
   632	
   633		mutex_lock(&cmdq->exec_lock);
   634	
   635		spin_lock_irqsave(&sec_thread->thread.chan->lock, flags);
   636		if (!sec_thread->task_cnt) {
   637			mod_timer(&sec_thread->timeout, jiffies +
   638				  msecs_to_jiffies(sec_thread->timeout_ms));
   639			sec_thread->wait_cookie = 1;
   640			sec_thread->next_cookie = 1;
   641			sec_thread->task_cnt = 0;
   642			__raw_writel(0, (void __iomem *)cmdq->shared_mem->va +
   643				     CMDQ_SEC_SHARED_THR_CNT_OFFSET + sec_thread->idx * sizeof(u32));
   644		}
   645	
   646		sec_task->reset_exec = sec_thread->task_cnt ? false : true;
   647		sec_task->wait_cookie = sec_thread->next_cookie;
   648		sec_thread->next_cookie = (sec_thread->next_cookie + 1) % CMDQ_MAX_COOKIE_VALUE;
   649		list_add_tail(&sec_task->task.list_entry, &sec_thread->thread.task_busy_list);
   650		sec_thread->task_cnt += 1;
   651		spin_unlock_irqrestore(&sec_thread->thread.chan->lock, flags);
   652		sec_task->trigger = sched_clock();
   653	
   654		if (!atomic_cmpxchg(&cmdq_path_res, 0, 1)) {
   655			err = cmdq_sec_task_submit(cmdq, NULL, CMD_CMDQ_IWC_PATH_RES_ALLOCATE,
   656						   CMDQ_INVALID_THREAD);
   657			if (err) {
   658				atomic_set(&cmdq_path_res, 0);
   659				goto task_end;
   660			}
   661		}
   662	
   663		if (sec_thread->task_cnt > CMDQ_MAX_TASK_IN_SECURE_THREAD) {
   664			dev_err(&cmdq->dev, "task_cnt:%u cannot more than %u sec_task:%p thread:%u",
   665				sec_thread->task_cnt, CMDQ_MAX_TASK_IN_SECURE_THREAD,
   666				sec_task, sec_thread->idx);
   667			err = -EMSGSIZE;
   668			goto task_end;
   669		}
   670	
   671		err = cmdq_sec_task_submit(cmdq, sec_task, CMD_CMDQ_IWC_SUBMIT_TASK,
   672					   sec_thread->idx);
   673		if (err)
   674			dev_err(&cmdq->dev, "cmdq_sec_task_submit err:%d sec_task:%p thread:%u",
   675				err, sec_task, sec_thread->idx);
   676	
   677	task_end:
   678		if (err) {
   679			struct cmdq_cb_data cb_data;
   680	
   681			cb_data.sta = err;
   682			cb_data.pkt = sec_task->task.pkt;
   683			mbox_chan_received_data(sec_thread->thread.chan, &cb_data);
   684	
   685			spin_lock_irqsave(&sec_thread->thread.chan->lock, flags);
   686			if (!sec_thread->task_cnt)
   687				dev_err(&cmdq->dev, "thread:%u task_cnt:%u cannot below zero",
   688					sec_thread->idx, sec_thread->task_cnt);
   689			else
   690				sec_thread->task_cnt -= 1;
   691	
   692			sec_thread->next_cookie = (sec_thread->next_cookie - 1 +
   693				CMDQ_MAX_COOKIE_VALUE) % CMDQ_MAX_COOKIE_VALUE;
   694			list_del(&sec_task->task.list_entry);
   695			dev_dbg(&cmdq->dev, "gce:%#lx err:%d sec_task:%p pkt:%p",
   696				(unsigned long)cmdq->base_pa, err, sec_task, sec_task->task.pkt);
   697			dev_dbg(&cmdq->dev, "thread:%u task_cnt:%u wait_cookie:%u next_cookie:%u",
   698				sec_thread->idx, sec_thread->task_cnt,
   699				sec_thread->wait_cookie, sec_thread->next_cookie);
   700			spin_unlock_irqrestore(&sec_thread->thread.chan->lock, flags);
   701	
   702			kfree(sec_task);
   703		}
   704	
   705		mutex_unlock(&cmdq->exec_lock);
   706	}
   707	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

