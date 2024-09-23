Return-Path: <linux-kernel+bounces-336271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B04B97F165
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 21:54:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 791061C2161D
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 19:54:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAD7C19F42C;
	Mon, 23 Sep 2024 19:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jNe2tRUr"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C4A79CC
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 19:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727121290; cv=none; b=R20GNXVB7rAaDWvfCI1nJR+q4TcTtRYQl8gETEj1w7ERyXeUzHWQYIaRvETB3Wh8rdAHsdxegfflittWABV7Zt2y3sQnuaB8hsqp+9bqLmOX62bbjIaqsAPVcyWt43X+13vzyTSXzS3ZbZdUMSlebhiT1/7YnDWJqV632ynXrKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727121290; c=relaxed/simple;
	bh=76UXzeByq3wxL1f4vfdIb7pJAMXsF8MyETpYSkG1n8Q=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=qRFHQwCzRE0dSvp0dw3TnNVYU2YPfsZNUXfttRxyCOI9rjY5Kfhd9ElyVMNuJknhpSrMqEtg/t7sZBQPcBa2EfLibHZorHNTNmvB2WO2qU/ecXjkTjpaSFNSK+ME9Dj9AkKqfbaA5puC7ptBQoIJ7zqKHwaAWgB4jIuvXh7pD94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jNe2tRUr; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727121288; x=1758657288;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=76UXzeByq3wxL1f4vfdIb7pJAMXsF8MyETpYSkG1n8Q=;
  b=jNe2tRUrwoPq6VY7HcDriMB2tVb0XYeR1QIOrTOt3itnYXcqZtkTKAlc
   pJZsDQOpyPDQM2AghyiPiDnSqWMhR8lVCO0+K7O7fedB5St8V8QIwCzqQ
   H6dRjlGcO4OUsTMuEV/+taFfDwlPK7e2zM3S94SFsgCAVRkYQj7RSyAxc
   Ud89FU91dlaok2PDD3SujEkcDY03Z+tSbH8W7rHyBMDmBvMtmPysY2+kE
   q0vRNeLFu0NwjLd/G/cOCpALBdT6U29Mz61XCxvij1fmq5HpJFkepLQyR
   cfwv0INrUCtcNrqip4lyOY+cfs5H0rTJi2s3fLNVY3CZRZJnUNK4Scs+M
   Q==;
X-CSE-ConnectionGUID: 1nG1XOVcQzqJMiN8Yzj++w==
X-CSE-MsgGUID: 3aTdr5RKQ9mzkP/MMQZddg==
X-IronPort-AV: E=McAfee;i="6700,10204,11204"; a="28982403"
X-IronPort-AV: E=Sophos;i="6.10,252,1719903600"; 
   d="scan'208";a="28982403"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2024 12:54:44 -0700
X-CSE-ConnectionGUID: xsXxBYCbS5CNZuGLKZpHng==
X-CSE-MsgGUID: syODOAAKRBKrzZND96GBkA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,252,1719903600"; 
   d="scan'208";a="75554831"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 23 Sep 2024 12:54:42 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ssp8q-000HYc-0c;
	Mon, 23 Sep 2024 19:54:40 +0000
