Return-Path: <linux-kernel+bounces-546902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BA5AA50024
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 14:17:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1DD6F7A2CAD
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 13:16:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC7712475D0;
	Wed,  5 Mar 2025 13:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bRVE3pdR"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92ABA2046A8;
	Wed,  5 Mar 2025 13:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741180561; cv=none; b=vDVpPkqSZlZ/1F3ePIXRH3383X+GQxEqsCqKv5u0jBIP3c6MStmjRYxgwC4KNcvsJawjRC81fELYF5jfk9laycpp02PJCdYwwDkezvoZR1kqxtQKTqTahPK7KAoNhc03+7/suujah80+cXHd98d+P+t/fMte/QzO1x4lhFHFhtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741180561; c=relaxed/simple;
	bh=FSA9Ozv525IV5w6+GJaUCX1AAA/L5wOmQaWsfimaaX4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q1JwgwdiP80bOAKGYx5GJ6/s42EK62hLA4gZRv6ynPxXBZCN2VBi5RDxrmIKsKDsYGMODs9wbb3c4Kl3bXRO217eQjql0rzjrtIjd/qivphRazi4XJJf+grHsmfh99RSwoaC54crNu+gugh14/3aWdWNd5R3mUmkoj8MhSY74dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bRVE3pdR; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741180559; x=1772716559;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FSA9Ozv525IV5w6+GJaUCX1AAA/L5wOmQaWsfimaaX4=;
  b=bRVE3pdRrPUhBZzx3R3IJwBuZtr0HlF07kq+erI2ly6o1hAch/0BPwOT
   FPFnzBVMkZQjt9+99NG3Nf9rTSh0GX9yTkz9i1+Z25cumgYnsLTze01rq
   siuMmtKvgwz5uZJEL/vSQfbIV+ve6ZAfEcbvEP3GM7YnJ1TwP14LhVc+M
   UmaOO1LyRmNHqvRFB+VjmHAud/+he+tbkripsStcoLSCSMgs/HP6bf4rB
   Rzf7OL1KNxUiZXp0YoNZQrM8quymt8CNpDDmCiYHe48HQN50YCziHFSJ6
   09JMdA69WduG+Dgvm++L6JmEZxAMTQkp/t4fU9ax263pW8heiS1I0nSCl
   w==;
X-CSE-ConnectionGUID: ah3UxnfOTf+sjO2tA2b6ZQ==
X-CSE-MsgGUID: PZdYxKebSdO6KR3EJl05vw==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="53537150"
X-IronPort-AV: E=Sophos;i="6.14,223,1736841600"; 
   d="scan'208";a="53537150"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2025 05:15:59 -0800
X-CSE-ConnectionGUID: +qx5GYliTR65WIshKN7ndw==
X-CSE-MsgGUID: CFm95MOBS+qd55cWAF9+lQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="118610885"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by orviesa010.jf.intel.com with ESMTP; 05 Mar 2025 05:15:55 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tpobI-000KzO-36;
	Wed, 05 Mar 2025 13:15:52 +0000
Date: Wed, 5 Mar 2025 21:15:08 +0800
From: kernel test robot <lkp@intel.com>
To: Su Hui <suhui@nfschina.com>, lucas.demarchi@intel.com,
	thomas.hellstrom@linux.intel.com, rodrigo.vivi@intel.com,
	maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch
Cc: oe-kbuild-all@lists.linux.dev, Su Hui <suhui@nfschina.com>,
	ilpo.jarvinen@linux.intel.com, andriy.shevchenko@linux.intel.com,
	michael.j.ruhl@intel.com, intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] drm/xe: Select INTEL_VSEC to fix build dependency
Message-ID: <202503052153.gQnXU123-lkp@intel.com>
References: <20250227073205.1248282-1-suhui@nfschina.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250227073205.1248282-1-suhui@nfschina.com>

Hi Su,

kernel test robot noticed the following build errors:

[auto build test ERROR on drm-xe/drm-xe-next]
[also build test ERROR on linus/master v6.14-rc5 next-20250304]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Su-Hui/drm-xe-Select-INTEL_VSEC-to-fix-build-dependency/20250227-153437
base:   https://gitlab.freedesktop.org/drm/xe/kernel.git drm-xe-next
patch link:    https://lore.kernel.org/r/20250227073205.1248282-1-suhui%40nfschina.com
patch subject: [PATCH] drm/xe: Select INTEL_VSEC to fix build dependency
config: loongarch-randconfig-001-20250304 (https://download.01.org/0day-ci/archive/20250305/202503052153.gQnXU123-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250305/202503052153.gQnXU123-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503052153.gQnXU123-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/fpga/tests/fpga-mgr-test.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/fpga/tests/fpga-bridge-test.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/fpga/tests/fpga-region-test.o
>> ERROR: modpost: "intel_vsec_register" [drivers/gpu/drm/xe/xe.ko] undefined!

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for INTEL_VSEC
   Depends on [n]: X86_PLATFORM_DEVICES [=n] && PCI [=y]
   Selected by [m]:
   - DRM_XE [=m] && HAS_IOMEM [=y] && DRM [=m] && PCI [=y] && MMU [=y] && (m [=m] && MODULES [=y] || KUNIT [=y]=y [=y])
   WARNING: unmet direct dependencies detected for FB_IOMEM_HELPERS
   Depends on [n]: HAS_IOMEM [=y] && FB_CORE [=n]
   Selected by [m]:
   - DRM_XE_DISPLAY [=y] && HAS_IOMEM [=y] && DRM [=m] && DRM_XE [=m] && DRM_XE [=m]=m [=m] && HAS_IOPORT [=y]

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

