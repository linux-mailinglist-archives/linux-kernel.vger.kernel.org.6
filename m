Return-Path: <linux-kernel+bounces-439181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60F9D9EABF7
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 10:28:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15CB9188141B
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 09:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D7D6233D9F;
	Tue, 10 Dec 2024 09:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WkNJj7o7"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E40DD234961
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 09:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733822900; cv=none; b=RYaOIOe6mSRf/onCynoD5gB7xkt0DnVzI5vljS1G6xgf0vRKDqGhLCcLKC44rx1Xa3A7icdz1feLwdlvzcAdaNC0QTZd709EXOQthGZTOTNp0eylMhcizmBN+tTudWJ5jyZVIuU4dnVwY7ddYNAgRx7eJpojwHk0W+dTnQu2ovQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733822900; c=relaxed/simple;
	bh=LjfoLzNczXxo4qRkdYXormMvdg1rRZdXzSXH8EFj3xI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=U1TMl8+r2SO9x5mrOhtWDisBxTq+QQvq78cpJxuRE03RO4kMA3yF53TphiKW+6M/ccUGFfEWJcQ7evTPOkj4CFmfPyhXLTqXhp3JGHCBrxoHxHtrRwTwdR7eU6jZu4njAzYrS0tnfSGoQImdDxR+jAwhgtZV4PZau4ba410z9n0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WkNJj7o7; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733822898; x=1765358898;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=LjfoLzNczXxo4qRkdYXormMvdg1rRZdXzSXH8EFj3xI=;
  b=WkNJj7o7xqwVv2/ogR7I6yBsWtW+WXBJD6sGHUEKn1Hajd+C9qb2O08d
   I60PascjYPQXpDaHcBeVl0zOFsP0bSO6HZJ8rZkc2BaMAJz4Js0qFHp7b
   HkSM/BZ+Q4E2YqgtJIbaHwXdFtZC+SxlBfyoNH6l4CiQLDd2mX9NopsB1
   poPPK0k/ahJnF8PTceuI1LTzflCTYAJG3b1Fc7JUEBL6X2AtKb6IhA7sf
   cIFQ5TSo76XBZ4zvxp+uIlglBYM3x9Xxg98Ae2K35uiCVACj/4TVe2qpf
   LwQWm9t3VAyHUm7QZrWFCvcerUE2LsdgYIIGQonJkVMcbyPZYXmNEBoL/
   Q==;
X-CSE-ConnectionGUID: 3FI5+cK2SluR34b6IKl5xg==
X-CSE-MsgGUID: JuenIVqSTmiGPFZfQy9FKw==
X-IronPort-AV: E=McAfee;i="6700,10204,11281"; a="45166566"
X-IronPort-AV: E=Sophos;i="6.12,222,1728975600"; 
   d="scan'208";a="45166566"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2024 01:28:17 -0800
X-CSE-ConnectionGUID: CqgY6qQ6QfqNUbbCynMHXg==
X-CSE-MsgGUID: G6aPQf2dRfKZt7lspZiR4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,222,1728975600"; 
   d="scan'208";a="95183228"
Received: from lkp-server01.sh.intel.com (HELO 82a3f569d0cb) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 10 Dec 2024 01:28:15 -0800
Received: from kbuild by 82a3f569d0cb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tKwXN-0005KL-0D;
	Tue, 10 Dec 2024 09:28:13 +0000