Date: Tue, 24 Sep 2024 03:54:34 +0800
From: kernel test robot <lkp@intel.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>
Subject: drivers/gpu/drm/i915/display/intel_display.c:1909:20: error:
 arithmetic between different enumeration types ('enum tc_port' and 'enum
 port')
Message-ID: <202409240317.ZiYfocHc-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hi Maarten,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   de5cb0dcb74c294ec527eddfe5094acfdb21ff21
commit: 44e694958b95395bd1c41508c88c8ca141bf9bd7 drm/xe/display: Implement display support
date:   9 months ago
config: riscv-randconfig-r053-20240923 (https://download.01.org/0day-ci/archive/20240924/202409240317.ZiYfocHc-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 8663a75fa2f31299ab8d1d90288d9df92aadee88)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240924/202409240317.ZiYfocHc-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409240317.ZiYfocHc-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/gpu/drm/i915/display/intel_display.c:28:
   In file included from include/linux/i2c.h:19:
   In file included from include/linux/regulator/consumer.h:35:
   In file included from include/linux/suspend.h:5:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:13:
   In file included from include/linux/cgroup.h:26:
   In file included from include/linux/kernel_stat.h:9:
   In file included from include/linux/interrupt.h:21:
   In file included from arch/riscv/include/asm/sections.h:9:
   In file included from include/linux/mm.h:2177:
   include/linux/vmstat.h:522:36: error: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Werror,-Wenum-enum-conversion]
     522 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   In file included from drivers/gpu/drm/i915/display/intel_display.c:89:
   drivers/gpu/drm/i915/display/intel_frontbuffer.h:46:21: error: field has incomplete type 'struct i915_active'
      46 |         struct i915_active write;
         |                            ^
   drivers/gpu/drm/i915/display/intel_frontbuffer.h:46:9: note: forward declaration of 'struct i915_active'
      46 |         struct i915_active write;
         |                ^
   drivers/gpu/drm/i915/display/intel_display.c:314:17: error: arithmetic between different enumeration types ('enum transcoder' and 'enum intel_display_power_domain') [-Werror,-Wenum-enum-conversion]
     314 |         power_domain = POWER_DOMAIN_TRANSCODER(cpu_transcoder);
         |                        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/i915/display/intel_display_power.h:125:10: note: expanded from macro 'POWER_DOMAIN_TRANSCODER'
     125 |          (tran) + POWER_DOMAIN_TRANSCODER_A)
         |          ~~~~~~ ^ ~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/i915/display/intel_display.c:1889:16: error: arithmetic between different enumeration types ('enum phy' and 'enum port') [-Werror,-Wenum-enum-conversion]
    1889 |                 return PHY_D + port - PORT_D_XELPD;
         |                        ~~~~~ ^ ~~~~
   drivers/gpu/drm/i915/display/intel_display.c:1891:16: error: arithmetic between different enumeration types ('enum phy' and 'enum port') [-Werror,-Wenum-enum-conversion]
    1891 |                 return PHY_F + port - PORT_TC1;
         |                        ~~~~~ ^ ~~~~
   drivers/gpu/drm/i915/display/intel_display.c:1893:16: error: arithmetic between different enumeration types ('enum phy' and 'enum port') [-Werror,-Wenum-enum-conversion]
    1893 |                 return PHY_B + port - PORT_TC1;
         |                        ~~~~~ ^ ~~~~
   drivers/gpu/drm/i915/display/intel_display.c:1895:16: error: arithmetic between different enumeration types ('enum phy' and 'enum port') [-Werror,-Wenum-enum-conversion]
    1895 |                 return PHY_C + port - PORT_TC1;
         |                        ~~~~~ ^ ~~~~
   drivers/gpu/drm/i915/display/intel_display.c:1900:15: error: arithmetic between different enumeration types ('enum phy' and 'enum port') [-Werror,-Wenum-enum-conversion]
    1900 |         return PHY_A + port - PORT_A;
         |                ~~~~~ ^ ~~~~
