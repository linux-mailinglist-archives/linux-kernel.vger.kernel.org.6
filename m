Return-Path: <linux-kernel+bounces-230471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C53E2917D4B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 12:08:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 351C5B20EFB
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 10:08:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29A77176230;
	Wed, 26 Jun 2024 10:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gg2CdOKh"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16B28175AA
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 10:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719396519; cv=none; b=A7QNPDazz9hE937O9FEbOrenglbNbrrvPuDKO20AUo76hJ5KkWXOiPqqjgjnkFBj5N1rxWfVz675Rbb5sS6WWH/qjH7cWQXFtnDGOJb9Sxa8rQ+UAwKKiZ4DXs8hzL3c3QoHtmxYaGGe6cOtw5UgvUvRNHajriT27mzlisOUxyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719396519; c=relaxed/simple;
	bh=QOYhx0sbrumiaTUkZqLb1sydzYfcamo/Fd0ReV1T7+I=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=aSyrPr1vRkUtHbhJSdeO6gXe+ucLD+V5ks5wgOreESoKYVNcadKoUWi2TdPdM2bhsqYfTM0jniInM5gOgS36sIJmLi3xE6HcIm8fRB9qt6xEdKwNdPE/9x0fVHhctr4iu2K896LETRwKAxme5hc0iK6GFMVK5qsf/uhksB5oBo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gg2CdOKh; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719396518; x=1750932518;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=QOYhx0sbrumiaTUkZqLb1sydzYfcamo/Fd0ReV1T7+I=;
  b=gg2CdOKhk0tXRR89SetWjfOrhOPAGzI0jPKMQFFz9s0v6R8SIcX81bu/
   LnR2LTV2chhzEzgvWEFktc3Margo9afr0qyvljUaaqtiS/us+jo2Xoyhp
   frvQ+N823tci7sASkxLYma22Hjwbi01y3i2r3+zwHTaX56+hoVc9gE9zW
   nZpEevSvi8T0y+lF8yB42PjzkHJ5NaU8RkuoDBWSIvt9fiJc8MkJ9MhbX
   xjyfv7kijV/TtZ1KhX8cU9vqc+JiOyr9BBfIHa0lXcYKTJLXFeiNzk6BN
   HXxNtr1jIRQ2l/HJ1R0WdM28UZmx89vY0eIM7cyZw2elO2qZGjiw0HA0/
   Q==;
X-CSE-ConnectionGUID: Lx0g1hNMTFKrBb+RGHSqkg==
X-CSE-MsgGUID: O4HCVRyoQiu/cNV1lyMPKw==
X-IronPort-AV: E=McAfee;i="6700,10204,11114"; a="27862640"
X-IronPort-AV: E=Sophos;i="6.08,266,1712646000"; 
   d="scan'208";a="27862640"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2024 03:08:37 -0700
X-CSE-ConnectionGUID: Vrhb2N48QLmR+dU1dux8LA==
X-CSE-MsgGUID: brqo+h+CSW6DfxeBC6El8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,266,1712646000"; 
   d="scan'208";a="48881613"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 26 Jun 2024 03:08:37 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sMPZp-000FB8-2q;
	Wed, 26 Jun 2024 10:08:33 +0000
Date: Wed, 26 Jun 2024 18:07:54 +0800
From: kernel test robot <lkp@intel.com>
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: WARNING: modpost: vmlinux: section mismatch in reference:
 tracing_gen_ctx+0x64 (section: .text.unlikely) -> initcall_level_names
 (section: .init.data)
Message-ID: <202406261719.2aAerZqM-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Masahiro,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   55027e689933ba2e64f3d245fb1ff185b3e7fc81
commit: 481461f5109919babbb393d6f68002936b8e2493 linux/export.h: make <linux/export.h> independent of CONFIG_MODULES
date:   11 months ago
config: xtensa-randconfig-002-20240225 (https://download.01.org/0day-ci/archive/20240626/202406261719.2aAerZqM-lkp@intel.com/config)
compiler: xtensa-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240626/202406261719.2aAerZqM-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406261719.2aAerZqM-lkp@intel.com/

All warnings (new ones prefixed by >>, old ones prefixed by <<):

WARNING: modpost: missing MODULE_DESCRIPTION() in vmlinux.o
WARNING: modpost: vmlinux: section mismatch in reference: put_page+0x30 (section: .text.unlikely) -> initcall_level_names (section: .init.data)
>> WARNING: modpost: vmlinux: section mismatch in reference: tracing_gen_ctx+0x64 (section: .text.unlikely) -> initcall_level_names (section: .init.data)

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

