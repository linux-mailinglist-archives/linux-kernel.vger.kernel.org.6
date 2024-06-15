Return-Path: <linux-kernel+bounces-215898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8538790987F
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 15:22:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FFD4282969
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 13:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4436949630;
	Sat, 15 Jun 2024 13:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OQf9KnD2"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9002717BB6
	for <linux-kernel@vger.kernel.org>; Sat, 15 Jun 2024 13:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718457742; cv=none; b=h5SdbDlvw9EqRPsZIdCNhmBD9CrRWAUzC6FJE3W+92AQhjAGLZ+nFx9eHRFrlyvrmY9fKMvxsBG9q+52lMoq4jrH3weGCxdvZdHqw+R1YlRM8WrJaE9B3Vfdv9HmgL6ZQEto/7j/Y4b4P9SwzjQ9hO1l8125P2goIqdrTm4BHIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718457742; c=relaxed/simple;
	bh=VCwZ+uyjW8n4BUAUo5BVEnDRbQ5NO/STlblMvhBGawk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=pqi8+2bPyjRecvX8hjXRTFaNXTYAfHHAJExsLBS2xBa3yApOqiWUXgjA8hZqNkUodLF9loSHRB74RVavyqiGxkhGrQ+uZnGOL9hprw6u4WCJGrzhtMiWJ+IKuxUk4UdWifZJN5Hhl1rP/aab77EMESXZ8Af6bJfRv++1Np54R/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OQf9KnD2; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718457740; x=1749993740;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=VCwZ+uyjW8n4BUAUo5BVEnDRbQ5NO/STlblMvhBGawk=;
  b=OQf9KnD23QeqV2Fb7bnQhrnjrsevBDoSwLULXQob/XfKwhEqHen1w2mf
   dC110dL2oXnnZQWnGEJP9Ho0B3EDcb4ZK0OvGAbtRfwq93M1ow2pug8WC
   DnQOgR+fn3ulEstg7xq06osllXgy0xBnoWV+fsKBOEF7TKblR3wy7UVXb
   44KYxuxnAVoTExKn/Ifg3HWsxZaithe8i14GH7MXCM/XRvHB4tLD7jbM0
   3C1oHNskoSq3muTengvQ3JcO4eu1ZE/xd0Vevf97oxhR8N3pUuVvx9DXO
   09OqX9GFpLg2pYb2tAO4Yu2878JlpMK/ypT8jsWIJAx6TsKCROT/ddtyv
   A==;
X-CSE-ConnectionGUID: kVP5qi5TR2m28ah9CjshFQ==
X-CSE-MsgGUID: UQa9QHG9TmSJwSN6qwh9rQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11104"; a="32887898"
X-IronPort-AV: E=Sophos;i="6.08,240,1712646000"; 
   d="scan'208";a="32887898"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2024 06:22:19 -0700
X-CSE-ConnectionGUID: snOxOt67TZmWisUxF9DC0A==
X-CSE-MsgGUID: l/8KA7xaTPOiNfgLF/WTkA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,240,1712646000"; 
   d="scan'208";a="40712551"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 15 Jun 2024 06:22:17 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sITMF-00003s-22;
	Sat, 15 Jun 2024 13:22:15 +0000
Date: Sat, 15 Jun 2024 21:22:00 +0800
From: kernel test robot <lkp@intel.com>
To: Alexey Makhalov <alexey.makhalov@broadcom.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	x86@kernel.org, "Borislav Petkov (AMD)" <bp@alien8.de>
Subject: [tip:x86/vmware 4/8] vmwgfx_msg.c:undefined reference to
 `vmware_hypercall_slow'
Message-ID: <202406152104.FxakP1MB-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/vmware
head:   ef08e7dc21307b226b5280d5e8cfea687bfd2866
commit: e5ac9008b79c59235c34494e555419665022f5e1 [4/8] drm/vmwgfx: Use VMware hypercall API
config: i386-buildonly-randconfig-002-20240615 (https://download.01.org/0day-ci/archive/20240615/202406152104.FxakP1MB-lkp@intel.com/config)
compiler: gcc-9 (Ubuntu 9.5.0-4ubuntu2) 9.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240615/202406152104.FxakP1MB-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406152104.FxakP1MB-lkp@intel.com/

All errors (new ones prefixed by >>):

   ld: drivers/gpu/drm/vmwgfx/vmwgfx_msg.o: in function `vmw_open_channel.constprop.0':
>> vmwgfx_msg.c:(.text+0x203): undefined reference to `vmware_hypercall_slow'
   ld: drivers/gpu/drm/vmwgfx/vmwgfx_msg.o: in function `vmw_recv_msg':
   vmwgfx_msg.c:(.text+0x46f): undefined reference to `vmware_hypercall_slow'
>> ld: vmwgfx_msg.c:(.text+0x49c): undefined reference to `vmware_hypercall_slow'
   ld: vmwgfx_msg.c:(.text+0x4c3): undefined reference to `vmware_hypercall_slow'
   ld: drivers/gpu/drm/vmwgfx/vmwgfx_msg.o: in function `vmw_close_channel':
   vmwgfx_msg.c:(.text+0x580): undefined reference to `vmware_hypercall_slow'
   ld: drivers/gpu/drm/vmwgfx/vmwgfx_msg.o:vmwgfx_msg.c:(.text+0x729): more undefined references to `vmware_hypercall_slow' follow
   ld: drivers/base/regmap/regmap-spi.o: in function `regmap_spi_read':
   regmap-spi.c:(.text+0xf): undefined reference to `spi_write_then_read'
   ld: drivers/base/regmap/regmap-spi.o: in function `regmap_spi_gather_write':
   regmap-spi.c:(.text+0x2b4): undefined reference to `spi_sync'
   ld: drivers/base/regmap/regmap-spi.o: in function `spi_sync_transfer.constprop.0':
   regmap-spi.c:(.text+0x337): undefined reference to `spi_sync'
   ld: drivers/base/regmap/regmap-spi.o: in function `regmap_spi_async_write':
   regmap-spi.c:(.text+0x445): undefined reference to `spi_async'
   ld: drivers/iio/dac/ad9739a.o: in function `ad9739a_driver_init':
   ad9739a.c:(.init.text+0x10): undefined reference to `__spi_register_driver'

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for REGMAP_SPI
   Depends on [n]: SPI [=n]
   Selected by [y]:
   - AD9739A [=y] && IIO [=y] && (SPI [=n] || COMPILE_TEST [=y])

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

