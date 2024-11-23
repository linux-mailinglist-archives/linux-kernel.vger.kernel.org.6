Return-Path: <linux-kernel+bounces-418996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC1B69D682E
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 09:32:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 683D5161251
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 08:32:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D5CC173336;
	Sat, 23 Nov 2024 08:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Xyx9FjeF"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8458D2309A9
	for <linux-kernel@vger.kernel.org>; Sat, 23 Nov 2024 08:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732350750; cv=none; b=NDe+rtsU4bzMkq2RwCa+82RtNnwApFMz5k4LsWlyvy2m/iCwbDMZPZYCnpf5R7flfc3Azy5xIovE1l+ftFAThMLnRssBo4ghf15m5gASztHnbvbNf38iuuptu3sm4aAgolBVEErwZKO+Fob8LtX43egK70VNRXD111yOM3NCGMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732350750; c=relaxed/simple;
	bh=QVVQVUkwUKvj4AcABye2tB/9AricLFsjzdPmpmeWWtg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ib8XTcyImqe4MqpxBWlbnPioMDG5d8Ag0DPzFAuqF/y1/jwhSyF6iB7C2KH/FyIAXhFyk5Rw+o97gfnpq/0k2+yCywm6Fhuo0Uqkovf8yb+9ORcMy8hsaVXAxuC8z6PagZjcbIciPSFFYKgm9dxmTtDwN4B+SRBPe2jv12dj6eA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Xyx9FjeF; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732350749; x=1763886749;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QVVQVUkwUKvj4AcABye2tB/9AricLFsjzdPmpmeWWtg=;
  b=Xyx9FjeFtn/34yEbsgnDZ0ytjtN6r8LOZREZ7gH4U2KSdNxvkshBBU1r
   n74V4VLuOlacnQ93WYHxYm2lPQqqDJtwnWSQ4ozsCvyPzT0+I2bs5pkFC
   nZe7u00S3BichV0ys3k4/67cuiTMawZT/6LawPbRi40nQ3TeMDWj5tv2z
   TBjdEXxMr1I7HPTfHzeKyiuLQ4W3wcZCawJNy1MPMnFyNpw8LbyhRMJgm
   RjqNowHflgBqsK09EMM1z5E07bfr6lJUq9VAWndxtF4sKF7FKLgzcuVBv
   c+2u3oAiccrAu/POjfD/BmRgQvuXdkSlThRHFr0fggc945dlzvC1sH2iI
   w==;
X-CSE-ConnectionGUID: cpwQFly8Qni1d9nj+xpe3A==
X-CSE-MsgGUID: aJiWnN7HRb++kp84vSlLOw==
X-IronPort-AV: E=McAfee;i="6700,10204,11264"; a="36170898"
X-IronPort-AV: E=Sophos;i="6.12,178,1728975600"; 
   d="scan'208";a="36170898"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2024 00:32:28 -0800
X-CSE-ConnectionGUID: iFKF55+nTgWHLfTFRbv9zA==
X-CSE-MsgGUID: GgiivKJNRWeqMgs9wXzwPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,178,1728975600"; 
   d="scan'208";a="91144616"
Received: from lkp-server01.sh.intel.com (HELO 8122d2fc1967) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 23 Nov 2024 00:32:24 -0800
Received: from kbuild by 8122d2fc1967 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tElZ0-0004WV-1g;
	Sat, 23 Nov 2024 08:32:22 +0000
Date: Sat, 23 Nov 2024 16:31:57 +0800
From: kernel test robot <lkp@intel.com>
To: Mika Laitio <lamikr@gmail.com>, christian.koenig@amd.com,
	Xinhui.Pan@amd.com, airlied@gmail.com, simona@ffwll.ch,
	Hawking.Zhang@amd.com, sunil.khatri@amd.com, lijo.lazar@amd.com,
	kevinyang.wang@amd.com, amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH] ammdgpu fix for gfx1103 queue evict/restore crash
Message-ID: <202411231603.PMbyCkko-lkp@intel.com>
References: <20241121195233.10679-1-lamikr@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241121195233.10679-1-lamikr@gmail.com>

Hi Mika,

kernel test robot noticed the following build warnings:

