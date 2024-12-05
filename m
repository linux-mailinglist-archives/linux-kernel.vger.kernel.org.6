Return-Path: <linux-kernel+bounces-433977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F8779E5FBC
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 21:50:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B2C1288951
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 20:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0691B1BB6BC;
	Thu,  5 Dec 2024 20:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hBtVJSdA"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F8F1B6D02
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 20:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733431799; cv=none; b=u97xb4wPdZrip+noODd9fQ1ZQ+caWwxhFum0y3xR4tYffsE8MtYKlAT5UOMrEd8G3oa4lm5/rsz4Pcco67x3jx07cot6lhO2f2eEVfflrK+XSbJdR6fXHOGkz1ikeYWuLwzyzi0VJvpceAqpok5IPQHUZIGuhiuASy/vwSzHTgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733431799; c=relaxed/simple;
	bh=Why5Nm8GLF/nDkjnQKhBre+oX5JL9LsNfqUoWF7Q2Z8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=i9W+OYIc7qSHdQjRGFW1HLsrXigewSBVpFo1/qrCYV7t0ShCGxxhX/RzAjj02usl8sXWBG6Wg+WFKox0Tv0hr+2GVaKExDKKcDgHsra/nZ8tK0Q2DMVGfeNqTb2NSInU/3Ca50znqNK2f6GW2RLRXwKJmvcsVsDY4oHKOlwZXMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hBtVJSdA; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733431798; x=1764967798;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Why5Nm8GLF/nDkjnQKhBre+oX5JL9LsNfqUoWF7Q2Z8=;
  b=hBtVJSdAKLEI+GMD/Roauxk7atqK2Wa91m4XGeHCaDgR4vPQN6jtVFx9
   kK0hSpdOsvuQ2GaszYy4lSCPxeq1waDsLnzlBA/MPwamMw/gF/p4iUhFE
   rnw3nWIiK9bqyUJnLJTkTz3Y55kP1C6V1w/h9qbVMmSTg9ZULO+s2DC09
   F6u+8IUilBAFFODqRXLUEMCEp95ApsUVe/S3kOOXZUFR2jloSPSVCl6rW
   bMZ1lfe/gAy6YnioGVrh8pjTSQhes+tQGr7x7GWNZwLM9XHEXLrTTqyPa
   sKyMQ3cMlcPv62AeITQFdysCPkcHGMNOKgsEI0THhg66UWAteqCin5Lpp
   g==;
X-CSE-ConnectionGUID: Qv7Ogy13Sh2jnPhdKRL9Dw==
X-CSE-MsgGUID: COUtky9rTFi96NkYngshIg==
X-IronPort-AV: E=McAfee;i="6700,10204,11277"; a="44795417"
X-IronPort-AV: E=Sophos;i="6.12,211,1728975600"; 
   d="scan'208";a="44795417"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2024 12:49:58 -0800
X-CSE-ConnectionGUID: EayVTB4pR3WNhvV5DPQoVg==
X-CSE-MsgGUID: 0NwuezABTnG8r9XdC4eRww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,211,1728975600"; 
   d="scan'208";a="94652654"
Received: from lkp-server01.sh.intel.com (HELO 82a3f569d0cb) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 05 Dec 2024 12:49:55 -0800
Received: from kbuild by 82a3f569d0cb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tJInJ-0000Np-0S;
	Thu, 05 Dec 2024 20:49:53 +0000
Date: Fri, 6 Dec 2024 04:49:24 +0800
From: kernel test robot <lkp@intel.com>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	x86@kernel.org, Ingo Molnar <mingo@kernel.org>
Subject: [tip:x86/boot 4/7] head64.c:undefined reference to
 `level4_kernel_pgt'
Message-ID: <202412060403.efD8Kgb7-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/boot
head:   faf0ed487415f76fe4acf7980ce360901f5e1698
commit: 3b6f99a94b04b389292590840d96342b7dd08941 [4/7] x86/boot: Disable UBSAN in early boot code
config: x86_64-buildonly-randconfig-001-20241206 (https://download.01.org/0day-ci/archive/20241206/202412060403.efD8Kgb7-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241206/202412060403.efD8Kgb7-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412060403.efD8Kgb7-lkp@intel.com/

All errors (new ones prefixed by >>):

   ld: arch/x86/kernel/head64.o: in function `__startup_64':
>> head64.c:(.head.text+0xbd): undefined reference to `level4_kernel_pgt'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

