Return-Path: <linux-kernel+bounces-550787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B104A56419
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 10:39:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F5DC3A7E9B
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 09:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC13E20AF67;
	Fri,  7 Mar 2025 09:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XjK9BYyj"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6770F1AA7BF;
	Fri,  7 Mar 2025 09:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741340339; cv=none; b=lZbvEaKOR6WnsoAKsztZj40fVXTlJOksFGkn/x1kneSfik4c2UA/3QXd+7BhlN+cpjFHaTAW6Pn3OOAr+OFNUjKqWj3+vQAClxMdd9PoDZ2ZVuxfDYCx7qTYfc0S8PWg065CNvxJKz5Z6vpdGsjT/zcEehtnWmWpHZcDLpZL1aA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741340339; c=relaxed/simple;
	bh=rLs1wzqH52S/8SS8AdvefAUT8BlMKmSH93vnAmNwPS0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a0kgLJdSbbAgu2/I3fn0mBrmVkJx320giIM3sfrXs67Nnel1abo4+u5qCLDHUHzrI06C1i0ht8yA+U5knEL8bQjkhCtuDyo+Wywg82nWlPPWg5WkLtvZIMAWu7pEXDJsfhuWzqe7/qMILceH9SBX8eASuB+6tSTXqqxQPaRIC4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XjK9BYyj; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741340337; x=1772876337;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rLs1wzqH52S/8SS8AdvefAUT8BlMKmSH93vnAmNwPS0=;
  b=XjK9BYyjLmjuPlQ/q/CiYeSt8/nNghiIlw1+NnAa7uS1YKIC6Dmar7Gy
   VIYeymI8Jiw15mOAzUfbz9dTytVd9en/kv8xOyUh38rm/mQckyML7JDWU
   52dWqsYkphq4LTGG9SWGFrfo/bDjJuFo/j+ymWHcV2RNXtKHBhDA0afgD
   oiC+UVdj7QQ1Pm9D5s5sJZVwAUIZXD09Ev/c34rD5KRr9yIxNKljPSOwO
   7xcX4lq5Jusl09FVP3+ZgUFf1MrxEgM4IhiMLtDSQtAW4t9J4u2e6j9sI
   gC5an/bmNfxrRgppeD01p0AM6Ie5wI6pNnOFTIq5Zyfk6cZOTj/wp3eLp
   g==;
X-CSE-ConnectionGUID: cJYimkFdSXWvJ+LDJGLWig==
X-CSE-MsgGUID: RSMkRsIZQ/6xlyGGq4W0qg==
X-IronPort-AV: E=McAfee;i="6700,10204,11365"; a="46161764"
X-IronPort-AV: E=Sophos;i="6.14,228,1736841600"; 
   d="scan'208";a="46161764"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2025 01:38:57 -0800
X-CSE-ConnectionGUID: kGyra7qNQN2eoeVm9SqYaw==
X-CSE-MsgGUID: xgQLYtAcTSmA84/tKBk4Iw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,228,1736841600"; 
   d="scan'208";a="124371050"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by fmviesa004.fm.intel.com with ESMTP; 07 Mar 2025 01:38:54 -0800
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tqUAO-0000Eh-1j;
	Fri, 07 Mar 2025 09:38:52 +0000
Date: Fri, 7 Mar 2025 17:38:08 +0800
From: kernel test robot <lkp@intel.com>
To: Jiayi Li <lijiayi@kylinos.cn>, gregkh@linuxfoundation.org,
	stern@rowland.harvard.edu, stefan.eichenberger@toradex.com,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, jiayi_dec@163.com,
	Jiayi Li <lijiayi@kylinos.cn>
Subject: Re: [PATCH v1] usb: core: Add boot delay for DH34 board in restore
 mode
Message-ID: <202503071748.Paav3L6j-lkp@intel.com>
References: <20250306061749.1502029-1-lijiayi@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250306061749.1502029-1-lijiayi@kylinos.cn>

Hi Jiayi,

kernel test robot noticed the following build errors:

[auto build test ERROR on usb/usb-testing]
[also build test ERROR on usb/usb-next usb/usb-linus linus/master v6.14-rc5 next-20250306]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jiayi-Li/usb-core-Add-boot-delay-for-DH34-board-in-restore-mode/20250306-141857
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
patch link:    https://lore.kernel.org/r/20250306061749.1502029-1-lijiayi%40kylinos.cn
patch subject: [PATCH v1] usb: core: Add boot delay for DH34 board in restore mode
config: arm64-randconfig-002-20250307 (https://download.01.org/0day-ci/archive/20250307/202503071748.Paav3L6j-lkp@intel.com/config)
compiler: clang version 15.0.7 (https://github.com/llvm/llvm-project 8dfdcc7b7bf66834a761bd8de445840ef68e4d1a)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250307/202503071748.Paav3L6j-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503071748.Paav3L6j-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

WARNING: modpost: missing MODULE_DESCRIPTION() in fs/exportfs/exportfs.o
WARNING: modpost: missing MODULE_DESCRIPTION() in lib/zlib_inflate/zlib_inflate.o
>> ERROR: modpost: "saved_command_line" [drivers/usb/core/usbcore.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