Date: Tue, 10 Dec 2024 17:27:19 +0800
From: kernel test robot <lkp@intel.com>
To: Lucas De Marchi <lucas.demarchi@intel.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Matt Roper <matthew.d.roper@intel.com>
Subject: drivers/gpu/drm/i915/display/intel_display.c:314:17: error:
 arithmetic between different enumeration types ('enum transcoder' and 'enum
 intel_display_power_domain')
Message-ID: <202412101732.5G5eKPLV-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   7cb1b466315004af98f6ba6c2546bb713ca3c237
commit: 237412e45390805e14a6936fb998d756c4eac9d8 drm/xe: Enable 32bits build
date:   10 months ago
config: i386-randconfig-001-20241209 (https://download.01.org/0day-ci/archive/20241210/202412101732.5G5eKPLV-lkp@intel.com/config)
compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51eccf88f5321e7c60591c5546b254b6afab99)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241210/202412101732.5G5eKPLV-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412101732.5G5eKPLV-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/gpu/drm/i915/display/intel_display.c:28:
   In file included from include/linux/i2c.h:19:
   In file included from include/linux/regulator/consumer.h:35:
   In file included from include/linux/suspend.h:5:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:20:
   In file included from include/linux/mm.h:2188:
   include/linux/vmstat.h:522:36: error: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Werror,-Wenum-enum-conversion]
     522 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
>> drivers/gpu/drm/i915/display/intel_display.c:314:17: error: arithmetic between different enumeration types ('enum transcoder' and 'enum intel_display_power_domain') [-Werror,-Wenum-enum-conversion]
     314 |         power_domain = POWER_DOMAIN_TRANSCODER(cpu_transcoder);
         |                        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/i915/display/intel_display_power.h:125:10: note: expanded from macro 'POWER_DOMAIN_TRANSCODER'
     125 |          (tran) + POWER_DOMAIN_TRANSCODER_A)
         |          ~~~~~~ ^ ~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/gpu/drm/i915/display/intel_display.c:1889:16: error: arithmetic between different enumeration types ('enum phy' and 'enum port') [-Werror,-Wenum-enum-conversion]
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
>> drivers/gpu/drm/i915/display/intel_display.c:1939:10: error: arithmetic between different enumeration types ('enum pipe' and 'enum intel_display_power_domain') [-Werror,-Wenum-enum-conversion]
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
   drivers/gpu/drm/i915/display/intel_display.c:3679:15: error: arithmetic between different enumeration types ('enum transcoder' and 'enum intel_display_power_domain') [-Werror,-Wenum-enum-conversion]
    3679 |                                                                POWER_DOMAIN_TRANSCODER(cpu_transcoder)))
         |                                                                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/i915/display/intel_display_power.h:125:10: note: expanded from macro 'POWER_DOMAIN_TRANSCODER'
     125 |          (tran) + POWER_DOMAIN_TRANSCODER_A)
         |          ~~~~~~ ^ ~~~~~~~~~~~~~~~~~~~~~~~~~
   fatal error: too many errors emitted, stopping now [-ferror-limit=]
   20 errors generated.
--
   In file included from drivers/gpu/drm/i915/display/intel_tc.c:6:
   In file included from drivers/gpu/drm/xe/compat-i915-headers/i915_drv.h:15:
   In file included from drivers/gpu/drm/xe/compat-i915-headers/gem/i915_gem_object.h:11:
   In file included from drivers/gpu/drm/xe/xe_bo.h:9:
   In file included from include/drm/ttm/ttm_tt.h:30:
   In file included from include/linux/pagemap.h:8:
   In file included from include/linux/mm.h:2188:
   include/linux/vmstat.h:522:36: error: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Werror,-Wenum-enum-conversion]
     522 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
>> drivers/gpu/drm/i915/display/intel_tc.c:251:41: error: arithmetic between different enumeration types ('enum intel_display_power_domain' and 'enum tc_port') [-Werror,-Wenum-enum-conversion]
     251 |         return POWER_DOMAIN_PORT_DDI_LANES_TC1 + tc_port - TC_PORT_1;
         |                ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ^ ~~~~~~~
   2 errors generated.
--
   In file included from drivers/gpu/drm/i915/display/skl_universal_plane.c:6:
   In file included from include/drm/drm_atomic_helper.h:31:
   In file included from include/drm/drm_crtc.h:32:
   In file included from include/drm/drm_modes.h:33:
   In file included from include/drm/drm_connector.h:32:
   In file included from include/drm/drm_util.h:36:
   In file included from include/linux/kgdb.h:19:
   In file included from include/linux/kprobes.h:28:
   In file included from include/linux/ftrace.h:13:
   In file included from include/linux/kallsyms.h:13:
   In file included from include/linux/mm.h:2188:
   include/linux/vmstat.h:522:36: error: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Werror,-Wenum-enum-conversion]
     522 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
