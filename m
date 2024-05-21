Return-Path: <linux-kernel+bounces-185439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A9258CB4F0
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 22:53:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8ABD1F22A23
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 20:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69DF8149C6D;
	Tue, 21 May 2024 20:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GPMGC4rc"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B72A7F49F;
	Tue, 21 May 2024 20:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716324798; cv=none; b=DhC3TdeLy6r6mY5OSIp5RNqUdeA8D/n5L3Dhla5ohfl8kdRsWT6/Tab77+UD/1DPt/3gyqUPoEVvf0CpEm4KuCbiLFBI/Cg+30wqHtSxDgZqDxZEYwjZ/hXX53WjhTFGrwLi0OwCCGwh0s65fT4jMZTgazGXpPNqJ90yN66Dblk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716324798; c=relaxed/simple;
	bh=Nk2m5drImbAFQMh1gv5SA4MPVptzBY8LHz5L3E6IPO4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iaOVsQrCWhrP8t3iDVtgSv4bcPiYJHI0koUYN6ej8x5QE0060Y7bX2yE96bKp2GEs4IDAnUTWr0SLo7Sm4RbdKVb5SVOKp9EwlXJUc4VoXBT06afo/Md/9Udb1fo4tPlpIZyZj4lL7kuW06aHaaKHLtJYlg+LWUvFqhHzJ6Mpm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GPMGC4rc; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716324797; x=1747860797;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Nk2m5drImbAFQMh1gv5SA4MPVptzBY8LHz5L3E6IPO4=;
  b=GPMGC4rcacZTBYqUmjHjHsdfJ+WG21uAyqekWFbTeyzdzgnLN8BrDTn4
   nw3ShJS5HFaqhABtfnFvjaXdAMfaOcx7ye3wFi+q+QpKdGF92anCqk/99
   RqacaRP/LSvlfvWMtZulS0aF5J4ilIQdz+R3TwR0nhrlTEy4hDyrrTH75
   rBJ/isi2tSfxcNDO7RiRHud0OueDkGMKfpKijwOlVQdUhWUIZAzWZ4+gG
   watrrpVHBKMfwFY1HeFN1Ludb/UPjDKw6XT2XfKuoHLC58MtlrZzgZTFf
   wrp3aVAn3g06bK2gn0yLTft1Y5+iayJEy7ByL5SA1fm0V0QRsQC1e+w6h
   w==;
X-CSE-ConnectionGUID: m93Ff2DATz+RR1tkZdL84w==
X-CSE-MsgGUID: CEGwIdCPRtSBRfqCucnNQw==
X-IronPort-AV: E=McAfee;i="6600,9927,11079"; a="30069560"
X-IronPort-AV: E=Sophos;i="6.08,178,1712646000"; 
   d="scan'208";a="30069560"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2024 13:53:16 -0700
X-CSE-ConnectionGUID: xGwXe5saR4eZACAD1ZMX5A==
X-CSE-MsgGUID: Bh7ZAIoNSDSkYE0WYniw5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,178,1712646000"; 
   d="scan'208";a="37816431"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by orviesa003.jf.intel.com with ESMTP; 21 May 2024 13:53:08 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s9WTa-0000ih-1m;
	Tue, 21 May 2024 20:52:55 +0000
Date: Wed, 22 May 2024 04:50:53 +0800
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
Cc: Paul Gazzillo <paul@pgazz.com>,
	Necip Fazil Yildiran <fazilyildiran@gmail.com>,
	oe-kbuild-all@lists.linux.dev, dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, keith.zhao@starfivetech.com
Subject: Re: [PATCH v4 04/10] drm/vs: Add hardware funcs for vs.
Message-ID: <202405220427.loHTDi8t-lkp@intel.com>
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
config: arc-kismet-CONFIG_DMA_CMA-CONFIG_DRM_VERISILICON_DC8200-0-0 (https://download.01.org/0day-ci/archive/20240522/202405220427.loHTDi8t-lkp@intel.com/config)
reproduce: (https://download.01.org/0day-ci/archive/20240522/202405220427.loHTDi8t-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405220427.loHTDi8t-lkp@intel.com/

kismet warnings: (new ones prefixed by >>)
>> kismet: WARNING: unmet direct dependencies detected for DMA_CMA when selected by DRM_VERISILICON_DC8200
   WARNING: unmet direct dependencies detected for DMA_CMA
     Depends on [n]: HAVE_DMA_CONTIGUOUS [=n] && CMA [=y]
     Selected by [y]:
     - DRM_VERISILICON_DC8200 [=y] && HAS_IOMEM [=y] && DRM [=y]

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

