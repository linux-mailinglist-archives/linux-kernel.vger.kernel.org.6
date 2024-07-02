Return-Path: <linux-kernel+bounces-238414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ACF9924A15
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 23:52:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8DD53B2324A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 21:52:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6CF8205E0E;
	Tue,  2 Jul 2024 21:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bS4O5DkC"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 907FF1BD512
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 21:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719957152; cv=none; b=A0jDNPK6bjPi+fE1gTx2Ihni/KMxV6M8X6QO/cisGT+1yFq2lxq4ORJ6RZFwWqnVL41/8Crsfb1zqJ+gZSvdU9kBrDW/Hfep11tHuBGS+w4BP5rgSsjyNM2LHW9IIwgdmFLL4YCPm1I/M19tklgtW6+zCH+EbgsRmulwk951SzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719957152; c=relaxed/simple;
	bh=2vi2262ofkIpSqDu0RdKa2alzQl8bJKkhCzzzh5dGsE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tJsIjmOVVQ6aEcvQSfvJTJ2tmOkBxjLiq7+4TORqDIC6Q1QTgH9+CFtB662WFqUQAAd9HAXrvFYlmxxOFNchR28N04gZFJUuQQODUUYmkXBb7u9sFatYAuRURhRf+GJ/2mI44Xjy5QFB5I6CPK0I9kkCQQsvopRg4z5NwnkanAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bS4O5DkC; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719957151; x=1751493151;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2vi2262ofkIpSqDu0RdKa2alzQl8bJKkhCzzzh5dGsE=;
  b=bS4O5DkCSgOBGRWPe9oWkfla1NF6ToiK+Jp8hjq82WystNZ6CqFj9+fK
   Rk6OxylRrH+zUsDYSZTKx53LxxSA7NNoGCbVG7bx6/w4gI71PnW6dxT3B
   XRz2/7VChszv03sDwJnp+59EiMao8X4noOrQcmjpfARUOu+IUQGzFMrS1
   PdXwWKYoYcp3du47sEdGXvNrgJQVn+TbGv2LrwXV6NwIRTEyEqRqNgh+2
   /Yw/bhof1+yRP34FgprkTZ3XJOAdH6b/zoQYKFylPH98Inwer9AgV/CAU
   kSHa8OHk19b3cHRcx8Hzyeb5tHBb+/JShMDR8mO/5uu0nby+zmBBOfy4J
   w==;
X-CSE-ConnectionGUID: +MHIL8JbQYG0Mo/dBEVt6w==
X-CSE-MsgGUID: +wxWlNK5QL+qc+qD9EUFtg==
X-IronPort-AV: E=McAfee;i="6700,10204,11121"; a="17279508"
X-IronPort-AV: E=Sophos;i="6.09,180,1716274800"; 
   d="scan'208";a="17279508"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2024 14:52:30 -0700
X-CSE-ConnectionGUID: ZPpZJ0HyQKC37SE5SYai4A==
X-CSE-MsgGUID: j3LNAZn7SSqsw/VaADq4sw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,180,1716274800"; 
   d="scan'208";a="46452243"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 02 Jul 2024 14:52:26 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sOlQE-000Oiv-39;
	Tue, 02 Jul 2024 21:52:22 +0000
Date: Wed, 3 Jul 2024 05:51:12 +0800
From: kernel test robot <lkp@intel.com>
To: Yi Sun <yi.sun@unisoc.com>, sunyibuaa@gmail.com, tj@kernel.org,
	jiangshanlai@gmail.com, jaegeuk@kernel.org, chao@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, ebiggers@google.com,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org, kent.overstreet@linux.dev,
	niuzhiguo84@gmail.com, Hao_hao.Wang@unisoc.com,
	yunlongxing23@gmail.com, yi.sun@unisoc.com
Subject: Re: [PATCH v2 1/2] workqueue: new struct io_work
Message-ID: <202407030547.MbODytSE-lkp@intel.com>
References: <20240701075138.1144575-2-yi.sun@unisoc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240701075138.1144575-2-yi.sun@unisoc.com>

Hi Yi,

kernel test robot noticed the following build errors:

[auto build test ERROR on jaegeuk-f2fs/dev-test]
[also build test ERROR on jaegeuk-f2fs/dev tj-wq/for-next linus/master v6.10-rc6 next-20240702]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Yi-Sun/workqueue-new-struct-io_work/20240701-155343
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git dev-test
patch link:    https://lore.kernel.org/r/20240701075138.1144575-2-yi.sun%40unisoc.com
patch subject: [PATCH v2 1/2] workqueue: new struct io_work
config: arc-tb10x_defconfig (https://download.01.org/0day-ci/archive/20240703/202407030547.MbODytSE-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240703/202407030547.MbODytSE-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202407030547.MbODytSE-lkp@intel.com/

All errors (new ones prefixed by >>):

   arc-elf-ld: kernel/workqueue.o: in function `may_adjust_io_work_task_ioprio':
   kernel/workqueue.c:2682:(.text+0xbb0): undefined reference to `set_task_ioprio'
>> arc-elf-ld: kernel/workqueue.c:2682:(.text+0xbb0): undefined reference to `set_task_ioprio'
   arc-elf-ld: kernel/workqueue.o: in function `restore_io_work_task_ioprio':
   kernel/workqueue.c:2698:(.text+0xbc8): undefined reference to `set_task_ioprio'
   arc-elf-ld: kernel/workqueue.c:2698:(.text+0xbc8): undefined reference to `set_task_ioprio'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