>> drivers/gpu/drm/i915/display/intel_display.c:1909:20: error: arithmetic between different enumeration types ('enum tc_port' and 'enum port') [-Werror,-Wenum-enum-conversion]
    1909 |                 return TC_PORT_1 + port - PORT_TC1;
         |                        ~~~~~~~~~ ^ ~~~~
   drivers/gpu/drm/i915/display/intel_display.c:1911:20: error: arithmetic between different enumeration types ('enum tc_port' and 'enum port') [-Werror,-Wenum-enum-conversion]
    1911 |                 return TC_PORT_1 + port - PORT_C;
         |                        ~~~~~~~~~ ^ ~~~~
   drivers/gpu/drm/i915/display/intel_display.c:1939:10: error: arithmetic between different enumeration types ('enum pipe' and 'enum intel_display_power_domain') [-Werror,-Wenum-enum-conversion]
    1939 |         set_bit(POWER_DOMAIN_PIPE(pipe), mask->bits);
         |                 ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/i915/display/intel_display_power.h:120:41: note: expanded from macro 'POWER_DOMAIN_PIPE'
     120 | #define POWER_DOMAIN_PIPE(pipe) ((pipe) + POWER_DOMAIN_PIPE_A)
         |                                  ~~~~~~ ^ ~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/i915/display/intel_display.c:1940:10: error: arithmetic between different enumeration types ('enum transcoder' and 'enum intel_display_power_domain') [-Werror,-Wenum-enum-conversion]
    1940 |         set_bit(POWER_DOMAIN_TRANSCODER(cpu_transcoder), mask->bits);
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/i915/display/intel_display_power.h:125:10: note: expanded from macro 'POWER_DOMAIN_TRANSCODER'
     125 |          (tran) + POWER_DOMAIN_TRANSCODER_A)
         |          ~~~~~~ ^ ~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/i915/display/intel_display.c:1943:11: error: arithmetic between different enumeration types ('enum pipe' and 'enum intel_display_power_domain') [-Werror,-Wenum-enum-conversion]
    1943 |                 set_bit(POWER_DOMAIN_PIPE_PANEL_FITTER(pipe), mask->bits);
         |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/i915/display/intel_display_power.h:122:11: note: expanded from macro 'POWER_DOMAIN_PIPE_PANEL_FITTER'
     122 |                 ((pipe) + POWER_DOMAIN_PIPE_PANEL_FITTER_A)
         |                  ~~~~~~ ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/i915/display/intel_display.c:2943:17: error: arithmetic between different enumeration types ('enum pipe' and 'enum intel_display_power_domain') [-Werror,-Wenum-enum-conversion]
    2943 |         power_domain = POWER_DOMAIN_PIPE(crtc->pipe);
         |                        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/i915/display/intel_display_power.h:120:41: note: expanded from macro 'POWER_DOMAIN_PIPE'
     120 | #define POWER_DOMAIN_PIPE(pipe) ((pipe) + POWER_DOMAIN_PIPE_A)
         |                                  ~~~~~~ ^ ~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/i915/display/intel_display.c:3335:17: error: arithmetic between different enumeration types ('enum pipe' and 'enum intel_display_power_domain') [-Werror,-Wenum-enum-conversion]
    3335 |         power_domain = POWER_DOMAIN_PIPE(crtc->pipe);
         |                        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/i915/display/intel_display_power.h:120:41: note: expanded from macro 'POWER_DOMAIN_PIPE'
     120 | #define POWER_DOMAIN_PIPE(pipe) ((pipe) + POWER_DOMAIN_PIPE_A)
         |                                  ~~~~~~ ^ ~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/i915/display/intel_display.c:3426:17: error: arithmetic between different enumeration types ('enum transcoder' and 'enum intel_display_power_domain') [-Werror,-Wenum-enum-conversion]
    3426 |         power_domain = POWER_DOMAIN_TRANSCODER(cpu_transcoder);
         |                        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/i915/display/intel_display_power.h:125:10: note: expanded from macro 'POWER_DOMAIN_TRANSCODER'
     125 |          (tran) + POWER_DOMAIN_TRANSCODER_A)
         |          ~~~~~~ ^ ~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/i915/display/intel_display.c:3464:18: error: arithmetic between different enumeration types ('enum pipe' and 'enum intel_display_power_domain') [-Werror,-Wenum-enum-conversion]
    3464 |                 power_domain = POWER_DOMAIN_PIPE(pipe);
         |                                ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/i915/display/intel_display_power.h:120:41: note: expanded from macro 'POWER_DOMAIN_PIPE'
     120 | #define POWER_DOMAIN_PIPE(pipe) ((pipe) + POWER_DOMAIN_PIPE_A)
         |                                  ~~~~~~ ^ ~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/i915/display/intel_display.c:3542:18: error: arithmetic between different enumeration types ('enum transcoder' and 'enum intel_display_power_domain') [-Werror,-Wenum-enum-conversion]
    3542 |                 power_domain = POWER_DOMAIN_TRANSCODER(cpu_transcoder);
         |                                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/i915/display/intel_display_power.h:125:10: note: expanded from macro 'POWER_DOMAIN_TRANSCODER'
     125 |          (tran) + POWER_DOMAIN_TRANSCODER_A)
         |          ~~~~~~ ^ ~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/i915/display/intel_display.c:3647:14: error: arithmetic between different enumeration types ('enum transcoder' and 'enum intel_display_power_domain') [-Werror,-Wenum-enum-conversion]
    3647 |                                                        POWER_DOMAIN_TRANSCODER(pipe_config->cpu_transcoder)))
         |                                                        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/i915/display/intel_display_power.h:125:10: note: expanded from macro 'POWER_DOMAIN_TRANSCODER'
     125 |          (tran) + POWER_DOMAIN_TRANSCODER_A)
         |          ~~~~~~ ^ ~~~~~~~~~~~~~~~~~~~~~~~~~
   fatal error: too many errors emitted, stopping now [-ferror-limit=]
   20 errors generated.

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for ACPI_WMI
   Depends on [n]: X86_PLATFORM_DEVICES [=n] && ACPI [=y]
   Selected by [m]:
   - DRM_XE [=m] && HAS_IOMEM [=y] && DRM [=m] && PCI [=y] && MMU [=y] && (m && MODULES [=y] || y && KUNIT [=n]=y) && ACPI [=y]


