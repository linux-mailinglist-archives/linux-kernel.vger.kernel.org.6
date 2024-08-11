Return-Path: <linux-kernel+bounces-282230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88D8F94E11B
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 14:28:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 451CC281794
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 12:28:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FD0954907;
	Sun, 11 Aug 2024 12:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TGKyUjvk"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B074D5A2;
	Sun, 11 Aug 2024 12:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723379291; cv=none; b=fkU0fsoXGVHs2DRvCSpTEs7HkIAFFM5RqRlEGdaVtKDOSLK7SjeYsrKyomoPz3r29c3XPUUEAuxH+aDh36e7yQdtctxTpkgOx1w4Ah+3HdLQQzh1Nn3hlSCrRtUixIhtyK3eTlYTdDu2D9tGVOHyLfUmC927o0Rg6XIpRbFh8TA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723379291; c=relaxed/simple;
	bh=myINd92mK7N+lJXX188asMi3yAV6ZM9LCZIFfM5I/Ss=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hHv3s5GR5Jc+CTd5rMlOJxHzWNkbS5CwNhoE5a5vYVHnLf6964wcVwcHwLFsfOpZuYuzgukU+HveQgTyeTzs+BNLtRQpJkdBV+sKgpWtkRUEgzH9puFY+9BtfRdUhDnxLM2ZtAObtwh+vZOW6BkVnJb0MA4fLL7mV0KmsG6LGDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TGKyUjvk; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723379290; x=1754915290;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=myINd92mK7N+lJXX188asMi3yAV6ZM9LCZIFfM5I/Ss=;
  b=TGKyUjvk0LL3RGdXM80wZipWSsz4XD9w5tDSomNLDjefSh9M+ymoRHLp
   g6gY9iYG1d7sNl7RkdQVYZgKguxqYCHDAgrEwGu+ysn1UC2rR1+ns/Pp3
   2HdTsLqNqeEjC4Egfr9VFZ49douyb4rqVn14T6CEdzbV73V1dJ3Nm83IT
   3oQnz1HdiLxXZrGOsi1A5UupHVT8KlcFBRgg1bzhjYQ3IKBXtjPYO9pV5
   iXcITrWYwIaXwPpzj/4Je94nH5qsA8FnShdNdYPyQEpu6xTDsEDDra83a
   Z5uyQccet62A6PQInpablUn0T5Q2zo+JnL4Wqiq5Y7E+nXTSJTU9zYdyq
   w==;
X-CSE-ConnectionGUID: FtsSRg14R2SjGYUNouL8mg==
X-CSE-MsgGUID: 4uFewO0uTBW34B/B5eAn3Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11161"; a="25262665"
X-IronPort-AV: E=Sophos;i="6.09,281,1716274800"; 
   d="scan'208";a="25262665"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2024 05:28:07 -0700
X-CSE-ConnectionGUID: fm/ti8VLQfGddUKzExIY+A==
X-CSE-MsgGUID: Cj/8OOLkTYunIQPmt7lIjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,281,1716274800"; 
   d="scan'208";a="62932466"
Received: from unknown (HELO b6bf6c95bbab) ([10.239.97.151])
  by orviesa004.jf.intel.com with ESMTP; 11 Aug 2024 05:28:04 -0700
Received: from kbuild by b6bf6c95bbab with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sd7g1-000ApH-2s;
	Sun, 11 Aug 2024 12:28:01 +0000
Date: Sun, 11 Aug 2024 20:27:48 +0800
From: kernel test robot <lkp@intel.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>,
	linux-arm-kernel@lists.infradead.org
Cc: oe-kbuild-all@lists.linux.dev,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Cristian Marussi <cristian.marussi@arm.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	arm-scmi@vger.kernel.org, james.quinlan@broadcom.com,
	justin.chen@broadcom.com, kapil.hali@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com
Subject: Re: [PATCH 2/2] firmware: arm_scmi: Support 'reg-io-width' property
 for shared memory
Message-ID: <202408112013.dn8y7Fg4-lkp@intel.com>
References: <20240810214621.14417-3-florian.fainelli@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240810214621.14417-3-florian.fainelli@broadcom.com>

Hi Florian,

kernel test robot noticed the following build errors:

[auto build test ERROR on next-20240809]
[cannot apply to robh/for-next soc/for-next linus/master v6.11-rc2 v6.11-rc1 v6.10 v6.11-rc2]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Florian-Fainelli/dt-bindings-sram-Document-reg-io-width-property/20240811-055659
base:   next-20240809
patch link:    https://lore.kernel.org/r/20240810214621.14417-3-florian.fainelli%40broadcom.com
patch subject: [PATCH 2/2] firmware: arm_scmi: Support 'reg-io-width' property for shared memory
config: sh-allmodconfig (https://download.01.org/0day-ci/archive/20240811/202408112013.dn8y7Fg4-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240811/202408112013.dn8y7Fg4-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408112013.dn8y7Fg4-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/firmware/arm_scmi/shmem.c: In function 'shmem_tx_prepare':
>> drivers/firmware/arm_scmi/shmem.c:39:17: error: implicit declaration of function 'iowrite64'; did you mean 'iowrite32'? [-Wimplicit-function-declaration]
      39 |                 iowrite##s(((u##s *)(xfer->tx.buf))[i / shmem_io_width],        \
         |                 ^~~~~~~
   drivers/firmware/arm_scmi/shmem.c:98:25: note: in expansion of macro '__shmem_copy_toio_tpl'
      98 |                         __shmem_copy_toio_tpl(64);
         |                         ^~~~~~~~~~~~~~~~~~~~~


vim +39 drivers/firmware/arm_scmi/shmem.c

    36	
    37	#define __shmem_copy_toio_tpl(s)			\
    38		for (unsigned int i = 0; i < xfer->tx.len; i += shmem_io_width)		\
  > 39			iowrite##s(((u##s *)(xfer->tx.buf))[i / shmem_io_width],	\
    40				   shmem->msg_payload + i);
    41	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

