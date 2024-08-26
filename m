Return-Path: <linux-kernel+bounces-302034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61CA695F8FE
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 20:30:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D93031F23D1F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 18:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B68718FC83;
	Mon, 26 Aug 2024 18:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lg6+5Wi6"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60ED32B9B0
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 18:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724697028; cv=none; b=sebbOokyWqwhATfgAEyW+OLpLXUGgk0lFLlOskkc5ArYxRmMWYs0byViOyZTYYRMM6b9a0f84S/hXAVKRBtAcUF3HgeGYSk/FTLPr9F1xjOKp4kVSBrv3c9AIoKLGaBbihmNGv3dX0h5s0AE+sMVki/lB8jnkC5iaLvpT6tdkhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724697028; c=relaxed/simple;
	bh=YhILNgjvH1xXf9u1639tG8k06076wywNcYFQG/t363M=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=q43fFjrdcfbRVMiw847yr8BtJhf7U/zn1vCJMtDR4EgjZzkRX2R3zF04UEkpTD3oOlJ6kEiz4CmOY23v05OOO7V0iRSbJBtSbdyoo0Ngm87G+6WQcVeQRaYCRspUghAxamNCrfzxGAqyEpoAZuXrZ2PXJh88G1OgsyXhf19zomE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lg6+5Wi6; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724697026; x=1756233026;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=YhILNgjvH1xXf9u1639tG8k06076wywNcYFQG/t363M=;
  b=lg6+5Wi6HfKGRVFXhhCpNFBGoLVtYivIU83515eBOxOTmNOtSS6EaqKj
   xgnBl03+AUchjFY/qXBSKyhQ4AnYBRJ64GJw+cWGSYkHrSJEomLVRdbJ4
   VIeSPckhrgVi7GojXfBNHzMPmrs+zpPawXigKFTZJ5qOO2KOhUeG8F2GM
   vX2pUVoQBjuJ8RUCB63KV6u1E4driTC/6psp8ppfBe+2G7H9vK1TFUD3N
   S0ZxkEMsVZmN/lcUKAqBkSH45gSrDa1c1VFY/P6WQWpZxDM+LHrEO2cK+
   fLjYn3G+dwrWT1JUCpWQfl5UnlaBjkK2guRIVSkEgrA3g07b8jqxLlFTP
   w==;
X-CSE-ConnectionGUID: jKa3AptkSli3GtCffWM5hg==
X-CSE-MsgGUID: 23/3psI6QKeOa9c0sgj6hQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11176"; a="33707563"
X-IronPort-AV: E=Sophos;i="6.10,178,1719903600"; 
   d="scan'208";a="33707563"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2024 11:30:25 -0700
X-CSE-ConnectionGUID: taVlwo3JRaWN6W0nhqJ4xA==
X-CSE-MsgGUID: uPrZwXlhTOaN7MhPkDyZVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,178,1719903600"; 
   d="scan'208";a="62911020"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 26 Aug 2024 11:30:23 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sieTs-000HTu-2v;
	Mon, 26 Aug 2024 18:30:20 +0000
Date: Tue, 27 Aug 2024 02:29:45 +0800
From: kernel test robot <lkp@intel.com>
To: Marc Zyngier <maz@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>
Subject: [tip:irq/core 60/61] kernel/irq/manage.c:230:47: error: section
 attribute cannot be specified for local variables
