Return-Path: <linux-kernel+bounces-177628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1820E8C41E6
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 15:28:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49F371C21370
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 13:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BF54152522;
	Mon, 13 May 2024 13:28:19 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47BCD152520
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 13:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715606898; cv=none; b=Vy0C3o0pwPsVIbAvxxTWYILgbf01ygghEidXWYmD4l+yuRuKEBoSVIGEYFZKCzfDOw5ySeQtKV21otAtYQLhiTFfdrcpGNH3nCk7v7TmBL+oef+7U8nK5X/IJnSd+SJv1HFG3PNCgRrm79NglEFTaZpanHi/sx0zvNG8VgOeaNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715606898; c=relaxed/simple;
	bh=AEAxlDQVWzaT1KlqyTqAeGRPurS+2BI1Nmmt1njkrzw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=gt8WYqN8Uo9B3H0etq1hpWbVRGY6j42Kc+wZgMXggBI1RqoeKOlOQWnDuwBYuIzNMminwq7K6qf6KavFZFXnm1zOiWf4ajPmV7o3iJysqqqMq23jptaoZNzULCUVU0HyjY+3ckpolNVH+zVTuzfjmVcc6TurfEMjNKLKIiDik5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4VdKwF4zXPz1S5kj;
	Mon, 13 May 2024 21:24:45 +0800 (CST)
Received: from kwepemm600012.china.huawei.com (unknown [7.193.23.74])
	by mail.maildlp.com (Postfix) with ESMTPS id 2A12118007F;
	Mon, 13 May 2024 21:28:12 +0800 (CST)
Received: from [10.174.178.220] (10.174.178.220) by
 kwepemm600012.china.huawei.com (7.193.23.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 13 May 2024 21:28:11 +0800
Message-ID: <f37cd607-cdde-4302-9515-7af2f958e841@huawei.com>
Date: Mon, 13 May 2024 21:28:10 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] workqueue: Fix rescuer task's name truncated
To: kernel test robot <lkp@intel.com>, Tejun Heo <tj@kernel.org>, Lai
 Jiangshan <jiangshanlai@gmail.com>, Aaron Tomlin <atomlin@atomlin.com>,
	<linux-kernel@vger.kernel.org>
CC: <oe-kbuild-all@lists.linux.dev>, Wenchao Hao <haowenchao22@gmail.com>
References: <20240513030639.3772468-1-haowenchao2@huawei.com>
 <202405131400.sEYZHYk2-lkp@intel.com>
Content-Language: en-US
From: Wenchao Hao <haowenchao2@huawei.com>
In-Reply-To: <202405131400.sEYZHYk2-lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600012.china.huawei.com (7.193.23.74)

On 2024/5/13 15:35, kernel test robot wrote:
> Hi Wenchao,
> 
> kernel test robot noticed the following build warnings:
> 
> [auto build test WARNING on tj-wq/for-next]
> [also build test WARNING on linus/master v6.9 next-20240510]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Wenchao-Hao/workqueue-Fix-rescuer-task-s-name-truncated/20240513-110849
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git for-next
> patch link:    https://lore.kernel.org/r/20240513030639.3772468-1-haowenchao2%40huawei.com
> patch subject: [PATCH] workqueue: Fix rescuer task's name truncated
> config: openrisc-allnoconfig (https://download.01.org/0day-ci/archive/20240513/202405131400.sEYZHYk2-lkp@intel.com/config)
> compiler: or1k-linux-gcc (GCC) 13.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240513/202405131400.sEYZHYk2-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202405131400.sEYZHYk2-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
>     kernel/workqueue.c: In function 'init_rescuer':
>>> kernel/workqueue.c:5558:57: warning: '%s' directive output may be truncated writing up to 31 bytes into a region of size 24 [-Wformat-truncation=]
>      5558 |         snprintf(rescuer->desc, sizeof(rescuer->desc), "%s", wq->name);
>           |                                                         ^~
>     kernel/workqueue.c:5558:9: note: 'snprintf' output between 1 and 32 bytes into a destination of size 24
>      5558 |         snprintf(rescuer->desc, sizeof(rescuer->desc), "%s", wq->name);
>           |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> 
> vim +5558 kernel/workqueue.c
> 
>    5528	
>    5529	/*
>    5530	 * Workqueues which may be used during memory reclaim should have a rescuer
>    5531	 * to guarantee forward progress.
>    5532	 */
>    5533	static int init_rescuer(struct workqueue_struct *wq)
>    5534	{
>    5535		struct worker *rescuer;
>    5536		int ret;
>    5537	
>    5538		if (!(wq->flags & WQ_MEM_RECLAIM))
>    5539			return 0;
>    5540	
>    5541		rescuer = alloc_worker(NUMA_NO_NODE);
>    5542		if (!rescuer) {
>    5543			pr_err("workqueue: Failed to allocate a rescuer for wq \"%s\"\n",
>    5544			       wq->name);
>    5545			return -ENOMEM;
>    5546		}
>    5547	
>    5548		rescuer->rescue_wq = wq;
>    5549		rescuer->task = kthread_create(rescuer_thread, rescuer, "kworker/R");
>    5550		if (IS_ERR(rescuer->task)) {
>    5551			ret = PTR_ERR(rescuer->task);
>    5552			pr_err("workqueue: Failed to create a rescuer kthread for wq \"%s\": %pe",
>    5553			       wq->name, ERR_PTR(ret));
>    5554			kfree(rescuer);
>    5555			return ret;
>    5556		}
>    5557	
>> 5558		snprintf(rescuer->desc, sizeof(rescuer->desc), "%s", wq->name);

This is because commit 31c89007285d3 ("workqueue.c: Increase workqueue name length") increase
WQ_NAME_LEN from 24 to 32, but forget to increase WORKER_DESC_LEN (WORKER_DESC_LEN should equal
to WQ_NAME_LEN ).

Same usage can be found in process_one_work(), it called strscpy() which would not WARNING.
I would add following changes and post V2:

diff --git a/include/linux/workqueue.h b/include/linux/workqueue.h
index 158784dd189a..72031fa80414 100644
--- a/include/linux/workqueue.h
+++ b/include/linux/workqueue.h
@@ -92,7 +92,7 @@ enum wq_misc_consts {
         WORK_BUSY_RUNNING       = 1 << 1,
  
         /* maximum string length for set_worker_desc() */
-       WORKER_DESC_LEN         = 24,
+       WORKER_DESC_LEN         = 32,
  };
  
  /* Convenience constants - of type 'unsigned long', not 'enum'! */


>    5559	
>    5560		wq->rescuer = rescuer;
>    5561		if (wq->flags & WQ_UNBOUND)
>    5562			kthread_bind_mask(rescuer->task, wq_unbound_cpumask);
>    5563		else
>    5564			kthread_bind_mask(rescuer->task, cpu_possible_mask);
>    5565		wake_up_process(rescuer->task);
>    5566	
>    5567		return 0;
>    5568	}
>    5569	
> 


