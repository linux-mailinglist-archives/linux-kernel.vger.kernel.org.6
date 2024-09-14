Return-Path: <linux-kernel+bounces-329435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BC32E979144
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 16:08:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9295EB222A1
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 14:08:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 292E41CFEB7;
	Sat, 14 Sep 2024 14:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DDEFHr5z"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04F5C1CF7D9
	for <linux-kernel@vger.kernel.org>; Sat, 14 Sep 2024 14:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726322890; cv=none; b=kzthyFVnOcnFrRfsRke2OnTyxajsSH2oHPUnHU2TpdB/mHXIHCdsFLSHZgFB5C/ehqHFaE1j5Ya2sG5ieW9sq0JkjoxICWrYuFBCeQBmSovjGR/CTZXrzOBQYWayOGUVj86nqm/1SkGJJJE+fh73PQQsXaUO+ShJ8RMqtZIw86M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726322890; c=relaxed/simple;
	bh=if8DTh8EU5bT2w+u+uOfO7v+N6zaMH73Nilq6miPoiA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YJoWN3RqN+p0+WqWq7XYJKWmrPID2QrcTeyXvDuvD3cLzCRbjt2fCE2Q8tr/QWNP6HBNrDRyfWuWyNk1YJGbFQSCsGo+J5GotAv7GBrji6/yPsikzEzfwXF3+T92Z31tbB6TnjlctftnPmjW93xMt+huRoFbCdpR3NXcGhQqGRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DDEFHr5z; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726322886; x=1757858886;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=if8DTh8EU5bT2w+u+uOfO7v+N6zaMH73Nilq6miPoiA=;
  b=DDEFHr5zxius6oLG1ng45MhPepgy8yqYNwUR4LroQIsgOJ7HJiP0dgQW
   Hc6RUc5gxt+4/VBl/shr/pLR552/VTZlDqjMMKbO/7QPIb9esObIT7SU4
   RzuUQEcJRV3OnmpnPU7qRA5MX+V/n6OwNdkkepFzbdxKlzMYqpL2lfofj
   OmbjV0hRM9nPzDsUr/2sn5mUw5bCBD7sX6F1kBwN4dH4gNrMA8B94LD9T
   W1nVJFJEmAgmUpvXsZfCAtjRAti9oz3I+pNT7Tf1wAF+JYV0xSfIgs46D
   Huxgvt+Oh3bkWQKcdgO+eYA446rKqh4lST7cILyo1Lah7Oaj4sZC1/rdb
   g==;
X-CSE-ConnectionGUID: cFGLQrNdTqGz9OKPhor6lw==
X-CSE-MsgGUID: Y+fkyAfzTYSU+scE1vPeUg==
X-IronPort-AV: E=McAfee;i="6700,10204,11195"; a="28962285"
X-IronPort-AV: E=Sophos;i="6.10,229,1719903600"; 
   d="scan'208";a="28962285"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2024 07:08:05 -0700
X-CSE-ConnectionGUID: HK4+3lcQTEmrDJeDvGsYSA==
X-CSE-MsgGUID: jnfhv6XsQMyLnY9gpiNn+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,229,1719903600"; 
   d="scan'208";a="73164848"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 14 Sep 2024 07:08:03 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1spTRQ-0007p2-1r;
	Sat, 14 Sep 2024 14:08:00 +0000
Date: Sat, 14 Sep 2024 22:07:52 +0800
From: kernel test robot <lkp@intel.com>
To: Lizhi Hou <lizhi.hou@amd.com>, ogabbay@kernel.org,
	dri-devel@lists.freedesktop.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Lizhi Hou <lizhi.hou@amd.com>, linux-kernel@vger.kernel.org,
	min.ma@amd.com, max.zhen@amd.com, sonal.santan@amd.com,
	king.tam@amd.com
Subject: Re: [PATCH V3 06/11] accel/amdxdna: Add GEM buffer object management
Message-ID: <202409142134.BxN16uQN-lkp@intel.com>
References: <20240911180604.1834434-7-lizhi.hou@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240911180604.1834434-7-lizhi.hou@amd.com>

Hi Lizhi,

kernel test robot noticed the following build errors:

[auto build test ERROR on drm-misc/drm-misc-next]
[also build test ERROR on drm-tip/drm-tip linus/master v6.11-rc7 next-20240913]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Lizhi-Hou/accel-amdxdna-Add-documentation-for-AMD-NPU-accelerator-driver/20240912-020807
base:   git://anongit.freedesktop.org/drm/drm-misc drm-misc-next
patch link:    https://lore.kernel.org/r/20240911180604.1834434-7-lizhi.hou%40amd.com
patch subject: [PATCH V3 06/11] accel/amdxdna: Add GEM buffer object management
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20240914/202409142134.BxN16uQN-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240914/202409142134.BxN16uQN-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409142134.BxN16uQN-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/accel/amdxdna/aie2_ctx.c:13:
>> drivers/accel/amdxdna/amdxdna_ctx.h:16:26: error: use of undeclared identifier 'count'
      16 |         u32 data[] __counted_by(count);
         |                                 ^
   1 error generated.
--
   In file included from drivers/accel/amdxdna/aie2_pci.c:16:
>> drivers/accel/amdxdna/amdxdna_ctx.h:16:26: error: use of undeclared identifier 'count'
      16 |         u32 data[] __counted_by(count);
         |                                 ^
   drivers/accel/amdxdna/aie2_pci.c:406:46: warning: shift count >= width of type [-Wshift-count-overflow]
     406 |         ret = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
         |                                                     ^~~~~~~~~~~~~~~~
   include/linux/dma-mapping.h:77:54: note: expanded from macro 'DMA_BIT_MASK'
      77 | #define DMA_BIT_MASK(n) (((n) == 64) ? ~0ULL : ((1ULL<<(n))-1))
         |                                                      ^ ~~~
   1 warning and 1 error generated.


vim +/count +16 drivers/accel/amdxdna/amdxdna_ctx.h

     8	
     9	/* Exec buffer command header format */
    10	#define AMDXDNA_CMD_STATE		GENMASK(3, 0)
    11	#define AMDXDNA_CMD_EXTRA_CU_MASK	GENMASK(11, 10)
    12	#define AMDXDNA_CMD_COUNT		GENMASK(22, 12)
    13	#define AMDXDNA_CMD_OPCODE		GENMASK(27, 23)
    14	struct amdxdna_cmd {
    15		u32 header;
  > 16		u32 data[] __counted_by(count);
    17	};
    18	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

