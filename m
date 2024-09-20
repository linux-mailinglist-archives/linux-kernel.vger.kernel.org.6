Return-Path: <linux-kernel+bounces-334692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4FD597DAB6
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 01:08:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 760732838DB
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 23:08:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4022418E02D;
	Fri, 20 Sep 2024 23:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H2aBqgeZ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F0DA18DF66
	for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 23:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726873704; cv=none; b=i89k+8emIp6kIDK4IT7qSUKpJvsS14N930xuf5JNm5Mi+8tZID4U/dP/IDGk3Ow3fY7WokqZjLimbOC3Fs1L7nKVXZ+b/EY9w8xlbwiIsATenGsmaKwfebSvBTyPsjnCmk1e7VUv2lATbH8UV16xRVTJ6OZXDZLoZyA7zvVnf8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726873704; c=relaxed/simple;
	bh=AdrFGyekahxzzeYdp99Uq0CVdiCj4pVNly9Mv6kJOdM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lco4aMilaKEBWnxDPRHVEhXRmeeWqKiLAYMUermreiOKcgdy1dNH5kch0Suvg5qbdQ5Lt1fvbNLF6BWa4lwmeqW7Njz4Cf45hNuZ7Wnp1/8Z0LIAOczcwPfxV/iZaMHtIhvTfCaqxWBmU0kiWYNfQYOpAZhsKgb0DAtjSrQuN+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H2aBqgeZ; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726873702; x=1758409702;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=AdrFGyekahxzzeYdp99Uq0CVdiCj4pVNly9Mv6kJOdM=;
  b=H2aBqgeZ/kxoK47KwjFp8CxqHV8gFdnRZf/hQGvvUOcGfBj9ZsYo7V4m
   esMXHoGfXoh7SMAbqbB1WL1k72wzA1RMYQdEBSLh3a21EUC3ykgJQUMp7
   nwiRAFYCKG8jeiGkh1FNKnH8TIxkg6PdfYJjVmSLmp2OwqHGYjpGkjY47
   kjtHL+tlj0bbiZcQUbHwPsXZMM8NUSPrsC1JLhpOSp+RaCf+FM/ZhXjIC
   mf7bl9h3XTqvneaA3ZQ2BM1AiJG2L8lS1yZpTTtViEOGTx9E8KjRIetd+
   5YqzH5z/EZcEeCYiYnEOhHCXlmHhmcYbAyvQLICNLxou+KNZ2QRSavLjf
   w==;
X-CSE-ConnectionGUID: mGrn8sVjRVqUYCDFdB8LYA==
X-CSE-MsgGUID: 7zyuXhiWS0ShdP+Of2XURw==
X-IronPort-AV: E=McAfee;i="6700,10204,11201"; a="29687676"
X-IronPort-AV: E=Sophos;i="6.10,245,1719903600"; 
   d="scan'208";a="29687676"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2024 16:08:20 -0700
X-CSE-ConnectionGUID: /9x5MuvrQ1CflGe7a1pZUw==
X-CSE-MsgGUID: GvMC5l//QXuTZNapSxyEEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,245,1719903600"; 
   d="scan'208";a="70457326"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 20 Sep 2024 16:08:17 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1srmjW-000Ev9-34;
	Fri, 20 Sep 2024 23:08:14 +0000
Date: Sat, 21 Sep 2024 07:08:10 +0800
From: kernel test robot <lkp@intel.com>
To: Gowthami Thiagarajan <gthiagarajan@marvell.com>, will@kernel.org,
	mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	sgoutham@marvell.com, lcherian@marvell.com, gcherian@marvell.com,
	Gowthami Thiagarajan <gthiagarajan@marvell.com>
Subject: Re: [PATCH v7] perf/marvell: Marvell PEM performance monitor support
Message-ID: <202409210634.k6bIKrGM-lkp@intel.com>
References: <20240919125117.3484572-1-gthiagarajan@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240919125117.3484572-1-gthiagarajan@marvell.com>

Hi Gowthami,

kernel test robot noticed the following build errors:

