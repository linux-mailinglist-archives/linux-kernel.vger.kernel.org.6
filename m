Return-Path: <linux-kernel+bounces-220424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9512590E18B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 04:11:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40FFF1F23438
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 02:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7563847A58;
	Wed, 19 Jun 2024 02:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RXvdh2Ye"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF5BB10A0A
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 02:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718763101; cv=none; b=PNmpfVCCjWLdl1xwMeg10nj6YZ0em/41g9QhbIpkOGieTYZKLj19Ss0juqTmaxZX2nKkl42iegPpe9FXpcbVrRqRCnxrOtoXkYKlitP2NX0xr8Al0BYDRmBo0jKxhCfqwZldi3WQRu2LhFcYnLBQp9UGHn5plI81tAzIwqLePyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718763101; c=relaxed/simple;
	bh=j56+G078g+1WkfSwbJaWUkMO607hyeFCjys8K7/8XbE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KX9KnkEeK2HeLr/lLum36mzKgaLrbmfiXOeYn0A0voiXjeKM1IizzamKPj4GMxT7rZKfkWJekXdAqjI8ibwZuFKCtnyMqX/8h94L+SnUzRhpovIXDtdYCK5mwjsCMNVUqrOBkhO4ur5iQAdfGlnpsVVTOzwdD1Hm0CP9bVXFW1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RXvdh2Ye; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718763099; x=1750299099;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=j56+G078g+1WkfSwbJaWUkMO607hyeFCjys8K7/8XbE=;
  b=RXvdh2YeDQSsIKPvL0jNduPjVZ7EKLHjIYbcT7SbLROYqaSZegvkJ4Il
   BsQPXPiErnWagWAuXlye5+m6MD4fXXrKe3gorSedMKS5OSKNBjTilHjSf
   G1HTldIIKCmQQ7r1SPufg9itgWLrwtad+V6ZeiYiI809hgJbjWTZWxmiI
   LId7TVlYSxkMF8hheBy41pv4zWfDfYCNzBUcAl1XeNZ0ZWMkbMOlaZBO4
   uYzju4r3rV63cpKLLurhYUKM14L5AJnRcjBDZN+4f5vYUZbLXearBhEXC
   DiK/aD8c91giTqGPxQbA/npzPf1pypTO8qbkmV3EfFdfcZ5SFum/tyXOH
   g==;
X-CSE-ConnectionGUID: hTqbvuwyS7ueM8VuScwW3w==
X-CSE-MsgGUID: m5KhWStnQwG0khAepvM3iA==
X-IronPort-AV: E=McAfee;i="6700,10204,11107"; a="19552188"
X-IronPort-AV: E=Sophos;i="6.08,249,1712646000"; 
   d="scan'208";a="19552188"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2024 19:11:38 -0700
X-CSE-ConnectionGUID: OztFEzKCSnKAGWDYpVC3bw==
X-CSE-MsgGUID: uN/KhuHdQ5q70JWD0Kekgg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,249,1712646000"; 
   d="scan'208";a="46184050"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 18 Jun 2024 19:11:36 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sJknO-0006AG-0U;
	Wed, 19 Jun 2024 02:11:34 +0000
Date: Wed, 19 Jun 2024 10:10:47 +0800
From: kernel test robot <lkp@intel.com>
To: Huacai Chen <chenhuacai@loongson.cn>,
	Thomas Gleixner <tglx@linutronix.de>
Cc: oe-kbuild-all@lists.linux.dev, loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>,
	Huacai Chen <chenhuacai@gmail.com>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: Re: [PATCH] irqchip/loongson-eiointc: Use early_cpu_to_node()
 instead of cpu_to_node()
Message-ID: <202406190940.wW8qmA6Q-lkp@intel.com>
References: <20240618081507.3996921-1-chenhuacai@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240618081507.3996921-1-chenhuacai@loongson.cn>

Hi Huacai,

kernel test robot noticed the following build errors:

[auto build test ERROR on tip/irq/core]
[also build test ERROR on linus/master v6.10-rc4 next-20240618]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Huacai-Chen/irqchip-loongson-eiointc-Use-early_cpu_to_node-instead-of-cpu_to_node/20240618-183129
base:   tip/irq/core
patch link:    https://lore.kernel.org/r/20240618081507.3996921-1-chenhuacai%40loongson.cn
patch subject: [PATCH] irqchip/loongson-eiointc: Use early_cpu_to_node() instead of cpu_to_node()
config: loongarch-alldefconfig (https://download.01.org/0day-ci/archive/20240619/202406190940.wW8qmA6Q-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240619/202406190940.wW8qmA6Q-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406190940.wW8qmA6Q-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/irqchip/irq-loongson-eiointc.c: In function 'pch_msi_parse_madt':
>> drivers/irqchip/irq-loongson-eiointc.c:342:24: error: implicit declaration of function 'early_cpu_to_node'; did you mean 'early_pfn_to_nid'? [-Werror=implicit-function-declaration]
     342 |                 node = early_cpu_to_node(eiointc_priv[nr_pics - 1]->node * CORES_PER_EIO_NODE);
         |                        ^~~~~~~~~~~~~~~~~
         |                        early_pfn_to_nid
   cc1: some warnings being treated as errors


vim +342 drivers/irqchip/irq-loongson-eiointc.c

   333	
   334	static int __init pch_msi_parse_madt(union acpi_subtable_headers *header,
   335						const unsigned long end)
   336	{
   337		struct irq_domain *parent;
   338		struct acpi_madt_msi_pic *pchmsi_entry = (struct acpi_madt_msi_pic *)header;
   339		int node;
   340	
   341		if (cpu_has_flatmode)
 > 342			node = early_cpu_to_node(eiointc_priv[nr_pics - 1]->node * CORES_PER_EIO_NODE);
   343		else
   344			node = eiointc_priv[nr_pics - 1]->node;
   345	
   346		parent = acpi_get_vec_parent(node, msi_group);
   347	
   348		if (parent)
   349			return pch_msi_acpi_init(parent, pchmsi_entry);
   350	
   351		return 0;
   352	}
   353	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

