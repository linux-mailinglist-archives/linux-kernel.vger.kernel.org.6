Return-Path: <linux-kernel+bounces-319725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 470EB970161
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 11:31:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04FD628136C
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 09:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D35214F119;
	Sat,  7 Sep 2024 09:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G2DuyrRn"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A951B85DC
	for <linux-kernel@vger.kernel.org>; Sat,  7 Sep 2024 09:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725701480; cv=none; b=JjM/zWnRMwH/CeK6qYab/nHBFtUW3FiH2ZXitsT4G0vwF35yYnBvxNHWHn4GTlDdYe76ugFT4wYvo8ONlVMPJN/+bpsfEEoOiBJdLXQieI3EHQpR23sFV0IP88yrDivivUSrG/xtuMRON0G+nDoKTw29kL2ZxLHKPBHHE9Yc2UA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725701480; c=relaxed/simple;
	bh=5rgiPfSgiSkQ2a20vad2k+7ksMwZjw8Ed0gNn4udwEQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c/OqcmTm2sTSJqHGyK72SFzZK5S/KyGUU9weSEMGfE5fiHlSncFF0/GG40CDxV8jxNN8vaZ9aSKvAxw8/d78DAQMnWIviqWj7JDSJliTSfAKgdmnY7tn6xV7ZdOx2usu3buyuJS83mDZLUOdtmvQQILqkuovM9QkN9HCT+tZV+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G2DuyrRn; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725701478; x=1757237478;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5rgiPfSgiSkQ2a20vad2k+7ksMwZjw8Ed0gNn4udwEQ=;
  b=G2DuyrRnYmGr8/Thz6Bt83ipxZsEgNJCd+Eb7p6PUHEnW3buto0kY2G4
   EcQjyyCs0BLkPD/p3HJylY86T1MLKdsuOxvQCA+AWRkES0GtMLCSKohRn
   Eh6mko7Ui2Uu+0RWIW54HBjtAfRKw2utNsjkC06PEg+J1OJENHCPcOL1H
   aXnepHVGcYBjdt4oUgHN5W8KU1PpI+TSCSajX2m5j5R9NPYpWFdQ+1wNI
   R/aBNwFfKxbciIw/g0rl3Y+VMPTut98frnLkIeOtyr+gXGHLSPq0Bvm09
   7sxqfzDFFYgBWpG7mxmJoiUkpULj2LyO+y9/7jB80x8BPxOIxM+gVsz0e
   w==;
X-CSE-ConnectionGUID: sc8nRzB1Q8mC2BWxnLREPA==
X-CSE-MsgGUID: W/3Gnt5FQEeN3kkfQRLqkQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11187"; a="13420522"
X-IronPort-AV: E=Sophos;i="6.10,210,1719903600"; 
   d="scan'208";a="13420522"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2024 02:31:18 -0700
X-CSE-ConnectionGUID: AV1+//C3THmHFO36yo6i8Q==
X-CSE-MsgGUID: C4FsPBRpTSmt2Sbvslxpiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,210,1719903600"; 
   d="scan'208";a="66510215"
Received: from lkp-server01.sh.intel.com (HELO 9c6b1c7d3b50) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 07 Sep 2024 02:31:14 -0700
Received: from kbuild by 9c6b1c7d3b50 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1smrmh-000COC-1S;
	Sat, 07 Sep 2024 09:31:11 +0000
Date: Sat, 7 Sep 2024 17:30:44 +0800
From: kernel test robot <lkp@intel.com>
To: Alexander Stein <alexander.stein@ew.tq-group.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Paul Gazzillo <paul@pgazz.com>,
	Necip Fazil Yildiran <fazilyildiran@gmail.com>,
	oe-kbuild-all@lists.linux.dev,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	dri-devel@lists.freedesktop.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] drm/imx: Add missing DRM_BRIDGE_CONNECTOR dependency
Message-ID: <202409071746.fBgS0kyW-lkp@intel.com>
References: <20240906063857.2223442-1-alexander.stein@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240906063857.2223442-1-alexander.stein@ew.tq-group.com>

Hi Alexander,

kernel test robot noticed the following build warnings:

[auto build test WARNING on next-20240905]
[cannot apply to v6.11-rc6 v6.11-rc5 v6.11-rc4 linus/master v6.11-rc6]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Alexander-Stein/drm-imx-Add-missing-DRM_BRIDGE_CONNECTOR-dependency/20240906-144116
base:   next-20240905
patch link:    https://lore.kernel.org/r/20240906063857.2223442-1-alexander.stein%40ew.tq-group.com
patch subject: [PATCH 1/1] drm/imx: Add missing DRM_BRIDGE_CONNECTOR dependency
config: alpha-kismet-CONFIG_DRM_BRIDGE_CONNECTOR-CONFIG_DRM_IMX_LDB-0-0 (https://download.01.org/0day-ci/archive/20240907/202409071746.fBgS0kyW-lkp@intel.com/config)
reproduce: (https://download.01.org/0day-ci/archive/20240907/202409071746.fBgS0kyW-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409071746.fBgS0kyW-lkp@intel.com/

kismet warnings: (new ones prefixed by >>)
>> kismet: WARNING: unmet direct dependencies detected for DRM_BRIDGE_CONNECTOR when selected by DRM_IMX_LDB
   WARNING: unmet direct dependencies detected for DRM_BRIDGE_CONNECTOR
     Depends on [n]: HAS_IOMEM [=y] && DRM [=y] && DRM_DISPLAY_HELPER [=n]
     Selected by [y]:
     - DRM_IMX_LDB [=y] && HAS_IOMEM [=y] && DRM [=y] && DRM_IMX [=y] && COMMON_CLK [=y]

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

