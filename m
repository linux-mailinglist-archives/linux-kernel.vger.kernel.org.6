Return-Path: <linux-kernel+bounces-572168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39D71A6C78F
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 05:26:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0767466139
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 04:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D525A13BC3F;
	Sat, 22 Mar 2025 04:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VLMIAtjz"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 319D95464E;
	Sat, 22 Mar 2025 04:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742617571; cv=none; b=VREijnsB5nAbYkL8oG7SR5RVuLhVItjzyT/Dc92stmB14g2yjLdaqtWES1NA1n/UZNDhSOAlO1jk8ykLx9l7I8zthgZz9GJEkZTjZ4n2WXtswXHypj+JgYkVCjsOyn9J/GPSeG9ylL3W35hpRxtavaHIBarnPXrGyY2VZKvlUvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742617571; c=relaxed/simple;
	bh=l6gLWnT6/12qsoTDy2FceFIUC2G5PMom7qnN2lEPN3k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N7lRRVfRYiIquTNUuLcUv6ggBouGf/zfkOr2TIu1347plSDQpQbV1DQE4IymdtF6cA/ehbac2j25hHq0onRlRaXrPdP7IXt5JdOwySHZQwnh6KYnQVj0BfGsSg0H+ahhSEFz6l7oMVGB/nD0o9o2VKWUa3+Q/eihPJjUbA1n/ZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VLMIAtjz; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742617569; x=1774153569;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=l6gLWnT6/12qsoTDy2FceFIUC2G5PMom7qnN2lEPN3k=;
  b=VLMIAtjz0EjdO0QWLuUuLKMO39YJiAeIB9N08twTCLo8VIz1W+9JZKN0
   C9CEgIR9rSX7zz3BgKgpPa8HGTuprlah3i0ar0SYn9wz7BndU6SfY9bFv
   /9PV7WvN1JIxlF/AhqBm5j7Wp83OoK7Bb6i02VRJXlVR8mvZdqTnnVE2B
   Yik/m+LlLPYtNplCw+T8V60+Gf51i3Qf7IzmQL/1E7Aro2OFIOY0747rI
   Q1gdveOVQv1xN8A0/jnzQuaqcsm9yTmfZbBOwFbPbmjPARbZOjj4RLwCG
   QPZa+gWcxFesHTGbj3AMH8bKYxqvhnIV1szQQd/kraBt9onRXwo+x4jvg
   A==;
X-CSE-ConnectionGUID: /59HpirkS2aMq5M9szNT5g==
X-CSE-MsgGUID: vg87+PoOQiGUAFnlIj4M2w==
X-IronPort-AV: E=McAfee;i="6700,10204,11380"; a="61412184"
X-IronPort-AV: E=Sophos;i="6.14,266,1736841600"; 
   d="scan'208";a="61412184"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2025 21:26:08 -0700
X-CSE-ConnectionGUID: BDa8yezbSx6cDg3x6ouRdw==
X-CSE-MsgGUID: zZHs0fnYTTWhNsfWtpN6Ig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,266,1736841600"; 
   d="scan'208";a="154578188"
Received: from lkp-server02.sh.intel.com (HELO e98e3655d6d2) ([10.239.97.151])
  by fmviesa001.fm.intel.com with ESMTP; 21 Mar 2025 21:26:05 -0700
Received: from kbuild by e98e3655d6d2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tvqQt-0001vL-1q;
	Sat, 22 Mar 2025 04:26:03 +0000
Date: Sat, 22 Mar 2025 12:25:12 +0800
From: kernel test robot <lkp@intel.com>
To: Chukun Pan <amadeus@jmu.edu.cn>, Heiko Stuebner <heiko@sntech.de>
Cc: oe-kbuild-all@lists.linux.dev, Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Dragan Simic <dsimic@manjaro.org>, Rob Herring <robh@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, Chukun Pan <amadeus@jmu.edu.cn>
Subject: Re: [PATCH 1/1] arm64: dts: rockchip: rk3568: Move PCIe3 MSI to use
 GIC ITS
Message-ID: <202503221203.7E0Oa0zG-lkp@intel.com>
References: <20250308093008.568437-2-amadeus@jmu.edu.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250308093008.568437-2-amadeus@jmu.edu.cn>

Hi Chukun,

kernel test robot noticed the following build errors:

[auto build test ERROR on rockchip/for-next]
[also build test ERROR on linus/master v6.14-rc7]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Chukun-Pan/arm64-dts-rockchip-rk3568-Move-PCIe3-MSI-to-use-GIC-ITS/20250308-173422
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git for-next
patch link:    https://lore.kernel.org/r/20250308093008.568437-2-amadeus%40jmu.edu.cn
patch subject: [PATCH 1/1] arm64: dts: rockchip: rk3568: Move PCIe3 MSI to use GIC ITS
config: arm64-randconfig-r071-20250321 (https://download.01.org/0day-ci/archive/20250322/202503221203.7E0Oa0zG-lkp@intel.com/config)
compiler: clang version 16.0.6 (https://github.com/llvm/llvm-project 7cbf1a2591520c2491aa35339f227775f4d3adf6)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250322/202503221203.7E0Oa0zG-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503221203.7E0Oa0zG-lkp@intel.com/

All errors (new ones prefixed by >>):

   also defined at arch/arm64/boot/dts/rockchip/rk3568-bpi-r2-pro.dts:597.10-605.3
>> ERROR: Input tree has errors, aborting (use -f to force output)
--
>> ERROR: Input tree has errors, aborting (use -f to force output)
--
   also defined at arch/arm64/boot/dts/rockchip/rk3568-fastrhino-r66s.dtsi:368.10-373.3
>> ERROR: Input tree has errors, aborting (use -f to force output)
--
   also defined at arch/arm64/boot/dts/rockchip/rk3568-lubancat-2.dts:518.10-522.3
>> ERROR: Input tree has errors, aborting (use -f to force output)
--
   also defined at arch/arm64/boot/dts/rockchip/rk3568-mecsbc.dts:273.10-279.3
>> ERROR: Input tree has errors, aborting (use -f to force output)
--
   also defined at arch/arm64/boot/dts/rockchip/rk3568-nanopi-r5c.dts:75.10-80.3
>> ERROR: Input tree has errors, aborting (use -f to force output)
--
   also defined at arch/arm64/boot/dts/rockchip/rk3568-nanopi-r5s.dts:103.10-110.3
>> ERROR: Input tree has errors, aborting (use -f to force output)
--
   also defined at arch/arm64/boot/dts/rockchip/rk3568-odroid-m1.dts:503.10-509.3
>> ERROR: Input tree has errors, aborting (use -f to force output)
--
   also defined at arch/arm64/boot/dts/rockchip/rk3568-photonicat.dts:361.10-369.3
>> ERROR: Input tree has errors, aborting (use -f to force output)
--
   also defined at arch/arm64/boot/dts/rockchip/rk3568-qnap-ts433.dts:551.10-556.3
>> ERROR: Input tree has errors, aborting (use -f to force output)
--
   also defined at arch/arm64/boot/dts/rockchip/rk3568-radxa-e25.dts:133.10-140.3
>> ERROR: Input tree has errors, aborting (use -f to force output)
..

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

