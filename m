Return-Path: <linux-kernel+bounces-251171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C820930182
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 23:19:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 474A01C212F4
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 21:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF70A49649;
	Fri, 12 Jul 2024 21:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BN2c1KCq"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C55B7433A8;
	Fri, 12 Jul 2024 21:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720819134; cv=none; b=lcOlZDOESU6wpEAU5SFClUGW3AnvdvZmmG0JQ9WmLrjzZ4AGrgq5R2ObZXmbSPwWaRyr82vzKkJyG+SqqAxlKlUZltarw8MmDjXkN3ehqcyfnH1SDxRY4FnpkpYv/wPPv7GY5CjB+Mom/Oqw4Zs1HQESFv+hzWb4nk10kafvKp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720819134; c=relaxed/simple;
	bh=N5xSnP8pdMySxHnBgNf2Tix1Gm3w2isPegAwUbJbCsI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=poqrXWrOrW/yd1LUDAEfm/bMGTbigwSXYXEp5SOGN9eMHc95isSxS3OFm+7biEpm81P3Rw37rtosjDzZlYajawlBbmMU5zm9jNRzoxUcHX5hQHQQzh+sR7NGy4axUhiYBIJfXNWjdhkcWH4DomS5qSjunEZJ0A0HoRGgYRu9F2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BN2c1KCq; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720819132; x=1752355132;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=N5xSnP8pdMySxHnBgNf2Tix1Gm3w2isPegAwUbJbCsI=;
  b=BN2c1KCqGdFCElsZxarJxSzZbz8wwNBbfSjcNlSVbY5yA4TY8YQnZ2CK
   CCezmmRy+ZFWv4NsbDQyg963ra0h1htehuOVBd16A2jDY4sqnWfZuu1zJ
   6genzvjdcIKmdBIsd9kUemwJSQMXoeToZOzV6Pvd3Gpd2NZSix8p0d538
   4YShcVtXyss4PkR1pKtgdZz+CffgmaQOcMB+MEw7fJyBsvPPZVr+FfvXl
   d8f4ZF4fzcx/q581nwXhDQXc6b+e63i8hIfZAR7guizMfyHVyElKeACPQ
   Kq16Sx34cE20GCAuZSmYdroa8rKirQ633f9dPUTy8rxMCtKM86IDJHuCW
   w==;
X-CSE-ConnectionGUID: fQ1zuvfqTkWm8SaasI4wZw==
X-CSE-MsgGUID: 0AZhpralQlmXjuvw1crGJA==
X-IronPort-AV: E=McAfee;i="6700,10204,11131"; a="28871205"
X-IronPort-AV: E=Sophos;i="6.09,204,1716274800"; 
   d="scan'208";a="28871205"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2024 14:18:52 -0700
X-CSE-ConnectionGUID: 2V8RI/uQRxi6oGjFZxYTgA==
X-CSE-MsgGUID: R2fl3YqJRRuCuJkmKaMehg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,204,1716274800"; 
   d="scan'208";a="53979274"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 12 Jul 2024 14:18:48 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sSNfB-000bIw-32;
	Fri, 12 Jul 2024 21:18:45 +0000
Date: Sat, 13 Jul 2024 05:18:26 +0800
From: kernel test robot <lkp@intel.com>
To: Igor Prusov <ivprusov@salutedevices.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Philipp Zabel <p.zabel@pengutronix.de>
Cc: oe-kbuild-all@lists.linux.dev, prusovigor@gmail.com,
	kernel@salutedevices.com, linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/6] ASoC: codecs: Add NeoFidelity NTP8918 codec
Message-ID: <202407130520.NOxTmD3N-lkp@intel.com>
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
[also build test WARNING on robh/for-next linus/master v6.10-rc7 next-20240712]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Igor-Prusov/dt-bindings-vendor-prefixes-Add-NeoFidelity-Inc/20240710-145725
base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next
patch link:    https://lore.kernel.org/r/20240709172834.9785-5-ivprusov%40salutedevices.com
patch subject: [PATCH 4/6] ASoC: codecs: Add NeoFidelity NTP8918 codec
config: sh-randconfig-r111-20240712 (https://download.01.org/0day-ci/archive/20240713/202407130520.NOxTmD3N-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 14.1.0
reproduce: (https://download.01.org/0day-ci/archive/20240713/202407130520.NOxTmD3N-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202407130520.NOxTmD3N-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> sound/soc/codecs/ntp8918.c:274:24: sparse: sparse: symbol 'ntp8918_dai_ops' was not declared. Should it be static?

vim +/ntp8918_dai_ops +274 sound/soc/codecs/ntp8918.c

   273	
 > 274	struct snd_soc_dai_ops ntp8918_dai_ops = {
   275		.hw_params = ntp8918_hw_params,
   276		.set_fmt = ntp8918_set_fmt,
   277	};
   278	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

