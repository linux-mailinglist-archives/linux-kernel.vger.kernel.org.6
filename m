Return-Path: <linux-kernel+bounces-233264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 730DC91B4EE
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 04:13:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A330A1C217BE
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 02:13:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A08018029;
	Fri, 28 Jun 2024 02:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XhjvSnq+"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D1653C0B;
	Fri, 28 Jun 2024 02:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719540797; cv=none; b=SPAqf0EqqgHnWSYQxqF+be5I0bkbC9RYtqdS7nzM0YtvaDlSEgCileKZXxhVJHIw0r7n9v1I2lRV5ANvv/IchRLHKuRN229wX4cyi45Wm5uCLfHKMHUKEX4Eyj9dmxC/Z/EhOQWFvLoDVQa2+k4kHmpAlOBbxWyn1S2b1LkzR9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719540797; c=relaxed/simple;
	bh=/Ub6zta+0SAXKh9uiet4CqS+rN7kBLSnTuCB14Q2Lo4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FAiCGQv2rIHQSt9wR94FCVUMFKDJTDFmd2a/H/COzwZPDz0yZ8OGqNO+Tbr0gQp/zvxRxrcpGEkGHCxkZFi9tgHQbdWvaT4rjZ5cWRZepSgAz2gk5EqH9Dhq9lvpZGkd9EZfLq5qMKqlADgfelRvuBh19ZVaDlB4XTA2zbAuHSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XhjvSnq+; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719540796; x=1751076796;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/Ub6zta+0SAXKh9uiet4CqS+rN7kBLSnTuCB14Q2Lo4=;
  b=XhjvSnq+A2QeoaWq+AjSSzwEey7T6tAhvUwV8gKZ7xkUSiPK7bj64mLL
   MIfoafPqvqWgb6fvbDkCcfxQitRsjwn6T3GgDy1FHFs/BidmLXqJN91i0
   J7F8GKzBNXhy17NzGJjziMrmtCmcSqcX3hxRJF81vObkhq+ZlGfI34Lyl
   x+k6emQH7q5hREPaHmkl2ubzoC6Q+QD0dn/KppOhfZ/6tJ+puVOZOj33n
   M0cYQvrPldJNa3JOjo5jPY+zM29WBiveFoJBsNeIrB/qM6+XQufOKQXww
   UhDgixs6BkhOyCz7fUmimbgbNusf1v2Pj7Gyse8m5HDLY8KltXrIhc8cp
   A==;
X-CSE-ConnectionGUID: zi9jAKOZT6q7iUOYkX0suQ==
X-CSE-MsgGUID: oOxRWSD+RLWpiU1tGjr7+Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11116"; a="16528808"
X-IronPort-AV: E=Sophos;i="6.09,167,1716274800"; 
   d="scan'208";a="16528808"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2024 19:13:15 -0700
X-CSE-ConnectionGUID: RELGioelQiOx8PUEyU8xUQ==
X-CSE-MsgGUID: w2oGwSiMSb6HzN3VDjLTeQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,167,1716274800"; 
   d="scan'208";a="44993921"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 27 Jun 2024 19:13:12 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sN16r-000Gie-2N;
	Fri, 28 Jun 2024 02:13:09 +0000
Date: Fri, 28 Jun 2024 10:12:17 +0800
From: kernel test robot <lkp@intel.com>
To: Jonas Karlman <jonas@kwiboo.se>, Heiko Stuebner <heiko@sntech.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, FUKAUMI Naoki <naoki@radxa.com>,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
	Jonas Karlman <jonas@kwiboo.se>
Subject: Re: [PATCH v2 2/2] arm64: dts: rockchip: Add Radxa ROCK 3B
Message-ID: <202406280948.sZf64ONz-lkp@intel.com>
References: <20240626201502.1384123-3-jonas@kwiboo.se>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240626201502.1384123-3-jonas@kwiboo.se>

Hi Jonas,

kernel test robot noticed the following build warnings:

[auto build test WARNING on rockchip/for-next]
[also build test WARNING on krzk/for-next krzk-dt/for-next krzk-mem-ctrl/for-next linus/master v6.10-rc5 next-20240627]
[cannot apply to robh/for-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jonas-Karlman/dt-bindings-arm-rockchip-Add-Radxa-ROCK-3B/20240627-160354
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git for-next
patch link:    https://lore.kernel.org/r/20240626201502.1384123-3-jonas%40kwiboo.se
patch subject: [PATCH v2 2/2] arm64: dts: rockchip: Add Radxa ROCK 3B
config: arm64-randconfig-051-20240628 (https://download.01.org/0day-ci/archive/20240628/202406280948.sZf64ONz-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 13.2.0
dtschema version: 2024.6.dev2+g3b69bad
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240628/202406280948.sZf64ONz-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406280948.sZf64ONz-lkp@intel.com/

dtcheck warnings: (new ones prefixed by >>)
>> arch/arm64/boot/dts/rockchip/rk3568-rock-3b.dtb: pmic@20: '#sound-dai-cells', 'assigned-clock-parents', 'assigned-clocks', 'clock-names', 'clocks' do not match any of the regexes: 'pinctrl-[0-9]+'
   	from schema $id: http://devicetree.org/schemas/mfd/rockchip,rk809.yaml#

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

