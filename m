Return-Path: <linux-kernel+bounces-243799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED59A929ABB
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 04:20:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AC311C20995
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 02:20:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4E8E4C99;
	Mon,  8 Jul 2024 02:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nDMizDYm"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55341184F;
	Mon,  8 Jul 2024 02:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720405198; cv=none; b=S5RmzuQxpjbjlS0IW3tfe8RhU+v4jcUC8GKSl5zrLPDniphMnfgnopB8TaDGOYT9lyugXig/TWOwhoLTOzTOJyNKz5AfQyD2F8DIoZJfIjGt00YAxlLt4U/L5bZsqZBEp4heXwQoXQmuIcfTzD4LlkbTT9g5vc2Mh8uCc+UTnzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720405198; c=relaxed/simple;
	bh=s9T/2wtxWK+ztTESZCfPEBhpQtw2HvuPyDZ+kNdyPXY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NU95cayZduu8peoNYTUZ20stEh8qZsOajhvsmxawbHHop5KLeP8vVJkZAQppryUIR8QvOmd6BunhRLo5U+lj4T8J2fHONbk/1TaAECRB2j85z6VsMOO1ZA98hafg1V33xV5hANAXqRBQQteywcK0TIPtLgx0daK7V3gx8vIXfLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nDMizDYm; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720405196; x=1751941196;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=s9T/2wtxWK+ztTESZCfPEBhpQtw2HvuPyDZ+kNdyPXY=;
  b=nDMizDYmmJWNOJoRhhrfjlj2ABSH51Vj9rfKtG2pWRjGNb8mkHmDzFt0
   IksWyoMOvj/v6k8sjJeVulVMmrMBPmoSQLaN+adpj91sIDtde6K/OVShb
   vMkGLlafC7nnfnwopkg7hNHh9MpkzFFB0iE3PG0cjSJRDsScR6wdIZv0J
   Kki/LFMRYubwxhsJDEpIClnzouQo6Qrji29zCYziVQosXPfCOlSiUPACA
   M7/IHVmTvmk2q58n5bGqliQEKuB8xkz6QjgZXg1+WaFYPiHY7WixQgZzm
   d9Z2ZWgGAo1jV1WY3ObdtcTEA8KwDoV5fn2RsgusMz8GER0YW3x0NDkPw
   g==;
X-CSE-ConnectionGUID: e+Klx88rSJeSRr6pkOx0AA==
X-CSE-MsgGUID: F0WqkjgaS6iQJrPUkE8axg==
X-IronPort-AV: E=McAfee;i="6700,10204,11126"; a="28263351"
X-IronPort-AV: E=Sophos;i="6.09,191,1716274800"; 
   d="scan'208";a="28263351"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2024 19:19:56 -0700
X-CSE-ConnectionGUID: rNcI9kJ9S9ubPcMhpYSQ4A==
X-CSE-MsgGUID: TV5niTMcTxigUSMI2Wg9yA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,191,1716274800"; 
   d="scan'208";a="51797881"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 07 Jul 2024 19:19:51 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sQdyn-000VSA-1g;
	Mon, 08 Jul 2024 02:19:49 +0000
Date: Mon, 8 Jul 2024 10:19:35 +0800
From: kernel test robot <lkp@intel.com>
To: Cristian Marussi <cristian.marussi@arm.com>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	arm-scmi@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, sudeep.holla@arm.com,
	james.quinlan@broadcom.com, f.fainelli@gmail.com,
	vincent.guittot@linaro.org, etienne.carriere@foss.st.com,
	peng.fan@oss.nxp.com, michal.simek@amd.com, quic_sibis@quicinc.com,
	quic_nkela@quicinc.com, ptosi@google.com, dan.carpenter@linaro.org,
	souvik.chakravarty@arm.com, Peng Fan <peng.fan@nxp.com>,
	Cristian Marussi <cristian.marussi@arm.com>
Subject: Re: [PATCH 1/8] firmware: arm_scmi: Introduce setup_shmem_iomap
Message-ID: <202407080937.AYEaDXCD-lkp@intel.com>
References: <20240707002055.1835121-2-cristian.marussi@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240707002055.1835121-2-cristian.marussi@arm.com>

Hi Cristian,

kernel test robot noticed the following build warnings:

[auto build test WARNING on soc/for-next]
[also build test WARNING on next-20240703]
[cannot apply to linus/master v6.10-rc7]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Cristian-Marussi/firmware-arm_scmi-Introduce-setup_shmem_iomap/20240707-082513
base:   https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git for-next
patch link:    https://lore.kernel.org/r/20240707002055.1835121-2-cristian.marussi%40arm.com
patch subject: [PATCH 1/8] firmware: arm_scmi: Introduce setup_shmem_iomap
config: arm-randconfig-r111-20240708 (https://download.01.org/0day-ci/archive/20240708/202407080937.AYEaDXCD-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project a0c6b8aef853eedaa0980f07c0a502a5a8a9740e)
reproduce: (https://download.01.org/0day-ci/archive/20240708/202407080937.AYEaDXCD-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202407080937.AYEaDXCD-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/firmware/arm_scmi/shmem.c:170:16: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected void * @@     got void [noderef] __iomem *[assigned] addr @@
   drivers/firmware/arm_scmi/shmem.c:170:16: sparse:     expected void *
   drivers/firmware/arm_scmi/shmem.c:170:16: sparse:     got void [noderef] __iomem *[assigned] addr
   drivers/firmware/arm_scmi/shmem.c:139:6: sparse: sparse: symbol 'setup_shmem_iomap' redeclared with different type (different address spaces):
   drivers/firmware/arm_scmi/shmem.c:139:6: sparse:    void *extern [addressable] [noderef] [toplevel] __iomem setup_shmem_iomap( ... )
   drivers/firmware/arm_scmi/shmem.c: note: in included file:
   drivers/firmware/arm_scmi/common.h:330:14: sparse: note: previously declared as:
   drivers/firmware/arm_scmi/common.h:330:14: sparse:    void [noderef] __iomem *extern [addressable] [toplevel] setup_shmem_iomap( ... )

vim +170 drivers/firmware/arm_scmi/shmem.c

   138	
   139	void *__iomem
   140	setup_shmem_iomap(struct scmi_chan_info *cinfo, struct device *dev, bool tx)
   141	{
   142		const char *desc = tx ? "Tx" : "Rx";
   143		int ret, idx = tx ? 0 : 1;
   144		struct device *cdev = cinfo->dev;
   145		struct device_node *shmem;
   146		resource_size_t size;
   147		struct resource res;
   148		void __iomem *addr;
   149	
   150		shmem = of_parse_phandle(cdev->of_node, "shmem", idx);
   151		if (!of_device_is_compatible(shmem, "arm,scmi-shmem")) {
   152			of_node_put(shmem);
   153			return ERR_PTR(-ENXIO);
   154		}
   155	
   156		ret = of_address_to_resource(shmem, 0, &res);
   157		of_node_put(shmem);
   158		if (ret) {
   159			dev_err(cdev, "failed to get SCMI %s shared memory\n", desc);
   160			return ERR_PTR(ret);
   161		}
   162	
   163		size = resource_size(&res);
   164		addr = devm_ioremap(dev, res.start, size);
   165		if (!addr) {
   166			dev_err(dev, "failed to ioremap SCMI %s shared memory\n", desc);
   167			return ERR_PTR(-EADDRNOTAVAIL);
   168		}
   169	
 > 170		return addr;

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

