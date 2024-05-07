Return-Path: <linux-kernel+bounces-171244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6B4C8BE1C2
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 14:13:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85F731F238A8
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 12:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C116156F48;
	Tue,  7 May 2024 12:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a8uzT7WZ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB7E9156F31;
	Tue,  7 May 2024 12:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715084018; cv=none; b=YeYOejm+C4McbdMK3jq9i5AQVW6NvI/cBFMQkpFxeIIMOXBqR0HvxfrLQLiuixo5UIuurpuQOoA09kf5GWvUZEN8RTMyEI1wZ3tB2hbwn3fUX08FDO9NLUJfOMn8K43a1RtrQL9VkG+aPLD1iy3qVCo6h3YQ3fa+zi9bO+4U73E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715084018; c=relaxed/simple;
	bh=nqDTDgzKgA9YqyhlTfPzGqvHKL1Og1Kte7O7JbMHNCc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T2Gs6zhTlOvwvnvxwueEcJb44WZJdsQ+V0VP/jFLmDAzjHhTyQqhCw2nzXItamwRBVGLClfjzVQPpIfzUKgaU+qVBb18X1t88HGQcLlvsGwlJUwEMqlgrJTJg2V85N4R1PWLwnQs4DYQnrD+luqNtZK8r+bZL6WppF4ZAYgFGb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a8uzT7WZ; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715084018; x=1746620018;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nqDTDgzKgA9YqyhlTfPzGqvHKL1Og1Kte7O7JbMHNCc=;
  b=a8uzT7WZ8vd8qM59v2G1i6MkPBEN4L1MAoK/i9k2b0ZJ1uAYDtvoDbkk
   KWQmTVIreaCVb3sp8reqbes1vgs8zA2nkQVtAZkc1p7RPxDUWxDvtJwiI
   ao/UxwPFETYF5JeioIXFgT6mv/1+vZVS2YPBCQ/x5zuzOqDDHoxl5LnPQ
   ihoQkorwiMjrHtRxBiqqHtI0hkibFQHu7WJ4/yMcUF8Co/tWSvg6f/Au0
   nNJrzO5F9wd1oUfX3WlaOpfP69gBrP3bbavqweB2yXZLAGHaJRx4nAL+8
   r43BRdWA7YCelHYf//V79navrsDgtroi8w1Q81GzqcP4Vsua9TDOYfVAo
   w==;
X-CSE-ConnectionGUID: dNggHSK9TbiBYRwMgHWyJg==
X-CSE-MsgGUID: /6/lxL5RRROj3k+/OnuFyw==
X-IronPort-AV: E=McAfee;i="6600,9927,11065"; a="11030617"
X-IronPort-AV: E=Sophos;i="6.08,261,1712646000"; 
   d="scan'208";a="11030617"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2024 05:13:37 -0700
X-CSE-ConnectionGUID: bawRtxXyRCm4hOPqu9/ehg==
X-CSE-MsgGUID: aM4VgwM0THCU0CBfg14nhw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,261,1712646000"; 
   d="scan'208";a="28582421"
Received: from lkp-server01.sh.intel.com (HELO f8b243fe6e68) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 07 May 2024 05:13:34 -0700
Received: from kbuild by f8b243fe6e68 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s4JhK-0001tQ-2i;
	Tue, 07 May 2024 12:13:30 +0000
Date: Tue, 7 May 2024 20:12:51 +0800
From: kernel test robot <lkp@intel.com>
To: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>, patrick@stwcx.xyz,
	joel@jms.id.au, openbmc@lists.ozlabs.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: oe-kbuild-all@lists.linux.dev,
	Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] ARM: dts: aspeed: yosemite4: add I3C config in DTS
Message-ID: <202405072003.qTcMKOm3-lkp@intel.com>
References: <20240506113306.1283179-1-Delphine_CC_Chiu@wiwynn.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240506113306.1283179-1-Delphine_CC_Chiu@wiwynn.com>

Hi Delphine,

kernel test robot noticed the following build errors:

[auto build test ERROR on robh/for-next]
[also build test ERROR on linus/master v6.9-rc7 next-20240507]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Delphine-CC-Chiu/ARM-dts-aspeed-yosemite4-add-I3C-config-in-DTS/20240506-193458
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/20240506113306.1283179-1-Delphine_CC_Chiu%40wiwynn.com
patch subject: [PATCH v1] ARM: dts: aspeed: yosemite4: add I3C config in DTS
config: arm-multi_v5_defconfig (https://download.01.org/0day-ci/archive/20240507/202405072003.qTcMKOm3-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240507/202405072003.qTcMKOm3-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405072003.qTcMKOm3-lkp@intel.com/

All errors (new ones prefixed by >>):

>> Error: arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts:598.1-6 Label or path i3c0 not found
>> Error: arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts:641.1-6 Label or path i3c1 not found
   FATAL ERROR: Syntax error parsing input tree

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

