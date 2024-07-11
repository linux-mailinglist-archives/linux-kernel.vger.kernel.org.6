Return-Path: <linux-kernel+bounces-248543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 333B592DEB4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 05:05:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6513D1C20F8F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 03:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D050912B62;
	Thu, 11 Jul 2024 03:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BMdV/qe9"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D480653;
	Thu, 11 Jul 2024 03:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720667106; cv=none; b=cucscFwD/QyS7pZBks5pUr7n1/Ni1yuVW9zaggx8DeV/3tK+1CIAEY2kmKVXf8Y4aPw3L/7tSZotXuGlPb1/2Ok87fR0IwGhFeWuIYnjILjVR2d+gh+blI/gNMVzFgT51rotvEeA30PicGk3TmEn4PT2SU5mZe29MViZO33ijGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720667106; c=relaxed/simple;
	bh=oFjg+xTnZMVTETDIv/X9rW3aaZxmLBK8FjNDz7J+6lQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tLLdxU2Wq6uNHRG51Xox+QqXzcTquDQ2zYNZSdSKdAlzJTQmpeD/A5wTtX+CSp0Hv1+EKkEXrVQqqtuL27stJ81TBZPv6oFtK3imNn+c9XE2jAsyuOzRcYadLSnSnUmKGOV0t3ZZ+IpUP+uFmvw5+hEkCF3y4LiLxtAgaq2e5p0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BMdV/qe9; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720667104; x=1752203104;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=oFjg+xTnZMVTETDIv/X9rW3aaZxmLBK8FjNDz7J+6lQ=;
  b=BMdV/qe9ZOIlXzMwZDGWVTR1Zk1nm6Ipr2YU20SaX2mzqhmQNAyozLtQ
   E/SmVjcZjINFTlHfu/QUpZRviuxYhELPCfcUDWSTTsGipAyhlOMW2FLXF
   Ez1Es+kJ2a4fAcDchYNJfrXZRwTCy/fGEm9ReeGsakieQu/MvHjn9omQN
   N/4ducUrz66b/LozHMTOrSPmC9Nx6Z+Ycnbu/5mF6U2xb6m4W19qkPRb+
   y7aaLYHZkCvGKuTrQAsv3XwujVslEqYAHgBGEjYROA4i5uKGjk6nTFt2l
   dnOQoODCkj8Lm9r7H1IsHISFOrgmusbQ6rlx3s2mhgoavaQvU0jFLwANj
   w==;
X-CSE-ConnectionGUID: 424O/vvoTbe7aBVinDM7Jg==
X-CSE-MsgGUID: Lm6k45WPTi6O6DFeQkgMqA==
X-IronPort-AV: E=McAfee;i="6700,10204,11129"; a="20936525"
X-IronPort-AV: E=Sophos;i="6.09,198,1716274800"; 
   d="scan'208";a="20936525"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2024 20:05:03 -0700
X-CSE-ConnectionGUID: Dli+H77UTHSUOAZttGjyfw==
X-CSE-MsgGUID: /pJ0CGFvSaao0wCI96hMiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,198,1716274800"; 
   d="scan'208";a="48415902"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 10 Jul 2024 20:05:00 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sRk78-000Yfy-0c;
	Thu, 11 Jul 2024 03:04:58 +0000
Date: Thu, 11 Jul 2024 11:04:28 +0800
From: kernel test robot <lkp@intel.com>
To: Igor Prusov <ivprusov@salutedevices.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Philipp Zabel <p.zabel@pengutronix.de>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	prusovigor@gmail.com, kernel@salutedevices.com,
	linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/6] ASoC: codecs: Add NeoFidelity NTP8918 codec
Message-ID: <202407111044.RZFnMlVh-lkp@intel.com>
References: <20240709172834.9785-5-ivprusov@salutedevices.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240709172834.9785-5-ivprusov@salutedevices.com>

Hi Igor,

kernel test robot noticed the following build warnings:

[auto build test WARNING on broonie-sound/for-next]
[also build test WARNING on robh/for-next linus/master v6.10-rc7 next-20240710]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Igor-Prusov/dt-bindings-vendor-prefixes-Add-NeoFidelity-Inc/20240710-145725
base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next
patch link:    https://lore.kernel.org/r/20240709172834.9785-5-ivprusov%40salutedevices.com
patch subject: [PATCH 4/6] ASoC: codecs: Add NeoFidelity NTP8918 codec
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20240711/202407111044.RZFnMlVh-lkp@intel.com/config)
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240711/202407111044.RZFnMlVh-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202407111044.RZFnMlVh-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> sound/soc/codecs/ntpfw.c:14: warning: cannot understand function prototype: 'struct ntpfw_chunk '


vim +14 sound/soc/codecs/ntpfw.c

fa3c817751bfd3 Igor Prusov 2024-07-09  13  
fa3c817751bfd3 Igor Prusov 2024-07-09 @14  struct ntpfw_chunk {
fa3c817751bfd3 Igor Prusov 2024-07-09  15  	__be16 length;
fa3c817751bfd3 Igor Prusov 2024-07-09  16  	u8 step;
fa3c817751bfd3 Igor Prusov 2024-07-09  17  	u8 data[];
fa3c817751bfd3 Igor Prusov 2024-07-09  18  } __packed;
fa3c817751bfd3 Igor Prusov 2024-07-09  19  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

