Return-Path: <linux-kernel+bounces-287892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F0FB952DCE
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 14:00:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C1BFCB276F9
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 12:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F41C4176AC6;
	Thu, 15 Aug 2024 12:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PX5pWGM+"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96410146A6D;
	Thu, 15 Aug 2024 12:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723723225; cv=none; b=ZHhqjkxddCoI9EvSLTjeOoRssxXd0dxgnT8K8eRN1D/IlWfTYrSJMNnQdbvaEe2hD/LZte8zgmKNTm7KCNZ5Fne4e9KIuh3br7CRJRpMQzZUzbx0jni4DgGtPHkRJBOgcOuaMzAPI4dQcfr0BiUKI3xgkcEQZRQlG4TsV9LAljI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723723225; c=relaxed/simple;
	bh=+fvBVhqwVxnnLELp45LxE5B3Ly84i4Yh9U1qnszQeKk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h6gCUfltIp707rn4h+7M1Q+gE4XdEot8BVx31aFK5tOJgjvmF5FRFfHm2++xP2xVuSC9hzaLfjLA2trumaFwXBPk2WknS5PD+PKeZA8H3+wp8Wys47pj7GNRFQQGH+4Ph+t5W8hSZ8cfSiaxmTSyWB1ZtWke1DJHtuunARLMApc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PX5pWGM+; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723723221; x=1755259221;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+fvBVhqwVxnnLELp45LxE5B3Ly84i4Yh9U1qnszQeKk=;
  b=PX5pWGM+QFn9O/v7OFVKnW+8uyv78fdf71FV1fIM/G9Kh2vNRyiHcvNt
   LLy0GSuiUwZrKU8VxBnv5hWHqwfLHQhgbc725aA8WoydBNncW3Dep/Imq
   qDnxjhExJ4kIGGWnEsTY9lVhgECK8r18hSFvzMYFUld19D2R9KS976DgF
   QvEQx2/v7F1StHJf1xn5OdxUIWi9bVVvzkf+nURt7zISkZdixGaM1BzQt
   aOaSFvJme2BqItI3b9+83Q9WTnCJWdyttpGFeLbCAvbdP6s9oR5XgyPha
   xFJzT0MYQaJ5koey/M79UA/FEZ5whXEaJL55TrpcYTAFP6ewh6XRVwDYb
   A==;
X-CSE-ConnectionGUID: OxaBiv3wS86nM/2im+SNMw==
X-CSE-MsgGUID: K+lDSLgFTjSaX2Wu6TXjbg==
X-IronPort-AV: E=McAfee;i="6700,10204,11164"; a="22135676"
X-IronPort-AV: E=Sophos;i="6.10,148,1719903600"; 
   d="scan'208";a="22135676"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2024 05:00:18 -0700
X-CSE-ConnectionGUID: 9pGFL3JARHqhgTEDSbWx6Q==
X-CSE-MsgGUID: FzBAoAyVSieqIx8P4Ogn+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,148,1719903600"; 
   d="scan'208";a="58960860"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 15 Aug 2024 05:00:15 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1seZ9J-0003Xg-15;
	Thu, 15 Aug 2024 12:00:13 +0000
Date: Thu, 15 Aug 2024 20:00:06 +0800
From: kernel test robot <lkp@intel.com>
To: Frank Li <Frank.Li@nxp.com>, Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shenghao Ding <shenghao-ding@ti.com>, Kevin Lu <kevin-lu@ti.com>,
	Baojun Xu <baojun.xu@ti.com>, Sebastian Reichel <sre@kernel.org>,
	"open list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." <linux-sound@vger.kernel.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"moderated list:TEXAS INSTRUMENTS AUDIO (ASoC/HDA) DRIVERS" <alsa-devel@alsa-project.org>
Cc: oe-kbuild-all@lists.linux.dev, imx@lists.linux.dev
Subject: Re: [PATCH 1/1] ASoC: dt-bindings: Convert tpa6130a2.txt to yaml
Message-ID: <202408151906.gY9zpl8b-lkp@intel.com>
References: <20240814175129.4027097-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240814175129.4027097-1-Frank.Li@nxp.com>

Hi Frank,

kernel test robot noticed the following build warnings:

[auto build test WARNING on broonie-sound/for-next]
[also build test WARNING on robh/for-next linus/master v6.11-rc3 next-20240815]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Frank-Li/ASoC-dt-bindings-Convert-tpa6130a2-txt-to-yaml/20240815-021426
base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next
patch link:    https://lore.kernel.org/r/20240814175129.4027097-1-Frank.Li%40nxp.com
patch subject: [PATCH 1/1] ASoC: dt-bindings: Convert tpa6130a2.txt to yaml
reproduce: (https://download.01.org/0day-ci/archive/20240815/202408151906.gY9zpl8b-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408151906.gY9zpl8b-lkp@intel.com/

All warnings (new ones prefixed by >>):

   Warning: Documentation/userspace-api/netlink/index.rst references a file that doesn't exist: Documentation/networking/netlink_spec/index.rst
   Warning: Documentation/userspace-api/netlink/specs.rst references a file that doesn't exist: Documentation/networking/netlink_spec/index.rst
   Warning: MAINTAINERS references a file that doesn't exist: Documentation/devicetree/bindings/reserved-memory/qcom
   Warning: MAINTAINERS references a file that doesn't exist: Documentation/devicetree/bindings/display/exynos/
   Warning: MAINTAINERS references a file that doesn't exist: Documentation/devicetree/bindings/misc/fsl,qoriq-mc.txt
>> Warning: MAINTAINERS references a file that doesn't exist: Documentation/devicetree/bindings/sound/tpa6130a2.txt
   Using alabaster theme

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

