Return-Path: <linux-kernel+bounces-205003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 116D28FF609
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 22:45:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1320C1C21615
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 20:45:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 666A653368;
	Thu,  6 Jun 2024 20:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P10+sQlB"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F6DE69D2F;
	Thu,  6 Jun 2024 20:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717706713; cv=none; b=k4eDZ3sV0c8usLes/rUi2XmN9Bvt8d04RKbZX9ndPg5mHxZ6byWXXl0leAC44svuolMTP6tDVuaCsHQgZHaXh/8jKbJvF+Y2XdcnbENs54x988ZvzjXToGLSGOMaRbdWpbCL+GDUIigVDgA80PXTOX6gTFaMelLpdvSos3YxE54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717706713; c=relaxed/simple;
	bh=zbRLG6muhRQTIckVj+vQW1FPTwrq3szBPYUQZ1sHcsA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QKHEyW/kHTVpBMAHbFf4rCkr/B6DSgxSTl61PGoWnZ8ZBrLZSgE7i08LB9hEsofc7Wf449+AZemzeicWaV6cr4vDl/NCi/AK2I69OkAD/oZwyfp6rlFn2sQDLHx9AHCz5dgE/sw33kaoqpSvzDlfx1g97ifm9FuWZsoKIrVH7Cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P10+sQlB; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717706712; x=1749242712;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zbRLG6muhRQTIckVj+vQW1FPTwrq3szBPYUQZ1sHcsA=;
  b=P10+sQlB/kYxArFjU4VAUjWfPHxqXgfFKaNkFCA/seuZzWrl3kE5fJpY
   +4cuNINK0G5Lwb6p4PRkKzbDQfjX1cbrgrniy0kw3zmiRki/ksYN54+NJ
   1S+KAf8FxlHk81EEZXO7QJJ5evAZRT8cLgCdjb9xxRGCSL/fte1u8kIn2
   v54uOZrPWvIeh1CFdjgCM0aJLse1CF+/I3IDoqoSKY6nvkGQ2ZeBQF50b
   Xuwlv5g57Gk67N9kSG5TqJgwWp89EV1oX0dd9pTmGd2D68M6/2qTT38aq
   xHw2pPme1d1IUhwBamtxXq+pKgqcT84E03cWQR4LzdPVFPpIefw96VY8R
   Q==;
X-CSE-ConnectionGUID: bh3r+EZiQjuNdrhc+TwDcg==
X-CSE-MsgGUID: a+dyHy9gTFG60wDSQIyHeg==
X-IronPort-AV: E=McAfee;i="6600,9927,11095"; a="14212268"
X-IronPort-AV: E=Sophos;i="6.08,219,1712646000"; 
   d="scan'208";a="14212268"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2024 13:45:11 -0700
X-CSE-ConnectionGUID: jzM1qSOBTnasmUwsB8PmmA==
X-CSE-MsgGUID: dsrwBcGNQd2mV0C8U3bo5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,219,1712646000"; 
   d="scan'208";a="42528870"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by fmviesa005.fm.intel.com with ESMTP; 06 Jun 2024 13:45:07 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sFJyr-0003go-2X;
	Thu, 06 Jun 2024 20:45:05 +0000
Date: Fri, 7 Jun 2024 04:44:37 +0800
From: kernel test robot <lkp@intel.com>
To: Shresth Prasad <shresthprasad7@gmail.com>, vkoul@kernel.org,
	kishon@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, heiko@sntech.de
Cc: oe-kbuild-all@lists.linux.dev, linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org, javier.carrasco.cruz@gmail.com,
	Shresth Prasad <shresthprasad7@gmail.com>
Subject: Re: [PATCH] dt-bindings: phy: rockchip-emmc-phy: Convert to dtschema
Message-ID: <202406070419.TJxm1rXC-lkp@intel.com>
References: <20240606184135.11065-2-shresthprasad7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240606184135.11065-2-shresthprasad7@gmail.com>

Hi Shresth,

kernel test robot noticed the following build warnings:

[auto build test WARNING on robh/for-next]
[also build test WARNING on linus/master v6.10-rc2 next-20240606]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Shresth-Prasad/dt-bindings-phy-rockchip-emmc-phy-Convert-to-dtschema/20240607-024538
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/20240606184135.11065-2-shresthprasad7%40gmail.com
patch subject: [PATCH] dt-bindings: phy: rockchip-emmc-phy: Convert to dtschema
reproduce: (https://download.01.org/0day-ci/archive/20240607/202406070419.TJxm1rXC-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406070419.TJxm1rXC-lkp@intel.com/

All warnings (new ones prefixed by >>):

   Warning: Documentation/devicetree/bindings/power/wakeup-source.txt references a file that doesn't exist: Documentation/devicetree/bindings/input/qcom,pm8xxx-keypad.txt
   Warning: Documentation/devicetree/bindings/regulator/siliconmitus,sm5703-regulator.yaml references a file that doesn't exist: Documentation/devicetree/bindings/mfd/siliconmitus,sm5703.yaml
>> Warning: Documentation/devicetree/bindings/soc/rockchip/grf.yaml references a file that doesn't exist: Documentation/devicetree/bindings/phy/rockchip-emmc-phy.txt
   Warning: MAINTAINERS references a file that doesn't exist: Documentation/devicetree/bindings/reserved-memory/qcom
   Warning: MAINTAINERS references a file that doesn't exist: Documentation/devicetree/bindings/display/exynos/
   Using alabaster theme

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

