Return-Path: <linux-kernel+bounces-176446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE3FD8C3002
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 09:16:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E14BAB22F38
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 07:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 238BDD2F5;
	Sat, 11 May 2024 07:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O0KD0eCw"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B9A2610D;
	Sat, 11 May 2024 07:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715411759; cv=none; b=DrRczBNLTlVd6mKHFjc3NU0HDOYR5eHf6GvJH7/siWCIOSV6L4OpDWzgnKPPry9csDe8cRCI8aYtpU+f+4ZIB+dECI0nT5zVuWy05CnByGfvjIYbtNZ+Wfh1IMCgXh6zJ3ZlJPAmhBRDtVmVapq8P2R+PjKqhClxB0scKdDP6bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715411759; c=relaxed/simple;
	bh=TjIX/flL554zvS60Pv08V4xwbSviSX/085JsCFPdfW0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FlGixZl1n5ZN0JrHTgfiv1CG11Wtlygx5QhRsSV2bupB9Sj3egSCzshTHh3T1Srd/mWZtGfGL7JX6uWFhu+hMv18Aj75YwOMr3+BGNxhGiOdBidT5KGiGnuyDbuF0Xna3HZsTR2U1KOW0ieBsYHcaPnmegH61LH8VcPIwGmqzbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O0KD0eCw; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715411757; x=1746947757;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TjIX/flL554zvS60Pv08V4xwbSviSX/085JsCFPdfW0=;
  b=O0KD0eCwO9R6GuqK5XlnlBlz7inxXag+onaC1SBQqx1Q4nBOG37CzdMX
   rWHGKqNhh9bdw/mVT8Dr1gwLQcQgvlr6movjuJNoFriUnIJ6iCB4gMrX9
   e6RlAZSKhXHie/VuLhUXGs+ssHVNCSvzg2ku3V5ORT35nFHqA4c/IfNpO
   HNpPSwI+IIxrFAVrdeNj0IsGKlUrW1g5FAk6Qy5l3EhshCCN3R11EglvT
   0NoQztO9f78Lh8DRmgzZiY6vFmyNf0JGK44rtciEcfyDXRi8sMRhUXFJC
   PxrCjZj6UPd+pHhx5QhC+sjz63W8HDiJfuWrNvcayc7ikbJjsRarcpunj
   Q==;
X-CSE-ConnectionGUID: vFZpoqfKT/+otG1Chca/cw==
X-CSE-MsgGUID: oiCacyipTlmlFXorJDiing==
X-IronPort-AV: E=McAfee;i="6600,9927,11069"; a="15223393"
X-IronPort-AV: E=Sophos;i="6.08,153,1712646000"; 
   d="scan'208";a="15223393"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2024 00:15:56 -0700
X-CSE-ConnectionGUID: MWwOHqH+RbO9RIk3HpsY+A==
X-CSE-MsgGUID: gzKGgGHUTNGlt5D+4HZqmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,153,1712646000"; 
   d="scan'208";a="34391821"
Received: from lkp-server01.sh.intel.com (HELO f8b243fe6e68) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 11 May 2024 00:15:52 -0700
Received: from kbuild by f8b243fe6e68 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s5gxS-00074n-0B;
	Sat, 11 May 2024 07:15:50 +0000
Date: Sat, 11 May 2024 15:14:52 +0800
From: kernel test robot <lkp@intel.com>
To: Pankaj Gupta <pankaj.gupta@nxp.com>, Jonathan Corbet <corbet@lwn.net>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	Pankaj Gupta <pankaj.gupta@nxp.com>
Subject: Re: [PATCH 4/4] firmware: imx: add driver for NXP EdgeLock Enclave
Message-ID: <202405111457.slkK7qEv-lkp@intel.com>
References: <20240510-imx-se-if-v1-4-27c5a674916d@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240510-imx-se-if-v1-4-27c5a674916d@nxp.com>

Hi Pankaj,

kernel test robot noticed the following build warnings:

[auto build test WARNING on e8f897f4afef0031fe618a8e94127a0934896aba]