[auto build test ERROR on tip/smp/core]
[also build test ERROR on soc/for-next linus/master v6.11 next-20240920]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Gowthami-Thiagarajan/perf-marvell-Marvell-PEM-performance-monitor-support/20240919-205406
base:   tip/smp/core
patch link:    https://lore.kernel.org/r/20240919125117.3484572-1-gthiagarajan%40marvell.com
patch subject: [PATCH v7] perf/marvell: Marvell PEM performance monitor support
config: hexagon-allmodconfig (https://download.01.org/0day-ci/archive/20240921/202409210634.k6bIKrGM-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 8663a75fa2f31299ab8d1d90288d9df92aadee88)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240921/202409210634.k6bIKrGM-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409210634.k6bIKrGM-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   In file included from drivers/perf/marvell_pem_pmu.c:10:
   In file included from include/linux/io.h:14:
   In file included from arch/hexagon/include/asm/io.h:328:
   include/asm-generic/io.h:548:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     548 |         val = __raw_readb(PCI_IOBASE + addr);
         |                           ~~~~~~~~~~ ^
   include/asm-generic/io.h:561:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     561 |         val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:37:51: note: expanded from macro '__le16_to_cpu'
      37 | #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
         |                                                   ^
   In file included from drivers/perf/marvell_pem_pmu.c:10:
   In file included from include/linux/io.h:14:
   In file included from arch/hexagon/include/asm/io.h:328:
   include/asm-generic/io.h:574:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     574 |         val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
      35 | #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
         |                                                   ^
   In file included from drivers/perf/marvell_pem_pmu.c:10:
   In file included from include/linux/io.h:14:
   In file included from arch/hexagon/include/asm/io.h:328:
   include/asm-generic/io.h:585:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     585 |         __raw_writeb(value, PCI_IOBASE + addr);
         |                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:595:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     595 |         __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:605:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     605 |         __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   In file included from drivers/perf/marvell_pem_pmu.c:12:
   In file included from include/linux/perf_event.h:18:
   In file included from include/uapi/linux/bpf_perf_event.h:11:
   In file included from ./arch/hexagon/include/generated/uapi/asm/bpf_perf_event.h:1:
   In file included from include/uapi/asm-generic/bpf_perf_event.h:4:
   In file included from include/linux/ptrace.h:10:
   In file included from include/linux/pid_namespace.h:7:
   In file included from include/linux/mm.h:2232:
   include/linux/vmstat.h:517:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     517 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
>> drivers/perf/marvell_pem_pmu.c:232:9: error: call to undeclared function 'readq_relaxed'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     232 |         return readq_relaxed(pmu->base + eventid_to_offset(eventid));
         |                ^
>> drivers/perf/marvell_pem_pmu.c:354:10: warning: format specifies type 'unsigned long long' but the argument has type 'resource_size_t' (aka 'unsigned int') [-Wformat]
     353 |         name = devm_kasprintf(pem_pmu->dev, GFP_KERNEL, "mrvl_pcie_rc_pmu_%llx",
         |                                                                           ~~~~
         |                                                                           %x
     354 |                               res->start);
         |                               ^~~~~~~~~~
   8 warnings and 1 error generated.


vim +/readq_relaxed +232 drivers/perf/marvell_pem_pmu.c

   228	
   229	static u64 pem_perf_read_counter(struct pem_pmu *pmu,
   230					 struct perf_event *event, int eventid)
   231	{
 > 232		return readq_relaxed(pmu->base + eventid_to_offset(eventid));
   233	}
   234	
   235	static void pem_perf_event_update(struct perf_event *event)
   236	{
   237		struct pem_pmu *pmu = to_pem_pmu(event->pmu);
   238		struct hw_perf_event *hwc = &event->hw;
   239		u64 prev_count, new_count;
   240	
   241		do {
   242			prev_count = local64_read(&hwc->prev_count);
   243			new_count = pem_perf_read_counter(pmu, event, hwc->idx);
   244		} while (local64_xchg(&hwc->prev_count, new_count) != prev_count);
   245	
   246		local64_add((new_count - prev_count), &event->count);
   247	}
   248	
   249	static void pem_perf_event_start(struct perf_event *event, int flags)
   250	{
   251		struct pem_pmu *pmu = to_pem_pmu(event->pmu);
   252		struct hw_perf_event *hwc = &event->hw;
   253		int eventid = hwc->idx;
   254	
   255		/*
   256		 * All counters are free-running and associated with
   257		 * a fixed event to track in Hardware
   258		 */
   259		local64_set(&hwc->prev_count,
   260			    pem_perf_read_counter(pmu, event, eventid));
   261	
   262		hwc->state = 0;
   263	}
   264	
   265	static int pem_perf_event_add(struct perf_event *event, int flags)
   266	{
   267		struct hw_perf_event *hwc = &event->hw;
   268	
   269		hwc->idx = event->attr.config;
   270		if (WARN_ON_ONCE(hwc->idx >= PEM_EVENTIDS_MAX))
   271			return -EINVAL;
   272		hwc->state |= PERF_HES_STOPPED;
   273	
   274		if (flags & PERF_EF_START)
   275			pem_perf_event_start(event, flags);
   276	
   277		return 0;
   278	}
   279	
   280	static void pem_perf_event_stop(struct perf_event *event, int flags)
   281	{
   282		struct hw_perf_event *hwc = &event->hw;
   283	
   284		if (flags & PERF_EF_UPDATE)
   285			pem_perf_event_update(event);
   286	
   287		hwc->state |= PERF_HES_STOPPED;
   288	}
   289	
   290	static void pem_perf_event_del(struct perf_event *event, int flags)
   291	{
   292		struct hw_perf_event *hwc = &event->hw;
   293	
   294		pem_perf_event_stop(event, PERF_EF_UPDATE);
   295		hwc->idx = -1;
   296	}
   297	
   298	static int pem_pmu_offline_cpu(unsigned int cpu, struct hlist_node *node)
   299	{
   300		struct pem_pmu *pmu = hlist_entry_safe(node, struct pem_pmu,
   301						       node);
   302		unsigned int target;
   303	
   304		if (cpu != pmu->cpu)
   305			return 0;
   306	
   307		target = cpumask_any_but(cpu_online_mask, cpu);
   308		if (target >= nr_cpu_ids)
   309			return 0;
   310	
   311		perf_pmu_migrate_context(&pmu->pmu, cpu, target);
   312		pmu->cpu = target;
   313		return 0;
   314	}
   315	
   316	static int pem_perf_probe(struct platform_device *pdev)
   317	{
   318		struct pem_pmu *pem_pmu;
   319		struct resource *res;
   320		void __iomem *base;
   321		char *name;
   322		int ret;
   323	
   324		pem_pmu = devm_kzalloc(&pdev->dev, sizeof(*pem_pmu), GFP_KERNEL);
   325		if (!pem_pmu)
   326			return -ENOMEM;
   327	
   328		pem_pmu->dev = &pdev->dev;
   329		platform_set_drvdata(pdev, pem_pmu);
   330	
   331		base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
   332		if (IS_ERR(base))
   333			return PTR_ERR(base);
   334	
   335		pem_pmu->base = base;
   336	
   337		pem_pmu->pmu = (struct pmu) {
   338			.module	      = THIS_MODULE,
   339			.capabilities = PERF_PMU_CAP_NO_EXCLUDE,
   340			.task_ctx_nr = perf_invalid_context,
   341			.attr_groups = pem_perf_attr_groups,
   342			.event_init  = pem_perf_event_init,
   343			.add	     = pem_perf_event_add,
   344			.del	     = pem_perf_event_del,
   345			.start	     = pem_perf_event_start,
   346			.stop	     = pem_perf_event_stop,
   347			.read	     = pem_perf_event_update,
   348		};
   349	
   350		/* Choose this cpu to collect perf data */
   351		pem_pmu->cpu = raw_smp_processor_id();
   352	
   353		name = devm_kasprintf(pem_pmu->dev, GFP_KERNEL, "mrvl_pcie_rc_pmu_%llx",
 > 354				      res->start);
   355		if (!name)
   356			return -ENOMEM;
   357	
   358		cpuhp_state_add_instance_nocalls(CPUHP_AP_PERF_ARM_MRVL_PEM_ONLINE,
   359						 &pem_pmu->node);
   360	
   361		ret = perf_pmu_register(&pem_pmu->pmu, name, -1);
   362		if (ret)
   363			goto error;
   364	
   365		return 0;
   366	error:
   367		cpuhp_state_remove_instance_nocalls(CPUHP_AP_PERF_ARM_MRVL_PEM_ONLINE,
   368						    &pem_pmu->node);
   369		return ret;
   370	}
   371	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

