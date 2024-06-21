Return-Path: <linux-kernel+bounces-223865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A4ADE911996
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 06:38:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2FBC4B230ED
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 04:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C886D12CD9B;
	Fri, 21 Jun 2024 04:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GR4+8wNb"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF8843687
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 04:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718944710; cv=none; b=Q1gaPu85Hvm3TOlAkVXLGVsOufdQZRHB/ybM1mr+npyDvkMnTYDWJN85yODTxAwghxuUd7we+zsqD/02hqmZSODrIq+xU27rglIrdS8yhsLmfs9NXOWxUmF+BqEA5er50XTZGM18FfB0/ivkgLInB0wr2PQEEGEmDlF7yQMFFDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718944710; c=relaxed/simple;
	bh=gNwz/g7O+nsS27JCGHYoWE+4IVggQp+k+Y26cxAwxFI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=oV0fwd53GwVjiLDi9i0xR8AnckCPgAxThsTA/x4qQdQBtlFyfvgijedmJCNIHY3h8XTpXclauZTEpG17qWNOUNkc3vJ/O8jDfW4A/9ickD9fqUm9AQ+MM4RLMGncqKdJpyE8ipUglYrMIMJA+G5Wse8UYzw9MPLSYfiWGV5FYQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GR4+8wNb; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718944708; x=1750480708;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=gNwz/g7O+nsS27JCGHYoWE+4IVggQp+k+Y26cxAwxFI=;
  b=GR4+8wNbCYETho3WECNlumOxOnkD0BqKeRIF6JeZ2mXA004P56DgYyo3
   W9W+ZxLShzX4LxDc+biHdAM5kvgVQ04x4lkQTNjkyLkd9jOLtPfEZjxR9
   og6i1ikDzQFV6fwK/LLSMCV3A0F7tkfVpCxjBbaiC2VTWHUFeW4Giwr8N
   JvygUg/EVhDDmVyvyxeo9s19jxxDziM+2iW+9bjinO8mnGOqI3DraEc46
   dRQ5ThDLcf8hANdeGoe+6OiBRde5YHfRmnA3+s6JrDMfHDCFvqIrP6BKE
   wQdxAQFsCo/3RONswl7oYYnsiS7Wt+4APfEHkZujhh6X1S6AYj7jyrRx8
   w==;
X-CSE-ConnectionGUID: eEfHCPsfQ8iwkUZpq3q02w==
X-CSE-MsgGUID: mctMvjizRE69heK3/rfDMA==
X-IronPort-AV: E=McAfee;i="6700,10204,11109"; a="19739619"
X-IronPort-AV: E=Sophos;i="6.08,253,1712646000"; 
   d="scan'208";a="19739619"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2024 21:38:27 -0700
X-CSE-ConnectionGUID: 245XCLHJTK26G6XdGkuIrA==
X-CSE-MsgGUID: 18OuxUEYSB2nGtexs3zRew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,253,1712646000"; 
   d="scan'208";a="47659668"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 20 Jun 2024 21:38:25 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sKW2Z-0008Ec-2a;
	Fri, 21 Jun 2024 04:38:23 +0000
Date: Fri, 21 Jun 2024 12:38:18 +0800
From: kernel test robot <lkp@intel.com>
To: Simon Trimmer <simont@opensource.cirrus.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Takashi Iwai <tiwai@suse.de>
Subject: serial-multi-instantiate.c:undefined reference to
 `spi_unregister_device'
Message-ID: <202406211244.oLhoF3My-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   50736169ecc8387247fe6a00932852ce7b057083
commit: 9b1effff19cdf2230d3ecb07ff4038a0da32e9cc ALSA: hda: cs35l56: Select SERIAL_MULTI_INSTANTIATE
date:   21 hours ago
config: x86_64-buildonly-randconfig-003-20231229 (https://download.01.org/0day-ci/archive/20240621/202406211244.oLhoF3My-lkp@intel.com/config)
compiler: gcc-13 (Ubuntu 13.2.0-4ubuntu3) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240621/202406211244.oLhoF3My-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406211244.oLhoF3My-lkp@intel.com/

All errors (new ones prefixed by >>):

   ld: vmlinux.o: in function `smi_devs_unregister':
>> serial-multi-instantiate.c:(.text+0x313dcfc): undefined reference to `spi_unregister_device'
   ld: vmlinux.o: in function `smi_spi_probe':
>> serial-multi-instantiate.c:(.text+0x313e335): undefined reference to `acpi_spi_count_resources'
>> ld: serial-multi-instantiate.c:(.text+0x313e4e1): undefined reference to `spi_add_device'
>> ld: serial-multi-instantiate.c:(.text+0x313e593): undefined reference to `acpi_spi_device_alloc'

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for SERIAL_MULTI_INSTANTIATE
   Depends on [n]: X86_PLATFORM_DEVICES [=y] && I2C [=y] && SPI [=n] && ACPI [=y]
   Selected by [y]:
   - SND_HDA_SCODEC_CS35L56_I2C [=y] && SOUND [=y] && SND [=y] && SND_HDA [=y] && I2C [=y] && (ACPI [=y] || COMPILE_TEST [=y]) && SND_SOC [=y]

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