>> drivers/gpu/drm/i915/display/skl_universal_plane.c:673:17: error: arithmetic between different enumeration types ('enum pipe' and 'enum intel_display_power_domain') [-Werror,-Wenum-enum-conversion]
     673 |         power_domain = POWER_DOMAIN_PIPE(plane->pipe);
         |                        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/i915/display/intel_display_power.h:120:41: note: expanded from macro 'POWER_DOMAIN_PIPE'
     120 | #define POWER_DOMAIN_PIPE(pipe) ((pipe) + POWER_DOMAIN_PIPE_A)
         |                                  ~~~~~~ ^ ~~~~~~~~~~~~~~~~~~~
   2 errors generated.
--
   In file included from drivers/gpu/drm/i915/display/intel_display_irq.c:7:
   In file included from drivers/gpu/drm/xe/compat-i915-headers/i915_drv.h:15:
   In file included from drivers/gpu/drm/xe/compat-i915-headers/gem/i915_gem_object.h:11:
   In file included from drivers/gpu/drm/xe/xe_bo.h:9:
   In file included from include/drm/ttm/ttm_tt.h:30:
   In file included from include/linux/pagemap.h:8:
   In file included from include/linux/mm.h:2188:
   include/linux/vmstat.h:522:36: error: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Werror,-Wenum-enum-conversion]
     522 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
>> drivers/gpu/drm/i915/display/intel_display_irq.c:1428:10: error: arithmetic between different enumeration types ('enum pipe' and 'enum intel_display_power_domain') [-Werror,-Wenum-enum-conversion]
    1428 |                                                    POWER_DOMAIN_PIPE(pipe)))
         |                                                    ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/i915/display/intel_display_power.h:120:41: note: expanded from macro 'POWER_DOMAIN_PIPE'
     120 | #define POWER_DOMAIN_PIPE(pipe) ((pipe) + POWER_DOMAIN_PIPE_A)
         |                                  ~~~~~~ ^ ~~~~~~~~~~~~~~~~~~~
>> drivers/gpu/drm/i915/display/intel_display_irq.c:1453:13: error: arithmetic between different enumeration types ('enum transcoder' and 'enum intel_display_power_domain') [-Werror,-Wenum-enum-conversion]
    1453 |                         domain = POWER_DOMAIN_TRANSCODER(trans);
         |                                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/i915/display/intel_display_power.h:125:10: note: expanded from macro 'POWER_DOMAIN_TRANSCODER'
     125 |          (tran) + POWER_DOMAIN_TRANSCODER_A)
         |          ~~~~~~ ^ ~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/i915/display/intel_display_irq.c:1467:10: error: arithmetic between different enumeration types ('enum pipe' and 'enum intel_display_power_domain') [-Werror,-Wenum-enum-conversion]
    1467 |                                                    POWER_DOMAIN_PIPE(pipe)))
         |                                                    ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/i915/display/intel_display_power.h:120:41: note: expanded from macro 'POWER_DOMAIN_PIPE'
     120 | #define POWER_DOMAIN_PIPE(pipe) ((pipe) + POWER_DOMAIN_PIPE_A)
         |                                  ~~~~~~ ^ ~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/i915/display/intel_display_irq.c:1686:13: error: arithmetic between different enumeration types ('enum transcoder' and 'enum intel_display_power_domain') [-Werror,-Wenum-enum-conversion]
    1686 |                         domain = POWER_DOMAIN_TRANSCODER(trans);
         |                                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/i915/display/intel_display_power.h:125:10: note: expanded from macro 'POWER_DOMAIN_TRANSCODER'
     125 |          (tran) + POWER_DOMAIN_TRANSCODER_A)
         |          ~~~~~~ ^ ~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/i915/display/intel_display_irq.c:1700:10: error: arithmetic between different enumeration types ('enum pipe' and 'enum intel_display_power_domain') [-Werror,-Wenum-enum-conversion]
    1700 |                                                    POWER_DOMAIN_PIPE(pipe)))
         |                                                    ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/i915/display/intel_display_power.h:120:41: note: expanded from macro 'POWER_DOMAIN_PIPE'
     120 | #define POWER_DOMAIN_PIPE(pipe) ((pipe) + POWER_DOMAIN_PIPE_A)
         |                                  ~~~~~~ ^ ~~~~~~~~~~~~~~~~~~~
   6 errors generated.
