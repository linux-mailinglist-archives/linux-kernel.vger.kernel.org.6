Return-Path: <linux-kernel+bounces-375199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D13AD9A92D9
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 00:03:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2BF20B231B0
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 22:03:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 963DC1FF045;
	Mon, 21 Oct 2024 22:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B9NM8C/i"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 582DF1FDFA0
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 22:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729548176; cv=none; b=bd6BVu6OT8WYhmhF1K0cqM2E+G5uLzXC5wUTVwcNToXrCL5Tpelzsl81Lbu7fkzxzcqpcvAn6OB01vdDaN1YVCrGBlZZHiawA/30uZ+FmwefgMgiUJwbXzvc1lpFVAVSUjcQLYqMv//jD1RwcvzpJBZLKBk1IYr4Cd85CeSQrUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729548176; c=relaxed/simple;
	bh=2HURbjKo1eAJNOse2Ao8NLyhdbO+OLbMMD9fcMmUnCw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TZAc4bzbOI38Gcsc4WILfbirxlWD92ASNmCiqlulxf9H5R2vPK0t9WGNOu7OtI478mWB6AZtf1fhRWk1mSTEdBFkUCZ3dKrrU2PHgOTWM3uCJ3XxpqnOjGED7yuXyco0PuWzmNeiv7rpZNGP3nJJXbPmTCGMIR4v71JZ7FIAMiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B9NM8C/i; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729548175; x=1761084175;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2HURbjKo1eAJNOse2Ao8NLyhdbO+OLbMMD9fcMmUnCw=;
  b=B9NM8C/iUN3I1MLP/d37EQjd1OQnQqIXjFSfgVU+Wq1Yn/ipTV/vNYt5
   EztIZJQsMULaEtba+WE5QCS0tPLObVTlmonHX8b1jcDtAw2FR+3PnY4tt
   T3W/oo+NAb+5I9pQETCN5pfzGbco5vZf4WxqZNjlIAxhdPg1pe7Kflzka
   BCvfZbjZNmZy1IFfRIN7Qjci5o1E9PszgzxfyTfuwhbHhCxTQC65ePEih
   bxkmX3cBipdnuLeomJVQY7M+t25pzLIuiGl8nXOIIbC7XIzj0HDMcFbO4
   kWDoUs5nybN9DYiQeP+B5hARaWdOG7VqAT4VlHFrqye0z3t0jRSFqNlLp
   Q==;
X-CSE-ConnectionGUID: 8kOs+BsxQ7O4tFc08tzJTQ==
X-CSE-MsgGUID: ZgwvmwO6Qie0ForeRmoS4g==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="51598968"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="51598968"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2024 15:02:54 -0700
X-CSE-ConnectionGUID: j61wYtazQt2GvMbHT417XA==
X-CSE-MsgGUID: JaX1jGIjTVCE/djY0grilA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,221,1725346800"; 
   d="scan'208";a="79742733"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 21 Oct 2024 15:02:51 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t30UD-000Sfc-0o;
	Mon, 21 Oct 2024 22:02:49 +0000
Date: Tue, 22 Oct 2024 06:01:49 +0800
From: kernel test robot <lkp@intel.com>
To: Bibo Mao <maobibo@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>,
	Jianmin Lv <lvjianmin@loongson.cn>
Cc: oe-kbuild-all@lists.linux.dev, loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org, lixianglai@loongson.cn,
	WANG Xuerui <kernel@xen0n.name>
Subject: Re: [PATCH v2] LoongArch: Fix cpu hotplug issue
Message-ID: <202410220508.9OO5jJgk-lkp@intel.com>
References: <20241021080418.644342-1-maobibo@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241021080418.644342-1-maobibo@loongson.cn>

Hi Bibo,

kernel test robot noticed the following build errors:

[auto build test ERROR on 42f7652d3eb527d03665b09edac47f85fb600924]

url:    https://github.com/intel-lab-lkp/linux/commits/Bibo-Mao/LoongArch-Fix-cpu-hotplug-issue/20241021-160525
base:   42f7652d3eb527d03665b09edac47f85fb600924
patch link:    https://lore.kernel.org/r/20241021080418.644342-1-maobibo%40loongson.cn
patch subject: [PATCH v2] LoongArch: Fix cpu hotplug issue
config: loongarch-allnoconfig (https://download.01.org/0day-ci/archive/20241022/202410220508.9OO5jJgk-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241022/202410220508.9OO5jJgk-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410220508.9OO5jJgk-lkp@intel.com/

All errors (new ones prefixed by >>):

   arch/loongarch/kernel/setup.c: In function 'topo_add_cpu':
>> arch/loongarch/kernel/setup.c:383:9: error: '__cpu_logical_map' undeclared (first use in this function); did you mean 'cpu_logical_map'?
     383 |         __cpu_logical_map[possible_cpus] = physid;
         |         ^~~~~~~~~~~~~~~~~
         |         cpu_logical_map
   arch/loongarch/kernel/setup.c:383:9: note: each undeclared identifier is reported only once for each function it appears in
   arch/loongarch/kernel/setup.c: In function 'topo_init':
   arch/loongarch/kernel/setup.c:391:9: error: '__cpu_logical_map' undeclared (first use in this function); did you mean 'cpu_logical_map'?
     391 |         __cpu_logical_map[0] = loongson_sysconf.boot_cpu_id;
         |         ^~~~~~~~~~~~~~~~~
         |         cpu_logical_map


vim +383 arch/loongarch/kernel/setup.c

   364	
   365	int topo_add_cpu(int physid)
   366	{
   367		int cpu;
   368	
   369		if (!bsp_added && (physid == loongson_sysconf.boot_cpu_id)) {
   370			bsp_added = true;
   371			return 0;
   372		}
   373	
   374		cpu = topo_get_cpu(physid);
   375		if (cpu >= 0) {
   376			pr_warn("Adding duplicated physical cpuid 0x%x\n", physid);
   377			return -EEXIST;
   378		}
   379	
   380		if (possible_cpus >= nr_cpu_ids)
   381			return -ERANGE;
   382	
 > 383		__cpu_logical_map[possible_cpus] = physid;
   384		cpu = possible_cpus++;
   385		return cpu;
   386	}
   387	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

