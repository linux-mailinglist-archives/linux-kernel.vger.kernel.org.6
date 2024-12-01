Return-Path: <linux-kernel+bounces-426759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1504B9DF773
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 00:34:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C982E2814BE
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Dec 2024 23:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D18DB1D8E1D;
	Sun,  1 Dec 2024 23:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EftpKKek"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 276FC1D88A6
	for <linux-kernel@vger.kernel.org>; Sun,  1 Dec 2024 23:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733096056; cv=none; b=c/rTX/RUnf9e3IVwrUbaFnsD3fVkMqy0HKWgQTroZ/IIglFvda6Ub/O2m91M6Idohzai1BQPrQexN3xqso9OVOAt1Jat4zgyWIjbKZM4luO9qHaE9NIsTAgL94o4vcMHe5bgEPfXzAR0fNTJt+dBIQZLTtEKUa9jAm/yQ6ujOLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733096056; c=relaxed/simple;
	bh=MZqN3Je2Tl02fqfB9TOZYBVVsOvGTSA4+xu5ZP5iAYE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=G83pC8GxH3gXh7fOIB3Spun8Hz2VBwzPrDXREmA1ylAYxIVh60D6wm5XYe94UrVL1RDGIJvIlvzWlyPmk01z3rqQTI7bcQ1KrWKTvpLMnUAerk2uf4z+Yj0uOomUsg3sPlA7ujsOxayvLrc3Uu0wMMcuQlH+iOiPjI0g9tibGvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EftpKKek; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733096053; x=1764632053;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=MZqN3Je2Tl02fqfB9TOZYBVVsOvGTSA4+xu5ZP5iAYE=;
  b=EftpKKekDax8SYZG7lQWyqQSNsDePMSQuiF0BVDH1uleRSYaNsx5IJv1
   YjYdX9wBRHlUlu5NTDDlyv2cXqCRm/c6zTVjFqe69yb8/TQkma0H78/oK
   mD32PdH8MAYL8CtHMLP/Je/O4nrzDdbqw7E6X/ICH/Jqb9rc88MJzCYbV
   lXYO4QE+9I0ReTV5gISWpExWVW1X8hOCABHY0MevGYg4SZ1sbF/vxJ77i
   p+KMBpPhTuoYq0o8tv1hyccWFzZQJLMlTBB7mWXblt7dur+4AXGvzQb6X
   WrgNeYLVFW74yyV6WxihR0j4ZQqGT91agmV+oPbCSTwanVXQP9BJcCqb0
   Q==;
X-CSE-ConnectionGUID: xYfn7CxCT1CU3YKbwp5M4A==
X-CSE-MsgGUID: 9k2jh5yrQeaKYtrMA34C3g==
X-IronPort-AV: E=McAfee;i="6700,10204,11273"; a="33385763"
X-IronPort-AV: E=Sophos;i="6.12,201,1728975600"; 
   d="scan'208";a="33385763"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2024 15:34:13 -0800
X-CSE-ConnectionGUID: mDZINgEdRI6I3sbynjcWkw==
X-CSE-MsgGUID: pQVRDhk6TvWxY+IDDgJXew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="97978238"
Received: from lkp-server02.sh.intel.com (HELO 36a1563c48ff) ([10.239.97.151])
  by orviesa003.jf.intel.com with ESMTP; 01 Dec 2024 15:34:12 -0800
Received: from kbuild by 36a1563c48ff with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tHtS5-0001vh-1Q;
	Sun, 01 Dec 2024 23:34:09 +0000
Date: Mon, 2 Dec 2024 07:33:48 +0800
From: kernel test robot <lkp@intel.com>
To: Stafford Horne <shorne@gmail.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: drivers/infiniband/hw/vmw_pvrdma/pvrdma.h:301:16: sparse: sparse:
 incorrect type in argument 1 (different base types)
