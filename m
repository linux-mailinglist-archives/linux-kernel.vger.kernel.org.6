Return-Path: <linux-kernel+bounces-377993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A8899AC9B3
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 14:10:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C0471C2164F
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 12:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A03E1ABEC5;
	Wed, 23 Oct 2024 12:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ezyg/Dop"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D598F1ABEA9
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 12:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729685398; cv=none; b=kJLmbqJaVJbd8DQte9iNKjm6RMiUPbQPnHMJrSN1bgLC1EgPeaLsQJHG78DB7tgD0kMURSgDlu2RoGeZCLv6E0dvpZ+Vq1idBISk6Pr/HnCAzShcnQPxvN99SDmVd6LycqPqAEnst/LZiCEFvt0vBs5767D1K0qRA+kNnJrMwXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729685398; c=relaxed/simple;
	bh=AXAFmD5+kV5yDbgBzUHhaWDhN8JMbiV5Uhxt1/QMjAE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OwyspQ6XD6FRV7gLaJJJuOobXL2S4YnNyrO9NslxLeQHH6Swbn+uAuklICbI6k8MQaWwvgyn0ohIBJebK6NcTOcjGClE2sccCTM+7lcGQx6mUk+pXsarrlFOPYAiMRwiYeS85uUPDd4+sqmjp//Z9Auab/vtg+x3XlHg0PchdWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ezyg/Dop; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729685396; x=1761221396;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=AXAFmD5+kV5yDbgBzUHhaWDhN8JMbiV5Uhxt1/QMjAE=;
  b=Ezyg/DopoMklj8sThNk8mq71lB21PhHL8pMlq3hv6/H+dU9pSuowT5GN
   tG/LY2QC3MFsNJGwJZAABCeq10Aen85YKHBKcb3Phn5RY+RGNP9qjDXVI
   ZtoXbXPwyE6VqTuv+1Rh7uVcCnLk7Pl4n9l1p12NOmWTPLzthTQgdpDet
   84M+OXQJX3eqh6Y6KDYjoaBEzApgEW68Ns5loO+MqyFZ5KEjHdEpf/C+f
   ztPrr3UqJuLPCGASDiC7OsOBVA8LSDYte2MJ2ZCzDNsAIKkYGTKVCiBiR
   houEo466CKH0BYrDQA6A8AyduIP6rYJJ+24kI88qxkM1355XUrcDRpA2K
   g==;
X-CSE-ConnectionGUID: wM6WJCiqRdOSA2xn2ztvMg==
X-CSE-MsgGUID: jAAGMMt6T0Sb3mR/MZtFjA==
X-IronPort-AV: E=McAfee;i="6700,10204,11234"; a="29376759"
X-IronPort-AV: E=Sophos;i="6.11,226,1725346800"; 
   d="scan'208";a="29376759"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2024 05:09:54 -0700
X-CSE-ConnectionGUID: CU1WNP8UT8uzJGu3GTNoXw==
X-CSE-MsgGUID: ww3eUaktSi2PIB25nAUjSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,226,1725346800"; 
   d="scan'208";a="117651570"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 23 Oct 2024 05:09:51 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t3aBR-000Usu-0i;
	Wed, 23 Oct 2024 12:09:49 +0000
Date: Wed, 23 Oct 2024 20:09:25 +0800
From: kernel test robot <lkp@intel.com>
To: Yuanchu Xie <yuanchu@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: oe-kbuild-all@lists.linux.dev, Wei Liu <liuwe@microsoft.com>,
	Rob Bradford <rbradford@rivosinc.com>,
	Theodore Ts'o <tytso@mit.edu>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	virtualization@lists.linux.dev, dev@lists.cloudhypervisor.org,
	Yuanchu Xie <yuanchu@google.com>
Subject: Re: [PATCH v4 1/2] virt: pvmemcontrol: control guest physical memory
 properties
Message-ID: <202410231908.jZfkawyd-lkp@intel.com>
References: <20241021204849.1580384-1-yuanchu@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241021204849.1580384-1-yuanchu@google.com>

Hi Yuanchu,

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on v6.12-rc4 next-20241023]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Yuanchu-Xie/virt-pvmemcontrol-add-Yuanchu-and-Pasha-as-maintainers/20241022-045035
base:   linus/master
patch link:    https://lore.kernel.org/r/20241021204849.1580384-1-yuanchu%40google.com
patch subject: [PATCH v4 1/2] virt: pvmemcontrol: control guest physical memory properties
config: i386-allmodconfig (https://download.01.org/0day-ci/archive/20241023/202410231908.jZfkawyd-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241023/202410231908.jZfkawyd-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410231908.jZfkawyd-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "per_cpu_ptr_to_phys" [drivers/virt/pvmemcontrol/pvmemcontrol.ko] undefined!

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for GET_FREE_REGION
   Depends on [n]: SPARSEMEM [=n]
   Selected by [m]:
   - RESOURCE_KUNIT_TEST [=m] && RUNTIME_TESTING_MENU [=y] && KUNIT [=m]

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

