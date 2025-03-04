Return-Path: <linux-kernel+bounces-544022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E724AA4DC7F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 12:25:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 147A016D2DA
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 11:25:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A27821F583F;
	Tue,  4 Mar 2025 11:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iolnmcAy"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 142671FF1C5;
	Tue,  4 Mar 2025 11:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741087481; cv=none; b=PB6sG1po6BZktn4wkNuKDRwoi4jm7rPSzf3UY4/RnWqmcEQFswBHsIyiRjDszxTME9b3/6PCCRVnuTr0TBcNS4LwsJheKltbvYfim5BTjHzQIn+qE/WzOUf/Cq0v5X4sUtaKF+YPpvRce4zSt1LRDbSjFC/h+85VbIBZ7Usxq7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741087481; c=relaxed/simple;
	bh=e8xAFzSOyEmR1JJktVOqZSTe9qvmMkeaXJerupWRRU8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MW9cgBlYTslUu8JSk8vgbt13ep/TdC6tKbZlu7r+ZZ++24dulk1/abcxLmi5uINt63UF/Hy3X9gbmIUyEipPtOThaJA7vSYVl+3fnyjkzB38CcUGd0MiZbibp6CYZBPkEtvhPWSW2DOoaylkllwmNzAnQz6bH9bkr1rYxDpk1iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iolnmcAy; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741087479; x=1772623479;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=e8xAFzSOyEmR1JJktVOqZSTe9qvmMkeaXJerupWRRU8=;
  b=iolnmcAygEZ6uLjyly1hmHvjEZdbFVoduHZFI3yYhEaScVDCwSqFXEIu
   hAPmR2ec3doz5nEIu2preLTxxAq8iTFkGleGoMni93g8FKHuqqz/G/ZiM
   XCeTW0daKiIjVs+iHTDfxUwaJdBcejvkGgTgDj5yw86LgVuozW6o3Q9OD
   9y/YDz1IMxsQvYyCGSEy4XOOOleiIXXSHoARHoDpsRaA+tS+ZW651aL9R
   lu+R0eUT22VyvluOalEf2Pgiqce60x5GUwrnSnY/IZzI0Fg5B2gQtuujd
   uawur5oNmbDgHM4ynHB2QYt/KV2jO8rcfqfPkqBddd+v0glHr8ctpseFD
   g==;
X-CSE-ConnectionGUID: jGq75flVRcaIbLafjT40iw==
X-CSE-MsgGUID: +HGdazroSjmKn/mo6RXpkA==
X-IronPort-AV: E=McAfee;i="6700,10204,11362"; a="45925577"
X-IronPort-AV: E=Sophos;i="6.13,331,1732608000"; 
   d="scan'208";a="45925577"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 03:24:38 -0800
X-CSE-ConnectionGUID: lAkXDvqMSwmcIaS7Nwzq+A==
X-CSE-MsgGUID: xCV705m/SdKj7H3VTZxEqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="122475846"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by fmviesa003.fm.intel.com with ESMTP; 04 Mar 2025 03:24:34 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tpQO0-000JhS-08;
	Tue, 04 Mar 2025 11:24:32 +0000
Date: Tue, 4 Mar 2025 19:24:27 +0800
From: kernel test robot <lkp@intel.com>
To: Tianyang Zhang <zhangtianyang@loongson.cn>, chenhuacai@kernel.org,
	kernel@xen0n.name, corbet@lwn.net, alexs@kernel.org,
	si.yanteng@linux.dev, tglx@linutronix.de, jiaxun.yang@flygoat.com,
	peterz@infradead.org, wangliupu@loongson.cn, lvjianmin@loongson.cn,
	maobibo@loongson.cn, siyanteng@cqsoftware.com.cn,
	gaosong@loongson.cn, yangtiezhu@loongson.cn
Cc: oe-kbuild-all@lists.linux.dev, loongarch@lists.linux.dev,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	Tianyang Zhang <zhangtianyang@loongson.cn>
Subject: Re: [PATCH 2/2] irq/irq-loongarch-ir:Add Redirect irqchip support
Message-ID: <202503041913.hIveXcmc-lkp@intel.com>
References: <20250303101533.31462-3-zhangtianyang@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250303101533.31462-3-zhangtianyang@loongson.cn>

Hi Tianyang,

kernel test robot noticed the following build errors:

[auto build test ERROR on tip/irq/core]
[also build test ERROR on lwn/docs-next linus/master v6.14-rc5 next-20250303]
[cannot apply to tip/smp/core]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Tianyang-Zhang/Docs-LoongArch-Add-Advanced-Extended-Redirect-IRQ-model-description/20250303-181832
base:   tip/irq/core
patch link:    https://lore.kernel.org/r/20250303101533.31462-3-zhangtianyang%40loongson.cn
patch subject: [PATCH 2/2] irq/irq-loongarch-ir:Add Redirect irqchip support
config: loongarch-randconfig-002-20250304 (https://download.01.org/0day-ci/archive/20250304/202503041913.hIveXcmc-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250304/202503041913.hIveXcmc-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503041913.hIveXcmc-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/irqchip/irq-loongarch-ir.c: In function 'loongarch_irq_redirect_alloc':
>> drivers/irqchip/irq-loongarch-ir.c:352:52: error: 'struct device' has no member named 'numa_node'
     352 |         node = ((msi_alloc_info_t *)arg)->desc->dev->numa_node;
         |                                                    ^~


vim +352 drivers/irqchip/irq-loongarch-ir.c

   342	
   343	static int loongarch_irq_redirect_alloc(struct irq_domain *domain,
   344						unsigned int virq, unsigned int nr_irqs,
   345						 void *arg)
   346	{
   347		struct redirect_table *ird_table;
   348		struct avecintc_data *avec_data;
   349		struct irq_data *irq_data;
   350		int ret, i, node;
   351	
 > 352		node = ((msi_alloc_info_t *)arg)->desc->dev->numa_node;
   353		ird_table = &irde_descs[node].ird_table;
   354		ret = irq_domain_alloc_irqs_parent(domain, virq, nr_irqs, arg);
   355		if (ret < 0)
   356			return ret;
   357	
   358		for (i = 0; i < nr_irqs; i++) {
   359			struct redirect_item *item;
   360	
   361			item = kzalloc(sizeof(struct redirect_item), GFP_KERNEL);
   362			if (!item) {
   363				pr_err("Alloc redirect descriptor failed\n");
   364				goto out_free_resources;
   365			}
   366	
   367			irq_data = irq_domain_get_irq_data(domain, virq + i);
   368	
   369			avec_data = irq_data_get_avec_data(irq_data);
   370			ret = redirect_table_alloc(item, ird_table);
   371			if (ret) {
   372				pr_err("Alloc redirect table entry failed\n");
   373				goto out_free_resources;
   374			}
   375	
   376			item->gpid = kzalloc_node(sizeof(struct redirect_gpid), GFP_KERNEL, node);
   377			if (!item->gpid) {
   378				pr_err("Alloc redirect GPID failed\n");
   379				goto out_free_resources;
   380			}
   381	
   382			irq_data->chip_data = item;
   383			irq_data->chip = &loongarch_redirect_chip;
   384			redirect_domain_prepare_entry(item, avec_data);
   385		}
   386		return 0;
   387	
   388	out_free_resources:
   389		loongarch_irq_redirect_free_resources(domain, virq, nr_irqs);
   390		irq_domain_free_irqs_common(domain, virq, nr_irqs);
   391	
   392		return -EINVAL;
   393	}
   394	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