vim +1909 drivers/gpu/drm/i915/display/intel_display.c

358633e71c0747 drivers/gpu/drm/i915/display/intel_display.c Matt Roper    2019-07-09  1902  
ac213c1b45f7dc drivers/gpu/drm/i915/intel_display.c         Paulo Zanoni  2018-05-21  1903  enum tc_port intel_port_to_tc(struct drm_i915_private *dev_priv, enum port port)
ac213c1b45f7dc drivers/gpu/drm/i915/intel_display.c         Paulo Zanoni  2018-05-21  1904  {
358633e71c0747 drivers/gpu/drm/i915/display/intel_display.c Matt Roper    2019-07-09  1905  	if (!intel_phy_is_tc(dev_priv, intel_port_to_phy(dev_priv, port)))
320c670c048d3b drivers/gpu/drm/i915/display/intel_display.c Ville Syrjälä 2020-10-28  1906  		return TC_PORT_NONE;
ac213c1b45f7dc drivers/gpu/drm/i915/intel_display.c         Paulo Zanoni  2018-05-21  1907  
005e95377249cb drivers/gpu/drm/i915/display/intel_display.c Matt Roper    2021-03-19  1908  	if (DISPLAY_VER(dev_priv) >= 12)
1d8ca002456b6c drivers/gpu/drm/i915/display/intel_display.c Ville Syrjälä 2020-10-28 @1909  		return TC_PORT_1 + port - PORT_TC1;
1d8ca002456b6c drivers/gpu/drm/i915/display/intel_display.c Ville Syrjälä 2020-10-28  1910  	else
1d8ca002456b6c drivers/gpu/drm/i915/display/intel_display.c Ville Syrjälä 2020-10-28  1911  		return TC_PORT_1 + port - PORT_C;
ac213c1b45f7dc drivers/gpu/drm/i915/intel_display.c         Paulo Zanoni  2018-05-21  1912  }
ac213c1b45f7dc drivers/gpu/drm/i915/intel_display.c         Paulo Zanoni  2018-05-21  1913  

:::::: The code at line 1909 was first introduced by commit
:::::: 1d8ca002456b6c504b0af2d159c4776ba6b1ad81 drm/i915: Add PORT_TCn aliases to enum port

:::::: TO: Ville Syrjälä <ville.syrjala@linux.intel.com>
:::::: CC: Ville Syrjälä <ville.syrjala@linux.intel.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

