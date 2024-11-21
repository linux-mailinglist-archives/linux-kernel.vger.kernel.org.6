Return-Path: <linux-kernel+bounces-417000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A6E09D4D78
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 14:07:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6583B22B18
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 13:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E46191D7E4C;
	Thu, 21 Nov 2024 13:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mbybtKKj"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAFD31B0F0C;
	Thu, 21 Nov 2024 13:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732194424; cv=none; b=NCOHAzcU9Ct9TZ/FBUrrp8zQuAujRDDwSpA6bqOYgYsOWwEMUZ9wLv5R5uvrwfLFekNumH42NN3s+2ysb/sOmPVtqml05QbIs3ZW0ZvgniOD8wlfXsshNpQZk8hFVT7HAyHU4dqqaTFc6yaym2qPckfBTe7LXojZdTcdAcmje00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732194424; c=relaxed/simple;
	bh=Z8PA0Mh/Y/MUPN5YQmqGz8Ls/8n0KHR881FuitZX5v4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bD0CtcW4Da/IQ7Biw2CqtDAIH/lye4021JMFwKipFXsCiLGe3cOx75XJTbGw8wQpwqSPUpJQ/qX3hfu8RQkQaRadNnOdGuU4lCapV5UG4EbaTAoyB1ZWYRAcQ8dy+yVP/4HKgqjNLU+TgyeLGmjRrofHtjwSk2uwWdkPLlrohLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mbybtKKj; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732194423; x=1763730423;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Z8PA0Mh/Y/MUPN5YQmqGz8Ls/8n0KHR881FuitZX5v4=;
  b=mbybtKKjC7XZ3Sn3Ft6TX5KmUxqcBEgEaW8vydk85fxa+hSdvDsPUZMb
   7Rmv8ZMI3j70D3AhgVmf9/jcRLXbr8TvGQ4Jraem/vKxoBc0cQbcQKhUH
   acIZkYEubVafx303edUMoPIRbCa3wEcshIkOdKE65wpm3V3VLwx7CQd+W
   JTofVByqNN9xBHIbxbAMpcp8sxr16L015dWS9t7D0JlxqJi+E/62iTNbU
   ihPSPyTJMo7bvDRD8mGBeuj8OP20dWMh5Ss/jcilHHzB1Bl8er5IE/SNN
   Y0Xvg1k3u3GgETJQCZXonPtgOGrpredl9wJVH71DRRtZRdjPc5FMRYwvm
   A==;
X-CSE-ConnectionGUID: V9Wkhpr0RUuVH6kUTLnejQ==
X-CSE-MsgGUID: GNC0P2UOSduhEADUaBCYiw==
X-IronPort-AV: E=McAfee;i="6700,10204,11263"; a="32420295"
X-IronPort-AV: E=Sophos;i="6.12,172,1728975600"; 
   d="scan'208";a="32420295"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2024 05:07:02 -0800
X-CSE-ConnectionGUID: i5LY9JAdRtOBT0lh04KPHQ==
X-CSE-MsgGUID: 81eOr58CRuia8XfsGnK2dg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,172,1728975600"; 
   d="scan'208";a="89852236"
Received: from lkp-server01.sh.intel.com (HELO 8122d2fc1967) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 21 Nov 2024 05:06:59 -0800
Received: from kbuild by 8122d2fc1967 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tE6tc-000309-3B;
	Thu, 21 Nov 2024 13:06:56 +0000
Date: Thu, 21 Nov 2024 21:05:57 +0800
From: kernel test robot <lkp@intel.com>
To: "Sung-Chi, Li" <lschyi@chromium.org>,
	Benson Leung <bleung@chromium.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	Guenter Roeck <groeck@chromium.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	chrome-platform@lists.linux.dev, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/3] platform/chrome: cros_ec_charge_state: add new
 driver to control charge
Message-ID: <202411212036.M5ujDUNV-lkp@intel.com>
References: <20241118-add_charger_state-v1-1-94997079f35a@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241118-add_charger_state-v1-1-94997079f35a@chromium.org>

Hi Li,

kernel test robot noticed the following build warnings:

[auto build test WARNING on lee-mfd/for-mfd-next]
[also build test WARNING on robh/for-next groeck-staging/hwmon-next chrome-platform/for-next chrome-platform/for-firmware-next lee-mfd/for-mfd-fixes linus/master v6.12 next-20241121]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Sung-Chi-Li/platform-chrome-cros_ec_charge_state-add-new-driver-to-control-charge/20241121-112442
base:   https://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git for-mfd-next
patch link:    https://lore.kernel.org/r/20241118-add_charger_state-v1-1-94997079f35a%40chromium.org
patch subject: [PATCH 1/3] platform/chrome: cros_ec_charge_state: add new driver to control charge
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20241121/202411212036.M5ujDUNV-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241121/202411212036.M5ujDUNV-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411212036.M5ujDUNV-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/platform/chrome/cros_ec_charge_state.c:198:40: warning: 'cros_ec_charge_state_id' defined but not used [-Wunused-const-variable=]
     198 | static const struct platform_device_id cros_ec_charge_state_id[] = {
         |                                        ^~~~~~~~~~~~~~~~~~~~~~~


vim +/cros_ec_charge_state_id +198 drivers/platform/chrome/cros_ec_charge_state.c

   197	
 > 198	static const struct platform_device_id cros_ec_charge_state_id[] = {
   199		{ DRV_NAME,  0 },
   200		{}
   201	};
   202	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

