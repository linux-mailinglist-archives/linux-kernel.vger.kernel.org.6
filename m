Return-Path: <linux-kernel+bounces-185446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72BB28CB508
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 23:03:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BF6F281B94
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 21:03:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AAD9149C60;
	Tue, 21 May 2024 21:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gvD2zmg5"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C52050276;
	Tue, 21 May 2024 21:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716325409; cv=none; b=iXn1cEYoy1zzAsYhEHYmfYFDFdnOTycPOw8ayngdb+6/euHNoq+EPoX1h09Dr6rFV9OQyfpwgxYrsVJ/KKc7aUlJG1z46B084sxl57HaJpGYBBh7SDY3PaeRDjk/ltfus+EBjLeenXgg8uq030dMxNO0DshE6UYmAscR88hrA50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716325409; c=relaxed/simple;
	bh=3Qqn1U062QTlYPQyqwB5Qbenc7wjbLzJgvCPQw09baU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lazC3IEbugyvhWb0iMqGbyBU+pw2gH/j2P3d7kXOvCUc0ewK2bXyjpJuLW8/g+t/ll1uHdPsTb1qYCOuRxponZLyXak82FkinFG7/EfL/Prc2XOuvcUuf2jRxIcIniItQYsu4r8VpPQSHeFxmmERq3X/IJj63LJgJZgc/5yZ+AQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gvD2zmg5; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716325405; x=1747861405;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3Qqn1U062QTlYPQyqwB5Qbenc7wjbLzJgvCPQw09baU=;
  b=gvD2zmg5O4PhGQQug5UpVftV3Q5P9LtzWC3xYBPIsRYIYU2nljqoym/j
   kSpM5oZ3CPH6Fuyp2e7cGdQROxKzGIVFYNpoflDruLWfNXmO4ggh6A6YR
   ADbFjPsDlO/4raLmK/KAKAB00IN+nS6qS7vgd69nnKP6dwbXJz/hPKb0Z
   SlMdi6SRNYPM6/kKojKfBbiAUdkzWpz+fI08valaYqr73iaOQUmxCiUi+
   ga2vWEjBFJSFMIG+App+Bp0tkIouD8R2MRW2fGqAV12LrmQo9kmKcTupr
   QZ1kYKSPZ7e3L8TcEuqoYuUy1pmYpHoeVlW18KkF7fhRDCH6mRHf3LQeu
   g==;
X-CSE-ConnectionGUID: jEMepWa4RLyKnoub8v4R6g==
X-CSE-MsgGUID: cJn6XWYRQr+wsqHmXVix5g==
X-IronPort-AV: E=McAfee;i="6600,9927,11079"; a="23959524"
X-IronPort-AV: E=Sophos;i="6.08,178,1712646000"; 
   d="scan'208";a="23959524"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2024 14:03:24 -0700
X-CSE-ConnectionGUID: pXBEd/GGQp2uY8jsR5UZ9w==
X-CSE-MsgGUID: C/u9NIUUQcCzg+Ch1rFlQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,178,1712646000"; 
   d="scan'208";a="33658115"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by orviesa007.jf.intel.com with ESMTP; 21 May 2024 14:03:18 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s9WdM-0000kJ-2v;
	Tue, 21 May 2024 21:03:04 +0000
Date: Wed, 22 May 2024 05:01:53 +0800
From: kernel test robot <lkp@intel.com>
To: keith <keith.zhao@starfivetech.com>, andrzej.hajda@intel.com,
	neil.armstrong@linaro.org, rfoss@kernel.org,
	Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
	jernej.skrabec@gmail.com, maarten.lankhorst@linux.intel.com,
	mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
	daniel@ffwll.ch, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, hjc@rock-chips.com, heiko@sntech.de,
	andy.yan@rock-chips.com, xingyu.wu@starfivetech.com,
	p.zabel@pengutronix.de, jack.zhu@starfivetech.com,
	shengyang.chen@starfivetech.com
Cc: oe-kbuild-all@lists.linux.dev, dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, keith.zhao@starfivetech.com
Subject: Re: [PATCH v4 04/10] drm/vs: Add hardware funcs for vs.
Message-ID: <202405220449.sjkbwf6F-lkp@intel.com>
References: <20240521105817.3301-5-keith.zhao@starfivetech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240521105817.3301-5-keith.zhao@starfivetech.com>

Hi keith,

kernel test robot noticed the following build warnings:

