Return-Path: <linux-kernel+bounces-548208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC7F6A541A7
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 05:26:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE50B16D2F2
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 04:26:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9407C19CC36;
	Thu,  6 Mar 2025 04:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="myN/k6lZ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F97319C54F;
	Thu,  6 Mar 2025 04:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741235159; cv=none; b=C5OWNQEhL+jNG4vwu39t2ZczwUK6cjAoA/yDNCQYhb+qaKN7aVMaP3hBgm9njlVZ8MNWQJgEKZaZr7/cGrMPtx5eym5Cvn8ZteqdSry1oEdDOMuP3o8d+SVd/qdhOWuKJlEn48fRRrl+XU5EAbMLV4nqcqwgmiZ8MaCgqPQE02Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741235159; c=relaxed/simple;
	bh=NJCVt2+YUa5c5YJ95PV1i2GlvWFyPhsZJ0jvLUACEOY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u/jECaM+Rke/xuxxeCaVLhkEpP3y2wGIlWvqwwEVw987NcRwYP5Jx+RA0HpeOq/WYnMNOgE4KKD3PH68TepWGasX99KDsjMEUeXjDHu9O+3GuzLaDplEd15v/WA1fDTw6tjwxlaedfS3j4T8FqQARAPwWetiYN18eiWd198Hs9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=myN/k6lZ; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741235157; x=1772771157;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NJCVt2+YUa5c5YJ95PV1i2GlvWFyPhsZJ0jvLUACEOY=;
  b=myN/k6lZ7+uYPDMV+Oo+LtUQZTeik9LHDeunELxyNBzxDgTYoNsxcx2Z
   WvxH8i1zsW+LyYtZ3cmjBsa07J2dSV94NyV8K7c0HJuKnoEn9ZSa2A44X
   k96YDsv1PbemKxTRr05nSgdoW2rLxDaQHzSammjbposQKtAj9P6/KZTRD
   nH/IJQt3cmbohFc+Rm7M/b5SJRezwILYoeT7icN9UB7TJdLhwwRL7f4/P
   ZfJxZi9TRlbMVvd/Ukgc9+idfY4IskXWS7CrgFoyIlt0BE/GUfohZEcit
   yRUG1HUr/Ea/+S0LXI5LRCnyWUxHc4EHRL411A487ssT1pydgAMhDONu4
   g==;
X-CSE-ConnectionGUID: zZeoU5FwSBaUBkojruNjsQ==
X-CSE-MsgGUID: Av8sX98yT/ykmWBYuj+J3Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="46003572"
X-IronPort-AV: E=Sophos;i="6.14,225,1736841600"; 
   d="scan'208";a="46003572"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2025 20:25:57 -0800
X-CSE-ConnectionGUID: Wox4vV5jSb64q56XBB+2rg==
X-CSE-MsgGUID: BmO2x536SbCjV5jLKsr7Dg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,225,1736841600"; 
   d="scan'208";a="119075926"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by fmviesa008.fm.intel.com with ESMTP; 05 Mar 2025 20:25:51 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tq2ns-000MWc-2Z;
	Thu, 06 Mar 2025 04:25:49 +0000
Date: Thu, 6 Mar 2025 12:24:46 +0800
From: kernel test robot <lkp@intel.com>
To: Manikandan Muralidharan <manikandan.m@microchip.com>, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org,
	nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
	claudiu.beznea@tuxon.dev, tudor.ambarus@linaro.org,
	pratyush@kernel.org, mwalle@kernel.org, miquel.raynal@bootlin.com,
	richard@nod.at, vigneshr@ti.com, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-mtd@lists.infradead.org
Cc: oe-kbuild-all@lists.linux.dev, manikandan.m@microchip.com,
	Varshini Rajendran <varshini.rajendran@microchip.com>
Subject: Re: [PATCH 1/2] mtd: spi-nor: sst: register SFDP region into NVMEM
 framework to read MAC Address
Message-ID: <202503061244.wH2sylN8-lkp@intel.com>
References: <20250305100134.1171124-1-manikandan.m@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250305100134.1171124-1-manikandan.m@microchip.com>

Hi Manikandan,

kernel test robot noticed the following build warnings:

[auto build test WARNING on mtd/spi-nor/next]
[also build test WARNING on robh/for-next abelloni/rtc-next linus/master v6.14-rc5 next-20250305]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Manikandan-Muralidharan/ARM-dts-microchip-sama5d29_curiosity-Add-nvmem-layout-in-QSPI-to-describe-EUI48-MAC-address-region/20250305-180433
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git spi-nor/next
patch link:    https://lore.kernel.org/r/20250305100134.1171124-1-manikandan.m%40microchip.com
patch subject: [PATCH 1/2] mtd: spi-nor: sst: register SFDP region into NVMEM framework to read MAC Address
config: m68k-stmark2_defconfig (https://download.01.org/0day-ci/archive/20250306/202503061244.wH2sylN8-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250306/202503061244.wH2sylN8-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503061244.wH2sylN8-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/mtd/spi-nor/sst.c:75: warning: Function parameter or struct member 'off' not described in 'sst26vf_sfdp_mac_addr_read'
>> drivers/mtd/spi-nor/sst.c:75: warning: Excess function parameter 'offset' description in 'sst26vf_sfdp_mac_addr_read'


vim +75 drivers/mtd/spi-nor/sst.c

    61	
    62	/**
    63	 * sst26vf_sfdp_mac_addr_read() - check if the EUI-48 MAC Address is programmed
    64	 * and read the data from the prestored SFDP data
    65	 *
    66	 * @priv: User context passed to read callbacks.
    67	 * @offset: Offset within the NVMEM device.
    68	 * @val: pointer where to fill the ethernet address
    69	 * @bytes: Length of the NVMEM cell
    70	 *
    71	 * Return: 0 on success, -EINVAL  otherwise.
    72	 */
    73	static int sst26vf_sfdp_mac_addr_read(void *priv, unsigned int off,
    74					      void *val, size_t bytes)
  > 75	{
    76		struct spi_nor *nor = priv;
    77		struct sfdp *sfdp = nor->sfdp;
    78		loff_t offset = off;
    79		size_t sfdp_size;
    80	
    81		/*
    82		 * Check if the EUI-48 MAC address is programmed in the next six address
    83		 * locations.
    84		 * @off is programmed in the DT and stores the start of MAC Address
    85		 * byte, (off - 1) stores the bit length of the Extended Unique
    86		 * Identifier
    87		 */
    88		if (SST26VF_SFDP_EUI48 != *((u8 *)sfdp->dwords + (offset - 1)))
    89			return -EINVAL;
    90	
    91		sfdp_size = sfdp->num_dwords * sizeof(*sfdp->dwords);
    92		memory_read_from_buffer(val, bytes, &offset, sfdp->dwords,
    93					sfdp_size);
    94		return 0;
    95	}
    96	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

