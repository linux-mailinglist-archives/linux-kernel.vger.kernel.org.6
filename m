Return-Path: <linux-kernel+bounces-175663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 88D908C2356
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 13:28:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF61EB23704
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 11:28:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B01B1172BD7;
	Fri, 10 May 2024 11:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iSzFTf9y"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66CC416FF5A;
	Fri, 10 May 2024 11:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715340370; cv=none; b=W1jXkYbR5aV/Q3nPVhvL/T24qteNud+cfSUBywMH74KCcBGRJGyeMt0Ye3IeNynQd1Z8+CsTv79Kuw9BbZZybV82jn/IzTL6K45N8KTt48r62LxUXUXvKPwSLNSs/ooKU23zVDjC2n144dvhJsH6MhyRZTzRydCjUmpp0P2vYP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715340370; c=relaxed/simple;
	bh=EhJhwV28/b5xd5+o1fMev9i9Pt9MkgYR3jtd/6Qa15k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZE1e1kCn5vxDmya7wur/E+TGasJHdLweMfHu9h+I2xscf3EoEyYkEQhSdiZMuy+DiMoJANa+wxgLFmRzV2Ol2Y27cDiZdhkFVs44faeXXojOnlfO9lW2z0uosBAc1O2mP2OUMoL6pX6ujcjYlH4jKnyx7OmqEWgLwS99WNvbxEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iSzFTf9y; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715340369; x=1746876369;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EhJhwV28/b5xd5+o1fMev9i9Pt9MkgYR3jtd/6Qa15k=;
  b=iSzFTf9yMVlVYSX65SiRqJO6sh95qN2VvTGFtSxazckvwxpBwi+cXaYg
   lq0Xq1a34Yu4nZuVEnWtWjQ79M/H/1NQUnKSxgbCWdFR4vyeYshP0Pjcu
   W8XfsMAhCCvF5nTjSzed5a9vTQ0/Cd3gEpCopBEDLFJQQVuoEScIGYG+R
   Df/70ZLxyEO3Jqhu2Vl6lZ1mQ3ThkZ0Gw8o4Q+bHMwWOzw8O4D673KJJv
   KZZeLtr/e2hZGnqXQYZFot/B4ZIOkBX9CP+zVsJVB27+TjMjHG17gKNkA
   9nUpVlwUx6yanzEGsvNvDNQKrJ0WK3uU3fa0HvcAxE9rYVn4UuFxLpsjE
   A==;
X-CSE-ConnectionGUID: oGhkQzOwSpW36KL23W67Sg==
X-CSE-MsgGUID: r6t5lxElRn+xqddeblqvGw==
X-IronPort-AV: E=McAfee;i="6600,9927,11068"; a="28826558"
X-IronPort-AV: E=Sophos;i="6.08,150,1712646000"; 
   d="scan'208";a="28826558"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2024 04:26:08 -0700
X-CSE-ConnectionGUID: ZqJ0JxwATVyiMsF7O+WVDg==
X-CSE-MsgGUID: UAabKaOsT2qfIBFrFbCyNQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,150,1712646000"; 
   d="scan'208";a="29445375"
Received: from lkp-server01.sh.intel.com (HELO f8b243fe6e68) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 10 May 2024 04:26:03 -0700
Received: from kbuild by f8b243fe6e68 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s5OO1-00063T-0p;
	Fri, 10 May 2024 11:26:01 +0000
Date: Fri, 10 May 2024 19:25:56 +0800
From: kernel test robot <lkp@intel.com>
To: Tomer Maimon <tmaimon77@gmail.com>, mturquette@baylibre.com,
	sboyd@kernel.org, p.zabel@pengutronix.de, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, tali.perry1@gmail.com,
	joel@jms.id.au, venture@google.com, yuenn@google.com,
	benjaminfair@google.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	devicetree@vger.kernel.org, openbmc@lists.ozlabs.org,
	Tomer Maimon <tmaimon77@gmail.com>, linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v24 2/4] reset: npcm: register npcm8xx clock auxiliary
 bus device
Message-ID: <202405101939.Espij82X-lkp@intel.com>
References: <20240509192411.2432066-3-tmaimon77@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240509192411.2432066-3-tmaimon77@gmail.com>

Hi Tomer,

kernel test robot noticed the following build errors:

[auto build test ERROR on clk/clk-next]
[also build test ERROR on pza/reset/next linus/master v6.9-rc7 next-20240510]
[cannot apply to pza/imx-drm/next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Tomer-Maimon/dt-bindings-reset-npcm-add-clock-properties/20240510-072622
base:   https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git clk-next
patch link:    https://lore.kernel.org/r/20240509192411.2432066-3-tmaimon77%40gmail.com
patch subject: [PATCH v24 2/4] reset: npcm: register npcm8xx clock auxiliary bus device
config: i386-buildonly-randconfig-004-20240510 (https://download.01.org/0day-ci/archive/20240510/202405101939.Espij82X-lkp@intel.com/config)
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240510/202405101939.Espij82X-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405101939.Espij82X-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/reset/reset-npcm.c:391:2: error: call to undeclared function 'kfree'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     391 |         kfree(rdev);
         |         ^
   drivers/reset/reset-npcm.c:391:2: note: did you mean 'vfree'?
   include/linux/vmalloc.h:162:13: note: 'vfree' declared here
     162 | extern void vfree(const void *addr);
         |             ^
>> drivers/reset/reset-npcm.c:400:9: error: call to undeclared function 'kzalloc'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     400 |         rdev = kzalloc(sizeof(*rdev), GFP_KERNEL);
         |                ^
   drivers/reset/reset-npcm.c:400:9: note: did you mean 'vzalloc'?
   include/linux/vmalloc.h:142:14: note: 'vzalloc' declared here
     142 | extern void *vzalloc(unsigned long size) __alloc_size(1);
         |              ^
>> drivers/reset/reset-npcm.c:400:7: error: incompatible integer to pointer conversion assigning to 'struct npcm_clock_adev *' from 'int' [-Wint-conversion]
     400 |         rdev = kzalloc(sizeof(*rdev), GFP_KERNEL);
         |              ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/reset/reset-npcm.c:414:3: error: call to undeclared function 'kfree'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     414 |                 kfree(adev);
         |                 ^
   4 errors generated.


vim +/kfree +391 drivers/reset/reset-npcm.c

   385	
   386	static void npcm_clock_adev_release(struct device *dev)
   387	{
   388		struct auxiliary_device *adev = to_auxiliary_dev(dev);
   389		struct npcm_clock_adev *rdev = to_npcm_clock_adev(adev);
   390	
 > 391		kfree(rdev);
   392	}
   393	
   394	static struct auxiliary_device *npcm_clock_adev_alloc(struct npcm_rc_data *rst_data, char *clk_name)
   395	{
   396		struct npcm_clock_adev *rdev;
   397		struct auxiliary_device *adev;
   398		int ret;
   399	
 > 400		rdev = kzalloc(sizeof(*rdev), GFP_KERNEL);
   401		if (!rdev)
   402			return ERR_PTR(-ENOMEM);
   403	
   404		rdev->base = rst_data->base;
   405	
   406		adev = &rdev->adev;
   407		adev->name = clk_name;
   408		adev->dev.parent = rst_data->dev;
   409		adev->dev.release = npcm_clock_adev_release;
   410		adev->id = 555u;
   411	
   412		ret = auxiliary_device_init(adev);
   413		if (ret) {
   414			kfree(adev);
   415			return ERR_PTR(ret);
   416		}
   417	
   418		return adev;
   419	}
   420	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

