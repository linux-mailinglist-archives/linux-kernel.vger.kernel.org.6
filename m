Return-Path: <linux-kernel+bounces-332184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 701D497B687
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 03:13:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C3551C22FD1
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 01:12:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1328F8468;
	Wed, 18 Sep 2024 01:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Mdd0lPIm"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8532B6AAD
	for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 01:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726621974; cv=none; b=BXoXOJF1L4wRrkIpkZWcZLhCcrCEd69r6uDSm0psydnpy94o3FkOZspdmQucfPJDwq9A2kEAnhZmMNzX//s+7k7W8ur2ubdyF9c92UemKgH/8VGEKYR6uZFFbMoom2Wn7c8WGdoo6HeyT88Yzv7/rHX/Bs7JBlmwGQsnxRoHAbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726621974; c=relaxed/simple;
	bh=w+uNyBMmVsRkcaFgJ8Zjs4hiThZcuCi8KjI0Aekj9Pc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=itT3nCmxL0IZQ/nvQlU2Z4MhZ2UjJ/cPbfLms5ZrSbqpeCeuCu4WqrKvKJrN14+rs3Aufj3sIbYoo4pFL1Gy9OLr2f4VXbZ1IOr+6i/++Y6vlJXBfhCzA6uKs9sAidvJun+H8OB11JY7wxyUTCjcRsTxKznGP9Cmx8tzWYuXzsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Mdd0lPIm; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726621971; x=1758157971;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=w+uNyBMmVsRkcaFgJ8Zjs4hiThZcuCi8KjI0Aekj9Pc=;
  b=Mdd0lPImmn0V0zLEy0PVoOf4/E0JoFvwNJ5rqj9nHyARS1nCYptVurp/
   K+Wx3IGaHYV/FW8JZRIGxiLUcfiX8oGq6mku9se+9k6r/8BlHeIZFPPrY
   XhkUAtqxy5WX3BcN6KlC44FgUbOIZxmAKdDBzzw4oXyigDG0Ux+KzZq+V
   BKK+vRnmSmaPURrLLW1TbVOzMKCRwoN0rS8TDkDRvB/kjLKb9UulcUH1h
   B1SWF89DpvZfMjQ+ZzxIVVQa44j+J08gbdrxjoJ8RIEQ5m3oLP4Is+MST
   IgTI9odttMuCp6Av/QEh4ZA7MTYUxyRDwL/5tOLKgC5e+b5ycL/Xvpe6h
   w==;
X-CSE-ConnectionGUID: /qVrwthoQy2ToiP0lb6XRw==
X-CSE-MsgGUID: TDIJ+uXdSEyys3aaaHz9Cw==
X-IronPort-AV: E=McAfee;i="6700,10204,11198"; a="25395470"
X-IronPort-AV: E=Sophos;i="6.10,235,1719903600"; 
   d="scan'208";a="25395470"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2024 18:12:50 -0700
X-CSE-ConnectionGUID: sKSswbQcTiK1WWQj2HRpHg==
X-CSE-MsgGUID: 3yAxE06ORnyqNhJcZK6yYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,235,1719903600"; 
   d="scan'208";a="100209837"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 17 Sep 2024 18:12:49 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sqjFP-000Bks-0T;
	Wed, 18 Sep 2024 01:12:47 +0000
Date: Wed, 18 Sep 2024 09:12:41 +0800
From: kernel test robot <lkp@intel.com>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Sami Tolvanen <samitolvanen@google.com>
Subject: ld.lld: error: undefined symbol: __kcfi_typeid_cpu_v7_smc_switch_mm
Message-ID: <202409180918.AGeTRmyW-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   2f27fce67173bbb05d5a0ee03dae5c021202c912
commit: 1a4fec49efe5273eb2fcf575175a117745f76f97 ARM: 9392/2: Support CLANG CFI
date:   5 months ago
config: arm-randconfig-002-20240918 (https://download.01.org/0day-ci/archive/20240918/202409180918.AGeTRmyW-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 8663a75fa2f31299ab8d1d90288d9df92aadee88)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240918/202409180918.AGeTRmyW-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409180918.AGeTRmyW-lkp@intel.com/

All errors (new ones prefixed by >>):

>> ld.lld: error: undefined symbol: __kcfi_typeid_cpu_v7_smc_switch_mm
   >>> referenced by proc-v7.S:94 (arch/arm/mm/proc-v7.S:94)
   >>>               arch/arm/mm/proc-v7.o:(.text+0x108) in archive vmlinux.a
--
>> ld.lld: error: undefined symbol: __kcfi_typeid_cpu_v7_hvc_switch_mm
   >>> referenced by proc-v7.S:105 (arch/arm/mm/proc-v7.S:105)
   >>>               arch/arm/mm/proc-v7.o:(.text+0x124) in archive vmlinux.a

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

