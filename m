Return-Path: <linux-kernel+bounces-240688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 40FBD927104
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 09:56:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 729D21C22077
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 07:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E84A1A3BC4;
	Thu,  4 Jul 2024 07:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BtspfWWm"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B2991A38F0;
	Thu,  4 Jul 2024 07:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720079793; cv=none; b=Mjq71/9/CJGophxnb8rpRHZEfGZ0pCHAGcScvY5PNeqerV92BPFq0O9Q76jDpc+9lyLQhAcU8mHRiEF49b6hDr5nxBiAxm8lH3MvkDeqfwHKkVb6HASkI261VkUigriU+Lpo2XQbpYxEe9pxEV/T75aCF46POqAX6u1t4TA72eY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720079793; c=relaxed/simple;
	bh=AjQyGUJZ0vfY7qZ8Lmdw5nPCnEsUxgopR1OuiDeFoYo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kObpRadKKgwbp37XVqLtWKRAdbKFwA9YjVnH3mMnbE09xr8/J76phBuAUKBPFa3iA+gcwcKUHdOUynSTmpiPjmThBvznEUBOJ1kicCSmFTZ31ja9yuZ19zWmiKlBYcuCzWsPhsi/p2ob8QHdhrbjZa9RJ57FWmNLuO/kH8YXfSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BtspfWWm; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720079792; x=1751615792;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=AjQyGUJZ0vfY7qZ8Lmdw5nPCnEsUxgopR1OuiDeFoYo=;
  b=BtspfWWm5GdwRPevBZL1NwW08bHIw8+eIvF48K3T2OyHQk4j7qDHsgZa
   AUaLAbLqIk8CzOK4fiJnG6I74YVI/VJvlqCJHMzHl/IqHqlq6YaKjNqoL
   LrmoFMisI+O/q3xOoqo97msvnfNETJgm1KsYZfJ7Lt64CIs9biiQN7VcO
   EExlWwQfYcYKdo8DmqExU9PRHTLMxQLXtnX6m8ocSshhzQYrQjtyqANma
   xKdc0aEUnq5XYGIc62q5BBFOtY35fynJKwF/eO2Xr3cR7z7Kz3YC0GSIc
   XzuDh1BhgNklYByU7PO9D+3MhmCOauZIUOOq+pO5hSgWKL9fBj0sHsEXf
   w==;
X-CSE-ConnectionGUID: HJrNDj0OQqeZ0lIK8ZDYyw==
X-CSE-MsgGUID: OvJK8L1URKikbdt/OzDAJw==
X-IronPort-AV: E=McAfee;i="6700,10204,11122"; a="34792118"
X-IronPort-AV: E=Sophos;i="6.09,183,1716274800"; 
   d="scan'208";a="34792118"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2024 00:56:15 -0700
X-CSE-ConnectionGUID: 2YDfhjTxQdCe2Yn4QD7Jkw==
X-CSE-MsgGUID: 01nKX0/rTTqXDDG/vnNDOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,183,1716274800"; 
   d="scan'208";a="46660403"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 04 Jul 2024 00:56:11 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sPHK4-000QjA-1y;
	Thu, 04 Jul 2024 07:56:08 +0000
Date: Thu, 4 Jul 2024 15:56:02 +0800
From: kernel test robot <lkp@intel.com>
To: zelong dong <zelong.dong@amlogic.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Kevin Hilman <khilman@baylibre.com>, Rob Herring <robh@kernel.org>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Krzysztof Kozlowski <krzk@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-amlogic@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	kelvin.zhang@amlogic.com, Zelong Dong <zelong.dong@amlogic.com>
Subject: Re: [PATCH 3/3] arm64: dts: amlogic: Add Amlogic A5 reset controller
Message-ID: <202407041520.P9v4H7Sq-lkp@intel.com>
References: <20240703061610.37217-4-zelong.dong@amlogic.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240703061610.37217-4-zelong.dong@amlogic.com>

Hi zelong,

kernel test robot noticed the following build warnings:

[auto build test WARNING on next-20240703]
[cannot apply to robh/for-next pza/reset/next pza/imx-drm/next v6.10-rc6 v6.10-rc5 v6.10-rc4 linus/master v6.10-rc6]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/zelong-dong/dt-bindings-reset-Add-compatible-and-DT-bindings-for-Amlogic-A4-A5-Reset-Controller/20240703-184517
base:   next-20240703
patch link:    https://lore.kernel.org/r/20240703061610.37217-4-zelong.dong%40amlogic.com
patch subject: [PATCH 3/3] arm64: dts: amlogic: Add Amlogic A5 reset controller
config: arm64-randconfig-051-20240704 (https://download.01.org/0day-ci/archive/20240704/202407041520.P9v4H7Sq-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 13.2.0
dtschema version: 2024.6.dev3+g650bf2d
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240704/202407041520.P9v4H7Sq-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202407041520.P9v4H7Sq-lkp@intel.com/

dtcheck warnings: (new ones prefixed by >>)
>> arch/arm64/boot/dts/amlogic/amlogic-a4-a113l2-ba400.dtb: reset-controller@2000: compatible: 'oneOf' conditional failed, one must be fixed:
   	['amlogic,a4-reset', 'amlogic,a5-reset', 'amlogic,meson-s4-reset'] is too long
   	'amlogic,a4-reset' is not one of ['amlogic,meson8b-reset', 'amlogic,meson-gxbb-reset', 'amlogic,meson-axg-reset', 'amlogic,meson-a1-reset', 'amlogic,meson-s4-reset', 'amlogic,t7-reset']
   	'amlogic,meson-s4-reset' was expected
   	from schema $id: http://devicetree.org/schemas/reset/amlogic,meson-reset.yaml#
--
>> arch/arm64/boot/dts/amlogic/amlogic-a5-a113x2-av400.dtb: reset-controller@2000: compatible: 'oneOf' conditional failed, one must be fixed:
   	['amlogic,a4-reset', 'amlogic,a5-reset', 'amlogic,meson-s4-reset'] is too long
   	'amlogic,a4-reset' is not one of ['amlogic,meson8b-reset', 'amlogic,meson-gxbb-reset', 'amlogic,meson-axg-reset', 'amlogic,meson-a1-reset', 'amlogic,meson-s4-reset', 'amlogic,t7-reset']
   	'amlogic,meson-s4-reset' was expected
   	from schema $id: http://devicetree.org/schemas/reset/amlogic,meson-reset.yaml#

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