Message-ID: <202412020705.MxSRSRYz-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   f788b5ef1ca9b1c2f8d4e1beb2b25edc2db43ef4
commit: ded2ee36313c941f1a12b6f85cde295b575264ae openrisc: Add pci bus support
date:   2 years, 4 months ago
config: openrisc-randconfig-r131-20241115 (https://download.01.org/0day-ci/archive/20241202/202412020705.MxSRSRYz-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 14.2.0
reproduce: (https://download.01.org/0day-ci/archive/20241202/202412020705.MxSRSRYz-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412020705.MxSRSRYz-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   drivers/infiniband/hw/vmw_pvrdma/pvrdma_cmd.c: note: in included file:
>> drivers/infiniband/hw/vmw_pvrdma/pvrdma.h:301:16: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   drivers/infiniband/hw/vmw_pvrdma/pvrdma.h:301:16: sparse:     expected unsigned int [usertype] value
   drivers/infiniband/hw/vmw_pvrdma/pvrdma.h:301:16: sparse:     got restricted __le32 [usertype]
   drivers/infiniband/hw/vmw_pvrdma/pvrdma.h:306:16: sparse: sparse: cast to restricted __le32
   drivers/infiniband/hw/vmw_pvrdma/pvrdma.h:306:16: sparse: sparse: cast to restricted __le32
   drivers/infiniband/hw/vmw_pvrdma/pvrdma.h:306:16: sparse: sparse: cast to restricted __le32
   drivers/infiniband/hw/vmw_pvrdma/pvrdma.h:306:16: sparse: sparse: cast to restricted __le32
   drivers/infiniband/hw/vmw_pvrdma/pvrdma.h:306:16: sparse: sparse: cast to restricted __le32
   drivers/infiniband/hw/vmw_pvrdma/pvrdma.h:306:16: sparse: sparse: cast to restricted __le32
--
   drivers/infiniband/hw/vmw_pvrdma/pvrdma_main.c: note: in included file:
   drivers/infiniband/hw/vmw_pvrdma/pvrdma.h:306:16: sparse: sparse: cast to restricted __le32
   drivers/infiniband/hw/vmw_pvrdma/pvrdma.h:306:16: sparse: sparse: cast to restricted __le32
   drivers/infiniband/hw/vmw_pvrdma/pvrdma.h:306:16: sparse: sparse: cast to restricted __le32
   drivers/infiniband/hw/vmw_pvrdma/pvrdma.h:306:16: sparse: sparse: cast to restricted __le32
   drivers/infiniband/hw/vmw_pvrdma/pvrdma.h:306:16: sparse: sparse: cast to restricted __le32
   drivers/infiniband/hw/vmw_pvrdma/pvrdma.h:306:16: sparse: sparse: cast to restricted __le32
>> drivers/infiniband/hw/vmw_pvrdma/pvrdma.h:301:16: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   drivers/infiniband/hw/vmw_pvrdma/pvrdma.h:301:16: sparse:     expected unsigned int [usertype] value
   drivers/infiniband/hw/vmw_pvrdma/pvrdma.h:301:16: sparse:     got restricted __le32 [usertype]
>> drivers/infiniband/hw/vmw_pvrdma/pvrdma.h:301:16: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   drivers/infiniband/hw/vmw_pvrdma/pvrdma.h:301:16: sparse:     expected unsigned int [usertype] value
   drivers/infiniband/hw/vmw_pvrdma/pvrdma.h:301:16: sparse:     got restricted __le32 [usertype]
>> drivers/infiniband/hw/vmw_pvrdma/pvrdma.h:301:16: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   drivers/infiniband/hw/vmw_pvrdma/pvrdma.h:301:16: sparse:     expected unsigned int [usertype] value
   drivers/infiniband/hw/vmw_pvrdma/pvrdma.h:301:16: sparse:     got restricted __le32 [usertype]
   drivers/infiniband/hw/vmw_pvrdma/pvrdma.h:306:16: sparse: sparse: cast to restricted __le32
   drivers/infiniband/hw/vmw_pvrdma/pvrdma.h:306:16: sparse: sparse: cast to restricted __le32
   drivers/infiniband/hw/vmw_pvrdma/pvrdma.h:306:16: sparse: sparse: cast to restricted __le32
   drivers/infiniband/hw/vmw_pvrdma/pvrdma.h:306:16: sparse: sparse: cast to restricted __le32
   drivers/infiniband/hw/vmw_pvrdma/pvrdma.h:306:16: sparse: sparse: cast to restricted __le32
   drivers/infiniband/hw/vmw_pvrdma/pvrdma.h:306:16: sparse: sparse: cast to restricted __le32
   drivers/infiniband/hw/vmw_pvrdma/pvrdma.h:306:16: sparse: sparse: cast to restricted __le32
   drivers/infiniband/hw/vmw_pvrdma/pvrdma.h:306:16: sparse: sparse: cast to restricted __le32
   drivers/infiniband/hw/vmw_pvrdma/pvrdma.h:306:16: sparse: sparse: cast to restricted __le32
   drivers/infiniband/hw/vmw_pvrdma/pvrdma.h:306:16: sparse: sparse: cast to restricted __le32
   drivers/infiniband/hw/vmw_pvrdma/pvrdma.h:306:16: sparse: sparse: cast to restricted __le32
   drivers/infiniband/hw/vmw_pvrdma/pvrdma.h:306:16: sparse: sparse: cast to restricted __le32
>> drivers/infiniband/hw/vmw_pvrdma/pvrdma.h:301:16: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   drivers/infiniband/hw/vmw_pvrdma/pvrdma.h:301:16: sparse:     expected unsigned int [usertype] value
   drivers/infiniband/hw/vmw_pvrdma/pvrdma.h:301:16: sparse:     got restricted __le32 [usertype]
>> drivers/infiniband/hw/vmw_pvrdma/pvrdma.h:301:16: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   drivers/infiniband/hw/vmw_pvrdma/pvrdma.h:301:16: sparse:     expected unsigned int [usertype] value
   drivers/infiniband/hw/vmw_pvrdma/pvrdma.h:301:16: sparse:     got restricted __le32 [usertype]
>> drivers/infiniband/hw/vmw_pvrdma/pvrdma.h:301:16: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   drivers/infiniband/hw/vmw_pvrdma/pvrdma.h:301:16: sparse:     expected unsigned int [usertype] value
   drivers/infiniband/hw/vmw_pvrdma/pvrdma.h:301:16: sparse:     got restricted __le32 [usertype]
   drivers/infiniband/hw/vmw_pvrdma/pvrdma.h:306:16: sparse: sparse: cast to restricted __le32
   drivers/infiniband/hw/vmw_pvrdma/pvrdma.h:306:16: sparse: sparse: cast to restricted __le32
   drivers/infiniband/hw/vmw_pvrdma/pvrdma.h:306:16: sparse: sparse: cast to restricted __le32
   drivers/infiniband/hw/vmw_pvrdma/pvrdma.h:306:16: sparse: sparse: cast to restricted __le32
   drivers/infiniband/hw/vmw_pvrdma/pvrdma.h:306:16: sparse: sparse: cast to restricted __le32
   drivers/infiniband/hw/vmw_pvrdma/pvrdma.h:306:16: sparse: sparse: cast to restricted __le32
>> drivers/infiniband/hw/vmw_pvrdma/pvrdma.h:301:16: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   drivers/infiniband/hw/vmw_pvrdma/pvrdma.h:301:16: sparse:     expected unsigned int [usertype] value
   drivers/infiniband/hw/vmw_pvrdma/pvrdma.h:301:16: sparse:     got restricted __le32 [usertype]

vim +301 drivers/infiniband/hw/vmw_pvrdma/pvrdma.h

29c8d9eba550c6 Adit Ranadive 2016-10-02  298  
29c8d9eba550c6 Adit Ranadive 2016-10-02  299  static inline void pvrdma_write_reg(struct pvrdma_dev *dev, u32 reg, u32 val)
29c8d9eba550c6 Adit Ranadive 2016-10-02  300  {
29c8d9eba550c6 Adit Ranadive 2016-10-02 @301  	writel(cpu_to_le32(val), dev->regs + reg);
29c8d9eba550c6 Adit Ranadive 2016-10-02  302  }
29c8d9eba550c6 Adit Ranadive 2016-10-02  303  

:::::: The code at line 301 was first introduced by commit
:::::: 29c8d9eba550c6d73d17cc1618a9f5f2a7345aa1 IB: Add vmw_pvrdma driver

:::::: TO: Adit Ranadive <aditr@vmware.com>
:::::: CC: Doug Ledford <dledford@redhat.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

