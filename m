Return-Path: <linux-kernel+bounces-172741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B6D078BF600
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 08:20:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B79831C21973
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 06:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BDC11803A;
	Wed,  8 May 2024 06:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Be5TFYRP"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35F961758E;
	Wed,  8 May 2024 06:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715149215; cv=none; b=MXujeL8Tex/Q6cM0vOdk3o+9JqDFDRqpIC64W6eSdd8kwuC/jcfQcMVgp38UHvFHZrmGJSfs7BMSV5WN2VEJzJhBYaDZ41U2rPUQgN8j2YvhQoN9fRjsqlqVNjdFC0qT0zz8zFGn3P9Gz7smcG3/nA9PDKuy5S/iHfL2wWwSwjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715149215; c=relaxed/simple;
	bh=9aXNhsDVP0gfJxfrZP8xiEseqy1Wo1/lCHeXwFzjbps=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UvOKBu0XZwLnFQuO01ZMsgkxvZDaFvDb2+zPsxzwzBNeVDZmeZ5zUSP9TLbE28vBK9FgJ/8dkf06YpKe0khJCw5D0P2HbegRIl1v9Dy+cKUNMt8YW282JTwq/NoYBt4gUieL6oUW/0AH5JVnd4orTuZ7y1gNKNNBVw5gQLv4V/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Be5TFYRP; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715149214; x=1746685214;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9aXNhsDVP0gfJxfrZP8xiEseqy1Wo1/lCHeXwFzjbps=;
  b=Be5TFYRP/DHlvKJK1PP9caygWBmbmTApcnRX6qLdQkzkYEGAN3Ihdasb
   U7yP9tZ74JXBjFuVKjcvdaDFOs6iIQh5T04r/NM15aLxmiM7BPBBDvBW0
   zHup0su8bPbCcIvyCz3QdaMAcekSvw9qqHMIA38EPXT3ONR1ecmWwkjpX
   vcopFY8f63q/lYJGxDTDr6sIvolA1VZq0SaReamQrP9VZksqKGqovs6xs
   XO2or3PoJ7pSHOBrnkAiEL0wLHMG2zamYMDMnCydjvdc+L9BkuXc41j5d
   C1s5LFSjxcqly8a9l09ZzxIMrf/icW+Wyuni1/KcTkbndvbhRyOsY4Bba
   A==;
X-CSE-ConnectionGUID: VHvnbLeARJel1k7HoYg1eg==
X-CSE-MsgGUID: HdsYz9+TRaeGkxkWrxck4A==
X-IronPort-AV: E=McAfee;i="6600,9927,11066"; a="14781180"
X-IronPort-AV: E=Sophos;i="6.08,144,1712646000"; 
   d="scan'208";a="14781180"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2024 23:20:14 -0700
X-CSE-ConnectionGUID: rnaNMFQnRnqLRZRs1Hz4LA==
X-CSE-MsgGUID: S4tCt9sASXC/k2Wyco5CyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,144,1712646000"; 
   d="scan'208";a="33254696"
Received: from lkp-server01.sh.intel.com (HELO f8b243fe6e68) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 07 May 2024 23:20:09 -0700
Received: from kbuild by f8b243fe6e68 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s4aes-00034K-0z;
	Wed, 08 May 2024 06:20:06 +0000
Date: Wed, 8 May 2024 14:19:07 +0800
From: kernel test robot <lkp@intel.com>
To: Tianyang Zhang <zhangtianyang@loongson.cn>, chenhuacai@kernel.org,
	kernel@xen0n.name, tglx@linutronix.de, jiaxun.yang@flygoat.com,
	gaoliang@loongson.cn, wangliupu@loongson.cn, lvjianmin@loongson.cn,
	yijun@loongson.cn, mhocko@suse.com, akpm@linux-foundation.org,
	dianders@chromium.org, maobibo@loongson.cn, xry111@xry111.site,
	zhaotianrui@loongson.cn, nathan@kernel.org, yangtiezhu@loongson.cn,
	zhoubinbin@loongson.cn
Cc: oe-kbuild-all@lists.linux.dev, loongarch@lists.linux.dev,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] Loongarch:Support loongarch avec
Message-ID: <202405081417.CPM5mm4Q-lkp@intel.com>
References: <20240507125953.9117-1-zhangtianyang@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240507125953.9117-1-zhangtianyang@loongson.cn>

Hi Tianyang,

kernel test robot noticed the following build warnings:

[auto build test WARNING on tip/irq/core]
[also build test WARNING on linus/master v6.9-rc7]
[cannot apply to next-20240507]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Tianyang-Zhang/Loongarch-Support-loongarch-avec/20240507-210314
base:   tip/irq/core
patch link:    https://lore.kernel.org/r/20240507125953.9117-1-zhangtianyang%40loongson.cn
patch subject: [PATCH 2/2] Loongarch:Support loongarch avec
config: mips-loongson3_defconfig (https://download.01.org/0day-ci/archive/20240508/202405081417.CPM5mm4Q-lkp@intel.com/config)
compiler: mips64el-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240508/202405081417.CPM5mm4Q-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405081417.CPM5mm4Q-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/irqchip/irq-loongson-pch-msi.c:107:31: warning: 'pch_msi_domain_info_v2' defined but not used [-Wunused-variable]
     107 | static struct msi_domain_info pch_msi_domain_info_v2 = {
         |                               ^~~~~~~~~~~~~~~~~~~~~~


vim +/pch_msi_domain_info_v2 +107 drivers/irqchip/irq-loongson-pch-msi.c

   106	
 > 107	static struct msi_domain_info pch_msi_domain_info_v2 = {
   108		.flags		= MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
   109				MSI_FLAG_MULTI_PCI_MSI | MSI_FLAG_PCI_MSIX,
   110		.chip	= &pch_msi_irq_chip_v2,
   111	};
   112	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

