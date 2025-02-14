Return-Path: <linux-kernel+bounces-514333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8B58A355B2
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 05:22:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AD7F16A6CE
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 04:22:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C4EE15CD4A;
	Fri, 14 Feb 2025 04:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mVB+xSbE"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19A6F1519AD;
	Fri, 14 Feb 2025 04:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739506937; cv=none; b=hPpgqp40dtimp+gaduKP7sz8NBMVyHYkUC1YzIjcGq6xqDNdE+qkmbalg9Zt4h/P0DKl4LyngdqXRCmba3nTcZ5XUM0vcRXvjM81MA367ck6lnW/OeqBMQzqu+/Bgw5R6gj5pHWfpn6Z4QsJXn1JQxpbbesC1apUMeVD5xf1KYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739506937; c=relaxed/simple;
	bh=E6U7r9+XPf5C9PFEIXPbnBypfFSXsnpSwDiuegOJVuw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sywS5Q+6oWlYqA5z2884qFDKXxHfjGWYLYCE/KB1rRh6uYhszkrBGeJ7K8z2r/V9UhpC9kvU9hLcn7IbVMAPbvi5YHQE8Ulyw2z8K9KPO9R4IhwwA/DeOVDMxUrIrskos2q9M5YJP++xz2hApxN9fb/PiaUxUSv/RvgL2ekJUE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mVB+xSbE; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739506936; x=1771042936;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=E6U7r9+XPf5C9PFEIXPbnBypfFSXsnpSwDiuegOJVuw=;
  b=mVB+xSbERg4bxXHmHGjHQXhKEZO/cWaonRP1K3CUKmR1hE3dpCQdtKAU
   XErkD7TdMoSblL4i/Nv7DcPTOc8R1Qe/ChQODUNdSXar9dCYOESlsldpj
   i8NiVV7Ty8N40PkK1aue+LFTNkhPa9GtsI1XnJ/w+FljAnKTTlaAun1rb
   ydH2tJImeOLtwHbyMWojHFM40mC8MyGY/uJG/1cJegzd98IK6YTYlQuAD
   Q1mdLBuYOidLXlsfxZKy9ui9UYfqtkyvldGH2Lm6Nr+jnaTnw3lx+gPFh
   c9TIcBxhAeMSC/rfa+zK7UH0lUOxf5uO+U9I7qi+3tmSnYu1DEEFCHYY6
   Q==;
X-CSE-ConnectionGUID: 4FuqktkBQUmLJtOOKOG82w==
X-CSE-MsgGUID: UwMKeMoKQvexycwSBj3eTQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11344"; a="40393031"
X-IronPort-AV: E=Sophos;i="6.13,284,1732608000"; 
   d="scan'208";a="40393031"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 20:22:15 -0800
X-CSE-ConnectionGUID: t+79vm8PSYKAAhX+bpJ3NQ==
X-CSE-MsgGUID: gq8QhoN5RA+HIfSRQvNY+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="144281882"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 13 Feb 2025 20:22:12 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tinDO-00193T-1j;
	Fri, 14 Feb 2025 04:22:10 +0000
Date: Fri, 14 Feb 2025 12:21:13 +0800
From: kernel test robot <lkp@intel.com>
To: Aman Kumar Pandey <aman.kumarpandey@nxp.com>,
	linux-kernel@vger.kernel.org, linux-i3c@lists.infradead.org,
	alexandre.belloni@bootlin.com, krzk+dt@kernel.org, robh@kernel.org,
	conor+dt@kernel.org, devicetree@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, vikash.bansal@nxp.com,
	priyanka.jain@nxp.com, shashank.rebbapragada@nxp.com,
	Frank.Li@nxp.com, Aman Kumar Pandey <aman.kumarpandey@nxp.com>
Subject: Re: [PATCH 2/2] drivers: i3c: Add driver for NXP P3H2x4x i3c-hub
 device
Message-ID: <202502141155.osJiWAHL-lkp@intel.com>
References: <20250212132227.1348374-2-aman.kumarpandey@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250212132227.1348374-2-aman.kumarpandey@nxp.com>

Hi Aman,

kernel test robot noticed the following build warnings:

[auto build test WARNING on robh/for-next]
[also build test WARNING on linus/master v6.14-rc2 next-20250213]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Aman-Kumar-Pandey/drivers-i3c-Add-driver-for-NXP-P3H2x4x-i3c-hub-device/20250212-213659
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/20250212132227.1348374-2-aman.kumarpandey%40nxp.com
patch subject: [PATCH 2/2] drivers: i3c: Add driver for NXP P3H2x4x i3c-hub device
config: i386-randconfig-r111-20250214 (https://download.01.org/0day-ci/archive/20250214/202502141155.osJiWAHL-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250214/202502141155.osJiWAHL-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502141155.osJiWAHL-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/i3c/p3h2x4x/p3h2x4x_i3c_hub_common.c:9:22: sparse: sparse: symbol 'p3h2x4x_ibireq' was not declared. Should it be static?
>> drivers/i3c/p3h2x4x/p3h2x4x_i3c_hub_common.c:15:22: sparse: sparse: symbol 'p3h2x4x_regmap_config' was not declared. Should it be static?
>> drivers/i3c/p3h2x4x/p3h2x4x_i3c_hub_common.c:37:26: sparse: sparse: Using plain integer as NULL pointer
   drivers/i3c/p3h2x4x/p3h2x4x_i3c_hub_common.c: note: in included file (through include/linux/module.h, drivers/i3c/p3h2x4x/p3h2x4x_i3c_hub.h):
   include/linux/list.h:83:21: sparse: sparse: self-comparison always evaluates to true

vim +/p3h2x4x_ibireq +9 drivers/i3c/p3h2x4x/p3h2x4x_i3c_hub_common.c

     8	
   > 9	struct i3c_ibi_setup p3h2x4x_ibireq = {
    10			.handler = p3h2x4x_ibi_handler,
    11			.max_payload_len = P3H2x4x_MAX_PAYLOAD_LEN,
    12			.num_slots = P3H2x4x_NUM_SLOTS,
    13	};
    14	
  > 15	struct regmap_config p3h2x4x_regmap_config = {
    16			.reg_bits = P3H2x4x_REG_BITS,
    17			.val_bits = P3H2x4x_VAL_BITS,
    18		};
    19	
    20	/* p3h2x4x ids (i3c) */
    21	static const struct i3c_device_id p3h2x4x_i3c_ids[] = {
    22		I3C_CLASS(I3C_DCR_HUB, NULL),
    23		{ /* sentinel */ },
    24	};
    25	MODULE_DEVICE_TABLE(i3c, p3h2x4x_i3c_ids);
    26	
    27	/* p3h2x4x ids (i2c) */
    28	static const struct i2c_device_id p3h2x4x_i2c_id_table[] = {
    29		{ "nxp-i3c-hub", P3H2x4x_HUB_ID },
    30		{ /* sentinel */ },
    31	};
    32	MODULE_DEVICE_TABLE(i2c, p3h2x4x_i2c_id_table);
    33	
    34	static const struct of_device_id  p3h2x4x_i2c_of_match[] = {
    35		{
    36			.compatible = "nxp,p3h2x4x",
  > 37			.data =  P3H2x4x_HUB_ID,
    38		},
    39		{ /* sentinel */ },
    40	};
    41	MODULE_DEVICE_TABLE(of, p3h2x4x_i2c_of_match);
    42	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

