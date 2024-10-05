Return-Path: <linux-kernel+bounces-351926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2619C9917E7
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 17:43:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E43CF283742
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 15:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D53B31553AB;
	Sat,  5 Oct 2024 15:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NeuG/irQ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9624A15381F
	for <linux-kernel@vger.kernel.org>; Sat,  5 Oct 2024 15:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728142998; cv=none; b=V3YDzlyZbPBkPPmYAf7LBGeQSBNJOHg+x5Rjeg89YaobYn2zJdP3hNvsbCxlv4LKZs8V3zR3d/oU0IzYo1CWvANwHt6HToODL/HcWtTDZcdjRYJKduWz1DGQV7QCvrvEn0B7/bmlWvz/viRZWMCGV9RMRRJV5HcvUsFZr3N6okI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728142998; c=relaxed/simple;
	bh=cMgSteDQVvEffjeaurvwoRqF6z/b5P9Y5FuOLh6xbeE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h3Oc9pbJRLI0M2aQCtjFH+Ruao+25W5kEMwWuYqBpf4TCE7u8rF7IqNQiBSTxvUOcU8iCjD/UbtokoZiWyGIEaaEUMQ+GsxtEBamev3H+MMJr4XkSC36UP3t45PtACfxXYjQPccGGjKN4g7g+DgBAXMZz6qOZBNeKVnQhMWcuYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NeuG/irQ; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728142997; x=1759678997;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cMgSteDQVvEffjeaurvwoRqF6z/b5P9Y5FuOLh6xbeE=;
  b=NeuG/irQaC6UNdzJJccJB/LsM4qULQn5VbVKP1F36sOJLUMX/ldkU5hx
   xZt1ZUyIMO565k3tlYcFUePsvntzY0TwPBeTDi1QWEwBiO1TAl5z4PauP
   NknYV5lA+6nVGPJDmUBhSNmxwCh5+dVQBtLeAWHrv1Iy/WLkIwEbgdGIM
   vLsI03XrtUv1yWcVDcfvP5ZJzyncz7JMIVWgm5EbB8c2TLyk77J4NwZPZ
   01LLJ0xqDdKmqlQDUpHGb7SL5LezSplcvqjCTHvZQzcOSszUh1dXvr63v
   nhd9BPA1dRRLaYyA5xhRtOWXA7SVVkCOOQUqsuNlAEDwrlZUasa2Di7Fg
   w==;
X-CSE-ConnectionGUID: movjHIQgQaGYu5ExlEBDyg==
X-CSE-MsgGUID: ++PfRzsVRYO2/MknbSKBGQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11216"; a="31050206"
X-IronPort-AV: E=Sophos;i="6.11,180,1725346800"; 
   d="scan'208";a="31050206"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2024 08:43:16 -0700
X-CSE-ConnectionGUID: SUfGKZvTR/iBOJJ8oCjqvw==
X-CSE-MsgGUID: BZYjzWG/ThmY1XARy3AiHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,180,1725346800"; 
   d="scan'208";a="79772860"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 05 Oct 2024 08:43:14 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sx6w3-00034k-1q;
	Sat, 05 Oct 2024 15:43:11 +0000
Date: Sat, 5 Oct 2024 23:42:49 +0800
From: kernel test robot <lkp@intel.com>
To: Cindy Lu <lulu@redhat.com>, jasowang@redhat.com, mst@redhat.com,
	michael.christie@oracle.com, linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org
Cc: oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v2 1/7] vhost: Add a new modparam to allow userspace
 select vhost_task
Message-ID: <202410052351.1dCg9uLx-lkp@intel.com>
References: <20241004015937.2286459-2-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241004015937.2286459-2-lulu@redhat.com>

Hi Cindy,

kernel test robot noticed the following build warnings:

[auto build test WARNING on mst-vhost/linux-next]
[also build test WARNING on linus/master v6.12-rc1 next-20241004]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Cindy-Lu/vhost-Add-a-new-modparam-to-allow-userspace-select-vhost_task/20241004-100307
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git linux-next
patch link:    https://lore.kernel.org/r/20241004015937.2286459-2-lulu%40redhat.com
patch subject: [PATCH v2 1/7] vhost: Add a new modparam to allow userspace select vhost_task
config: x86_64-randconfig-122-20241005 (https://download.01.org/0day-ci/archive/20241005/202410052351.1dCg9uLx-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241005/202410052351.1dCg9uLx-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410052351.1dCg9uLx-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/vhost/vhost.c:44:6: sparse: sparse: symbol 'enforce_inherit_owner' was not declared. Should it be static?
   drivers/vhost/vhost.c:1899:54: sparse: sparse: self-comparison always evaluates to false
   drivers/vhost/vhost.c:1900:54: sparse: sparse: self-comparison always evaluates to false
   drivers/vhost/vhost.c:1901:55: sparse: sparse: self-comparison always evaluates to false
   drivers/vhost/vhost.c:2156:46: sparse: sparse: self-comparison always evaluates to false
   drivers/vhost/vhost.c:2236:48: sparse: sparse: self-comparison always evaluates to false
   drivers/vhost/vhost.c: note: in included file (through include/linux/wait.h, include/linux/eventfd.h):
   include/linux/list.h:83:21: sparse: sparse: self-comparison always evaluates to true

vim +/enforce_inherit_owner +44 drivers/vhost/vhost.c

    35	
    36	static ushort max_mem_regions = 64;
    37	module_param(max_mem_regions, ushort, 0444);
    38	MODULE_PARM_DESC(max_mem_regions,
    39		"Maximum number of memory regions in memory map. (default: 64)");
    40	static int max_iotlb_entries = 2048;
    41	module_param(max_iotlb_entries, int, 0444);
    42	MODULE_PARM_DESC(max_iotlb_entries,
    43		"Maximum number of iotlb entries. (default: 2048)");
  > 44	bool enforce_inherit_owner = true;
    45	module_param(enforce_inherit_owner, bool, 0444);
    46	MODULE_PARM_DESC(enforce_inherit_owner,
    47			 "enforce vhost use vhost_task(default: Y)");
    48	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