[auto build test WARNING on drm-misc/drm-misc-next]
[also build test WARNING on drm-tip/drm-tip v6.12 next-20241122]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Mika-Laitio/ammdgpu-fix-for-gfx1103-queue-evict-restore-crash/20241122-035602
base:   git://anongit.freedesktop.org/drm/drm-misc drm-misc-next
patch link:    https://lore.kernel.org/r/20241121195233.10679-1-lamikr%40gmail.com
patch subject: [PATCH] ammdgpu fix for gfx1103 queue evict/restore crash
config: arm64-allmodconfig (https://download.01.org/0day-ci/archive/20241123/202411231603.PMbyCkko-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 592c0fe55f6d9a811028b5f3507be91458ab2713)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241123/202411231603.PMbyCkko-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411231603.PMbyCkko-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_device_queue_manager.c:32:
   In file included from drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_priv.h:37:
   In file included from include/linux/kfifo.h:40:
   In file included from include/linux/dma-mapping.h:11:
   In file included from include/linux/scatterlist.h:8:
   In file included from include/linux/mm.h:2213:
   include/linux/vmstat.h:504:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     504 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     505 |                            item];
         |                            ~~~~
   include/linux/vmstat.h:511:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     511 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     512 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   include/linux/vmstat.h:518:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     518 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   include/linux/vmstat.h:524:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     524 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     525 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
>> drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_device_queue_manager.c:1354:1: warning: unused label 'out_unlock' [-Wunused-label]
    1354 | out_unlock:
         | ^~~~~~~~~~~
   5 warnings generated.


vim +/out_unlock +1354 drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_device_queue_manager.c

  1292	
  1293	static int restore_process_queues_cpsch(struct device_queue_manager *dqm,
  1294						struct qcm_process_device *qpd)
  1295	{
  1296		struct queue *q;
  1297		struct device *dev = dqm->dev->adev->dev;
  1298		struct kfd_process_device *pdd;
  1299		uint64_t eviction_duration;
  1300		int retval = 0;
  1301	
  1302		// gfx1103 APU fails to remove the queue usually after 10-50 attempts
  1303		if (dqm->dev->adev->flags & AMD_IS_APU)
  1304			goto out;
  1305		pdd = qpd_to_pdd(qpd);
  1306	
  1307		dqm_lock(dqm);
  1308		if (WARN_ON_ONCE(!qpd->evicted)) /* already restored, do nothing */
  1309			goto out;
  1310		if (qpd->evicted > 1) { /* ref count still > 0, decrement & quit */
  1311			qpd->evicted--;
  1312			goto out;
  1313		}
  1314	
  1315		/* The debugger creates processes that temporarily have not acquired
  1316		 * all VMs for all devices and has no VMs itself.
  1317		 * Skip queue restore on process restore.
  1318		 */
  1319		if (!pdd->drm_priv)
  1320			goto vm_not_acquired;
  1321	
  1322		pr_debug_ratelimited("Restoring PASID 0x%x queues\n",
  1323				    pdd->process->pasid);
  1324	
  1325		/* Update PD Base in QPD */
  1326		qpd->page_table_base = amdgpu_amdkfd_gpuvm_get_process_page_dir(pdd->drm_priv);
  1327		pr_debug("Updated PD address to 0x%llx\n", qpd->page_table_base);
  1328	
  1329		/* activate all active queues on the qpd */
  1330		list_for_each_entry(q, &qpd->queues_list, list) {
  1331			q->properties.is_evicted = false;
  1332			if (!QUEUE_IS_ACTIVE(q->properties))
  1333				continue;
  1334	
  1335			q->properties.is_active = true;
  1336			increment_queue_count(dqm, &pdd->qpd, q);
  1337	
  1338			if (dqm->dev->kfd->shared_resources.enable_mes) {
  1339				retval = add_queue_mes(dqm, q, qpd);
  1340				if (retval) {
  1341					dev_err(dev, "Failed to restore queue %d\n",
  1342						q->properties.queue_id);
  1343					goto out;
  1344				}
  1345			}
  1346		}
  1347		if (!dqm->dev->kfd->shared_resources.enable_mes)
  1348			retval = execute_queues_cpsch(dqm,
  1349						      KFD_UNMAP_QUEUES_FILTER_DYNAMIC_QUEUES, 0, USE_DEFAULT_GRACE_PERIOD);
  1350		eviction_duration = get_jiffies_64() - pdd->last_evict_timestamp;
  1351		atomic64_add(eviction_duration, &pdd->evict_duration_counter);
  1352	vm_not_acquired:
  1353		qpd->evicted = 0;
> 1354	out_unlock:
  1355		dqm_unlock(dqm);
  1356	out:
  1357		return retval;
  1358	}
  1359	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