--
   In file included from drivers/gpu/drm/i915/display/intel_pipe_crc.c:34:
   In file included from drivers/gpu/drm/i915/display/intel_de.h:9:
   In file included from drivers/gpu/drm/xe/compat-i915-headers/i915_drv.h:15:
   In file included from drivers/gpu/drm/xe/compat-i915-headers/gem/i915_gem_object.h:11:
   In file included from drivers/gpu/drm/xe/xe_bo.h:9:
   In file included from include/drm/ttm/ttm_tt.h:30:
   In file included from include/linux/pagemap.h:8:
   In file included from include/linux/mm.h:2188:
   include/linux/vmstat.h:522:36: error: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Werror,-Wenum-enum-conversion]
     522 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
>> drivers/gpu/drm/i915/display/intel_pipe_crc.c:594:17: error: arithmetic between different enumeration types ('enum pipe' and 'enum intel_display_power_domain') [-Werror,-Wenum-enum-conversion]
     594 |         power_domain = POWER_DOMAIN_PIPE(pipe);
         |                        ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/i915/display/intel_display_power.h:120:41: note: expanded from macro 'POWER_DOMAIN_PIPE'
     120 | #define POWER_DOMAIN_PIPE(pipe) ((pipe) + POWER_DOMAIN_PIPE_A)
         |                                  ~~~~~~ ^ ~~~~~~~~~~~~~~~~~~~
   2 errors generated.
--
   In file included from drivers/gpu/drm/i915/display/skl_watermark.c:8:
   In file included from drivers/gpu/drm/xe/compat-i915-headers/i915_drv.h:15:
   In file included from drivers/gpu/drm/xe/compat-i915-headers/gem/i915_gem_object.h:11:
   In file included from drivers/gpu/drm/xe/xe_bo.h:9:
   In file included from include/drm/ttm/ttm_tt.h:30:
   In file included from include/linux/pagemap.h:8:
   In file included from include/linux/mm.h:2188:
   include/linux/vmstat.h:522:36: error: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Werror,-Wenum-enum-conversion]
     522 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
>> drivers/gpu/drm/i915/display/skl_watermark.c:810:17: error: arithmetic between different enumeration types ('enum pipe' and 'enum intel_display_power_domain') [-Werror,-Wenum-enum-conversion]
     810 |         power_domain = POWER_DOMAIN_PIPE(pipe);
         |                        ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/i915/display/intel_display_power.h:120:41: note: expanded from macro 'POWER_DOMAIN_PIPE'
     120 | #define POWER_DOMAIN_PIPE(pipe) ((pipe) + POWER_DOMAIN_PIPE_A)
         |                                  ~~~~~~ ^ ~~~~~~~~~~~~~~~~~~~
   2 errors generated.
--
   In file included from drivers/gpu/drm/i915/display/intel_ddi.c:32:
   In file included from include/drm/drm_privacy_screen_consumer.h:13:
   In file included from include/drm/drm_connector.h:32:
   In file included from include/drm/drm_util.h:36:
   In file included from include/linux/kgdb.h:19:
   In file included from include/linux/kprobes.h:28:
   In file included from include/linux/ftrace.h:13:
   In file included from include/linux/kallsyms.h:13:
   In file included from include/linux/mm.h:2188:
   include/linux/vmstat.h:522:36: error: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Werror,-Wenum-enum-conversion]
     522 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
