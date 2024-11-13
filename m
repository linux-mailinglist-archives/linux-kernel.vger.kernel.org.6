Return-Path: <linux-kernel+bounces-407583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 756129C6FB8
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 13:52:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9BFCB24706
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 12:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9AB11FB89B;
	Wed, 13 Nov 2024 12:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bSuVOysx"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27AD31DF743
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 12:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731501675; cv=none; b=j2uTXI2OTuzJDrjY9GLqJvBLjieuyToCGoi7it71l2nXvck9ncTmoQf+vTil//0MhK/g232AL4pG2NObO5pddJ6Zb1kJJPaVz8Ni1kvNpK50tRt5UHeFbyyWONCEF4LnepM6X8En+trheFAfxUc/Q2LEis/GG0e+voiMufzvVzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731501675; c=relaxed/simple;
	bh=KSSfOuMGhC3q5EI6IsrxUQ2ucDor056uF8lEBcPjaj8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UWn4z3oKAuMpAGl6yYfTXzx3blUa9Zv80Z/NExgYOYTAEoIyKhKWAO0/uX1fT/pdWC6yqpNP2ruUHMmvLAm8xVQv7GCAxo/SI12d+1aiegJAMhCpmhCf0EB/bWDp6PxyHH/UutkqSajMRdeRVl/6no3stDHf6jrHPg6TP9tSklE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bSuVOysx; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731501673; x=1763037673;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KSSfOuMGhC3q5EI6IsrxUQ2ucDor056uF8lEBcPjaj8=;
  b=bSuVOysxdxVentg5FJspUalCGFqUdmnqJh76wDHljrIMSXW4EJp0SjpA
   oeg5nrxKQcX2SSVOZergOtNzwlbQ3CMVw+7BEqerdXA1Zn8bOfDJ+04D5
   nlW/Lk/J8fLxqKfGfJ0lsqU8Br29yViIoAFqe1X+u9g+R5FSOtNgmUQIj
   Owt2jk8R53gIpPjXwrWS0iM/xObZtf8cd2rsNUr+2kw8kjqNIYFW7NnWo
   vko3p4g7GhSJnJcN1PEJA7qdkziB8bduhWgezC8opLjV29dA4n1eMIrdZ
   vSrNST4bQeGuOmWXTGrrlC/N1sJjq38jHr2noNAhcxa8+LF1tJmY5y/f2
   A==;
X-CSE-ConnectionGUID: G4i5sJJaQTCa54577/3hmQ==
X-CSE-MsgGUID: 6KkBR6XtQJSyGbp2fwJ3bA==
X-IronPort-AV: E=McAfee;i="6700,10204,11254"; a="30784416"
X-IronPort-AV: E=Sophos;i="6.12,150,1728975600"; 
   d="scan'208";a="30784416"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2024 04:41:12 -0800
X-CSE-ConnectionGUID: HcuAhA75Q7qx83V038xdXg==
X-CSE-MsgGUID: LHFSecGRTuq7im81N8SCLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,150,1728975600"; 
   d="scan'208";a="87431170"
Received: from lkp-server01.sh.intel.com (HELO 80bd855f15b3) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 13 Nov 2024 04:41:11 -0800
Received: from kbuild by 80bd855f15b3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tBCgG-0000Np-31;
	Wed, 13 Nov 2024 12:41:08 +0000
Date: Wed, 13 Nov 2024 20:40:34 +0800
From: kernel test robot <lkp@intel.com>
To: Liu Chao <liuchao173@huawei.com>, linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, lixiaokeng@huawei.com, caihe@huawei.com
Subject: Re: [PATCH] Add interface to trigger backtrace on specified CPUs
Message-ID: <202411132038.ZTErSl6v-lkp@intel.com>
References: <20241112125609.1406586-1-liuchao173@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241112125609.1406586-1-liuchao173@huawei.com>

Hi Liu,

kernel test robot noticed the following build errors:

[auto build test ERROR on akpm-mm/mm-nonmm-unstable]
[also build test ERROR on linus/master v6.12-rc7 next-20241113]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Liu-Chao/Add-interface-to-trigger-backtrace-on-specified-CPUs/20241112-210050
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-nonmm-unstable
patch link:    https://lore.kernel.org/r/20241112125609.1406586-1-liuchao173%40huawei.com
patch subject: [PATCH] Add interface to trigger backtrace on specified CPUs
config: arc-allyesconfig (https://download.01.org/0day-ci/archive/20241113/202411132038.ZTErSl6v-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241113/202411132038.ZTErSl6v-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411132038.ZTErSl6v-lkp@intel.com/

All errors (new ones prefixed by >>):

>> kernel/backtrace.c:29:19: error: 'no_llseek' undeclared here (not in a function); did you mean 'noop_llseek'?
      29 |         .llseek = no_llseek,
         |                   ^~~~~~~~~
         |                   noop_llseek


vim +29 kernel/backtrace.c

    25	
    26	static const struct file_operations backtrace_fops = {
    27		.owner  = THIS_MODULE,
    28		.write  = backtrace_write,
  > 29		.llseek = no_llseek,
    30	};
    31	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