url:    https://github.com/intel-lab-lkp/linux/commits/Pankaj-Gupta/Documentation-firmware-add-imx-se-to-other_interfaces/20240510-213210
base:   e8f897f4afef0031fe618a8e94127a0934896aba
patch link:    https://lore.kernel.org/r/20240510-imx-se-if-v1-4-27c5a674916d%40nxp.com
patch subject: [PATCH 4/4] firmware: imx: add driver for NXP EdgeLock Enclave
config: arm64-allmodconfig (https://download.01.org/0day-ci/archive/20240511/202405111457.slkK7qEv-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project b910bebc300dafb30569cecc3017b446ea8eafa0)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240511/202405111457.slkK7qEv-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405111457.slkK7qEv-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/firmware/imx/ele_common.c:27:6: warning: variable 'err' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
      27 |         if (!wait_for_completion_timeout(&priv->done, wait)) {
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/firmware/imx/ele_common.c:36:9: note: uninitialized use occurs here
      36 |         return err;
         |                ^~~
   drivers/firmware/imx/ele_common.c:27:2: note: remove the 'if' if its condition is always true
      27 |         if (!wait_for_completion_timeout(&priv->done, wait)) {
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/firmware/imx/ele_common.c:24:9: note: initialize the variable 'err' to silence this warning
      24 |         int err;
         |                ^
         |                 = 0
   1 warning generated.
--
   In file included from drivers/firmware/imx/ele_base_msg.c:8:
   In file included from include/linux/dma-mapping.h:11:
   In file included from include/linux/scatterlist.h:8:
   In file included from include/linux/mm.h:2188:
   include/linux/vmstat.h:508:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     508 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     509 |                            item];
         |                            ~~~~
   include/linux/vmstat.h:515:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     515 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     516 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   include/linux/vmstat.h:522:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     522 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   include/linux/vmstat.h:527:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     527 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     528 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   include/linux/vmstat.h:536:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     536 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     537 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
>> drivers/firmware/imx/ele_base_msg.c:23:6: warning: variable 'ret' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
      23 |         if (!priv || !s_info)
         |             ^~~~~~~~~~~~~~~~
   drivers/firmware/imx/ele_base_msg.c:114:9: note: uninitialized use occurs here
     114 |         return ret;
         |                ^~~
   drivers/firmware/imx/ele_base_msg.c:23:2: note: remove the 'if' if its condition is always false
      23 |         if (!priv || !s_info)
         |         ^~~~~~~~~~~~~~~~~~~~~
      24 |                 goto exit;
         |                 ~~~~~~~~~
>> drivers/firmware/imx/ele_base_msg.c:23:6: warning: variable 'ret' is used uninitialized whenever '||' condition is true [-Wsometimes-uninitialized]
      23 |         if (!priv || !s_info)
         |             ^~~~~
   drivers/firmware/imx/ele_base_msg.c:114:9: note: uninitialized use occurs here
     114 |         return ret;
         |                ^~~
   drivers/firmware/imx/ele_base_msg.c:23:6: note: remove the '||' if its condition is always false
      23 |         if (!priv || !s_info)
         |             ^~~~~~~~
   drivers/firmware/imx/ele_base_msg.c:21:9: note: initialize the variable 'ret' to silence this warning
      21 |         int ret;
         |                ^
         |                 = 0
>> drivers/firmware/imx/ele_base_msg.c:23:6: warning: variable 'get_info_addr' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
      23 |         if (!priv || !s_info)
         |             ^~~~~~~~~~~~~~~~
   drivers/firmware/imx/ele_base_msg.c:103:6: note: uninitialized use occurs here
     103 |         if (get_info_addr) {
         |             ^~~~~~~~~~~~~
   drivers/firmware/imx/ele_base_msg.c:23:2: note: remove the 'if' if its condition is always false
      23 |         if (!priv || !s_info)
         |         ^~~~~~~~~~~~~~~~~~~~~
      24 |                 goto exit;
         |                 ~~~~~~~~~
>> drivers/firmware/imx/ele_base_msg.c:23:6: warning: variable 'get_info_addr' is used uninitialized whenever '||' condition is true [-Wsometimes-uninitialized]
      23 |         if (!priv || !s_info)
         |             ^~~~~
   drivers/firmware/imx/ele_base_msg.c:103:6: note: uninitialized use occurs here
     103 |         if (get_info_addr) {
         |             ^~~~~~~~~~~~~
   drivers/firmware/imx/ele_base_msg.c:23:6: note: remove the '||' if its condition is always false
      23 |         if (!priv || !s_info)
         |             ^~~~~~~~
   drivers/firmware/imx/ele_base_msg.c:18:27: note: initialize the variable 'get_info_addr' to silence this warning
      18 |         phys_addr_t get_info_addr;
         |                                  ^
         |                                   = 0
   9 warnings generated.


vim +27 drivers/firmware/imx/ele_common.c

    20	
    21	int imx_ele_msg_rcv(struct se_if_priv *priv)
    22	{
    23		u32 wait;
    24		int err;
    25	
    26		wait = msecs_to_jiffies(1000);
  > 27		if (!wait_for_completion_timeout(&priv->done, wait)) {
    28			dev_err(priv->dev,
    29					"Error: wait_for_completion timed out.\n");
    30			err = -ETIMEDOUT;
    31		}
    32	
    33		mutex_unlock(&priv->se_if_cmd_lock);
    34		priv->no_dev_ctx_used = false;
    35	
    36		return err;
    37	}
    38	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

