Return-Path: <linux-kernel+bounces-181878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA3AA8C82BA
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 10:48:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9612C28332A
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 08:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97E7817C69;
	Fri, 17 May 2024 08:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K2cKc34z"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11FDF14003
	for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 08:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715935715; cv=none; b=gyneemjrk6RR/1Ne3ybujmo3nuUL27eg0rvCx7iUJM84xq0NvkyzQc5NwR/LhNpzZfNixCajlv1Ptw/o0l1yZvdXidGQ+U17u4I2OvEceZh7hzKiZdeSHiICm7+3GPDcyEYeMhmF7/LjsLwQBQBOBV8BWQppOjs35SNdS1I5n7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715935715; c=relaxed/simple;
	bh=kh7f4XVJlekTgFQfSrA3xaox9KnnolyD8OejBPxU2rc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HsHKPtF23zGA7QFGjpv9EQlhq2AXFBx0b11M7lQgGHvVcDeXEZkd8JfHA653cWMAFCKjtVYBWga+BgffKSJA5hOvfoZ15roxYqB3ppzWTllqWE9QcAcMhkdNrYf5eKzWcNNdjjRDmxrcBxPhE7+WowFzvQK3LVg0lFaPb7sDdzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K2cKc34z; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715935714; x=1747471714;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kh7f4XVJlekTgFQfSrA3xaox9KnnolyD8OejBPxU2rc=;
  b=K2cKc34z1XEcAPDnu5JGJdAQ+jD2e/ZZxwCH3tnnUDYxlBQIhz7zKgPA
   zc4ZpLKtBEqx5I0Apz2BMoGDEm4qSz0PkHPDajXnu4oFye0+NDJucsHfK
   g9emIh4JkdptdpFCkFckaQ731gAPXIqsSM1pzQWQfsijDmFl/qJkexmmK
   IV0ng93ySbDgv1wPsAw8pIfp7ZFqyTOsBGRBg3Qsst5CN78bnv39ygYLt
   yGbZbnQdwF/DL8sWxjRVhmVCoAvh/eTeZIOq4SbTkxhTzU0jOY7a5wcCS
   TkiEJDwjHymkPg+CH4r52K+FFCFT76JrRMiqOUo8XfiycJyGZZ7SQJ/R8
   g==;
X-CSE-ConnectionGUID: ladX3xtjSkqYzw1EB9MffQ==
X-CSE-MsgGUID: 0Tvw39Z1QsKvhKxc+TZj4A==
X-IronPort-AV: E=McAfee;i="6600,9927,11074"; a="12043569"
X-IronPort-AV: E=Sophos;i="6.08,167,1712646000"; 
   d="scan'208";a="12043569"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2024 01:48:24 -0700
X-CSE-ConnectionGUID: b/DQDFUTQR+FeldUD3/CKw==
X-CSE-MsgGUID: wVe4fkLURC2HgGqWTTQM3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,167,1712646000"; 
   d="scan'208";a="36628943"
Received: from unknown (HELO 108735ec233b) ([10.239.97.151])
  by orviesa004.jf.intel.com with ESMTP; 17 May 2024 01:48:22 -0700
Received: from kbuild by 108735ec233b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s7tGG-0000TQ-0K;
	Fri, 17 May 2024 08:48:20 +0000
Date: Fri, 17 May 2024 16:48:05 +0800
From: kernel test robot <lkp@intel.com>
To: Mukesh Ojha <quic_mojha@quicinc.com>, tglx@linutronix.de
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Mukesh Ojha <quic_mojha@quicinc.com>
Subject: Re: [PATCH] genirq/chip: Fix the warn for non-SMP system
Message-ID: <202405171649.ZHgcLqIQ-lkp@intel.com>
References: <1715887825-1031-1-git-send-email-quic_mojha@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1715887825-1031-1-git-send-email-quic_mojha@quicinc.com>

Hi Mukesh,

kernel test robot noticed the following build errors:

[auto build test ERROR on tip/irq/core]
[also build test ERROR on linus/master v6.9 next-20240517]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Mukesh-Ojha/genirq-chip-Fix-the-warn-for-non-SMP-system/20240517-033251
base:   tip/irq/core
patch link:    https://lore.kernel.org/r/1715887825-1031-1-git-send-email-quic_mojha%40quicinc.com
patch subject: [PATCH] genirq/chip: Fix the warn for non-SMP system
config: alpha-allnoconfig (https://download.01.org/0day-ci/archive/20240517/202405171649.ZHgcLqIQ-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240517/202405171649.ZHgcLqIQ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405171649.ZHgcLqIQ-lkp@intel.com/

All errors (new ones prefixed by >>):

   alpha-linux-ld: kernel/irq/chip.o: in function `irq_startup':
>> (.text+0x17f8): undefined reference to `irq_do_set_affinity'
>> alpha-linux-ld: (.text+0x1808): undefined reference to `irq_do_set_affinity'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

