Return-Path: <linux-kernel+bounces-293650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FE0A9582B4
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 11:36:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C8232852D5
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 09:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 180E218C009;
	Tue, 20 Aug 2024 09:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KvYsE4U7"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B8F18A6C5
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 09:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724146594; cv=none; b=DNnlYkbYY0iKJhv7hAihfDB2eAtPqR576u6YPGpafeM3i66HaJA9a+J0OOLhkJNoQ/+eijAtj6jSfbGX0rqj4/Yjcclj4Yu+dkh97fPqdQgfkL09cKietMULPJYT0jL+sN//N8ELe1qWMh2EsR2teYYe9Txo5GzJ5LoYnfSvWbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724146594; c=relaxed/simple;
	bh=RFfQjLyBZ346VswZC7hJZyreSBOlBSvIf1UsGsCLYqs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Btqfb08pYy0CR/kwWg6v1r61fZz+CfWmx3yjf1mpa0qlq8J1Ai1sO6wNzZE+Qpip9ZoHikt3wBnfs1bdF/qc7WnsyCN9y4NrnXySDjAemi+dh30i+qeObMBrsvQkpydD/OznneDX5dGkyfwcrQwXg9ftNSZDQQHERxQsurmZdoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KvYsE4U7; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724146592; x=1755682592;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=RFfQjLyBZ346VswZC7hJZyreSBOlBSvIf1UsGsCLYqs=;
  b=KvYsE4U7cSgZ3EaMMvILI2web20YBx8anOQucvQ9OF+qqYFiJ+vTBQz4
   zFEhzRFp5rEcB7YCeU0Ot/SaQvr4YrIhTWFV+YoURfIwFGjc9gFL/LN69
   hu1weE3Mpp8rprQMW1JypAjyZCI/Z7TlziE9it/ZnccVBft9FCeZwLtDn
   Z99iyxcRxhAxPaGc9pD8/2YCB/T+A5tIvn17NfKITkjucfdZlMfYhHCDt
   YWI1Nc+GxaB+4Tmjhs3Wkod/XHd+GZK48gy0H1dXgBvuGRJBG3GITDPaV
   JuSc0OMUBARXRqWvuO5nL/d64A3Bh7A3QGyaP7N2UzQ780Grntnx1iiO7
   A==;
X-CSE-ConnectionGUID: eUkutwzJSbKO2sO6fOwdkA==
X-CSE-MsgGUID: PFHLtB03QhGo5d34uv6Zlg==
X-IronPort-AV: E=McAfee;i="6700,10204,11169"; a="22563731"
X-IronPort-AV: E=Sophos;i="6.10,161,1719903600"; 
   d="scan'208";a="22563731"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2024 02:36:31 -0700
X-CSE-ConnectionGUID: YBO1ugnASV+f034OQCB9aw==
X-CSE-MsgGUID: yQ87jKA9RDK0C0ydDcXUMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,161,1719903600"; 
   d="scan'208";a="91441455"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 20 Aug 2024 02:36:28 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sgLHt-0009z0-0B;
	Tue, 20 Aug 2024 09:36:25 +0000
Date: Tue, 20 Aug 2024 17:35:38 +0800
From: kernel test robot <lkp@intel.com>
To: Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>
Subject: ld.lld: error: undefined symbol: devm_hwrng_register
Message-ID: <202408201716.knXsXPX7-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   6e4436539ae182dc86d57d13849862bcafaa4709
commit: 74a22fced5a012c57f56d1cf7ea926cc366a2a3a platform: cznic: turris-omnia-mcu: Make poweroff and wakeup code optional
date:   13 days ago
config: hexagon-randconfig-r054-20240820 (https://download.01.org/0day-ci/archive/20240820/202408201716.knXsXPX7-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 26670e7fa4f032a019d23d56c6a02926e854e8af)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240820/202408201716.knXsXPX7-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408201716.knXsXPX7-lkp@intel.com/

All errors (new ones prefixed by >>):

>> ld.lld: error: undefined symbol: devm_hwrng_register
   >>> referenced by turris-omnia-mcu-trng.c:95 (drivers/platform/cznic/turris-omnia-mcu-trng.c:95)
   >>>               drivers/platform/cznic/turris-omnia-mcu-trng.o:(omnia_mcu_register_trng) in archive vmlinux.a
   >>> referenced by turris-omnia-mcu-trng.c:95 (drivers/platform/cznic/turris-omnia-mcu-trng.c:95)
   >>>               drivers/platform/cznic/turris-omnia-mcu-trng.o:(omnia_mcu_register_trng) in archive vmlinux.a

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

