Return-Path: <linux-kernel+bounces-221978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D53E90FB56
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 04:33:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4135B224C9
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 02:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DC8E1CAA6;
	Thu, 20 Jun 2024 02:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e+w1kRi8"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD5001E520;
	Thu, 20 Jun 2024 02:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718850793; cv=none; b=e/GC+cz1kBmROt2vaP4Cx2ryFPnXyirphoEHIq6tnLMY0nK+ZBiVHsBnV157Ab5K0AgLU4jXhHU1yI+y/MQgI+bVLVCq1UFycwXTzuyWGKV3UFRLXaoEiVYwfPM9zOKqxOg+o2eKd9b29vE/LexmT527S05+XtalwpQQI/zZCeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718850793; c=relaxed/simple;
	bh=SMkR1O0QE7WLTB+swNTh34HIL8vuJgRvNeiHw5yeszs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p/GNC1rOcrCHM1DumF1Kaqzq7BTSx9myptOf+hx8md+8NMSvzNlmXbjPe77KMx24sLjOTota4ozGbUieAgZLqxFpsBICkASMyezmzw2YUtOYMxVaPe0ui3zQq5UZj7qpDTnxIN7bQfl3TcO1iExaHk4LxEifbtNTnaVy2+JXrNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e+w1kRi8; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718850792; x=1750386792;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SMkR1O0QE7WLTB+swNTh34HIL8vuJgRvNeiHw5yeszs=;
  b=e+w1kRi8Pj4tqKtxzTMXiEMynVNlW+A5UvS9UV/AtU0CVJLrliYaQXQn
   ++W2ytqQCLbwpcOsJqYOPXDHkDLL44Ump6MbZtG3JjZyQuR3c71XmuCNw
   52H+jZ+AHYDWNMP/PUrrg1KS4qzG1prYj6guMRH/XG3/S/9COZ1RYV+a7
   31RP0iFnkCTSkZA5W64qofWmFAFwUbyC+AXO0y2Me6cgVaJxPg8NQrQmQ
   7RpuVfgZwEq+P3hWIVH34v80padJax/AWdE0a/3/U/uo5qeZOlwvr7RkQ
   8XilQGjoo2VTNIJ+VggDNGji+8fqMRP0yPplkpA/ds+8O11Ao0mPAl+g/
   A==;
X-CSE-ConnectionGUID: OGhqk6BkSnaI8o81BBJz6A==
X-CSE-MsgGUID: MxfiJD7zRYSM1l2JcDLXsQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11108"; a="15926258"
X-IronPort-AV: E=Sophos;i="6.08,251,1712646000"; 
   d="scan'208";a="15926258"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2024 19:33:11 -0700
X-CSE-ConnectionGUID: c2ksaAtlTxK8O4ZTXNkeRQ==
X-CSE-MsgGUID: 2W407GraQpCOtfU8YrCQUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,251,1712646000"; 
   d="scan'208";a="47006204"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 19 Jun 2024 19:33:10 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sK7bn-0007EI-0F;
	Thu, 20 Jun 2024 02:33:07 +0000
Date: Thu, 20 Jun 2024 10:32:12 +0800
From: kernel test robot <lkp@intel.com>
To: Mark Watson <markus.c.watson@gmail.com>, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH] dt-bindings: misc: axi-fifo: Add binding for AXI-Stream
 FIFO
Message-ID: <202406201053.hc3wOYdz-lkp@intel.com>
References: <ZnOAgM+zacF6u1x7@laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZnOAgM+zacF6u1x7@laptop>

Hi Mark,

kernel test robot noticed the following build warnings:

[auto build test WARNING on robh/for-next]
[also build test WARNING on linus/master v6.10-rc4 next-20240619]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Mark-Watson/dt-bindings-misc-axi-fifo-Add-binding-for-AXI-Stream-FIFO/20240620-090916
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/ZnOAgM%2BzacF6u1x7%40laptop
patch subject: [PATCH] dt-bindings: misc: axi-fifo: Add binding for AXI-Stream FIFO
config: arc-randconfig-051-20240620 (https://download.01.org/0day-ci/archive/20240620/202406201053.hc3wOYdz-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 13.2.0
dtschema version: 2024.6.dev1+g833054f
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240620/202406201053.hc3wOYdz-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406201053.hc3wOYdz-lkp@intel.com/

dtcheck warnings: (new ones prefixed by >>)
>> Documentation/devicetree/bindings/misc/xlnx,axi-fifo-mm-s-4.1.yaml: xlnx,axi-str-rxd-tdata-width: missing type definition
>> Documentation/devicetree/bindings/misc/xlnx,axi-fifo-mm-s-4.1.yaml: xlnx,axi-str-txc-tdata-width: missing type definition
>> Documentation/devicetree/bindings/misc/xlnx,axi-fifo-mm-s-4.1.yaml: xlnx,axi-str-txd-tdata-width: missing type definition
>> Documentation/devicetree/bindings/misc/xlnx,axi-fifo-mm-s-4.1.yaml: xlnx,data-interface-type: missing type definition
>> Documentation/devicetree/bindings/misc/xlnx,axi-fifo-mm-s-4.1.yaml: xlnx,has-axis-tdest: missing type definition
>> Documentation/devicetree/bindings/misc/xlnx,axi-fifo-mm-s-4.1.yaml: xlnx,has-axis-tid: missing type definition
>> Documentation/devicetree/bindings/misc/xlnx,axi-fifo-mm-s-4.1.yaml: xlnx,has-axis-tkeep: missing type definition
>> Documentation/devicetree/bindings/misc/xlnx,axi-fifo-mm-s-4.1.yaml: xlnx,has-axis-tstrb: missing type definition
>> Documentation/devicetree/bindings/misc/xlnx,axi-fifo-mm-s-4.1.yaml: xlnx,has-axis-tuser: missing type definition
>> Documentation/devicetree/bindings/misc/xlnx,axi-fifo-mm-s-4.1.yaml: xlnx,s-axi-id-width: missing type definition
>> Documentation/devicetree/bindings/misc/xlnx,axi-fifo-mm-s-4.1.yaml: xlnx,s-axi4-data-width: missing type definition
>> Documentation/devicetree/bindings/misc/xlnx,axi-fifo-mm-s-4.1.yaml: xlnx,select-xpm: missing type definition
>> Documentation/devicetree/bindings/misc/xlnx,axi-fifo-mm-s-4.1.yaml: xlnx,use-rx-cut-through: missing type definition
>> Documentation/devicetree/bindings/misc/xlnx,axi-fifo-mm-s-4.1.yaml: xlnx,use-rx-data: missing type definition
>> Documentation/devicetree/bindings/misc/xlnx,axi-fifo-mm-s-4.1.yaml: xlnx,use-tx-ctrl: missing type definition
>> Documentation/devicetree/bindings/misc/xlnx,axi-fifo-mm-s-4.1.yaml: xlnx,use-tx-cut-through: missing type definition
>> Documentation/devicetree/bindings/misc/xlnx,axi-fifo-mm-s-4.1.yaml: xlnx,use-tx-data: missing type definition
   Documentation/devicetree/bindings/net/snps,dwmac.yaml: mac-mode: missing type definition

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

