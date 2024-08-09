Return-Path: <linux-kernel+bounces-281575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CFAE94D856
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 23:10:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CF6D285426
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 21:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89C2D16A36E;
	Fri,  9 Aug 2024 21:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QpG5/puR"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 321B2224EA;
	Fri,  9 Aug 2024 21:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723237816; cv=none; b=GCE7DEwHwHn+eLMnfky86c22fw/faSjt2DDNhtLHZL/sSUVbOkc2+MD85qzkz1Ly0L71dO6JLej0XANqJrCp6zZRtim20qzjbHfEUfN9UBcXsuEqP2u0maNoXEHMZxor6WD0A0oznmJOMGt4YRqZmtUxudLTIle+6qYC03I8nY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723237816; c=relaxed/simple;
	bh=mqq+JEfGxXJbA9UuP3dN134huReQHnwuwzViD9L6Ti0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T1uOI9GNSJi2J0htmJbsHPxb1Jg2A6a76wyUbiJKz9llFioovMAeKYj9cqxtRgGZl0NPfxtHhInP0zJPjjCq+rgNhR3Flu8fRYHGKGIWNnBITZSw+JnX1Un1NzVFbpMP5EFNkH7cVluVVYT9OhABGgrdqprLRPv2s5C8PeKVykk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QpG5/puR; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723237814; x=1754773814;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mqq+JEfGxXJbA9UuP3dN134huReQHnwuwzViD9L6Ti0=;
  b=QpG5/puRWANUUrYiag9dgf9ldVDEeI4rjPE2DrejdRHsKTFyrIKhqkOR
   +iaO55TjpcK7UKpw+AXjqGpMkdnHkUCdnJV1bZrT28sB58iG43pnx/XlR
   Iwj1FYG8buUCzDDHX91n0oa+HY/5Fkr9cyEXOFZMgDLKEnsWwWoCuOT9V
   8veIXCVFG+rAWnDBvDJMt+k4rOEx2VpKzubqX7WaTsqEw29CMw4tejwhE
   agQ3u+JCjUlDR3NjLu7hdRjpVpqF+Xb30MPJrhBHQRS6xFS7C6yztZvxV
   Rz1ApAEPdSNcC+/VW52s8bemS+z0K3y8xBKw4Am9dIzZjztRQWDTqzTCJ
   Q==;
X-CSE-ConnectionGUID: pDf4msXPRZ2d4VgSG7d+Og==
X-CSE-MsgGUID: S+5M6/1JSZ6Rrx6K5qvSQQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11159"; a="21403413"
X-IronPort-AV: E=Sophos;i="6.09,277,1716274800"; 
   d="scan'208";a="21403413"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2024 14:10:12 -0700
X-CSE-ConnectionGUID: 8FlihEywRfunBIQxxE36fA==
X-CSE-MsgGUID: hXN7S+L4S3iqCNgzJ24Hzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,277,1716274800"; 
   d="scan'208";a="88323810"
Received: from unknown (HELO b6bf6c95bbab) ([10.239.97.151])
  by orviesa002.jf.intel.com with ESMTP; 09 Aug 2024 14:10:05 -0700
Received: from kbuild by b6bf6c95bbab with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1scWs5-0009Gp-2t;
	Fri, 09 Aug 2024 21:10:01 +0000
Date: Sat, 10 Aug 2024 05:09:20 +0800
From: kernel test robot <lkp@intel.com>
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Sandy Huang <hjc@rock-chips.com>,
	Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>,
	Andy Yan <andy.yan@rock-chips.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Mark Yao <markyao0591@gmail.com>,
	Sascha Hauer <s.hauer@pengutronix.de>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
	kernel@collabora.com, Alexandre ARNOUD <aarnoud@me.com>,
	Luis de Arquer <ldearquer@gmail.com>,
	Algea Cao <algea.cao@rock-chips.com>
Subject: Re: [PATCH v2 3/3] drm/rockchip: Add basic RK3588 HDMI output support
Message-ID: <202408100431.ujB0M1q7-lkp@intel.com>
References: <20240801-b4-rk3588-bridge-upstream-v2-3-9fa657a4e15b@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240801-b4-rk3588-bridge-upstream-v2-3-9fa657a4e15b@collabora.com>

Hi Cristian,

kernel test robot noticed the following build errors:

[auto build test ERROR on 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0]

url:    https://github.com/intel-lab-lkp/linux/commits/Cristian-Ciocaltea/dt-bindings-display-rockchip-Add-schema-for-RK3588-HDMI-TX-Controller/20240802-173018
base:   1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0
patch link:    https://lore.kernel.org/r/20240801-b4-rk3588-bridge-upstream-v2-3-9fa657a4e15b%40collabora.com
patch subject: [PATCH v2 3/3] drm/rockchip: Add basic RK3588 HDMI output support
config: hexagon-allmodconfig (https://download.01.org/0day-ci/archive/20240810/202408100431.ujB0M1q7-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project f86594788ce93b696675c94f54016d27a6c21d18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240810/202408100431.ujB0M1q7-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408100431.ujB0M1q7-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c:15:
   In file included from include/linux/phy/phy.h:17:
   In file included from include/linux/regulator/consumer.h:35:
   In file included from include/linux/suspend.h:5:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:13:
   In file included from include/linux/cgroup.h:26:
   In file included from include/linux/kernel_stat.h:9:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:14:
   In file included from arch/hexagon/include/asm/io.h:328:
   include/asm-generic/io.h:548:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     548 |         val = __raw_readb(PCI_IOBASE + addr);
         |                           ~~~~~~~~~~ ^
   include/asm-generic/io.h:561:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     561 |         val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:37:51: note: expanded from macro '__le16_to_cpu'
      37 | #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
         |                                                   ^
   In file included from drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c:15:
   In file included from include/linux/phy/phy.h:17:
   In file included from include/linux/regulator/consumer.h:35:
   In file included from include/linux/suspend.h:5:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:13:
   In file included from include/linux/cgroup.h:26:
   In file included from include/linux/kernel_stat.h:9:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:14:
   In file included from arch/hexagon/include/asm/io.h:328:
   include/asm-generic/io.h:574:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     574 |         val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
      35 | #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
         |                                                   ^
   In file included from drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c:15:
   In file included from include/linux/phy/phy.h:17:
   In file included from include/linux/regulator/consumer.h:35:
   In file included from include/linux/suspend.h:5:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:13:
   In file included from include/linux/cgroup.h:26:
   In file included from include/linux/kernel_stat.h:9:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:14:
   In file included from arch/hexagon/include/asm/io.h:328:
   include/asm-generic/io.h:585:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     585 |         __raw_writeb(value, PCI_IOBASE + addr);
         |                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:595:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     595 |         __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:605:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     605 |         __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   In file included from drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c:15:
   In file included from include/linux/phy/phy.h:17:
   In file included from include/linux/regulator/consumer.h:35:
   In file included from include/linux/suspend.h:5:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:21:
   In file included from include/linux/mm.h:2253:
   include/linux/vmstat.h:514:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     514 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
>> drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c:18:10: fatal error: 'drm/bridge/dw_hdmi_qp.h' file not found
      18 | #include <drm/bridge/dw_hdmi_qp.h>
         |          ^~~~~~~~~~~~~~~~~~~~~~~~~
   7 warnings and 1 error generated.


vim +18 drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c

    17	
  > 18	#include <drm/bridge/dw_hdmi_qp.h>
    19	#include <drm/drm_bridge_connector.h>
    20	#include <drm/drm_of.h>
    21	#include <drm/drm_probe_helper.h>
    22	#include <drm/drm_simple_kms_helper.h>
    23	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