>> drivers/gpu/drm/i915/display/intel_ddi.c:811:12: error: arithmetic between different enumeration types ('enum transcoder' and 'enum intel_display_power_domain') [-Werror,-Wenum-enum-conversion]
     811 |                                                                    POWER_DOMAIN_TRANSCODER(cpu_transcoder));
         |                                                                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/i915/display/intel_display_power.h:125:10: note: expanded from macro 'POWER_DOMAIN_TRANSCODER'
     125 |          (tran) + POWER_DOMAIN_TRANSCODER_A)
         |          ~~~~~~ ^ ~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/i915/display/intel_ddi.c:825:37: error: arithmetic between different enumeration types ('enum transcoder' and 'enum intel_display_power_domain') [-Werror,-Wenum-enum-conversion]
     825 |                 intel_display_power_put(dev_priv, POWER_DOMAIN_TRANSCODER(cpu_transcoder),
         |                                                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/i915/display/intel_display_power.h:125:10: note: expanded from macro 'POWER_DOMAIN_TRANSCODER'
     125 |          (tran) + POWER_DOMAIN_TRANSCODER_A)
         |          ~~~~~~ ^ ~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/i915/display/intel_ddi.c:3754:18: error: arithmetic between different enumeration types ('enum transcoder' and 'enum intel_display_power_domain') [-Werror,-Wenum-enum-conversion]
    3754 |                 power_domain = POWER_DOMAIN_TRANSCODER(cpu_transcoder);
         |                                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/i915/display/intel_display_power.h:125:10: note: expanded from macro 'POWER_DOMAIN_TRANSCODER'
     125 |          (tran) + POWER_DOMAIN_TRANSCODER_A)
         |          ~~~~~~ ^ ~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/gpu/drm/i915/display/intel_ddi.c:4669:21: error: arithmetic between different enumeration types ('enum hpd_pin' and 'enum port') [-Werror,-Wenum-enum-conversion]
    4669 |                 return HPD_PORT_D + port - PORT_D_XELPD;
         |                        ~~~~~~~~~~ ^ ~~~~
   drivers/gpu/drm/i915/display/intel_ddi.c:4671:23: error: arithmetic between different enumeration types ('enum hpd_pin' and 'enum port') [-Werror,-Wenum-enum-conversion]
    4671 |                 return HPD_PORT_TC1 + port - PORT_TC1;
         |                        ~~~~~~~~~~~~ ^ ~~~~
   drivers/gpu/drm/i915/display/intel_ddi.c:4673:21: error: arithmetic between different enumeration types ('enum hpd_pin' and 'enum port') [-Werror,-Wenum-enum-conversion]
    4673 |                 return HPD_PORT_A + port - PORT_A;
         |                        ~~~~~~~~~~ ^ ~~~~
   drivers/gpu/drm/i915/display/intel_ddi.c:4680:21: error: arithmetic between different enumeration types ('enum hpd_pin' and 'enum port') [-Werror,-Wenum-enum-conversion]
    4680 |                 return HPD_PORT_C + port - PORT_TC1;
         |                        ~~~~~~~~~~ ^ ~~~~
   drivers/gpu/drm/i915/display/intel_ddi.c:4682:21: error: arithmetic between different enumeration types ('enum hpd_pin' and 'enum port') [-Werror,-Wenum-enum-conversion]
    4682 |                 return HPD_PORT_A + port - PORT_A;
         |                        ~~~~~~~~~~ ^ ~~~~
   drivers/gpu/drm/i915/display/intel_ddi.c:4689:23: error: arithmetic between different enumeration types ('enum hpd_pin' and 'enum port') [-Werror,-Wenum-enum-conversion]
    4689 |                 return HPD_PORT_TC1 + port - PORT_TC1;
         |                        ~~~~~~~~~~~~ ^ ~~~~
   drivers/gpu/drm/i915/display/intel_ddi.c:4691:21: error: arithmetic between different enumeration types ('enum hpd_pin' and 'enum port') [-Werror,-Wenum-enum-conversion]
    4691 |                 return HPD_PORT_A + port - PORT_A;
         |                        ~~~~~~~~~~ ^ ~~~~
   drivers/gpu/drm/i915/display/intel_ddi.c:4701:21: error: arithmetic between different enumeration types ('enum hpd_pin' and 'enum port') [-Werror,-Wenum-enum-conversion]
    4701 |                 return HPD_PORT_C + port - PORT_TC1;
         |                        ~~~~~~~~~~ ^ ~~~~
   drivers/gpu/drm/i915/display/intel_ddi.c:4703:21: error: arithmetic between different enumeration types ('enum hpd_pin' and 'enum port') [-Werror,-Wenum-enum-conversion]
    4703 |                 return HPD_PORT_A + port - PORT_A;
         |                        ~~~~~~~~~~ ^ ~~~~
   drivers/gpu/drm/i915/display/intel_ddi.c:4710:23: error: arithmetic between different enumeration types ('enum hpd_pin' and 'enum port') [-Werror,-Wenum-enum-conversion]
    4710 |                 return HPD_PORT_TC1 + port - PORT_C;
         |                        ~~~~~~~~~~~~ ^ ~~~~
   drivers/gpu/drm/i915/display/intel_ddi.c:4712:21: error: arithmetic between different enumeration types ('enum hpd_pin' and 'enum port') [-Werror,-Wenum-enum-conversion]
    4712 |                 return HPD_PORT_A + port - PORT_A;
         |                        ~~~~~~~~~~ ^ ~~~~
   drivers/gpu/drm/i915/display/intel_ddi.c:4724:20: error: arithmetic between different enumeration types ('enum hpd_pin' and 'enum port') [-Werror,-Wenum-enum-conversion]
    4724 |         return HPD_PORT_A + port - PORT_A;
         |                ~~~~~~~~~~ ^ ~~~~
   drivers/gpu/drm/i915/display/intel_ddi.c:4732:20: error: arithmetic between different enumeration types ('enum hpd_pin' and 'enum port') [-Werror,-Wenum-enum-conversion]
    4732 |         return HPD_PORT_A + port - PORT_A;
         |                ~~~~~~~~~~ ^ ~~~~
   17 errors generated.
