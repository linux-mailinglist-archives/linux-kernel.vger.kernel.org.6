Return-Path: <linux-kernel+bounces-329635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D45C99793EA
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 03:06:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 717A1282FB8
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 01:06:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E0A41B85D1;
	Sun, 15 Sep 2024 01:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JYiWeSd1"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F9681B85C7
	for <linux-kernel@vger.kernel.org>; Sun, 15 Sep 2024 01:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726362387; cv=none; b=h6Rf30N5fLRwOxixPc+caf/AIEvuCUWxLIdDv3U3zSfRrzhjzckRgWlfBI/tabzh+BunjH0hu8B9fNCnJKxX+CCF1SSdeyciN44WCIoY9gZQEFFcL2SeQGWQtbN9MMwoxFfaPJW1vSAOMPtFpe237V14AlztHnBlMsFf1V+QLWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726362387; c=relaxed/simple;
	bh=a6N0FJCZ6E1cNMZnvuuHQxShNL0biJNFKXcoO0OoAAA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=EWgwUCZJqaGpvLBcFvyo/sICG2gerz3eoSIT8+qgxPsu9HACewcCVde+/HiotqnKnEUSpgFtRMt5fx6jsgJl6+YCG3ctZpUXtu9NEbG+02qpSGQ66wJ7YzKcJPVoGxWM/LB9uWzYrqWuyI3UVnV/eEMynWEqvjtTsOXRWTEqEY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JYiWeSd1; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726362386; x=1757898386;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=a6N0FJCZ6E1cNMZnvuuHQxShNL0biJNFKXcoO0OoAAA=;
  b=JYiWeSd1T1S80UQ82ohadCaiswkVcPUl0sjg5CXCf3hUL/u+k4O8LewJ
   VceGR8hSWHDuWWVjn+h+gxwx5pXITgf5Kj2bSpCxJRP1EJeM14TfcfT0k
   DJh1Xo1UaEIbbqABmyx9Le1hX3yS6QXyFvv2NSCn6KOFEvcrTEBmjguiw
   XMRkCIrn55itmKHZAeB8Ic1LQ6uKBd3AzZwtzJjfYxTXABFq7Za2KA/fJ
   QDSuCHfMKdbvXUiW0KKz9sMb8FUsm5Eq3zJqMXJ3/YPXSRLhM7VS2oGQQ
   EzWjl8iWNMWsQ1zdXchsh6Hx6p5H8tsoBVP6T9jAvZyRSFpTb+EBXVjC8
   w==;
X-CSE-ConnectionGUID: M58E0eF2SzOHrOKDRJk+qg==
X-CSE-MsgGUID: m1z52+WbSs2jut85dONXbA==
X-IronPort-AV: E=McAfee;i="6700,10204,11195"; a="36582241"
X-IronPort-AV: E=Sophos;i="6.10,230,1719903600"; 
   d="scan'208";a="36582241"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2024 18:06:26 -0700
X-CSE-ConnectionGUID: ZHPBYM1wSoSOsUfBU08C9Q==
X-CSE-MsgGUID: Y+0jddAaSOGoAecz4IC0/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,230,1719903600"; 
   d="scan'208";a="69283188"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 14 Sep 2024 18:06:25 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1spdiY-0008IU-2Q;
	Sun, 15 Sep 2024 01:06:22 +0000
Date: Sun, 15 Sep 2024 09:05:30 +0800
From: kernel test robot <lkp@intel.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: arch/m68k/sun3/sun3ints.c:33:13: sparse: sparse: cast truncates bits
 from constant value (ffffff7f becomes 7f)
Message-ID: <202409150822.m4wt3d6X-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   0babf683783ddca06551537c6781e413cfe8d27b
commit: 72e70a0e7ac7c422843eb8bbf192e820e9ccd24d m68k: sun3: Change led_pattern[] to unsigned char
date:   12 months ago
config: m68k-randconfig-r131-20240914 (https://download.01.org/0day-ci/archive/20240915/202409150822.m4wt3d6X-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 14.1.0
reproduce: (https://download.01.org/0day-ci/archive/20240915/202409150822.m4wt3d6X-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409150822.m4wt3d6X-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> arch/m68k/sun3/sun3ints.c:33:13: sparse: sparse: cast truncates bits from constant value (ffffff7f becomes 7f)

vim +33 arch/m68k/sun3/sun3ints.c

    31	
    32	static unsigned char led_pattern[8] = {
  > 33		(u8)~(0x80), (u8)~(0x01),
    34		(u8)~(0x40), (u8)~(0x02),
    35		(u8)~(0x20), (u8)~(0x04),
    36		(u8)~(0x10), (u8)~(0x08)
    37	};
    38	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