Message-ID: <202408270209.9VfZ8muh-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq/core
head:   0b39441eaab8bedcba1129776ec85178d4d0d9fb
commit: 6c70d79f363c0c9a712e107b9c4d3644ca8c7490 [60/61] genirq: Get rid of global lock in irq_do_set_affinity()
config: s390-allyesconfig (https://download.01.org/0day-ci/archive/20240827/202408270209.9VfZ8muh-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240827/202408270209.9VfZ8muh-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408270209.9VfZ8muh-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/asm-generic/percpu.h:7,
                    from arch/s390/include/asm/percpu.h:183,
                    from include/linux/irqflags.h:19,
                    from include/linux/spinlock.h:59,
                    from include/linux/irq.h:14,
                    from kernel/irq/manage.c:11:
   kernel/irq/manage.c: In function 'irq_do_set_affinity':
   include/linux/percpu-defs.h:92:40: error: section attribute cannot be specified for local variables
      92 |         extern __PCPU_DUMMY_ATTRS char __pcpu_unique_##name;            \
         |                                        ^~~~~~~~~~~~~~
   include/linux/percpu-defs.h:115:9: note: in expansion of macro 'DEFINE_PER_CPU_SECTION'
     115 |         DEFINE_PER_CPU_SECTION(type, name, "")
         |         ^~~~~~~~~~~~~~~~~~~~~~
   kernel/irq/manage.c:230:16: note: in expansion of macro 'DEFINE_PER_CPU'
     230 |         static DEFINE_PER_CPU(struct cpumask, __tmp_mask);
         |                ^~~~~~~~~~~~~~
   include/linux/percpu-defs.h:93:33: error: section attribute cannot be specified for local variables
      93 |         __PCPU_DUMMY_ATTRS char __pcpu_unique_##name;                   \
         |                                 ^~~~~~~~~~~~~~
   include/linux/percpu-defs.h:115:9: note: in expansion of macro 'DEFINE_PER_CPU_SECTION'
     115 |         DEFINE_PER_CPU_SECTION(type, name, "")
         |         ^~~~~~~~~~~~~~~~~~~~~~
   kernel/irq/manage.c:230:16: note: in expansion of macro 'DEFINE_PER_CPU'
     230 |         static DEFINE_PER_CPU(struct cpumask, __tmp_mask);
         |                ^~~~~~~~~~~~~~
>> include/linux/percpu-defs.h:93:33: error: declaration of '__pcpu_unique___tmp_mask' with no linkage follows extern declaration
      93 |         __PCPU_DUMMY_ATTRS char __pcpu_unique_##name;                   \
         |                                 ^~~~~~~~~~~~~~
   include/linux/percpu-defs.h:115:9: note: in expansion of macro 'DEFINE_PER_CPU_SECTION'
     115 |         DEFINE_PER_CPU_SECTION(type, name, "")
         |         ^~~~~~~~~~~~~~~~~~~~~~
   kernel/irq/manage.c:230:16: note: in expansion of macro 'DEFINE_PER_CPU'
     230 |         static DEFINE_PER_CPU(struct cpumask, __tmp_mask);
         |                ^~~~~~~~~~~~~~
   include/linux/percpu-defs.h:92:40: note: previous declaration of '__pcpu_unique___tmp_mask' with type 'char'
      92 |         extern __PCPU_DUMMY_ATTRS char __pcpu_unique_##name;            \
         |                                        ^~~~~~~~~~~~~~
   include/linux/percpu-defs.h:115:9: note: in expansion of macro 'DEFINE_PER_CPU_SECTION'
     115 |         DEFINE_PER_CPU_SECTION(type, name, "")
         |         ^~~~~~~~~~~~~~~~~~~~~~
   kernel/irq/manage.c:230:16: note: in expansion of macro 'DEFINE_PER_CPU'
     230 |         static DEFINE_PER_CPU(struct cpumask, __tmp_mask);
         |                ^~~~~~~~~~~~~~
>> kernel/irq/manage.c:230:47: error: section attribute cannot be specified for local variables
     230 |         static DEFINE_PER_CPU(struct cpumask, __tmp_mask);
         |                                               ^~~~~~~~~~
   include/linux/percpu-defs.h:94:51: note: in definition of macro 'DEFINE_PER_CPU_SECTION'
      94 |         extern __PCPU_ATTRS(sec) __typeof__(type) name;                 \
         |                                                   ^~~~
   kernel/irq/manage.c:230:16: note: in expansion of macro 'DEFINE_PER_CPU'
     230 |         static DEFINE_PER_CPU(struct cpumask, __tmp_mask);
         |                ^~~~~~~~~~~~~~
>> kernel/irq/manage.c:230:47: error: section attribute cannot be specified for local variables
     230 |         static DEFINE_PER_CPU(struct cpumask, __tmp_mask);
         |                                               ^~~~~~~~~~
   include/linux/percpu-defs.h:95:51: note: in definition of macro 'DEFINE_PER_CPU_SECTION'
      95 |         __PCPU_ATTRS(sec) __weak __typeof__(type) name
         |                                                   ^~~~
   kernel/irq/manage.c:230:16: note: in expansion of macro 'DEFINE_PER_CPU'
     230 |         static DEFINE_PER_CPU(struct cpumask, __tmp_mask);
         |                ^~~~~~~~~~~~~~
>> kernel/irq/manage.c:230:47: error: weak declaration of '__tmp_mask' must be public
     230 |         static DEFINE_PER_CPU(struct cpumask, __tmp_mask);
         |                                               ^~~~~~~~~~
   include/linux/percpu-defs.h:95:51: note: in definition of macro 'DEFINE_PER_CPU_SECTION'
      95 |         __PCPU_ATTRS(sec) __weak __typeof__(type) name
         |                                                   ^~~~
   kernel/irq/manage.c:230:16: note: in expansion of macro 'DEFINE_PER_CPU'
     230 |         static DEFINE_PER_CPU(struct cpumask, __tmp_mask);
         |                ^~~~~~~~~~~~~~
>> kernel/irq/manage.c:230:47: error: declaration of '__tmp_mask' with no linkage follows extern declaration
     230 |         static DEFINE_PER_CPU(struct cpumask, __tmp_mask);
         |                                               ^~~~~~~~~~
   include/linux/percpu-defs.h:95:51: note: in definition of macro 'DEFINE_PER_CPU_SECTION'
      95 |         __PCPU_ATTRS(sec) __weak __typeof__(type) name
         |                                                   ^~~~
   kernel/irq/manage.c:230:16: note: in expansion of macro 'DEFINE_PER_CPU'
     230 |         static DEFINE_PER_CPU(struct cpumask, __tmp_mask);
         |                ^~~~~~~~~~~~~~
   kernel/irq/manage.c:230:47: note: previous declaration of '__tmp_mask' with type 'struct cpumask'
     230 |         static DEFINE_PER_CPU(struct cpumask, __tmp_mask);
         |                                               ^~~~~~~~~~
   include/linux/percpu-defs.h:94:51: note: in definition of macro 'DEFINE_PER_CPU_SECTION'
      94 |         extern __PCPU_ATTRS(sec) __typeof__(type) name;                 \
         |                                                   ^~~~
   kernel/irq/manage.c:230:16: note: in expansion of macro 'DEFINE_PER_CPU'
     230 |         static DEFINE_PER_CPU(struct cpumask, __tmp_mask);
         |                ^~~~~~~~~~~~~~


vim +230 kernel/irq/manage.c

   220	
   221	int irq_do_set_affinity(struct irq_data *data, const struct cpumask *mask,
   222				bool force)
   223	{
   224		struct irq_desc *desc = irq_data_to_desc(data);
   225		struct irq_chip *chip = irq_data_get_irq_chip(data);
   226		const struct cpumask  *prog_mask;
   227		struct cpumask *tmp_mask;
   228		int ret;
   229	
 > 230		static DEFINE_PER_CPU(struct cpumask, __tmp_mask);
   231	
   232		if (!chip || !chip->irq_set_affinity)
   233			return -EINVAL;
   234	
   235		tmp_mask = this_cpu_ptr(&__tmp_mask);
   236	
   237		/*
   238		 * If this is a managed interrupt and housekeeping is enabled on
   239		 * it check whether the requested affinity mask intersects with
   240		 * a housekeeping CPU. If so, then remove the isolated CPUs from
   241		 * the mask and just keep the housekeeping CPU(s). This prevents
   242		 * the affinity setter from routing the interrupt to an isolated
   243		 * CPU to avoid that I/O submitted from a housekeeping CPU causes
   244		 * interrupts on an isolated one.
   245		 *
   246		 * If the masks do not intersect or include online CPU(s) then
   247		 * keep the requested mask. The isolated target CPUs are only
   248		 * receiving interrupts when the I/O operation was submitted
   249		 * directly from them.
   250		 *
   251		 * If all housekeeping CPUs in the affinity mask are offline, the
   252		 * interrupt will be migrated by the CPU hotplug code once a
   253		 * housekeeping CPU which belongs to the affinity mask comes
   254		 * online.
   255		 */
   256		if (irqd_affinity_is_managed(data) &&
   257		    housekeeping_enabled(HK_TYPE_MANAGED_IRQ)) {
   258			const struct cpumask *hk_mask;
   259	
   260			hk_mask = housekeeping_cpumask(HK_TYPE_MANAGED_IRQ);
   261	
   262			cpumask_and(tmp_mask, mask, hk_mask);
   263			if (!cpumask_intersects(tmp_mask, cpu_online_mask))
   264				prog_mask = mask;
   265			else
   266				prog_mask = tmp_mask;
   267		} else {
   268			prog_mask = mask;
   269		}
   270	
   271		/*
   272		 * Make sure we only provide online CPUs to the irqchip,
   273		 * unless we are being asked to force the affinity (in which
   274		 * case we do as we are told).
   275		 */
   276		cpumask_and(tmp_mask, prog_mask, cpu_online_mask);
   277		if (!force && !cpumask_empty(tmp_mask))
   278			ret = chip->irq_set_affinity(data, tmp_mask, force);
   279		else if (force)
   280			ret = chip->irq_set_affinity(data, mask, force);
   281		else
   282			ret = -EINVAL;
   283	
   284		switch (ret) {
   285		case IRQ_SET_MASK_OK:
   286		case IRQ_SET_MASK_OK_DONE:
   287			cpumask_copy(desc->irq_common_data.affinity, mask);
   288			fallthrough;
   289		case IRQ_SET_MASK_OK_NOCOPY:
   290			irq_validate_effective_affinity(data);
   291			irq_set_thread_affinity(desc);
   292			ret = 0;
   293		}
   294	
   295		return ret;
   296	}
   297	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

