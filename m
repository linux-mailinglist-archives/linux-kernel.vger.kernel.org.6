Return-Path: <linux-kernel+bounces-196981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BF1C8D6490
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 16:31:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2CB8EB27CDF
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 14:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79DA9481CE;
	Fri, 31 May 2024 14:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b4q0BVzH"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 761D436AF8;
	Fri, 31 May 2024 14:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717165867; cv=none; b=LvJ6S8BF0dyLovSpcRnW6FUV78et7DOsAD19fDr/Pe3xb+QvDeEyK9/2H0RegNK7SXNRQCREONl7c77PW2Lfbh2kAwg1lkTNwH7O4Yw0aoGS4yZNAKldIwc8lnTvYF08DzyfOzY1RQllu4AiHDvbjCM5xoqQal4y8PcH1oFd7oI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717165867; c=relaxed/simple;
	bh=JvE95VldL4Wm6uxSEGwGimYI1FBYwpi2JYmljsv3ZAA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZxT5ztcQuU1pSz7t7L3Nn927KNp+67NCezMgJWDJl5ELBwfcz8duXuBK3DXAh99kOTNC+RtFBs3I1+7X3oX9+q94PJm4E9HA3Aa+7XSz7g5hKvNgrMAiWCYSKEYw7z0GKbpvmvq1WgwGCjN5AadulsNaox3NCBCsX6NW87p2u+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b4q0BVzH; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717165867; x=1748701867;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JvE95VldL4Wm6uxSEGwGimYI1FBYwpi2JYmljsv3ZAA=;
  b=b4q0BVzHOW2xK2I1bjLX/1wu+QOVP2TRIG8vbl8JX6y1hLm1PGE9mcdm
   y1lNZ7o5w3FQQEPc9iU5DnHp7J12uMFwbuOpQ8PcQOEAnn/6h+r6bOngG
   pLzvIaYblMt8enQG+BHJr341Ev+gayBX0yQxnxWUGKxKLGPdRnxiJhMDu
   i9dIKt6kx09tIwLxnJ55DoZi+KmvL+tIFIpDUNfFygejyp1vz8WCRzHTH
   MaCVDxP9CkTd6ea3gPyB1FVwoLA5h3l9ql5zTBDJyyEBqpROPZUej0eGO
   Im2hFFJezB9r8pmA3RIEy9xEjeuXJlm3AiK8dmQ6TTJArjswSXxB+3kcC
   A==;
X-CSE-ConnectionGUID: DgQSZmW2S5Oe0YT++RnP+A==
X-CSE-MsgGUID: 4g3Ea7UxQ2uBowTLfGIp/A==
X-IronPort-AV: E=McAfee;i="6600,9927,11088"; a="36242690"
X-IronPort-AV: E=Sophos;i="6.08,204,1712646000"; 
   d="scan'208";a="36242690"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2024 07:31:06 -0700
X-CSE-ConnectionGUID: 0FTBQ/SASnC/QvwnryK7fA==
X-CSE-MsgGUID: KgUFmX8zTD2bMRaXcoAYwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,204,1712646000"; 
   d="scan'208";a="73666970"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2024 07:30:59 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1sD3HS-0000000CUNA-19F6;
	Fri, 31 May 2024 17:30:54 +0300
Date: Fri, 31 May 2024 17:30:53 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: kernel test robot <lkp@intel.com>
Cc: Rob Herring <robh@kernel.org>, Weidong Wang <wangweidong.a@awinic.com>,
	Mark Brown <broonie@kernel.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	Shenghao Ding <shenghao-ding@ti.com>,
	Marco Felsch <m.felsch@pengutronix.de>,
	Alper Nebi Yasak <alpernebiyasak@gmail.com>,
	Chancel Liu <chancel.liu@nxp.com>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
	alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
	linuxppc-dev@lists.ozlabs.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, llvm@lists.linux.dev,
	oe-kbuild-all@lists.linux.dev, Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	James Schulman <james.schulman@cirrus.com>,
	David Rhodes <david.rhodes@cirrus.com>,
	Richard Fitzgerald <rf@opensource.cirrus.com>,
	Kevin Lu <kevin-lu@ti.com>, Baojun Xu <baojun.xu@ti.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Banajit Goswami <bgoswami@quicinc.com>,
	Shengjiu Wang <shengjiu.wang@gmail.com>,
	Xiubo Li <Xiubo.Lee@gmail.com>
Subject: Re: [PATCH v1 1/6] ASoC: codecs: Remove unused of_gpio.h
Message-ID: <ZlnfHWx3uPzCoJwX@smile.fi.intel.com>
References: <20240530230037.1156253-2-andriy.shevchenko@linux.intel.com>
 <202405311428.tzsBMIPs-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202405311428.tzsBMIPs-lkp@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, May 31, 2024 at 02:42:33PM +0800, kernel test robot wrote:
> Hi Andy,
> 
> kernel test robot noticed the following build errors:
> 
> [auto build test ERROR on broonie-sound/for-next]
> [also build test ERROR on shawnguo/for-next rockchip/for-next linus/master v6.10-rc1 next-20240529]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Andy-Shevchenko/ASoC-codecs-Remove-unused-of_gpio-h/20240531-070350
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next
> patch link:    https://lore.kernel.org/r/20240530230037.1156253-2-andriy.shevchenko%40linux.intel.com
> patch subject: [PATCH v1 1/6] ASoC: codecs: Remove unused of_gpio.h
> config: i386-buildonly-randconfig-006-20240531 (https://download.01.org/0day-ci/archive/20240531/202405311428.tzsBMIPs-lkp@intel.com/config)
> compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240531/202405311428.tzsBMIPs-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202405311428.tzsBMIPs-lkp@intel.com/

My gosh, the whoever wrote the GPIO code in that driver has no clue what they
are doing. It's a pure mess.

-- 
With Best Regards,
Andy Shevchenko