[auto build test WARNING on drm-misc/drm-misc-next]
[also build test WARNING on linus/master next-20240521]
[cannot apply to robh/for-next rockchip/for-next v6.9]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/keith/dt-bindings-display-Add-YAML-schema-for-JH7110-display-pipeline/20240521-110316
base:   git://anongit.freedesktop.org/drm/drm-misc drm-misc-next
patch link:    https://lore.kernel.org/r/20240521105817.3301-5-keith.zhao%40starfivetech.com
patch subject: [PATCH v4 04/10] drm/vs: Add hardware funcs for vs.
config: arc-randconfig-r123-20240522 (https://download.01.org/0day-ci/archive/20240522/202405220449.sjkbwf6F-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20240522/202405220449.sjkbwf6F-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405220449.sjkbwf6F-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   drivers/gpu/drm/verisilicon/vs_dc_hw.c: note: in included file (through include/linux/mmzone.h, include/linux/gfp.h, include/linux/stackdepot.h, ...):
   include/linux/page-flags.h:241:46: sparse: sparse: self-comparison always evaluates to false
   include/linux/page-flags.h:241:46: sparse: sparse: self-comparison always evaluates to false
>> drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse:     got void *
>> drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse:     got void *
>> drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse:     got void *
>> drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse:     got void *
>> drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse:     got void *
>> drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse:     got void *
>> drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse:     got void *
>> drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse:     got void *
>> drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse:     got void *
>> drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse:     got void *
>> drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse:     got void *
>> drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse:     got void *
>> drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse:     got void *
>> drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse:     got void *
>> drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse:     got void *
>> drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse:     got void *
>> drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse:     got void *
>> drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse:     got void *
>> drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse:     got void *
>> drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse:     got void *
>> drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse:     got void *
>> drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse:     got void *
>> drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse:     got void *
>> drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse:     got void *
>> drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse:     got void *
>> drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse:     got void *
>> drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse:     got void *
>> drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse:     got void *
>> drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse:     got void *
>> drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse:     got void *
>> drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse:     got void *
>> drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse:     got void *
>> drivers/gpu/drm/verisilicon/vs_dc_hw.c:271:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:271:21: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:271:21: sparse:     got void *
>> drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse:     got void *
>> drivers/gpu/drm/verisilicon/vs_dc_hw.c:271:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:271:21: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:271:21: sparse:     got void *
>> drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse:     got void *
>> drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse:     got void *
>> drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse:     got void *
>> drivers/gpu/drm/verisilicon/vs_dc_hw.c:271:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:271:21: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:271:21: sparse:     got void *
>> drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse:     got void *
>> drivers/gpu/drm/verisilicon/vs_dc_hw.c:271:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:271:21: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:271:21: sparse:     got void *
>> drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse:     got void *
>> drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse:     got void *
>> drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse:     got void *
>> drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse:     got void *
>> drivers/gpu/drm/verisilicon/vs_dc_hw.c:271:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:271:21: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:271:21: sparse:     got void *
>> drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse:     got void *
>> drivers/gpu/drm/verisilicon/vs_dc_hw.c:271:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:271:21: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:271:21: sparse:     got void *
>> drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse:     got void *
>> drivers/gpu/drm/verisilicon/vs_dc_hw.c:271:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:271:21: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:271:21: sparse:     got void *
>> drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse:     got void *
>> drivers/gpu/drm/verisilicon/vs_dc_hw.c:271:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:271:21: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:271:21: sparse:     got void *
>> drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse:     got void *
>> drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse:     got void *
>> drivers/gpu/drm/verisilicon/vs_dc_hw.c:271:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:271:21: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:271:21: sparse:     got void *
>> drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse:     got void *
>> drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse:     got void *
>> drivers/gpu/drm/verisilicon/vs_dc_hw.c:271:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:271:21: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:271:21: sparse:     got void *
>> drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse:     got void *
>> drivers/gpu/drm/verisilicon/vs_dc_hw.c:271:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:271:21: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:271:21: sparse:     got void *
>> drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse:     got void *
>> drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse:     got void *
>> drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse:     got void *
>> drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse:     got void *
>> drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse:     got void *
>> drivers/gpu/drm/verisilicon/vs_dc_hw.c:271:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:271:21: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:271:21: sparse:     got void *
>> drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse:     got void *
>> drivers/gpu/drm/verisilicon/vs_dc_hw.c:271:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:271:21: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:271:21: sparse:     got void *
>> drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse:     got void *
>> drivers/gpu/drm/verisilicon/vs_dc_hw.c:271:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:271:21: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:271:21: sparse:     got void *
>> drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse:     got void *
>> drivers/gpu/drm/verisilicon/vs_dc_hw.c:271:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:271:21: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:271:21: sparse:     got void *
>> drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse:     got void *
>> drivers/gpu/drm/verisilicon/vs_dc_hw.c:271:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:271:21: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:271:21: sparse:     got void *
>> drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse:     got void *
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:261:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:261:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:261:9: sparse:     got void *
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:261:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:261:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:261:9: sparse:     got void *
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:256:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:256:16: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:256:16: sparse:     got void *
>> drivers/gpu/drm/verisilicon/vs_dc_hw.c:271:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:271:21: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:271:21: sparse:     got void *
>> drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse:     got void *
>> drivers/gpu/drm/verisilicon/vs_dc_hw.c:271:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:271:21: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:271:21: sparse:     got void *
>> drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse:     got void *
>> drivers/gpu/drm/verisilicon/vs_dc_hw.c:271:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:271:21: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:271:21: sparse:     got void *
>> drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse:     got void *
>> drivers/gpu/drm/verisilicon/vs_dc_hw.c:271:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:271:21: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:271:21: sparse:     got void *
>> drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse:     got void *
>> drivers/gpu/drm/verisilicon/vs_dc_hw.c:271:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:271:21: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:271:21: sparse:     got void *
>> drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse:     got void *
>> drivers/gpu/drm/verisilicon/vs_dc_hw.c:271:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:271:21: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:271:21: sparse:     got void *
>> drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse:     got void *
>> drivers/gpu/drm/verisilicon/vs_dc_hw.c:271:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:271:21: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:271:21: sparse:     got void *
>> drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse:     got void *
>> drivers/gpu/drm/verisilicon/vs_dc_hw.c:271:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:271:21: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:271:21: sparse:     got void *
>> drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse:     got void *
>> drivers/gpu/drm/verisilicon/vs_dc_hw.c:271:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:271:21: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:271:21: sparse:     got void *
>> drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse:     got void *
>> drivers/gpu/drm/verisilicon/vs_dc_hw.c:271:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:271:21: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:271:21: sparse:     got void *
>> drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse:     got void *
>> drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse:     got void *
>> drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse:     got void *
>> drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse:     got void *
>> drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse:     got void *
>> drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse:     got void *
>> drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse:     got void *
>> drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse:     got void *
>> drivers/gpu/drm/verisilicon/vs_dc_hw.c:271:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:271:21: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:271:21: sparse:     got void *
>> drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse:     got void *
>> drivers/gpu/drm/verisilicon/vs_dc_hw.c:271:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:271:21: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:271:21: sparse:     got void *
>> drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse:     got void *
>> drivers/gpu/drm/verisilicon/vs_dc_hw.c:271:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:271:21: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:271:21: sparse:     got void *
>> drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse:     got void *
>> drivers/gpu/drm/verisilicon/vs_dc_hw.c:271:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:271:21: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:271:21: sparse:     got void *
>> drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse:     got void *
>> drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse:     got void *
>> drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse:     got void *
>> drivers/gpu/drm/verisilicon/vs_dc_hw.c:271:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:271:21: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:271:21: sparse:     got void *
>> drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse:     got void *
>> drivers/gpu/drm/verisilicon/vs_dc_hw.c:271:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:271:21: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:271:21: sparse:     got void *
>> drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse:     got void *
>> drivers/gpu/drm/verisilicon/vs_dc_hw.c:271:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:271:21: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:271:21: sparse:     got void *
>> drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse:     got void *
>> drivers/gpu/drm/verisilicon/vs_dc_hw.c:271:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:271:21: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:271:21: sparse:     got void *
>> drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse:     got void *
>> drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse:     got void *
>> drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse:     got void *
>> drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse:     got void *
>> drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse:     got void *
>> drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse:     got void *
>> drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse:     got void *
>> drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/gpu/drm/verisilicon/vs_dc_hw.c:266:9: sparse:     got void *

vim +266 drivers/gpu/drm/verisilicon/vs_dc_hw.c

   263	
   264	static inline void dc_write(struct dc_hw *hw, u32 reg, u32 value)
   265	{
 > 266		writel(value, hw->reg_base + reg - DC_REG_BASE);
   267	}
   268	
   269	static inline u32 dc_read(struct dc_hw *hw, u32 reg)
   270	{
 > 271		u32 value = readl(hw->reg_base + reg - DC_REG_BASE);
   272	
   273		return value;
   274	}
   275	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