--
   In file included from drivers/gpu/drm/i915/display/intel_dpll_mgr.c:28:
   In file included from drivers/gpu/drm/i915/display/intel_de.h:9:
   In file included from drivers/gpu/drm/xe/compat-i915-headers/i915_drv.h:15:
   In file included from drivers/gpu/drm/xe/compat-i915-headers/gem/i915_gem_object.h:11:
   In file included from drivers/gpu/drm/xe/xe_bo.h:9:
   In file included from include/drm/ttm/ttm_tt.h:30:
   In file included from include/linux/pagemap.h:8:
   In file included from include/linux/mm.h:2188:
   include/linux/vmstat.h:522:36: error: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Werror,-Wenum-enum-conversion]
     522 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
>> drivers/gpu/drm/i915/display/intel_dpll_mgr.c:188:19: error: arithmetic between different enumeration types ('enum tc_port' and 'enum intel_dpll_id') [-Werror,-Wenum-enum-conversion]
     188 |         return TC_PORT_1 + id - DPLL_ID_ICL_MGPLL1;
         |                ~~~~~~~~~ ^ ~~
   2 errors generated.
..


vim +314 drivers/gpu/drm/i915/display/intel_display.c

79e539453b34e35 drivers/gpu/drm/i915/intel_display.c         Jesse Barnes  2008-11-07  302  
8c66081b0b32a5f drivers/gpu/drm/i915/display/intel_display.c Ville Syrjälä 2021-09-13  303  void assert_transcoder(struct drm_i915_private *dev_priv,
b104e8b200974f9 drivers/gpu/drm/i915/display/intel_display.c Ville Syrjälä 2019-11-12  304  		       enum transcoder cpu_transcoder, bool state)
b24e71798871089 drivers/gpu/drm/i915/intel_display.c         Jesse Barnes  2011-01-04  305  {
63d7bbe9ded4146 drivers/gpu/drm/i915/intel_display.c         Jesse Barnes  2011-01-04  306  	bool cur_state;
4feed0ebfa45879 drivers/gpu/drm/i915/intel_display.c         Imre Deak     2016-02-12  307  	enum intel_display_power_domain power_domain;
0e6e0be4c952372 drivers/gpu/drm/i915/intel_display.c         Chris Wilson  2019-01-14  308  	intel_wakeref_t wakeref;
b24e71798871089 drivers/gpu/drm/i915/intel_display.c         Jesse Barnes  2011-01-04  309  
e56134bc79569d5 drivers/gpu/drm/i915/intel_display.c         Ville Syrjälä 2017-06-01  310  	/* we keep both pipes enabled on 830 */
e56134bc79569d5 drivers/gpu/drm/i915/intel_display.c         Ville Syrjälä 2017-06-01  311  	if (IS_I830(dev_priv))
8e636784b6f7665 drivers/gpu/drm/i915/intel_display.c         Daniel Vetter 2012-01-22  312  		state = true;
8e636784b6f7665 drivers/gpu/drm/i915/intel_display.c         Daniel Vetter 2012-01-22  313  
4feed0ebfa45879 drivers/gpu/drm/i915/intel_display.c         Imre Deak     2016-02-12 @314  	power_domain = POWER_DOMAIN_TRANSCODER(cpu_transcoder);
0e6e0be4c952372 drivers/gpu/drm/i915/intel_display.c         Chris Wilson  2019-01-14  315  	wakeref = intel_display_power_get_if_enabled(dev_priv, power_domain);
0e6e0be4c952372 drivers/gpu/drm/i915/intel_display.c         Chris Wilson  2019-01-14  316  	if (wakeref) {
3eb08ea58e5717c drivers/gpu/drm/i915/display/intel_display.c Ville Syrjälä 2023-02-14  317  		u32 val = intel_de_read(dev_priv, TRANSCONF(cpu_transcoder));
3eb08ea58e5717c drivers/gpu/drm/i915/display/intel_display.c Ville Syrjälä 2023-02-14  318  		cur_state = !!(val & TRANSCONF_ENABLE);
4feed0ebfa45879 drivers/gpu/drm/i915/intel_display.c         Imre Deak     2016-02-12  319  
0e6e0be4c952372 drivers/gpu/drm/i915/intel_display.c         Chris Wilson  2019-01-14  320  		intel_display_power_put(dev_priv, power_domain, wakeref);
4feed0ebfa45879 drivers/gpu/drm/i915/intel_display.c         Imre Deak     2016-02-12  321  	} else {
4feed0ebfa45879 drivers/gpu/drm/i915/intel_display.c         Imre Deak     2016-02-12  322  		cur_state = false;
693101618a4beed drivers/gpu/drm/i915/intel_display.c         Paulo Zanoni  2013-01-29  323  	}
693101618a4beed drivers/gpu/drm/i915/intel_display.c         Paulo Zanoni  2013-01-29  324  
6b9bd7c35d32be4 drivers/gpu/drm/i915/display/intel_display.c Jani Nikula   2023-05-12  325  	I915_STATE_WARN(dev_priv, cur_state != state,
b104e8b200974f9 drivers/gpu/drm/i915/display/intel_display.c Ville Syrjälä 2019-11-12  326  			"transcoder %s assertion failure (expected %s, current %s)\n",
6b9bd7c35d32be4 drivers/gpu/drm/i915/display/intel_display.c Jani Nikula   2023-05-12  327  			transcoder_name(cpu_transcoder), str_on_off(state),
6b9bd7c35d32be4 drivers/gpu/drm/i915/display/intel_display.c Jani Nikula   2023-05-12  328  			str_on_off(cur_state));
b24e71798871089 drivers/gpu/drm/i915/intel_display.c         Jesse Barnes  2011-01-04  329  }
b24e71798871089 drivers/gpu/drm/i915/intel_display.c         Jesse Barnes  2011-01-04  330  

:::::: The code at line 314 was first introduced by commit
:::::: 4feed0ebfa45879bc422c9a0bfa3cffec82ea60a drm/i915: Ensure the HW is powered during HW access in assert_pipe

:::::: TO: Imre Deak <imre.deak@intel.com>
:::::: CC: Imre Deak <imre.deak@intel.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

